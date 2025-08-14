Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CD14A60F
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210178; cv=none; b=TgwSmdcIKX6ajfNslTFgh3fhy1yIv+bUVZhviTLbzi76cFzmo9bgwAsBxS3WdGvxgvc89TgbZcfZAh2QVXWmUeObCNN2jiA+KSxgUO3yFxD63rCuadFC5YCAKXu/e/DpATJKeK9tI4wF379r94lCfCoTfRCVGW9zMIRBs9bREi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210178; c=relaxed/simple;
	bh=d/CyOan2Q7QHgiWgmx1dW4u8meDRRpj19+iMmwfV4Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjERFdpVoZWYvhs5P4BvDNjysDD5+4OKnefc5n1wIPG/gqgu5yiTQq8NJpW1g1U94Y4uHK2CMemVAsf+4yMNDwUOtvP2ArkCFLngXkAlQjEHhqv/EKF1mkUmuEbpe15w3JmtP1cOTIijvshG0ITer8oo+/voUp7tCgILukNb2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD536C4CEED;
	Thu, 14 Aug 2025 22:22:56 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v8 06/11] cxl/test: Add cxl_test support for cxl_port_get_possible_dports()
Date: Thu, 14 Aug 2025 15:21:46 -0700
Message-ID: <20250814222151.3520500-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814222151.3520500-1-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the delayed dport allocation scheme, the total possible number of
dports need to be discovered during port probe. Add the mock function
that does it for cxl_test.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/cxl.c  | 48 +++++++++++++++++++++++++++++++++--
 tools/testing/cxl/test/mock.c | 15 +++++++++++
 tools/testing/cxl/test/mock.h |  1 +
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index d07f14cb7aa4..e070cda6ca41 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -5,6 +5,7 @@ ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
+ldflags-y += --wrap=cxl_port_get_possible_dports
 ldflags-y += --wrap=devm_cxl_setup_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8faf4143d04e..ecb12a29f3ac 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -921,10 +921,12 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
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
@@ -958,6 +960,47 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 		return -ENXIO;
 	}
 
+	*port_array = array;
+	*port_array_size = array_size;
+
+	return 0;
+}
+
+static int mock_cxl_port_get_possible_dports(struct cxl_port *port)
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
+	return dports;
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
@@ -1036,6 +1079,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
+	.cxl_port_get_possible_dports = mock_cxl_port_get_possible_dports,
 	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
 	.devm_cxl_add_passthrough_decoder = mock_cxl_add_passthrough_decoder,
 	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 1989ae020df3..eefdc1f009c7 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -196,6 +196,21 @@ int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_enumerate_dports, "CXL");
 
+int __wrap_cxl_port_get_possible_dports(struct cxl_port *port)
+{
+	int dports, index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(port->uport_dev))
+		dports = ops->cxl_port_get_possible_dports(port);
+	else
+		dports = cxl_port_get_possible_dports(port);
+	put_cxl_mock_ops(index);
+
+	return dports;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_port_get_possible_dports, "CXL");
+
 int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 {
 	int rc, index;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index d1b0271d2822..413abb2dcb14 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -20,6 +20,7 @@ struct cxl_mock_ops {
 	bool (*is_mock_port)(struct device *dev);
 	bool (*is_mock_dev)(struct device *dev);
 	int (*devm_cxl_port_enumerate_dports)(struct cxl_port *port);
+	int (*cxl_port_get_possible_dports)(struct cxl_port *port);
 	struct cxl_hdm *(*devm_cxl_setup_hdm)(
 		struct cxl_port *port, struct cxl_endpoint_dvsec_info *info);
 	int (*devm_cxl_add_passthrough_decoder)(struct cxl_port *port);
-- 
2.50.1

