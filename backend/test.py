import matplotlib.pyplot as plt

# Data
models = [
    "ECG-TX",
    "2x Layer BI-LSTM [8]",
    "CAA-TL (AlexNet) [9]",
    "CAA-TL (SqueezeNet) [9]",
    "CAA-TL (ResNet50) [9]",
    "SRCNN [13]",
]
accuracy = [99.98, 93.9, 98.38, 90.08, 91, 87.5]

# Plot
plt.figure(figsize=(6, 4))  # Reduce figure size
bars = plt.bar(models, accuracy, color="blue")
plt.ylabel("Accuracy (%)")
plt.xlabel("Models")
plt.ylim(85, 100)  # Set y-axis limits for better visualization
plt.xticks(rotation=30, ha="right")  # Adjust rotation to prevent overlap

# Add accuracy labels
for bar, acc in zip(bars, accuracy):
    plt.text(bar.get_x() + bar.get_width() / 2, acc + 0.3, f"{acc:.2f}%", ha="center")

# Save figure
plt.savefig("model_accuracy.png", dpi=400, bbox_inches="tight", pad_inches=0.1)
plt.show()
