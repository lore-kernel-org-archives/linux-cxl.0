Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0072156F25
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688644; cv=none; b=QZulPksBg9F4X6QqmOE0y5ZP1q5QtxldEAv08HlZhq/RymZHYzSYMFylAboGTRwOKCkYkoDPcQEsiJ0ADqv1A1wUJzCBuYZl4aYVEZ+ypEC/OfjTu4+wiYnAODizs5ZL4jAwyj/s1pHfk9+D/+eL6Y5t9ZZ5icxoV1DaHGzKBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688644; c=relaxed/simple;
	bh=Lbad5jbslaNKX4OCWpEZBcDfFHJnCgVtnVi/yKTMwmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IeqGAxeXokwOTQ/h+7ImfaWKb6KOFZFo/PUq0yEjcN5xMW5bGj19ZBDj23yxS0KK4a+DeESVWQzri9NMJK/tLiN83qAOMbUvNTSx86U72y5NzNytN0xkmsiqfzuTcz+NpRUuH4ETcNaTlCMtQe4jrtS9fb/cny6QPw2//1+7N0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25101C433C7;
	Tue,  9 Apr 2024 18:50:44 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH] cxl: Calculate region bandwidth of targets with shared upstream link
Date: Tue,  9 Apr 2024 11:50:23 -0700
Message-ID: <20240409185023.151885-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a topology where multiple targets sharing the same upstream link, the
bandwidth must be divided amongst all the sharing targets.
cxl_rr->num_targets keeps track of the numbers of targets sharing the same
upstream port. The bandwidth should be divided amongst all those targets.
Take the min of that bandwidth and the whole path bandwidth as the actual
bandwidth for each of the target.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Link: https://lore.kernel.org/linux-cxl/20240405143242.0000363a@Huawei.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c   | 24 ++++++++++++++++++++++--
 drivers/cxl/core/core.h   |  3 +++
 drivers/cxl/core/pci.c    | 17 +++++++++++++++++
 drivers/cxl/core/region.c | 10 ++++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 4b717d2f5a9d..af5c02ab49e3 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -551,7 +551,10 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 			.start = cxled->dpa_res->start,
 			.end = cxled->dpa_res->end,
 	};
+	struct cxl_port *port = cxlmd->endpoint;
+	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
 	struct cxl_dpa_perf *perf;
+	int usp_bw, targets;
 
 	switch (cxlr->mode) {
 	case CXL_DECODER_RAM:
@@ -569,6 +572,19 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 	if (!range_contains(&perf->dpa_range, &dpa))
 		return;
 
+	usp_bw = cxl_pci_get_bandwidth(pdev);
+	if (usp_bw < 0)
+		return;
+
+	/*
+	 * Get the number of targets that share the upstream link. If there are more
+	 * than 1 shared targets, the upstream port bandwidth is divided equally
+	 * amongst all the targets.
+	 */
+	targets = cxl_region_targets(port, cxlr);
+	if (!targets)
+		return;
+
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		/* Get total bandwidth and the worst latency for the cxl region */
 		cxlr->coord[i].read_latency = max_t(unsigned int,
@@ -577,8 +593,12 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 		cxlr->coord[i].write_latency = max_t(unsigned int,
 						     cxlr->coord[i].write_latency,
 						     perf->coord[i].write_latency);
-		cxlr->coord[i].read_bandwidth += perf->coord[i].read_bandwidth;
-		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
+		cxlr->coord[i].read_bandwidth += min_t(unsigned int,
+						       perf->coord[i].read_bandwidth,
+						       usp_bw / targets);
+		cxlr->coord[i].write_bandwidth += min_t(unsigned int,
+							perf->coord[i].write_bandwidth,
+							usp_bw / targets);
 	}
 }
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc5a95665aa0..3eccd5ea1ae4 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -89,9 +89,12 @@ enum cxl_poison_trace_type {
 };
 
 long cxl_pci_get_latency(struct pci_dev *pdev);
+int cxl_pci_get_bandwidth(struct pci_dev *pdev);
 
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
 bool cxl_need_node_perf_attrs_update(int nid);
 
+int cxl_region_targets(struct cxl_port *port, struct cxl_region *cxlr);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0df09bd79408..8fbfc5115cd0 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1045,3 +1045,20 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
 
 	return cxl_flit_size(pdev) * MEGA / bw;
 }
+
+int cxl_pci_get_bandwidth(struct pci_dev *pdev)
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
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..9b8bdb01ff0f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -222,6 +222,16 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
 	return xa_load(&port->regions, (unsigned long)cxlr);
 }
 
+int cxl_region_targets(struct cxl_port *port, struct cxl_region *cxlr)
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

