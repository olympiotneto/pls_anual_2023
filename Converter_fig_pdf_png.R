# Converter figuras em PDF em png

library(pdftools)
directory<-"Relatorio_2023_files/figure-pdf"
paste(directory, "/",
      list.files(directory, pattern = "*.pdf"), sep = "") |>
  purrr::walk(
    \(files){
      pdf_converter(
        files,
        format = "png",
        dpi = 300,
        pages =NULL,
        filenames =)
    }
  )
