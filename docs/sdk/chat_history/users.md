# Users

The User API allows developers to manage users and their sessions. This includes adding, getting, updating, deleting, and listing users, as well as retrieving a user's sessions.

## Adding a User

You can add a new user by providing the user details.

=== ":fontawesome-brands-python: Python"
    ```python title="Add a User"
user = {
"user_id": "user123",

        "metadata": {"foo": "bar"}
    }
    new_user = await user_manager.add(user)
    `

=== ":simple-typescript: TypeScript"
`typescript title="Add a User"
    const user: ICreateUserRequest = {
        user_id: "user123",
        metadata: { foo: "bar" },
    };
    const newUser = await userManager.add(user);
    `

## Getting a User

You can retrieve a user by their ID.

=== ":fontawesome-brands-python: Python"
`python title="Get a User"
    user = await user_manager.get("user123")
    `

=== ":simple-typescript: TypeScript"
`typescript title="Get a User"
    const user = await userManager.get("user123");
    `

## Updating a User

You can update a user's details by providing the updated user details.

=== ":fontawesome-brands-python: Python"
`python title="Update a User"
    user = {
        "user_id": "user123",
        "metadata": {"foo": "baz"}
    }
    updated_user = await user_manager.update(user)
    `

=== ":simple-typescript: TypeScript"
`typescript title="Update a User"
    const user: IUpdateUserRequest = {
        user_id: "user123",
        metadata: { foo: "baz" },
    };
    const updatedUser = await userManager.update(user);
    `

## Deleting a User

You can delete a user by their ID.

=== ":fontawesome-brands-python: Python"
`python title="Delete a User"
    await user_manager.delete("user123")
    `

=== ":simple-typescript: TypeScript"
`typescript title="Delete a User"
    await userManager.delete("user123");
    `

## Listing Users

You can list all users, with optional limit and cursor parameters for pagination.

=== ":fontawesome-brands-python: Python"
`python title="List Users"
    users = await user_manager.list(limit=10, cursor=0)
    `

=== ":simple-typescript: TypeScript"
`typescript title="List Users"
    const users = await userManager.list(10, 0);
    `

## Getting a User's Sessions

You can retrieve all sessions for a user by their ID.

=== ":fontawesome-brands-python: Python"
`python title="Get User's Sessions"
    sessions = await user_manager.getSessions("user123")
    `

=== ":simple-typescript: TypeScript"
`typescript title="Get User's Sessions"
    const sessions = await userManager.getSessions("user123");
    `

## Listing Users in Chunks

You can retrieve users in chunks of a specified size. This is a generator function that yields each chunk of users as they are retrieved.

=== ":fontawesome-brands-python: Python"
`python title="List Users in Chunks"
    async for users in user_manager.listChunked(chunkSize=100):
        process(users)
    `

=== ":simple-typescript: TypeScript"
`typescript title="List Users in Chunks"
    for await (const users of userManager.listChunked(100)) {
        process(users);
    }
    `
