// material
import { Box, Grid, Container, Typography } from "@mui/material";
// components
import Page from "../components/Page";
import {
  TopUpRequests,
  Hadiah,
  Merchants,
  RegisteredUser,
} from "../sections/@dashboard/app";

// ----------------------------------------------------------------------

export default function DashboardApp() {
  return (
    <Page title="Dashboard | Cakrawala.id Admin">
      <Container maxWidth="xl">
        <Box sx={{ pb: 5 }}>
          <Typography variant="h4">Hi, Welcome back</Typography>
        </Box>
        <Grid container spacing={3}>
          <Grid item xs={12} sm={6} md={3}>
            <RegisteredUser />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <TopUpRequests />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Merchants />
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Hadiah />
          </Grid>
        </Grid>
      </Container>
    </Page>
  );
}
