![banner](https://i.imgur.com/T509KBB.png "banner")

# Description

This project is a web-based hacking game based on Hacker Experience 2 and Grey Hack. It will have a mix of idle game features, puzzle hacking missions, RPG and competitive gameplay.

If you have ever played Greyhack, you will know that after you learn the basics and intermediate mechanics of the game, there is not much more gameplay to keep players engaged. Some players who enjoy game script coding may stick around, but they eventually run out of things to code, and the game updates usually just add over restricted APIs that are hard to make use of.

The main problem is that Greyhack lacks multiplayer features to make the game more about competing and cooperating with others, and less about endlessly doing the same missions over and over again, and creating unhackable servers (which destroys the whole point of the game: hacking).

And Hacker Experience 2? Well, it never saw the light of day, but it had a pretty good vision for a multiplayer hacker game, and I plan to improve and use them in Hacker Place.

### Demo

the current state of the game is very very VERY basic

[![Demo](https://i.imgur.com/BLuFcNG.gif)](https://youtu.be/VftUaKUQNSQ)

click the gif to watch the video

# Requirements

```
 ruby 3.2.2
 nodejs 18.2.0
 go 1.21.4
```

* **Dev setup**

```bash
  cd ~
  mkdir .postgres_docker
  podman pull docker.io/library/postgres
  podman run -dt --name my-postgres -e POSTGRES_PASSWORD=postgres -v "~/.postgres_docker:/var/lib/postgresql/data:Z" -p 5432:5432 postgres

  podman pull docker.io/redis
  podman run -d --name redis_server -p 6379:6379 redis
```

* **Run**

```bash
  foreman start -f Procfile.dev 
```

* **Build go bindings**

```bash
  cd app/lgo
  go build
```
