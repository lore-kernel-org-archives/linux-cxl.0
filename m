Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053F21324F;
	Thu, 20 Feb 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073570; cv=none; b=h9ulSGq9WT74KuICi5HTQbBaT19tRfHf28I1mcRxI8WEnni/9dyDNw7M5WkKVIvuW3lN1NKJkYqKtxm37ZdcmOfJfqJC6xp1Ma2xCAUVk1L9SDNWaaUEKJoKTU2htpZ2CdsjIUmRk20YydlRn/pYIUok66zPrHbulMVtuoxrf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073570; c=relaxed/simple;
	bh=Ndz1AhMQJxf/vpfOi3X2uISTFtPQQoDdhovYdkguK1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sky8xuSYWs213d/O7CbHTV5FlYHxBYSzdjzei6U4WEIefz2zKtqJ63MUJo9/7V/Syl7obwNiO9bgIxSblVtuyodM4NqCDN1VoAC5wXvf7RLuzy6Ekz1qIWljzvHjGfWGLy/1ZWijhd5jdoD/Vf/tJ+jfKcyUUktAyR1bBmu1Wmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyiGtsSx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyiGtsSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740073569; x=1771609569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ndz1AhMQJxf/vpfOi3X2uISTFtPQQoDdhovYdkguK1E=;
  b=GyiGtsSxOy3C9bIjhP8PCrgqg3lvoMblCHl9YDmejw/jKicBiUDD+oQa
   276Fv3i7jlsKDP6sBQdT9Mw+KrU+WHFQqxInR+bTJOBg4N5f5uBIkJ+kE
   uTSz+H097QSgG2319xGAlxL86O0vOYepnRQI6uOjIlSnP3ySxMxPrOuDB
   wVa2msjnf7uutjLnzirRqp3K5JFyQfcNQY81bGBiR1EuFAED/uzQt0OPL
   u709uRgnYAzMxiw5bhZ0OmgyDsOSkFAPFTnxjQF+lb0XMUAIh8cjYfIUn
   7qNinKjKshOT5P/3NqOAm0II5aKXGxt78oLLygzyN5r6hbNE8/QpmYUzA
   A==;
X-CSE-ConnectionGUID: s1ogsvEvS8+rDY5IQ8PtaQ==
X-CSE-MsgGUID: 3M+FBuhsTR+DerhS3r0mmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44650459"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="44650459"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:46:08 -0800
X-CSE-ConnectionGUID: RwNAgTMfSamLFmZx8BdcsQ==
X-CSE-MsgGUID: p12JbVWhRXOcLCOEXeZiHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="145967440"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:46:07 -0800
Message-ID: <98940e54-a4da-4362-b137-75580da4a2fe@intel.com>
Date: Thu, 20 Feb 2025 10:46:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/18] cxl/acpi: Unify CFMWS memory log messages with
 SRAT messages
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-19-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-19-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
> CFMWS entries have a similar importance as SRAT table entries to
> describe memory regions. For CXL error analysis and memory debugging
> information of both is needed. Unify output of both messages to
> improve logging. Change the style of CFMWS message according to SRAT
> output. Also, turn messages into a dev_info() same as for SRAT.
> 
> SRAT pr_info() for reference:
> 
> drivers/acpi/numa/srat.c:
>   pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3e75e612cbc4..93c73b163c28 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -447,7 +447,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  			cfmws->base_hpa,
>  			cfmws->base_hpa + cfmws->window_size - 1, rc);
>  	else
> -		dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
> +		dev_info(dev, "ACPI: CFMWS: Node %u [mem %#010Lx-%#010Lx]\n",
>  			phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
>  			cfmws->base_hpa + cfmws->window_size - 1);
>  

