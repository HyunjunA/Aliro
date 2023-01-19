/* ~This file is part of the Aliro library~

Copyright (C) 2023 Epistasis Lab, 
Center for Artificial Intelligence Research and Education (CAIRE),
Department of Computational Biomedicine (CBM),
Cedars-Sinai Medical Center.

Aliro is maintained by:
    - Hyunjun Choi (hyunjun.choi@cshs.org)
    - Miguel Hernandez (miguel.e.hernandez@cshs.org)
    - Nick Matsumoto (nicholas.matsumoto@cshs.org)
    - Jay Moran (jay.moran@cshs.org)
    - and many other generous open source contributors

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

(Autogenerated header, do not modify)

*/
import React from 'react';
import { Modal } from 'semantic-ui-react';

const DatasetModal = ({ project, handleClose }) => {
  if(!project) { return null; }
  // use inline styling because I can't figure out css
  return (
    <Modal basic style={{ marginTop:'0' }} open={project ? true : false} onClose={handleClose} closeIcon>
      <Modal.Header>Info for dataset: {project.name}</Modal.Header>
      <Modal.Content>
        <pre>{JSON.stringify(project.schema, null, 2)}</pre>
      </Modal.Content>
    </Modal>
  );
};

export default DatasetModal;
