"""
    @author Jonas Freire (jonasfreireperson@gmail.com)

"""

"""
    * To found the colors 'tags':
        document->  meta;
                    settings;
                    scripts;
                    font-face-decls;
                    styles;
                    automatic-styles    ->  style;
                                            style;
                                            style;
                                            style;
                                            style;
                                            style;
                                            page-layout;
                                            page-layout;
                    master-styles;
                    body;
"""
# Imports
import xml.etree.ElementTree as ET


# Dictionary to namespaces of fods format xml
ns = { 'office'     :   "urn:oasis:names:tc:opendocument:xmlns:office:1.0",
        'style'     :   "urn:oasis:names:tc:opendocument:xmlns:style:1.0",
        'text'      :   "urn:oasis:names:tc:opendocument:xmlns:text:1.0",
        'table'     :   "urn:oasis:names:tc:opendocument:xmlns:table:1.0",
        'draw'      :   "urn:oasis:names:tc:opendocument:xmlns:drawing:1.0",
        'fo'        :   "urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0",
        'xlink'     :   "http://www.w3.org/1999/xlink",
        'dc'        :   "http://purl.org/dc/elements/1.1/",
        'meta'      :   "urn:oasis:names:tc:opendocument:xmlns:meta:1.0",
        'number'    :   "urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0",
        'presentation'  :   "urn:oasis:names:tc:opendocument:xmlns:presentation:1.0",
        'svg'           :   "urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0",
    }


# Setup variables
file_source = 'teste_1.fods'
file_destiny = 'data.bin'
width_of_matrix = 64
height_of_matrix = 64
size_of_structure = 5 * 4			# 5 words of 4 bytes
# reg_color = '$s0'					# Register where will contain the color
# reg_memory = '$s1'				# Register where will contain the memory position of first pixel
# initial_position = '0x10010000' 	# Initial position of screen

# Dictionary to standards IDs to nodes
IDs =   {   '#000000'   :   '0x0',	# Empty space
            '#ffffff'   :   '0x1',	# Pac dot
            '#ffffff'   :   '0x1',	# Especial
            '#ff0000'   :   '0x3',	# Fruit
            '#2d32b8'   :   '0x4'	# Wall
        }

# Load xml file
tree = ET.parse(file_source)
root = tree.getroot()


# Dictionary of background colors
colors = {}


# Discover the background colors
autom_styles = root.find('office:automatic-styles', ns)
for style in autom_styles.findall('style:style', ns):
    style_name = style.get('{urn:oasis:names:tc:opendocument:xmlns:style:1.0}name')
    cell_properties = style.find('style:table-cell-properties', ns)
    if(cell_properties == None):
        continue
    background_color = cell_properties.get('{urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0}background-color')
    if(background_color == None):
        continue
    # print('style_name =', style_name, 'background_color =', background_color)
    colors[style_name] = background_color




# Create the matrix with background colors
# Each element corresponds to one pixel
x = 0
y = 0
screen = [[0 for k in range(width_of_matrix)] for j in range(height_of_matrix)]
table = root.find('office:body', ns).find('office:spreadsheet', ns).find('table:table', ns)
for row in table.findall('table:table-row', ns):
    y = 0
    for cell in row.findall('table:table-cell', ns):
        if('{urn:oasis:names:tc:opendocument:xmlns:table:1.0}style-name' not in cell.attrib):   # If the table-cell doesn't have table:style-name attribute
            continue
        background_color = colors[cell.get('{urn:oasis:names:tc:opendocument:xmlns:table:1.0}style-name')]
        screen[x][y] = background_color
        y = y + 1
    x = x + 1
        # print('%.7s  ' % (background_color), end='')
    # print()

# Print matrix
#print('-' * 40)
#print("Print Matrix")
#print()
#for x in range(height_of_matrix):
    #for y in range(width_of_matrix):
        #print(" %s " % (screen[x][y]), end="")
    #print()

# Convert the matrix into graph
graph = []
for x in range(height_of_matrix):
    for y in range(width_of_matrix):

        # ID of node
        actual_pixel = IDs[screen[x][y]]    # Get the ID to save on node
        graph.append(actual_pixel)          # Store ID to node

        # UP neighbor set
        x_neighbor = x - 1
        y_neighbor = y
        if(x_neighbor >= 0): # If the up neighbor is under limits of screen
            # graph.append( hex((x_neighbor*width_of_matrix) + y_neighbor) * size_of_structure) )
            graph.append( hex(-width_of_matrix * size_of_structure) )
        else:
            graph.append( hex(0) )

        # RIGHT neighbor set
        x_neighbor = x
        y_neighbor = y + 1
        if(y_neighbor < width_of_matrix): # If the right neighbor is under limits of screen
            # graph.append( hex(((x_neighbor*width_of_matrix) + y_neighbor) * size_of_structure) )
            graph.append( hex(size_of_structure) )
        else:
            graph.append( hex(0) )

        # DOWN neighbor set
        x_neighbor = x + 1
        y_neighbor = y
        if(x_neighbor < height_of_matrix): # If the down neighbor is under limits of screen
            # graph.append( hex(((x_neighbor*width_of_matrix) + y_neighbor) * size_of_structure) )
            graph.append( hex(width_of_matrix * size_of_structure) )
        else:
            graph.append( hex(0) )

        # LEFT neighbor set
        x_neighbor = x
        y_neighbor = y - 1
        if(y_neighbor >= 0): # If the left neighbor is under limits of screen
            # graph.append( hex(((x_neighbor*width_of_matrix) + y_neighbor) * size_of_structure) )
            graph.append( hex(-size_of_structure) )
        else:
            graph.append( hex(0) )


print()
for k in range(int(len(graph) / 5)):
    print("%5s - %5s | %5s | %5s | %5s | %5s" % (hex(k*20), graph[k*5], graph[k*5 + 1], graph[k*5 + 2], graph[k*5 + 3], graph[k*5 + 4]))
print()

# Connect to file
file = open(file_destiny, 'w')

# Write preparation to file
file.write('.data\n\n')
file.write('graph:\n')
for k in range(int(len(graph) / 5)):
    file.write("%10s %10s %10s %10s %10s\n" % (graph[k*5], graph[k*5 + 1], graph[k*5 + 2], graph[k*5 + 3], graph[k*5 + 4]))


# # Write preparation to file
# file.write('.text:\n\n')
# file.write('li %s, %s\n\n\n' % (reg_memory, initial_position))

# # Write stage to file
# offset = 0
# background_color_last = None
# table = root.find('office:body', ns).find('office:spreadsheet', ns).find('table:table', ns)
# for row in table.findall('table:table-row', ns):
#     for cell in row.findall('table:table-cell', ns):
#         if('{urn:oasis:names:tc:opendocument:xmlns:table:1.0}style-name' not in cell.attrib):   # If the table-cell doesn't have table:style-name attribute
#             continue
#         background_color = colors[cell.get('{urn:oasis:names:tc:opendocument:xmlns:table:1.0}style-name')]
#         background_color = '0x' + background_color[1:]     # Remove the '#' and add '0x'
#         # Load reg_color with the background_color number
#         if(background_color != background_color_last):
#             file.write('li %s, %s\n' % (reg_color, background_color))
#         # Store background_color number on your respective position
#         file.write('sw %s, %d(%s)\n' % (reg_color, offset, reg_memory))
#         # Set offset to next word
#         offset = offset + 4
#         if(offset >= 65532):
#             file.write('addi %s, %s, %s\n' % (reg_memory, reg_memory, hex(offset)))
#             offset = 0
#         # Store the last background_color
#         background_color_last = background_color
#         # print('%.7s  ' % (background_color), end='')
#     # print()



# Close file
file.close()


















# TODO remove this
