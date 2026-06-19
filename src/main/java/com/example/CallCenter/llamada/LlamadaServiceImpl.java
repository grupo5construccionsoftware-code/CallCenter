package com.example.CallCenter.llamada;

import com.example.CallCenter.agente.Agente;
import com.example.CallCenter.agente.AgenteRepository;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Duration;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class LlamadaServiceImpl implements LlamadaService {

    private final LlamadaRepository llamadaRepository;
    private final AgenteRepository agenteRepository;

    private static final DateTimeFormatter FORMATO_HORA        = DateTimeFormatter.ofPattern("HH:mm[:ss]");
    private static final DateTimeFormatter FORMATO_HORA_SIMPLE = DateTimeFormatter.ofPattern("HH:mm");

    public LlamadaServiceImpl(LlamadaRepository llamadaRepository, AgenteRepository agenteRepository) {
        this.llamadaRepository = llamadaRepository;
        this.agenteRepository = agenteRepository;
    }

    @Override
    public List<Llamada> listarLlamadas() {
        return llamadaRepository.findAll();
    }

    @Override
    public List<Llamada> listarLlamadasPorAgente(int idAgente) {
        return llamadaRepository.findByIdAgente(idAgente);
    }

    @Override
    public List<Llamada> listarLlamadasPorAgentes(Collection<Integer> idsAgentes) {
        return llamadaRepository.findByIdAgenteIn(idsAgentes);
    }

    @Override
    public Llamada obtenerLlamadaPorId(int id_llamada) {
        return llamadaRepository.findById(id_llamada).orElse(null);
    }

    @Override
    public void crearLlamada(Llamada llamada) {
        // 1. Fecha actual si no viene
        if (llamada.getFecha_llamada() == null || llamada.getFecha_llamada().isBlank()) {
            llamada.setFecha_llamada(LocalDate.now().toString());
        }

        // 2. Hora inicio — recortar a HH:mm
        llamada.setHora_inicio(recortarHora(llamada.getHora_inicio()));

        // 3. Hora fin — recortar a HH:mm
        if (llamada.getHora_fin() == null || llamada.getHora_fin().isBlank()) {
            llamada.setHora_fin(LocalTime.now().format(FORMATO_HORA_SIMPLE));
        } else {
            llamada.setHora_fin(recortarHora(llamada.getHora_fin()));
        }

        // 4. Duración
        if (llamada.getDuracion() == null || llamada.getDuracion().isBlank()) {
            llamada.setDuracion(calcularDuracion(llamada.getHora_inicio(), llamada.getHora_fin()));
        }

        // 5. Estado por defecto
        if (llamada.getEstado_llamada() == null || llamada.getEstado_llamada().isBlank()) {
            llamada.setEstado_llamada("Activo");
        }

        // 6. Motivo tipificación
        asignarMotivo(llamada);

        Llamada guardada = llamadaRepository.save(llamada);

        // 7. Código de llamada: Lla{numeroParaEseAgente}{codigoDelAgente}
        // Ej: agente con codigo "Age1E4" -> su 1ra llamada es "Lla1Age1E4"
        int numeroParaAgente = llamadaRepository.contarLlamadasHastaId(
                guardada.getId_agente(), guardada.getId_llamada());
        Agente agente = agenteRepository.findById(guardada.getId_agente()).orElse(null);
        String codigoAgente = (agente != null && agente.getCodigo_agente() != null)
                ? agente.getCodigo_agente()
                : "Age" + guardada.getId_agente();
        guardada.setCodigo_llamada("Lla" + numeroParaAgente + codigoAgente);
        llamadaRepository.save(guardada);
    }

    @Override
    public void actualizarLlamada(Llamada llamada) {
        Llamada actual = llamadaRepository.findById(llamada.getId_llamada()).orElse(null);
        if (actual == null) return;

        // Preservar campos que no se editan
        llamada.setFecha_llamada(actual.getFecha_llamada());
        llamada.setId_agente(actual.getId_agente());
        llamada.setCodigo_llamada(actual.getCodigo_llamada());

        if (llamada.getHora_inicio() == null || llamada.getHora_inicio().isBlank())
            llamada.setHora_inicio(actual.getHora_inicio());
        if (llamada.getHora_fin() == null || llamada.getHora_fin().isBlank())
            llamada.setHora_fin(actual.getHora_fin());
        if (llamada.getDuracion() == null || llamada.getDuracion().isBlank())
            llamada.setDuracion(actual.getDuracion());
        if (llamada.getEstado_llamada() == null || llamada.getEstado_llamada().isBlank())
            llamada.setEstado_llamada(actual.getEstado_llamada());

        // Reasignar motivo por si cambió la tipificación
        asignarMotivo(llamada);

        llamadaRepository.save(llamada);
    }

    @Override
    public void eliminarLlamada(int id_llamada) {
        llamadaRepository.deleteById(id_llamada);
    }

    // ── Auxiliares ─────────────────────────────────────────────────────────────

    private void asignarMotivo(Llamada llamada) {
        if (llamada.getId_tipo() == null || llamada.getId_tipo() <= 0) return;
        String motivo = llamadaRepository.findMotivoByIdTipo(llamada.getId_tipo());
        if (motivo != null) llamada.setMotivo_tipo(motivo);
    }

    private String recortarHora(String hora) {
        if (hora == null || hora.isBlank()) return LocalTime.now().format(FORMATO_HORA_SIMPLE);
        try {
            return LocalTime.parse(hora, FORMATO_HORA).format(FORMATO_HORA_SIMPLE);
        } catch (Exception e) {
            return hora.length() >= 5 ? hora.substring(0, 5) : hora;
        }
    }

    private String calcularDuracion(String horaInicio, String horaFin) {
        try {
            LocalTime inicio = LocalTime.parse(horaInicio, FORMATO_HORA);
            LocalTime fin    = LocalTime.parse(horaFin,    FORMATO_HORA);
            Duration dur = Duration.between(inicio, fin);
            if (dur.isNegative()) dur = dur.plusHours(24);

            long horas   = dur.toHours();
            long minutos = dur.toMinutesPart();
            long segundos = dur.toSecondsPart();

            List<String> partes = new ArrayList<>();
            if (horas    > 0) partes.add(horas    + " h");
            if (minutos  > 0) partes.add(minutos  + " min");
            if (segundos > 0 || partes.isEmpty()) partes.add(segundos + " seg");
            return String.join(" ", partes);
        } catch (Exception e) {
            return "0 seg";
        }
    }
}