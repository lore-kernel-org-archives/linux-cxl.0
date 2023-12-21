Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBC77F34
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dapWEiy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196215; x=1734732215;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yq4IQVAlJqKkP80IbEpBqAy1dmmiAjl5H+gDcbYmWOM=;
  b=dapWEiy+O/8K2loyW/XSnkHiebND/ol045nTX1fb0zDz20bXPUwxTUjI
   Vx1OjLPYMODjiG5/biKDd4OhhxMioiGl2/1Ug5eARolUjorTy7Q0I4s9h
   vMUmhJq/GHWPfNgUhmib8t5dPC4/w7HMiIVnJ12ULBFe+ioUWaCzEe4RI
   9tBIZwX85xShWy4ANMq04VW/BqoZ7dRxS43oxymheJSRBRUbKHj9fvBI7
   PoAGq/6V5k5Iqfr7uDtR/hb8iyFJn+3qo16hHTECiXyWY9lW1pdBXI6ET
   6fyS5h35Qpca1yGszC7otuyccimZjgOgNTHaycnuZSOmmp5SreQnIFNho
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2873875"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="2873875"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="770083859"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="770083859"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:33 -0800
Subject: [PATCH v15 11/19] cxl: Add support for _DSM Function for retrieving
 QTG ID
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:03:32 -0700
Message-ID: <170319621294.2212653.1649682083061569256.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)

Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
an input of an ACPI package with 4 dwords (read latency, write latency,
read bandwidth, write bandwidth). The call returns a package with 1 WORD
that provides the max supported QTG ID and a package that may contain 0 or
more WORDs as the recommended QTG IDs in the recommended order.

Create a cxl_root container for the root cxl_port and provide a callback
->get_qos_class() in order to retrieve the QoS class. For the ACPI case,
the _DSM helper is used to retrieve the QTG ID and returned. A
devm_cxl_add_root() function is added for root port setup and registration
of the cxl_root callback operation(s).

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/acpi.c      |  132 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/port.c |   41 +++++++++++++--
 drivers/cxl/cxl.h       |   25 +++++++++
 3 files changed, 190 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 2034eb4ce83f..2f7de910ce57 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
+#include <linux/node.h>
 #include <asm/div64.h>
 #include "cxlpci.h"
 #include "cxl.h"
@@ -17,6 +18,10 @@ struct cxl_cxims_data {
 	u64 xormaps[] __counted_by(nr_maps);
 };
 
+static const guid_t acpi_cxl_qtg_id_guid =
+	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
+		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
+
 /*
  * Find a targets entry (n) in the host bridge interleave list.
  * CXL Specification 3.0 Table 9-22
@@ -194,6 +199,125 @@ struct cxl_cfmws_context {
 	int id;
 };
 
+/**
+ * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
+ * @handle: ACPI handle
+ * @coord: performance access coordinates
+ * @entries: number of QTG IDs to return
+ * @qos_class: int array provided by caller to return QTG IDs
+ *
+ * Return: number of QTG IDs returned, or -errno for errors
+ *
+ * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
+ * the QTG IDs that are suitable for the performance point in order of most
+ * suitable to least suitable. Write back array of QTG IDs and return the
+ * actual number of QTG IDs written back.
+ */
+static int
+cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
+			  int entries, int *qos_class)
+{
+	union acpi_object *out_obj, *out_buf, *obj;
+	union acpi_object in_array[4] = {
+		[0].integer = { ACPI_TYPE_INTEGER, coord->read_latency },
+		[1].integer = { ACPI_TYPE_INTEGER, coord->write_latency },
+		[2].integer = { ACPI_TYPE_INTEGER, coord->read_bandwidth },
+		[3].integer = { ACPI_TYPE_INTEGER, coord->write_bandwidth },
+	};
+	union acpi_object in_obj = {
+		.package = {
+			.type = ACPI_TYPE_PACKAGE,
+			.count = 4,
+			.elements = in_array,
+		},
+	};
+	int count, pkg_entries, i;
+	u16 max_qtg;
+	int rc;
+
+	if (!entries)
+		return -EINVAL;
+
+	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
+	if (!out_obj)
+		return -ENXIO;
+
+	if (out_obj->type != ACPI_TYPE_PACKAGE) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	/* Check Max QTG ID */
+	obj = &out_obj->package.elements[0];
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	max_qtg = obj->integer.value;
+
+	/* It's legal to have 0 QTG entries */
+	pkg_entries = out_obj->package.count;
+	if (pkg_entries <= 1) {
+		rc = 0;
+		goto out;
+	}
+
+	/* Retrieve QTG IDs package */
+	obj = &out_obj->package.elements[1];
+	if (obj->type != ACPI_TYPE_PACKAGE) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	pkg_entries = obj->package.count;
+	count = min(entries, pkg_entries);
+	for (i = 0; i < count; i++) {
+		u16 qtg_id;
+
+		out_buf = &obj->package.elements[i];
+		if (out_buf->type != ACPI_TYPE_INTEGER) {
+			rc = -ENXIO;
+			goto out;
+		}
+
+		qtg_id = out_buf->integer.value;
+		if (qtg_id > max_qtg)
+			pr_warn("QTG ID %u greater than MAX %u\n",
+				qtg_id, max_qtg);
+
+		qos_class[i] = qtg_id;
+	}
+	rc = count;
+
+out:
+	ACPI_FREE(out_obj);
+	return rc;
+}
+
+static int cxl_acpi_qos_class(struct cxl_port *root_port,
+			      struct access_coordinate *coord, int entries,
+			      int *qos_class)
+{
+	acpi_handle handle;
+	struct device *dev;
+
+	dev = root_port->uport_dev;
+
+	if (!dev_is_platform(dev))
+		return -ENODEV;
+
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return -ENODEV;
+
+	return cxl_acpi_evaluate_qtg_dsm(handle, coord, entries, qos_class);
+}
+
+static const struct cxl_root_ops acpi_root_ops = {
+	.qos_class = cxl_acpi_qos_class,
+};
+
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 			   const unsigned long end)
 {
@@ -656,6 +780,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
 	struct resource *cxl_res;
+	struct cxl_root *cxl_root;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(host);
@@ -675,9 +800,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	cxl_res->end = -1;
 	cxl_res->flags = IORESOURCE_MEM;
 
-	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
-	if (IS_ERR(root_port))
-		return PTR_ERR(root_port);
+	cxl_root = devm_cxl_add_root(host, &acpi_root_ops);
+	if (IS_ERR(cxl_root))
+		return PTR_ERR(cxl_root);
+	root_port = &cxl_root->port;
 
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 38441634e4c6..955a99cff22d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -541,7 +541,10 @@ static void cxl_port_release(struct device *dev)
 	xa_destroy(&port->dports);
 	xa_destroy(&port->regions);
 	ida_free(&cxl_port_ida, port->id);
-	kfree(port);
+	if (is_cxl_root(port))
+		kfree(to_cxl_root(port));
+	else
+		kfree(port);
 }
 
 static ssize_t decoders_committed_show(struct device *dev,
@@ -669,13 +672,22 @@ static struct lock_class_key cxl_port_key;
 static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 				       struct cxl_dport *parent_dport)
 {
+	struct cxl_root *cxl_root = NULL;
 	struct cxl_port *port;
 	struct device *dev;
 	int rc;
 
-	port = kzalloc(sizeof(*port), GFP_KERNEL);
-	if (!port)
-		return ERR_PTR(-ENOMEM);
+	/* No parent_dport, root cxl_port */
+	if (!parent_dport) {
+		cxl_root = kzalloc(sizeof(*cxl_root), GFP_KERNEL);
+		if (!cxl_root)
+			return ERR_PTR(-ENOMEM);
+		port = &cxl_root->port;
+	} else {
+		port = kzalloc(sizeof(*port), GFP_KERNEL);
+		if (!port)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	rc = ida_alloc(&cxl_port_ida, GFP_KERNEL);
 	if (rc < 0)
@@ -733,7 +745,10 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	return port;
 
 err:
-	kfree(port);
+	if (cxl_root)
+		kfree(cxl_root);
+	else
+		kfree(port);
 	return ERR_PTR(rc);
 }
 
@@ -884,6 +899,22 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
 
+struct cxl_root *devm_cxl_add_root(struct device *host,
+				   const struct cxl_root_ops *ops)
+{
+	struct cxl_root *cxl_root;
+	struct cxl_port *port;
+
+	port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
+	if (IS_ERR(port))
+		return (struct cxl_root *)port;
+
+	cxl_root = to_cxl_root(port);
+	cxl_root->ops = ops;
+	return cxl_root;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_root, CXL);
+
 struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port)
 {
 	/* There is no pci_bus associated with a CXL platform-root port */
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 22f664b9f4c6..abbdcd3a7596 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -615,6 +615,29 @@ struct cxl_port {
 	bool cdat_available;
 };
 
+struct cxl_root_ops {
+	int (*qos_class)(struct cxl_port *root_port,
+			 struct access_coordinate *coord, int entries,
+			 int *qos_class);
+};
+
+/**
+ * struct cxl_root - logical collection of root cxl_port items
+ *
+ * @port: cxl_port member
+ * @ops: cxl root operations
+ */
+struct cxl_root {
+	struct cxl_port port;
+	const struct cxl_root_ops *ops;
+};
+
+static inline struct cxl_root *
+to_cxl_root(const struct cxl_port *port)
+{
+	return container_of(port, struct cxl_root, port);
+}
+
 static inline struct cxl_dport *
 cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 {
@@ -703,6 +726,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct device *uport_dev,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
+struct cxl_root *devm_cxl_add_root(struct device *host,
+				   const struct cxl_root_ops *ops);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);


