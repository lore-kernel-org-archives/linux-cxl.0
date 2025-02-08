Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC06192B63
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738995249; cv=pass; b=mFQLKQChG3jBYeCuq4Fa8mAjKoSWaU33eW58lieeZtUpK2S3OycV4ZXrzNaWM1Pau3jTjLwftsV//apGTtdwwh7M5+6Suu7qtXXy4dYiRj0IhltzRl1gExIJtZLz2xGf0o9yaiFesNuovaXYg8QdU+/DMu4bY4o9hMQxwUbpxio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738995249; c=relaxed/simple;
	bh=hgAFjrKPm5G1oERopNpIC2ROOLl+GbukaWAHxOLAsKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7I2XCtiPNknOaeTFE9bYR15FMR+VvngILGtu59FsnYvTdyPLBKvO36vedWCkpxoBH71sC4qS8st4gUb6pS4GkAx6v2nMNfaKrAb9eiFbNLBVmM1YYNZxlxcw+ad+nKpGXVSoZffKLlobX/kuriqTE2hNp1Mfp/vPJhvGtrfwXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=U9Mi+W++; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="U9Mi+W++"
ARC-Seal: i=1; a=rsa-sha256; t=1738995231; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YKKfDRnebJlmuAo9e7oqEr86IlfH+Eao+uGlyOzNtysSpx68EqiO/Dx+pNC7IZ4ljoUFHUlV0l10g682/OLGkGJ+amfIVVeFfjTqHZ5SuAqT1swuEwQwd/8mZaOiuWZe0XJkSciUUCj0BI2+dtU1VjPm2w1mnqsIqi7Dp2cFKcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738995231; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KsN8ZwLiiWIqGOJ4ktm+zY4eWNH2XaZBCJdqnqyzXgw=; 
	b=MGI247sShqjW9FMssfODWQjkXNhV5UW54jCuW66idw1SLaaSpBiUCQfu28a073485EquTIgH3pbimDXjaWzL8IT9vj6Cis0pMyUM07Xpy+HcDotmKv4utd2nzzn/aLDiZIuvDMBvToZ21ZIQjCfgHFbhb3zZmPwS3MXVIO+nmuk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738995231;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=KsN8ZwLiiWIqGOJ4ktm+zY4eWNH2XaZBCJdqnqyzXgw=;
	b=U9Mi+W++CBLkJwpE2EJoPMtIKiwiK4EeNMO/OM8XmirWRMDBSoqiQ9w4N1M6ZfDw
	2tOxWvbjHBeyu703K/Gl1KaLSQOcVhAbtBc4e0QqZhTmcIh2JWfVExwFkg1RGK5dSPD
	W/yI6ku/X93Hz46/x3dGfINsg8dErXV7m2GPqgJs=
Received: by mx.zohomail.com with SMTPS id 1738995228773536.4350675764848;
	Fri, 7 Feb 2025 22:13:48 -0800 (PST)
Message-ID: <c0699c93-3a2f-4c64-847d-db3c46a153a2@zohomail.com>
Date: Sat, 8 Feb 2025 14:13:47 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] cxl: Add Get Supported Features command for
 kernel usage
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-3-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122758bc0ad11523ae5ab61305f0000082dcc12b39ddf3e4b564278622ab262a7b61dbc02d3dbdca2d:zu080112278cb439cd7273609c89f6310a0000b4d90c04331c6c3ca157b8720e989b169e2c076e82c4644748:rf0801122d275ced3b807883c969be7d4b000050210c81e8aba1516004a5bee228ad39f6fbf551e1e7181517bf7936864ea5:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
>
> The driver will retrieve the Feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature. The retrieved Feature
> entries are stored in the cxl_mailbox context.
>
> The setup of Features is initiated via devm_cxl_setup_features() during the
> pci probe function before the cxl_memdev is enumerated.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[...]
> +static struct cxl_feat_entries *
> +get_supported_features(struct cxl_features_state *cxlfs)
> +{
> +	int remain_feats, max_size, max_feats, start, rc, hdr_size;
> +	struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
> +	int feat_size = sizeof(struct cxl_feat_entry);
> +	struct cxl_mbox_get_sup_feats_in mbox_in;
> +	struct cxl_feat_entry *entry;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int count;
> +
> +	count = cxl_get_supported_features_count(cxl_mbox);
> +	if (count <= 0)
> +		return NULL;
> +
> +	struct cxl_feat_entries *entries __free(kvfree) =
> +		kvmalloc(struct_size(entries, ent, count), GFP_KERNEL);
> +	if (!entries)
> +		return NULL;
> +
> +	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
> +		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	if (!mbox_out)
> +		return NULL;
> +
> +	hdr_size = struct_size(mbox_out, ents, 0);
> +	max_size = cxl_mbox->payload_size - hdr_size;
> +	/* max feat entries that can fit in mailbox max payload size */
> +	max_feats = max_size / feat_size;
> +	entry = entries->ent;
> +
> +	start = 0;
> +	remain_feats = count;
> +	do {
> +		int retrieved, alloc_size, copy_feats;
> +		int num_entries;
> +
> +		if (remain_feats > max_feats) {
> +			alloc_size = struct_size(mbox_out, ents, max_feats);
> +			remain_feats = remain_feats - max_feats;
> +			copy_feats = max_feats;
> +		} else {
> +			alloc_size = struct_size(mbox_out, ents, remain_feats);
> +			copy_feats = remain_feats;
> +			remain_feats = 0;
> +		}
> +
> +		memset(&mbox_in, 0, sizeof(mbox_in));
> +		mbox_in.count = cpu_to_le32(alloc_size);
> +		mbox_in.start_idx = cpu_to_le16(start);
> +		memset(mbox_out, 0, alloc_size);
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +			.size_in = sizeof(mbox_in),
> +			.payload_in = &mbox_in,
> +			.size_out = alloc_size,
> +			.payload_out = mbox_out,
> +			.min_out = hdr_size,
> +		};
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc < 0)
> +			return ERR_PTR(rc);
Should return NULL here?
> +
> +		if (mbox_cmd.size_out <= hdr_size)
> +			return NULL;
> +
> +		/*
> +		 * Make sure retrieved out buffer is multiple of feature
> +		 * entries.
> +		 */
> +		retrieved = mbox_cmd.size_out - hdr_size;
> +		if (retrieved % feat_size)
> +			return NULL;
> +
> +		num_entries = le16_to_cpu(mbox_out->num_entries);
> +		/*
> +		 * If the reported output entries * defined entry size !=
> +		 * retrieved output bytes, then the output package is incorrect.
> +		 */
> +		if (num_entries * feat_size != retrieved)
> +			return NULL;
> +
> +		memcpy(entry, mbox_out->ents, retrieved);
> +		entry += num_entries;
> +		/*
> +		 * If the number of output entries is less than expected, add the
> +		 * remaining entries to the next batch.
> +		 */
> +		remain_feats += copy_feats - num_entries;
> +		start += num_entries;
> +	} while (remain_feats);
> +
> +	entries->num_features = count;
> +
> +	return no_free_ptr(entries);
> +}
> +
> +static void free_cxlfs(void *_cxlfs)
> +{
> +	struct cxl_features_state *cxlfs = _cxlfs;
> +	struct cxl_dev_state *cxlds = cxlfs->cxlds;
> +
> +	cxlds->cxlfs = NULL;
> +	kvfree(cxlfs->entries);
> +	kfree(cxlfs);
> +}
> +
> +/**
> + * devm_cxl_setup_features() - Allocate and initialize features context
> + * @cxlds: CXL device context
> + *
> + * Return 0 on success or -errno on failure.
> + */
> +int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	int rc;
> +
> +	if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
> +		return -ENODEV;
> +
> +	struct cxl_features_state *cxlfs __free(kfree) =
> +		kzalloc(sizeof(*cxlfs), GFP_KERNEL);
> +	if (!cxlfs)
> +		return -ENOMEM;
> +
> +	cxlfs->cxlds = cxlds;
> +
> +	cxlfs->entries = get_supported_features(cxlfs);
> +	if (!cxlfs->entries)
> +		return -ENOMEM;

It will be a problem if the above cxl_internal_send_cmd() in get_supported_features() returns a "ERR_PTR(rc)". My understanding is the cxl_internal_send_cmd() should return a NULL in failure cases.

Other looks good to me.

Reviewed-by: Li Ming <ming.li@zohomail.com>


