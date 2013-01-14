module Alsa
  class Error < StandardError
    attr_reader :code

    def initialize( code )
      @code = code
      super("ALSA error : #{@code} #{error_string}")
    end

    def error_string
      @error_string ||= Asound::Seq.snd_strerror( code )
    end
  end
end
