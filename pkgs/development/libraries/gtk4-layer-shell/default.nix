# { lib, stdenv
# , fetchFromGitHub
# , static ? true
# , meson
# , ninja
# , pkg-config
# , gtk-doc
# , docbook-xsl-nons
# , docbook_xml_dtd_43
# , wayland
# , wayland-protocols
# , gtk4
# , vala
# # , gtk3
# , cmake
# , gobject-introspection
# # , valabind
    # # "gtk-doc"
    # # "gobject-introspection"
    # # "meson"
    # # "ninja"
    # # "valabind"
    # # "python"
# }:

# stdenv.mkDerivation rec {
  # pname = "gtk4-layer-shell";
  # version = "1.0.0";

  # outputs = [ "out" "dev" "devdoc" ];

  # src = fetchFromGitHub {
    # owner = "wmww";
    # repo = "gtk4-layer-shell";
    # rev = "v${version}";
    # # sha256 = "sha256-jLWXBoYcVoUSzw4OIYVM5iPvsmpy+Wg5TbDpo8cll80=";
    # sha256 = "sha256-8bf7O/y9gQohd9ZLc7wygUeZxtU5RAsn1PW8pg0NcAc=";
  # };

  # nativeBuildInputs = [
    # meson
    # ninja
    # pkg-config
    # gobject-introspection
    # gtk-doc
    # docbook-xsl-nons
    # docbook_xml_dtd_43
    # cmake
    # # valabind
  # ];

  # buildInputs = [
    # wayland
    # wayland-protocols
    # # valabind
    # gtk4
    # # gtk3
  # ];

  # mesonFlags = [
    # # "-Ddocs=true"
    # # "--prefix=/usr"
    # # "--wrap-mode=nofallback"
    # # "--buildtype=plain"
    # "-Dtests=true"
    # "-Ddocs=true"
    # "-Dintrospection=true"
    # "-Dvapi=true"
    # "-Dexamples=true"
  # ];

  # meta = with lib; {
    # description = "A library to create panels and other desktop components for Wayland using the Layer Shell protocol";
    # license = licenses.lgpl3Plus;
    # maintainers = with maintainers; [ eonpatapon ];
    # platforms = platforms.unix;
  # };
# }
{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, meson
, ninja
, pkg-config
, gtk-doc
, docbook-xsl-nons
, docbook_xml_dtd_43
, wayland-protocols
, wayland
, gtk4
, gtk3
, gobject-introspection
, vala
}:

stdenv.mkDerivation rec {
  pname = "gtk4-layer-shell";
  version = "1.0.0";

  outputs = [ "out" "dev" "devdoc" ];
  outputBin = "devdoc"; # for demo

  src = fetchFromGitHub {
    owner = "wmww";
    repo = "gtk4-layer-shell";
    rev = "v${version}";
    sha256 = "sha256-8bf7O/y9gQohd9ZLc7wygUeZxtU5RAsn1PW8pg0NcAc=";
    # sha256 = "sha256-Z7jPYLKgkwMNXu80aaZ2vNj57LbN+X2XqlTTq6l0wTE=";
    # sha256 = "89d25ca0a7c2db7795c6bfb46e7d504ee71f005b3ea8580c8e9e35b57027be92";
  };

  patches = [
    # https://github.com/wmww/gtk-layer-shell/pull/146
    # Mark wayland-scanner as a build-time dependency
    # (fetchpatch {
      # url = "https://github.com/wmww/gtk-layer-shell/commit/6fd16352e5b35fefc91aa44e73671addaaa95dfc.patch";
      # hash = "sha256-U/mxmcRcZnsF0fvWW0axo6ajqW40NuOzNIAzoLCboRM=";
    # })
    # # https://github.com/wmww/gtk-layer-shell/pull/147
    # # Remove redundant dependency check for gtk-doc
    # (fetchpatch {
      # url = "https://github.com/wmww/gtk-layer-shell/commit/124ccc2772d5ecbb40b54872c22e594c74bd39bc.patch";
      # hash = "sha256-WfrWe9UJCp1RvVJhURAxGw4jzqPjoaP6182jVdoEAQs=";
    # })
  ];

  strictDeps = true;

  depsBuildBuild = [
    pkg-config
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gobject-introspection
    gtk-doc
    docbook-xsl-nons
    docbook_xml_dtd_43
    vala
    # wayland-scanner
  ];

  buildInputs = [
    # wayland
    wayland-protocols
    # # valabind
    # gtk4
    gtk3
    wayland
    gtk4
  ];

  mesonFlags = [
    "-Ddocs=true"
    "-Dexamples=true"
    "-Dtests=true"
    # "-Ddocs=true"
    "-Dintrospection=true"
    "-Dvapi=true"
    # "-Dexamples=true"
  ];

  meta = with lib; {
    description = "A library to create panels and other desktop components for Wayland using the Layer Shell protocol";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ eonpatapon ];
    platforms = platforms.linux;
  };
}
