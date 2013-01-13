require 'asound'

class AlsaMidi
  attr_reader :in, :out, :handle, :client_id

  def initialize(name, out_caps = SND_SEQ_PORT_CAP_READ|SND_SEQ_PORT_CAP_SUBS_READ)
    seq_handle_p = FFI::MemoryPointer.new :pointer
    check { Asound::Seq.open( seq_handle_p, "default", SND_SEQ_OPEN_DUPLEX, 0 ) } #SND_SEQ_OPEN_INPUT
    @handle = seq_handle_p.get_pointer(0)
    
    check { Asound::Seq.set_client_name( @handle, name ) }
    @in = check { Asound::Seq.create_simple_port(
        @handle, "in", 
        SND_SEQ_PORT_CAP_WRITE|SND_SEQ_PORT_CAP_SUBS_WRITE,
        SND_SEQ_PORT_TYPE_APPLICATION) }

    @out = check { Asound::Seq.create_simple_port(
        @handle, "out", 
        SND_SEQ_PORT_CAP_READ|SND_SEQ_PORT_CAP_SUBS_READ,
        SND_SEQ_PORT_TYPE_MIDI_GENERIC|SND_SEQ_PORT_TYPE_APPLICATION) }

    @client_id = check { Asound::Seq.client_id( @handle ) }

    @handle
  end

  def read_event
    ev_p = FFI::MemoryPointer.new :pointer
    check { Asound::Seq.event_input(@handle, ev_p) }
    Asound::Seq::Event.new(ev_p.get_pointer(0))
  end

  def write_note_on( ch, note, velocity )
    ev = Asound::Seq::Event.new
    ev.set_note_on( ch, note, velocity )
    write_note(ev)
  end

  def write_note_off( ch, note, velocity )
    ev = Asound::Seq::Event.new
    ev.set_note_off( ch, note, velocity )
    write_note(ev)
  end

  def write_note(ev)
    ev.set_direct
    ev.set_source( @client_id, @out )
    ev.set_dest( SND_SEQ_ADDRESS_SUBSCRIBERS, SND_SEQ_ADDRESS_UNKNOWN )

    alsa :event_output_direct, ev.pointer
  end  

  def connect_out_to(client, port)
    alsa :connect_to, @out, client, port
  end
  
  def alsa( sym, *args )
    args.unshift @handle
    check { Asound::Seq.send( sym, *args ) }
  end

  def check
    r = yield
    $err = r
    raise "Alsa Seq API returned error : #{r}" if r < 0
    r
  end
end
