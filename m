Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427A14A090
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159334; cv=none; b=mOawdhv69rUu9npR50VULOZRXBRo8Bpjk/lTtV/4xk19ZAVKeoK5khejGT2GxhgltbhQZ5yFTeQlJ1r+tDpr2E8BfymWWkgmM/Gvfi3uYOLd2oVNR4M6zrD4o1pUvHjheWFBFrqG3ZFrLwF0R6DT/e7LxcsZLILhkQWjYVG6n84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159334; c=relaxed/simple;
	bh=VqNoePzcaQ9JwitnNer0sTE387H6ImaQQNNS9bVlVGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qcyca9W39zjGLCteZPLPZLfcIdganhSKLt1c81BtwOj/FFYyFX7bQswTmI4oiBFUgCRPrWzbcpP9SCB1masRkjXMwngZDBiyj/9pMUMKrG102Qs55Ey+/jLYjU3t2Tx+/7txNrrmOJm/Pimo6KRHxfBP1EugUPaHenGK29cTHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63B7C43390;
	Wed,  3 Apr 2024 15:48:53 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v7 3/5] cxl: Fix incorrect region perf data calculation
Date: Wed,  3 Apr 2024 08:47:14 -0700
Message-ID: <20240403154844.3403859-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403154844.3403859-1-dave.jiang@intel.com>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current math in cxl_region_perf_data_calculate divides the latency by 1000
every time the function gets called. This causes the region latency to be
divided by 1000 per memory device and the math is incorrect. This is user
visible as the latency access_coordinate exposed via sysfs will show
incorrect latency data.

Normalize values from CDAT to nanoseconds. Adjust sub-nanoseconds latency
to at least 1. Remove adjustment of perf numbers from the generic target
since hmat handling code has already normalized those numbers. Now all
computation and stored numbers should be in nanoseconds.

cxl_hb_get_perf_coordinates() is removed and HB coords are calculated
in the port access_coordinate calculation path since it no longer need
to be treated special.

Fixes: 3d9f4a197230 ("cxl/region: Calculate performance data for a region")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v7:
- Remove min_not_zero(). Incorrectly set everything to 1. DIV_ROUNDUP()
  will ensure sub-nanoseconds values not 0 unless value 0 to begin with.
  (Jonathan)
- Reflowed patch order
- Remove cxl_hb_get_perf_coordinates() as change made function unnessary.
- Add hb access_coordinate back to port caclculation.
---
 drivers/cxl/acpi.c      | 13 +-----
 drivers/cxl/core/cdat.c | 89 ++++++++++++++++-------------------------
 drivers/cxl/core/port.c | 36 ++---------------
 drivers/cxl/cxl.h       |  2 -
 4 files changed, 40 insertions(+), 100 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index af5cb818f84d..566c387d4385 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -525,22 +525,11 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
 {
 	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
 	u32 uid;
-	int rc;
 
 	if (kstrtou32(acpi_device_uid(hb), 0, &uid))
 		return -EINVAL;
 
-	rc = acpi_get_genport_coordinates(uid, dport->hb_coord);
-	if (rc < 0)
-		return rc;
-
-	/* Adjust back to picoseconds from nanoseconds */
-	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
-		dport->hb_coord[i].read_latency *= 1000;
-		dport->hb_coord[i].write_latency *= 1000;
-	}
-
-	return 0;
+	return acpi_get_genport_coordinates(uid, dport->hb_coord);
 }
 
 static int add_host_bridge_dport(struct device *match, void *arg)
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index eddbbe21450c..48704976693e 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -20,6 +20,31 @@ struct dsmas_entry {
 	int qos_class;
 };
 
+static u32 cdat_normalize(u16 entry, u64 base, u8 type)
+{
+	u32 value;
+
+	/*
+	 * Check for invalid and overflow values
+	 */
+	if (entry == 0xffff || !entry)
+		return 0;
+	else if (base > (UINT_MAX / (entry)))
+		return 0;
+
+	value = entry * base;
+	switch (type) {
+	case ACPI_HMAT_ACCESS_LATENCY:
+	case ACPI_HMAT_READ_LATENCY:
+	case ACPI_HMAT_WRITE_LATENCY:
+		value = DIV_ROUND_UP(value, 1000);
+		break;
+	default:
+		break;
+	}
+	return value;
+}
+
 static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
 			      const unsigned long end)
 {
@@ -97,7 +122,6 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 	__le16 le_val;
 	u64 val;
 	u16 len;
-	int rc;
 
 	len = le16_to_cpu((__force __le16)hdr->length);
 	if (len != size || (unsigned long)hdr + len > end) {
@@ -124,10 +148,8 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 
 	le_base = (__force __le64)dslbis->entry_base_unit;
 	le_val = (__force __le16)dslbis->entry[0];
-	rc = check_mul_overflow(le64_to_cpu(le_base),
-				le16_to_cpu(le_val), &val);
-	if (rc)
-		pr_warn("DSLBIS value overflowed.\n");
+	val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
+			     dslbis->data_type);
 
 	cxl_access_coordinate_set(&dent->coord, dslbis->data_type, val);
 
@@ -164,7 +186,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
 	struct access_coordinate ep_c;
-	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct dsmas_entry *dent;
 	int valid_entries = 0;
 	unsigned long index;
@@ -176,12 +197,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 		return rc;
 	}
 
-	rc = cxl_hb_get_perf_coordinates(port, coord);
-	if (rc)  {
-		dev_dbg(&port->dev, "Failed to retrieve hb perf coordinates.\n");
-		return rc;
-	}
-
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 
 	if (!cxl_root)
@@ -194,18 +209,9 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 		int qos_class;
 
 		cxl_coordinates_combine(&dent->coord, &dent->coord, &ep_c);
-		/*
-		 * Keeping the host bridge coordinates separate from the dsmas
-		 * coordinates in order to allow calculation of access class
-		 * 0 and 1 for region later.
-		 */
-		cxl_coordinates_combine(&coord[ACCESS_COORDINATE_CPU],
-					&coord[ACCESS_COORDINATE_CPU],
-					&dent->coord);
 		dent->entries = 1;
-		rc = cxl_root->ops->qos_class(cxl_root,
-					      &coord[ACCESS_COORDINATE_CPU],
-					      1, &qos_class);
+		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
+					      &qos_class);
 		if (rc != 1)
 			continue;
 
@@ -461,10 +467,8 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 
 		le_base = (__force __le64)tbl->sslbis_header.entry_base_unit;
 		le_val = (__force __le16)tbl->entries[i].latency_or_bandwidth;
-
-		if (check_mul_overflow(le64_to_cpu(le_base),
-				       le16_to_cpu(le_val), &val))
-			dev_warn(dev, "SSLBIS value overflowed!\n");
+		val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
+				     sslbis->data_type);
 
 		xa_for_each(&port->dports, index, dport) {
 			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
@@ -521,17 +525,13 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 				    struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlmd->endpoint;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct access_coordinate hb_coord[ACCESS_COORDINATE_MAX];
-	struct access_coordinate coord;
 	struct range dpa = {
 			.start = cxled->dpa_res->start,
 			.end = cxled->dpa_res->end,
 	};
 	struct cxl_dpa_perf *perf;
-	int rc;
 
 	switch (cxlr->mode) {
 	case CXL_DECODER_RAM:
@@ -549,35 +549,16 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 	if (!range_contains(&perf->dpa_range, &dpa))
 		return;
 
-	rc = cxl_hb_get_perf_coordinates(port, hb_coord);
-	if (rc)  {
-		dev_dbg(&port->dev, "Failed to retrieve hb perf coordinates.\n");
-		return;
-	}
-
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
-		/* Pickup the host bridge coords */
-		cxl_coordinates_combine(&coord, &hb_coord[i], &perf->coord);
-
 		/* Get total bandwidth and the worst latency for the cxl region */
 		cxlr->coord[i].read_latency = max_t(unsigned int,
 						    cxlr->coord[i].read_latency,
-						    coord.read_latency);
+						    perf->coord.read_latency);
 		cxlr->coord[i].write_latency = max_t(unsigned int,
 						     cxlr->coord[i].write_latency,
-						     coord.write_latency);
-		cxlr->coord[i].read_bandwidth += coord.read_bandwidth;
-		cxlr->coord[i].write_bandwidth += coord.write_bandwidth;
-
-		/*
-		 * Convert latency to nanosec from picosec to be consistent
-		 * with the resulting latency coordinates computed by the
-		 * HMAT_REPORTING code.
-		 */
-		cxlr->coord[i].read_latency =
-			DIV_ROUND_UP(cxlr->coord[i].read_latency, 1000);
-		cxlr->coord[i].write_latency =
-			DIV_ROUND_UP(cxlr->coord[i].write_latency, 1000);
+						     perf->coord.write_latency);
+		cxlr->coord[i].read_bandwidth += perf->coord.read_bandwidth;
+		cxlr->coord[i].write_bandwidth += perf->coord.write_bandwidth;
 	}
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7aadcec4fc64..c7c00eb373af 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2133,38 +2133,6 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
 
-/**
- * cxl_hb_get_perf_coordinates - Retrieve performance numbers between initiator
- *				 and host bridge
- *
- * @port: endpoint cxl_port
- * @coord: output access coordinates
- *
- * Return: errno on failure, 0 on success.
- */
-int cxl_hb_get_perf_coordinates(struct cxl_port *port,
-				struct access_coordinate *coord)
-{
-	struct cxl_port *iter = port;
-	struct cxl_dport *dport;
-
-	if (!is_cxl_endpoint(port))
-		return -EINVAL;
-
-	dport = iter->parent_dport;
-	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
-		iter = to_cxl_port(iter->dev.parent);
-		dport = iter->parent_dport;
-	}
-
-	coord[ACCESS_COORDINATE_LOCAL] =
-		dport->hb_coord[ACCESS_COORDINATE_LOCAL];
-	coord[ACCESS_COORDINATE_CPU] =
-		dport->hb_coord[ACCESS_COORDINATE_CPU];
-
-	return 0;
-}
-
 static bool parent_port_is_cxl_root(struct cxl_port *port)
 {
 	return is_cxl_root(to_cxl_port(port->dev.parent));
@@ -2215,6 +2183,10 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 		c.read_latency += dport->link_latency;
 	} while (!is_cxl_root);
 
+	dport = iter->parent_dport;
+	/* Retrieve HB coords */
+	cxl_coordinates_combine(&c, &c, dport->hb_coord);
+
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
 	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 534e25e2f0a4..ed02373ce3d9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -884,8 +884,6 @@ void cxl_switch_parse_cdat(struct cxl_port *port);
 
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
-int cxl_hb_get_perf_coordinates(struct cxl_port *port,
-				struct access_coordinate *coord);
 void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 				    struct cxl_endpoint_decoder *cxled);
 
-- 
2.44.0

