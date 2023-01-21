class Target < ISM::Software

    def configure
        super
        @useChroot=true
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr"],
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
    end

    def clean
        super
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libltdl.a")
    end

end
