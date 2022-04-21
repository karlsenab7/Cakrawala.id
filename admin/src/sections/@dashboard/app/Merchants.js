import { useState, useEffect } from "react";
import { url } from "src/api";
import axios from "axios";
// material
import { alpha, styled } from "@mui/material/styles";
import { Card, Typography } from "@mui/material";
//
import Iconify from "../../../components/Iconify";

// ----------------------------------------------------------------------

const RootStyle = styled(Card)(({ theme }) => ({
  boxShadow: "none",
  textAlign: "center",
  padding: theme.spacing(5, 0),
  color: theme.palette.warning.darker,
  backgroundColor: theme.palette.warning.lighter,
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
  color: theme.palette.warning.dark,
  backgroundImage: `linear-gradient(135deg, ${alpha(
    theme.palette.warning.dark,
    0
  )} 0%, ${alpha(theme.palette.warning.dark, 0.24)} 100%)`,
}));

// ----------------------------------------------------------------------

export default function Merchants() {
  const [rows, setRows] = useState([]);

  const getAllMerchants = async () => {
    const response = await axios.get(url + "/admin/merchant");
    setRows(response.data.data);
  };

  useEffect(() => {
    getAllMerchants();
  }, []);

  return (
    <RootStyle>
      <IconWrapperStyle>
        <Iconify icon="bxs:store" width={24} height={24} />
      </IconWrapperStyle>
      <Typography variant="h3">{rows?.length}</Typography>
      <Typography variant="subtitle2" sx={{ opacity: 0.72 }}>
        {rows.length > 1 ? "Merchants" : "Merchant"}
      </Typography>
    </RootStyle>
  );
}
