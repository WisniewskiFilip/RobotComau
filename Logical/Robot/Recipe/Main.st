
PROGRAM _INIT
	(* Insert code here *)
	MpRecipeXml_0.MpLink := ADR(gRecipeXml);
	MpRecipeXml_0.Enable := TRUE;
	
	MpRecipeRegPar_0.MpLink := ADR(gRecipeXml);
	MpRecipeRegPar_0.Enable := TRUE;
	gAimPos;
	ScrewPosible := TRUE;
	ScrewWasherPosible := TRUE;
	WrenchPosible := TRUE;
	
	MpFileManagerUI_R(MpLink := ADR(gFileManagerUI_R), Enable :=1 , ErrorReset :=0 , UISetup :=MpFileMngSetup , UIConnect :=ADR(MpFileMngConnectR));
	MpFileMngConnectR.DeviceList.DeviceNames[0] := 'RecipeDir';
	
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	
	IF clear THEN 
	
		FOR i := 0 TO 13 BY 1 DO
		gAimPos[i] :=0 ;	
		END_FOR;
		ScrewPosible := TRUE;
		ScrewWasherPosible := TRUE;
		WrenchPosible := TRUE;
	END_IF
	
	
	
	FOR i := 0 TO 13 BY 1 DO
		
		IF gAimPos[i]  = 1 THEN 
			ScrewPosible := FALSE;
		END_IF
		IF gAimPos[i]  = 2 THEN 
			ScrewWasherPosible := FALSE;
		END_IF
		IF gAimPos[i]  = 3 THEN 
			ScrewPosible := FALSE;
			ScrewWasherPosible := FALSE;
		END_IF
		IF gAimPos[i]  = 4 THEN 
			WrenchPosible := FALSE;
		END_IF
		IF gAimPos[i]  = 5 THEN 
			WrenchPosible := FALSE;
			ScrewPosible := FALSE;
		END_IF
		IF gAimPos[i]  = 6 THEN 
			WrenchPosible := FALSE;
			ScrewWasherPosible := FALSE;
		END_IF
		IF gAimPos[i]  = 7 THEN 
			WrenchPosible := FALSE;
			ScrewPosible := FALSE;
			ScrewWasherPosible := FALSE;
		END_IF
		
	END_FOR;
		

		
	MpRecipeXml_0();
	MpRecipeXml_0.DeviceName := ADR('RecipeDir');
	MpRecipeRegPar_0();
	MpRecipeRegPar_0.PVName := ADR('gAimPos');
	
	MpRecipeXml_0.FileName := ADR(name);

	
	
	
	

	
	MpFileManagerUI_R();
	tabInfo.NumberOfElements := 0;
	
	IF MpFileMngConnectR.MessageBox.Type = mpFILE_MSG_OK THEN 
		messageType := 'OK';
	ELSIF MpFileMngConnectR.MessageBox.Type = mpFILE_MSG_CONFIRM_DELETE THEN
		messageType := 'DELETE';
	ELSIF MpFileMngConnectR.MessageBox.Type = mpFILE_MSG_CONFIRM_OVERWRITE THEN
		messageType := 'OVERWRITE';
	ELSIF MpFileMngConnectR.MessageBox.Type = mpFILE_MSG_BUSY THEN
		messageType := 'BUSY';
	END_IF
	
	FOR iFile := 0 TO 49 BY 1 DO
		(* create arrays with file properties *)

		IF tabInfo.NumberOfElements >= iFile THEN
			brsmemcpy(ADR(tabInfo.Name[iFile]), ADR(MpFileMngConnectR.File.List.Items[iFile].Name), SIZEOF(tabInfo.Name[iFile]));
			brsmemcpy(ADR(tabInfo.Size[iFile]), ADR(MpFileMngConnectR.File.List.Items[iFile].Size), SIZEOF(tabInfo.Size[iFile]));
			brsmemcpy(ADR(tabInfo.Type[iFile]), ADR(MpFileMngConnectR.File.List.Items[iFile].ItemType), SIZEOF(tabInfo.Type[iFile]));
			brsmemcpy(ADR(tabInfo.LastModified[iFile]), ADR(MpFileMngConnectR.File.List.Items[iFile].LastModified), SIZEOF(tabInfo.LastModified[iFile]));
		END_IF
		
		IF tabInfo.SelectedRow = iFile THEN
			MpFileMngConnectR.File.List.Items[iFile].IsSelected := TRUE;
			name2 := MpFileMngConnectR.File.List.Items[iFile].Name;
		END_IF
		(* numbers of elements in the table *)
		IF tabInfo.Type[iFile] <> mpFILE_ITEM_TYPE_NONE THEN
			//			tabInfo.NumberOfElements := iFile;
			tabInfo.NumberOfElements := tabInfo.NumberOfElements + 1;
		END_IF
	END_FOR
	
	tableShowLimit := tabInfo.NumberOfElements - 1;
	tableConfig := '{"specRows": [ {"from":0, "to":';
	brsitoa(tableShowLimit,ADR(tempString));
	brsstrcat(ADR(tableConfig),ADR(tempString));
	brsstrcat(ADR(tableConfig),ADR(', "visible":true}, {"from":'));
	brsitoa(tabInfo.NumberOfElements,ADR(tempString));
	brsstrcat(ADR(tableConfig),ADR(tempString));
	brsstrcat(ADR(tableConfig),ADR(', "to":49, "visible":false}]}'));
	
	
	IF PriorytetS = 1 THEN
		Index[0] := 1;
	ELSIF PriorytetSW = 1 THEN
		Index[0] := 2;
	ELSIF PriorytetW = 1 THEN
		Index[0] := 4;	
	END_IF
	
	IF PriorytetS = 2 THEN
		Index[1] := 1;
	ELSIF PriorytetSW = 2 THEN
		Index[1] := 2;
	ELSIF PriorytetW = 2 THEN
		Index[1] := 4;	
	END_IF
	
	IF PriorytetS = 3 THEN
		Index[2] := 1;
	ELSIF PriorytetSW = 3 THEN
		Index[2] := 2;
	ELSIF PriorytetW = 3 THEN
		Index[2] := 4;	
	END_IF
	
	IF PriorytetS = PriorytetSW OR PriorytetS = PriorytetW OR PriorytetSW = PriorytetW OR
		PriorytetS = 0 OR PriorytetSW = 0 OR PriorytetW = 0
		THEN
		Index[0] := 1;
		Index[1] := 2;
		Index[2] := 4;	
	END_IF
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

