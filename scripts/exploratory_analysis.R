## instalar os pacotes necessários
# pckgs <-  c(
#   "tidyverse","DataExplorer",
#   "skimr","explore","devtools","remotes",
#   "correlationfunnel","janitor")
# install.packags("pckgs")
# remotes::install_github("rfsaldanha/microdatasus")
# devtools::install_github("agstn/dataxray")


## carregar os pacotes
library(tidyverse) # ferramentas para análise de dados
library(janitor) # ferramentas para limpeza de dados
library(skimr) # análise de qualidade de dados 
library(dataxray) # exploração de dados automática
library(explore) # exploração de dados automática
library(DataExplorer) # exploração de dados automática
library(correlationfunnel) # análise de correlação
library(ggcorrplot) # análise de correlação

### carregar os dados
dados <- readRDS(here::here("data","cleaned.RDS")) 
## primeiro resumo dos dados com glimpse 
dados %>% glimpse()
dados %>% head()
## avaliar qualidade dos dados com skimr
skim(dados)

## EDA automática com DataExplorer
set.seed(50)
dados %>% 
  select(3:25) %>% 
create_report(., y = "B3SA3.SA")

## EDA automática com xray
dados %>% 
  make_xray() %>% 
  view_xray()
## EDA automática com 
dados %>% explore() 

## análise de correlação
dados %>% 
  select(-1) %>% 
  cor() %>% 
  ggcorrplot(
    type = "lower",
    insig = "blank",
 #   lab = TRUE,
    digits = 3
  )

## correlation funnel
dados %>% 
  select(-1) %>% 
  binarize(n_bins = 2) %>% 
  glimpse()


dados %>% 
  select(-1) %>% 
  binarize(n_bins = 2) %>% 
  correlate(target = B3SA3.SA__0_Inf) %>% 
  plot_correlation_funnel(interactive = TRUE)
