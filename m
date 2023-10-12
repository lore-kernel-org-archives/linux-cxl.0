Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC6133986
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQTZ5+lp"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC76EB7
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136906; x=1728672906;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGfD9zTYV41UpBvCw7Vyc/ljAam3z9Ayc4x8uvMxFMk=;
  b=XQTZ5+lpFaL1XME0pC4nyfNuCClYTYcM4rUcwvyMPziEir1ezqAv/vnW
   lTk9a5ApByeGafEVzoWd3c2wmRl9+lkVtQbtkRPUFLkM56ViR0v1Fvx3A
   u+kIvmPUXSQzCM3xQ9T8JuSC7pgjpUdZfIWRLOl/Fj8Mcf1E2eMJzglz9
   AX8rrB9wgipjPd5JBcUXfvol3oWqcKYvq7ymI89MhvRucrOgiXUUl6Ya1
   GbkUp/Bckly7mN+D+6ku99FXpFjRjA52UTZ6mrrO7aMzBJ5ej/+ao3V7f
   Axt/GR3s+CKNJTQqDhpdMUnmKqQrB9I07yLzhHEaORSr2Ri/b7em429JH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388880367"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388880367"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870711571"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870711571"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:01 -0700
Subject: [PATCH v11 15/22] cxl: Add support for _DSM Function for retrieving
 QTG ID
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:55:00 -0700
Message-ID: <169713690074.2205276.14288360792472635288.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
---
v11:
- Fix function comment header (Jonathan)
- Remove rc init (Jonathan)
- Return 0 when no QTG IDs provided. (Jonathan)
v10:
- Remove allocation in _DSM handler. Change input parameter to request
  number of ids to return.
- Removed Jonathan's review tag due to significant changes
v9:
- Fix input to 4 ints instead of using buffers. (Dan)
- Remove all endien conversion inside acpi handling code. (Dan)
v8:
- Change DSM return package parsing to use integers.
v7:
- Fix stray lines in commit log. (Jonathan)
v5:
- Make the helper a callback for the CXL root. (Dan)
- Drop the addition of core/acpi.c. (Dan)
- Add endiness handling. (Jonathan)
- Refactor error exits. (Jonathan)
- Update evaluate function description. (Jonathan)
- Make uuid static. (Dan)
v2:
- Reorder var declaration and use C99 style. (Jonathan)
- Allow >2 ACPI objects in package for future expansion. (Jonathan)
- Check QTG IDs against MAX QTG ID provided by output package. (Jonathan)
---
 drivers/cxl/acpi.c      |  132 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/port.c |   41 +++++++++++++--
 drivers/cxl/cxl.h       |   25 +++++++++
 3 files changed, 190 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 2034eb4ce83f..1eb477e8274c 100644
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
+	union acpi_object *out_obj, *out_buf, *pkg;
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
+	pkg = &out_obj->package.elements[0];
+	if (pkg->type != ACPI_TYPE_INTEGER) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	max_qtg = pkg->integer.value;
+
+	/* It's legal to have 0 QTG entries */
+	pkg_entries = out_obj->package.count;
+	if (pkg_entries <= 1) {
+		rc = 0;
+		goto out;
+	}
+
+	/* Retrieve QTG IDs package */
+	pkg = &out_obj->package.elements[1];
+	if (pkg->type != ACPI_TYPE_PACKAGE) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	pkg_entries = pkg->package.count;
+	count = min(entries, pkg_entries);
+	for (i = 0; i < count; i++) {
+		u16 qtg_id;
+
+		out_buf = &pkg->package.elements[i];
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
+static int cxl_acpi_get_qos_class(struct cxl_port *root_port,
+				  struct access_coordinate *coord,
+				  int entries, int *qos_class)
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
+	.get_qos_class = cxl_acpi_get_qos_class,
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
index fc31ff8954c0..23403538505b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -528,7 +528,10 @@ static void cxl_port_release(struct device *dev)
 	xa_destroy(&port->dports);
 	xa_destroy(&port->regions);
 	ida_free(&cxl_port_ida, port->id);
-	kfree(port);
+	if (is_cxl_root(port))
+		kfree(to_cxl_root(port));
+	else
+		kfree(port);
 }
 
 static const struct attribute_group *cxl_port_attribute_groups[] = {
@@ -632,13 +635,22 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 				       resource_size_t component_reg_phys,
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
@@ -697,7 +709,10 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	return port;
 
 err:
-	kfree(port);
+	if (cxl_root)
+		kfree(cxl_root);
+	else
+		kfree(port);
 	return ERR_PTR(rc);
 }
 
@@ -821,6 +836,22 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
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
index 2d1fd6d0cce5..587677fc597c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -611,6 +611,29 @@ struct cxl_port {
 	bool cdat_available;
 };
 
+struct cxl_root_ops {
+	int (*get_qos_class)(struct cxl_port *root_port,
+			     struct access_coordinate *coord,
+			     int entries, int *qos_class);
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
@@ -696,6 +719,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct device *uport_dev,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
+struct cxl_root *devm_cxl_add_root(struct device *host,
+				   const struct cxl_root_ops *ops);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);


