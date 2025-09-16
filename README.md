# Student Portal MVP

A user-centric web application designed to streamline the tracking of student progress and survey data, enabling users and administrators to gain insights into student performance and feedback. This application features tools for managing users, surveys, questions, and responses, with a focus on providing a clear and intuitive interface for both students and staff.

## 🚩 Problem Statement

DPI currently collect student applications for all PTTL programs through Qualtrics and manually ETL the data into Salesforce. This process is not automated, makes duplicate detection difficult (especially when students use different emails), and is time-consuming. We are seeking developer support to build a more efficient, automated solution.

## 🎯 Project Goals

-   Replace manual ETL with automated data sync
-   Enable students to manage their own profiles and applications
-   Improve data accuracy and reduce administrative workload

## 💡 Proposed Features

-   Student login portal
-   Profile and application management
-   Two-way sync with Salesforce
-   Duplicate detection logic
-   Admin dashboard

## 🚫 Constraints

-   No paid third-party tools or apps

## User Flow

1.  **Login/Sign up:** Users can log/sign up in to the application using their email and password.
2.  **Import CSV:** Users can import CSV files from Qualtrics surveys. The application will:
    *   Import all responses from the CSV.
    *   Create new surveys if they don't already exist.
    *   Import all questions from the survey if they are not already created.
3.  **View Data:** Users can visually view each survey, each response, and all the questions and answers associated with them.

## Qualtrics CSV Export Guide

When exporting data from Qualtrics to be used with this application, please use the following settings:

-   Download all fields
-   Export labels
-   Remove line breaks
-   Split multi-line fields into columns
-   Use internal IDs in header

## Technologies Used

-   Rails 8.0.2.1
-   Ruby 3.4.5
-   PostgreSQL
-   Hotwire (Turbo & Stimulus)
-   Importmap
-   Puma

## Services Used

-   **Render:** For application deployment.
-   **Xata.io:** For the production PostgreSQL database.
-   **Salesforce:** For data integration.

## Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/trailsofink/student_portal_mvp.git
    cd student_portal_mvp
    ```

2.  Install the dependencies:
    ```bash
    bundle install
    ```

3.  Set up the database:
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  Start the development server:
    ```bash
    bin/dev
    ```


