Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124EA39022A;
	Wed, 18 Mar 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848460; cv=none; b=R0GGA6d8sr6piuvBblCj63+EOcQkr+AhDe4nI8ZPQevo0ME8m52CPsA4+EIsDkGuU7+iw5/02wlyuTnrDQizYYwbpW8D0qYSO4Ztitdi682xdk0XVWWnzgDxgCmjfV/2zZA5Qq8BCtpzYBk2QXEzesYE7emIFqb+7W4dYc7pgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848460; c=relaxed/simple;
	bh=naC/KGMymmnh9pcOiJVUz2bx6hJJja6wL8shxmkfA2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjvOP9pdFkHrn/PFlDkcKhqJG619LUugkV9ndoi1PA9HHfl6BUzBTi2eHuDoC7B81RVsk6cD72iCnHvTSjDlIzi2B4vokY89VIwqydPL3MuTvigm4U333JlUYpSuR7fi2AkX2LCfi4EyXeVAzPsJhhGBR93b4LU1HvhoQIWizBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6Gwmg8T; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6Gwmg8T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848457; x=1805384457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=naC/KGMymmnh9pcOiJVUz2bx6hJJja6wL8shxmkfA2A=;
  b=g6Gwmg8TDbAiSAcrBxUoNyXiSKcHjEU8JbOhinqPaIb2gTmOtrL/nD4h
   H0hKA8FjYRIhPonyFdHCCxSx+euOdamPnPbLwi7aex3JkyN0fCUuXjtDP
   kfmEODjTe35bIa0Pt3ZhIZmHIhTXaPQU2u0+qpYUboeu4JdsTSnU57Wm9
   woOwQolXEWeBtKWjE67dMcsQOFzOgRouSbobqiELCMD2Jhsvr1Wi7jtdD
   NeXfAAvSWIZv/JINIop5AhCuecJchTPyjiSYLsWfhvtc5HpAEjKYFgsu9
   BqOXCdXaO4wUaabrgCOUADN9jp0S5eBFhCaiUJXibkpUwn6naRJvP5vM6
   Q==;
X-CSE-ConnectionGUID: qftNlqq5SfiCUEG6/LmqcQ==
X-CSE-MsgGUID: Ti+j+F2LTquOzMrGrkggcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85982360"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85982360"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:40:56 -0700
X-CSE-ConnectionGUID: OPLoo12WTZO7BUHoi9X0Ig==
X-CSE-MsgGUID: r7xGQSfwROyrHT004mCjcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227608355"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.242]) ([10.125.108.242])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:40:56 -0700
Message-ID: <69f68851-9e02-431a-9331-8f687bb2fa4a@intel.com>
Date: Wed, 18 Mar 2026 08:40:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Add support for 32 switch decoders
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260318-add_support_for_32_decoders-v1-1-bb7b41efde2a@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260318-add_support_for_32_decoders-v1-1-bb7b41efde2a@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/26 6:00 AM, Li Ming wrote:
> Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
> support 32 HDM decoders. Current implementation misses some decoders on
> CXL host bridge and switch in the case that the value of Decoder Count
> field in CXL HDM decoder Capability Register is greater than or equal to
> 9.
> 
> Update calculation implementation to ensure the decoder count calculation
> is correct for CXL host bridge/switch ports.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/cxl.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b947286eb9b..466b8eeefed7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -77,7 +77,12 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  {
>  	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>  
> -	return val ? val * 2 : 1;
> +	if (!val)
> +		return 1;
> +	else if (val <= 8)
> +		return val * 2;
> +	else
> +		return 4 * (val - 4);

That looks a bit messy. How about:

switch (val) {
case 0:
	return 1;
case 1..8:
	return val * 2;
case 9..12:
	return val 4 * (val - 4);
default:
	return -ENXIO;
}

DJ

>  }
>  
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> 
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260318-add_support_for_32_decoders-4a7c77949a41
> 
> Best regards,

