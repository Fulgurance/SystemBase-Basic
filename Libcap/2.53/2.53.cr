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
        setPermissions("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/lib/libcap.so.2.53")
        setPermissions("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/lib/libpsx.so.2.53")
    end

end
