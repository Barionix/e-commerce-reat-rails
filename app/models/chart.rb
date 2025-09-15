class Chart < ApplicationRecord
  def self.generate_unique_code(length = 5)
    alphabet = ('A'..'Z').to_a

    loop do
      code = Array.new(length) { alphabet.sample }.join
      return code unless exists?(code: code)
    end
  end
  
  validates :preco, presence: true
  validates :code, uniqueness: true

end
