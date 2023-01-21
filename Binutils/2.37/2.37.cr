class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
        fileDeleteLine("#{mainWorkDirectoryPath}/etc/texi2pod.pl",63)
        deleteAllFilesRecursivelyFinishing("#{mainWorkDirectoryPath}",".1")
    end

    def configure
        super
        @useChroot=true
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
        @useChroot=false
        deleteFile("#{Ism.settings.rootPath}/usr/lib/lib/bfd.a")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/lib/ctf.a")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/lib/ctf-nobfd.a")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/lib/opcodes.a")
    end

end
