Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA6239E76;
	Wed, 19 Nov 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596232; cv=none; b=JFU0VG+G18remaU2tpc3zxV6f9A5f+SiAcoLYqKFJ/OLPsAeazJh4mcScro4Tjzh0uY5ivr4I5CbgExj5rora5OFf18oD2Neqe05Ctfr4NTxHVbGUtQ8qCwKmEqeE68RS1bVzmmQXxNMLIQsWdajSY9HHZO4uIPLcs3ZhirHuVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596232; c=relaxed/simple;
	bh=88WEpF77s66yhkk+cSD4j1rSoZ0TxLgXcdnr4Tzdt0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPZ+JVI43hp5yLQYnr/9uKT+AndNjHB0V9w9mf+oJhgQ1T4UfnFPlCfvxIGzXFl+dPo//ue4z8yToVe7+MIXZhWSuxS4nqevnNq9mWQmRvWMHBS8gWSp4MZWokSlvRYb5HOcwlsq5+eUZdC1B0AI8veLVI0xWg+rQzQXIREV2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hd2uj55R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hd2uj55R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763596231; x=1795132231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=88WEpF77s66yhkk+cSD4j1rSoZ0TxLgXcdnr4Tzdt0s=;
  b=hd2uj55RllTHG3ZybOZMUq0VYlroUI3+wKhGaJZke5/lSJtS6F7ChBT9
   3Zaz1pH48U+QdhuoSbd4GjPguNmT78GgKnNKgGTKYpwchyBgcOYzZKAmw
   c8uUXXiRFh1WqLhmg1GbG8T4+fMK10t7VAQ4OsJr0NWtxnJ1LI5bIWQWP
   PbUhGLzQLNBrnFdNbTvdCJvKEWJd+cjuJuguherDm1gayHWrWCvn4Gosf
   djjdbsWvKLZmt+/SY6JCuCzM8fD4U3m8zbr9MjTW+1a6stu/+7WqR39PI
   rT8xcMF6zWvJm88SudpNZOduQKeUv6InszKNSFqicoKxyC+JDTziTSiIv
   g==;
X-CSE-ConnectionGUID: XRHvCnVlTFm1uGQzKo/x2A==
X-CSE-MsgGUID: 297Hh+GJQ1ea1JEgwFiLSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69270580"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="69270580"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:50:30 -0800
X-CSE-ConnectionGUID: tNoFP4ICSBWKmntJpl0MSA==
X-CSE-MsgGUID: tQqSJNrySfeC4FOIAVNkSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="221848632"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:50:29 -0800
Message-ID: <08284d4c-b7fe-4f61-9928-0d9d3329e88b@intel.com>
Date: Wed, 19 Nov 2025 16:50:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/44] drivers/cxl: use min() instead of min_t()
To: david.laight.linux@gmail.com, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-18-david.laight.linux@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251119224140.8616-18-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 3:41 PM, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> and so cannot discard significant bits.
> 
> In this case the 'unsigned long' value is small enough that the result
> is ok.
> 
> Detected by an extra check added to min_t().
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fa6dd0c94656..17aec916e8cd 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -663,7 +663,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
>  	u32 offset = 0;
>  
>  	while (remaining) {
> -		u32 xfer_size = min_t(u32, remaining, cxl_mbox->payload_size);
> +		u32 xfer_size = min(remaining, cxl_mbox->payload_size);
>  		struct cxl_mbox_cmd mbox_cmd;
>  		struct cxl_mbox_get_log log;
>  		int rc;

