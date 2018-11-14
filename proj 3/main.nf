params.in_files = 'data/*.txt'
params.out_dir = 'Result/'
params.out_file = 'output.csv'


in_images = Channel.fromPath( params.in_files )

process clean_Data {
    container 'rocker/tidyverse'
    
    input:
    file i from in_images

    output:
    file '*.csv' into out_csvs

    script:
    """
    Rscript $baseDir/bin/absProcess.R $i 
    """
}



process top10_csv{
   
      container 'rock/tidyverse'
  
      publishDir params.out_dir, mode: 'copy'  


    input:
    file  f from out_csvs.collectFile(name: 'institute.csv', newLine: true)
  
     
    output:
    file params.out_file into params.out_dir
    
       """
  
       Rscript $baseDir/bin/fileComb.R $f
	
  
     """

}



