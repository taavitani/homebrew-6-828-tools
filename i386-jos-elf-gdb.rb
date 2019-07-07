class I386JosElfGdb < Formula
  homepage "http://pdos.csail.mit.edu/6.828/2014/tools.html"
  url "https://ftp.gnu.org/gnu/gdb/gdb-8.2.tar.xz"
  sha256 "c3a441a29c7c89720b734e5a9c6289c0a06be7e0c76ef538f7bbcef389347c39"

  def install
    mkdir "build" do
      system "../configure", "--target=i386-jos-elf",
                             "--prefix=#{prefix}",
                             "--disable-werror"
      system "make"
      system "make", "install-gdb"
    end
  end

  test do
    system "#{bin}/i386-jos-elf-gdb", "#{bin}/i386-jos-elf-gdb", "-configuration"
  end
end

