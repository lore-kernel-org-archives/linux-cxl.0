Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA11A314A
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971566; cv=none; b=PiBCIjzLIDpTfd5FI9vj7n8wQXA1nWJqdqGgXGeczbSwTf857Zz+CED8fzbp014IPyAjOV/3ZyZ//6SGHASA1gypTgsYC5v5po9/S6QlW67YzhpGbb0zXxSZYQ/verXba74Ray7QiNxuGh/nAQJswCN+Cb5sK4Py9pwlJgzecaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971566; c=relaxed/simple;
	bh=xXijePko9aEGXph5f7Ic12Sj3Saf8rAvwCtkWzbu92I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdQvarL5vnQjt6IoLJfgb8qb0ajGSUQsTVcpk5EPHAgizdXW1sTBFPU7xUvnVcBIbo1iAxbmSy/WfSv7aJ9FMf2Fiu3+FG6YyW4/vmCyfnZoNSmAhZBu3w+6/qICitb8HS42DHGWOZepOCzJ5MVjS4VrQ0qiHcJG0u9NKH5Xvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEF0C4CED1;
	Fri,  7 Feb 2025 23:39:25 +0000 (UTC)
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
Subject: [PATCH v4 06/15] cxl: Setup exclusive CXL features that are reserved for the kernel
Date: Fri,  7 Feb 2025 16:37:46 -0700
Message-ID: <20250207233914.2375110-7-dave.jiang@intel.com>
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

Certain features will be exclusively used by components such as in
kernel RAS driver. Setup an exclusion list that can be later filtered
out before exposing to user space.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 26 ++++++++++++++++++++++++++
 include/cxl/features.h      | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index d337224158fa..82f21f64452a 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -6,6 +6,28 @@
 #include "cxl.h"
 #include "cxlmem.h"
 
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
+static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
+{
+	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
+		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
+			return true;
+	}
+
+	return false;
+}
+
 inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
 {
 	return cxlds->cxlfs;
@@ -46,6 +68,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
 	struct cxl_mbox_get_sup_feats_in mbox_in;
 	struct cxl_feat_entry *entry;
 	struct cxl_mbox_cmd mbox_cmd;
+	int user_feats = 0;
 	int count;
 
 	count = cxl_get_supported_features_count(cxl_mbox);
@@ -120,6 +143,8 @@ get_supported_features(struct cxl_features_state *cxlfs)
 			return NULL;
 
 		memcpy(entry, mbox_out->ents, retrieved);
+		if (!is_cxl_feature_exclusive(entry))
+			user_feats++;
 		entry += num_entries;
 		/*
 		 * If the number of output entries is less than expected, add the
@@ -130,6 +155,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
 	} while (remain_feats);
 
 	entries->num_features = count;
+	entries->num_user_features = user_feats;
 
 	return no_free_ptr(entries);
 }
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 4e3527ba8a1d..1ab97e676c03 100644
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
 /* Feature commands capability supported by a device */
 enum cxl_features_capability {
 	CXL_FEATURES_NONE = 0,
@@ -130,6 +163,7 @@ struct cxl_features_state {
 	struct cxl_dev_state *cxlds;
 	struct cxl_feat_entries {
 		int num_features;
+		int num_user_features;
 		struct cxl_feat_entry ent[] __counted_by(num_features);
 	} *entries;
 };
-- 
2.48.1

