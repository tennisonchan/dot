class Dot < Formula
  desc "Simply to backup, restore, and sync the packages and dotfiles for you."
  homepage "https://github.com/tennisonchan/dot"
  url "https://github.com/tennisonchan/dot/archive/0.1.1.tar.gz"
  version "0.1.1"
  sha256 "833817c91723f5545e5ee6487807cc59d985c5950c41ddaacbb542eb3ad07fe8"

  def install
    bin.install "bin/dot"
    prefix.install "Dot"
    prefix.install "Topics"
  end

  test do
    system "false"
  end
end
