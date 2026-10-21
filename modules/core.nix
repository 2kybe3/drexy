{ inputs, ... }: {
  _module.args = {
    secrets = "${inputs.secrets}";
  };
}
