Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141896BFCE
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817776; cv=none; b=Ti+Ejhac5CqXPH5aODBUbgnAcsWzEwbfSYrZ7Wd/rDqYztowYOQEKWhSB+dcbQi4kq74CkNNgUIdPQUJAgc89hirlETGBB05kNuQzndFxtbFMYWdIhd8FMV3vK4P7Hth52cONOHe+BVr5BnTLJ6bC3IkwWAtTJ2vDtofpdtaUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817776; c=relaxed/simple;
	bh=xIqQ0q8rTUwHqyl/JhdyVBe5pRAq+17YPP+3pxdsQNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPV/aWKzSpWGyAsMkYSDymOClsNgvzW7TH2cQEokkOHK/fz3IdDvnl4CbpyXhy1rAwfLMOCJQzB49sFVzIBbiNIOOFjACiIk1xMst5GCwckxTbieq9OhhIf5qbB5JYjzNAMzzURtXbBenWc+hK1NxgBzqTqeoGlKH/7ia1uo7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuLphx8N; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuLphx8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817775; x=1801353775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xIqQ0q8rTUwHqyl/JhdyVBe5pRAq+17YPP+3pxdsQNg=;
  b=QuLphx8ND8imobwNB2Ih7gk26w+Hqu2CrzrDt6kj7g/ehZU8UBDAW3Jr
   sXuTtldEKO53Ii0vFmqlM/rX3UQ9wVMU6OqDuWpsnCW0CM+GJimERZf2U
   qJZfUMW5e8RLB31dsFcKwBJO72iwqkJxkIFWI3vxBDJFM6cJBkm61MPr4
   QPm/mqhPvOeDrN5sWMeOqbQ6aUCFyXIfo3L686qbfOxyfczTlahMOFxba
   agHP32F1OxsssxocLLghBvw5WtkcvLzpG3pUGCq5ysIhyeD42K4H0k4mc
   NNEm2/7UFOjcfNG68oAa8e9SaHUBnM4JIhwIs6mIcp0p/VKUw59L3JItj
   A==;
X-CSE-ConnectionGUID: AdgI+bCeRImACswhsOfqNQ==
X-CSE-MsgGUID: aCS2kYl6TmGYgOodEfkx1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71156920"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71156920"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:02:50 -0800
X-CSE-ConnectionGUID: GufOs7X+S7ylBa/dXNN8+g==
X-CSE-MsgGUID: SLSrTh85Sn+ALmFJ+vzgjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208093729"
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
Subject: [PATCH v2 7/9] cxl/port: Map Port RAS registers
Date: Fri, 30 Jan 2026 16:04:01 -0800
Message-ID: <20260131000403.2135324-8-dan.j.williams@intel.com>
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

From: Terry Bowman <terry.bowman@amd.com>

In preparation for CXL VH (Virtual Host) topology protocol error handling,
add RAS capability registered mapping for all ports in a CXL VH topology.
This includes the RAS capabilities of Switch Upstream Ports, Switch
Downstream Ports, Host Bridge Ports ("upstream"), and Root Ports
("downstream")

Update cxl_port_add_dport() to map the upstream RAS capability on first
'dport' attach.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/cxlpci.h   |  4 ++++
 drivers/cxl/core/ras.c | 16 ++++++++++++++++
 drivers/cxl/port.c     |  6 ++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4479d632a687..626a37b72fc3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -607,6 +607,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -628,6 +629,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0db3d73548aa..970add0256e9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -82,6 +82,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
+void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 
@@ -93,6 +94,9 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 static inline void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
 {
 }
+static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
+{
+}
 #endif
 
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index e90b7a91bf5d..b4be9c5715a6 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -166,6 +166,22 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
 
+void devm_cxl_port_ras_setup(struct cxl_port *port)
+{
+	struct cxl_register_map *map = &port->reg_map;
+
+	if (!map->component_map.ras.valid) {
+		dev_dbg(&port->dev, "RAS registers not found\n");
+		return;
+	}
+
+	map->host = &port->dev;
+	if (cxl_map_component_regs(map, &port->regs,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
+
 void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 {
 	void __iomem *addr;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 929f7e259f0d..6ebd665fb347 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -192,6 +192,12 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		rc = devm_cxl_switch_port_decoders_setup(port);
 		if (rc)
 			return ERR_PTR(rc);
+
+		/*
+		 * RAS setup is optional, either driver operation can continue
+		 * on failure, or the device does not implement RAS registers.
+		 */
+		devm_cxl_port_ras_setup(port);
 	}
 
 	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
-- 
2.52.0

