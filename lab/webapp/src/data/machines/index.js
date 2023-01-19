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
import { combineReducers } from 'redux';
import {
  FETCH_MACHINES_REQUEST,
  FETCH_MACHINES_SUCCESS,
  FETCH_MACHINES_FAILURE,
  FETCH_ENV_VARS_REQUEST,
  FETCH_ENV_VARS_SUCCESS,
  FETCH_ENV_VARS_FAILURE
} from './actions';

const list = (state = [], action) => {
	switch(action.type) {
		case FETCH_MACHINES_SUCCESS:
			return action.payload;
		default:
			return state;
	}
};

const envVarStuff = (state = [], action) => {
	switch(action.type) {
		case FETCH_ENV_VARS_SUCCESS:
			return action.payload;
		default:
			return state;
	}
};

const isFetching = (state = false, action) => {
  switch(action.type) {
    case FETCH_MACHINES_REQUEST:
      return true;
    case FETCH_MACHINES_SUCCESS:
    case FETCH_MACHINES_FAILURE:
      return false;
    default:
      return state;
  }
};

const isEnvVarFetching = (state = false, action) => {
  switch(action.type) {
    case FETCH_ENV_VARS_REQUEST:
      return true;
    case FETCH_ENV_VARS_SUCCESS:
    case FETCH_ENV_VARS_FAILURE:
      return false;
    default:
      return state;
  }
};

const error = (state = null, action) => {
  switch(action.type) {
    case FETCH_MACHINES_FAILURE:
      return action.payload;
    case FETCH_ENV_VARS_FAILURE:
      return action.payload;
    default:
      return state;
  }
};

const machines = combineReducers({
  list,
  envVarStuff,
  isFetching,
  isEnvVarFetching,
  error
});

export default machines;
