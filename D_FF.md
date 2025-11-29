# 💻 Implementación de D Flip-Flop en Verilog

Este módulo Verilog implementa un **D Flip-Flop (D-FF)** activado por el flanco positivo del reloj (**Positive Edge Triggered**). Su función principal es **almacenar el valor** de la entrada D y proporcionar la salida Q y su complemento Qn.

## Descripción
Un D Flip-Flop captura el valor presente en la entrada D en el instante del flanco positivo del reloj (clk) y lo mantiene en la salida Q hasta el siguiente flanco positivo. Este ejemplo es ideal para entender la lógica secuencial básica en Verilog.

## Código
```verilog
module D_ff (
  input clk,  // Entrada de la señal de Reloj (Clock). Control de sincronización. 
  input D,    // Entrada de Datos (Data). El valor que se va a almacenar.
  output reg Q, // Salida Principal (Q). Declarada como 'reg' porque su valor es
                // almacenado y modificado dentro de un bloque 'always'.
  output Qn  // Salida Complementaria (Q bar). El complemento de Q.
);

// lógica secuencial
always @(posedge clk) begin
  // Este bloque 'always' define la lógica secuencial del Flip-Flop.
  // Solo se ejecuta en el flanco POSITIVO (posedge) de la señal clk.
  
  Q <= D;  // Asignación No Bloqueante (<=): Transfiere el valor de D a Q.
           // Esto define la función de retención y actualización del D-FF.
end

assign Qn = ~Q; // asignación de la salida negada de Q
endmodule
```

## Uso rápido
1. Coloca d_ff.v en tu simulador o entorno de síntesis (por ejemplo, Icarus Verilog, ModelSim, etc.).  
2. Simula aplicando estímulos a D y generando un reloj en clk para observar cómo Q sigue a D en cada flanco positivo.  
3. Si quieres un testbench de ejemplo, te lo genero.

## modulo de estimulo
```verilog
`timescale 1ns / 1ps

module D_ff_tb;

    // 1. Declaración de señales de prueba (reg para entradas, wire para salidas)
    reg clk;
    reg D;
    wire Q;
    wire Qn;

    // Parámetros para la generación del reloj
    parameter PERIOD = 10; // Período del reloj en ns (frecuencia de 100 MHz)
    parameter HALF_PERIOD = PERIOD / 2;

    // 2. Instancia del Módulo bajo Prueba (Device Under Test - DUT)
    D_ff DUT (
        .clk(clk),
        .D(D),
        .Q(Q),
        .Qn(Qn)
    );

    // 3. Generación de la señal de reloj (clock)
    initial begin
        // Inicializar clk a 0
        clk = 0;
        // Generar un reloj continuo con un ciclo de trabajo del 50%
        forever #(HALF_PERIOD) clk = ~clk;
    end

    // 4. Generación de la secuencia de estímulos (data)
    initial begin
        // Inicializar entradas de datos
        D = 0;

        // Iniciar la simulación y observar el reset (si existiera)
        $display("Tiempo | clk | D | Q | Qn");
        $monitor("%t |  %b  | %b | %b | %b", $time, clk, D, Q, Qn);
        
        // Estímulos de prueba:

        // 0 ns: Valores iniciales
        #2; 

        // 2 ns: Aplicar D=1 (antes del primer flanco)
        D = 1;
        #8; // Esperar al primer flanco POSITIVO (10 ns)

        // 10 ns (Flanco): Q debería cambiar de 0 a 1

        // 12 ns: Cambiar D=0 (antes del segundo flanco)
        D = 0;
        #8; // Esperar al segundo flanco POSITIVO (20 ns)
        
        // 20 ns (Flanco): Q debería cambiar de 1 a 0

        // 22 ns: Mantener D=0
        #8; // Esperar al tercer flanco POSITIVO (30 ns)
        
        // 30 ns (Flanco): Q debería permanecer en 0

        // 32 ns: Cambiar D=1
        D = 1;
        #8; // Esperar al cuarto flanco POSITIVO (40 ns)

        // 40 ns (Flanco): Q debería cambiar de 0 a 1

        // Finalizar la simulación
        #20 $finish;
    end

    // Para guardar datos en un archivo VCD (opcional, para visualización de ondas)
    initial begin
        $dumpfile("D_ff.vcd");
        $dumpvars(0, D_ff_tb);
    end

endmodule
```
