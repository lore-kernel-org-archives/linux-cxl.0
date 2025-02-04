Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F925A623
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706688; cv=none; b=m5TdnjROG9HcvtASNvx9SpuJgnLSWxQWmWY4GRo87lMD1g8Zs137sVAJSxVqavSC4YO4qJGMkCBhZojIFnO59xX29ods10gciCoDgKRkTIXERxp1PEsV8iUuWq+PoW1xaTlfd56KdIs+fzxNbQ3qt350ruzcz1567pByhqFzGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706688; c=relaxed/simple;
	bh=DUmCNlRQYdYNaTVWQryluYHT2VuW1cs3qgmEVyhVn0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEfpPYtfCZaXq9XwZo2MZ8ip+tsOpVs37shw7gQKnX6nJWqqKqLA5ICI+4LhdI8S9VJYO23v5V1OPz3wgjnb1FGYq0+IxDS/LYHzWjATuX/SvWN638Eg0phAyFd5s1T9bx7RCo+1B3fvvXfm60hAiiMjfg9PwBWYt7lWzgLcQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A013FC4CEDF;
	Tue,  4 Feb 2025 22:04:47 +0000 (UTC)
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
Subject: [PATCH v3 07/16] cxl: Setup exclusive CXL features that are reserved for the kernel
Date: Tue,  4 Feb 2025 15:03:08 -0700
Message-ID: <20250204220430.4146187-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204220430.4146187-1-dave.jiang@intel.com>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain features will be exclusively used by components such as in
kernel RAS driver. Setup an exclusion list that can be later filtered
out before exposing to user space.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 29 +++++++++++++++++++++++++++++
 drivers/cxl/features.c      |  4 ++++
 drivers/cxl/features.h      |  3 +++
 include/cxl/features.h      | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index ec0df5ad741c..0ab02c2a94f9 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -8,6 +8,35 @@
 #include "cxlmem.h"
 #include "features.h"
 
+/* All the features below are exclusive to the kernel */
+static const uuid_t cxl_exclusive_feats[] = {
+	CXL_FEAT_PATROL_SCRUB_UUID,
+	CXL_FEAT_ECS_UUID,
+	CXL_FEAT_SPPR_UUID,
+	CXL_FEAT_HPPR_UUID,
+	CXL_FEAT_CACHELINE_SPARING_UUID,
+	CXL_FEAT_ROW_SPARING_UUID,
+	CXL_FEAT_BANK_SPARING_UUID,
+	CXL_FEAT_RANK_SPARING_UUID,
+};
+
+/**
+ * is_cxl_feature_exclusive() - Check if a CXL feature is exclusive to kernel
+ * @entry: cxl feature entry
+ *
+ * Return true if feature is exclusive to kernel, otherwise false
+ */
+bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
+{
+	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
+		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_feature_exclusive, "CXL");
+
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 4d8c603121f0..0086fdb20bfd 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -46,6 +46,7 @@ static int get_supported_features(struct cxl_memdev *cxlmd,
 	struct cxl_mbox_get_sup_feats_in mbox_in;
 	struct cxl_feat_entry *entry;
 	struct cxl_mbox_cmd mbox_cmd;
+	int user_feats = 0;
 	int count;
 
 	if (cxlfs->cap < CXL_FEATURES_RO)
@@ -125,6 +126,8 @@ static int get_supported_features(struct cxl_memdev *cxlmd,
 			return -ENXIO;
 
 		memcpy(entry, mbox_out->ents, retrieved);
+		if (!is_cxl_feature_exclusive(entry))
+			user_feats++;
 		entry++;
 		/*
 		 * If the number of output entries is less than expected, add the
@@ -135,6 +138,7 @@ static int get_supported_features(struct cxl_memdev *cxlmd,
 	} while (remain_feats);
 
 	cxlfs->num_features = count;
+	cxlfs->num_user_features = user_feats;
 	cxlfs->entries = no_free_ptr(entries);
 	return devm_add_action_or_reset(&cxlmd->dev, cxl_free_feature_entries,
 					cxlfs->entries);
diff --git a/drivers/cxl/features.h b/drivers/cxl/features.h
index 0cc6d9e6c441..8706f944b476 100644
--- a/drivers/cxl/features.h
+++ b/drivers/cxl/features.h
@@ -3,6 +3,9 @@
 #ifndef __CXL_FEATURES_LOCAL__
 #define __CXL_FEATURES_LOCAL__
 
+struct cxl_feat_entry;
+
 int devm_cxl_add_features(struct cxl_memdev *cxlmd);
+bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);
 
 #endif
diff --git a/include/cxl/features.h b/include/cxl/features.h
index a7811969cfdb..869a18559f2b 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -5,6 +5,39 @@
 
 #include <linux/uuid.h>
 
+/* Feature UUIDs used by the kernel */
+#define CXL_FEAT_PATROL_SCRUB_UUID						\
+	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,	\
+		  0x06, 0xdb, 0x8a)
+
+#define CXL_FEAT_ECS_UUID							\
+	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,	\
+		  0x89, 0x33, 0x86)
+
+#define CXL_FEAT_SPPR_UUID							\
+	UUID_INIT(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e, 0x69, 0x2c, 0x91,	\
+		  0x75, 0x68, 0xbb)
+
+#define CXL_FEAT_HPPR_UUID							\
+	UUID_INIT(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1, 0xec, 0x74, 0x59,	\
+		  0xfb, 0x0e, 0x24)
+
+#define CXL_FEAT_CACHELINE_SPARING_UUID						\
+	UUID_INIT(0x96C33386, 0x91dd, 0x44c7, 0x9e, 0xcb, 0xfd, 0xaf, 0x65,	\
+		  0x03, 0xba, 0xc4)
+
+#define CXL_FEAT_ROW_SPARING_UUID						\
+	UUID_INIT(0x450ebf67, 0xb135, 0x4f97, 0xa4, 0x98, 0xc2, 0xd5, 0x7f,	\
+		  0x27, 0x9b, 0xed)
+
+#define CXL_FEAT_BANK_SPARING_UUID						\
+	UUID_INIT(0x78b79636, 0x90ac, 0x4b64, 0xa4, 0xef, 0xfa, 0xac, 0x5d,	\
+		  0x18, 0xa8, 0x63)
+
+#define CXL_FEAT_RANK_SPARING_UUID						\
+	UUID_INIT(0x34dbaff5, 0x0552, 0x4281, 0x8f, 0x76, 0xda, 0x0b, 0x5e,	\
+		  0x7a, 0x76, 0xa7)
+
 struct cxl_mailbox;
 
 /* Index IDs for CXL mailbox Feature commands */
@@ -27,12 +60,14 @@ enum cxl_features_capability {
  * @cxlmd: Pointer to cxl mem device
  * @cap: Feature commands capability
  * @num_features: total Features supported by the device
+ * @num_user_features: total Features not kernel exclusive
  * @entries: Feature detail entries fetched from the device
  */
 struct cxl_features_state {
 	struct cxl_memdev *cxlmd;
 	enum cxl_features_capability cap;
 	int num_features;
+	int num_user_features;
 	struct cxl_feat_entry *entries;
 };
 
-- 
2.48.1

