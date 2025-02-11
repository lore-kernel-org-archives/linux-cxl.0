Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF2253B72
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290443; cv=none; b=rbIliPLmF1yI67PzSG52AUkP34bgYPNqZvSAZMH5bcOsinPrZGGstcvasfoK3IpGAgk45RldzPw6sb3/qRssoSk7TUIiu9UEjbbr9lfjBcvztjRg+SbOtVgBAdpT+UnLLiEWPVdhcKSTtEAw8o9zieu8zw/fdUOSGEvehXQQqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290443; c=relaxed/simple;
	bh=r5g1SIg2O/PEbPrHBg0Ls2EJ3X4W/itX/2zI6LGgthQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp+5XazECy+SJIyKLTYDxWFPrjTd+yjLG0G964HwTqV27U24icMTTykMeW2dkVt6R+ihMQXpY95JxJ6AwR1XmgETjUeWVANJo9ZQSnTsig9vVVBmx19LJZ5QQ2aFwPVbdvGzn/em2dj99pglK9QKHDs9FlHWt+sRKaTWcegDIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOtDZ55l; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOtDZ55l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739290441; x=1770826441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r5g1SIg2O/PEbPrHBg0Ls2EJ3X4W/itX/2zI6LGgthQ=;
  b=bOtDZ55lgClQAiWnWg7e9bUT0SyC0TKVq+VKSr29ayOhkS0tvhn/vQeM
   zniOefSwyrVFW9l0yLFcOvO14CfguVE50sX/NoefaSMSMf9ih2Ko1u6fG
   lz5iPrU8/FaSprLygLTrFe3mVTwMYwO29EnbFaAZoKnCVL8Hk4O0CF4Hh
   krjAE3JXZFhqql/Hd2GCFKBGy2j8S3MWHCeMWmlmzkACnxlVa13zSp+32
   gfao+3gq33F+1fITEMv/9QSSOnC6poZQV2t8jJMePuu7bO7KAFzGmKOnN
   lOK3nkkOHtrEcd7x8LesVHs6gfCAe+2WhQmm5ygqbGvMI3N3YzfX7DJ98
   g==;
X-CSE-ConnectionGUID: wsYrXfD1SmuZ6XFGBsxG6w==
X-CSE-MsgGUID: bNdg2rUlQ9uaJx6/IplOMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43575707"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="43575707"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 08:14:01 -0800
X-CSE-ConnectionGUID: bWdYaQC8QI+TMMmH1zpkVw==
X-CSE-MsgGUID: GgDAcALiSpKNTcEww8lywg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117171487"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.26]) ([10.125.108.26])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 08:14:00 -0800
Message-ID: <56f7d17d-1a9f-4f97-8ca6-bc0206dc7f93@intel.com>
Date: Tue, 11 Feb 2025 09:13:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] cxl: Setup exclusive CXL features that are
 reserved for the kernel
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-7-dave.jiang@intel.com>
 <7c6c904c-4045-4b5b-8c31-99e3fd971515@zohomail.com>
 <d991ca86-2e0b-46e5-80af-e922d38d20ab@intel.com>
 <7e199f67-f068-42fd-ae2e-fa2d402f9e20@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <7e199f67-f068-42fd-ae2e-fa2d402f9e20@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/10/25 10:46 PM, Li Ming wrote:
> On 2/11/2025 1:50 AM, Dave Jiang wrote:
>>
>> On 2/7/25 11:22 PM, Li Ming wrote:
>>> On 2/8/2025 7:37 AM, Dave Jiang wrote:
>>>> Certain features will be exclusively used by components such as in
>>>> kernel RAS driver. Setup an exclusion list that can be later filtered
>>>> out before exposing to user space.
>>>>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>>  drivers/cxl/core/features.c | 26 ++++++++++++++++++++++++++
>>>>  include/cxl/features.h      | 34 ++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 60 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>>>> index d337224158fa..82f21f64452a 100644
>>>> --- a/drivers/cxl/core/features.c
>>>> +++ b/drivers/cxl/core/features.c
>>>> @@ -6,6 +6,28 @@
>>>>  #include "cxl.h"
>>>>  #include "cxlmem.h"
>>>>  
>>>> +/* All the features below are exclusive to the kernel */
>>>> +static const uuid_t cxl_exclusive_feats[] = {
>>>> +	CXL_FEAT_PATROL_SCRUB_UUID,
>>>> +	CXL_FEAT_ECS_UUID,
>>>> +	CXL_FEAT_SPPR_UUID,
>>>> +	CXL_FEAT_HPPR_UUID,
>>>> +	CXL_FEAT_CACHELINE_SPARING_UUID,
>>>> +	CXL_FEAT_ROW_SPARING_UUID,
>>>> +	CXL_FEAT_BANK_SPARING_UUID,
>>>> +	CXL_FEAT_RANK_SPARING_UUID,
>>>> +};
>>>> +
>>>> +static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
>>>> +{
>>>> +	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
>>>> +		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
>>>> +			return true;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>>  inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>>>>  {
>>>>  	return cxlds->cxlfs;
>>>> @@ -46,6 +68,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
>>>>  	struct cxl_mbox_get_sup_feats_in mbox_in;
>>>>  	struct cxl_feat_entry *entry;
>>>>  	struct cxl_mbox_cmd mbox_cmd;
>>>> +	int user_feats = 0;
>>>>  	int count;
>>>>  
>>>>  	count = cxl_get_supported_features_count(cxl_mbox);
>>>> @@ -120,6 +143,8 @@ get_supported_features(struct cxl_features_state *cxlfs)
>>>>  			return NULL;
>>>>  
>>>>  		memcpy(entry, mbox_out->ents, retrieved);
>> While you are pointing out the issue with copying multiple entries, I noticed that this needs to be fixed in patch2 as well. It should be:
>> memcpy(entry, mbox_out->ents + start, retrieved);
>>
>> DJ
> 
> I noticed there is a 'mbox_in.start_idx = cpu_to_le16(start)' before sending GET_SUPPORTED_FEATURES command every time.
> 
> I think the 'mbox_out->ents[0]' is the first feature info starting from 'start', so the change you mentioned is not needed?

Ah yep. Thanks. 
> 
> 
> Ming
> 

