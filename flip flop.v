module D_ff (
  input clk,  // Entrada de la señal de Reloj (Clock). Control de sincronización. 
  input D,    // Entrada de Datos (Data). El valor que se va a almacenar.
  output reg Q, // Salida Principal (Q). Declarada como 'reg' porque su valor es
                // almacenado y modificado dentro de un bloque 'always'.
  output Qn  // Salida Complementaria (Q bar). El complemento de Q.
);

//logica secuencial
always @(posedge clk) begin
  // Este bloque 'always' define la lógica secuencial del Flip-Flop.
  // Solo se ejecuta en el flanco POSITIVO (posedge) de la señal clk.
  
  Q <= D;  // Asignación No Bloqueante (<=): Transfiere el valor de D a Q.
           // Esto define la función de retención y actualización del D-FF.
end

assign Qn = ~Q; // asignacion de la salida negada de Q
endmodule 
  
