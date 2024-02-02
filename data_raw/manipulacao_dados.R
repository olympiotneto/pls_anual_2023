library(tidyverse)

data <-read_delim("data_raw/dados_res400_SP_30012024.csv",
                                delim = ";", escape_double = FALSE, locale = locale(decimal_mark = ",",
                                                                                    grouping_mark = ".", encoding = "ISO-8859-1"),
                                trim_ws = TRUE)
#Tratamento dos dados

d <- data |>
  filter(periodicidade == "Mensal") |>
  dplyr::select(ano, mes, acap:vd) |>
  mutate(mes = case_when(
    mes == 1 ~"Jan",
    mes == 2 ~"Fev",
    mes == 3 ~"Mar",
    mes == 4 ~"Abr",
    mes == 5 ~"Mai",
    mes == 6 ~"Jun",
    mes == 7 ~"Jul",
    mes == 8 ~"Ago",
    mes == 9 ~"Set",
    mes == 10 ~"Out",
    mes == 11 ~"Nov",
    mes == 12 ~"Dez"
  )
  ) |>
  mutate(mes = fct(mes,levels = c("Jan", "Fev", "Mar", "Abr", "Mai","Jun"
                                  ,"Jul","Ago","Set","Out","Nov","Dez")),
         ano = fct(as.character(ano),levels = c("2021","2022","2023")),
         mes_ano = fct(paste(mes, ano, sep = "/"))) |>
  relocate(mes_ano,.after = mes)


# #Põe a variável mes_ano em ordem
#
# d$mes_ano <- factor(d$mes_ano,levels=paste(d$mes, d$ano, sep = "/"),
#                       ordered = TRUE)

write_rds(d,"data/dado_mensal.RDS")


#Dados anuais

d_anual <- data |>
  filter(periodicidade == "Anual") |>
  select(ano, acap:vd) |>
  mutate(ano = fct(as.character(ano),
                         levels = c("2021","2022","2023")) )

write_rds(d_anual,"data/dado_anual.RDS")


