import argparse
import os
import posixpath
import re

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("hostname")
    parser.add_argument("config_dir")
    args = parser.parse_args()
    hostname = args.hostname
    config_dir = args.config_dir

    host_dir = posixpath.join(config_dir, "hosts", hostname)
    os.makedirs(host_dir, exist_ok=True)
    with open(posixpath.join(host_dir, "default.nix"), "w+") as f:
        f.write("""{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
""");
    with open(posixpath.join(host_dir, "configuration.nix"), "w+") as f:
        f.write(f"""{"{"}
  networking.hostName = \"{hostname}\";
{"}"}
""")
        
    flake_path = posixpath.join(config_dir, "flake.nix")
    with open(flake_path, "r") as f:
        flake = ''.join(f.readlines())
        pattern = re.compile("nixosConfigurations\s*=\s*")
        result = re.search(pattern, flake)
        config = f"""
        {hostname} = inputs.nixpkgs.lib.nixosSystem {"{"}
          system = system;
          modules = [
            ./configuration.nix
            ./hosts/{hostname}
          ];
        {"}"};
        """
        split = result.end()
        flake = flake[0:split+1] + config + flake[split+1:]
    with open(flake_path, "w") as f:
        f.write(flake)

if __name__ == "__main__":
    main()