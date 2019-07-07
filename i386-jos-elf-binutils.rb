class I386JosElfBinutils < Formula
  homepage "http://pdos.csail.mit.edu/6.828/2014/tools.html"
  url "http://ftpmirror.gnu.org/binutils/binutils-2.32.tar.xz"
  sha256 "0ab6c55dd86a92ed561972ba15b9b70a8b9f75557f896446c82e8b36e473ee04"

  def install
    system "./configure", "--target=i386-jos-elf",
                          "--disable-multilib",
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
