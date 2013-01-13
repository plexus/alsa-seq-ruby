require './alsa_seq'

class AlsaMidi
  attr_reader :in, :out, :handle, :client_id

  def initialize(name, out_caps = SND_SEQ_PORT_CAP_READ|SND_SEQ_PORT_CAP_SUBS_READ)
    seq_handle_p = FFI::MemoryPointer.new :pointer
    check { AlsaSeq.open( seq_handle_p, "default", SND_SEQ_OPEN_DUPLEX, 0 ) } #SND_SEQ_OPEN_INPUT
    @handle = seq_handle_p.get_pointer(0)
    
    check { AlsaSeq.set_client_name( @handle, name ) }
    @in = check { AlsaSeq.create_simple_port(
        @handle, "in", 
        SND_SEQ_PORT_CAP_WRITE|SND_SEQ_PORT_CAP_SUBS_WRITE,
        SND_SEQ_PORT_TYPE_APPLICATION) }

    @out = check { AlsaSeq.create_simple_port(
        @handle, "out", 
        SND_SEQ_PORT_CAP_READ|SND_SEQ_PORT_CAP_SUBS_READ,
        SND_SEQ_PORT_TYPE_MIDI_GENERIC|SND_SEQ_PORT_TYPE_APPLICATION) }

    @client_id = check { AlsaSeq.client_id( @handle ) }

    @handle
  end

  def read_event
    ev_p = FFI::MemoryPointer.new :pointer
    check { AlsaSeq.event_input(@handle, ev_p) }
    AlsaSeq::Event.new(ev_p.get_pointer(0))
  end

  def write_note( ch, note, velocity, duration )
    ev = AlsaSeq::Event.new
    ev.set_note( ch, note, velocity, duration)
    ev.set_direct
    ev.set_source( @client_id, @out )
    ev.set_dest( SND_SEQ_ADDRESS_SUBSCRIBERS, SND_SEQ_ADDRESS_UNKNOWN )
    ev.set_dest( 134, 0 )
p ev
    alsa :event_output_direct, ev.pointer
    #alsa :drain_output
  end

  def echo
    ev = AlsaSeq::Event.new
    ev[:type] = 50
    ev.set_direct
    ev.set_source( @client_id, @out )
    ev.set_dest( SND_SEQ_ADDRESS_SUBSCRIBERS, SND_SEQ_ADDRESS_UNKNOWN )
    ev.set_dest( 134, 0 )
p ev
    alsa :event_output_direct, ev.pointer
    #alsa :drain_output
  end

  def connect_in_to(client, port)
    alsa :connect_to, @in, client, port
  end

  def connect_out_to(client, port)
    alsa :connect_to, @out, client, port
  end
  
  def alsa( sym, *args )
    args.unshift @handle
    check { AlsaSeq.send( sym, *args ) }
  end

  def check
    r = yield
    $err = r
    raise "Alsa Seq API returned error : #{r}" if r < 0
    r
  end

end

module AlsaSeq
  class Event
    def set_note(ch, key, vel, dur)
      self[:type] = EVENT_TYPES[:SND_SEQ_EVENT_NOTE]
      self.set_fixed
      self[:flags] |= SND_SEQ_TIME_STAMP_REAL
      self[:data][:note][:channel] = ch
      self[:data][:note][:note] = key
      self[:data][:note][:velocity] = vel
      self[:data][:note][:duration] = dur
    end

    def set_noteon(ch, key, vel)
      self[:type] = EVENT_TYPES[:SND_SEQ_EVENT_NOTEON]
      self.set_fixed
      self[:data][:note][:channel] = ch
      self[:data][:note][:note] = key
      self[:data][:note][:velocity] = vel
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
