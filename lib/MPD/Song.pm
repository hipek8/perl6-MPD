use v6;
use NativeCall;
use MPD::NativeSymbols;

sub song(OpaquePointer $song-ptr --> Hash) is export {
    my %hash is default(Any);
    for TagType.enums.kv -> $k, $v {
        %hash{$k} = $_ with mpd_song_get_tag($song-ptr,$v,0);
    }
    %hash<id> = mpd_song_get_id($song-ptr);
    %hash<file> = mpd_song_get_uri($song-ptr);
    %hash<pos> = mpd_song_get_pos($song-ptr);
    %hash<time> = mpd_song_get_duration($song-ptr);
    %hash<modified> = DateTime.new: mpd_song_get_last_modified($song-ptr);
    return %hash;
};


