class Target < ISM::Software
    
    def build
        super
        runPythonScript(["setup.py", "build"],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        runPythonScript(["setup.py", "install", "--root=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/bash-completion/completions/meson")
        copyFile("#{buildDirectoryPath(false)}/data/shell-completions/bash/meson","#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/bash-completion/completions/meson")
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/zsh/site-functions/_meson")
        copyFile("#{buildDirectoryPath(false)}/data/shell-completions/zsh/_meson","#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/zsh/site-functions/_meson")
    end

end
