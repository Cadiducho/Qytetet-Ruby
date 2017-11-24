module ModeloQytetet
  class Jugador

    attr_accessor :encarcelado
    attr_reader :nombre
    attr_accessor :saldo
    attr_accessor :casilla_actual
    attr_accessor :carta_libertad
    attr_reader :propiedades

    def initialize(nombre)
      @nombre = nombre
      @encarcelado = false
      @saldo = 750
      @casilla_actual = nil
      @carta_libertad = nil
      @propiedades = Array.new
    end

    def tengo_propiedades
      !@propiedades.empty?
    end

    def actualizar_posicion(casilla)
      if casilla.numero_casilla < @casilla_actual.numero_casilla
        modificar_saldo(Qytetet.instance.SALDO_SALIDA)
      end

      tiene_propietario = false
      @casilla_actual = casilla
      if casilla.soy_edificable
        tiene_propietario = casilla.tengo_propietario
        if tiene_propietario
          unless casilla.propietario_encarcelado
            coste_alquiler = casilla.cobrar_alquiler
            modificar_saldo(-1 * coste_alquiler)
          end
        end
      elsif casilla.tipo == TipoCasilla::IMPUESTO
        coste = casilla.coste
        modificar_saldo(-1 * coste)
      end

      tiene_propietario
    end

    def comprar_titulo
      puedo_comprar = false
      if @casilla_actual.soy_edificable
        unless @casilla_actual.tengo_propietario
          coste_compra = @casilla_actual.coste
          if coste_compra <= @saldo
            titulo = @casilla_actual.asignar_propietario(self)
            @propiedades << titulo
            modificar_saldo(-1 * coste_compra)

            puedo_comprar = true
          end
        end
      end
      puedo_comprar
    end

    def devolver_carta_libertad
      old = @carta_libertad
      Qytetet.instance.mazo << old
      @carta_libertad = nil
      old
    end

    def ir_a_carcel(casilla)
      @casilla_actual = casilla
      @encarcelado = true
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

    def pagar_libertad(precio_libertad)
      tengo_saldo_cond = tengo_saldo(precio_libertad)
      if tengo_saldo_cond
        modificar_saldo(-1 * precio_libertad)
      end
      tengo_saldo_cond
    end

    def puedo_edificar_casa(casilla)
      es_de_mipropiedad(casilla) && tengo_saldo(casilla.precio_edificar)
    end

    def puedo_edificar_hotel(casilla)
      es_de_mipropiedad(casilla) && tengo_saldo(casilla.precio_edificar)
    end

    def puedo_hipotecar(casilla)
      es_de_mipropiedad(casilla)
    end

    def puedo_pagar_hipoteca(casilla)
      es_de_mipropiedad(casilla) && (casilla.calcular_valor_hipoteca * 1.10) <= @saldo
    end

    def puedo_vender_propiedad(casilla)
      casilla.hipotecada && casilla.titulo.propietario.equal?(self)
    end

    def tengo_carta_libertad
      @carta_libertad != nil
    end

    def vender_propiedad(casilla)
      precio_venta = casilla.vender_titulo
      casilla.titulo.propietario = nil
      casilla.num_casas = 0
      casilla.num_hoteles = 0
      modificar_saldo(precio_venta)
      eliminar_de_mis_propiedades(casilla)
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