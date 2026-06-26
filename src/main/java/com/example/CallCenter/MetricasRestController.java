package com.example.CallCenter;

import com.example.CallCenter.agente.model.Agente;
import com.example.CallCenter.agente.AgenteService;
import com.example.CallCenter.llamada.model.Llamada;
import com.example.CallCenter.llamada.LlamadaService;
import com.example.CallCenter.Empresa.EmpresaService;
import com.example.CallCenter.tipificacion.TipificacionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/metricas")
public class MetricasRestController {

    private static final DateTimeFormatter FORMATO_HORA = DateTimeFormatter.ofPattern("HH:mm[:ss]");
    private static final Pattern PATRON_DURACION = Pattern.compile("(\\d+)\\s*(h|min|seg)", Pattern.CASE_INSENSITIVE);

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

        List<Long> duraciones = llamadas.stream()
                .map(this::obtenerDuracionSegundos)
                .filter(segundos -> segundos > 0)
                .toList();

        long totalSegundos = duraciones.stream().mapToLong(Long::longValue).sum();
        long promedioSegundos = duraciones.isEmpty() ? 0 : totalSegundos / duraciones.size();
        long maximaDuracion = duraciones.stream().mapToLong(Long::longValue).max().orElse(0);
        long minimaDuracion = duraciones.stream().mapToLong(Long::longValue).min().orElse(0);

        data.put("totalLlamadas", llamadas.size());
        data.put("tiempoTotal", formatearDuracion(totalSegundos));
        data.put("duracionPromedio", formatearDuracion(promedioSegundos));
        data.put("llamadaMasLarga", formatearDuracion(maximaDuracion));
        data.put("llamadaMasCorta", formatearDuracion(minimaDuracion));
        data.put("horaPico", obtenerHoraPico(llamadas));

        Map<String, Long> porFechaOrdenado = new TreeMap<>(
                llamadas.stream()
                        .filter(l -> l.getFecha_llamada() != null)
                        .collect(Collectors.groupingBy(Llamada::getFecha_llamada, Collectors.counting()))
        );
        data.put("llamadasPorFecha", porFechaOrdenado);

        Map<String, Long> porHoraOrdenado = new TreeMap<>(
                llamadas.stream()
                        .map(this::obtenerHoraInicio)
                        .filter(Objects::nonNull)
                        .collect(Collectors.groupingBy(hora -> String.format("%02d:00", hora.getHour()), Collectors.counting()))
        );
        data.put("llamadasPorHora", porHoraOrdenado);

        Map<String, Long> tiempoPorFecha = llamadas.stream()
                .filter(l -> l.getFecha_llamada() != null && !l.getFecha_llamada().isBlank())
                .collect(Collectors.groupingBy(
                        Llamada::getFecha_llamada,
                        TreeMap::new,
                        Collectors.summingLong(this::obtenerDuracionSegundos)
                ));
        Map<String, Long> tiempoPorFechaMinutos = tiempoPorFecha.entrySet().stream()
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        entry -> Math.round(entry.getValue() / 60.0),
                        (a, b) -> a,
                        TreeMap::new
                ));
        data.put("tiempoPorFecha", tiempoPorFechaMinutos);

        Map<Integer, Long> porAgenteId = llamadas.stream()
                .collect(Collectors.groupingBy(Llamada::getId_agente, Collectors.counting()));
        data.put("llamadasPorAgenteId", porAgenteId);

        return data;
    }

    private long obtenerDuracionSegundos(Llamada llamada) {
        long segundos = parsearDuracion(llamada.getDuracion());
        if (segundos > 0) {
            return segundos;
        }
        LocalTime inicio = obtenerHora(llamada.getHora_inicio());
        LocalTime fin = obtenerHora(llamada.getHora_fin());
        if (inicio == null || fin == null) {
            return 0;
        }
        Duration duracion = Duration.between(inicio, fin);
        if (duracion.isNegative()) {
            duracion = duracion.plusHours(24);
        }
        return duracion.getSeconds();
    }

    private long parsearDuracion(String duracion) {
        if (duracion == null || duracion.isBlank()) {
            return 0;
        }
        Matcher matcher = PATRON_DURACION.matcher(duracion);
        long segundos = 0;
        while (matcher.find()) {
            long valor = Long.parseLong(matcher.group(1));
            String unidad = matcher.group(2).toLowerCase();
            if ("h".equals(unidad)) {
                segundos += valor * 3600;
            } else if ("min".equals(unidad)) {
                segundos += valor * 60;
            } else {
                segundos += valor;
            }
        }
        return segundos;
    }

    private String obtenerHoraPico(List<Llamada> llamadas) {
        return llamadas.stream()
                .map(this::obtenerHoraInicio)
                .filter(Objects::nonNull)
                .collect(Collectors.groupingBy(LocalTime::getHour, Collectors.counting()))
                .entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .map(entry -> String.format("%02d:00", entry.getKey()))
                .orElse("-");
    }

    private LocalTime obtenerHoraInicio(Llamada llamada) {
        return obtenerHora(llamada.getHora_inicio());
    }

    private LocalTime obtenerHora(String hora) {
        if (hora == null || hora.isBlank()) {
            return null;
        }
        try {
            return LocalTime.parse(hora.trim(), FORMATO_HORA);
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    private String formatearDuracion(long totalSegundos) {
        if (totalSegundos <= 0) {
            return "-";
        }
        long horas = totalSegundos / 3600;
        long minutos = (totalSegundos % 3600) / 60;
        long segundos = totalSegundos % 60;

        List<String> partes = new ArrayList<>();
        if (horas > 0) partes.add(horas + " h");
        if (minutos > 0) partes.add(minutos + " min");
        if (segundos > 0 || partes.isEmpty()) partes.add(segundos + " seg");
        return String.join(" ", partes);
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
