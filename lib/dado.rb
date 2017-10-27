require "singleton"

module ModeloQytetet
  class Dado
    include Singleton

    def tirar
      num = 1 + rand(6)
    end
  end
end