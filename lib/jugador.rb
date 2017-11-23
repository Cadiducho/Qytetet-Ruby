module ModeloQytetet
  class Jugador

    attr_accessor :encarcelado
    attr_reader :nombre
    attr_reader :saldo
    attr_reader :casilla_actual
    attr_reader :carta_libertad
    attr_reader :propiedades

    def initialize(nombre)
      @nombre = nombre
      @encarcelado = false;
      @saldo = 750
      @casilla_actual = nil
      @carta_libertad = nil
      @propiedades = Array.new
    end

    def tengo_propiedades
      !@propiedades.empty?
    end

    def actualizar_posicion(casilla)
      @casilla_actual = casilla
    end

    def comprar_titulo
      raise NotImplementedError.new
    end

    def devolver_carta_libertad
      old = @carta_libertad
      Qytetet.instance.mazo << old
      @carta_libertad = nil
      old
    end

    def ir_a_carcel(casilla)
      raise NotImplementedError.new
    end

    def modificar_saldo(cantidad)
      @saldo += cantidad
    end

    def obtener_capital
      capital = @saldo
      @propiedades.each { |t|
        capital += t.casilla.coste + t.precioEdificar * (t.casilla.num_casas + t.casilla.num_hoteles)
      }
      capital
    end

    def obtener_propiedades_hipotecadas(hipotecada)
      lista = Array.new
      @propiedades.each { |t|
        if t.hipotecada == hipotecada
          lista << t
        end
      }
      lista
    end

    def pagar_cobrar_por_casa_y_hotel(cantidad)
      modificar_saldo(-1 * cantidad * cuantas_casas_hoteles_tengo)
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
      es_de_mipropiedad(casilla)
    end

    def puedo_pagar_hipoteca(casilla)
      es_de_mipropiedad(casilla) && (casilla.coste_hipoteca * 1.10) <= @saldo
    end

    def puedo_vender_propiedad(casilla)
      casilla.hipotecada && casilla.tituulo.propietario.equal?(self)
    end

    def tengo_carta_libertad
      @carta_libertad != nil
    end

    def vender_propiedad(casilla)
      raise NotImplementedError.new
    end

    private
    def cuantas_casas_hoteles_tengo
      total = 0
      @propiedades.each {|t|
        total += t.casilla.num_casas + t.casilla.num_hoteles
      }
      total
    end

    def eliminar_de_mis_propiedades(casilla)
      @propiedades.delete(casilla)
    end

    def es_de_mipropiedad(casilla)
      casilla.titulo.propietario.equal?(self)
    end

    def tengo_saldo(cantidad)
      cantidad <= @saldo
    end
    
    def to_s
      "Nombre: #{nombre} \n Encarcelado: #{@encarcelado} \n Saldo: #{@saldo} \n @Casilla Actual #{@casilla_actual}\n Carta Libertad #{@carta_libertad}"
    end
  end
end