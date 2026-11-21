import { getCollection } from 'astro:content';
import site from './site.json';
import type { Lang } from '../i18n/ui';

export type App = {
  id: string;
  name: string;
  category: string;
  description: string;
  features: string[];
  role: string;
  stack: string;
  meta: string;
  group: 'business' | 'life' | 'game';
  featured: boolean;
  icon: string;
  screens: string[];
  landscape: boolean;
  logoOnly: boolean;
  tint: string;
  accent: string;
  play: string;
  appstore: string;
};

export async function loadApps(lang: Lang): Promise<App[]> {
  const entries = await getCollection('projects', (e) => e.data.status === 'published');
  return entries
    .sort((a, b) => a.data.order - b.data.order)
    .map(({ id, data: d }) => ({
      id,
      name: lang === 'ar' ? d.name_ar : d.name_en,
      category: lang === 'ar' ? d.category_ar : d.category_en,
      description: lang === 'ar' ? d.description_ar : d.description_en,
      features: lang === 'ar' ? d.features_ar : d.features_en,
      role: lang === 'ar' ? d.role_ar : d.role_en,
      stack: d.stack,
      meta: [d.company, d.year].filter(Boolean).join(' · '),
      group: d.group,
      featured: d.featured,
      icon: d.icon,
      screens: d.screens.length ? d.screens : [d.icon],
      landscape: d.landscape,
      logoOnly: d.logo_only,
      tint: d.tint,
      accent: d.accent,
      play: d.play_url,
      appstore: d.appstore_url,
    }));
}

export const pick = <T extends Record<string, unknown>>(obj: T, key: string, lang: Lang) =>
  obj[`${key}_${lang}`] as string;

export { site };
