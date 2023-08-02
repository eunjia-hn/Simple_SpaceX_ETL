USE SpaceX;

/*
a. Which drone ship has received the most succesfful successive landings by falcon 9 booster?
List the landing drone ships in order from most successful successive landings to least.
*/

SELECT S.ShipID, S.ShipName, COUNT(L.LaunchID)
FROM tblLAUNCHES L
	JOIN tblROCKETS R ON L.RocketID = R.RocketID
    JOIN tblLAUNCH_SHIP LS ON L.LaunchID = LS.LaunchID
    JOIN tblSHIPS S ON LS.ShipID = S.ShipID
WHERE R.RocketName = 'Falcon 9'
AND L.Success = 'TRUE'
GROUP BY S.ShipID, S.ShipName
ORDER BY COUNT(L.LaunchID) DESC;


/*
b. Which payload nationality has been on the most launches? 
List nationalities and the count of launches that the nationality has been up on from most to least launches.
*/

SELECT tblPayLOADS.Nationality, COUNT(PayloadID)
FROM tblLAUNCHES 
JOIN tblPAYLOADS ON tblLAUNCHES.launchid = tblPayloads.launchid
WHERE tblLAUNCHES.Success = 'TRUE'
GROUP BY tblPAYLOADS.Nationality
ORDER BY COUNT(payloadid) DESC;




