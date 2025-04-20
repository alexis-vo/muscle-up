import matplotlib.pyplot as plt

class WeeklyProgressPlot:
    def __init__(self, df):
        self.df = df

    def show(self):
        plt.figure(figsize=(10, 6))
        for athlete in self.df['surname'].unique():
            sub_df = self.df[self.df['surname'] == athlete]
            plt.plot(sub_df['week'], sub_df['total_reps'], marker='o', label=athlete)

        plt.title("Weekly Progress - Total Reps per Athlete")
        plt.xlabel("Week")
        plt.ylabel("Total Repetitions")
        plt.legend()
        plt.grid(True)
        plt.xticks(rotation=45)
        plt.tight_layout()
        plt.show()
        print("✅ Plot displayed successfully!")