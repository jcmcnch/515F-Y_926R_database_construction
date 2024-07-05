#!/bin/bash -i

#this script will extract the headers from the .fasta and create a table with feature/taxonomy

##download the file
wget https://github.com/pr2database/pr2database/releases/download/v5.0.0/pr2_version_5.0.0_SSU_dada2.fasta.gz
## unzip
gzip -d pr2_version5.0.0_SSU_dada2.fasta.gz


# Input file
input_file="pr2_version5.0.0_SSU_dada2.fasta"
# Output file
output_file="pr2_clean.fasta"
# File to save the extracted lines
extracted_file="pr2_headers.txt"

# Initialize a counter
counter=1

# Clear the output files if they already exist
> "$output_file"
> "$extracted_file"

# Read the input file line by line
while IFS= read -r line; do
  # Check if the line starts with '>'
  if [[ "$line" == \>* ]]; then
  	# Create the new header line with feature_counter
    new_header="feature_$counter"
    #remove > from original header when saving
    clean_line="${line#>}"
    # Save the original header line to extracted file
    echo -e "$new_header\t$clean_line" >> "$extracted_file"
    # Replace with the counter and save to output file
    echo ">feature_$counter" >> "$output_file"
    # Increment the counter
    ((counter++))
  else
    # Print the line as is to the output file
    echo "$line" >> "$output_file"
  fi
done < "$input_file"


echo "Processing complete. Check $output_file for the result and $extracted_file for the extracted headers."
