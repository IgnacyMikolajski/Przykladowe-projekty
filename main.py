import pygame
import random
import klasy
pygame.mixer.pre_init(44100, -16, 2, 2048)
pygame.init()

pygame.mixer.init()
# stałe
clock = pygame.time.Clock()
screen = pygame.display.set_mode((850, 531))

tło_gry = pygame.image.load(r'C:\Users\Lenovo\PycharmProjects\game1\pliki do gry\tło.jpg')
# załadowanie i otwożenie muzyki 
pygame.mixer.music.load(r'C:\Users\Lenovo\PycharmProjects\game1\Muzyka i dzwienki/music1.wav')
pygame.mixer.music.set_volume(0.1)
pygame.mixer.music.play(-1)


# ustawienie poczontkowych parametrów gry
running = True

mode = 0
#inicjalizacja trzcionek i komunikatów do komunikacji z graczem
font = pygame.font.Font(None, 40)
font2 = pygame.font.Font(None, 60)
font3 = pygame.font.Font(None, 30)
pozycja1= 40,120
pozycja2= 400,120
text3 = font2.render("", True, pygame.Color("black"))
text_rect3 = text3.get_rect(center=(400, 400))
# pentla gry

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
#tryb konfiguracji gry ekran startowy
    if mode == 0:
        klawisz = pygame.key.get_pressed()
        background_color = (255, 255, 255)
        screen.fill(background_color)

        text0 = font3.render("strzałka w gure poziom trudniści normalny strzałka w duł trudny", True, pygame.Color("black"))
        text_rect0 = text0.get_rect(center=(400, 100))
        screen.blit(text0, text_rect0)
        screen.blit(text3, text_rect3)
        poziom=0
        if klawisz[pygame.K_DOWN] or klawisz[pygame.K_s]:
            pudelko = klasy.wybieralka(4)
            collision_sound = pygame.mixer.Sound(r'C:\Users\Lenovo\PycharmProjects\game1\Muzyka i dzwienki/hit_sound.wav')

            bot = klasy.CPU(r'C:\Users\Lenovo\PycharmProjects\game1\pliki do gry/pok2.png', 20, "nic", 2)
            player = klasy.Player(r'C:\Users\Lenovo\PycharmProjects\game1\pliki do gry/pok1.png', 20, "nic")
            kulka = klasy.animacje_i_dziwienk(r'C:\Users\Lenovo\PycharmProjects\game1\pliki do gry/images1.png', r'C:\Users\Lenovo\PycharmProjects\game1\pliki do gry/images2.png', 40, 20, 500, bot,collision_sound)
            arena = klasy.arena(1, player, bot, pudelko, kulka)
            mode = 1

            hp1 = str(player.hp)
            hp2 = str(bot.hp)



        if klawisz[pygame.K_UP] or klawisz[pygame.K_w]:
            pudelko = klasy.wybieralka(5)
            collision_sound = pygame.mixer.Sound(r'C:\Users\Lenovo\PycharmProjects\game1\Muzyka i dzwienki/hit_sound.wav')

            bot = klasy.CPU(r'C:\Users\Lenovo\PycharmProjects\game1\pliki do gry/pok2.png', 20, "nic", 1)
            player = klasy.Player(r'C:\Users\Lenovo\PycharmProjects\game1\pliki do gry/pok1.png', 20, "nic")
            kulka = klasy.animacje_i_dziwienk(r'C:\Users\Lenovo\PycharmProjects\game1\pliki do gry/images1.png', r'C:\Users\Lenovo\PycharmProjects\game1\pliki do gry/images2.png', 40, 20, 500, bot,collision_sound)
            arena = klasy.arena(1, player, bot, pudelko, kulka)

            hp1 = str(player.hp)
            hp2 = str(bot.hp)
            mode = 1








# główna czenść gry
    if mode == 1:
        #zawsze wysiwietlana część gry

        klawisz = pygame.key.get_pressed()
        screen.blit(tło_gry, (0, 0))
        arena.rysuj(screen)

        text1 = font.render(hp1, True, pygame.Color("black"))
        text_rect = text1.get_rect(center=(100, 400))
        screen.blit(text1, text_rect)
        text2 = font.render(hp2, True, pygame.Color("black"))
        text_rect2 = text2.get_rect(center=(700, 400))
        screen.blit(text2, text_rect2)

        #

        if pudelko.zatwierdzenie == 0:
            arena.wybierz(screen, klawisz)
            kulka.kolizja =0
            kulka.rect.center=20,500
            arena.turn=0
        if pudelko.zatwierdzenie ==1 :
            if arena.turn == 0:
                arena.walka()
                hp1 = str(player.hp)
                hp2 = str(bot.hp)
                print(player.hp)
                print(bot.hp)


            arena.animacja_ataku(screen)

            if kulka.kolizja == 1:
                pudelko.zatwierdzenie = 0

        if player.hp <=0 or bot.hp <=0 :
            mode = 2
# sprawdzenie wyniku walki i wysiwietlenie komunikatu konicowego przekierowanie do trybu 0 (poczontkowego)
    if mode == 2:
        if player.hp > 0 and bot.hp <= 0:
            text3 = font2.render("wygrałeś", True, pygame.Color("black"))



        if bot.hp > 0 and player.hp <= 0:
            text3 = font2.render("przegrałeś", True, pygame.Color("black"))


        if bot.hp <= 0 and player.hp <= 0:
            text3 = font2.render("remis", True, pygame.Color("black"))

        klawisz = pygame.key.get_pressed()
        mode = 0


    pygame.display.update()
    clock.tick(60)


