class Target < ISM::Software

    def build
        super
        @useChroot=true
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"prefix=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr","install"],buildDirectoryPath)
        @useChroot=false
    end

    def clean
        super
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libzstd.a")
    end

end
