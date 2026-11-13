import Foundation

struct FavoriteItem {
    let title: String
    let subtitle: String
    let imageName: String
    let rating: Double
    let description: String
}


enum FavoritesLibrary {
    static let movies: [FavoriteItem] = [
        FavoriteItem(
                    title: "Extraordinary You",
                    subtitle: "Romance • Fantasy • School",
                    imageName: "1",
                    rating: 5,
                    description: "Eun Dan-oh discovers that she is a character in a comic book and that her life is controlled by its writer. She decides to change her destiny instead of following the story. Along the way, she meets a mysterious student who helps her discover true love."
                ),
                FavoriteItem(
                    title: "Dive Into You",
                    subtitle: "Romance • Drama",
                    imageName: "2",
                    rating: 4.5,
                    description: "Two young people meet while facing challenges in their personal lives. As they spend more time together, they begin to understand each other's dreams and feelings. Their relationship teaches them about love, trust and personal growth."
                ),
                FavoriteItem(
                    title: "Strong Woman Do Bong Soon",
                    subtitle: "Romance • Comedy • Fantasy",
                    imageName: "3",
                    rating: 5,
                    description: "Do Bong-soon is a young woman born with extraordinary physical strength. She becomes the bodyguard of a wealthy gaming company CEO named Ahn Min-hyuk. While protecting him and investigating a dangerous criminal, she unexpectedly falls in love."
                ),
                FavoriteItem(
                    title: "The Judge from Hell",
                    subtitle: "Fantasy • Thriller • Crime",
                    imageName: "4",
                    rating: 5,
                    description: "A demon enters the body of a human judge and begins punishing criminals who escape justice. She meets a kind detective who believes in protecting innocent people. Their relationship slowly changes the way she understands humanity and justice."
                ),
                FavoriteItem(
                    title: "Lovely Runner",
                    subtitle: "Romance • Fantasy • Time Travel",
                    imageName: "5",
                    rating: 5,
                    description: "Im Sol is devastated when her favorite singer, Ryu Sun-jae, suddenly dies. She unexpectedly travels back in time to their school years and gets a chance to change his future. As she tries to save him, their lives become connected through love and destiny."
                ),
                FavoriteItem(
                    title: "Tomorrow",
                    subtitle: "Fantasy • Drama • Supernatural",
                    imageName: "6",
                    rating: 4.5,
                    description: "Choi Joon-woong falls into a coma after an unexpected accident. He joins a team of grim reapers who work to save people who have lost hope in life. Through their missions, he learns about human suffering, compassion and the importance of living."
                ),
                FavoriteItem(
                    title: "Twinkling Watermelon",
                    subtitle: "Romance • Fantasy • Youth",
                    imageName: "7",
                    rating: 5,
                    description: "Eun-gyeol is a talented young musician who unexpectedly travels back to 1995. There, he meets his father as a teenager and joins a band with him. While trying to protect his family's future, he discovers friendship, first love and the power of music."
                ),
                FavoriteItem(
                    title: "See You in My 19th Life",
                    subtitle: "Romance • Fantasy • Drama",
                    imageName: "8",
                    rating: 5,
                    description: "Ban Ji-eum is a woman who remembers every one of her previous lives. In her nineteenth life, she searches for a man she loved during her eighteenth life. As they meet again, she must deal with painful memories and secrets from the past."
                ),
                FavoriteItem(
                    title: "Tale of the Nine Tailed",
                    subtitle: "Romance • Fantasy • Action",
                    imageName: "9",
                    rating: 4.5,
                    description: "Lee Yeon is a legendary nine-tailed fox who lives among humans. He meets a television producer investigating supernatural mysteries and searching for her missing parents. Together, they face dangerous spirits while uncovering a love story connected to their past."
                ),
                FavoriteItem(
                    title: "The Nanyang Mystery",
                    subtitle: "Mystery • Fantasy • Thriller",
                    imageName: "10",
                    rating: 4,
                    description: "A mysterious series of events brings several people into a world filled with secrets. As they investigate strange incidents, they encounter supernatural forces and hidden truths. Their journey becomes increasingly dangerous as the mysteries begin to connect."
                ),
                FavoriteItem(
                    title: "Love Undercover",
                    subtitle: "Romance • Comedy • Drama",
                    imageName: "11",
                    rating: 4.5,
                    description: "A young woman becomes involved in a complicated situation where she must hide her true identity. While trying to complete her mission, she unexpectedly develops romantic feelings. Secrets and misunderstandings create funny and emotional moments throughout her journey."
                ),
                FavoriteItem(
                    title: "The Remarried Empress",
                    subtitle: "Romance • Fantasy • Historical",
                    imageName: "12",
                    rating: 4.5,
                    description: "Empress Navier is a respected ruler whose marriage begins to fall apart when her husband falls in love with another woman. Instead of accepting an unhappy future, she makes a surprising decision to remarry. Her story explores love, betrayal, dignity and the struggle for power."
                ),
                FavoriteItem(
                    title: "Spirit Fingers",
                    subtitle: "Romance • Comedy • Youth",
                    imageName: "13",
                    rating: 5,
                    description: "Song Woo-yeon is a shy student who struggles with confidence and expressing herself. Her life changes when she joins a colorful art club called Spirit Fingers. Through new friendships and romance, she gradually learns to love herself and discover her own identity."
                ),
                FavoriteItem(
                    title: "Hometown Cha-Cha-Cha",
                    subtitle: "Romance • Comedy • Slice of Life",
                    imageName: "14",
                    rating: 5,
                    description: "Yoon Hye-jin is a successful dentist who moves from Seoul to a peaceful seaside village. There, she meets Hong Du-sik, a helpful man loved by the local residents. As they grow closer, they learn about love, community and healing from the past."
                ),
                FavoriteItem(
                    title: "Upside Down",
                    subtitle: "Romance • Comedy • Drama",
                    imageName: "15",
                    rating: 4.5,
                    description: "Unexpected events turn the main characters' ordinary lives upside down. As they face misunderstandings and difficult choices, new relationships begin to develop. Their experiences teach them important lessons about love, friendship and personal happiness."
                ),
                FavoriteItem(
                    title: "See You in My 19th Life",
                    subtitle: "Romance • Fantasy • Drama",
                    imageName: "16",
                    rating: 5,
                    description: "Ban Ji-eum has the unusual ability to remember all of her past lives. She decides to reconnect with someone important from her previous life. However, her memories create emotional challenges as she tries to build a new future."
                ),
                FavoriteItem(
                    title: "High School Return of a Gangster",
                    subtitle: "Fantasy • Action • School",
                    imageName: "17",
                    rating: 4.5,
                    description: "A middle-aged gangster unexpectedly finds his soul inside the body of a high school student. He discovers that the student has been suffering from bullying and loneliness. Using his experience and courage, he begins protecting his classmates and changing their lives."
                ),
                FavoriteItem(
                    title: "Oh My Venus",
                    subtitle: "Romance • Legal • Drama",
                    imageName: "18",
                    rating: 4.5,
                    description: "Kang Joo-eun is a lawyer who struggles with her confidence after gaining weight. She meets Kim Young-ho, a famous personal trainer who agrees to help her become healthier. As they spend time together, their friendship develops into a romantic relationship."
                ),
                FavoriteItem(
                    title: "The Dude in Me",
                    subtitle: "Comedy • Fantasy • Action",
                    imageName: "19",
                    rating: 4.5,
                    description: "A powerful gangster and a shy high school student accidentally exchange bodies after an unusual incident. The gangster must adapt to school life while dealing with bullies and unexpected family problems. Their strange situation leads to hilarious adventures and surprising personal discoveries."
                ),
                FavoriteItem(
                    title: "Heartbeat",
                    subtitle: "Romance • Fantasy • Comedy",
                    imageName: "20",
                    rating: 5,
                    description: "Seon Woo-hyeol is a half-human vampire who dreams of becoming fully human. After sleeping for almost one hundred years, he wakes up just before completing his transformation. He begins living with a practical young woman, and their unusual relationship slowly turns into love."
                )
            ]
        }
