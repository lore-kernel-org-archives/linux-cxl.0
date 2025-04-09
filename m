Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5572638A9;
	Wed,  9 Apr 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212905; cv=none; b=V2SYLqY0/G4d1JXLB4D2zH45QJ1Xfw/DDdTRZsRoo8N3kRrwKGM7QCyblXmR1nKWMKUhVppBWW+nodymunuB0UJz//K5rCo0fR8jTrKs7Djb1jP2twj2WGVxUJVadnN7V8YOpM3/FdQMekYZ4tGEOBHWjhROPOHNe+yMQkttHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212905; c=relaxed/simple;
	bh=yRWrmXt8NaZQ6MLBo1bv+eeG7YyvMrMCJtYcM0X4ni0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAVqgYcgn9MmuBVr7J5pHZ+t2jzBPV7H1zSL0wzVgHCr00JcugfQzfd5CjXMDh1jddxdwz60iWocU5E3lbboG0uhzOh24wrSGfNyo8aay9N6Wq7iwQPMIH5kRCkoJKPVWYsHjIK6Gu08PpZlPDycX+B3N0ip7YR03sC+4A9FYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQMR2ujI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQMR2ujI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744212903; x=1775748903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yRWrmXt8NaZQ6MLBo1bv+eeG7YyvMrMCJtYcM0X4ni0=;
  b=YQMR2ujIL3/clhotMSo5hYiNkkrljjcJogQyZT+njtuAx//e4l/brj7d
   g1E7cpZ8yAPABZB9S+xkGoCdb4njy3cVq7R5B6DL9CeGWz95nC5Fj7+1v
   mIUkFy//1hNUJzVhTDwGKSs/caJhZ8Hiiwr9mKps+DE7UVKsemh3hxgsd
   1m2qGbFHGV+phDOjiSSzplc51GYky+s4fCYJFJnEPtRQc0wLlmoqy6K32
   KIbJWpl1xcI/nzJw5AplX3xabI88D1KYWDJilSbk3tkAqniDe+6QNBYGb
   vIHEyHg1mM1ZJtCsMKXfaWyBNkmAazmt5cUkMLOyjg/Zu8AxVMBjZ0ygK
   w==;
X-CSE-ConnectionGUID: D+ks7vNnRRathjRImbzSTg==
X-CSE-MsgGUID: N2X980T3TOa0cOeMSemoqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="57071010"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="57071010"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:35:02 -0700
X-CSE-ConnectionGUID: uS7fge+TQ261Gwh+xpy8dQ==
X-CSE-MsgGUID: EQMHv0zHRlWgzedwnWyuQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128590609"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.236]) ([10.125.111.236])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:35:02 -0700
Message-ID: <d8f5fbc5-5deb-4232-bd5e-440098650da8@intel.com>
Date: Wed, 9 Apr 2025 08:35:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] cxl/feature: Using Full Data Transfer only when
 offset is 0
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 shiju.jose@huawei.com
References: <20250409024825.510632-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250409024825.510632-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/25 7:48 PM, Li Ming wrote:
> Per CXL r3.2 section 8.2.10.6.3 Set Feature(Opcode 0502h)
> 
> "If the Feature data is transferred in its entirely, the caller makes
> one call to Set Feature with Action = Full Data Transfer. The Offset
> field is not used and shall be ignored."
> 
> It implies if using Full Data Transfer, the received data should be
> updated from offset 0 on device side.
> 
> Current driver implementation is if feature data size is less than mbox
> payload - set feature header, driver will use Full Data Transfer even if
> user provides an offset. Per above description, feature data will be
> written from offset 0 rather than the offset value user provided, the
> result will not be what user expects.
> 
> The changes is checking if the offset caller provides is equal to 0, if
> yes, using Full Data Transfer, if not, using Initiate Data Transfer -
> Finish Data Transfer.
> 
> After the changes, all Set Feature transfer scenarios are below:
> 
> 1. data size + header is less than mbox payload and offset is 0
> 	Full Data Transfer
> 
> 2. data size + header is less than mbox payload and offset is not 0
> 	Initiate Data Transfer(with all feature data) - Finish Data Transfer(with no feature data)
> 
> 3. data size + header us greater than mbox payload with any value of offset
> 	Initiate Data Transfer - Continue Data Transfer - Finish Data Transfer
> 
> Fixes: 14d502cc2718e ("cxl/mbox: Add SET_FEATURE mailbox command")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks for this. LGTM. You can drop the RFC. 

> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1
> ---
>  drivers/cxl/core/features.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index f4daefe3180e..fcc624cefe89 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -259,6 +259,17 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	return data_rcvd_size;
>  }
>  
> +static bool is_last_feat_transfer(struct cxl_mbox_set_feat_in *pi)
> +{
> +	switch (le32_to_cpu(pi->flags) & CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK) {
> +	case CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER:
> +	case CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
>   * available in the mailbox for storing the actual feature data so that
> @@ -294,14 +305,14 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > cxl_mbox->payload_size)
>  		return -ENOMEM;
>  
> -	if (hdr_size + feat_data_size <= cxl_mbox->payload_size) {
> +	if (hdr_size + feat_data_size <= cxl_mbox->payload_size && !offset) {
>  		pi->flags = cpu_to_le32(feat_flag |
>  					CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
>  		data_in_size = feat_data_size;
>  	} else {
>  		pi->flags = cpu_to_le32(feat_flag |
>  					CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
> -		data_in_size = cxl_mbox->payload_size - hdr_size;
> +		data_in_size = min(feat_data_size, cxl_mbox->payload_size - hdr_size);
>  	}
>  
>  	do {
> @@ -322,7 +333,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  		}
>  
>  		data_sent_size += data_in_size;
> -		if (data_sent_size >= feat_data_size) {
> +		if (data_sent_size >= feat_data_size &&
> +		    is_last_feat_transfer(pi)) {
>  			if (return_code)
>  				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
>  			return 0;

