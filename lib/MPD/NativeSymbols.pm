use v6;
use NativeCall;

enum TagType is export «
    :artist(0)
    album
    albumartist
    title
    track
    name
    genre
    date
    composer
    performer
    comment
    disc
»;
### CONNECTION ###
sub mpd_connection_new(Str $host, uint32 $port, uint32 $timeout)
    returns OpaquePointer
    is export
    is native('mpdclient') { ... }

sub mpd_connection_free(OpaquePointer)
    is export
    is native('mpdclient') { ... }

sub mpd_connection_get_error(OpaquePointer)
    returns int32
    is export
    is native('mpdclient') { ... }

sub mpd_connection_get_error_message(OpaquePointer)
    returns Str
    is export
    is native('mpdclient') { ... }

sub mpd_connection_get_fd(OpaquePointer)
    returns int32
    is export is native('mpdclient') { ... }

sub mpd_connection_get_server_version(OpaquePointer)
    returns uint32
    is export is native('mpdclient') { ... }
### STATUS ###
sub mpd_run_status(OpaquePointer)
    returns OpaquePointer
    is export
    is native('mpdclient') { ... }

sub mpd_status_free(OpaquePointer)
    is export
    is native('mpdclient') { ... }

sub mpd_status_get_state(OpaquePointer)
    returns int32
    is export
    is native('mpdclient') { ... }

### CONTROLS ###

sub mpd_run_play(OpaquePointer)
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_run_play_pos(OpaquePointer, uint32)
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_run_stop(OpaquePointer)
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_send_toggle_pause(OpaquePointer)       
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_run_toggle_pause(OpaquePointer)       
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_run_next(OpaquePointer)       
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_run_previous(OpaquePointer)       
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_run_update (OpaquePointer, Str) 
    returns uint32
    is export
    is native('mpdclient') { ... }

### SEARCH ###
sub mpd_search_add_uri_constraint (OpaquePointer, int32, Str)
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_search_add_tag_constraint (OpaquePointer, int32, int32, Str)
    returns bool
    is export
    is native('mpdclient') { ... }
sub mpd_search_add_any_tag_constraint (OpaquePointer, int32, Str)
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_search_commit (OpaquePointer)
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_search_db_songs (OpaquePointer, bool)
    returns bool
    is export
    is native('mpdclient') { ... }

sub mpd_search_add_db_songs (OpaquePointer, bool)
    returns bool
    is export
    is native('mpdclient') { ... }

### SONG OBJECT ###
sub mpd_tag_name (int32)
    returns Str
    is export
    is native('mpdclient') { ... };

sub mpd_song_get_tag (OpaquePointer, int32, uint32) 
    returns Str
    is export
    is native('mpdclient') { ... };

sub mpd_song_free(OpaquePointer)
    is export
    is native('mpdclient') { ... }

sub mpd_run_current_song(OpaquePointer)
    returns OpaquePointer
    is export
    is native('mpdclient') { ... }

sub mpd_song_get_uri(OpaquePointer)
    returns Str
    is export
    is native('mpdclient') { ... }

sub mpd_song_get_id(OpaquePointer)
    returns uint32
    is export
    is native('mpdclient') { ... }

sub mpd_song_get_pos (OpaquePointer)
    returns uint32
    is export
    is native('mpdclient') { ... }

sub mpd_song_get_duration (OpaquePointer)                     
    returns uint32
    is export
    is native('mpdclient') { ... }

sub mpd_song_get_last_modified (OpaquePointer)  
    returns uint32
    is export
    is native('mpdclient') { ... }
