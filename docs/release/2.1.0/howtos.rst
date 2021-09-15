.. _howtos:

****************************************************************
How Tos
****************************************************************

The samples and documentation here should get you quickly up and running with the PDF Services SDK. These code examples illustrate how to perform PDF actions using the SDK, including:

* Creating a PDF from multiple formats, including HTML, Microsoft Office documents, and text files
* Exporting a PDF to other formats or an image
* Combining entire PDFs or specified page ranges
* Using OCR to make a PDF file searchable with a custom locale
* Compress PDFs with compression level and Linearize PDFs
* Protect PDFs with password(s) and Remove password protection from PDFs
* Common page operations, including inserting, replacing, deleting, reordering, and rotating
* Splitting PDFs into multiple files
* Extract PDF as JSON: the content, structure & renditions of table and figure elements along with Character Bounding Boxes
* Get the properties of a PDF file like page count, PDF version, file size, compliance levels, font info, permissions and more


.. _inmemory:

Runtime in-memory authentication
=======================================

The SDK supports providing the authentication credentials at runtime. Doing so allows fetching the credentials from a secret server during runtime instead of storing them in a file. Please refer the following samples for details.


* `Java <https://github.com/adobe/pdfservices-java-sdk-samples/blob/master/src/main/java/com/adobe/pdfservices/operation/samples/createpdf/CreatePDFWithInMemoryAuthCredentials.java>`_
* `.NET <https://github.com/adobe/PDFServices.NET.SDK.Samples/tree/master/CreatePDFWithInMemoryAuthCredentials>`_
* `Node.js <https://github.com/adobe/pdfservices-node-sdk-samples/blob/master/src/createpdf/create-pdf-with-inmemory-auth-credentials.js>`_
* `Python <https://github.com/adobe/pdfservices-python-sdk-samples/blob/master/src/extractpdf/extract_txt_from_pdf_with_in_memory_auth_credentials.py>`_

Custom timeout configuration
===============================

The APIs use inferred timeout properties and provide defaults. However, the SDK supports custom timeouts for the API calls. You can tailor the timeout settings for your environment and network speed. In addition to the details below, you can refer to working code samples:

* `Java <https://github.com/adobe/pdfservices-java-sdk-samples/blob/master/src/main/java/com/adobe/pdfservices/operation/samples/createpdf/CreatePDFWithCustomTimeouts.java>`__
* `.NET <https://github.com/adobe/PDFServices.NET.SDK.Samples/blob/master/CreatePDFWithCustomTimeouts/Program.cs>`__
* `Node.js <https://github.com/adobe/pdfservices-node-sdk-samples/blob/master/src/createpdf/create-pdf-with-custom-timeouts.js>`__
* `Python <https://github.com/adobe/pdfservices-python-sdk-samples/blob/master/src/extractpdf/extract_txt_from_pdf_with_custom_timeouts.py>`__

.. _timejava:

Java timeout configuration
--------------------------------

Available properties:

* **connectTimeout**: Default: 2000. The maximum allowed time in milliseconds for creating an initial HTTPS connection.
* **socketTimeout**: Default: 10000. The maximum allowed time in milliseconds between two successive HTTP response packets.

Override the timeout properties via a custom ``ClientConfig`` class:

::

     ClientConfig clientConfig = ClientConfig.builder()
        .withConnectTimeout(3000)
        .withSocketTimeout(20000)
        .build();

.. _timenet:

.NET timeout configuration
--------------------------------

Available properties:

* **timeout**: Default: 400000. The maximum allowed time in milliseconds for establishing a connection, sending a request, and getting a response.
* **readWriteTimeout**: Default: 10000. The maximum allowed time in milliseconds to read or write data after connection is established.

Override the timeout properties via a custom ``ClientConfig`` class:

::

  ClientConfig clientConfig = ClientConfig.ConfigBuilder()
    .timeout(500000)
    .readWriteTimeout(15000)
    .Build();

.. _timenode:

Node.js timeout configuration
--------------------------------

Available properties:

* **connectTimeout**: Default: 10000. The maximum allowed time in milliseconds for creating an initial HTTPS connection.
* **readTimeout**: Default: 10000. The maximum allowed time in milliseconds between two successive HTTP response packets.

Override the timeout properties via a custom ``ClientConfig`` class:

::

  const clientConfig = PDFServicesSdk.ClientConfig
    .clientConfigBuilder()
    .withConnectTimeout(15000)
    .withReadTimeout(15000)
    .build();

.. _timepython:

Python timeout configuration
-------------------------------

Available properties:

* **connectTimeout**: Default: 4000. The number of milliseconds Requests will wait for the client to establish a connection to Server.
* **readTimeout**: Default: 10000. The number of milliseconds the client will wait for the server to send a response.

Override the timeout properties via a custom ``ClientConfig`` class:

::

  client_config = ClientConfig.builder()
                  .with_connect_timeout(10000)
                  .with_read_timeout(40000)
                  .build()


Create PDF
=========================

Create a PDF
-------------------------------


Use the sample below to create PDFs from Microsoft Office documents (Word, Excel and PowerPoint) and other `supported file formats <https://opensource.adobe.com/pdfservices-java-sdk-samples/apidocs/latest/com/adobe/pdfservices/operation/pdfops/CreatePDFOperation.SupportedSourceFormat.html>`_. While the example shows .docx file conversion, the SDK supports the following formats:

* Microsoft Word (DOC, DOCX)
* Microsoft PowerPoint (PPT, PPTX)
* Microsoft Excel (XLS, XLSX)
* Text (TXT, RTF)
* Image (BMP, JPEG, GIF, TIFF, PNG)

.. raw:: html

  <div class="tabs">
	  <!--<button onclick="copyToClipboard('#tabsjava1')">This copy button works.</button>-->
      <ul>
        <li><a href="#tabsjava1">JAVA</a></li>
        <li><a href="#tabsnet1">.NET</a></li>
        <li><a href="#tabsnode1">NODE</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-createPDF" target="_blank">REST API</a></li>
      </ul>
      <div id="tabsjava1">
      <div class="cmdline"><strong>Run the sample:</strong><br />
 mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.createpdf.CreatePDFFromDOCX</div>

 <pre class="prettyprint">
 //Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CreatePDFFromDOCX {

       // Initialize the logger.
       private static final Logger LOGGER = LoggerFactory.getLogger(CreatePDFFromDOCX.class);

       public static void main(String[] args) {

         try {

           // Initial setup, create credentials instance.
           Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
               .fromFile("pdfservices-api-credentials.json")
               .build();

           //Create an ExecutionContext using credentials and create a new operation instance.
           ExecutionContext executionContext = ExecutionContext.create(credentials);
           CreatePDFOperation createPdfOperation = CreatePDFOperation.createNew();

           // Set operation input from a source file.
           FileRef source = FileRef.createFromLocalFile("src/main/resources/createPDFInput.docx");
           createPdfOperation.setInput(source);

           // Execute the operation.
           FileRef result = createPdfOperation.execute(executionContext);

           // Save the result to the specified location.
           result.saveAs("output/createPDFFromDOCX.pdf");

         } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
           LOGGER.error("Exception encountered while executing operation", ex);
         }
       }
     }
      </pre>
      </div>
      <div id="tabsnet1">
	<div class="cmdline"><strong>Run the sample:</strong><br />
 cd CreatePDFFromDocx/<br/>
 dotnet run CreatePDFFromDocx.csproj
		</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace CreatePDFFromDocx
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          CreatePDFOperation createPdfOperation = CreatePDFOperation.CreateNew();

          // Set operation input from a source file.
          FileRef source = FileRef.CreateFromLocalFile(@"createPdfInput.docx");
          createPdfOperation.SetInput(source);

          // Execute the operation.
          FileRef result = createPdfOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/createPdfOutput.pdf");
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
     </pre>
      </div>
  <div id="tabsnode1">
  <div class="cmdline"><strong>Run the sample:</strong><br />
 node src/createpdf/create-pdf-from-docx.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFservicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        createPdfOperation = PDFServicesSdk.CreatePDF.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/createPDFInput.docx');
    createPdfOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    createPdfOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/createPDFFromDOCX.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

    </div>
  <!--end tab data-->
  </div>

Create PDF with DocumentLanguage
---------------------------------

Use the sample below to create PDFs with supported documentLanguage from Microsoft Office documents (Word, Excel and PowerPoint). The example shows .docx file conversion with english as the language of the input file, the SDK supports the following formats:

* Microsoft Word (DOC, DOCX)
* Microsoft PowerPoint (PPT, PPTX)
* Microsoft Excel (XLS, XLSX)
* Text (TXT, RTF)

.. raw:: html

  <div class="tabs">
	  <!--<button onclick="copyToClipboard('#tabsjava1')">This copy button works.</button>-->
      <ul>
        <li><a href="#tabsjava11">JAVA</a></li>
        <li><a href="#tabsnet11">.NET</a></li>
        <li><a href="#tabsnode11">NODE</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-createPDF" target="_blank">REST API</a></li>
      </ul>
      <div id="tabsjava11">
      <div class="cmdline"><strong>Run the sample:</strong><br />
 mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.createpdf.CreatePDFFromDOCXWithOptions</div>

 <pre class="prettyprint">
 //Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CreatePDFFromDOCXWithOptions {

       // Initialize the logger.
       private static final Logger LOGGER = LoggerFactory.getLogger(CreatePDFFromDOCXWithOptions.class);

       public static void main(String[] args) {

         try {

           // Initial setup, create credentials instance.
           Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
               .fromFile("pdfservices-api-credentials.json")
               .build();

           //Create an ExecutionContext using credentials and create a new operation instance.
           ExecutionContext executionContext = ExecutionContext.create(credentials);
           CreatePDFOperation createPdfOperation = CreatePDFOperation.createNew();

           // Set operation input from a source file.
           FileRef source = FileRef.createFromLocalFile("src/main/resources/createPDFInput.docx");
           createPdfOperation.setInput(source);

           // Provide any custom configuration options for the operation.
           setCustomOptions(createPdfOperation);

           // Execute the operation.
           FileRef result = createPdfOperation.execute(executionContext);

           // Save the result to the specified location.
           result.saveAs("output/createPDFFromDOCXWithOptionsOutput.pdf");

         } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
           LOGGER.error("Exception encountered while executing operation", ex);
         }
       }

       private static void setCustomOptions(CreatePDFOperation createPdfOperation) {
         // Select the documentLanguage for input file.
         SupportedDocumentLanguage documentLanguage = SupportedDocumentLanguage.EN_US;

         // Set the desired Word-to-PDF conversion options.
         CreatePDFOptions wordOptions = CreatePDFOptions.wordOptionsBuilder().
         withDocumentLanguage(documentLanguage).
         build();

         createPdfOperation.setOptions(wordOptions);
    }
  }
      </pre>
      </div>
      <div id="tabsnet11">
	<div class="cmdline"><strong>Run the sample:</strong><br />
 cd CreatePDFFromDocxWithOptions/<br/>
 dotnet run CreatePDFFromDocxWithOptions.csproj
		</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace CreatePDFFromDocxWithOptions
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          CreatePDFOperation createPdfOperation = CreatePDFOperation.CreateNew();

          // Set operation input from a source file.
          FileRef source = FileRef.CreateFromLocalFile(@"createPdfInput.docx");
          createPdfOperation.SetInput(source);

          // Provide any custom configuration options for the operation.
          SetCustomOptions(createPdfOperation);

          // Execute the operation.
          FileRef result = createPdfOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/createPDFFromDOCXWithOptionsOutput.pdf");
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      private static void SetCustomOptions(CreatePDFOperation createPdfOperation)
      {
         // Select the documentLanguage for input file.
         SupportedDocumentLanguage documentLanguage = SupportedDocumentLanguage.EN_US;

         // Set the desired Word-to-PDF conversion options.
         CreatePDFOptions createPDFOptions = CreatePDFOptions.WordOptionsBuilder()
         .WithDocumentLanguage(documentLanguage)
         .Build();
         createPdfOperation.SetOptions(createPDFOptions);
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }

     </pre>
      </div>
  <div id="tabsnode11">
  <div class="cmdline"><strong>Run the sample:</strong><br />
 node src/createpdf/create-pdf-from-docx-with-options.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
 const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

 const setCustomOptions = (createPdfOperation) => {
     // Select the documentLanguage for input file.
     const documentLanguage = PDFServicesSdk.CreatePDF.options.word.SupportedDocumentLanguage.EN_US;

     // Set the desired WORD-to-PDF conversion options with documentLanguage.
     const createPdfOptions = new PDFServicesSdk.CreatePDF.options.word.CreatePDFFromWordOptions.Builder()
         .withDocumentLanguage(documentLanguage).build();
     createPdfOperation.setOptions(createPdfOptions);
 };

 try {
     // Initial setup, create credentials instance.
     const credentials =  PDFServicesSdk.Credentials
         .serviceAccountCredentialsBuilder()
         .fromFile("pdfservices-api-credentials.json")
         .build();

     // Create an ExecutionContext using credentials and create a new operation instance.
     const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
         createPdfOperation = PDFServicesSdk.CreatePDF.Operation.createNew();

     // Set operation input from a source file.
         const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/createPDFInput.docx');
     createPdfOperation.setInput(input);

     // Provide any custom configuration options for the operation.
     setCustomOptions(createPdfOperation);

     // Execute the operation and Save the result to the specified location.
     createPdfOperation.execute(executionContext)
         .then(result => result.saveAsFile('output/createPDFFromDOCXWithOptionsOutput.pdf'))
         .catch(err => {
             if(err instanceof PDFServicesSdk.Error.ServiceApiError
                 || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                 console.log('Exception encountered while executing operation', err);
             } else {
                 console.log('Exception encountered while executing operation', err);
             }
         });
 } catch (err) {
     console.log('Exception encountered while executing operation', err);
 }
 </pre>

    </div>
  <!--end tab data-->
  </div>

Create a PDF from static HTML
-------------------------------

The sample below creates a PDF file from a static HTML file. The file must be local. Since HTML/web pages typically contain external assets, the input file must be a zip file containing an index.html at the top level of the archive as well as any dependencies such as images, css files, and so on.

.. raw:: html

  <div class="tabs">
      <ul>
        <li><a href="#tabsjava2">JAVA</a></li>
        <li><a href="#tabsnet2">.NET</a></li>
        <li><a href="#tabsnode2">NODE</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-createPDFFromHTML" target="_blank">REST API</a></li>
      </ul>
      <div id="tabsjava2">
	 <div class="cmdline"><strong>Run the sample:</strong><br />
 mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.createpdf.CreatePDFFromStaticHTML
	</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CreatePDFFromStaticHTML {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(CreatePDFFromStaticHTML.class);

    public static void main(String[] args) {

      try {

        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        CreatePDFOperation htmlToPDFOperation = CreatePDFOperation.createNew();

        // Set operation input from a source file.
        FileRef source = FileRef.createFromLocalFile("src/main/resources/createPDFFromStaticHtmlInput.zip");
        htmlToPDFOperation.setInput(source);

        // Provide any custom configuration options for the operation.
        setCustomOptions(htmlToPDFOperation);

        // Execute the operation.
        FileRef result = htmlToPDFOperation.execute(executionContext);

        // Save the result to the specified location.
        result.saveAs("output/createPDFFromStaticHtmlOutput.pdf");

      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }

    private static void setCustomOptions(CreatePDFOperation htmlToPDFOperation) {
      // Define the page layout, in this case an 8 x 11.5 inch page (effectively portrait orientation).
      PageLayout pageLayout = new PageLayout();
      pageLayout.setPageSize(8, 11.5);

      // Set the desired HTML-to-PDF conversion options.
      CreatePDFOptions htmlToPdfOptions = CreatePDFOptions.htmlOptionsBuilder()
          .includeHeaderFooter(true)
          .withPageLayout(pageLayout)
          .build();
      htmlToPDFOperation.setOptions(htmlToPdfOptions);
    }
  }
      </pre>
      </div>

      <div id="tabsnet2">
	 <div class="cmdline"><strong>Run the sample:</strong><br />
 cd CreatePDFFromStaticHtml/ <br/>
 dotnet run CreatePDFFromStaticHtml.csproj
	</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace CreatePDFFromStaticHtml
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          CreatePDFOperation htmlToPDFOperation = CreatePDFOperation.CreateNew();

          // Set operation input from a source file.
          FileRef source = FileRef.CreateFromLocalFile(@"createPDFFromStaticHtmlInput.zip");
          htmlToPDFOperation.SetInput(source);

          // Provide any custom configuration options for the operation.
          SetCustomOptions(htmlToPDFOperation);

          // Execute the operation.
          FileRef result = htmlToPDFOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/createPdfFromStaticHtmlOutput.pdf");
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
         // Catch more errors here. . .
      }

      private static void SetCustomOptions(CreatePDFOperation htmlToPDFOperation)
      {
        // Define the page layout, in this case an 8 x 11.5 inch page (effectively portrait orientation).
        PageLayout pageLayout = new PageLayout();
        pageLayout.SetPageSize(8, 11.5);

        // Set the desired HTML-to-PDF conversion options.
        CreatePDFOptions htmlToPdfOptions = CreatePDFOptions.HtmlOptionsBuilder()
            .IncludeHeaderFooter(true)
            .WithPageLayout(pageLayout)
            . Build();
        htmlToPDFOperation.SetOptions(htmlToPdfOptions);
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
   </pre>
      </div>
  <div id="tabsnode2">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/createpdf/create-pdf-from-static-html.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const setCustomOptions = (htmlToPDFOperation) => {
    // Define the page layout, in this case an 8 x 11.5 inch page (effectively portrait orientation).
    const pageLayout = new PDFServicesSdk.CreatePDF.options.PageLayout();
    pageLayout.setPageSize(8, 11.5);

    // Set the desired HTML-to-PDF conversion options.
    const htmlToPdfOptions = new PDFServicesSdk.CreatePDF.options.html.CreatePDFFromHtmlOptions.Builder()
      .includesHeaderFooter(true)
      .withPageLayout(pageLayout)
      .build();
    htmlToPDFOperation.setOptions(htmlToPdfOptions);
  };


  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
      .serviceAccountCredentialsBuilder()
      .fromFile("pdfservices-api-credentials.json")
      .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
      htmlToPDFOperation = PDFServicesSdk.CreatePDF.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/createPDFFromStaticHtmlInput.zip');
    htmlToPDFOperation.setInput(input);

    // Provide any custom configuration options for the operation.
    setCustomOptions(htmlToPDFOperation);

    // Execute the operation and Save the result to the specified location.
    htmlToPDFOperation.execute(executionContext)
      .then(result => result.saveAsFile('output/createPdfFromStaticHtmlOutput.pdf'))
      .catch(err => {
        if(err instanceof PDFServicesSdk.Error.ServiceApiError
          || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
          console.log('Exception encountered while executing operation', err);
        } else {
          console.log('Exception encountered while executing operation', err);
        }
      });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

   </div>
  <!--end tab data-->
  </div>

Create a PDF from static HTML with inline CSS
---------------------------------------------

The sample below creates a PDF file from a static HTML file with inline CSS. The file must be local.

.. raw:: html

  <div class="tabs">
      <ul>
        <li><a href="#tabsjava1001">JAVA</a></li>
        <li><a href="#tabsnet1001">.NET</a></li>
        <li><a href="#tabsnode1001">NODE</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-createPDFFromHTML" target="_blank">REST API</a></li>
      </ul>
      <div id="tabsjava1001">
	 <div class="cmdline"><strong>Run the sample:</strong><br />
 mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.createpdf.CreatePDFFromHTMLWithInlineCSS
	</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CreatePDFFromHTMLWithInlineCSS {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(CreatePDFFromStaticHTML.class);

    public static void main(String[] args) {

      try {

        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        CreatePDFOperation htmlToPDFOperation = CreatePDFOperation.createNew();

        // Set operation input from a source file.
        FileRef source = FileRef.createFromLocalFile("src/main/resources/createPDFFromHTMLWithInlineCSSInput.html");
        htmlToPDFOperation.setInput(source);

        // Provide any custom configuration options for the operation.
        setCustomOptions(htmlToPDFOperation);

        // Execute the operation.
        FileRef result = htmlToPDFOperation.execute(executionContext);

        // Save the result to the specified location.
        result.saveAs("output/createPDFFromHTMLWithInlineCSSOutput.pdf");

      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }

    private static void setCustomOptions(CreatePDFOperation htmlToPDFOperation) {
      // Define the page layout, in this case an 20 x 25 inch page (effectively portrait orientation).
      PageLayout pageLayout = new PageLayout();
      pageLayout.setPageSize(20, 25);

      // Set the desired HTML-to-PDF conversion options.
      CreatePDFOptions htmlToPdfOptions = CreatePDFOptions.htmlOptionsBuilder()
          .includeHeaderFooter(true)
          .withPageLayout(pageLayout)
          .build();
      htmlToPDFOperation.setOptions(htmlToPdfOptions);
    }
  }
      </pre>
      </div>

      <div id="tabsnet1001">
	 <div class="cmdline"><strong>Run the sample:</strong><br />
 cd CreatePDFFromStaticHtml/ <br/>
 dotnet run CreatePDFFromHTMLWithInlineCSS.csproj
	</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace CreatePDFFromHTMLWithInlineCSS
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          CreatePDFOperation htmlToPDFOperation = CreatePDFOperation.CreateNew();

          // Set operation input from a source file.
          FileRef source = FileRef.CreateFromLocalFile(@"createPDFFromHTMLWithInlineCSSInput.html");
          htmlToPDFOperation.SetInput(source);

          // Provide any custom configuration options for the operation.
          SetCustomOptions(htmlToPDFOperation);

          // Execute the operation.
          FileRef result = htmlToPDFOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/createPDFFromHTMLWithInlineCSSOutput.pdf");
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
         // Catch more errors here. . .
      }

      private static void SetCustomOptions(CreatePDFOperation htmlToPDFOperation)
      {
        // Define the page layout, in this case an 20 x 25 inch page (effectively portrait orientation).
        PageLayout pageLayout = new PageLayout();
        pageLayout.SetPageSize(20, 25);

        // Set the desired HTML-to-PDF conversion options.
        CreatePDFOptions htmlToPdfOptions = CreatePDFOptions.HtmlOptionsBuilder()
            .IncludeHeaderFooter(true)
            .WithPageLayout(pageLayout)
            . Build();
        htmlToPDFOperation.SetOptions(htmlToPdfOptions);
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
   </pre>
      </div>
  <div id="tabsnode1001">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/createpdf/create-pdf-from-html-with-inline-css.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const setCustomOptions = (htmlToPDFOperation) => {
    // Define the page layout, in this case an 20 x 25 inch page (effectively portrait orientation).
    const pageLayout = new PDFServicesSdk.CreatePDF.options.PageLayout();
    pageLayout.setPageSize(20, 25);

    // Set the desired HTML-to-PDF conversion options.
    const htmlToPdfOptions = new PDFServicesSdk.CreatePDF.options.html.CreatePDFFromHtmlOptions.Builder()
      .includesHeaderFooter(true)
      .withPageLayout(pageLayout)
      .build();
    htmlToPDFOperation.setOptions(htmlToPdfOptions);
  };


  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
      .serviceAccountCredentialsBuilder()
      .fromFile("pdfservices-api-credentials.json")
      .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
      htmlToPDFOperation = PDFServicesSdk.CreatePDF.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/createPDFFromHTMLWithInlineCSSInput.html');
    htmlToPDFOperation.setInput(input);

    // Provide any custom configuration options for the operation.
    setCustomOptions(htmlToPDFOperation);

    // Execute the operation and Save the result to the specified location.
    htmlToPDFOperation.execute(executionContext)
      .then(result => result.saveAsFile('output/createPDFFromHTMLWithInlineCSSOutput.pdf'))
      .catch(err => {
        if(err instanceof PDFServicesSdk.Error.ServiceApiError
          || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
          console.log('Exception encountered while executing operation', err);
        } else {
          console.log('Exception encountered while executing operation', err);
        }
      });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

   </div>
  <!--end tab data-->
  </div>

Create a PDF File From HTML specified via URL
---------------------------------------------

The sample below creates a PDF file from a HTML file specified via URL.

.. raw:: html

  <div class="tabs">
      <ul>
        <li><a href="#tabsjava1002">JAVA</a></li>
        <li><a href="#tabsnet1002">.NET</a></li>
        <li><a href="#tabsnode1002">NODE</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-createPDFFromHTML" target="_blank">REST API</a></li>
      </ul>
      <div id="tabsjava1002">
	 <div class="cmdline"><strong>Run the sample:</strong><br />
 mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.createpdf.CreatePDFFromURL
	</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CreatePDFFromURL {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(CreatePDFFromStaticHTML.class);

    public static void main(String[] args) {

      try {

        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        CreatePDFOperation htmlToPDFOperation = CreatePDFOperation.createNew();

        // Set operation input from a source URL.
        FileRef source = FileRef.createFromURL(new URL("https://www.adobe.io"));
        htmlToPDFOperation.setInput(source);

        // Provide any custom configuration options for the operation.
        setCustomOptions(htmlToPDFOperation);

        // Execute the operation.
        FileRef result = htmlToPDFOperation.execute(executionContext);

        // Save the result to the specified location.
        result.saveAs("output/createPDFFromURLOutput.pdf");

      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }

    private static void setCustomOptions(CreatePDFOperation htmlToPDFOperation) {
      // Define the page layout, in this case an 20 x 25 inch page (effectively portrait orientation).
      PageLayout pageLayout = new PageLayout();
      pageLayout.setPageSize(20, 25);

      // Set the desired HTML-to-PDF conversion options.
      CreatePDFOptions htmlToPdfOptions = CreatePDFOptions.htmlOptionsBuilder()
          .includeHeaderFooter(true)
          .withPageLayout(pageLayout)
          .build();
      htmlToPDFOperation.setOptions(htmlToPdfOptions);
    }
  }
      </pre>
      </div>

      <div id="tabsnet1002">
	 <div class="cmdline"><strong>Run the sample:</strong><br />
 cd CreatePDFFromStaticHtml/ <br/>
 dotnet run CreatePDFFromURL.csproj
	</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace CreatePDFFromURL
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          CreatePDFOperation htmlToPDFOperation = CreatePDFOperation.CreateNew();

          // Set operation input from a source URL.
          FileRef source = FileRef.CreateFromURI(new Uri("https://www.adobe.io"));
          htmlToPDFOperation.SetInput(source);

          // Provide any custom configuration options for the operation.
          SetCustomOptions(htmlToPDFOperation);

          // Execute the operation.
          FileRef result = htmlToPDFOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/createPdfFromURLOutput.pdf");
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
         // Catch more errors here. . .
      }

      private static void SetCustomOptions(CreatePDFOperation htmlToPDFOperation)
      {
        // Define the page layout, in this case an 20 x 25 inch page (effectively portrait orientation).
        PageLayout pageLayout = new PageLayout();
        pageLayout.SetPageSize(20, 25);

        // Set the desired HTML-to-PDF conversion options.
        CreatePDFOptions htmlToPdfOptions = CreatePDFOptions.HtmlOptionsBuilder()
            .IncludeHeaderFooter(true)
            .WithPageLayout(pageLayout)
            . Build();
        htmlToPDFOperation.SetOptions(htmlToPdfOptions);
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
   </pre>
      </div>
  <div id="tabsnode1002">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/createpdf/create-pdf-from-url.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const setCustomOptions = (htmlToPDFOperation) => {
    // Define the page layout, in this case an 20 x 25 inch page (effectively portrait orientation).
    const pageLayout = new PDFServicesSdk.CreatePDF.options.PageLayout();
    pageLayout.setPageSize(20, 25);

    // Set the desired HTML-to-PDF conversion options.
    const htmlToPdfOptions = new PDFServicesSdk.CreatePDF.options.html.CreatePDFFromHtmlOptions.Builder()
      .includesHeaderFooter(true)
      .withPageLayout(pageLayout)
      .build();
    htmlToPDFOperation.setOptions(htmlToPdfOptions);
  };


  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
      .serviceAccountCredentialsBuilder()
      .fromFile("pdfservices-api-credentials.json")
      .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
      htmlToPDFOperation = PDFServicesSdk.CreatePDF.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromURL(
        "https://www.adobe.io"
    );
    htmlToPDFOperation.setInput(input);

    // Provide any custom configuration options for the operation.
    setCustomOptions(htmlToPDFOperation);

    // Execute the operation and Save the result to the specified location.
    htmlToPDFOperation.execute(executionContext)
      .then(result => result.saveAsFile('output/createPDFFromHTMLWithInlineCSSOutput.pdf'))
      .catch(err => {
        if(err instanceof PDFServicesSdk.Error.ServiceApiError
          || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
          console.log('Exception encountered while executing operation', err);
        } else {
          console.log('Exception encountered while executing operation', err);
        }
      });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

   </div>
  <!--end tab data-->
  </div>


Create a PDF from dynamic HTML
-------------------------------

To support workflows with dynamic data, ``CreatePDFFromDynamicHTML`` creates PDFs from dynamic HTML. It's a common scenario for enterprise to provide end users with an HTML template with form fields. This API allows you to capture the users unique data entries and then save it as PDF.  Collected data is stored in a JSON file, and the source HTML file must include ``<script src='./json.js' type='text/javascript'></script>``. Refer to the API docs for usage.

The sample ``CreatePDFFromDynamicHTML`` converts a zip file, containing the input HTML file and its resources, along with the input data to a PDF file. The input data is used by the JavaScript in the HTML file to manipulate the HTML DOM, thus effectively updating the source HTML file. This mechanism can be used to provide data to the template HTML dynamically prior to PDF conversion.


.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava19">JAVA</a></li>
      <li><a href="#tabsnet19">.NET</a></li>
      <li><a href="#tabsnode19">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-createPDFFromHTML" target="_blank">REST API</a></li>
    </ul>

    <div id="tabsjava19">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.createpdf.CreatePDFFromDynamicHTML </div>
      <pre class="prettyprint">
  // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CreatePDFFromDynamicHTML {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(CreatePDFFromDynamicHTML.class);

    public static void main(String[] args) {

      try {

        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        CreatePDFOperation htmlToPDFOperation = CreatePDFOperation.createNew();

        // Set operation input from a source file.
        FileRef source = FileRef.createFromLocalFile("src/main/resources/createPDFFromDynamicHtmlInput.zip");
        htmlToPDFOperation.setInput(source);

        // Provide any custom configuration options for the operation.
        setCustomOptions(htmlToPDFOperation);

        // Execute the operation.
        FileRef result = htmlToPDFOperation.execute(executionContext);

        // Save the result to the specified location.
        result.saveAs("output/createPDFFromDynamicHtmlOutput.pdf");

      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }

    private static void setCustomOptions(CreatePDFOperation htmlToPDFOperation) {
      // Define the page layout, in this case an 8 x 11.5 inch page (effectively portrait orientation).
      PageLayout pageLayout = new PageLayout();
      pageLayout.setPageSize(8, 11.5);

      //Set the dataToMerge field that needs to be populated in the HTML before its conversion
      JSONObject dataToMerge = new JSONObject();
      dataToMerge.put("title","Create, Convert PDFs and More!");
      dataToMerge.put("sub_title","Easily integrate PDF actions within your document workflows.");

      // Set the desired HTML-to-PDF conversion options.
      CreatePDFOptions htmlToPdfOptions = CreatePDFOptions.htmlOptionsBuilder()
          .includeHeaderFooter(true)
          .withPageLayout(pageLayout)
          .withDataToMerge(dataToMerge)
          .build();
      htmlToPDFOperation.setOptions(htmlToPdfOptions);
    }
  }
      </pre>
    </div>

    <div id="tabsnet19">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd CreatePDFFromDynamicHtml/<br/>
  dotnet run CreatePDFFromDynamicHtml.csproj</div>
      <pre class="prettyprint">
  // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace CreatePDFFromDynamicHtml
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          CreatePDFOperation htmlToPDFOperation = CreatePDFOperation.CreateNew();

          // Set operation input from a source file.
          FileRef source = FileRef.CreateFromLocalFile(@"createPDFFromDynamicHtmlInput.zip");
          htmlToPDFOperation.SetInput(source);

          // Provide any custom configuration options for the operation.
          SetCustomOptions(htmlToPDFOperation);

          // Execute the operation.
          FileRef result = htmlToPDFOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/createPdfFromDynamicHtmlOutput.pdf");
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // errors continued. . .
      }

      private static void SetCustomOptions(CreatePDFOperation htmlToPDFOperation)
      {
        // Define the page layout, in this case an 8 x 11.5 inch page (effectively portrait orientation).
        PageLayout pageLayout = new PageLayout();
        pageLayout.SetPageSize(8, 11.5);

        //Set the dataToMerge field that needs to be populated in the HTML before its conversion
        JObject dataToMerge = new JObject
        {
          { "title", "Create, Convert PDFs and More!" },
          { "sub_title", "Easily integrate PDF actions within your document workflows." }
        };

        // Set the desired HTML-to-PDF conversion options.
        CreatePDFOptions htmlToPdfOptions = CreatePDFOptions.HtmlOptionsBuilder()
            .IncludeHeaderFooter(true)
            .WithPageLayout(pageLayout)
            .WithDataToMerge(dataToMerge)
            .Build();
        htmlToPDFOperation.SetOptions(htmlToPdfOptions);
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
      </pre>
    </div>

    <div id="tabsnode19">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/createpdf/create-pdf-from-dynamic-html.js</div>
      <pre class="prettyprint">
  // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample

  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const setCustomOptions = (htmlToPDFOperation) => {
    // Define the page layout, in this case an 8 x 11.5 inch page (effectively portrait orientation).
    const pageLayout = new PDFServicesSdk.CreatePDF.options.PageLayout();
    pageLayout.setPageSize(8, 11.5);
    //Set the dataToMerge field that needs to be populated in the HTML before its conversion.
    const dataToMerge = {
        "title":"Create, Convert PDFs and More!",
        "sub_title": "Easily integrate PDF actions within your document workflows."
    };
    // Set the desired HTML-to-PDF conversion options.
    const htmlToPdfOptions = new PDFServicesSdk.CreatePDF.options.html.CreatePDFFromHtmlOptions.Builder()
        .includesHeaderFooter(true)
        .withPageLayout(pageLayout)
        .withDataToMerge(dataToMerge)
        .build();
    htmlToPDFOperation.setOptions(htmlToPdfOptions);
  };


  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        htmlToPDFOperation = PDFServicesSdk.CreatePDF.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/createPDFFromDynamicHtmlInput.zip');
    htmlToPDFOperation.setInput(input);

    // Provide any custom configuration options for the operation.
    setCustomOptions(htmlToPDFOperation);

    // Execute the operation and Save the result to the specified location.
    htmlToPDFOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/createPdfFromDynamicHtmlOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Export PDF
===================

Export a PDF
-------------------------------

The sample below converts a PDF file into a number of `supported formats <https://opensource.adobe.com/pdfservices-java-sdk-samples/apidocs/latest/com/adobe/pdfservices/operation/pdfops/options/exportpdf/ExportPDFTargetFormat.html>`_ such as:

* Microsoft Office file formats
* Text files
* Images

.. raw:: html

 <div class="tabs">
   <ul>
      <li><a href="#tabsjava4">JAVA</a></li>
      <li><a href="#tabsnet4">.NET</a></li>
      <li><a href="#tabsnode4">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-exportPDF" target="_blank">REST API</a></li>
   </ul>
   <div id="tabsjava4">
 <div class="cmdline"><strong>Run the sample:</strong><br />
 mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.exportpdf.ExportPDFToDOCX
 </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class ExportPDFToDOCX {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(ExportPDFToDOCX.class);

    public static void main(String[] args) {

      try {
        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();
        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        ExportPDFOperation exportPdfOperation = ExportPDFOperation.createNew(ExportPDFTargetFormat.DOCX);

        // Set operation input from a local PDF file
        FileRef sourceFileRef = FileRef.createFromLocalFile("src/main/resources/exportPDFInput.pdf");
        exportPdfOperation.setInput(sourceFileRef);

        // Execute the operation.
        FileRef result = exportPdfOperation.execute(executionContext);

        // Save the result to the specified location.
        result.saveAs("output/exportPdfOutput.docx");

      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }
  }
   </pre>
   </div>
   <div id="tabsnet4">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  cd ExportPDFToDocx/<br/>
  dotnet run ExportPDFToDocx.csproj
		</div>
      <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace ExportPDFToDocx
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          ExportPDFOperation exportPdfOperation = ExportPDFOperation.CreateNew(ExportPDFTargetFormat.DOCX);

          // Set operation input from a local PDF file
          FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"exportPdfInput.pdf");
          exportPdfOperation.SetInput(sourceFileRef);

          // Execute the operation.
          FileRef result = exportPdfOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/exportPdfOutput.docx");
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
   </pre>
   </div>
  <div id="tabsnode4">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/exportpdf/export-pdf-to-docx.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    //Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        exportPDF = PDFServicesSdk.ExportPDF,
        exportPdfOperation = exportPDF.Operation.createNew(exportPDF.SupportedTargetFormats.DOCX);

    // Set operation input from a source file
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/exportPDFInput.pdf');
    exportPdfOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    exportPdfOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/exportPdfOutput.docx'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

 </div>
  <!--end tab data-->
  </div>

Export a PDF to images
-------------------------------

The sample below converts a PDF file to one or more jpeg or png images. Exporting to an image produces a zip archive containing one image per page. Each image file name ends with "_<unpadded_page_index_number>". For example, a PDF file with 15 pages will generate 15 image files. The first file's name ends with "_1" and the last file's name ends with "_15".


.. raw:: html

  <div class="tabs">
       <ul>
         <li><a href="#tabsjava5">JAVA</a></li>
         <li><a href="#tabsnet5">.NET</a></li>
          <li><a href="#tabsnode5">NODE</a></li>
          <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-exportPDF">REST API</a></li>
       </ul>
       <div id="tabsjava5">
		  <div class="cmdline"><strong>Run the sample:</strong><br />
  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.exportpdf.ExportPDFToJPEG
  </div>
  <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class ExportPDFToJPEG {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(ExportPDFToJPEG.class);

    public static void main(String[] args) {
      try {

        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        ExportPDFOperation exportPdfOperation = ExportPDFOperation.createNew(ExportPDFTargetFormat.JPEG);

        // Set operation input from a source file.
        FileRef sourceFileRef = FileRef.createFromLocalFile("src/main/resources/exportPDFToImageInput.pdf");
        exportPdfOperation.setInput(sourceFileRef);

        // Execute the operation.
        FileRef result = exportPdfOperation.execute(executionContext);

        // Save the result to the specified location.
        result.saveAs("output/exportPDFToJPEG.zip");

      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }
  }
      </pre>
      </div>
      <div id="tabsnet5">
	  <div class="cmdline"><strong>Run the sample:</strong><br />
  cd ExportPDFToImage/ <br/>
  dotnet run ExportPDFToImage.csproj
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples


  namespace ExportPDFToImage
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          ExportPDFOperation exportPdfOperation = ExportPDFOperation.CreateNew(ExportPDFTargetFormat.JPEG);

          // Set operation input from a source file.
          FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"exportPdfToImageInput.pdf");
          exportPdfOperation.SetInput(sourceFileRef);

          // Execute the operation.
          FileRef result = exportPdfOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/exportPdfToImageOutput.zip");
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
     </pre>
      </div>
  <div id="tabsnode5">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/exportpdf/export-pdf-to-jpeg.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    //Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        exportPDF = PDFServicesSdk.ExportPDF,
        exportPdfOperation = exportPDF.Operation.createNew(exportPDF.SupportedTargetFormats.JPEG);

    // Set operation input from a source file
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/exportPDFToImageInput.pdf');
    exportPdfOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    exportPdfOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/exportPDFToJPEG.zip'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

    </div>
  <!--end tab data-->
  </div>

Export a PDF to list of images
-------------------------------

The sample below converts a PDF file to one or more jpeg or png images.


.. raw:: html

  <div class="tabs">
       <ul>
         <li><a href="#tabsjava1003">JAVA</a></li>
         <li><a href="#tabsnet1003">.NET</a></li>
          <li><a href="#tabsnode1003">NODE</a></li>
          <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-exportPDF">REST API</a></li>
       </ul>
       <div id="tabsjava1003">
		  <div class="cmdline"><strong>Run the sample:</strong><br />
  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.exportpdf.ExportPDFToJPEGList
  </div>
  <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples
  package com.adobe.pdfservices.operation.samples.exportpdf;


  public class ExportPDFToJPEGList {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(ExportPDFToJPEG.class);

    public static void main(String[] args) {
      try {

        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        ExportPDFToImagesOperation exportPDFToImagesOperation = ExportPDFToImagesOperation.createNew(ExportPDFToImagesTargetFormat.JPEG);

        // Set operation input from a source file.
        FileRef sourceFileRef = FileRef.createFromLocalFile("src/main/resources/exportPDFToImageInput.pdf");
        exportPDFToImagesOperation.setInput(sourceFileRef);

        // Execute the operation.
        List<FileRef> results = exportPDFToImagesOperation.execute(executionContext);

        // Save the result to the specified location.
        int index = 0;
        for(FileRef result : results) {
            result.saveAs("output/exportPDFToImagesOutput_" + index + ".jpeg");
            index++;
        }
      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }
  }
      </pre>
      </div>
      <div id="tabsnet1003">
	  <div class="cmdline"><strong>Run the sample:</strong><br />
  cd ExportPDFToJPEGList/ <br/>
  dotnet run ExportPDFToJPEGList.csproj
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples


  namespace
  {
    class Program ExportPDFToJPEGList
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          ExportPDFToImagesOperation exportPDFToImagesOperation = ExportPDFToImagesOperation.CreateNew(ExportPDFToImagesTargetFormat.JPEG);

          // Set operation input from a source file.
          FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"exportPDFToImagesInput.pdf");
          exportPDFToImagesOperation.SetInput(sourceFileRef);

          // Execute the operation.
          List<FileRef> result = exportPDFToImagesOperation.Execute(executionContext);

          // Save the result to the specified location.
          int index = 0;
          foreach (FileRef fileRef in result)
          {
                    fileRef.SaveAs(Directory.GetCurrentDirectory() + "/output/exportPDFToImagesOutput_" + index + ".jpeg");
                    index++;
          }
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
     </pre>
      </div>
  <div id="tabsnode1003">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/exportpdf/export-pdf-to-jpeg-list.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    //Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        exportPDF = PDFServicesSdk.ExportPDF,
        exportPdfToImagesOperation = exportPDFToImages.Operation.createNew(exportPDFToImages.SupportedTargetFormats.JPEG);

    // Set operation input from a source file
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/exportPDFToImageInput.pdf');
    exportPdfToImagesOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    exportPdfToImagesOperation.execute(executionContext)
        .then(result => {
            let saveFilesPromises = [];
            for(let i = 0; i < result.length; i++){
                saveFilesPromises.push(result[i].saveAsFile(`output/exportPDFToJPEGOutput_${i}.jpeg`));
            }
            return Promise.all(saveFilesPromises);
        })
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

    </div>
  <!--end tab data-->
  </div>


Combine PDF Files
===================

Combine files
--------------------

This sample combines up to 20 PDF files into a single PDF file.

.. raw:: html

  <div class="tabs">
      <ul>
        <li><a href="#tabsjava6">JAVA</a></li>
        <li><a href="#tabsnet6">.NET</a></li>
        <li><a href="#tabsnode6">NODE</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-combinePDF">REST API</a></li>
      </ul>
      <div id="tabsjava6">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.combinepdf.CombinePDF
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CombinePDF {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(CombinePDF.class);

    public static void main(String[] args) {
      try {
        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        CombineFilesOperation combineFilesOperation = CombineFilesOperation.createNew();

        // Add operation input from source files.
        FileRef combineSource1 = FileRef.createFromLocalFile("src/main/resources/combineFilesInput1.pdf");
        FileRef combineSource2 = FileRef.createFromLocalFile("src/main/resources/combineFilesInput2.pdf");
        combineFilesOperation.addInput(combineSource1);
        combineFilesOperation.addInput(combineSource2);

        // Execute the operation.
        FileRef result = combineFilesOperation.execute(executionContext);

        // Save the result to the specified location.
        result.saveAs("output/combineFilesOutput.pdf");

      } catch (IOException | ServiceApiException | SdkException | ServiceUsageException e) {
        LOGGER.error("Exception encountered while executing operation", e);
      }
    }
  }
      </pre>
      </div>
      <div id="tabsnet6">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  cd CombinePDF/ <br/>
  dotnet run CombinePDF.csproj
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace CombinePDF
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          CombineFilesOperation combineFilesOperation = CombineFilesOperation.CreateNew();

          // Add operation input from source files.
          FileRef combineSource1 = FileRef.CreateFromLocalFile(@"combineFilesInput1.pdf");
          FileRef combineSource2 = FileRef.CreateFromLocalFile(@"combineFilesInput2.pdf");
          combineFilesOperation.AddInput(combineSource1);
          combineFilesOperation.AddInput(combineSource2);

          // Execute the operation.
          FileRef result = combineFilesOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/combineFilesOutput.pdf");

        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
     </pre>
      </div>
  <div id="tabsnode6">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/combinepdf/combine-pdf.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials = PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        combineFilesOperation = PDFServicesSdk.CombineFiles.Operation.createNew();

    // Set operation input from a source file.
    const combineSource1 = PDFServicesSdk.FileRef.createFromLocalFile('resources/combineFilesInput1.pdf'),
        combineSource2 = PDFServicesSdk.FileRef.createFromLocalFile('resources/combineFilesInput2.pdf');
    combineFilesOperation.addInput(combineSource1);
    combineFilesOperation.addInput(combineSource2);

    // Execute the operation and Save the result to the specified location.
    combineFilesOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/combineFilesOutput.pdf'))
        .catch(err => {
            if (err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

    </div>
  <!--end tab data-->
  </div>

Combine pages from multiple files
-----------------------------------

This combine sample combines specific pages from up to 20 different PDF files into a single
PDF file. Optional arguments allow specifying page ranges for each file to combine in the output file.

.. raw:: html

  <div class="tabs">
      <ul>
        <li><a href="#tabsjava7">JAVA</a></li>
        <li><a href="#tabsnet7">.NET</a></li>
		    <li><a href="#tabsnode7">NODE</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-combinePDF">REST API</a></li>
      </ul>
      <div id="tabsjava7">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.combinepdf.CombinePDFWithPageRanges
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CombinePDFWithPageRanges {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(CombinePDFWithPageRanges.class);

    public static void main(String[] args) {

      try {

        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        CombineFilesOperation combineFilesOperation = CombineFilesOperation.createNew();

        // Create a FileRef instance from a local file.
        FileRef firstFileToCombine = FileRef.createFromLocalFile("src/main/resources/combineFileWithPageRangeInput1.pdf");
        PageRanges pageRangesForFirstFile = getPageRangeForFirstFile();
        // Add the first file as input to the operation, along with its page range.
        combineFilesOperation.addInput(firstFileToCombine, pageRangesForFirstFile);

        // Create a second FileRef instance using a local file.
        FileRef secondFileToCombine = FileRef.createFromLocalFile("src/main/resources/combineFileWithPageRangeInput2.pdf");
        PageRanges pageRangesForSecondFile = getPageRangeForSecondFile();
        // Add the second file as input to the operation, along with its page range.
        combineFilesOperation.addInput(secondFileToCombine, pageRangesForSecondFile);

        // Execute the operation.
        FileRef result = combineFilesOperation.execute(executionContext);

        // Save the result to the specified location.
        result.saveAs("output/combineFilesWithPageOptionsOutput.pdf");

      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }

    private static PageRanges getPageRangeForSecondFile() {
      // Specify which pages of the second file are to be included in the combined file.
      PageRanges pageRangesForSecondFile = new PageRanges();
      // Add all pages including and after page 3.
      pageRangesForSecondFile.addAllFrom(3);
      return pageRangesForSecondFile;
    }

    private static PageRanges getPageRangeForFirstFile() {
      // Specify which pages of the first file are to be included in the combined file.
      PageRanges pageRangesForFirstFile = new PageRanges();
      // Add page 1.
      pageRangesForFirstFile.addSinglePage(1);
      // Add page 2.
      pageRangesForFirstFile.addSinglePage(2);
      // Add pages 3 to 4.
      pageRangesForFirstFile.addRange(3, 4);
      return pageRangesForFirstFile;
    }
  }
      </pre>
      </div>
      <div id="tabsnet7">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  cd CombinePDFWithPageRanges/<br/>
  dotnet run CombinePDFWithPageRanges.csproj
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace CombinePDFWithPageRanges
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {

          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          CombineFilesOperation combineFilesOperation = CombineFilesOperation.CreateNew();

          // Create a FileRef instance from a local file.
          FileRef firstFileToCombine = FileRef.CreateFromLocalFile(@"combineFileWithPageRangeInput1.pdf");
          PageRanges pageRangesForFirstFile = GetPageRangeForFirstFile();
          // Add the first file as input to the operation, along with its page range.
          combineFilesOperation.AddInput(firstFileToCombine, pageRangesForFirstFile);

          // Create a second FileRef instance using a local file.
          FileRef secondFileToCombine = FileRef.CreateFromLocalFile(@"combineFileWithPageRangeInput2.pdf");
          PageRanges pageRangesForSecondFile = GetPageRangeForSecondFile();
          // Add the second file as input to the operation, along with its page range.
          combineFilesOperation.AddInput(secondFileToCombine, pageRangesForSecondFile);

          // Execute the operation.
          FileRef result = combineFilesOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/combineFilesOutput.pdf");

        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      private static PageRanges GetPageRangeForSecondFile()
      {
        // Specify which pages of the second file are to be included in the combined file.
        PageRanges pageRangesForSecondFile = new PageRanges();
        // Add all pages including and after page 5.
        pageRangesForSecondFile.AddAllFrom(5);
        return pageRangesForSecondFile;
      }

      private static PageRanges GetPageRangeForFirstFile()
      {
        // Specify which pages of the first file are to be included in the combined file.
        PageRanges pageRangesForFirstFile = new PageRanges();
        // Add page 2.
        pageRangesForFirstFile.AddSinglePage(2);
        // Add page 3.
        pageRangesForFirstFile.AddSinglePage(3);
        // Add pages 5 to 7.
        pageRangesForFirstFile.AddRange(5, 7);
        return pageRangesForFirstFile;
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
     </pre>
      </div>
  <div id="tabsnode7">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/combinepdf/combine-pdf-with-page-ranges.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const getPageRangesForFirstFile = () => {
    // Specify which pages of the first file are to be included in the combined file.
    const pageRangesForFirstFile = new PDFServicesSdk.PageRanges();
    // Add page 1.
    pageRangesForFirstFile.addSinglePage(1);
    // Add page 2.
    pageRangesForFirstFile.addSinglePage(2);
    // Add pages 3 to 4.
    pageRangesForFirstFile.addPageRange(3, 4);
    return pageRangesForFirstFile;
  };

  const getPageRangesForSecondFile = () => {
    // Specify which pages of the second file are to be included in the combined file.
    const pageRangesForSecondFile = new PDFServicesSdk.PageRanges();
    // Add all pages including and after page 3.
    pageRangesForSecondFile.addAllFrom(3);
    return pageRangesForSecondFile;
  };

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        combineFilesOperation = PDFServicesSdk.CombineFiles.Operation.createNew();

    // Create a FileRef instance from a local file.
    const combineSource1 = PDFServicesSdk.FileRef.createFromLocalFile('resources/combineFilesInput1.pdf'),
        pageRangesForFirstFile = getPageRangesForFirstFile();
    // Add the first file as input to the operation, along with its page range.
    combineFilesOperation.addInput(combineSource1, pageRangesForFirstFile);

    // Create a second FileRef instance using a local file.
    const combineSource2 = PDFServicesSdk.FileRef.createFromLocalFile('resources/combineFilesInput2.pdf'),
        pageRangesForSecondFile = getPageRangesForSecondFile();
    // Add the second file as input to the operation, along with its page range.
    combineFilesOperation.addInput(combineSource2, pageRangesForSecondFile);

    // Execute the operation and Save the result to the specified location.
    combineFilesOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/combineFilesWithPageRangesOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>
    </div>
  <!--end tab data-->
  </div>

OCR PDF
=============================================

Text recognition (OCR)
------------------------

Optical character recognition (OCR) converts images to text so that you and your users can fully interact with the PDF file. After performing OCR, the PDF may be fully editable and searchable. The input format must be ``application/pdf``.

This sample defaults to the en-us locale. For other languages, see :ref:`ocrlang`.

.. raw:: html

  <div class="tabs">
      <ul>
        <li><a href="#tabsjava9">JAVA</a></li>
        <li><a href="#tabsnet9">.NET</a></li>
		    <li><a href="#tabsnode9">NODE</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-ocr">REST API</a></li>
      </ul>
      <div id="tabsjava9">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.ocrpdf.OcrPDF
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

 public class OcrPDF {

  // Initialize the logger.
  private static final Logger LOGGER = LoggerFactory.getLogger(OcrPDF.class);

  public static void main(String[] args) {

   try {

    // Initial setup, create credentials instance.
    Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
      .fromFile("pdfservices-api-credentials.json")
      .build();

    //Create an ExecutionContext using credentials and create a new operation instance.
    ExecutionContext executionContext = ExecutionContext.create(credentials);
    OCROperation ocrOperation = OCROperation.createNew();

    // Set operation input from a source file.
    FileRef source = FileRef.createFromLocalFile("src/main/resources/ocrInput.pdf");
    ocrOperation.setInput(source);

    // Execute the operation
    FileRef result = ocrOperation.execute(executionContext);

    // Save the result at the specified location
    result.saveAs("output/ocrOutput.pdf");

   } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
    LOGGER.error("Exception encountered while executing operation", ex);
   }
  }
 }

      </pre>
      </div>
      <div id="tabsnet9">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  cd OcrPDF/<br/>
  dotnet run OcrPDF.csproj
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace OcrPDF
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          OCROperation ocrOperation = OCROperation.CreateNew();

          // Set operation input from a source file.
          FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"ocrInput.pdf");
          ocrOperation.SetInput(sourceFileRef);

          // Execute the operation.
          FileRef result = ocrOperation.Execute(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/ocrOperationOutput.pdf");
        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
     </pre>
      </div>
  <div id="tabsnode9">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/ocr/ocr-pdf.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        ocrOperation = PDFServicesSdk.OCR.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/ocrInput.pdf');
    ocrOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    ocrOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/ocrOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>
    </div>
  <!--end tab data-->
  </div>

.. _ocrlang:

OCR with explicit language
-------------------------------

You can perform OCR on files in other languages, including German, French, Danish, and other languages. Refer to ``OCRSupportedLocale`` and ``OCRSupportedType`` in the API docs  for a list of supported OCR locales and OCR types.

As shown in the OcrPDFWithOptions sample, when you make a PDF file searchable, you specify both the locale (language) and the type. There are two types which produce a different result:

* One type ensures that text is searchable and selectable, but modifies the original image during the cleanup process (for example, deskews it) before placing an invisible text layer over it. This type removes unwanted artifacts and may result in a more readable document in some scenarios.
* The second (EXACT) type, also overlays a searchable text layer over the original image, but in this case, the original image is unchanged. This type produces maximum fidelity to the original image.

.. raw:: html

  <div class="tabs">
      <ul>
        <li><a href="#tabsjava8">JAVA</a></li>
        <li><a href="#tabsnet8">.NET</a></li>
        <li><a href="#tabsnode8">NODE</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-ocr">REST API</a></li>
      </ul>
      <div id="tabsjava8">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  mvn -f pom.xml exec:java
  Dexec.mainClass=com.adobe.pdfservices.operation.samples.ocrpdf.OcrPDFWithOptions
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class OcrPDFWithOptions {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(OcrPDFWithOptions.class);

    public static void main(String[] args) {

        try {

            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            //Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            OCROperation ocrOperation = OCROperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/ocrInput.pdf");
            ocrOperation.setInput(source);

            // Build OCR options from supported locales and OCR-types and set them into the operation
            OCROptions ocrOptions = OCROptions.ocrOptionsBuilder()
                    .withOCRLocale(OCRSupportedLocale.EN_US)
                    .withOCRType(OCRSupportedType.SEARCHABLE_IMAGE_EXACT)
                    .build();
            ocrOperation.setOptions(ocrOptions);

            // Execute the operation
            FileRef result = ocrOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs("output/ocrWithOptionsOutput.pdf");

        } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
            LOGGER.error("Exception encountered while executing operation", ex);
        }
    }
  }
      </pre>
      </div>
      <div id="tabsnet8">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  cd OcrPDFWithOptions<br/>
  dotnet run OcrPDFWithOptions.csproj
  </div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

 namespace OcrPDFWithOptions
 {
  class Program
  {
    private static readonly ILog log = LogManager.GetLogger(typeof(Program));
    static void Main()
    {
      //Configure the logging
      ConfigureLogging();
      try
      {
        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                .Build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.Create(credentials);
        OCROperation ocrOperation = OCROperation.CreateNew();

        // Set operation input from a source file.
        FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"ocrWithOptionsInput.pdf");
        ocrOperation.SetInput(sourceFileRef);
        // Build OCR options from supported locales and OCR-types and set them into the operation
        OCROptions ocrOptions = OCROptions.OCROptionsBuilder()
            .WithOcrLocale(OCRSupportedLocale.EN_US)
            .WithOcrType(OCRSupportedType.SEARCHABLE_IMAGE_EXACT)
            .Build();
        ocrOperation.SetOptions(ocrOptions);

        // Execute the operation.
        FileRef result = ocrOperation.Execute(executionContext);

        // Save the result to the specified location.
        result.SaveAs(Directory.GetCurrentDirectory() + "/output/ocrOperationWithOptionsOutput.pdf");
      }
      catch (ServiceUsageException ex)
      {
        log.Error("Exception encountered while executing operation", ex);
      }
      // Catch more errors here . . .
    }

    static void ConfigureLogging()
    {
      ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
      XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
    }
  }
 }
 </pre>
      </div>
  <div id="tabsnode8">
  <div class="cmdline"><strong>Run the sample:</strong><br />
  node src/ocr/ocr-pdf-with-options.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    //Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        ocrOperation = PDFServicesSdk.OCR.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/ocrInput.pdf');
    ocrOperation.setInput(input);

    // Provide any custom configuration options for the operation.
    const options = new PDFServicesSdk.OCR.options.OCROptions.Builder()
        .withOcrType(PDFServicesSdk.OCR.options.OCRSupportedType.SEARCHABLE_IMAGE_EXACT)
        .withOcrLang(PDFServicesSdk.OCR.options.OCRSupportedLocale.EN_US)
        .build();
    ocrOperation.setOptions(options);

    // Execute the operation and Save the result to the specified location.
    ocrOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/ocrWithOptionsOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>
    </div>
  <!--end tab data-->
  </div>


Compress PDFs
===================

Compress PDFs
---------------

Compress PDFs to reduce the file size prior to performing workflow operations that use bandwidth or memory.


.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava21">JAVA</a></li>
      <li><a href="#tabsnet21">.NET</a></li>
      <li><a href="#tabsnode21">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-compressPDF">REST API</a></li>
    </ul>

    <div id="tabsjava21">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.compresspdf.CompressPDF</div>
      <pre class="prettyprint">
   // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CompressPDF {
    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(CompressPDF.class);

    public static void main(String[] args) {

        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            CompressPDFOperation compressPDFOperation = CompressPDFOperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/compressPDFInput.pdf");
            compressPDFOperation.setInput(source);

            // Execute the operation
            FileRef result = compressPDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs("output/compressPDFOutput.pdf");

        } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
            LOGGER.error("Exception encountered while executing operation", ex);
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnet21">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd CompressPDF/<br/>dotnet run CompressPDF.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace CompressPDF
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials and create a new operation instance.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);
                CompressPDFOperation compressPDFOperation = CompressPDFOperation.CreateNew();

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"compressPDFInput.pdf");
                compressPDFOperation.SetInput(sourceFileRef);

                // Execute the operation.
                FileRef result = compressPDFOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/compressPDFOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode21">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/compresspdf/compress-pdf.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        compressPDF = PDFServicesSdk.CompressPDF,
        compressPDFOperation = compressPDF.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/compressPDFInput.pdf');
    compressPDFOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    compressPDFOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/compressPDFOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>


Compress PDFs with Compression Level
-------------------------------------

Compress PDFs to reduce the file size on the basis of provided compression level, prior to performing workflow operations that use bandwidth or memory. Refer to ``CompressionLevel`` in the API docs for a list of supported compression levels.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava10">JAVA</a></li>
      <li><a href="#tabsnet10">.NET</a></li>
      <li><a href="#tabsnode10">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-compressPDF">REST API</a></li>
    </ul>

    <div id="tabsjava10">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.compresspdf.CompressPDFWithOptions</div>
      <pre class="prettyprint">
   // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class CompressPDFWithOptions {
    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(CompressPDFWithOptions.class);

    public static void main(String[] args) {

        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            CompressPDFOperation compressPDFOperation = CompressPDFOperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/compressPDFInput.pdf");
            compressPDFOperation.setInput(source);

            // Build CompressPDF options from supported compression levels and set them into the operation
            CompressPDFOptions compressPDFOptions = CompressPDFOptions.compressPDFOptionsBuilder()
                    .withCompressionLevel(CompressionLevel.LOW)
                    .build();
            compressPDFOperation.setOptions(compressPDFOptions);

            // Execute the operation
            FileRef result = compressPDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs("output/compressPDFWithOptionsOutput.pdf");

        } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
            LOGGER.error("Exception encountered while executing operation", ex);
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnet10">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd CompressPDF/<br/>dotnet run CompressPDFWithOptions.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace CompressPDFWithOptions
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials and create a new operation instance.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);
                CompressPDFOperation compressPDFOperation = CompressPDFOperation.CreateNew();

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"compressPDFInput.pdf");
                compressPDFOperation.SetInput(sourceFileRef);

                // Build CompressPDF options from supported compression levels and set them into the operation
                CompressPDFOptions compressPDFOptions = CompressPDFOptions.CompressPDFOptionsBuilder()
                        .WithCompressionLevel(CompressionLevel.LOW)
                        .Build();
                compressPDFOperation.SetOptions(compressPDFOptions);

                // Execute the operation.
                FileRef result = compressPDFOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/compressPDFWithOptionsOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode10">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/compresspdf/compress-pdf-with-options.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        compressPDF = PDFServicesSdk.CompressPDF,
        compressPDFOperation = compressPDF.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/compressPDFInput.pdf');
    compressPDFOperation.setInput(input);

    // Provide any custom configuration options for the operation.
    const options = new compressPDF.options.CompressPDFOptions.Builder()
        .withCompressionLevel(PDFServicesSdk.CompressPDF.options.CompressionLevel.MEDIUM)
        .build();
    compressPDFOperation.setOptions(options);

    // Execute the operation and Save the result to the specified location.
    compressPDFOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/compressPDFWithOptionsOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>


Linearize PDFs
=======================

Linearizing a PDF creates a web-optimized PDF file which supports incremental access in network environments.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava20">JAVA</a></li>
      <li><a href="#tabsnet20">.NET</a></li>
      <li><a href="#tabsnode20">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-linearizePDF">REST API</a></li>
    </ul>

    <div id="tabsjava20">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.linearizepdf.LinearizePDF</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class LinearizePDF {
    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(LinearizePDF.class);

    public static void main(String[] args) {

        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            LinearizePDFOperation linearizePDFOperation = LinearizePDFOperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/linearizePDFInput.pdf");
            linearizePDFOperation.setInput(source);

            // Execute the operation
            FileRef result = linearizePDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs("output/linearizePDFOutput.pdf");

        } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
            LOGGER.error("Exception encountered while executing operation", ex);
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnet20">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd LinearizePDF/<br/>dotnet run LinearizePDF.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace LinearizePDF
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials and create a new operation instance.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);
                LinearizePDFOperation linearizePDFOperation = LinearizePDFOperation.CreateNew();

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"linearizePDFInput.pdf");
                linearizePDFOperation.SetInput(sourceFileRef);

                // Execute the operation.
                FileRef result = linearizePDFOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/linearizePDFOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode20">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/linearizepdf/linearize-pdf.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        linearizePDF = PDFServicesSdk.LinearizePDF,
        linearizePDFOperation = linearizePDF.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/linearizePDFInput.pdf');
    linearizePDFOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    linearizePDFOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/linearizePDFOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Protect PDF
=================

Protect PDFs with user password
----------------------------------

You can password protect PDFs so that only users with a document open password can open the file.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava22">JAVA</a></li>
      <li><a href="#tabsnet22">.NET</a></li>
      <li><a href="#tabsnode22">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-protectPDF">REST API</a></li>
    </ul>

    <div id="tabsjava22">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.protectpdf.ProtectPDF</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class ProtectPDF {
    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(ProtectPDF.class);

    public static void main(String[] args) {

        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials.
            ExecutionContext executionContext = ExecutionContext.create(credentials);

            // Build ProtectPDF options by setting a User Password and Encryption
            // Algorithm (used for encrypting the PDF file).
            ProtectPDFOptions protectPDFOptions = ProtectPDFOptions.passwordProtectOptionsBuilder()
                    .setUserPassword("encryptPassword")
                    .setEncryptionAlgorithm(EncryptionAlgorithm.AES_256)
                    .build();

            // Create a new operation instance.
            ProtectPDFOperation protectPDFOperation = ProtectPDFOperation.createNew(protectPDFOptions);

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/protectPDFInput.pdf");
            protectPDFOperation.setInput(source);

            // Execute the operation
            FileRef result = protectPDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs("output/protectPDFOutput.pdf");

        } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
            LOGGER.error("Exception encountered while executing operation", ex);
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnet22">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd ProtectPDF/<br/>dotnet run ProtectPDF.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace ProtectPDF
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Build ProtectPDF options by setting a User Password and Encryption
                // Algorithm (used for encrypting the PDF file).
                ProtectPDFOptions protectPDFOptions = ProtectPDFOptions.PasswordProtectOptionsBuilder()
                        .SetUserPassword("encryptPassword")
                        .SetEncryptionAlgorithm(EncryptionAlgorithm.AES_256)
                        .Build();

                // Create a new operation instance
                ProtectPDFOperation protectPDFOperation = ProtectPDFOperation.CreateNew(protectPDFOptions);

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"protectPDFInput.pdf");
                protectPDFOperation.SetInput(sourceFileRef);

                // Execute the operation.
                FileRef result = protectPDFOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/protectPDFOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode22">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/protectpdf/protect-pdf.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

    // Build ProtectPDF options by setting a User Password and Encryption
    // Algorithm (used for encrypting the PDF file).
    const protectPDF = PDFServicesSdk.ProtectPDF,
        options = new protectPDF.options.PasswordProtectOptions.Builder()
            .setUserPassword("encryptPassword")
            .setEncryptionAlgorithm(PDFServicesSdk.ProtectPDF.options.EncryptionAlgorithm.AES_256)
            .build();

    // Create a new operation instance.
    const protectPDFOperation = protectPDF.Operation.createNew(options);

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/protectPDFInput.pdf');
    protectPDFOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    protectPDFOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/protectPDFOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Protect PDFs with owner password
-------------------------------------

You can secure a PDF file with owner/permissions password and set the restriction on certain features like printing, editing and copying in the PDF document. Refer to ``ContentEncryption`` and ``Permission`` in the API docs for a list of supported types of content to encrypt and types of document permissions.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava31">JAVA</a></li>
      <li><a href="#tabsnet31">.NET</a></li>
      <li><a href="#tabsnode31">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-protectPDF">REST API</a></li>
    </ul>

    <div id="tabsjava31">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.protectpdf.ProtectPDFWithOwnerPassword</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class ProtectPDFWithOwnerPassword {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(ProtectPDFWithOwnerPassword.class);

    public static void main(String[] args) {

        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials.
            ExecutionContext executionContext = ExecutionContext.create(credentials);

            // Create new permissions instance and add the required permissions
            Permissions permissions = Permissions.createNew();
            permissions.addPermission(Permission.PRINT_LOW_QUALITY);
            permissions.addPermission(Permission.EDIT_DOCUMENT_ASSEMBLY);
            permissions.addPermission(Permission.COPY_CONTENT);

            // Build ProtectPDF options by setting an Owner/Permissions Password, Permissions,
            // Encryption Algorithm (used for encrypting the PDF file) and specifying the type of content to encrypt.
            ProtectPDFOptions protectPDFOptions = ProtectPDFOptions.passwordProtectOptionsBuilder()
                    .setOwnerPassword("password")
                    .setPermissions(permissions)
                    .setEncryptionAlgorithm(EncryptionAlgorithm.AES_256)
                    .setContentEncryption(ContentEncryption.ALL_CONTENT_EXCEPT_METADATA)
                    .build();

            // Create a new operation instance.
            ProtectPDFOperation protectPDFOperation = ProtectPDFOperation.createNew(protectPDFOptions);

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/protectPDFInput.pdf");
            protectPDFOperation.setInput(source);

            // Execute the operation
            FileRef result = protectPDFOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs("output/protectPDFWithOwnerPasswordOutput.pdf");

        } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
            LOGGER.error("Exception encountered while executing operation", ex);
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnet31">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd ProtectPDFWithOwnerPassword/<br/>dotnet run ProtectPDFWithOwnerPassword.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace ProtectPDFWithOwnerPassword
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create new permissions instance and add the required permissions
                Permissions permissions = Permissions.CreateNew();
                permissions.AddPermission(Permission.PRINT_LOW_QUALITY);
                permissions.AddPermission(Permission.EDIT_DOCUMENT_ASSEMBLY);
                permissions.AddPermission(Permission.COPY_CONTENT);

                // Build ProtectPDF options by setting an Owner/Permissions Password, Permissions,
                // Encryption Algorithm (used for encrypting the PDF file) and specifying the type of content to encrypt.
                ProtectPDFOptions protectPDFOptions = ProtectPDFOptions.PasswordProtectOptionsBuilder()
                    .SetOwnerPassword("password")
                    .SetPermissions(permissions)
                    .SetEncryptionAlgorithm(EncryptionAlgorithm.AES_256)
                    .SetContentEncryption(ContentEncryption.ALL_CONTENT_EXCEPT_METADATA)
                    .Build();

                // Create a new operation instance
                ProtectPDFOperation protectPDFOperation = ProtectPDFOperation.CreateNew(protectPDFOptions);

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"protectPDFInput.pdf");
                protectPDFOperation.SetInput(sourceFileRef);

                // Execute the operation.
                FileRef result = protectPDFOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/protectPDFWithOwnerPasswordOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode31">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/protectpdf/protect-pdf-with-owner-password.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

    // Create new permissions instance and add the required permissions
    const protectPDF = PDFServicesSdk.ProtectPDF,
        protectPDFOptions = protectPDF.options,
        permissions = protectPDFOptions.Permissions.createNew();
    permissions.addPermission(protectPDFOptions.Permission.PRINT_LOW_QUALITY);
    permissions.addPermission(protectPDFOptions.Permission.EDIT_DOCUMENT_ASSEMBLY);
    permissions.addPermission(protectPDFOptions.Permission.COPY_CONTENT);

    // Build ProtectPDF options by setting an Owner/Permissions Password, Permissions,
    // Encryption Algorithm (used for encrypting the PDF file) and specifying the type of content to encrypt.
    const options = new protectPDFOptions.PasswordProtectOptions.Builder()
            .setOwnerPassword("password")
            .setPermissions(permissions)
            .setEncryptionAlgorithm(protectPDFOptions.EncryptionAlgorithm.AES_256)
            .setContentEncryption(protectPDFOptions.ContentEncryption.ALL_CONTENT_EXCEPT_METADATA)
            .build();

    // Create a new operation instance.
    const protectPDFOperation = protectPDF.Operation.createNew(options);

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/protectPDFInput.pdf');
    protectPDFOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    protectPDFOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/protectPDFWithOwnerPasswordOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Remove Protection
=====================================

Use the below sample to remove security from a PDF document.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava32">JAVA</a></li>
      <li><a href="#tabsnet32">.NET</a></li>
      <li><a href="#tabsnode32">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-removeProtection">REST API</a></li>
    </ul>

    <div id="tabsjava32">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.removeprotection.RemoveProtection</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class RemoveProtection {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(RemoveProtection.class);

    public static void main(String[] args) {
        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            RemoveProtectionOperation removeProtectionOperation = RemoveProtectionOperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/removeProtectionInput.pdf");
            removeProtectionOperation.setInput(source);

            // Set the password for removing security from a PDF document.
            removeProtectionOperation.setPassword("password");

            // Execute the operation.
            FileRef result = removeProtectionOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs("output/removeProtectionOutput.pdf");

        } catch (IOException | ServiceApiException | SdkException | ServiceUsageException e) {
            LOGGER.error("Exception encountered while executing operation", e);
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnet32">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd RemoveProtection/<br/>dotnet run RemoveProtection.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace RemoveProtection
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create a new operation instance
                RemoveProtectionOperation removeProtectionOperation = RemoveProtectionOperation.CreateNew();

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"removeProtectionInput.pdf");
                removeProtectionOperation.SetInput(sourceFileRef);

                // Set the password for removing security from a PDF document.
                removeProtectionOperation.SetPassword("password");

                // Execute the operation.
                FileRef result = removeProtectionOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/removeProtectionOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode32">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/removeprotection/remove-protection.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

    // Create a new operation instance.
    const removeProtectionOperation = PDFServicesSdk.RemoveProtection.Operation.createNew(),
        input = PDFServicesSdk.FileRef.createFromLocalFile(
            'resources/removeProtectionInput.pdf',
            PDFServicesSdk.RemoveProtection.SupportedSourceFormat.pdf
        );
    // Set operation input from a source file.
    removeProtectionOperation.setInput(input);

    // Set the password for removing security from a PDF document.
    removeProtectionOperation.setPassword("password");

    // Execute the operation and Save the result to the specified location.
    removeProtectionOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/removeProtectionOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Insert Pages
=====================================

The insert operation inserts additional pages from different PDFs into an existing PDF.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava23">JAVA</a></li>
      <li><a href="#tabsnet23">.NET</a></li>
      <li><a href="#tabsnode23">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-combinePDF">REST API</a></li>
    </ul>

    <div id="tabsjava23">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.insertpages.InsertPDFPages</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples
   public class InsertPDFPages {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(InsertPDFPages.class);

    public static void main(String[] args) {
        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            InsertPagesOperation insertPagesOperation = InsertPagesOperation.createNew();

            // Set operation base input from a source file.
            FileRef baseSourceFile = FileRef.createFromLocalFile("src/main/resources/baseInput.pdf");
            insertPagesOperation.setBaseInput(baseSourceFile);

            // Create a FileRef instance using a local file.
            FileRef firstFileToInsert = FileRef.createFromLocalFile("src/main/resources/firstFileToInsertInput.pdf");
            PageRanges pageRanges = getPageRangeForFirstFile();

            // Adds the pages (specified by the page ranges) of the input PDF file to be inserted at
            // the specified page of the base PDF file.
            insertPagesOperation.addPagesToInsertAt(firstFileToInsert, pageRanges, 2);

            // Create a FileRef instance using a local file.
            FileRef secondFileToInsert = FileRef.createFromLocalFile("src/main/resources/secondFileToInsertInput.pdf");

            // Adds all the pages of the input PDF file to be inserted at the specified page of the
            // base PDF file.
            insertPagesOperation.addPagesToInsertAt(secondFileToInsert, 3);

            // Execute the operation.
            FileRef result = insertPagesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs("output/insertPagesOutput.pdf");

        } catch (IOException | ServiceApiException | SdkException | ServiceUsageException e) {
            LOGGER.error("Exception encountered while executing operation", e);
        }
    }

    private static PageRanges getPageRangeForFirstFile() {
        // Specify which pages of the first file are to be inserted in the base file.
        PageRanges pageRanges = new PageRanges();
        // Add pages 1 to 3.
        pageRanges.addRange(1, 3);

        // Add page 4.
        pageRanges.addSinglePage(4);

        return pageRanges;
    }
  }
      </pre>
    </div>

    <div id="tabsnet23">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd InsertPDFPages/<br/>dotnet run InsertPDFPages.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace InsertPDFPages
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            // Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create a new operation instance
                InsertPagesOperation insertPagesOperation = InsertPagesOperation.CreateNew();

                // Set operation base input from a source file.
                FileRef baseSourceFile = FileRef.CreateFromLocalFile(@"baseInput.pdf");
                insertPagesOperation.SetBaseInput(baseSourceFile);

                // Create a FileRef instance using a local file.
                FileRef firstFileToInsert = FileRef.CreateFromLocalFile(@"firstFileToInsertInput.pdf");
                PageRanges pageRanges = GetPageRangeForFirstFile();

                // Adds the pages (specified by the page ranges) of the input PDF file to be inserted at
                // the specified page of the base PDF file.
                insertPagesOperation.AddPagesToInsertAt(firstFileToInsert, pageRanges, 2);

                // Create a FileRef instance using a local file.
                FileRef secondFileToInsert = FileRef.CreateFromLocalFile(@"secondFileToInsertInput.pdf");

                // Adds all the pages of the input PDF file to be inserted at the specified page of the
                // base PDF file.
                insertPagesOperation.AddPagesToInsertAt(secondFileToInsert, 3);

                // Execute the operation.
                FileRef result = insertPagesOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/insertPagesOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            // Catch more errors here . . .
        }

        private static PageRanges GetPageRangeForFirstFile()
        {
            // Specify which pages of the first file are to be inserted in the base file.
            PageRanges pageRanges = new PageRanges();
            // Add pages 1 to 3.
            pageRanges.AddRange(1, 3);

            // Add page 4.
            pageRanges.AddSinglePage(4);

            return pageRanges;
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode23">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/insertpages/insert-pdf-pages.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const getPageRangesForFirstFile = () => {
    // Specify which pages of the first file are to be inserted in the base file.
    const pageRangesForFirstFile = new PDFServicesSdk.PageRanges();
    // Add pages 1 to 3.
    pageRangesForFirstFile.addPageRange(1, 3);

    // Add page 4.
    pageRangesForFirstFile.addSinglePage(4);

    return pageRangesForFirstFile;
  };

  try {
    // Initial setup, create credentials instance.
    const credentials = PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        insertPagesOperation = PDFServicesSdk.InsertPages.Operation.createNew();

    // Set operation base input from a source file.
    const baseInputFile = PDFServicesSdk.FileRef.createFromLocalFile('resources/baseInput.pdf');
    insertPagesOperation.setBaseInput(baseInputFile);

    // Create a FileRef instance using a local file.
    const firstFileToInsert = PDFServicesSdk.FileRef.createFromLocalFile('resources/firstFileToInsertInput.pdf'),
        pageRanges = getPageRangesForFirstFile();

    // Adds the pages (specified by the page ranges) of the input PDF file to be inserted at
    // the specified page of the base PDF file.
    insertPagesOperation.addPagesToInsertAt(2, firstFileToInsert, pageRanges);

    // Create a FileRef instance using a local file.
    const secondFileToInsert = PDFServicesSdk.FileRef.createFromLocalFile('resources/secondFileToInsertInput.pdf');

    // Adds all the pages of the input PDF file to be inserted at the specified page of the
    // base PDF file.
    insertPagesOperation.addPagesToInsertAt(3, secondFileToInsert);

    // Execute the operation and Save the result to the specified location.
    insertPagesOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/insertPagesOutput.pdf'))
        .catch(err => {
            if (err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Replace Pages
=====================================

The replace pages operation replaces pages in a PDF with pages from other PDF files.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava24">JAVA</a></li>
      <li><a href="#tabsnet24">.NET</a></li>
      <li><a href="#tabsnode24">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-combinePDF">REST API</a></li>
    </ul>

    <div id="tabsjava24">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.replacepages.ReplacePDFPages</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class ReplacePDFPages {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(ReplacePDFPages.class);

    public static void main(String[] args) {

        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            ReplacePagesOperation replacePagesOperation = ReplacePagesOperation.createNew();

            // Set operation base input from a source file.
            FileRef baseSourceFile = FileRef.createFromLocalFile("src/main/resources/baseInput.pdf");
            replacePagesOperation.setBaseInput(baseSourceFile);

            // Create a FileRef instance using a local file.
            FileRef firstInputFile = FileRef.createFromLocalFile("src/main/resources/replacePagesInput1.pdf");
            PageRanges pageRanges = getPageRangeForFirstFile();

            // Adds the pages (specified by the page ranges) of the input PDF file for replacing the
            // page of the base PDF file.
            replacePagesOperation.addPagesForReplace(firstInputFile, pageRanges, 1);


            // Create a FileRef instance using a local file.
            FileRef secondInputFile = FileRef.createFromLocalFile("src/main/resources/replacePagesInput2.pdf");

            // Adds all the pages of the input PDF file for replacing the page of the base PDF file.
            replacePagesOperation.addPagesForReplace(secondInputFile, 3);

            // Execute the operation
            FileRef result = replacePagesOperation.execute(executionContext);

            // Save the result at the specified location
            result.saveAs("output/replacePagesOutput.pdf");
        } catch (IOException | ServiceApiException | SdkException | ServiceUsageException e) {
            LOGGER.error("Exception encountered while executing operation", e);
        }
    }

    private static PageRanges getPageRangeForFirstFile() {
        // Specify pages of the first file for replacing the page of base PDF file.
        PageRanges pageRanges = new PageRanges();
        // Add pages 1 to 3.
        pageRanges.addRange(1, 3);

        // Add page 4.
        pageRanges.addSinglePage(4);

        return pageRanges;
    }
  }
      </pre>
    </div>

    <div id="tabsnet24">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd ReplacePDFPages/<br/>dotnet run ReplacePDFPages.csproj
      </div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace ReplacePDFPages
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create a new operation instance
                ReplacePagesOperation replacePagesOperation = ReplacePagesOperation.CreateNew();

                // Set operation base input from a source file.
                FileRef baseSourceFile = FileRef.CreateFromLocalFile(@"baseInput.pdf");
                replacePagesOperation.SetBaseInput(baseSourceFile);

                // Create a FileRef instance using a local file.
                FileRef firstInputFile = FileRef.CreateFromLocalFile(@"replacePagesInput1.pdf");
                PageRanges pageRanges = GetPageRangeForFirstFile();

                // Adds the pages (specified by the page ranges) of the input PDF file for replacing the
                // page of the base PDF file.
                replacePagesOperation.AddPagesForReplace(firstInputFile, pageRanges, 1);

                // Create a FileRef instance using a local file.
                FileRef secondInputFile = FileRef.CreateFromLocalFile(@"replacePagesInput2.pdf");

                // Adds all the pages of the input PDF file for replacing the page of the base PDF file.
                replacePagesOperation.AddPagesForReplace(secondInputFile, 3);

                // Execute the operation.
                FileRef result = replacePagesOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/replacePagesOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            // Catch more errors here . . .
        }

        private static PageRanges GetPageRangeForFirstFile()
        {
            // Specify pages of the first file for replacing the page of base PDF file.
            PageRanges pageRanges = new PageRanges();
            // Add pages 1 to 3.
            pageRanges.AddRange(1, 3);

            // Add page 4.
            pageRanges.AddSinglePage(4);

            return pageRanges;
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode24">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/replacepages/replace-pdf-pages.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const getPageRangesForFirstFile = () => {
    // Specify pages of the first file for replacing the page of base PDF file.
    const pageRangesForFirstFile = new PDFServicesSdk.PageRanges();
    // Add pages 1 to 3.
    pageRangesForFirstFile.addPageRange(1, 3);

    // Add page 4.
    pageRangesForFirstFile.addSinglePage(4);

    return pageRangesForFirstFile;
  };

  try {
    // Initial setup, create credentials instance.
    const credentials = PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        replacePagesOperation = PDFServicesSdk.ReplacePages.Operation.createNew();

    // Set operation base input from a source file.
    const baseInputFile = PDFServicesSdk.FileRef.createFromLocalFile('resources/baseInput.pdf');
    replacePagesOperation.setBaseInput(baseInputFile);

    // Create a FileRef instance using a local file.
    const firstInputFile = PDFServicesSdk.FileRef.createFromLocalFile('resources/replacePagesInput1.pdf'),
        pageRanges = getPageRangesForFirstFile();

    // Adds the pages (specified by the page ranges) of the input PDF file for replacing the
    // page of the base PDF file.
    replacePagesOperation.addPagesForReplace(1, firstInputFile, pageRanges);

    // Create a FileRef instance using a local file.
    const secondInputFile = PDFServicesSdk.FileRef.createFromLocalFile('resources/replacePagesInput2.pdf');

    // Adds all the pages of the input PDF file for replacing the page of the base PDF file.
    replacePagesOperation.addPagesForReplace(3, secondInputFile);

    // Execute the operation and Save the result to the specified location.
    replacePagesOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/replacePagesOutput.pdf'))
        .catch(err => {
            if (err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Delete Pages
=====================================

The delete pages operation selectively removes pages from a PDF file.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava25">JAVA</a></li>
      <li><a href="#tabsnet25">.NET</a></li>
      <li><a href="#tabsnode25">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-pageManipulation">REST API</a></li>
    </ul>

    <div id="tabsjava25">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.deletepages.DeletePDFPages</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

    public class DeletePDFPages {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(DeletePDFPages.class);

    public static void main(String[] args) {
        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            DeletePagesOperation deletePagesOperation = DeletePagesOperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/deletePagesInput.pdf");
            deletePagesOperation.setInput(source);

            // Delete pages of the document (as specified by PageRanges).
            PageRanges pageRangeForDeletion = getPageRangeForDeletion();
            deletePagesOperation.setPageRanges(pageRangeForDeletion);

            // Execute the operation.
            FileRef result = deletePagesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs("output/deletePagesOutput.pdf");

        } catch (IOException | ServiceApiException | SdkException | ServiceUsageException e) {
            LOGGER.error("Exception encountered while executing operation", e);
        }
    }

    private static PageRanges getPageRangeForDeletion() {
        // Specify pages for deletion.
        PageRanges pageRangeForDeletion = new PageRanges();
        // Add page 1.
        pageRangeForDeletion.addSinglePage(1);

        // Add pages 3 to 4.
        pageRangeForDeletion.addRange(3, 4);
        return pageRangeForDeletion;
    }
  }
      </pre>
    </div>

    <div id="tabsnet25">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd DeletePDFPages/<br/>dotnet run DeletePDFPages.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace DeletePDFPages
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            // Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create a new operation instance
                DeletePagesOperation deletePagesOperation = DeletePagesOperation.CreateNew();

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"deletePagesInput.pdf");
                deletePagesOperation.SetInput(sourceFileRef);

                // Delete pages of the document (as specified by PageRanges).
                PageRanges pageRangeForDeletion = GetPageRangeForDeletion();
                deletePagesOperation.SetPageRanges(pageRangeForDeletion);

                // Execute the operation.
                FileRef result = deletePagesOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/deletePagesOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        private static PageRanges GetPageRangeForDeletion()
        {
            // Specify pages for deletion.
            PageRanges pageRangeForDeletion = new PageRanges();
            // Add page 1.
            pageRangeForDeletion.AddSinglePage(1);

            // Add pages 3 to 4.
            pageRangeForDeletion.AddRange(3, 4);
            return pageRangeForDeletion;
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode25">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/deletepages/delete-pdf-pages.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const getPageRangesForDeletion = () => {
    // Specify pages for deletion.
    const pageRangesForDeletion = new PDFServicesSdk.PageRanges();
    // Add page 1.
    pageRangesForDeletion.addSinglePage(1);

    // Add pages 3 to 4.
    pageRangesForDeletion.addPageRange(3, 4);
    return pageRangesForDeletion;
  };

  try {
    // Initial setup, create credentials instance.
    const credentials = PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        deletePagesOperation = PDFServicesSdk.DeletePages.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/deletePagesInput.pdf');
    deletePagesOperation.setInput(input);

    // Delete pages of the document (as specified by PageRanges).
    const pageRangesForDeletion = getPageRangesForDeletion();
    deletePagesOperation.setPageRanges(pageRangesForDeletion);

    // Execute the operation and Save the result to the specified location.
    deletePagesOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/deletePagesOutput.pdf'))
        .catch(err => {
            if (err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Reorder Pages
=====================================

The reorder pages operation moves pages from one location to another in a PDF file.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava26">JAVA</a></li>
      <li><a href="#tabsnet26">.NET</a></li>
      <li><a href="#tabsnode26">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-combinePDF">REST API</a></li>
    </ul>

    <div id="tabsjava26">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.reorderpages.ReorderPDFPages</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class ReorderPDFPages {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(ReorderPDFPages.class);

    public static void main(String[] args) {
        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            ReorderPagesOperation reorderPagesOperation = ReorderPagesOperation.createNew();

            // Set operation input from a source file, along with specifying the order of the pages for
            // rearranging the pages in a PDF file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/reorderPagesInput.pdf");
            PageRanges pageRanges = getPageRangeForReorder();
            reorderPagesOperation.setInput(source);
            reorderPagesOperation.setPagesOrder(pageRanges);

            // Execute the operation.
            FileRef result = reorderPagesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs("output/reorderPagesOutput.pdf");

        } catch (IOException | ServiceApiException | SdkException | ServiceUsageException e) {
            LOGGER.error("Exception encountered while executing operation", e);
        }
    }

    private static PageRanges getPageRangeForReorder() {
        // Specify order of the pages for an output document.
        PageRanges pageRanges = new PageRanges();
        // Add pages 3 to 4.
        pageRanges.addRange(3, 4);

        // Add page 1.
        pageRanges.addSinglePage(1);

        return pageRanges;
    }
  }
      </pre>
    </div>

    <div id="tabsnet26">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd ReorderPages/<br/>dotnet run ReorderPDFPages.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace ReorderPDFPages
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            // Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create a new operation instance
                ReorderPagesOperation reorderPagesOperation = ReorderPagesOperation.CreateNew();

                // Set operation input from a source file, along with specifying the order of the pages for
                // rearranging the pages in a PDF file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"reorderPagesInput.pdf");
                reorderPagesOperation.SetInput(sourceFileRef);
                PageRanges pageRanges = GetPageRangeForReorder();
                reorderPagesOperation.SetPagesOrder(pageRanges);

                // Execute the operation.
                FileRef result = reorderPagesOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/reorderPagesOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        private static PageRanges GetPageRangeForReorder()
        {
            // Specify order of the pages for an output document.
            PageRanges pageRanges = new PageRanges();
            // Add pages 3 to 4.
            pageRanges.AddRange(3, 4);

            // Add page 1.
            pageRanges.AddSinglePage(1);

            return pageRanges;
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode26">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/reorderpages/reorder-pdf-pages.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const getPageRangeForReorder = () => {
    // Specify order of the pages for an output document.
    const pageRanges = new PDFServicesSdk.PageRanges();

    // Add pages 3 to 4.
    pageRanges.addPageRange(3, 4);

    // Add page 1.
    pageRanges.addSinglePage(1);

    return pageRanges;
  };
  try {
    // Initial setup, create credentials instance.
    const credentials = PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        reorderPagesOperation = PDFServicesSdk.ReorderPages.Operation.createNew();

    // Set operation input from a source file, along with specifying the order of the pages for
    // rearranging the pages in a PDF file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/reorderPagesInput.pdf');
    const pageRanges = getPageRangeForReorder();
    reorderPagesOperation.setInput(input);
    reorderPagesOperation.setPagesOrder(pageRanges);

    // Execute the operation and Save the result to the specified location.
    reorderPagesOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/reorderPagesOutput.pdf'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Rotate Pages
=====================================

The rotate pages operation selectively rotates pages in PDF file. For example, you can change portrait view to landscape view.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava27">JAVA</a></li>
      <li><a href="#tabsnet27">.NET</a></li>
      <li><a href="#tabsnode27">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-pageManipulation">REST API</a></li>
    </ul>

    <div id="tabsjava27">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.rotatepages.RotatePDFPages</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class RotatePDFPages {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(RotatePDFPages.class);

    public static void main(String[] args) {
        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            RotatePagesOperation rotatePagesOperation = RotatePagesOperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/rotatePagesInput.pdf");
            rotatePagesOperation.setInput(source);

            // Sets angle by 90 degrees (in clockwise direction) for rotating the specified pages of
            // the input PDF file.
            PageRanges firstPageRange = getFirstPageRangeForRotation();
            rotatePagesOperation.setAngleToRotatePagesBy(Angle._90, firstPageRange);

            // Sets angle by 180 degrees (in clockwise direction) for rotating the specified pages of
            // the input PDF file.
            PageRanges secondPageRange = getSecondPageRangeForRotation();
            rotatePagesOperation.setAngleToRotatePagesBy(Angle._180, secondPageRange);

            // Execute the operation.
            FileRef result = rotatePagesOperation.execute(executionContext);

            // Save the result to the specified location.
            result.saveAs("output/rotatePagesOutput.pdf");

        } catch (IOException | ServiceApiException | SdkException | ServiceUsageException e) {
            LOGGER.error("Exception encountered while executing operation", e);
        }
    }

    private static PageRanges getFirstPageRangeForRotation() {
        // Specify pages for rotation.
        PageRanges firstPageRange = new PageRanges();
        // Add page 1.
        firstPageRange.addSinglePage(1);

        // Add pages 3 to 4.
        firstPageRange.addRange(3, 4);
        return firstPageRange;
    }

    private static PageRanges getSecondPageRangeForRotation() {
        // Specify pages for rotation.
        PageRanges secondPageRange = new PageRanges();
        // Add page 2.
        secondPageRange.addSinglePage(2);

        return secondPageRange;
    }
  }
    </pre>
    </div>

    <div id="tabsnet27">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd RotatePDFPages/<br/>dotnet run RotatePDFPages.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace RotatePDFPages
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            // Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create a new operation instance
                RotatePagesOperation rotatePagesOperation = RotatePagesOperation.CreateNew();

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"rotatePagesInput.pdf");
                rotatePagesOperation.SetInput(sourceFileRef);

                // Sets angle by 90 degrees (in clockwise direction) for rotating the specified pages of
                // the input PDF file.
                PageRanges firstPageRange = GetFirstPageRangeForRotation();
                rotatePagesOperation.SetAngleToRotatePagesBy(Angle._90, firstPageRange);

                // Sets angle by 180 degrees (in clockwise direction) for rotating the specified pages of
                // the input PDF file.
                PageRanges secondPageRange = GetSecondPageRangeForRotation();
                rotatePagesOperation.SetAngleToRotatePagesBy(Angle._180, secondPageRange);

                // Execute the operation.
                FileRef result = rotatePagesOperation.Execute(executionContext);

                // Save the result to the specified location.
                result.SaveAs(Directory.GetCurrentDirectory() + "/output/rotatePagesOutput.pdf");
            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }

        private static PageRanges GetFirstPageRangeForRotation()
        {
            // Specify pages for rotation.
            PageRanges firstPageRange = new PageRanges();
            // Add page 1.
            firstPageRange.AddSinglePage(1);

            // Add pages 3 to 4.
            firstPageRange.AddRange(3, 4);
            return firstPageRange;
        }

        private static PageRanges GetSecondPageRangeForRotation()
        {
            // Specify pages for rotation.
            PageRanges secondPageRange = new PageRanges();
            // Add page 2.
            secondPageRange.AddSinglePage(2);

            return secondPageRange;
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode27">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/rotatepages/rotate-pdf-pages.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const getFirstPageRangeForRotation = () => {
    // Specify pages for rotation.
    const firstPageRange = new PDFServicesSdk.PageRanges();
    // Add page 1.
    firstPageRange.addSinglePage(1);

    // Add pages 3 to 4.
    firstPageRange.addPageRange(3, 4);

    return firstPageRange;
  };

  const getSecondPageRangeForRotation = () => {
    // Specify pages for rotation.
    const secondPageRange = new PDFServicesSdk.PageRanges();
    // Add page 2.
    secondPageRange.addSinglePage(2);

    return secondPageRange;
  };

  try {
    // Initial setup, create credentials instance.
    const credentials = PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
        rotatePagesOperation = PDFServicesSdk.RotatePages.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/rotatePagesInput.pdf');
    rotatePagesOperation.setInput(input);

    // Sets angle by 90 degrees (in clockwise direction) for rotating the specified pages of
    // the input PDF file.
    const firstPageRange = getFirstPageRangeForRotation();
    rotatePagesOperation.setAngleToRotatePagesBy(PDFServicesSdk.RotatePages.Angle._90, firstPageRange);

    // Sets angle by 180 degrees (in clockwise direction) for rotating the specified pages of
    // the input PDF file.
    const secondPageRange = getSecondPageRangeForRotation();
    rotatePagesOperation.setAngleToRotatePagesBy(PDFServicesSdk.RotatePages.Angle._180,secondPageRange);

    // Execute the operation and Save the result to the specified location.
    rotatePagesOperation.execute(executionContext)
        .then(result => result.saveAsFile('output/rotatePagesOutput.pdf'))
        .catch(err => {
            if (err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Split PDF
=====================================

Split PDF by number of pages
--------------------------------

This operation splits a PDF into multiple smaller documents. Simply use the page count to specify the maximum number of pages of each output file.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava28">JAVA</a></li>
      <li><a href="#tabsnet28">.NET</a></li>
      <li><a href="#tabsnode28">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-splitPDF">REST API</a></li>
    </ul>

    <div id="tabsjava28">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.splitpdf.SplitPDFByNumberOfPages</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class SplitPDFByNumberOfPages {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(SplitPDFByNumberOfPages.class);

    public static void main(String[] args) {
        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            SplitPDFOperation splitPDFOperation = SplitPDFOperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/splitPDFInput.pdf");
            splitPDFOperation.setInput(source);

            // Set the maximum number of pages each of the output files can have.
            splitPDFOperation.setPageCount(2);

            // Execute the operation.
            List<FileRef> result = splitPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            int index = 0;
            for (FileRef fileRef : result) {
                fileRef.saveAs("output/SplitPDFByNumberOfPagesOutput_" + index + ".pdf");
                index++;
            }

        } catch (IOException| ServiceApiException | SdkException | ServiceUsageException e) {
            LOGGER.error("Exception encountered while executing operation", e);
        }
    }

  }
    </pre>
    </div>

    <div id="tabsnet28">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd SplitPDFByNumberOfPages/<br/>dotnet run SplitPDFByNumberOfPages.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace SplitPDFByNumberOfPages
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create a new operation instance
                SplitPDFOperation splitPDFOperation = SplitPDFOperation.CreateNew();

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"splitPDFInput.pdf");
                splitPDFOperation.SetInput(sourceFileRef);

                // Set the maximum number of pages each of the output files can have.
                splitPDFOperation.SetPageCount(2);

                // Execute the operation.
                List<FileRef> result = splitPDFOperation.Execute(executionContext);

                // Save the result to the specified location.
                int index = 0;
                foreach (FileRef fileRef in result)
                {
                    fileRef.SaveAs(Directory.GetCurrentDirectory() + "/output/SplitPDFByNumberOfPagesOutput_" + index + ".pdf");
                    index++;
                }

            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode28">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/splitpdf/split-pdf-by-number-of-pages.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

    // Create a new operation instance.
    const splitPDFOperation = PDFServicesSdk.SplitPDF.Operation.createNew(),
        input = PDFServicesSdk.FileRef.createFromLocalFile(
            'resources/splitPDFInput.pdf',
            PDFServicesSdk.SplitPDF.SupportedSourceFormat.pdf
        );
    // Set operation input from a source file.
    splitPDFOperation.setInput(input);

    // Set the maximum number of pages each of the output files can have.
    splitPDFOperation.setPageCount(2);

    // Execute the operation and Save the result to the specified location.
    splitPDFOperation.execute(executionContext)
        .then(result => {
            let saveFilesPromises = [];
            for(let i = 0; i < result.length; i++){
                saveFilesPromises.push(result[i].saveAsFile(`output/SplitPDFByNumberOfPagesOutput_${i}.pdf`));
            }
            return Promise.all(saveFilesPromises);
        })
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Split PDF by page ranges
--------------------------------

As an alternative to creating smaller PDFs with a set number of pages, you can split PDFs into multiple smaller documents by specifying page ranges where each page range corresponds to a single output file.

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava29">JAVA</a></li>
      <li><a href="#tabsnet29">.NET</a></li>
      <li><a href="#tabsnode29">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-splitPDF">REST API</a></li>
    </ul>

    <div id="tabsjava29">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.splitpdf.SplitPDFByPageRanges</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class SplitPDFByPageRanges {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(SplitPDFByPageRanges.class);

    public static void main(String[] args) {
        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            SplitPDFOperation splitPDFOperation = SplitPDFOperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/splitPDFInput.pdf");
            splitPDFOperation.setInput(source);

            // Set the page ranges where each page range corresponds to a single output file.
            PageRanges pageRanges = getPageRanges();
            splitPDFOperation.setPageRanges(pageRanges);

            // Execute the operation.
            List<FileRef> result = splitPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            int index = 0;
            for (FileRef fileRef : result) {
                fileRef.saveAs("output/SplitPDFByPageRangesOutput_" + index + ".pdf");
                index++;
            }

        } catch (IOException | ServiceApiException | SdkException | ServiceUsageException e) {
            LOGGER.error("Exception encountered while executing operation", e);
        }
    }

    private static PageRanges getPageRanges() {
        // Specify page ranges.
        PageRanges pageRanges = new PageRanges();
        // Add page 1.
        pageRanges.addSinglePage(1);

        // Add pages 3 to 4.
        pageRanges.addRange(3, 4);
        return pageRanges;
    }

  }
    </pre>
    </div>

    <div id="tabsnet29">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd SplitPDFByPageRanges/<br/>dotnet run SplitPDFByPageRanges.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace SplitPDFByPageRanges
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create a new operation instance
                SplitPDFOperation splitPDFOperation = SplitPDFOperation.CreateNew();

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"splitPDFInput.pdf");
                splitPDFOperation.SetInput(sourceFileRef);

                // Set the page ranges where each page range corresponds to a single output file.
                PageRanges pageRanges = GetPageRanges();
                splitPDFOperation.SetPageRanges(pageRanges);

                // Execute the operation.
                List<FileRef> result = splitPDFOperation.Execute(executionContext);

                // Save the result to the specified location.
                int index = 0;
                foreach (FileRef fileRef in result)
                {
                    fileRef.SaveAs(Directory.GetCurrentDirectory() + "/output/SplitPDFByPageRangesOutput_" + index + ".pdf");
                    index++;
                }

            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
            // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }

        private static PageRanges GetPageRanges()
        {
            // Specify page ranges.
            PageRanges pageRanges = new PageRanges();
            // Add page 1.
            pageRanges.AddSinglePage(1);

            // Add pages 3 to 4.
            pageRanges.AddRange(3, 4);
            return pageRanges;
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode29">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/splitpdf/split-pdf-by-page-ranges.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  const getPageRanges = () => {
    // Specify pages ranges.
    const pageRanges = new PDFServicesSdk.PageRanges();
    // Add page 1.
    pageRanges.addSinglePage(1);

    // Add pages 3 to 4.
    pageRanges.addPageRange(3, 4);
    return pageRanges;
  };
  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

    // Create a new operation instance.
    const splitPDFOperation = PDFServicesSdk.SplitPDF.Operation.createNew(),
        input = PDFServicesSdk.FileRef.createFromLocalFile(
            'resources/splitPDFInput.pdf',
            PDFServicesSdk.SplitPDF.SupportedSourceFormat.pdf
        );
    // Set operation input from a source file.
    splitPDFOperation.setInput(input);

    // Set the page ranges where each page range corresponds to a single output file.
    const pageRanges = getPageRanges();
    splitPDFOperation.setPageRanges(pageRanges);

    // Execute the operation and Save the result to the specified location.
    splitPDFOperation.execute(executionContext)
        .then(result => {
            let saveFilesPromises = [];
            for(let i = 0; i < result.length; i++){
                saveFilesPromises.push(result[i].saveAsFile(`output/SplitPDFByPageRangesOutput_${i}.pdf`));
            }
            return Promise.all(saveFilesPromises);
        })
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Split PDF into number of files
--------------------------------

As an alternative to creating smaller PDFs by specifying a set number of pages or a page range, you can split PDFs by file count. In this case, the operation creates the specified number of files with each containing an identical number of pages (if possible).

.. raw:: html

 <div class="tabs">
    <!--begin tab data-->
    <ul>
      <li><a href="#tabsjava30">JAVA</a></li>
      <li><a href="#tabsnet30">.NET</a></li>
      <li><a href="#tabsnode30">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-splitPDF">REST API</a></li>
    </ul>

    <div id="tabsjava30">
      <div class="cmdline"><strong>Run the sample:</strong><br/>mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.splitpdf.SplitPDFIntoNumberOfFiles</div>
      <pre class="prettyprint">
       // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class SplitPDFIntoNumberOfFiles {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(SplitPDFIntoNumberOfFiles.class);

    public static void main(String[] args) {
        try {
            // Initial setup, create credentials instance.
            Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                    .fromFile("pdfservices-api-credentials.json")
                    .build();

            // Create an ExecutionContext using credentials and create a new operation instance.
            ExecutionContext executionContext = ExecutionContext.create(credentials);
            SplitPDFOperation splitPDFOperation = SplitPDFOperation.createNew();

            // Set operation input from a source file.
            FileRef source = FileRef.createFromLocalFile("src/main/resources/splitPDFInput.pdf");
            splitPDFOperation.setInput(source);

            // Set the number of documents to split the input PDF file into.
            splitPDFOperation.setFileCount(2);

            // Execute the operation.
            List<FileRef> result = splitPDFOperation.execute(executionContext);

            // Save the result to the specified location.
            int index = 0;
            for (FileRef fileRef : result) {
                fileRef.saveAs("output/SplitPDFIntoNumberOfFilesOutput_" + index + ".pdf");
                index++;
            }

        } catch (IOException | ServiceApiException | SdkException | ServiceUsageException e) {
            LOGGER.error("Exception encountered while executing operation", e);
        }
    }

  }
    </pre>
    </div>

    <div id="tabsnet30">
      <div class="cmdline"><strong>Run the sample:</strong><br/>cd SplitPDFIntoNumberOfFiles/<br/>dotnet run SplitPDFIntoNumberOfFiles.csproj</div>
      <pre class="prettyprint">
      // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples
  namespace SplitPDFIntoNumberOfFiles
  {
    class Program
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(Program));
        static void Main()
        {
            //Configure the logging
            ConfigureLogging();
            try
            {
                // Initial setup, create credentials instance.
                Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                .Build();

                // Create an ExecutionContext using credentials.
                ExecutionContext executionContext = ExecutionContext.Create(credentials);

                // Create a new operation instance
                SplitPDFOperation splitPDFOperation = SplitPDFOperation.CreateNew();

                // Set operation input from a source file.
                FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"splitPDFInput.pdf");
                splitPDFOperation.SetInput(sourceFileRef);

                // Set the number of documents to split the input PDF file into.
                splitPDFOperation.SetFileCount(2);

                // Execute the operation.
                List<FileRef> result = splitPDFOperation.Execute(executionContext);

                // Save the result to the specified location.
                int index = 0;
                foreach (FileRef fileRef in result)
                {
                    fileRef.SaveAs(Directory.GetCurrentDirectory() + "/output/SplitPDFIntoNumberOfFilesOutput_" + index + ".pdf");
                    index++;
                }

            }
            catch (ServiceUsageException ex)
            {
                log.Error("Exception encountered while executing operation", ex);
            }
             // Catch more errors here . . .
        }

        static void ConfigureLogging()
        {
            ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
        }
    }
  }
      </pre>
    </div>

    <div id="tabsnode30">
      <div class="cmdline"><strong>Run the sample:</strong><br/>node src/splitpdf/split-pdf-into-number-of-files.js</div>
      <pre class="prettyprint">
      // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    // Create an ExecutionContext using credentials
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

    // Create a new operation instance.
    const splitPDFOperation = PDFServicesSdk.SplitPDF.Operation.createNew(),
        input = PDFServicesSdk.FileRef.createFromLocalFile(
            'resources/splitPDFInput.pdf',
            PDFServicesSdk.SplitPDF.SupportedSourceFormat.pdf
        );
    // Set operation input from a source file.
    splitPDFOperation.setInput(input);

    // Set the number of documents to split the input PDF file into.
    splitPDFOperation.setFileCount(2);

    // Execute the operation and Save the result to the specified location.
    splitPDFOperation.execute(executionContext)
        .then(result => {
            let saveFilesPromises = [];
            for(let i = 0; i < result.length; i++){
                saveFilesPromises.push(result[i].saveAsFile(`output/SplitPDFIntoNumberOfFilesOutput_${i}.pdf`));
            }
            return Promise.all(saveFilesPromises);
        })
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
      </pre>
    </div>
  <!--end tab data-->
  </div>

Extract PDF
===============


Structured Information Output Format
----------------------------------------

The output of an SDK extract operation is a zip package containing the following:

* The structuredData.json file with the extracted content & PDF element structure. See the `JSON schema <../../release/shared/extractJSONOutputSchema2.json>`_ for a description of the default output. (Please refer the `Styling JSON schema <../../release/shared/extractJSONOutputSchemaStylingInfo.json>`_ for a description of the output when the styling option is enabled.)
* A renditions folder(s) containing renditions for each element type selected as input. The folder name is either "tables" or "figures" depending on your specified element type. Each folder contains renditions with filenames that correspond to the element information in the JSON file.

.. image:: ./images/extractsamplefiles.png

The following is a summary of key elements in the extracted JSON(See additional descriptions in the `JSON schema <../../release/shared/extractJSONOutputSchema2.json>`_):

*  Elements : Ordered list of semantic elements (like headings, paragraphs, tables, figures) found in the document, on the basis of position in the structure tree of the document.The output does not include headers or footers.In addition, headings that repeat across pages are reported for the first occurrence only.
*  Bounds : Bounding box enclosing the content items forming this element. Not reported for elements which don't have any content items (like empty table cells).
*  Font : Font description for the font associated with the first character. Only reported for text elements.
*  TextSize : Text size (in points) of the last character. Only reported for text elements.
*  Attributes: Includes additional properties like line height and text alignment.
*  Path : The Path describes the location of elements in the structure tree including the element type and the instance number. Element types are based on the
   `ISO standard <https://www.iso.org/standard/75839.html>`_ , a summary is included below for convenience :

   * Aside : Content which is not part of regular content flow of the document
   * Figure : Non-reflowable constructs like graphs, images, flowcharts
   * Footnote : FootNote
   * H, H1, H2, etc : Heading Level
   * L : List
   * Li : List Item
   * Lbl : List Item label
   * Lbody : List item body
   * P : Paragraph
   * ParagraphSpan : Denotes part of a paragraph. Reported when paragraph is broken (generally due to page break or column break)
   * Reference : Link
   * Sect : Logical section of the document
   * StyleSpan : Denotes difference in styling of text relative to the parent container
   * Sub : Single line of a multiline paragraph (e.g. addresses). Such paras are created in html using <br> inside <p> tags
   * Table : Table
   * TD : Table cell
   * TH : Table header cell
   * TR : Table row
   * Title : Title of the document. This is the most prominent heading which can define the whole document.
   * TOC : Table of contents
   * TOCI : Table of contents item
   * Watermark : Watermark

*  Text : Text for the element in UTF-8 format, only reported for text elements. When inline elements are reported separately from parent block element, then this value has references to those inline elements.
*  Figures : Identified as a Figure in the Path attribute, saved as a PNG in the figures folder with the filename identified in the filePaths attribute.
*  Tables : Identified as a Table in the Path attribute, saved as a .CSV, .XLSX, and .PNG in the tables folder with the filename identified in the filePaths attribute.
*  FilePaths : List of file paths to additional output files (images and spreadsheets)
*  Pages : A list of properties for each page of the PDF including page number, width, height, and rotation.
*  Reading Order : The reading order of content within columns, across page breaks, and inclusive of asides is represented by the order of the elements in the Elements array. In the normal mode, exceptions can occur for elements extracted from their container (eg. A reference link in the middle of a paragraph). However, the order is preserved in Styling mode where all Elements and their Kids are represented in the natural reading order.

API limitations
--------------------------

* **Unsupported PDF types**: The API does not support extracting from policy protected and secured PDFs unless the security restrictions allow for Content Copying.
* **Size limits**: Maximum supported file size is 100MB.
* **Page limits**: Non scanned PDFs are limited to 200 pages and Scanned PDFs must be 100 pages or less.Limits may be lower for files with a large number of tables.
* **Rate limits[Extract]**: Keep request rate below 25 requests per minute.


Extract Text from a PDF
--------------------------

Use the sample below to extract text element information from a PDF document.

.. raw:: html

  <div class="tabs">
      <ul>
        <li><a href="#tabsjava100">JAVA</a></li>
        <li><a href="#tabsnet100">.NET</a></li>
        <li><a href="#tabsnode100">NODE</a></li>
        <li><a href="#tabspython100">PYTHON</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-extractPDF">REST API</a></li>
      </ul>
      <div id="tabsjava100">
      <div class="cmdline"><strong>Run the sample:</strong><br />

  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.extractpdf.ExtractTextInfoFromPDF </div>
  <pre class="prettyprint">

  public class ExtractTextInfoFromPDF {

      private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(ExtractTextInfoFromPDF.class);

      public static void main(String[] args) {

          try {

              // Initial setup, create credentials instance.
              Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                      .fromFile("pdfservices-api-credentials.json")
                      .build();

              // Create an ExecutionContext using credentials.
              ExecutionContext executionContext = ExecutionContext.create(credentials);

              ExtractPDFOperation extractPDFOperation = ExtractPDFOperation.createNew();

              // Provide an input FileRef for the operation
              FileRef source = FileRef.createFromLocalFile("src/main/resources/extractPdfInput.pdf");
              extractPDFOperation.setInputFile(source);

              // Build ExtractPDF options and set them into the operation
              ExtractPDFOptions extractPDFOptions = ExtractPDFOptions.extractPdfOptionsBuilder()
                      .addElementsToExtract(Arrays.asList(ExtractElementType.TEXT))
                      .build();
              extractPDFOperation.setOptions(extractPDFOptions);

              // Execute the operation
              FileRef result = extractPDFOperation.execute(executionContext);

              // Save the result at the specified location
              result.saveAs("output/ExtractTextInfoFromPDF.zip");

          } catch (ServiceApiException | IOException | SdkException | ServiceUsageException e) {
              LOGGER.error("Exception encountered while executing operation", e);
          }
      }
  }
      </pre>
    </div>
    <div id="tabsnet100">
    <div class="cmdline"><strong>Run the sample:</strong><br />
      cd ExtractTextInfoFromPDF/<br />
      dotnet run ExtractTextInfoFromPDF.csproj </div>
    <pre class="prettyprint">

    namespace ExtractTextInfoFromPDF
    {
        class Program
        {
            private static readonly ILog log = LogManager.GetLogger(typeof(Program));
            static void Main()
            {
                //Configure the logging
                ConfigureLogging();
                try
                {
                    // Initial setup, create credentials instance.
                    Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                        .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                        .Build();

                    //Create an ExecutionContext using credentials and create a new operation instance.
                    ExecutionContext executionContext = ExecutionContext.Create(credentials);
                    ExtractPDFOperation extractPdfOperation = ExtractPDFOperation.CreateNew();

                    // Set operation input from a source file.
                    FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"extractPdfInput.pdf");
                    extractPdfOperation.SetInputFile(sourceFileRef);

                    // Build ExtractPDF options and set them into the operation
                    ExtractPDFOptions extractPdfOptions = ExtractPDFOptions.ExtractPdfOptionsBuilder()
                        .AddElementsToExtract(new List&lt;ExtractElementType&gt;(new []{ ExtractElementType.TEXT}))
                        .build();
                    extractPdfOperation .SetOptions(extractPdfOptions);

                    // Execute the operation.
                    FileRef result = extractPdfOperation.Execute(executionContext);

                    // Save the result to the specified location.
                    result.SaveAs(Directory.GetCurrentDirectory() + "/output/ExtractTextInfoFromPDF.zip");
                }
                catch (ServiceUsageException ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
                catch (ServiceApiException ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
                catch (SDKException ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
                catch (IOException ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
                catch (Exception ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
            }

            static void ConfigureLogging()
            {
                ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
                XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
            }
        }
    }

    </pre>
    </div>
     <div id="tabsnode100">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    node src/extractpdf/extract-text-info-from-pdf.js
     </div>
    <pre class="prettyprint">

    const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');
    try {
        // Initial setup, create credentials instance.
        const credentials =  PDFServicesSdk.Credentials
            .serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        // Create an ExecutionContext using credentials
        const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

        // Build extractPDF options
        const options = new PDFServicesSdk.ExtractPDF.options.ExtractPdfOptions.Builder()
            .addElementsToExtract(PDFServicesSdk.ExtractPDF.options.ExtractElementType.TEXT).build()

        // Create a new operation instance.
        const extractPDFOperation = PDFServicesSdk.ExtractPDF.Operation.createNew(),
            input = PDFServicesSdk.FileRef.createFromLocalFile(
                'resources/extractPDFInput.pdf',
                PDFServicesSdk.ExtractPDF.SupportedSourceFormat.pdf
            );

        // Set operation input from a source file.
        extractPDFOperation.setInput(input);

        // Set options
        extractPDFOperation.setOptions(options);

        extractPDFOperation.execute(executionContext)
            .then(result => result.saveAsFile('output/ExtractTextInfoFromPDF.zip'))
            .catch(err => {
                if(err instanceof PDFServicesSdk.Error.ServiceApiError
                    || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                    console.log('Exception encountered while executing operation', err);
                } else {
                    console.log('Exception encountered while executing operation', err);
                }
            });
    } catch (err) {
        console.log('Exception encountered while executing operation', err);
    }

    </pre>
    </div>
    <div id="tabspython100">
      <div class="cmdline"><strong>Run the sample:</strong><br />

  python src/extractpdf/extract_txt_from_pdf.py </div>
  <pre class="prettyprint">

    logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))

    try:
        # get base path.
        base_path = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

        # Initial setup, create credentials instance.
        credentials = Credentials.service_account_credentials_builder()\
            .from_file(base_path + "/pdfservices-api-credentials.json") \
            .build()

        #Create an ExecutionContext using credentials and create a new operation instance.
        execution_context = ExecutionContext.create(credentials)
        extract_pdf_operation = ExtractPDFOperation.create_new()

        #Set operation input from a source file.
        source = FileRef.create_from_local_file(base_path + "/resources/extractPdfInput.pdf")
        extract_pdf_operation.set_input(source)

        # Build ExtractPDF options and set them into the operation
        extract_pdf_options: ExtractPDFOptions = ExtractPDFOptions.builder() \
            .with_element_to_extract(ExtractElementType.TEXT) \
            .build()
        extract_pdf_operation.set_options(extract_pdf_options)

        #Execute the operation.
        result: FileRef = extract_pdf_operation.execute(execution_context)

        # Save the result to the specified location.
        result.save_as(base_path + "/output/ExtractTextInfoFromPDF.zip")
    except (ServiceApiException, ServiceUsageException, SdkException):
        logging.exception("Exception encountered while executing operation")


      </pre>
    </div>
  <!--end tab data-->
  </div>

Extract Text and Tables
--------------------------

The sample below extracts text and table elements information from a PDF document.It also generates table renditions in xlsx format by default.

.. raw:: html

  <div class="tabs">
      <ul>
        <li><a href="#tabsjava101">JAVA</a></li>
        <li><a href="#tabsnet101">.NET</a></li>
        <li><a href="#tabsnode101">NODE</a></li>
        <li><a href="#tabspython101">PYTHON</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-extractPDF">REST API</a></li>

      </ul>
      <div id="tabsjava101">
      <div class="cmdline"><strong>Run the sample:</strong><br />

    mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.extractpdf.ExtractTextTableInfoFromPDF </div>

    <pre class="prettyprint">

  public class ExtractTextTableInfoFromPDF {

      private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(ExtractTextTableInfoFromPDF.class);

      public static void main(String[] args) {

          try {

              // Initial setup, create credentials instance.
              Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                      .fromFile("pdfservices-api-credentials.json")
                      .build();

              // Create an ExecutionContext using credentials.
              ExecutionContext executionContext = ExecutionContext.create(credentials);

              ExtractPDFOperation extractPDFOperation = ExtractPDFOperation.createNew();

              // Provide an input FileRef for the operation
              FileRef source = FileRef.createFromLocalFile("src/main/resources/extractPdfInput.pdf");
              extractPDFOperation.setInputFile(source);

              // Build ExtractPDF options and set them into the operation
              ExtractPDFOptions extractPDFOptions = ExtractPDFOptions.extractPdfOptionsBuilder()
                      .addElementsToExtract(Arrays.asList(ExtractElementType.TEXT, ExtractElementType.TABLES))
                      .build();
              extractPDFOperation.setOptions(extractPDFOptions);

              // Execute the operation
              FileRef result = extractPDFOperation.execute(executionContext);

              // Save the result at the specified location
              result.saveAs("output/ExtractTextTableInfoFromPDF.zip");

          } catch (ServiceApiException | IOException | SdkException | ServiceUsageException e) {
              LOGGER.error("Exception encountered while executing operation", e);
          }
      }
  }
    </pre>
    </div>
    <div id="tabsnet101">
    <div class="cmdline"><strong>Run the sample:</strong><br />
      cd ExtractTextTableInfoFromPDF/<br />
      dotnet run ExtractTextTableInfoFromPDF.csproj </div>
    <pre class="prettyprint">

    namespace ExtractTextTableInfoFromPDF
    {
        class Program
        {
            private static readonly ILog log = LogManager.GetLogger(typeof(Program));
            static void Main()
            {
                //Configure the logging
                ConfigureLogging();
                try
                {
                    // Initial setup, create credentials instance.
                    Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                    .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                    .Build();

                    //Create an ExecutionContext using credentials and create a new operation instance.
                    ExecutionContext executionContext = ExecutionContext.Create(credentials);
                    ExtractPDFOperation extractPdfOperation = ExtractPDFOperation.CreateNew();

                    // Set operation input from a source file.
                    FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"extractPdfInput.pdf");
                    extractPdfOperation.SetInputFile(sourceFileRef);

                    // Build ExtractPDF options and set them into the operation
                    ExtractPDFOptions extractPdfOptions = ExtractPDFOptions.ExtractPdfOptionsBuilder()
                        .AddElementsToExtract(new List&lt;ExtractElementType&gt;(new []{ ExtractElementType.TEXT, ExtractElementType.TABLES}))
                        .build();
                    extractPdfOperation.SetOptions(extractPdfOptions);

                    // Execute the operation.
                    FileRef result = extractPdfOperation.Execute(executionContext);

                    // Save the result to the specified location.
                    result.SaveAs(Directory.GetCurrentDirectory() + "/output/ExtractTextTableInfoFromPDF.zip");
                }
                catch (ServiceUsageException ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
                catch (ServiceApiException ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
                catch (SDKException ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
                catch (IOException ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
                catch (Exception ex)
                {
                    log.Error("Exception encountered while executing operation", ex);
                }
            }

            static void ConfigureLogging()
            {
                ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
                XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
            }
        }
    }

    </pre>
    </div>
     <div id="tabsnode101">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    node src/extractpdf/extract-text-table-info-from-pdf.js
     </div>
    <pre class="prettyprint">

    const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');
    try {
        // Initial setup, create credentials instance.
        const credentials =  PDFServicesSdk.Credentials
            .serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        // Create an ExecutionContext using credentials
        const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

        // Build extractPDF options
        const options = new PDFServicesSdk.ExtractPDF.options.ExtractPdfOptions.Builder()
            .addElementsToExtract(PDFServicesSdk.ExtractPDF.options.ExtractElementType.TEXT, PDFServicesSdk.ExtractPDF.options.ExtractElementType.TABLES)
            .build()

        // Create a new operation instance.
        const extractPDFOperation = PDFServicesSdk.ExtractPDF.Operation.createNew(),
            input = PDFServicesSdk.FileRef.createFromLocalFile(
                'resources/extractPDFInput.pdf',
                PDFServicesSdk.ExtractPDF.SupportedSourceFormat.pdf
            );

        // Set operation input from a source file.
        extractPDFOperation.setInput(input);

        // Set options
        extractPDFOperation.setOptions(options);

        extractPDFOperation.execute(executionContext)
            .then(result => result.saveAsFile('output/ExtractTextTableInfoFromPDF.zip'))
            .catch(err => {
                if(err instanceof PDFServicesSdk.Error.ServiceApiError
                    || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                    console.log('Exception encountered while executing operation', err);
                } else {
                    console.log('Exception encountered while executing operation', err);
                }
            });
    } catch (err) {
        console.log('Exception encountered while executing operation', err);
    }

    </pre>
    </div>
  <div id="tabspython101">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    python src/extractpdf/extract_txt_table_info_from_pdf.py
     </div>
    <pre class="prettyprint">

    logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))

    try:
        # get base path.
        base_path = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

        # Initial setup, create credentials instance.
        credentials = Credentials.service_account_credentials_builder()\
            .from_file(base_path + "/pdfservices-api-credentials.json") \
            .build()

        #Create an ExecutionContext using credentials and create a new operation instance.
        execution_context = ExecutionContext.create(credentials)
        extract_pdf_operation = ExtractPDFOperation.create_new()

        #Set operation input from a source file.
        source = FileRef.create_from_local_file(base_path + "/resources/extractPdfInput.pdf")
        extract_pdf_operation.set_input(source)

        # Build ExtractPDF options and set them into the operation
        extract_pdf_options: ExtractPDFOptions = ExtractPDFOptions.builder() \
            .with_element_to_extract(ExtractElementType.TEXT) \
            .with_element_to_extract(ExtractElementType.TABLES) \
            .build()
        extract_pdf_operation.set_options(extract_pdf_options)

        #Execute the operation.
        result: FileRef = extract_pdf_operation.execute(execution_context)

        # Save the result to the specified location.
        result.save_as(base_path + "/output/ExtractTextTableInfoFromPDF.zip")
    except (ServiceApiException, ServiceUsageException, SdkException):
        logging.exception("Exception encountered while executing operation")

    </pre>
    </div>
  <!--end tab data-->
  </div>

Extract Text and Tables (w/ Tables Renditions)
----------------------------------------

The sample below extracts text and table elements information as well as table renditions from PDF Document. Note that the output is a zip containing the structured information along with renditions.

.. raw:: html

  <div class="tabs">
	  <!--<button onclick="copyToClipboard('#tabsjava1')">This copy button works.</button>-->
      <ul>
        <li><a href="#tabsjava102">JAVA</a></li>
        <li><a href="#tabsnet102">.NET</a></li>
        <li><a href="#tabsnode102">NODE</a></li>
        <li><a href="#tabspython102">PYTHON</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-extractPDF">REST API</a></li>
      </ul>
      <div id="tabsjava102">
      <div class="cmdline"><strong>Run the sample:</strong><br />

  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.extractpdf.ExtractTextTableInfoWithRenditionsFromPDF
  </div>

    <pre class="prettyprint">

  public class ExtractTextTableInfoWithRenditionsFromPDF {

      private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(ExtractTextTableInfoWithRenditionsFromPDF.class);

      public static void main(String[] args) {

          try {

              // Initial setup, create credentials instance.
              Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                      .fromFile("pdfservices-api-credentials.json")
                      .build();

              // Create an ExecutionContext using credentials.
              ExecutionContext executionContext = ExecutionContext.create(credentials);

              ExtractPDFOperation extractPDFOperation = ExtractPDFOperation.createNew();

              // Provide an input FileRef for the operation
              FileRef source = FileRef.createFromLocalFile("src/main/resources/extractPdfInput.pdf");
              extractPDFOperation.setInputFile(source);

              // Build ExtractPDF options and set them into the operation
              ExtractPDFOptions extractPDFOptions = ExtractPDFOptions.extractPdfOptionsBuilder()
                      .addElementsToExtract(Arrays.asList(ExtractElementType.TEXT, ExtractElementType.TABLES))
                      .addElementToExtractRenditions(ExtractRenditionsElementType.TABLES)
                      .build();
              extractPDFOperation.setOptions(extractPDFOptions);

              // Execute the operation
              FileRef result = extractPDFOperation.execute(executionContext);

              // Save the result at the specified location
              result.saveAs("output/ExtractTextTableInfoWithRenditionsFromPDF.zip");

          } catch (ServiceApiException | IOException | SdkException | ServiceUsageException e) {
              LOGGER.error("Exception encountered while executing operation", e);
          }
      }
  }
    </pre>
  </div>
  <div id="tabsnet102">
  <div class="cmdline"><strong>Run the sample:</strong><br />
    cd ExtractTextTableInfoWithRenditionsFromPDF/<br />
    dotnet run ExtractTextTableInfoWithRenditionsFromPDF.csproj </div>
  <pre class="prettyprint">

  namespace ExtractTextTableInfoWithRenditionsFromPDF
  {
      class Program
      {
          private static readonly ILog log = LogManager.GetLogger(typeof(Program));
          static void Main()
          {
              //Configure the logging
              ConfigureLogging();
              try
              {
                  // Initial setup, create credentials instance.
                  Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                  .Build();

                  //Create an ExecutionContext using credentials and create a new operation instance.
                  ExecutionContext executionContext = ExecutionContext.Create(credentials);
                  ExtractPDFOperation extractPdfOperation = ExtractPDFOperation.CreateNew();

                  // Set operation input from a source file.
                  FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"extractPdfInput.pdf");
                  extractPdfOperation.SetInputFile(sourceFileRef);

                  // Build ExtractPDF options and set them into the operation
                  ExtractPDFOptions extractPdfOptions = ExtractPDFOptions.ExtractPdfOptionsBuilder()
                          .AddElementsToExtract(new List&lt;ExtractElementType&gt;(new []{ ExtractElementType.TEXT, ExtractElementType.TABLES}))
                          .AddElementsToExtractRenditions(new List&lt;ExtractRenditionsElementType&gt; (new [] {ExtractRenditionsElementType.TABLES}))
                          .build();

                  extractPdfOperation.SetOptions(extractPdfOptions);

                  // Execute the operation.
                  FileRef result = extractPdfOperation.Execute(executionContext);

                  // Save the result to the specified location.
                  result.SaveAs(Directory.GetCurrentDirectory() + "/output/ExtractTextTableInfoWithRenditionsFromPDF.zip");
              }
              catch (ServiceUsageException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (ServiceApiException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (SDKException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (IOException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (Exception ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
          }

          static void ConfigureLogging()
          {
              ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
              XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
          }
      }
  }

  </pre>
  </div>
     <div id="tabsnode102">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    node src/extractpdf/extract-text-table-info-with-tables-renditions-from-pdf.js
     </div>
    <pre class="prettyprint">
    const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');
    try {
        // Initial setup, create credentials instance.
        const credentials =  PDFServicesSdk.Credentials
            .serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        // Create an ExecutionContext using credentials
        const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

        // Build extractPDF options
        const options = new PDFServicesSdk.ExtractPDF.options.ExtractPdfOptions.Builder()
            .addElementsToExtract(PDFServicesSdk.ExtractPDF.options.ExtractElementType.TEXT, PDFServicesSdk.ExtractPDF.options.ExtractElementType.TABLES)
            .addElementsToExtractRenditions(PDFServicesSdk.ExtractPDF.options.ExtractRenditionsElementType.TABLES)
            .build()

        // Create a new operation instance.
        const extractPDFOperation = PDFServicesSdk.ExtractPDF.Operation.createNew(),
            input = PDFServicesSdk.FileRef.createFromLocalFile(
                'resources/extractPDFInput.pdf',
                PDFServicesSdk.ExtractPDF.SupportedSourceFormat.pdf
            );

        // Set operation input from a source file
        extractPDFOperation.setInput(input);

        // Set options
        extractPDFOperation.setOptions(options);

        extractPDFOperation.execute(executionContext)
            .then(result => result.saveAsFile('output/ExtractTextTableInfoWithTablesRenditionsFromPDF.zip'))
            .catch(err => {
                if(err instanceof PDFServicesSdk.Error.ServiceApiError
                    || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                    console.log('Exception encountered while executing operation', err);
                } else {
                    console.log('Exception encountered while executing operation', err);
                }
            });
    } catch (err) {
        console.log('Exception encountered while executing operation', err);
    }
     </pre>
    </div>
  <div id="tabspython102">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    python src/extractpdf/extract_txt_table_info_with_rendition_from_pdf.py
     </div>
    <pre class="prettyprint">
    logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))

    try:
        # get base path.
        base_path = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

        # Initial setup, create credentials instance.
        credentials = Credentials.service_account_credentials_builder() \
            .from_file(base_path + "/pdfservices-api-credentials.json") \
            .build()

        # Create an ExecutionContext using credentials and create a new operation instance.
        execution_context = ExecutionContext.create(credentials)
        extract_pdf_operation = ExtractPDFOperation.create_new()

        # Set operation input from a source file.
        source = FileRef.create_from_local_file(base_path + "/resources/extractPdfInput.pdf")
        extract_pdf_operation.set_input(source)

        # Build ExtractPDF options and set them into the operation
        extract_pdf_options: ExtractPDFOptions = ExtractPDFOptions.builder() \
            .with_elements_to_extract([ExtractElementType.TEXT, ExtractElementType.TABLES]) \
            .with_element_to_extract_renditions(ExtractRenditionsElementType.TABLES) \
            .build()
        extract_pdf_operation.set_options(extract_pdf_options)

        # Execute the operation.
        result: FileRef = extract_pdf_operation.execute(execution_context)

        # Save the result to the specified location.
        result.save_as(base_path + "/output/ExtractTextTableWithTableRendition.zip")
    except (ServiceApiException, ServiceUsageException, SdkException):
        logging.exception("Exception encountered while executing operation")

     </pre>
    </div>
  <!--end tab data-->
  </div>



Extract Text and Tables (w/ Tables and Figures Renditions)
----------------------------------------

The sample below extracts text and table elements information as well as tables and figures renditions from PDF Document. Note that the output is a zip containing the structured information along with renditions.

.. raw:: html

  <div class="tabs">
	  <!--<button onclick="copyToClipboard('#tabsjava1')">This copy button works.</button>-->
      <ul>
        <li><a href="#tabsjava106">JAVA</a></li>
        <li><a href="#tabsnet106">.NET</a></li>
        <li><a href="#tabsnode106">NODE</a></li>
        <li><a href="#tabspython106">PYTHON</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-extractPDF">REST API</a></li>
      </ul>
      <div id="tabsjava106">
      <div class="cmdline"><strong>Run the sample:</strong><br />

  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.extractpdf.ExtractTextTableInfoWithRenditionsFromPDF
  </div>

    <pre class="prettyprint">

  public class ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF {

      private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF.class);

      public static void main(String[] args) {

          try {

              // Initial setup, create credentials instance.
              Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                      .fromFile("pdfservices-api-credentials.json")
                      .build();

              // Create an ExecutionContext using credentials.
              ExecutionContext executionContext = ExecutionContext.create(credentials);

              ExtractPDFOperation extractPDFOperation = ExtractPDFOperation.createNew();

              // Provide an input FileRef for the operation
              FileRef source = FileRef.createFromLocalFile("src/main/resources/extractPdfInput.pdf");
              extractPDFOperation.setInputFile(source);

              // Build ExtractPDF options and set them into the operation
              ExtractPDFOptions extractPDFOptions = ExtractPDFOptions.extractPdfOptionsBuilder()
                      .addElementsToExtract(Arrays.asList(ExtractElementType.TEXT, ExtractElementType.TABLES))
                      .addElementsToExtractRenditions(Arrays.asList(ExtractRenditionsElementType.TABLES, ExtractRenditionsElementType.FIGURES))
                      .build();
              extractPDFOperation.setOptions(extractPDFOptions);

              // Execute the operation
              FileRef result = extractPDFOperation.execute(executionContext);

              // Save the result at the specified location
              result.saveAs("output/ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF.zip");

          } catch (ServiceApiException | IOException | SdkException | ServiceUsageException e) {
              LOGGER.error("Exception encountered while executing operation", e);
          }
      }
  }
    </pre>
  </div>
  <div id="tabsnet106">
  <div class="cmdline"><strong>Run the sample:</strong><br />
    cd ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF/<br />
    dotnet run ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF.csproj </div>
  <pre class="prettyprint">

  namespace ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF
  {
      class Program
      {
          private static readonly ILog log = LogManager.GetLogger(typeof(Program));
          static void Main()
          {
              //Configure the logging
              ConfigureLogging();
              try
              {
                  // Initial setup, create credentials instance.
                  Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                  .Build();

                  //Create an ExecutionContext using credentials and create a new operation instance.
                  ExecutionContext executionContext = ExecutionContext.Create(credentials);
                  ExtractPDFOperation extractPdfOperation = ExtractPDFOperation.CreateNew();

                  // Set operation input from a source file.
                  FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"extractPdfInput.pdf");
                  extractPdfOperation.SetInputFile(sourceFileRef);

                  // Build ExtractPDF options and set them into the operation
                  ExtractPDFOptions extractPdfOptions = ExtractPDFOptions.ExtractPdfOptionsBuilder()
                          .AddElementsToExtract(new List&lt;ExtractElementType&gt;(new []{ ExtractElementType.TEXT, ExtractElementType.TABLES}))
                          .AddElementsToExtractRenditions(new List&lt;ExtractRenditionsElementType&gt; (new []{ExtractRenditionsElementType.FIGURES, ExtractRenditionsElementType.TABLES}))
                          .build();

                  extractPdfOperation.SetOptions(extractPdfOptions);

                  // Execute the operation.
                  FileRef result = extractPdfOperation.Execute(executionContext);

                  // Save the result to the specified location.
                  result.SaveAs(Directory.GetCurrentDirectory() + "/output/ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF.zip");
              }
              catch (ServiceUsageException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (ServiceApiException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (SDKException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (IOException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (Exception ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
          }

          static void ConfigureLogging()
          {
              ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
              XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
          }
      }
  }

  </pre>
  </div>
     <div id="tabsnode106">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    node src/extractpdf/extract-text-table-info-with-figures-tables-renditions-from-pdf.js
     </div>
    <pre class="prettyprint">
    const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');
    try {
        // Initial setup, create credentials instance.
        const credentials =  PDFServicesSdk.Credentials
            .serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        // Create an ExecutionContext using credentials
        const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

        // Build extractPDF options
        const options = new PDFServicesSdk.ExtractPDF.options.ExtractPdfOptions.Builder()
            .addElementsToExtract(PDFServicesSdk.ExtractPDF.options.ExtractElementType.TEXT, PDFServicesSdk.ExtractPDF.options.ExtractElementType.TABLES)
            .addElementsToExtractRenditions(PDFServicesSdk.ExtractPDF.options.ExtractRenditionsElementType.FIGURES, PDFServicesSdk.ExtractPDF.options.ExtractRenditionsElementType.TABLES)
            .build()

        // Create a new operation instance.
        const extractPDFOperation = PDFServicesSdk.ExtractPDF.Operation.createNew(),
            input = PDFServicesSdk.FileRef.createFromLocalFile(
                'resources/extractPDFInput.pdf',
                PDFServicesSdk.ExtractPDF.SupportedSourceFormat.pdf
            );

        // Set operation input from a source file
        extractPDFOperation.setInput(input);

        // Set options
        extractPDFOperation.setOptions(options);

        extractPDFOperation.execute(executionContext)
            .then(result => result.saveAsFile('output/ExtractTextTableWithFigureTableRendition.zip'))
            .catch(err => {
                if(err instanceof PDFServicesSdk.Error.ServiceApiError
                    || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                    console.log('Exception encountered while executing operation', err);
                } else {
                    console.log('Exception encountered while executing operation', err);
                }
            });
    } catch (err) {
        console.log('Exception encountered while executing operation', err);
    }
     </pre>
    </div>
  <div id="tabspython106">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    python src/extractpdf/extract_txt_table_info_with_figure_tables_rendition_from_pdf.py
     </div>
    <pre class="prettyprint">
    logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))

    try:
        # get base path.
        base_path = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

        # Initial setup, create credentials instance.
        credentials = Credentials.service_account_credentials_builder() \
            .from_file(base_path + "/pdfservices-api-credentials.json") \
            .build()

        # Create an ExecutionContext using credentials and create a new operation instance.
        execution_context = ExecutionContext.create(credentials)
        extract_pdf_operation = ExtractPDFOperation.create_new()

        # Set operation input from a source file.
        source = FileRef.create_from_local_file(base_path + "/resources/extractPdfInput.pdf")
        extract_pdf_operation.set_input(source)

        # Build ExtractPDF options and set them into the operation
        extract_pdf_options: ExtractPDFOptions = ExtractPDFOptions.builder() \
            .with_elements_to_extract([ExtractElementType.TEXT, ExtractElementType.TABLES]) \
            .with_elements_to_extract_renditions([ExtractRenditionsElementType.TABLES, ExtractRenditionsElementType.FIGURES]) \
            .build()
        extract_pdf_operation.set_options(extract_pdf_options)

        # Execute the operation.
        result: FileRef = extract_pdf_operation.execute(execution_context)

        # Save the result to the specified location.
        result.save_as(base_path + "/output/ExtractTextTableWithFigureTableRendition.zip")
    except (ServiceApiException, ServiceUsageException, SdkException):
        logging.exception("Exception encountered while executing operation")

     </pre>
    </div>
  <!--end tab data-->
  </div>


Extract Text and Tables and Character Bounding Boxes (w/ Renditions)
------------------------------------------------------------------------------

The sample below extracts table renditions and bounding boxes for characters present in text blocks(paragraphs, list, headings), in addition to text, table, and figure element information from PDF Document. Note that the output is a zip containing the structured information along with renditions.

.. raw:: html

  <div class="tabs">
	  <!--<button onclick="copyToClipboard('#tabsjava1')">This copy button works.</button>-->
      <ul>
        <li><a href="#tabsjava103">JAVA</a></li>
        <li><a href="#tabsnet103">.NET</a></li>
        <li><a href="#tabsnode103">NODE</a></li>
        <li><a href="#tabspython103">PYTHON</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-extractPDF">REST API</a></li>
      </ul>
      <div id="tabsjava103">
      <div class="cmdline"><strong>Run the sample:</strong><br />

  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.extractpdf.ExtractTextTableInfoWithCharBoundsFromPDF
  </div>

    <pre class="prettyprint">

  public class ExtractTextTableInfoWithCharBoundsFromPDF {

      private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(ExtractTextTableInfoWithCharBoundsFromPDF.class);

      public static void main(String[] args) {

          try {

              // Initial setup, create credentials instance.
              Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                      .fromFile("pdfservices-api-credentials.json")
                      .build();

              // Create an ExecutionContext using credentials.
              ExecutionContext executionContext = ExecutionContext.create(credentials);

              ExtractPDFOperation extractPDFOperation = ExtractPDFOperation.createNew();

              // Provide an input FileRef for the operation
              FileRef source = FileRef.createFromLocalFile("src/main/resources/extractPdfInput.pdf");
              extractPDFOperation.setInputFile(source);

              // Build ExtractPDF options and set them into the operation
              ExtractPDFOptions extractPDFOptions = ExtractPDFOptions.extractPdfOptionsBuilder()
                      .addElementsToExtract(Arrays.asList(ExtractElementType.TEXT, ExtractElementType.TABLES))
                      .addCharInfo(true)
                      .build();
              extractPDFOperation.setOptions(extractPDFOptions);

              // Execute the operation
              FileRef result = extractPDFOperation.execute(executionContext);

              // Save the result at the specified location
              result.saveAs("output/ExtractTextTableInfoWithCharBoundsFromPDF.zip");

          } catch (ServiceApiException | IOException | SdkException | ServiceUsageException e) {
              LOGGER.error("Exception encountered while executing operation", e);
          }
      }
  }
    </pre>
  </div>
  <div id="tabsnet103">
  <div class="cmdline"><strong>Run the sample:</strong><br />
    cd ExtractTextTableInfoWithCharBoundsFromPDF/<br />
    dotnet run ExtractTextTableInfoWithCharBoundsFromPDF.csproj </div>
  <pre class="prettyprint">

  namespace ExtractTextTableInfoWithCharBoundsFromPDF
  {
      class Program
      {
          private static readonly ILog log = LogManager.GetLogger(typeof(Program));
          static void Main()
          {
              //Configure the logging
              ConfigureLogging();
              try
              {
                  // Initial setup, create credentials instance.
                  Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                  .Build();

                  //Create an ExecutionContext using credentials and create a new operation instance.
                  ExecutionContext executionContext = ExecutionContext.Create(credentials);
                  ExtractPDFOperation extractPdfOperation = ExtractPDFOperation.CreateNew();

                  // Set operation input from a source file.
                  FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"extractPdfInput.pdf");
                  extractPdfOperation.SetInputFile(sourceFileRef);

                  // Build ExtractPDF options and set them into the operation
                  ExtractPDFOptions extractPdfOptions = ExtractPDFOptions.ExtractPdfOptionsBuilder()
                      .AddElementsToExtract(new List&lt;ExtractElementType&gt;(new []{ ExtractElementType.TEXT, ExtractElementType.TABLES}))
                      .AddAddCharInfo(true)
                      .build();
                  extractPdfOperation.SetOptions(extractPdfOptions);

                  // Execute the operation.
                  FileRef result = extractPdfOperation.Execute(executionContext);

                  // Save the result to the specified location.
                  result.SaveAs(Directory.GetCurrentDirectory() + "/output/ExtractTextTableInfoWithCharBoundsFromPDF.zip");
              }
              catch (ServiceUsageException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (ServiceApiException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (SDKException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (IOException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (Exception ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
          }

          static void ConfigureLogging()
          {
              ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
              XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
          }
      }
  }

  </pre>
  </div>
     <div id="tabsnode103">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    node src/extractpdf/extract-text-table-info-with-char-bounds-from-pdf.js
     </div>
    <pre class="prettyprint">
    const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');
    try {
        // Initial setup, create credentials instance.
        const credentials =  PDFServicesSdk.Credentials
            .serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        // Create an ExecutionContext using credentials
        const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

        // Build extractPDF options
        const options = new PDFServicesSdk.ExtractPDF.options.ExtractPdfOptions.Builder()
            .addElementsToExtract(PDFServicesSdk.ExtractPDF.options.ExtractElementType.TEXT, PDFServicesSdk.ExtractPDF.options.ExtractElementType.TABLES)
            .addCharInfo(true)
            .build()

        // Create a new operation instance.
        const extractPDFOperation = PDFServicesSdk.ExtractPDF.Operation.createNew(),
            input = PDFServicesSdk.FileRef.createFromLocalFile(
                'resources/extractPDFInput.pdf',
                PDFServicesSdk.ExtractPDF.SupportedSourceFormat.pdf
            );

        // Set operation input from a source file.
        extractPDFOperation.setInput(input);

        // Set options
        extractPDFOperation.setOptions(options);

        extractPDFOperation.execute(executionContext)
            .then(result => result.saveAsFile('output/ExtractTextTableInfoWithCharBoundsFromPDF.zip'))
            .catch(err => {
                if(err instanceof PDFServicesSdk.Error.ServiceApiError
                    || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                    console.log('Exception encountered while executing operation', err);
                } else {
                    console.log('Exception encountered while executing operation', err);
                }
            });
    } catch (err) {
        console.log('Exception encountered while executing operation', err);
    }
     </pre>
    </div>
  <div id="tabspython103">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    python src/extractpdf/extract_txt_table_info_with_char_bounds_from_pdf.py
     </div>
    <pre class="prettyprint">
    logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))

    try:
        # get base path.
        base_path = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

        # Initial setup, create credentials instance.
        credentials = Credentials.service_account_credentials_builder()\
            .from_file(base_path + "/pdfservices-api-credentials.json") \
            .build()

        #Create an ExecutionContext using credentials and create a new operation instance.
        execution_context = ExecutionContext.create(credentials)
        extract_pdf_operation = ExtractPDFOperation.create_new()

        #Set operation input from a source file.
        source = FileRef.create_from_local_file(base_path + "/resources/extractPdfInput.pdf")
        extract_pdf_operation.set_input(source)

        # Build ExtractPDF options and set them into the operation
        extract_pdf_options: ExtractPDFOptions = ExtractPDFOptions.builder() \
            .with_element_to_extract(ExtractElementType.TEXT) \
            .with_get_char_info(True) \
            .build()
        extract_pdf_operation.set_options(extract_pdf_options)

        #Execute the operation.
        result: FileRef = extract_pdf_operation.execute(execution_context)

        # Save the result to the specified location.
        result.save_as(base_path + "/output/ExtractTextInfoWithCharBoundsFromPDF.zip")
    except (ServiceApiException, ServiceUsageException, SdkException):
        logging.exception("Exception encountered while executing operation")

     </pre>
    </div>
  <!--end tab data-->
  </div>


Extract Text and Tables and Table Structure as CSV (w/ Renditions)
------------------------------------------------------------------------------

The sample below adds option to get CSV output for tables in addition to extracting text, table, and figure element information as well as table renditions from PDF Document. Note that the output is a zip containing the structured information along with renditions.

.. raw:: html

  <div class="tabs">
	  <!--<button onclick="copyToClipboard('#tabsjava1')">This copy button works.</button>-->
      <ul>
        <li><a href="#tabsjava104">JAVA</a></li>
        <li><a href="#tabsnet104">.NET</a></li>
        <li><a href="#tabsnode104">NODE</a></li>
        <li><a href="#tabspython104">PYTHON</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-extractPDF">REST API</a></li>
      </ul>
      <div id="tabsjava104">
      <div class="cmdline"><strong>Run the sample:</strong><br />

  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.extractpdf.ExtractTextTableInfoWithTableStructureFromPdf
  </div>

    <pre class="prettyprint">

  public class ExtractTextTableInfoWithTableStructureFromPdf {

      private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(ExtractTextTableInfoWithTableStructureFromPdf.class);

      public static void main(String[] args) {

          try {

              // Initial setup, create credentials instance.
              Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                      .fromFile("pdfservices-api-credentials.json")
                      .build();

              // Create an ExecutionContext using credentials.
              ExecutionContext executionContext = ExecutionContext.create(credentials);

              ExtractPDFOperation extractPDFOperation = ExtractPDFOperation.createNew();

              // Provide an input FileRef for the operation
              FileRef source = FileRef.createFromLocalFile("src/main/resources/extractPdfInput.pdf");
              extractPDFOperation.setInputFile(source);

              // Build ExtractPDF options and set them into the operation
              ExtractPDFOptions extractPDFOptions = ExtractPDFOptions.extractPdfOptionsBuilder()
                      .addElementsToExtract(Arrays.asList(ExtractElementType.TEXT, ExtractElementType.TABLES))
                      .addElementToExtractRenditions(ExtractRenditionsElementType.TABLES)
                      .addTableStructureFormat(TableStructureType.CSV)
                      .build();
              extractPDFOperation.setOptions(extractPDFOptions);

              // Execute the operation
              FileRef result = extractPDFOperation.execute(executionContext);

              // Save the result at the specified location
              result.saveAs("output/ExtractTextTableInfoWithTableStructureFromPdf.zip");

          } catch (ServiceApiException | IOException | SdkException | ServiceUsageException e) {
              LOGGER.error("Exception encountered while executing operation", e);
          }
      }
  }
    </pre>
  </div>
  <div id="tabsnet104">
  <div class="cmdline"><strong>Run the sample:</strong><br />
    cd ExtractTextTableInfoWithTableStructureFromPDF/<br />
    dotnet run ExtractTextTableInfoWithTableStructureFromPDF.csproj </div>
  <pre class="prettyprint">

  namespace ExtractTextTableInfoWithTableStructureFromPDF
  {
      class Program
      {
          private static readonly ILog log = LogManager.GetLogger(typeof(Program));
          static void Main()
          {
              //Configure the logging
              ConfigureLogging();
              try
              {
                  // Initial setup, create credentials instance.
                  Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                  .Build();

                  //Create an ExecutionContext using credentials and create a new operation instance.
                  ExecutionContext executionContext = ExecutionContext.Create(credentials);
                  ExtractPDFOperation extractPdfOperation = ExtractPDFOperation.CreateNew();

                  // Set operation input from a source file.
                  FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"extractPdfInput.pdf");
                  extractPdfOperation.SetInputFile(sourceFileRef);

                  // Build ExtractPDF options and set them into the operation
                  ExtractPDFOptions extractPdfOptions = ExtractPDFOptions.ExtractPdfOptionsBuilder()
                      .AddElementsToExtract(new List&lt;ExtractElementType&gt;(new []{ ExtractElementType.TEXT, ExtractElementType.TABLES}))
                      .AddElementsToExtractRenditions(new List&lt;ExtractRenditionsElementType&gt;(new [] {ExtractRenditionsElementType.TABLES}))
                      .AddTableStructureFormat(TableStructureType.CSV)
                      .build();

                  extractPdfOperation.SetOptions(extractPdfOptions);

                  // Execute the operation.
                  FileRef result = extractPdfOperation.Execute(executionContext);

                  // Save the result to the specified location.
                  result.SaveAs(Directory.GetCurrentDirectory() + "/output/ExtractTextTableInfoWithTableStructureFromPDF.zip");
              }
              catch (ServiceUsageException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (ServiceApiException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (SDKException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (IOException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (Exception ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
          }

          static void ConfigureLogging()
          {
              ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
              XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
          }
      }
  }

  </pre>
  </div>
     <div id="tabsnode104">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    node src/extractpdf/extract-text-table-info-with-tables-renditions-from-pdf.js
     </div>
    <pre class="prettyprint">
    const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');
    try {
        // Initial setup, create credentials instance.
        const credentials =  PDFServicesSdk.Credentials
            .serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        // Create an ExecutionContext using credentials
        const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

        // Build extractPDF options
        const options = new PDFServicesSdk.ExtractPDF.options.ExtractPdfOptions.Builder()
            .addElementsToExtract(PDFServicesSdk.ExtractPDF.options.ExtractElementType.TEXT, PDFServicesSdk.ExtractPDF.options.ExtractElementType.TABLES)
            .addElementsToExtractRenditions(PDFServicesSdk.ExtractPDF.options.ExtractRenditionsElementType.TABLES)
            .addTableStructureFormat(PDFServicesSdk.ExtractPDF.options.TableStructureType.CSV)
            .build()

        // Create a new operation instance.
        const extractPDFOperation = PDFServicesSdk.ExtractPDF.Operation.createNew(),
            input = PDFServicesSdk.FileRef.createFromLocalFile(
                'resources/extractPDFInput.pdf',
                PDFServicesSdk.ExtractPDF.SupportedSourceFormat.pdf
            );

        // Set operation input from a source file.
        extractPDFOperation.setInput(input);

        // Set options
        extractPDFOperation.setOptions(options);

        extractPDFOperation.execute(executionContext)
            .then(result => result.saveAsFile('output/ExtractTextTableWithTableStructure.zip'))
            .catch(err => {
                if(err instanceof PDFServicesSdk.Error.ServiceApiError
                    || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                    console.log('Exception encountered while executing operation', err);
                } else {
                    console.log('Exception encountered while executing operation', err);
                }
            });
    } catch (err) {
        console.log('Exception encountered while executing operation', err);
    }
     </pre>
    </div>
  <div id="tabspython104">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    python src/extractpdf/extract_txt_table_info_with_table_structure_from_pdf.py
     </div>
    <pre class="prettyprint">
    logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))

    try:
        # get base path.
        base_path = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

        # Initial setup, create credentials instance.
        credentials = Credentials.service_account_credentials_builder() \
            .from_file(base_path + "/pdfservices-api-credentials.json") \
            .build()

        # Create an ExecutionContext using credentials and create a new operation instance.
        execution_context = ExecutionContext.create(credentials)
        extract_pdf_operation = ExtractPDFOperation.create_new()

        # Set operation input from a source file.
        source = FileRef.create_from_local_file(base_path + "/resources/extractPdfInput.pdf")
        extract_pdf_operation.set_input(source)

        # Build ExtractPDF options and set them into the operation
        extract_pdf_options: ExtractPDFOptions = ExtractPDFOptions.builder() \
            .with_elements_to_extract([ExtractElementType.TEXT, ExtractElementType.TABLES]) \
            .with_element_to_extract_renditions(ExtractRenditionsElementType.TABLES) \
            .with_table_structure_format(TableStructureType.CSV) \
            .build()
        extract_pdf_operation.set_options(extract_pdf_options)

        # Execute the operation.
        result: FileRef = extract_pdf_operation.execute(execution_context)

        # Save the result to the specified location.
        result.save_as(base_path + "/output/ExtractTextTableWithTableStructure.zip")
    except (ServiceApiException, ServiceUsageException, SdkException):
        logging.exception("Exception encountered while executing operation")

     </pre>
    </div>
  <!--end tab data-->
  </div>


(Beta Feature) Extract Text and Tables and Styling Info
------------------------------------------------------------------------------

Note: This option is experimental which means that the output may change without notice. It is provided for evaluation and feedback purposes only. Use of this option is not supported under the `Document Cloud Services versioning policy <https://opensource.adobe.com/pdftools-sdk-docs/release/latest/policies.html#>`_

The sample below adds option to get styling information of each element( Bold / Italics / Superscript etc) in addition to extracting text, table, and figure element information as well as table renditions from PDF Document. Note that the output is a zip containing the structured information along with renditions.
Please see the `Styling JSON schema <../../release/shared/extractJSONOutputSchemaStylingInfo.json>`_ for reference.

.. raw:: html

  <div class="tabs">
	  <!--<button onclick="copyToClipboard('#tabsjava1')">This copy button works.</button>-->
      <ul>
        <li><a href="#tabsjava105">JAVA</a></li>
        <li><a href="#tabsnet105">.NET</a></li>
        <li><a href="#tabsnode105">NODE</a></li>
        <li><a href="#tabspython105">PYTHON</a></li>
        <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-extractPDF">REST API</a></li>
      </ul>
      <div id="tabsjava105">
      <div class="cmdline"><strong>Run the sample:</strong><br />

  mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.extractpdf.ExtractTextTableWithStylingInfoFromPdf
  </div>

    <pre class="prettyprint">

  public class ExtractTextTableInfoWithStylingFromPDF {

      private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(ExtractTextTableInfoWithStylingFromPDF.class);

      public static void main(String[] args) {

          try {

              // Initial setup, create credentials instance.
              Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
                      .fromFile("pdfservices-api-credentials.json")
                      .build();

              // Create an ExecutionContext using credentials.
              ExecutionContext executionContext = ExecutionContext.create(credentials);

              ExtractPDFOperation extractPDFOperation = ExtractPDFOperation.createNew();

              // Provide an input FileRef for the operation
              FileRef source = FileRef.createFromLocalFile("src/main/resources/extractPdfInput.pdf");
              extractPDFOperation.setInputFile(source);

              // Build ExtractPDF options and set them into the operation
              ExtractPDFOptions extractPDFOptions = ExtractPDFOptions.extractPdfOptionsBuilder()
                      .addElementsToExtract(Arrays.asList(ExtractElementType.TEXT, ExtractElementType.TABLES))
                      .addGetStylingInfo(true)
                      .build();
              extractPDFOperation.setOptions(extractPDFOptions);

              // Execute the operation
              FileRef result = extractPDFOperation.execute(executionContext);

              // Save the result at the specified location
              result.saveAs("output/ExtractTextTableInfoWithStylingFromPDF.zip");

          } catch (ServiceApiException | IOException | SdkException | ServiceUsageException e) {
              LOGGER.error("Exception encountered while executing operation", e);
          }
      }
  }
    </pre>
  </div>
  <div id="tabsnet105">
  <div class="cmdline"><strong>Run the sample:</strong><br />
    cd ExtractTextTableInfoWithStylingFromPDF/<br />
    dotnet run ExtractTextTableInfoWithStylingFromPDF.csproj </div>
  <pre class="prettyprint">

  namespace ExtractTextTableInfoWithStylingFromPDF
  {
      class Program
      {
          private static readonly ILog log = LogManager.GetLogger(typeof(Program));
          static void Main()
          {
              //Configure the logging
              ConfigureLogging();
              try
              {
                  // Initial setup, create credentials instance.
                  Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                                  .Build();

                  //Create an ExecutionContext using credentials and create a new operation instance.
                  ExecutionContext executionContext = ExecutionContext.Create(credentials);
                  ExtractPDFOperation extractPdfOperation = ExtractPDFOperation.CreateNew();

                  // Set operation input from a source file.
                  FileRef sourceFileRef = FileRef.CreateFromLocalFile(@"extractPdfInput.pdf");
                  extractPdfOperation.SetInputFile(sourceFileRef);

                  // Build ExtractPDF options and set them into the operation
                  ExtractPDFOptions extractPdfOptions = ExtractPDFOptions.ExtractPdfOptionsBuilder()
                          .AddElementsToExtract(new List&lt;ExtractElementType&gt;(new []{ ExtractElementType.TEXT, ExtractElementType.TABLES}))
                          .AddGetStylingInfo(true)
                          .build();

                  extractPdfOperation.SetOptions(extractPdfOptions);


                  // Execute the operation.
                  FileRef result = extractPdfOperation.Execute(executionContext);

                  // Save the result to the specified location.
                  result.SaveAs(Directory.GetCurrentDirectory() + "/output/ExtractTextTableInfoWithStylingFromPDF.zip");
              }
              catch (ServiceUsageException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (ServiceApiException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (SDKException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (IOException ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
              catch (Exception ex)
              {
                  log.Error("Exception encountered while executing operation", ex);
              }
          }

          static void ConfigureLogging()
          {
              ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
              XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
          }
      }
  }
  </pre>
  </div>
     <div id="tabsnode105">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    node src/extractpdf/extract-text-table-with-styling-info-from-pdf.js
     </div>
    <pre class="prettyprint">
    const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');
    try {
        // Initial setup, create credentials instance.
        const credentials =  PDFServicesSdk.Credentials
            .serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        // Create an ExecutionContext using credentials
        const executionContext = PDFServicesSdk.ExecutionContext.create(credentials);

        // Build extractPDF options
        const options = new PDFServicesSdk.ExtractPDF.options.ExtractPdfOptions.Builder()
            .addElementsToExtract(PDFServicesSdk.ExtractPDF.options.ExtractElementType.TEXT, PDFServicesSdk.ExtractPDF.options.ExtractElementType.TABLES)
            .getStylingInfo(true)
            .build()

        // Create a new operation instance.
        const extractPDFOperation = PDFServicesSdk.ExtractPDF.Operation.createNew(),
            input = PDFServicesSdk.FileRef.createFromLocalFile(
                'resources/extractPDFInput.pdf',
                PDFServicesSdk.ExtractPDF.SupportedSourceFormat.pdf
            );

        // Set operation input from a source file.
        extractPDFOperation.setInput(input);

        // Set options
        extractPDFOperation.setOptions(options);

        extractPDFOperation.execute(executionContext)
            .then(result => result.saveAsFile('output/ExtractTextTableInfoWithStylingInfoFromPDF.zip'))
            .catch(err => {
                if(err instanceof PDFServicesSdk.Error.ServiceApiError
                    || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                    console.log('Exception encountered while executing operation', err);
                } else {
                    console.log('Exception encountered while executing operation', err);
                }
            });
    } catch (err) {
        console.log('Exception encountered while executing operation', err);
    }
     </pre>
    </div>

  <div id="tabspython105">
    <div class="cmdline"><strong>Run the sample:</strong><br />
    python src/extractpdf/extract_txt_table_with_styling_info_from_pdf.py
     </div>
    <pre class="prettyprint">
    logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))

    try:
        # get base path.
        base_path = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

        # Initial setup, create credentials instance.
        credentials = Credentials.service_account_credentials_builder()\
            .from_file(base_path + "/pdfservices-api-credentials.json") \
            .build()

        #Create an ExecutionContext using credentials and create a new operation instance.
        execution_context = ExecutionContext.create(credentials)
        extract_pdf_operation = ExtractPDFOperation.create_new()

        #Set operation input from a source file.
        source = FileRef.create_from_local_file(base_path + "/resources/extractPdfInput.pdf")
        extract_pdf_operation.set_input(source)

        # Build ExtractPDF options and set them into the operation
        extract_pdf_options: ExtractPDFOptions = ExtractPDFOptions.builder() \
            .with_element_to_extract(ExtractElementType.TEXT) \
            .with_include_styling_info(True) \
            .build()
        extract_pdf_operation.set_options(extract_pdf_options)

        #Execute the operation.
        result: FileRef = extract_pdf_operation.execute(execution_context)

        # Save the result to the specified location.
        result.save_as(base_path + "/output/ExtractTextInfoWithStylingInfoFromPDF.zip")
    except (ServiceApiException, ServiceUsageException, SdkException):
        logging.exception("Exception encountered while executing operation")

     </pre>
    </div>
  <!--end tab data-->
  </div>

Fetch PDF Properties
====================


Fetch PDF Properties as a JSON File
------------------------------------

The sample below fetches the properties of an input PDF, as a JSON file.

.. raw:: html

 <div class="tabs">
   <ul>
      <li><a href="#tabsjava1007">JAVA</a></li>
      <li><a href="#tabsnet1007">.NET</a></li>
      <li><a href="#tabsnode1007">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-pdfProperties" target="_blank">REST API</a></li>
   </ul>
   <div id="tabsjava1007">
 <div class="cmdline"><strong>Run the sample:</strong> mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.pdfproperties.PDFPropertiesAsFile</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class PDFPropertiesAsFile {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(PDFPropertiesAsFile.class);

    public static void main(String[] args) {

      try {

        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        PDFPropertiesOperation pdfPropertiesOperation = PDFPropertiesOperation.createNew();

        // Provide an input FileRef for the operation
        FileRef source = FileRef.createFromLocalFile("src/main/resources/pdfPropertiesInput.pdf");
        pdfPropertiesOperation.setInputFile(source);

        // Execute the operation
        FileRef result = pdfPropertiesOperation.executeAndReturnFileRef(executionContext);

        // Save the result at the specified location
        result.saveAs("output/pdfPropertiesOutput.json");

      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }
  }
   </pre>
   </div>
   <div id="tabsnet1007">
  <div class="cmdline"><strong>Run the sample:</strong>
  cd PDFPropertiesAsFile/<br/>
  dotnet run PDFPropertiesAsFile.csproj
		</div>
      <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace PDFPropertiesAsFile
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          PDFPropertiesOperation pdfPropertiesOperation = PDFPropertiesOperation.CreateNew();

          // Provide an input FileRef for the operation
          FileRef source = FileRef.CreateFromLocalFile(@"pdfPropertiesInput.pdf");
          pdfPropertiesOperation.SetInput(source);

          // Execute the operation.
          FileRef result = pdfPropertiesOperation.ExecuteAndReturnFileRef(executionContext);

          // Save the result to the specified location.
          result.SaveAs(Directory.GetCurrentDirectory() + "/output/pdfPropertiesOutput.json");

        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
   </pre>
   </div>
  <div id="tabsnode1007">
  <div class="cmdline"><strong>Run the sample:</strong>
  node src/pdfproperties/pdf-properties-as-file.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

	//Create an ExecutionContext using credentials and create a new operation instance.
	const clientContext = PDFServicesSdk.ExecutionContext.create(credentials),
        pdfPropertiesOperation = PDFServicesSdk.PDFProperties.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/pdfPropertiesInput.pdf');
    pdfPropertiesOperation.setInput(input);

    // Execute the operation and Save the result to the specified location.
    pdfPropertiesOperation.executeAndReturnFileRef(clientContext)
        .then(result => result.saveAsFile('output/PDFPropertiesOutput.json'))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

 </div>
  <!--end tab data-->
  </div>

Fetch PDF Properties as a JSON Object
------------------------------------

The sample below fetches the properties of an input PDF, as a JSON object.

.. raw:: html

 <div class="tabs">
   <ul>
      <li><a href="#tabsjava1008">JAVA</a></li>
      <li><a href="#tabsnet1008">.NET</a></li>
      <li><a href="#tabsnode1008">NODE</a></li>
      <li><a href="https://documentcloud.adobe.com/document-services/index.html#post-pdfProperties" target="_blank">REST API</a></li>
   </ul>
   <div id="tabsjava1008">
 <div class="cmdline"><strong>Run the sample:</strong> mvn -f pom.xml exec:java -Dexec.mainClass=com.adobe.pdfservices.operation.samples.pdfproperties.PDFPropertiesAsJSONObject</div>
 <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_java_samples

  public class PDFPropertiesAsJSONObject {

    // Initialize the logger.
    private static final Logger LOGGER = LoggerFactory.getLogger(PDFPropertiesAsJSONObject.class);

    public static void main(String[] args) {

      try {

        // Initial setup, create credentials instance.
        Credentials credentials = Credentials.serviceAccountCredentialsBuilder()
            .fromFile("pdfservices-api-credentials.json")
            .build();

        //Create an ExecutionContext using credentials and create a new operation instance.
        ExecutionContext executionContext = ExecutionContext.create(credentials);
        PDFPropertiesOperation pdfPropertiesOperation = PDFPropertiesOperation.createNew();

        // Provide an input FileRef for the operation
        FileRef source = FileRef.createFromLocalFile("src/main/resources/pdfPropertiesInput.pdf");
        pdfPropertiesOperation.setInputFile(source);

        // Build PDF Properties options to include page level properties and set them into the operation
        PDFPropertiesOptions pdfPropertiesOptions = PDFPropertiesOptions.PDFPropertiesOptionsBuilder()
              .includePageLevelProperties(true)
              .build();
        pdfPropertiesOperation.setOptions(pdfPropertiesOptions);

        // Execute the operation and return JSON Object
        JSONObject result = pdfPropertiesOperation.execute(executionContext);
        LOGGER.info("The resultant PDF Properties are: {}", result);

      } catch (ServiceApiException | IOException | SdkException | ServiceUsageException ex) {
        LOGGER.error("Exception encountered while executing operation", ex);
      }
    }
  }
   </pre>
   </div>
   <div id="tabsnet1008">
  <div class="cmdline"><strong>Run the sample:</strong>
  cd PDFPropertiesAsJSONObject/<br/>
  dotnet run PDFPropertiesAsJSONObject.csproj
		</div>
      <pre class="prettyprint">
 // Get the samples from https://www.adobe.com/go/pdftoolsapi_net_samples

  namespace PDFPropertiesAsJSONObject
  {
    class Program
    {
      private static readonly ILog log = LogManager.GetLogger(typeof(Program));
      static void Main()
      {
        //Configure the logging
        ConfigureLogging();
        try
        {
          // Initial setup, create credentials instance.
          Credentials credentials = Credentials.ServiceAccountCredentialsBuilder()
                  .FromFile(Directory.GetCurrentDirectory() + "/pdfservices-api-credentials.json")
                  .Build();

          //Create an ExecutionContext using credentials and create a new operation instance.
          ExecutionContext executionContext = ExecutionContext.Create(credentials);
          PDFPropertiesOperation pdfPropertiesOperation = PDFPropertiesOperation.CreateNew();

          // Provide an input FileRef for the operation
          FileRef source = FileRef.CreateFromLocalFile(@"pdfPropertiesInput.pdf");
          pdfPropertiesOperation.SetInput(source);

          // Build PDF Properties options to include page level properties and set them into the operation
          PDFPropertiesOptions pdfPropertiesOptions = PDFPropertiesOptions.PDFPropertiesOptionsBuilder()
                   .IncludePageLevelProperties(true)
                   .Build();
          pdfPropertiesOperation.SetOptions(pdfPropertiesOptions);

          // Execute the operation and return JSON Object
          JObject result = pdfPropertiesOperation.Execute(executionContext);
          Console.WriteLine("The resultant PDF Properties are: " + result.ToString());

        }
        catch (ServiceUsageException ex)
        {
          log.Error("Exception encountered while executing operation", ex);
        }
        // Catch more errors here. . .
      }

      static void ConfigureLogging()
      {
        ILoggerRepository logRepository = LogManager.GetRepository(Assembly.GetEntryAssembly());
        XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));
      }
    }
  }
   </pre>
   </div>
  <div id="tabsnode1008">
  <div class="cmdline"><strong>Run the sample:</strong>
  node src/pdfproperties/pdf-properties-as-json.js
  </div>
 <pre class="prettyprint">
 // Get the samples from http://www.adobe.com/go/pdftoolsapi_node_sample
  const PDFServicesSdk = require('@adobe/pdfservices-node-sdk');

  try {
    // Initial setup, create credentials instance.
    const credentials =  PDFServicesSdk.Credentials
        .serviceAccountCredentialsBuilder()
        .fromFile("pdfservices-api-credentials.json")
        .build();

    //Create an ExecutionContext using credentials and create a new operation instance.
    const executionContext = PDFServicesSdk.ExecutionContext.create(credentials),
         pdfPropertiesOperation = PDFServicesSdk.PDFProperties.Operation.createNew();

    // Set operation input from a source file.
    const input = PDFServicesSdk.FileRef.createFromLocalFile('resources/pdfPropertiesInput.pdf');
    pdfPropertiesOperation.setInput(input);

    // Provide any custom configuration options for the operation.
    const options = new PDFServicesSdk.PDFProperties.options.PDFPropertiesOptions.Builder()
        .includePageLevelProperties(true)
        .build();
    pdfPropertiesOperation.setOptions(options);

    // Execute the operation and log the JSON Object.
    pdfPropertiesOperation.execute(executionContext)
        .then(result => console.log("The resultant json object is : " + JSON.stringify(result)))
        .catch(err => {
            if(err instanceof PDFServicesSdk.Error.ServiceApiError
                || err instanceof PDFServicesSdk.Error.ServiceUsageError) {
                console.log('Exception encountered while executing operation', err);
            } else {
                console.log('Exception encountered while executing operation', err);
            }
        });
  } catch (err) {
    console.log('Exception encountered while executing operation', err);
  }
 </pre>

 </div>
  <!--end tab data-->
  </div>


.. toctree::
    :hidden:
