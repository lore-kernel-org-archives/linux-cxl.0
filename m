Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D59137931
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747539; cv=none; b=Au1NcTH/zrM076ky52xiEGpYGufOtYN2lPolG625Me/wlK5GV7Nke7mTghI7L1omLGyWy4rXmhnRbudFE8hM0SqYq5pqsinpG31yKp7YRcL8zxZXBOz4PGOauiDu7QOe5Y5fkE37ztbnxAbfKr+B+g6sANBAauV5dEzBl+PBm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747539; c=relaxed/simple;
	bh=YJ1BBFoV5jFErQs6EFI26XIbLzEBF8+2kOGBuiVIotw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYk7x172m1FiCe6fTdiOya5KipG+LfHGXuHv5zmEB9+AJPgaZ8m/XV+AF+HEoHS9FNkjV6adRzEUUGhmH6CeAQMrTTnQncKXZuEEXnKUICcauygo6nH/0es7Gd/pVd5wfNdBKG44QwXlrbr/VUPDU7mx6gCHareoHzYtUy6FxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBD7C433C7;
	Wed,  6 Mar 2024 17:52:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v3 2/3] cxl: Consolidate dport access_coordinate ->hb_coord and ->sw_coord into ->coord
Date: Wed,  6 Mar 2024 10:52:03 -0700
Message-ID: <20240306175204.1906538-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306175204.1906538-1-dave.jiang@intel.com>
References: <20240306175204.1906538-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver stores access_coordinate for host bridge in ->hb_coord and switch
CDAT access_coordinate in ->sw_coord. Since neither of these
access_coordinate clobber each other, the variable name can be consolidated
into ->coord to simplify the code. This change also simplifies the iteration
loop in cxl_endpoint_get_perf_coordinates() and allow all the
access_coordinate to be picked up in the loop.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/acpi.c      | 6 +++---
 drivers/cxl/core/cdat.c | 2 +-
 drivers/cxl/core/port.c | 5 +----
 drivers/cxl/cxl.h       | 6 ++----
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1a3e6aafbdcc..dbd5a0d10f8b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -530,13 +530,13 @@ static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
 	if (kstrtou32(acpi_device_uid(hb), 0, &uid))
 		return -EINVAL;
 
-	rc = acpi_get_genport_coordinates(uid, &dport->hb_coord);
+	rc = acpi_get_genport_coordinates(uid, &dport->coord);
 	if (rc < 0)
 		return rc;
 
 	/* Adjust back to picoseconds from nanoseconds */
-	dport->hb_coord.read_latency *= 1000;
-	dport->hb_coord.write_latency *= 1000;
+	dport->coord.read_latency *= 1000;
+	dport->coord.write_latency *= 1000;
 
 	return 0;
 }
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 0363ca434ef4..fcfb6308996b 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -460,7 +460,7 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 		xa_for_each(&port->dports, index, dport) {
 			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
 			    dsp_id == dport->port_id)
-				cxl_access_coordinate_set(&dport->sw_coord,
+				cxl_access_coordinate_set(&dport->coord,
 							  sslbis->data_type,
 							  val);
 		}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e1d30a885700..6fa273677963 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2143,7 +2143,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	 * nothing to gather.
 	 */
 	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
-		combine_coordinates(&c, &dport->sw_coord);
+		combine_coordinates(&c, &dport->coord);
 		c.write_latency += dport->link_latency;
 		c.read_latency += dport->link_latency;
 
@@ -2151,9 +2151,6 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 		dport = iter->parent_dport;
 	}
 
-	/* Augment with the generic port (host bridge) perf data */
-	combine_coordinates(&c, &dport->hb_coord);
-
 	/* Get the calculated PCI paths bandwidth */
 	pdev = to_pci_dev(port->uport_dev->parent);
 	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 003feebab79b..0cf5f23d9de6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -658,8 +658,7 @@ struct cxl_rcrb_info {
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  * @regs: Dport parsed register blocks
- * @sw_coord: access coordinates (performance) for switch from CDAT
- * @hb_coord: access coordinates (performance) from ACPI generic port (host bridge)
+ * @coord: access coordinates (bandwidth and latency performance attributes)
  * @link_latency: calculated PCIe downstream latency
  */
 struct cxl_dport {
@@ -670,8 +669,7 @@ struct cxl_dport {
 	bool rch;
 	struct cxl_port *port;
 	struct cxl_regs regs;
-	struct access_coordinate sw_coord;
-	struct access_coordinate hb_coord;
+	struct access_coordinate coord;
 	long link_latency;
 };
 
-- 
2.43.0

