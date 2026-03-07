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

const TABLE_TYPES = [
  "colors",
  "diceRolls",
  "animals",
  "weather",
  "playingCards",
  "coordinates",
  "scores",
  "moods",
  "words",
  "planets",
] as const;

type TableType = (typeof TABLE_TYPES)[number];

/** Build an independent random schedule of timestamps within 60 seconds. */
function buildSchedule(): number[] {
  const times: number[] = [];
  let elapsed = 0;
  while (elapsed < 60_000) {
    const delay = randInt(5000, 10000);
    elapsed += delay;
    if (elapsed <= 60_000) {
      times.push(elapsed);
    }
  }
  return times;
}

/**
 * Public mutation: triggers a 1-minute cycle of random updates.
 * Each of the 10 data types gets its own independent update schedule,
 * so they all update at different times throughout the minute.
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

    // For each table type, generate an independent schedule and schedule updates
    let totalScheduled = 0;
    for (const tableType of TABLE_TYPES) {
      // Immediate first update for each type
      await updateOneTable(ctx.db, tableType);

      const schedule = buildSchedule();
      totalScheduled += schedule.length;
      for (const delayMs of schedule) {
        await ctx.scheduler.runAfter(delayMs, internal.mutations.updateTable, {
          tableType,
        });
      }
    }

    // Schedule a single "mark done" at 61 seconds
    const statusId = await ctx.db.insert("updateStatus", {
      active: true,
      startedAt: Date.now(),
      updatesRemaining: totalScheduled,
    });
    await ctx.scheduler.runAfter(61_000, internal.mutations.markDone, { statusId });

    return { status: "started", totalScheduled: totalScheduled + TABLE_TYPES.length };
  },
});

/**
 * Internal mutation: updates a single table type with fresh random data.
 */
export const updateTable = internalMutation({
  args: {
    tableType: v.string(),
  },
  handler: async (ctx, { tableType }) => {
    await updateOneTable(ctx.db, tableType as TableType);
  },
});

/**
 * Internal mutation: marks the update cycle as done after ~60 seconds.
 */
export const markDone = internalMutation({
  args: {
    statusId: v.id("updateStatus"),
  },
  handler: async (ctx, { statusId }) => {
    const status = await ctx.db.get(statusId);
    if (status) {
      await ctx.db.patch(statusId, { active: false, updatesRemaining: 0 });
    }
  },
});

async function updateOneTable(db: any, tableType: TableType) {
  switch (tableType) {
    case "colors": {
      const old = await db.query("colors").collect();
      for (const doc of old) await db.delete(doc._id);
      await db.insert("colors", { hex: randomHex(), name: pick(COLOR_NAMES) });
      break;
    }
    case "diceRolls": {
      const old = await db.query("diceRolls").collect();
      for (const doc of old) await db.delete(doc._id);
      const die1 = randInt(1, 6);
      const die2 = randInt(1, 6);
      await db.insert("diceRolls", { die1, die2, total: die1 + die2 });
      break;
    }
    case "animals": {
      const old = await db.query("animals").collect();
      for (const doc of old) await db.delete(doc._id);
      await db.insert("animals", pick(ANIMALS));
      break;
    }
    case "weather": {
      const old = await db.query("weather").collect();
      for (const doc of old) await db.delete(doc._id);
      await db.insert("weather", {
        condition: pick(WEATHER_CONDITIONS),
        tempF: randInt(10, 110),
        humidity: randInt(10, 100),
      });
      break;
    }
    case "playingCards": {
      const old = await db.query("playingCards").collect();
      for (const doc of old) await db.delete(doc._id);
      const suit = pick(SUITS);
      const rank = pick(RANKS);
      await db.insert("playingCards", { suit, rank, display: `${rank}${suit}` });
      break;
    }
    case "coordinates": {
      const old = await db.query("coordinates").collect();
      for (const doc of old) await db.delete(doc._id);
      await db.insert("coordinates", {
        lat: Math.round((Math.random() * 180 - 90) * 1000) / 1000,
        lng: Math.round((Math.random() * 360 - 180) * 1000) / 1000,
        label: pick(LOCATION_LABELS),
      });
      break;
    }
    case "scores": {
      const old = await db.query("scores").collect();
      for (const doc of old) await db.delete(doc._id);
      await db.insert("scores", {
        home: randInt(0, 120),
        away: randInt(0, 120),
        sport: pick(SPORTS),
      });
      break;
    }
    case "moods": {
      const old = await db.query("moods").collect();
      for (const doc of old) await db.delete(doc._id);
      const mood = pick(MOODS);
      await db.insert("moods", { ...mood, intensity: randInt(1, 10) });
      break;
    }
    case "words": {
      const old = await db.query("words").collect();
      for (const doc of old) await db.delete(doc._id);
      const word = pick(WORDS);
      await db.insert("words", { ...word, length: word.word.length });
      break;
    }
    case "planets": {
      const old = await db.query("planets").collect();
      for (const doc of old) await db.delete(doc._id);
      await db.insert("planets", pick(PLANETS));
      break;
    }
  }
}
