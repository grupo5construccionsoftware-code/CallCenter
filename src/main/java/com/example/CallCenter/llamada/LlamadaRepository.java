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
                llamada.setFecha_llamada(llamadaActual.getFecha_llamada());
                llamada.setId_agente(llamadaActual.getId_agente());

                if (llamada.getHora_inicio() == null || llamada.getHora_inicio().isBlank()) {
                    llamada.setHora_inicio(llamadaActual.getHora_inicio());
                }
                if (llamada.getHora_fin() == null || llamada.getHora_fin().isBlank()) {
                    llamada.setHora_fin(llamadaActual.getHora_fin());
                }
                if (llamada.getDuracion() == null || llamada.getDuracion().isBlank()) {
                    llamada.setDuracion(llamadaActual.getDuracion());
                }
                if (llamada.getEstado_llamada() == null || llamada.getEstado_llamada().isBlank()) {
                    llamada.setEstado_llamada(llamadaActual.getEstado_llamada());
                }

                asignarMotivo(llamada);
                llamadas.set(i, llamada);
                break;
            }
        }
    }

    @Override
    public void eliminarLlamada(int id_llamada) {
        // Borrado lógico
        Llamada llamada = obtenerLlamadaPorId(id_llamada);
        if (llamada != null) {
            llamada.setEstado_llamada("Eliminado");
        }
    }

    // ── Datos iniciales ────────────────────────────────────────────────────────

    private void cargarLlamadasIniciales() {
        llamadas.add(crearLlamadaInicial(1, "Maria Lopez",   "987654321", "2026-05-01", "09:10", "09:20", "10 min", "El cliente consulta sobre su factura",     1, 1, "Activo", "Consulta"));
        llamadas.add(crearLlamadaInicial(2, "Carlos Perez",  "923456781", "2026-05-02", "10:25", "10:40", "15 min", "El cliente presenta una queja por cobro",   1, 2, "Activo", "Reclamo"));
        llamadas.add(crearLlamadaInicial(3, "Ana Torres",    "934567812", "2026-05-03", "11:40", "11:55", "15 min", "El cliente adquiere el plan básico",        1, 3, "Activo", "Venta"));
        llamadas.add(crearLlamadaInicial(4, "Luis Ramirez",  "945678123", "2026-05-04", "13:15", "13:30", "15 min", "El cliente necesita ayuda con la app",      1, 4, "Activo", "Soporte"));
        llamadas.add(crearLlamadaInicial(5, "Rosa Garcia",   "956781234", "2026-05-05", "15:05", "15:12", "7 min",  "Consulta general",                         1, 5, "Activo", "Otros"));
    }

    private Llamada crearLlamadaInicial(int id, String cliente, String telefono,
                                        String fecha, String horaInicio, String horaFin,
                                        String duracion, String descripcion,
                                        int idAgente, int idTipo, String estado, String motivo) {
        Llamada llamada = new Llamada();
        llamada.setId_llamada(id);
        llamada.setNombre_cliente(cliente);
        llamada.setTelefono_cliente(telefono);
        llamada.setFecha_llamada(fecha);
        llamada.setHora_inicio(horaInicio);
        llamada.setHora_fin(horaFin);
        llamada.setDuracion(duracion);
        llamada.setDescripcion_tipo(descripcion);
        llamada.setId_agente(idAgente);
        llamada.setId_tipo(idTipo);
        llamada.setEstado_llamada(estado);
        llamada.setMotivo_tipo(motivo);
        return llamada;
    }

    // ── Métodos auxiliares ─────────────────────────────────────────────────────

    private void asignarMotivo(Llamada llamada) {
        Integer idTipo = llamada.getId_tipo();
        if (idTipo == null) return;
        Tipificacion tip = tipificacionDAO.obtenerTipificacionPorId(idTipo);
        if (tip != null) {
            llamada.setMotivo_tipo(tip.getMotivo_tipo());
        }
    }

    private String calcularDuracion(String horaInicio, String horaFin) {
        try {
            LocalTime inicio = LocalTime.parse(horaInicio, FORMATO_HORA);
            LocalTime fin    = LocalTime.parse(horaFin,    FORMATO_HORA);
            Duration dur = Duration.between(inicio, fin);
            if (dur.isNegative()) dur = dur.plusHours(24);

            long horas    = dur.toHours();
            long minutos  = dur.toMinutesPart();
            long segundos = dur.toSecondsPart();

            List<String> partes = new ArrayList<>();
            if (horas   > 0) partes.add(horas   + " h");
            if (minutos > 0) partes.add(minutos  + " min");
            if (segundos > 0 || partes.isEmpty()) partes.add(segundos + " seg");
            return String.join(" ", partes);
        } catch (Exception e) {
            return "0 seg";
        }
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


