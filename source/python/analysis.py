import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

sector_time = pd.read_csv('sector_time.csv')
sector_time = sector_time.dropna()
# delete rows with negative and equall to 0 values of delivery duration 
sector_time = sector_time[sector_time['real_delivery_duration'] > 0]

time = pd.to_numeric(sector_time['real_delivery_duration'])
planned_time = pd.to_numeric(sector_time['planned_delivery_duration'])
sector = pd.to_numeric(sector_time['sector_id'])

# delete 2% biggest and 2% smallest values 
# time_cleaned = time[(time < time.quantile(0.98)) & (time > time.quantile(0.02))]
time_cleaned = time
# # difference between planned and real time
diff_planned_real_time = planned_time - time_cleaned

avg = time_cleaned.mean()
print(f"Average time: {avg}")
# changing the time to minutes
diff_planned_real_time_minutes = np.ceil(diff_planned_real_time/60)
time_minutes = np.ceil(time_cleaned / 60)
avg_minutes = np.ceil(avg / 60)

nr_of_sectors = len(sector.unique())

plt.figure(figsize=(10, 6))
plt.hist(time_minutes, bins=8, label='Sectors')
plt.title('Distribution of delivery lengths')
plt.xlabel('Time (minutes)')
plt.ylabel('Frequency (number of deliveries)')
plt.savefig(f'delivery_len_all_sectors.png')


plt.figure(figsize=(10, 6))
plt.hist(diff_planned_real_time_minutes, bins=8, label='Sectors')
plt.title('Distribution of the differences between planned and real delivery lengths')
plt.xlabel('Time (minutes)')
plt.ylabel('Frequency (number of deliveries)')
plt.savefig(f'diff_delivery_len_all_sectors.png')

for i in range(1, nr_of_sectors + 1):
    print(f"Average time for sector {i}: {time_minutes[sector == i].mean()}")
    plt.figure(figsize=(10, 6))
    plt.hist(time_minutes[sector == i], bins=8)
    plt.title(f'Distribution of delivery lengths sector {i}')
    plt.xlabel('Time (minutes)')
    plt.ylabel('Frequency (number of deliveries)')
    plt.savefig(f'delivery_len_sector_{i}.png')

for i in range(1, nr_of_sectors + 1):
    plt.figure(figsize=(10, 6))
    plt.hist(diff_planned_real_time_minutes[sector == i], bins=8)
    plt.title(f'Distribution of the differences between planned and real delivery lengths sector {i}')
    plt.xlabel('Time (minutes)')
    plt.ylabel('Frequency (number of deliveries)')
    plt.savefig(f'diff_ delivery_len_sector_{i}.png')





