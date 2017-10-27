module ModeloQytetet
  class Jugador

    attr_accessor :encarcelado
    attr_reader :nombre
    attr_reader :saldo
    attr_reader :casilla_actual
    attr_reader :carta_libertad

    def initialize(nombre)
      @nombre = nombre
      @encarcelado = false;
      @saldo = 750
      @casilla_actual = nil
      @carta_libertad = nil
    end

    def tengo_propiedades
      raise NotImplementedError.new
    end

    def actualizar_posicion(casilla)
      @casilla_actual = casilla
    end

    def comprar_titulo
      raise NotImplementedError.new
    end

    def devolver_carta_libertad
      raise NotImplementedError.new
    end

    def ir_a_carcel(casilla)
      raise NotImplementedError.new
    end

    def modificar_saldo(saldo)
      raise NotImplementedError.new
    end

    def obtener_capital
      @saldo
    end

    def obtener_propiedades_hipotecadas(hipotecada)
      raise NotImplementedError.new
    end

    def pagar_cobrar_por_casa_y_hotel(cantidad)
      raise NotImplementedError.new
    end

    def pagar_libertad(cantidad)
      raise NotImplementedError.new
    end

    def puedo_edificar_casa(casilla)
      raise NotImplementedError.new
    end

    def puedo_edificar_hotel(casilla)
      raise NotImplementedError.new
    end

    def puedo_hipotecar(casilla)
      raise NotImplementedError.new
    end

    def puedo_pagar_hipoteca(casilla)
      raise NotImplementedError.new
    end

    def puedo_vender_propiedad(casilla)
      raise NotImplementedError.new
    end

    def tengo_carta_libertad
      @carta_libertad != nil
    end

    def vender_propiedad(casilla)
      raise NotImplementedError.new
    end

    def cuantas_casas_hoteles_tengo
      raise NotImplementedError.new
    end

    def eliminar_de_mis_propiedades(casilla)
      raise NotImplementedError.new
    end

    def es_de_mipropiedad(casilla)
      raise NotImplementedError.new
    end

    def tengo_saldo(cantidad)
      cantidad <= @saldo
    end
    
    def to_s
      "Nombre: #{nombre} \n Encarcelado: #{@encarcelado} \n Saldo: #{@saldo} \n @Casilla Actual #{@casilla_actual}\n Carta Libertad #{@carta_libertad}"
    end
  end
end