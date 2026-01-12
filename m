Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F852C029C;
	Mon, 12 Jan 2026 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233825; cv=none; b=XULdsSSOcCbSYw4CyeAe4azLpCZWG+VM3i9TPSrffpcYvXmaB3aIM1jz4iICi0Nr5A+jCWCOtxD+bNib7s7hlM2xnjp5bWiOsl/5wKWh9p5RDWOTyWRUlF/LbZbqh02SMZXiLmluNMF+22v40z+eibtudYgTksMje8hjrRGynFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233825; c=relaxed/simple;
	bh=bTgYVQ36vRV+SgPgfVQbFVw12/NnChrm4eNX5FHKvQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pA2I/xvZj1W1K1JdUkmCBtJSDdfWV0q+bn4En9kSZpPKfoT9cITXYXruN0kyKW7h0um5MVYMuG0o9Sksptg8AHdl4/XQWdJ2HCifmEYUnfuKuXvzNXZZd6Rfw2+zMEo+jmrtqPBpOOobESjW7Oi9rDO49tPH9k8QlCGZhbYIG3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/9FGWv/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/9FGWv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768233823; x=1799769823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bTgYVQ36vRV+SgPgfVQbFVw12/NnChrm4eNX5FHKvQI=;
  b=T/9FGWv/vskgZhSvEqUgA6XADlWi+ZEe5WYuMySqZRJJ4ueUoZwjSsQg
   qgTDW39cFmIaAVcQVRphocsYnhaK2Y0kxWiiBt8KxDCFgt9iozdOmG7Rt
   NWEWNkNPAtwubf4/WW7qf2IQDK0bFnS700P7RFyLxd3aimpzKbZgK4Oj4
   XiWU042cyv6HhN7luhDsU9SkUaWy1fdR+kG+WzmeJTSiwDyT8sxzCjfu3
   ExWiizwT6RRGXWoiTrJbzoZ00fMSgIdgm/+eQCK4sPIHXK/PhCuvcjVZi
   9GwBEH21pasqIKs9AeXfAIEz2FjfLh/PTPWU044vmiTELsZGw4EF9xmjx
   g==;
X-CSE-ConnectionGUID: 3Cld/zIlSCy6QKJd1cOzlA==
X-CSE-MsgGUID: kqYx7cmuTJ+t4y/pQEuwKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="92176792"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="92176792"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 08:03:43 -0800
X-CSE-ConnectionGUID: BtvHopU3SLScAT9WvV3TGg==
X-CSE-MsgGUID: ziR47CpARkSacdUdB/T98Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="208641988"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.139]) ([10.125.110.139])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 08:03:43 -0800
Message-ID: <24ee9955-518d-4254-a961-3bf6a2d90840@intel.com>
Date: Mon, 12 Jan 2026 09:03:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/hdm: Fix potential infinite loop in
 __cxl_dpa_reserve()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260112120526.530232-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260112120526.530232-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/12/26 5:05 AM, Li Ming wrote:
> In __cxl_dpa_reserve(), it will check if the new resource range is
> included in one of paritions of the cxl memory device.
> cxlds->nr_paritions is used to represent how many partitions information
> the cxl memory device has. In the loop, if driver cannot find a
> partition including the new resource range, it will be an infinite loop.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to cxl/fixes with Fixes tag fixed
d4026a44626490dc4eca4dd2c4d0816338fa179b

> ---
>  drivers/cxl/core/hdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1c5d2022c87a..a470099a69f1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -403,7 +403,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	 * is not set.
>  	 */
>  	if (cxled->part < 0)
> -		for (int i = 0; cxlds->nr_partitions; i++)
> +		for (int i = 0; i < cxlds->nr_partitions; i++)
>  			if (resource_contains(&cxlds->part[i].res, res)) {
>  				cxled->part = i;
>  				break;

