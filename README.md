# Order Tracking App

This Flutter-based application enables users to track their orders in real-time. It incorporates Firebase Auth for user authentication and Ably Realtime for live updates on order statuses.

## Technologies Used

- **Flutter:** The framework used for building the mobile application.
- **Stacked Architecture:** Employed the MVVM pattern through the Stacked package for structured development.
    - [Stacked documentation](https://pub.dev/packages/stacked)
- **Gorouter:** Routing system utilized for navigation within the app.
- **Get_it:** Dependency injection tool utilized to manage class dependencies.
- **Firebase Auth:** Integrated for user authentication purposes.
- **Google_sign_in package:** Used for enabling Google and GitHub authentication.
- **Ably_flutter:** Implemented for real-time updates on order statuses.

## Pages and Functionality

### Homepage:
- Displays a list of orders.
- Initialization includes the instantiation of the AblyService class and registering it with Get_it.
- Opens a connection to Ably for real-time updates.

### Order Detail Page:
- Displays the full details of a selected order, including:
    - Order ID
    - Order Date
    - Order Item
    - Order Quantity
    - Order Price
- Real-time updates for order statuses from Ably.
- Seamlessly switches between the homepage and order detail page while tracking orders in real-time.

## Ably Service Class

### Methods

- **openConnection:**
    - Initializes the AblyService class and creates a connection to the Ably server.
    - This connection is persisted throughout the app's lifecycle.

- **subscribeToOrderChannel(orderId):**
    - Subscribes to the order channel by passing a specific order ID.
    - Utilizes a unique channel name for each order to manage subscriptions efficiently.
    - In this case, while testing with only one order, a unique channel name is used for testing purposes.

## Order Service Class

### Methods

- **mockOrders:**
    - Initializes and creates a sample order stored in a reactive value.
    - Could be enhanced by allowing the creation of multiple sample orders for diverse test scenarios.

- **getOrder:**
    - Retrieves an order by ID.

- **updateOrderStatus:**
    - Called when the Ably Service class receives a message from the subscription to update an order's status.

## Possible Enhancements

- **addMockOrder method:**
    - Capability to generate new orders programmatically for additional test cases, expanding test coverage.

- **Update Order Status Method:**
    - Implement a function that allows updating an order's status from the application UI, triggered by a button click. This simulates status updates initiated by the user within the app.

- **Utility Class Extraction:**
    - Extract common functionalities like DateTime and string manipulation into utility classes for better organization and reusability.

## Using the App

To utilize the application effectively, follow these steps:

1. Replace the key in the Ably Service class with your Ably API key.
2. To simulate real-time updates from the server, subscribe to the "order_1" channel (default order in this case) using the Ably dashboard console.
3. To push a message from the Ably dashboard console:
    - Set the event name as "order update".
    - The message data should be in the format:

   ```json
   {
     "orderId": 1,
     "status": "ORDER_DELIVERED"
   }


        Where orderId represents the ID of the order and status is the order status enum.

Implementing these enhancements and instructions will improve the app's functionality, expand test coverage, and enable better management of order statuses and real-time updates.

Conclusion

The app successfully integrates Firebase Auth and Ably Realtime to provide users with a seamless order tracking experience. The architecture's use of Stacked along with Gorouter and Get_it allows for maintainable and scalable development.