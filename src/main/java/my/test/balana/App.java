package my.test.balana;

import java.io.File;
import java.io.FilenameFilter;
import java.util.Collections;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;

import org.wso2.balana.*;
import org.wso2.balana.finder.impl.FileBasedPolicyFinderModule;

import org.wso2.balana.PDP;
import org.wso2.balana.PDPConfig;
import org.wso2.balana.finder.AttributeFinder;
import org.wso2.balana.finder.AttributeFinderModule;
import org.wso2.balana.finder.PolicyFinder;

import se.sics.DBAttributeFinderModule;

/**
 * My BALANA-with-DATABASE test!
 * Created by ipatini on 14/12/2016, using code from ExamplePDP of Ludwig
 */
public class App 
{
	/**
	 * Usage: java my.test.balana.App [-v] [-D<delay_sec>] [-R<eval_iterations>] [-c<precision>] [-I<uc_id>] [-P<policies_dir>] [<XACML-request-file> [<XACML-response-file> | -o]]
	 */
    public static void main( String[] args ) throws Exception
    {
		if (args.length==0) {
			System.out.println( "\nMy BALANA test!\n" );
			System.out.println("Usage: java my.test.balana.App [-v] [-D<delay_sec>] [-R<eval_iterations>] [-c<precision>] [-I<uc_id>] [-P<policies_dir>] [<XACML-request-file> [<XACML-response-file> | -o]]");
			return;
		}
		
		// Check for verbose flag
		int p = 0;
		boolean verbose = false;
		if (args.length>p && args[p].trim().equals("-v")) { verbose = true; p++; }
		
        if (verbose) System.out.println( "\nMy BALANA-with-DATABASE test!\n" );
		
		// Measure initial memory consumption
		Runtime rt = Runtime.getRuntime();
		double startMem = rt.totalMemory() - rt.freeMemory();
		
		// Insert a start delay if -D argument is specified
		long startDelay = 0;
		if (args.length>p && args[p].trim().startsWith("-D")) {
			startDelay = Long.parseLong(args[p].substring(2));
			try { Thread.currentThread().sleep(startDelay*1000); } catch (InterruptedException e) {}
			p++;
		}
		
		// Specify evaulation iterations if -R argument is specified
		int evalIterations = 1;
		if (args.length>p && args[p].trim().startsWith("-R")) { evalIterations = Integer.parseInt(args[p].trim().substring(2)); p++; }
		
		// Specify number of workers if -W argument is specified
		int numOfWorkers = 1;
		if (args.length>p && args[p].trim().startsWith("-W")) { numOfWorkers = Integer.parseInt(args[p].trim().substring(2)); p++; }
		
		// Specify measurements print precision
		int prec = 3;
		if (args.length>p && args[p].trim().startsWith("-c")) { prec = Integer.parseInt(args[p].trim().substring(2)); p++; }
		
		// Define a Use Case id (used to report measurements at the end)
		String runId = "";
		if (args.length>p && args[p].trim().startsWith("-I")) { runId = args[p].trim().substring(2); p++; }
		
		// Specify "policies" directory (default "policies")
		String policyDirectoryLocation = "policies";
		if (args.length>p && args[p].trim().startsWith("-P")) { policyDirectoryLocation = args[p].trim().substring(2); p++; }
        if (verbose) System.out.println( "POLICY-DIR:  "+policyDirectoryLocation );
		
		// Specify XACML request file (default "xacml-request.xml")
		String xacmlRequestFile = "xacml-request.xml";
		if (args.length>p && !args[p].trim().isEmpty()) { xacmlRequestFile = args[p].trim(); p++; }
		// Load XACML request from file
		String xacmlRequest = new java.util.Scanner(new java.io.File(xacmlRequestFile)).useDelimiter("\\Z").next();
        if (verbose) System.out.println( "XACML-REQUEST:\n"+xacmlRequest+"\n" );
		
		// BALANA configuration (loading of policies?)
		long tm0 = System.nanoTime();
		String configFileLocation = "balana.cfg.xml";
		System.setProperty(ConfigurationStore.PDP_CONFIG_PROPERTY, configFileLocation);
		System.setProperty(FileBasedPolicyFinderModule.POLICY_DIR_PROPERTY, policyDirectoryLocation);
		//XXX: Balana balana = Balana.getInstance();
		//XXX: PDP pdp = new PDP(balana.getPdpConfig());

		Set<String> fileNames 
				= getFilesInFolder(policyDirectoryLocation, ".xml");
		PolicyFinder pf = new PolicyFinder();
		FileBasedPolicyFinderModule  pfm 
			= new FileBasedPolicyFinderModule(fileNames);
		pf.setModules(Collections.singleton(pfm));
		pfm.init(pf);

		// registering new attribute finder, so default PDPConfig is needed to change
		PDPConfig pdpConfig = org.wso2.balana.Balana.getInstance().getPdpConfig();
		AttributeFinder attributeFinder = pdpConfig.getAttributeFinder();
		java.util.List<AttributeFinderModule> finderModules = attributeFinder.getModules();
		AttributeFinderModule afm = new DBAttributeFinderModule(null, null, null);
		finderModules.add(afm);
		attributeFinder.setModules(finderModules);
		PDP pdp = new PDP(new PDPConfig(attributeFinder, pf, null, true));

		// Measure memory consumption after BALANA initialization
		double initMem = rt.totalMemory() - rt.freeMemory();

		// BALANA execution - XACML request evaluation
		/*long tm1 = System.nanoTime();
		String xacmlResponse = null;
		for (int i=0; i<evalIterations; i++) {
			xacmlResponse = pdp.evaluate(xacmlRequest);
		}
		long tm2 = System.nanoTime();
		
		// Specify XACML response file (default "xacml-response.xml")
		if (xacmlResponse!=null) {
			if (verbose) System.out.println( "\nXACML-RESPONSE:\n"+xacmlResponse+"\n" );
			String xacmlResponseFile = null;
			if (args.length>p && !args[p].trim().isEmpty()) xacmlResponseFile = args[p].trim();
			if (xacmlResponseFile!=null && xacmlResponseFile.equals("-o")) xacmlResponseFile = "xacml-response.xml";
			// Save XACML response to file
			if (xacmlResponseFile!=null) {
				try(java.io.PrintStream ps = new java.io.PrintStream(xacmlResponseFile)) { ps.println(xacmlResponse); }
			}
		}*/
		
		// BALANA execution - Start Workers
		System.out.println("Starting "+numOfWorkers+" workers...");
		AtomicInteger activeCounter = new AtomicInteger(numOfWorkers);
		TestWorker[] workers = new TestWorker[numOfWorkers];
		long tm1 = System.nanoTime();
		for (int w=0; w<numOfWorkers; w++) {
			workers[w] = new TestWorker(w, activeCounter, evalIterations, pdp, xacmlRequest);
			workers[w].start();
			//System.out.println("-- Worker "+(w+1)+" of "+numOfWorkers+" started");
		}
		System.out.println("Starting "+numOfWorkers+" workers... ok");

		// Wait workers to finish
		while (activeCounter.get()>0) {
			try { Thread.sleep(200); } catch (Exception ex) {}
		}
		long tm2 = System.nanoTime();
		System.out.println("All workers finished...");

		// Collect worker measurements
		long totalIterationDuration = 0;
		long totalIterations = 0;
		for (int w=0; w<numOfWorkers; w++) {
			TestMeasurements meas = workers[w].getMeasurements();
			totalIterationDuration += meas.sumIterationDurations;
			totalIterations += meas.runIterations;
		}
		double averageIterationDuration = totalIterationDuration / totalIterations;
		double averageDurationPerWorker = totalIterationDuration / numOfWorkers;

		// Measure end-of-execution memory consumption
		double endMem = rt.totalMemory() - rt.freeMemory();
		double usedMem = endMem-initMem;
		
		double TO_MB = 1024*1024;
		double TO_MSEC = 1000000f;
		
		// Print measurements
		String reportHeader = "UC#\tTotal dur (ms)\tEval. dur (ms)\tEval. iter. (#)\tEval. iter. dur (ms)\tStart mem (mb)\tInit. mem (mb)\tEnd mem (mb)\tWorkers\tAvg.Iter.Dur.\tAvg.Worker Dur.\n";
		int cols = reportHeader.split("[\t]+").length-1;
		StringBuilder sb = new StringBuilder("%%s");
		Integer[] colsArgs = new Integer[cols];
		for (int i=0; i<cols; i++) { sb.append("\t%%.%df"); colsArgs[i]=prec; }
		String preFmt = sb.append("\n").toString();
		
		String fmt = String.format( preFmt, colsArgs);
        System.out.printf( reportHeader );
        System.out.printf( fmt, runId, (tm2-tm0)/TO_MSEC, (tm2-tm1)/TO_MSEC, (double)evalIterations, (tm2-tm1)/evalIterations/TO_MSEC, startMem/TO_MB, initMem/TO_MB, endMem/TO_MB, (double)numOfWorkers, averageIterationDuration/TO_MSEC, averageDurationPerWorker/TO_MSEC );

        if (verbose) System.out.println( "Bye!\n" );
    }

    private static Set<String> getFilesInFolder(String directory, final String extension) {
        File dir = new File(directory);
        String[] children = null;
        if (extension != null) {
            FilenameFilter filter = new FilenameFilter() {
                public boolean accept(File f, String name) {
                    return name.endsWith(extension);
                }
            };
            children = dir.list(filter);
        } else {
            children = dir.list();
        }
        HashSet<String> result = new HashSet<String>();
        for (int i=0; i<children.length;i++) {
            result.add(directory + System.getProperty("file.separator") + children[i]);
        }
        return result;
    }

    public static class TestWorker extends Thread {
		private int workerId;
		private AtomicInteger activeCounter;
		private int evalIterations;
		private PDP pdp;
		private String xacmlRequest;
		private TestMeasurements measurements;

		public TestWorker(int workerId, AtomicInteger activeCounter, int evalIterations, PDP pdp, String xacmlRequest) {
			this.workerId = workerId;
			this.activeCounter = activeCounter;
			this.evalIterations = evalIterations;
			this.pdp = pdp;
			this.xacmlRequest = xacmlRequest;
		}

		public void run() {
			// BALANA execution - XACML request evaluation
			long tm0 = System.nanoTime();
			long diffSum = 0;
			String xacmlResponse = null;
			for (int i=0; i<evalIterations; i++) {
				long tm1 = System.nanoTime();
				xacmlResponse = pdp.evaluate(xacmlRequest);
				long tm2 = System.nanoTime();
				long diff = tm2-tm1;
				diffSum += diff;
			}
			long tm3 = System.nanoTime();

			measurements = new TestMeasurements(tm3-tm0, evalIterations, diffSum);
			activeCounter.decrementAndGet();
		}

		public TestMeasurements getMeasurements() {
			return measurements;
		}
	}

	public static class TestMeasurements {
    	long runDuration;
    	long runIterations;
    	long sumIterationDurations;

    	public TestMeasurements(long rd, long ri, long sid) { runDuration=rd; runIterations=ri; sumIterationDurations=sid; }

    	public double getAverageIterationDuration1() { return runDuration / runIterations; }
    	public double getAverageIterationDuration2() { return sumIterationDurations / runIterations; }
	}

}
