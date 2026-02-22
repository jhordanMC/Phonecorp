package domain;

import java.time.LocalDateTime;

public class EntidadComprobante {
    private Integer idComprobante;
    private Integer idPago; // UNIQUE (1 a 1 con Pago)
    private String tipoComprobante;
    private String serie;
    private String numeroCorrelativo;
    private String hashSunat; // nullable
    private LocalDateTime fechaEmision; // default GETDATE()

    public EntidadComprobante() {}

    public EntidadComprobante(Integer idComprobante, Integer idPago, String tipoComprobante, String serie,
                              String numeroCorrelativo, String hashSunat, LocalDateTime fechaEmision) {
        this.idComprobante = idComprobante;
        this.idPago = idPago;
        this.tipoComprobante = tipoComprobante;
        this.serie = serie;
        this.numeroCorrelativo = numeroCorrelativo;
        this.hashSunat = hashSunat;
        this.fechaEmision = fechaEmision;
    }

    public Integer getIdComprobante() { return idComprobante; }
    public void setIdComprobante(Integer idComprobante) { this.idComprobante = idComprobante; }

    public Integer getIdPago() { return idPago; }
    public void setIdPago(Integer idPago) { this.idPago = idPago; }

    public String getTipoComprobante() { return tipoComprobante; }
    public void setTipoComprobante(String tipoComprobante) { this.tipoComprobante = tipoComprobante; }

    public String getSerie() { return serie; }
    public void setSerie(String serie) { this.serie = serie; }

    public String getNumeroCorrelativo() { return numeroCorrelativo; }
    public void setNumeroCorrelativo(String numeroCorrelativo) { this.numeroCorrelativo = numeroCorrelativo; }

    public String getHashSunat() { return hashSunat; }
    public void setHashSunat(String hashSunat) { this.hashSunat = hashSunat; }

    public LocalDateTime getFechaEmision() { return fechaEmision; }
    public void setFechaEmision(LocalDateTime fechaEmision) { this.fechaEmision = fechaEmision; }
}