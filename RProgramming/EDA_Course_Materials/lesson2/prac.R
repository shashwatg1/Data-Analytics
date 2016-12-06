stateInfo <- read.csv("stateData.csv"); #Reads the entire csv file

stateSubset <- subset(stateInfo, state.region == 1) #to extract particular entries satisfying the conditions entered

stateSubsetBracket <- stateInfo[stateInfo$state.region == 1,] #same result as subset
