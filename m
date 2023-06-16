Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8023AEB64D8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 21:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbjFPVmH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245310AbjFPVmG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 17:42:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BB935AE
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686951724; x=1718487724;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfML9GaS6HC2jg6bO3/7UNIrvPyaTvpq5kxAtsqDe18=;
  b=OFIkVTKnMhqArKroP1XY03ojjHIYwvvGzNFfXhRCgmwS5o9cbLV1EJi3
   aYCL5ziRM92Anzw6ogrHIqIaM/+TyAgRfBSxcUR4lNuPQbv/tev48YVYc
   RXVn3vuad1N5U/dmWlkgiKGW7qhCpOgrjPdoA59Z687s4OBlBTyu/1SXl
   XZopI3wGD1L45WzNlegBGU6vRJyXQyJcpYbSG8ATMo9Deo4eYfYRaSEiP
   89hOkeI3jP9s6sNqu1cMnTDCWS5RhQlqfyOB8CplFojHSOgo5HFhUCuhU
   hS8Yw8gbVi+iKWoe/8bt85ODqcYri2150zOhOi8QAaarptjbExijOj1ja
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="362733576"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="362733576"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="959757297"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="959757297"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.91])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:02 -0700
Subject: [PATCH v7 04/11] cxl: Add support for _DSM Function for retrieving
 QTG ID
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 16 Jun 2023 14:42:03 -0700
Message-ID: <168695172301.3031571.9812118774299137032.stgit@djiang5-mobl3>
In-Reply-To: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
References: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
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
 drivers/cxl/acpi.c      |  146 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/port.c |   41 ++++++++++++-
 drivers/cxl/cxl.h       |   36 ++++++++++++
 3 files changed, 215 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index e063df2bf876..8247df06d683 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -17,6 +17,10 @@ struct cxl_cxims_data {
 	u64 xormaps[];
 };
 
+static const guid_t acpi_cxl_qtg_id_guid =
+	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
+		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
+
 /*
  * Find a targets entry (n) in the host bridge interleave list.
  * CXL Specification 3.0 Table 9-22
@@ -194,6 +198,140 @@ struct cxl_cfmws_context {
 	int id;
 };
 
+/**
+ * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
+ * @handle: ACPI handle
+ * @input: bandwidth and latency data
+ *
+ * Return: qos_class output or ERRPTR of -errno
+ *
+ * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
+ * the QTG IDs that are suitable for the performance point in order of most
+ * suitable to least suitable. Return first QTG ID.
+ */
+static struct qos_class *
+cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct qtg_dsm_input *input)
+{
+	union acpi_object *out_obj, *out_buf, *pkg;
+	union acpi_object in_buf = {
+		.buffer = {
+			.type = ACPI_TYPE_BUFFER,
+			.pointer = (u8 *)input,
+			.length = cpu_to_le32(sizeof(*input)),
+		},
+	};
+	union acpi_object in_obj = {
+		.package = {
+			.type = ACPI_TYPE_PACKAGE,
+			.count = cpu_to_le32(1),
+			.elements = &in_buf
+		},
+	};
+	struct qos_class *output;
+	u16 max_qtg;
+	__le16 *ent;
+	int entries;
+	int i, len;
+	int rc = 0;
+
+	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
+	if (!out_obj)
+		return ERR_PTR(-ENXIO);
+
+	if (out_obj->type != ACPI_TYPE_PACKAGE) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	/* Check Max QTG ID */
+	pkg = &out_obj->package.elements[0];
+	if (pkg->type != ACPI_TYPE_BUFFER) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (le32_to_cpu(pkg->buffer.length) != sizeof(u16)) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	max_qtg = le16_to_cpu(*(__le16 *)pkg->buffer.pointer);
+
+	/* Retrieve QTG IDs package */
+	pkg = &out_obj->package.elements[1];
+	if (pkg->type != ACPI_TYPE_PACKAGE) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	out_buf = &pkg->package.elements[0];
+	if (out_buf->type != ACPI_TYPE_BUFFER) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	len = le32_to_cpu(out_buf->buffer.length);
+
+	/* It's legal to have 0 QTG entries */
+	if (len == 0) {
+		rc = -EEXIST;
+		goto out;
+	}
+
+	/* Malformed package, not multiple of WORD size */
+	if (len % sizeof(__le16)) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	entries = len / sizeof(__le16);
+	output = kmalloc(sizeof(*output) + entries * sizeof(int), GFP_KERNEL);
+	if (!output) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	ent = (__le16 *)out_buf->buffer.pointer;
+	for (i = 0; i < entries; i++) {
+		int qtg_id = le16_to_cpu(ent[i]);
+
+		if (qtg_id > max_qtg)
+			pr_warn("QTG ID %u greater than MAX %u\n",
+				qtg_id, max_qtg);
+
+		output->entries[i] = qtg_id;
+	}
+	output->nr = entries;
+
+out:
+	ACPI_FREE(out_obj);
+	if (rc)
+		output = ERR_PTR(rc);
+	return output;
+}
+
+static struct qos_class *
+cxl_acpi_get_qos_class(struct cxl_port *root_port, struct qtg_dsm_input *input)
+{
+	acpi_handle handle;
+	struct device *dev;
+
+	dev = root_port->uport;
+
+	if (!dev_is_platform(dev))
+		return ERR_PTR(-ENODEV);
+
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return ERR_PTR(-ENODEV);
+
+	return cxl_acpi_evaluate_qtg_dsm(handle, input);
+}
+
+static const struct cxl_root_ops acpi_root_ops = {
+	.get_qos_class = cxl_acpi_get_qos_class,
+};
+
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 			   const unsigned long end)
 {
@@ -631,6 +769,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
 	struct resource *cxl_res;
+	struct cxl_root *cxl_root;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(host);
@@ -650,9 +789,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
index 3cf84e456d67..dd18c6eb3833 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -525,7 +525,10 @@ static void cxl_port_release(struct device *dev)
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
@@ -628,13 +631,22 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
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
@@ -692,7 +704,10 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	return port;
 
 err:
-	kfree(port);
+	if (cxl_root)
+		kfree(cxl_root);
+	else
+		kfree(port);
 	return ERR_PTR(rc);
 }
 
@@ -777,6 +792,22 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
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
index 952778230d5f..6733569afac3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -586,6 +586,40 @@ struct cxl_port {
 	bool cdat_available;
 };
 
+struct qtg_dsm_input {
+	__le32 rd_lat;
+	__le32 wr_lat;
+	__le32 rd_bw;
+	__le32 wr_bw;
+};
+
+struct qos_class {
+	int nr;
+	int entries[];
+};
+
+struct cxl_root_ops {
+	struct qos_class *(*get_qos_class)(struct cxl_port *root_port,
+					  struct qtg_dsm_input *input);
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
@@ -665,6 +699,8 @@ struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
+struct cxl_root *devm_cxl_add_root(struct device *host,
+				   const struct cxl_root_ops *ops);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);


