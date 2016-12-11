use v6;
use NativeCall;
use MPD::Song;
use MPD::NativeSymbols;

class MPD {
    class Connection is repr('CPointer') {};
    class Status     is repr('CPointer') {};

    has OpaquePointer $!conn;
    has $!keep-alive-supply;
    has Lock $!lock;  # lock critical sections

    method new(Str $host = "127.0.0.1", Int $port = 6600, Int $timeout = 10000, Bool :$keep-alive = True) {
        my $conn = mpd_connection_new($host, $port, $timeout);
        if mpd_connection_get_error($conn) {
            die mpd_connection_get_error_message($conn);
        }
        my Lock $lock .= new;

        # quick and dirty keep-alive to prevent sefgaults from closed connection
        # older versions of libmpdclient don't support mpd_connection_set_keepalive
        my $keep-alive-supply;
        if $keep-alive {
            $keep-alive-supply = Supply.interval(5);
            $keep-alive-supply.tap( -> $v { 
                $lock.protect({
                    my $s = mpd_run_status($conn);
                    mpd_status_free($s);
                });
            }); 
        }
        self.bless(:$conn, :$keep-alive-supply, :$lock);
    }

    submethod BUILD (:$!conn,:$!keep-alive-supply, :$!lock) {}


    method current-song {
        my $song-ptr = mpd_run_current_song($!conn);
        my $song = song($song-ptr);
        mpd_song_free($song-ptr);
        return $song;
    }

    method state {
        $!lock.protect({
            my $s = mpd_run_status($!conn);
            my $r = mpd_status_get_state($s);
            mpd_status_free($s);
            return <unknown stop play pause>[$r];
        });
    }
    method play { mpd_run_play($!conn); }
    method pause { mpd_send_toggle_pause($!conn); }
    method toggle { mpd_run_toggle_pause($!conn); }
    method stop { mpd_run_stop($!conn); }
    method next { mpd_run_next($!conn); }
    method previous { mpd_run_previous($!conn); }
    method update { mpd_run_update($!conn, Str); }
    method search(Str :f(:$file), :t(:%tags), Bool :a(:$add)) {
    $!lock.protect({
        $add 
            ?? mpd_search_add_db_songs($!conn, False)
            !! mpd_search_db_songs($!conn, False);

        #TODO: add tag support
        
        mpd_search_add_uri_constraint($!conn, 0, $file) with $file;

        mpd_search_commit($!conn);
    })
    }
    method add($file) {
        self.search(:$file, :a);
    }
}


# vim: ft=perl6
