Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5581A314A
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971568; cv=none; b=mOst4bK2wEL+WiX1iRlZTKgouBbInzFEBU/S9t1pfzOaL+b0UUKvzsEHnn9zPQLjY6plZyUhZjCZFM4kAe+2ApbrmXsAPz3NWQdBd7arwcMZf4+wwMDgnZs8kuQcS9996Roqd4f5X0YfovFAhdqQcoK3rjvSARWDVAZx0Ibc2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971568; c=relaxed/simple;
	bh=igSPSzPm8Nc7h4XP6eCHgFlpBEqQ5l+i4Z3mQR9XluU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT/Ux/Bi7Q1+jdD/8/25NH2Y+fRlOrTZGCWM0MQ4kHHxRbSJZ8XdsJZc9tcxlpqhF9LKKYe9X3JVfHxyrZlJ5SHOCCg/bLHLCxEG/Hn9qYmEcbjxQM5aSdnhrUS4Z42NNKl9fGaP7S6/N31jNVrRseQCdIOa2xsnX/x5mY+7HZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8217CC4CED1;
	Fri,  7 Feb 2025 23:39:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com
Subject: [PATCH v4 07/15] cxl: Add FWCTL support to CXL
Date: Fri,  7 Feb 2025 16:37:47 -0700
Message-ID: <20250207233914.2375110-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207233914.2375110-1-dave.jiang@intel.com>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fwctl support code to allow sending of CXL feature commands from
userspace through as ioctls via FWCTL. Provide initial setup bits. The
CXL PCI probe function will call cxl_setup_fwctl() after the cxl_memdev
has been enumerated in order to setup FWCTL char device under the
cxl_memdev like the existing memdev char device for issuing CXL raw
mailbox commands from userspace via ioctls.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c  | 74 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c            |  4 ++
 include/cxl/features.h       | 14 +++++++
 include/uapi/fwctl/fwctl.h   |  1 +
 tools/testing/cxl/test/mem.c |  4 ++
 5 files changed, 97 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 82f21f64452a..81e8ff66c12e 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+#include <linux/fwctl.h>
 #include <linux/device.h>
 #include <cxl/mailbox.h>
 #include <cxl/features.h>
@@ -167,6 +168,13 @@ static void free_cxlfs(void *_cxlfs)
 
 	cxlds->cxlfs = NULL;
 	kvfree(cxlfs->entries);
+
+	if (cxlfs->cxl_fwctl) {
+		struct cxl_fwctl *fwctl = cxlfs->cxl_fwctl;
+
+		fwctl_unregister(&fwctl->fwctl_dev);
+		fwctl_put(&fwctl->fwctl_dev);
+	}
 	kfree(cxlfs);
 }
 
@@ -334,3 +342,69 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	} while (true);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_feature, "CXL");
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
+static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	/* Place holder */
+	return ERR_PTR(-EOPNOTSUPP);
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
+	.info = cxlctl_info,
+	.fw_rpc = cxlctl_fw_rpc,
+};
+
+DEFINE_FREE(free_fwctl, struct cxl_fwctl *, if (_T) fwctl_put(&_T->fwctl_dev))
+
+int cxl_setup_fwctl(struct cxl_memdev *cxlmd)
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
+	struct cxl_fwctl *fwctl __free(free_fwctl) =
+		fwctl_alloc_device(&cxlmd->dev, &cxlctl_ops,
+				   struct cxl_fwctl, fwctl_dev);
+	if (!fwctl)
+		return -ENOMEM;
+
+	fwctl->cxlmd = cxlmd;
+	rc = fwctl_register(&fwctl->fwctl_dev);
+	if (rc)
+		return rc;
+
+	cxlfs->cxl_fwctl = no_free_ptr(fwctl);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_setup_fwctl, "CXL");
+
+MODULE_IMPORT_NS("FWCTL");
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3e666ec51580..b093cb16de3e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1013,6 +1013,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_setup_fwctl(cxlmd);
+	if (rc)
+		dev_dbg(&pdev->dev, "No CXL FWCTL setup\n");
+
 	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
 	if (pmu_count < 0)
 		return pmu_count;
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 1ab97e676c03..d0c94756e452 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -4,6 +4,7 @@
 #define __CXL_FEATURES_H__
 
 #include <linux/uuid.h>
+#include <linux/fwctl.h>
 
 /* Feature UUIDs used by the kernel */
 #define CXL_FEAT_PATROL_SCRUB_UUID						\
@@ -158,6 +159,9 @@ enum cxl_set_feat_flag_data_transfer {
  * @entries: CXl feature entry context
  *	@num_features: total Features supported by the device
  *	@ent: Flex array of Feature detail entries from the device
+ * @fwctl: CXL Firmware Control context
+ *	@fwctl_dev: Firmware Control device
+ *	@cxlfs: Pointer to CXL Features state
  */
 struct cxl_features_state {
 	struct cxl_dev_state *cxlds;
@@ -166,12 +170,17 @@ struct cxl_features_state {
 		int num_user_features;
 		struct cxl_feat_entry ent[] __counted_by(num_features);
 	} *entries;
+	struct cxl_fwctl {
+		struct fwctl_device fwctl_dev;
+		struct cxl_memdev *cxlmd;
+	} *cxl_fwctl;
 };
 
 struct cxl_mailbox;
 #ifdef CONFIG_CXL_FEATURES
 inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
 int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
+int cxl_setup_fwctl(struct cxl_memdev *cxlmd);
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
@@ -190,6 +199,11 @@ static inline int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 	return -EOPNOTSUPP;
 }
 
+static inline int cxl_setup_fwctl(struct cxl_memdev *cxlmd)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox,
 				     const uuid_t *feat_uuid,
 				     enum cxl_get_feat_selection selection,
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
index 4809a90ff9b6..53ae16282541 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1646,6 +1646,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = cxl_setup_fwctl(cxlmd);
+	if (rc)
+		dev_dbg(dev, "No CXL FWCTL setup\n");
+
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
 
 	return 0;
-- 
2.48.1

