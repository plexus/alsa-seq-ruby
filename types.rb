module AlsaSeq
  typedef :uchar, :event_type_t
  typedef :uint,  :tick_time_t

  class RealTime < FFI::Struct
    layout :tv_sec,  :uint, # /**< seconds */
           :tv_nsec, :uint  # /**< nanoseconds */
  end


  class Timestamp < FFI::Union
    layout :tick, :tick_time_t,
           :time, RealTime
  end

  class Addr < FFI::Struct
    layout :client, :uchar, # Client id
           :port,   :uchar   # Port id
  end

  class Event < FFI::Struct
    class Data < FFI::Union
      class EvNote < FFI::Struct
        layout :channel      , :uchar, # channel number
               :note         , :uchar, # note
               :velocity     , :uchar, # velocity
               :off_velocity , :uchar, # note-off velocity; only for #SND_SEQ_EVENT_NOTE
               :duration     , :int    # duration until note-off; only for #SND_SEQ_EVENT_NOTE
      end
      layout :note, EvNote

      # snd_seq_ev_ctrl_t control;        /**< MIDI control information */
      # snd_seq_ev_raw8_t raw8;           /**< raw8 data */
      # snd_seq_ev_raw32_t raw32;         /**< raw32 data */
      # snd_seq_ev_ext_t ext;             /**< external data */
      # snd_seq_ev_queue_control_t queue; /**< queue control */
      # snd_seq_timestamp_t time;         /**< timestamp */
      # snd_seq_addr_t addr;              /**< address */
      # snd_seq_connect_t connect;        /**< connect information */
      # snd_seq_result_t result;          /**< operation result code */
    end

    layout :type   , :event_type_t,
           :flags  , :uchar,
           :tag    , :uchar,
           :queue  , :uchar,
           :time   , Timestamp, # /**< schedule time */
           :source , Addr,
           :dest   , Addr,
           :data   , Data

    end
  end

__END__

/** Sequencer event */
typedef struct snd_seq_event {
	snd_seq_event_type_t type;	/**< event type */
	unsigned char flags;		/**< event flags */
	unsigned char tag;		/**< tag */
	
	unsigned char queue;		/**< schedule queue */
	snd_seq_timestamp_t time;	/**< schedule time */

	snd_seq_addr_t source;		/**< source address */
	snd_seq_addr_t dest;		/**< destination address */

	union {
		snd_seq_ev_note_t note;		/**< note information */
		snd_seq_ev_ctrl_t control;	/**< MIDI control information */
		snd_seq_ev_raw8_t raw8;		/**< raw8 data */
		snd_seq_ev_raw32_t raw32;	/**< raw32 data */
		snd_seq_ev_ext_t ext;		/**< external data */
		snd_seq_ev_queue_control_t queue; /**< queue control */
		snd_seq_timestamp_t time;	/**< timestamp */
		snd_seq_addr_t addr;		/**< address */
		snd_seq_connect_t connect;	/**< connect information */
		snd_seq_result_t result;	/**< operation result code */
	} data;				/**< event data... */
} snd_seq_event_t;
