class Target < ISM::Software

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"prefix=#{builtSoftwareDirectoryPath}/usr","install"],buildDirectoryPath)
    end

    def clean
        super
        removeFile("#{Ism.settings.rootPath}/usr/lib/libzstd.a")
    end

end
