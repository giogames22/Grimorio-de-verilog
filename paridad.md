# Generador de Paridad - Descripción del Sistema

## Descripción general

El sistema recibe un flujo serial de bits, **agrupados en bytes de 8 bits**, y calcula el **bit de paridad impar** correspondiente a cada byte.
El flujo es continuo y se señaliza cuando cada byte está listo.

---

## Entradas y Salidas

| Señal         | Tipo    | Descripción                                                           |
| ------------- | ------- | --------------------------------------------------------------------- |
| `clk`         | Entrada | Reloj del sistema                                                     |
| `rstn`        | Entrada | Reset asíncrono activo en bajo                                        |
| `data_in`     | Entrada | Bit de entrada serial                                                 |
| `bit_valido`  | Entrada | Indica si `data_in` es válido en este ciclo (1 = válido, 0 = ignorar) |
| `paridad_out` | Salida  | Bit de paridad impar del byte (1 = impar, 0 = par)                    |
| `byte_listo`  | Salida  | Pulso de 1 ciclo indicando que `paridad_out` es válido                |

---

## Comportamiento del sistema

1. Se cuentan **8 bits válidos** (`bit_valido = 1`) para formar un byte.
2. Se calcula la **paridad impar** del byte recibido.
3. Se activa `byte_listo = 1` **solo durante 1 ciclo** al terminar los 8 bits.
4. Después de ese ciclo:

   * `byte_listo` vuelve a 0.
   * Se reinicia el contador y la acumulación de paridad para el siguiente byte.
5. Al activar el reset (`rstn = 0`):

   * Se reinicia el contador.
   * Se borra cualquier acumulación de paridad anterior.
6. Cuando `rstn` vuelve a 1, el módulo empieza a contar desde cero.

---

## Ejemplos de Entrada / Salida

| Datos (byte) | Paridad impar (`paridad_out`) |
| ------------ | ----------------------------- |
| `0000_0000`  | 1                             |
| `0000_0001`  | 0                             |
| `1010_1010`  | 1                             |

---

## Casos de prueba recomendados

* Secuencias de bits: `11000000`, `00000000`, `10101010`
* Señal `bit_valido` intermitente: ejemplo `1, 0, 1, 1, 0, ...`
* Activar `reset` a la mitad de la recepción del byte

---

## Señales clave de funcionamiento

| Señal         | Función                                                           |
| ------------- | ----------------------------------------------------------------- |
| `paridad_reg` | Registro interno que acumula la XOR de los bits del byte          |
| `contador`    | Cuenta cuántos bits válidos se han recibido (0 a N-1)             |
| `paridad_out` | Guarda la paridad final del byte hasta que se reciba el siguiente |
| `byte_listo`  | Pulso de 1 ciclo indicando que `paridad_out` es válido            |

---

## Flujo temporal resumido

1. `rstn = 0` → `contador = 0`, `paridad_reg = 1` (paridad impar inicial), `byte_listo = 0`
2. Cada ciclo:

   * Si `bit_valido = 1` → actualizar `paridad_reg` y `contador`
   * Si `contador == N-1`:

     * Generar `paridad_out`
     * Activar `byte_listo = 1` (1 ciclo)
     * Reiniciar `contador` y `paridad_reg` para siguiente byte
3. `paridad_out` **no se reinicia**, mantiene la salida hasta el siguiente byte

---

## Entregables

* `Paridad.v` → Módulo RTL del generador de paridad
* `Tb_paridad.v` → Testbench simple para validar el módulo

---

## Tiempo estimado de implementación

| Tarea            | Tiempo estimado |
| ---------------- | --------------- |
| RTL              | 25 minutos      |
| Testbench simple | 25 minutos      |
| Debugging final  | 10 minutos      |
