Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77E1B2EE2
	for <linux-cxl@vger.kernel.org>; Wed, 21 Aug 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263843; cv=none; b=DY1ncgbBRQwnarqhdIOpPG8pCHiW/2kJcGCB2f7TJc4W2N6m6vpQiWSJ45FsRMi+cYevLiZxI4QGAgjHJflLvJaTT1sL6EyzgOy2biEtVVR8XQ7Bwn0noZz9J1Hjl+f/Ztug+KyhVAKqnRx17hN9Q8YrGYem/1GZF9QJoK1+Fmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263843; c=relaxed/simple;
	bh=JYd9hG0GyP4fFMdzfCzGbSUeTeJgcS/ifd5hRcZn17g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YESmK1zU0xoAetB4OVJhSCt/InBuAsxTNrci4CwsRLEKssaP9xR6RdicOPJDXnAmxwTiU1kHWOR3+GpH+jGksF50FVz3GfdbvPYTRToTVb27bDIvzrVlNL+mjSHSs4XhvScO4kUfZfc0vth5f80q0bINZyJxjwiDyV7nA48SH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CK4Ar9vl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CK4Ar9vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724263841; x=1755799841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JYd9hG0GyP4fFMdzfCzGbSUeTeJgcS/ifd5hRcZn17g=;
  b=CK4Ar9vlIdoNVnAJ6Eb+FLNJPemj/imBA3+Zu+Jzd06wKyr0yYzZkm4l
   pdREKTLMoBO9Wz82yiny5ETMysWfrr8GFeSrA3uyYBOQojasMsmcT2tU5
   b+s5T/7AW/WOaHbL0tVtjyKdjqB8hefY035tlPZVWFJBLSbzQTm6ZPzfp
   PBGimQM/HwbwAQWBB+fcli45CD6JF3D49pQnkQzN3iTBs2M9HQSdSWV34
   ogdSF/qb2snUOmdaSMr2xncuHTjxXTpp1JDKL2TGjCgHoxEuGbgd5N5EM
   vzX86QU4pdDRDP3Nwyca67xoZs1v0/loVvHnb6VNJFuMUJ7VOqlv+rg6N
   Q==;
X-CSE-ConnectionGUID: n98Q3GdhTEeml6HFl9v3HA==
X-CSE-MsgGUID: ZYFCnZnoRdG+A6214KTkIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22453069"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22453069"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 11:10:41 -0700
X-CSE-ConnectionGUID: 9XVOkyRbSdGt49XsYUdvVQ==
X-CSE-MsgGUID: QylHHfU9QsGq16cJab8DbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84338902"
Received: from cmdeoliv-mobl.amr.corp.intel.com (HELO [10.125.108.204]) ([10.125.108.204])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 11:10:40 -0700
Message-ID: <f3bc35a5-d263-4edf-af1f-3e0b4eb036e0@intel.com>
Date: Wed, 21 Aug 2024 11:10:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/13] cxl: Add Get Supported Features command for
 kernel usage
To: Shiju Jose <shiju.jose@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-5-dave.jiang@intel.com>
 <3067b2de83734e1fbe0bc3b93e45ce79@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3067b2de83734e1fbe0bc3b93e45ce79@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/24 9:05 AM, Shiju Jose wrote:
> Hi Dave,
> 
> Few comments inline.
> 
>> -----Original Message-----
>> From: Dave Jiang <dave.jiang@intel.com>
>> Sent: 18 July 2024 22:32
>> To: linux-cxl@vger.kernel.org
>> Cc: dan.j.williams@intel.com; ira.weiny@intel.com; vishal.l.verma@intel.com;
>> alison.schofield@intel.com; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; dave@stgolabs.net; jgg@nvidia.com; Shiju
>> Jose <shiju.jose@huawei.com>
>> Subject: [RFC PATCH 04/13] cxl: Add Get Supported Features command for
>> kernel usage
>>
>> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h) The command
>> retrieve the list of supported device-specific features (identified by UUID) and
>> general information about each Feature.
>>
>> The driver will retrieve the feature entries in order to make checks and provide
>> information for the Get Feature and Set Feature command. One of the main
>> piece of information retrieved are the effects a Set Feature command would
>> have for a particular feature.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> drivers/cxl/core/mbox.c      | 151 +++++++++++++++++++++++++++++++++++
>> drivers/cxl/cxlmem.h         |  29 +++++++
>> drivers/cxl/pci.c            |   4 +
>> include/linux/cxl/mailbox.h  |   3 +
>> include/uapi/linux/cxl_mem.h |   1 +
>> 5 files changed, 188 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>> b9c64f1837a8..70e3962ed570 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -67,6 +67,7 @@ static struct cxl_mem_command
>> cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>> 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>> 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>> 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>> +	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD,
>> 0),
>> };
>>
>> /*
>> @@ -790,6 +791,156 @@ static const uuid_t log_uuid[] = {
>> 	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,  };
>>
>> +static void cxl_free_features(void *features) {
>> +	kvfree(features);
>> +}
>> +
>> +static int cxl_get_supported_features_count(struct cxl_mailbox
>> +*cxl_mbox) {
>> +	struct cxl_mbox_get_sup_feats_out mbox_out;
>> +	struct cxl_mbox_get_sup_feats_in mbox_in;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	int rc;
>> +
>> +	memset(&mbox_in, 0, sizeof(mbox_in));
>> +	mbox_in.count = sizeof(mbox_out);
>> +	memset(&mbox_out, 0, sizeof(mbox_out));
>> +	mbox_cmd = (struct cxl_mbox_cmd) {
>> +		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>> +		.size_in = sizeof(mbox_in),
>> +		.payload_in = &mbox_in,
>> +		.size_out = sizeof(mbox_out),
>> +		.payload_out = &mbox_out,
>> +		.min_out = sizeof(mbox_out),
>> +	};
>> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	cxl_mbox->num_features = le16_to_cpu(mbox_out.supported_feats);
>> +	if (!cxl_mbox->num_features)
>> +		return -ENOENT;
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_get_supported_features(struct cxl_mailbox *cxl_mbox) {
>> +	int remain_feats, max_size, max_feats, start, rc;
>> +	int feat_size = sizeof(struct cxl_feat_entry);
>> +	struct cxl_mbox_get_sup_feats_out *mbox_out;
>> +	struct cxl_mbox_get_sup_feats_in mbox_in;
>> +	int hdr_size = sizeof(*mbox_out);
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	struct cxl_mem_command *cmd;
>> +	void *ptr;
>> +
>> +	/* Get supported features is optional, need to check */
>> +	cmd =
>> cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
>> +	if (!cmd)
>> +		return -EOPNOTSUPP;
>> +	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
>> +		return -EOPNOTSUPP;
>> +
>> +	rc = cxl_get_supported_features_count(cxl_mbox);
>> +	if (rc)
>> +		return rc;
>> +
>> +	struct cxl_feat_entry *entries __free(kvfree) =
>> +		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
>> +
>> +	if (!entries)
>> +		return -ENOMEM;
>> +
>> +	cxl_mbox->entries = no_free_ptr(entries);
>> +	rc = devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
>> +				      cxl_mbox->entries);
>> +	if (rc)
>> +		return rc;
>> +
>> +	max_size = cxl_mbox->payload_size - hdr_size;
>> +	/* max feat entries that can fit in mailbox max payload size */
>> +	max_feats = max_size / feat_size;
>> +	ptr = &cxl_mbox->entries[0];
>> +
>> +	mbox_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>> +	if (!mbox_out)
>> +		return -ENOMEM;
>> +
>> +	start = 0;
>> +	remain_feats = cxl_mbox->num_features;
>> +	do {
>> +		int retrieved, alloc_size, copy_feats;
>> +
>> +		if (remain_feats > max_feats) {
>> +			alloc_size = sizeof(*mbox_out) + max_feats * feat_size;
>> +			remain_feats = remain_feats - max_feats;
>> +			copy_feats = max_feats;
>> +		} else {
>> +			alloc_size = sizeof(*mbox_out) + remain_feats *
>> feat_size;
>> +			copy_feats = remain_feats;
>> +			remain_feats = 0;
>> +		}
>> +
>> +		memset(&mbox_in, 0, sizeof(mbox_in));
>> +		mbox_in.count = alloc_size;
>> +		mbox_in.start_idx = start;
>> +		memset(mbox_out, 0, alloc_size);
>> +		mbox_cmd = (struct cxl_mbox_cmd) {
>> +			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>> +			.size_in = sizeof(mbox_in),
>> +			.payload_in = &mbox_in,
>> +			.size_out = alloc_size,
>> +			.payload_out = mbox_out,
>> +			.min_out = hdr_size,
>> +		};
>> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>> +		if (rc < 0)
> Please free mbox_out here.

ok

>> +			return rc;
>> +
>> +		if (mbox_cmd.size_out <= hdr_size) {
>> +			rc = -ENXIO;
>> +			goto err;
>> +		}
>> +
>> +		/*
>> +		 * Make sure retrieved out buffer is multiple of feature
>> +		 * entries.
>> +		 */
>> +		retrieved = mbox_cmd.size_out - hdr_size;
>> +		if (retrieved % sizeof(struct cxl_feat_entry)) {
> May be replace with feat_size  as it was set to sizeof(struct cxl_feat_entry)? 

ok

>> +			rc = -ENXIO;
>> +			goto err;
>> +		}
>> +
>> +		/*
>> +		 * If the reported output entries * defined entry size !=
>> +		 * retrieved output bytes, then the output package is incorrect.
>> +		 */
>> +		if (mbox_out->num_entries * feat_size != retrieved) {
>> +			rc = -ENXIO;
>> +			goto err;
>> +		}
>> +
>> +		memcpy(ptr, mbox_out->ents, retrieved);
>> +		ptr += retrieved;
>> +		/*
>> +		 * If the number of output entries is less than expected, add the
>> +		 * remaining entries to the next batch.
>> +		 */
>> +		remain_feats += copy_feats - mbox_out->num_entries;
>> +		start += mbox_out->num_entries;
>> +	} while (remain_feats);
>> +
>> +	return 0;
>> +
>> +err:
> Please free mbox_out here.

ok

>> +	cxl_mbox->num_features = 0;
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>> +
>> /**
>>  * cxl_enumerate_cmds() - Enumerate commands for a device.
>>  * @mds: The driver data for the operation diff --git a/drivers/cxl/cxlmem.h
>> b/drivers/cxl/cxlmem.h index efdf833f2c51..4d3690aa2f3b 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -482,6 +482,7 @@ enum cxl_opcode {
>> 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
>> 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
>> 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
>> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
>> 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>> 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>> 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
>> @@ -765,6 +766,32 @@ enum {
>> 	CXL_PMEM_SEC_PASS_USER,
>> };
>>
>> +/* Get Supported Features (0x500h) CXL r3.1 8.2.9.6.1 */ struct
>> +cxl_mbox_get_sup_feats_in {
>> +	__le32 count;
>> +	__le16 start_idx;
>> +	__le16 reserved;
> Is u8  reserved[2]; better? 
>> +} __packed;
>> +
>> +struct cxl_feat_entry {
>> +	uuid_t uuid;
>> +	__le16 id;
>> +	__le16 get_feat_size;
>> +	__le16 set_feat_size;
>> +	__le32 flags;
>> +	u8 get_feat_ver;
>> +	u8 set_feat_ver;
>> +	__le16 effects;
> May be set_effects?

ok

>> +	u8 reserved[18];
>> +} __packed;
>> +
>> +struct cxl_mbox_get_sup_feats_out {
>> +	__le16 num_entries;
>> +	__le16 supported_feats;
>> +	__le32 reserved;
> u8  reserved[4]?

ok

>> +	struct cxl_feat_entry ents[]
>> +__counted_by(le32_to_cpu(supported_feats));
>> +} __packed;
>> +
>> int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>> 			  struct cxl_mbox_cmd *cmd);
>> int cxl_dev_state_identify(struct cxl_memdev_state *mds); @@ -824,4 +851,6
>> @@ struct cxl_hdm {  struct seq_file;  struct dentry
>> *cxl_debugfs_create_dir(const char *dir);  void cxl_dpa_debug(struct seq_file
>> *file, struct cxl_dev_state *cxlds);
>> +
>> +int cxl_get_supported_features(struct cxl_mailbox *cxl_mbox);
>> #endif /* __CXL_MEM_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
>> 7e26da706921..6a00238446f9 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -872,6 +872,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const
>> struct pci_device_id *id)
>> 	if (rc)
>> 		return rc;
>>
>> +	rc = cxl_get_supported_features(&cxlds->cxl_mbox);
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "No features enumerated.\n");
>> +
>> 	rc = cxl_set_timestamp(mds);
>> 	if (rc)
>> 		return rc;
>> diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h index
>> 2380b22d7a12..570864239b8f 100644
>> --- a/include/linux/cxl/mailbox.h
>> +++ b/include/linux/cxl/mailbox.h
>> @@ -53,6 +53,7 @@ struct cxl_mbox_cmd {
>>  * @mbox_mutex: mutex protects device mailbox and firmware
>>  * @mbox_wait: rcuwait for mailbox
>>  * @mbox_send: @dev specific transport for transmitting mailbox commands
>> + * @features: number of supported features
>>  */
>> struct cxl_mailbox {
>> 	struct device *host;
>> @@ -63,6 +64,8 @@ struct cxl_mailbox {
>> 	struct mutex mbox_mutex; /* lock to protect mailbox context */
>> 	struct rcuwait mbox_wait;
>> 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd
>> *cmd);
>> +	int num_features;
>> +	struct cxl_feat_entry *entries;
> Not sure storing the unrelated feature details in the struct cxl_mailbox is appropriate? 

Yeah I suppose it can be up leveled to the dev_state context. 

>> };
>>
>> #endif
>> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h index
>> c6c0fe27495d..bd2535962f70 100644
>> --- a/include/uapi/linux/cxl_mem.h
>> +++ b/include/uapi/linux/cxl_mem.h
>> @@ -50,6 +50,7 @@
>> 	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
>> 	___C(CLEAR_LOG, "Clear Log"),					  \
>> 	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
>> +	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),
>> 	  \
>> 	___C(MAX, "invalid / last command")
>>
>> #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
>> --
>> 2.45.2
> 
> Thanks,
> Shiju
> 
