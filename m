Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB513A276
	for <linux-cxl@vger.kernel.org>; Fri, 27 Sep 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454125; cv=none; b=ouhc+uMXHUEVFxRn7c02EuXV0N8A95VHwPadq3u4QCODGIt2PUivdBTp4HjlG94x9kyiNaT3o/HmOVPJ2z5UxRpHTQBVWWoU2+Mq0EqML3VYj+dHloO1XAoksrBX7csetLCFbWF6cPzwk3YXdLH7uarX9u69KLWIAmz9xva1gZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454125; c=relaxed/simple;
	bh=klF2iZfwh2+nG8JAds+S3q18HVww0Ub6KWdU/8VM6w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcTjr9QrhQG7feG5SPa/cER5oiQEKeWR5EwPqyJdS2XvLuVwgxfrOm8mGWvshYVSE17B6eL36TswvubcXWWF1zNTDnpEqPj7oKMrY1vsQ5TRF13B+MCfQESRdB7rHqVy2vnQ/o/NYhyZH/bLlAawtnGQBtw+Mk/N7augb+Hps6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JX3p4i1s; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JX3p4i1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727454123; x=1758990123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=klF2iZfwh2+nG8JAds+S3q18HVww0Ub6KWdU/8VM6w0=;
  b=JX3p4i1sYhco3+P9CCiwravnH1HvXeUgLaMfDcI4xTS0UJbDnsAt9CtB
   9iGN/U0cYp1tpPkzQra/Kfj/NKLqUMBpOwZ4wtbDi4OH62hLptghwcq7J
   xIfzyicLtrpqYDmGlJO/iYX4r0hKGQZbpmE3AZe9SnkSRhwVaPw2Z4Dli
   nd5PdoWK3nXXi8+tNjpoDvF9MVDT95UMxrBZnvurqZq9/bzaNwB+wrmdH
   R178pu9GcWb1nH8IikSRfO0Rf4QnDPy27uoNidrvWEwviz0Vzh1X3mdKN
   3DdEOpr9ZlyjGtyC9CQzQBEKkI3UcvVy7iAy49dQzUku5YqHbBVy6OwpI
   w==;
X-CSE-ConnectionGUID: +Ud5eEBgR8upc8fVq5mRYw==
X-CSE-MsgGUID: 599XLECdQZ6qi/UUrB9VFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="26736726"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="26736726"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:22:03 -0700
X-CSE-ConnectionGUID: KN2oHQOdQsabTFxJ4Dr7kg==
X-CSE-MsgGUID: opp3o+TKQRqGSEgf0nrr1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="110069516"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.33]) ([10.125.108.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:22:02 -0700
Message-ID: <806fbf8c-c3c3-41ed-b4b7-cb0a74d408df@intel.com>
Date: Fri, 27 Sep 2024 09:22:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/13] cxl: Add Get Supported Features command for
 kernel usage
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-5-dave.jiang@intel.com>
 <20240726185010.0000295c@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240726185010.0000295c@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/26/24 10:50 AM, Jonathan Cameron wrote:
> On Thu, 18 Jul 2024 14:32:22 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
>> The command retrieve the list of supported device-specific features
>> (identified by UUID) and general information about each Feature.
>>
>> The driver will retrieve the feature entries in order to make checks and
>> provide information for the Get Feature and Set Feature command. One of
>> the main piece of information retrieved are the effects a Set Feature
>> command would have for a particular feature.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Already a fairly well reviewed implementation of this in 
> 
> https://lore.kernel.org/linux-cxl/20240726160556.2079-5-shiju.jose@huawei.com/
> 
> Though it wasn't focused on providing userspace access to it and doesn't handle
> large feature lists which would be eventually needed.
> 
> I'd have preferred to see review on that rather than another version
> of the same functionality.
> 
> Note the QEMU testing used for that set will be useable here too
> and is now upstream.
> 
> A few comments inline.
> 
> Jonathan
> 
> 
>> +int cxl_get_supported_features(struct cxl_mailbox *cxl_mbox)
>> +{
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
>> +	cmd = cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
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
> 
> Hmm. Not srue I'd bother with __free(kvfree) for one line that doesn't
> do the free.
> 
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
> Freed?
> 
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
>> +			alloc_size = sizeof(*mbox_out) + remain_feats * feat_size;
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
>> +	cxl_mbox->num_features = 0;
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>> +
>>  /**
>>   * cxl_enumerate_cmds() - Enumerate commands for a device.
>>   * @mds: The driver data for the operation
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index efdf833f2c51..4d3690aa2f3b 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
> 
>> +struct cxl_mbox_get_sup_feats_out {
>> +	__le16 num_entries;
>> +	__le16 supported_feats;
>> +	__le32 reserved;
>> +	struct cxl_feat_entry ents[] __counted_by(le32_to_cpu(supported_feats));
> 
> I didn't know __counted_by worked with function calls. Interesting.

Actually I need to use __counted_by_le() instead as someone pointed out via kbot reporting.

DJ

> 
>> +} __packed;
>> +
> 
>>  #endif /* __CXL_MEM_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 7e26da706921..6a00238446f9 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -872,6 +872,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	if (rc)
>>  		return rc;
>>  
>> +	rc = cxl_get_supported_features(&cxlds->cxl_mbox);
> 
> I would separate no features from an error in trying to enumerate them.
> 
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "No features enumerated.\n");
>> +
>>  	rc = cxl_set_timestamp(mds);
>>  	if (rc)
>>  		return rc;
>> diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
>> index 2380b22d7a12..570864239b8f 100644
>> --- a/include/linux/cxl/mailbox.h
>> +++ b/include/linux/cxl/mailbox.h
>> @@ -53,6 +53,7 @@ struct cxl_mbox_cmd {
>>   * @mbox_mutex: mutex protects device mailbox and firmware
>>   * @mbox_wait: rcuwait for mailbox
>>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>> + * @features: number of supported features
> 
> missing docs for entries.
> 
>>   */
>>  struct cxl_mailbox {
>>  	struct device *host;
>> @@ -63,6 +64,8 @@ struct cxl_mailbox {
>>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
>>  	struct rcuwait mbox_wait;
>>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
>> +	int num_features;
>> +	struct cxl_feat_entry *entries;
>>  };
>>  
>>  #endif
>> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
>> index c6c0fe27495d..bd2535962f70 100644
>> --- a/include/uapi/linux/cxl_mem.h
>> +++ b/include/uapi/linux/cxl_mem.h
>> @@ -50,6 +50,7 @@
>>  	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
>>  	___C(CLEAR_LOG, "Clear Log"),					  \
>>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
>> +	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
>>  	___C(MAX, "invalid / last command")
>>  
>>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> 

