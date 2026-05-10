class SshthingBeta < Formula
  desc "Secure SSH manager TUI (SQLCipher + AES-GCM) with SSH/SFTP and Finder mounts"
  homepage "https://github.com/Vansh-Raja/SSHThing"

  url "https://github.com/Vansh-Raja/SSHThing/archive/refs/tags/v3.0.0-beta.2.tar.gz"
  version "3.0.0-beta.2"
  sha256 "9adb809c4f05397b34fab17c6ccbbdc0c036d57f8a83d2e312d64433868556f2"
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
