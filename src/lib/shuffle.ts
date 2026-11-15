// Deterministic shuffle: the same seed always gives the same order, so a
// component can re-render (for example after an answer is checked) without the
// choices jumping around. A new seed gives a new order.

// mulberry32: a tiny seeded random number generator. Each call to the function
// it returns gives a number from 0 up to (not including) 1.
function mulberry32(seed: number) {
  let a = seed >>> 0;
  return () => {
    a = (a + 0x6d2b79f5) >>> 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

// Turns a string (a question id) into a number, so each question gets its own
// order instead of every question using the same one.
function hashString(text: string): number {
  let h = 2166136261;
  for (let i = 0; i < text.length; i++) {
    h ^= text.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}

// Fisher-Yates shuffle, done on a copy so the original array is never changed.
// Seed 0 means "the seed is not ready yet" and returns the original order.
export function shuffleChoices<T>(items: T[], seed: number, key: string): T[] {
  if (seed === 0) return items;
  const random = mulberry32(seed ^ hashString(key));
  const result = [...items];
  for (let i = result.length - 1; i > 0; i--) {
    const j = Math.floor(random() * (i + 1));
    [result[i], result[j]] = [result[j], result[i]];
  }
  return result;
}
