Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB754F5E0
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250600; cv=none; b=mcY+IH03QlDBNwS05IIMLNSx+cApUMFhRl9yMlhTeD9vYx59tOnSumC0F7op02GjMpsbbLawT5c9ihvN+twpcgoJUXaSw0SYO5Sc+Q55Y1oftNuFkim22Yd12mht1/3KGA0F81/EU9y5WUVDLAI9WfWH7UviGwjZSOwHjfVCe6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250600; c=relaxed/simple;
	bh=VzlEdbKcj1p+hR0wKJlkjbNHzpCMUlxdnszGBKFLciA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv4/6VkfPCDAXmUqBEYzKdTMXTAl//6K58IoGOJXk/B0aq8vVIpR8b1fBGvp4vXLL3K0jV9PaRYNZX9V1C24yvOTE9jqnG5mFDFDZUorATrUA9DUvrmos2B03KsvD4GAW5tF7qE3NtCAK1/cGnq/jmhoS72ds6hT1i5Kdeodjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09B3C4CEF7;
	Thu,  5 Feb 2026 00:16:39 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 1/2] cxl/test: Removal of nvdimm_bus_register() wrapper in cxl_test
Date: Wed,  4 Feb 2026 17:16:32 -0700
Message-ID: <20260205001633.1813643-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205001633.1813643-1-dave.jiang@intel.com>
References: <20260205001633.1813643-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove nvdimm_bus_register() wrapper in cxl_test driver in order to
address a fix in a different commit that fixes the issue of missing
nvdimm bus object due to an initialization race. The CXL CLI unit
test cxl-security.sh will be adjusted with this new change.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pmem.c            |  2 +-
 include/linux/libnvdimm.h     |  2 +-
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 15 ---------------
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index e197883690ef..45486a9d23a5 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -334,7 +334,7 @@ static int cxl_nvdimm_bridge_probe(struct device *dev)
 	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
 
 	cxl_nvb->nd_desc = (struct nvdimm_bus_descriptor) {
-		.provider_name = "CXL",
+		.provider_name = dev_name(dev->parent->parent),
 		.module = THIS_MODULE,
 		.ndctl = cxl_pmem_ctl,
 	};
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 28f086c4a187..716163fc5e09 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -89,7 +89,7 @@ struct nvdimm_bus_descriptor {
 	unsigned long dimm_family_mask;
 	unsigned long bus_family_mask;
 	struct module *module;
-	char *provider_name;
+	const char *provider_name;
 	struct device_node *of_node;
 	ndctl_fn ndctl;
 	int (*flush_probe)(struct nvdimm_bus_descriptor *nd_desc);
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 0e151d0572d1..44abab0275e4 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -3,7 +3,6 @@ ldflags-y += --wrap=acpi_table_parse_cedt
 ldflags-y += --wrap=is_acpi_device_node
 ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
-ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=devm_cxl_add_rch_dport
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 44bce80ef3ff..47b1aadabf98 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -148,21 +148,6 @@ struct acpi_pci_root *__wrap_acpi_pci_find_root(acpi_handle handle)
 }
 EXPORT_SYMBOL_GPL(__wrap_acpi_pci_find_root);
 
-struct nvdimm_bus *
-__wrap_nvdimm_bus_register(struct device *dev,
-			   struct nvdimm_bus_descriptor *nd_desc)
-{
-	int index;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_dev(dev->parent->parent))
-		nd_desc->provider_name = "cxl_test";
-	put_cxl_mock_ops(index);
-
-	return nvdimm_bus_register(dev, nd_desc);
-}
-EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
-
 int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 {
 	int rc, index;
-- 
2.52.0

