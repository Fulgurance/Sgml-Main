class Target < ISM::Software

    def prepareInstallation
        super

        (0..55).each do |value|
            fileDeleteLine("#{buildDirectoryPath}/docbook.cat",58)
        end

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5")

        copyFile(   "#{buildDirectoryPath}/docbook.cat",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/catalog")

        copyFile(   "#{buildDirectoryPath}/*.dtd",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/")

        copyFile(   "#{buildDirectoryPath}/*.mod",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/")

        copyFile(   "#{buildDirectoryPath}/*.dcl",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/")
    end

    def install
        super

        runChownCommand("-R root:root /usr/share/sgml/docbook/sgml-dtd-4.5")

        runInstallCatalogCommand(arguments: "--add                              \
                                            /etc/sgml/sgml-docbook-dtd-4.5.cat  \
                                            /usr/share/sgml/docbook/sgml-dtd-4.5/catalog")

        runInstallCatalogCommand(arguments: "--add                              \
                                            /etc/sgml/sgml-docbook-dtd-4.5.cat  \
                                            /etc/sgml/sgml-docbook.cat")
    end

end
