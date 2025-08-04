# make_animation.R

# Load required libraries
library(readr)
library(dplyr)
library(ggplot2)
library(gganimate)
library(gifski)
library(png)

# Load the data
data <- read_csv("C:/Users/user/Desktop/projects/predicting-phone-addiction/teen_phone_addiction_dataset.csv")

# Convert School_Grade to ordered factor
data$School_Grade <- factor(data$School_Grade, 
                            levels = c("7th", "8th", "9th", "10th", "11th", "12th"),
                            ordered = TRUE)

# Create the animated ggplot with bright colors and bold labels
p <- ggplot(data, aes(x = Daily_Usage_Hours, 
                      y = Addiction_Level, 
                      color = Gender, 
                      size = Sleep_Hours)) +
  geom_point(alpha = 0.8, stroke = 0.8) +
  scale_color_manual(values = c("Male" = "#1E90FF", "Female" = "#FF69B4")) +  # Bright blue & pink
  scale_size_continuous(range = c(2, 10)) +
  labs(
    title = "📱 Teen Smartphone Usage vs. Addiction Level",
    subtitle = "School Grade: {closest_state}",
    x = "Daily Usage Hours",
    y = "Addiction Level (0–10)",
    color = "Gender",
    size = "Sleep Hours"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 20, color = "#4A148C"),
    plot.subtitle = element_text(size = 16, face = "italic"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    legend.title = element_text(face = "bold")
  ) +
  transition_states(School_Grade, transition_length = 4, state_length = 2) +  # Slower movement
  ease_aes('cubic-in-out')

# Render the animation with extended duration
anim <- animate(p, 
                width = 800, height = 600, 
                fps = 10, duration = 20,  # Increased from 8 to 20 seconds
                renderer = gifski_renderer())

# Save the animation
anim_save("C:/Users/user/Desktop/projects/predicting-phone-addiction/teen_addiction.gif", animation = anim)
