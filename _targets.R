# see great demo/tutorial here with palmerpenguins data:
# https://carpentries-incubator.github.io/targets-workshop/index.html
# https://github.com/joelnitta/penguins-targets/blob/main/_targets.R

# Load Packages and Functions ---------------------------------------------

source("R/packages.R")

# gage pipeline -----------------------------------------------------------

tar_plan(
  # get raw gage site list (takes a min!)
  ca_Q_sites = dataRetrieval::whatNWISdata(stateCd="CA", parameterCd = "00060"),
  # get counties in CA
  ca_counties = tigris::counties(state = "CA"),

  # make gage data spatial to join with counties
  ca_Q_sites_sf = ca_Q_sites |>
    filter(!is.na(dec_lat_va)) |>
    st_as_sf(coords=c("dec_long_va","dec_lat_va"), remove=FALSE, crs=4269),

  # now intersect with county
  ca_Q_sites_cnty = st_intersection(ca_Q_sites_sf, ca_counties[,c(1:6)]),

  # Generate report
  tar_quarto(
    usgs_Q_report,
    path = "usgs_Q_report.qmd",
    quiet = FALSE
  )
)
