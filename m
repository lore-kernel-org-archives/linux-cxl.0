Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713919F115
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738995780; cv=pass; b=SCM0mYeuIsHS1UWobfH9D4qwwpd1TZZmVKxDuU5Ee+3Y6S66ttYmxdh0LMas5T80WOWoddOs+vnu8sy6Fb9zyjfNqmLNdXouEREfnsJzL0asJBK6wQv9FnzfuLZQNQZmm2Zh3sI8omOaxiNGApB2G03eu47lgPmQstb/ZtBQ2d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738995780; c=relaxed/simple;
	bh=9j2SnjejxzAYfmvO3j/SI8BHBphzcbUhv2l4YKDYI8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5OvBnknmQDP0i9CTBZEfXfiskXETw6zJhr1AuMQu7kbqToLgkFCBVa2k1ojxn98Xsy2c5fKocEKy8VXVbRndn0n6fUvwoDSIuEWBreAQcSgtGClXTA/SfCvxMwbNSAOylUH6puMRy3LfODJgntRIltrr6Eq6WAcZd5Cv5KKKrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ecwPSNM1; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ecwPSNM1"
ARC-Seal: i=1; a=rsa-sha256; t=1738995759; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E0m6NMkFNpPP7pXCxBQ8+v9CrWVC2mttbEv0lhml+X7D8iA6nLUDoxvAuimkbycU13ou1S4IyOyeUDEj8E46I6B/TXW3TJ8K4tLZrTp9aOoxhQACRmCJ7znrXJJVLumfdCcz2a6v2p2fjfxv/oODJX9feQbs5L4UG8Y1D2JOE6s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738995759; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=23LH+zln5mKf7Rjy5EBV3eQNdQx9HIo+yV7TLQrK9Nc=; 
	b=BguT0RcIce85KRr+lKet55xxZTk2m6nShzZCHoiPY7wYq9M/vdkxs7NPvqlFsjtEaFIYTN3SiPiVyP0P57JxyA6GZiOrujFI0GVORk/M+41xThHwLfrnLTfWl7ijtB/JvFGDfL0mRszcioBk7ApJfnZTF1AN6oggnzSwD2sfGns=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738995759;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=23LH+zln5mKf7Rjy5EBV3eQNdQx9HIo+yV7TLQrK9Nc=;
	b=ecwPSNM1VXR34VOeg3xEPyQ+nCstkBOHKjh1u3myCVgYCk6crstW8ntyAogGO0Qh
	xML8bFYBOOFe8dgxVwD58KwgS1Lu/RHBEvJGKlyzh10oTndzucP7ekbYXeRz5VH8WG1
	6gdmSD8Z+yNirAgR/PjNAKe8NsMTFa07h6MURBAQ=
Received: by mx.zohomail.com with SMTPS id 1738995756089713.9810098022797;
	Fri, 7 Feb 2025 22:22:36 -0800 (PST)
Message-ID: <7c6c904c-4045-4b5b-8c31-99e3fd971515@zohomail.com>
Date: Sat, 8 Feb 2025 14:22:34 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] cxl: Setup exclusive CXL features that are
 reserved for the kernel
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-7-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122783811514e722e2a9d0a0a49d0000fed1d18f1884650e20624a7a300209f0b113b0fd2ccfc633de:zu0801122702cfa2d701b62f2916ab5c9200000faa68185d659ceeefdb1db90c5ae9d4d7066a4ac26d26df4b:rf0801122d0b72ae164aa0a69da0c4060d0000af1f056a53cef95a4150dd21c161fefd46e0e8fea34b14d1c5973cf7da6115:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> Certain features will be exclusively used by components such as in
> kernel RAS driver. Setup an exclusion list that can be later filtered
> out before exposing to user space.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/features.c | 26 ++++++++++++++++++++++++++
>  include/cxl/features.h      | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index d337224158fa..82f21f64452a 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -6,6 +6,28 @@
>  #include "cxl.h"
>  #include "cxlmem.h"
>  
> +/* All the features below are exclusive to the kernel */
> +static const uuid_t cxl_exclusive_feats[] = {
> +	CXL_FEAT_PATROL_SCRUB_UUID,
> +	CXL_FEAT_ECS_UUID,
> +	CXL_FEAT_SPPR_UUID,
> +	CXL_FEAT_HPPR_UUID,
> +	CXL_FEAT_CACHELINE_SPARING_UUID,
> +	CXL_FEAT_ROW_SPARING_UUID,
> +	CXL_FEAT_BANK_SPARING_UUID,
> +	CXL_FEAT_RANK_SPARING_UUID,
> +};
> +
> +static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
> +		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>  {
>  	return cxlds->cxlfs;
> @@ -46,6 +68,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
>  	struct cxl_mbox_get_sup_feats_in mbox_in;
>  	struct cxl_feat_entry *entry;
>  	struct cxl_mbox_cmd mbox_cmd;
> +	int user_feats = 0;
>  	int count;
>  
>  	count = cxl_get_supported_features_count(cxl_mbox);
> @@ -120,6 +143,8 @@ get_supported_features(struct cxl_features_state *cxlfs)
>  			return NULL;
>  
>  		memcpy(entry, mbox_out->ents, retrieved);
> +		if (!is_cxl_feature_exclusive(entry))
> +			user_feats++;

I guess that here should check all entries copied from mbox_out->ents, so it should be


for (int i = 0; i < num_entries; i++)

    if (!is_cxl_feature_exclusive(entry + i))

        user_feats++;


Other looks good to me.

Reviewed-by: Li Ming <ming.li@zohomail.com>


>  		entry += num_entries;
>  		/*
>  		 * If the number of output entries is less than expected, add the
> @@ -130,6 +155,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
>  	} while (remain_feats);
>  
>  	entries->num_features = count;
> +	entries->num_user_features = user_feats;
>  
>  	return no_free_ptr(entries);
>  }
