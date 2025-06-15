'use client';

import React from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { useSession } from 'next-auth/react';
import { useRouter } from 'next/navigation';
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
} from "@/components/ui/dropdown-menu";
import {
  NavigationMenu,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  navigationMenuTriggerStyle,
} from "@/components/ui/navigation-menu";
import { Menu } from 'lucide-react';
import 'primeicons/primeicons.css'


export default function Navbar() {
  const { data: session } = useSession();
  const router = useRouter();

  const avatarUrl = session?.user?.image ?? "https://cdn.discordapp.com/embed/avatars/1.png";

  const handleSubmitClick = (e: React.MouseEvent<HTMLAnchorElement>) => {
    e.preventDefault();
    if (session?.user) {
      router.push("/submit");
    } else {
      router.push("/api/auth/signin");
    }
  };

  return (
    <div
      className="fixed top-0 left-0 w-full z-50 flex items-center justify-between px-4 pt-2 font-medium antialiased text-white"
      style={{ fontFamily: '"Inter Variable", sans-serif' }}
    >
      {/* Left (mobile nav)*/}
      <div className="md:hidden">
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <button className="flex items-center gap-2 bg-stone-900/95 px-3 py-[15px] rounded-lg shadow-lg backdrop-blur-sm">
              <Menu className="w-4 h-4" />
              <span>Menu</span>
            </button>
          </DropdownMenuTrigger>
          <DropdownMenuContent className="bg-stone-900 text-white rounded-lg shadow-lg border border-stone-700 p-1 w-40 mt-2">
            <DropdownMenuItem asChild>
              <Link href="/" className="w-full block px-5 py-1 hover:text-gray-300">
                Demon list
              </Link>
            </DropdownMenuItem>
            <DropdownMenuItem asChild>
              <Link href="/leaderboard" className="w-full block px-5 py-1 hover:text-gray-300">
                Leaderboard
              </Link>
            </DropdownMenuItem>
            <DropdownMenuItem asChild>
              <Link href="https://discord.gg/p4XKkufSQc" className="w-full block px-5 py-1 hover:text-gray-300">
                  Discord Server
              </Link>
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>

      {/* desktop nav */}
      <div className="hidden md:flex">
        <NavigationMenu className="bg-stone-900/95 rounded-lg shadow-lg backdrop-blur-sm px-2 py-2">
          <NavigationMenuList>
            <NavigationMenuItem>
              <NavigationMenuLink asChild className="px-2 py-1 bg-stone-900/95">
                <Link href="/" className={navigationMenuTriggerStyle()}>
                  Demon list
                </Link>
              </NavigationMenuLink>
            </NavigationMenuItem>
            <NavigationMenuItem>
              <NavigationMenuLink asChild className="px-2 py-1 bg-stone-900/95">
                <Link href="/leaderboard" className={navigationMenuTriggerStyle()}>
                  Leaderboard
                </Link>
              </NavigationMenuLink>
            </NavigationMenuItem>
            <NavigationMenuItem>
              <NavigationMenuLink asChild className="px-2 py-1 bg-stone-900/95">
                <Link href="https://discord.gg/p4XKkufSQc" className={navigationMenuTriggerStyle()}>
                  Discord Server
                </Link>
              </NavigationMenuLink>
            </NavigationMenuItem>
          </NavigationMenuList>
        </NavigationMenu>
      </div>

      {/* Right */}
<div className="flex items-center gap-2">
  <NavigationMenu className="bg-stone-900/95 rounded-lg shadow-lg backdrop-blur-sm px-2 py-1">
    <NavigationMenuList>
      <NavigationMenuItem>
        <NavigationMenuLink asChild className="px-2 py-1 bg-stone-900/95">
          <a href="/submit" onClick={handleSubmitClick} className={navigationMenuTriggerStyle()}>
            Submit
          </a>
        </NavigationMenuLink>
      </NavigationMenuItem>
      <NavigationMenuItem>
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <button className="focus:outline-none pt-[7px]">
              <Image
                src={avatarUrl}
                alt="avatar"
                width={34}
                height={34}
                className="w-8 h-8 rounded-full cursor-pointer object-cover"
                priority
              />
            </button>
          </DropdownMenuTrigger>
          <DropdownMenuContent
            align="end"
            sideOffset={5}
            className="min-w-[180px] bg-stone-900 text-white rounded-lg shadow-lg border border-stone-700 p-1 w-40 mt-2"
          >
            {session?.user ? (
              <>
                <DropdownMenuItem asChild>
                  <Link href="/submissions" className="block px-5 py-1 hover:text-gray-400 font-medium">
                    My submissions
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuItem asChild>
                  <Link href="/api/auth/signout" className="block px-5 py-1 hover:text-gray-400 font-medium">
                    Sign out
                  </Link>
                </DropdownMenuItem>
              </>
            ) : (
              <DropdownMenuItem asChild>
                <Link href="/api/auth/signin" className="block px-5 py-1 hover:text-gray-400 font-medium">
                  Login
                </Link>
              </DropdownMenuItem>
            )}
          </DropdownMenuContent>
        </DropdownMenu>
      </NavigationMenuItem>
    </NavigationMenuList>
  </NavigationMenu>
</div>

    </div>
  );
}
