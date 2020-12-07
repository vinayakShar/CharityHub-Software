![Logo](./Website/public/img/logo.png)

# About

Our mission is to provide a simple and accessible hub for charities, non-profits, and disaster-relief organizations to find potential donors, from casual users to philanthropists.

The goal of this project is to provide a simple and accessible way for charities, nonprofits, and disaster-relief organizations to expand their reach to potential donors. The foundation of our system would be to allow people who have philanthropic interests to access an organized system to find charities and resources that help them put money towards helping missions that are important to them. We want to bring a relative easy to the process of donating towards a charity. Oftentimes it can be hard to find a charity that matches your intended mission, and can take a lot of research to ensure that the money is being put towards positive aspects.

This website is a non-profit centralized database that provides a straight-forward and accessible way for common people to find charities catered to their interests or relevant to their situations. It will also provide a streamlined way for people to start their own charities or foundations by listing all necessary steps to establish themselves, as well as allow them to upload a statement with their statistics and goals to help them be categorized and recommended to users.

# Team Members

- Philip Knott
- Vinayak Sharma
- Joseph Nam
- Micah Cook
- Jacob Line
- Matthew Eccles

# CharityHub

The latest release of our project can be found on Heroku here: https://charity-hub-dev.herokuapp.com/

# Repo Organization Structure

The lastest code for our website is found within /Website/

A local version of our database can be recreated with CharityHub.sql

Project milestones can be found within /MILESTONES/

TESTING 

-To run/test code on a local machine, run "node app.js" and go to localhost:8080. Make sure to have npm install.


-PayPal Test Payment Credentials
//Can use these to make payments to sandbox (try not to spend it all)

User Name:
sb-fl0g03965234@personal.example.com

Password:
cF7*?|Au



-Heroku postgreSQL Credentials for DB Testing/Viewing

Host
    ec2-34-232-24-202.compute-1.amazonaws.com
Database
    da21001os1ce9n
User
    ccymiucxeppyjz
Port
    5432
Password
    facdd2d9c5c6beec0a7c23a93983082695eec0fc5460e67ae3f8bcbae31ebd9e
URI
    postgres://ccymiucxeppyjz:facdd2d9c5c6beec0a7c23a93983082695eec0fc5460e67ae3f8bcbae31ebd9e@ec2-34-232-24-202.compute-1.amazonaws.com:5432/da21001os1ce9n
Heroku CLI
    heroku pg:psql postgresql-rectangular-14472 --app charity-hub-dev
