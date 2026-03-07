import { mutation, internalMutation } from "./_generated/server";
import { internal } from "./_generated/api";
import { v } from "convex/values";
import {
  COLOR_NAMES,
  ANIMALS,
  WEATHER_CONDITIONS,
  SUITS,
  RANKS,
  LOCATION_LABELS,
  SPORTS,
  MOODS,
  WORDS,
  PLANETS,
} from "./data";

function pick<T>(arr: T[]): T {
  return arr[Math.floor(Math.random() * arr.length)];
}

function randInt(min: number, max: number): number {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomHex(): string {
  return (
    "#" +
    Math.floor(Math.random() * 0xffffff)
      .toString(16)
      .padStart(6, "0")
  );
}

/**
 * Public mutation: triggers a 1-minute cycle of random updates.
 * Updates happen every 5-10 seconds, then stop.
 */
export const triggerUpdates = mutation({
  handler: async (ctx) => {
    // Check if already active
    const existing = await ctx.db.query("updateStatus").collect();
    for (const doc of existing) {
      if (doc.active) {
        return { status: "already_running", updatesRemaining: doc.updatesRemaining };
      }
    }

    // Clear old status docs
    for (const doc of existing) {
      await ctx.db.delete(doc._id);
    }

    // Calculate how many updates fit in ~60 seconds at 5-10s intervals.
    // We'll pre-schedule all of them now with random delays.
    const updates: number[] = [];
    let elapsed = 0;
    while (elapsed < 60_000) {
      const delay = randInt(5000, 10000);
      elapsed += delay;
      if (elapsed <= 60_000) {
        updates.push(elapsed);
      }
    }

    const statusId = await ctx.db.insert("updateStatus", {
      active: true,
      startedAt: Date.now(),
      updatesRemaining: updates.length,
    });

    // Do an immediate first update
    await doRandomUpdate(ctx);

    // Schedule each future update
    for (let i = 0; i < updates.length; i++) {
      await ctx.scheduler.runAfter(updates[i], internal.mutations.scheduledUpdate, {
        statusId,
        index: i,
        total: updates.length,
      });
    }

    return { status: "started", totalUpdates: updates.length + 1 };
  },
});

/**
 * Internal scheduled mutation: performs one round of random updates.
 */
export const scheduledUpdate = internalMutation({
  args: {
    statusId: v.id("updateStatus"),
    index: v.number(),
    total: v.number(),
  },
  handler: async (ctx, { statusId, index, total }) => {
    await doRandomUpdate(ctx);

    // Update remaining count
    const remaining = total - (index + 1);
    const status = await ctx.db.get(statusId);
    if (status) {
      await ctx.db.patch(statusId, {
        updatesRemaining: remaining,
        active: remaining > 0,
      });
    }
  },
});

async function doRandomUpdate(ctx: { db: any }) {
  // --- Colors ---
  const oldColors = await ctx.db.query("colors").collect();
  for (const c of oldColors) await ctx.db.delete(c._id);
  const hex = randomHex();
  await ctx.db.insert("colors", { hex, name: pick(COLOR_NAMES) });

  // --- Dice Rolls ---
  const oldDice = await ctx.db.query("diceRolls").collect();
  for (const d of oldDice) await ctx.db.delete(d._id);
  const die1 = randInt(1, 6);
  const die2 = randInt(1, 6);
  await ctx.db.insert("diceRolls", { die1, die2, total: die1 + die2 });

  // --- Animals ---
  const oldAnimals = await ctx.db.query("animals").collect();
  for (const a of oldAnimals) await ctx.db.delete(a._id);
  const animal = pick(ANIMALS);
  await ctx.db.insert("animals", animal);

  // --- Weather ---
  const oldWeather = await ctx.db.query("weather").collect();
  for (const w of oldWeather) await ctx.db.delete(w._id);
  await ctx.db.insert("weather", {
    condition: pick(WEATHER_CONDITIONS),
    tempF: randInt(10, 110),
    humidity: randInt(10, 100),
  });

  // --- Playing Cards ---
  const oldCards = await ctx.db.query("playingCards").collect();
  for (const c of oldCards) await ctx.db.delete(c._id);
  const suit = pick(SUITS);
  const rank = pick(RANKS);
  await ctx.db.insert("playingCards", { suit, rank, display: `${rank}${suit}` });

  // --- Coordinates ---
  const oldCoords = await ctx.db.query("coordinates").collect();
  for (const c of oldCoords) await ctx.db.delete(c._id);
  await ctx.db.insert("coordinates", {
    lat: Math.round((Math.random() * 180 - 90) * 1000) / 1000,
    lng: Math.round((Math.random() * 360 - 180) * 1000) / 1000,
    label: pick(LOCATION_LABELS),
  });

  // --- Scores ---
  const oldScores = await ctx.db.query("scores").collect();
  for (const s of oldScores) await ctx.db.delete(s._id);
  await ctx.db.insert("scores", {
    home: randInt(0, 120),
    away: randInt(0, 120),
    sport: pick(SPORTS),
  });

  // --- Moods ---
  const oldMoods = await ctx.db.query("moods").collect();
  for (const m of oldMoods) await ctx.db.delete(m._id);
  const mood = pick(MOODS);
  await ctx.db.insert("moods", {
    ...mood,
    intensity: randInt(1, 10),
  });

  // --- Words ---
  const oldWords = await ctx.db.query("words").collect();
  for (const w of oldWords) await ctx.db.delete(w._id);
  const word = pick(WORDS);
  await ctx.db.insert("words", {
    ...word,
    length: word.word.length,
  });

  // --- Planets ---
  const oldPlanets = await ctx.db.query("planets").collect();
  for (const p of oldPlanets) await ctx.db.delete(p._id);
  const planet = pick(PLANETS);
  await ctx.db.insert("planets", planet);
}
