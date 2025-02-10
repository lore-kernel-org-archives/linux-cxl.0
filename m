Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ECC24BD0F
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207239; cv=none; b=dCUW4MzNg7Lkg5i7MUMq1t0vnYA3111LYcl3qiH2idh5+1y6lS8LIPWLPgPi7Qt0ZpQG2q6BvNEvpoddF/k2cMTYaISK+G8gc8sLnmaiLOKiN5RwSrA7BvsbocZ5eyeun4D8S1HV9Y4FYhJLRJUSh52HvJ4Abzs5dou4CBmGkOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207239; c=relaxed/simple;
	bh=9C8iXBv4bt1LbpPwiCaoOr5HPTODifohya35dmNX24E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Khu+4XNkCn+HGsziHHX6TFigVNH0N1Mgwzdlep3hCdddREN1TZ6PkC6IEMU6iHWNXqlmGyH8IvSJTb9ltjVinXaJ5UQpJs0K9XS4db1fQkCBNeHOZ2+cXjL96JhYRSjSq3+CWUccO9j8RFBDYSe3UxTppYPvRcWZbdjv6LdMU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cE+ObGlR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cE+ObGlR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739207238; x=1770743238;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9C8iXBv4bt1LbpPwiCaoOr5HPTODifohya35dmNX24E=;
  b=cE+ObGlRNvwzcIYercfeJu1uujW6rkwKyz+IEGOjL7mMB7YGZPmo3K93
   WRbSLy6oZiRAL/BYnU1Z5XmEqnCT2nx0/60QzUGP419EN2fQ6oq85mbGx
   vfZeiJhgTaEil0lmxDjdjSUOT2TSxHi3/94PcNy34WMYuXnLTmE2prsSD
   VMoxjYyJlO2YH7AYBU1cs8boqqKYMV0yH4hcYDZqEh5i0hTEGkeeyvrlL
   dLmkXilMl2M91xFllCCZMX/2y2gVzoFGyppt1nd8z7b2ev+BeN8TvzKbC
   Y0YZjfqfQacq8mGGsNjcd4I/JEU01DpSu1w9DRWVxkLvI3Qyfo4ChsXi6
   g==;
X-CSE-ConnectionGUID: ASKTREESTxKY0fjb2u1oQg==
X-CSE-MsgGUID: x89aTp++TaSM1dYj2/yy9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39912529"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39912529"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:06:55 -0800
X-CSE-ConnectionGUID: sGGKIEACRlubfUCrZH4kZw==
X-CSE-MsgGUID: d3qvOypUTeWAW8IWAz1sKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="112882094"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.192]) ([10.125.111.192])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:06:52 -0800
Message-ID: <d4f75292-b618-4cb6-9959-1f5c10331cf2@intel.com>
Date: Mon, 10 Feb 2025 10:06:51 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] cxl: Add Get Supported Features command for
 kernel usage
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-3-dave.jiang@intel.com>
 <c0699c93-3a2f-4c64-847d-db3c46a153a2@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <c0699c93-3a2f-4c64-847d-db3c46a153a2@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/25 11:13 PM, Li Ming wrote:
> On 2/8/2025 7:37 AM, Dave Jiang wrote:
>> CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
>> The command retrieve the list of supported device-specific features
>> (identified by UUID) and general information about each Feature.
>>
>> The driver will retrieve the Feature entries in order to make checks and
>> provide information for the Get Feature and Set Feature command. One of
>> the main piece of information retrieved are the effects a Set Feature
>> command would have for a particular feature. The retrieved Feature
>> entries are stored in the cxl_mailbox context.
>>
>> The setup of Features is initiated via devm_cxl_setup_features() during the
>> pci probe function before the cxl_memdev is enumerated.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> [...]
>> +static struct cxl_feat_entries *
>> +get_supported_features(struct cxl_features_state *cxlfs)
>> +{
>> +	int remain_feats, max_size, max_feats, start, rc, hdr_size;
>> +	struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
>> +	int feat_size = sizeof(struct cxl_feat_entry);
>> +	struct cxl_mbox_get_sup_feats_in mbox_in;
>> +	struct cxl_feat_entry *entry;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	int count;
>> +
>> +	count = cxl_get_supported_features_count(cxl_mbox);
>> +	if (count <= 0)
>> +		return NULL;
>> +
>> +	struct cxl_feat_entries *entries __free(kvfree) =
>> +		kvmalloc(struct_size(entries, ent, count), GFP_KERNEL);
>> +	if (!entries)
>> +		return NULL;
>> +
>> +	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
>> +		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>> +	if (!mbox_out)
>> +		return NULL;
>> +
>> +	hdr_size = struct_size(mbox_out, ents, 0);
>> +	max_size = cxl_mbox->payload_size - hdr_size;
>> +	/* max feat entries that can fit in mailbox max payload size */
>> +	max_feats = max_size / feat_size;
>> +	entry = entries->ent;
>> +
>> +	start = 0;
>> +	remain_feats = count;
>> +	do {
>> +		int retrieved, alloc_size, copy_feats;
>> +		int num_entries;
>> +
>> +		if (remain_feats > max_feats) {
>> +			alloc_size = struct_size(mbox_out, ents, max_feats);
>> +			remain_feats = remain_feats - max_feats;
>> +			copy_feats = max_feats;
>> +		} else {
>> +			alloc_size = struct_size(mbox_out, ents, remain_feats);
>> +			copy_feats = remain_feats;
>> +			remain_feats = 0;
>> +		}
>> +
>> +		memset(&mbox_in, 0, sizeof(mbox_in));
>> +		mbox_in.count = cpu_to_le32(alloc_size);
>> +		mbox_in.start_idx = cpu_to_le16(start);
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
>> +			return ERR_PTR(rc);
> Should return NULL here?

Thanks for the catch. I missed that one.

DJ
>> +
>> +		if (mbox_cmd.size_out <= hdr_size)
>> +			return NULL;
>> +
>> +		/*
>> +		 * Make sure retrieved out buffer is multiple of feature
>> +		 * entries.
>> +		 */
>> +		retrieved = mbox_cmd.size_out - hdr_size;
>> +		if (retrieved % feat_size)
>> +			return NULL;
>> +
>> +		num_entries = le16_to_cpu(mbox_out->num_entries);
>> +		/*
>> +		 * If the reported output entries * defined entry size !=
>> +		 * retrieved output bytes, then the output package is incorrect.
>> +		 */
>> +		if (num_entries * feat_size != retrieved)
>> +			return NULL;
>> +
>> +		memcpy(entry, mbox_out->ents, retrieved);
>> +		entry += num_entries;
>> +		/*
>> +		 * If the number of output entries is less than expected, add the
>> +		 * remaining entries to the next batch.
>> +		 */
>> +		remain_feats += copy_feats - num_entries;
>> +		start += num_entries;
>> +	} while (remain_feats);
>> +
>> +	entries->num_features = count;
>> +
>> +	return no_free_ptr(entries);
>> +}
>> +
>> +static void free_cxlfs(void *_cxlfs)
>> +{
>> +	struct cxl_features_state *cxlfs = _cxlfs;
>> +	struct cxl_dev_state *cxlds = cxlfs->cxlds;
>> +
>> +	cxlds->cxlfs = NULL;
>> +	kvfree(cxlfs->entries);
>> +	kfree(cxlfs);
>> +}
>> +
>> +/**
>> + * devm_cxl_setup_features() - Allocate and initialize features context
>> + * @cxlds: CXL device context
>> + *
>> + * Return 0 on success or -errno on failure.
>> + */
>> +int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>> +	int rc;
>> +
>> +	if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
>> +		return -ENODEV;
>> +
>> +	struct cxl_features_state *cxlfs __free(kfree) =
>> +		kzalloc(sizeof(*cxlfs), GFP_KERNEL);
>> +	if (!cxlfs)
>> +		return -ENOMEM;
>> +
>> +	cxlfs->cxlds = cxlds;
>> +
>> +	cxlfs->entries = get_supported_features(cxlfs);
>> +	if (!cxlfs->entries)
>> +		return -ENOMEM;
> 
> It will be a problem if the above cxl_internal_send_cmd() in get_supported_features() returns a "ERR_PTR(rc)". My understanding is the cxl_internal_send_cmd() should return a NULL in failure cases.
> 
> Other looks good to me.
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> 

