# PFC-EDU v3.0 Evaporation Tests - Jan. to Feb. Data

### Setup
To test the affects of an airstone on the growth of plants in the Personal Food Computer (PFC-EDU) v3.0, 
20 of the machines were setup to grow basil over a month. The machines were configured with and
without airstones, with and without the air flow fan turned on, and some with soil instead of a 
hydroponic setup.

The PFC-EDU v3.0 is comprised of a 'brain' circuit board that has the sensors and LED lights, and is driven by
a BeagleBone Black wireless computer. The 20 machines used in this test had brain boards that were
used in the school pilot program the prior fall, but 3 of them had new BeagleBones installed due to 
damage to the ones that were returned. 

The following three IDs are the machines that had the new BeagleBones:

 - EDU-90DB5116-50-65-83-e6-7d-b0
 - EDU-D834D808-f4-5e-ab-fa-82-e8
 - EDU-E074D2DE-f4-5e-ab-3d-d0-61

### Data

#### Compiled Data (`data/PFC_EVAP_DATASET_Jan-Feb_2019.xlsx`)

This file contains data from running multiple grows in multiple Personal food computers to test the effects of air pump on evaporation of the water. 

There are multiple tabs in the `.xlsx` file:

 - Tab 0: Bot Mapping. This tab describes the set up of the 20 machines. (more detail below)
 - Tab 1: compile_manual_PFC_evap_201902_. This tab is a compilation of all the manual data that was recorded. (`dissolved_o2`, `height_cm`, `leaf_count`, `leaves_removed`, `harvest_fresh_mass_g`) Not all rows have all columns, missing data (or data not recorded) have `NA` as a value.
 - Tab 2: Water Level Notes. Notes taken about how much water was left at various intervals through out the process.
 - Tab 3: Images. A list of all images from the machines taken. The file format has Bot ID, Date, and Time (UTC) embeded in it
 - Tab 4: Raw Sensor Data. All sensor readings taken by the bots
 
 ##### CSV Data

 The `notebooks/prepare_data.ipynb` python notebook parses the data in the Excel file to produce a series of 
 directories under `data/csv`. A subdirectory is created for each bot in the test, and three CSV files are generated.
 
  - `image_urls.csv` is csv where each row is: `[UTC timestamp, URL]` pointing to an image captured by the bot
  - `manual_data.csv` contains all the manual measurements with each row consisting of 
    - `treatment`
    - `date (no time)`
    - `dissovled_o2` - `NA` indicates no measurement
    - `height_cm` - `NA` indicates no measurement
    - `leaf_count` - `NA` indicates no measurement
    - `leaves_removed` - `NA` indicates no measurement
    - `harvest_fresh_mass_g` - `NA` indicates no measurement
  - `raw_sensor_data.csv` contains the raw measurements the bot made during the run. Each row consists of:
    - `time_utc`
    - `var` - the measured variable
    - `name` - the sensor name (some sensors report multiple `var`s
    - `value` - the measured value

#### Raw BigQuery Data
Under the `data/csv/raw_from_BQ` directory is data pulled directly from BigQuery. 

`bq-results-pfc-20-pilot-dta-oct_11_2018-jan_1_2019.csv` file was an attempt to see if 
any of the machines used in the in the 'PFC 20 Evap Test' had actually reported data back 
during the school pilot. It appears they did not, but many had been turned on once we got them back in December.

`bq-results-pfc-20-test-jan_14-feb_15.csv` contains the data pulled for the durration of the 
evaporation test performed between January 14th and February 15th, 2019.

The two .csv files were pulled using the query in `query.txt` with the indicated date ranges.
The `split_datas` directory contains data split out by bot and sensor. `evap_test` contains the data from the 
evaporation test, and `pilot_data` contains the attempt to pull data from the school pilot.
The `notebooks/prepare_raw_from_BQ.ipynp` file was used to do the splitting. 

The split out files were used for the computations below.

#### Computed Data

The output of the `prepare_data.ipynb` has been saved to a few locations:

 - `data/evap_test_summart_by_bot/` contains a CSV file for each bot with stats on each sensor value found
 - `data/dates_of_data_found_in_pilot_timeframe_Oct_2018-Dec_2018.txt` contains the min and max data for each bot of data found when querying BigQuery with the time frame of Oct 11, 2019 through Dec 31, 2018. All the bots have some data after they were returned to OpenAg.

#### BigQuery Used

There was only one Big Query query used to retrieve the data in the raw_sensor_data
    
#### Timelapse images
Timelapse movies can be made using the `scripts/make_timelapse.sh` script. You'll want to generate an
images.txt file which has one image URL per line. You can pull this from the 
`data/csv/raw_from_BQ/split_datas/evap_test/<DEVICE_ID>_Camera-Top_URL.csv` data files. (There is
one for each PFC)

You can use `ffmpeg` to generate a grid of videos using various `hstack`/`vstack`/`xstack` options.

The `timelapse_vidoes` directory contains pre-made time lapses.
[`full_grid.mp4`](timelapse_videos/full_grid.mp4) provides a full grid of the 20 bots during the month long run.
Images from 3 bots are missing, and one is very much out of focus.

In the grid, the first column are bots running without an airstone and with normal fan speed.
The second column are bots runnig with an airstone, but with no fan.
The third column are the bots that were running without an airstone, and without a fan.
The fourth column are bots that had soil (rather than hydroponics), with no air fan.
The fifth column is the 'control' running with an airstone, and with the normal air fan.

You'll find the individual videos for each bot in the corresponding compressed subdirectory.


#### Data Plots
   You can view the output of the `notebooks/Plot PFC Evap Test Data.ipynb` in the [doc/jupyter_output/Plot PFC Evap Test Data/ Directory](doc/jupyter_output/Plot%20PFC%20Evap%20Test%20Data/Plot%20PFC%20Evap%20Test%20Data.md)
