### Summary


This is a recipe app built using Swift and Xcode. The app fetches data from a JSON source and displays recipes in a two-column grid layout. Each recipe includes an image, a title, and a button to watch a YouTube video if one is available. Users can tap an image to view a larger version along with the full recipe name. The app also provides an option to sort recipes by cuisine. If the data is malformed or empty, a "No Recipes Available" screen is displayed.

### 📱 Screenshots

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/e09e4282-61ea-473b-a8ea-e99aa24d4168" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/a17770a9-da84-48b1-a99e-1d22a5f597a3" width="300"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/790a0bce-7c3c-4e6c-b107-9911f768d829" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/37bc121d-cd90-4932-8d32-dbe84653c183" width="300"></td>
  </tr>
</table>




### Focus Areas

I really wanted to prioritize JSON processing and ensure the data is clean, structured, and reliable. In my experience building apps, I've found that when data integrity is handled properly from the start, front-end issues become much easier to diagnose and fix. A well-structured data flow prevents hidden bugs and reduces the risk of deeply rooted problems that can be difficult to resolve later.



### Time Spent
The project took around six hours in total, involving some trial and error with data processing. I started by planning how I wanted to structure and parse the JSON to ensure a smooth setup for the UI. Next, I created a brief sketch of the interface and outlined the features I wanted, such as the ability to tap an image to view it in full screen. After finalizing the design, I spent a few hours implementing and testing until I had a product I was satisfied with.


### Trade-offs and Decisions

One trade-off I had to make was depending on my time. I wanted to make sure the data was processed well and efficiently, so I ended up spending less time on the UI. Another trade-off was choosing to cache images in the file system rather than just using in-memory caching, which ensures persistence but could lead to increased storage usage over time.



### Weakest Part of the Project

I think the weakest part of my project would be my UI/UX. There are definitely some things I would have liked to continue adding to enhance the user experience and improve the overall look and feel. Given more time, I would refine the layout, add more interactive elements, and ensure a smoother, more responsive design. Despite these constraints, I’m happy with how the project turned out and see it as a strong foundation for future improvements.




### Additional Information

One of the biggest constraints I faced was balancing **time and scope**. While I was able to prioritize clean JSON processing and caching, I didn’t have enough time to refine the UI as much as I wanted.  

For future improvements, I would like to:
- Add **offline storage** so users can access recipes without an internet connection.
- Improve the **UI layout** with animations and a more modern design.
- Introduce **a search feature** to quickly filter recipes.  

A key challenge I encountered was **efficiently handling image caching** while keeping memory usage low. I learned how to combine file system storage with NSCache to improve performance, which was a valuable takeaway from this project. 
how does this look overall 
