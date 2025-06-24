Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469E25A2C7
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801167; cv=none; b=IQo9bSle+V3NHwzz8QjAFWTpH4jfplZueSGIVik2r/dl1pgvSApL0vvXFH4Jd1pvOnXW7t/KlcHCwwQOwttKkCddNlefSrJmKF6bb3khmWVYTAkNOUuhndTkB7itcR8b2UVjPyuMCIqe3WDegI4s9ewv4bWyKuYoODfMmRp6rkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801167; c=relaxed/simple;
	bh=gNVxDFvHqrV4XD6xy4aVkVPKuwEwsagWsxdsISkJZfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg8a0bfnV9tmLs4RUfnwioh81AggMnssiWPfbTy87F3sy7iYqfHpToluQNNLlZ8G3ORMCXHjkE2G/FrTg8j+gd5SmBsgxYiv+zqMlyc7twqMrYOVZ8vOXrAMYvQ9I/PZbffbxZ4vi/tR+yEWuxYBwxCAdv3oxNreLQqFIuQqc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11752C4CEE3;
	Tue, 24 Jun 2025 21:39:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH v4 5/9] cxl/test: Add cxl_test support for new dport allocation scheme
Date: Tue, 24 Jun 2025 14:39:12 -0700
Message-ID: <20250624213916.1665889-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624213916.1665889-1-dave.jiang@intel.com>
References: <20250624213916.1665889-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/cxl.c  | 60 +++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mock.c | 15 +++++++++
 tools/testing/cxl/test/mock.h |  1 +
 4 files changed, 77 insertions(+)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 31a2d73c963f..1f05497c44e1 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -5,6 +5,7 @@ ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
+ldflags-y += --wrap=cxl_port_get_total_dports
 ldflags-y += --wrap=devm_cxl_setup_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8a5815ca870d..5d6585d4b15e 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -920,6 +920,65 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	return 0;
 }
 
+static int mock_cxl_port_get_total_dports(struct cxl_port *port)
+{
+	struct platform_device **array;
+	int i, array_size;
+	int dports = 0;
+
+	if (port->depth == 1) {
+		if (is_multi_bridge(port->uport_dev)) {
+			array_size = ARRAY_SIZE(cxl_root_port);
+			array = cxl_root_port;
+		} else if (is_single_bridge(port->uport_dev)) {
+			array_size = ARRAY_SIZE(cxl_root_single);
+			array = cxl_root_single;
+		} else {
+			dev_dbg(&port->dev, "%s: unknown bridge type\n",
+				dev_name(port->uport_dev));
+			return -ENXIO;
+		}
+	} else if (port->depth == 2) {
+		struct cxl_port *parent = to_cxl_port(port->dev.parent);
+
+		if (is_multi_bridge(parent->uport_dev)) {
+			array_size = ARRAY_SIZE(cxl_switch_dport);
+			array = cxl_switch_dport;
+		} else if (is_single_bridge(parent->uport_dev)) {
+			array_size = ARRAY_SIZE(cxl_swd_single);
+			array = cxl_swd_single;
+		} else {
+			dev_dbg(&port->dev, "%s: unknown bridge type\n",
+				dev_name(port->uport_dev));
+			return -ENXIO;
+		}
+	} else {
+		dev_WARN_ONCE(&port->dev, 1, "unexpected depth %d\n",
+			      port->depth);
+		return -ENXIO;
+	}
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
 static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 {
 	struct platform_device **array;
@@ -1035,6 +1094,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
+	.cxl_port_get_total_dports = mock_cxl_port_get_total_dports,
 	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
 	.devm_cxl_add_passthrough_decoder = mock_cxl_add_passthrough_decoder,
 	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 1989ae020df3..c92cc3a4f0b9 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -196,6 +196,21 @@ int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_enumerate_dports, "CXL");
 
+int __wrap_cxl_port_get_total_dports(struct cxl_port *port)
+{
+	int rc, index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(port->uport_dev))
+		rc = ops->cxl_port_get_total_dports(port);
+	else
+		rc = cxl_port_get_total_dports(port);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_port_get_total_dports, "CXL");
+
 int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 {
 	int rc, index;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index d1b0271d2822..9f9685d0f00c 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -20,6 +20,7 @@ struct cxl_mock_ops {
 	bool (*is_mock_port)(struct device *dev);
 	bool (*is_mock_dev)(struct device *dev);
 	int (*devm_cxl_port_enumerate_dports)(struct cxl_port *port);
+	int (*cxl_port_get_total_dports)(struct cxl_port *port);
 	struct cxl_hdm *(*devm_cxl_setup_hdm)(
 		struct cxl_port *port, struct cxl_endpoint_dvsec_info *info);
 	int (*devm_cxl_add_passthrough_decoder)(struct cxl_port *port);
-- 
2.49.0

