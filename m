Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37071CEE9F
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589934; cv=none; b=sCJu6Vo37Xoh3tqnzygFBgLx68Nx+SL/c/IJ+Zk5g2ygzM/hWrqvZxNnJVrWtgfHYSTwE03MqKACeAanchQG4DHsEAkJlTGMdL9OExTdQckixwEe4pm6rs6vblqO4fRa5JyszIBs0PnoLAAZ77n9Tq1Zl4BRAKb+0dWxjhalIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589934; c=relaxed/simple;
	bh=fDnjnfCNGgIHUIMaIjv0kSDP+AwuyzQkxQn4WDWls2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzfBfCmLOlQUvmHS8B9pAFD7rfDPzBsVmEYBo5hExmQM8Drn7l3KiuNsS9VrA1oEj7Q4xGQEkVdkRjO+dAhV+FjtRx480oIIygQX1h2qUxuAGkLulYadG6BRLZiDKuDsXehLpaJgmxT53T2pOAaoAh5jkO/EBS5Po2jy5bHKWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBB6C4CED2;
	Wed, 22 Jan 2025 23:52:14 +0000 (UTC)
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
Subject: [PATCH v1 09/19] cxl: Setup exclusive CXL features that are reserved for the kernel
Date: Wed, 22 Jan 2025 16:50:40 -0700
Message-ID: <20250122235159.2716036-10-dave.jiang@intel.com>
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

Certain features will be exclusively used by components such as in
kernel RAS driver. Setup an exclusion list that can be later filtered
out before exposing to user space.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 22 ++++++++++++++++++++++
 drivers/cxl/features.c      |  6 +++++-
 include/cxl/features.h      | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 932e82b52f90..c836b3a64561 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -6,6 +6,17 @@
 #include "core.h"
 #include "cxlmem.h"
 
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
 #define CXL_FEATURE_MAX_DEVS 65536
 static DEFINE_IDA(cxl_features_ida);
 
@@ -263,3 +274,14 @@ int cxl_set_feature(struct cxl_features *features,
 	} while (true);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_feature, "CXL");
+
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
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 6b061bef3a6a..1c4bcd7465cb 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -47,6 +47,7 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
 	struct cxl_mbox_get_sup_feats_in mbox_in;
 	struct cxl_feat_entry *entry;
 	struct cxl_mbox_cmd mbox_cmd;
+	int user_feats = 0;
 	int count;
 
 	/* Get supported features is optional, need to check */
@@ -127,6 +128,8 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
 			return -ENXIO;
 
 		memcpy(entry, mbox_out->ents, retrieved);
+		if (!is_cxl_feature_exclusive(entry))
+			user_feats++;
 		entry++;
 		/*
 		 * If the number of output entries is less than expected, add the
@@ -138,6 +141,7 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
 
 	cfs->num_features = count;
 	cfs->entries = no_free_ptr(entries);
+	cfs->num_user_features = user_feats;
 	return devm_add_action_or_reset(&cfs->features->dev,
 					cxl_free_feature_entries, cfs->entries);
 }
@@ -177,7 +181,7 @@ static ssize_t features_show(struct device *dev, struct device_attribute *attr,
 	if (!cfs)
 		return -ENOENT;
 
-	return sysfs_emit(buf, "%d\n", cfs->num_features);
+	return sysfs_emit(buf, "%d\n", cfs->num_user_features);
 }
 
 static DEVICE_ATTR_RO(features);
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 370c8d57c728..f746358ba5f9 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -5,6 +5,38 @@
 
 #include <linux/uuid.h>
 
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
 
 enum feature_cmds {
@@ -73,6 +105,7 @@ struct cxl_mbox_get_sup_feats_out {
 struct cxl_features_state {
 	struct cxl_features *features;
 	int num_features;
+	int num_user_features;
 	struct cxl_feat_entry *entries;
 };
 
@@ -140,5 +173,6 @@ size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
 int cxl_set_feature(struct cxl_features *features, const uuid_t feat_uuid,
 		    u8 feat_version, void *feat_data, size_t feat_data_size,
 		    u32 feat_flag, u16 offset, u16 *return_code);
+bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);
 
 #endif
-- 
2.47.1

