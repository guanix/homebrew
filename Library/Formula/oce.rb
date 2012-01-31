require 'formula'

class Oce < Formula
  url 'https://github.com/tpaviot/oce/tarball/OCE-0.9.0-rc1'
  homepage 'https://github.com/tpaviot/oce'
  md5 '5c38f1f988914e68c5eafa2674f12494'
  version '0.9.0-rc1'

  depends_on 'ftgl'
  depends_on 'cmake'

  def install    
    system "cmake", ".", std_cmake_parameters, "-DOCE_INSTALL_PREFIX:PATH=#{prefix}"
    system "make"
    system "make install/strip"
  end
end
