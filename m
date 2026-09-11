Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC94BEE43;
	Fri, 11 Sep 2026 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171187; cv=none; b=ilIq1yA73m5HrCYVhwtFY6ctUQLHc2ubWOzL85H2K9ztOdBEy+0ExEXhMlGWxrcbOD6+P8uZg+0ONQDXu+spO7DKsMGEIN65WJwOCk0a2qmT4BO6gOcSvQJztOXKcH48PHyTg5CVuNlWIFDvXZc+4hR/aVQBlNdfRD5rEdufWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171187; c=relaxed/simple;
	bh=zjyLm9f6fIxyUDdZFCrV1WNkmDxsNfwCLy8DA9Ytb0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSTyqel00ZAVbptiPDPofzH9bpKiijrR8WCH4vqkKMXXPqT4xGluymSwAVphrTzotYWINGx2oKQrMTGwkiSGCbcIx89prZxC3YDZBRzronSJL8/Ny4msJP1D5LU+fSbFB5ezhX6A6x7OhjRXQYeinKTv33JM4qarIX1zmnUBP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmInT84K; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmInT84K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789171184; x=1820707184;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zjyLm9f6fIxyUDdZFCrV1WNkmDxsNfwCLy8DA9Ytb0M=;
  b=GmInT84KKyZo7Pt2DL91lz/R68QEdoIE63Mfmr8G83/IdZdJkMfCpuA7
   gN/cIzPVig3/NgtL5mzasNyBkQim1PSFgShO+/Q/SfTWh3cJzcTlOYDlF
   TmpEAOk7HpmW9ET7quQh52DxdOt7k2CBqmWktUJx8glMxBF5tQNS6ufyU
   0aV0+GCdSIjUeVmrftsHxhbyvQNN0EszfPlGG1LZIKiLC5JHVTlfvvmco
   eAgqA6x/mSz88h6/hiTP6EE9wFIIza013JsvloQqgT6t7fvLlthxBdFEJ
   EjVtSwUHY3/GpUSITH5wm6qWduEoY9Iz2KfZ3NnYCKD+dgceZ6csME+F4
   A==;
X-CSE-ConnectionGUID: aZUhQlBcRY6tzxqhIPOoLA==
X-CSE-MsgGUID: E1FW4cFbTZSBV3lj3ojk/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89678564"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89678564"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 16:59:43 -0700
X-CSE-ConnectionGUID: fGvVNgN/QI+3uTvCjJ3JmA==
X-CSE-MsgGUID: QPcezL5VQwWnT9rJKLb/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="310327609"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.42]) ([10.125.108.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 16:59:43 -0700
Message-ID: <753afbb6-c236-47e9-b48f-d7f9567deb2c@intel.com>
Date: Fri, 11 Sep 2026 16:59:41 -0700
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

Fixed title typo

Applied to cxl/next:
2cad1223081f

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

