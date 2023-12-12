import pygame
import random

class base_monster(pygame.sprite.Sprite):
    def __init__(self, image,hp):
        super().__init__()
        self.image = pygame.image.load(image)
        self.rect = self.image.get_rect()
        self.rect.center = 100,480
        self.hp=hp
        self.hp_max=hp
        self.move=None

    def rysuj(self, surface):
        surface.blit(self.image, self.rect)


    #move_1 ruch stworka move_2 ruch przeciwnego stworka
    def obrażenia(self,move_1,move_2):
        if move_1 =="fire":
            if move_2=="water":
                self.hp=self.hp-2
            else:
                self.hp = self.hp - 1

        if move_1=="water":
            if move_2=="wind":
                self.hp = self.hp - 2
            else:
                self.hp = self.hp - 1

        if move_1=="wind":
            if move_2=="fire":
                self.hp = self.hp - 2

            else:
                self.hp = self.hp - 1

class Player(base_monster):
    def __init__(self, image, hp, move):
        super().__init__(image, hp)
        self.rect.center = 100, 480
        self.move = move


    def ruch(self,opcja):
        if opcja == 1:
            self.move="apteczka"
            self.hp += 3
            if self.hp > self.hp_max:
                self.hp = self.hp_max


        if opcja == 2:
            self.move="fire"

        if opcja ==3:
            self.move="water"

        else:
            self.move="wind"

class CPU(Player):
    def __init__(self, image, hp,move,healing_potions):
        super().__init__(image, hp,move)
        self.rect.center = 700, 470

        self.healing_potions=healing_potions

    def ruch(self):

        if self.healing_potions > 0:
            option=random.randint(1, 4)

        else:
            option= random.randint(2, 4)

        if option == 1:
            self.move = "apteczka"
            if self.hp == self.hp_max:
                self.hp = self.hp
            if self.hp == (self.hp_max - 1):
                self.hp = self.hp_max
            if self.hp == self.hp_max - 2:
                self.hp = self.hp_max

            else:
                self.hp = self.hp + 3

            self.healing_potions=self.healing_potions-1

        if  option == 2:
            self.move = "fire"

        if  option == 3:
            self.move = "water"

        if option == 4:
            self.move = "wind"


import pygame

class wybieralka(pygame.sprite.Sprite):
    def __init__(self, healing_potions):
        super().__init__()
        self.healing_potions = healing_potions
        self.opcja = None
        self.font = pygame.font.Font(None, 18)
        self.nr=1
        self.frame_counter = 0
        self.frame_check_interval = 6
        self.zatwierdzenie=0

    def rysuj(self, surface,):
        white = pygame.Color("white")
        fill_rect = pygame.Rect(0, 0, 850, 150)  # Przykładowy prostokąt wypełnienia
        surface.fill(white, fill_rect)

        text1 = self.font.render("Atak ognisty", True, pygame.Color("black"))
        text_rect = text1.get_rect(center=(60, 10))
        surface.blit(text1, text_rect)

        text2 = self.font.render("Atak wodny", True, pygame.Color("black"))
        text_rect = text2.get_rect(center=(55, 30))
        surface.blit(text2, text_rect)

        text3 = self.font.render("Atak powietrzny", True, pygame.Color("black"))
        text_rect = text3.get_rect(center=(69,50))
        surface.blit(text3, text_rect)

        liczba_potek=str(self.healing_potions)
        wiadomość="Użycie eliksiru leczoncego możliwe użycia = "+ liczba_potek
        if self.healing_potions > 0:
            text4 = self.font.render(wiadomość, True, pygame.Color("black"))
            text_rect = text4.get_rect(center=(154, 70))
            surface.blit(text4, text_rect)


        if self.nr == 1:
            text1 = self.font.render("Atak ognisty", True, pygame.Color("red"))
            text_rect = text1.get_rect(center=(60, 10))
            surface.blit(text1, text_rect)
            self.opcja = 2
        elif self.nr == 2:
            text2 = self.font.render("Atak wodny", True, pygame.Color("red"))
            text_rect = text2.get_rect(center=(55, 30))
            surface.blit(text2, text_rect)
            self.opcja = 3
        elif self.nr == 3:
            text3 = self.font.render("Atak powietrzny", True, pygame.Color("red"))
            text_rect = text3.get_rect(center=(69, 50))
            surface.blit(text3, text_rect)
            self.opcja = 4

        elif self.nr == 4:
            if self.healing_potions>0:
                text4 = self.font.render(wiadomość, True, pygame.Color("red"))
                text_rect = text4.get_rect(center=(154, 70))
                surface.blit(text4, text_rect)
                self.opcja = 1

            else :
                text4 = self.font.render("nie masz jusz eliksirów użyj innej opcji ", True, pygame.Color("red"))
                text_rect = text4.get_rect(center=(130, 70))
                surface.blit(text4, text_rect)
                self.opcja=5





    def wybierz(self,klawisz):


        if klawisz[pygame.K_DOWN] or klawisz[pygame.K_s]:

            if self.nr == 4:
                self.nr = 1
            else:
                self.nr = self.nr + 1
        if klawisz[pygame.K_UP] or klawisz[pygame.K_w]:

            if self.nr == 1:
                self.nr = 4
            else:
                self.nr = self.nr - 1



        if klawisz[pygame.K_RETURN]:
            if self.opcja != 5:
                self.zatwierdzenie = 1
                if self.opcja == 1:
                    self.healing_potions -= 1





    def update(self,surface,klawisz):
        if self.zatwierdzenie == 0:
            self.rysuj(surface)
            self.frame_counter += 1
            if self.frame_counter % self.frame_check_interval == 0:
                self.wybierz(klawisz)


class animacje_i_dziwienk(pygame.sprite.Sprite):
    def __init__(self,zd1,zd2,ruch,cx,cy,obiekt_kolizyjny,collision_sound):
        super().__init__()

        self.image1 = pygame.image.load(zd1)
        self.image2=pygame.image.load(zd2)
        self.image=self.image1
        self.obiekt_kolizyjny=obiekt_kolizyjny
        self.rect = self.image1.get_rect()
        self.rect.center = cx,cy
        self.przesun=ruch
        self.kolizja=0
        self.frame_counter = 0
        self.frame_check_interval = 6
        self.collision_sound=collision_sound

    def animuj(self,surface):
        if self.kolizja == 0:
            self.frame_counter += 1
            self.image = self.image1
            surface.blit(self.image, self.rect)
            if self.frame_counter % self.frame_check_interval == 0:
                self.image = self.image2
                surface.blit(self.image, self.rect)
                self.rect.x += self.przesun








        if self.rect.colliderect(self.obiekt_kolizyjny.rect):
            self.kolizja=1
            self.collision_sound.play()
            self.kill()





class arena(pygame.sprite.Sprite):
    def __init__(self,poziom_trudności,player,CPU,wybierałka,kulka):
        super().__init__()
        self.poziom_trudności=poziom_trudności
        self.player=player
        self.CPU=CPU
        self.player=player
        self.cpu=CPU
        self.wybierałka=wybierałka
        self.atak=kulka
        self.turn=0

    def rysuj(self,surface):
        self.cpu.rysuj(surface)
        self.player.rysuj(surface)

    def wybierz(self,surface,klawisz):
        self.wybierałka.update(surface, klawisz)

    def animacja_ataku(self,surface):
        self.atak.animuj(surface)

    def walka(self):
        self.player.ruch(self.wybierałka.opcja)
        self.CPU.ruch()
        self.player.obrażenia(self.player.move,self.CPU.move)
        self.CPU.obrażenia(self.CPU.move,self.player.move)
        self.turn=1
































