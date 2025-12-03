# PROBLEMA ELEVADOR
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
