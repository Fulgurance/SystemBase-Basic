class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath}/src/Makefile.in","groups$(EXEEXT) ","")
        replaceTextAllFilesRecursivelyNamed("#{buildDirectoryPath}/man","Makefile.in","groups.1 ","")
        replaceTextAllFilesRecursivelyNamed("#{buildDirectoryPath}/man","Makefile.in","getspnam.3 ","")
        replaceTextAllFilesRecursivelyNamed("#{buildDirectoryPath}/man","Makefile.in","passwd.5 ","")
        fileReplaceTextAtLineNumber("#{buildDirectoryPath}/libmisc/salt.c","rounds","min_rounds",224)
        generateEmptyFile("#{buildDirectoryPath}/")
    end

    def configure
        super
        configureSource([   "--sysconfdir=#{Ism.settings.rootPath}/etc",
                            "--with-group-name-max-length=32"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"exec_prefix=/usr","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"-C","man","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install-man"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath}/etc/default")
    end

end
