Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7C1E3DFD
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298562; cv=none; b=ttyh3INT2uYkvfCJ8ffwsEmPcCz1fizYVgPWOm/Ev4x/LgWzrFVPq7tDFU3SosoFU7Kr/aBoje9mNNKd5FGs4E/ZSUWcF7FHIpY+UyHWHmjxQeFlfm4LqKEMSsEMsI3SMriv4fdlSndfc4C5sbzrksqLQvp700+a6pS/QecieAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298562; c=relaxed/simple;
	bh=b9D1wQoq6pPBakmsBjDFAcyaNANz6TCefXuRQVfxTnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4naCS5zdoHw8SYu9M0u+8pV6Ndd5uEbwMggFMJRMXnZe2K7ALE/qVXH6OtTgR+vdRJJDYedBv9sM6kXcbwYjy1ISbu2f513R91hcTWILZ0eMvho0bKhL67J+6fWuYkyB81CizQoa0qyy6zj9tUfCEX8Q9134VIuQgVv4u5XBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B3DC4CEDD;
	Tue, 11 Feb 2025 18:29:21 +0000 (UTC)
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
Subject: [PATCH v5 07/15] cxl: Add FWCTL support to CXL
Date: Tue, 11 Feb 2025 11:28:01 -0700
Message-ID: <20250211182909.1650096-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211182909.1650096-1-dave.jiang@intel.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
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
v5:
- Add devm action to fwctl. (Dan)
- Remove memdev back pointer from fwctl. (Dan)
- Allocate bare fwctl_dev. (Dan)
- Select CONFIG_FWCTL for CONFIG_CXL_FEATURES
---
 drivers/cxl/Kconfig          |  1 +
 drivers/cxl/core/features.c  | 81 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c            |  4 ++
 include/cxl/features.h       | 10 +++++
 include/uapi/fwctl/fwctl.h   |  1 +
 tools/testing/cxl/test/mem.c |  4 ++
 6 files changed, 101 insertions(+)

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
index 02558f46883d..db48a8fbde81 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+#include <linux/fwctl.h>
 #include <linux/device.h>
 #include <cxl/mailbox.h>
 #include <cxl/features.h>
@@ -334,3 +335,83 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
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
index c13f6267305e..68835295e56f 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -4,6 +4,7 @@
 #define __CXL_FEATURES_H__
 
 #include <linux/uuid.h>
+#include <linux/fwctl.h>
 
 /* Feature UUIDs used by the kernel */
 #define CXL_FEAT_PATROL_SCRUB_UUID						\
@@ -158,6 +159,7 @@ enum cxl_set_feat_flag_data_transfer {
  * @entries: CXl feature entry context
  *	@num_features: total Features supported by the device
  *	@ent: Flex array of Feature detail entries from the device
+ * @fwctl_dev: Firmware Control device
  */
 struct cxl_features_state {
 	struct cxl_dev_state *cxlds;
@@ -166,12 +168,15 @@ struct cxl_features_state {
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
@@ -182,6 +187,11 @@ static inline int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
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

