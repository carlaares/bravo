module Bravo
  class Request
    attr_accessor :concept, :document_type, :date, :currency_id, :iva_code,
      :net_amount, :iva_amount, :document_number, :total, :from, :to,
      :date_from, :date_to, :due_on, :header

    def to_hash
      { 'FeCAEReq' => { 'FeCabReq' => header, 'FeDetReq' => build_details } }
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def build_details
      details = {
        'FECAEDetRequest' => {
          'Concepto'    => concept,
          'DocTipo'     => document_type,
          'CbteFch'     => date,
          'ImpTotConc'  => 0.00,
          'MonId'       => currency_id,
          'MonCotiz'    => 1,
          'ImpOpEx'     => 0.00,
          'ImpTrib'     => 0.00,
          'DocNro'      => document_number,
          'ImpNeto'     => net_amount,
          'ImpIVA'      => iva_amount,
          'ImpTotal'    => total,
          'CbteDesde'   => from,
          'CbteHasta'   => to,
          'FchServDesde' => date_from,
          'FchServHasta' => date_to,
          'FchVtoPago' => due_on,
          'Iva' => iva_array
        }
      }
      details.reject { |_k, v| v.nil? }
    end

    private

    def iva_array
      if Bravo.own_iva_cond == :responsable_monotributo
        nil
      else
        {
          'AlicIva' => {
            'Id'      => iva_code,
            'BaseImp' => net_amount,
            'Importe' => iva_amount
          }
        }
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
  end
end
