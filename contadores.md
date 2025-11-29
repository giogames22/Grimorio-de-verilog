# Contador

Un contador es un circuito secuencial digital que almacena un valor y lo actualiza cada vez que ocurre un evento, normalmente un flanco del reloj. Se usa para contar pulsos, ciclos, elementos que pasan por un sistema, o para generar secuencias binarias.

Los contadores están formados internamente por flip-flops y una lógica de próximo estado.

<img width="3999" height="1472" alt="imagen_2025-11-28_204035727" src="https://github.com/user-attachments/assets/8b1e24a4-efd9-425a-b3dd-11ca1feaca33" />

## Ejemplo 1: Contador ascendete con lógica de “próximo estado”
Este estilo separa el cálculo del próximo valor (nVAL) del registro que guarda el valor actual.
```verilog
//contador ascendente
module contA(BCLK,BnRES,VAL);
	input BCLK; //delcaracion del reloj
	input BnRES; // declaracion del boton de reset
    output [3:0] VAL;//declaracion de las salidas del contador

  // Declaración de registros internos
    reg [3:0] VAL, nVAL;// VAL: Valor Actual (se almacena en el flip-flop)
	                    // nVAL: Próximo Valor (siguiente estado)

  //cambio con el flanco positivo del reloj o el positivo del reset
always @(posedge BCLK or posedge BnRES)
    if(BnRES==1) VAL=0; //si el boton reset vale 1 resetear a 0
    else VAL=nVAL; // si cambia clock y no reset val toma el valor de nval

always @(VAL)
    nVAL=VAL+1;// si cambia val  nval es igual al valor de val +1

endmodule
```
## Ejemplo 2: Contador ascendente simple (método directo)
Este estilo es más corto y práctico para proyectos reales.
```verilog
module contador_simple (
    input  wire clk,
    input  wire rst,     // reset síncrono
    output reg [7:0] q   // contador de 8 bits (0–255)
);

always @(posedge clk) begin
    if (rst)
        q <= 8'd0;       // reset
    else
        q <= q + 1;      // incrementa
end

endmodule
```
## Ejemplo 3 contador descendente simple

```verilog
module contador_descendente (
    input  wire clk,     // reloj
    input  wire rst,     // reset síncrono
    output reg [3:0] q   // salida del contador
);

always @(posedge clk) begin
    if (rst)
        q <= 4'd15;      // inicia en 15
    else
        q <= q - 1;      // cuenta hacia abajo
end

endmodule
```
## Ejemplo 4 contador ascendente/descendente

```verilog
module contador_updown (
    input  wire clk,       // reloj
    input  wire rst,       // reset síncrono
    input  wire up_down,   // 1 = up (sube), 0 = down (baja)
    output reg [3:0] q     // salida del contador
);

always @(posedge clk) begin
    if (rst)
        q <= 4'd0;                 // reset a 0 (puedes cambiarlo si quieres)
    else begin
        if (up_down)
            q <= q + 1;            // cuenta ascendente
        else
            q <= q - 1;            // cuenta descendente
    end
end

endmodule

```
