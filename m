Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D811DEFD2
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739252818; cv=pass; b=o58+1J4O8+CCIy83fbt7vVahbi+sL6TOz7xHvuDfMxdS0VVP6dzP1ENhGC4dbnQUtof09gRB+7HIEgSVfHUE2Z2HNMs1bnAsNQP0Q8eOnVPiicxXXtz6DLlIaA7KvaZxqlW4kotigNPMQzGzvD+XDmWCWmzcuPDrZwvbP6zSYr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739252818; c=relaxed/simple;
	bh=1sfBlDsE6NybRlhU7MD2jG2yaQUNH1D9Ep9C49w2Opw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByAHdDpxC7omAvttGnVzePEwpkvqReLb2+R7YU7IA+BGOj7eoF3juJIL/OSoo0vR6la4tsrs2lAO/ovPJQUspIxlCviLwMJBoz/qXWuKDu8RNXS6O/6VvtY/DZFx3MFUrD3RXr+rxZJo0TfdUndB6EW8+YDL7bjKvCU7f9adqwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EE3LYwZq; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EE3LYwZq"
ARC-Seal: i=1; a=rsa-sha256; t=1739252797; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hfCiLjund3zMtrUJ9NSqavvuekOpBRqunvJfu6a3UrqywNBMmRig+PVa2/q9d8SR/4tUeFQ3kw/QkwWNUC61//CozkdCMTPLMtEclRB+zYlpTE+m7hgZlUh/j7RV2rN5PJwlPtKPLdv3GYSV44XDW5PVQHb0fdItFRCSa/XT+qE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739252797; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ra3ik4L74mI/EleeqyuvDQq7laB2uFJyTkglvF5QLyY=; 
	b=VlaArXefkpmUpmX3s1Q+OZyjEWG+N17Lff5Ia2nqIKFiJDXxHGUmNVBuF0uGjjQ38X95TKIFrs3LGQ0Vcd7Ni2ovd0b//OX+cDktVcgoPV1we0NnB4U/Iw6jCx+qsWjPqfL20Amcz9suWi6pmX7Wy0AFEmU+Lfn/04q+smQKaJI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739252797;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ra3ik4L74mI/EleeqyuvDQq7laB2uFJyTkglvF5QLyY=;
	b=EE3LYwZqwPvn8JIN4j/BD/NeE8bqF920RsgnK5VagM7Q0yD9ySNHpBduCQW2uhm8
	71RtOdDWk4lanfBbPfxSk+mZGkjDAzsZj4/I2B46BIcT8pSyI3Pc9V0qj9hT0rzshEL
	ZmBsmCaA7GpAfKFTA00LI17ZzSrcnQCj21wnzD/w=
Received: by mx.zohomail.com with SMTPS id 1739252793596952.7087934726432;
	Mon, 10 Feb 2025 21:46:33 -0800 (PST)
Message-ID: <7e199f67-f068-42fd-ae2e-fa2d402f9e20@zohomail.com>
Date: Tue, 11 Feb 2025 13:46:30 +0800
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
 <7c6c904c-4045-4b5b-8c31-99e3fd971515@zohomail.com>
 <d991ca86-2e0b-46e5-80af-e922d38d20ab@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <d991ca86-2e0b-46e5-80af-e922d38d20ab@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227c141984913e53e720fcc44c000002782c75340fc565430b3858b6402fe5edffa4887e7c5b6bbeb:zu08011227d8bc393d8658f0a7f6f662cd0000e5e35621c2bc526e9b0765a7521d96ecade379535c38e6b34c:rf0801122d41650cf823f4c005428df1150000a904407dec3f43f33c025b1c438b4cb97ecd3b20608def88e768cb1503bca4:ZohoMail
X-ZohoMailClient: External

On 2/11/2025 1:50 AM, Dave Jiang wrote:
>
> On 2/7/25 11:22 PM, Li Ming wrote:
>> On 2/8/2025 7:37 AM, Dave Jiang wrote:
>>> Certain features will be exclusively used by components such as in
>>> kernel RAS driver. Setup an exclusion list that can be later filtered
>>> out before exposing to user space.
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>  drivers/cxl/core/features.c | 26 ++++++++++++++++++++++++++
>>>  include/cxl/features.h      | 34 ++++++++++++++++++++++++++++++++++
>>>  2 files changed, 60 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>>> index d337224158fa..82f21f64452a 100644
>>> --- a/drivers/cxl/core/features.c
>>> +++ b/drivers/cxl/core/features.c
>>> @@ -6,6 +6,28 @@
>>>  #include "cxl.h"
>>>  #include "cxlmem.h"
>>>  
>>> +/* All the features below are exclusive to the kernel */
>>> +static const uuid_t cxl_exclusive_feats[] = {
>>> +	CXL_FEAT_PATROL_SCRUB_UUID,
>>> +	CXL_FEAT_ECS_UUID,
>>> +	CXL_FEAT_SPPR_UUID,
>>> +	CXL_FEAT_HPPR_UUID,
>>> +	CXL_FEAT_CACHELINE_SPARING_UUID,
>>> +	CXL_FEAT_ROW_SPARING_UUID,
>>> +	CXL_FEAT_BANK_SPARING_UUID,
>>> +	CXL_FEAT_RANK_SPARING_UUID,
>>> +};
>>> +
>>> +static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
>>> +{
>>> +	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
>>> +		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
>>> +			return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>>  inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>>>  {
>>>  	return cxlds->cxlfs;
>>> @@ -46,6 +68,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
>>>  	struct cxl_mbox_get_sup_feats_in mbox_in;
>>>  	struct cxl_feat_entry *entry;
>>>  	struct cxl_mbox_cmd mbox_cmd;
>>> +	int user_feats = 0;
>>>  	int count;
>>>  
>>>  	count = cxl_get_supported_features_count(cxl_mbox);
>>> @@ -120,6 +143,8 @@ get_supported_features(struct cxl_features_state *cxlfs)
>>>  			return NULL;
>>>  
>>>  		memcpy(entry, mbox_out->ents, retrieved);
> While you are pointing out the issue with copying multiple entries, I noticed that this needs to be fixed in patch2 as well. It should be:
> memcpy(entry, mbox_out->ents + start, retrieved);
>
> DJ

I noticed there is a 'mbox_in.start_idx = cpu_to_le16(start)' before sending GET_SUPPORTED_FEATURES command every time.

I think the 'mbox_out->ents[0]' is the first feature info starting from 'start', so the change you mentioned is not needed?


Ming

