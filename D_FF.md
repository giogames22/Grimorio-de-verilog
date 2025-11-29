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

## Notas
- Renombra el archivo Verilog a `d_ff.v` para evitar espacios en el nombre (recomendado).
- Mantén las imágenes o diagramas en la carpeta `images/`.

## Diagrama
![Diagrama D Flip-Flop]([images/dff_diagram.png](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.analog.com%2Fen%2Fresources%2Fglossary%2Fd-flip-flop.html&psig=AOvVaw2IQ086A_DJVvGvo0aWzhP_&ust=1764464975390000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCNCkxrKWlpEDFQAAAAAdAAAAABAL))
