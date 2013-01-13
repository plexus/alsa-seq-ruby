SND_SEQ_OPEN_OUTPUT             = 1
SND_SEQ_OPEN_INPUT              = 2 
SND_SEQ_OPEN_DUPLEX             = SND_SEQ_OPEN_OUTPUT | SND_SEQ_OPEN_INPUT

SND_SEQ_PORT_SYSTEM_TIMER       = 0         # /**< system timer port */
SND_SEQ_PORT_SYSTEM_ANNOUNCE    = 1         # /**< system announce port */

SND_SEQ_PORT_CAP_READ           = (1 << 0)  #  /**< readable from this port */
SND_SEQ_PORT_CAP_WRITE          = (1 << 1)  #/**< writable to this port */
SND_SEQ_PORT_CAP_SYNC_READ      = (1 << 2)  # /**< allow read subscriptions */
SND_SEQ_PORT_CAP_SYNC_WRITE     = (1 << 3)  # /**< allow write subscriptions */
SND_SEQ_PORT_CAP_DUPLEX         = (1 << 4)  #  /**< allow read/write duplex */
SND_SEQ_PORT_CAP_SUBS_READ      = (1 << 5)  # /**< allow read subscription */
SND_SEQ_PORT_CAP_SUBS_WRITE     = (1 << 6)  # /**< allow write subscription */
SND_SEQ_PORT_CAP_NO_EXPORT      = (1 << 7)  # /**< routing not allowed */

SND_SEQ_PORT_TYPE_SPECIFIC      = (1 << 0)
SND_SEQ_PORT_TYPE_MIDI_GENERIC  = (1 << 1)
SND_SEQ_PORT_TYPE_MIDI_GM       = (1 << 2)
SND_SEQ_PORT_TYPE_MIDI_GS       = (1 << 3)
SND_SEQ_PORT_TYPE_MIDI_XG       = (1 << 4)
SND_SEQ_PORT_TYPE_MIDI_MT32     = (1 << 5)
SND_SEQ_PORT_TYPE_MIDI_GM2      = (1 << 6)
SND_SEQ_PORT_TYPE_SYNTH         = (1 << 10)
SND_SEQ_PORT_TYPE_DIRECT_SAMPLE = (1 << 11)
SND_SEQ_PORT_TYPE_SAMPLE        = (1 << 12)
SND_SEQ_PORT_TYPE_HARDWARE      = (1 << 16)
SND_SEQ_PORT_TYPE_SOFTWARE      = (1 << 17)
SND_SEQ_PORT_TYPE_SYNTHESIZER   = (1 << 18)
SND_SEQ_PORT_TYPE_PORT          = (1 << 19)
SND_SEQ_PORT_TYPE_APPLICATION   = (1 << 20)


SND_SEQ_ADDRESS_UNKNOWN     = 253 # /**< unknown source */
SND_SEQ_ADDRESS_SUBSCRIBERS = 254 # /**< send event to all subscribed ports */
SND_SEQ_ADDRESS_BROADCAST   = 255 # /**< send event to all queues/clients/ports/channels */


SND_SEQ_QUEUE_DIRECT = 253 # /**< direct dispatch */

SND_SEQ_EVENT_LENGTH_FIXED    = (0 << 2)  # /**< fixed event size */
SND_SEQ_EVENT_LENGTH_VARIABLE = (1 << 2)  # /**< variable event size */
SND_SEQ_EVENT_LENGTH_VARUSR   = (2 << 2)  # /**< variable event size - user memory space */
SND_SEQ_EVENT_LENGTH_MASK     = (3 << 2)  # /**< mask for event length bits */

SND_SEQ_TIME_STAMP_TICK	= (0 << 0) # /**< timestamp in clock ticks */
SND_SEQ_TIME_STAMP_REAL	= (1 << 0) # /**< timestamp in real time */
SND_SEQ_TIME_STAMP_MASK	= (1 << 0) # /**< mask for timestamp bits */

#/** Sequencer event type */
#enum snd_seq_event_type {
EVENT_TYPES = {
  # /** system status; event data type = #snd_seq_result_t */
  :SND_SEQ_EVENT_SYSTEM            => 0,
  # /** returned result status; event data type = #snd_seq_result_t */
  :SND_SEQ_EVENT_RESULT            => 1,

  # /** note on and off with duration; event data type = #snd_seq_ev_note_t */
  :SND_SEQ_EVENT_NOTE              => 5,
  # /** note on; event data type = #snd_seq_ev_note_t */
  :SND_SEQ_EVENT_NOTEON            => 6,
  # /** note off; event data type = #snd_seq_ev_note_t */
  :SND_SEQ_EVENT_NOTEOFF           => 7,
  # /** key pressure change (aftertouch); event data type = #snd_seq_ev_note_t */
  :SND_SEQ_EVENT_KEYPRESS          => 8,

  # /** controller; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_CONTROLLER        => 10,
  # /** program change; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_PGMCHANGE         => 11,
  # /** channel pressure; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_CHANPRESS         => 12,
  # /** pitchwheel; event data type = #snd_seq_ev_ctrl_t; data is from -8192 to 8191) */
  :SND_SEQ_EVENT_PITCHBEND         => 13,
  # /** 14 bit controller value; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_CONTROL14         => 14,
  # /** 14 bit NRPN;  event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_NONREGPARAM       => 15,
  # /** 14 bit RPN; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_REGPARAM          => 16,

  # /** SPP with LSB and MSB values; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_SONGPOS           => 20 ,
  # /** Song Select with song ID number; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_SONGSEL           => 21,
  # /** midi time code quarter frame; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_QFRAME            => 22,
  # /** SMF Time Signature event; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_TIMESIGN          => 23,
  # /** SMF Key Signature event; event data type = #snd_seq_ev_ctrl_t */
  :SND_SEQ_EVENT_KEYSIGN           => 24,

  # /** MIDI Real Time Start message; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_START             => 30 ,
  # /** MIDI Real Time Continue message; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_CONTINUE          => 31,
  # /** MIDI Real Time Stop message; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_STOP              => 32,
  # /** Set tick queue position; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_SETPOS_TICK       => 33,
  # /** Set real-time queue position; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_SETPOS_TIME       => 34,
  # /** (SMF) Tempo event; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_TEMPO             => 35,
  # /** MIDI Real Time Clock message; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_CLOCK             => 36,
  # /** MIDI Real Time Tick message; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_TICK              => 37,
  # /** Queue timer skew; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_QUEUE_SKEW        => 38,
  # /** Sync position changed; event data type = #snd_seq_ev_queue_control_t */
  :SND_SEQ_EVENT_SYNC_POS          => 39,

  # /** Tune request; event data type = none */
  :SND_SEQ_EVENT_TUNE_REQUEST      => 40,
  # /** Reset to power-on state; event data type = none */
  :SND_SEQ_EVENT_RESET             => 41,
  # /** Active sensing event; event data type = none */
  :SND_SEQ_EVENT_SENSING           => 42,

  # /** Echo-back event; event data type = any type */
  :SND_SEQ_EVENT_ECHO              => 50,
  # /** OSS emulation raw event; event data type = any type */
  :SND_SEQ_EVENT_OSS               => 51,

  # /** New client has connected; event data type = #snd_seq_addr_t */
  :SND_SEQ_EVENT_CLIENT_START      => 60,
  # /** Client has left the system; event data type = #snd_seq_addr_t */
  :SND_SEQ_EVENT_CLIENT_EXIT       => 61,
  # /** Client status/info has changed; event data type = #snd_seq_addr_t */
  :SND_SEQ_EVENT_CLIENT_CHANGE     => 62,
  # /** New port was created; event data type = #snd_seq_addr_t */
  :SND_SEQ_EVENT_PORT_START        => 63,
  # /** Port was deleted from system; event data type = #snd_seq_addr_t */
  :SND_SEQ_EVENT_PORT_EXIT         => 64,
  # /** Port status/info has changed; event data type = #snd_seq_addr_t */
  :SND_SEQ_EVENT_PORT_CHANGE       => 65,

  # /** Ports connected; event data type = #snd_seq_connect_t */
  :SND_SEQ_EVENT_PORT_SUBSCRIBED   => 66,
  # /** Ports disconnected; event data type = #snd_seq_connect_t */
  :SND_SEQ_EVENT_PORT_UNSUBSCRIBED => 67,

  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR0              => 90,
  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR1              => 91,
  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR2              => 92,
  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR3              => 93,
  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR4              => 94,
  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR5              => 95,
  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR6              => 96,
  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR7              => 97,
  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR8              => 98,
  # /** user-defined event; event data type = any (fixed size) */
  :SND_SEQ_EVENT_USR9              => 99,

  # /** system exclusive data (variable length);  event data type = #snd_seq_ev_ext_t */
  :SND_SEQ_EVENT_SYSEX             => 130,
  # /** error event;  event data type = #snd_seq_ev_ext_t */
  :SND_SEQ_EVENT_BOUNCE            => 131,
  # /** reserved for user apps;  event data type = #snd_seq_ev_ext_t */
  :SND_SEQ_EVENT_USR_VAR0          => 135,
  # /** reserved for user apps; event data type = #snd_seq_ev_ext_t */
  :SND_SEQ_EVENT_USR_VAR1          => 136,
  # /** reserved for user apps; event data type = #snd_seq_ev_ext_t */
  :SND_SEQ_EVENT_USR_VAR2          => 137,
  # /** reserved for user apps; event data type = #snd_seq_ev_ext_t */
  :SND_SEQ_EVENT_USR_VAR3          => 138,
  # /** reserved for user apps; event data type = #snd_seq_ev_ext_t */
  :SND_SEQ_EVENT_USR_VAR4          => 139,

  # /** NOP; ignored in any case */
  :SND_SEQ_EVENT_NONE              => 255
}
