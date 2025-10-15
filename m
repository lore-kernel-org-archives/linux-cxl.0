Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AC27E076;
	Wed, 15 Oct 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546319; cv=none; b=RQ5HlFL89MNiy1lPb3aV5Bh2ei9RP804+PelAZEmgvp5qn+9muxXNRzCj1vixP520ZegEQkJJjaLMJTbfVFXKsT4fhPFCGq9yCtRh0ajVY7vGlb2Kudu/IMQybxhSUILg06xje9cVqUG5euBi7qA0luWeWFHcKuJHQb/mWbnj+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546319; c=relaxed/simple;
	bh=6kgf7iMD+JZUR24w4JLI+S12D5BlZmm/nKrPBixlFbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PQ/Hamskg/2xNMLEJMnQna3lk1bFWWNy3hAwrTEBZo67jqgoO+9+iQL85dePHAeNwAaIuQ8hDRn1dSbvhbRwy5kIPZZjlFnRUwsvdYQF/l++VI/LZ9r1D5lA9EqhR8i31AyQBJIXYwRxHDvG6ZeyXmd9RZNpigBaDSgKEfkeysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rml6ah5u; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rml6ah5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760546318; x=1792082318;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6kgf7iMD+JZUR24w4JLI+S12D5BlZmm/nKrPBixlFbE=;
  b=Rml6ah5uzfnmi5JQXOgDSiT6BLlVuipeVSeSjzusG9t4gwM9ipIGAeCK
   pkl43T2qcQSspYnrv56JBB/71AWcE+yNsZRwAdCIcfd0qxgdPL6xxILJ3
   ZvPai7WmIHn+1zXw8kzCdAI3phzIYEA/P1v4KGbeUzvyO27U6StHZ+kDt
   m47v0vdjNngEy1T1fB9ZVlrpSdUcCDizlrCg1uPuGLDOdP/IfN2qERYTC
   DoKRX9Z3HBSZAG4dMVMrn9EeA2uFQdgbjJvf0FKKJuVPEvkOOyIKd0T/B
   Bmgz9VDhLr7xKdf77Y7n/unC9nVSp+btd2Br2zA1gujDL27g7tFgR817e
   w==;
X-CSE-ConnectionGUID: tOF9O4s5THWFXxMR4zw/BQ==
X-CSE-MsgGUID: Z42CQ9K6T7CKmkuVapYydg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62770701"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="62770701"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:38:37 -0700
X-CSE-ConnectionGUID: K/jzDD8DSi2d/0+yQ3Jx+w==
X-CSE-MsgGUID: rw5bFQbUSEycWPcSDtKW2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="186238127"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.221]) ([10.125.111.221])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:38:36 -0700
Message-ID: <d67e3fc9-ebc8-4538-9135-48a0b02d7af9@intel.com>
Date: Wed, 15 Oct 2025 09:38:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cxl: Allow zero sized HDM decoders
To: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 "open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-3-vaslot@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251015024019.1189713-3-vaslot@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 7:40 PM, Vishal Aslot wrote:
> CXL spec permits committing zero sized decoders.
> Linux currently considers them as an error.
> 
> Zero-sized decoders are helpful when the BIOS
> is committing them. Often BIOS will also lock
> them to prevent them being changed due to the
> TSP requirement. For example, if the type 3
> device is part of a TCB.
> 
> The host bridge, switch, and end-point decoders
> can all be committed with zero-size. If they are
> locked along the VH, it is often to prevent
> hotplugging of a new device that could not be
> attested post boot and cannot be included in
> TCB.
> 
> The caller leaves the decoder allocated but does
> not add it. It simply continues to the next decoder.

I think it should add it as well, just as a locked decoder that's size 0. When we do cxl list of decoders, we should see those decoders as how they are.

DJ

> 
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d3a094ca01ad..1c036a485723 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1036,13 +1036,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			return -ENXIO;
>  		}
>  
> +		port->commit_end = cxld->id;
> +
>  		if (size == 0) {
> -			dev_warn(&port->dev,
> +			dev_dbg(&port->dev,
>  				 "decoder%d.%d: Committed with zero size\n",
>  				 port->id, cxld->id);
> -			return -ENXIO;
> +			return -ENOSPC;
>  		}
> -		port->commit_end = cxld->id;
>  	} else {
>  		if (cxled) {
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -1198,6 +1199,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  
>  		rc = init_hdm_decoder(port, cxld, hdm, i, &dpa_base, info);
>  		if (rc) {
> +			if (rc == -ENOSPC)
> +				continue;
>  			dev_warn(&port->dev,
>  				 "Failed to initialize decoder%d.%d\n",
>  				 port->id, i);


