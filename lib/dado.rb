require "singleton"

module ModeloQytetet
  class Dado
    include Singleton

    def tirar
      1 + rand(6)
    end
  end
end