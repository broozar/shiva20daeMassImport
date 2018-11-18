-- DAE MASS IMPORTER
-- November 2018
-- Felix Caffier

--------------------------------------------------------------------------------

function onMainViewUpdateMenuFile ( hView, hMenu )

end

function onRefreshUI ( hView, hMenu )
	
	log.message ( "Refreshing FFBX module lists..." )
	refreshTargetList ( )

end

--------------------------------------------------------------------------------

function onWebTris ( hView, hMenu )
	
	log.message ( "Visiting trisymphony website..." )
	system.openURL( "www.trisymphony.com" )
	
end
