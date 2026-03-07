import { query } from "./_generated/server";

export const getColors = query({
  handler: async (ctx) => {
    return await ctx.db.query("colors").collect();
  },
});

export const getDiceRolls = query({
  handler: async (ctx) => {
    return await ctx.db.query("diceRolls").collect();
  },
});

export const getAnimals = query({
  handler: async (ctx) => {
    return await ctx.db.query("animals").collect();
  },
});

export const getWeather = query({
  handler: async (ctx) => {
    return await ctx.db.query("weather").collect();
  },
});

export const getPlayingCards = query({
  handler: async (ctx) => {
    return await ctx.db.query("playingCards").collect();
  },
});

export const getCoordinates = query({
  handler: async (ctx) => {
    return await ctx.db.query("coordinates").collect();
  },
});

export const getScores = query({
  handler: async (ctx) => {
    return await ctx.db.query("scores").collect();
  },
});

export const getMoods = query({
  handler: async (ctx) => {
    return await ctx.db.query("moods").collect();
  },
});

export const getWords = query({
  handler: async (ctx) => {
    return await ctx.db.query("words").collect();
  },
});

export const getPlanets = query({
  handler: async (ctx) => {
    return await ctx.db.query("planets").collect();
  },
});

export const getUpdateStatus = query({
  handler: async (ctx) => {
    return await ctx.db.query("updateStatus").collect();
  },
});
