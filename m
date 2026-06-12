Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970BA1E9B1A
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227033; cv=none; b=Iidb0ZON7z0O8n3mEmoWqzDcwuB6/hNKpI8ULltES0bMmUgClN7h25NLKR6S+2Iv03JC147q9HfoGliNRvOx/EYZtNu7WZK1U/kGkz/lA+6LGAjLfb1NjcEVYO2GvGkcqrdn67Tx3Dzw0N7y65UgJC31V0duKbkhtyd/s84Tq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227033; c=relaxed/simple;
	bh=PWUl7ed1fLQK6YiFJbg9lVo1qbP9nUUD2CdPmRUrzL0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Owb0LXGSqohgd87nuEXAWBYomI3rB++9DIdVtxvb4LWGnDGUnMTHs5ZBIhM4AJogVBQYTqDXvAIyAFM+G7J5O4trqHGnSourLbH+ZW7oV5KXYayaEYb1zWp4bgoB2bxLPfWrsOd25OYc3eIHsy+/q2Kwx7XjlkBKNwaE8b3XT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxrgMs3Z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxrgMs3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781227032; x=1812763032;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=PWUl7ed1fLQK6YiFJbg9lVo1qbP9nUUD2CdPmRUrzL0=;
  b=dxrgMs3ZHu2KNOfOSaOy0CIaR0jMLfEyIyxkKvz50zQWtA/hYFgpdVYK
   SdUrZFvEDYFnmIdHa2RqpxZrry1yk9IzYrV5E30/LaErgb7U+W7e/AzUQ
   ov5kn/GcEy0HP+L4Dxr+wyOIUUbVqfBUP4NnxRn2/yyZf7vi1NjvRmbBw
   xnDPaYyGa5znUbIo/y3WPJhrLNrg/+AH4ALgNN2uGj/YuxwU0HdL1ScM1
   OcBrb1j48WpTXc3wPWmRakEMDCEwRiMQSgGPVUGI3BmXjK2fje+RRYPay
   MFpXNMtLTPgccsC6EMOvu1E+GOMsEh6L7oqZBj71HMRVf3Mgd5MHRhIYH
   w==;
X-CSE-ConnectionGUID: GPHfum0lSSimUl8kl7wYOQ==
X-CSE-MsgGUID: zlad3ykeSgSSyB7u1sQc9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82118629"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82118629"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:17:12 -0700
X-CSE-ConnectionGUID: QiDsoPg/QeSYWjC4LH7VdA==
X-CSE-MsgGUID: KIs7lwuYRSmbjPqZijJHpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246556122"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.105]) ([10.125.110.105])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:17:12 -0700
Message-ID: <31a0fd2a-5c13-480d-8a7a-82eef55a6831@intel.com>
Date: Thu, 11 Jun 2026 18:17:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Unregister cxl_acpi in cxl_test_init() error
 path
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 djbw@kernel.org
References: <20260611230355.198912-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260611230355.198912-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/26 4:03 PM, Dave Jiang wrote:
> In cxl_test_init(), Once cxl_mock_platform_device_add() succeeds, all
> error paths after needs to call platform_device_unregister() instead of
> platform_device_put() to clean up.
> 
> Fixes: 67dcdd4d3b83 ("tools/testing/cxl: Introduce a mocked-up CXL port hierarchy")
> Reported-by: sashiko-bot
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
50cc34be04a0

> ---
>  tools/testing/cxl/test/cxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index e6f68dba85d1..5733a526f7dc 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1955,7 +1955,7 @@ static __init int cxl_test_init(void)
>  err_mem:
>  	cxl_mem_exit();
>  err_root:
> -	platform_device_put(cxl_acpi);
> +	platform_device_unregister(cxl_acpi);
>  err_rch:
>  	cxl_rch_topo_exit();
>  err_single:
> 
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> prerequisite-patch-id: 1368e94a3bbc2945c2eb36ac72bd6ab8a10650de

