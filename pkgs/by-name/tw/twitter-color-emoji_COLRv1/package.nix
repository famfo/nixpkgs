{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  nanoemoji,
}:

let
  version = {
    major = "17";
    minor = "0";
    patch = "3";
  };
  name = "twitter-color-emoji_COLRv1";
in
stdenvNoCC.mkDerivation {
  inherit name;
  src = fetchFromGitHub {
    owner = "jdecked";
    repo = "twemoji";
    rev = "v${version.major}.${version.minor}.${version.patch}";
    hash = "sha256-qgdguv5/EhjLlKxIvvQF7+s+AkY7KnFhaKRziOR1hhY=";
  };

  nativeBuildInputs = [ nanoemoji ];
  buildPhase = ''
    nanoemoji \
      --color_format glyf_colr_1 \
      --family "Twitter Color Emoji" \
      --version_major "${version.major}" \
      --version_minor "${version.minor}" \
      --output_file ${name}.ttf \
      assets/svg/*
  '';

  installPhase = ''
    install -Dm644 build/${name}.ttf $out/share/fonts/truetype/${name}.ttf
  '';

  meta = {
    description = "COLR v1 build of Twitter's Twemoji font";
    homepage = "https://github.com/twitter/twemoji";
    license = [ lib.licenses.cc-by-40 ];
    maintainers = [ lib.maintainers.famfo ];
  };
}
