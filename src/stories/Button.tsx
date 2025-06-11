"use client";
import React from "react";
import { Slot } from "@radix-ui/react-slot";
import { clsx } from "clsx";

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  asChild?: boolean;
  variant?: "primary" | "secondary" | "outline" | "ghost";
  className?: string;
  children?: React.ReactNode;
  ref?: React.Ref<HTMLElement>;
}

const buttonVariant = {
  primary:
    "text-white shadow bg-orange-600 border border-orange-500 hover:bg-orange-700",
  secondary:
    "text-amber-950 shadow bg-amber-500 border border-amber-400 hover:bg-amber-600",
  outline:
    "text-white bg-neutral-950 shadow border border-gray-700 hover:border-gray-800 hover:bg-zinc-900/75 hover:text-slate-100",
  ghost: "hover:bg-(--accent) hover:text-slate-100",
};

function Button({
  asChild = false,
  variant = "primary",
  className,
  children,
  ref,
  ...props
}: ButtonProps) {
  const Comp = asChild ? Slot : "button";
  return (
    <Comp
      // eslint-disable-next-line @typescript-eslint/no-explicit-any, @typescript-eslint/no-unsafe-assignment
      ref={ref as any}
      className={clsx(
        "inline-flex w-fit items-center justify-center rounded-2xl px-5 py-2 font-medium transition-all duration-150",
        buttonVariant[variant],
        className,
      )}
      {...props}
    >
      {children}
    </Comp>
  );
}

export default Button;
