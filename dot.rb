class Dot < Formula
  desc "Simply to backup, restore, and sync the packages and dotfiles for you."
  homepage "https://github.com/tennisonchan/dot"
  url "https://github.com/tennisonchan/dot/archive/0.1.1.tar.gz"
  version "0.1.1"
  sha256 "25794f5721ecf9e01543236fd19123cc72c9f5cb2de769562b1f59ca13b3fa25"

  def install
    bin.install "bin/dot"
    prefix.install "Dot"
    prefix.install "Topics"
  end

  test do
    system "false"
  end
end
