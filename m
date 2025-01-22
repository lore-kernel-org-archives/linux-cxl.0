Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AA1CAA98
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589928; cv=none; b=vCiyPIt11YQGQGN1sjyf0cgtYpSc2i0d2Di3E/mqrw99Rp/kKl++z4ul3uzWfLe8D2xOBp91yVSG0YxsKCtR/NCDrA7UYSIoJ8yT4I0MMlqQI104JDyPcSXTuj6wdLHgxHlOT/zdM+MvGtJY2f8Tn0+UF15R3Aroj5Zwiz73R40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589928; c=relaxed/simple;
	bh=pw6f0QVtZSevOI6RSE7JaKpmoyG4cFUt5Cs1EdxSu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzyseCGUxo5L4wmgPnu5b7k6AMjvLbPGJkRAS9Jt0rgH6XHEBsuolHm1j1qAoRSH7D1KKJ83gN+BmE8UNfLnJ/3TvAsq6CYHZCPdT4MIMuYwaK3PQYUWbhOpdOgn53RuW3WmKrW+YhhCyaZN24fo9OwE3j8+2tsluWX7V7/AhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD7FC4CED2;
	Wed, 22 Jan 2025 23:52:07 +0000 (UTC)
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
Subject: [PATCH v1 04/19] cxl: Add Get Supported Features command for kernel usage
Date: Wed, 22 Jan 2025 16:50:35 -0700
Message-ID: <20250122235159.2716036-5-dave.jiang@intel.com>
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

CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
The command retrieve the list of supported device-specific features
(identified by UUID) and general information about each Feature.

The driver will retrieve the feature entries in order to make checks and
provide information for the Get Feature and Set Feature command. One of
the main piece of information retrieved are the effects a Set Feature
command would have for a particular feature.

Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v1:
- Change input param from cxlds to cxl_mbox
- Move mbox_out declaration inline. (Jonathan)
- Fix __counted_by() input. (Jonathan)
- Return count for cxl_get_supported_features_count(). (Dan)
- Remove goto from cxl_get_supported_features(). (Dan)
- Return cxl_get_supported_feature_entry() directly. (Dan)
- Drop user path enumeration. (Dan)
- Move to the feature driver model. (Dan)
- Add support for 0 feature data requested.
- Add missing increment of feature data ptr during copy.
---
 drivers/cxl/core/features.c |  28 +++++++
 drivers/cxl/core/mbox.c     |   3 +-
 drivers/cxl/cxl.h           |   2 +
 drivers/cxl/features.c      | 146 +++++++++++++++++++++++++++++++++++-
 include/cxl/features.h      |  32 ++++++++
 5 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index eb6eb191a32e..66a4b82910e6 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
 #include <linux/device.h>
+#include <cxl/mailbox.h>
 #include "cxl.h"
 #include "core.h"
 
@@ -69,3 +70,30 @@ struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_features_alloc, "CXL");
+
+struct cxl_feat_entry *
+cxl_get_supported_feature_entry(struct cxl_features *features,
+				const uuid_t *feat_uuid)
+{
+	struct cxl_feat_entry *feat_entry;
+	struct cxl_features_state *cfs;
+	int count;
+
+	cfs = dev_get_drvdata(&features->dev);
+	if (!cfs)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!cfs->num_features)
+		return ERR_PTR(-ENOENT);
+
+	/* Check CXL dev supports the feature */
+	feat_entry = cfs->entries;
+	for (count = 0; count < cfs->num_features;
+	     count++, feat_entry++) {
+		if (uuid_equal(&feat_entry->uuid, feat_uuid))
+			return feat_entry;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, "CXL");
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5e21ff99d70f..0b4946205910 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -234,7 +234,7 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
 	return NULL;
 }
 
-static struct cxl_mem_command *cxl_find_feature_command(u16 opcode)
+struct cxl_mem_command *cxl_find_feature_command(u16 opcode)
 {
 	struct cxl_mem_command *c;
 
@@ -244,6 +244,7 @@ static struct cxl_mem_command *cxl_find_feature_command(u16 opcode)
 
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_find_feature_command, "CXL");
 
 static const char *cxl_mem_opcode_to_name(u16 opcode)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ee29d1a1c8df..1284614d71d0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -912,6 +912,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+struct cxl_mem_command *cxl_find_feature_command(u16 opcode);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 644add26975f..a5949312a4ab 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -3,20 +3,164 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <cxl/mailbox.h>
 #include <cxl/features.h>
 
 #include "cxl.h"
+#include "cxlmem.h"
+
+static void cxl_free_feature_entries(void *entries)
+{
+	kvfree(entries);
+}
+
+static int cxl_get_supported_features_count(struct cxl_mailbox *cxl_mbox)
+{
+	struct cxl_mbox_get_sup_feats_out mbox_out;
+	struct cxl_mbox_get_sup_feats_in mbox_in;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	memset(&mbox_in, 0, sizeof(mbox_in));
+	mbox_in.count = cpu_to_le32(sizeof(mbox_out));
+	memset(&mbox_out, 0, sizeof(mbox_out));
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+		.size_in = sizeof(mbox_in),
+		.payload_in = &mbox_in,
+		.size_out = sizeof(mbox_out),
+		.payload_out = &mbox_out,
+		.min_out = sizeof(mbox_out),
+	};
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	return le16_to_cpu(mbox_out.supported_feats);
+}
+
+static int cxl_get_supported_features(struct cxl_features_state *cfs)
+{
+	int remain_feats, max_size, max_feats, start, rc, hdr_size;
+	struct cxl_mailbox *cxl_mbox = cfs->features->cxl_mbox;
+	int feat_size = sizeof(struct cxl_feat_entry);
+	struct cxl_mbox_get_sup_feats_in mbox_in;
+	struct cxl_feat_entry *entry;
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mem_command *cmd;
+	int count;
+
+	/* Get supported features is optional, need to check */
+	cmd = cxl_find_feature_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
+	if (!cmd)
+		return -EOPNOTSUPP;
+	if (!test_bit(cmd->info.id, cxl_mbox->feature_cmds))
+		return -EOPNOTSUPP;
+
+	count = cxl_get_supported_features_count(cxl_mbox);
+	if (count == 0)
+		return 0;
+	if (count < 0)
+		return -ENXIO;
+
+	struct cxl_feat_entry *entries __free(kvfree) =
+		kvmalloc(count * sizeof(*entries), GFP_KERNEL);
+	if (!entries)
+		return -ENOMEM;
+
+	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
+		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!mbox_out)
+		return -ENOMEM;
+
+	hdr_size = sizeof(*mbox_out);
+	max_size = cxl_mbox->payload_size - hdr_size;
+	/* max feat entries that can fit in mailbox max payload size */
+	max_feats = max_size / feat_size;
+	entry = entries;
+
+	start = 0;
+	remain_feats = count;
+	do {
+		int retrieved, alloc_size, copy_feats;
+		int num_entries;
+
+		if (remain_feats > max_feats) {
+			alloc_size = sizeof(*mbox_out) + max_feats * feat_size;
+			remain_feats = remain_feats - max_feats;
+			copy_feats = max_feats;
+		} else {
+			alloc_size = sizeof(*mbox_out) + remain_feats * feat_size;
+			copy_feats = remain_feats;
+			remain_feats = 0;
+		}
+
+		memset(&mbox_in, 0, sizeof(mbox_in));
+		mbox_in.count = cpu_to_le32(alloc_size);
+		mbox_in.start_idx = cpu_to_le16(start);
+		memset(mbox_out, 0, alloc_size);
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+			.size_in = sizeof(mbox_in),
+			.payload_in = &mbox_in,
+			.size_out = alloc_size,
+			.payload_out = mbox_out,
+			.min_out = hdr_size,
+		};
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0)
+			return rc;
+
+		if (mbox_cmd.size_out <= hdr_size)
+			return -ENXIO;
+
+		/*
+		 * Make sure retrieved out buffer is multiple of feature
+		 * entries.
+		 */
+		retrieved = mbox_cmd.size_out - hdr_size;
+		if (retrieved % feat_size)
+			return -ENXIO;
+
+		num_entries = le16_to_cpu(mbox_out->num_entries);
+		/*
+		 * If the reported output entries * defined entry size !=
+		 * retrieved output bytes, then the output package is incorrect.
+		 */
+		if (num_entries * feat_size != retrieved)
+			return -ENXIO;
+
+		memcpy(entry, mbox_out->ents, retrieved);
+		entry++;
+		/*
+		 * If the number of output entries is less than expected, add the
+		 * remaining entries to the next batch.
+		 */
+		remain_feats += copy_feats - num_entries;
+		start += num_entries;
+	} while (remain_feats);
+
+	cfs->num_features = count;
+	cfs->entries = no_free_ptr(entries);
+	return devm_add_action_or_reset(&cfs->features->dev,
+					cxl_free_feature_entries, cfs->entries);
+}
 
 static int cxl_features_probe(struct device *dev)
 {
 	struct cxl_features *features = to_cxl_features(dev);
+	int rc;
+
 	struct cxl_features_state *cfs __free(kfree) =
 		kzalloc(sizeof(*cfs), GFP_KERNEL);
-
 	if (!cfs)
 		return -ENOMEM;
 
 	cfs->features = features;
+	rc = cxl_get_supported_features(cfs);
+	if (rc)
+		return rc;
+
 	dev_set_drvdata(dev, no_free_ptr(cfs));
 
 	return 0;
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 7a8be3c621a1..429b9782667c 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -3,6 +3,8 @@
 #ifndef __CXL_FEATURES_H__
 #define __CXL_FEATURES_H__
 
+#include <linux/uuid.h>
+
 struct cxl_mailbox;
 
 enum feature_cmds {
@@ -19,12 +21,42 @@ struct cxl_features {
 };
 #define to_cxl_features(dev) container_of(dev, struct cxl_features, dev)
 
+/* Get Supported Features (0x500h) CXL r3.1 8.2.9.6.1 */
+struct cxl_mbox_get_sup_feats_in {
+	__le32 count;
+	__le16 start_idx;
+	u8 reserved[2];
+} __packed;
+
+struct cxl_feat_entry {
+	uuid_t uuid;
+	__le16 id;
+	__le16 get_feat_size;
+	__le16 set_feat_size;
+	__le32 flags;
+	u8 get_feat_ver;
+	u8 set_feat_ver;
+	__le16 effects;
+	u8 reserved[18];
+} __packed;
+
+struct cxl_mbox_get_sup_feats_out {
+	__le16 num_entries;
+	__le16 supported_feats;
+	u8 reserved[4];
+	struct cxl_feat_entry ents[] __counted_by_le(num_entries);
+} __packed;
+
 struct cxl_features_state {
 	struct cxl_features *features;
 	int num_features;
+	struct cxl_feat_entry *entries;
 };
 
 struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
 					struct device *parent);
+struct cxl_feat_entry *
+cxl_get_supported_feature_entry(struct cxl_features *features,
+				const uuid_t *feat_uuid);
 
 #endif
-- 
2.47.1

