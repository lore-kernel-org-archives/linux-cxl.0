Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537232E121
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790639198; cv=none; b=iQqU2P0ubxSEoWf0V4gOyRNxwEOg+CDpITTGGJ8vHVqdvPuJlc3wzXYN4rbNMCKlHKfKpyP3jV1m12sjtvEIgvvkdXPNMTtPwEyrFdf7OtHv92LHDzNPrYO3+C8V1DuA5yp7WAgsf0fUbn14X+6kYh/HYxed+S+gsyGlq6X7Myk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790639198; c=relaxed/simple;
	bh=UnXoKnmrtB/GAMsMV4mXcx8z4nSRtxmdaifJ+C13ln0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jccUdz1rZdBuyMl4/ALanDjCQ6JbF/QYfNBoMgf6WAhN/C5S4G1Z0HN76BpNSHW9hxsJL3ZX+W926I+xQZAHQyc+gFXgECWHFM2DAVnJu22FENJVEznP/rscTLOdSV9tyFuvVuaroEBPzixCd0J7dAtlehYVJYinPDM8U/gl8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cK2mkjtC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cK2mkjtC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790639197; x=1822175197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UnXoKnmrtB/GAMsMV4mXcx8z4nSRtxmdaifJ+C13ln0=;
  b=cK2mkjtCXoPmVB2CO569VgGtknNJ6gg6TkaKTDpoOF86UfAJMGS+4lfD
   yIoH2gaoecM95FszPNJQjEbZb0WAsiqRCWbG4iJQQCYG2B7/Gb2qqg1s2
   3Kg+8A2Fj7OnIdNP/gReE1uHBLF0GcW8UzjZjEcQgwZ0843+CT16V2/YI
   JbI/hPrzLzC5ER6OFa/0awKPVz8bkJ0HAqnC3WuCv65z35YGB8i2jIs/L
   EF6vAW+VDnnIXkfNTNdwZuqqIZ7xh+6ZAecwNt58kwfTW4kKhKunxHYKo
   0B/dbV+S4rlzrgW5AgCPYfpjkXxsraiuMKoHE+eTnEA3EkzqSxs6e7qzq
   w==;
X-CSE-ConnectionGUID: iiPAcKh4TKygO2HTCMBkmQ==
X-CSE-MsgGUID: eTeo1sjLQP22YqelU4k4Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="93841583"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="93841583"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:46:31 -0700
X-CSE-ConnectionGUID: gJvNcfkARw6EYatL8FtADQ==
X-CSE-MsgGUID: mpDx32RVS+C/IPv/roSu5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="283272896"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.79]) ([10.125.111.79])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:46:29 -0700
Message-ID: <a0146647-8bd1-4ca2-9548-d04174d4e430@intel.com>
Date: Mon, 28 Sep 2026 16:46:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/pci: Program the Port GPF timeouts before caching
 the DVSEC
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260922100026.3742401-1-kanie@linux.alibaba.com>
 <20260922100026.3742401-3-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260922100026.3742401-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 3:00 AM, Guixin Liu wrote:
> cxl_gpf_port_setup() caches the Port GPF DVSEC offset in the dport
> before programming the phase timeouts, and ignores the return value
> of both update_gpf_port_dvsec() calls: the function always reports
> success.
> 
> A failing config write is therefore not only silent, it is also
> permanent: the timeouts stay at the hardware defaults instead of the
> maximum flush window the kernel is asking for, and the cached offset
> keeps any later endpoint attach from retrying the update.
> 
> Propagate the errors and cache the offset only after both phases are
> programmed, so the next endpoint attach retries the setup.
> 
> Fixes: 6af941db6a60 ("cxl/pci: Update Port GPF timeout only when the first EP attaching")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e31aad7a525a..1f470ab0df3b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -840,7 +840,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  
>  	rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
>  	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
> @@ -850,11 +850,17 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
>  
>  	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
> -	if (!rc)
> -		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
> -			phase, GPF_TIMEOUT_BASE_MAX);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		pci_warn(pdev, "Port GPF phase %d timeout write failed: %d\n",
> +			 phase, rc);
> +		return rc;
> +	}
>  
> -	return rc;
> +	pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
> +		phase, GPF_TIMEOUT_BASE_MAX);
> +
> +	return 0;
>  }
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport)
> @@ -864,16 +870,22 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>  
>  	if (!dport->gpf_dvsec) {
>  		struct pci_dev *pdev;
> -		int dvsec;
> +		int dvsec, rc;
>  
>  		dvsec = cxl_gpf_get_dvsec(dport->dport_dev);
>  		if (!dvsec)
>  			return -EINVAL;
>  
> -		dport->gpf_dvsec = dvsec;
>  		pdev = to_pci_dev(dport->dport_dev);
> -		update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 1);
> -		update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 2);
> +		rc = update_gpf_port_dvsec(pdev, dvsec, 1);
> +		if (rc)
> +			return rc;
> +
> +		rc = update_gpf_port_dvsec(pdev, dvsec, 2);
> +		if (rc)
> +			return rc;
> +
> +		dport->gpf_dvsec = dvsec;
>  	}
>  
>  	return 0;

