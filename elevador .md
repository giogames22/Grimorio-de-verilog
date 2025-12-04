
## 🛗 Diseño de un Sistema de Control de Elevador Multinivel

---

### 1. Planteamiento del Problema

Se desea diseñar un **sistema digital de control** para un elevador con un número **parametrizable de pisos $N$**.

El sistema debe gestionar:
* Las solicitudes de piso.
* El movimiento del elevador.
* La apertura/cierre de puertas.
* Garantizar condiciones seguras de operación mediante sensores y modos especiales.

El diseño se implementará como una **FSM (Finite State Machine)** y módulos auxiliares como registros, colas (**FIFO**), temporizadores y lógica de control.

---

### 2. Requerimientos del Sistema

#### 2.1 Parámetros

| Parámetro | Descripción |
| :--- | :--- |
| **N** | Cantidad de pisos (parametrizable). |
| **Tiempo de apertura de puertas** | Configurable (5–10 s). |

---

### 3. Entradas del Sistema

| Señal | Tipo | Descripción |
| :--- | :--- | :--- |
| **clk** | Reloj | Señal de reloj principal |
| **rst\_n** | Reset asincrónico | Restablece el sistema |
| **req\_piso[N-1:0]** | Vector | Solicitudes de piso desde el **panel interno** |
| **req\_llamada[N-1:0]** | Vector | Botones externos (subir/bajar según piso) |
| **puerta\_cerrada** | Sensor | **1** si la puerta está totalmente cerrada |
| **puerta\_abierta** | Sensor | **1** si la puerta está abierta |
| **sensor\_antitrap** | Sensor | Detecta obstáculos en el cierre de puerta |
| **btn\_emergencia** | Botón | Detiene el elevador inmediatamente |
| **encoder\_pos** | Sensor | Sensor incremental o indicador del piso actual |

---

### 4. Salidas del Sistema

| Señal | Tipo | Descripción |
| :--- | :--- | :--- |
| **motor\_up** | Output | Activa motor hacia **arriba** |
| **motor\_down** | Output | Activa motor hacia **abajo** |
| **abrir\_puerta** | Output | Activa mecanismo de apertura |
| **cerrar\_puerta** | Output | Activa mecanismo de cierre |
| **display\_piso** | Número | Indica piso actual |
| **indicador\_subiendo** | LED | Muestra movimiento ascendente |
| **indicador\_bajando** | LED | Muestra movimiento descendente |
| **alarma\_emergencia** | LED/Output | Indica modo de emergencia |
| **bloqueo\_motor** | Output | Apaga motor por seguridad |

---

### 5. Funciones Principales del Sistema

#### 5.1 Gestión de Solicitudes

* Se deben poder **almacenar múltiples solicitudes** simultáneamente.
* Se puede usar:
    * Un **FIFO** para manejar todas las solicitudes en orden.
    * O un **registro de bits (bitmask)** que marque los pisos pedidos.

#### 5.2 Movimiento Inteligente

* **Prioridad** según dirección actual.
* Minimizar **cambios de dirección**.
* **Pausa** en cada piso solicitado.

#### 5.3 Control de Puertas

* **Abrir** al llegar a un piso solicitado.
* Mantener **abiertas** por el tiempo programado.
* **No moverse** si $puerta\_cerrada = 0$.
* **Reabrir** si $sensor\_antitrap = 1$.

#### 5.4 Modo de Emergencia

Al presionar **btn\_emergencia**:

* Se **desactiva el motor y se bloquea** 
* Se **abren las puertas** si es seguro.
* Se **limpian las solicitudes**.
* El sistema espera a que se **libere la emergencia**.

#### 5.5 Indicadores

* Mostrar **piso actual** en leds o display
* LED de **dirección** según sentido del motor.
* Señal de **alarma** durante emergencia.

---


crear un codigo  en verilog para el funcionamiento de un elevador, debe contar con un numero n de botones 
```verilog
//creacion de un elevador 
module elevador #(parameter n = 4)(
  input  [n-1:0] button,
  input  [n-1:0] sensor,
  input          door, 
  output reg     up, 
  output reg     down,
  output [n-1:0] piso_indicado
);
//asignacion de un indicador de piso  por luces
  assign piso_indicado = sensor;

// seleccion de pisos y mov del elevador  
  always (*) begin
    if (door == 1) begin//revisa que la puerta este cerrada
      
      if (button > sensor) begin // si el piso esta por encima sube
        up   = 1;
        down = 0;
      end
      else if (button < sensor) begin //si el piso esta por debajo baja
        up   = 0;
        down = 1;
      end
      else begin // si ya etsamos en el piso no se mueve
        up   = 0;
        down = 0;
      end
// si la puerta esta abierta no se mueve 
    end 
    else begin
      up   = 0;
      down = 0;
    end
  end

endmodule
```
