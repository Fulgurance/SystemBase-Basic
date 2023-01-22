class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--with-internal-glib",
                            "--disable-host-tool",
                            "--docdir=/usr/share/doc/pkg-config-0.29.2"],
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

end
