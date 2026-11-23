# 🧾 Sistema de Facturación y Reportes (SOLID + ORM)

Proyecto integrador que combina programación orientada a objetos, principios SOLID y persistencia con SQLAlchemy para gestionar productos, pedidos, cálculo de descuentos y exportación automática de facturas en PDF (`reporte_pedidos.pdf`).

## 📂 Módulos principales
* **`producto.py` / `pedido.py` / `factura.py`:** Modelos de dominio y reglas de negocio.
* **`descuento.py`:** Lógica extensible para aplicación de descuentos.
* **`api.py`:** Capa de interacción y servicios.
* **`reporte.py`:** Generación automática del resumen de pedidos en formato PDF.
* **`main.py`:** Punto de entrada y ejecución del flujo completo.