class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--disable-efiemu",
                            "--disable-werror"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/bash-completion/completions")
        moveFile("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/etc/bash_completion.d/grub","#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/bash-completion/completions/grub")
    end

end
