{inputs, ...}: {
  lib,
  pkgs,
  config,
  ...
}: {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = let
      createChromiumExtensionFor = browserVersion: {
        id,
        sha256,
        version,
      }: {
        inherit id;
        crxPath = builtins.fetchurl {
          url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
          name = "${id}.crx";
          inherit sha256;
        };
        inherit version;
      };
      createChromiumExtension = createChromiumExtensionFor (lib.versions.major config.programs.chromium.package.version);
    in [
      # darkreader
      (createChromiumExtension {
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        version = "4.9.76";
        sha256 = "sha256:1pi05k1xrl2wdjxb66yhasqfh400igm66wzmghbcx0b2i9h2h6ix";
      })

      # ublock origin
      (createChromiumExtension {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        version = "1.55.0";
        sha256 = "sha256:0w9zc8in4gqlhg5hngffdi763h4d2mizq86z91z6rkjsj7w403fl";
      })

      # # adguard
      # (createChromiumExtension {
      #   id = "bgnkhhnnamicmpeenaelnjfhikgbkllg";
      #   version = "4.3.13";
      #   sha256 = "sha256:1rrn78dqvnj096cllcw6bdwxlilinmlw57nhs25yhqwf46zvgq3n";
      # })

      # bitwarden
      (createChromiumExtension {
        id = "nngceckbapebfimnlniiiahkandclblb";
        version = "2024.1.1";
        sha256 = "sha256:1pjdcdmliys07za6v0qdkdv393a34cy1bhcc57vm6zx4dcz4gp58";
      })

      # crosspilot
      (createChromiumExtension {
        id = "migomhggnppjdijnfkiimcpjgnhmnale";
        version = "1.5.1";
        sha256 = "sha256:084p18r62p904yvgrbcn2b41kbjsnifw22r5aa3vlxmlzkdydwhc";
      })

      # cococut
      (createChromiumExtension {
        id = "gddbgllpilhpnjpkdbopahnpealaklle";
        version = "3.14";
        sha256 = "sha256:19nccm7i7ad4p48gjckl4ir8pawprfz1s6383h3j8mn645mnn1ql";
      })

      # # chromium web store
      #  {
      #   id = "chromiumwebstoreabcdefghijklmnop";
      #   crxPath = builtins.fetchurl {
      #     name = "Chromium.Web.Store.crx";
      #     url = "https://github.com/NeverDecaf/chromium-web-store/releases/download/v1.5.4.1/Chromium.Web.Store.crx";
      #     sha256 = "sha256:0mgqc3j0198zc3fd56hsaf7idffy8cr24v57zi8ygs24qgixydii";
      #   };
      #   version = "v1.5.4.1";
      # }
    ];
  };
}

