Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CC30DEA3
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390782; cv=none; b=WwWd12JF2u6u8Y4v8M9f75DaraGKwWG2h9lhzBUwJOuHNIqMJaC0V8ibPojW7kheSnKSk+6XIxr9jYrEZ+yXdMZpoNujbMKITbw3gWCJuSSfz+YJkNIdfDK4CLjUm/b/RUeWMp79RAwh1r1d/9+ZjLdQJuTASVwnHzyS3rVwgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390782; c=relaxed/simple;
	bh=bvy/uyfC1tRNdxBwz8C/ZmEFqixsyW2anMlq8RdTaFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luDvoxL3TWGPe+N3V+eSTpTsxjuzpT0VD28alV8JMrOIeXvarthh96IlKOSN3MSY6um7HayjorycG676ujBqI0h/kN8z2w9yzssTo3Lcd37oTpXOmYeTjzb8Cvk+gdvxsr86yvL9ZDT0kQ0Zv4R7nyxJvm167hfubMzOmkKnPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07084C4CEFB;
	Mon, 17 Nov 2025 14:46:21 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2 3/3] cxl/test: Add support for acpi extended linear cache
Date: Mon, 17 Nov 2025 07:46:11 -0700
Message-ID: <20251117144611.903692-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117144611.903692-1-dave.jiang@intel.com>
References: <20251117144611.903692-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the mock wrappers for hmat_get_extended_linear_cache_size() in order
to emulate the ACPI helper function for the regions that are mock'd by
cxl_test.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Changed to use mock_auto_region_size
---
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/cxl.c  | 21 +++++++++++++++++++++
 tools/testing/cxl/test/mock.c | 20 ++++++++++++++++++++
 tools/testing/cxl/test/mock.h |  3 +++
 4 files changed, 45 insertions(+)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 0d5ce4b74b9f..65e9ac227aee 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -11,6 +11,7 @@ ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
+ldflags-y += --wrap=hmat_get_extended_linear_cache_size
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 2c3979c0b505..0c14e060a0cc 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -614,6 +614,25 @@ mock_acpi_evaluate_integer(acpi_handle handle, acpi_string pathname,
 	return AE_OK;
 }
 
+static int
+mock_hmat_get_extended_linear_cache_size(struct resource *backing_res,
+					 int nid, resource_size_t *cache_size)
+{
+	struct acpi_cedt_cfmws *window = mock_cfmws[0];
+	struct resource cfmws0_res =
+		DEFINE_RES_MEM(window->base_hpa, window->window_size);
+
+	if (!extended_linear_cache ||
+	    !resource_contains(&cfmws0_res, backing_res)) {
+		return hmat_get_extended_linear_cache_size(backing_res,
+							   nid, cache_size);
+	}
+
+	*cache_size = mock_auto_region_size;
+
+	return 0;
+}
+
 static struct pci_bus mock_pci_bus[NR_BRIDGES];
 static struct acpi_pci_root mock_pci_root[ARRAY_SIZE(mock_pci_bus)] = {
 	[0] = {
@@ -1142,6 +1161,8 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
 	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
 	.devm_cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
+	.hmat_get_extended_linear_cache_size =
+		mock_hmat_get_extended_linear_cache_size,
 	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
 };
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 995269a75cbd..bff5853717f0 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -111,6 +111,26 @@ acpi_status __wrap_acpi_evaluate_integer(acpi_handle handle,
 }
 EXPORT_SYMBOL(__wrap_acpi_evaluate_integer);
 
+int __wrap_hmat_get_extended_linear_cache_size(struct resource *backing_res,
+					       int nid,
+					       resource_size_t *cache_size)
+{
+	int index, rc;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops)
+		rc = ops->hmat_get_extended_linear_cache_size(backing_res, nid,
+							      cache_size);
+	else
+		rc = hmat_get_extended_linear_cache_size(backing_res, nid,
+							 cache_size);
+
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(__wrap_hmat_get_extended_linear_cache_size);
+
 struct acpi_pci_root *__wrap_acpi_pci_find_root(acpi_handle handle)
 {
 	int index;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 4ed932e76aae..bfd36cbdbae2 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -25,6 +25,9 @@ struct cxl_mock_ops {
 	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
 	struct cxl_dport *(*devm_cxl_add_dport_by_dev)(struct cxl_port *port,
 						       struct device *dport_dev);
+	int (*hmat_get_extended_linear_cache_size)(struct resource *backing_res,
+						   int nid,
+						   resource_size_t *cache_size);
 };
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops);
-- 
2.51.1

