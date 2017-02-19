use strict;
use Irssi;

our $VERSION = '0.1.0';
our %IRSSI = (
	authors => 'Greg Malysa',
	contact => 'gjm76@cornell.edu',
	name => 'audacious',
	description => 'Controls a running audacious instance',
	license => 'BSD',
);

my $audpid = 0;

sub usage {
	Irssi::print("Usage:");
	Irssi::print("  /AUDACIOUS init");
	Irssi::print("  /AUDACIOUS help");
	Irssi::print("  /AUDACIOUS playing");
}

sub cmd_audacious {
	my ($cmd) = @_;

	if ($cmd eq "init") {
		init();
	}
	elsif ($cmd eq "help") {
		usage();
	}
	elsif ($cmd eq "playing") {
		if ($audpid == 0) {
			init();
		}

		if ($audpid == 0) {
			Irssi::active_win->command("say Media player not found!");
			return;
		}

		my $song = `audtool --current-song`;
		my $time = `audtool --current-song-output-length`;
		my $len = `audtool --current-song-length`;
		my $bitrate = `audtool --current-song-bitrate-kbps`;
		my $freq = `audtool --current-song-frequency-khz`;

		chomp($song);
		chomp($time);
		chomp($len);
		chomp($bitrate);
		chomp($freq);

		Irssi::active_win->command(
			"say \x{02}playing:\x{02} \"$song\" \x{02}[\x{02}${bitrate}kbps\x{02}][\x{02}${freq}kHz\x{02}]\x{02}\x{02}[\x{02}$len\x{02}]\x{02}"
		);
	}
	else {
		usage();
	}
}

sub init {
	$audpid = `pidof -s audacious`;
	chomp($audpid);

	if ($audpid > 0) {
		my $dbusstr = `cat /proc/$audpid/environ | strings | grep DBUS_SESSION_BUS_ADDRESS`;
		chomp($dbusstr);
		my ($key, $value) = split('=', $dbusstr, 2);
		$ENV{$key} = $value;
	}
}

Irssi::command_bind('audacious', 'cmd_audacious');
