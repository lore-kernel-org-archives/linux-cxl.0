Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03991E522
	for <linux-cxl@vger.kernel.org>; Wed, 21 Aug 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256353; cv=none; b=oewRl08aOLsrP0wAZKtu3y68zdKwW3ElHpd7LkFauE22lJ1Rpnep9KHs+XhsWKKqWE3eWaguZj//2U8bv+ZQ3n+s4pZ+VJmDpB03sT0IZUl1q63EM5ueksKvZdS7OF+O8BAqvOaCifzQOjxuGF/dRwhz75reZafmfFrBtq7mekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256353; c=relaxed/simple;
	bh=erTXL4XTHvbLZD8bmG76I+YacV7o3D9GmT6+i53V5do=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rLdIS3e8tUggAO9ku4zNPtgYitP0Wc93B189mRRdas4dNCc3yiAAm9MgU90JLpOf3DnJDodc7dECuMtOVK6203+fCA4Wzn7F8rZ0xPkvBGyCGiCX1VH2rkK3/PAZT3BV1EVzJbCiuvVbXxGQwAHXHFt3s6BqAX3oK1wkTIusygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WprhS3ThWz6K9FT;
	Thu, 22 Aug 2024 00:02:48 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (unknown [7.191.162.219])
	by mail.maildlp.com (Postfix) with ESMTPS id B3CCC140B2A;
	Thu, 22 Aug 2024 00:05:47 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 17:05:47 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Wed, 21 Aug 2024 17:05:47 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [RFC PATCH 04/13] cxl: Add Get Supported Features command for
 kernel usage
Thread-Topic: [RFC PATCH 04/13] cxl: Add Get Supported Features command for
 kernel usage
Thread-Index: AQHa2Vpbfc+1y3FEh0eFdrM4Im1L47Ix+n/A
Date: Wed, 21 Aug 2024 16:05:47 +0000
Message-ID: <3067b2de83734e1fbe0bc3b93e45ce79@huawei.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-5-dave.jiang@intel.com>
In-Reply-To: <20240718213446.1750135-5-dave.jiang@intel.com>
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

Hi Dave,

Few comments inline.

>-----Original Message-----
>From: Dave Jiang <dave.jiang@intel.com>
>Sent: 18 July 2024 22:32
>To: linux-cxl@vger.kernel.org
>Cc: dan.j.williams@intel.com; ira.weiny@intel.com; vishal.l.verma@intel.co=
m;
>alison.schofield@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave@stgolabs.net; jgg@nvidia.com; Shiju
>Jose <shiju.jose@huawei.com>
>Subject: [RFC PATCH 04/13] cxl: Add Get Supported Features command for
>kernel usage
>
>CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h) The command
>retrieve the list of supported device-specific features (identified by UUI=
D) and
>general information about each Feature.
>
>The driver will retrieve the feature entries in order to make checks and p=
rovide
>information for the Get Feature and Set Feature command. One of the main
>piece of information retrieved are the effects a Set Feature command would
>have for a particular feature.
>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>---
> drivers/cxl/core/mbox.c      | 151 +++++++++++++++++++++++++++++++++++
> drivers/cxl/cxlmem.h         |  29 +++++++
> drivers/cxl/pci.c            |   4 +
> include/linux/cxl/mailbox.h  |   3 +
> include/uapi/linux/cxl_mem.h |   1 +
> 5 files changed, 188 insertions(+)
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>b9c64f1837a8..70e3962ed570 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -67,6 +67,7 @@ static struct cxl_mem_command
>cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] =3D {
> 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
> 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>+	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD,
>0),
> };
>
> /*
>@@ -790,6 +791,156 @@ static const uuid_t log_uuid[] =3D {
> 	[VENDOR_DEBUG_UUID] =3D DEFINE_CXL_VENDOR_DEBUG_UUID,  };
>
>+static void cxl_free_features(void *features) {
>+	kvfree(features);
>+}
>+
>+static int cxl_get_supported_features_count(struct cxl_mailbox
>+*cxl_mbox) {
>+	struct cxl_mbox_get_sup_feats_out mbox_out;
>+	struct cxl_mbox_get_sup_feats_in mbox_in;
>+	struct cxl_mbox_cmd mbox_cmd;
>+	int rc;
>+
>+	memset(&mbox_in, 0, sizeof(mbox_in));
>+	mbox_in.count =3D sizeof(mbox_out);
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
>+	cxl_mbox->num_features =3D le16_to_cpu(mbox_out.supported_feats);
>+	if (!cxl_mbox->num_features)
>+		return -ENOENT;
>+
>+	return 0;
>+}
>+
>+int cxl_get_supported_features(struct cxl_mailbox *cxl_mbox) {
>+	int remain_feats, max_size, max_feats, start, rc;
>+	int feat_size =3D sizeof(struct cxl_feat_entry);
>+	struct cxl_mbox_get_sup_feats_out *mbox_out;
>+	struct cxl_mbox_get_sup_feats_in mbox_in;
>+	int hdr_size =3D sizeof(*mbox_out);
>+	struct cxl_mbox_cmd mbox_cmd;
>+	struct cxl_mem_command *cmd;
>+	void *ptr;
>+
>+	/* Get supported features is optional, need to check */
>+	cmd =3D
>cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
>+	if (!cmd)
>+		return -EOPNOTSUPP;
>+	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
>+		return -EOPNOTSUPP;
>+
>+	rc =3D cxl_get_supported_features_count(cxl_mbox);
>+	if (rc)
>+		return rc;
>+
>+	struct cxl_feat_entry *entries __free(kvfree) =3D
>+		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
>+
>+	if (!entries)
>+		return -ENOMEM;
>+
>+	cxl_mbox->entries =3D no_free_ptr(entries);
>+	rc =3D devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
>+				      cxl_mbox->entries);
>+	if (rc)
>+		return rc;
>+
>+	max_size =3D cxl_mbox->payload_size - hdr_size;
>+	/* max feat entries that can fit in mailbox max payload size */
>+	max_feats =3D max_size / feat_size;
>+	ptr =3D &cxl_mbox->entries[0];
>+
>+	mbox_out =3D kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>+	if (!mbox_out)
>+		return -ENOMEM;
>+
>+	start =3D 0;
>+	remain_feats =3D cxl_mbox->num_features;
>+	do {
>+		int retrieved, alloc_size, copy_feats;
>+
>+		if (remain_feats > max_feats) {
>+			alloc_size =3D sizeof(*mbox_out) + max_feats * feat_size;
>+			remain_feats =3D remain_feats - max_feats;
>+			copy_feats =3D max_feats;
>+		} else {
>+			alloc_size =3D sizeof(*mbox_out) + remain_feats *
>feat_size;
>+			copy_feats =3D remain_feats;
>+			remain_feats =3D 0;
>+		}
>+
>+		memset(&mbox_in, 0, sizeof(mbox_in));
>+		mbox_in.count =3D alloc_size;
>+		mbox_in.start_idx =3D start;
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
Please free mbox_out here.
>+			return rc;
>+
>+		if (mbox_cmd.size_out <=3D hdr_size) {
>+			rc =3D -ENXIO;
>+			goto err;
>+		}
>+
>+		/*
>+		 * Make sure retrieved out buffer is multiple of feature
>+		 * entries.
>+		 */
>+		retrieved =3D mbox_cmd.size_out - hdr_size;
>+		if (retrieved % sizeof(struct cxl_feat_entry)) {
May be replace with feat_size  as it was set to sizeof(struct cxl_feat_entr=
y)?=20
>+			rc =3D -ENXIO;
>+			goto err;
>+		}
>+
>+		/*
>+		 * If the reported output entries * defined entry size !=3D
>+		 * retrieved output bytes, then the output package is incorrect.
>+		 */
>+		if (mbox_out->num_entries * feat_size !=3D retrieved) {
>+			rc =3D -ENXIO;
>+			goto err;
>+		}
>+
>+		memcpy(ptr, mbox_out->ents, retrieved);
>+		ptr +=3D retrieved;
>+		/*
>+		 * If the number of output entries is less than expected, add the
>+		 * remaining entries to the next batch.
>+		 */
>+		remain_feats +=3D copy_feats - mbox_out->num_entries;
>+		start +=3D mbox_out->num_entries;
>+	} while (remain_feats);
>+
>+	return 0;
>+
>+err:
Please free mbox_out here.
>+	cxl_mbox->num_features =3D 0;
>+	return rc;
>+}
>+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>+
> /**
>  * cxl_enumerate_cmds() - Enumerate commands for a device.
>  * @mds: The driver data for the operation diff --git a/drivers/cxl/cxlme=
m.h
>b/drivers/cxl/cxlmem.h index efdf833f2c51..4d3690aa2f3b 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -482,6 +482,7 @@ enum cxl_opcode {
> 	CXL_MBOX_OP_GET_LOG_CAPS	=3D 0x0402,
> 	CXL_MBOX_OP_CLEAR_LOG           =3D 0x0403,
> 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST =3D 0x0405,
>+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	=3D 0x0500,
> 	CXL_MBOX_OP_IDENTIFY		=3D 0x4000,
> 	CXL_MBOX_OP_GET_PARTITION_INFO	=3D 0x4100,
> 	CXL_MBOX_OP_SET_PARTITION_INFO	=3D 0x4101,
>@@ -765,6 +766,32 @@ enum {
> 	CXL_PMEM_SEC_PASS_USER,
> };
>
>+/* Get Supported Features (0x500h) CXL r3.1 8.2.9.6.1 */ struct
>+cxl_mbox_get_sup_feats_in {
>+	__le32 count;
>+	__le16 start_idx;
>+	__le16 reserved;
Is u8  reserved[2]; better?=20
>+} __packed;
>+
>+struct cxl_feat_entry {
>+	uuid_t uuid;
>+	__le16 id;
>+	__le16 get_feat_size;
>+	__le16 set_feat_size;
>+	__le32 flags;
>+	u8 get_feat_ver;
>+	u8 set_feat_ver;
>+	__le16 effects;
May be set_effects?
>+	u8 reserved[18];
>+} __packed;
>+
>+struct cxl_mbox_get_sup_feats_out {
>+	__le16 num_entries;
>+	__le16 supported_feats;
>+	__le32 reserved;
u8  reserved[4]?
>+	struct cxl_feat_entry ents[]
>+__counted_by(le32_to_cpu(supported_feats));
>+} __packed;
>+
> int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
> 			  struct cxl_mbox_cmd *cmd);
> int cxl_dev_state_identify(struct cxl_memdev_state *mds); @@ -824,4 +851,=
6
>@@ struct cxl_hdm {  struct seq_file;  struct dentry
>*cxl_debugfs_create_dir(const char *dir);  void cxl_dpa_debug(struct seq_f=
ile
>*file, struct cxl_dev_state *cxlds);
>+
>+int cxl_get_supported_features(struct cxl_mailbox *cxl_mbox);
> #endif /* __CXL_MEM_H__ */
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
>7e26da706921..6a00238446f9 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -872,6 +872,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const
>struct pci_device_id *id)
> 	if (rc)
> 		return rc;
>
>+	rc =3D cxl_get_supported_features(&cxlds->cxl_mbox);
>+	if (rc)
>+		dev_dbg(&pdev->dev, "No features enumerated.\n");
>+
> 	rc =3D cxl_set_timestamp(mds);
> 	if (rc)
> 		return rc;
>diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h ind=
ex
>2380b22d7a12..570864239b8f 100644
>--- a/include/linux/cxl/mailbox.h
>+++ b/include/linux/cxl/mailbox.h
>@@ -53,6 +53,7 @@ struct cxl_mbox_cmd {
>  * @mbox_mutex: mutex protects device mailbox and firmware
>  * @mbox_wait: rcuwait for mailbox
>  * @mbox_send: @dev specific transport for transmitting mailbox commands
>+ * @features: number of supported features
>  */
> struct cxl_mailbox {
> 	struct device *host;
>@@ -63,6 +64,8 @@ struct cxl_mailbox {
> 	struct mutex mbox_mutex; /* lock to protect mailbox context */
> 	struct rcuwait mbox_wait;
> 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd
>*cmd);
>+	int num_features;
>+	struct cxl_feat_entry *entries;
Not sure storing the unrelated feature details in the struct cxl_mailbox is=
 appropriate?=20
> };
>
> #endif
>diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h i=
ndex
>c6c0fe27495d..bd2535962f70 100644
>--- a/include/uapi/linux/cxl_mem.h
>+++ b/include/uapi/linux/cxl_mem.h
>@@ -50,6 +50,7 @@
> 	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
> 	___C(CLEAR_LOG, "Clear Log"),					  \
> 	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
>+	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),
>	  \
> 	___C(MAX, "invalid / last command")
>
> #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
>--
>2.45.2

Thanks,
Shiju
