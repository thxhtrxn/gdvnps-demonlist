-- CreateTable
CREATE TABLE "User" (
    "id" UUID NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "emailVerified" TIMESTAMP(3),
    "image" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
    "id" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,
    "refresh_token_expires_in" INTEGER,
    "isAdmin" BOOLEAN NOT NULL DEFAULT false,
    "isBanned" BOOLEAN NOT NULL DEFAULT false,
    "isHidden" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VerificationToken" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "Level" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR DEFAULT 'N/a',
    "creator" VARCHAR DEFAULT 'N/a',
    "videoID" VARCHAR DEFAULT 'N/a',
    "minProgress" BIGINT DEFAULT 100,
    "top" DOUBLE PRECISION,
    "rating" BIGINT,
    "songID" BIGINT,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isPlatformer" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Level_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LevelDeathCount" (
    "levelID" BIGINT NOT NULL,
    "count" BIGINT[],

    CONSTRAINT "LevelDeathCount_pkey" PRIMARY KEY ("levelID")
);

-- CreateTable
CREATE TABLE "Player" (
    "id" BIGSERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" VARCHAR,
    "avatar" VARCHAR,
    "totalPt" DOUBLE PRECISION,
    "maxPt" BIGINT,
    "rank" BIGINT,
    "overallRank" BIGINT,
    "uid" UUID NOT NULL,
    "rating" DOUBLE PRECISION DEFAULT 0,
    "reviewCooldown" TIMESTAMPTZ(6),
    "renameCooldown" TIMESTAMPTZ(6) NOT NULL DEFAULT '2020-06-09 14:03:33.297+00'::timestamp with time zone,
    "recordCount" BIGINT NOT NULL DEFAULT 0,
    "exp" BIGINT NOT NULL DEFAULT 0,
    "extraExp" BIGINT,

    CONSTRAINT "Player_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Record" (
    "userid" UUID NOT NULL,
    "levelid" BIGINT NOT NULL,
    "videoLink" VARCHAR,
    "refreshRate" BIGINT DEFAULT 60,
    "progress" BIGINT DEFAULT 0,
    "timestamp" BIGINT DEFAULT 0,
    "pt" DOUBLE PRECISION,
    "mobile" BOOLEAN NOT NULL DEFAULT false,
    "isChecked" BOOLEAN DEFAULT false,
    "comment" VARCHAR,
    "reviewer" UUID,
    "needMod" BOOLEAN NOT NULL DEFAULT false,
    "reviewerComment" TEXT,
    "raw" TEXT DEFAULT '',
    "time" BIGINT,

    CONSTRAINT "Record_pkey" PRIMARY KEY ("userid","levelid")
);

-- CreateTable
CREATE TABLE "DeathCount" (
    "levelID" BIGINT NOT NULL,
    "uid" UUID NOT NULL,
    "count" BIGINT[],
    "completedTime" TIMESTAMPTZ(6),

    CONSTRAINT "DeathCount_pkey" PRIMARY KEY ("levelID","uid")
);

-- CreateTable
CREATE TABLE "EventProof" (
    "userid" UUID NOT NULL,
    "eventID" BIGINT NOT NULL,
    "content" TEXT NOT NULL DEFAULT '',
    "accepted" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "EventProof_pkey" PRIMARY KEY ("userid","eventID")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" BIGSERIAL NOT NULL,
    "content" TEXT,
    "to" UUID NOT NULL,
    "status" BIGINT NOT NULL DEFAULT 0,
    "timestamp" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "redirect" TEXT,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "Account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_token_key" ON "VerificationToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_identifier_token_key" ON "VerificationToken"("identifier", "token");

-- CreateIndex
CREATE UNIQUE INDEX "Player_name_key" ON "Player"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Player_email_key" ON "Player"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Player_uid_key" ON "Player"("uid");

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LevelDeathCount" ADD CONSTRAINT "LevelDeathCount_levelID_fkey" FOREIGN KEY ("levelID") REFERENCES "Level"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Player" ADD CONSTRAINT "Player_uid_fkey" FOREIGN KEY ("uid") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Record" ADD CONSTRAINT "Record_levelid_fkey" FOREIGN KEY ("levelid") REFERENCES "Level"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Record" ADD CONSTRAINT "Record_userid_fkey" FOREIGN KEY ("userid") REFERENCES "Player"("uid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Record" ADD CONSTRAINT "Record_reviewer_fkey" FOREIGN KEY ("reviewer") REFERENCES "Player"("uid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeathCount" ADD CONSTRAINT "DeathCount_uid_fkey" FOREIGN KEY ("uid") REFERENCES "Player"("uid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EventProof" ADD CONSTRAINT "EventProof_userid_fkey" FOREIGN KEY ("userid") REFERENCES "Player"("uid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_to_fkey" FOREIGN KEY ("to") REFERENCES "Player"("uid") ON DELETE NO ACTION ON UPDATE NO ACTION;
