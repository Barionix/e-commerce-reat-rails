module ChartHelper
  def generate_chart_code(length = 5)
    alphabet = ('A'..'Z').to_a

    loop do
      code = Array.new(length) { alphabet.sample }.join

      # Verifica se o código já existe no banco
      return code unless Chart.exists?(code: code)
    end
  end
end
