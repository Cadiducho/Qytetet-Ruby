#encoding: utf-8

require_relative "jugador"
require_relative "tramposo"

jugador1 = ModeloQytetet::Jugador.new("John")
jugador2 = ModeloQytetet::Tramposo.new(jugador1)
        
puts jugador1.to_s
puts jugador2.to_s

for i in 1..8
  jugador1.modificar_saldo(-1 * i * 30)
  jugador2.modificar_saldo(-1 * i * 30)
end
        
puts jugador1.to_s
puts jugador2.to_s
        
jugador2.perdonar

puts jugador2.to_s