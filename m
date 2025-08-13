Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D31B4248;
	Wed, 13 Aug 2025 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043329; cv=none; b=JHOUCR7KzX5btppIYIGpxFkq9BkRmdSKu5kubo+dA3uAjYouFUR46NalylUiotyMRr0Y12smajYk3chSPevvGpRvJDgjXwr2LFR183yZVtVir9TQPjF6h0iD911Bq18/2M3SNOqDTQGb/4nZMl1aFESNABuZ22g/LnWI51GHDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043329; c=relaxed/simple;
	bh=fFWkenXhNI0YA0ZR3uSv3YEzOtHv0+yKxUhrs5e2Df0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIQFq7MyjuClErL9uMmC+3rOnZOG8Y26uU5Pxjr8LBtGBFVu8xjjldvR4oG8vZg4XroYrb0MTK2bLSMLcODsd0p661KDTpQgacBtPAJOIG+38OIM4vmKKk8h1kgv6cMYiNsyXFbrxLdTqPiaDiA//qByeiKVMaU/Q8dmCXTIvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBMx04bQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBMx04bQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755043329; x=1786579329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fFWkenXhNI0YA0ZR3uSv3YEzOtHv0+yKxUhrs5e2Df0=;
  b=kBMx04bQ4Ys7uC8bj5uXbUuy6xckwuoPHhPiep+g+EobrvM67r2uZUdF
   /OTlxBiBfSalHPE7STm75F3FSSMB5xaBk3/tQLNZqjDYLlt2rAcxZ+rsu
   Phr2ipcwj3NBq9/wd2UdDxxS9X+fnHA8dyNd2EMtHahff3/ktE5yJYg1s
   Ku3Ve/38jQ7T619Vv0y8eu/+L8C+JhOZszgnbR0wcy1O/rW5KBeHtkjDh
   o651JtETJgz0qQXOGIUuqpY3rd5BSaL+t5MMRxRv9crwqqhZswmh6jT1E
   EbaD/Kcd5q5IvNfoTGte867iKSj49m9KIUHaZC5TDYxbm/SuirQnm90sb
   g==;
X-CSE-ConnectionGUID: W47JAtx6Qri4gSW6Sg4pOQ==
X-CSE-MsgGUID: NxMBtH4xTUSt0poqS6NeeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56538056"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56538056"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 17:02:08 -0700
X-CSE-ConnectionGUID: N7UT1eQsSkWulp66DhhBJw==
X-CSE-MsgGUID: BVIbH7fRS2mqUdZTzI3Tqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165952263"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.149]) ([10.247.119.149])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 17:02:03 -0700
Message-ID: <78ebb53e-5cb3-4a6f-b2da-dd37e952a333@intel.com>
Date: Tue, 12 Aug 2025 17:01:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Use str_plural() to simplify the code
To: Xichao Zhao <zhao.xichao@vivo.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811122519.543554-1-zhao.xichao@vivo.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250811122519.543554-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/25 5:25 AM, Xichao Zhao wrote:
> Use the string choice helper function str_plural() to simplify the code.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
applied to cxl/next
22fb4ad89885

> ---
>  drivers/cxl/core/hdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..37176c0a781f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -197,7 +197,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	 */
>  	if (should_emulate_decoders(info)) {
>  		dev_dbg(dev, "Fallback map %d range register%s\n", info->ranges,
> -			info->ranges > 1 ? "s" : "");
> +			str_plural(info->ranges));
>  		cxlhdm->decoder_count = info->ranges;
>  	}
>  

