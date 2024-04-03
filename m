Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528714A4E9
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159335; cv=none; b=Hea1muie+QsKZrWNwEUw7wMKIGrE53biJ49IKFdz54CTRMGdrX0QLOKZnEDcWlt2dGqCvYdYksxzuxtLw1YvvITZCYnpV/+LYuBozlbBjbryCN9t+jO7lr9NgYudBhfJC3NwDYWdCnP24uVjQcoiERVkDmaP16mZD+Rafph8XeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159335; c=relaxed/simple;
	bh=nJNFKlv73g0DT9py/HgjU/6jc7XHeNQgoNWKfJOhUOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFkw0WS3oMUtC22DFICL9J/xL9UJyNrzJUoQ7guiaQk0SxZBAh9jLYRhL2ig4AyN2Tv/herUblICo60NDc/NbrdHn4gfOaHCtXCFxf8ZLZRPmjJ0eorcLbSJyn4pueL6oUW7vk74WdyTAZmYOnvlJJtirBkdNCuSxNOA4NHK6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E18C433F1;
	Wed,  3 Apr 2024 15:48:54 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v7 4/5] cxl: Consolidate dport access_coordinate ->hb_coord and ->sw_coord into ->coord
Date: Wed,  3 Apr 2024 08:47:15 -0700
Message-ID: <20240403154844.3403859-5-dave.jiang@intel.com>
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

The driver stores access_coordinate for host bridge in ->hb_coord and
switch CDAT access_coordinate in ->sw_coord. Since neither of these
access_coordinate clobber each other, the variable name can be consolidated
into ->coord to simplify the code.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v7:
- Adjusted based on code changes from pervious patches
---
 drivers/cxl/acpi.c           |  2 +-
 drivers/cxl/core/cdat.c      | 74 +++++++++++++++++++++++-------------
 drivers/cxl/core/port.c      | 48 +++++++++++++++++------
 drivers/cxl/cxl.h            |  6 +--
 drivers/cxl/cxlmem.h         |  2 +-
 tools/testing/cxl/test/cxl.c | 10 +++--
 6 files changed, 94 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 566c387d4385..cb8c155a2c9b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -529,7 +529,7 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
 	if (kstrtou32(acpi_device_uid(hb), 0, &uid))
 		return -EINVAL;
 
-	return acpi_get_genport_coordinates(uid, dport->hb_coord);
+	return acpi_get_genport_coordinates(uid, dport->coord);
 }
 
 static int add_host_bridge_dport(struct device *match, void *arg)
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 48704976693e..4b717d2f5a9d 100644
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
@@ -83,8 +83,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
-static void cxl_access_coordinate_set(struct access_coordinate *coord,
-				      int access, unsigned int val)
+static void __cxl_access_coordinate_set(struct access_coordinate *coord,
+					int access, unsigned int val)
 {
 	switch (access) {
 	case ACPI_HMAT_ACCESS_LATENCY:
@@ -110,6 +110,13 @@ static void cxl_access_coordinate_set(struct access_coordinate *coord,
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
@@ -151,7 +158,7 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 	val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
 			     dslbis->data_type);
 
-	cxl_access_coordinate_set(&dent->coord, dslbis->data_type, val);
+	cxl_access_coordinate_set(dent->coord, dslbis->data_type, val);
 
 	return 0;
 }
@@ -185,13 +192,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
-	struct access_coordinate ep_c;
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
@@ -208,10 +215,11 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	xa_for_each(dsmas_xa, index, dent) {
 		int qos_class;
 
-		cxl_coordinates_combine(&dent->coord, &dent->coord, &ep_c);
+		cxl_coordinates_combine(dent->coord, dent->coord, ep_c);
 		dent->entries = 1;
-		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
-					      &qos_class);
+		rc = cxl_root->ops->qos_class(cxl_root,
+					      &dent->coord[ACCESS_COORDINATE_CPU],
+					      1, &qos_class);
 		if (rc != 1)
 			continue;
 
@@ -228,14 +236,17 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
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
@@ -472,10 +483,11 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 
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
 
@@ -497,6 +509,21 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
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
@@ -508,15 +535,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
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
@@ -553,12 +573,12 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 		/* Get total bandwidth and the worst latency for the cxl region */
 		cxlr->coord[i].read_latency = max_t(unsigned int,
 						    cxlr->coord[i].read_latency,
-						    perf->coord.read_latency);
+						    perf->coord[i].read_latency);
 		cxlr->coord[i].write_latency = max_t(unsigned int,
 						     cxlr->coord[i].write_latency,
-						     perf->coord.write_latency);
-		cxlr->coord[i].read_bandwidth += perf->coord.read_bandwidth;
-		cxlr->coord[i].write_bandwidth += perf->coord.write_bandwidth;
+						     perf->coord[i].write_latency);
+		cxlr->coord[i].read_bandwidth += perf->coord[i].read_bandwidth;
+		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
 	}
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c7c00eb373af..801c4018a1dd 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2133,6 +2133,29 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
 
+static void add_latency(struct access_coordinate *c, long latency)
+{
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		c[i].write_latency += latency;
+		c[i].read_latency += latency;
+	}
+}
+
+static void set_min_bandwidth(struct access_coordinate *c, unsigned int bw)
+{
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		c[i].write_bandwidth = min(c[i].write_bandwidth, bw);
+		c[i].read_bandwidth = min(c[i].read_bandwidth, bw);
+	}
+}
+
+static void set_access_coordinates(struct access_coordinate *out,
+				   struct access_coordinate *in)
+{
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
+		out[i] = in[i];
+}
+
 static bool parent_port_is_cxl_root(struct cxl_port *port)
 {
 	return is_cxl_root(to_cxl_port(port->dev.parent));
@@ -2149,9 +2172,15 @@ static bool parent_port_is_cxl_root(struct cxl_port *port)
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
@@ -2178,14 +2207,13 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 		 * have CDAT and therefore needs to be skipped.
 		 */
 		if (!is_cxl_root)
-			cxl_coordinates_combine(&c, &c, &dport->sw_coord);
-		c.write_latency += dport->link_latency;
-		c.read_latency += dport->link_latency;
+			cxl_coordinates_combine(c, c, dport->coord);
+		add_latency(c, dport->link_latency);
 	} while (!is_cxl_root);
 
 	dport = iter->parent_dport;
 	/* Retrieve HB coords */
-	cxl_coordinates_combine(&c, &c, dport->hb_coord);
+	cxl_coordinates_combine(c, c, dport->coord);
 
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
@@ -2194,10 +2222,8 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
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
index ed02373ce3d9..036d17db68e0 100644
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
 
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 908e0d083936..61c69297e797 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -986,10 +986,12 @@ static void dpa_perf_setup(struct cxl_port *endpoint, struct range *range,
 {
 	dpa_perf->qos_class = FAKE_QTG_ID;
 	dpa_perf->dpa_range = *range;
-	dpa_perf->coord.read_latency = 500;
-	dpa_perf->coord.write_latency = 500;
-	dpa_perf->coord.read_bandwidth = 1000;
-	dpa_perf->coord.write_bandwidth = 1000;
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		dpa_perf->coord[i].read_latency = 500;
+		dpa_perf->coord[i].write_latency = 500;
+		dpa_perf->coord[i].read_bandwidth = 1000;
+		dpa_perf->coord[i].write_bandwidth = 1000;
+	}
 }
 
 static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
-- 
2.44.0

