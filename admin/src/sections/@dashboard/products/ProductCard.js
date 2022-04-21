import PropTypes from "prop-types";
import { Link as RouterLink } from "react-router-dom";
// material
import { Box, Card, Link, Typography, Stack, Button } from "@mui/material";
import { styled } from "@mui/material/styles";
//
import axios from "axios";
import { url } from "../../../api";

// ----------------------------------------------------------------------

const ProductImgStyle = styled("img")({
  top: 0,
  width: "100%",
  height: "100%",
  objectFit: "cover",
  position: "absolute",
});

// ----------------------------------------------------------------------

ShopProductCard.propTypes = {
  product: PropTypes.object,
};

export default function ShopProductCard({ product }) {
  const { name, price, stock, image, id } = product;

  const stockEditor = (id) => {
    const newStock = window.prompt("Stock baru anda");
    if (id && newStock && parseInt(newStock) >= 0) {
      axios
        .patch(url + `/admin/reward/${id}`, {
          stock: parseInt(newStock),
        })
        .then((r) => {
          if (r.status === 200) {
            alert("Stock has been updated with id: " + id);
            window.location.reload();
            return;
          }
          alert("ERROR: Stock cannot be updated");
        })
        .catch((e) => {
          console.log("updatestok", e);
          alert("ERROR: Something went wrong");
        });
    } else {
      alert("ERROR: invalid input!");
    }
  };

  return (
    <Card>
      <Box sx={{ pt: "100%", position: "relative" }}>
        <ProductImgStyle alt={name} src={image} />
      </Box>

      <Stack spacing={2} sx={{ p: 3 }}>
        <Link to="#" color="inherit" underline="hover" component={RouterLink}>
          <Typography variant="subtitle2" noWrap>
            {name}
          </Typography>
        </Link>

        <Stack
          direction="row"
          alignItems="center"
          justifyContent="space-between"
        >
          <Typography variant="subtitle1">
            <Typography
              component="span"
              variant="body1"
              sx={{
                color: "text.disabled",
              }}
            >
              Stock:
            </Typography>
            &nbsp;
            {stock}
          </Typography>
          <Typography variant="subtitle1">
            <Typography
              component="span"
              variant="body1"
              sx={{
                color: "text.disabled",
              }}
            >
              Pts
            </Typography>
            &nbsp;
            {price}
          </Typography>
        </Stack>

        <Button
          fullWidth
          size="large"
          type="submit"
          color="inherit"
          variant="outlined"
          onClick={() => {
            stockEditor(id);
          }}
        >
          Edit Stock
        </Button>
      </Stack>
    </Card>
  );
}
