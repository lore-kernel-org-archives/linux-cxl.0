Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C165298CA5
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585244; cv=none; b=b4u1Lo1hHiJL/bOr0QH6RWsNAIKNX67UvB2745Q85dvdSQeLoA/yXt3kWdZpgV36c1KbIEnBcpRbAK15w7Ysov2cwFY8LEOqeMjWwy58rzaiDKdAbr0C3DmBMZaHlQN7qhh/Ngcg+3RPHAfJSqtGGhTltyKQT0KVCnnfQF73nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585244; c=relaxed/simple;
	bh=KgISCBctjSuFXk6HSJZfGObJgI7JB97M+AMc7QwTFwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnFPlM9GLDIlU1nVu+ePeMsxkmUjHWarab1Ou+mvf/Gez41FGoREau2+zjwFP01vX3Od1afuNrMubcTlQwiFh5mLOJrtB8/Im+ml6juRQIGwzivb9sVqp5zvg0frWBJfhpdjuK7TxDp4s2yKz4d86EbCSoQxhiMGfKtUS3qrxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CEDC4CEE3;
	Thu,  3 Jul 2025 23:27:23 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v5 05/10] cxl/test: Add cxl_test support for cxl_port_update_total_ports()
Date: Thu,  3 Jul 2025 16:27:05 -0700
Message-ID: <20250703232710.3141436-6-dave.jiang@intel.com>
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

In the delayed dport allocation scheme, the total number of dports
need to be discovered during port probe. Add the mock function
that does it for cxl_test.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Update to support cxl_port_update_total_dports()
- Consolidate common code for getting the port array (Jonathan)
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

