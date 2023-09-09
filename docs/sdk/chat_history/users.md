# Users

Just like [`Sessions`](sessions.md), `Users` are a fundamental part of the Zep Memory Store. A `User` represents an individual interacting with your application. Each `User` can have multiple `Sessions` associated with them, allowing you to track and manage the interactions of a user over time.

The `UserID` is a unique identifier for each user. This can be any string value - for example, it could be a username, an email address, or a UUID. You can also store additional data related to the user in the `metadata` field.

The `User` object and its associated `Sessions` provide a powerful way to manage and understand the behavior of individuals using your application. By associating `Sessions` with `Users`, you can track the progression of conversations and interactions over time, providing valuable context and history.

In the following sections, you will learn how to manage `Users` and their associated `Sessions`.

## The `User` model

You can associate rich business context with a `User`:

- `user_id`: A unique identifier of the user that maps to your internal User ID.
- `email`: The user's email.
- `first_name`: The user's first name.
- `last_name`: The user's last name.
- `metadata`: Any additional data associated with the user.


## Adding a User

You can add a new user by providing the user details.

=== ":fontawesome-brands-python: Python"

    ```python
    user_request = CreateUserRequest(
        user_id=user_id,
        email="user@example.com",
        first_name="Jane",
        last_name="Smith",
        metadata={"foo": "bar"},
    )
    new_user = client.user.add(user_request)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    const user: ICreateUserRequest = {
        user_id: "user123",
        metadata: { foo: "bar" },
    };
    const newUser = await client.user.add(user);
    ```

> Learn how to associate [`Sessions` with Users](sessions.md)

## Getting a User

You can retrieve a user by their ID.

=== ":fontawesome-brands-python: Python"

    ```python
    user = client.user.get("user123")
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    const user = await client.user.get("user123");
    ```

## Updating a User

You can update a user's details by providing the updated user details.

=== ":fontawesome-brands-python: Python"

    ```python
    user_request = UpdateUserRequest(
        user_id=user_id,
        email="updated_user@example.com",
        first_name="Jane",
        last_name="Smith",
        metadata={"foo": "updated_bar"},
    )
    updated_user = client.user.update(user_request)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    const user: IUpdateUserRequest = {
        user_id: "user123",
        metadata: { foo: "baz" },
    };
    const updatedUser = await client.user.update(user);
    ```

## Deleting a User

You can delete a user by their ID.

=== ":fontawesome-brands-python: Python"

    ```python
    client.user.delete("user123")
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    await client.user.delete("user123");
    ```



## Getting a User's Sessions

You can retrieve all `Sessions` for a user by their ID.

=== ":fontawesome-brands-python: Python"

    ```python
    # Get all sessions for user123
    sessions = client.user.getSessions("user123")
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    // Get all sessions for user123
    const sessions = await client.user.getSessions("user123");
    ```

## Listing Users

You can list all users, with optional limit and cursor parameters for pagination.

=== ":fontawesome-brands-python: Python"

    ```python
    # List the first 10 users
    users = client.user.list(limit=10, cursor=0)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    // List the first 10 users
    const users = await client.user.list(10, 0);
    ```

## Listing Users in Chunks

You can retrieve users in chunks of a specified size. This is a generator function that yields each chunk of users as they are retrieved.

=== ":fontawesome-brands-python: Python"

    ```python
    for users in client.user.listChunked(chunkSize=100):
        process(users)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    for await (const users of client.user.listChunked(100)) {
        process(users);
    }
    ```

