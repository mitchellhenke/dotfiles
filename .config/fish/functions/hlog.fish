# Defined in - @ line 1
function hlog --description 'alias hlog=heroku logs -t -n 99999'
	heroku logs -t -n 99999 $argv;
end
