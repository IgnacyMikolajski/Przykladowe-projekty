import java.util.List;
import java.util.concurrent.Callable;
import java.util.Random;






public class MujCalable implements Callable<Integer> {
    List<Integer> cos;
    private Random random = new Random();

    MujCalable(List<Integer> toś) {
        this.cos = toś;
    }

    @Override
    public Integer call() throws Exception {
        int liczba = random.nextInt(100) + 1;
        boolean uniklana = czyLiczbaUnikalna(liczba);

        //System.out.println(!uniklana);
        //System.out.println("\n");

        if (!uniklana) {
            return liczba;
        } else {
            return 0;
        }
    }
        public void wypisz () {
            System.out.println(cos.get(0));
        }

        private synchronized boolean czyLiczbaUnikalna ( int liczba){
            List<Integer> tablica = Wielowontkowość.getZmiennaA();
            return tablica.contains(liczba);
        }



}
