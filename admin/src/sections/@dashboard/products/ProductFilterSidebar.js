import PropTypes from "prop-types";
import { Form, FormikProvider } from "formik";
// material
import {
  Box,
  Radio,
  Stack,
  Button,
  Drawer,
  Rating,
  Divider,
  Checkbox,
  FormGroup,
  IconButton,
  Typography,
  RadioGroup,
  FormControlLabel,
  TextField,
} from "@mui/material";
//
import Iconify from "../../../components/Iconify";
import Scrollbar from "../../../components/Scrollbar";
import ColorManyPicker from "../../../components/ColorManyPicker";
import { useState } from "react";

// ----------------------------------------------------------------------

export const SORT_BY_OPTIONS = [
  { value: "featured", label: "Featured" },
  { value: "newest", label: "Newest" },
  { value: "priceDesc", label: "Price: High-Low" },
  { value: "priceAsc", label: "Price: Low-High" },
];
export const FILTER_GENDER_OPTIONS = ["Men", "Women", "Kids"];
export const FILTER_CATEGORY_OPTIONS = [
  "All",
  "Shose",
  "Apparel",
  "Accessories",
];
export const FILTER_RATING_OPTIONS = [
  "up4Star",
  "up3Star",
  "up2Star",
  "up1Star",
];
export const FILTER_PRICE_OPTIONS = [
  { value: "below", label: "Below $25" },
  { value: "between", label: "Between $25 - $75" },
  { value: "above", label: "Above $75" },
];
export const FILTER_COLOR_OPTIONS = [
  "#00AB55",
  "#000000",
  "#FFFFFF",
  "#FFC0CB",
  "#FF4842",
  "#1890FF",
  "#94D82D",
  "#FFC107",
];

// ----------------------------------------------------------------------

ShopFilterSidebar.propTypes = {
  isOpenFilter: PropTypes.bool,
  onResetFilter: PropTypes.func,
  onOpenFilter: PropTypes.func,
  onCloseFilter: PropTypes.func,
  formik: PropTypes.object,
};

export default function ShopFilterSidebar({
  isOpenFilter,
  onResetFilter,
  onOpenFilter,
  onCloseFilter,
  formik,
}) {
  const { values, getFieldProps, handleChange } = formik;

  const [name, setName] = useState("");
  const [stock, setStock] = useState("");
  const [points, setPoints] = useState("");
  const [imageup, setImage] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const submitProcesser = () => {
    setIsLoading(true);
    onResetFilter(name, stock, points, imageup).finally(() => {
      setIsLoading(false);
    });
  };

  return (
    <>
      <Button
        disableRipple
        color="inherit"
        endIcon={<Iconify icon="carbon:add-filled" />}
        onClick={onOpenFilter}
      >
        Add New Reward&nbsp;
      </Button>

      <FormikProvider value={formik}>
        <Form autoComplete="off" noValidate>
          <Drawer
            anchor="right"
            open={isOpenFilter}
            onClose={onCloseFilter}
            PaperProps={{
              sx: { width: 280, border: "none", overflow: "hidden" },
            }}
          >
            <Stack
              direction="row"
              alignItems="center"
              justifyContent="space-between"
              sx={{ px: 1, py: 2 }}
            >
              <Typography variant="subtitle1" sx={{ ml: 1 }}>
                Add New Prize
              </Typography>
              <IconButton onClick={onCloseFilter}>
                <Iconify icon="eva:close-fill" width={20} height={20} />
              </IconButton>
            </Stack>

            <Divider />

            <Scrollbar>
              <Stack spacing={3} sx={{ p: 3 }}>
                <div>
                  <Typography variant="subtitle1" gutterBottom>
                    Reward Name
                  </Typography>
                  <TextField
                    id="nama-hadiah"
                    label="Reward Name"
                    variant="outlined"
                    onChange={(e) => setName(e.target.value)}
                  />
                </div>

                <div>
                  <Typography variant="subtitle1" gutterBottom>
                    Stock
                  </Typography>
                  <TextField
                    id="stock-hadiah"
                    label="Reward Stock"
                    variant="outlined"
                    type={"number"}
                    onChange={(e) => setStock(e.target.value)}
                  />
                </div>

                <div>
                  <Typography variant="subtitle1" gutterBottom>
                    Points Needed to be Spent
                  </Typography>
                  <TextField
                    id="point-hadiah"
                    label="Reward Points"
                    variant="outlined"
                    type={"number"}
                    onChange={(e) => setPoints(e.target.value)}
                  />
                </div>

                <div>
                  <Typography variant="subtitle1" gutterBottom>
                    Image
                  </Typography>
                  <input
                    accept="image/*"
                    className="gambar-hadiah"
                    style={{ display: "none" }}
                    id="raised-button-file"
                    onChange={(e) => {
                      setImage(e.target.files[0]);
                    }}
                    multiple
                    type="file"
                  />
                  <label htmlFor="raised-button-file">
                    <Button
                      variant="raised"
                      component="span"
                      className="gambar-hadiah"
                    >
                      Upload
                    </Button>
                  </label>
                </div>
              </Stack>
            </Scrollbar>

            <Box sx={{ p: 3 }}>
              {isLoading ? (
                <Typography variant="subtitle1" gutterBottom>
                  Loading...
                </Typography>
              ) : (
                <Button
                  fullWidth
                  size="large"
                  type="submit"
                  color="inherit"
                  variant="outlined"
                  onClick={submitProcesser}
                  startIcon={<Iconify icon="ic:round-clear-all" />}
                >
                  Submit
                </Button>
              )}
            </Box>
          </Drawer>
        </Form>
      </FormikProvider>
    </>
  );
}
