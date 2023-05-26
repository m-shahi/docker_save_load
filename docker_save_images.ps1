$imageInfo = docker images --format "{{.Repository}};{{.Tag}};{{.ID}}"
$imageObject = $imageInfo | ConvertFrom-Csv -Delimiter ";" -Header "Repository", "Tag", "ID"

foreach ($image in $imageObject) {	
    
	$RepoName = $image.Repository
	if ($RepoName -like '*/*') {
		# Get the second part of the repository name if it exists
	    $repositoryName = $RepoName.split('/')[1]
	} else {
		# Else, use the full image name as the repository name
		$repositoryName = $RepoName
	}

	
	$fileName = $repositoryName + '_' + $image.Tag + '.tar'
	echo "Exporting $repositoryName ..."
	docker save -o $fileName $image.ID
	echo "$repositoryName was exported successfully!`nfile name: $fileName"
	echo =======================
}

pause
