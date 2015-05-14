class I386JosElfGcc < Formula
  homepage "http://pdos.csail.mit.edu/6.828/2014/tools.html"
  url "http://ftpmirror.gnu.org/gcc/gcc-4.6.1/gcc-core-4.6.1.tar.bz2"
  sha256 "0bbb8f754a31f29013f6e9ad4c755d92bb0f154a665c4b623e86ae7174d98e33"

  depends_on "gcc48" => :build
  depends_on "gmp4"
  depends_on "libmpc08"
  depends_on "mpfr2"
  depends_on "i386-jos-elf-binutils"

  def install
    mkdir 'build' do
      gcc = Formula["gcc48"]
      system "../configure", "--target=i386-jos-elf",
                            "--enable-languages=c",
                            "--with-gmp=#{Formula["gmp4"].opt_prefix}",
                            "--with-mpc=#{Formula["libmpc08"].opt_prefix}",
                            "--with-mpfr=#{Formula["mpfr2"].opt_prefix}",
                            "--with-system-zlib",
                            "--disable-werror",
                            "--disable-libssp",
                            "--disable-libmudflap",
                            "--with-newlib",
                            "--without-headers",
                            "--prefix=#{prefix}",
                            "CC=#{gcc.bin}/gcc-#{gcc.version.to_s.slice(/\d\.\d/)}"
      system "make", "all-gcc"
      system "make", "install-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-target-libgcc"
      raise "#{version_suffix}"
    end

    # Handle conflicts between GCC formulae.
    # Remove libffi stuff, which is not needed after GCC is built.
    Dir.glob(prefix/"**/libffi.*") { |file| File.delete file }
    # Rename libiberty.a.
    Dir.glob(prefix/"**/libiberty.*") { |file| add_suffix file, version_suffix }
    # Rename man7.
    Dir.glob(man7/"*.7") { |file| add_suffix file, version_suffix }

    # Even when suffixes are appended, the info pages conflict when
    # install-info is run. Fix this.
    info.rmtree
  end

  def version_suffix
    version.to_s.slice(/\d\.\d/)
  end

  def add_suffix(file, suffix)
    dir = File.dirname(file)
    ext = File.extname(file)
    base = File.basename(file, ext)
    File.rename file, "#{dir}/#{base}-#{suffix}#{ext}"
  end

  test do
    system "#{bin}/i386-jos-elf-gcc -v"
  end
end
