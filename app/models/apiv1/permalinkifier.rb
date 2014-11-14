class Apiv1::Permalinkifier
  IllegalCharacters = '`~!@#$%^&*()_-=+\\|][{}\'";:/?.>,< '.split('') + "\r\n".split('')
  class << self
    def permalinkify(string)
      _single_spacify_string _spacify_illegal_characters string.to_s.downcase
    end

    private
    def _single_spacify_string(string)
      string.gsub(/ +/, ' ').strip
    end
    def _spacify_illegal_characters(string)
      string.split('').map do |char|
        if Apiv1::Permalinkifier::IllegalCharacters.include? char
          ' '
        else
          char
        end
      end.join('')
    end
  end
end