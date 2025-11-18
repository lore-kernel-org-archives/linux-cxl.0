Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2B3126A4
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508925; cv=none; b=WNtAggAo5SEpIgyRRKgpE9p9KJqspuMu/AHzt3gre7y5Zy+Q2O4khiGQwu/lcwvNaZGoDSlKACZIHzyTlLIFU3F8t7sN6Jel/U0u66g4XFQ1Rm+01JHv+BV3dmok+dEsllHKcetOVzBL/KvlzwyMy9d0FgTND3Tu9YXAUjB9UwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508925; c=relaxed/simple;
	bh=vbyQpCOuIUwoNJYIu5boe7KRM3ONknryjksD3//GSes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr6B1LrusVfEXX9oWzWyfd99aU2WgQNQuKAQrTwyxaIRKd6BDh3ehXuG1r1eJVjja0o2c8d3+JkGOEPV5Jamt+68beMpYrPGS2hcbDQjwo4E1B3EjJtkIidn7Qw+QSY0Czuzs2TseoojQlyCVGK1XdOtCK8cx0n8cBofkiXJBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AU8ZsNvq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AU8ZsNvq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763508925; x=1795044925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vbyQpCOuIUwoNJYIu5boe7KRM3ONknryjksD3//GSes=;
  b=AU8ZsNvq0lF9iVMiFABGqaAwjU/8fddDNpKS4kFaCEEQzT8WmAXsudxN
   k4nYSy8lWV8fXTDUJ4iH6IsH4WUiuRwM+RgwbJqTWb6xvrr8yjZfGjNvc
   377zzcs2TyHlzuoxOfg3CVYeRtojkg3QjWMp3VcHoweAeF2MNSrXp1Woa
   VVxt1Ov0dCyORC9A3R5N22Mg0x+gHlVoSKBvGu5VlelKUPlAniiz+R7J2
   ZdULHmT+y3eJC7niek1U3ZXKelrzZ0Vd4CWTNL7EPTUWV/693721fWg85
   ICMphO+OfL4ackJgb/oqF0IIykOg3kTRbax8yGeBHdpVFAhULTwmh9AhP
   g==;
X-CSE-ConnectionGUID: UHcuNRpxSdCmH4HCVF3fbQ==
X-CSE-MsgGUID: GHyzMF7HTY+yQ0UUXzjjeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76648928"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76648928"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:35:24 -0800
X-CSE-ConnectionGUID: b+RP98S8RP6YV0j1r59Z4g==
X-CSE-MsgGUID: rycI38AMTIe+yNut4Fslvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191026284"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.115]) ([10.125.109.115])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:35:23 -0800
Message-ID: <10f99d05-4fa8-4e7e-9ecf-cc0d69eee668@intel.com>
Date: Tue, 18 Nov 2025 16:35:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Remove ret_limit race condition in
 mock_get_event()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
References: <20251116013819.1713780-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251116013819.1713780-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/25 6:37 PM, Alison Schofield wrote:
> Commit 364ee9f3265e ("cxl/test: Enhance event testing") changed the
> loop iterator in mock_get_event() from a static constant,
> CXL_TEST_EVENT_CNT, to a dynamic global variable, ret_limit. The
> intent was to vary the number of events returned per call to simulate
> events occurring while logs are being read.
> 
> However, ret_limit is modified without synchronization. When multiple
> threads call mock_get_event() concurrently, one thread may read
> ret_limit, another thread may increment it, and the first thread's
> loop condition and size calculation see and use the updated value.
> 
> This is visible during cxl_test module load when all memdevs are
> initializing simultaneously, which includes getting event records. It
> is not tied to the cxl-events.sh unit test specifically, as that
> operates on a single memdev.
> 
> While no actual harm results (the buffer is always large enough and
> the record count fields correctly reflect what was written), this is
> a correctness issue. The race creates an inconsistent state within
> mock_get_event() and adding variability based on a race appears
> unintended.
> 
> Make ret_limit a local variable populated from an atomic counter. Each
> call gets a stable value that won't change during execution. That
> preserves the intended behavior of varying the return counts across
> calls while eliminating the race condition.
> 
> This implementation uses "+ 1" to produce the full range of 1 to
> CXL_TEST_EVENT_RET_MAX (4) records. Previously only 1, 2, 3 were
> produced.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

applied to cxl/next
b6369daf0d6a cxl/test: Remove ret_limit race condition in mock_get_event()

> ---
> 
> This was found while chasing a NULL payload_out issue in mock_get_event()
> that Itaru reported here [1] and Fabio and I have both seen but not been
> able to reliably reproduce. Although the accounting can be wrong wrt
> ret_limit, no potential overflow was found.
> 
> [1] https://lore.kernel.org/linux-cxl/49A4B521-AB66-4037-A23D-1D0D7AF0F42F@linux.dev/
> 
> 
>  tools/testing/cxl/test/mem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index d533481672b7..6809c4a26f5e 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -250,22 +250,22 @@ static void mes_add_event(struct mock_event_store *mes,
>   * Vary the number of events returned to simulate events occuring while the
>   * logs are being read.
>   */
> -static int ret_limit = 0;
> +static atomic_t event_counter = ATOMIC_INIT(0);
>  
>  static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_get_event_payload *pl;
>  	struct mock_event_log *log;
>  	u16 nr_overflow;
> +	int ret_limit;
>  	u8 log_type;
>  	int i;
>  
>  	if (cmd->size_in != sizeof(log_type))
>  		return -EINVAL;
>  
> -	ret_limit = (ret_limit + 1) % CXL_TEST_EVENT_RET_MAX;
> -	if (!ret_limit)
> -		ret_limit = 1;
> +	/* Vary return limit from 1 to CXL_TEST_EVENT_RET_MAX */
> +	ret_limit = (atomic_inc_return(&event_counter) % CXL_TEST_EVENT_RET_MAX) + 1;
>  
>  	if (cmd->size_out < struct_size(pl, records, ret_limit))
>  		return -EINVAL;
> 
> base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c

