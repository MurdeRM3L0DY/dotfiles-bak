{super, ...}: {
  system = "x86_64-linux";

  modules = with super; [
    hardware-configuration
    configuration
  ];
}

