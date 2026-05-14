-- CreateTable
CREATE TABLE "developers" (
    "devid" SERIAL NOT NULL,
    "devname" VARCHAR(150) NOT NULL,
    "userid" INTEGER,

    CONSTRAINT "developers_pkey" PRIMARY KEY ("devid")
);

-- CreateTable
CREATE TABLE "friends" (
    "user1id" INTEGER NOT NULL,
    "user2id" INTEGER NOT NULL,
    "status" VARCHAR(20) DEFAULT 'accepted',

    CONSTRAINT "friends_pkey" PRIMARY KEY ("user1id","user2id")
);

-- CreateTable
CREATE TABLE "gamedevelopers" (
    "gameid" INTEGER NOT NULL,
    "devid" INTEGER NOT NULL,

    CONSTRAINT "gamedevelopers_pkey" PRIMARY KEY ("gameid","devid")
);

-- CreateTable
CREATE TABLE "gamegenres" (
    "gameid" INTEGER NOT NULL,
    "genreid" INTEGER NOT NULL,

    CONSTRAINT "gamegenres_pkey" PRIMARY KEY ("gameid","genreid")
);

-- CreateTable
CREATE TABLE "gamepublishers" (
    "gameid" INTEGER NOT NULL,
    "pubid" INTEGER NOT NULL,

    CONSTRAINT "gamepublishers_pkey" PRIMARY KEY ("gameid","pubid")
);

-- CreateTable
CREATE TABLE "games" (
    "gameid" SERIAL NOT NULL,
    "title" VARCHAR(200) NOT NULL,
    "description" TEXT,
    "releasedate" DATE,
    "agerating" VARCHAR(10),
    "baseprice" DECIMAL(10,2) DEFAULT 0.0,
    "isEarlyAccess" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "games_pkey" PRIMARY KEY ("gameid")
);

-- CreateTable
CREATE TABLE "genres" (
    "genreid" SERIAL NOT NULL,
    "genrename" VARCHAR(50) NOT NULL,

    CONSTRAINT "genres_pkey" PRIMARY KEY ("genreid")
);

-- CreateTable
CREATE TABLE "library" (
    "userid" INTEGER NOT NULL,
    "gameid" INTEGER NOT NULL,
    "playtimehours" INTEGER DEFAULT 0,
    "purchasedate" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "library_pkey" PRIMARY KEY ("userid","gameid")
);

-- CreateTable
CREATE TABLE "orderitems" (
    "orderitemid" SERIAL NOT NULL,
    "orderid" INTEGER NOT NULL,
    "gameid" INTEGER NOT NULL,
    "priceatpurchase" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "orderitems_pkey" PRIMARY KEY ("orderitemid")
);

-- CreateTable
CREATE TABLE "orders" (
    "orderid" SERIAL NOT NULL,
    "userid" INTEGER NOT NULL,
    "orderdate" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "totalamount" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("orderid")
);

-- CreateTable
CREATE TABLE "points" (
    "userid" INTEGER NOT NULL,
    "totalpoints" INTEGER DEFAULT 0,

    CONSTRAINT "points_pkey" PRIMARY KEY ("userid")
);

-- CreateTable
CREATE TABLE "publishers" (
    "pubid" SERIAL NOT NULL,
    "pubname" VARCHAR(150) NOT NULL,
    "userid" INTEGER,

    CONSTRAINT "publishers_pkey" PRIMARY KEY ("pubid")
);

-- CreateTable
CREATE TABLE "reviews" (
    "reviewid" SERIAL NOT NULL,
    "userid" INTEGER,
    "gameid" INTEGER,
    "comment" TEXT,
    "rating" INTEGER,
    "reviewdate" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("reviewid")
);

-- CreateTable
CREATE TABLE "users" (
    "userid" SERIAL NOT NULL,
    "nickname" VARCHAR(100) NOT NULL,
    "email" VARCHAR(150) NOT NULL,
    "regdate" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("userid")
);

-- CreateTable
CREATE TABLE "tags" (
    "tagid" SERIAL NOT NULL,
    "tagname" VARCHAR(50) NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("tagid")
);

-- CreateTable
CREATE TABLE "gametags" (
    "gameid" INTEGER NOT NULL,
    "tagid" INTEGER NOT NULL,

    CONSTRAINT "gametags_pkey" PRIMARY KEY ("gameid","tagid")
);

-- CreateIndex
CREATE UNIQUE INDEX "genres_genrename_key" ON "genres"("genrename");

-- CreateIndex
CREATE UNIQUE INDEX "reviews_userid_gameid_key" ON "reviews"("userid", "gameid");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "tags_tagname_key" ON "tags"("tagname");

-- AddForeignKey
ALTER TABLE "developers" ADD CONSTRAINT "developers_userid_fkey" FOREIGN KEY ("userid") REFERENCES "users"("userid") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "friends" ADD CONSTRAINT "friends_user1id_fkey" FOREIGN KEY ("user1id") REFERENCES "users"("userid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "friends" ADD CONSTRAINT "friends_user2id_fkey" FOREIGN KEY ("user2id") REFERENCES "users"("userid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gamedevelopers" ADD CONSTRAINT "gamedevelopers_devid_fkey" FOREIGN KEY ("devid") REFERENCES "developers"("devid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gamedevelopers" ADD CONSTRAINT "gamedevelopers_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "games"("gameid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gamegenres" ADD CONSTRAINT "gamegenres_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "games"("gameid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gamegenres" ADD CONSTRAINT "gamegenres_genreid_fkey" FOREIGN KEY ("genreid") REFERENCES "genres"("genreid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gamepublishers" ADD CONSTRAINT "gamepublishers_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "games"("gameid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gamepublishers" ADD CONSTRAINT "gamepublishers_pubid_fkey" FOREIGN KEY ("pubid") REFERENCES "publishers"("pubid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "library" ADD CONSTRAINT "library_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "games"("gameid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "library" ADD CONSTRAINT "library_userid_fkey" FOREIGN KEY ("userid") REFERENCES "users"("userid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orderitems" ADD CONSTRAINT "orderitems_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "games"("gameid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orderitems" ADD CONSTRAINT "orderitems_orderid_fkey" FOREIGN KEY ("orderid") REFERENCES "orders"("orderid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_userid_fkey" FOREIGN KEY ("userid") REFERENCES "users"("userid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "points" ADD CONSTRAINT "points_userid_fkey" FOREIGN KEY ("userid") REFERENCES "users"("userid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "publishers" ADD CONSTRAINT "publishers_userid_fkey" FOREIGN KEY ("userid") REFERENCES "users"("userid") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "games"("gameid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_userid_fkey" FOREIGN KEY ("userid") REFERENCES "users"("userid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gametags" ADD CONSTRAINT "gametags_gameid_fkey" FOREIGN KEY ("gameid") REFERENCES "games"("gameid") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gametags" ADD CONSTRAINT "gametags_tagid_fkey" FOREIGN KEY ("tagid") REFERENCES "tags"("tagid") ON DELETE CASCADE ON UPDATE NO ACTION;
