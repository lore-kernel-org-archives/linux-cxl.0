Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85D17A2F6
	for <linux-cxl@vger.kernel.org>; Fri, 23 May 2025 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747980028; cv=none; b=hnqJ7r+lP2tjf+FMU7s5qt+T5KFH2AaQPcDYWHRbMFwZbnPRVWu6YhbX0fJRTIn5i5rea+h4p8w8o90HDjgwYcpOCTFizVKowVKqtHgl6zP4NzUPwMFt6pK2ZzJL0IKW0w+Dm12dtOgxQS0S01nWkTrL9eiRrQtLM+Wyi7I+BY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747980028; c=relaxed/simple;
	bh=O5q9Sg68tfPeHqMn3mC/eaNSosBn6I+CRfSPGfxGJhs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZvGrOdAgeJRNvnngPfKk/4TNfGwLnxQWav5NH3ZyI40SWEx9r3s83x0p2JPGRezSs3R3ohV0Y1mL0JYRjpNfehDbXljSbhNIMwIzvltJJwoIqRWknI6N0KH86Dz9JBx+pqpevCSqRRXrP9ubLH2B1QfyA6WhgjhPa/RPpERby/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZiF65a+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZiF65a+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747980028; x=1779516028;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=O5q9Sg68tfPeHqMn3mC/eaNSosBn6I+CRfSPGfxGJhs=;
  b=iZiF65a+d1qpYt4PbisTr6qJLL+aI+yP7+UR+L0f1ciUG/HW6kPqALsn
   DyjVGMR1Bc9IZ/CWiAl632zqBYoq+F8t3rXH/upGKTKg9zM+S0YXaURyR
   uHzRlacWGTG/RxDvHXbUGK5iERZ55bqFAKcIwT9O3jAv6O9tCRmPBMSCd
   KVI3AbU0TpdOmtp0zZfHQP6sD9cKXXAR6aNLrEsbBp6rVhm9MZsxJ8xo8
   /WMfW+HZryGkPNVjhEjyGzGgglNxWOWF5e96iHJJK0bMGza4kckr/+Hw8
   B6t7l/hPThZhu9S+Ji11hizSTfkFFjdSeaFTsIzIB9qzZveHF22EaORuY
   g==;
X-CSE-ConnectionGUID: xVZ2JD+HT8KqE8nYiA92MA==
X-CSE-MsgGUID: 2NmCgUtpTASZ/o9ic6jK5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="67441354"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="67441354"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 23:00:27 -0700
X-CSE-ConnectionGUID: WSDZx+J2RT6NwkW4yJxQhQ==
X-CSE-MsgGUID: KZnp0lF9S7atk2jTurRIvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="141398279"
Received: from lamonsox-mobl1.amr.corp.intel.com (HELO [10.125.63.139]) ([10.125.63.139])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 23:00:24 -0700
Message-ID: <d4ac98ba-bfea-40b3-a7b2-99e1bac5bb41@linux.intel.com>
Date: Thu, 22 May 2025 23:00:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marc Herbert <marc.herbert@linux.intel.com>
Subject: Re: [ndctl PATCH] cxl/test: skip, don't fail, when kernel tracing is
 not enabled
To: alison.schofield@intel.com, nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20250523031518.1781309-1-alison.schofield@intel.com>
Content-Language: en-GB
In-Reply-To: <20250523031518.1781309-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-05-22 20:15, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl-events.sh and cxl-poison.sh require a kernel with CONFIG_TRACING
> enabled and currently report a FAIL when /sys/kernel/tracing is
> missing. Update these tests to report a SKIP along with a message
> stating the requirement. This allows the tests to run cleanly on
> systems without TRACING enabled and gives users the info needed to
> enable TRACING for testing.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Noticed this behavior in Itaru's test results:
> https://lore.kernel.org/linux-cxl/FD4183E1-162E-4790-B865-E50F20249A74@linux.dev/
> 
>  test/cxl-events.sh | 1 +
>  test/cxl-poison.sh | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/test/cxl-events.sh b/test/cxl-events.sh
> index c216d6aa9148..7326eb7447ee 100644
> --- a/test/cxl-events.sh
> +++ b/test/cxl-events.sh
> @@ -13,6 +13,7 @@ num_info_expected=3
>  rc=77
>  
>  set -ex
> +[ -d "/sys/kernel/tracing" ] || do_skip "test requires CONFIG_TRACING"
>  
>  trap 'err $LINENO' ERR
>  
> diff --git a/test/cxl-poison.sh b/test/cxl-poison.sh
> index 2caf092db460..6ed890bc666c 100644
> --- a/test/cxl-poison.sh
> +++ b/test/cxl-poison.sh
> @@ -7,6 +7,7 @@
>  rc=77
>  
>  set -ex
> +[ -d "/sys/kernel/tracing" ] || do_skip "test requires CONFIG_TRACING"
>  
>  trap 'err $LINENO' ERR
>  

Reviewed-by: Marc Herbert <marc.herbert@linux.intel.com>


