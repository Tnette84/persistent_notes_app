# Week 12 – Persistent Notes App

## Phase 1: Theme Settings

In this phase, I added the shared_preferences package to save the Dark Mode setting. I created methods to save and load the setting and added a switch to turn Dark Mode on and off. I tested the app on Windows and confirmed that Dark Mode stayed on after closing and reopening the app.

## Phase 2: File Storage

In this phase, I added the path_provider package and created a text field and Save Note button. I used Dart file operations to save notes to a local text file. I tested the app and confirmed that the saved note appeared in the terminal.

## Phase 3: Restoring Saved Notes

In this phase, I added a method to load saved notes when the app starts. I used fileExists checking to prevent errors if the file is missing. I tested the app and confirmed that my saved note appeared automatically after reopening it.

## Phase 4: Final Testing and Validation

In this phase, I tested the Dark Mode switch, saved preferences, note saving, and automatic note loading. The application ran successfully on Windows, and the saved settings and notes were restored after restarting the app.