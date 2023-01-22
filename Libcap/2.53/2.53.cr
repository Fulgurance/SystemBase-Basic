class Target < ISM::Software

    def prepare
        super
        fileDeleteLine("#{buildDirectoryPath(false)}/libcap/Makefile",177)
        fileDeleteLine("#{buildDirectoryPath(false)}/libcap/Makefile",188)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions,"prefix=/usr","lib=lib"],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"prefix=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr","lib=lib","install"],buildDirectoryPath)
    end

end
