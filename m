Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A93C1087;
	Tue, 14 Jul 2026 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052414; cv=none; b=YKA4kkvkt7Ci5bBJzde6IiuwvL7CE7ZyrPRqPPrSd8BPTfv2iWPdU4NT6/6F3XQkdCd96uhN8yy3X0UTJmcDOldc2l26NMkyluKo1FCAjx6LQg0auyTjl+qTEqTNC8QcmSps1dfTOHy1piy769Y4vDZ/4BWuzN8E7eBrPEu2KZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052414; c=relaxed/simple;
	bh=9C9FAhgOyn3Lv0hqfBb+V3AAMp19nzpCqpzN5c69a1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmxcBUI8JPJul/iKURHKeu90asNOPnl3Ug2HPZ8Fc4qm1SiLSIfJSdLyZoRXMs3P8u8S5+ej32uHHwkpMwzTBI/00llVN8UDgi33W9212m6GO1QpA11TysitHyi0791yPnN3oePHdafMe9tL7YkzrnVFnbJu4Exkrhfy3R+Dqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ot6O/HoG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ot6O/HoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784052413; x=1815588413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9C9FAhgOyn3Lv0hqfBb+V3AAMp19nzpCqpzN5c69a1I=;
  b=Ot6O/HoGgYAbaJNSwzBUvn7jHe862hRzuhi5zwl6Oe2YF4bP9LFJpLCI
   GUlu29QaryloTgPaURRu3slEm4xiEuJDGGrVoHn2pz2peZ7GI+QJQ9M9b
   AUeUjxFwdjFcWmF0Gbpk1JIZSQXBTC8oqKfHBtZO3jaw4r9xn1ODky1DC
   kz13NHvWutno5mlLcTnTwUpgvYKsrsaJTNiM7gYw4CmPediPgG3ZuZBbk
   4R2Eej2q7df1SY7FLDcDUFvJZkWgce4n5vXyHUUzQ2G6PGsVMmuqMBtY/
   DBri9h1bhMq3Wq2e65ZsB3b8oKHEDnr9KkKJikNWd8QoCDaRlJuwiJbxh
   Q==;
X-CSE-ConnectionGUID: hXGfbCD7TwKTLkXZyfdX8A==
X-CSE-MsgGUID: YTd6FXihQfumgZOPmLUxcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83669448"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="83669448"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:06:52 -0700
X-CSE-ConnectionGUID: fPoDGZKbThGP/hYYsZGX+g==
X-CSE-MsgGUID: T30jAzGiTnGnUgt8ZS0+MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254805543"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:06:50 -0700
Message-ID: <afcb4966-88c3-4462-b1f2-5e63dfdabd81@intel.com>
Date: Tue, 14 Jul 2026 11:06:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cxl/features: Clamp Get Feature output size to the
 remaining buffer
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com,
 kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-4-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260626104102.53892-4-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/26 3:41 AM, Richard Cheng wrote:
> cxl_get_feature() reads a feature in a loop but passes a fixed size_out
> as the output capacity every iteration. On the last partial iteration
> the buffer has less room left, so a device that returns more than asked
> can overflow feat_out.
> 
> Use the per-iter size data_to_rd_size, which already tracks the
> remaining room, as the output capacity.
> 
> Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changelog:
> 
> v2 -> v3:
>     - New patch.
> 
>  drivers/cxl/core/features.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index ed18ccb5e236..e52371f87300 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -225,7 +225,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		       void *feat_out, size_t feat_out_size, u16 offset,
>  		       u16 *return_code)
>  {
> -	size_t data_to_rd_size, size_out;
> +	size_t data_to_rd_size;
>  	struct cxl_mbox_get_feat_in pi;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	size_t data_rcvd_size = 0;
> @@ -237,7 +237,6 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	if (!feat_out || !feat_out_size)
>  		return 0;
>  
> -	size_out = min(feat_out_size, cxl_mbox->payload_size);
>  	uuid_copy(&pi.uuid, feat_uuid);
>  	pi.selection = selection;
>  	do {
> @@ -250,7 +249,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  			.opcode = CXL_MBOX_OP_GET_FEATURE,
>  			.size_in = sizeof(pi),
>  			.payload_in = &pi,
> -			.size_out = size_out,
> +			.size_out = data_to_rd_size,
>  			.payload_out = feat_out + data_rcvd_size,
>  			.min_out = data_to_rd_size,
>  		};

