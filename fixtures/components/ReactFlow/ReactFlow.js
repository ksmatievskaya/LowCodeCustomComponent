import React, {useEffect, useState, useCallback} from 'https://cdn.skypack.dev/react';
import ReactDOM from 'https://cdn.skypack.dev/react-dom';
import { Button, Container } from 'https://cdn.skypack.dev/@material-ui/core';
import ReactFlow, {useNodesState, useEdgesState} from 'https://cdn.skypack.dev/react-flow-renderer';

const MyCustomComponent = ({data, updateData, runQuery}) => {
  const dataRules = data.rules;
  const dataPayments = data.payments;
  const dataEdges = data.settings;
  
  
  const initialRules = dataRules?.map((item, i) => {
  return (
     {
      id: `${i + 1}`,
      data: {label: item, role: 'rule'},
      position: {x: 100, y: i * 300}
    }
  )
})
  
const initialPayments =  dataPayments?.map((item, i) => {
  return(
    {
      id: `${ initialRules.length + i + 1}`,
      data: {label: item, role: 'payment'},
      position: {x: i * 200, y: 200}
    }
  )
})

	const initialNodes = initialPayments === undefined ? null : initialRules?.concat(initialPayments);
  
 const initialEdges = dataEdges?.map((item, i) => {
  const splitted = item.split('->');
  const sourceObj = initialNodes.filter(item => item.data.label === splitted[0]);
  const targetObj = initialNodes.filter(item => item.data.label === splitted[1]);
  
  return(
    {
      id: `e${sourceObj[0]?.id}-${targetObj[0]?.id}`,
      source: `${sourceObj[0]?.id}`,
      target: `${targetObj[0]?.id}`
    }
  )
})

   
  const [nodes, setNodes, onNodesChange] = useNodesState();
  const [edges, setEdges, onEdgesChange] = useEdgesState();
  
  const [nodeName, setNodeName] = useState("Нет данных");
  const [nodeBg, setNodeBg] = useState("#eee");
  
  useEffect(() => {
  	setNodes(initialNodes)
  }, [data])
  
   useEffect(() => {
  	setEdges(initialEdges)
  }, [data])
	
  
  
  useEffect(() => {
     setNodes((nds) =>
      nds?.map((node) => {
        if (initialNodes.length <= 1) {
          
          node.data = {
            ...node.data,
            label: nodeName
          };
        }

        return node;
      })
    );
  }, [nodeName, setNodes, data]);

  useEffect(() => {
   setNodes((nds) =>
      nds?.map((node) => {
        if (node.data.role === "rule") {
          
          node.style = { ...node.style, backgroundColor: nodeBg };
        }

        return node;
      })
    );
  }, [nodeBg, setNodes, data]);

  return (
    <div style={{ height: 800, marginTop: 50, marginLeft: 30 }}>
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        defaultzoom={1.5}
        minZoom={0.2}
        maxZoom={4}
        attributionPosition="bottom-left"
      ></ReactFlow>
    </div>
  );
};
const ConnectedComponent = Tooljet.connectComponent(MyCustomComponent);
ReactDOM.render(<ConnectedComponent />, document.body);