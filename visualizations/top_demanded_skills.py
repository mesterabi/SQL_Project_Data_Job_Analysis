import json
import pandas as pd
import matplotlib.pyplot as plt

# JSON data from results
data = [
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "92628"
  },
  {
    "skill_id": 181,
    "skills": "excel",
    "demand_count": "67031"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "57326"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "46554"
  },
  {
    "skill_id": 183,
    "skills": "power bi",
    "demand_count": "39468"
  }
]

# Load into DataFrame
df = pd.DataFrame(data)
df['demand_count'] = pd.to_numeric(df['demand_count'])
df = df.sort_values(by='demand_count', ascending=False)

# Plot
fig, ax = plt.subplots(figsize=(10, 6))
ax.bar(df['skills'], df['demand_count'], color='orange')
ax.set_ylabel('Demand Count')
ax.set_title('Top 5 In-Demand Skills for Data Analysts')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.savefig('top_demanded_skills.png')  # Save to file