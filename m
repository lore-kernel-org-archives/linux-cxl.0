Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E21113
	for <linux-cxl@vger.kernel.org>; Thu, 11 Apr 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859410; cv=none; b=p1rGtELHPFeg/EfDQaoSslXfhuFMgqNkfJR/AvmpxjO12S4EP1DcJitBsk2nHI/2UFpysEwA/muXvC2PuvkDNiKndP/AL0j9V+4GbMzLzFjyXnniv1mhK3tcIzY37uGua6c6EvmzM+cusm+7G4QaX6ReW4GPTR9PwOv0bjmA9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859410; c=relaxed/simple;
	bh=e4b/DAITvUFDynQLCyHr6sFgw5JUaVoC7voAnEieUyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvKtlLPM1nhvPUdjbVObRrc0OpFsHJJ9LPJozb0TWbT+fJLVxSFj8APXGuTlgSFhVltCmS9Y+1ZlcKdHYstnB4IS0ul+HkPBzPh4RQJzL/WCf+huYEAdtBsa6MFpT+r+o62vAGeWWqUVha+p6nQcOOT7dryAkMJ3QQuMC3lSA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F5CC072AA;
	Thu, 11 Apr 2024 18:16:50 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v2] cxl: Calculate region bandwidth of targets with shared upstream link
Date: Thu, 11 Apr 2024 11:16:41 -0700
Message-ID: <20240411181641.514075-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a topology where multiple targets sharing the same switch uplink, the
bandwidth must be divided amongst all the sharing targets.
cxl_rr->num_targets keeps track of the numbers of targets sharing the same
upstream port. The current implementation accumulates targets during
cxl_region_attach() and does not have the final number of targets until
the last target is attached. If the upstream link is shared, accumulate
bandwidth up to the switch upstream bandwidth.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Link: https://lore.kernel.org/linux-cxl/20240405143242.0000363a@Huawei.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

v2:
- cxl_region_targets() -> cxl_port_shared_region_targets(). (Dan)
- Use different method to calculate bandwidth. (Dan)
---
 drivers/cxl/core/cdat.c   | 48 +++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/core.h   |  3 +++
 drivers/cxl/core/pci.c    | 35 ++++++++++++++++++++++++++++
 drivers/cxl/core/region.c | 10 ++++++++
 4 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 4b717d2f5a9d..09f3e62e19a5 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -541,6 +541,36 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 MODULE_IMPORT_NS(CXL);
 
+static int cxl_get_switch_uport_bandwidth(struct device *uport_dev)
+{
+	struct device *dev = uport_dev->parent;
+
+	if (!dev_is_pci(dev))
+		return -ENODEV;
+
+	return cxl_pci_get_switch_usp_bandwidth(to_pci_dev(dev));
+}
+
+/*
+ * Calculate the bandwidth for the cxl region based on the number of targets
+ * that share an upstream switch. The function is called while targets are
+ * being attached for a region. If the number of targets is 1, then
+ * the target either does not have a upstream switch or it's the first target
+ * of the shared link. In this case, the bandwidth is the sum of the target
+ * bandwidth and the collected region bandwidth. If the targets from cxl_rr is
+ * greater than 1, then the bandwidth is the minimum of the switch upstream
+ * port bandwidth or the region plus the target bandwidth.
+ */
+static unsigned int calculate_region_bw(int targets, unsigned int usp_bw,
+					unsigned int ep_bw,
+					unsigned int region_bw)
+{
+	if (targets == 1)
+		return region_bw + ep_bw;
+
+	return min_t(unsigned int, usp_bw, region_bw + ep_bw);
+}
+
 void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 				    struct cxl_endpoint_decoder *cxled)
 {
@@ -551,7 +581,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 			.start = cxled->dpa_res->start,
 			.end = cxled->dpa_res->end,
 	};
+	struct cxl_port *port = cxlmd->endpoint;
 	struct cxl_dpa_perf *perf;
+	int usp_bw, targets;
 
 	switch (cxlr->mode) {
 	case CXL_DECODER_RAM:
@@ -569,6 +601,12 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 	if (!range_contains(&perf->dpa_range, &dpa))
 		return;
 
+	usp_bw = cxl_get_switch_uport_bandwidth(port->uport_dev);
+	if (usp_bw > 0)
+		targets = cxl_port_shared_region_targets(port, cxlr);
+	else
+		targets = 1;
+
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		/* Get total bandwidth and the worst latency for the cxl region */
 		cxlr->coord[i].read_latency = max_t(unsigned int,
@@ -577,8 +615,14 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 		cxlr->coord[i].write_latency = max_t(unsigned int,
 						     cxlr->coord[i].write_latency,
 						     perf->coord[i].write_latency);
-		cxlr->coord[i].read_bandwidth += perf->coord[i].read_bandwidth;
-		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
+		cxlr->coord[i].read_bandwidth =
+			calculate_region_bw(targets, usp_bw,
+					    perf->coord[i].read_bandwidth,
+					    cxlr->coord[i].read_bandwidth);
+		cxlr->coord[i].write_bandwidth =
+			calculate_region_bw(targets, usp_bw,
+					    perf->coord[i].write_bandwidth,
+					    cxlr->coord[i].write_bandwidth);
 	}
 }
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc5a95665aa0..99c1c24df671 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -89,9 +89,12 @@ enum cxl_poison_trace_type {
 };
 
 long cxl_pci_get_latency(struct pci_dev *pdev);
+int cxl_pci_get_switch_usp_bandwidth(struct pci_dev *pdev);
 
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
 bool cxl_need_node_perf_attrs_update(int nid);
 
+int cxl_port_shared_region_targets(struct cxl_port *port, struct cxl_region *cxlr);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0df09bd79408..9281ed5a073d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1045,3 +1045,38 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
 
 	return cxl_flit_size(pdev) * MEGA / bw;
 }
+
+static int cxl_pci_get_bandwidth(struct pci_dev *pdev)
+{
+	u16 lnksta;
+	u32 width;
+	int speed;
+
+	speed = pcie_link_speed_mbps(pdev);
+	if (speed < 0)
+		return 0;
+	speed /= BITS_PER_BYTE;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
+
+	return speed * width;
+}
+
+int cxl_pci_get_switch_usp_bandwidth(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pci_dev *iter = pdev;
+
+	do {
+		if (pci_pcie_type(iter) == PCI_EXP_TYPE_UPSTREAM)
+			break;
+
+		dev = iter->dev.parent;
+		if (!dev || !dev_is_pci(dev))
+			return -ENODEV;
+		iter = to_pci_dev(dev);
+	} while (1);
+
+	return cxl_pci_get_bandwidth(iter);
+}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..5a1bca31d269 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -222,6 +222,16 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
 	return xa_load(&port->regions, (unsigned long)cxlr);
 }
 
+int cxl_port_shared_region_targets(struct cxl_port *port, struct cxl_region *cxlr)
+{
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+
+	if (!cxl_rr)
+		return 0;
+
+	return cxl_rr->nr_targets;
+}
+
 static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 {
 	if (!cpu_cache_has_invalidate_memregion()) {
-- 
2.44.0

