Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5B264638
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077903; cv=none; b=dMAGt7tqvirZByIQupLIK6Ts+Rds8ghU9KjJNbty007n9zSlDbaAvvqUV659jPCM3cH53Wi6uLpPvCpI1Q2CNuIUtw7fY04M4H0Ijo/S/Yi7gxGz2HuX13sZw1uAHIqdn1NS7uqEbbOb+ER6hOUOfJMHwG7uKu6Nqd9zUhlptlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077903; c=relaxed/simple;
	bh=i3Q3CuGdFFADBwB0oqo4wWNubJ8gV5Q9uMib1b58gpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjTz67czv+dmtcNDY01bP4MjFDUMr1qRwTxrQQJjHim2juD+MrCjKG8XFU2jjb1vjAGYM2mnRF8OVOfsGddKxpTGBG8pYIga7sx8H9oLbf6OvHhrV84m2zgMifYQlS4CcL17AgHO6S00Gje95Iw9NVXbDVQ0ip+m8tf22q6BC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TToYjoUG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TToYjoUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740077903; x=1771613903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i3Q3CuGdFFADBwB0oqo4wWNubJ8gV5Q9uMib1b58gpw=;
  b=TToYjoUGStH4oCreBeZot1ytVPB2yLHSAa3K2c9PbSBLPCxVbeXLd2vV
   hnE9pvtsYKUX5l0lSLqJcXAbXk1LGuXzL9PrPPfWJ3xeTtZFBWqHgDQAw
   QfGNP86OO3jqZPdjeK9WuleKxOGvjq60oKAiwV9kPpxvDl4GBxwXjWH/a
   B7m9K+1JZdlRLcNLX3IUYVdfhViBCkEJumptiOYzDVkswWdSYJv2CiWx1
   KASN/VZ6NVHLj6a0qc5Z33UjtrGVvLrbMB3F9+u/YhQuHNFfvqwYP51DD
   M31/o5sTC+1bLfEJxC00RHm1uEy3l0jiy8RaOhSTyNqSbKbBQhvObbDM3
   g==;
X-CSE-ConnectionGUID: ynXuBUHyRHGed3QiPIy3Eg==
X-CSE-MsgGUID: muYxNEG1S4K0jEGrKtQIzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44658054"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="44658054"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:58:22 -0800
X-CSE-ConnectionGUID: SuiXAHq2QRmRREf6Sgzxvg==
X-CSE-MsgGUID: YHtO3NA/S2OIx4Qxb91vew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120110514"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:58:21 -0800
Message-ID: <e50697b7-bed9-40e0-ac18-37e894029c94@intel.com>
Date: Thu, 20 Feb 2025 11:58:18 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cxl: Some ABI doc updates
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 ira.weiny@intel.com, alison.schofield@intel.com, linux-cxl@vger.kernel.org
References: <20250218224853.67457-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250218224853.67457-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 3:48 PM, Davidlohr Bueso wrote:
> Hi, Two small ABI doc fixes.
> 
> Changes from v1: - picked up review
>                  - s/Mb/MB in patch 2 (Jonathan)
> 
> Thanks!
> 
> Davidlohr Bueso (2):
>   cxl: Plug typos in ABI doc
>   cxl: Document missing sysfs files
> 
>  Documentation/ABI/testing/sysfs-bus-cxl | 26 +++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> --
> 2.39.5
> 

Applied to cxl/next
