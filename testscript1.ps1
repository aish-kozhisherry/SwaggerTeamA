$files=$(git diff HEAD~ HEAD --name-status)
$temp=$files -split [System.Environment]::NewLine
echo $temp
$count=$temp.Length
echo "Total changed $count files"
For ($i=0; $i -lt $temp.Length; $i++)
{
  $name=$temp[$i]
  echo "this is the $i th file :$name"
  $output=$name.Split("`t")
  echo $output[0]
  echo $output[1]
  echo $output[2]
  $outputFile="temp"
  if ($output[0] -eq "D")
  {
    echo "A file was deleted and it will not pass through the pipeline. Filename: $output[1]"  
  }
  elseif (($output[0] -eq "R100") -or ($output[0] -eq "R099") )
  {
  $outputFileinside = Split-Path $output[2] -leaf
  $outputFile=$outputFileinside
  echo "this is the $outputFile"  
  }
  elseif (($output[0] -eq "A") -or ($output[0] -eq "M") )
  {
  $outputFileinside = Split-Path $output[1] -leaf
  $outputFile=$outputFileinside
  echo "this is the $outputFile"  
  }
  echo $outputFile
  if ($outputFile -eq "temp")
  {
  echo "File deleted. No action"
  echo $outputFile
  }
  else
  {
  echo $outputFile
  echo "this is not a delete"
  $body1 = '
    { 
          "parameters":  "{\"filename\":  \"'+$outputFile+'\"}",
          "definition": {
          "id": 581
           } 
    }
    '
	$bodyJson1=$body1 | ConvertFrom-Json
     Write-Output $bodyJson1
     $bodyString1=$bodyJson1 | ConvertTo-Json -Depth 100
     Write-Output $bodyString1
	 $body2 = '
    { 
          "parameters":  "{\"filename\":  \"'+$outputFile+'\"}",
          "definition": {
          "id": 582
           } 
    }
    '
     $bodyJson2=$body2 | ConvertFrom-Json
     Write-Output $bodyJson2
     $bodyString2=$bodyJson2 | ConvertTo-Json -Depth 100
     Write-Output $bodyString2
     $user="Aishwarya.Kozhisherry@realogy.com"
     $token="cy5rib7nmobljcdnsld3rdrete27i4m4lk2f4lepo3kti3ev25ja"
     $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))
     $Uri = "https://realogy.visualstudio.com/APIM.CRP/_apis/build/builds?api-version=5.0"
     $buildresponse1 = Invoke-RestMethod -Method Post -UseDefaultCredentials -ContentType application/json -Uri $Uri -Body $bodyString1 -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}
     Write-host $buildresponse1
     $buildId1 = $buildresponse1.id
     Write-host $buildId1
	 $buildresponse2 = Invoke-RestMethod -Method Post -UseDefaultCredentials -ContentType application/json -Uri $Uri -Body $bodyString2 -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}
     Write-host $buildresponse2
     $buildId2 = $buildresponse2.id
     Write-host $buildId2
     $Urinew = "https://realogy.visualstudio.com/APIM.CRP/_apis/build/builds/"
     $Uri11 = $Urinew+$buildId1+"?api-version=5.0"
     $responseFromGet1 = Invoke-RestMethod -Method Get -ContentType application/json -Uri $Uri11 -Headers @{Authorization=("Basic {0}" -f $base64authinfo)}
     Write-host $responseFromGet1
     $status1 = $responseFromGet1.status
     Write-host $status1
     while($status1 -ne "completed")
	      {
          Start-Sleep -Seconds 5
          $responseFromGet = Invoke-RestMethod -Method Get -ContentType application/json -Uri $Uri11 -Headers @{Authorization=("Basic {0}" -f $base64authinfo)}
          $status1 = $responseFromGet.status
          $result = $responseFromGet.result
          Write-Host "Status: " + $status1  
          Write-Host "result" + $result
		  if ($result -eq "succeeded")
		  {
			echo "Swagger-spec validation for $outputFile succeeded proceeding to Get Proxyname pipeline"
			$body = '
            { 
            "parameters":  "{\"filename\":  \"'+$outputFile+'\"}",
            "definition": {
            "id": 583
                          } 
            }
            '
            $bodyJson=$body | ConvertFrom-Json
            Write-Output $bodyJson
            $bodyString=$bodyJson | ConvertTo-Json -Depth 100
            Write-Output $bodyString
            $user="Aishwarya.Kozhisherry@realogy.com"
            $token="cy5rib7nmobljcdnsld3rdrete27i4m4lk2f4lepo3kti3ev25ja"
            $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))
            $Uri = "https://realogy.visualstudio.com/APIM.CRP/_apis/build/builds?api-version=5.0"
            $buildresponse = Invoke-RestMethod -Method Post -UseDefaultCredentials -ContentType application/json -Uri $Uri -Body $bodyString -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}
            Write-host $buildresponse
            $buildId = $buildresponse.id
            Write-host $buildId
            $Urinew = "https://realogy.visualstudio.com/APIM.CRP/_apis/build/builds/"
            $Uri2 = $Urinew+$buildId+"?api-version=5.0"
            $responseFromGet = Invoke-RestMethod -Method Get -ContentType application/json -Uri $Uri2 -Headers @{Authorization=("Basic {0}" -f $base64authinfo)}
            Write-host $responseFromGet
            $status = $responseFromGet.status
            Write-host $status
            while($status -ne "completed")
			{
              Start-Sleep -Seconds 5
              $responseFromGet = Invoke-RestMethod -Method Get -ContentType application/json -Uri $Uri2 -Headers @{Authorization=("Basic {0}" -f $base64authinfo)}
              $status = $responseFromGet.status
              $result= $responseFromGet.result
              Write-Host "Status: " + $status  
              Write-Host "result" + $result
			  if ($result -eq "succeeded") 
			  {
				  echo "Get Proxyname for $outputFile succeeded, now proceeding to Convert into Proxy"
			  }
			  elseif ($result -eq "failed")  { echo "Get proxyname failed" }
			  else { echo "Get Proxyname pipeline for $outputFile is In progress" }
            }
		   }			
		  elseif ($result -eq "failed")  { echo "Swagger-spec validation for $outputFile failed" }
		  else { echo "Swagger-spec validation for $outputFile is In progress" }
		   }
	 $Urinew = "https://realogy.visualstudio.com/APIM.CRP/_apis/build/builds/"
     $Uri22 = $Urinew+$buildId2+"?api-version=5.0"
     $responseFromGet2 = Invoke-RestMethod -Method Get -ContentType application/json -Uri $Uri22 -Headers @{Authorization=("Basic {0}" -f $base64authinfo)}
     Write-host $responseFromGet2
     $status2 = $responseFromGet2.status
     Write-host $status2
     while($status2 -ne "completed")
     {
          Start-Sleep -Seconds 5
          $responseFromGet = Invoke-RestMethod -Method Get -ContentType application/json -Uri $Uri11 -Headers @{Authorization=("Basic {0}" -f $base64authinfo)}
          $status = $responseFromGet.status
          $result = $responseFromGet.result
          Write-Host "Status: " + $status  
          Write-Host "result" + $result
		  if ($result -eq "succeeded")
		  {
					echo "Import to Swaggerhub for $outputFile succeeded in parallel"
          }	
          elseif ($result -eq "failed") {echo "Import to Swaggerhub for $outputFile failed"}
		  else {echo "Import to Swaggerhub for $outputFile is In progress"}
      }		  
  }
}