{inputs', ...}: {
  hj.packages = [
    inputs'.zen-browser.packages.default
  ];
}
