# PREPARATION

#set a working directory to simplify data calls
#setwd("D:/R/R Projects/DivvyBikes")

#load necessary libraries
library(tidyverse)
library(lubridate)
library(ggplot2)
library(scales)
library(janitor)
library(tidyr)
library(leaflet)


# DATA WRANGLING (putting raw data into a usable form)

# Import CSV into tibbles
feb2022 <- read_csv("./data/202202-divvy-tripdata.csv")
mar2022 <- read_csv("./data/202203-divvy-tripdata.csv")
apr2022 <- read_csv("./data/202204-divvy-tripdata.csv")
may2022 <- read_csv("./data/202205-divvy-tripdata.csv")
jun2022 <- read_csv("./data/202206-divvy-tripdata.csv")
jul2022 <- read_csv("./data/202207-divvy-tripdata.csv")
aug2022 <- read_csv("./data/202208-divvy-tripdata.csv")
sep2022 <- read_csv("./data/202209-divvy-publictripdata.csv")
oct2022 <- read_csv("./data/202210-divvy-tripdata.csv")
nov2022 <- read_csv("./data/202211-divvy-tripdata.csv")
dec2022 <- read_csv("./data/202212-divvy-tripdata.csv")
jan2023 <- read_csv("./data/202301-divvy-tripdata.csv")


glimpse(feb2022)


# Compare columns in the data.frames (names and quantity)
## (rbind() throws an error if the data frames have different number of columns,
### whereas bind_rows() would assign NA's. Hence, rbind to check.
#### Returns TRUE if the columns are identical)
compare_df_cols_same(feb2022, mar2022, apr2022, may2022, jun2022, jul2022,
                     aug2022,sep2022, oct2022, nov2022, dec2022, jan2023,
                     bind_method = c("rbind"))

# Or, check column names and quantity manually
colnames(feb2022)
colnames(mar2022)
colnames(apr2022)
colnames(may2022)
colnames(jun2022)
colnames(jul2022)
colnames(aug2022)
colnames(sep2022)
colnames(oct2022)
colnames(nov2022)
colnames(dec2022)
colnames(jan2023)

# Clean names, if needed. By default, cleans to snake_case
clean_names(feb2022)

#Inspecting the DFs to look for inconsistencies in data types.
str(feb2022)
str(mar2022)
str(apr2022)
str(may2022)
str(jun2022)
str(jul2022)
str(aug2022)
str(sep2022)
str(oct2022)
str(nov2022)
str(dec2022)
str(jan2023)

# Combine single DataFrames into a big DataFrames. I use bind_rows because it's faster.
full_tripdata <- bind_rows(feb2022, mar2022, apr2022, may2022, jun2022, jul2022,
                           aug2022, sep2022, oct2022, nov2022, dec2022, jan2023)

# Remove single DataFrames
rm(feb2022, mar2022, apr2022, may2022, jun2022, jul2022,
   aug2022, sep2022, oct2022, nov2022, dec2022, jan2023)

# Check for ride_id duplicates
get_dupes(full_tripdata, ride_id)

# Replace "docked_bike" with "classic_bike" because docked_bike is an old name
# for classic_bike that was omitted after electric_bike type were introduced.
full_tripdata <- full_tripdata %>% 
  mutate(rideable_type = if_else(rideable_type == "docked_bike", "classic_bike", rideable_type))
# Verify that it was replaced successfully
count(full_tripdata, rideable_type)
table(full_tripdata$rideable_type)

# Find the number of missing values in the DF and in particular variables
sum(is.na(full_tripdata))
sum(is.na(full_tripdata$start_station_name))
sum(is.na(full_tripdata$start_station_id))
sum(is.na(full_tripdata$end_station_name))
sum(is.na(full_tripdata$end_station_id))
sum(is.na(full_tripdata$start_lat))
sum(is.na(full_tripdata$start_lng))
sum(is.na(full_tripdata$end_lat))
sum(is.na(full_tripdata$end_lng))
# Сount missing values by column wise
sapply(full_tripdata, function(x) sum(is.na(x)))
# Find the location of missing values
which(is.na(full_tripdata))



# FURTHER QUESTIONS

# PROBLEM 1:
# There are more unique station names than unique station ID

# PROBLEM 2: 
# Some lat and lng end in 'xx.xx000', like -87.62000. It looks like in those
# cases the coordinates aren't accurate. Moreover, stations with such coordinates
# have IDs that consist of just three numbers, such as "628", whereas 'normal'
# IDs seem to include more numbers and sometimes letters.

length(unique(full_tripdata$start_station_name))
length(unique(full_tripdata$start_station_id))
#or
n_distinct(full_tripdata$start_station_name)
n_distinct(full_tripdata$start_station_id)
# I see that for 1680 unique station names there are 1312 unique station IDs.
# Exploring further. I create temporary tibbles to explore inconsistencies in naming.

# Find inconsistent start_station_name with identical IDs
inconsistent_start_station_name <- full_tripdata %>% 
  group_by(start_station_id) %>% 
  filter(n_distinct(start_station_name) > 1) %>% 
  select(start_station_id, start_station_name) %>% 
  distinct() %>% 
  arrange(desc(start_station_id))

# Find inconsistent end_station_name with identical IDs
inconsistent_end_station_name <- full_tripdata %>% 
  group_by(end_station_id) %>% 
  filter(n_distinct(end_station_name) > 1) %>% 
  select(end_station_id, end_station_name) %>% 
  distinct() %>% 
  arrange(desc(end_station_id))

missing_station_names <- full_tripdata %>%
  filter(is.null(start_station_id) & is.null(start_station_name))

full_tripdata %>%
  filter(is.na(start_station_name),
         is.na(start_station_id),
         nchar(as.character(start_lat)) == 8)



# FURTHER EXPLANATION:

# After manually exploring inconsistent names, I found that stations with the
# same ID sometimes have their name started with "Public Rack - " or "City Rack - ",
# and sometimes not. I explored System Map on Divvy website and figured out that these must be
# the same stations.

# Some stations have the same IDs, but different names, e.g.
# "Kedzie Ave & 61st Pl W" and "Kedzie Ave & 61st Pl" both have ID = 1039, but
# according to the System Map they are different stations, located across the
# road.
# Hence no cleaning for these names.

# Some stations have " (Temp)" added to their name. Might be that Divvy Bikes
# had 2 stations close to each other to AB test a better location for a station.
# Might be not, yet for the purpose of the current analysis it's safe to merge such stations
# into one.

# Some stations are maintenance stations. I remove them, too. 

# Remove unnecessary string pieces from station names for consistency
full_tripdata <- full_tripdata %>% 
  mutate(start_station_name = str_remove(start_station_name, "Public Rack - ")) %>%
  mutate(start_station_name = str_remove(start_station_name, "Public  Rack - ")) %>% 
  mutate(start_station_name = str_remove(start_station_name, "Pubic Rack - ")) %>%
  mutate(start_station_name = str_remove(start_station_name, "City Rack - ")) %>% 
  mutate(start_station_name = str_remove(start_station_name, "amp;")) %>% 
  mutate(start_station_name = str_trim(str_remove(start_station_name, " \\(Temp\\)"))) %>% 
  mutate(start_station_name = str_remove(start_station_name, "\\*")) %>% 
  mutate(start_station_name = str_remove(start_station_name, " - Charging")) %>% 
  mutate(start_station_name = str_remove(start_station_name, " (May)")) %>%
  mutate(start_station_name = str_replace(start_station_name, "Western & 28th - Velasquez Institute Vaccination Site", "Western Ave & 28th St")) %>% 
  mutate(start_station_name = str_replace(start_station_name, "Halsted & 63rd - Kennedy-King Vaccination Site", "Halsted St & 63rd St")) %>% 
  mutate(start_station_name = str_replace(start_station_name, "Broadway & Wilson - Truman College Vaccination Site", "Broadway & Wilson Ave")) %>% 
  filter(start_station_id != "DIVVY 001 - Warehouse test station" &
           start_station_id != "Hubbard Bike-checking (LBS-WH-TEST)" |
           is.na(start_station_id)) %>% 
  mutate(end_station_name = str_remove(end_station_name, "Public Rack - ")) %>% 
  mutate(end_station_name = str_remove(end_station_name, "Public  Rack - ")) %>% 
  mutate(end_station_name = str_remove(end_station_name, "Pubic Rack - ")) %>% 
  mutate(end_station_name = str_remove(end_station_name, "City Rack - ")) %>% 
  mutate(end_station_name = str_remove(end_station_name, "amp;")) %>% 
  mutate(end_station_name = str_trim(str_remove(end_station_name, " \\(Temp\\)"))) %>% 
  mutate(end_station_name = str_remove(end_station_name, "\\*")) %>% 
  mutate(end_station_name = str_remove(end_station_name, " - Charging")) %>% 
  mutate(end_station_name = str_remove(end_station_name, " (May)")) %>% 
  mutate(end_station_name = str_replace(end_station_name, "Western & 28th - Velasquez Institute Vaccination Site", "Western Ave & 28th St")) %>% 
  mutate(end_station_name = str_replace(end_station_name, "Halsted & 63rd - Kennedy-King Vaccination Site", "Halsted St & 63rd St")) %>% 
  mutate(end_station_name = str_replace(end_station_name, "Broadway & Wilson - Truman College Vaccination Site", "Broadway & Wilson Ave")) %>% 
  filter(end_station_id != "DIVVY 001 - Warehouse test station" &
           end_station_id != "Hubbard Bike-checking (LBS-WH-TEST)" |
           is.na(end_station_id))  

# tibble to check for station names
stations <- full_tripdata %>%
  group_by(start_station_name) %>%
  arrange(start_station_name) %>%
  distinct(start_station_name) %>%
  filter(startsWith(start_station_name, "Pub"))

# check duplicate naming
full_tripdata %>% 
  group_by(end_station_id) %>% 
  filter(n_distinct(end_station_name) > 1) %>% 
  select(end_station_id, end_station_name) %>% 
  distinct() %>% 
  arrange(desc(end_station_id))


# The number of inconsistent station names was reduces from 741 to 215.

# Check count for station IDs and names
full_tripdata %>% 
  summarise (
    start_id = start_station_id %>% n_distinct,
    end_id = end_station_id %>% n_distinct,
    start_name = start_station_name %>% n_distinct,
    end_name = end_station_name %>% n_distinct
  )


# Distinct start_station_name that is not in end_station_name
full_tripdata %>% 
  filter(!is.na(start_station_name) 
         & !(full_tripdata$start_station_name %in% full_tripdata$end_station_name)
  ) %>%
  distinct(start_station_name)

# Distinct end_station_name that is not in start_station_name
full_tripdata %>% 
  filter(!is.na(end_station_name) 
         & !(full_tripdata$end_station_name %in% full_tripdata$start_station_name)
  ) %>%
  distinct(end_station_name)

# Distinct start_station_id that is not in end_station_id
full_tripdata %>% 
  filter(!is.na(start_station_id) 
         & !(full_tripdata$start_station_id %in% full_tripdata$end_station_id)
  ) %>%
  distinct(start_station_id)

# Distinct end_station_id that is not in start_station_id
full_tripdata %>% 
  filter(!is.na(end_station_id) 
         & !(full_tripdata$end_station_id %in% full_tripdata$start_station_id)
  ) %>%
  distinct(end_station_id)


# Remove unnecessary string pieces from station names for consistency
full_tripdata <- full_tripdata %>% 
  filter(end_station_id != "DIVVY CASSETTE REPAIR MOBILE STATION"
         | is.na(end_station_id)
  )  

# Remove unnecessary string pieces from station names for consistency
full_tripdata <- full_tripdata %>% 
  filter(start_station_id != "DIVVY CASSETTE REPAIR MOBILE STATION"
         | is.na(start_station_id)
  )  


# Remove temporary tibbles
rm(inconsistent_end_station_name, inconsistent_start_station_name)



# STATISTICS

#statistical summary of a data frame.
summary(full_tripdata)

# Contingency tables
table(full_tripdata$member_casual)
table(full_tripdata$rideable_type)

#Add columns that list the date, year, month, week, day, day_of_week, hour of each ride.
full_tripdata$date <- as.Date(full_tripdata$started_at)
full_tripdata$year <- format(as.Date(full_tripdata$started_at), "%Y")
full_tripdata$month <- format(as.Date(full_tripdata$started_at), "%m")
full_tripdata$week <- week(as.POSIXct(full_tripdata$started_at))
full_tripdata$day <- format(as.Date(full_tripdata$started_at), "%d")
full_tripdata$day_of_week <- format(as.Date(full_tripdata$date), "%A")
full_tripdata$hour <- hour(as.POSIXct(full_tripdata$started_at))

# Add a variable to check for round trips
full_tripdata$round_trip <- ifelse((full_tripdata$start_station_id == full_tripdata$end_station_id), 1, 0)
table(full_tripdata$round_trip)

#Add a numeric variable for ride duration
full_tripdata$ride_length <- as.numeric(difftime(full_tripdata$ended_at,full_tripdata$started_at), units="secs")

# Thoughts on ride_length:

# ride_length can't be negative, yet some of the observations are. This might be due to
# clock miscalibration across stations or bikes depending on how this process is organized.
# Should I work at Divvy, I would explore deeper knowing business domain, but for the purpose
# of this analysis it's reasonable to just exclude rides with negative duration.

# Calculate the number of rides with negative ride_length
sum(full_tripdata$ride_length < 0)
# Remove negative ride_length
full_tripdata <- full_tripdata[!(full_tripdata$ride_length <= 0),]

# Short rides such as a one-second ride or a ten-second ride don't make much sense
# either. Some of them are the result of people changing their mind, some might be
# a calibration mistake. Despite the reasons, I should find a cut-off point in
# ride_length and remove the corresponding rides.

# Check out the ride_length deciles to check for outliers and determine a scale for a plot.
quantile(full_tripdata$ride_length, probs = seq(0,1,0.1))
# Evidently, there are outliers in the 1st and the 10th decile, which will
# make the data less informative. I need to handle this.

# Check the distribution of ride duration, trimmed after ride_length > 3600 seconds.
ggplot(full_tripdata, aes(x = ride_length, fill = member_casual)) + 
  geom_histogram(binwidth = 1, position = "stack") +
  scale_y_continuous(labels = comma) +
  xlim(0,3600)
# The distribution looks like a right-skewed bell curve with extreme outliers close to a zero point.
# From the plot it's noticeable the outliers lay somewhere in the < 100 ride_length range. 
# Count all ride_duration's in this range and arrange the values to find the cut-off point.
full_tripdata %>% 
  filter(ride_length < 100) %>% 
  count(ride_length) %>% 
  arrange(n) %>% 
  print(n = 100)
# The cut-off point is 65 because ride_length = 65 has the lowest number of rides
# where ride_length > 0, meaning that this is the lowest point on the part of the graph
# that contains outliers.

# Remove the corresponding rides
full_tripdata <- full_tripdata[!(full_tripdata$ride_length < 65),]
# Check the distribution once again, now it looks more reliable for future analysis
ggplot(full_tripdata, aes(x = ride_length, fill = member_casual)) + 
  geom_histogram(binwidth = 1, position = "stack") +
  scale_y_continuous(labels = comma) +
  xlim(0,3600)

# There might be better ways to calculate the cut-off point, for example using
# statistical methods. However, since all methods for identifying outliers
# are arbitrary, I consider the method I used to be reliable, too.

# Alternatively, I might use the Empirical Rule (or 68-95-99.7 rule), which says
# that any observation more than 3 standard deviations away from the mean is unusual
# and might be considered an outlier.(However, this rule is usually applied
# to symmetric distributions)

# For skewed distribution with outliers, which this distribution is, we could
# use the IQR rule

# Applying the IQR rule to find outliers on the right. I might use 1.7 coefficient because
# it is equal to the 3 standard deviations rule.
quantile(full_tripdata$ride_length, probs = 0.75) + 1.7*IQR(full_tripdata$ride_length)
# However, it might be wise to remove only extreme outliers, hence coefficient = 3
quantile(full_tripdata$ride_length, probs = 0.75) + 3*IQR(full_tripdata$ride_length)
# The result with coefficient = 3 is 3386

# While the long rides might be real rides indeed, in this analysis we're
# interested in how most casual riders differ from most members.
# Hence, we exclude extremely long rides from the sample for better understanding
# of how the majority of the client behave. 

# Remove the outliers on the right
full_tripdata <- full_tripdata[!(full_tripdata$ride_length > 3386),]
# Check the distribution once again, now it looks more reliable for the
# current analysis goals
ggplot(full_tripdata, aes(x = ride_length, fill = member_casual)) + 
  geom_histogram(binwidth = 1, position = "stack") +
  scale_y_continuous(labels = comma)


# Deciles to look at ride_length
full_tripdata %>%
  group_by(member_casual) %>%
  summarise(
    `10%` = format(as.POSIXct(0, origin = "1970-01-01") + round(quantile(ride_length, probs = 0.1)), format = "%Mm %Ss"),
    `20%` = format(as.POSIXct(0, origin = "1970-01-01") + round(quantile(ride_length, probs = 0.2)), format = "%Mm %Ss"),
    `30%` = format(as.POSIXct(0, origin = "1970-01-01") + round(quantile(ride_length, probs = 0.3)), format = "%Mm %Ss"),
    `40%` = format(as.POSIXct(0, origin = "1970-01-01") + round(quantile(ride_length, probs = 0.4)), format = "%Mm %Ss"),
    `50%` = format(as.POSIXct(0, origin = "1970-01-01") + round(quantile(ride_length, probs = 0.5)), format = "%Mm %Ss"),
    `60%` = format(as.POSIXct(0, origin = "1970-01-01") + round(quantile(ride_length, probs = 0.6)), format = "%Mm %Ss"),
    `70%` = format(as.POSIXct(0, origin = "1970-01-01") + round(quantile(ride_length, probs = 0.7)), format = "%Mm %Ss"),
    `80%` = format(as.POSIXct(0, origin = "1970-01-01") + round(quantile(ride_length, probs = 0.8)), format = "%Mm %Ss"),
    `90%` = format(as.POSIXct(0, origin = "1970-01-01") + round(quantile(ride_length, probs = 0.9)), format = "%Mm %Ss")
  )


# ADDITIONAL STATISTICS, or quick insights we can get from this data:

#Basic descriptive analysis on a particular variable
summary(full_tripdata$ride_length)
#Average ride length
mean(full_tripdata$ride_length)
round(mean(full_tripdata$ride_length, trim = 0.01), 0)
#Median ride length
median(full_tripdata$ride_length)
#Longest ride
max(full_tripdata$ride_length)
#Shortest ride
min(full_tripdata$ride_length)

# Number of rides by rideable_type and member_casual
full_tripdata %>%
  group_by(rideable_type, member_casual) %>%
  summarize(num_rides = n())

# Number of rides by rideable_type and member_casual, wide data
full_tripdata %>%
  count(rideable_type, member_casual, name = "count") %>%
  pivot_wider(names_from = member_casual, values_from = count)

# Longest 10 rides
longest_10_rides <- full_tripdata %>% 
  arrange(desc(ride_length)) %>% 
  group_by(member_casual) %>% 
  slice(1:10)

# Descriptive statistics comparison
aggregate(full_tripdata$ride_length ~ full_tripdata$member_casual, FUN = mean)
# or
aggregate(ride_length ~ member_casual, data = full_tripdata, function(x) round(mean(x, trim = 0.01), 0))
aggregate(full_tripdata$ride_length ~ full_tripdata$member_casual, FUN = median)
aggregate(full_tripdata$ride_length ~ full_tripdata$member_casual, FUN = max)
aggregate(full_tripdata$ride_length ~ full_tripdata$member_casual, FUN = min)

# Compare total ride_length for different bike types, hours
aggregate(full_tripdata$ride_length ~ full_tripdata$rideable_type, FUN = function(x) round(sum(x)/3600, 0))

# Average time by each day and each member group
aggregate(ride_length ~ member_casual + day_of_week, data = full_tripdata, mean)
# Rewritten with the use of dplyr::group_by()
full_tripdata %>%
  group_by(member_casual, day_of_week) %>%
  summarize(mean_ride_length = mean(ride_length))
# Reordering days of the week
full_tripdata$day_of_week <- ordered(full_tripdata$day_of_week, levels=c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"))
is.factor(full_tripdata$day_of_week)
# Average time by each day and each member group, reordered
aggregate(ride_length ~ member_casual + day_of_week, data = full_tripdata, mean)

# Ridership data by type and weekday
type_weekday <- full_tripdata %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n(),average_duration = round(mean(ride_length),0)) %>% 
  arrange(member_casual,weekday)



# VISUALIZATION


# 1 BASIC PIES

## 1.1 Number of Rides Ratio by Customer Type

# Pie chart: Ride Ratio by Customer Type
pie_percent_rides <- full_tripdata %>% 
  count(member_casual) %>% 
  rename(group = member_casual) %>% 
  rename(value = n) %>% 
  arrange(desc(group)) %>%
  mutate(prop = value / sum(value) *100)

ggplot(pie_percent_rides, aes(x="", y=value, fill=group)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="none") +
  geom_text(aes(label = paste0(round(prop, 2), "%\n", comma(value), " rides\n", group)),
            position = position_stack(vjust = 0.5),
            color = "white", size=6, lineheight=0.8) +
  labs(title = "Ride Ratio by Customer Type") +
  guides(fill = guide_legend(title = "Customer Type"))

## 1.2 Total Ride Duration Ratio by Customer Type

# Pie chart: Total Ride Duration Proportion by Customer Type
pie_ride_length_ratio <- full_tripdata %>% 
  group_by(member_casual) %>% 
  summarise(total_duration = sum(ride_length) / 3600) %>% 
  mutate(prop = total_duration / sum(total_duration) * 100)

ggplot(pie_ride_length_ratio, aes(x="", y=total_duration, fill=member_casual)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="none") +
  geom_text(aes(label = paste0(round(prop, 1), "%\n", comma(round(total_duration,0)), " hours\n", member_casual)),
            position = position_stack(vjust = 0.5),
            color = "white", size=6, lineheight=0.8) +
  labs(title = "Total Ride Duration Ratio by Customer Type") +
  guides(fill = guide_legend(title = "Customer Type"))


# MEAN VALUES

# 2.1 Mean Ride Length by Customer Type
bar_mean_length <- full_tripdata %>% 
  group_by(member_casual) %>% 
  summarise(mean_length = mean(ride_length) / 60)

ggplot(bar_mean_length, aes(x=member_casual, y=mean_length, fill=member_casual)) +
  theme_minimal() +
  geom_bar(stat="identity", position = "dodge") +
  scale_y_continuous(labels = comma) +
  theme(legend.position="none") +
  labs(title = "Mean Ride Length by Customer Type (minutes)",
       x = "",
       y = "",
       fill = "Customer Type")


# 2.2 Mean Ride Length by Day of Week
bar_mean_length_per_week <- full_tripdata %>% 
  group_by(day_of_week, member_casual) %>% 
  summarise(mean_length = mean(ride_length) / 60) %>% 
  mutate(day_of_week = factor(day_of_week, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))) %>%
  arrange(day_of_week)  

ggplot(bar_mean_length_per_week, aes(x=day_of_week, y=mean_length, fill=member_casual)) +
  theme_minimal() +
  geom_bar(stat="identity", position = "dodge") +
  geom_text(aes(label = round(mean_length,1)), position = position_dodge(width = 0.9), vjust = -0.5) +
  scale_y_continuous(labels = comma) +
  theme(legend.position="bottom") +
  labs(title = "Mean Ride Length by Day of Week by Customer Type (minutes)",
       x = "",
       y = "",
       fill = "Customer Type")

# 2.3 Mean Trip Length by Ride Start Hour
line_ride_length_hour <- full_tripdata %>% 
  group_by(hour, member_casual) %>% 
  summarise(mean_ride_length = mean(ride_length) / 60) %>% 
  arrange(hour)

ggplot(line_ride_length_hour, aes(x = hour, y = mean_ride_length, color = member_casual)) + 
  geom_line() +
  scale_x_continuous(breaks = unique(line_ride_length_hour$hour)) +  # Use scale_x_continuous instead of scale_x_discrete
  scale_y_continuous(expand = c(0, 0), limits = c(0, max(line_ride_length_hour$mean_ride_length))) +  # Set limits to include 0
  theme_minimal() +
  labs(title = "Mean Trip Length distribution by Start Hour, in minutes",
       color = "Customer Type",
       x = element_blank(),
       y = element_blank()) +
  theme(legend.position = "bottom")

# 2.4 Mean Ride Length per Week
area_mean_ride_week <- full_tripdata %>% 
  group_by(week = floor_date(date, unit = "week"), member_casual) %>% 
  summarise(mean_length = mean(ride_length) / 60) %>% 
  arrange(week)

ggplot(area_mean_ride_week, aes(x = week, y = mean_length, fill = member_casual)) +
  geom_area(position = "identity") +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  scale_x_date(date_breaks = "2 month", date_labels = "%b %Y") +
  scale_y_continuous(breaks = seq(0, max(area_mean_ride_week$mean_length), 2)) +
  labs(title = "Mean ride length per Week by Customer Type (minutes)",
       fill = "Customer Type")


# 2.5 Mean ride length per Month by Customer Type
area_mean_ride_month <- full_tripdata %>% 
  group_by(month = floor_date(date, unit = "month"), member_casual) %>% 
  summarise(mean_length = mean(ride_length) / 60) %>% 
  arrange(month)

ggplot(area_mean_ride_month, aes(x = month, y = mean_length, fill = member_casual)) +
  geom_area(position = "identity") +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  scale_x_date(date_breaks = "2 month", date_labels = "%b %Y") +
  scale_y_continuous(breaks = seq(0, max(area_mean_ride_month$mean_length), 2)) +
  labs(title = "Mean ride length per Month by Customer Type (minutes)",
       fill = "Customer Type")



# 3 YEARLY NUMBER AND PROPORTION

# 3.1 Area chart: Number of Rides per Day by Customer Type
area_ride_count_date <- full_tripdata %>% 
  group_by(date,member_casual) %>% 
  summarise(ride_count = n()) %>% 
  arrange(date)

ggplot(area_ride_count_date, aes(x = date, y = ride_count, fill = member_casual)) +
  geom_area() +
  theme_minimal() +
  theme(legend.position="bottom",
        axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  scale_x_date(breaks = "2 month", labels = date_format("%b %Y")) +
  labs(title = "Number of Rides per Day by Customer Type",
       fill = "Customer Type")

# 3.2 Proportion of Rides per Month
col_ride_count_month <- full_tripdata %>% 
  group_by(month = floor_date(date, unit = "month"), member_casual) %>% 
  summarise(ride_count = n()) %>% 
  arrange(month) %>%
  group_by(month) %>%
  mutate(ride_count_prop = ride_count / sum(ride_count))

ggplot(col_ride_count_month, aes(x = month, y = ride_count_prop, fill = member_casual)) +
  geom_col(position = "fill") +
  geom_text(aes(label = paste0(round(ride_count_prop * 100), "%")), 
            position = position_fill(vjust = 0.5), size = 3) +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank()) +  # Remove Y-axis title and text
  scale_x_date(date_labels = "%b %Y", date_breaks = "2 month") +
  labs(title = "Proportion of Rides per Month",
       fill = "Customer Type")


# 3.3 Ridership by Day of Week 
bar_trips_count_week_per_membership <- full_tripdata %>% 
  group_by(day_of_week, member_casual) %>% 
  summarise(trips = sum(!is.na(ride_id))) %>% 
  mutate(day_of_week = factor(day_of_week, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))) %>%
  arrange(day_of_week)

ggplot(bar_trips_count_week_per_membership, aes(x=day_of_week, y=trips, fill=member_casual)) +
  theme_minimal() +
  geom_bar(stat="identity", position = "dodge") +
  scale_y_continuous(labels = comma) +
  theme(legend.position="bottom") +
  labs(title = "Ridership by Day of Week by Customer Type",
       x = "",
       y = "",
       fill = "Customer Type")



# 4 ROUND TRIPS

# 4.0 Percentage of Round Trips
full_tripdata %>% 
  group_by(member_casual) %>% 
  summarise(num_round_trip = sum(round_trip, na.rm = TRUE), total_trips = n(), ratio = round((num_round_trip / total_trips)*100,2))

# 4.1 Number of Round Trips by Hour
area_round_trips <- full_tripdata %>% 
  group_by(hour, member_casual) %>% 
  summarise(num_round_trip = sum(round_trip, na.rm = TRUE)) %>% 
  arrange(hour)

ggplot(area_round_trips, aes(x = hour, y = num_round_trip, color = member_casual)) +
  geom_line() +
  scale_x_discrete(limits = area_round_trips$hour) +
  theme_minimal() +
  scale_y_continuous(labels = comma) +
  labs(title = "Number of Round Trips by Hour",
       color = "Customer Type",
       x = element_blank(),
       y = element_blank()) +
  theme(legend.position = "bottom")


# 4.2 Number of Round Trips by Day of Week
bar_round_trips_dow <- full_tripdata %>% 
  group_by(day_of_week, member_casual) %>% 
  summarise(num_round_trip = sum(round_trip, na.rm = TRUE)) %>% 
  mutate(day_of_week = factor(day_of_week, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))) %>%
  arrange(day_of_week)  


ggplot(bar_round_trips_dow, aes(x = day_of_week, y = num_round_trip, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  scale_y_continuous(labels = comma) +
  labs(title = "Number of Round Trips by Day of Week",
       fill = "Customer Type",
       x = element_blank(),
       y = element_blank()) +
  theme(legend.position = "bottom")


# 4.3 Ratio of Round Trips by Day of Week
round_trips_dow <- full_tripdata %>% 
  group_by(day_of_week, member_casual) %>% 
  summarise(num_round_trip = sum(round_trip, na.rm = TRUE), total_trips = n(), ratio = round((num_round_trip / total_trips)*100,2)) %>% 
  mutate(day_of_week = factor(day_of_week, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))) %>%
  arrange(day_of_week) 

ggplot(round_trips_dow, aes(x = day_of_week, y = ratio, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(round(ratio, 1), "%")), position = position_dodge(width = 0.9), vjust = -0.5) +
  theme_minimal() +
  scale_y_continuous(labels = NULL) +
  labs(title = "Ratio of Round Trips by Day of Week",
       fill = "Customer Type",
       x = element_blank(),
       y = element_blank()) +
  theme(legend.position = "bottom")


# 4.4 Percentage of Round Trips by Hour
line_round_trips <- full_tripdata %>% 
  group_by(hour, member_casual) %>% 
  summarise(num_round_trip = sum(round_trip, na.rm = TRUE), total_trips = n(), ratio = round((num_round_trip / total_trips)*100,2)) %>% 
  arrange(hour)

ggplot(line_round_trips, aes(x = hour, y = ratio, color = member_casual)) +
  geom_line() +
  scale_x_discrete(limits = line_round_trips$hour) +
  theme_minimal() +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +  # Add % sign to Y-axis labels
  labs(title = "Ratio of Round Trips by Hour",
       color = "Customer Type",
       x = element_blank(),
       y = "") +
  theme(legend.position = "bottom")



# 5 RIDE NUMBER DISTRIBUTION AND SO ON

# 5.1.1 Ride Number Distribution by the time the ride started
line_ride_count_hour <- full_tripdata %>% 
  group_by(hour, member_casual) %>% 
  summarise(ride_count = n()) %>% 
  arrange(hour)

ggplot(line_ride_count_hour, aes(x = hour, y = ride_count, color = member_casual)) + 
  geom_line() +
  scale_x_discrete(limits = line_ride_count_hour$hour) +
  theme_minimal() +
  scale_y_continuous(labels = comma) +
  labs(title = "Ride Number Distribution by Ride Start Hour",
       color = "Customer Type",
       x = element_blank(),
       y = element_blank()) +
  theme(legend.position = "bottom")

# 5.1.2
ggplot(full_tripdata, aes(x = hour, fill = member_casual)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = function(x) paste0(x * 100, "%"), expand = c(0, 0)) +
  scale_x_discrete(limits = full_tripdata$hour) +
  labs(x = NULL, y = NULL, title = "Ride Number Proportion by Ride Start Hour") +
  guides(fill = guide_legend(title = NULL)) +
  theme_minimal() +
  theme(legend.position = "bottom")

# 5.2 Ratio of Ride Number Distribution by the time the ride started.
line_ratio_ride_hour <- full_tripdata %>% 
  group_by(hour, member_casual) %>% 
  summarise(ratio_ride_count = n()) %>%  
  arrange(hour) %>%
  group_by(member_casual) %>%
  mutate(total = sum(ratio_ride_count),
         prop = ratio_ride_count / total * 100)

ggplot(line_ratio_ride_hour, aes(x = hour, y = prop, color = member_casual)) + 
  geom_line() +
  scale_x_discrete(limits = line_ratio_ride_hour$hour) +
  theme_minimal() +
  scale_y_continuous(labels = comma) +
  labs(title = "Ridership Percentage by Hour, %",
       color = "Customer Type",
       x = element_blank(),
       y = element_blank()) +
  theme(legend.position = "bottom")



# 6 ADDITIONAL PLOTS

# 6.1.1 Ride Length per Minute Intervals
trip_length_minutes <- full_tripdata %>% 
  group_by(ride_length, member_casual) %>% 
  summarise(num_rides = n(),
            ride_length_minutes = round(ride_length/60)) %>% 
  group_by(ride_length_minutes, member_casual) %>% 
  mutate(total_rides = n())

ggplot(trip_length_minutes, aes(x = ride_length_minutes, y = total_rides, color = member_casual)) +
  geom_line() +
  scale_y_continuous(label = comma) +
  scale_x_continuous(breaks = seq(1,58,4)) +
  theme_minimal() +
  theme(legend.position = "bottom") +
  labs(title = "Ride Length per Minute Intervals",
       color = "Customer Type",
       x = element_blank(),
       y = element_blank())


# 6.1.2 Ride Length Histogram (5-minute bins)
ggplot(full_tripdata, aes(x = ride_length/60, fill = member_casual)) +
  geom_histogram(binwidth = 5, color = "black", position = "stack") +
  scale_x_continuous(limits = c(0, 60), breaks = seq(0, 55, 5)) +
  scale_y_continuous(label = comma) +
  theme_minimal() +
  labs(title = "Ride Length Histogram (5-minute bins)",
       fill = "Customer Type") +
  theme(legend.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank())


# 6.2 Total Rides per Month
rides_month <- full_tripdata %>% 
  group_by(month, member_casual, year) %>% 
  summarise(rides_count = n()) %>% 
  arrange(year)

ggplot(rides_month, aes(x = month, y = rides_count, fill = member_casual)) +
  geom_col(position = "stack") +
  theme_minimal() +
  scale_y_continuous(labels = comma) +
  scale_x_discrete(limits = rides_month$month,
                   label = paste0(month.abb[as.integer(rides_month$month)],", ",rides_month$year)) +
  labs(title = "Number of Rides per Month by Customer Type",
       x = "Month",
       y = "Number of Rides",
       fill = "Customer Type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Number of Rides by Bike Type
ggplot(full_tripdata, aes(x = rideable_type, fill = member_casual)) + 
  theme_minimal() +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = comma) +
  labs(y = "",
       legend = "Type of Customer",
       title = "Number of Rides by Bike Type and Customer Type")


# 6.3 Number of Rides by Bike Type
ggplot(full_tripdata, aes(x = member_casual, fill = rideable_type)) + 
  theme_minimal() +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = comma) +
  labs(y = "",
       legend = "Type of Customer",
       title = "Number of Rides by Bike Type and Customer Type")

ggplot(full_tripdata, aes(x = member_casual, fill = rideable_type)) + 
  theme_minimal() +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c("lightblue", "steelblue")) +
  scale_y_continuous(labels = comma) +
  labs(y = "",
       x = NULL,
       legend.title = "Type of Bike",
       title = "Number of Rides by Bike Type and Customer Type")


# 6.4 Proportion of Rides by Bike Type and Customer Type
bike_type_prop <- full_tripdata %>%
  group_by(member_casual, rideable_type) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count))

ggplot(bike_type_prop, aes(x = member_casual, y = proportion, fill = rideable_type)) + 
  theme_minimal() +
  geom_bar(stat = "identity") +
  geom_text(aes(label = percent(proportion)),
            position = position_stack(vjust = 0.5),
            size = 3) +
  scale_fill_manual(values = c("lightblue", "steelblue")) +
  scale_y_continuous(breaks = NULL) +
  labs(y = NULL,
       x = NULL,
       fill = "",
       title = "Proportion of Rides by Bike Type and Customer Type")


# 6.5 Proportion of Rides by Bike Type and Customer Type, Monthly
bike_type_prop_month <- full_tripdata %>%
  group_by(member_casual, rideable_type, month) %>%
  summarise(count = n()) %>%
  group_by(month, member_casual) %>%
  mutate(sum_count = sum(count),
         proportion = count / sum_count)

ggplot(bike_type_prop_month, aes(x = member_casual, y = proportion, fill = rideable_type)) + 
  theme_minimal() +
  geom_bar(stat = "identity", position = "fill") +
  geom_text(aes(label = percent(proportion, accuracy = 1)),
            position = position_stack(vjust = 0.5),
            size = 3) +
  scale_fill_manual(values = c("lightblue", "steelblue")) +
  scale_y_continuous(breaks = NULL, labels = scales::percent) +
  labs(y = NULL,
       x = NULL,
       fill = "",
       title = "Proportion of Rides by Bike Type and Customer Type") +
  facet_wrap(~ month, labeller = labeller(month = c("01" = "Jan", "02" = "Feb", "03" = "Mar", "04" = "Apr", "05" = "May", "06" = "Jun", "07" = "Jul", "08" = "Aug", "09" = "Sep", "10" = "Oct", "11" = "Nov", "12" = "Dec"))) +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))

# 6.6 Classic Bike Ridership Percentage by Hour.
ratio_rideable_hour <- full_tripdata %>% 
  group_by(hour, member_casual, rideable_type) %>% 
  summarise(ratio_rideable_hour = n()) %>%  
  arrange(hour) %>%
  group_by(member_casual, hour) %>%
  mutate(total = sum(ratio_rideable_hour),
         prop = ratio_rideable_hour / total * 100) %>% 
  filter(rideable_type == "classic_bike")

ggplot(ratio_rideable_hour, aes(x = hour, y = prop, color = member_casual)) + 
  geom_line() +
  scale_x_discrete(limits = ratio_rideable_hour$hour) +
  theme_minimal() +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(title = "Classic Bike Ridership Percentage by Hour",
       color = "Customer Type",
       x = element_blank(),
       y = element_blank()) +
  theme(legend.title = element_blank(),
        legend.position = "bottom")









# Number of Rides by Day of Week by Customer Type
full_tripdata %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n(),average_duration = round(mean(ride_length),0)) %>% 
  arrange(member_casual,weekday) %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) + 
  theme_minimal() +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = scales::comma_format()) +
  labs(y = "Number of Rides",
       x = "Day of Week",
       title = "Number of Rides by Bike Type and Customer Type")  

#Total rides per hour, stacked (default)
ggplot(full_tripdata, aes(x = hour, fill = member_casual)) + 
  geom_bar() +
  scale_y_continuous(labels = comma) +
  scale_x_discrete(limits = full_tripdata$hour) +
  labs(x = "hours", y = "total_rides") +
  guides(fill = guide_legend(title = "customer_type"))

#Total rides per hour, position dodge
ggplot(full_tripdata, aes(x = hour, fill = member_casual)) + 
  geom_bar(position = "dodge") +
  scale_y_continuous(labels = comma) +
  scale_x_discrete(limits = full_tripdata$hour) +
  labs(x = "hours", y = "total_rides") +
  guides(fill = guide_legend(title = "customer_type"))

#Total rides per hour, position fill
ggplot(full_tripdata, aes(x = hour, fill = member_casual)) + 
  geom_bar(position = "fill") +
  scale_y_continuous(labels = comma) +
  scale_x_discrete(limits = full_tripdata$hour) +
  labs(x = "hours", y = "ratio of customer_type") +
  guides(fill = guide_legend(title = "customer_type"))









#Number of rides per length, x = seconds, trimmed
ggplot(full_tripdata, aes(x = ride_length, fill = member_casual)) + 
  geom_bar(position = "dodge") +
  scale_y_continuous(labels = comma) +
  xlim(0,2800)

#Ratio of rides per customer type for each ride length, x = seconds, trimmed
ggplot(full_tripdata, aes(x = ride_length, fill = member_casual)) + 
  geom_bar(position = "fill") +
  scale_y_continuous(labels = comma) +
  xlim(0,1000)



# LOCATION-WISE ANALYSIS

# Top Stations
top_start_stations <- full_tripdata %>%
  filter(!is.na(start_station_name), !is.na(start_station_id)) %>% 
  group_by(start_station_id, start_station_name, member_casual) %>% 
  summarise(rides = n()) %>%
  group_by(start_station_id, start_station_name) %>% 
  mutate(total_rides_station = sum(rides)) %>% 
  group_by(start_station_id, start_station_name) %>% 
  mutate(percentage_of_total_rides_station = round(rides / sum(rides) * 100, 2)) %>% 
  group_by(member_casual) %>% 
  mutate(percentage_of_total_rides_by_member_casual = round(rides / sum(rides) * 100, 2)) %>% 
  arrange(member_casual, desc(rides)) %>% 
  group_by(member_casual) %>%
  slice(1:10)

top_end_stations <- full_tripdata %>%
  filter(!is.na(end_station_name), !is.na(end_station_id)) %>% 
  group_by(end_station_id, end_station_name, member_casual) %>% 
  summarise(rides = n()) %>%
  group_by(end_station_id, end_station_name) %>% 
  mutate(total_rides_station = sum(rides)) %>% 
  group_by(end_station_id, end_station_name) %>% 
  mutate(percentage_of_total_rides_station = round(rides / sum(rides) * 100, 2)) %>% 
  group_by(member_casual) %>% 
  mutate(percentage_of_total_rides_by_member_casual = round(rides / sum(rides) * 100, 2)) %>% 
  arrange(member_casual, desc(rides)) %>% 
  group_by(member_casual) %>%
  slice(1:10)

# Top 20 start stations
full_tripdata %>%
  filter(!is.na(start_station_name), !is.na(start_station_id)) %>% 
  group_by(start_station_id, start_station_name) %>% 
  summarise(total_rides = n(),
            casual_rides = sum(ifelse(member_casual == "casual", 1, 0)),
            member_rides = sum(ifelse(member_casual == "member", 1, 0))) %>% 
  arrange(desc(total_rides)) %>%
  head(20) %>% 
  ggplot(aes(y = reorder(start_station_name, total_rides), x = total_rides)) +
  geom_col(aes(fill = "casual"), width = 0.5, position = "stack") +
  geom_col(aes(y = reorder(start_station_name, total_rides), x = member_rides, fill = "member"), width = 0.5, position = "stack") +
  ylab(NULL) +
  xlab(NULL) +
  ggtitle("Top 20 Start Stations by Total Rides") +
  theme_minimal() +
  theme(axis.text.x = element_text(hjust = 1),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.box = "horizontal")

# top 20 member start stations
full_tripdata %>%
  filter(!is.na(start_station_name), !is.na(start_station_id)) %>% 
  group_by(start_station_id, start_station_name) %>% 
  summarise(total_rides = n(),
            casual_rides = sum(ifelse(member_casual == "casual", 1, 0)),
            member_rides = sum(ifelse(member_casual == "member", 1, 0))) %>% 
  arrange(desc(member_rides)) %>%
  head(20) %>% 
  ggplot(aes(y = reorder(start_station_name, member_rides), x = total_rides)) +
  geom_col(aes(fill = "casual"), width = 0.5, position = "stack") +
  geom_col(aes(y = reorder(start_station_name, member_rides), x = member_rides, fill = "member"), width = 0.5, position = "stack") +
  ylab(NULL) +
  xlab(NULL) +
  ggtitle("Top 20 Member Start Stations by Total Rides") +
  theme_minimal() +
  theme(axis.text.x = element_text(hjust = 1),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.box = "horizontal")

# top 20 casual start stations
full_tripdata %>%
  filter(!is.na(start_station_name), !is.na(start_station_id)) %>% 
  group_by(start_station_id, start_station_name) %>% 
  summarise(total_rides = n(),
            casual_rides = sum(ifelse(member_casual == "casual", 1, 0)),
            member_rides = sum(ifelse(member_casual == "member", 1, 0))) %>% 
  arrange(desc(casual_rides)) %>%
  head(20) %>% 
  ggplot(aes(y = reorder(start_station_name, casual_rides), x = total_rides)) +
  geom_col(aes(fill = "member"), width = 0.5, position = "stack") +
  geom_col(aes(y = reorder(start_station_name, casual_rides), x = casual_rides, fill = "casual"), width = 0.5, position = "stack") +
  ylab(NULL) +
  xlab(NULL) +
  ggtitle("Top 20 Casual Start Stations by Total Rides") +
  theme_minimal() +
  theme(axis.text.x = element_text(hjust = 1),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.box = "horizontal")


# Top 20 end stations
full_tripdata %>%
  filter(!is.na(end_station_name), !is.na(end_station_id)) %>% 
  group_by(end_station_id, end_station_name) %>% 
  summarise(total_rides = n(),
            casual_rides = sum(ifelse(member_casual == "casual", 1, 0)),
            member_rides = sum(ifelse(member_casual == "member", 1, 0))) %>% 
  arrange(desc(total_rides)) %>%
  head(20) %>% 
  ggplot(aes(y = reorder(end_station_name, total_rides), x = total_rides)) +
  geom_col(aes(fill = "casual"), width = 0.5, position = "stack") +
  geom_col(aes(y = reorder(end_station_name, total_rides), x = member_rides, fill = "member"), width = 0.5, position = "stack") +
  ylab(NULL) +
  xlab(NULL) +
  ggtitle("Top 20 End Stations by Total Rides") +
  theme_minimal() +
  theme(axis.text.x = element_text(hjust = 1),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.box = "horizontal")



# 7 HEATMAP

library(ggmap)
library(RColorBrewer)

# Create a bounding box for the data
chicago_bb <- matrix(
  c(-87.7, 41.76, -87.55, 41.97),
  nrow = 2,
  ncol = 2,
  dimnames = list(c("x", "y"), c("min", "max"))
)

# Get the map of Chicago using the bounding box coordinates
chicago_map <- get_stamenmap(bbox = c(-87.75, 41.78, -87.55, 41.97), 
                             source = "stamen",
                             maptype = "toner-lite",
                             zoom = 12)
# Plot the empty map
ggmap(chicago_map)

# Casual rides heatmap tibble
full_tripdata_casual <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id),
         member_casual == "casual"
  )

# casual rides heatmap
ggmap(chicago_map) + 
  stat_density2d(data=full_tripdata_casual,  aes(x=start_lng, y=start_lat, fill=..level.., alpha= ..level..), geom="polygon") +
  scale_fill_gradientn(colours=rev(brewer.pal(7, "Spectral")))


# Save casual rides heatmap
ggsave(filename="./casual_heatmap_1.png")


# Member rides heatmap tibble
full_tripdata_member <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id),
         member_casual == "member"
  )

# Member rides heatmap
ggmap(chicago_map) + 
  stat_density2d(data=full_tripdata_member,  aes(x=start_lng, y=start_lat, fill=..level.., alpha= ..level..), geom="polygon") +
  scale_fill_gradientn(colours=rev(brewer.pal(7, "Spectral")))

# Save member rides heatmap
ggsave(filename="./member_heatmap_1.png")



# 8 ROUTES

# Casual Top Routes (500+ rides)
routes_casual <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id),
         member_casual == "casual") %>% 
  group_by(start_station_id, start_station_name, end_station_id, end_station_name) %>% 
  summarise( start_lat = median(start_lat),
             start_lng = median(start_lng),
             end_lat = median(end_lat),
             end_lng = median(end_lng),
             total_rides = n()
  ) %>% 
  filter(total_rides > 500) %>% 
  mutate(start_lat = if_else(start_lat == end_lat, start_lat + 0.00001, start_lat)) %>% 
  mutate(start_lng = if_else(start_lng == end_lng, start_lng + 0.00001, start_lng))


ggmap(chicago_map) + 
  geom_curve(routes_casual, mapping = aes(x = start_lng, y = start_lat, xend = end_lng, yend = end_lat, 
                                          alpha= total_rides, color = total_rides),
             size = 0.5, curvature = .2, arrow = arrow(length=unit(0.2,"cm"), ends="first", type = "closed")) +
  coord_cartesian() +
  labs(title = "Top Routes by Casual Users, 500+ Rides",x=NULL,y=NULL) +
  theme(legend.position="right")

ggsave(filename="./casual_top_routes_500.png")

# Casual Top Routes Classic Bike (250+ rides)
routes_casual_classic <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id),
         member_casual == "casual",
         rideable_type == "classic_bike") %>% 
  group_by(start_station_id, start_station_name, end_station_id, end_station_name) %>% 
  summarise( start_lat = median(start_lat),
             start_lng = median(start_lng),
             end_lat = median(end_lat),
             end_lng = median(end_lng),
             total_rides = n()
  ) %>% 
  filter(total_rides > 250) %>% 
  mutate(start_lat = if_else(start_lat == end_lat, start_lat + 0.00001, start_lat)) %>% 
  mutate(start_lng = if_else(start_lng == end_lng, start_lng + 0.00001, start_lng))


ggmap(chicago_map) + 
  geom_curve(routes_casual_classic, mapping = aes(x = start_lng, y = start_lat, xend = end_lng, yend = end_lat, 
                                                  alpha= total_rides, color = total_rides),
             size = 0.5, curvature = .2, arrow = arrow(length=unit(0.2,"cm"), ends="first", type = "closed")) +
  coord_cartesian() +
  labs(title = "Top Routes by Casuals, Classic Bike, 250+ Rides",x=NULL,y=NULL) +
  theme(legend.position="right")

ggsave(filename="./casual_top_routes_classic_250.png")


# Casual Top Routes Electric Bike (250+ rides)
routes_casual_electric <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id),
         member_casual == "casual",
         rideable_type == "electric_bike") %>% 
  group_by(start_station_id, start_station_name, end_station_id, end_station_name) %>% 
  summarise( start_lat = median(start_lat),
             start_lng = median(start_lng),
             end_lat = median(end_lat),
             end_lng = median(end_lng),
             total_rides = n()
  ) %>% 
  filter(total_rides > 250) %>% 
  mutate(start_lat = if_else(start_lat == end_lat, start_lat + 0.00001, start_lat)) %>% 
  mutate(start_lng = if_else(start_lng == end_lng, start_lng + 0.00001, start_lng))


ggmap(chicago_map) + 
  geom_curve(routes_casual_electric, mapping = aes(x = start_lng, y = start_lat, xend = end_lng, yend = end_lat, 
                                                   alpha= total_rides, color = total_rides),
             size = 0.5, curvature = .2, arrow = arrow(length=unit(0.2,"cm"), ends="first", type = "closed")) +
  coord_cartesian() +
  labs(title = "Top Routes by Casuals, Electric Bike, 250+ Rides",x=NULL,y=NULL) +
  theme(legend.position="right")

ggsave(filename="./casual_top_routes_electric_250.png")



# Member Top Routes (500+ rides)
routes_member <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id),
         member_casual == "member") %>% 
  group_by(start_station_id, start_station_name, end_station_id, end_station_name) %>% 
  summarise( start_lat = median(start_lat),
             start_lng = median(start_lng),
             end_lat = median(end_lat),
             end_lng = median(end_lng),
             total_rides = n()
  ) %>% 
  filter(total_rides > 500) %>% 
  mutate(start_lat = if_else(start_lat == end_lat, start_lat + 0.00001, start_lat)) %>% 
  mutate(start_lng = if_else(start_lng == end_lng, start_lng + 0.00001, start_lng))


ggmap(chicago_map) + 
  geom_curve(routes_member, mapping = aes(x = start_lng, y = start_lat, xend = end_lng, yend = end_lat, 
                                          alpha= total_rides, color = total_rides),
             size = 0.5, curvature = .2, arrow = arrow(length=unit(0.2,"cm"), ends="first", type = "closed")) +
  coord_cartesian() +
  labs(title = "Top Routes by Members, 500+ Rides",x=NULL,y=NULL) +
  theme(legend.position="right")

ggsave(filename="./member_top_routes_500.png")

# Member Top Routes Classic Bike (250+ rides)
routes_member_classic <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id),
         member_casual == "member",
         rideable_type == "classic_bike") %>% 
  group_by(start_station_id, start_station_name, end_station_id, end_station_name) %>% 
  summarise( start_lat = median(start_lat),
             start_lng = median(start_lng),
             end_lat = median(end_lat),
             end_lng = median(end_lng),
             total_rides = n()
  ) %>% 
  filter(total_rides > 250) %>% 
  mutate(start_lat = if_else(start_lat == end_lat, start_lat + 0.00001, start_lat)) %>% 
  mutate(start_lng = if_else(start_lng == end_lng, start_lng + 0.00001, start_lng))


ggmap(chicago_map) + 
  geom_curve(routes_member_classic, mapping = aes(x = start_lng, y = start_lat, xend = end_lng, yend = end_lat, 
                                                  alpha= total_rides, color = total_rides),
             size = 0.5, curvature = .2, arrow = arrow(length=unit(0.2,"cm"), ends="first", type = "closed")) +
  coord_cartesian() +
  labs(title = "Top Routes by Members, Classic Bike, 250+ Rides",x=NULL,y=NULL) +
  theme(legend.position="right")

ggsave(filename="./member_top_routes_classic_250.png")


# Member Top Routes Electric Bike (250+ rides)
routes_member_electric <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id),
         member_casual == "member",
         rideable_type == "electric_bike") %>% 
  group_by(start_station_id, start_station_name, end_station_id, end_station_name) %>% 
  summarise( start_lat = median(start_lat),
             start_lng = median(start_lng),
             end_lat = median(end_lat),
             end_lng = median(end_lng),
             total_rides = n()
  ) %>% 
  filter(total_rides > 250) %>% 
  mutate(start_lat = if_else(start_lat == end_lat, start_lat + 0.00001, start_lat)) %>% 
  mutate(start_lng = if_else(start_lng == end_lng, start_lng + 0.00001, start_lng))


ggmap(chicago_map) + 
  geom_curve(routes_member_electric, mapping = aes(x = start_lng, y = start_lat, xend = end_lng, yend = end_lat, 
                                                   alpha= total_rides, color = total_rides),
             size = 0.5, curvature = .2, arrow = arrow(length=unit(0.2,"cm"), ends="first", type = "closed")) +
  coord_cartesian() +
  labs(title = "Top Routes by Members, Electric Bike, 250+ Rides",x=NULL,y=NULL) +
  theme(legend.position="right")

ggsave(filename="./member_top_routes_electric_250.png")







# 8.1 ROUTES (LEAFLET)


# Casual Top Routes (500+ rides)
routes_casual_1 <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id),
         member_casual == "casual") %>% 
  group_by(start_station_id, start_station_name, end_station_id, end_station_name) %>% 
  summarise( start_lat = median(start_lat),
             start_lng = median(start_lng),
             end_lat = median(end_lat),
             end_lng = median(end_lng),
             total_rides = n()
  ) %>% 
  filter(total_rides > 500) %>%
  arrange(desc(total_rides)) %>% 
  mutate(start_lat = if_else(start_lat == end_lat, start_lat + 0.00001, start_lat)) %>% 
  mutate(start_lng = if_else(start_lng == end_lng, start_lng + 0.00001, start_lng)) %>% 
  head(25)

# Create the map
chicago_map <- leaflet() %>%
  setView(lng = -87.65, lat = 41.88, zoom = 11) %>%
  addProviderTiles("CartoDB.PositronNoLabels") %>%
  addTiles(options = providerTileOptions(noWrap = TRUE, minZoom = 0, maxZoom = 18, opacity = 1, 
                                         attribution = 'Map tiles by <a href="https://carto.com/attribution">CARTO</a>, under <a href="https://creativecommons.org/licenses/by/3.0/">CC BY 3.0</a>. Data by <a href="https://www.openstreetmap.org/">OpenStreetMap</a>, under <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC BY SA</a>.'),
           group = "Map Tiles") %>%
  addTiles(urlTemplate = "https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_nolabels/{z}/{x}/{y}.png", 
           group = "Grayscale Map Tiles")

rm(polyline, i, row)

# Add the polylines representing the routes with adjusted opacity
# Iterate over each row and add the polyline
for (i in 1:nrow(routes_casual)) {
  row <- routes_casual[i, ]
  polyline <- addPolylines(
    chicago_map,
    data = row,
    lng = c(row$start_lng, row$end_lng),
    lat = c(row$start_lat, row$end_lat),
    color = if (row$total_rides / max(routes_casual$total_rides) > 0.75) {
      "#8F111D"
    } else if (row$total_rides / max(routes_casual$total_rides) > 0.5 &&
               row$total_rides / max(routes_casual$total_rides) <= 0.75 ) {
      "#BD1628"
    } else if (row$total_rides / max(routes_casual$total_rides) > 0.25 &&
               row$total_rides / max(routes_casual$total_rides) <= 0.5 ) {
      "#D31122"
    } else if (row$total_rides / max(routes_casual$total_rides) > 0.1 &&
               row$total_rides / max(routes_casual$total_rides) <= 0.25 ) {
      "#F1202B"
    } else if (row$total_rides / max(routes_casual$total_rides) <= 0.1) {
      "#F63C41"
    },
    opacity = if (row$total_rides / max(routes_casual$total_rides) > 0.75) {
      1
    } else if (row$total_rides / max(routes_casual$total_rides) > 0.5 &&
               row$total_rides / max(routes_casual$total_rides) <= 0.75 ) {
      0.75
    } else if (row$total_rides / max(routes_casual$total_rides) > 0.25 &&
               row$total_rides / max(routes_casual$total_rides) <= 0.5 ) {
      0.5
    } else if (row$total_rides / max(routes_casual$total_rides) > 0.1 &&
               row$total_rides / max(routes_casual$total_rides) <= 0.25 ) {
      0.3
    } else if (row$total_rides / max(routes_casual$total_rides) <= 0.1) {
      0.2
    },
    weight = row$total_rides / max(routes_casual$total_rides) * 7
  )
  
  chicago_map <- polyline
}

chicago_map





# Additional Tibbles for Tableau

# Top Routes Tibble for Tableau
top_routes <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id)) %>% 
  group_by(start_station_id, start_station_name, end_station_id, end_station_name, member_casual, rideable_type) %>% 
  summarise( start_lat = median(start_lat),
             start_lng = median(start_lng),
             end_lat = median(end_lat),
             end_lng = median(end_lng),
             total_rides = n()
  ) %>% 
  filter(total_rides > 0) %>% 
  mutate(start_lat = if_else(start_lat == end_lat, start_lat + 0.00001, start_lat)) %>% 
  mutate(start_lng = if_else(start_lng == end_lng, start_lng + 0.00001, start_lng))


# Top Routes Tibble for Tableau
top_routes_100 <-  full_tripdata %>%
  filter(!is.na(start_station_name),
         !is.na(start_station_id),
         !is.na(end_station_name),
         !is.na(end_station_id)) %>% 
  group_by(start_station_id, start_station_name, end_station_id, end_station_name, member_casual, rideable_type) %>% 
  summarise( start_lat = median(start_lat),
             start_lng = median(start_lng),
             end_lat = median(end_lat),
             end_lng = median(end_lng),
             total_rides = n()
  ) %>% 
  filter(total_rides > 100) %>% 
  mutate(start_lat = if_else(start_lat == end_lat, start_lat + 0.00001, start_lat)) %>% 
  mutate(start_lng = if_else(start_lng == end_lng, start_lng + 0.00001, start_lng))



# EXPORT RESULTS

#Save to CSV
write.csv(full_tripdata, "D:/R/R Projects/DivvyBikes/results/divvybikes_f2022_j2023.csv", row.names=FALSE)
write.csv(top_routes, "D:/R/R Projects/DivvyBikes/results/top_routes.csv", row.names=FALSE)



### ADDENDUM ###



### REMINDER ###