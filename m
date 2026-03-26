Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038423507C
	for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560750; cv=none; b=T+2hn6Uk96y0xffrFvoYQK43o3UjpVJwsxRydhdwMkcsDjIYjr0OO8AahMgcDpfzeT7v4VVynXOkyBlgnj5F1748PzYIMkB6ADbAlgpWsRCZeklM/pvdONVCsurf7QV3WCI86f8zQi6xtMxdI0lBnpxvpkBwlSPkZUO+/0y12HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560750; c=relaxed/simple;
	bh=PZo8IvLothaqhZuuO5et+JzGO5HZuXofWJxt2I3coTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dODPq9YsizM2kx7QtIJRvvrqa7XjCowThXpE9tWGfcoxux3txgRKpwrepV2a+tMPe4+S5uAE9DkjNU+9ed48bBnlkznXxsxsu+SHq8axvV57quM5mtNcByj5Q8W66AgwZAC/4A9bIn+HCSg48j469HffCdER+TCaancQBOj6EUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bO72o9i3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bO72o9i3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774560749; x=1806096749;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PZo8IvLothaqhZuuO5et+JzGO5HZuXofWJxt2I3coTk=;
  b=bO72o9i3K7KWrHCrRPL2Af7AgfJmq+wrDv+dzfADVK+oyUmkLyjR7Em5
   5g92GMrS+hAbTH3zaCDRuSluZv22IzbD6HHQF58+iujFGMaCr6jbeDdnk
   x2SpCTIiE172qJUgbYrVNTI119LRBfVtEcWXdat2o9nCY8GZngevBbVpU
   nI50G/pTBIAPvYOBMFN4VXSeZNY8GjBnMnY+NeGGhPVG4+F0AV2JMD5WF
   y+ajDGaVp7NLfei4RJskpWMHcKcWQDqrNs0AmFtHwikHrEhQbmKezUJJ/
   1n742AuixDxRQY1FhLa6C6hkCND9Bt3tCZiBK9H+5/WpZXnnBcybGIBfb
   g==;
X-CSE-ConnectionGUID: xjB5dLizT9Gn3dLGLm4HPQ==
X-CSE-MsgGUID: 86FmpivATNeE9tV78+ydqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="78229227"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="78229227"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 14:32:28 -0700
X-CSE-ConnectionGUID: mwTPal+lQD6fAAQXiOF/Zw==
X-CSE-MsgGUID: u3c3fiZET+CboCOtvlOrHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="255617992"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.122]) ([10.125.110.122])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 14:32:27 -0700
Message-ID: <594e2663-06ff-44c4-8420-f00b788290cc@intel.com>
Date: Thu, 26 Mar 2026 14:32:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add CXL_PMEM as dependency for CXL_ACPI
To: dylan.eskew@candelatech.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20260326211441.83573-2-dylan.eskew@candelatech.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260326211441.83573-2-dylan.eskew@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/26 2:14 PM, dylan.eskew@candelatech.com wrote:
> From: Dylan Eskew <dylan.eskew@candelatech.com>
> 
> Prevent a linking issue against CXL_PMEM when CXL_ACPI is configured in
> Kconfig.
> 
> Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>

Hi Dylan, does this commit fixes your issue? It's in Linus's tree now.
93d0fcdddc9e ("cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate mismatch")

> ---
>  drivers/cxl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..baf1d17ec0fc 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -58,6 +58,7 @@ config CXL_ACPI
>  	tristate "CXL ACPI: Platform Support"
>  	depends on ACPI
>  	depends on ACPI_NUMA
> +	depends on CXL_PMEM
>  	default CXL_BUS
>  	select ACPI_TABLE_LIB
>  	select ACPI_HMAT

