{config, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      user = {
        email = "ah0199004@gmail.com";
        name = "xaolan";
        signingKey = "/home/xaolan/.ssh/id_ed25519.pub";
      };
      commit.gpgSign = true;
      credential.helper = "store";
      gpg = {
        format = "ssh";
      };
      "gpg.ssh" = {
        allowedSignersFile = "/home/xaolan/.config/git/allowed_signers";
        program = "ssh-keygen";
      };
      core.pager = "delta";
      delta = {
        dark = true;
      };
      diff.colorMoved = "default";
      init.defaultBranch = "master";
      branch.autosetupmerge = true;
      push.default = "current";
      merge.stat = true;
      tag.gpgSign = true;
      core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      repack.usedeltabaseoffset = true;
      pull.ff = "only";
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      rerere = {
        autoupdate = true;
        enabled = true;
      };
    };
  };
}
