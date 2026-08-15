{ lib, buildGoModule, fetchFromGitHub, fetchpatch2,
system
}:

buildGoModule (finalAttrs: {
  pname = "k8s-mf";
  version = "0.2.21";  # renovate: datasource=github-releases depName=confighub/sdk
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "confighub";
    repo = "sdk";
    tag = "v${finalAttrs.version}";
    hash = "sha256-VCK/o29aJ1EpOOsxa6F4wRh/PFDiNMkSTs7SMFifoL4=";
  };

  patches = [
    (fetchpatch2 {
      url = "https://github.com/confighub/sdk/compare/eff1a7b24cffb2ea9978eb599efbeb17db9e10ff...610f33b6c0f48c9aa2b53cd63600ae3efd09a10f.diff?full_index=1";
      hash = "sha256-sU1fNpTwQSLXIHszc1jz3javo63MGcN34YlQ9jgruYQ=";
    })
  ];

  modRoot = "./cmd/k8s-mf/";

  vendorHash = "sha256-IY9DZnCCLNRAghj+TAgtFpE3ji+nBc1ggV6DIN8Qn5k=";

  ldflags = [ "-s" ];

  meta = {
    description = "k8s-mf inspects and repairs Kubernetes server-side-apply managed fields";
    homepage = "//github.com/confighub/sdk/tree/main/cmd/k8s-mf/";
    changelog = "https://github.com/confighub/sdk/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    platforms = [ system ];
    mainProgram = "k8s-mf";
  };
})
