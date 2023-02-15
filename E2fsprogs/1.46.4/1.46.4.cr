class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--enable-elf-shlibs",
                            "--disable-libblkid",
                            "--disable-libuuid",
                            "--disable-uuidd",
                            "--disable-fsck"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        runGunzipCommand(["#{Ism.settings.rootPath}usr/share/info/libext2fs.info.gz"])
        runInstallinfoCommand([ "--dir-file=#{Ism.settings.rootPath}usr/share/info/dir",
                                "#{Ism.settings.rootPath}usr/share/info/libext2fs.info"])
    end

    def clean
        super
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libcom_err.a")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libe2p.a")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libext2fs.a")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libss.a")
    end

end
