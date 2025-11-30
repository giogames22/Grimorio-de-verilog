# 📘 Registro (Registro de Propósito General)

Un registro es un circuito secuencial digital diseñado para almacenar un conjunto de bits.
Funciona utilizando flip-flops conectados en paralelo, de manera que todos los bits se actualizan simultáneamente en el flanco del reloj.
##🔹 Características principales

*  Almacena N bits (tamaño fijo).
*  Actualiza su contenido solo con un flanco de reloj.
* Puede tener reset para inicializarlo.
* Es la unidad básica de almacenamiento dentro de una CPU, microcontrolador, FPGA o ASIC.

##🔹 Entradas típicas de un registro

* clk → reloj, controla cuándo se actualiza el registro.
* rst → reset, pone el registro en cero.
* d[N-1:0] → datos a guardar.

##🔹 Salida típica
q[N-1:0] → datos almacenados (salida del registro).

## 🔹 Tipos de registro
* Registro simple → almacena un valor.
* Registro con enable → solo guarda cuando enable = 1.
* Registro de desplazamiento (shift register) → mueve los bits.
* Registro circular → rota los bits.
* Banco de registros → varios registros organizados.
