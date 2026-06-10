Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BB416CD33
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110772; cv=none; b=HXN9QVqfF+1Db7f4+qanPMdjhmg8wlP1aJ1VoDIWk9+0j/El17IV/N8mRGgNiFAal7hqIYh4MGCweEVljXruFAe6haBZ4CJ75AsZk7OQ+7mDX7eEzm9xN474xEtKZhBlJU8RD37W2QoUlIXWKKStaa4d/gkUi8WV1+DDKWJLv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110772; c=relaxed/simple;
	bh=01hycXc3btksk6W2QRNkqxLhZwVstSeVvQksAma1UAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrSdTpr7QcyM1nneo7B0lZPw6dGLki3Rh1k//kz921+0Vf9/SJ1ITYG2ckOhge6h0le6+ZEWEFl+XGwirmmFWh2sPRXmXO5A1CSg7myo3xXn/Blsp7R/lpoJdNyKfx1EhJvo7I1gb8WGeXYSl2YmSBhEM9hlagCKhTvc+PTZqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSxFT8ok; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSxFT8ok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781110772; x=1812646772;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=01hycXc3btksk6W2QRNkqxLhZwVstSeVvQksAma1UAw=;
  b=mSxFT8okq3czs6UETF02sYv7BaEDh7fwm27TYAd3NZAN3Y361x80wGQ5
   fjO8Xcn1J3NBB7r9n+qlCRJGNJXPmqk7xBdx6ARKVFuwaFlpS6qMEuf/T
   seoSO8PZHKInFVpjz2cO7GoXCc1LMjduGna9ADct7AXpjdPFle5a8I44G
   vTBuDc0AiifqE47p50X1N+FKCd7+1Q6k5gkrTO9iEBOZa6vhVS6qbO3a9
   8MhnDvXX/RzjbC8cTa7Zl5QIuNp45g4xFrcIr43E2sbyychzFMDsoNqQm
   WmD1Nv7FT4c4XdHnB6C3kvrk0ysYZTcL70enACgH4vBrltWJ+SiD8a5uP
   A==;
X-CSE-ConnectionGUID: je653mxrRWeHs9JRR/v7rQ==
X-CSE-MsgGUID: ROl3O5EmQ2iVc8ArMfwqfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92230348"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="92230348"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 09:59:32 -0700
X-CSE-ConnectionGUID: JKZpuRcwSu+CXLl6DnvHRw==
X-CSE-MsgGUID: Zr7VCTUASbqoY1ZrUK+/Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="245360189"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.110.25]) ([10.125.110.25])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 09:59:30 -0700
Message-ID: <2628c67c-536f-4622-a73c-4dad13239cdd@intel.com>
Date: Wed, 10 Jun 2026 09:59:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: update reference to removed
 CONFIG_PROVE_CXL_LOCKING
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
References: <20260610042101.222349-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260610042101.222349-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/9/26 9:21 PM, Ethan Nelson-Moore wrote:
> A comment in drivers/cxl/port.c refers to CONFIG_PROVE_CXL_LOCKING,
> which was removed in commit 38a34e10768c ("cxl: Drop
> cxl_device_lock()"). That commit switched CXL subsystem locking to
> custom lock classes, which can be validated via the standard
> CONFIG_PROVE_LOCKING option. Update the comment to reflect this.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52f..99cf77b6b699 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -18,7 +18,7 @@
>   * firmware) are managed in this drivers context. Each driver instance
>   * is responsible for tearing down the driver context of immediate
>   * descendant ports. The locking for this is validated by
> - * CONFIG_PROVE_CXL_LOCKING.
> + * CONFIG_PROVE_LOCKING.
>   *
>   * The primary service this driver provides is presenting APIs to other
>   * drivers to utilize the decoders, and indicating to userspace (via bind

