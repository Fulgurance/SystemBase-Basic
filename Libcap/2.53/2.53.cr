class Target < ISM::Software

    def prepare
        super
        fileDeleteLine("#{buildDirectoryPath}/libcap/Makefile",177)
        fileDeleteLine("#{buildDirectoryPath}/libcap/Makefile",188)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions,"prefix=/usr","lib=lib"],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"prefix=/usr","lib=lib","DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
    end

end
