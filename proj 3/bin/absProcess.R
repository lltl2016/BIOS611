args = commandArgs(trailingOnly = TRUE)
a=readLines(args[1])
library(tidyverse)
## Cleaning data by adding a blank between two words
dat=str_replace_all(a[4],"([a-z])([A-Z])", "\\1 \\2")
dat=str_replace_all(dat, "([a-z])(of)", "\\1 \\2")
dat=str_replace_all(dat, "(of)([a-z])", "\\1 \\2")
dat = str_replace_all(dat,"'s","s")

##get every researcher's insititution information by (1) or ;
temp = str_split(dat,"\\([[:digit:]]\\)")
temp1 = unlist(temp)[-1]
temp2 = str_split(temp1,"[[:punct:]]")
institute = c()

## Add institution name
for (i in 1:length(temp1)){
  str=temp2[[i]][str_detect(temp2[[i]], "Research|University|College|Institution|Institute|Hospital|School|Center")]
  if(length(str)!=0){
    if (length(str) == 1){
      x = str_replace_all(str,"//d+","")
      institute = append(institute,trimws(x,"left"))
    } 
    else {
      if (any(grep("Research|University|College",str))){
        institute = append(institute,str[grep("Research|University|College",str)])
      }else if (any(grep("Institution|Institute|Hospital|School",str))){
        institute = append(institute,str[grep("Institution|Institute|Hospital|School",str)])
      }else{
        institute = append(institute,str[length(str)])
      }
    }   
  }
}

institute = trimws(institute,"left")
institute=Filter(function(x) !any(grepl("University of North Carolina", x)), institute)
institute=unique(institute)
d1=length(institute)


title = rep(str_replace_all(a[2],"\\d+",""),length(institute))
abs = rep(str_replace_all(a[5],"\\d+",""),length(institute))
b = as.data.frame(cbind(institute,title,abs),stringsAsFactors = FALSE)


write.csv(b,file = "out.csv")
