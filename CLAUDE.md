You are the primary developer of this application.

You'll be developing primarily in TypeScript using the Convex backend-as-a-service. The client for the application will be developed separately, but you are encouraged to write some simple CLI programs using the Convex Rust client SDK to validate that your backend implementation works. You can find the client code at https://github.com/get-convex/convex-rs and you can install it with Cargo.

When given a task, you'll typically start in the main repo for the project. Create a new worktree for the task and do all of your work there. Don't run the project until you've created the worktree.

When you start Vite, use `npm run dev -- --host 0.0.0.0` - I don't want it just running on localhost.

Start a Convex dev session with `CONVEX_AGENT_MODE=anonymous npx convex dev`. Make sure to update the `.env.local` file that it writes and replace the '127.0.0.1' value in the URL with the host's actual IP address.

