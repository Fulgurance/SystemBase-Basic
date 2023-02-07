class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
        fileDeleteLine("#{mainWorkDirectoryPath(false)}/etc/texi2pod.pl",63)
        deleteAllFilesRecursivelyFinishing("#{mainWorkDirectoryPath(false)}",".1")
    end

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--enable-gold",
                            "--enable-ld=default",
                            "--enable-plugins",
                            "--enable-shared",
                            "--disable-werror",
                            "--enable-64-bit-bfd",
                            "--with-system-zlib"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions,"tooldir=/usr"],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"tooldir=/usr","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

    def clean
        super
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libbfd.a")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libctf.a")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libctf-nobfd.a")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libopcodes.a")
    end

end
