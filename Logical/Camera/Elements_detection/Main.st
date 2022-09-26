
PROGRAM _INIT
	//CAMERA INITIAL VALUES
	Camera_0.Focus := 30000;
	Camera_0.ExposureTime := 40000;
	Camera_0.NumSearch := 14;
	Camera_0.Enable := 1;
	
	PixelRange_0.ScrewLimit := 200;
	PixelRange_0.WasherBoltLimit := 500;
	PixelRange_0.WrenchLimit := 2000;
	PixelRange_0.HolderLimit := 10000;
	
	///////////////////////////////
	DetectedSquares := 7;
	DetectedScrew := 1;
	DetectedScrewWasher := 1;
	DetectedWrench := 1;
	//////////////////////////////
	 
END_PROGRAM

PROGRAM _CYCLIC
	//IMAGE ACQUISITION
	Camera_0.ImageAcq := Camera_0.diTrigger AND Camera_0.Ready;
	
	DetectedSquares := 0;
	DetectedScrew := 0;
	DetectedScrewWasher := 0;
	DetectedWrench := 0;
	
	FOR i := 0 TO 13 DO
		//SQUARES DETECTION 
		gSquareArray[Camera_0.ModelNumArray[i]-1] := Camera_0.PixelCntSquareArray[i] < PixelRange_0.HolderLimit;
		gIsPosGood[Camera_0.ModelNumArray[i]-1] := Camera_0.PixelCntSquareArray[i] < PixelRange_0.HolderLimit;
		IF Camera_0.PixelCntSquareArray[i] < PixelRange_0.HolderLimit THEN
			DetectedSquares := DetectedSquares + 1;
		END_IF
		
		IF Camera_0.PixelCntSquareArray[i] < 50 THEN
			//NOTHING
			gActPos[Camera_0.ModelNumArray[i]-1] := 0;
			gElementsArray[Camera_0.ModelNumArray[i]-1] := 0;
		ELSIF Camera_0.PixelCntSquareArray[i] < PixelRange_0.ScrewLimit THEN
			//SCREW
			gActPos[Camera_0.ModelNumArray[i]-1] := 1;
			gElementsArray[Camera_0.ModelNumArray[i]-1] := 1;
			DetectedScrew := DetectedScrew + 1;
		ELSIF Camera_0.PixelCntSquareArray[i] < PixelRange_0.WasherBoltLimit THEN
			//WASHER BOLT
			gActPos[Camera_0.ModelNumArray[i]-1] := 2;
			gElementsArray[Camera_0.ModelNumArray[i]-1] := 2;
			DetectedScrewWasher := DetectedScrewWasher + 1;
		ELSIF Camera_0.PixelCntSquareArray[i] < PixelRange_0.WrenchLimit THEN
			//WRENCH
			gActPos[Camera_0.ModelNumArray[i]-1] := 4;
			gElementsArray[Camera_0.ModelNumArray[i]-1] := 4;
			DetectedWrench := DetectedWrench + 1;
		ELSE
			gActPos[Camera_0.ModelNumArray[i]-1] := 0;
			gElementsArray[Camera_0.ModelNumArray[i]-1] := 0;
		END_IF;
	
	END_FOR;

END_PROGRAM

PROGRAM _EXIT

	 
END_PROGRAM

