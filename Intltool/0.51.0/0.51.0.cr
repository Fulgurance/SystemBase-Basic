class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath(false)}/intltool-update.in","\${","\$\{")
    end

    def configure
        super
        configureSource([   "--prefix=/usr"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/intltool-0.51.0")
        copyFile("#{buildDirectoryPath(false)}doc/I18N-HOWTO","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/intltool-0.51.0/I18N-HOWTO")
        setPermissions("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/intltool-0.51.0/I18N-HOWTO",644)
    end

end
