![XCUISnippet_Deployer_small_logo](https://github.com/user-attachments/assets/0eb456e6-ecd1-459c-994f-15482485580f)

# XCUISnippetDeployer

## Overview

The `XCUISnippetDeployer` complements the `XCUIBuilder` tool by extending its functionality. It enhances the workflow by deploying code snippets to simplify and accelerate the development of additional tests after the initial framework deployment by `XCUIBuilder`.

The `XCUISnippetDeployer` is a command-line tool that simplifies the creation and deployment of Xcode code snippets. By leveraging this tool, developers can quickly deploy pre-defined sets of code snippets into Xcode's environment, improving productivity and ensuring consistent coding practices.

## Features

- Supports 2 snippet patterns (**Screen Transition Chaining**, **Self Chaining**).

- Automatically generates and deploys `.codesnippet` files to Xcode's designated folder.

- Uses Xcode-compliant Property List (plist) format for seamless integration.

- Ensures each snippet is assigned a unique identifier (UUID).

- Includes CLI-based interaction for user-friendly deployment.

- Provides well-defined and organized templates for common XCUITest patterns, tailored to align with the framework architecture for the chosen implementation pattern.

## Prerequisites

- macOS system with Xcode installed.

- Access to the ~/Library/Developer/Xcode/UserData/CodeSnippets/ directory.

## Installation

1. Clone the `XCUISnippetDeployer` repository or copy the source files into a local folder.

2. Ensure all source files are located within the following structure:

<img width="542" alt="Screenshot 2024-12-08 at 1 00 35 AM" src="https://github.com/user-attachments/assets/8bac190d-caee-4478-bde7-7769cf6b4ebb">

3. Build the tool using Xcode.

## Usage

### Running the Tool

1. Open Xcode and run the `XCUISnippetDeployer` project.

2. Follow the steps displayed in the Xcode console:

    - Select a pattern by entering the corresponding number.

    - Press Enter to confirm your selection.

### CLI Workflow

1. The tool will display available snippet patterns:
<img width="545" alt="Screenshot 2024-12-08 at 1 12 58 AM" src="https://github.com/user-attachments/assets/c18e6b08-900b-4865-bae7-c17f52e22772">

2. Enter the number corresponding to the desired snippet pattern.

3. The tool will deploy the snippets for the selected pattern into the Xcode `CodeSnippets` directory.

4. Restart Xcode to see the new snippets in the snippet manager (`Command + Shift + L`).

### Removing Deployed Snippets

To remove previously deployed snippets:

1. Navigate to the Xcode `CodeSnippets` directory:
<img width="554" alt="Screenshot 2024-12-08 at 1 15 24 AM" src="https://github.com/user-attachments/assets/1c629cd7-bb8a-4fa7-90c9-9d21496d70c1">

2. Identify and delete the `.codesnippet` files you wish to remove or remove them using the snippet manager in Xcode.

## Example Snippets

### Screen Transition Chaining

- **Title**: `Tap func`

- **Content**:
<img width="558" alt="Screenshot 2024-12-08 at 1 20 02 AM" src="https://github.com/user-attachments/assets/ca963b1f-7bb1-40f1-88d6-c0296b3b839d">

### Self Chaining

- **Title**: `Tap func`

- **Content**:
<img width="582" alt="Screenshot 2024-12-08 at 1 21 12 AM" src="https://github.com/user-attachments/assets/94f47e7a-2f3c-4f78-9c50-90b6a3aa5e2e">

## How It Works

### Directory and File Management

- Snippets are saved in the Xcode `CodeSnippets` directory:

<img width="554" alt="Screenshot 2024-12-08 at 1 15 24 AM" src="https://github.com/user-attachments/assets/1c629cd7-bb8a-4fa7-90c9-9d21496d70c1">

- Each snippet is saved as a `.codesnippet` file in plist format.

### File Format (Plist)

Each `.codesnippet` file is generated in plist format and includes the following keys:

- **IDECodeSnippetTitle**: The title of the snippet.

- **IDECodeSnippetSummary**: A brief description of the snippet.

- **IDECodeSnippetContents**: The code content of the snippet.

- **IDECodeSnippetLanguage**: The programming language (e.g., `Xcode.SourceCodeLanguage.Swift`).

- **IDECodeSnippetCompletionPrefix**: The shortcut prefix for triggering the snippet.

- **IDECodeSnippetCompletionScopes**: The applicable scopes (e.g., `CodeExpression`, `ClassImplementation`, or `All`).

- **IDECodeSnippetUserSnippet**: A boolean indicating if it's a user snippet.

- **IDECodeSnippetVersion**: The snippet version.

## Troubleshooting

### Snippets Not Appearing in Xcode

1. **Restart Xcode**: Ensure Xcode is restarted after deploying snippets.

2. **Check Snippet Path**: Verify the `.codesnippet` files are located in:

<img width="554" alt="Screenshot 2024-12-08 at 1 15 24 AM" src="https://github.com/user-attachments/assets/1c629cd7-bb8a-4fa7-90c9-9d21496d70c1">

3. **Validate File Format**: Ensure the files are in plist format with correct keys and values.

## Contributing

Contributions are welcome! If you have suggestions or want to add new snippet patterns, please submit a pull request or open an issue.

## License

This tool is licensed under the Apache License 2.0. See the `LICENSE` file for details.

