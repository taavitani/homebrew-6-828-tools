class I386JosElfBinutils < Formula
  homepage "http://pdos.csail.mit.edu/6.828/2014/tools.html"
  url "http://ftpmirror.gnu.org/binutils/binutils-2.21.1.tar.bz2"
  sha256 "cdecfa69f02aa7b05fbcdf678e33137151f361313b2f3e48aba925f64eabf654"

  def install
    system "./configure", "--target=i386-jos-elf",
                          "--disable-werror",
                          "--disable-nls",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert `#{bin}/i386-jos-elf-objdump -i`.include? "elf32-i386"
  end
end
