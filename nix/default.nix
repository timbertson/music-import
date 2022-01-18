{ pkgs ? import <nixpkgs> {} }:
with pkgs;
with stdenv;
{ src }:
mkDerivation {
	name = "music-import";
	inherit src;
	buildInputs = let py = python3Packages; in [
		makeWrapper
		mp3gain
		py.gnureadline py.mutagen
	];
	buildPhase = "true";
	installPhase = ''
		mkdir -p "$out/bin"
		cp "music-import" "$out/bin"
		wrapProgram "$out/bin/music-import" \
			--prefix PATH : "${mp3gain}/bin" \
			--set PYTHONPATH "$PYTHONPATH" \
			;
	'';
	shellHook = ''
		export PATH="${builtins.getEnv "PWD"}:$PATH";
	'';
}

