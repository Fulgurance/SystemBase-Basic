class Target < ISM::Software

    def extract
        super
        moveFile("#{workDirectoryPath(false)}/procps-3.3.17","#{workDirectoryPath(false)}/procps-ng-3.3.17")
    end

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--docdir=/usr/share/doc/procps-ng-3.3.17",
                            "--disable-static",
                            "--disable-kill"],
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
