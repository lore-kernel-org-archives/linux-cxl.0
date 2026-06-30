Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00B349CCF;
	Tue, 30 Jun 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834873; cv=none; b=o5aWB0CGDVGPIylyDEDlSzQYYyKRiEWtJSPnpiab8p0cM7HmWSqRTD98EzgXNCIu2zxrJapDtKMFgdsxdPGVWcx+mQIZaN6oBixxXdaMd9pDBBFFfyXGWfurfg+0qRJiGGeSIsygfulLEAZocApCabubDDuU9HYRgGro4sLd5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834873; c=relaxed/simple;
	bh=i8jo1o5u3WhYTUBiZ/Qh6t+Wk7/nEALqzBb1P1i+TqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwYLGeVzEGHyPKU4+UKS7TASs5xTkewnxDu6PL1MELiPHxsRMNSE8FQKt5ukH/6cFU+ILT+h/5IkU4kZg6EVW4YPj1GAPcVC3pVHZWSJc0HmF7X8RSGID28Hemjs9/TZFnVJtcXIfKqCkkJJ5uzHvs55Uv0rhPsttFx5SuKL78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLHAi/g8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLHAi/g8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782834873; x=1814370873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i8jo1o5u3WhYTUBiZ/Qh6t+Wk7/nEALqzBb1P1i+TqI=;
  b=eLHAi/g8X7fNQujs2fzU+V2AATIXOyGSSSbEx23aS3MUiq/fUtBSc8ff
   fq4s0V1yXEd7huqhhC9kKBi19OXgBPQiwv8QdfkVkxnIaxYcWAym1oyOL
   C0J7dQo1zgvsZHzbBuFVNHgi27pWRTbLZpuRqjUY5ohhoaHkaTkMGPnPG
   tKmOSKy2tt4JGeVJjBkJdCSF4opDjWhfIkeutNTM5a+fP5dj3AvOXwSj8
   uW4iQmTMGZce3RvDw5CI1Vfm4+jOpjBbVlbwwD5KA4U1Hm24z/+OvLONM
   589im5K7V38s5gyTDt66lge7kLm8Qlz1ofHi5Vn7qFzCofxXgoVPiqzWB
   g==;
X-CSE-ConnectionGUID: 5qIP366FQ4+GsQia2PaIkg==
X-CSE-MsgGUID: ITm2jDNTSTKGcOrQkbn00A==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83425862"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83425862"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:54:33 -0700
X-CSE-ConnectionGUID: h7Vpqlt/TsWjYJEYK4iLvA==
X-CSE-MsgGUID: 5+UAC1FFReqoiNjpKOyEVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="247828413"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.254]) ([10.125.109.254])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:54:30 -0700
Message-ID: <3cdc48ca-5c39-42aa-8853-e5e3a7884bbe@intel.com>
Date: Tue, 30 Jun 2026 08:54:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cxl/features: Reject feature offset that overflows
 16-bit field
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260630074657.43077-1-icheng@nvidia.com>
 <20260630074657.43077-2-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260630074657.43077-2-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/30/26 12:46 AM, Richard Cheng wrote:
> cxl_get_feature() and cxl_set_feature() build the mailbox command's
> offset as cpu_to_le16(offset + data_rcvd_size/data_sent_size), but never
> check the sum fits in the 16-bit field. Via fwctl, a user-supplied
> offset plus count/op_size summing over 65535 silently wraps, steering
> the device to the wrong feature offset.
> 
> Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
> Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/features.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72..db5964ea184f 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -237,6 +237,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	if (!feat_out || !feat_out_size)
>  		return 0;
>  
> +	if (offset + feat_out_size > U16_MAX)
> +		return 0;

Should this return -EINVAL?

> +
>  	size_out = min(feat_out_size, cxl_mbox->payload_size);
>  	uuid_copy(&pi.uuid, feat_uuid);
>  	pi.selection = selection;
> @@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	if (return_code)
>  		*return_code = CXL_MBOX_CMD_RC_INPUT;
>  
> +	if (offset + feat_data_size > U16_MAX)
> +		return -EINVAL;
> +
>  	struct cxl_mbox_set_feat_in *pi __free(kfree) =
>  			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
>  	if (!pi)

