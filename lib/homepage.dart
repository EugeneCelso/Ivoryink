import 'package:flutter/cupertino.dart';
import 'bookpage.dart';
import 'book_reading_page.dart';

class Homepage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;
  final bool isDark;

  const Homepage({
    super.key,
    required this.onAddToCart,
    required this.isDark,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Fiction', 'Non-Fiction', 'Mystery', 'Sci-Fi', 'Romance', 'History', 'Self-Help', 'Fantasy'];

  Color get _bg => widget.isDark ? Color(0xFF0D0D0D) : Color(0xFFF5F0E8);
  Color get _card => widget.isDark ? Color(0xFF1A1410) : Color(0xFFFFFFFF);
  Color get _text => widget.isDark ? Color(0xFFE8D5B7) : Color(0xFF2C1810);
  Color get _subtext => widget.isDark ? Color(0xFF8B7355) : Color(0xFF9B7B5A);
  Color get _border => widget.isDark ? Color(0xFF3A2820) : Color(0xFFE8D5B7);

  final List<Map<String, dynamic>> books = [
    {
      'name': 'Harry Potter and the Sorcerer\'s Stone',
      'author': 'J.K. Rowling',
      'price': 549,
      'category': 'Fantasy',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1474154022i/3.jpg',
      'description': 'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Fantasy', 'Adventure', 'Young Adult'],
      'rating': 4.9,
      'reviews': 124503,
      'pages': '309',
      'publisher': 'Scholastic',
      'isbn': '978-0439708180',
      'language': 'English',
      'excerpt': 'Mr. and Mrs. Dursley, of number four, Privet Drive, were proud to say that they were perfectly normal, thank you very much. They were the last people you\'d expect to be involved in anything strange or mysterious, because they just didn\'t hold with such nonsense.\n\nMr. Dursley was the director of a firm called Grunnings, which made drills. He was a big, beefy man with hardly any neck, although he did have a very large mustache. Mrs. Dursley was thin and blonde and had nearly twice the usual amount of neck, which came in very useful as she spent so much of her time craning over garden fences, spying on the neighbors.\n\nThe Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.',
    },
    {
      'name': 'Harry Potter and the Chamber of Secrets',
      'author': 'J.K. Rowling',
      'price': 549,
      'category': 'Fantasy',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1474169725i/15881.jpg',
      'description': 'The Dursleys were so mean and hideous that summer that all Harry Potter wanted was to get back to the Hogwarts School for Witchcraft and Wizardry.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Fantasy', 'Adventure', 'Young Adult'],
      'rating': 4.8,
      'reviews': 98210,
      'pages': '341',
      'publisher': 'Scholastic',
      'isbn': '978-0439064873',
      'language': 'English',
      'excerpt': 'Not for the first time, an argument had broken out over breakfast at number four, Privet Drive. Mr. Vernon Dursley had been woken in the early hours of the morning by a loud, hooting noise from his nephew Harry\'s room.\n\n"Third time this week!" he roared across the table. "If you can\'t control that owl, it\'ll have to go!"\n\nHarry tried to explain about Hedwig, how she got restless if she wasn\'t allowed out at night, but Uncle Vernon wasn\'t listening.',
    },
    {
      'name': 'Harry Potter and the Prisoner of Azkaban',
      'author': 'J.K. Rowling',
      'price': 599,
      'category': 'Fantasy',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1499277281i/5.jpg',
      'description': 'For twelve long years, the dread fortress of Azkaban held an infamous prisoner named Sirius Black.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Fantasy', 'Adventure', 'Mystery'],
      'rating': 4.9,
      'reviews': 107832,
      'pages': '435',
      'publisher': 'Scholastic',
      'isbn': '978-0439136365',
      'language': 'English',
      'excerpt': 'Harry Potter was a highly unusual boy in many ways. For one thing, he hated the summer holidays more than any other time of year. For another, he really wanted to do his homework but was forced to do it in secret, in the dead of night.\n\nAnd he also happened to be a wizard.\n\nIt was nearly midnight, and he was lying on his stomach in bed, the blankets drawn right over his head like a tent, a flashlight in one hand and a large leather-bound book propped open against his pillow.',
    },
    {
      'name': 'The Fellowship of the Ring',
      'author': 'J.R.R. Tolkien',
      'price': 649,
      'category': 'Fantasy',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1654215925i/61215351.jpg',
      'description': 'One Ring to rule them all, One Ring to find them, One Ring to bring them all and in the darkness bind them.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Fantasy', 'Adventure', 'Classic'],
      'rating': 4.9,
      'reviews': 89423,
      'pages': '423',
      'publisher': 'Houghton Mifflin',
      'isbn': '978-0547928210',
      'language': 'English',
      'excerpt': 'When Mr. Bilbo Baggins of Bag End announced that he would shortly be celebrating his eleventy-first birthday with a party of special magnificence, there was much talk and excitement in Hobbiton.\n\nBilbo was very rich and very peculiar, and had been the wonder of the Shire for sixty years, ever since his remarkable disappearance and unexpected return. The riches he had brought back from his travels had now become a local legend, and it was popularly believed, whatever the old folk might say, that the Hill at Bag End was full of tunnels stuffed with treasure.',
    },
    {
      'name': 'The Two Towers',
      'author': 'J.R.R. Tolkien',
      'price': 649,
      'category': 'Fantasy',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1654215927i/61215352.jpg',
      'description': 'The Fellowship was scattered. Some were bracing hopelessly for war against the ancient evil of Sauron.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Fantasy', 'Adventure', 'Classic'],
      'rating': 4.8,
      'reviews': 72104,
      'pages': '352',
      'publisher': 'Houghton Mifflin',
      'isbn': '978-0547928203',
      'language': 'English',
      'excerpt': 'Aragorn sped on up the hill. Every now and again he bent to the ground. Hobbits go light, and their footprints are not easy even for a Ranger to read, but not far from the top a spring crossed the path, and in the wet earth he saw what he was seeking.\n\n"I read the signs aright," he said to himself. "Frodo ran to the hill-top. I wonder what he saw there? But he returned by the same way, and went down the hill again."\n\nAragorn hesitated. He longed to go to the high seat himself, but time was pressing.',
    },
    {
      'name': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'price': 459,
      'category': 'Fiction',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1553383690i/2657.jpg',
      'description': 'The unforgettable novel of a childhood in a sleepy Southern town and the crisis of conscience that rocked it.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Fiction', 'Classic', 'Historical'],
      'rating': 4.8,
      'reviews': 98234,
      'pages': '281',
      'publisher': 'J.B. Lippincott & Co.',
      'isbn': '978-0061935466',
      'language': 'English',
      'excerpt': 'When he was nearly thirteen, my brother Jem got his arm badly broken at the elbow. When it healed, and Jem\'s fears of never being able to play football were assuaged, he was seldom self-conscious about his injury.\n\nI never understood his preoccupation with it, but it was all he thought about in the years that came after. He was thin-boned but wiry; in later years, when it bothered him, he would say that his left arm was somewhat shorter than his right; when he stood or walked, the back of his hand was at right angles to his body, his thumb parallel to his thigh.\n\nWhen enough years had gone by to enable us to look back on them, we sometimes discussed the events leading to his accident.',
    },
    {
      'name': '1984',
      'author': 'George Orwell',
      'price': 429,
      'category': 'Fiction',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1657781256i/61439040.jpg',
      'description': 'Among the seminal texts of the 20th century, 1984 is a rare work that grows more haunting as its futuristic purgatory becomes more real.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Fiction', 'Dystopia', 'Classic'],
      'rating': 4.7,
      'reviews': 113489,
      'pages': '328',
      'publisher': 'Secker & Warburg',
      'isbn': '978-0451524935',
      'language': 'English',
      'excerpt': 'It was a bright cold day in April, and the clocks were striking thirteen. Winston Smith, his chin nuzzled into his breast in an effort to escape the vile wind, slipped quickly through the glass doors of Victory Mansions, though not quickly enough to prevent a swirl of gritty dust from entering along with him.\n\nThe hallway smelt of boiled cabbage and old rag mats. At one end of it a coloured poster, too large for indoor display, had been tacked to the wall. It depicted simply an enormous face, more than a metre wide: the face of a man of about forty-five, with a heavy black moustache and ruggedly handsome features.\n\nWinston made for the stairs. It was no use trying the lift. Even at the best of times it was seldom working, and at present the electric current was cut off during daylight hours.',
    },
    {
      'name': 'Pride and Prejudice',
      'author': 'Jane Austen',
      'price': 349,
      'category': 'Romance',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1320399351i/1885.jpg',
      'description': 'Since its immediate success in 1813, Pride and Prejudice has remained one of the most popular novels in the English language.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Romance', 'Classic', 'Fiction'],
      'rating': 4.8,
      'reviews': 87652,
      'pages': '432',
      'publisher': 'T. Egerton',
      'isbn': '978-0141439518',
      'language': 'English',
      'excerpt': 'It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife. However little known the feelings or views of such a man may be on his first entering a neighbourhood, this truth is so well fixed in the minds of the surrounding families, that he is considered as the rightful property of some one or other of their daughters.\n\n"My dear Mr. Bennet," said his lady to him one day, "have you heard that Netherfield Park is let at last?"\n\nMr. Bennet replied that he had not. "But it is," returned she; "for Mrs. Long has just been here, and she told me all about it."',
    },
    {
      'name': 'The Midnight Library',
      'author': 'Matt Haig',
      'price': 549,
      'category': 'Fiction',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1602190253i/52578297.jpg',
      'description': 'Between life and death there is a library. When Nora Olson finds herself in the Midnight Library, she has a chance to make things right.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Fiction', 'Fantasy', 'Contemporary'],
      'rating': 4.8,
      'reviews': 23471,
      'pages': '304',
      'publisher': 'Canongate Books',
      'isbn': '978-1786892737',
      'language': 'English',
      'excerpt': 'Nineteen years before she decided to die, Nora Seed sat in the warmth of a library. She was eleven years old, and the library — the school library — was her favourite place in the world.\n\nMrs. Elm was the librarian. She was a small woman with white hair and a kindly, timeless face that Nora found hard to age. She wore cardigans and had a habit of picking up a book, reading a couple of lines and then laughing quietly to herself as if she were sharing a private joke with the author.\n\n"Reading is the best thing you can do, Nora," she had once said. "It is like living inside possibility."',
    },
    {
      'name': 'Atomic Habits',
      'author': 'James Clear',
      'price': 649,
      'category': 'Self-Help',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1655988385i/40121378.jpg',
      'description': 'A groundbreaking guide to building good habits and breaking bad ones. Tiny changes, remarkable results.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Self-Help', 'Psychology', 'Productivity'],
      'rating': 4.9,
      'reviews': 45892,
      'pages': '320',
      'publisher': 'Avery Publishing',
      'isbn': '978-0735211292',
      'language': 'English',
      'excerpt': 'The fate of British Cycling changed one day in 2003 when the organization hired Dave Brailsford as its new performance director. At the time, professional cycling in Great Britain had endured almost one hundred years of mediocrity.\n\nBrailsford had been hired to put British Cycling on a new trajectory. What made him different from previous coaches was his relentless commitment to a strategy he referred to as "the aggregation of marginal gains," which was the philosophy of searching for a tiny margin of improvement in everything you do.\n\n"The whole principle came from the idea that if you broke down everything you could think of that goes into riding a bike, and then improved it by 1 percent, you will get a significant increase when you put them all together," Brailsford explained.',
    },
    {
      'name': 'Project Hail Mary',
      'author': 'Andy Weir',
      'price': 599,
      'category': 'Sci-Fi',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1597695864i/54493401.jpg',
      'description': 'Ryland Grace is the sole survivor on a desperate, last-chance mission — and if he fails, humanity and the earth itself will perish.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Sci-Fi', 'Adventure', 'Thriller'],
      'rating': 4.9,
      'reviews': 31204,
      'pages': '476',
      'publisher': 'Ballantine Books',
      'isbn': '978-0593135204',
      'language': 'English',
      'excerpt': 'What\'s two plus two?\n\nI don\'t know.\n\nI mean, I know the answer. Four. That\'s not the point. I\'m just using it to check some things. I know four. I know math. I know... a lot of things. I know way more than I should. I\'m very smart. Also, I have no idea where I am, and it occurs to me that I might be dead.\n\nI open my eyes. White ceiling. White walls. I\'m lying in a bed. There\'s a rhythmic beeping coming from next to me. I\'m in a medical bay. I look around. There are two other beds in here with me, and both of them have... bodies in them.',
    },
    {
      'name': 'The Thursday Murder Club',
      'author': 'Richard Osman',
      'price': 499,
      'category': 'Mystery',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1586534517i/46000520.jpg',
      'description': 'In a peaceful retirement village, four unlikely friends meet weekly in the Jigsaw Room to investigate unsolved crimes.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Mystery', 'Crime', 'Humor'],
      'rating': 4.7,
      'reviews': 18903,
      'pages': '382',
      'publisher': 'Viking',
      'isbn': '978-1984880963',
      'language': 'English',
      'excerpt': 'Thursday. Coopers Chase Retirement Village, Kent. It has been raining for eleven days, and Elizabeth Best is at her wit\'s end. She has not left her flat for a week.\n\nOn her desk in front of her lies a photograph. A woman on a beach. The woman is smiling. Elizabeth supposes she was smiling too, when she took the picture. This was before, though.\n\nThe photograph has been there for six days, staring up at her. She has picked it up many times but has not yet been able to work out what it means, or what it might lead to. She knows it leads somewhere — Elizabeth always knows these things.',
    },
    {
      'name': 'Educated',
      'author': 'Tara Westover',
      'price': 529,
      'category': 'Non-Fiction',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1506026635i/35133922.jpg',
      'description': 'A memoir about a young girl who, kept out of school, leaves her survivalist family and goes on to earn a PhD from Cambridge University.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Memoir', 'Non-Fiction', 'Education'],
      'rating': 4.8,
      'reviews': 29456,
      'pages': '334',
      'publisher': 'Random House',
      'isbn': '978-0399590504',
      'language': 'English',
      'excerpt': 'I\'m standing on the mountain, my father behind me. He says, "You\'re going to be okay." I\'m not sure I believe him. I\'m not sure of anything, standing here on this cold mountain in the early morning light.\n\nMy father is a man of strong opinions and I have never been able to separate his strength from his certainty. He believes things fully, with his whole self. He believes the mountain is sacred, that to level it would be a sacrilege. He believes the government is a threat. He believes the end of days is coming.\n\nHe believes I should not be here. Not on this mountain, not in this life, not in this world that he has spent thirty years trying to keep away from his family.',
    },
    {
      'name': 'The Seven Husbands of Evelyn Hugo',
      'author': 'Taylor Jenkins Reid',
      'price': 549,
      'category': 'Romance',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1664458703i/32620332.jpg',
      'description': 'Aging Hollywood starlet Evelyn Hugo finally chooses an unknown journalist to tell her riveting life story.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Romance', 'Fiction', 'Historical'],
      'rating': 4.9,
      'reviews': 52341,
      'pages': '400',
      'publisher': 'Washington Square Press',
      'isbn': '978-1501161933',
      'language': 'English',
      'excerpt': 'I was working at Vivant as a staff writer — low on the totem pole but still on it — when the call came in that Evelyn Hugo wanted to give her story exclusively to our magazine and she wanted me to write it.\n\nI had been at Vivant for three years. In those three years, I had interviewed two congresswomen, one astronaut, and a handful of local celebrities. I had written two cover stories and had gotten a raise after the second one.\n\nSo when Evelyn Hugo\'s publicist called our office and said Ms. Hugo was prepared to grant the interview of a lifetime, I had no reason to believe she was asking for me.',
    },
    {
      'name': 'Sapiens',
      'author': 'Yuval Noah Harari',
      'price': 699,
      'category': 'History',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1420585954i/23692271.jpg',
      'description': 'A brief history of humankind — from the Stone Age to the present. Harari explores how Homo sapiens came to rule the world.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['History', 'Science', 'Anthropology'],
      'rating': 4.7,
      'reviews': 67823,
      'pages': '464',
      'publisher': 'Harper',
      'isbn': '978-0062316097',
      'language': 'English',
      'excerpt': 'About 13.5 billion years ago, matter, energy, time and space came into being in what is known as the Big Bang. The story of these fundamental features of our universe is called physics.\n\nAbout 300,000 years after their appearance, matter and energy started to coalesce into complex structures, called atoms, which then combined into molecules. The story of atoms, molecules and their interactions is called chemistry.\n\nAbout 3.8 billion years ago, on a planet called Earth, certain molecules combined to form particularly large and intricate structures called organisms. The story of organisms is called biology.',
    },
    {
      'name': 'Gone Girl',
      'author': 'Gillian Flynn',
      'price': 459,
      'category': 'Mystery',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1554086139i/19288043.jpg',
      'description': 'On the morning of their fifth wedding anniversary, Nick Dunne\'s wife Amy suddenly disappears. The police suspect Nick — and soon so does everyone else.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Mystery', 'Thriller', 'Psychological'],
      'rating': 4.6,
      'reviews': 41206,
      'pages': '422',
      'publisher': 'Crown Publishing',
      'isbn': '978-0307588371',
      'language': 'English',
      'excerpt': 'When I think of my wife, I always think of her head. The shape of it, to begin with. The very first time I saw her, it was the back of the head I saw, and there was something lovely about it, the angles of it.\n\nLike a shiny, hard corn kernel or a riverbed fossil. She had what the Victorians would call a finely shaped head. You could imagine the skull quite easily.\n\nI\'d know her head anywhere. And what\'s inside it. I think of that, too: her mind. Her brain, all those coils, and her thoughts shuttling through those coils like fast, frantic centipedes.',
    },
    {
      'name': 'The Alchemist',
      'author': 'Paulo Coelho',
      'price': 399,
      'category': 'Fiction',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1654371463i/18144590.jpg',
      'description': 'A magical story about Santiago, an Andalusian shepherd boy who yearns to travel in search of a worldly treasure.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Fiction', 'Philosophy', 'Adventure'],
      'rating': 4.7,
      'reviews': 89234,
      'pages': '208',
      'publisher': 'HarperOne',
      'isbn': '978-0062315007',
      'language': 'English',
      'excerpt': 'The boy\'s name was Santiago. Dusk was falling as the boy arrived with his herd at an abandoned church. The roof had fallen in long ago, and an enormous sycamore had grown up where the sacristy had once been.\n\nHe decided to spend the night there. He saw to it that all the sheep entered through the ruined gate, and then laid down some planks of wood against it to prevent the flock from wandering away during the night.\n\nThere were no wolves in the region, but once an animal had strayed during the night, and the boy had had to spend the entire next day searching for it.',
    },
    {
      'name': 'Dune',
      'author': 'Frank Herbert',
      'price': 649,
      'category': 'Sci-Fi',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1555447414i/44767458.jpg',
      'description': 'Set on the desert planet Arrakis, Dune is the story of Paul Atreides — heir to a noble family in control of the most precious element in the galaxy.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Sci-Fi', 'Fantasy', 'Classic'],
      'rating': 4.8,
      'reviews': 56104,
      'pages': '688',
      'publisher': 'Ace Books',
      'isbn': '978-0441013593',
      'language': 'English',
      'excerpt': 'A beginning is the time for taking the most delicate care that the balances are correct. This every sister of the Bene Gesserit knows.\n\nTo begin your study of the life of Muad\'Dib, then take care that you first place him in his time: born in the 57th year of the Padishah Emperor, Shaddam IV. And take the most special care that you locate Muad\'Dib in his place: the planet Arrakis. Do not be deceived by the fact that he was born on Caladan and lived his first fifteen years there. Arrakis, the planet known as Dune, is forever his place.',
    },
    {
      'name': 'The Psychology of Money',
      'author': 'Morgan Housel',
      'price': 499,
      'category': 'Self-Help',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1581527774i/41881472.jpg',
      'description': 'Timeless lessons on wealth, greed, and happiness. Doing well with money isn\'t about what you know — it\'s about how you behave.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Finance', 'Self-Help', 'Non-Fiction'],
      'rating': 4.8,
      'reviews': 41209,
      'pages': '256',
      'publisher': 'Harriman House',
      'isbn': '978-0857197689',
      'language': 'English',
      'excerpt': 'Let me tell you about a problem I\'ve seen in finance. I call it the Vegas paradox. Most people know that Vegas is designed to take your money. The house always wins, in the long run.\n\nBut there\'s a peculiar thing about Vegas. More than 40 million people visit every year — not despite the fact that the odds are stacked against them, but seemingly because of it.\n\nFinance works the same way. People make predictably irrational decisions. Not because they\'re stupid, but because they grew up with a different relationship with money than you, or because they\'re optimizing for something other than what you think they should.',
    },
    {
      'name': 'Meditations',
      'author': 'Marcus Aurelius',
      'price': 349,
      'category': 'Non-Fiction',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1569760148i/30659.jpg',
      'description': 'The private journal of the greatest of the philosopher-kings. His thoughts on Stoic philosophy, wisdom, and the art of living remain profound and timeless.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Philosophy', 'Classic', 'Non-Fiction'],
      'rating': 4.9,
      'reviews': 57823,
      'pages': '254',
      'publisher': 'Modern Library',
      'isbn': '978-0812968255',
      'language': 'English',
      'excerpt': 'Begin the morning by saying to thyself, I shall meet with the busy-body, the ungrateful, arrogant, deceitful, envious, unsocial. All these things happen to them by reason of their ignorance of what is good and evil.\n\nBut I who have perceived the nature of the good that it is beautiful, and of the bad that it is ugly, and the nature of him who does wrong, that it is akin to me, I can neither receive injury from any of them, for no one can fix on me what is ugly, nor can I be angry with my kinsman.\n\nFor we are made for co-operation, like feet, like hands, like eyelids, like the rows of the upper and lower teeth.',
    },
    {
      'name': 'The Hitchhiker\'s Guide to the Galaxy',
      'author': 'Douglas Adams',
      'price': 429,
      'category': 'Sci-Fi',
      'image': 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1559986835i/386162.jpg',
      'description': 'Seconds before Earth is destroyed to make way for a hyperspace bypass, Arthur Dent is plucked off the planet by his friend Ford Prefect.',
      'formats': ['Hardcover', 'Paperback'],
      'genres': ['Sci-Fi', 'Comedy', 'Classic'],
      'rating': 4.8,
      'reviews': 48301,
      'pages': '224',
      'publisher': 'Del Rey',
      'isbn': '978-0345391803',
      'language': 'English',
      'excerpt': 'Far out in the uncharted backwaters of the unfashionable end of the Western Spiral arm of the Galaxy lies a small unregarded yellow sun. Orbiting this at a distance of roughly ninety-two million miles is an utterly insignificant little blue-green planet whose ape-descended life forms are so amazingly primitive that they still think digital watches are a pretty neat idea.\n\nThis planet has — or rather had — a problem, which was this: most of the people living on it were unhappy for pretty much all of the time. Many solutions were suggested for this problem, but most of these were largely concerned with the movements of small green pieces of paper, which is odd because on the whole it wasn\'t the small green pieces of paper that were unhappy.\n\nAnd so the problem remained; lots of people were mean, and most of them were miserable, even the ones with digital watches.',
    },
  ];

  List<Map<String, dynamic>> get filteredBooks {
    if (selectedCategory == 'All') return books;
    return books.where((b) => b['category'] == selectedCategory).toList();
  }

  // ── Excerpt preview bottom sheet ──────────────────────────────────────────
  void _showExcerptPreview(Map<String, dynamic> book) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.72,
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          border: Border(top: BorderSide(color: _border, width: 1)),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 12, bottom: 16),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(color: _border, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              // Header: small cover + title + author
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book['image'],
                        width: 56,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 56,
                          height: 80,
                          color: Color(0xFF8B4513).withOpacity(0.15),
                          child: Center(child: Text('📖')),
                        ),
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Color(0xFF8B4513).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'EXCERPT PREVIEW',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF8B4513),
                                letterSpacing: 1.4,
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            book['name'],
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: _text, height: 1.25),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 3),
                          Text(book['author'], style: TextStyle(fontSize: 12, color: _subtext)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(height: 1, color: _border, margin: EdgeInsets.symmetric(horizontal: 20)),
              SizedBox(height: 16),
              // Scrollable excerpt body
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    book['excerpt'] ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      color: _text,
                      height: 1.75,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ),
              // Continue Reading CTA
              Padding(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => BookReadingPage(book: book, isDark: widget.isDark),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF2C1810), Color(0xFF8B4513)]),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: Color(0xFF8B4513).withOpacity(0.3), blurRadius: 10, offset: Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.book_fill, color: Color(0xFFE8D5B7), size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Continue Reading',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFFFFFFF), letterSpacing: 0.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: _bg,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('📚', style: TextStyle(fontSize: 28)),
                        SizedBox(width: 8),
                        Text(
                          'IVORY & INK',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: 5, color: _text),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${books.length} curated titles in our collection',
                      style: TextStyle(fontSize: 13, color: _subtext),
                    ),
                  ],
                ),
              ),
            ),

            // Featured Banner
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 4, 20, 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C1810), Color(0xFF8B4513)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Color(0xFF8B4513).withOpacity(0.35), blurRadius: 16, offset: Offset(0, 6)),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8D5B7).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'THIS WEEK\'S PICK',
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFFE8D5B7), letterSpacing: 1.5),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Free shipping on\n every orders ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFFFFFFFF), height: 1.2),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(color: Color(0xFFE8D5B7), borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              'Shop Now',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF2C1810)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('📖', style: TextStyle(fontSize: 60)),
                  ],
                ),
              ),
            ),

            // Categories
            SliverToBoxAdapter(
              child: Container(
                height: 44,
                margin: EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = selectedCategory == cat;
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = cat),
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFF8B4513) : _card,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: isSelected ? Color(0xFF8B4513) : _border),
                          boxShadow: isSelected
                              ? [BoxShadow(color: Color(0xFF8B4513).withOpacity(0.3), blurRadius: 8, offset: Offset(0, 3))]
                              : null,
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: isSelected ? Color(0xFFFFFFFF) : _subtext,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Books grid
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.62,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildBookCard(filteredBooks[index]),
                  childCount: filteredBooks.length,
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => BookDetailPage(
              book: book,
              onAddToCart: widget.onAddToCart,
              isDark: widget.isDark,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF8B4513).withOpacity(widget.isDark ? 0.1 : 0.07),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  book['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Color(0xFF8B4513).withOpacity(0.15),
                    child: Center(child: Text('📖', style: TextStyle(fontSize: 48))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book['name'],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _text, height: 1.2),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3),
                  Text(book['author'], style: TextStyle(fontSize: 11, color: _subtext), maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(CupertinoIcons.star_fill, size: 11, color: Color(0xFFFFAA00)),
                      SizedBox(width: 3),
                      Text('${book['rating']}', style: TextStyle(fontSize: 11, color: _subtext)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₱${book['price']}',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: _text),
                      ),
                      // Preview button → opens excerpt bottom sheet
                      GestureDetector(
                        onTap: () => _showExcerptPreview(book),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Color(0xFF8B4513).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFF8B4513).withOpacity(0.3)),
                          ),
                          child: Icon(CupertinoIcons.book, size: 13, color: Color(0xFF8B4513)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}