$files=$(git diff HEAD~ HEAD --name-only)
$temp=$files -split ' '
echo $temp
$count=$temp.Length
echo "Total changed $count files"
For ($i=0; $i -lt $temp.Length; $i++)
{
  $name=$temp[$i]
  echo "this is $name file"
  $outputPath = "$name"
  $outputFile = Split-Path $outputPath -leaf
  echo "this is the $outputFile"
  $body = '
    { 
          "parameters":  "{\"filename\":  \"'+$outputFile+'\"}",
          "definition": {
          "id": 581
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
          $result = $responseFromGet.result
          Write-Host "Status: " + $status  
          Write-Host "result" + $result
              if ($result -eq "succeeded") 
			    {
				echo "Swagger-spec validation for $outputFile succeeded, now proceeding to Import into Swaggerhub"
                $body = '
                   { 
                          "parameters":  "{\"filename\":  \"'+$outputFile+'\"}",
                          "definition": {
                          "id": 582
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
						   echo "Import into Swaggerhub for $outputFile succeeded, now proceeding to Get Proxyname"
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
                                    $body = '
                                        { 
                                        "parameters":  "{\"filename\":  \"'+$outputFile+'\"}",
                                        "definition": {
                                        "id": 584
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
                                            }
         
                                    }
									else { echo "Convert to proxy failed" }
                                 }
         
                            }
                            else { echo " Get proxyname failed" }							
                        }
         
                }
                else { echo "Import into swaggerhub failed"}				
          }  
}