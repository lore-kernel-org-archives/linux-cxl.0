Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016084BEE3A;
	Fri, 11 Sep 2026 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163913; cv=none; b=Z1UOI4D4nZBVJt+ujb7F/uiFfCqapRbCqDbriJrlrJxHdnOucyrlRW9KKiU935mgiLhbrnMAySQAB6oi1eJuXMffNRQMIdZWnk+WDYkP8SRu88n7LeitsAMmgs5jl1GYahm1eUkgY/+vBFgNXsYBB8/9RfPcUBrrPksBHqSo5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163913; c=relaxed/simple;
	bh=yr9syAsnRLwuXmKkM3bg57Me/8ncv25601DggI1ps6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBswKAyL0ltzqxU7fYBWzsuah3R0nHv4JE2ncNkoG/IqmIxLwflNq2woyyS9BxikLRb4hPxV9FxLuSkzTVeN4Jf8lLDtLyJ22GvNcdOwXe2Lh6cdM9Oqu1YhJoB2Y7fhGwEVk+LW9KjtqFVAjHxoJcvWHv0aCHl73yE71D9Ejnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iT/c45nc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iT/c45nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789163912; x=1820699912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yr9syAsnRLwuXmKkM3bg57Me/8ncv25601DggI1ps6k=;
  b=iT/c45ncF1yePj5uZnbLP29mwtp3Wmy1pZE/YagysdYC6mE+JE8TQhak
   G5bwQa0yZF/RXDiIwxSx+bMPsKdyAILzUyEPBRZaNr+8WzTqaCUGP/+JA
   4i5oIgzaCGbMQ3mUHxjkwTqn22TMATiveHY+7kg60EPVpd2vsLhrjwDto
   8BJUenCCRpgrJ2IYUW7bmsBtyKGHjVaV0yzrRKrCT3otH9hNrkE+HuWt8
   C8RtPYX4GjO56qeYuL659IJ9Z6GB3aKooXLSOzLrbe7MRuXJJbmwhUn/m
   KQaUtoWjnwytl4/6/9Ic9Jbjv1tLvy2DWEZiB2kpm44BuWgVVXOsq9HEJ
   g==;
X-CSE-ConnectionGUID: bJOZ3C10RxOHUsw6g8h16g==
X-CSE-MsgGUID: iEXH3aYUTQaFGNEumU5XXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89563114"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89563114"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:58:32 -0700
X-CSE-ConnectionGUID: +cKrVmJMRCyQawGRRQa+Jg==
X-CSE-MsgGUID: Fcu7HPzJRiWJfrQGt0DY/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="269429277"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.42]) ([10.125.108.42])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:58:30 -0700
Message-ID: <6a5c975c-764f-4af7-8aa3-9dea94ad603f@intel.com>
Date: Fri, 11 Sep 2026 14:58:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] cxl/features: Ensure that count is set before
 access to end[] __counted_by()
To: Ashok Raj <ashok.raj@oss.qualcomm.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260911215304.1816467-1-ashok.raj@oss.qualcomm.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260911215304.1816467-1-ashok.raj@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/11/26 2:53 PM, Ashok Raj wrote:
> get_supported_features() assigns entries->num_features only after the
> memcpy() loop that fills entries->ent[] has already run. Since ent[]
> is __counted_by(num_features), the compiler's bounds instrumentation
> sees a 0-length array during that loop and FORTIFY_SOURCE trips on
> the memcpy. Set @num_features right after allocation, before any
> write into ent[], so the bound is correct for the whole lifetime of
> the array.
> 
> This was found via a fortify panic:
> 
>  memcpy: detected buffer overflow: 384 byte write of buffer size 0
>  WARNING: lib/string_helpers.c:1035 at __fortify_report+0x54/0xa0
>  kernel BUG at lib/string_helpers.c:1043!
>  Call trace:
>   __fortify_panic+0x10/0x18
>   get_supported_features.isra.0+0x4a0/0x4d0 [cxl_core]
>   devm_cxl_setup_features+0x84/0x120 [cxl_core]
>   cxl_pci_probe+0x254/0x5e0 [cxl_pci]
> 
> Same class of bug, same fix shape as commit 6c9d2e87df40
> ("cxl/fwctl: Fix __fortify_panic"), which fixed the analogous issue
> in cxlctl_get_supported_features() but missed this one.
> 
> Fixes: f0e6a2329bf9 ("cxl: Add Get Supported Features command for kernel usage")
> Signed-off-by: Ashok Raj <ashok.raj@oss.qualcomm.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> RESEND: Dropped the mailing lists (linux-cxl, linux-kernel) from Cc
> by mistake on the first send. Resending with proper Cc.
> 
>  drivers/cxl/core/features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index ba6d2a5acb74..754fe5eb4b76 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -97,6 +97,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
>  		kvmalloc_flex(*entries, ent, count);
>  	if (!entries)
>  		return NULL;
> +	entries->num_features = count;
>  
>  	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
>  		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> @@ -174,7 +175,6 @@ get_supported_features(struct cxl_features_state *cxlfs)
>  		start += num_entries;
>  	} while (remain_feats);
>  
> -	entries->num_features = count;
>  	entries->num_user_features = user_feats;
>  
>  	return no_free_ptr(entries);

