import React, { useState, useEffect } from "react";
import Paper from "@mui/material/Paper";
import axios from "axios";
import moment from "moment";
import { Link as RouterLink } from "react-router-dom";
import Iconify from "../components/Iconify";
import "./Modal.css";

import { url } from "../api";
// material
import {
  Card,
  Table,
  Stack,
  Button,
  TableRow,
  TableBody,
  TableCell,
  Container,
  Typography,
  TableContainer,
  TablePagination,
  TableHead,
  Alert,
  Collapse,
} from "@mui/material";
// components
import Page from "../components/Page";
import Scrollbar from "../components/Scrollbar";
import { Box } from "@mui/system";

export default function Merchant() {
  const [page, setPage] = useState(0);
  const [alertSignal, setAlert] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(5);
  const [rows, setRows] = useState([]);
  const [open, setOpen] = useState(true);
  const [modal, setModal] = useState(false);

  const [name, setName] = useState("");
  const [address, setAddress] = useState("");
  const [accountID, setAccountID] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    alert(`Success add merchant!`);
  };

  const toggleModal = () => {
    setModal(!modal);
  };

  if (modal) {
    document.body.classList.add("active-modal");
  } else {
    document.body.classList.remove("active-modal");
  }

  const getAllMerchant = async () => {
    axios
      .get(url + "/admin/merchant")
      .then((r) => {
        setRows(r.data.data);
      })
      .catch((e) => console.log(e));
  };

  const deleteMerchant = async (mid, merchantName) => {
    if (!mid) return;

    const conf = window.confirm(
      "apakah anda yakin ingin hapus merchant " + merchantName
    );
    if (conf) {
      axios
        .delete(url + `/admin/merchant/${mid}`)
        .then((r) => {
          if (r.status === 200) {
            window.alert("Merchant has been deleted");
            window.location.reload();
          } else {
            window.alert("ERROR: Merchant cannot be deleted");
          }
        })
        .catch((e) => window.alert("ERROR: Something went wrong"));
    }
  };

  const addMerchant = async (name, address, accountID) => {
    if (!(name && address && accountID)) {
      window.alert("Every fields needs to be filled!");
      return;
    }
    axios
      .post(url + "/admin/merchant/add", {
        name: name,
        address: address,
        accountID: parseInt(accountID),
      })
      .then((r) => {
        if (r.status === 200) {
          alert("New merchant has been added");
          window.location.reload();
        }
      })
      .catch((e) => {
        console.log(e);
        alert("ERROR: New merchant cannot be added");
      });
  };

  useEffect(async () => {
    await getAllMerchant();
  }, []);

  const handleChangePage = (event, newPage) => {
    console.log("npage", newPage);
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };
  const emptyRows =
    rowsPerPage - Math.min(rowsPerPage, rows.length - page * rowsPerPage);

  return (
    <Page title="Merchant | Cakrawala.id Admin">
      <Container>
        <Stack
          direction="row"
          alignItems="center"
          justifyContent="space-between"
          mb={5}
        >
          <Typography variant="h4" gutterBottom>
            Merchant
          </Typography>
        </Stack>

        <Card>
          <Scrollbar>
            <TableContainer component={Paper}>
              <Table aria-label="simple table">
                <TableHead>
                  <TableRow>
                    <TableCell align="center">Merchant ID</TableCell>
                    <TableCell align="center">Merchant Name</TableCell>
                    <TableCell align="center">Address</TableCell>
                    <TableCell align="center">Created Date</TableCell>
                    <TableCell align="center">Updated Date</TableCell>
                    <TableCell align="center">Action</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {rows.length <= 0 ? (
                    <TableCell colSpan={8} align="center">
                      There is no merchant
                    </TableCell>
                  ) : (
                    rows.map((row, index) => (
                      <TableRow key={row?.id}>
                        <TableCell align="center">{row?.id}</TableCell>
                        <TableCell align="center">{row?.Name}</TableCell>
                        <TableCell align="center">{row?.Address}</TableCell>
                        <TableCell align="center">
                          {moment(row?.createdAt).format(
                            "MMMM Do YYYY, HH:mm:ss"
                          )}
                        </TableCell>
                        <TableCell align="center">
                          {moment(row?.updatedAt).format(
                            "MMMM Do YYYY, HH:mm:ss"
                          )}
                        </TableCell>
                        <TableCell align="center">
                          <Button
                            variant="outlined"
                            style={{
                              borderColor: "#00A2ED",
                              color: "#00A2ED",
                            }}
                            onClick={() => {}}
                          >
                            Details
                          </Button>
                          <Button
                            variant="outlined"
                            style={{
                              borderColor: "#b50531",
                              color: "#b50531",
                            }}
                            onClick={() => {
                              deleteMerchant(row?.id, row?.Name);
                            }}
                          >
                            Delete
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))
                  )}
                  {emptyRows > 0 && (
                    <TableRow style={{ height: 53 * emptyRows }}>
                      <TableCell colSpan={6} />
                    </TableRow>
                  )}
                </TableBody>
              </Table>
              <TablePagination
                rowsPerPageOptions={[5, 10, 25]}
                component="div"
                count={rows.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onPageChange={handleChangePage}
                onRowsPerPageChange={handleChangeRowsPerPage}
              />
            </TableContainer>
          </Scrollbar>
        </Card>
        <br />
        <Button
          variant="contained"
          component={RouterLink}
          to="#"
          display="flex"
          alignItems="center"
          justifyContent="flex-end"
          startIcon={<Iconify icon="eva:plus-fill" />}
          onClick={toggleModal}
        >
          Add Merchant
        </Button>
        {modal && (
          <div className="modal">
            <div onClick={toggleModal} className="overlay"></div>
            <div className="modal-content">
              <form
                onSubmit={() => {
                  addMerchant(name, address, accountID);
                }}
              >
                <h1>Add Merchant</h1>
                <br />
                <label>
                  Enter merchant name:
                  <input
                    type="text"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                  />
                </label>
                <br />
                <br />
                <label>
                  Enter merchant address:
                  <input
                    type="text"
                    value={address}
                    onChange={(e) => setAddress(e.target.value)}
                  />
                </label>
                <br />
                <br />
                <label>
                  Enter merchant accound id:
                  <input
                    type="text"
                    value={accountID}
                    onChange={(e) => setAccountID(e.target.value)}
                  />
                </label>
                <br />
                <br />
                <input type="submit" />
                <button className="close-modal" onClick={toggleModal}>
                  X
                </button>
              </form>
            </div>
          </div>
        )}
      </Container>
    </Page>
  );
}
