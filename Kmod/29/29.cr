class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--with-xz",
                            "--with-zstd",
                            "--with-zlib"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

    def install
        super
        makeLink("../bin/kmod","#{Ism.settings.rootPath}/usr/sbin/depmod",:symbolicLinkByOverwrite)
        makeLink("../bin/kmod","#{Ism.settings.rootPath}/usr/sbin/insmod",:symbolicLinkByOverwrite)
        makeLink("../bin/kmod","#{Ism.settings.rootPath}/usr/sbin/modinfo",:symbolicLinkByOverwrite)
        makeLink("../bin/kmod","#{Ism.settings.rootPath}/usr/sbin/modprobe",:symbolicLinkByOverwrite)
        makeLink("../bin/kmod","#{Ism.settings.rootPath}/usr/sbin/rmmod",:symbolicLinkByOverwrite)
        makeLink("kmod","#{Ism.settings.rootPath}/usr/bin/lsmod",:symbolicLinkByOverwrite)
    end

end
