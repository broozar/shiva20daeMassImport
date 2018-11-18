-- DAE MASS IMPORTER
-- November 2018
-- Felix Caffier

--------------------------------------------------------------------------------
-- TOOLS
--------------------------------------------------------------------------------

function refreshTargetList ( )

    local hComboBox = gui.getComponent ( "mdae.convert.target" )
    if not hComboBox then message.warning ( "mDAE: target profile ComboBox not found" ) return end

    local tTargetProfileList = project.getTargetProfileList ( )
    if  ( tTargetProfileList ) then
        if ( gui.getComboBoxItemCount ( hComboBox ) ~= #tTargetProfileList )
        then
            gui.removeAllComboBoxItems ( hComboBox )

            local tSortedProfiles       = { }
            local hDefaultTargetProfile = project.getDefaultTargetProfile ( )

            for i = 1, #tTargetProfileList do
                if  ( hDefaultTargetProfile ~= tTargetProfileList[i] ) then
                    table.insert ( tSortedProfiles, project.getTargetProfileName ( tTargetProfileList[i] ) )
                end
            end

            table.sort ( tSortedProfiles )
            gui.appendComboBoxItem ( hComboBox, project.getTargetProfileName ( hDefaultTargetProfile ) )

            for i = 1, #tSortedProfiles    do
                gui.appendComboBoxItem ( hComboBox, tSortedProfiles[i] )
            end
        end
    end

end

--------------------------------------------------------------------------------
-- INIT / DESTROY
--------------------------------------------------------------------------------

function onMainViewInit ( )

    -- prepare combo boxes
    local hConSwa = gui.getComponent ( "mdae.convert.swapyz" )
    if ( hConSwa ) and ( gui.getComboBoxItemCount ( hConSwa ) == 0 ) then
        gui.appendComboBoxItem ( hConSwa, "None" ) --0
        gui.appendComboBoxItem ( hConSwa, "Everything" ) --1
        gui.appendComboBoxItem ( hConSwa, "Skeleton only" ) --2
        gui.appendComboBoxItem ( hConSwa, "Animation only" ) --3
        gui.appendComboBoxItem ( hConSwa, "Skeleton and Animation only" ) --4
    end

    onConfigLoad ( )
    refreshTargetList ( )

end

function onMainViewDestroy ( )

end

--------------------------------------------------------------------------------
-- STARTUP CONFIG
--------------------------------------------------------------------------------

function onConfigLoad ( )

    local sMID = this.getModuleIdentifier ( )

    local hImpMat = gui.getComponent ( "mdae.import.material" )
    local hImpTex = gui.getComponent ( "mdae.import.texture" )
    local hImpShp = gui.getComponent ( "mdae.import.shape" )
    local hImpAni = gui.getComponent ( "mdae.import.animation" )

    local hConSca = gui.getComponent ( "mdae.convert.prescale" )
    local hConTrX = gui.getComponent ( "mdae.convert.transX" )
    local hConTrY = gui.getComponent ( "mdae.convert.transY" )
    local hConTrZ = gui.getComponent ( "mdae.convert.transZ" )
    local hConRoX = gui.getComponent ( "mdae.convert.rotX" )
    local hConRoY = gui.getComponent ( "mdae.convert.rotY" )
    local hConRoZ = gui.getComponent ( "mdae.convert.rotZ" )
    local hConTrXs = gui.getComponent ( "mdae.convert.transXs" )
    local hConTrYs = gui.getComponent ( "mdae.convert.transYs" )
    local hConTrZs = gui.getComponent ( "mdae.convert.transZs" )
    local hConRoXs = gui.getComponent ( "mdae.convert.rotXs" )
    local hConRoYs = gui.getComponent ( "mdae.convert.rotYs" )
    local hConRoZs = gui.getComponent ( "mdae.convert.rotZs" )
    local hConSkel = gui.getComponent ( "mdae.convert.skelscale" )
    local hConRoXa = gui.getComponent ( "mdae.convert.rotXa" )
    local hConRoYa = gui.getComponent ( "mdae.convert.rotYa" )
    local hConRoZa = gui.getComponent ( "mdae.convert.rotZa" )
    local hConRela = gui.getComponent ( "mdae.convert.animRelative" )

    local bImpMat = project.getUserProperty ( nil, sMID ..".config.mdae.import.material" )
    local bImpTex = project.getUserProperty ( nil, sMID ..".config.mdae.import.texture" )
    local bImpShp = project.getUserProperty ( nil, sMID ..".config.mdae.import.shape" )
    local bImpAni = project.getUserProperty ( nil, sMID ..".config.mdae.import.animation" )

    local nConSca = project.getUserProperty ( nil, sMID ..".config.mdae.convert.prescale" )
    local nConTrX = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transX" )
    local nConTrY = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transY" )
    local nConTrZ = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transZ" )
    local nConRoX = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotX" )
    local nConRoY = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotY" )
    local nConRoZ = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotZ" )
    local nConTrXs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transXs" )
    local nConTrYs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transYs" )
    local nConTrZs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transZs" )
    local nConRoXs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotXs" )
    local nConRoYs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotYs" )
    local nConRoZs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotZs" )
    local nConSkel = project.getUserProperty ( nil, sMID ..".config.mdae.convert.skelscale" )
    local nConRoXa = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotXa" )
    local nConRoYa = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotYa" )
    local nConRoZa = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotZa" )
    local bConRela = project.getUserProperty ( nil, sMID ..".config.mdae.convert.animRelative" )

    if ( hImpMat ) then gui.setCheckBoxState ( hImpMat, bImpMat and gui.kCheckStateOn or gui.kCheckStateOff ) end
    if ( hImpTex ) then gui.setCheckBoxState ( hImpTex, bImpTex and gui.kCheckStateOn or gui.kCheckStateOff ) end
    if ( hImpShp ) then gui.setCheckBoxState ( hImpShp, bImpShp and gui.kCheckStateOn or gui.kCheckStateOff ) end
    if ( hImpAni ) then gui.setCheckBoxState ( hImpAni, bImpAni and gui.kCheckStateOn or gui.kCheckStateOff ) end

    if ( hConSca ) then gui.setNumberBoxValue ( hConSca, nConSca or 1.0 ) end
    if ( hConTrX ) then gui.setNumberBoxValue ( hConTrX, nConTrX or 0 ) end
    if ( hConTrY ) then gui.setNumberBoxValue ( hConTrY, nConTrY or 0 ) end
    if ( hConTrZ ) then gui.setNumberBoxValue ( hConTrZ, nConTrZ or 0 ) end
    if ( hConRoX ) then gui.setNumberBoxValue ( hConRoX, nConRoX or 0 ) end
    if ( hConRoY ) then gui.setNumberBoxValue ( hConRoY, nConRoY or 0 ) end
    if ( hConRoZ ) then gui.setNumberBoxValue ( hConRoZ, nConRoZ or 0 ) end
    if ( hConTrXs ) then gui.setNumberBoxValue ( hConTrXs, nConTrXs or 0 ) end
    if ( hConTrYs ) then gui.setNumberBoxValue ( hConTrYs, nConTrYs or 0 ) end
    if ( hConTrZs ) then gui.setNumberBoxValue ( hConTrZs, nConTrZs or 0 ) end
    if ( hConRoXs ) then gui.setNumberBoxValue ( hConRoXs, nConRoXs or 0 ) end
    if ( hConRoYs ) then gui.setNumberBoxValue ( hConRoYs, nConRoYs or 0 ) end
    if ( hConRoZs ) then gui.setNumberBoxValue ( hConRoZs, nConRoZs or 0 ) end
    if ( hConSkel ) then gui.setNumberBoxValue ( hConSkel, nConSkel or 1.0 ) end
    if ( hConRoXa ) then gui.setNumberBoxValue ( hConRoXa, nConRoXa or 0 ) end
    if ( hConRoYa ) then gui.setNumberBoxValue ( hConRoYa, nConRoYa or 0 ) end
    if ( hConRoZa ) then gui.setNumberBoxValue ( hConRoZa, nConRoZa or 0 ) end
    if ( hConRela ) then gui.setCheckBoxState ( hConRela, bConRela and gui.kCheckStateOn or gui.kCheckStateOff ) end

end

function onConfigSave ( )

    local sMID = this.getModuleIdentifier ( )

    local hImpMat = gui.getComponent ( "mdae.import.material" )
    local hImpTex = gui.getComponent ( "mdae.import.texture" )
    local hImpShp = gui.getComponent ( "mdae.import.shape" )
    local hImpAni = gui.getComponent ( "mdae.import.animation" )

    local hConSca = gui.getComponent ( "mdae.convert.prescale" )
    local hConTrX = gui.getComponent ( "mdae.convert.transX" )
    local hConTrY = gui.getComponent ( "mdae.convert.transY" )
    local hConTrZ = gui.getComponent ( "mdae.convert.transZ" )
    local hConRoX = gui.getComponent ( "mdae.convert.rotX" )
    local hConRoY = gui.getComponent ( "mdae.convert.rotY" )
    local hConRoZ = gui.getComponent ( "mdae.convert.rotZ" )
    local hConTrXs = gui.getComponent ( "mdae.convert.transXs" )
    local hConTrYs = gui.getComponent ( "mdae.convert.transYs" )
    local hConTrZs = gui.getComponent ( "mdae.convert.transZs" )
    local hConRoXs = gui.getComponent ( "mdae.convert.rotXs" )
    local hConRoYs = gui.getComponent ( "mdae.convert.rotYs" )
    local hConRoZs = gui.getComponent ( "mdae.convert.rotZs" )
    local hConSkel = gui.getComponent ( "mdae.convert.skelscale" )
    local hConRoXa = gui.getComponent ( "mdae.convert.rotXa" )
    local hConRoYa = gui.getComponent ( "mdae.convert.rotYa" )
    local hConRoZa = gui.getComponent ( "mdae.convert.rotZa" )
    local hConRela = gui.getComponent ( "mdae.convert.animRelative" )

    project.setUserProperty ( nil, sMID ..".config.mdae.import.material", gui.getCheckBoxState ( hImpMat ) == gui.kCheckStateOn )
    project.setUserProperty ( nil, sMID ..".config.mdae.import.texture", gui.getCheckBoxState ( hImpTex ) == gui.kCheckStateOn )
    project.setUserProperty ( nil, sMID ..".config.mdae.import.shape", gui.getCheckBoxState ( hImpShp ) == gui.kCheckStateOn )
    project.setUserProperty ( nil, sMID ..".config.mdae.import.animation", gui.getCheckBoxState ( hImpAni ) == gui.kCheckStateOn )

    project.setUserProperty ( nil, sMID ..".config.mdae.convert.prescale", gui.getNumberBoxValue ( hConSca ) or 1.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.transX", gui.getNumberBoxValue ( hConTrX ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.transY", gui.getNumberBoxValue ( hConTrY ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.transZ", gui.getNumberBoxValue ( hConTrZ ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.rotX", gui.getNumberBoxValue ( hConRoX ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.rotY", gui.getNumberBoxValue ( hConRoY ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.rotZ", gui.getNumberBoxValue ( hConRoZ ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.transXs", gui.getNumberBoxValue ( hConTrXs ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.transYs", gui.getNumberBoxValue ( hConTrYs ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.transZs", gui.getNumberBoxValue ( hConTrZs ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.rotXs", gui.getNumberBoxValue ( hConRoXs ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.rotYs", gui.getNumberBoxValue ( hConRoYs ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.rotZs", gui.getNumberBoxValue ( hConRoZs ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.skelscale", gui.getNumberBoxValue ( hConSkel ) or 1.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.rotXa", gui.getNumberBoxValue ( hConRoXa ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.rotYa", gui.getNumberBoxValue ( hConRoYa ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.rotZa", gui.getNumberBoxValue ( hConRoZa ) or 0.0 )
    project.setUserProperty ( nil, sMID ..".config.mdae.convert.animRelative", gui.getCheckBoxState ( hConRela ) == gui.kCheckStateOn )

end

--------------------------------------------------------------------------------
-- INPUT
--------------------------------------------------------------------------------

function onInputAdd ( )

    local hTree = gui.getComponent ( "mdae.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    local tOldFiles = {}
    for j=1, cTree do
        table.insert ( tOldFiles, gui.getTreeItemText ( gui.getTreeItem ( hTree, j ) ) )
    end


    local tNewFiles = gui.showFileChooserDialog ( "Add files...", "", "Collada (*.dae);;All files (*.*)", gui.kFileChooserDialogOptionOpenFiles )
    if ( tNewFiles and ( utils.getVariableType ( tNewFiles ) == utils.kVariableTypeTable ) and ( #tNewFiles > 0 ) ) then
        for i = 1, #tNewFiles do
            local it = tNewFiles[i]
            if ( cTree > 0 ) then
                if ( table.find ( tOldFiles, it ) ) then
                    log.message ( "mDAE: Ignoring duplicate file '" ..it .."'" )
                else
                    local item = gui.appendTreeItem ( hTree )
                    gui.setTreeItemData ( item, gui.kDataRoleDisplay, it )
                end
            else
                local item = gui.appendTreeItem ( hTree )
                gui.setTreeItemData ( item, gui.kDataRoleDisplay, it )
            end
        end
    end

end

function onInputRemoveAll ( )

    local hTree = gui.getComponent ( "mdae.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    if cTree < 1 then return end
    for j=cTree, 1, -1 do
        gui.removeTreeItem ( hTree, gui.getTreeItem ( hTree, j ) )
    end

end

function onInputRemove ( )

    local hTree = gui.getComponent ( "mdae.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    if cTree < 1 then return end

    for i=cTree, 1, -1 do
        local it = gui.getTreeItem ( hTree, i )
        if gui.isTreeItemSelected ( hTree, it ) then
            gui.removeTreeItem ( hTree, it )
        end
    end

end

--------------------------------------------------------------------------------
-- DAE IMPORT
--------------------------------------------------------------------------------

function onImportDAE ( )

    local sMID = this.getModuleIdentifier ( )

    -- get conversion options

    local iSwap = 0
    local hConSwa = gui.getComponent ( "mdae.convert.swapyz" )
    if ( hConSwa ) then iSwap = gui.getComboBoxItemRow ( gui.getComboBoxSelectedItem ( hConSwa ) ) -1 end

    local bImpMat = project.getUserProperty ( nil, sMID ..".config.mdae.import.material" )
    local bImpTex = project.getUserProperty ( nil, sMID ..".config.mdae.import.texture" )
    local bImpShp = project.getUserProperty ( nil, sMID ..".config.mdae.import.shape" )
    local bImpAni = project.getUserProperty ( nil, sMID ..".config.mdae.import.animation" )

    local nConSca = project.getUserProperty ( nil, sMID ..".config.mdae.convert.prescale" )
    local nConTrX = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transX" )
    local nConTrY = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transY" )
    local nConTrZ = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transZ" )
    local nConRoX = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotX" )
    local nConRoY = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotY" )
    local nConRoZ = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotZ" )
    local nConTrXs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transXs" )
    local nConTrYs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transYs" )
    local nConTrZs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.transZs" )
    local nConRoXs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotXs" )
    local nConRoYs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotYs" )
    local nConRoZs = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotZs" )
    local nConSkel = project.getUserProperty ( nil, sMID ..".config.mdae.convert.skelscale" )
    local nConRoXa = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotXa" )
    local nConRoYa = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotYa" )
    local nConRoZa = project.getUserProperty ( nil, sMID ..".config.mdae.convert.rotZa" )
    local bConRela = project.getUserProperty ( nil, sMID ..".config.mdae.convert.animRelative" )

    local vConSca = table.pack ( nConSca, nConSca, nConSca )
    local vConTra = table.pack ( nConTrX, nConTrY, nConTrZ )
    local vConRot = table.pack ( nConRoX, nConRoY, nConRoZ )
    local vConScaS = table.pack ( nConSkel, nConSkel, nConSkel )
    local vConTraS = table.pack ( nConTrXs, nConTrYs, nConTrZs )
    local vConRotS = table.pack ( nConRoXs, nConRoYs, nConRoZs )
    local vConRotA = table.pack ( nConRoXa, nConRoYa, nConRoZa )


    -- get file names from tree

    local hTree = gui.getComponent ( "mdae.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    if cTree < 1 then
        log.warning ( "mDAE: nothing to import..." )
        return
    end

    for i=1, cTree do
        local sFilename = gui.getTreeItemText ( gui.getTreeItem ( hTree, i ) )
        if ( not system.fileExists ( sFilename ) ) then
            log.warning ( "mDAE: Could not locate '" ..sFilename .."', skipping..." )
        else

            -- create a new job for every import

            local hImportJob = job.create ( "" )
            if not hImportJob then
                log.warning ( "mDAE: Could not create Job for " ..sFilename )
            else

                local sProjectRootPath = project.getRootDirectory ( )
                local sFileToImportPath = sFilename
                local sModelname = string.extractFileName ( sFileToImportPath )

                local hTarget
                local hSelectedItem = gui.getComboBoxSelectedItem ( gui.getComponent ( "mdae.convert.target" ) )
                if  ( hSelectedItem ) then
                    gui.getComboBoxItemUserData ( hSelectedItem )
                end

                job.setType     ( hImportJob, job.kTypeImportModel )
                job.setProperty ( hImportJob, job.kPropertyLogOutput,               true )

                job.setProperty ( hImportJob, job.kPropertySourceFile,              sFileToImportPath )
                job.setProperty ( hImportJob, job.kPropertyDestinationName,         sModelname )
                job.setProperty ( hImportJob, job.kPropertyDestinationDirectory,    sProjectRootPath  )
                job.setProperty ( hImportJob, job.kPropertyDescription,             "mDAE Model Import" )
                job.setProperty ( hImportJob, job.kPropertyDestinationTarget,       hTarget )

                job.setProperty ( hImportJob, job.kPropertyImportPrefixItemList, { sModelname .."_" } )

                local tbDummy = { job.kImportItemDummy, false }
                local tbMesh = { job.kImportItemMesh , bImpShp }
                local tbCamera = { job.kImportItemCamera , false }
                local tbLight = { job.kImportItemLight , false }
                local tbMaterial = { job.kImportItemMaterial , bImpMat }
                local tbTexture = { job.kImportItemTexture, bImpTex }
                local tbSkeleton = { job.kImportItemSkeleton , true }
                local tbAnimation = { job.kImportItemAnimation , bImpAni }
                job.setProperty ( hImportJob, job.kPropertyImportProcessItemList, { false, tbDummy, tbMesh, tbCamera, tbLight, tbMaterial, tbTexture, tbSkeleton, tbAnimation } )

                job.setProperty ( hImportJob, job.kPropertyImportGlobalTranslation, vConTra )
                job.setProperty ( hImportJob, job.kPropertyImportGlobalRotation, vConRot )
                job.setProperty ( hImportJob, job.kPropertyImportGlobalScale, vConSca )
                if ( iSwap == 1 ) then job.setProperty ( hImportJob, job.kPropertyImportGlobalZUp2YUp, true ) end

                job.setProperty ( hImportJob, job.kPropertyImportSkeletonTranslation, vConTraS )
                job.setProperty ( hImportJob, job.kPropertyImportSkeletonRotation, vConRotS )
                job.setProperty ( hImportJob, job.kPropertyImportSkeletonScale, vConScaS )
                if ( (iSwap == 2) or (iSwap == 4) ) then job.setProperty ( hImportJob, job.kPropertyImportSkeletonZUp2YUp, true ) end

                job.setProperty ( hImportJob, job.kPropertyImportAnimationRotation, vConRotA )
                if ( (iSwap == 3) or (iSwap == 4) ) then job.setProperty ( hImportJob, job.kPropertyImportAnimationZUp2YUp, true ) end

                job.setProperty ( hImportJob, job.kPropertyImportAnimationRelativeKeys, bConRela )

                -- Run the job (ASYNC)

                if ( job.run ( hImportJob, true ) ) then
                    log.message ( "mDAE: running import job for " ..sFilename )
                end

            end

        end
    end
end

function onRunImportDAE ( )

    onConfigSave ( )
    log.message ( "-------------------------------" )
    log.message ( "mDAE: Starting DAE import process" )

    onImportDAE ( )

end