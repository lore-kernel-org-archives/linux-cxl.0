Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868666;
	b=LKdxfxWTtf/SWMa+KS/PrsXWq7JNsERWM1fXZxnrjU13scbMqfitq7/KwVN/ms7MR/gQ
	 dVmIz3PphuIYCRYgbsPGsplEoFKxqsHr1+ccIFTvRzg27Rv5DzSEoA+ifLgw8d3r2ibLO
	 Km77pRYQPvMv7RFj3u8U6nnZUPa/mfThXSN912lH81qzE2xEjE+0wiD0hS51Cq3Nc8fbh
	 mRkL9bljdz5fQxaoraEDmoMV6QayqC31+drGh17EyQfXPchsKWCZAorMSBdBPAKPYSZi7
	 +WLk+xynRyojxst+/H4jJjNvqnZkW+raUf5AwmjiC6LXanc5Fkol8nZPPdlfQq2sEhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868666;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=d1U7Zg+8BUkr+MXWT2mjLT7i22v3k6inK78V0yPDvnU=;
	b=g9FSwrcMoex476F1sMYn0WvWVDgVXlemNVaiqWL+N1ec+bo/wKQ0Ri+tN7d8HATYBy0X
	 mXM346RkkcMbKiEAxDxPLfDt8nJnVd2LwofeF9Z43lSNRN3qQ061fQwdF6Qk0B7kclyVT
	 GY3+AQDAbnkn/3Vt6kU9rbJy/Vl5AOhguzkmDby10ouVm1F7Zl0eOo1Zvy0f02TvlbEKL
	 Pbo0C6Qr2gyEhJ1LY5RCG4Ribb+OGREuJgXARl2vV9bVXra2kuFjSK8pRksIwIu6YrVQn
	 57fLOBY9pWOSUMUMfXkX9DBYtoFUE61hfKlHDZvCPhkd6nfsPd30Dx0y8XXjPiGo1Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="HNxOM/rx";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE2606A881
	for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 22:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAEE2606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HNxOM/rx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794868665; x=1826404665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M4e6ksUQ+nxr+FUoYLvyqs3zJEqubul34Nncg7uOJ80=;
  b=HNxOM/rxsg6vVjUYmZRP9crgUMVncfJ8QzSJN5iMxni87NM4c5hfgmdM
   wHm9z3mTqhP54RXc9QT42ZsZhhfIXyT7iRRkuqN913vQPbLc2NMVjJBu6
   DR74ZE18Ea8qujJjt6M9y29BoxCJT6ebGkfQyfguC9CSk5XK0T/X6huJy
   Uy19+7hi8TQ8kerjLPEeXFFEVZqdwBaUj08iBujnPB5D3OE2ppLjXOFKc
   gfC+D1Wf2HrI/XrfI5kXgzmdHwQ4ClTDZcOW2C2lBJse+ElninXszcWfT
   n1Duul7Nx71ptJ7Njus95x2tpMSdBzwCc87wVVbVmIQ2BSzYMw2A5sEEi
   Q==;
X-CSE-ConnectionGUID: SlHi0E8pRAWPiuht7VdN5A==
X-CSE-MsgGUID: HK7xG64bQUOnPJ+wwxX4zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3610394"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3610394"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:37:44 -0800
X-CSE-ConnectionGUID: tAtXVp+sQ0yaLVltOzDR7A==
X-CSE-MsgGUID: iPhnLn8VRh66aDwgCpL3rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9708244"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.118]) ([10.125.108.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:37:42 -0800
Message-ID: <727537be-00b8-4e46-815e-7132ac8e7a14@intel.com>
Date: Mon, 16 Nov 2026 15:37:36 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Free the decoder registry when cxl_test_init()
 fails
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <20261106222240.958402-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261106222240.958402-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/26 3:22 PM, Alison Schofield wrote:
> Decoder registry entries persist across mock device removal to support
> topology replay. Sashiko review found that if cxl_test_init() fails after
> decoders are enumerated, the entries leak because cxl_test_exit() is never
> called.
> 
> Free the registry entries and destroy the xarray during error unwind.
> 
> Fixes: f3b1d2260703 ("tools/testing/cxl: Enable replay of user regions as auto regions")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/fixes:
a5fb83dcf19a

> ---
>  tools/testing/cxl/test/cxl.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 3eb1051b1ee8..e3bed17ae253 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -2436,6 +2436,17 @@ static int cxl_topo_init(void)
>  	return cxl_type3_topo_init();
>  }
>  
> +static void free_decoder_registry(void)
> +{
> +	unsigned long index;
> +	void *entry;
> +
> +	xa_for_each(&decoder_registry, index, entry) {
> +		xa_erase(&decoder_registry, index);
> +		kfree(entry);
> +	}
> +}
> +
>  static __init int cxl_test_init(void)
>  {
>  	struct range mappable;
> @@ -2525,20 +2536,11 @@ static __init int cxl_test_init(void)
>  	gen_pool_destroy(cxl_mock_pool);
>  err_gen_pool_create:
>  	unregister_cxl_mock_ops(&cxl_mock_ops);
> +	free_decoder_registry();
> +	xa_destroy(&decoder_registry);
>  	return rc;
>  }
>  
> -static void free_decoder_registry(void)
> -{
> -	unsigned long index;
> -	void *entry;
> -
> -	xa_for_each(&decoder_registry, index, entry) {
> -		xa_erase(&decoder_registry, index);
> -		kfree(entry);
> -	}
> -}
> -
>  static __exit void cxl_test_exit(void)
>  {
>  	hmem_test_exit();
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

