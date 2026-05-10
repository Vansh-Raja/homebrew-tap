class SshthingBeta < Formula
  desc "Secure SSH manager TUI (SQLCipher + AES-GCM) with SSH/SFTP and Finder mounts"
  homepage "https://github.com/Vansh-Raja/SSHThing"

  url "https://github.com/Vansh-Raja/SSHThing/archive/refs/tags/v3.0.0-beta.4.tar.gz"
  version "3.0.0-beta.4"
  sha256 "80b504ef023a70e1fb892aec2d5f8e07f89666066a4fbfaac6f8dc82578e25bc"
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
      -X github.com/Vansh-Raja/SSHThing/internal/app.defaultCloudBaseURL=https://testsshthing.vanshraja.me
    ]

    system "go", "build", *std_go_args(output: bin/"sshthing", ldflags: ldflags), "./cmd/sshthing"
  end

  test do
    assert_match "sshthing", shell_output("#{bin}/sshthing --version")
  end
end
