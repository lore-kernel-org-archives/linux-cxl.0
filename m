Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5561836CE
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000286; cv=none; b=hhIrpNC/KQwO4hj/sHmfqR1qUUYFwQZ1nB0FrRLVBF2pjOgaU2NPg6edT+2vOxUJ73ek+3FFjcWOy3qyOJo2qBFE0PcSSRQXFIEEih2fllv6qlu/uQobMoXIXtLZGLkR/6dvhUSErDjH7UOOjQfZddOh/7SolBBZans0poT3Hr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000286; c=relaxed/simple;
	bh=O3E0k7DMbTHO4ChGNtSq1NdKaLHCPYhR2hkoiOb4Vkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caxynZ4UVmLa1tkzoZe/LKEZO59sm9lphOlTUOWiUiiwPKZUIuI8nc3gGDaTXswSAOGY9awKcbtjJwmqqGFJ7qNUJExcBj9aBVFLM/cQwRafiaDRXT7yEWtHCXEhi3TKQBr9oA5Nt4G47x6dP//uPm1wJhLUV8tZ7B3TBSqUyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hfu9v6xL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hfu9v6xL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717000284; x=1748536284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O3E0k7DMbTHO4ChGNtSq1NdKaLHCPYhR2hkoiOb4Vkc=;
  b=Hfu9v6xLlfHG5+DGCQ/jeHdjMsNTvSxZWCJ1W5UL1fJ9lM46GC0ppGeA
   XVC969AJhLnnK6aDUgakYlolzl+PVy4FbdwrvGxIoB9MIZ5xtBX0N+AdV
   1yF3iS3mc26GgBuDTMaJG/kBz4q26pkX88tvKsfXx1758oqcRarNkcOTj
   4KeGkIhyG1EpSfElgvGRpAM/ztkvaKXorxve7e61CIV0llU/eA/duSaRR
   zglJ/67DgKucVWRVRuAfbPfvBLBcpR/vlB/Xoz9X8wAe4roK4kYRZIyW5
   Cf75eU3aiZ2dLedeb6iZgH3vqN8QJg3Y8lhhsWmlP6f/LrG2Z8L7HKPsO
   w==;
X-CSE-ConnectionGUID: 51YJSYueS1a4cfvhe+Zr4w==
X-CSE-MsgGUID: L431R1NiQIOwKneOJbdmbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13370854"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13370854"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:31:23 -0700
X-CSE-ConnectionGUID: cwOzPLgaQV+k0whbb3YDcQ==
X-CSE-MsgGUID: 5XHUEeADTICjI0gsRqyt8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35575235"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.117]) ([10.125.111.117])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:31:22 -0700
Message-ID: <c2f43fa5-f5a2-4e18-b192-fccbc2792519@intel.com>
Date: Wed, 29 May 2024 09:31:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: the ctrl register should be read when it is
 being used
To: Foryun Ma <foryun.ma@jaguarmicro.com>, dave@stgolabs.net
Cc: linux-cxl@vger.kernel.org, rrichter@amd.com, angus.chen@jaguarmicro.com,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20240529093354.409-1-foryun.ma@jaguarmicro.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240529093354.409-1-foryun.ma@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/24 2:33 AM, Foryun Ma wrote:
> When the cap register and wait_for_valid checks fail, the ctrl register
> read will be redundant.
> 
> Signed-off-by: Foryun Ma <foryun.ma@jaguarmicro.com>

Please consider slight change to the subject and commit log:

cxl/core/pci: Move reading of control register to immediately before usage

Relocate the reading of the DVSEC control register to immediately before usage and
avoid unnecessary PCI config access from the read if DVSEC capability check, hdm_count
check, or device validity check results in failure.


Otherwise LGTM

> ---
>  drivers/cxl/core/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8567dd11eaac..627be83881e9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -338,10 +338,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  	if (rc)
>  		return rc;
>  
> -	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> -	if (rc)
> -		return rc;
> -
>  	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
>  		dev_dbg(dev, "Not MEM Capable\n");
>  		return -ENXIO;
> @@ -363,6 +359,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>  		return rc;
>  	}
>  
> +	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
> +	if (rc)
> +		return rc;
> +
>  	/*
>  	 * The current DVSEC values are moot if the memory capability is
>  	 * disabled, and they will remain moot after the HDM Decoder
