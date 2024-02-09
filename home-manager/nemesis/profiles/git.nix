{profiles, ...}: {...}: {
  imports = with profiles; [
    (tools.git {
      userName = "MurdeRM3L0DY";
      userEmail = "";
    })
  ];
}
