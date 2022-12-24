{ lib
, resholve
, bash
, coreutils
, gnugrep
, ncurses
, git
, findutils
, gawk
, gnused
}:

resholve.mkDerivation rec {
  pname = "multi-git-status";
  version = "unreleased";
  src = lib.cleanSource ./.;

  solutions = {
    mgitstatus = {
      scripts = [ "bin/mgitstatus" ];
      interpreter = "${bash}/bin/sh";
      execer = [
        # no command args in these git invocations
        "cannot:${git}/bin/git"
      ];

      inputs = [
        coreutils
        gnugrep
        ncurses
        git
        findutils
        gawk
        gnused
      ];
    };
  };

  makeFlags = [ "PREFIX=${placeholder "out"}" ];

  meta = with lib; {
    description = "Show uncommitted, untracked and unpushed changes for multiple Git repos";
    homepage = "https://github.com/fboender/multi-git-status";
    license = licenses.mit;
    maintainers = with maintainers; [ abathur ];
    platforms = platforms.all;
  };
}
