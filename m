Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BE433A0
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817776; cv=none; b=bVXrs99W8zyvMBQmQl8UYvUGjM8a1/EK1LEkFdrwkkeuzS8Iaz/G8FOUhxgV+P0Gx4hXvJwSwA8qIQcjLVkGcKZUSndouxudr7t3pzrMMq2dhag2SpZuYvswVOoDUfGa0VJokfpEYSVQHhHyRX9kU9wK4t26c41IVOIrSnXyYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817776; c=relaxed/simple;
	bh=8c8+k1KMqVchrzV+7t1TU5OALfZGhctER0Lu8nT8PkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKL9srRB6LBdErbZH50mEOhLw6dbivmbbm7NyTbsjeBrCKZgCPh3SEJpKX2Styu7nFegdfohfb02I7A1derbVp2F33V4mR9VHPOdDA+231z2Umy3HuSbL/EXRccSEXdTuBk3rVEa92N0HRkrhLSxEvPyddaZpyzAWEwGlOyJEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPrNJoM8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPrNJoM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817774; x=1801353774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8c8+k1KMqVchrzV+7t1TU5OALfZGhctER0Lu8nT8PkQ=;
  b=IPrNJoM8q1tl/r7p+PvOu1/6HxBifvCFpdiCktwC1wAdvRA44APJPvoq
   Q8zsaj2Q3yNXIXW+5G9/09drG1WZmfrrE0EPEy/eED6csbkX7lF2hktBD
   aqIBwbjdFoasdC3ZdYyTyM4dU4m9OpZpwaQ8TXzrZDRhj2RYBhDNxTkdc
   sztc0jejIGnJoJAj2+jrxe77ymG5IN9IW5u0FeNCpglz2i7So0l85W34F
   pz4Dul/PV/xMVQS6XJ1hG1//pgm8tKKZisFVIzTkgm8TCxoNtPeIOkB0l
   Lfr+LPiwgtkUkI12RruDpOmBJLQ7Z8Or77JM+/+WeTfnVaQt+DJUSuiuN
   g==;
X-CSE-ConnectionGUID: YCwhr2PkRriFB7d5xAlw/g==
X-CSE-MsgGUID: Waz0afQrT++m8yZeFIb4BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71156918"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71156918"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:02:50 -0800
X-CSE-ConnectionGUID: g7G7P8UyTCyHn+tIyzFUxA==
X-CSE-MsgGUID: Ma6xSaezQySD1IhrHLEnQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208093726"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa006.jf.intel.com with ESMTP; 30 Jan 2026 16:02:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	alison.schofield@intel.com,
	dave.jiang@intel.com,
	terry.bowman@amd.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 6/9] cxl/port: Move dport RAS setup to dport add time
Date: Fri, 30 Jan 2026 16:04:00 -0800
Message-ID: <20260131000403.2135324-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131000403.2135324-1-dan.j.williams@intel.com>
References: <20260131000403.2135324-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Towards the end goal of making all CXL RAS capability handling uniform
across host bridge ports, upstream switch ports, and endpoint ports, move
dport RAS setup. Move it to cxl_switch_port_probe() context for switch / VH
dports (via cxl_port_add_dport()) and cxl_endpoint_port_probe() context for
an RCH dport. Rename the RAS setup helper to devm_cxl_dport_ras_setup() for
symmetry with devm_cxl_switch_port_decoders_setup().

Only the RCH version needs to be exported and the cxl_test mocking can be
deleted with a dev_is_pci() check on the dport_dev.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h       | 10 ++++++++++
 drivers/cxl/cxlpci.h          |  8 ++++----
 drivers/cxl/core/port.c       | 12 +++---------
 drivers/cxl/core/ras.c        | 30 ++++++++++++++++++------------
 drivers/cxl/mem.c             |  2 --
 drivers/cxl/port.c            | 12 ++++++++++++
 tools/testing/cxl/test/mock.c | 12 ------------
 tools/testing/cxl/Kbuild      |  1 -
 8 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 422531799af2..be3c7b137115 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -144,6 +144,14 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
+static inline struct device *dport_to_host(struct cxl_dport *dport)
+{
+	struct cxl_port *port = dport->port;
+
+	if (is_cxl_root(port))
+		return port->uport_dev;
+	return &port->dev;
+}
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
@@ -152,6 +160,7 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
+void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -166,6 +175,7 @@ static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 6f9c78886fd9..0db3d73548aa 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -81,7 +81,7 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 
@@ -90,9 +90,9 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 {
 	return PCI_ERS_RESULT_NONE;
 }
-
-static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
-						struct device *host) { }
+static inline void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
+{
+}
 #endif
 
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7356e1725db8..9f56f7e75e81 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1119,15 +1119,6 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
-static struct device *dport_to_host(struct cxl_dport *dport)
-{
-	struct cxl_port *port = dport->port;
-
-	if (is_cxl_root(port))
-		return port->uport_dev;
-	return &port->dev;
-}
-
 static void free_dport(void *dport)
 {
 	kfree(dport);
@@ -1261,6 +1252,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_debugfs_create_dport_dir(dport);
 
+	if (!dport->rch)
+		devm_cxl_dport_ras_setup(dport);
+
 	/* keep the group, and mark the end of devm actions */
 	cxl_dport_close_dr_group(dport, no_free_ptr(dport_dr_group));
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 72908f3ced77..e90b7a91bf5d 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -139,26 +139,32 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
 }
 
 /**
- * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
+ * devm_cxl_dport_ras_setup - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
- * @host: host device for devm operations
  */
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
 {
-	dport->reg_map.host = host;
+	dport->reg_map.host = dport_to_host(dport);
 	cxl_dport_map_ras(dport);
+}
 
-	if (dport->rch) {
-		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
+void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
+{
+	struct pci_host_bridge *host_bridge;
 
-		if (!host_bridge->native_aer)
-			return;
+	if (!dev_is_pci(dport->dport_dev))
+		return;
 
-		cxl_dport_map_rch_aer(dport);
-		cxl_disable_rch_root_ints(dport);
-	}
+	devm_cxl_dport_ras_setup(dport);
+
+	host_bridge = to_pci_host_bridge(dport->dport_dev);
+	if (!host_bridge->native_aer)
+		return;
+
+	cxl_dport_map_rch_aer(dport);
+	cxl_disable_rch_root_ints(dport);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
+EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
 
 void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c2ee7f7f6320..e25c33f8c6cf 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -166,8 +166,6 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
-
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
 			dev_err(dev, "CXL port topology %s not enabled\n",
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 913c469e067a..929f7e259f0d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -71,6 +71,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+	struct cxl_dport *dport = port->parent_dport;
 	int rc;
 
 	/* Cache the data early to ensure is_visible() works */
@@ -86,6 +87,17 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	/*
+	 * With VH (CXL Virtual Host) topology the cxl_port::add_dport() method
+	 * handles RAS setup for downstream ports. With RCH (CXL Restricted CXL
+	 * Host) topologies the downstream port is enumerated early by platform
+	 * firmware, but the RCRB (root complex register block) is not mapped
+	 * until after the cxl_pci driver attaches to the RCIeP (root complex
+	 * integrated endpoint).
+	 */
+	if (dport->rch)
+		devm_cxl_dport_rch_ras_setup(dport);
+
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index f307c5b39184..b8fcb50c1027 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -234,18 +234,6 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, "CXL");
 
-void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
-{
-	int index;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (!ops || !ops->is_mock_port(dport->dport_dev))
-		cxl_dport_init_ras_reporting(dport, host);
-
-	put_cxl_mock_ops(index);
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
-
 struct cxl_dport *__wrap_devm_cxl_add_dport_by_dev(struct cxl_port *port,
 						   struct device *dport_dev)
 {
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 9b2d514a867e..982e8ea28b92 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -7,7 +7,6 @@ ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=devm_cxl_add_rch_dport
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
-ldflags-y += --wrap=cxl_dport_init_ras_reporting
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
 ldflags-y += --wrap=hmat_get_extended_linear_cache_size
 ldflags-y += --wrap=devm_cxl_add_dport_by_dev
-- 
2.52.0

