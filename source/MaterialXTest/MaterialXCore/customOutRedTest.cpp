//
// Created by edithXu on 2025/1/15.
//
#include <MaterialXTest/External/Catch/catch.hpp>
#include <MaterialXCore/Document.h>
#include <MaterialXFormat/File.h>
#include <MaterialXFormat/XmlIo.h>
#include <iostream>

namespace mx = MaterialX;

TEST_CASE("CreateShaderWithRedColor", "[shader]")
{
    try
    {
        // Create a new MaterialX document
        mx::DocumentPtr doc = mx::createDocument();

        // Create a node graph with a constant color output
        mx::NodeGraphPtr nodeGraph = doc->addNodeGraph("NG_diffuseAlbedo");
        mx::NodePtr constant = nodeGraph->addNode("constant");
        constant->setInputValue("value", mx::Color3(0.5f));
        mx::OutputPtr output = nodeGraph->addOutput();
        output->setConnectedNode(constant);
        REQUIRE(output->isColorType());
        REQUIRE(doc->validate());

        // Create a simple shader interface
        mx::NodeDefPtr simpleSrf = doc->addNodeDef("", mx::SURFACE_SHADER_TYPE_STRING, "simpleSrf");
        simpleSrf->setInputValue("diffColor", mx::Color3(1.0f));
        simpleSrf->setInputValue("specColor", mx::Color3(0.0f));
        mx::InputPtr roughness = simpleSrf->setInputValue("roughness", 0.25f);
        REQUIRE(!roughness->getIsUniform());
        roughness->setIsUniform(true);
        REQUIRE(roughness->getIsUniform());

        // Instantiate shader and material nodes
        mx::NodePtr shaderNode = doc->addNodeInstance(simpleSrf);
        mx::NodePtr materialNode = doc->addMaterialNode("", shaderNode);
        REQUIRE(materialNode->getUpstreamElement() == shaderNode);

        // Bind the diffuse color input to  the constant color output
        shaderNode->setConnectedOutput("diffColor", output);
        REQUIRE(shaderNode->getUpstreamElement() == constant);

        // Bind the rougheness input to a  value
        mx::InputPtr instanceRoughness = shaderNode->setInputValue("roughness", 0.5f);
        REQUIRE(instanceRoughness->getValue()->asA<float>() == 0.5f);
        REQUIRE(instanceRoughness->getDefaultValue()->asA<float>() == 0.25f);

        // validate the document
        REQUIRE(doc->validate());

        // Create a namespaced custom library
        // mx::DocumentPtr customLib = mx::createDocument();
        // customLib->setNamespace("custom");
        // mx::NodeGraphPtr customNodeGraph = customLib->addNodeGraph("customNG");
        // mx::NodeDefPtr customNodeDef = customLib->addNodeDef("ND_simpleSrf", "surfaceshader", "simpleSrf");
        // mx::ImplementationPtr customImpl = customLib->addImplementation("IM_custom");
        // customNodeGraph->addNodeInstance(customNodeDef, "custom1");
        // customImpl->setNodeDef(customNodeDef);
        // REQUIRE(customLib->validate());

        // Import the custom library
        // doc->importLibrary(customLib);
        // mx::NodeGraphPtr importedNodeGraph = doc->getNodeGraph("custom:customNG");
        // mx::NodeDefPtr importedNodeDef = doc->getNodeDef("custom:ND_simpleSrf");
        // mx::ImplementationPtr importedImpl = doc->getImplementation("custom:IM_custom");
        // mx::NodePtr importedNode = importedNodeGraph->getNode("custom1");
        // REQUIRE(importedNodeDef != nullptr);
        // REQUIRE(importedNode->getNodeDef() == importedNodeDef);
        // REQUIRE(importedImpl->getNodeDef() == importedNodeDef);

        // Write the document to a file
        std::string outputFilename = "/Users/yanbing.xu/Desktop/outputRed.mtlx";
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