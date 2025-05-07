Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C82BD04
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578605; cv=none; b=iws7VWKQ73deN8Dw1woIix1s34RX8xNnP4MfaMAIseHS86+ccOn4ASip3dRBTNwixFbVxxzX7H2IY01tXQVWje0IEdX1ay+XZzOp46T+E4YSPW3q6q9ECSwsWVSXmQlYHL4IQWws8d0KkvIRYWPNhXDzab4kE5T1M6OKDXsh2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578605; c=relaxed/simple;
	bh=/X9/7IiPkCRojTIv8J7ZqEO0uuqS/KQmF0g9ffcmjW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jE9pyYoxXJxhobIhsytcITqqFpmdqbTxBDf0alOJ5sEurndFFliBcrmIENmTvuD4fTfIWUaVt66wL/ErZpSRhd+I2ospVHYXTDS9rF0+vUn8nsO30oEzgV2Pa7IGw5ajZ/ViQ7yy5QL3k6zuM0ct5TfXXfcCk6a82YDl2FOReDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCD5C4CEE4;
	Wed,  7 May 2025 00:43:24 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH v2 09/10] cxl: Create an xarray to tie a host bridge to the cxl_root
Date: Tue,  6 May 2025 17:43:09 -0700
Message-ID: <20250507004310.3536991-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507004310.3536991-1-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
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
 drivers/cxl/core/port.c | 53 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  4 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 259b217e812f..a5a673d789f3 100644
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
+ * cxl_udev_to_root - Retrieve cxl_root tied to the host bridge device
+ * @uport_dev: upstream port device that is the host bridge
+ *
+ * Return cxl_root on success or NULL on failure
+ *
+ * A reference is taken on the port device. Caller needs to call put_device()
+ * when done.
+ */
+struct cxl_root *cxl_udev_to_root(struct device *uport_dev)
+{
+	struct cxl_root *root;
+
+	root = xa_load(&cxl_root_ports, (unsigned long)uport_dev);
+	if (!root)
+		return NULL;
+
+	get_device(&root->port.dev);
+
+	return root;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_udev_to_root, "CXL");
+
+static void unregister_udev_root_ports(void *uport_dev)
+{
+	xa_erase(&cxl_root_ports, (unsigned long)uport_dev);
+}
+
+/**
+ * devm_cxl_register_udev_root_port - Tie a hostbridge device to a root port
+ * @host: device that hosts the memory for the xarray entries
+ * @uport_dev: host bridge device that serves as the xarray index
+ * @root: cxl_root that serves as the xarray entry data
+ *
+ * Return 0 on success or -errno on failure.
+ */
+int devm_cxl_register_udev_root_port(struct device *host,
+				     struct device *uport_dev,
+				     struct cxl_root *root)
+{
+	int rc;
+
+	rc = xa_insert(&cxl_root_ports, (unsigned long)uport_dev, root,
+		       GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(host, unregister_udev_root_ports,
+					uport_dev);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_register_udev_root_port, "CXL");
+
 bool dev_is_cxl_root_child(struct device *dev)
 {
 	struct cxl_port *port, *parent;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 22f1a9542077..e0cba91803cc 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -736,6 +736,10 @@ struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 			      struct pci_bus *bus);
 struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
+int devm_cxl_register_udev_root_port(struct device *host,
+				     struct device *uport_dev,
+				     struct cxl_root *root);
+struct cxl_root *cxl_udev_to_root(struct device *uport_dev);
 struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct device *uport_dev,
 				   resource_size_t component_reg_phys,
-- 
2.49.0

