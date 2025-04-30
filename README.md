## ![Hunger404](https://github.com/user-attachments/assets/18f08c94-26bc-40a6-b3ec-250275493be4)
Welcome to Hunger404, where suddenly, your hunger can no longer be found. Hunger404 is a simple iOS application availble for iOS 16+ designed to give users access to easy-to-follow recipes curated by our team of expert food gurus.

### Main Dashboard
![Screenshot 2025-04-29 at 3 56 43 PM](https://github.com/user-attachments/assets/cb46ec44-78da-4eb2-91c1-9cf9fe7d69eb)

### Recipe Details
![Screenshot 2025-04-29 at 3 57 09 PM](https://github.com/user-attachments/assets/2e2bbe43-a24a-4eba-b9f0-d905022c98d4)

### Search by Title or Cuisine
![Screenshot 2025-04-29 at 3 58 47 PM](https://github.com/user-attachments/assets/017305e1-0efd-4c4b-9083-cc2955aa2f47)

## Focus Areas
The majority of focus throughout this project went towards achieving the highest level of an industry feel possible. With only one production app under my belt as a developer, my only product to reach the app store served more as a testing ground than a polished production piece. For this project, I wanted to take what I have learned and use it to create a solid app that doesn't take any unnecessary risks, while still having as much character as possible from me as a developer.

Alongside that, alot of focus went into potential bug mitigation and network optimization, making sure that the app would remain smooth should it scale in the future with its current handling of network calls. I also put a considerable amount of thought into the best way to layout the app's code structure so that it would remain easy to maintain should it scale in the future. Currently, its a relatively simple MVVM structure, although its one that could likely be improved upon in the future due to my inexperience.

## Time Spent
From start to finish, I spent somewhere in the ballpark of 20 hours working on this project. I could have probably achieved the same result in 14-16 hours, but like every project, there were several points throughout the process that ended up taking longer to work through than I anticipated. 

First among these was initial project startup and design decisions, both from a project layout and UI design perspective; I wanted to make sure I had a solid foundation that I was going to like throughout the project before I started to prevent any significant changes halfway through. After this was set, the next big time sink for me was setting up the cache system and thoroughly testing it to make sure it behaved as expected. I don't have alot of experience with NSCache, so this took a little longer than expected, but I am very pleased with how it turned out.

## Trade-offs and Decisions
The most difficult challenge throughout this project for was finding ways to be innovative and unique while retaining the aformentioned production quality feel, given the minimal project constraints. The biggest trade off I believe I made in this project is the decision to go for a more sleek, minimal, usable UI design, favoring efficiency and usability over a design that tried to implement as many different features as possible.

When thinking about the target audience for this app, I pictured users that wanted quick access to fun options without the need to dig through features or without getting overwhelmed with choices. This led to the simple 1 page navigation structure, with no bottom tab bar, and the sleek search function on the main dashboard.

## Project Weaknesses
When looking at this project as a developer, I think the weakest part of the project is likely the way I have begun to implement the MVVM structure. While my other personal projects are structured using MVVM, my lack of experience in a real production setting, leads me to believe that my implementation is not ideal, and likely flawed in potentially significant ways when the app begins to scale. Overall project layouts are something that I am looking forward to learning more about in the future, and while I believe the current structure of this app is fine for now, I believe it remains the apps weakest link.

When looking at this project as a user, I think the UI/UX lacks depth. I think the app's dashboard page is a nice view with a good usable layout, but I would like to provide the user with more functionality when looking at a recipe's details page. In the future I would like to add a nice view for a recipe's instructions should the instruction data get added to the JSON being pulled by the app, as well as common tools needed when cooking like timers, alarms, etc.

## Additional Information
Overall, I greatly enjoyed this project. I like its simplicity and the freedom that developers have to express their creativity in the UI/UX design. I think the end result that I arrived at is nifty, although if the recipe data contained instructions, I believe my design could really flourish and turn into a more full bodied cooking companion.

Also worth noting, this is the first new project that I have started in quite a while, and I completely forgot to create branches/pull requests... every commit was pushed straight to main. Shame on me.
