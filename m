Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAF1CAA99
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589936; cv=none; b=oPWQ2EjaU7aJkU5fsQNSeiicvqT+putbb8YjujVcfgAjzscHyirNn+fHAMRD2HP+5H26Hab9oOR/FlH6iZiow5CY9G9Es3kVJ5igR1j9YQ8IHPY8PctDxGo5bOS2WjPQahKOPh3S/qLMPeea+3RhP1GrDWB0pGjOWtPLBN5AhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589936; c=relaxed/simple;
	bh=2wx+Ja1wemk02GmHYRSORoWjuTt1Fvq5WIMtcCQP3d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zqmo9NFj+uxcmKnjib9KouBaqTzsVDkegS4iHv8ZS7iQung7yM/Ev5FGQDSEe77h9yhUTNTuzmQnyskDxux9vxR15MowNhglO8ZSORdhhO4deDwuGIxVw306zLik3EQ+3SmdB96S7FIK65lFLgQOT0KRPkrIKBNUzbNipPBuZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E7EC4CED2;
	Wed, 22 Jan 2025 23:52:15 +0000 (UTC)
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
Subject: [PATCH v1 10/19] cxl: Add FWCTL support to the CXL features driver
Date: Wed, 22 Jan 2025 16:50:41 -0700
Message-ID: <20250122235159.2716036-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122235159.2716036-1-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fwctl support code to allow sending of CXL feature commands from
userspace through as ioctls via FWCTL. Provide initial setup bits.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v1:
- Add missing dev_set_name() (Jason)
---
 drivers/cxl/Kconfig        |  1 +
 drivers/cxl/features.c     | 44 ++++++++++++++++++++++++++++++++++++--
 include/cxl/features.h     |  2 ++
 include/uapi/fwctl/fwctl.h |  1 +
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 9a6ffd81ac0e..5de06c3806ce 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -148,6 +148,7 @@ config CXL_REGION_INVALIDATION_TEST
 
 config CXL_FEATURES
 	tristate "CXL: Features support"
+	depends on FWCTL
 	default CXL_BUS
 	help
 	  Enable CXL features support that are tied to a CXL mailbox.
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 1c4bcd7465cb..5a2b771586d3 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -9,6 +9,37 @@
 #include "cxl.h"
 #include "cxlmem.h"
 
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
+			   void *rpc_in, size_t in_len, size_t *out_len)
+{
+	/* Place holder */
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static const struct fwctl_ops cxlctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_CXL,
+	.uctx_size = sizeof(struct cxl_features),
+	.open_uctx = cxlctl_open_uctx,
+	.close_uctx = cxlctl_close_uctx,
+	.info = cxlctl_info,
+	.fw_rpc = cxlctl_fw_rpc,
+};
+
 static void cxl_free_feature_entries(void *entries)
 {
 	kvfree(entries);
@@ -146,13 +177,16 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
 					cxl_free_feature_entries, cfs->entries);
 }
 
+DEFINE_FREE(cfs, struct cxl_features_state *, if (_T) fwctl_put(&_T->fwctl))
+
 static int cxl_features_probe(struct device *dev)
 {
 	struct cxl_features *features = to_cxl_features(dev);
 	int rc;
 
-	struct cxl_features_state *cfs __free(kfree) =
-		kzalloc(sizeof(*cfs), GFP_KERNEL);
+	struct cxl_features_state *cfs __free(cfs) =
+		fwctl_alloc_device(dev, &cxlctl_ops,
+				   struct cxl_features_state, fwctl);
 	if (!cfs)
 		return -ENOMEM;
 
@@ -161,6 +195,10 @@ static int cxl_features_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	rc = fwctl_register(&cfs->fwctl);
+	if (rc)
+		return rc;
+
 	dev_set_drvdata(dev, no_free_ptr(cfs));
 
 	return 0;
@@ -170,6 +208,7 @@ static void cxl_features_remove(struct device *dev)
 {
 	struct cxl_features_state *cfs = dev_get_drvdata(dev);
 
+	fwctl_unregister(&cfs->fwctl);
 	kfree(cfs);
 }
 
@@ -212,4 +251,5 @@ module_cxl_driver(cxl_features_driver);
 MODULE_DESCRIPTION("CXL: Features");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("CXL");
+MODULE_IMPORT_NS("FWCTL");
 MODULE_ALIAS_CXL(CXL_DEVICE_FEATURES);
diff --git a/include/cxl/features.h b/include/cxl/features.h
index f746358ba5f9..69697c069e63 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -4,6 +4,7 @@
 #define __CXL_FEATURES_H__
 
 #include <linux/uuid.h>
+#include <linux/fwctl.h>
 
 #define CXL_FEAT_PATROL_SCRUB_UUID						\
 	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,	\
@@ -103,6 +104,7 @@ struct cxl_mbox_get_sup_feats_out {
 } __packed;
 
 struct cxl_features_state {
+	struct fwctl_device fwctl;
 	struct cxl_features *features;
 	int num_features;
 	int num_user_features;
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index f9b27fb5c161..2c3817592308 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -43,6 +43,7 @@ enum {
 enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
+	FWCTL_DEVICE_TYPE_CXL,
 };
 
 /**
-- 
2.47.1

