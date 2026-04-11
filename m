Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562A1CEADB
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871655; cv=none; b=aoHwNVPZTKzSnj46exXXmcxiDXrdTbcsFcA9C8qcwGYukqbJpn27u3Buri26MxO7omgraTP92A8zzx5jQpL+IH6GULyST7lJAIghdFGxqqADChTNBrKKjOXyy3MML9gjwrQBEbSQTZi5ptHFYt+PPsugxd1Ptn9/UlGSf8d0wM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871655; c=relaxed/simple;
	bh=s6rgC9u0mSxaoSiZwwzxI5lv3deFh3As4fpw4Tf5TA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHmI94a/kK0Hk3FKAHnHn0FVmfXuFr6HNdn+aE47JHS11GlDDD8ykhPLtpALgebJk0RR9E36XQ3YXNelFLAGq2h/gyO1A/o1qXRiwTDmcz538je42vbFDwutjA4Yp/lBBeYs6HIy8qBkrfuHTPbkR8rgBXBIJYmVPniic1b1AvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9Pd5r+G; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9Pd5r+G"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-793fdbb8d3aso30630167b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871653; x=1776476453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0W11I3lHWFkj3y5vdI0hMeQ/Q7jOhY7+EnFVHJ897U=;
        b=J9Pd5r+GzZjee8recbutPItqYLsu9OMrxvamw7kF0isjoRQf5pcpQ9bwzDTI8VkI5J
         96R1VojXYBSClwzVC9/Zfiec7RTqKB/HSuIFwowqaJvF0LgJIK5eqk9KEHrW2UgvTVaO
         BVLuW05FyvcX+uWWsiRlFoSr2oOOUVjOcf92lPMgKW+jldF9Q6DjVGZpY2ho2b1gjKr8
         GZ0Wznqkr3jxMNIVBXde0tXmRQW6tmrLmRJumCQ48EUM1obYBLJCFswa6t5trCOtzqRy
         snjI4W2kfBl/1qPdklMncE8ALb5cgCubyWZXGlicFuFQ9o2Rg6DnbOf9OX38+kNsOpE7
         PR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871653; x=1776476453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0W11I3lHWFkj3y5vdI0hMeQ/Q7jOhY7+EnFVHJ897U=;
        b=adkbQnfG/lSALykdniAfhaWkW2oKBD4V5bXvgjNmfpT4Su6FNQUjsNUv6wjUGcEu7c
         0vJkxNLI+vU8ZY/VZw+ZZvtFTNelpoPVk38BZwCgxarG21Q7SUjbsie0kTpBXgUnqonQ
         apAt3f+gfVNDhUPNeW2qPejszgPudiIpa6LUd0kV+b2j8VCewmiQhnssATw+3FJtYAvm
         09meFXFUkC5aDgnnykd2YjHxzlroIpl4lssqxyPOg45lPIST1X4olK/x9Uh1uc6vRoVn
         dft6aUgT0KYih5irjsajiJ2hHr7SyYP7YgE7ex9mB9aKD3YK0eJOhM8zzMFLfCTacvcv
         uz6A==
X-Gm-Message-State: AOJu0YyTERbjpc+7wo7kGf8xLlcB+EgOM9duAKygk2qqQHD/2QFcXKNH
	Mb4/7irSGhgQO1n96YluS2iCyN9/75rb6wbP/G8BFRihgH54xyhKYe6N5iFdeQ==
X-Gm-Gg: AeBDies0HcHrssNM3FIH8CTwDZHnmxuJmcRMJR3sjQahR3UYw8ux9uGVHUkG4iduSu8
	BaQY/OqKXFhDtXWu+dOSRWyH8YsEtBwiTW9enEGRL81yupzXiGhsgpUKcugMasGIpbI8q2f/U5w
	SYogZdNoxVkvcqx9bPwjFFS4w+RkzRBm6gtOSj7/ftaULI2osORrLGDpbsndOpq5E0GxyMJsup3
	2GxT6S74GczMnr96khNQKXdigJCPcUZsD7OnLJk1id1dej/G+dnJPvVTYIiur+c7MrgX9lspzNS
	GQOcuQREeDKjM9BdtxJee3vTvCtpqst94wGnLIl7UE9R3C21oPvrj1GKuBdInShQnzk1w2E98pe
	UcZOSy9HBCuhYlBfJwTkHHX5loofva75lEuT9IqeDwRUOxHBvw0PV5mB4grJs27hu3wSKiZDh2w
	o8IoN3J25Ij2ni0n1YbS2SDhcv+GjMxcrjjx85VlzzXQ==
X-Received: by 2002:a05:690c:83:b0:79a:6d65:c333 with SMTP id 00721157ae682-7af71b50716mr56483797b3.40.1775871652572;
        Fri, 10 Apr 2026 18:40:52 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:52 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 19/20] tools/testing/cxl: Add DC Regions to mock mem data
Date: Fri, 10 Apr 2026 18:23:14 -0700
Message-ID: <20260411013958.47422-20-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

cxl_test provides a good way to ensure quick smoke and regression
testing.  The complexity of Dynamic Capacity (DC) extent processing as
well as the complexity of the new sparse DAX regions can mostly be
tested through cxl_test.  This includes management of sparse regions and
DAX devices on those regions; the management of extent device lifetimes;
and the processing of DCD events.

The only missing functionality from this test is actual interrupt
processing.

Mock memory devices can easily mock DC information and manage fake
extent data.

Define mock_dc_partition information within the mock memory data.  Add
sysfs entries on the mock device to inject and delete extents.

The inject format is <start>:<length>:<tag>:<more_flag>
The delete format is <start>:<length>

Directly call the event irq callback to simulate irqs to process the
test extents.

Add DC mailbox commands to the CEL and implement those commands.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: rebase]
[djbw: s/region/partition/]
[iweiny: s/tag/uuid/]
---
 tools/testing/cxl/test/mem.c | 753 +++++++++++++++++++++++++++++++++++
 1 file changed, 753 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index fe1dadddd18e..6e3d97dce09e 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -20,6 +20,7 @@
 #define FW_SLOTS 3
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
+#define BASE_DYNAMIC_CAP_DPA DEV_SIZE
 
 #define MOCK_INJECT_DEV_MAX 8
 #define MOCK_INJECT_TEST_MAX 128
@@ -113,6 +114,22 @@ static struct cxl_cel_entry mock_cel[] = {
 				      EFFECT(SECURITY_CHANGE_IMMEDIATE) |
 				      EFFECT(BACKGROUND_OP)),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_DC_CONFIG),
+		.effect = CXL_CMD_EFFECT_NONE,
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_DC_EXTENT_LIST),
+		.effect = CXL_CMD_EFFECT_NONE,
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_ADD_DC_RESPONSE),
+		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE)),
+	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_RELEASE_DC),
+		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE)),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -173,6 +190,8 @@ struct vendor_test_feat {
 	__le32 data;
 } __packed;
 
+#define NUM_MOCK_DC_REGIONS 2
+
 struct cxl_mockmem_data {
 	void *lsa;
 	void *fw;
@@ -191,6 +210,20 @@ struct cxl_mockmem_data {
 	unsigned long sanitize_timeout;
 	struct vendor_test_feat test_feat;
 	u8 shutdown_state;
+
+	struct cxl_dc_partition dc_partitions[NUM_MOCK_DC_REGIONS];
+	u32 dc_ext_generation;
+	struct mutex ext_lock;
+
+	/*
+	 * Extents are in 1 of 3 states
+	 * FM (sysfs added but not sent to the host yet)
+	 * sent (sent to the host but not accepted)
+	 * accepted (by the host)
+	 */
+	struct xarray dc_fm_extents;
+	struct xarray dc_sent_extents;
+	struct xarray dc_accepted_exts;
 };
 
 static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -607,6 +640,251 @@ static void cxl_mock_event_trigger(struct device *dev)
 	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
 }
 
+struct cxl_extent_data {
+	u64 dpa_start;
+	u64 length;
+	u8 uuid[UUID_SIZE];
+	bool shared;
+};
+
+static int __devm_add_extent(struct device *dev, struct xarray *array,
+			     u64 start, u64 length, const char *uuid,
+			     bool shared)
+{
+	struct cxl_extent_data *extent;
+
+	extent = devm_kzalloc(dev, sizeof(*extent), GFP_KERNEL);
+	if (!extent)
+		return -ENOMEM;
+
+	extent->dpa_start = start;
+	extent->length = length;
+	memcpy(extent->uuid, uuid, min(sizeof(extent->uuid), strlen(uuid)));
+	extent->shared = shared;
+
+	if (xa_insert(array, start, extent, GFP_KERNEL)) {
+		devm_kfree(dev, extent);
+		dev_err(dev, "Failed xarry insert %#llx\n", start);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int devm_add_fm_extent(struct device *dev, u64 start, u64 length,
+			      const char *uuid, bool shared)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+
+	guard(mutex)(&mdata->ext_lock);
+	return __devm_add_extent(dev, &mdata->dc_fm_extents, start, length,
+				 uuid, shared);
+}
+
+/* It is known that ext and the new range are not equal */
+static struct cxl_extent_data *
+split_ext(struct device *dev, struct xarray *array,
+	  struct cxl_extent_data *ext, u64 start, u64 length)
+{
+	u64 new_start, new_length;
+
+	if (ext->dpa_start == start) {
+		new_start = start + length;
+		new_length = (ext->dpa_start + ext->length) - new_start;
+
+		if (__devm_add_extent(dev, array, new_start, new_length,
+				      ext->uuid, false))
+			return NULL;
+
+		ext = xa_erase(array, ext->dpa_start);
+		if (__devm_add_extent(dev, array, start, length, ext->uuid,
+				      false))
+			return NULL;
+
+		return xa_load(array, start);
+	}
+
+	/* ext->dpa_start != start */
+
+	if (__devm_add_extent(dev, array, start, length, ext->uuid, false))
+		return NULL;
+
+	new_start = ext->dpa_start;
+	new_length = start - ext->dpa_start;
+
+	ext = xa_erase(array, ext->dpa_start);
+	if (__devm_add_extent(dev, array, new_start, new_length, ext->uuid,
+			      false))
+		return NULL;
+
+	return xa_load(array, start);
+}
+
+/*
+ * Do not handle extents which are not inside a single extent sent to
+ * the host.
+ */
+static struct cxl_extent_data *
+find_create_ext(struct device *dev, struct xarray *array, u64 start, u64 length)
+{
+	struct cxl_extent_data *ext;
+	unsigned long index;
+
+	xa_for_each(array, index, ext) {
+		u64 end = start + length;
+
+		/* start < [ext) <= start */
+		if (start < ext->dpa_start ||
+		    (ext->dpa_start + ext->length) <= start)
+			continue;
+
+		if (end <= ext->dpa_start ||
+		    (ext->dpa_start + ext->length) < end) {
+			dev_err(dev, "Invalid range %#llx-%#llx\n", start,
+				end);
+			return NULL;
+		}
+
+		break;
+	}
+
+	if (!ext)
+		return NULL;
+
+	if (start == ext->dpa_start && length == ext->length)
+		return ext;
+
+	return split_ext(dev, array, ext, start, length);
+}
+
+static int dc_accept_extent(struct device *dev, u64 start, u64 length)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_extent_data *ext;
+
+	dev_dbg(dev, "Host accepting extent %#llx\n", start);
+	mdata->dc_ext_generation++;
+
+	lockdep_assert_held(&mdata->ext_lock);
+	ext = find_create_ext(dev, &mdata->dc_sent_extents, start, length);
+	if (!ext) {
+		dev_err(dev, "Extent %#llx-%#llx not found\n",
+			start, start + length);
+		return -ENOMEM;
+	}
+	ext = xa_erase(&mdata->dc_sent_extents, ext->dpa_start);
+	return xa_insert(&mdata->dc_accepted_exts, start, ext, GFP_KERNEL);
+}
+
+static void release_dc_ext(void *md)
+{
+	struct cxl_mockmem_data *mdata = md;
+
+	xa_destroy(&mdata->dc_fm_extents);
+	xa_destroy(&mdata->dc_sent_extents);
+	xa_destroy(&mdata->dc_accepted_exts);
+}
+
+/* Pretend to have some previous accepted extents */
+struct pre_ext_info {
+	u64 offset;
+	u64 length;
+} pre_ext_info[] = {
+	{
+		.offset = SZ_128M,
+		.length = SZ_64M,
+	},
+	{
+		.offset = SZ_256M,
+		.length = SZ_64M,
+	},
+};
+
+static int devm_add_sent_extent(struct device *dev, u64 start, u64 length,
+				const char *tag, bool shared)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+
+	lockdep_assert_held(&mdata->ext_lock);
+	return __devm_add_extent(dev, &mdata->dc_sent_extents, start, length,
+				 tag, shared);
+}
+
+static int inject_prev_extents(struct device *dev, u64 base_dpa)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	int rc;
+
+	dev_dbg(dev, "Adding %ld pre-extents for testing\n",
+		ARRAY_SIZE(pre_ext_info));
+
+	guard(mutex)(&mdata->ext_lock);
+	for (int i = 0; i < ARRAY_SIZE(pre_ext_info); i++) {
+		u64 ext_dpa = base_dpa + pre_ext_info[i].offset;
+		u64 ext_len = pre_ext_info[i].length;
+
+		dev_dbg(dev, "Adding pre-extent DPA:%#llx LEN:%#llx\n",
+			ext_dpa, ext_len);
+
+		rc = devm_add_sent_extent(dev, ext_dpa, ext_len, "", false);
+		if (rc) {
+			dev_err(dev, "Failed to add pre-extent DPA:%#llx LEN:%#llx; %d\n",
+				ext_dpa, ext_len, rc);
+			return rc;
+		}
+
+		rc = dc_accept_extent(dev, ext_dpa, ext_len);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+static int cxl_mock_dc_partition_setup(struct device *dev)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	u64 base_dpa = BASE_DYNAMIC_CAP_DPA;
+	u32 dsmad_handle = 0xFADE;
+	u64 decode_length = SZ_512M;
+	u64 block_size = SZ_512;
+	u64 length = SZ_512M;
+	int rc;
+
+	mutex_init(&mdata->ext_lock);
+	xa_init(&mdata->dc_fm_extents);
+	xa_init(&mdata->dc_sent_extents);
+	xa_init(&mdata->dc_accepted_exts);
+
+	rc = devm_add_action_or_reset(dev, release_dc_ext, mdata);
+	if (rc)
+		return rc;
+
+	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
+		struct cxl_dc_partition *part = &mdata->dc_partitions[i];
+
+		dev_dbg(dev, "Creating DC partition DC%d DPA:%#llx LEN:%#llx\n",
+			i, base_dpa, length);
+
+		part->base = cpu_to_le64(base_dpa);
+		part->decode_length = cpu_to_le64(decode_length /
+						  CXL_CAPACITY_MULTIPLIER);
+		part->length = cpu_to_le64(length);
+		part->block_size = cpu_to_le64(block_size);
+		part->dsmad_handle = cpu_to_le32(dsmad_handle);
+		dsmad_handle++;
+
+		rc = inject_prev_extents(dev, base_dpa);
+		if (rc) {
+			dev_err(dev, "Failed to add pre-extents for DC%d\n", i);
+			return rc;
+		}
+
+		base_dpa += decode_length;
+	}
+
+	return 0;
+}
+
 static int mock_gsl(struct cxl_mbox_cmd *cmd)
 {
 	if (cmd->size_out < sizeof(mock_gsl_payload))
@@ -1582,6 +1860,192 @@ static int mock_get_supported_features(struct cxl_mockmem_data *mdata,
 	return 0;
 }
 
+static int mock_get_dc_config(struct device *dev,
+			      struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_get_dc_config_in *dc_config = cmd->payload_in;
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	u8 partition_requested, partition_start_idx, partition_ret_cnt;
+	struct cxl_mbox_get_dc_config_out *resp;
+	int i;
+
+	partition_requested = min(dc_config->partition_count, NUM_MOCK_DC_REGIONS);
+
+	if (cmd->size_out < struct_size(resp, partition, partition_requested))
+		return -EINVAL;
+
+	memset(cmd->payload_out, 0, cmd->size_out);
+	resp = cmd->payload_out;
+
+	partition_start_idx = dc_config->start_partition_index;
+	partition_ret_cnt = 0;
+	for (i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
+		if (i >= partition_start_idx) {
+			memcpy(&resp->partition[partition_ret_cnt],
+				&mdata->dc_partitions[i],
+				sizeof(resp->partition[partition_ret_cnt]));
+			partition_ret_cnt++;
+		}
+	}
+	resp->avail_partition_count = NUM_MOCK_DC_REGIONS;
+	resp->partitions_returned = i;
+
+	dev_dbg(dev, "Returning %d dc partitions\n", partition_ret_cnt);
+	return 0;
+}
+
+static int mock_get_dc_extent_list(struct device *dev,
+				   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_get_extent_out *resp = cmd->payload_out;
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_mbox_get_extent_in *get = cmd->payload_in;
+	u32 total_avail = 0, total_ret = 0;
+	struct cxl_extent_data *ext;
+	u32 ext_count, start_idx;
+	unsigned long i;
+
+	ext_count = le32_to_cpu(get->extent_cnt);
+	start_idx = le32_to_cpu(get->start_extent_index);
+
+	memset(resp, 0, sizeof(*resp));
+
+	guard(mutex)(&mdata->ext_lock);
+	/*
+	 * Total available needs to be calculated and returned regardless of
+	 * how many can actually be returned.
+	 */
+	xa_for_each(&mdata->dc_accepted_exts, i, ext)
+		total_avail++;
+
+	if (start_idx > total_avail)
+		return -EINVAL;
+
+	xa_for_each(&mdata->dc_accepted_exts, i, ext) {
+		if (total_ret >= ext_count)
+			break;
+
+		if (total_ret >= start_idx) {
+			resp->extent[total_ret].start_dpa =
+						cpu_to_le64(ext->dpa_start);
+			resp->extent[total_ret].length =
+						cpu_to_le64(ext->length);
+			memcpy(&resp->extent[total_ret].uuid, ext->uuid,
+					sizeof(resp->extent[total_ret]));
+			total_ret++;
+		}
+	}
+
+	resp->returned_extent_count = cpu_to_le32(total_ret);
+	resp->total_extent_count = cpu_to_le32(total_avail);
+	resp->generation_num = cpu_to_le32(mdata->dc_ext_generation);
+
+	dev_dbg(dev, "Returning %d extents of %d total\n",
+		total_ret, total_avail);
+
+	return 0;
+}
+
+static void dc_clear_sent(struct device *dev)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_extent_data *ext;
+	unsigned long index;
+
+	lockdep_assert_held(&mdata->ext_lock);
+
+	/* Any extents not accepted must be cleared */
+	xa_for_each(&mdata->dc_sent_extents, index, ext) {
+		dev_dbg(dev, "Host rejected extent %#llx\n", ext->dpa_start);
+		xa_erase(&mdata->dc_sent_extents, ext->dpa_start);
+	}
+}
+
+static int mock_add_dc_response(struct device *dev,
+				struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_mbox_dc_response *req = cmd->payload_in;
+	u32 list_size = le32_to_cpu(req->extent_list_size);
+
+	guard(mutex)(&mdata->ext_lock);
+	for (int i = 0; i < list_size; i++) {
+		u64 start = le64_to_cpu(req->extent_list[i].dpa_start);
+		u64 length = le64_to_cpu(req->extent_list[i].length);
+		int rc;
+
+		rc = dc_accept_extent(dev, start, length);
+		if (rc)
+			return rc;
+	}
+
+	dc_clear_sent(dev);
+	return 0;
+}
+
+static void dc_delete_extent(struct device *dev, unsigned long long start,
+			     unsigned long long length)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	unsigned long long end = start + length;
+	struct cxl_extent_data *ext;
+	unsigned long index;
+
+	dev_dbg(dev, "Deleting extent at %#llx len:%#llx\n", start, length);
+
+	guard(mutex)(&mdata->ext_lock);
+	xa_for_each(&mdata->dc_fm_extents, index, ext) {
+		u64 extent_end = ext->dpa_start + ext->length;
+
+		/*
+		 * Any extent which 'touches' the released delete range will be
+		 * removed.
+		 */
+		if ((start <= ext->dpa_start && ext->dpa_start < end) ||
+		    (start <= extent_end && extent_end < end))
+			xa_erase(&mdata->dc_fm_extents, ext->dpa_start);
+	}
+
+	/*
+	 * If the extent was accepted let it be for the host to drop
+	 * later.
+	 */
+}
+
+static int release_accepted_extent(struct device *dev, u64 start, u64 length)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_extent_data *ext;
+
+	guard(mutex)(&mdata->ext_lock);
+	ext = find_create_ext(dev, &mdata->dc_accepted_exts, start, length);
+	if (!ext) {
+		dev_err(dev, "Extent %#llx not in accepted state\n", start);
+		return -EINVAL;
+	}
+	xa_erase(&mdata->dc_accepted_exts, ext->dpa_start);
+	mdata->dc_ext_generation++;
+
+	return 0;
+}
+
+static int mock_dc_release(struct device *dev,
+			   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_dc_response *req = cmd->payload_in;
+	u32 list_size = le32_to_cpu(req->extent_list_size);
+
+	for (int i = 0; i < list_size; i++) {
+		u64 start = le64_to_cpu(req->extent_list[i].dpa_start);
+		u64 length = le64_to_cpu(req->extent_list[i].length);
+
+		dev_dbg(dev, "Extent %#llx released by host\n", start);
+		release_accepted_extent(dev, start, length);
+	}
+
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 			      struct cxl_mbox_cmd *cmd)
 {
@@ -1673,6 +2137,18 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		rc = mock_get_supported_features(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_GET_DC_CONFIG:
+		rc = mock_get_dc_config(dev, cmd);
+		break;
+	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
+		rc = mock_get_dc_extent_list(dev, cmd);
+		break;
+	case CXL_MBOX_OP_ADD_DC_RESPONSE:
+		rc = mock_add_dc_response(dev, cmd);
+		break;
+	case CXL_MBOX_OP_RELEASE_DC:
+		rc = mock_dc_release(dev, cmd);
+		break;
 	case CXL_MBOX_OP_GET_FEATURE:
 		rc = mock_get_feature(mdata, cmd);
 		break;
@@ -1758,6 +2234,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	dev_set_drvdata(dev, mdata);
 
+	rc = cxl_mock_dc_partition_setup(dev);
+	if (rc)
+		return rc;
+
 	mdata->lsa = vmalloc(LSA_SIZE);
 	if (!mdata->lsa)
 		return -ENOMEM;
@@ -1814,6 +2294,9 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	if (cxl_dcd_supported(mds))
+		cxl_configure_dcd(mds, &range_info);
+
 	rc = cxl_dpa_setup(cxlds, &range_info);
 	if (rc)
 		return rc;
@@ -1921,11 +2404,281 @@ static ssize_t sanitize_timeout_store(struct device *dev,
 
 static DEVICE_ATTR_RW(sanitize_timeout);
 
+/* Return if the proposed extent would break the test code */
+static bool new_extent_valid(struct device *dev, size_t new_start,
+			     size_t new_len)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_extent_data *extent;
+	size_t new_end, i;
+
+	if (!new_len)
+		return false;
+
+	new_end = new_start + new_len;
+
+	dev_dbg(dev, "New extent %zx-%zx\n", new_start, new_end);
+
+	guard(mutex)(&mdata->ext_lock);
+	dev_dbg(dev, "Checking extents starts...\n");
+	xa_for_each(&mdata->dc_fm_extents, i, extent) {
+		if (extent->dpa_start == new_start)
+			return false;
+	}
+
+	dev_dbg(dev, "Checking sent extents starts...\n");
+	xa_for_each(&mdata->dc_sent_extents, i, extent) {
+		if (extent->dpa_start == new_start)
+			return false;
+	}
+
+	dev_dbg(dev, "Checking accepted extents starts...\n");
+	xa_for_each(&mdata->dc_accepted_exts, i, extent) {
+		if (extent->dpa_start == new_start)
+			return false;
+	}
+
+	return true;
+}
+
+struct cxl_test_dcd {
+	uuid_t id;
+	struct cxl_event_dcd rec;
+} __packed;
+
+struct cxl_test_dcd dcd_event_rec_template = {
+	.id = CXL_EVENT_DC_EVENT_UUID,
+	.rec = {
+		.hdr = {
+			.length = sizeof(struct cxl_test_dcd),
+		},
+	},
+};
+
+static int log_dc_event(struct cxl_mockmem_data *mdata, enum dc_event type,
+			u64 start, u64 length, const char *tag_str, bool more)
+{
+	struct device *dev = mdata->mds->cxlds.dev;
+	struct cxl_test_dcd *dcd_event;
+
+	dev_dbg(dev, "mock device log event %d\n", type);
+
+	dcd_event = devm_kmemdup(dev, &dcd_event_rec_template,
+				     sizeof(*dcd_event), GFP_KERNEL);
+	if (!dcd_event)
+		return -ENOMEM;
+
+	dcd_event->rec.flags = 0;
+	if (more)
+		dcd_event->rec.flags |= CXL_DCD_EVENT_MORE;
+	dcd_event->rec.event_type = type;
+	dcd_event->rec.extent.start_dpa = cpu_to_le64(start);
+	dcd_event->rec.extent.length = cpu_to_le64(length);
+	memcpy(dcd_event->rec.extent.uuid, tag_str,
+	       min(sizeof(dcd_event->rec.extent.uuid),
+		   strlen(tag_str)));
+
+	mes_add_event(mdata, CXL_EVENT_TYPE_DCD,
+		      (struct cxl_event_record_raw *)dcd_event);
+
+	/* Fake the irq */
+	cxl_mem_get_event_records(mdata->mds, CXLDEV_EVENT_STATUS_DCD);
+
+	return 0;
+}
+
+static void mark_extent_sent(struct device *dev, unsigned long long start)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_extent_data *ext;
+
+	guard(mutex)(&mdata->ext_lock);
+	ext = xa_erase(&mdata->dc_fm_extents, start);
+	if (xa_insert(&mdata->dc_sent_extents, ext->dpa_start, ext, GFP_KERNEL))
+		dev_err(dev, "Failed to mark extent %#llx sent\n", ext->dpa_start);
+}
+
+/*
+ * Format <start>:<length>:<tag>:<more_flag>
+ *
+ * start and length must be a multiple of the configured partition block size.
+ * Tag can be any string up to 16 bytes.
+ *
+ * Extents must be exclusive of other extents
+ *
+ * If the more flag is specified it is expected that an additional extent will
+ * be specified without the more flag to complete the test transaction with the
+ * host.
+ */
+static ssize_t __dc_inject_extent_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count,
+					bool shared)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	unsigned long long start, length, more;
+	char *len_str, *uuid_str, *more_str;
+	size_t buf_len = count;
+	int rc;
+
+	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
+	if (!start_str)
+		return -ENOMEM;
+
+	len_str = strnchr(start_str, buf_len, ':');
+	if (!len_str) {
+		dev_err(dev, "Extent failed to find len_str: %s\n", start_str);
+		return -EINVAL;
+	}
+
+	*len_str = '\0';
+	len_str += 1;
+	buf_len -= strlen(start_str);
+
+	uuid_str = strnchr(len_str, buf_len, ':');
+	if (!uuid_str) {
+		dev_err(dev, "Extent failed to find uuid_str: %s\n", len_str);
+		return -EINVAL;
+	}
+	*uuid_str = '\0';
+	uuid_str += 1;
+
+	more_str = strnchr(uuid_str, buf_len, ':');
+	if (!more_str) {
+		dev_err(dev, "Extent failed to find more_str: %s\n", uuid_str);
+		return -EINVAL;
+	}
+	*more_str = '\0';
+	more_str += 1;
+
+	if (kstrtoull(start_str, 0, &start)) {
+		dev_err(dev, "Extent failed to parse start: %s\n", start_str);
+		return -EINVAL;
+	}
+
+	if (kstrtoull(len_str, 0, &length)) {
+		dev_err(dev, "Extent failed to parse length: %s\n", len_str);
+		return -EINVAL;
+	}
+
+	if (kstrtoull(more_str, 0, &more)) {
+		dev_err(dev, "Extent failed to parse more: %s\n", more_str);
+		return -EINVAL;
+	}
+
+	if (!new_extent_valid(dev, start, length))
+		return -EINVAL;
+
+	rc = devm_add_fm_extent(dev, start, length, uuid_str, shared);
+	if (rc) {
+		dev_err(dev, "Failed to add extent DPA:%#llx LEN:%#llx; %d\n",
+			start, length, rc);
+		return rc;
+	}
+
+	mark_extent_sent(dev, start);
+	rc = log_dc_event(mdata, DCD_ADD_CAPACITY, start, length, uuid_str, more);
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
+	return count;
+}
+
+static ssize_t dc_inject_extent_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	return __dc_inject_extent_store(dev, attr, buf, count, false);
+}
+static DEVICE_ATTR_WO(dc_inject_extent);
+
+static ssize_t dc_inject_shared_extent_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	return __dc_inject_extent_store(dev, attr, buf, count, true);
+}
+static DEVICE_ATTR_WO(dc_inject_shared_extent);
+
+static ssize_t __dc_del_extent_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count,
+				     enum dc_event type)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	unsigned long long start, length;
+	char *len_str;
+	int rc;
+
+	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
+	if (!start_str)
+		return -ENOMEM;
+
+	len_str = strnchr(start_str, count, ':');
+	if (!len_str) {
+		dev_err(dev, "Failed to find len_str: %s\n", start_str);
+		return -EINVAL;
+	}
+	*len_str = '\0';
+	len_str += 1;
+
+	if (kstrtoull(start_str, 0, &start)) {
+		dev_err(dev, "Failed to parse start: %s\n", start_str);
+		return -EINVAL;
+	}
+
+	if (kstrtoull(len_str, 0, &length)) {
+		dev_err(dev, "Failed to parse length: %s\n", len_str);
+		return -EINVAL;
+	}
+
+	dc_delete_extent(dev, start, length);
+
+	if (type == DCD_FORCED_CAPACITY_RELEASE)
+		dev_dbg(dev, "Forcing delete of extent %#llx len:%#llx\n",
+			start, length);
+
+	rc = log_dc_event(mdata, type, start, length, "", false);
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
+	return count;
+}
+
+/*
+ * Format <start>:<length>
+ */
+static ssize_t dc_del_extent_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	return __dc_del_extent_store(dev, attr, buf, count,
+				     DCD_RELEASE_CAPACITY);
+}
+static DEVICE_ATTR_WO(dc_del_extent);
+
+static ssize_t dc_force_del_extent_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	return __dc_del_extent_store(dev, attr, buf, count,
+				     DCD_FORCED_CAPACITY_RELEASE);
+}
+static DEVICE_ATTR_WO(dc_force_del_extent);
+
 static struct attribute *cxl_mock_mem_attrs[] = {
 	&dev_attr_security_lock.attr,
 	&dev_attr_event_trigger.attr,
 	&dev_attr_fw_buf_checksum.attr,
 	&dev_attr_sanitize_timeout.attr,
+	&dev_attr_dc_inject_extent.attr,
+	&dev_attr_dc_inject_shared_extent.attr,
+	&dev_attr_dc_del_extent.attr,
+	&dev_attr_dc_force_del_extent.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cxl_mock_mem);
-- 
2.43.0

