Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC54C8FE6
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646763; cv=none; b=e7jdXSU0toboat5F2ONYHUnHupwgtf6mHQYMJiujlmc0qU3Rd1HnEBY3p6xN4E21vgu9OAHUJKZ+W2Ic7BZHAGhM4K8vs/N5lEF5gerM4g34V6tMyCsz2zaAQPxOFRVr80yS1sOwvoGcdZ7lxqVrzEBnZd9W8xjjfnrIUbhlBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646763; c=relaxed/simple;
	bh=Yb0MBIMcMi3KyEoYDSOd5KKAUPnrliUZ5FAk75kwyzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gba/w1JycSGXS3oC0b/rjiZs1LdcJkXU56loXWyRtc28QaZnQ2DKtt9jWtaysS3yLPiTKPP5hEpGVynlzKpMEalU03mv9MQumYnx0KX2YZqRthmNzA8BehQTS8PrbsFLpZj4tXDMgfHPWv51VaizTO10FvhX1V5gdgeEK/U3724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMYCzXTT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMYCzXTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784646762; x=1816182762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yb0MBIMcMi3KyEoYDSOd5KKAUPnrliUZ5FAk75kwyzk=;
  b=eMYCzXTTzOaeVMd/L3BckzZQaKM6IhF897U1QXJzcWzbGVLTBOg1FDs7
   tFm1LdpFgnFOb9SBa9V6CBLcULfq7XFaau/KsFo0gCiZnR2vp41CpG1cv
   AaHTQrYcpBzq6Qdf0KyDqY5qTBc3EWiSi6Y4LJf/WQ3fxk0/9Zi/EOxc1
   j+Xl69i3PrH69VnowAISWZLBaYpCZz20wt77ac2AxXKRd0marT54joZHK
   wlT3f5KvqZo/OkD//2MFIMV72lIvf3Yhk10ONxnio5iQS8O4Jra10NBor
   viTjdH1P+pPq5aGNAiy0jTI/HmnF7JMr+7Clo4NC+PVVwzvZKt16OWRDl
   A==;
X-CSE-ConnectionGUID: ByrX32jfQTuozjoa8p7j2A==
X-CSE-MsgGUID: CKFe/j9FR1myV7NivEJUAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="72789284"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="72789284"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:12:41 -0700
X-CSE-ConnectionGUID: fYaIqoXqQW6u0teoQHIjLg==
X-CSE-MsgGUID: EygEhQKpRDmW3iTWIwvzKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="257239555"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.244]) ([10.125.109.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:12:41 -0700
Message-ID: <45af7537-5cf9-4673-8b18-6169ee214853@intel.com>
Date: Tue, 21 Jul 2026 08:12:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] cxl/hdm: Restore commit_end when decoder
 enumeration fails
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <3b2d66e380cb00b1365911a59f32739580d82563.1784595445.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3b2d66e380cb00b1365911a59f32739580d82563.1784595445.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/20/26 6:59 PM, Alison Schofield wrote:
> commit_end tracks the highest committed decoder on a port. It gets
> advanced before decoder enumeration is complete, so a later failure
> leaves it pointing at a decoder that was never added. The next probe
> then rejects decoder0 as out of order and enumeration fails.
> 
> Reset commit_end to the none committed baseline once the decoders are

s/none committed/uncommitted/ ?

> torn down, so a subsequent probe rebuilds it from scratch. Register
> the reset before the decoders are added so that on unwind it runs
> after every decoder has been unregistered. This prevents commit_end
> from dropping below the highest committed decoder still registered and
> exposing an inconsistent value to a concurrent reader.
> 
> Protect the commit_end advance in the DVSEC emulation path against
> concurrent readers, matching the register-programmed path.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/hdm.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 077aface1a2a..7d4ba7fa30fa 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -955,7 +955,8 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  	 * change the range registers at run time.
>  	 */
>  	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> -	port->commit_end = cxld->id;
> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> +		port->commit_end = cxld->id;
>  
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
>  	if (rc) {
> @@ -1181,6 +1182,14 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
>  		msleep(20);
>  }
>  
> +static void cxl_reset_commit_end(void *data)
> +{
> +	struct cxl_port *port = data;
> +
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +	port->commit_end = -1;
> +}
> +
>  /**
>   * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
>   * @cxlhdm: Structure to populate with HDM capabilities
> @@ -1191,13 +1200,21 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
> -	int i;
>  	u64 dpa_base = 0;
> +	int i, rc;
>  
>  	cxl_settle_decoders(cxlhdm);
>  
> +	/*
> +	 * Reset commit_end after all decoders have been torn down so a
> +	 * subsequent probe rebuilds it from scratch.
> +	 */
> +	rc = devm_add_action(&port->dev, cxl_reset_commit_end, port);
> +	if (rc)
> +		return rc;
> +
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> -		int rc, target_count = cxlhdm->target_count;
> +		int target_count = cxlhdm->target_count;
>  		struct cxl_decoder *cxld;
>  
>  		if (is_cxl_endpoint(port)) {

