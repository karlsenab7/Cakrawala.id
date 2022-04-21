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
  color: theme.palette.info.darker,
  backgroundColor: theme.palette.info.lighter,
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
  color: theme.palette.info.dark,
  backgroundImage: `linear-gradient(135deg, ${alpha(
    theme.palette.info.dark,
    0
  )} 0%, ${alpha(theme.palette.info.dark, 0.24)} 100%)`,
}));

// ----------------------------------------------------------------------

const TOTAL = 1352831;

export default function TopUpRequests() {
  const [rows, setRows] = useState([]);

  const getAllTopUpRequest = async () => {
    const response = await axios.get(url + "/admin/top-up/request");
    setRows(response.data.data);
  };

  useEffect(() => {
    getAllTopUpRequest();
  }, []);
  return (
    <RootStyle>
      <IconWrapperStyle>
        <Iconify
          icon="akar-icons:circle-chevron-up-fill"
          width={24}
          height={24}
        />
      </IconWrapperStyle>
      <Typography variant="h3">{rows?.length}</Typography>
      <Typography variant="subtitle2" sx={{ opacity: 0.72 }}>
        {rows.length > 1 ? "Top Up Requests" : "Top Up Request"}
      </Typography>
    </RootStyle>
  );
}
