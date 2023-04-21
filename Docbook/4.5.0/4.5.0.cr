class Target < ISM::Software

    def prepareInstallation
        super

        (0..55).each do |value|
            fileDeleteLine("#{buildDirectoryPath(false)}/docbook.cat",58)
        end

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5")

        copyFile("#{buildDirectoryPath(false)}/docbook.cat","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/catalog")
        copyFile(Dir["#{buildDirectoryPath(false)}/*.dtd"],"#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/")
        copyFile(Dir["#{buildDirectoryPath(false)}/*.mod"],"#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/")
        copyFile(Dir["#{buildDirectoryPath(false)}/*.dcl"],"#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5/")
    end

    def install
        super

        setOwnerRecursively("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/sgml/docbook/sgml-dtd-4.5","root","root")

        runInstallCatalogCommand([  "--add",
                                    "/etc/sgml/sgml-docbook-dtd-4.5.cat",
                                    "/usr/share/sgml/docbook/sgml-dtd-4.5/catalog"])
        runInstallCatalogCommand([  "--add",
                                    "/etc/sgml/sgml-docbook-dtd-4.5.cat",
                                    "/etc/sgml/sgml-docbook.cat"])
    end

end
