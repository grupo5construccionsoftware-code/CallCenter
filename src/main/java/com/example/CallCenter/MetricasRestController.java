package com.example.CallCenter;

import com.example.CallCenter.agente.Agente;
import com.example.CallCenter.agente.AgenteService;
import com.example.CallCenter.llamada.Llamada;
import com.example.CallCenter.llamada.LlamadaService;
import com.example.CallCenter.Empresa.EmpresaService;
import com.example.CallCenter.tipificacion.TipificacionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/metricas")
public class MetricasRestController {

    private final LlamadaService llamadaService;
    private final AgenteService agenteService;
    private final EmpresaService empresaService;
    private final TipificacionService tipificacionService;

    public MetricasRestController(LlamadaService llamadaService,
                                  AgenteService agenteService,
                                  EmpresaService empresaService,
                                  TipificacionService tipificacionService) {
        this.llamadaService = llamadaService;
        this.agenteService = agenteService;
        this.empresaService = empresaService;
        this.tipificacionService = tipificacionService;
    }

    @GetMapping("/agente")
    public Map<String, Object> metricasAgente(HttpSession session) {
        int idAgente = obtenerIdAgente(session);
        List<Llamada> llamadas = llamadaService.listarLlamadasPorAgente(idAgente);
        return calcularMetricas(llamadas);
    }

    @GetMapping("/empresa")
    public Map<String, Object> metricasEmpresa(HttpSession session) {
        int idEmpresa = obtenerIdEmpresa(session);
        List<Integer> ids = agenteService.listarAgentes().stream()
                .filter(a -> a.getId_empresa() == idEmpresa)
                .map(Agente::getId_agente)
                .collect(Collectors.toList());
        List<Llamada> llamadas = ids.isEmpty()
                ? Collections.emptyList()
                : llamadaService.listarLlamadasPorAgentes(ids);
        return calcularMetricas(llamadas);
    }

    @GetMapping("/superadmin")
    public Map<String, Object> metricasSuperadmin(
            @RequestParam(value = "id_empresa", required = false) Long idEmpresa) {

        List<Llamada> llamadas;
        if (idEmpresa != null) {
            List<Integer> ids = agenteService.listarAgentes().stream()
                    .filter(a -> a.getId_empresa() == idEmpresa.intValue())
                    .map(Agente::getId_agente)
                    .collect(Collectors.toList());
            llamadas = ids.isEmpty()
                    ? Collections.emptyList()
                    : llamadaService.listarLlamadasPorAgentes(ids);
        } else {
            llamadas = llamadaService.listarLlamadas();
        }

        Map<String, Object> result = calcularMetricas(llamadas);
        result.put("totalEmpresas", empresaService.listarEmpresas().size());
        result.put("totalAgentes", agenteService.listarAgentes().size());

        List<Map<String, Object>> porEmpresa = new ArrayList<>();
        empresaService.listarEmpresas().forEach(emp -> {
            List<Integer> agIds = agenteService.listarAgentes().stream()
                    .filter(a -> a.getId_empresa() == emp.getId_empresa())
                    .map(Agente::getId_agente)
                    .collect(Collectors.toList());
            long total = agIds.isEmpty() ? 0
                    : llamadaService.listarLlamadasPorAgentes(agIds).size();
            Map<String, Object> entry = new LinkedHashMap<>();
            entry.put("nombre", emp.getNombre_empresa());
            entry.put("totalLlamadas", total);
            porEmpresa.add(entry);
        });
        result.put("llamadasPorEmpresa", porEmpresa);

        return result;
    }

    private Map<String, Object> calcularMetricas(List<Llamada> llamadas) {
        Map<String, Object> data = new LinkedHashMap<>();

        data.put("totalLlamadas", llamadas.size());

        long clientesFrecuentes = llamadas.stream()
                .collect(Collectors.groupingBy(Llamada::getTelefono_cliente, Collectors.counting()))
                .values().stream().filter(c -> c > 1).count();
        data.put("clientesFrecuentes", clientesFrecuentes);

        OptionalDouble promedio = llamadas.stream()
                .map(Llamada::getDuracion)
                .filter(d -> d != null && d.toLowerCase().contains("min"))
                .mapToDouble(d -> {
                    try { return Double.parseDouble(d.toLowerCase().replace("min", "").trim()); }
                    catch (NumberFormatException e) { return 0; }
                }).average();
        data.put("duracionPromedio", promedio.isPresent()
                ? String.format("%.1f min", promedio.getAsDouble()) : "-");

        llamadas.stream()
                .filter(l -> l.getMotivo_tipo() != null)
                .collect(Collectors.groupingBy(Llamada::getMotivo_tipo, Collectors.counting()))
                .entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .ifPresentOrElse(
                        e -> data.put("tipificacionComun", e.getKey()),
                        () -> data.put("tipificacionComun", "-")
                );

        Map<String, Long> porMotivo = llamadas.stream()
                .filter(l -> l.getMotivo_tipo() != null)
                .collect(Collectors.groupingBy(Llamada::getMotivo_tipo, Collectors.counting()));
        data.put("llamadasPorMotivo", porMotivo);

        Map<String, Long> porFechaOrdenado = new TreeMap<>(
                llamadas.stream()
                        .filter(l -> l.getFecha_llamada() != null)
                        .collect(Collectors.groupingBy(Llamada::getFecha_llamada, Collectors.counting()))
        );
        data.put("llamadasPorFecha", porFechaOrdenado);

        Map<Integer, Long> porAgenteId = llamadas.stream()
                .collect(Collectors.groupingBy(Llamada::getId_agente, Collectors.counting()));
        data.put("llamadasPorAgenteId", porAgenteId);

        return data;
    }

    private int obtenerIdEmpresa(HttpSession session) {
        Object id = session.getAttribute("id_empresa");
        if (id instanceof Integer) return (Integer) id;
        if (id instanceof Long) return ((Long) id).intValue();
        if (id instanceof String) {
            try { return Integer.parseInt((String) id); } catch (NumberFormatException e) { }
        }
        return 1;
    }

    private int obtenerIdAgente(HttpSession session) {
        Object id = session.getAttribute("id_agente");
        if (id instanceof Integer) return (Integer) id;
        if (id instanceof Long) return ((Long) id).intValue();
        if (id instanceof String) {
            try { return Integer.parseInt((String) id); } catch (NumberFormatException e) { }
        }
        return 1;
    }
}