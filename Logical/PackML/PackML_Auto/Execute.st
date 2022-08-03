//   General conception of this code
//  assainging binary values to each object 
//	screw      -001 - 1
//  screw pad  -010 - 2
//  wrench     -100 - 4
//  therefore we can assing to gAimPose table values from 0-7 ( sum must equal 7) in order to
//  easly differentiate what kind of object we need to move into aim pose.
//  for example if we see 6 -> 110 we know that we have to move screw pad and wrench to this pose
//	
//  order of moves is defined by order of numbers in Index 






ACTION Execute: 
	IF MpPackMLStateIsActive(gPackMLCore,
		mpPACKML_STATE_EXECUTE,
		1) THEN

		PackML_State := 'EXECUTE';

		
		CASE Step OF
			ROBOTCTRL_CALCULATE:	
				//blocks which can be used as buffor
				FOR x:=0 TO SizeOfArray DO 
					IF  gActPos[x]=0 AND gIsPosGood=TRUE THEN
						gPosBuffor[x]:=TRUE;
					END_IF;
				END_FOR;
				
				IF gSwapFlag THEN
					Step:=ROBOTCTRL_SWAP;
				ELSIF P1P2_Ok THEN
					Step:=ROBOTCTRL_IS_MOVE_NEEDED;
				ELSIF y<IndexSize THEN
					Step:=ROBOTCTRL_CALCULATE_P1;
				ELSE 
					diStart:=FALSE;
					RoboParameters.ProgramName := 'HOME.st';
					MpRoboArm6Axis_0.MoveProgram:=1;
					IF MpRoboArm6Axis_0.MoveDone THEN
						MpRoboArm6Axis_0.MoveProgram:=FALSE;
						MpPackMLStateComplete(gPackMLCore, 1);
					END_IF
					
				END_IF;
				
				
			ROBOTCTRL_CALCULATE_P1:	
				//assigning values to P1 and P1up
				FOR x:=0  TO SizeOfArray DO
					IF gActPos[x]=Index[y] THEN
						P1.Orient.Angle1:=gRobPos[x].Orient.Angle1;
						P1.Orient.Angle2:=gRobPos[x].Orient.Angle2;
						P1.Orient.Angle3:=gRobPos[x].Orient.Angle3;
						P1.Pos.X:=gRobPos[x].Pos.X;
						P1.Pos.Y:=gRobPos[x].Pos.Y;
						P1.Pos.Z:=gRobPos[x].Pos.Z;
						P1up.Orient.Angle1:=gRobPos[x].Orient.Angle1;
						P1up.Orient.Angle2:=gRobPos[x].Orient.Angle2;
						P1up.Orient.Angle3:=gRobPos[x].Orient.Angle3;
						P1up.Pos.X:=gRobPos[x].Pos.X;
						P1up.Pos.Y:=gRobPos[x].Pos.Y;
						P1up.Pos.Z:=gRobPos[x].Pos.Z+50;
					END_IF;	
				END_FOR;
				Step:=ROBOTCTRL_CALCULATE_P2;
				Step_State := 'CALCULATE_P2';
				
			ROBOTCTRL_CALCULATE_P2:	
				FOR x:=0 TO SizeOfArray DO
					//copig values 
					gAimPos1[x]:=gAimPos[x];
				END_FOR;
				FOR x:=0 TO SizeOfArray DO
					//reseting maps 
					Aim1[x]:=FALSE;
					Aim2[x]:=FALSE;
					Aim4[x]:=FALSE;
				END_FOR;
				//Creating maps conteining positions of each element 
				//by substracting corresponding value of element 
				//AND checing IF its greater OR equal TO zero
				FOR z:=0 TO IndexSize DO
					IF Index[z]=4 THEN
						FOR x:=0 TO SizeOfArray DO
							IF((gAimPos1[x]-4)>=0) THEN
								gAimPos1[x]:=gAimPos1[x]-4;
								Aim4[x]:=TRUE;
							END_IF;
						END_FOR;
					END_IF;	
				END_FOR;
				
				FOR z:=0 TO IndexSize DO
					IF Index[z]=2 THEN
						FOR x:=0 TO SizeOfArray DO
							IF((gAimPos1[x]-2)>=0) THEN
								gAimPos1[x]:=gAimPos1[x]-2;
								Aim2[x]:=TRUE;
							END_IF;
						END_FOR;
					END_IF;	
				END_FOR;	
				
				FOR z:=0 TO IndexSize DO
					IF Index[z]=1 THEN
						FOR x:=0 TO SizeOfArray DO
							IF((gAimPos1[x]-1)>=0) THEN
								gAimPos1[x]:=gAimPos1[x]-1;
									Aim1[x]:=TRUE;
								END_IF;
							END_FOR;
						END_IF;		
					END_FOR;
				
				
					//assigning values to P2 and P2up
				IF Index[y]=4 THEN
					//moving in order defined in Index
						FOR x:=0  TO SizeOfArray DO
							IF Aim4[x]=TRUE THEN
								P2.Orient.Angle1:=gRobPos[x].Orient.Angle1;
								P2.Orient.Angle2:=gRobPos[x].Orient.Angle2;
								P2.Orient.Angle3:=gRobPos[x].Orient.Angle3;
								P2.Pos.X:=gRobPos[x].Pos.X;
								P2.Pos.Y:=gRobPos[x].Pos.Y;
								P2.Pos.Z:=gRobPos[x].Pos.Z;
								P2up.Orient.Angle1:=gRobPos[x].Orient.Angle1;
								P2up.Orient.Angle2:=gRobPos[x].Orient.Angle2;
								P2up.Orient.Angle3:=gRobPos[x].Orient.Angle3;
								P2up.Pos.X:=gRobPos[x].Pos.X;
								P2up.Pos.Y:=gRobPos[x].Pos.Y;
								P2up.Pos.Z:=gRobPos[x].Pos.Z+50;
								END_IF;
							END_FOR;
						ELSIF Index[y]=2 THEN
						FOR x:=0  TO SizeOfArray DO
							IF Aim2[x]=TRUE THEN	
								P2.Orient.Angle1:=gRobPos[x].Orient.Angle1;
								P2.Orient.Angle2:=gRobPos[x].Orient.Angle2;
								P2.Orient.Angle3:=gRobPos[x].Orient.Angle3;
								P2.Pos.X:=gRobPos[x].Pos.X;
								P2.Pos.Y:=gRobPos[x].Pos.Y;
								P2.Pos.Z:=gRobPos[x].Pos.Z;
								P2up.Orient.Angle1:=gRobPos[x].Orient.Angle1;
								P2up.Orient.Angle2:=gRobPos[x].Orient.Angle2;
								P2up.Orient.Angle3:=gRobPos[x].Orient.Angle3;
								P2up.Pos.X:=gRobPos[x].Pos.X;
								P2up.Pos.Y:=gRobPos[x].Pos.Y;
								P2up.Pos.Z:=gRobPos[x].Pos.Z+50;
							END_IF;
						END_FOR;			
					ELSIF Index[y]=1 THEN
						FOR x:=0  TO SizeOfArray DO
							IF Aim1[x]=TRUE THEN	
								P2.Orient.Angle1:=gRobPos[x].Orient.Angle1;
								P2.Orient.Angle2:=gRobPos[x].Orient.Angle2;
								P2.Orient.Angle3:=gRobPos[x].Orient.Angle3;
								P2.Pos.X:=gRobPos[x].Pos.X;
								P2.Pos.Y:=gRobPos[x].Pos.Y;
								P2.Pos.Z:=gRobPos[x].Pos.Z;
								P2up.Orient.Angle1:=gRobPos[x].Orient.Angle1;
								P2up.Orient.Angle2:=gRobPos[x].Orient.Angle2;
								P2up.Orient.Angle3:=gRobPos[x].Orient.Angle3;
								P2up.Pos.X:=gRobPos[x].Pos.X;
								P2up.Pos.Y:=gRobPos[x].Pos.Y;
								P2up.Pos.Z:=gRobPos[x].Pos.Z+50;
							END_IF;
						END_FOR;			
					END_IF;				
					P1P2_Ok:=1; // this flag means that new P1 and new P2 have been assigned  
					Step:=ROBOTCTRL_CALCULATE;

			ROBOTCTRL_IS_MOVE_NEEDED:
				//checking if actual and aim positions are not the same 
				IF P1.Orient.Angle1=P2.Orient.Angle1 AND P1.Pos.X=P2.Pos.X AND P1.Orient.Angle2=P2.Orient.Angle2 AND P1.Pos.Y=P2.Pos.Y AND P1.Orient.Angle3=P2.Orient.Angle3 AND P1.Pos.Z=P2.Pos.Z THEN
					y:=y+1; // index of next object 
					P1P2_Ok:=0; // ready to assign new values to p1 p1up p2 p2up
					Step:=ROBOTCTRL_CALCULATE; // next assigning procedure with new object 
					Step_State := 'CALCULATE';
				ELSE
					Step_State := 'MOVE';
					Step:=ROBOTCTRL_MOVE;   // going to move command 
				END_IF;

			ROBOTCTRL_MOVE:
				IF cmdInterrupt OR MpRoboArm6Axis_0.MoveInterrupted THEN 
					cmdInterrupt := FALSE; 
					Step:=ROBOTCTRL_INTERRUPT;
					Step_State := 'INTERRUPT';
					MpPackMLMode_Auto.Hold := 1;
				END_IF; 


				//executing move procedure
				MpRoboArm6Axis_0.MoveProgram:=1;
				IF MpRoboArm6Axis_0.MoveDone THEN
					//restarting assigning procedure with new object after finishing move 
					MpRoboArm6Axis_0.MoveProgram:=0;
					y:=y+1;
					P1P2_Ok:=0;
					Step:=ROBOTCTRL_CALCULATE;
					Step_State := 'CALCULATE';
					
				END_IF 
				
			ROBOTCTRL_SWAP:	
				//todo
				gSwapFlag:=FALSE;
				HelpfulInt:=0;
				FOR x:=0 TO SizeOfArray DO 
					IF gSwapMap[x] THEN
						gSwapPoses[HelpfulInt].Orient.Angle1:=gRobPos[x].Orient.Angle1;
						gSwapPoses[HelpfulInt].Orient.Angle2:=gRobPos[x].Orient.Angle2;
						gSwapPoses[HelpfulInt].Orient.Angle3:=gRobPos[x].Orient.Angle3;
						gSwapPoses[HelpfulInt].Pos.X:=gRobPos[x].Pos.X;
						gSwapPoses[HelpfulInt].Pos.Y:=gRobPos[x].Pos.Y;
						gSwapPoses[HelpfulInt].Pos.Z:=gRobPos[x].Pos.Z;
						HelpfulInt:=HelpfulInt + 1;
					END_IF
				END_FOR;
				//gSwapMap should only have 2 values equal to TRUE therefore HelpfulInt should equal to 2
				//but just in case it is better to assign 2 to HelpfulInt
				HelpfulInt:=2;
				
				FOR x:=0 TO SizeOfArray DO 
					IF gPosBuffor[x] THEN
						gSwapPoses[HelpfulInt].Orient.Angle1:=gRobPos[x].Orient.Angle1;
						gSwapPoses[HelpfulInt].Orient.Angle2:=gRobPos[x].Orient.Angle2;
						gSwapPoses[HelpfulInt].Orient.Angle3:=gRobPos[x].Orient.Angle3;
						gSwapPoses[HelpfulInt].Pos.X:=gRobPos[x].Pos.X;
						gSwapPoses[HelpfulInt].Pos.Y:=gRobPos[x].Pos.Y;
						gSwapPoses[HelpfulInt].Pos.Z:=gRobPos[x].Pos.Z;
					END_IF
				END_FOR;
				
				FOR x:=0 TO SizeOfArray DO 
					gSwapMap[x]:=FALSE;
				END_FOR;
				
				
				
				
				Step:=ROBOTCTRL_SWAP_MOVE;
				
				
			ROBOTCTRL_SWAP_MOVE:
				//first move 
				///////////////////////P1
				P1.Orient.Angle1:=gSwapPoses[0].Orient.Angle1;
				P1.Orient.Angle2:=gSwapPoses[0].Orient.Angle2;
				P1.Orient.Angle3:=gSwapPoses[0].Orient.Angle3;
				P1.Pos.X:=gSwapPoses[0].Pos.X;
				P1.Pos.Y:=gSwapPoses[0].Pos.Y;
				P1.Pos.Z:=gSwapPoses[0].Pos.Z;
				P1up.Orient.Angle1:=gSwapPoses[0].Orient.Angle1;
				P1up.Orient.Angle2:=gSwapPoses[0].Orient.Angle2;
				P1up.Orient.Angle3:=gSwapPoses[0]].Orient.Angle3;
				P1up.Pos.X:=gSwapPoses[0].Pos.X;
				P1up.Pos.Y:=gSwapPoses[0].Pos.Y;
				P1up.Pos.Z:=gSwapPoses[0].Pos.Z+50;
				///////////////////////P2
				P2.Orient.Angle1:=gSwapPoses[2].Orient.Angle1;
				P2.Orient.Angle2:=gSwapPoses[2].Orient.Angle2;
				P2.Orient.Angle3:=gSwapPoses[2].Orient.Angle3;
				P2.Pos.X:=gSwapPoses[2].Pos.X;
				P2.Pos.Y:=gSwapPoses[2].Pos.Y;
				P2.Pos.Z:=gSwapPoses[2].Pos.Z;
				P2up.Orient.Angle1:=gSwapPoses[2].Orient.Angle1;
				P2up.Orient.Angle2:=gSwapPoses[2].Orient.Angle2;
				P2up.Orient.Angle3:=gSwapPoses[2].Orient.Angle3;
				P2up.Pos.X:=gSwapPoses[2].Pos.X;
				P2up.Pos.Y:=gSwapPoses[2].Pos.Y;
				P2up.Pos.Z:=gSwapPoses[2].Pos.Z+50;
				//////////////////////// command execute
				MpRoboArm6Axis_0.MoveProgram:=1;
				IF MpRoboArm6Axis_0.MoveDone THEN
					//second move 
					MpRoboArm6Axis_0.MoveProgram:=0;
					///////////////////////P1
					P1.Orient.Angle1:=gSwapPoses[0].Orient.Angle1;
					P1.Orient.Angle2:=gSwapPoses[0].Orient.Angle2;
					P1.Orient.Angle3:=gSwapPoses[0].Orient.Angle3;
					P1.Pos.X:=gSwapPoses[0].Pos.X;
					P1.Pos.Y:=gSwapPoses[0].Pos.Y;
					P1.Pos.Z:=gSwapPoses[0].Pos.Z;
					P1up.Orient.Angle1:=gSwapPoses[0].Orient.Angle1;
					P1up.Orient.Angle2:=gSwapPoses[0].Orient.Angle2;
					P1up.Orient.Angle3:=gSwapPoses[0].Orient.Angle3;
					P1up.Pos.X:=gSwapPoses[0].Pos.X;
					P1up.Pos.Y:=gSwapPoses[0].Pos.Y;
					P1up.Pos.Z:=gSwapPoses[0].Pos.Z+50;
					///////////////////////P2
					P2.Orient.Angle1:=gSwapPoses[1].Orient.Angle1;
					P2.Orient.Angle2:=gSwapPoses[1].Orient.Angle2;
					P2.Orient.Angle3:=gSwapPoses[1].Orient.Angle3;
					P2.Pos.X:=gSwapPoses[1].Pos.X;
					P2.Pos.Y:=gSwapPoses[1].Pos.Y;
					P2.Pos.Z:=gSwapPoses[1].Pos.Z;
					P2up.Orient.Angle1:=gSwapPoses[1].Orient.Angle1;
					P2up.Orient.Angle2:=gSwapPoses[1].Orient.Angle2;
					P2up.Orient.Angle3:=gSwapPoses[1].Orient.Angle3;
					P2up.Pos.X:=gSwapPoses[1].Pos.X;
					P2up.Pos.Y:=gSwapPoses[1].Pos.Y;
					P2up.Pos.Z:=gSwapPoses[1].Pos.Z+50;
					//////////////////////// command execute
					MpRoboArm6Axis_0.MoveProgram:=1;
					IF MpRoboArm6Axis_0.MoveDone THEN
						//third move
						MpRoboArm6Axis_0.MoveProgram:=0;
						///////////////////////P1
						P1.Orient.Angle1:=gSwapPoses[2].Orient.Angle1;
						P1.Orient.Angle2:=gSwapPoses[2].Orient.Angle2;
						P1.Orient.Angle3:=gSwapPoses[2].Orient.Angle3;
						P1.Pos.X:=gSwapPoses[2].Pos.X;
						P1.Pos.Y:=gSwapPoses[2].Pos.Y;
						P1.Pos.Z:=gSwapPoses[2].Pos.Z;
						P1up.Orient.Angle1:=gSwapPoses[2].Orient.Angle1;
						P1up.Orient.Angle2:=gSwapPoses[2].Orient.Angle2;
						P1up.Orient.Angle3:=gSwapPoses[2].Orient.Angle3;
						P1up.Pos.X:=gSwapPoses[2].Pos.X;
						P1up.Pos.Y:=gSwapPoses[2].Pos.Y;
						P1up.Pos.Z:=gSwapPoses[2].Pos.Z+50;
						///////////////////////P2
						P2.Orient.Angle1:=gSwapPoses[0].Orient.Angle1;
						P2.Orient.Angle2:=gSwapPoses[0].Orient.Angle2;
						P2.Orient.Angle3:=gSwapPoses[0].Orient.Angle3;
						P2.Pos.X:=gSwapPoses[0].Pos.X;
						P2.Pos.Y:=gSwapPoses[0].Pos.Y;
						P2.Pos.Z:=gSwapPoses[0].Pos.Z;
						P2up.Orient.Angle1:=gSwapPoses[0].Orient.Angle1;
						P2up.Orient.Angle2:=gSwapPoses[0].Orient.Angle2;
						P2up.Orient.Angle3:=gSwapPoses[0].Orient.Angle3;
						P2up.Pos.X:=gSwapPoses[0].Pos.X;
						P2up.Pos.Y:=gSwapPoses[0].Pos.Y;
						P2up.Pos.Z:=gSwapPoses[0].Pos.Z+50;
						//////////////////////// command execute
						MpRoboArm6Axis_0.MoveProgram:=1;
					END_IF 
				END_IF 
		END_CASE;
		
	END_IF

END_ACTION
