class Target < ISM::Software

    def prepare
        super
        fileDeleteLine("#{buildDirectoryPath(false)}ksym_mod.c",192)
        fileReplaceText("#{buildDirectoryPath(false)}syslogd.c","union wait","int")
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"BINDIR=/sbin","DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc")

        syslogData = <<-CODE
        auth,authpriv.* -/var/log/auth.log
        *.*;auth,authpriv.none -/var/log/sys.log
        daemon.* -/var/log/daemon.log
        kern.* -/var/log/kern.log
        mail.* -/var/log/mail.log
        user.* -/var/log/user.log
        *.emerg *
        CODE
        fileWriteData("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}etc/syslog.conf",syslogData)
    end

end
