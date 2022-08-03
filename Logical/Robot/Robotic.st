VAR {AT PLC} 
P2up : McPointType;
P2 : McPointType;
P1up : McPointType;
P1 : McPointType;
P0 : McPointType;
HOME : McPointType;
PZ : McPointType;
A : McAxisTargetType;
doMagnet : BOOL;
y : USINT;
MaxSpeed : DINT;
LowSpeed : DINT;

END_VAR

	PROGRAM _MAIN 
	
	Feedrate(MaxSpeed);    //move with reduced speed      

	IF y=0 THEN
		MoveA(A); //move HOME
	END_IF;

//	MoveJ(P0);   //move to lower HOME pose

	MoveL(P1up); //move over the aim 1 pose
	Feedrate(LowSpeed);

	MoveL(P1);  //move to aim 1
	
	DO_PATH_SYNCH
	doMagnet := TRUE;
	END_PATH_SYNCH
	
	WaitTime(1);        
	MoveL(P1up); //move over the aim 1 pose
	Feedrate(MaxSpeed);	
	MoveL(P2up); //move over the aim 2 pose
	Feedrate(LowSpeed);

	MoveL(P2);    //move to aim 2
	DO_PATH_SYNCH
	doMagnet := FALSE;
	END_PATH_SYNCH
	WaitTime(1);
	
	MoveL(P2up); //move over the aim 2 pose
	Feedrate(MaxSpeed);	

	//	MoveL(P0);   //move to lower HOME pose
	IF y=2 THEN
		MoveJ(HOME); //move to  HOME
	END_IF;

END_PROGRAM