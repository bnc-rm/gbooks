import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class TransformToCSV {

	public static void main(String args[]) {
		TransformerFactory tf = TransformerFactory.newInstance();
		StreamSource xsl, xml;
		StreamResult csv;
		try {
			xsl = new StreamSource(new FileReader(args[0]));
			Transformer t = tf.newTransformer(xsl);
			csv = new StreamResult(new FileWriter(args[2]));
			File dir = new File(args[1]);

			for (File in : dir.listFiles()) {
				if (in.isFile()) {
					if (in.getName().endsWith(".xml")) {
						xml = new StreamSource(new FileReader(in));
						t.transform(xml, csv);
					}
				}
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (TransformerConfigurationException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}