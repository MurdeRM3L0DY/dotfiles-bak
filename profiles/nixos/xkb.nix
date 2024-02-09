{inputs, ...}: c: {...}: {
  console.useXkbConfig = true;

  services.xserver = {
    enable = true;
    autoRepeatDelay = 160;
    autoRepeatInterval = 40;
    layout = c.layout or "";
    xkbOptions = c.xkbOptions or "";
  };
}
