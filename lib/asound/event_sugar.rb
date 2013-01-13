module Asound::Seq
  module EventSugar
    def channel
      self[:data][:note][:channel]
    end

    def note
      self[:data][:note][:note]
    end
    
    def velocity
      self[:data][:note][:velocity]
    end

    def note_on?
      self.type == :SND_SEQ_EVENT_NOTEON
    end

    def set_note(ch, note, vel, dur)
      self[:type] = EVENT_TYPES[:SND_SEQ_EVENT_NOTE]
      self.set_fixed
      #self[:flags] |= SND_SEQ_TIME_STAMP_REAL
      self[:data][:note][:channel] = ch
      self[:data][:note][:note] = note
      self[:data][:note][:velocity] = vel
      self[:data][:note][:duration] = dur
    end

    def set_note_on(ch, note, vel)
      set_note(ch, note, vel, 0)
      self[:type] = EVENT_TYPES[:SND_SEQ_EVENT_NOTEON]
    end

    def set_note_off(ch, note, vel)
      set_note(ch, note, vel, 0)
      self[:type] = EVENT_TYPES[:SND_SEQ_EVENT_NOTEOFF]
    end

    def set_fixed
      self[:flags] &= ~SND_SEQ_EVENT_LENGTH_MASK
      self[:flags] |= SND_SEQ_EVENT_LENGTH_FIXED
    end

    def set_direct
      self[:queue] = SND_SEQ_QUEUE_DIRECT
    end

    def set_source(client, port)
      self[:source][:client] = client
      self[:source][:port] = port
    end

    def set_dest(client, port)
      self[:dest][:client] = client
      self[:dest][:port] = port
    end

    def type
      EVENT_TYPES.invert[ self[:type] ] 
    end

    def inspect
      kv = {}
      if [ :SND_SEQ_EVENT_NOTE, :SND_SEQ_EVENT_NOTEON, :SND_SEQ_EVENT_NOTEOFF ].include?(type)
        [ :channel, :note, :velocity, :off_velocity, :duration ].each do |k|
          kv[k] = self[:data][:note][k]
        end
      end
      [ :source, :dest ].each do |sd|
        kv[sd] =  "#{self[sd][:client]}:#{self[sd][:port]}"
      end
      [:flags, :tag, :queue].each do |k|
        kv[k] = self[k]
      end
      kv[:time] = [self[:time][:tick], self[:time][:time][:tv_sec], self[:time][:time][:tv_sec]].join(':')
      
      "#<#{self.type} #{kv.inspect}>"
    end
  end
end
