{ stdenv, fetchurl, pkgconfig, gtk2, libglade, openbox,
  imlib2, libstartup_notification, makeWrapper, libSM }:

stdenv.mkDerivation rec {
  pname = "obconf";
  version = "2.0.4";

  src = fetchurl {
    url = "http://openbox.org/dist/obconf/obconf-${version}.tar.gz";
    sha256 = "1fanjdmd8727kk74x5404vi8v7s4kpq48l583d12fsi4xvsfb8vi";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [
    gtk2 libglade libSM openbox imlib2 libstartup_notification
    makeWrapper
  ];

  postInstall = ''
    wrapProgram $out/bin/obconf --prefix XDG_DATA_DIRS : ${openbox}/share/
  '';

  meta = {
    description = "GUI configuration tool for openbox";
    homepage = "http://openbox.org/wiki/ObConf";
    license = stdenv.lib.licenses.gpl2;
    maintainers = [ stdenv.lib.maintainers.lhvwb ];
    platforms = stdenv.lib.platforms.linux;
  };
}
