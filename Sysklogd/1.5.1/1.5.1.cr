class Target < ISM::Software

    def prepare
        super
        fileDeleteLine("#{buildDirectoryPath}/ksym_mod.c",192)
        fileReplaceText("#{buildDirectoryPath}/syslogd.c","union wait","int")
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"BINDIR=/sbin","DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
    end

end