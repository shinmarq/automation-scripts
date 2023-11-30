package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"strings"
)

func main() {
	// Open the input CSV file for reading
	inputFile, err := os.Open("input.csv")
	if err != nil {
		fmt.Println("Error opening input file:", err)
		return
	}
	defer inputFile.Close()

	// Read the CSV data
	reader := csv.NewReader(inputFile)
	records, err := reader.ReadAll()
	if err != nil {
		fmt.Println("Error reading CSV:", err)
		return
	}

	// Define the character to eliminate
	// Remove asterisk
	charToRemove := "*"

	// Iterate through the CSV data and eliminate the character
	for i, row := range records {
		for j, cell := range row {
			// Remove the character from the cell
			cleanedCell := strings.Replace(cell, charToRemove, "", -1)
			records[i][j] = cleanedCell
		}
	}

	// Create a new CSV file for writing the modified data
	outputFile, err := os.Create("output.csv")
	if err != nil {
		fmt.Println("Error creating output file:", err)
		return
	}
	defer outputFile.Close()

	// Write the modified data to the new CSV file
	writer := csv.NewWriter(outputFile)
	defer writer.Flush()

	for _, row := range records {
		err := writer.Write(row)
		if err != nil {
			fmt.Println("Error writing CSV:", err)
			return
		}
	}

	fmt.Println("Character removed and saved to output.csv")
}
