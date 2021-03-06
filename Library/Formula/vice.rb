require 'formula'

class Vice < Formula
  url "http://www.zimmers.net/anonftp/pub/cbm/crossplatform/emulators/VICE/vice-2.2.tar.gz"
  md5 "6737f540806205384e9129026898b0a1"
  homepage 'http://www.viceteam.org/'

  def remove_unused_icons
    Pathname.glob libexec+'*.app' do |d|
      appname = File.basename(d, '.app')

      Pathname.glob d+'Contents/Resources/x*.icns' do |g|
        File.unlink g if File.basename(g, '.icns') != appname
      end
    end
  end

  fails_with_llvm "Cannot build with LLVM"

  def install
    ENV.libpng

    # Disable the zlibtest, we know we have it.
    # Use Cocoa instead of X
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-cocoa",
                          "--without-x",
                          "--disable-zlibtest"
    system "make"
    system "make bindist"
    prefix.install Dir['vice-macosx-*/*']
    remove_unused_icons
  end

  def caveats
    "Cocoa apps for these emulators have been installed to #{prefix}."
  end
end
