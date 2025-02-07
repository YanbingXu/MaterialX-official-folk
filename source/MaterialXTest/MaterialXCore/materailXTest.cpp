#include <MaterialXTest/External/Catch/catch.hpp>
#include <MaterialXCore/Document.h>
#include <MaterialXFormat/File.h>
#include <MaterialXFormat/XmlIo.h>
#include <iostream>

namespace mx = MaterialX;

TEST_CASE("CreateShader", "[shader]")
{
    try
    {
        // Create a new MaterialX document
        mx::DocumentPtr doc = mx::createDocument();

        // // Create a node graph
        // mx::NodeGraphPtr nodeGraph = doc->addNodeGraph("NG_diffuseAlbedo");

        // // Create a constant node for the diffuseAlbedo input
        // mx::NodePtr constantNode = nodeGraph->addNode("constant", "diffuseAlbedo", "color3");
        // constantNode->setInputValue("value", mx::Color3(1.0f, 0.0f, 0.0f), "color3");  // Red color

        // Create a shader node
        mx::NodePtr shaderNode = doc->addNode("standard_surface", "SR_diffuseAlbedo", "surfaceshader");
        shaderNode->addInput("base_color", "color3");
        shaderNode->setInputValue("base_color", mx::Color3(1.0f, 0.0f, 0.0f), "color3");  // Red color
        // Create a material node
        mx::NodePtr materialNode = doc->addMaterialNode("M_diffuseAlbedo", shaderNode);

        // Write the document to a file
        std::string outputFilename = "/Users/yanbing.xu/Desktop/output.mtlx";
        mx::writeToXmlFile(doc, outputFilename);
        REQUIRE(mx::FilePath(outputFilename).exists());
        std::cout << "File created successfully: " << outputFilename << std::endl;
    }
    catch (const std::exception& e)
    {
        std::cerr << "Exception occurred: " << e.what() << std::endl;
        REQUIRE(false); // Fail the test if an exception is thrown
    }
}