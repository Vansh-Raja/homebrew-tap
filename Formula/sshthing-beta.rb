class SshthingBeta < Formula
  desc "Secure SSH manager TUI (SQLCipher + AES-GCM) with SSH/SFTP and Finder mounts"
  homepage "https://github.com/Vansh-Raja/SSHThing"

  url "https://github.com/Vansh-Raja/SSHThing/archive/refs/tags/v2.1.0-beta.1.tar.gz"
  version "2.1.0-beta.1"
  sha256 "cf1cc41ced2bb696fd00231be07aff09fc13095d1c1ca0813113f8dc06abe82f"
  head "https://github.com/Vansh-Raja/SSHThing.git", branch: "main"

  depends_on "go" => :build
  depends_on "sqlcipher"

  conflicts_with "sshthing", because: "both install the sshthing binary"

  def install
    ENV["CGO_ENABLED"] = "1"
    ENV.append "CGO_CPPFLAGS", "-I#{Formula["sqlcipher"].opt_include}"
    ENV.append "CGO_LDFLAGS", "-L#{Formula["sqlcipher"].opt_lib}"

    ldflags = %W[
      -s -w
      -X main.version=#{version}
    ]

    system "go", "build", *std_go_args(output: bin/"sshthing", ldflags: ldflags), "./cmd/sshthing"
  end

  test do
    assert_match "sshthing", shell_output("#{bin}/sshthing --version")
  end
end
