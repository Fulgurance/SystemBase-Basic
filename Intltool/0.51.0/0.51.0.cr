class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath}/intltool-update.in","\${","\$\{")
    end

    def configure
        super
        @useChroot=true
        configureSource([   "--prefix=/usr"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        @useChroot=false
        copyFile("#{buildDirectoryPath}doc/I18N-HOWTO","#{builtSoftwareDirectoryPath}/usr/share/doc/intltool-0.51.0/I18N-HOWTO")
    end

end
