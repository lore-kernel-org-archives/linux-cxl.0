Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DB1DB125
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656445; cv=none; b=FU/e3vAYMLgRnLSSk7csL5JiI0s7crRm4CqTBZhs4RaAX7PYPZHigBEHjJIorvw7v0xIpmf2z8hF0tcb7p3i+z9zJQTBn3nyxnDt1bnc4ipFNhBM128jLXdTmxGr87S01oUR5Nqej6EV95u6q0NngIg5Ta8EAN/lr9RkHaWlnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656445; c=relaxed/simple;
	bh=8+zTcm/JS+/uQtWbKk1PvsOZvqRtVhMczdXgf32B1Ic=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WF5XJsVuuREoIrF17jS5G1S1w1SsekOE3T8PyQWDWMwfeFKnTC3DN+lhZBscCX7WyvY2l9HAWvDD4M1VBo1wKrpECZLv//xdtO6MXNWpOhK5qImEQASKGQuXuCrUWafY1OIqtbDJeDWHXnMsAuVF7Or7pnPCHVs3Ehx0+AKKSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loliAGfQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loliAGfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749656444; x=1781192444;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8+zTcm/JS+/uQtWbKk1PvsOZvqRtVhMczdXgf32B1Ic=;
  b=loliAGfQxqU4TwpR3lilRBLjR9ITb0tB1j/L6TaSfIILKiWjehXZlsqp
   NdLiceNg1qJ5raBqHM9t+mtZZal0rvOEidUGW77NZkEXEMvKCYaIv21kG
   6jAt4JdltpYkDfRUpxAh75tkX/rkgQWpo/R8kYySn/CR1sSsxRMeiBOht
   cO/GTljU7odlnK2hAkwBzEcrPeyfbCo7qcBuQtii4GiGiI4He0M0Q9sW1
   AEc9C0yBUCleguC/A1DoePiHwKAJEIDnPr2VFehOqmdu1W5B52FSZhFAz
   Xs0goHoGU4k0LbHB2Ig4Qf+GWjI4O/Y7LvAIGqZIlJpRWbBQc3cbtxxtt
   w==;
X-CSE-ConnectionGUID: Azzhqsg0T2CnCgOGUKR2aQ==
X-CSE-MsgGUID: GW/ofR0uTVGBUtb9qdJKxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62417459"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="62417459"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:40:43 -0700
X-CSE-ConnectionGUID: gdxrLrDPS8SyIPsmDD5JJw==
X-CSE-MsgGUID: nBuecz5KR52bsDV6tWQE2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152505441"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.168]) ([10.125.111.168])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:40:43 -0700
Message-ID: <ba4ed993-539e-4ad4-b85b-afd0416166b1@intel.com>
Date: Wed, 11 Jun 2025 08:40:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add comment about 'cxl_root_decoder' and flex array
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250610175401.172660-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250610175401.172660-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/25 10:54 AM, Dave Jiang wrote:
> Add a warning comment for 'struct cxl_root_decoder' to not add members
> after 'cxlsd' since 'cxlsd' has flex array at the end.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
> ---
>  drivers/cxl/cxl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9a17e8beca7a..68596e9216f3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -445,6 +445,7 @@ struct cxl_root_decoder {
>  	int qos_class;
>  	const struct cxl_rd_ops *ops;
>  	struct cxl_switch_decoder cxlsd;
> +	/* DO NOT ADD AFTER THIS POINT, cxlsd has flex array component */
>  };
>  
>  /*
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> prerequisite-patch-id: 77982cd1ed494cf0f747ccf74c6b8949be9837d6

