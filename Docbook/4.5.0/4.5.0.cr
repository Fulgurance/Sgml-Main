class Target < ISM::Software

    def prepareInstallation
        super

        (0..55).each do |value|
            fileDeleteLine("#{buildDirectoryPath}/docbook.cat",58)
        end

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5")

        copyFile("#{buildDirectoryPath}/docbook.cat","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/catalog")
        copyFile(Dir["#{buildDirectoryPath}/*.dtd"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/")
        copyFile(Dir["#{buildDirectoryPath}/*.mod"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/")
        copyFile(Dir["#{buildDirectoryPath}/*.dcl"],"#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/")
    end

    def install
        super

        setOwnerRecursively("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5","root","root")

        runInstallCatalogCommand([  "--add",
                                    "/etc/sgml/sgml-docbook-dtd-4.5.cat",
                                    "/usr/share/sgml/docbook/sgml-dtd-4.5/catalog"])
        runInstallCatalogCommand([  "--add",
                                    "/etc/sgml/sgml-docbook-dtd-4.5.cat",
                                    "/etc/sgml/sgml-docbook.cat"])
    end

end
