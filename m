Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928833B966
	for <linux-cxl@vger.kernel.org>; Tue, 25 Aug 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672010; cv=none; b=erbB7RaAeFH/Osiv889byyTrSWWJXrZLh+23hHzgBxcJx1hdfNXkMiTqmAkAimNs0vvRrs00lmZLA+tVSol4WKfWn6QbtSChDtne/i7y0QkRS787Kb4m7JSFIyqmQPOWMwFsygHZtdotf1diMAnJXFUlDdaqkj/SxPDKn84xvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672010; c=relaxed/simple;
	bh=rmvn7MkQI6I22YjqiQetDR4kuEKixrSrzhw9XQRdH3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iS3qMlcbUitC+H6hIdFL+r7di1naVJ3xsreGajjOy77X0JuWTBGRNadbgT1hAl9oSdmkzVAtkDV0qXCEGfiKAxim5wMIZGJ8FEFFwUD6KYhj0pEfbvJzLQE4rrYcDb7Xjh9H1n+yaYis9sbbwkCrnC0q77LNKV50r9MXNWvjIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2t8NWI6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2t8NWI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787672007; x=1819208007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rmvn7MkQI6I22YjqiQetDR4kuEKixrSrzhw9XQRdH3M=;
  b=f2t8NWI6jt5H23Tk/wbc8rh9RbeZOWsQTsnJL6Dz5jEe8SKVuMUB4Rwo
   ox+Npp1XqgNxOQbrOhwuWiQtsjp6Jd1MLX+wTVin2G+vwjQjA4tnTipWs
   mIyUiE3vq2dLTrN5LXFcxw7bvuhbWNUBio9FgywndJV9VHN66ECqcCCsI
   um/IbvZWNLwDdrxaHsKHE6dvBn++IFjJsRrOC8GY7un1XC0jjtmXjA0GQ
   xe16PJQ0cpsJ+UsXn08hU6IVvB6QNcjzREg3I8oAUK5nT6qKmWzXJS87g
   uy1y1La6iUEYOuZuEJ2Ats6Ze31GgmKEwBLW68wgG6dOwevUre1mvcR3P
   A==;
X-CSE-ConnectionGUID: 01a8qh3hRHWhQUTCQ8bwqA==
X-CSE-MsgGUID: Ik6w60czTXGUZMW4l1MfJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88197554"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88197554"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:33:26 -0700
X-CSE-ConnectionGUID: szT9EScyTZih+Xf6hOPxMA==
X-CSE-MsgGUID: LfDC67t4S9WE4SNRFPW+Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="290846804"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:33:24 -0700
Message-ID: <63f81fed-931d-4a4c-b9f3-5421e0435543@intel.com>
Date: Tue, 25 Aug 2026 08:33:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Guard against a missing peer mapping
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, sashiko-bot@kernel.org
References: <20260821222515.2675707-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260821222515.2675707-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/26 3:25 PM, Alison Schofield wrote:
> When two endpoints share a dport, both must be mapped by the port.
> 
> sashiko-bot reports that a missing peer mapping could result in a NULL
> pointer dereference during region creation.
> 
> No caller can reach this today. Guard it anyway so a future violation
> of the mapping requirement fails region creation rather than causing
> an oops.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/cover.1787255388.git.alison.schofield%40intel.com?part=3
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..75b8092e6dc2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1367,7 +1367,8 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	/*
>  	 * If this position wants to share a dport with the last endpoint mapped
>  	 * then that endpoint, at index 'position - distance', must also be
> -	 * mapped by this dport.
> +	 * mapped by this dport. An endpoint that this port does not map at all
> +	 * fails that requirement.
>  	 */
>  	if (pos < distance) {
>  		dev_dbg(&cxlr->dev, "%s:%s: cannot host %s:%s at %d\n",
> @@ -1378,7 +1379,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	cxled_peer = p->targets[pos - distance];
>  	cxlmd_peer = cxled_to_memdev(cxled_peer);
>  	ep_peer = cxl_ep_load(port, cxlmd_peer);
> -	if (ep->dport != ep_peer->dport) {
> +	if (!ep_peer || ep->dport != ep_peer->dport) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s: %s:%s pos %d mismatched peer %s:%s\n",
>  			dev_name(port->uport_dev), dev_name(&port->dev),
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

