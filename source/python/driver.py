import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

# Read the csv file
sector_time = pd.read_csv('driver_time.csv')
sector_time = sector_time.dropna()
sector_time = sector_time[sector_time['real_delivery_duration'] >= 0]

time = pd.to_numeric(sector_time['real_delivery_duration'])
planned_time = pd.to_numeric(sector_time['planned_delivery_duration'])
sector = pd.to_numeric(sector_time['sector_id'])
driver_id = pd.to_numeric(sector_time['driver_id'])


# delete 2% biggest and 2% smallest values (could be done in sql too)
# it was done in sql

# time_cleaned = time[(time < time.quantile(0.98)) & (time > time.quantile(0.02))]

time_cleaned = time
diff_planned_real_time = planned_time - time_cleaned

diff_planned_real_time_minutes = np.ceil(diff_planned_real_time/60)
time_minutes = np.ceil(time_cleaned / 60)

nr_of_sectors = len(sector.unique())
nr_of_driver = len(driver_id.unique())

for i in range(1, nr_of_driver + 1):
    plt.figure(figsize=(10, 6))
    plt.hist(diff_planned_real_time_minutes[driver_id==i], bins=8)
    plt.title(f'Distribution of the difference between planned and actual delivery durations by driver{i}')
    plt.xlabel('Time (minutes)')
    plt.ylabel('Frequency (number of deliveries)')
    plt.savefig(f'driver_{i}_diff_time.png')






