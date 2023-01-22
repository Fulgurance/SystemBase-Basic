class Target < ISM::Software

    def prepare
        super
        fileDeleteLine("#{buildDirectoryPath(false)}/ksym_mod.c",192)
        fileReplaceText("#{buildDirectoryPath(false)}/syslogd.c","union wait","int")
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"BINDIR=/sbin","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
