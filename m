Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812F823D5
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407761; cv=none; b=paMyli06N8syZtdxkuUnm/jxXVv2D7VUSqdAz5ZqRr5D34Vzls6+qkZmlRUkeMXnk8bFgLIfgFmflJXUnhhA/GOKnAKh432QlUeBf8tBxkxRSMCEVGmFWWc+XxTHqHLSLxSTIaWWSZqD82pnHH3jQ4xRD4Bzo7q6C8xJdCMsYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407761; c=relaxed/simple;
	bh=XHPsFv6QxPW2bvNItzTXueqt/WvlEzNF8+SlMR3WrkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOMCcY2xG32mlHelQTFWF5EEx3LuLaQkHBeky3VX4f9bKLoBk+4SC1WxjZSac990IGzbrfc8pE1wAEZzZiLGTE6k6FS5zx+DWEyzOe+FGnhJmwQUELFQREU+BFOD+Gm95EEK6baUiTFXDCAdWljlIs7lRyvXZwyQI6v422N/SBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC117C43399;
	Mon, 25 Mar 2024 23:02:40 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v5 2/4] cxl: Consolidate dport access_coordinate ->hb_coord and ->sw_coord into ->coord
Date: Mon, 25 Mar 2024 16:00:49 -0700
Message-ID: <20240325230234.1847525-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325230234.1847525-1-dave.jiang@intel.com>
References: <20240325230234.1847525-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver stores access_coordinate for host bridge in ->hb_coord and
switch CDAT access_coordinate in ->sw_coord. Since neither of these
access_coordinate clobber each other, the variable name can be consolidated
into ->coord to simplify the code. This change also simplifies the
iteration loop in cxl_endpoint_get_perf_coordinates() and allow all the
access_coordinate to be picked up in the loop.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Rebased against v6.9-rc1
  With 2 access classes, switch coords will use first element has holder
---
 drivers/cxl/acpi.c      |  6 +--
 drivers/cxl/core/cdat.c | 99 +++++++++++++++++++----------------------
 drivers/cxl/core/port.c | 67 +++++++++++++---------------
 drivers/cxl/cxl.h       |  6 +--
 drivers/cxl/cxlmem.h    |  2 +-
 5 files changed, 81 insertions(+), 99 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index af5cb818f84d..0cfd141c0bed 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -530,14 +530,14 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
 	if (kstrtou32(acpi_device_uid(hb), 0, &uid))
 		return -EINVAL;
 
-	rc = acpi_get_genport_coordinates(uid, dport->hb_coord);
+	rc = acpi_get_genport_coordinates(uid, dport->coord);
 	if (rc < 0)
 		return rc;
 
 	/* Adjust back to picoseconds from nanoseconds */
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
-		dport->hb_coord[i].read_latency *= 1000;
-		dport->hb_coord[i].write_latency *= 1000;
+		dport->coord[i].read_latency *= 1000;
+		dport->coord[i].write_latency *= 1000;
 	}
 
 	return 0;
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index eddbbe21450c..5b75d2d56099 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -14,7 +14,7 @@
 struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
-	struct access_coordinate coord;
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 
 	int entries;
 	int qos_class;
@@ -58,8 +58,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
-static void cxl_access_coordinate_set(struct access_coordinate *coord,
-				      int access, unsigned int val)
+static void __cxl_access_coordinate_set(struct access_coordinate *coord,
+					int access, unsigned int val)
 {
 	switch (access) {
 	case ACPI_HMAT_ACCESS_LATENCY:
@@ -85,6 +85,13 @@ static void cxl_access_coordinate_set(struct access_coordinate *coord,
 	}
 }
 
+static void cxl_access_coordinate_set(struct access_coordinate *coord,
+				      int access, unsigned int val)
+{
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
+		__cxl_access_coordinate_set(&coord[i], access, val);
+}
+
 static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 			       const unsigned long end)
 {
@@ -129,7 +136,7 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 	if (rc)
 		pr_warn("DSLBIS value overflowed.\n");
 
-	cxl_access_coordinate_set(&dent->coord, dslbis->data_type, val);
+	cxl_access_coordinate_set(dent->coord, dslbis->data_type, val);
 
 	return 0;
 }
@@ -163,25 +170,18 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
-	struct access_coordinate ep_c;
-	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
 	struct dsmas_entry *dent;
 	int valid_entries = 0;
 	unsigned long index;
 	int rc;
 
-	rc = cxl_endpoint_get_perf_coordinates(port, &ep_c);
+	rc = cxl_endpoint_get_perf_coordinates(port, ep_c);
 	if (rc) {
 		dev_dbg(&port->dev, "Failed to retrieve ep perf coordinates.\n");
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
@@ -193,18 +193,10 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	xa_for_each(dsmas_xa, index, dent) {
 		int qos_class;
 
-		cxl_coordinates_combine(&dent->coord, &dent->coord, &ep_c);
-		/*
-		 * Keeping the host bridge coordinates separate from the dsmas
-		 * coordinates in order to allow calculation of access class
-		 * 0 and 1 for region later.
-		 */
-		cxl_coordinates_combine(&coord[ACCESS_COORDINATE_CPU],
-					&coord[ACCESS_COORDINATE_CPU],
-					&dent->coord);
+		cxl_coordinates_combine(dent->coord, dent->coord, ep_c);
 		dent->entries = 1;
 		rc = cxl_root->ops->qos_class(cxl_root,
-					      &coord[ACCESS_COORDINATE_CPU],
+					      &dent->coord[ACCESS_COORDINATE_CPU],
 					      1, &qos_class);
 		if (rc != 1)
 			continue;
@@ -222,14 +214,17 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
 			      struct cxl_dpa_perf *dpa_perf)
 {
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
+		dpa_perf->coord[i] = dent->coord[i];
 	dpa_perf->dpa_range = dent->dpa_range;
-	dpa_perf->coord = dent->coord;
 	dpa_perf->qos_class = dent->qos_class;
 	dev_dbg(dev,
 		"DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
 		dent->dpa_range.start, dpa_perf->qos_class,
-		dent->coord.read_bandwidth, dent->coord.write_bandwidth,
-		dent->coord.read_latency, dent->coord.write_latency);
+		dent->coord[ACCESS_COORDINATE_CPU].read_bandwidth,
+		dent->coord[ACCESS_COORDINATE_CPU].write_bandwidth,
+		dent->coord[ACCESS_COORDINATE_CPU].read_latency,
+		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
 }
 
 static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
@@ -468,10 +463,11 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 
 		xa_for_each(&port->dports, index, dport) {
 			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
-			    dsp_id == dport->port_id)
-				cxl_access_coordinate_set(&dport->sw_coord,
+			    dsp_id == dport->port_id) {
+				cxl_access_coordinate_set(dport->coord,
 							  sslbis->data_type,
 							  val);
+			}
 		}
 	}
 
@@ -493,6 +489,21 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
 
+static void __cxl_coordinates_combine(struct access_coordinate *out,
+				      struct access_coordinate *c1,
+				      struct access_coordinate *c2)
+{
+		if (c1->write_bandwidth && c2->write_bandwidth)
+			out->write_bandwidth = min(c1->write_bandwidth,
+						   c2->write_bandwidth);
+		out->write_latency = c1->write_latency + c2->write_latency;
+
+		if (c1->read_bandwidth && c2->read_bandwidth)
+			out->read_bandwidth = min(c1->read_bandwidth,
+						  c2->read_bandwidth);
+		out->read_latency = c1->read_latency + c2->read_latency;
+}
+
 /**
  * cxl_coordinates_combine - Combine the two input coordinates
  *
@@ -504,15 +515,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c1,
 			     struct access_coordinate *c2)
 {
-		if (c1->write_bandwidth && c2->write_bandwidth)
-			out->write_bandwidth = min(c1->write_bandwidth,
-						   c2->write_bandwidth);
-		out->write_latency = c1->write_latency + c2->write_latency;
-
-		if (c1->read_bandwidth && c2->read_bandwidth)
-			out->read_bandwidth = min(c1->read_bandwidth,
-						  c2->read_bandwidth);
-		out->read_latency = c1->read_latency + c2->read_latency;
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
+		__cxl_coordinates_combine(&out[i], &c1[i], &c2[i]);
 }
 
 MODULE_IMPORT_NS(CXL);
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
@@ -549,25 +549,16 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
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
+						    perf->coord[i].read_latency);
 		cxlr->coord[i].write_latency = max_t(unsigned int,
 						     cxlr->coord[i].write_latency,
-						     coord.write_latency);
-		cxlr->coord[i].read_bandwidth += coord.read_bandwidth;
-		cxlr->coord[i].write_bandwidth += coord.write_bandwidth;
+						     perf->coord[i].write_latency);
+		cxlr->coord[i].read_bandwidth += perf->coord[i].read_bandwidth;
+		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
 
 		/*
 		 * Convert latency to nanosec from picosec to be consistent
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6cbde50a742b..e388f50675f8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2133,36 +2133,27 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
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
+static void add_latency(struct access_coordinate *c, long latency)
 {
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
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		c[i].write_latency += latency;
+		c[i].read_latency += latency;
 	}
+}
 
-	coord[ACCESS_COORDINATE_LOCAL] =
-		dport->hb_coord[ACCESS_COORDINATE_LOCAL];
-	coord[ACCESS_COORDINATE_CPU] =
-		dport->hb_coord[ACCESS_COORDINATE_CPU];
+static void set_min_bandwidth(struct access_coordinate *c, unsigned int bw)
+{
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		c[i].write_bandwidth = min(c[i].write_bandwidth, bw);
+		c[i].read_bandwidth = min(c[i].read_bandwidth, bw);
+	}
+}
 
-	return 0;
+static void set_access_coordinates(struct access_coordinate *out,
+				   struct access_coordinate *in)
+{
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
+		out[i] = in[i];
 }
 
 /**
@@ -2176,9 +2167,15 @@ int cxl_hb_get_perf_coordinates(struct cxl_port *port,
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord)
 {
-	struct access_coordinate c = {
-		.read_bandwidth = UINT_MAX,
-		.write_bandwidth = UINT_MAX,
+	struct access_coordinate c[] = {
+		{
+			.read_bandwidth = UINT_MAX,
+			.write_bandwidth = UINT_MAX,
+		},
+		{
+			.read_bandwidth = UINT_MAX,
+			.write_bandwidth = UINT_MAX,
+		},
 	};
 	struct cxl_port *iter = port;
 	struct cxl_dport *dport;
@@ -2198,11 +2195,9 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	 * nothing to gather.
 	 */
 	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
-		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
-		c.write_latency += dport->link_latency;
-		c.read_latency += dport->link_latency;
-
 		iter = to_cxl_port(iter->dev.parent);
+		cxl_coordinates_combine(c, c, dport->coord);
+		add_latency(c, dport->link_latency);
 		dport = iter->parent_dport;
 	}
 
@@ -2213,10 +2208,8 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 		return -ENXIO;
 	bw /= BITS_PER_BYTE;
 
-	c.write_bandwidth = min(c.write_bandwidth, bw);
-	c.read_bandwidth = min(c.read_bandwidth, bw);
-
-	*coord = c;
+	set_min_bandwidth(c, bw);
+	set_access_coordinates(coord, c);
 
 	return 0;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 534e25e2f0a4..2d846282c171 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -663,8 +663,7 @@ struct cxl_rcrb_info {
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  * @regs: Dport parsed register blocks
- * @sw_coord: access coordinates (performance) for switch from CDAT
- * @hb_coord: access coordinates (performance) from ACPI generic port (host bridge)
+ * @coord: access coordinates (bandwidth and latency performance attributes)
  * @link_latency: calculated PCIe downstream latency
  */
 struct cxl_dport {
@@ -675,8 +674,7 @@ struct cxl_dport {
 	bool rch;
 	struct cxl_port *port;
 	struct cxl_regs regs;
-	struct access_coordinate sw_coord;
-	struct access_coordinate hb_coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 };
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 20fb3b35e89e..36cee9c30ceb 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -401,7 +401,7 @@ enum cxl_devtype {
  */
 struct cxl_dpa_perf {
 	struct range dpa_range;
-	struct access_coordinate coord;
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	int qos_class;
 };
 
-- 
2.44.0

