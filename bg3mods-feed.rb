# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Bg3modsFeed < Formula
  desc "A feed generator of mods for Baldur's Gate 3"
  homepage "https://github.com/tinyzimmer/bg3mods-feed"
  version "0.0.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/tinyzimmer/bg3mods-feed/releases/download/v0.0.0/bg3mods-feed_Darwin_x86_64.tar.gz"
      sha256 "6dd1abf0fd2450e39c9b5493f1ae8ac2b3d9d6c7719a231203e21a0bf278db3d"

      def install
        bin.install "bg3mods-feed"
      end
    end
    on_arm do
      url "https://github.com/tinyzimmer/bg3mods-feed/releases/download/v0.0.0/bg3mods-feed_Darwin_arm64.tar.gz"
      sha256 "31d70df451d56336e9ba8ac3d6f2c6055b356ee38b12b6b2af1c827a17b110d5"

      def install
        bin.install "bg3mods-feed"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/tinyzimmer/bg3mods-feed/releases/download/v0.0.0/bg3mods-feed_Linux_x86_64.tar.gz"
        sha256 "339d8b43caef18822ca683682cc8730016c65709359f083e08739f2096f727c8"

        def install
          bin.install "bg3mods-feed"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/tinyzimmer/bg3mods-feed/releases/download/v0.0.0/bg3mods-feed_Linux_arm64.tar.gz"
        sha256 "e41217164c10e0a8b69534bf3c65a6ba8654223b7b80e7fda218444cab053e71"

        def install
          bin.install "bg3mods-feed"
        end
      end
    end
  end

  def caveats
    <<~EOS
      You can start the service with `brew services start bg3mods-feed`.
      The service will be available at http://localhost:#{ENV['BG3MODS_LISTEN_PORT'] || '8080'}/feed.
    EOS
  end

  service do
    run "#{bin}/bg3mods-feed"
    keep_alive true
    environment_variables
      BG3MODS_LISTEN: ":#{ENV['BG3MODS_LISTEN_PORT'] || '8080'}"
      BG3MODS_TAGS: "#{ENV['BG3MODS_TAGS'] || ''}"
      BG3MODS_PLATFORM: "#{ENV['BG3MODS_PLATFORM'] || ''}"
      BG3MODS_MAX_FEED_ITEMS: "#{ENV['BG3MODS_MAX_FEED_ITEMS'] || '100'}"
      BG3MODS_SORT: "#{ENV['BG3MODS_SORT'] || 'recent'}"
      BG3MODS_FETCH_INTERVAL: "#{ENV['BG3MODS_FETCH_INTERVAL'] || '5m'}"
      BG3MODS_FORMAT: "#{ENV['BG3MODS_FORMAT'] || 'atom'}"
    sockets "tcp://127.0.0.1:#{ENV['BG3MODS_LISTEN_PORT'] || '8080'}"
  end

  test do
    system "#{bin}/bg3mods-feed --version"
  end
end
