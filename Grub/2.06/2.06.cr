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
        copyFile("/etc/bash_completion.d/grub","#{builtSoftwareDirectoryPath}/usr/share/bash-completion/completions")
    end

    def clean
        super
        deleteFile("/etc/bash_completion.d/grub")
    end

end
