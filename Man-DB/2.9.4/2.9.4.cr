class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--docdir=#{Ism.settings.rootPath}/usr/share/doc/man-db-2.9.4",
                            "--sysconfdir=#{Ism.settings.rootPath}/etc",
                            "--disable-setuid",
                            "--enable-cache-owner=bin",
                            "--with-browser=#{Ism.settings.rootPath}/usr/bin/lynx",
                            "--with-vgrind=#{Ism.settings.rootPath}/usr/bin/vgrind",
                            "--with-grap=#{Ism.settings.rootPath}/usr/bin/grap",
                            "--with-systemdtmpfilesdir=",
                            "--with-systemdsystemunitdir="],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
    end

end
