
ACTION Resetting:
	
	IF MpPackMLStateIsActive(gPackMLCore,
		mpPACKML_STATE_RESETTING,
		1) THEN
		MpPackMLMode_Auto.Reset := 0;
		MpPackMLMode_Auto.Stop := 0;
		PackML_State := 'RESETTING';
		gCompliteFlag:=FALSE;
		y := 0;
		NotFirstFlag:=FALSE;
		Camera_0.ImageAcq := Camera_0.Ready;
		
		IF NOT MpRoboArm6Axis_0.PowerOn THEN
			MpPackMLMode_Auto.Stop := 1;
		END_IF
		
		FOR x:=0 TO 5 DO 
			FOR y:=0 TO 17 DO 
				IF  RestorePos[x].Data[y]=0 THEN
				emptyPos:=emptyPos+1;	
				END_IF
			END_FOR;
		END_FOR;
		
		CASE Step OF
			ROBOTCTRL_POWER:
				
				IF MpRoboArm6Axis_0.Info.ReadyToPowerOn THEN
					MpRoboArm6Axis_0.Power := TRUE; 
					Step := ROBOTCTRL_WAIT_POWER; 
					Step_State := 'WAIT_POWER';
				END_IF; 
		
			ROBOTCTRL_WAIT_POWER: 
				IF MpRoboArm6Axis_0.PowerOn THEN
					Step := ROBOTCTRL_HOME; 
					Step_State := 'HOME';
				END_IF;
		
			ROBOTCTRL_HOME: 
				MpRoboArm6Axis_0.Home := TRUE; 
				Step := ROBOTCTRL_WAIT_HOME;
				Step_State := 'WAIT_HOME';
			
			ROBOTCTRL_WAIT_HOME: 
				IF MpRoboArm6Axis_0.IsHomed THEN
					MpRoboArm6Axis_0.Home := FALSE; 
					(*Step := ROBOTCTRL_READY;*)
					(*	Step_State := 'READY';*)
					MpPackMLStateComplete(gPackMLCore, 1);
					
				END_IF; 
			
		END_CASE;
		
	END_IF; 
END_ACTION
