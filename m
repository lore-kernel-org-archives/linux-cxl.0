Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3242652A4
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931952; cv=none; b=HPORMOi6El0JCIl6P8q34NpVe/5Ea0CV2oWMVwV/NEnJX6XANTdaohRD/SfHAdUfMfTZSvFpL2RG5BZdJagDVj5JzLWTLeF+eshf055VGy/NOSVIbLnwmJUicDpv0tqWxtAP/3objIIdQq13AOyFfnRDDTTzAFghqNR1rYtUD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931952; c=relaxed/simple;
	bh=lyfFr1EqHFTKD6ZHwtDqZqDRFyvJBeGqEsVg4xjfYaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elrPKy77dEW/ab+oBPCmdHwmU8x59tziOavoWlQHVM/074l7/OA6F0AEF7tZF46VpMCReA4FhmJ+O2MP2oN58brAxzNQl8MjsQ3MUgx201D+dJSn0xXT+xbYSfjo/a0ldQ4NHhdwG3rZS1A/84TfCTSI9wiIlflp3g1kOEnArvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB5DC4CEE7;
	Fri, 31 Oct 2025 17:32:31 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 3/4] cxl/test: Add support for acpi extended linear cache
Date: Fri, 31 Oct 2025 10:32:23 -0700
Message-ID: <20251031173224.3537030-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031173224.3537030-1-dave.jiang@intel.com>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
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
index 4e9007f2d510..b537f65e4c11 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -613,6 +613,25 @@ mock_acpi_evaluate_integer(acpi_handle handle, acpi_string pathname,
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
+	*cache_size = MOCK_AUTO_REGION_SIZE;
+
+	return 0;
+}
+
 static struct pci_bus mock_pci_bus[NR_BRIDGES];
 static struct acpi_pci_root mock_pci_root[ARRAY_SIZE(mock_pci_bus)] = {
 	[0] = {
@@ -1141,6 +1160,8 @@ static struct cxl_mock_ops cxl_mock_ops = {
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
2.51.0

