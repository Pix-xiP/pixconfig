# Get from FB-Stash

function aws-fb-get -d "Function for quickly pulling from fb-report-stash in AWS"
   command aws s3 cp s3://fb-report-stash/$argv ./
end
