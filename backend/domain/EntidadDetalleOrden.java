package domain;

import java.math.BigDecimal;

public class EntidadDetalleOrden {
    private Integer idDetalle;
    private Integer idOrden;
    private Integer idProducto;
    private Integer cantidad;
    private BigDecimal precioPactado;
    private BigDecimal subtotal;

    public EntidadDetalleOrden() {}

    public EntidadDetalleOrden(Integer idDetalle, Integer idOrden, Integer idProducto, Integer cantidad,
                               BigDecimal precioPactado, BigDecimal subtotal) {
        this.idDetalle = idDetalle;
        this.idOrden = idOrden;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
        this.precioPactado = precioPactado;
        this.subtotal = subtotal;
    }

    public Integer getIdDetalle() { return idDetalle; }
    public void setIdDetalle(Integer idDetalle) { this.idDetalle = idDetalle; }

    public Integer getIdOrden() { return idOrden; }
    public void setIdOrden(Integer idOrden) { this.idOrden = idOrden; }

    public Integer getIdProducto() { return idProducto; }
    public void setIdProducto(Integer idProducto) { this.idProducto = idProducto; }

    public Integer getCantidad() { return cantidad; }
    public void setCantidad(Integer cantidad) { this.cantidad = cantidad; }

    public BigDecimal getPrecioPactado() { return precioPactado; }
    public void setPrecioPactado(BigDecimal precioPactado) { this.precioPactado = precioPactado; }

    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) { this.subtotal = subtotal; }
}