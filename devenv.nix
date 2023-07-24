 {
    inputs.devenv.url = "github:cachix/devenv/latest";

    outputs = { devenv, ... }: {
        packages.x86_64-linux = [devenv.packages.x86_64-linux.devenv];
    };
}
