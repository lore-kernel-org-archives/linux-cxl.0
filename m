Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67022F152
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532547; cv=none; b=TKZI101h1lKWa1eM/cyfKe/2bEQeux8Hj3Lira1YKG1B3mdx0yPuMdeMeDl2tqEKa9yZjfNm1j7udBxs4TKrkWGqW02Y2uhcxX3UtdNHFSNVjYj6gK3AO+ZExMWi1KWSHJTakEnRbLJVjm943UtyJNYNPWadHhB47tzIB/Q2Opw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532547; c=relaxed/simple;
	bh=zzDANcNGgXxnCVh7E9ovMoWIwdICKyd41VldbAjCSao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8+OivzXEeEkxHD7WdjoM9FdIBjrpbZOp2Qibh+LlQwy3QCRgMa5VTNUI2lfDVKtL61OlPb+4rCiqDsM5E5vRUMWbLip9bfzr/LISly8G87GdkNtAnEwyrHXjT5KtJLn+KkDbs5zYvhD2ecX5/k0uFxaFfYJLFrhvHaPiRpzEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45F9C4CEED;
	Mon, 14 Jul 2025 22:35:46 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v7 05/10] cxl/test: Add cxl_test support for cxl_port_update_total_ports()
Date: Mon, 14 Jul 2025 15:35:22 -0700
Message-ID: <20250714223527.461147-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714223527.461147-1-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the delayed dport allocation scheme, the total number of dports
need to be discovered during port probe. Add the mock function
that does it for cxl_test.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/cxl.c  | 53 +++++++++++++++++++++++++++++++++--
 tools/testing/cxl/test/mock.c | 15 ++++++++++
 tools/testing/cxl/test/mock.h |  1 +
 4 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 31a2d73c963f..b9fbaaca999e 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -5,6 +5,7 @@ ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
+ldflags-y += --wrap=cxl_port_update_total_dports
 ldflags-y += --wrap=devm_cxl_setup_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8a5815ca870d..6fd1eaca6cbe 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -920,10 +920,12 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	return 0;
 }
 
-static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
+static int get_port_array(struct cxl_port *port,
+			  struct platform_device ***port_array,
+			  int *port_array_size)
 {
 	struct platform_device **array;
-	int i, array_size;
+	int array_size;
 
 	if (port->depth == 1) {
 		if (is_multi_bridge(port->uport_dev)) {
@@ -957,6 +959,52 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 		return -ENXIO;
 	}
 
+	*port_array = array;
+	*port_array_size = array_size;
+
+	return 0;
+}
+
+static int mock_cxl_port_update_total_dports(struct cxl_port *port)
+{
+	struct platform_device **array;
+	int rc, i, array_size;
+	int dports = 0;
+
+	rc = get_port_array(port, &array, &array_size);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < array_size; i++) {
+		struct platform_device *pdev = array[i];
+
+		if (pdev->dev.parent != port->uport_dev) {
+			dev_dbg(&port->dev, "%s: mismatch parent %s\n",
+				dev_name(port->uport_dev),
+				dev_name(pdev->dev.parent));
+			continue;
+		}
+
+		dports++;
+	}
+
+	if (!dports)
+		return -ENXIO;
+
+	port->total_dports = dports;
+
+	return 0;
+}
+
+static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
+{
+	struct platform_device **array;
+	int rc, i, array_size;
+
+	rc = get_port_array(port, &array, &array_size);
+	if (rc)
+		return rc;
+
 	for (i = 0; i < array_size; i++) {
 		struct platform_device *pdev = array[i];
 		struct cxl_dport *dport;
@@ -1035,6 +1083,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
+	.cxl_port_update_total_dports = mock_cxl_port_update_total_dports,
 	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
 	.devm_cxl_add_passthrough_decoder = mock_cxl_add_passthrough_decoder,
 	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 1989ae020df3..6272c0691275 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -196,6 +196,21 @@ int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_enumerate_dports, "CXL");
 
+int __wrap_cxl_port_update_total_dports(struct cxl_port *port)
+{
+	int rc, index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(port->uport_dev))
+		rc = ops->cxl_port_update_total_dports(port);
+	else
+		rc = cxl_port_update_total_dports(port);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_port_update_total_dports, "CXL");
+
 int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 {
 	int rc, index;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index d1b0271d2822..bf2a3e5581ba 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -20,6 +20,7 @@ struct cxl_mock_ops {
 	bool (*is_mock_port)(struct device *dev);
 	bool (*is_mock_dev)(struct device *dev);
 	int (*devm_cxl_port_enumerate_dports)(struct cxl_port *port);
+	int (*cxl_port_update_total_dports)(struct cxl_port *port);
 	struct cxl_hdm *(*devm_cxl_setup_hdm)(
 		struct cxl_port *port, struct cxl_endpoint_dvsec_info *info);
 	int (*devm_cxl_add_passthrough_decoder)(struct cxl_port *port);
-- 
2.50.0

