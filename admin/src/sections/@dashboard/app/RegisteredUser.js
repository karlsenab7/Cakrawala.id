import { useState, useEffect } from "react";
import { url } from "src/api";
import axios from "axios";
// material
import { alpha, styled } from "@mui/material/styles";
import { Card, Typography } from "@mui/material";
// component
import Iconify from "../../../components/Iconify";

// ----------------------------------------------------------------------

const RootStyle = styled(Card)(({ theme }) => ({
  boxShadow: "none",
  textAlign: "center",
  padding: theme.spacing(5, 0),
  color: theme.palette.primary.darker,
  backgroundColor: theme.palette.primary.lighter,
}));

const IconWrapperStyle = styled("div")(({ theme }) => ({
  margin: "auto",
  display: "flex",
  borderRadius: "50%",
  alignItems: "center",
  width: theme.spacing(8),
  height: theme.spacing(8),
  justifyContent: "center",
  marginBottom: theme.spacing(3),
  color: theme.palette.primary.dark,
  backgroundImage: `linear-gradient(135deg, ${alpha(
    theme.palette.primary.dark,
    0
  )} 0%, ${alpha(theme.palette.primary.dark, 0.24)} 100%)`,
}));

// ----------------------------------------------------------------------

const TOTAL = 714000;

export default function RegisteredUser() {
  const [rows, setRows] = useState([]);

  const getAllUser = async () => {
    axios
      .get(url + "/admin/user")
      .then((r) => {
        setRows(r.data.data);
      })
      .catch((e) => console.log(e));
  };

  useEffect(async () => {
    await getAllUser();
  }, []);

  return (
    <RootStyle>
      <IconWrapperStyle>
        <Iconify icon="eva:people-fill" width={24} height={24} />
      </IconWrapperStyle>
      <Typography variant="h3">{rows?.length}</Typography>
      <Typography variant="subtitle2" sx={{ opacity: 0.72 }}>
        {rows.length > 1 ? "Registered Users" : "Registered User"}
      </Typography>
    </RootStyle>
  );
}
