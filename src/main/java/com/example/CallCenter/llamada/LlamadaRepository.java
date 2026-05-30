package com.example.CallCenter.llamada;

import java.time.LocalDate;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import com.example.CallCenter.tipificacion.TipificacionDAO;
import com.example.CallCenter.tipificacion.Tipificacion;
import org.springframework.stereotype.Repository;

@Repository
public class LlamadaRepository implements LlamadaDAO {

    private final List<Llamada> llamadas = new ArrayList<>();
    private final TipificacionDAO tipificacionDAO;
    private static final DateTimeFormatter FORMATO_HORA = DateTimeFormatter.ofPattern("HH:mm[:ss]");
    private static final DateTimeFormatter FORMATO_HORA_COMPLETA = DateTimeFormatter.ofPattern("HH:mm:ss");

    public LlamadaRepository(TipificacionDAO tipificacionDAO) {
        this.tipificacionDAO = tipificacionDAO;
        cargarLlamadasIniciales();
    }

    @Override
    public List<Llamada> listarLlamadas() {
        return llamadas;
    }

    @Override
    public List<Llamada> listarLlamadasPorAgente(int idAgente) {
        return llamadas.stream()
                .filter(l -> l.getId_agente() == idAgente)
                .collect(Collectors.toList());
    }

    @Override
    public List<Llamada> listarLlamadasPorAgentes(Collection<Integer> idsAgentes) {
        return llamadas.stream()
                .filter(l -> idsAgentes != null && idsAgentes.contains(l.getId_agente()))
                .collect(Collectors.toList());
    }

    @Override
    public Llamada obtenerLlamadaPorId(int id_llamada) {
        return llamadas.stream()
                .filter(l -> l.getId_llamada() == id_llamada)
                .findFirst()
                .orElse(null);
    }

    @Override
    public void crearLlamada(Llamada llamada) {
        int nuevoId = llamadas.stream()
                .mapToInt(Llamada::getId_llamada)
                .max()
                .orElse(0) + 1;
        llamada.setId_llamada(nuevoId);
        if (llamada.getId_agente() <= 0) {
            llamada.setId_agente(1);
        }
        llamada.setFecha_llamada(LocalDate.now().toString());
        llamada.setHora(LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm")));
        llamada.setEstado("activo");
        if (llamada.getDuracion() == null || llamada.getDuracion().trim().isEmpty()) {
            llamada.setDuracion("00:00");
        }
        if (llamada.getDescripcion_llamada() == null) {
            llamada.setDescripcion_llamada("");
        }
        if (llamada.getHora_inicio() == null || llamada.getHora_inicio().isBlank()) {
            llamada.setHora_inicio(LocalTime.now().format(FORMATO_HORA_COMPLETA));
        }
        if (llamada.getEstado_llamada() == null || llamada.getEstado_llamada().isBlank()) {
            llamada.setEstado_llamada("Activo");
        }
        completarFinYDuracion(llamada);
        asignarMotivo(llamada);
        llamadas.add(llamada);
    }

    @Override
    public void actualizarLlamada(Llamada llamada) {
        for (int i = 0; i < llamadas.size(); i++) {
            if (llamadas.get(i).getId_llamada() == llamada.getId_llamada()) {
                Llamada llamadaActual = llamadas.get(i);
                llamada.setFecha_llamada(llamadas.get(i).getFecha_llamada());
                llamada.setId_agente(llamadas.get(i).getId_agente());
                llamada.setDuracion(llamadas.get(i).getDuracion());
                if (llamada.getEstado() == null || llamada.getEstado().trim().isEmpty()) {
                    llamada.setEstado(llamadas.get(i).getEstado());
                if (llamada.getHora_inicio() == null || llamada.getHora_inicio().isBlank()) {
                    llamada.setHora_inicio(llamadaActual.getHora_inicio());
                }
                if (llamada.getHora_fin() == null || llamada.getHora_fin().isBlank()) {
                    llamada.setHora_fin(llamadaActual.getHora_fin());
                }
                if (llamada.getDuracion() == null || llamada.getDuracion().isBlank()) {
                    llamada.setDuracion(llamadaActual.getDuracion());
                }
                asignarMotivo(llamada);
                llamadas.set(i, llamada);
                break;
            }
        }
    }

    @Override
    public void eliminarLlamada(int id_llamada) {
        // Borrado lógico: cambia estado a "borrado"
        llamadas.stream()
                .filter(l -> l.getId_llamada() == id_llamada)
                .findFirst()
                .ifPresent(l -> l.setEstado("borrado"));
    }

    private void cargarLlamadasIniciales() {
        llamadas.add(crearLlamadaInicial(1, "Maria Lopez",   "987654321", "2026-05-01", "09:10", 1, 1, "Consulta", "05:23", "activo", "El cliente consulta sobre su factura"));
        llamadas.add(crearLlamadaInicial(2, "Carlos Perez",  "923456781", "2026-05-02", "10:25", 1, 2, "Reclamo",  "08:47", "activo", "El cliente presenta una queja por cobro incorrecto"));
        llamadas.add(crearLlamadaInicial(3, "Ana Torres",    "934567812", "2026-05-03", "11:40", 1, 3, "Venta",    "12:05", "activo", "El cliente adquiere el plan básico"));
        llamadas.add(crearLlamadaInicial(4, "Luis Ramirez",  "945678123", "2026-05-04", "13:15", 1, 4, "Soporte",  "06:30", "activo", "El cliente necesita ayuda con la aplicación"));
        llamadas.add(crearLlamadaInicial(5, "Rosa Garcia",   "956781234", "2026-05-05", "15:05", 1, 5, "Otros",    "03:15", "activo", "Consulta general"));
    }

    private Llamada crearLlamadaInicial(int id, String cliente, String telefono,
                                        String fecha, String hora, int idAgente,
                                        int idTipo, String motivo, String duracion,
                                        String estado, String descripcion) {
        Llamada llamada = new Llamada();
        llamada.setId_llamada(id);
        llamada.setNombre_cliente(cliente);
        llamada.setTelefono_cliente(telefono);
        llamada.setFecha_llamada(fecha);
        llamada.setHora_inicio(horaInicio);
        llamada.setHora_fin(horaFin);
        llamada.setDuracion(duracion);
        llamada.setDescripcion_tipo(descripcionTipo);
        llamada.setId_agente(idAgente);
        llamada.setId_tipo(idTipo);
        llamada.setEstado_llamada(estado);
        llamada.setMotivo_tipo(motivo);
        llamada.setDuracion(duracion);
        llamada.setEstado(estado);
        llamada.setDescripcion_llamada(descripcion);
        return llamada;
    }

    private void asignarMotivo(Llamada llamada) {
        Integer idTipo = llamada.getId_tipo();
        if (idTipo == null) return;
        Tipificacion tip = tipificacionDAO.obtenerTipificacionPorId(idTipo);
        if (tip != null) {
            llamada.setMotivo_tipo(tip.getMotivo_tipo());
        }
    }

    private String calcularDuracion(String horaInicio, String horaFin) {
        LocalTime inicio = LocalTime.parse(horaInicio, FORMATO_HORA);
        LocalTime fin = LocalTime.parse(horaFin, FORMATO_HORA);
        Duration duracion = Duration.between(inicio, fin);
        if (duracion.isNegative()) {
            duracion = duracion.plusHours(24);
        }

        long horas = duracion.toHours();
        long minutos = duracion.toMinutesPart();
        long segundos = duracion.toSecondsPart();
        List<String> partes = new ArrayList<>();

        if (horas > 0) partes.add(horas + " h");
        if (minutos > 0) partes.add(minutos + " min");
        if (segundos > 0 || partes.isEmpty()) partes.add(segundos + " seg");
        return String.join(" ", partes);
    }

    private void completarFinYDuracion(Llamada llamada) {
        if (llamada.getHora_fin() == null || llamada.getHora_fin().isBlank()) {
            llamada.setHora_fin(LocalTime.now().format(FORMATO_HORA_COMPLETA));
        }
        if (llamada.getDuracion() == null || llamada.getDuracion().isBlank()) {
            llamada.setDuracion(calcularDuracion(llamada.getHora_inicio(), llamada.getHora_fin()));
        }
    }
}
