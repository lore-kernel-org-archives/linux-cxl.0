Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315324;
	b=v31DapENHo+KrqW3HOmcbVpDrR5+3ZzjmFlN13i/Y2qAMAeHq3vg4J1OymBcM6seaRL7
	 n58I7zi3E3PBWhvoP3kovFJnA62Y3zALNQvtqqkCyUw4Kf0PaFcRe8w33Rmi57F868J11
	 wIESQOBqOiKhNPxbg9kx94lRDhLRdp+sJ692jLKGAqaKXX1uPjop9tpxhdFDDDqPjXXmZ
	 BSU0wS/yUO8BKGLxshFh/gahZeH5n38wQGCVNLVBTfSzcrrYbLP//r9A40NhVA+QcDPV5
	 Kb0D7F2fIvF/ZvGRg/WhJWx+57WOW/ZAhE/V+X1TGYa7oxuK9nRN+pzsXypR9mnX1ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315324;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8W9N3Va6V9hf9+SWEhqbaOMJ3vEqwZGsFvwonV413mY=;
	b=zyI3E4vm2ZqM0JEcgn0RGh4utoFahoRTDYfoc+k333eQ9qR+SqrihOAz15uLnFKz+Mx6
	 TrBq2V4STQ6+dTmymgPmJ4ZzmDzPxM4947Zc/6lHRDKJSXKpv85sD7aZZQriEbc2Dxuq8
	 4riuIdCeHHlZPaYtuCJTviZ8/yZLj050xV90vxlV1lEj1V4GO+cB4AGvJrv4BtalZz44J
	 f3Ah26qmq57AKz+5FGclJpDbYt1unFaOb1Hh1vJfJxcWI9LmUNNYcWRETZYf9ec6YFs5I
	 93CVtMdGSzxHTadRAZ8/7Z0qCiyWspYNIg9oQJrDfBvNk0lkZM5sulwcnM+IjZ1+Y0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=inQRgjt3;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD6606A31C
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 23:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48FD6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=inQRgjt3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793315318; x=1824851318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3FXnrAxQVHkKm3z0R6eNgTZompzDhkgAZF1HXUYduu4=;
  b=inQRgjt3DA6fNAmcRVtz11TQ+nURiUpkQJGfom5N027OSsbuWNNF6+uA
   qsoIRSrJMXki7f9pmf+aqQ2GUCBYORghiBVbeTRAZBjvQq1d/BSPZ3T71
   MKOziG0LzBo9r7iwCELg0qOhWtUSF8uuSOu0V75+P5IeD12UhfJVvtcNm
   zRFV5sxACTAnvDyXSGnRLViSU+7lS9dV4KQdRH+wecfBLNAV6RAdoYRxS
   AA/m4c1e6WmiK5kVMAvep1/KM+71sKDtCqwaH6O/+/6C0bU43R/J5QOVi
   obFjf0rlAnhrO6wfH7+4RRyjmFVMdXA6iHRNz/RE5oFDMC7+9Nze0s0pL
   w==;
X-CSE-ConnectionGUID: G1jd3GDVTvCAOdis54DPDg==
X-CSE-MsgGUID: eiDhE+ILR76o1ZWAIyjtVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1966807"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1966807"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:08:38 -0700
X-CSE-ConnectionGUID: GiSFWD+ySzeK68YEYf7ilg==
X-CSE-MsgGUID: YAYa09fTROuifa+dANeVwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5611994"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.28]) ([10.125.109.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:08:36 -0700
Message-ID: <197c7286-6961-4934-80f7-896cf8a37ef6@intel.com>
Date: Thu, 29 Oct 2026 16:08:35 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Account for locked decoders regardless of commit
 state
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, ming.li@zohomail.com,
 icheng@nvidia.com, linux-cxl@vger.kernel.org
References: <20261029201327.1119231-1-dave@stgolabs.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261029201327.1119231-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/26 1:13 PM, Davidlohr Bueso wrote:
> Firmware may arm a locked decoder it leaves uncommitted, a corner
> case albeit a valid one. Enumeration only records the bit for committed
> decoders, yet setup_hw_decoder() carries it through and the driver's
> own commit triggers it read-only.
> 
> A later region teardown then writes a reset the hardware ignores and
> clears CXL_DECODER_F_ENABLE anyway, so the decoder looks free while it
> still decodes and releases its DPA.
> 
> Record the bit regardless of the commit state, such that the decoder
> then reads locked from probe, and a region built on it is locked at
> attach.
> 
> Tested on qemu modified to enforce locked, arming the bit on an
> uncommitted endpoint decoder before the endpoint probes, then
> committing and deleting a 256M region on it and creating a 512M one.
> Before, the decoder and region read unlocked, the DPA is freed and the
> second region reports committed while the hardware still decodes the
> first; after, both read locked from attach, decommit fails with
> -EPERM, the DPA release with -EBUSY, and the second region cannot
> allocate DPA.
> 
> Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Can you commit the decoder in locked state? Or are you just stuck in this weird state?

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/hdm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index fdcef20e01ba..a34f3509ab1f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1064,11 +1064,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		.end = base + size - 1,
>  	};
>  
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		cxld->flags |= CXL_DECODER_F_LOCK;
> +
>  	/* decoders are enabled if committed */
>  	if (committed) {
>  		cxld->flags |= CXL_DECODER_F_ENABLE;
> -		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> -			cxld->flags |= CXL_DECODER_F_LOCK;
>  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
>  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		else

