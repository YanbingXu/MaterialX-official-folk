import MaterialX as mx

def create_mdx_file(output_filename):
    # Create a new MaterialX document
    doc = mx.createDocument()

    # Create a node graph
    nodeGraph = doc.addNodeGraph('NG_diffuseAlbedo')

    # Create an image node for the diffuseAlbedo input
    # imageNode = nodeGraph.addNode('image', 'diffuseAlbedo', 'color3')
    # imageNode.setInputValue('file', 'path/to/your/albedo_texture.png', 'filename')

    # Create a constant node for the diffuseAlbedo input
    # constantNode = nodeGraph.addNode('constant', 'diffuseAlbedo', 'color3')
    # constantNode.setInputValue('value', mx.Color3(1.0, 0.0, 0.0), 'color3')  # Red color


    # Create a shader node
    shaderNode = doc.addNode('standard_surface', 'SR_diffuseAlbedo', 'surfaceshader')
    # shaderNode.addInput('base_color', 'color3').setConnectedNode(imageNode)
    shaderNode.addInput('base_color', 'color3').setValue(mx.Color3(1.0, 0.0, 0.0))

    # Create a material node
    materialNode = doc.addMaterialNode('M_diffuseAlbedo', shaderNode)

    # Write the document to a file
    mx.writeToXmlFile(doc, output_filename)
    print(f'Wrote MaterialX document to disk: {output_filename}')

if __name__ == '__main__':
    create_mdx_file('output.mtlx')