import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Wielowontkowość {
  static List<Integer> lista= new ArrayList();

    public static List<Integer> getZmiennaA() {
        return lista;
    }

    public static void setZmiennaA(List<Integer> nowaWartosc) {
        lista = nowaWartosc;
    }
    public static void main(String[] args) throws ExecutionException, InterruptedException {
       // ArrayList<Integer> lista = new ArrayList<>();

        MujCalable a = new MujCalable(lista);
        MujCalable b = new MujCalable(lista);
        MujCalable c = new MujCalable(lista);

        ExecutorService executorService = Executors.newFixedThreadPool(3);
        int i = 0;

        while(i<30){

        Future<Integer> wynik = executorService.submit(c);
        Future<Integer> wynik2 = executorService.submit(b);
        Future<Integer> wynik3 = executorService.submit(a);

        Integer wynikOperacji = wynik.get();
        Integer wynikOperacji2 = wynik2.get();
        Integer wynikOperacji3 = wynik3.get();


        lista.add(wynikOperacji);
        lista.add(wynikOperacji2);
        lista.add(wynikOperacji3);
        System.out.println(wynikOperacji+" wynik1");
        System.out.println(wynikOperacji2+" wynik2");
        System.out.println(wynikOperacji+" wynik3");

    i=i+1;
        }
        executorService.shutdown();
}}
