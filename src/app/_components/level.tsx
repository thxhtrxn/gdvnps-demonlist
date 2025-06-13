"use client";

import { useState } from "react";

import { api } from "@/trpc/react";

export function LatestPost() {
  const [latestLevel] = api.level.getLatest.useSuspenseQuery();

  const utils = api.useUtils();
  const [name, setName] = useState("");
  const createLevel = api.level.create.useMutation({
    onSuccess: async () => {
      await utils.level.invalidate();
      setName("");
    },
  });

  return (
    <div className="w-full max-w-xs">
      {latestLevel ? (
        <p className="truncate">Your most recent level: {latestLevel.name}</p>
      ) : (
        <p>You have no levels yet.</p>
      )}
      <form
        onSubmit={(e) => {
          e.preventDefault();
          createLevel.mutate({ name });
        }}
        className="flex flex-col gap-2"
      >
        <input
          type="text"
          placeholder="Title"
          value={name}
          onChange={(e) => setName(e.target.value)}
          className="w-full rounded-full bg-white/10 px-4 py-2 text-white"
        />
        <button
          type="submit"
          className="rounded-full bg-white/10 px-10 py-3 font-semibold transition hover:bg-white/20"
          disabled={createLevel.isPending}
        >
          {createLevel.isPending ? "Submitting..." : "Submit"}
        </button>
      </form>
    </div>
  );
}
