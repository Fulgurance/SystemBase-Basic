class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--bindir=/usr/sbin",
                            "--sysconfdir=/etc",
                            "--enable-manpages",
                            "--disable-static"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"-f","udev-lfs-20171102/Makefile.lfs","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],workDirectoryPath)
    end

    def install
        super
        runUdevadmCommand(["hwdb","--update"])
    end

end
