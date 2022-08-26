
ACTION Idle: 
	
	IF MpPackMLStateIsActive(gPackMLCore,
		mpPACKML_STATE_IDLE,
		1) THEN
		
		MpPackMLMode_Auto.Reset := 0;
		
		PackML_State := 'IDLE';

		
		//		CASE Step OF
		//			ROBOTCTRL_READY: 
		MpRoboArm6Axis_0.MoveProgram := 0;
		

		FOR x:=0 TO SizeOfArray DO 
			IF  gActPos[x]=0 THEN
				gSwapEnable[x]:=FALSE;
			ELSE 
				gSwapEnable[x]:=TRUE;
			END_IF;
		END_FOR;
		
		
		IF NOT(MpRoboArm6Axis_0.PowerOn) THEN
			//					Step := ROBOTCTRL_DISABLED;
			//					Step_State := 'DISABLED';
			MpPackMLMode_Auto.Stop := TRUE;
		END_IF;
			 
		IF diStart  THEN // diStart is active robot starts procedure 
			diStart := FALSE;
			MpPackMLMode_Auto.Start := TRUE;
			Step := ROBOTCTRL_CHECK;
			Step_State := 'CHECK';
		END_IF;
					
			
			
		//		END_CASE;
			
	END_IF

END_ACTION
