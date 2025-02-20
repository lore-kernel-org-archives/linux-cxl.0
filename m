Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089592638A3
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080691; cv=none; b=GYDalCtx4xfATxeovZRo9PdLs1MN8W4owePoF5/DXrHLRSBtNmcyZq1jJ00Bg3Nx5PLHsJLx7q0xvETIR4M/S+0lNPxUi16wsHf/xReq7DkSG76FYz1GCGY1vlO6vD3AcJiHGBmu5H3Oq7EZRULbINBGdZt8FmaVbDn5LihK14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080691; c=relaxed/simple;
	bh=AWqpL8hZCds+IihWyp5cM7vTz6Sbzhqqr3IGYa4bqwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoHNj4qcrte0L6qFznf/mXNm9Lhjr9c/R5IYiGy8+qLOnQvwsjpUg2Q+Nwdjy6Lqts7NTPJ9s/cvI7kJK4f6JPSHOL/iOhNvfdNBxxbxdE6GSVkpXmBzU3bBLk8Ku/Sawq46bJ5PBtCSmN1Hkh/Fi8xJXCMKHjQTYu8HjzPQ2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04DAC4CED1;
	Thu, 20 Feb 2025 19:44:50 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v7 07/14] cxl: Add FWCTL support to CXL
Date: Thu, 20 Feb 2025 12:42:45 -0700
Message-ID: <20250220194438.2281088-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220194438.2281088-1-dave.jiang@intel.com>
References: <20250220194438.2281088-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fwctl support code to allow sending of CXL feature commands from
userspace through as ioctls via FWCTL. Provide initial setup bits. The
CXL PCI probe function will call devm_cxl_setup_fwctl() after the
cxl_memdev has been enumerated in order to setup FWCTL char device under
the cxl_memdev like the existing memdev char device for issuing CXL raw
mailbox commands from userspace via ioctls.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/Kconfig          |  1 +
 drivers/cxl/core/features.c  | 74 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c            |  4 ++
 include/cxl/features.h       | 10 +++++
 include/uapi/fwctl/fwctl.h   |  1 +
 tools/testing/cxl/test/mem.c |  4 ++
 6 files changed, 94 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ad2e796e4ac6..2b6e662c89bf 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -105,6 +105,7 @@ config CXL_MEM
 config CXL_FEATURES
 	bool "CXL: Features"
 	depends on CXL_PCI
+	select FWCTL
 	help
 	  Enable support for CXL Features. A CXL device that includes a mailbox
 	  supports commands that allows listing, getting, and setting of
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 048ba4fc3538..846de3294a5e 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+#include <linux/fwctl.h>
 #include <linux/device.h>
 #include <cxl/mailbox.h>
 #include <cxl/features.h>
@@ -331,3 +332,76 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 		}
 	} while (true);
 }
+
+/* FWCTL support */
+
+static inline struct cxl_memdev *fwctl_to_memdev(struct fwctl_device *fwctl_dev)
+{
+	return to_cxl_memdev(fwctl_dev->dev.parent);
+}
+
+static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
+{
+	return 0;
+}
+
+static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
+{
+}
+
+static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			   void *in, size_t in_len, size_t *out_len)
+{
+	/* Place holder */
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static const struct fwctl_ops cxlctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_CXL,
+	.uctx_size = sizeof(struct fwctl_uctx),
+	.open_uctx = cxlctl_open_uctx,
+	.close_uctx = cxlctl_close_uctx,
+	.fw_rpc = cxlctl_fw_rpc,
+};
+
+DEFINE_FREE(free_fwctl_dev, struct fwctl_device *, if (_T) fwctl_put(_T))
+
+static void free_memdev_fwctl(void *_fwctl_dev)
+{
+	struct fwctl_device *fwctl_dev = _fwctl_dev;
+
+	fwctl_unregister(fwctl_dev);
+	fwctl_put(fwctl_dev);
+}
+
+int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_features_state *cxlfs;
+	int rc;
+
+	cxlfs = to_cxlfs(cxlds);
+	if (!cxlfs)
+		return -ENODEV;
+
+	/* No need to setup FWCTL if there are no user allowed features found */
+	if (!cxlfs->entries->num_user_features)
+		return -ENODEV;
+
+	struct fwctl_device *fwctl_dev __free(free_fwctl_dev) =
+		_fwctl_alloc_device(&cxlmd->dev, &cxlctl_ops, sizeof(*fwctl_dev));
+	if (!fwctl_dev)
+		return -ENOMEM;
+
+	rc = fwctl_register(fwctl_dev);
+	if (rc)
+		return rc;
+
+	cxlfs->fwctl_dev = fwctl_dev;
+
+	return devm_add_action_or_reset(&cxlmd->dev, free_memdev_fwctl,
+					no_free_ptr(fwctl_dev));
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_fwctl, "CXL");
+
+MODULE_IMPORT_NS("FWCTL");
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3e666ec51580..993fa60fe453 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1013,6 +1013,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = devm_cxl_setup_fwctl(cxlmd);
+	if (rc)
+		dev_dbg(&pdev->dev, "No CXL FWCTL setup\n");
+
 	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
 	if (pmu_count < 0)
 		return pmu_count;
diff --git a/include/cxl/features.h b/include/cxl/features.h
index d2cde46b0fec..fce3c2dbde5a 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -4,6 +4,7 @@
 #define __CXL_FEATURES_H__
 
 #include <linux/uuid.h>
+#include <linux/fwctl.h>
 
 /* Feature UUIDs used by the kernel */
 #define CXL_FEAT_PATROL_SCRUB_UUID						\
@@ -162,6 +163,7 @@ enum cxl_set_feat_flag_data_transfer {
  * @entries: CXl feature entry context
  *	@num_features: total Features supported by the device
  *	@ent: Flex array of Feature detail entries from the device
+ * @fwctl_dev: Firmware Control device
  */
 struct cxl_features_state {
 	struct cxl_dev_state *cxlds;
@@ -170,12 +172,15 @@ struct cxl_features_state {
 		int num_user_features;
 		struct cxl_feat_entry ent[] __counted_by(num_features);
 	} *entries;
+	struct fwctl_device *fwctl_dev;
 };
 
 struct cxl_mailbox;
+struct cxl_memdev;
 #ifdef CONFIG_CXL_FEATURES
 inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
 int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
+int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd);
 #else
 static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
 {
@@ -186,6 +191,11 @@ static inline int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #endif
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 518f054f02d2..f57f6d86b12f 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -43,6 +43,7 @@ enum {
 enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
+	FWCTL_DEVICE_TYPE_CXL = 2,
 	FWCTL_DEVICE_TYPE_BNXT = 3,
 };
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 4809a90ff9b6..848db399102c 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1646,6 +1646,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = devm_cxl_setup_fwctl(cxlmd);
+	if (rc)
+		dev_dbg(dev, "No CXL FWCTL setup\n");
+
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
 
 	return 0;
-- 
2.48.1

