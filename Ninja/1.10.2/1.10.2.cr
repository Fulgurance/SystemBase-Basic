class Target < ISM::Software
    
    def build
        super
        runPythonScript(["configure.py", "--bootstrap"],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/bin/")
        copyFile("#{buildDirectoryPath(false)}/ninja","#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/bin/")
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/bash-completion/completions/ninja")
        copyFile("#{buildDirectoryPath(false)}/misc/bash-completion","#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/bash-completion/completions/ninja")
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/zsh/site-functions/_ninja")
        copyFile("#{buildDirectoryPath(false)}/misc/zsh-completion","#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/zsh/site-functions/_ninja")
    end

end
