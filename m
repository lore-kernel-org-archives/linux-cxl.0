Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416901C0DEF;
	Fri, 16 Aug 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817330; cv=none; b=mQgBL7qMRKCkzA/eNbfkzpIxaIs4rLo9vPYO8l5e0E9XXIXusFIqojPkwlOlF/Z2BhDnFtpf8A+8TvDj2FW2/PaLE0Jw4PKtiu43m5bIQMPl+9NaY1j162nDjgpEmMmK9v95TijU9FMlb4Lt1wD7oq5jjpr64lzF+tsZJMfJhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817330; c=relaxed/simple;
	bh=JkDM6qOAZQFkgrtzgYpKJMm1/f3q0KpCMbrLfqjn7K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pw1sEKZyKEaY9Yc4/nfa3ON6W6blUjK7q/m8wWCN8pDDrYNe+Lf5uklKdR028/+XUJetFwEtCTY3HMTb1H0TCo7JYbkQRIfPHAe7DeItM4cSBO+JlwwyZpwlfb+GIbPRCBT4R9NexuEX5PCNltixCIYAUB7IirUU65QMyojIzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhSzX5ds; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhSzX5ds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817329; x=1755353329;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JkDM6qOAZQFkgrtzgYpKJMm1/f3q0KpCMbrLfqjn7K0=;
  b=YhSzX5dsZvDrNKYrv/ggJxzFXrcqY/WRbMzZ3VAVPZqq5enOniIKqqlT
   sBVsiqgjjK256EZD+Joju4aZkTq9wYHuz3BRQCYNDe0yR7+xA/Zgc9om7
   BizTJR/v/uLE9+pAV18u0IURhMgw5QyFwxEdkURk2jS0GINVsc+PmcbKd
   1uAF2m/dNTidILtPvNByoGhiPWmdGXtzbP8BmE1114fD/CpbjwQWVwiVs
   /o10fP9mS99VkKDlbJynHtT9AZ/k6KxJUrsFMFKkB6D49ZLSPTbL7ucYG
   a+QO+rt21XYTE1xnNAfYs7QhrCRCjxMqu3iec6EwOOQq5oLMID0PIbX9q
   w==;
X-CSE-ConnectionGUID: x5BqP1bkQDSbP29VxxLbHw==
X-CSE-MsgGUID: ZM7zW1MZRz+y11xwVET6lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22085327"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22085327"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:48 -0700
X-CSE-ConnectionGUID: ZSVPy8pcSg6eU3q04uQ1zQ==
X-CSE-MsgGUID: kn9GxhzgQwiuYECNt8usIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64571672"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:46 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:22 -0500
Subject: [PATCH RESEND v2 17/18] tools/testing/cxl: Add DC Regions to mock
 mem data
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-17-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=15596;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=JkDM6qOAZQFkgrtzgYpKJMm1/f3q0KpCMbrLfqjn7K0=;
 b=sSOSUyzQrS4opwTrgI0qLmGwl+bEZyeiJbBuF75668wUFIcR9IaEfXRTR+KbWOYgmS7EnisQ7
 8oPD5ILkf5yCpmioPQTyMncqKJFHR3HArNNi7oU9ooPW5hr3tGJK8b8
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

To test DC regions the mock memory devices will need to store
information about the regions and manage fake extent data.

Define mock_dc_region information within the mock memory data.  Add
sysfs entries on the mock device to inject and delete extents.

The inject format is <start>:<length>:<tag>
The delete format is <start>

Add DC mailbox commands to the CEL and implement those commands.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/cxl/test/mem.c | 449 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 449 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 6a036c8d215d..d6041a2145c5 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -18,6 +18,7 @@
 #define FW_SLOTS 3
 #define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
+#define BASE_DYNAMIC_CAP_DPA DEV_SIZE
 
 #define MOCK_INJECT_DEV_MAX 8
 #define MOCK_INJECT_TEST_MAX 128
@@ -89,6 +90,22 @@ static struct cxl_cel_entry mock_cel[] = {
 		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_COLD_RESET) |
 				      EFFECT(CONF_CHANGE_IMMEDIATE)),
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
@@ -147,6 +164,7 @@ struct mock_event_store {
 	u32 ev_status;
 };
 
+#define NUM_MOCK_DC_REGIONS 2
 struct cxl_mockmem_data {
 	void *lsa;
 	void *fw;
@@ -161,6 +179,10 @@ struct cxl_mockmem_data {
 	struct mock_event_store mes;
 	u8 event_buf[SZ_4K];
 	u64 timestamp;
+	struct cxl_dc_region_config dc_regions[NUM_MOCK_DC_REGIONS];
+	u32 dc_ext_generation;
+	struct xarray dc_extents;
+	struct xarray dc_accepted_exts;
 };
 
 static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -529,6 +551,98 @@ static void cxl_mock_event_trigger(struct device *dev)
 	cxl_mem_get_event_records(mes->mds, mes->ev_status);
 }
 
+static int devm_add_extent(struct device *dev, u64 start, u64 length,
+			   const char *tag)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_dc_extent_data *extent;
+
+	extent = devm_kzalloc(dev, sizeof(*extent), GFP_KERNEL);
+	if (!extent) {
+		dev_dbg(dev, "Failed to allocate extent\n");
+		return -ENOMEM;
+	}
+	extent->dpa_start = start;
+	extent->length = length;
+	memcpy(extent->tag, tag, min(sizeof(extent->tag), strlen(tag)));
+
+	if (xa_insert(&mdata->dc_extents, start, extent, GFP_KERNEL)) {
+		devm_kfree(dev, extent);
+		dev_err(dev, "Failed xarry insert %llx\n", start);
+		return -EINVAL;
+	}
+	mdata->dc_ext_generation++;
+
+	return 0;
+}
+
+static int dc_accept_extent(struct device *dev, u64 start)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "Accepting extent 0x%llx\n", start);
+	return xa_insert(&mdata->dc_accepted_exts, start, (void *)start,
+			 GFP_KERNEL);
+}
+
+static void release_dc_ext(void *md)
+{
+	struct cxl_mockmem_data *mdata = md;
+
+	xa_destroy(&mdata->dc_extents);
+	xa_destroy(&mdata->dc_accepted_exts);
+}
+
+static int cxl_mock_dc_region_setup(struct device *dev)
+{
+#define DUMMY_EXT_OFFSET SZ_256M
+#define DUMMY_EXT_LENGTH SZ_256M
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	u64 base_dpa = BASE_DYNAMIC_CAP_DPA;
+	u32 dsmad_handle = 0xFADE;
+	u64 decode_length = SZ_2G;
+	u64 block_size = SZ_512;
+	/* For testing make this smaller than decode length */
+	u64 length = SZ_1G;
+	int rc;
+
+	xa_init(&mdata->dc_extents);
+	xa_init(&mdata->dc_accepted_exts);
+
+	rc = devm_add_action_or_reset(dev, release_dc_ext, mdata);
+	if (rc)
+		return rc;
+
+	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
+		struct cxl_dc_region_config *conf = &mdata->dc_regions[i];
+
+		dev_dbg(dev, "Creating DC region DC%d DPA:%llx LEN:%llx\n",
+			i, base_dpa, length);
+
+		conf->region_base = cpu_to_le64(base_dpa);
+		conf->region_decode_length = cpu_to_le64(decode_length /
+						CXL_CAPACITY_MULTIPLIER);
+		conf->region_length = cpu_to_le64(length);
+		conf->region_block_size = cpu_to_le64(block_size);
+		conf->region_dsmad_handle = cpu_to_le32(dsmad_handle);
+		dsmad_handle++;
+
+		/* Pretend we have some previous accepted extents */
+		rc = devm_add_extent(dev, base_dpa + DUMMY_EXT_OFFSET,
+				     DUMMY_EXT_LENGTH, "CXL-TEST");
+		if (rc)
+			return rc;
+
+		rc = dc_accept_extent(dev, base_dpa + DUMMY_EXT_OFFSET);
+		if (rc)
+			return rc;
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
@@ -1315,6 +1429,148 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
 	return -EINVAL;
 }
 
+static int mock_get_dc_config(struct device *dev,
+			      struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_get_dc_config *dc_config = cmd->payload_in;
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	u8 region_requested, region_start_idx, region_ret_cnt;
+	struct cxl_mbox_dynamic_capacity *resp;
+
+	region_requested = dc_config->region_count;
+	if (NUM_MOCK_DC_REGIONS < region_requested)
+		region_requested = NUM_MOCK_DC_REGIONS;
+
+	if (cmd->size_out < struct_size(resp, region, region_requested))
+		return -EINVAL;
+
+	memset(cmd->payload_out, 0, cmd->size_out);
+	resp = cmd->payload_out;
+
+	region_start_idx = dc_config->start_region_index;
+	region_ret_cnt = 0;
+	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
+		if (i >= region_start_idx) {
+			memcpy(&resp->region[region_ret_cnt],
+				&mdata->dc_regions[i],
+				sizeof(resp->region[region_ret_cnt]));
+			region_ret_cnt++;
+		}
+	}
+	resp->avail_region_count = region_ret_cnt;
+
+	dev_dbg(dev, "Returning %d dc regions\n", region_ret_cnt);
+	return 0;
+}
+
+
+static int mock_get_dc_extent_list(struct device *dev,
+				   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_mbox_get_dc_extent *get = cmd->payload_in;
+	struct cxl_mbox_dc_extents *resp = cmd->payload_out;
+	u32 total_avail = 0, total_ret = 0;
+	struct cxl_dc_extent_data *ext;
+	u32 ext_count, start_idx;
+	unsigned long i;
+
+	ext_count = le32_to_cpu(get->extent_cnt);
+	start_idx = le32_to_cpu(get->start_extent_index);
+
+	memset(resp, 0, sizeof(*resp));
+
+	/*
+	 * Total available needs to be calculated and returned regardless of
+	 * how many can actually be returned.
+	 */
+	xa_for_each(&mdata->dc_extents, i, ext)
+		total_avail++;
+
+	if (start_idx > total_avail)
+		return -EINVAL;
+
+	xa_for_each(&mdata->dc_extents, i, ext) {
+		if (total_ret >= ext_count)
+			break;
+
+		if (total_ret >= start_idx) {
+			resp->extent[total_ret].start_dpa =
+						cpu_to_le64(ext->dpa_start);
+			resp->extent[total_ret].length =
+						cpu_to_le64(ext->length);
+			memcpy(&resp->extent[total_ret].tag, ext->tag,
+					sizeof(resp->extent[total_ret]));
+			resp->extent[total_ret].shared_extn_seq =
+					cpu_to_le16(ext->shared_extent_seq);
+			total_ret++;
+		}
+	}
+
+	resp->ret_extent_cnt = cpu_to_le32(total_ret);
+	resp->total_extent_cnt = cpu_to_le32(total_avail);
+	resp->extent_list_num = cpu_to_le32(mdata->dc_ext_generation);
+
+	dev_dbg(dev, "Returning %d extents of %d total\n",
+		total_ret, total_avail);
+
+	return 0;
+}
+
+static int mock_add_dc_response(struct device *dev,
+				struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_dc_response *req = cmd->payload_in;
+	u32 list_size = le32_to_cpu(req->extent_list_size);
+
+	for (int i = 0; i < list_size; i++) {
+		u64 start = le64_to_cpu(req->extent_list[i].dpa_start);
+		int rc;
+
+		dev_dbg(dev, "Extent 0x%llx accepted by HOST\n", start);
+		rc = dc_accept_extent(dev, start);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int dc_delete_extent(struct device *dev, unsigned long long start)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	void *ext;
+
+	dev_dbg(dev, "Deleting extent at %llx\n", start);
+
+	ext = xa_erase(&mdata->dc_extents, start);
+	if (!ext) {
+		dev_err(dev, "No extent found at %llx\n", start);
+		return -EINVAL;
+	}
+	devm_kfree(dev, ext);
+	mdata->dc_ext_generation++;
+
+	return 0;
+}
+
+static int mock_dc_release(struct device *dev,
+			   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_mbox_dc_response *req = cmd->payload_in;
+	u32 list_size = le32_to_cpu(req->extent_list_size);
+
+	for (int i = 0; i < list_size; i++) {
+		u64 start = le64_to_cpu(req->extent_list[i].dpa_start);
+
+		dev_dbg(dev, "Extent 0x%llx released by HOST\n", start);
+		xa_erase(&mdata->dc_accepted_exts, start);
+	}
+
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
 			      struct cxl_mbox_cmd *cmd)
 {
@@ -1399,6 +1655,18 @@ static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
 	case CXL_MBOX_OP_ACTIVATE_FW:
 		rc = mock_activate_fw(mdata, cmd);
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
 	default:
 		break;
 	}
@@ -1467,6 +1735,10 @@ static int __cxl_mock_mem_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	dev_set_drvdata(dev, mdata);
 
+	rc = cxl_mock_dc_region_setup(dev);
+	if (rc)
+		return rc;
+
 	mdata->lsa = vmalloc(LSA_SIZE);
 	if (!mdata->lsa)
 		return -ENOMEM;
@@ -1515,6 +1787,10 @@ static int __cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = cxl_dev_dynamic_capacity_identify(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_create_range_info(mds);
 	if (rc)
 		return rc;
@@ -1528,6 +1804,10 @@ static int __cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	rc = cxl_dev_get_dynamic_capacity_extents(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_memdev_setup_fw_upload(mds);
 	if (rc)
 		return rc;
@@ -1669,10 +1949,179 @@ static ssize_t fw_buf_checksum_show(struct device *dev,
 
 static DEVICE_ATTR_RO(fw_buf_checksum);
 
+/* Returns if the proposed extent is valid */
+static bool new_extent_valid(struct device *dev, size_t new_start,
+			     size_t new_len)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	struct cxl_dc_extent_data *extent;
+	size_t new_end, i;
+
+	if (!new_len)
+		return -EINVAL;
+
+	new_end = new_start + new_len;
+
+	dev_dbg(dev, "New extent %zx-%zx\n", new_start, new_end);
+
+	/* Overlap with other extent? */
+	xa_for_each(&mdata->dc_extents, i, extent) {
+		size_t ext_end = extent->dpa_start + extent->length;
+
+		if (extent->dpa_start <= new_start && new_start < ext_end) {
+			dev_err(dev, "Extent overlap: Start %llu ?<= %zx ?<= %zx\n",
+				extent->dpa_start, new_start, ext_end);
+			return false;
+		}
+		if (extent->dpa_start <= new_end && new_end < ext_end) {
+			dev_err(dev, "Extent overlap: End %llx ?<= %zx ?<= %zx\n",
+				extent->dpa_start, new_end, ext_end);
+			return false;
+		}
+	}
+
+	/* Ensure it is in a region and is valid for that regions block size */
+	for (int i = 0; i < NUM_MOCK_DC_REGIONS; i++) {
+		struct cxl_dc_region_config *dc_region = &mdata->dc_regions[i];
+		size_t reg_start, reg_end;
+
+		reg_start = le64_to_cpu(dc_region->region_base);
+		reg_end = le64_to_cpu(dc_region->region_length);
+		reg_end += reg_start;
+
+		dev_dbg(dev, "Region %d: %zx-%zx\n", i, reg_start, reg_end);
+
+		if (reg_start >= new_start && new_end < reg_end) {
+			u64 block_size = le64_to_cpu(dc_region->region_block_size);
+
+			if (new_start % block_size || new_len % block_size) {
+				dev_err(dev, "Extent not aligned to block size: start %zx; len %zx; block_size 0x%llx\n",
+					new_start, new_len, block_size);
+				return false;
+			}
+
+			dev_dbg(dev, "Extent in region %d\n", i);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * Format <start>:<length>:<tag>
+ *
+ * start and length must be a multiple of the configured region block size.
+ * Tag can be any string up to 16 bytes.
+ *
+ * Extents must be exclusive of other extents
+ */
+static ssize_t dc_inject_extent_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
+	unsigned long long start, length;
+	char *len_str, *tag_str;
+	size_t buf_len = count;
+	int rc;
+
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
+	tag_str = strnchr(len_str, buf_len, ':');
+	if (!tag_str) {
+		dev_err(dev, "Extent failed to find tag_str: %s\n", len_str);
+		return -EINVAL;
+	}
+	*tag_str = '\0';
+	tag_str += 1;
+
+	if (kstrtoull(start_str, 0, &start)) {
+		dev_err(dev, "Extent failed to parse start: %s\n", start_str);
+		return -EINVAL;
+	}
+	if (kstrtoull(len_str, 0, &length)) {
+		dev_err(dev, "Extent failed to parse length: %s\n", len_str);
+		return -EINVAL;
+	}
+
+	if (!new_extent_valid(dev, start, length))
+		return -EINVAL;
+
+	rc = devm_add_extent(dev, start, length, tag_str);
+	if (rc)
+		return rc;
+
+	return count;
+}
+static DEVICE_ATTR_WO(dc_inject_extent);
+
+static ssize_t dc_del_extent_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	unsigned long long start;
+	int rc;
+
+	if (kstrtoull(buf, 0, &start)) {
+		dev_err(dev, "Extent failed to parse start value\n");
+		return -EINVAL;
+	}
+
+	rc = dc_delete_extent(dev, start);
+	if (rc)
+		return rc;
+
+	return count;
+}
+static DEVICE_ATTR_WO(dc_del_extent);
+
+static ssize_t dc_force_del_extent_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	unsigned long long start;
+	void *ext;
+	int rc;
+
+	if (kstrtoull(buf, 0, &start)) {
+		dev_err(dev, "Extent failed to parse start value\n");
+		return -EINVAL;
+	}
+
+	ext = xa_erase(&mdata->dc_accepted_exts, start);
+	if (ext)
+		dev_dbg(dev, "Forcing remove of accepted extent: %llx\n",
+			start);
+
+	dev_dbg(dev, "Forcing delete of extent at %llx\n", start);
+	rc = dc_delete_extent(dev, start);
+	if (rc)
+		return rc;
+
+	return count;
+}
+static DEVICE_ATTR_WO(dc_force_del_extent);
+
 static struct attribute *cxl_mock_mem_attrs[] = {
 	&dev_attr_security_lock.attr,
 	&dev_attr_event_trigger.attr,
 	&dev_attr_fw_buf_checksum.attr,
+	&dev_attr_dc_inject_extent.attr,
+	&dev_attr_dc_del_extent.attr,
+	&dev_attr_dc_force_del_extent.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cxl_mock_mem);

-- 
2.45.2

