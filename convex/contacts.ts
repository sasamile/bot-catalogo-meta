import { v } from "convex/values";
import { query } from "./_generated/server";

export const getById = query({
  args: { contactId: v.id("contacts") },
  handler: async (ctx, args) => {
    return await ctx.db.get(args.contactId);
  },
});
