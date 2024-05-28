import java.util.*;
import org.apache.commons.math3.distribution.ChiSquaredDistribution;
import org.apache.commons.math3.distribution.NormalDistribution;

public class PruebasEstadisticas {

    private static int opcion;
    private static int n = 0;
    private static double Alpha;
    private static int k;

    public static void main(String[] arg) {

        try (Scanner sc = new Scanner(System.in)) {
            System.out.println(
                    "Se puede elegir opciones de pruebas estadisticas \n\t1.-Prueba de la Normal \n\t2.-Prueba de la Frecuencia \nEscoge una de las opciones: ");
            opcion = sc.nextInt();
        }

        double[][] muestra = new double[2][5];
        muestra[0] = new double[] { 0.32, 0.04, 0.81, 0.77, 0.69 };
        muestra[1] = new double[] { 0.16, 0.45, 0.63, 0.29, 0.94 };

        if (opcion == 1) {

            try (Scanner sc = new Scanner(System.in)) {
                System.out.println(
                        "Introduzca el valor de Alpha en porcentaje entero: ");
                double res = sc.nextInt();
                Alpha = res / 100;
            }
            PruebaNormal(muestra);
        }

        if (opcion == 2) {
            try (Scanner sc = new Scanner(System.in)) {
                System.out.println(
                        "Introduzca el valor de Alpha en porcentaje entero: ");
                double res = sc.nextInt();
                Alpha = res / 100;

                System.out.println(
                        "Introduzca el valor de K: ");
                k = sc.nextInt();
            }

            PruebaFrecuencia(muestra);

        }
    }

    public static void PruebaNormal(double[][] muestra) {

        // Paso 1
        Tamanio(muestra);
        System.out.println("n = " + n + "");

        // Paso 2
        double media = (sumarMatriz(muestra) / n);
        System.out.println("media = " + media + "");

        // Paso 3
        double z = (((media - 0.5) * (Math.sqrt(n))) / (Math.sqrt(1.0 / 12)));
        double ValorZ = Math.round(z * 10000) / 10000.0;
        System.out.println("ValorZ = " + ValorZ + "");

        // Paso 4
        double alpha = Alpha; // nivel de significancia
        double zAlphaDiv2 = getZAlphaDiv2(alpha);
        System.out.println("Z alpha/2 = " + zAlphaDiv2 + "");

        // Paso 5
        if (ValorZ < zAlphaDiv2) {
            // Paso 6
            System.out.println("UNIFORMIDAD");
        } else {
            System.out.println("NO UNIFORMIDAD");
        }
    }

    public static void PruebaFrecuencia(double[][] muestra) {
        // Paso 1
        Tamanio(muestra);
        System.out.println("n = " + n + "");

        // Paso 2
        double FE = (((double) (n)) / k);
        System.out.println("FE = " + FE + "");

        // Paso 3
        double div = 1.0 / k;
        double[] listaIntervalos = new double[k + 1];
        listaIntervalos[0] = 0.0;
        for (int i = 1; i <= k; i++) {
            listaIntervalos[i] = div * i;
        }

        int frecuencia[] = new int[k];
        // llenar matriz
        for (int i = 0; i < k; i++) {
            frecuencia[i] = 0;
        }

        for (int i = 0; i < muestra.length; i++) {
            for (int j = 0; j < muestra[i].length; j++) {
                double num = muestra[i][j];
                for (int k = 0; k < listaIntervalos.length - 1; k++) {
                    if (num >= listaIntervalos[k] && num < listaIntervalos[k + 1]) {
                        frecuencia[k]++;
                    }
                }
            }
        }
        System.out.println("FO");
        for (int i = 0; i < k; i++) {
            System.out.println(frecuencia[i]);
        }

        // Paso 4
        double xCuadrado = (Math.pow((FE - frecuencia[0]), 2) / FE);
        for (int i = 1; i < k; i++) {
            xCuadrado = xCuadrado + (Math.pow((FE - frecuencia[i]), 2) / FE);
        }

        // Paso 5
        ChiSquaredDistribution chiSquaredDist = new ChiSquaredDistribution(k - 1);
        double chiSquaredValue = chiSquaredDist.inverseCumulativeProbability(1 - Alpha);

        System.out.println("X^2 alpha, k-1 = " + chiSquaredValue);
        //Paso 6
        if(xCuadrado < chiSquaredValue){
            System.out.println("UNIFORMIDAD");
        }else{
            System.out.println("NO UNIFORMIDAD");
        }
    }

    public static void Tamanio(double[][] muestra) {
        for (int i = 0; i < muestra.length; i++) {
            for (int j = 0; j < muestra[i].length; j++) {
                n++;
            }
        }
    }

    public static double sumarMatriz(double[][] matriz) {
        double suma = 0;
        for (int i = 0; i < matriz.length; i++) {
            for (int j = 0; j < matriz[i].length; j++) {
                suma += matriz[i][j];
            }
        }
        return suma;
    }

    public static double getZAlphaDiv2(double alpha) {
        NormalDistribution normalDist = new NormalDistribution();
        double zAlphaDiv2 = normalDist.inverseCumulativeProbability(1 - (alpha / 2));
        return zAlphaDiv2;
    }

}
