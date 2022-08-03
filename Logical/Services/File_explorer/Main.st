
PROGRAM _INIT
	(* Insert code here *)
	MpFileMngSetup.FileListSize := 50;
	MpFileManagerUI_0(MpLink := ADR(gFileManagerUI), Enable :=1 , ErrorReset :=0 , UISetup :=MpFileMngSetup , UIConnect :=ADR(MpFileMngConnect));
	MpFileMngConnect.DeviceList.DeviceNames[0] := 'FilesDir';
	sortOrder[0] := '{"value":"0", "text":"Alphabetic (ascending)"}';
	sortOrder[1] := '{"value":"1", "text":"Alphabetic (descending)"}';
	sortOrder[2] := '{"value":"2", "text":"By size (ascending)"}';
	sortOrder[3] := '{"value":"3", "text":"By size (descending)"}';
	sortOrder[4] := '{"value":"4", "text":"By date (ascending))"}';
	sortOrder[5] := '{"value":"5", "text":"By date (descending)"}';
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	MpFileManagerUI_0();
	tabInfo.NumberOfElements := 0;
	
	CASE chosenSortOrder OF
		0:
			MpFileMngConnect.File.SortOrder := mpFILE_SORT_BY_NAME_ASC;
		1:
			MpFileMngConnect.File.SortOrder := mpFILE_SORT_BY_NAME_DESC;
		2:
			MpFileMngConnect.File.SortOrder := mpFILE_SORT_BY_SIZE_ASC;
		3:
			MpFileMngConnect.File.SortOrder := mpFILE_SORT_BY_SIZE_DES;
		4:
			MpFileMngConnect.File.SortOrder := mpFILE_SORT_BY_MOD_TIME_ASC;
		5:
			MpFileMngConnect.File.SortOrder := mpFILE_SORT_BY_MOD_TIME_DESC;
	END_CASE
			
	
	IF MpFileMngConnect.MessageBox.Type = mpFILE_MSG_OK THEN 
		messageType := 'OK';
	ELSIF MpFileMngConnect.MessageBox.Type = mpFILE_MSG_CONFIRM_DELETE THEN
		messageType := 'DELETE';
	ELSIF MpFileMngConnect.MessageBox.Type = mpFILE_MSG_CONFIRM_OVERWRITE THEN
		messageType := 'OVERWRITE';
	ELSIF MpFileMngConnect.MessageBox.Type = mpFILE_MSG_BUSY THEN
		messageType := 'BUSY';
	END_IF
	
	
	
	FOR iFile := 0 TO 49 BY 1 DO
		(* create arrays with file properties *)
//		IF tabInfo.NumberOfElements >= iFile THEN
			brsmemcpy(ADR(tabInfo.Name[iFile]), ADR(MpFileMngConnect.File.List.Items[iFile].Name), SIZEOF(tabInfo.Name[iFile]));
			brsmemcpy(ADR(tabInfo.Size[iFile]), ADR(MpFileMngConnect.File.List.Items[iFile].Size), SIZEOF(tabInfo.Size[iFile]));
			brsmemcpy(ADR(tabInfo.Type[iFile]), ADR(MpFileMngConnect.File.List.Items[iFile].ItemType), SIZEOF(tabInfo.Type[iFile]));
			brsmemcpy(ADR(tabInfo.LastModified[iFile]), ADR(MpFileMngConnect.File.List.Items[iFile].LastModified), SIZEOF(tabInfo.LastModified[iFile]));
//		END_IF
		
		IF tabInfo.SelectedRow = iFile THEN
			MpFileMngConnect.File.List.Items[iFile].IsSelected := TRUE;
		END_IF
		(* numbers of elements in the table *)
		IF tabInfo.Type[iFile] <> mpFILE_ITEM_TYPE_NONE THEN
			//			tabInfo.NumberOfElements := iFile;
			tabInfo.NumberOfElements := tabInfo.NumberOfElements + 1;
		END_IF
		
		CASE tabInfo.Type[iFile] OF
			mpFILE_ITEM_TYPE_FOLDER:
				itemType[iFile] := 'Folder';
			mpFILE_ITEM_TYPE_FILE:
				itemType[iFile] := 'Plik';
			mpFILE_ITEM_TYPE_TXT:
				itemType[iFile] := 'Plik tekstowy';
			mpFILE_ITEM_TYPE_HTML:
				itemType[iFile] := 'Plik HTML';
			mpFILE_ITEM_TYPE_XLS:
				itemType[iFile] := 'Plik XLS';
			mpFILE_ITEM_TYPE_XML:
				itemType[iFile] := 'Plik XML';
			mpFILE_ITEM_TYPE_CSV:
				itemType[iFile] := 'Plik CSV';
			mpFILE_ITEM_TYPE_JPG:
				itemType[iFile] := 'Plik JPG';
			mpFILE_ITEM_TYPE_BMP:
				itemType[iFile] := 'Plik BMP';
			mpFILE_ITEM_TYPE_UNKNOWN:
				itemType[iFile] := 'Plik nieznany';
			END_CASE
	END_FOR
	
	tableShowLimit := tabInfo.NumberOfElements - 1;
	tableConfig := '{"specRows": [ {"from":0, "to":';
	brsitoa(tableShowLimit,ADR(tempString));
	brsstrcat(ADR(tableConfig),ADR(tempString));
	brsstrcat(ADR(tableConfig),ADR(', "visible":true}, {"from":'));
	brsitoa(tabInfo.NumberOfElements,ADR(tempString));
	brsstrcat(ADR(tableConfig),ADR(tempString));
	brsstrcat(ADR(tableConfig),ADR(', "to":49, "visible":false}]}'));
	

//		TableConfig := '{"specRows": [ ';    
//		FOR Index:=0 TO MAX_ORDERS_NUM_MINUS_ONE DO
//			IF Index <> 0 THEN
//				brsstrcat(ADR(TableConfig), ADR(','));
//			END_IF;
//			brsstrcat(ADR(TableConfig), ADR('{"index":'));
//			brsitoa(Index, ADR(IndexStr)); (*write int_value to the string*)
//			brsstrcat(ADR(TableConfig), ADR(IndexStr));
//
//			//    IF  (OrderLengths[Index] = 0) AND (OrderCounts[Index] = 0) THEN
//			IF  (OrderLengths[Index] = 0) THEN
//
//				brsstrcat(ADR(TableConfig), ADR(', "visible":false}'));
//			ELSE
//				brsstrcat(ADR(TableConfig), ADR(', "visible":true}'));
//			END_IF;
//
//			IF (Index = MAX_ORDERS_NUM_MINUS_ONE) THEN
//				brsstrcat(ADR(TableConfig), ADR(']}'));
//			END_IF;
//		END_FOR;
//		(* Return true *)
//		CreateTableConfig := TRUE;

	
	

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	MpFileManagerUI_0.Enable := FALSE;
	MpFileManagerUI_0();
END_PROGRAM

