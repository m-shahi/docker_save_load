$imageInfo = docker images --format "{{.Repository}};{{.Tag}}"
$imageObject = $imageInfo | ConvertFrom-Csv -Delimiter ";" -Header "Repository", "Tag"

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
	$repo = $RepoName + ':' + $image.Tag
	echo "Exporting $repositoryName ..."
	
	echo $repo
	docker save -o $fileName $repo
	echo "$repositoryName was exported successfully!`nfile name: $fileName"
	echo =======================
}

pause
