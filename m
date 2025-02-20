Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55F1CAA6E
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065852; cv=none; b=CGiIj/QbW8i/+iOnU05fzORfpbuQpS0e0uRKfb3qBEOTPDMhNSwAGeRr2a9hU32ZgmUt6rJvAWvB+tx1hUZhGWLmYUBft8Hw9vj9yM70IsL8wfrOuqv2uS6KTPwb8gLe/w4jIYsXG3Kkli97moiDkviMe12sT+ph7gTjDo9hGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065852; c=relaxed/simple;
	bh=wqwjZQRce8VLpkGND4Z+5m1KH4LJAySzr9lNWn9iaaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQuMLj2S53cK+Cf7Wh7vqF+rgxACqZMuHDKPvU1Ged2RDQIgVtv6Dwdi3yk3OQYpGrCL5cCnEk23Bi7zT2zURHZtmemykLNsASYL5g21zyHQfU37aqUrC4hw8lHRTQVCOZZmajy3BjWBTy2eWT4WfnKCKrCS0Y3lFibs1fbypx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzHPk3Mxlz6GDnK;
	Thu, 20 Feb 2025 23:34:50 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B378140B39;
	Thu, 20 Feb 2025 23:37:28 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Feb 2025 16:37:28 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 20 Feb 2025 16:37:28 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"saeed@kernel.org" <saeed@kernel.org>, Li Ming <ming.li@zohomail.com>
Subject: RE: [PATCH v6 02/14] cxl: Add Get Supported Features command for
 kernel usage
Thread-Topic: [PATCH v6 02/14] cxl: Add Get Supported Features command for
 kernel usage
Thread-Index: AQHbgliRQnDJmMSlik2vt7gwCI+93rNQVFXQ
Date: Thu, 20 Feb 2025 15:37:27 +0000
Message-ID: <41d3ba24f5354b67ab261c6a24f09ffb@huawei.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-3-dave.jiang@intel.com>
In-Reply-To: <20250218225721.2682235-3-dave.jiang@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Dave Jiang <dave.jiang@intel.com>
>Sent: 18 February 2025 22:55
>To: linux-cxl@vger.kernel.org
>Cc: dan.j.williams@intel.com; ira.weiny@intel.com; vishal.l.verma@intel.co=
m;
>alison.schofield@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave@stgolabs.net; jgg@nvidia.com; Shiju
>Jose <shiju.jose@huawei.com>; saeed@kernel.org; Li Ming
><ming.li@zohomail.com>
>Subject: [PATCH v6 02/14] cxl: Add Get Supported Features command for kern=
el
>usage
>
>CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h) The command
>retrieve the list of supported device-specific features (identified by UUI=
D) and
>general information about each Feature.
>
>The driver will retrieve the Feature entries in order to make checks and p=
rovide
>information for the Get Feature and Set Feature command. One of the main
>piece of information retrieved are the effects a Set Feature command would
>have for a particular feature. The retrieved Feature entries are stored in=
 the
>cxl_mailbox context.
>
>The setup of Features is initiated via devm_cxl_setup_features() during th=
e pci
>probe function before the cxl_memdev is enumerated.
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Reviewed-by: Li Ming <ming.li@zohomail.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Tested-by: Shiju Jose <shiju.jose@huawei.com>

>---
>v6:
>- Remove @cap comment from 'cxl_features_state' (Shiju)
>---
> drivers/cxl/Kconfig          |  11 +++
> drivers/cxl/core/Makefile    |   1 +
> drivers/cxl/core/features.c  | 175 +++++++++++++++++++++++++++++++++++
> drivers/cxl/cxlmem.h         |   4 +
> drivers/cxl/pci.c            |   4 +
> include/cxl/features.h       |  87 +++++++++++++++++
> tools/testing/cxl/Kbuild     |   1 +
> tools/testing/cxl/test/mem.c |   4 +
> 8 files changed, 287 insertions(+)
> create mode 100644 drivers/cxl/core/features.c
>
>diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig index
>876469e23f7a..ad2e796e4ac6 100644
>--- a/drivers/cxl/Kconfig
>+++ b/drivers/cxl/Kconfig
>@@ -102,6 +102,17 @@ config CXL_MEM
>
> 	  If unsure say 'm'.
>
>+config CXL_FEATURES
>+	bool "CXL: Features"
>+	depends on CXL_PCI
>+	help
>+	  Enable support for CXL Features. A CXL device that includes a mailbox
>+	  supports commands that allows listing, getting, and setting of
>+	  optionally defined features such as memory sparing or post package
>+	  sparing. Vendors may define custom features for the device.
>+
>+	  If unsure say 'n'
>+
> config CXL_PORT
> 	default CXL_BUS
> 	tristate
>diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile index
>9259bcc6773c..b0bfbd9eac9b 100644
>--- a/drivers/cxl/core/Makefile
>+++ b/drivers/cxl/core/Makefile
>@@ -16,3 +16,4 @@ cxl_core-y +=3D pmu.o
> cxl_core-y +=3D cdat.o
> cxl_core-$(CONFIG_TRACING) +=3D trace.o
> cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
>+cxl_core-$(CONFIG_CXL_FEATURES) +=3D features.o
>diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c new=
 file
>mode 100644 index 000000000000..f2898a56bd63
>--- /dev/null
>+++ b/drivers/cxl/core/features.c
>@@ -0,0 +1,175 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
>+#include <linux/device.h> #include <cxl/mailbox.h> #include
>+<cxl/features.h> #include "cxl.h"
>+#include "cxlmem.h"
>+
>+inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>+{
>+	return cxlds->cxlfs;
>+}
>+EXPORT_SYMBOL_NS_GPL(to_cxlfs, "CXL");
>+
>+static int cxl_get_supported_features_count(struct cxl_mailbox
>+*cxl_mbox) {
>+	struct cxl_mbox_get_sup_feats_out mbox_out;
>+	struct cxl_mbox_get_sup_feats_in mbox_in;
>+	struct cxl_mbox_cmd mbox_cmd;
>+	int rc;
>+
>+	memset(&mbox_in, 0, sizeof(mbox_in));
>+	mbox_in.count =3D cpu_to_le32(sizeof(mbox_out));
>+	memset(&mbox_out, 0, sizeof(mbox_out));
>+	mbox_cmd =3D (struct cxl_mbox_cmd) {
>+		.opcode =3D CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>+		.size_in =3D sizeof(mbox_in),
>+		.payload_in =3D &mbox_in,
>+		.size_out =3D sizeof(mbox_out),
>+		.payload_out =3D &mbox_out,
>+		.min_out =3D sizeof(mbox_out),
>+	};
>+	rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>+	if (rc < 0)
>+		return rc;
>+
>+	return le16_to_cpu(mbox_out.supported_feats);
>+}
>+
>+static struct cxl_feat_entries *
>+get_supported_features(struct cxl_features_state *cxlfs) {
>+	int remain_feats, max_size, max_feats, start, rc, hdr_size;
>+	struct cxl_mailbox *cxl_mbox =3D &cxlfs->cxlds->cxl_mbox;
>+	int feat_size =3D sizeof(struct cxl_feat_entry);
>+	struct cxl_mbox_get_sup_feats_in mbox_in;
>+	struct cxl_feat_entry *entry;
>+	struct cxl_mbox_cmd mbox_cmd;
>+	int count;
>+
>+	count =3D cxl_get_supported_features_count(cxl_mbox);
>+	if (count <=3D 0)
>+		return NULL;
>+
>+	struct cxl_feat_entries *entries __free(kvfree) =3D
>+		kvmalloc(struct_size(entries, ent, count), GFP_KERNEL);
>+	if (!entries)
>+		return NULL;
>+
>+	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =3D
>+		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>+	if (!mbox_out)
>+		return NULL;
>+
>+	hdr_size =3D struct_size(mbox_out, ents, 0);
>+	max_size =3D cxl_mbox->payload_size - hdr_size;
>+	/* max feat entries that can fit in mailbox max payload size */
>+	max_feats =3D max_size / feat_size;
>+	entry =3D entries->ent;
>+
>+	start =3D 0;
>+	remain_feats =3D count;
>+	do {
>+		int retrieved, alloc_size, copy_feats;
>+		int num_entries;
>+
>+		if (remain_feats > max_feats) {
>+			alloc_size =3D struct_size(mbox_out, ents, max_feats);
>+			remain_feats =3D remain_feats - max_feats;
>+			copy_feats =3D max_feats;
>+		} else {
>+			alloc_size =3D struct_size(mbox_out, ents, remain_feats);
>+			copy_feats =3D remain_feats;
>+			remain_feats =3D 0;
>+		}
>+
>+		memset(&mbox_in, 0, sizeof(mbox_in));
>+		mbox_in.count =3D cpu_to_le32(alloc_size);
>+		mbox_in.start_idx =3D cpu_to_le16(start);
>+		memset(mbox_out, 0, alloc_size);
>+		mbox_cmd =3D (struct cxl_mbox_cmd) {
>+			.opcode =3D CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>+			.size_in =3D sizeof(mbox_in),
>+			.payload_in =3D &mbox_in,
>+			.size_out =3D alloc_size,
>+			.payload_out =3D mbox_out,
>+			.min_out =3D hdr_size,
>+		};
>+		rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>+		if (rc < 0)
>+			return NULL;
>+
>+		if (mbox_cmd.size_out <=3D hdr_size)
>+			return NULL;
>+
>+		/*
>+		 * Make sure retrieved out buffer is multiple of feature
>+		 * entries.
>+		 */
>+		retrieved =3D mbox_cmd.size_out - hdr_size;
>+		if (retrieved % feat_size)
>+			return NULL;
>+
>+		num_entries =3D le16_to_cpu(mbox_out->num_entries);
>+		/*
>+		 * If the reported output entries * defined entry size !=3D
>+		 * retrieved output bytes, then the output package is incorrect.
>+		 */
>+		if (num_entries * feat_size !=3D retrieved)
>+			return NULL;
>+
>+		memcpy(entry, mbox_out->ents, retrieved);
>+		entry +=3D num_entries;
>+		/*
>+		 * If the number of output entries is less than expected, add the
>+		 * remaining entries to the next batch.
>+		 */
>+		remain_feats +=3D copy_feats - num_entries;
>+		start +=3D num_entries;
>+	} while (remain_feats);
>+
>+	entries->num_features =3D count;
>+
>+	return no_free_ptr(entries);
>+}
>+
>+static void free_cxlfs(void *_cxlfs)
>+{
>+	struct cxl_features_state *cxlfs =3D _cxlfs;
>+	struct cxl_dev_state *cxlds =3D cxlfs->cxlds;
>+
>+	cxlds->cxlfs =3D NULL;
>+	kvfree(cxlfs->entries);
>+	kfree(cxlfs);
>+}
>+
>+/**
>+ * devm_cxl_setup_features() - Allocate and initialize features context
>+ * @cxlds: CXL device context
>+ *
>+ * Return 0 on success or -errno on failure.
>+ */
>+int devm_cxl_setup_features(struct cxl_dev_state *cxlds) {
>+	struct cxl_mailbox *cxl_mbox =3D &cxlds->cxl_mbox;
>+
>+	if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
>+		return -ENODEV;
>+
>+	struct cxl_features_state *cxlfs __free(kfree) =3D
>+		kzalloc(sizeof(*cxlfs), GFP_KERNEL);
>+	if (!cxlfs)
>+		return -ENOMEM;
>+
>+	cxlfs->cxlds =3D cxlds;
>+
>+	cxlfs->entries =3D get_supported_features(cxlfs);
>+	if (!cxlfs->entries)
>+		return -ENOMEM;
>+
>+	cxlds->cxlfs =3D cxlfs;
>+
>+	return devm_add_action_or_reset(cxlds->dev, free_cxlfs,
>+no_free_ptr(cxlfs)); } EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features,
>+"CXL");
>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
>55c55685cb39..0dc2682eb379 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -392,6 +392,7 @@ struct cxl_dpa_perf {
>  * @serial: PCIe Device Serial Number
>  * @type: Generic Memory Class device or Vendor Specific Memory device
>  * @cxl_mbox: CXL mailbox context
>+ * @cxl_features: CXL features context
>  */
> struct cxl_dev_state {
> 	struct device *dev;
>@@ -407,6 +408,9 @@ struct cxl_dev_state {
> 	u64 serial;
> 	enum cxl_devtype type;
> 	struct cxl_mailbox cxl_mbox;
>+#ifdef CONFIG_CXL_FEATURES
>+	struct cxl_features_state *cxlfs;
>+#endif
> };
>
> static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl=
_mbox)
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
>a96e54c6259e..3e666ec51580 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -997,6 +997,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const
>struct pci_device_id *id)
> 	if (rc)
> 		return rc;
>
>+	rc =3D devm_cxl_setup_features(cxlds);
>+	if (rc)
>+		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
>+
> 	cxlmd =3D devm_cxl_add_memdev(&pdev->dev, cxlds);
> 	if (IS_ERR(cxlmd))
> 		return PTR_ERR(cxlmd);
>diff --git a/include/cxl/features.h b/include/cxl/features.h index
>357d3acf8429..5b3485eb0f77 100644
>--- a/include/cxl/features.h
>+++ b/include/cxl/features.h
>@@ -3,6 +3,8 @@
> #ifndef __CXL_FEATURES_H__
> #define __CXL_FEATURES_H__
>
>+#include <linux/uuid.h>
>+
> /* Feature commands capability supported by a device */  enum
>cxl_features_capability {
> 	CXL_FEATURES_NONE =3D 0,
>@@ -10,4 +12,89 @@ enum cxl_features_capability {
> 	CXL_FEATURES_RW,
> };
>
>+/* Get Supported Features (0x500h) CXL r3.2 8.2.9.6.1 */ struct
>+cxl_mbox_get_sup_feats_in {
>+	__le32 count;
>+	__le16 start_idx;
>+	u8 reserved[2];
>+} __packed;
>+
>+/* CXL spec r3.2 Table 8-87 command effects */
>+#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)
>+#define CXL_CMD_CONFIG_CHANGE_IMMEDIATE		BIT(1)
>+#define CXL_CMD_DATA_CHANGE_IMMEDIATE		BIT(2)
>+#define CXL_CMD_POLICY_CHANGE_IMMEDIATE		BIT(3)
>+#define CXL_CMD_LOG_CHANGE_IMMEDIATE		BIT(4)
>+#define CXL_CMD_SECURITY_STATE_CHANGE		BIT(5)
>+#define CXL_CMD_BACKGROUND			BIT(6)
>+#define CXL_CMD_BGCMD_ABORT_SUPPORTED		BIT(7)
>+#define CXL_CMD_EFFECTS_VALID			BIT(9)
>+#define CXL_CMD_CONFIG_CHANGE_CONV_RESET	BIT(10)
>+#define CXL_CMD_CONFIG_CHANGE_CXL_RESET		BIT(11)
>+
>+/*
>+ * CXL spec r3.2 Table 8-109
>+ * Get Supported Features Supported Feature Entry  */ struct
>+cxl_feat_entry {
>+	uuid_t uuid;
>+	__le16 id;
>+	__le16 get_feat_size;
>+	__le16 set_feat_size;
>+	__le32 flags;
>+	u8 get_feat_ver;
>+	u8 set_feat_ver;
>+	__le16 effects;
>+	u8 reserved[18];
>+} __packed;
>+
>+/* @flags field for 'struct cxl_feat_entry' */
>+#define CXL_FEATURE_F_CHANGEABLE		BIT(0)
>+#define CXL_FEATURE_F_PERSIST_FW_UPDATE		BIT(4)
>+#define CXL_FEATURE_F_DEFAULT_SEL		BIT(5)
>+#define CXL_FEATURE_F_SAVED_SEL			BIT(6)
>+
>+/*
>+ * CXL spec r3.2 Table 8-108
>+ * Get supported Features Output Payload  */ struct
>+cxl_mbox_get_sup_feats_out {
>+	__struct_group(cxl_mbox_get_sup_feats_out_hdr, hdr, /* no attrs */,
>+		__le16 num_entries;
>+		__le16 supported_feats;
>+		__u8 reserved[4];
>+	);
>+	struct cxl_feat_entry ents[] __counted_by_le(num_entries); } __packed;
>+
>+/**
>+ * struct cxl_features_state - The Features state for the device
>+ * @cxlds: Pointer to CXL device state
>+ * @entries: CXl feature entry context
>+ *	@num_features: total Features supported by the device
>+ *	@ent: Flex array of Feature detail entries from the device
>+ */
>+struct cxl_features_state {
>+	struct cxl_dev_state *cxlds;
>+	struct cxl_feat_entries {
>+		int num_features;
>+		struct cxl_feat_entry ent[] __counted_by(num_features);
>+	} *entries;
>+};
>+
>+#ifdef CONFIG_CXL_FEATURES
>+inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state
>+*cxlds); int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
>+#else static inline struct cxl_features_state *to_cxlfs(struct
>+cxl_dev_state *cxlds) {
>+	return NULL;
>+}
>+
>+static inline int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
>+{
>+	return -EOPNOTSUPP;
>+}
>+#endif
>+
> #endif
>diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild index
>b1256fee3567..0a6572ab6f37 100644
>--- a/tools/testing/cxl/Kbuild
>+++ b/tools/testing/cxl/Kbuild
>@@ -63,6 +63,7 @@ cxl_core-y +=3D $(CXL_CORE_SRC)/pmu.o  cxl_core-y +=3D
>$(CXL_CORE_SRC)/cdat.o
> cxl_core-$(CONFIG_TRACING) +=3D $(CXL_CORE_SRC)/trace.o
> cxl_core-$(CONFIG_CXL_REGION) +=3D $(CXL_CORE_SRC)/region.o
>+cxl_core-$(CONFIG_CXL_FEATURES) +=3D $(CXL_CORE_SRC)/features.o
> cxl_core-y +=3D config_check.o
> cxl_core-y +=3D cxl_core_test.o
> cxl_core-y +=3D cxl_core_exports.o
>diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c i=
ndex
>8d731bd63988..e9494cd446ef 100644
>--- a/tools/testing/cxl/test/mem.c
>+++ b/tools/testing/cxl/test/mem.c
>@@ -1558,6 +1558,10 @@ static int cxl_mock_mem_probe(struct
>platform_device *pdev)
> 	if (rc)
> 		return rc;
>
>+	rc =3D devm_cxl_setup_features(cxlds);
>+	if (rc)
>+		dev_dbg(dev, "No CXL Features discovered\n");
>+
> 	cxl_mock_add_event_logs(&mdata->mes);
>
> 	cxlmd =3D devm_cxl_add_memdev(&pdev->dev, cxlds);
>--
>2.48.1

