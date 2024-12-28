#!/opt/local/bin/bash
 
walk()
{
	echo "Starting Directory Walk..."
	for FILE in $1
	do
		if [ -d "$FILE" ]; then
			echo "Checking directory :: "$FILE
			for DFILE in $FILE/*
			do
				if [ -d "$DFILE" ]; then
					echo "Found sub-directory :: "$DFILE
					walk "$DFILE"
					
				elif echo "$DFILE" | grep -i -q ".*\.png$"; then
					echo "Found PNG file :: "$DFILE
					magick "$DFILE" "${DFILE%.*}.jpg";
					echo "Conversion complete :: " $DFILE
					
					if [ -f "${DFILE%.*}.jpg" ]; then
						echo "Removing file :: " $DFILE
						rm "$DFILE"
					else
						echo "Failure to convert PNG file (no target found) :: " $DFILE
					fi
						
				else
					echo "Not a PNG file :: " $DFILE
				fi
			done
		fi
	done
	return 0
}

walk $1