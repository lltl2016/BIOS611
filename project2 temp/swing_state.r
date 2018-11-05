is_swing_state <- function(stateId){
  for (i in 1:nrow(summerization_sup_rate)){
    if (summerization_sup_rate[i,1] == stateId){
      if(abs(summerization_sup_rate$sup_D[i]-summerization_sup_rate$sup_R[i]) < 4){
        return(TRUE)
      }
      
    }
  }
  return(FALSE)

}