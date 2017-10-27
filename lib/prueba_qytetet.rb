#encoding: utf-8

require_relative "qytetet"

module ModeloQytetet

  qytetet = Qytetet.instance

  puts 'Todas las sorpresas'
  qytetet.mazo.each { |sorpresa| puts sorpresa }

  puts 'Todas las casillas'
  qytetet.tablero.casillas.each { |casilla| puts casilla}

end