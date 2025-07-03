Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAE2D94B6
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585248; cv=none; b=VY1lpofWVJ5Pr7b+CtYURMECVWHPe0RQ1FC5ur2jnWw05NAoybFKoXq5CNwj4zVQ48Mjtg55RZxfKaAiSmYgesyynDIfovEBnm2pJhktnabXkLRywCntGKrWg4G2+VKFGYooen1gY0eMED1LI9RczZMLomFTlT1bVYvwE6g8UmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585248; c=relaxed/simple;
	bh=MnR6qPLdtkyChdq+nFzOI9HFGyH9onKrBhegrtPjqLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAFNFWFwmNJ5cVPlHqeaAkcZ1fmkS3a3D0O7st844PnuHbvCHMxwZPw17Bt7Vh4yO+6acoYP9Zxd4LXF+K/EusKytnUcImjFPiVux0h8krn1aKSI0Og0Ku7PsOIna4zUz2BGNVxqzbMX67tCUPMeWSX+usqmEyudXGbp87K1RTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9E1C4CEE3;
	Thu,  3 Jul 2025 23:27:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v5 08/10] cxl: Create an xarray to tie a host bridge to the cxl_root
Date: Thu,  3 Jul 2025 16:27:08 -0700
Message-ID: <20250703232710.3141436-9-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703232710.3141436-1-dave.jiang@intel.com>
References: <20250703232710.3141436-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper functions to setup association of a host bridge device to a
related cxl_root. Functions are in preparation to support the moving
of host bridge ports creation from cxl_acpi to cxl_memdev probe path.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 53 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  4 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1e57e7e9f0cc..1089fce24293 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -38,6 +38,7 @@ DECLARE_RWSEM(cxl_region_rwsem);
 
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
+static DEFINE_XARRAY(cxl_root_ports);
 
 /*
  * The terminal device in PCI is NULL and @platform_bus
@@ -1014,6 +1015,58 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, "CXL");
 
+/**
+ * cxl_hb_uport_dev_to_root - Retrieve cxl_root tied to the host bridge device
+ * @hb_uport_dev: host bridge upstream port device
+ *
+ * Return cxl_root on success or NULL on failure
+ *
+ * A reference is taken on the port device. Caller needs to call put_device()
+ * when done.
+ */
+struct cxl_root *cxl_hb_uport_dev_to_root(struct device *hb_uport_dev)
+{
+	struct cxl_root *root;
+
+	root = xa_load(&cxl_root_ports, (unsigned long)hb_uport_dev);
+	if (!root)
+		return NULL;
+
+	get_device(&root->port.dev);
+
+	return root;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_hb_uport_dev_to_root, "CXL");
+
+static void unregister_hb_uport_root_ports(void *hb_uport_dev)
+{
+	xa_erase(&cxl_root_ports, (unsigned long)hb_uport_dev);
+}
+
+/**
+ * devm_cxl_register_hb_uport_root_port - Tie a hostbridge device to a root port
+ * @host: device that hosts the memory for the xarray entries
+ * @hb_uport_dev: host bridge device that serves as the xarray index
+ * @root: cxl_root that serves as the xarray entry data
+ *
+ * Return 0 on success or -errno on failure.
+ */
+int devm_cxl_register_hb_uport_root_port(struct device *host,
+					 struct device *hb_uport_dev,
+					 struct cxl_root *root)
+{
+	int rc;
+
+	rc = xa_insert(&cxl_root_ports, (unsigned long)hb_uport_dev, root,
+		       GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(host, unregister_hb_uport_root_ports,
+					hb_uport_dev);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_register_hb_uport_root_port, "CXL");
+
 static bool dev_is_cxl_root_child(struct device *dev)
 {
 	struct cxl_port *port, *parent;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cc5e0858824b..f88a7ab8d94b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -734,6 +734,10 @@ struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 			      struct pci_bus *bus);
 struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
+int devm_cxl_register_hb_uport_root_port(struct device *host,
+					 struct device *hb_uport_dev,
+					 struct cxl_root *root);
+struct cxl_root *cxl_hb_uport_dev_to_root(struct device *uport_dev);
 struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct device *uport_dev,
 				   resource_size_t component_reg_phys,
-- 
2.50.0

