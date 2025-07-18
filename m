Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEDE2253BA;
	Fri, 18 Jul 2025 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752881245; cv=none; b=jLfViKFoZ6oS9Rg7x8jjjnfp+zTXQ/c6799TRF/NY69Yro447o7gwAO7gYf5gypo4csxrwcCpZNcWUxf3fOTBUNCMt9CnaUPuj3YVETFWjW7MEcH+CZeaU598eyUYy7sQNxZwEdb07d5bMxiNNIuvy1v3xf3KbbiCg1CI/Ysdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752881245; c=relaxed/simple;
	bh=7pa18f3UjzDAJ1eYgUFLIzCYRlxRZIqaHJgl0gEnP9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1rqx1esyVV94brru5Jb1y+y5vf4Tg7IMyOU0aUruY5uvWMbrz1A5MweZMBh2J3eTmNM+tO5KGW5zcuuBaxCJdFcyPL9tB5IfkHr47rwC3EoTfBOwTRxoVeKev7JckM+Au28lvrEFVBvTXFEIi9MqZ0bUeHbeW8yMmXBGnyDvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaNWn7dn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaNWn7dn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752881243; x=1784417243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7pa18f3UjzDAJ1eYgUFLIzCYRlxRZIqaHJgl0gEnP9M=;
  b=UaNWn7dnLKIICOfEW9nnaR1f+TwiM6rByxICHEY4CZgIFrGXtx+TzcWN
   Q6kWXcTbm/o9kE+NJhn6aXArmDwkQerAxPmRx0qJ9Mpa2jrKnuMeU5Y5N
   hbKR4w94/4tmvWRhb+vOjS11HA9Vc0tWuTdDoBFyY/3bV2g4BPwfgxa+d
   uoSl0zyNls8Kj2OBl66b/27S6YhDXQMJO5BlWeW5A1Az9CQKjB+YVTUvm
   /Xefz4OxUKuC1kaICBbMdPmToysxjWPZEMRqBvyt7ZDyXq399AENx/9nF
   /ulJIHwSzFzOFrTKlquOgjcz24XMgi9K41qFEIwDbjH2cE/OpKdwR9MqD
   g==;
X-CSE-ConnectionGUID: vDAeAotcSAanxN6I8OerVQ==
X-CSE-MsgGUID: i1X2xw/DSJOHE3Eax3rFbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54393610"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="54393610"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 16:27:22 -0700
X-CSE-ConnectionGUID: 4wHBjNFSS3K3XZGGri9akA==
X-CSE-MsgGUID: emJLTxEXRtmjvnLA7WgpCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="195398285"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.127]) ([10.247.118.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 16:27:16 -0700
Message-ID: <7d9e6df5-5921-422e-9ef8-4cef3f89b555@intel.com>
Date: Fri, 18 Jul 2025 16:27:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cxl/region: Fix an ERR_PTR() vs NULL bug
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Robert Richter <rrichter@amd.com>, Li Ming <ming.li@zohomail.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <7def7da0-326a-410d-8c92-718c8963c0a2@sabinyo.mountain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <7def7da0-326a-410d-8c92-718c8963c0a2@sabinyo.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 2:22 PM, Dan Carpenter wrote:
> The __cxl_decoder_detach() function is expected to return NULL on error
> but this error path accidentally returns an error pointer.  It could
> potentially lead to an error pointer dereference in the caller.  Change
> it to return NULL.
> 
> Fixes: b3a88225519c ("cxl/region: Consolidate cxl_decoder_kill_region() and cxl_region_detach()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks Dan!

Applied to cxl/next
49d6e658e758e42aaff8ae5ecdd2d06b29abf53e

> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f0765a0af845..71cc42d05248 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2108,7 +2108,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
>  		if (pos >= p->interleave_ways) {
>  			dev_dbg(&cxlr->dev, "position %d out of range %d\n",
>  				pos, p->interleave_ways);
> -			return ERR_PTR(-ENXIO);
> +			return NULL;
>  		}
>  
>  		if (!p->targets[pos])

