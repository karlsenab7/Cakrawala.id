import { useFormik } from "formik";
import { useEffect, useState } from "react";
// material
import { Container, Stack, Typography } from "@mui/material";
// components
import Page from "../components/Page";
import {
  ProductSort,
  ProductList,
  ProductCartWidget,
  ProductFilterSidebar,
} from "../sections/@dashboard/products";
import axios from "axios";
import { url } from "../api";
import { uploadImageFirbase } from "../api/firebase";

// ----------------------------------------------------------------------

export default function EcommerceShop() {
  const [openFilter, setOpenFilter] = useState(false);
  const [prods, setProds] = useState([]);

  const formik = useFormik({
    initialValues: {
      gender: "",
      category: "",
      colors: "",
      priceRange: "",
      rating: "",
    },
    onSubmit: () => {
      setOpenFilter(false);
    },
  });

  const { resetForm, handleSubmit } = formik;

  const handleOpenFilter = () => {
    setOpenFilter(true);
  };

  const handleCloseFilter = () => {
    setOpenFilter(false);
  };

  const handleResetFilter = async (name, stock, points, image) => {
    //Disini buat skema submitnya ya ges ya
    if (!(stock && name && points && image)) {
      window.alert("Every fields needs to be filled!");
      return;
    }
    await uploadImageFirbase(image)
      .then((r) => {
        if (r) {
          return axios.post(url + "/admin/add-reward", {
            name: name,
            price: parseInt(points),
            stock: parseInt(stock),
            image: r,
          });
        }
      })
      .then((r) => {
        if (r.status === 200) {
          alert("New reward has been uploaded");
          window.location.reload();
        }
      })
      .catch((e) => {
        console.log(e);
        alert("ERROR: New reward cannot be uploaded");
      });
  };

  const getProducts = () => {
    axios
      .get(url + "/admin/reward")
      .then((r) => {
        if (r.status === 200) {
          setProds(r.data.data);
        }
      })
      .catch((e) => console.log(e));
  };

  useEffect(() => {
    getProducts();
  }, []);

  return (
    <Page title="Dashboard: Hadiah | Cakrawala.id Admin">
      <Container>
        <Typography variant="h4" sx={{ mb: 5 }}>
          Reward
        </Typography>

        <Stack
          direction="row"
          flexWrap="wrap-reverse"
          alignItems="center"
          justifyContent="flex-end"
          sx={{ mb: 5 }}
        >
          <Stack direction="row" spacing={1} flexShrink={0} sx={{ my: 1 }}>
            <ProductFilterSidebar
              formik={formik}
              isOpenFilter={openFilter}
              onResetFilter={handleResetFilter}
              onOpenFilter={handleOpenFilter}
              onCloseFilter={handleCloseFilter}
            />
          </Stack>
        </Stack>

        <ProductList products={prods} />
      </Container>
    </Page>
  );
}
