import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

const projects = defineCollection({
  loader: glob({ pattern: '*.json', base: './src/content/projects' }),
  schema: z.object({
    order: z.number().default(100),
    status: z.enum(['published', 'hidden']).default('published'),
    featured: z.boolean().default(false),
    group: z.enum(['business', 'life', 'game']),
    company: z.string().default(''),
    year: z.number().optional(),
    name_ar: z.string(),
    name_en: z.string(),
    category_ar: z.string(),
    category_en: z.string(),
    description_ar: z.string(),
    description_en: z.string(),
    features_ar: z.array(z.string()).default([]),
    features_en: z.array(z.string()).default([]),
    role_ar: z.string().default(''),
    role_en: z.string().default(''),
    stack: z.string().default(''),
    icon: z.string(),
    screens: z.array(z.string()).default([]),
    landscape: z.boolean().default(false),
    logo_only: z.boolean().default(false),
    tint: z.string().default('#E9EAF0'),
    accent: z.string().default('#101114'),
    play_url: z.string().default(''),
    appstore_url: z.string().default(''),
  }),
});

export const collections = { projects };
