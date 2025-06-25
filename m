Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE5262FDB
	for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866712; cv=none; b=Oyhc2eAWzZTUCR+Qe2AW77//ur411ir6C4yPIym8AyKjodvpxsQSYqLLtbfNTUEycJHeyf6nMRd/UyhcfuOK70AKFL/NpCkSqHidknjeJf5MeV3XruKH+FxC3Q+XbJwRdL9iG6l8zmc/5FDTlj9GW/Ct/rTOCEQIBJw81pMiv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866712; c=relaxed/simple;
	bh=BRWGRa/2Gya7zFdvsXBM7wjK8RcqDXeEvdG/kmiCNFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F8mPW479IHv708589KoFNKQ7kR2pret/+ezlzf2Nj+juaXh+vs3YqrnFXMsNzWG/qmfeUH7ljQ/yZJzyONQWUouon0mncyYDY4ROjOoXnNJX2BJQiRHg8uO8kNoXRPjde8rMJDbIUue8yDpRLeNOU3Xy+UT1Y/NDD8No4t4bm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/9BGylJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/9BGylJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750866711; x=1782402711;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=BRWGRa/2Gya7zFdvsXBM7wjK8RcqDXeEvdG/kmiCNFs=;
  b=B/9BGylJHOK4e+sP5riPyteSp9hh+2tgYpTJNFOWeKn9lqkHh9bw7sFP
   +Csdiko1fSF77RnPsHrCd2h6ekUuYP6mQIEJQ34WUwzKmriaJb2JUtVJQ
   uOJMUTHSeQuABld7TCZDeYhMtEaloTd1C9ANEyp6Avq26aliDK+fjpGxJ
   +WLtiKhAYK7kNvIwwWq5xKEtNmhqWgOUOXgGzqaKTAB+8T1FwNI0k7FlS
   XFlkTmN0MOU+zx8LvOZw0cZAD+sHf3GcK1ZU1JLqvJR7YlzppyolMMnQf
   XwHKXXZzWlunKgAvgVeKkz8QaLIahUNE9uZe4VgJkabuMwE8tzz6CxjFY
   w==;
X-CSE-ConnectionGUID: J5j4FnSLQr+aI2rwqF2voA==
X-CSE-MsgGUID: MU6BwyZJSk2ih1RfPHru4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="56929070"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="56929070"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:51:51 -0700
X-CSE-ConnectionGUID: vqA/ZRHZTTSt750z8UjiLg==
X-CSE-MsgGUID: FAjTh/8MQ4qmKoWyAjh+fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="156648680"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.5]) ([10.125.109.5])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:51:51 -0700
Message-ID: <c44abbdd-21a0-4cdf-b934-8cf8adbb8224@intel.com>
Date: Wed, 25 Jun 2025 08:51:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/edac: Use correct format specifier for u32 val
To: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-cxl@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/25 11:39 AM, Alok Tiwari wrote:
> The dev_dbg() message in cxl_set_ecs_threshold() used %d for
> an unsigned value, which could lead to incorrect logging.
> Update the format specifier to %u to match variable type.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Applied to cxl\next

> ---
>  drivers/cxl/core/edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 2cbc664e5d626..76cb016e0bd9a 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -693,7 +693,7 @@ static int cxl_set_ecs_threshold(struct device *dev, u8 *log_cap, u16 *config,
>  				      ECS_THRESHOLD_IDX_4096);
>  		break;
>  	default:
> -		dev_dbg(dev, "Invalid CXL ECS threshold count(%d) to set\n",
> +		dev_dbg(dev, "Invalid CXL ECS threshold count(%u) to set\n",
>  			val);
>  		dev_dbg(dev, "Supported ECS threshold counts: %u, %u, %u\n",
>  			ECS_THRESHOLD_256, ECS_THRESHOLD_1024,

