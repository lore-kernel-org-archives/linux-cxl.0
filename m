Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB53F0742
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052747; cv=none; b=jWf77KxVV5yNjMWJ3G53DOCjzIafc02yp0ZfpOBcLIUKfJhFJjVy1vDdd3KlqyllBk70G0vNUbK2MOS/I0spxbevOIPXVfxWG0UV43oABHV59cTG0QFFIflYPrahvXlnU5qhC6fLTh3bTKdcwajLG5M8etXuUsLoIs2ePLbZPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052747; c=relaxed/simple;
	bh=JVQcR4j2395dnkKetxYgvaXojhp6GoVN9FG3whWaR7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjiQ+2aFft+ge183k3wb1oI0hpgrZjMCPuw3rFoghXJRYO1KuF+Vnipwoi1Z4EOE5SQcxZzmEChf7tbs1q7O7fL1G3oAbanaXUB2qC8GXJIQzeGJwQn/VO+UnhhiQFy8XGU6CmSGMWYNBy/YlIvA5kBmoHc+THfh3pLtL5wqCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIYzfDrC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIYzfDrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769052745; x=1800588745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JVQcR4j2395dnkKetxYgvaXojhp6GoVN9FG3whWaR7M=;
  b=fIYzfDrC75tjp1rzIlhmzr2SlxsGUfxUtT32QdNbSKE5y5x4RcPwwG6H
   uz3ewFdVj8e2k/E3Ztp26W0TThkYw96ygInkvdm9Zl/ZFFoOa5+MAo6JG
   tul0SpUtAVkhLsl7eYuDcNPnWUEeOXGFreqpVpqyspZZzlXFSAbLCg2NR
   GWPDdOL5M7oAGcBRqOA8tIoCyDFNTHVHxXYsv4TwZVGYHpQPMJKGmgk/O
   PPV22gtHe2HNzdWTVNa6jS6rciCF5lfE0J+VbHCe0rCqPChEPYEwPThPy
   urY/BKgGJMV0/PhJB8OKBMbj2Ew7eZTH5nvrXEBgUgkighdQJH3YEyyR/
   A==;
X-CSE-ConnectionGUID: AmRmhl/0R5+ET5o7j5U1VQ==
X-CSE-MsgGUID: EAtNjuMhRuu5NDZDiUbB4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81734460"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="81734460"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:32:19 -0800
X-CSE-ConnectionGUID: /5cv1eK0TYimUtwH6mRr3Q==
X-CSE-MsgGUID: 5uAkIpz3TxmhnsJY2ZsW7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211064111"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa005.fm.intel.com with ESMTP; 21 Jan 2026 19:32:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	terry.bowman@amd.com
Subject: [PATCH 7/9] cxl/port: Map CXL Endpoint Port and CXL Switch Port RAS registers
Date: Wed, 21 Jan 2026 19:33:28 -0800
Message-ID: <20260122033330.1622168-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122033330.1622168-1-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/cxlpci.h   |  4 ++++
 drivers/cxl/core/ras.c | 16 ++++++++++++++++
 drivers/cxl/port.c     |  6 ++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 75ff5f055f7f..3e0e82523bfd 100644
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
index 2988533fb0a2..50a643cb3e04 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -202,6 +202,12 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
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

