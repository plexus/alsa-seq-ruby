require 'ffi'

module AlsaSeq
  extend FFI::Library
end

require './constants'
require './types'

module AlsaSeq
  ffi_lib 'asound'
  ffi_convention :stdcall

  def self.aseq_function( afunc, args )
    attach_function afunc, "snd_seq_#{afunc}".to_sym, args, :int
  end

  # seq.h: int snd_seq_open(snd_seq_t **handle, const char *name, int streams, int mode)
  aseq_function :open, [ :pointer, :string, :int, :int ]

  # seqmid.h: int snd_seq_set_client_name(snd_seq_t *seq, const char *name)
  aseq_function :set_client_name, [:pointer, :string]

  # seqmid.h: int snd_seq_create_simple_port(snd_seq_t *seq, const char *name, unsigned int caps, unsigned int type)
  aseq_function :create_simple_port, [:pointer, :string, :uint, :uint]

  # seq.h: int snd_seq_event_input(snd_seq_t *handle, snd_seq_event_t **ev)
  aseq_function :event_input, [:pointer, :pointer]

  # seq.h: int snd_seq_event_output(snd_seq_t *handle, snd_seq_event_t *ev);
  aseq_function :event_output, [:pointer, :pointer]

  # seq.h: int snd_seq_event_output_direct(snd_seq_t *handle, snd_seq_event_t *ev);
  aseq_function :event_output_direct, [:pointer, :pointer]

  aseq_function :drain_output, [:pointer]

  aseq_function :client_id, [:pointer]

  aseq_function :connect_to, [:pointer, :int, :int, :int]
end
