import { defineSchema, defineTable } from "convex/server";
import { v } from "convex/values";

export default defineSchema({
  colors: defineTable({
    hex: v.string(),
    name: v.string(),
  }),
  diceRolls: defineTable({
    die1: v.number(),
    die2: v.number(),
    total: v.number(),
  }),
  animals: defineTable({
    name: v.string(),
    emoji: v.string(),
    sound: v.string(),
  }),
  weather: defineTable({
    condition: v.string(),
    tempF: v.number(),
    humidity: v.number(),
  }),
  playingCards: defineTable({
    suit: v.string(),
    rank: v.string(),
    display: v.string(),
  }),
  coordinates: defineTable({
    lat: v.number(),
    lng: v.number(),
    label: v.string(),
  }),
  scores: defineTable({
    home: v.number(),
    away: v.number(),
    sport: v.string(),
  }),
  moods: defineTable({
    mood: v.string(),
    emoji: v.string(),
    intensity: v.number(),
  }),
  words: defineTable({
    word: v.string(),
    language: v.string(),
    length: v.number(),
  }),
  planets: defineTable({
    name: v.string(),
    distanceAU: v.float64(),
    moons: v.number(),
  }),
  // Tracks whether an update cycle is active
  updateStatus: defineTable({
    active: v.boolean(),
    startedAt: v.number(),
    updatesRemaining: v.number(),
  }),
});
