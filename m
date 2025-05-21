Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C05289371
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852498; cv=none; b=XnvTxOq36+hLWXMzmA/OV3GmMjNHvnxqffQydH7z1+hqEMAm0KbcYv1e5QmOhV68MdHKvlY0UsEMHjRCft99blEnoID0lNGcdIvzx8wU1exET+x0XfDNxNxIs2SUJ9Q6cdOiGMkZDK8G5CdBGh/Xi1nR+vbhe0RS19I+Jn2crVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852498; c=relaxed/simple;
	bh=oMsKDVfxLP4UvYenhjsyrFMqd85Eg/exuGcK0zgq/mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhfC1F3mZvOAaZ56INgHP5YkIw65IJV1FrhY4pkm5X052C13l389VLGUyVIelOALJNUZTi+9x4Vv24Dv2hvFees+fPgLVJcK7EWPMvALz5mfZilko1dx/4UPEe9S+fhxGsZVEXWF/rE5pnu06mKzGm7c4Ex01NdwRapMIfkpTjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624A7C4CEE4;
	Wed, 21 May 2025 18:34:58 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v3 8/9] cxl: Create an xarray to tie a host bridge to the cxl_root
Date: Wed, 21 May 2025 11:34:42 -0700
Message-ID: <20250521183443.3828320-9-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521183443.3828320-1-dave.jiang@intel.com>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Rename udev to hb_uport_dev (Gregory)
---
 drivers/cxl/core/port.c | 53 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  4 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5c05cc70787e..7650254fdcb4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -38,6 +38,7 @@ DECLARE_RWSEM(cxl_region_rwsem);
 
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
+static DEFINE_XARRAY(cxl_root_ports);
 
 /*
  * The terminal device in PCI is NULL and @platform_bus
@@ -1013,6 +1014,58 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
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
 bool dev_is_cxl_root_child(struct device *dev)
 {
 	struct cxl_port *port, *parent;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 22f1a9542077..443182146076 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -736,6 +736,10 @@ struct pci_bus;
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
2.49.0

