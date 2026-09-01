Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01884486BA2
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284795; cv=none; b=syEsh6nazNpd7Qi9wenoBkU5PpaI3dRdHO5QjtSa0ydrWUjAwC4+e5yW0O1D8QWOcG2oEuhvjcsLVyDvv7NNganZuER4jYUvk0VYom5eI1G5IKdcb1eQmscGzZvKuacZcfPbbY8BaQdfHQvQnldg2CAmbCBA7HEjn3wuaN85prc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284795; c=relaxed/simple;
	bh=RMuPpjBBPYCUBv+I2AhH9ucEwXwnWX8mocRcLt8iQaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGzBOwJals5HUFCSnVxH1MyDKyz4kka71ygfAbw2ek8qHUAZJFurBHWmOz/H52HEQmHr66JV1HUY1ssgEKjMPm6Mz/+3i8EirUzXeupy3UR4G3WJP0Jz8BQlrp7q9jTq97YZ+mYhHQr5YBzPqADQlsU7TUFsln2cPgvdRlWpybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7i73Rgf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7i73Rgf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788284794; x=1819820794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RMuPpjBBPYCUBv+I2AhH9ucEwXwnWX8mocRcLt8iQaU=;
  b=J7i73Rgf5CtJGqMSOYNHnmL7Bg6/JWWRk86TI2C7lLelehaw5JD//IhX
   BVwuNLwD77kOs4rIwmAx/GAeHHX0mBgLiEsGagcxcoFNppjdnSvUS2471
   nOM5PF0b7Pk+3T9hJ4R+ggHbSgSoFQMQBaIaoPhPR0M0N2aN4SAQ2/5hg
   Jpr9R7W2rFqZUrtGyaNJEOtzrBEvTXLa1dbonSTlklbd1fJdjJvSBdbLg
   KHlZQD3lMqA/h9dgHo0p9IG0mwZkJI601uN/3y2yRxm7Uq83cbzFISA86
   cZn8YgvbsQ4oASEtXpADJIe8AanwjYGFGJkzB1xGIcMoDyTssNFMX65yE
   Q==;
X-CSE-ConnectionGUID: aaOP0YsuTlaoNOK3nqGxPQ==
X-CSE-MsgGUID: EAtRElxcSEeWvjDTze7j+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100235271"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="100235271"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:46:34 -0700
X-CSE-ConnectionGUID: BEWU7UKxTZaSli7HHs05jg==
X-CSE-MsgGUID: ucm2IdKNTsmgKtZBVQcgyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="274436990"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.72]) ([10.125.110.72])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:46:32 -0700
Message-ID: <78b03d7a-f2a9-4056-bbdc-c621cae2101e@intel.com>
Date: Tue, 1 Sep 2026 10:46:31 -0700
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

Applied to cxl/next
b212e37113f8

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

