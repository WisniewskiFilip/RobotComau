

ACTION Starting: 

	IF MpPackMLStateIsActive(gPackMLCore,
		mpPACKML_STATE_STARTING,
		1) THEN
		
		MpPackMLMode_Auto.Start := 0;
		
		PackML_State := 'STARTING';
		
		
		Camera_0.ImageAcq := 0;
		
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
				DetectedScrew := 0;
				DetectedScrewWasher := 0;
				DetectedWrench := 0;
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
				DetectedScrew := 0;
				DetectedScrewWasher := 0;
				DetectedWrench := 0;
			END_IF;
		
		END_FOR;
		
		CASE Step OF
			ROBOTCTRL_CHECK: 	//checking if aim targets are available
				
				AimIsGood:=TRUE;
				FOR x:=0  TO SizeOfArray DO
					IF gAimPos[x]>0 THEN
						IF (gIsPosGood[x]=FALSE) THEN 
							Step:=ROBOTCTRL_ERROR_WRONG_AIM; 
							Step_State := 'ERROR_WRONG_AIM';
							AimIsGood:=0; 
						END_IF;	
					END_IF;		
				END_FOR;
				IF AimIsGood=TRUE THEN
					y:=0;
					P1P2_Ok:=0;
					Step:=ROBOTCTRL_CALCULATE;
					Step_State := 'CALCULATE';
					Camera_0.diTrigger := 0;
					MpPackMLStateComplete(gPackMLCore, 1);
				END_IF;	
			
			ROBOTCTRL_ERROR_WRONG_AIM:
				//handling wrong target error 
				doVisError:=TRUE;
				IF diAck THEN
					doVisError:=FALSE;
					
					Step:=ROBOTCTRL_CHECK;
					Step_State := 'CHECK';
				END_IF;
			
		END_CASE;
		
	END_IF
END_ACTION
