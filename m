Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEA3BED7D;
	Mon, 27 Jul 2026 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183954; cv=none; b=IUwRyL8R1ENa8OAIEu6fSmelbEk60tAzcEhxD+LsfFRgtLacosZ90uOAfFybOVXRPHfCBFWsnpIiFrw+6AfR3OaQXY58V1HMYWrhJzskdx+2BDkYEBFhGGuMtCVxfD89B69ogsXk1avjdtZNFm+03nzobVMIJUAI1o6s/0E4M1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183954; c=relaxed/simple;
	bh=k724Mcb0Yd7x3og58df7xqAM/wCEguCVtlcyEmLS5Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XU+Ds/fWN145FmBTF//DT7GLOfL5RSuMeL/doIVBg3qI6Mo94vK0edwk9tq72XYZL5XFu27a/JDN8+Pa+kPa4oh66ZoSezr/iOA0c2w3rRG2caQYyxclGTFSyq+BlBkJV+24B4kHYHn24W2FAXG80QEDpt2DDRH7mYd38J750Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lol3z9FG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lol3z9FG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785183951; x=1816719951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k724Mcb0Yd7x3og58df7xqAM/wCEguCVtlcyEmLS5Bs=;
  b=Lol3z9FGoWNdwWunp23B3t+ppD37zzvJMN3EKlqzPTOU9jGxUu9E1eoo
   d3cXs9jNRa+aGJcVioxcrAidHP+L8nFrr2jJLEkjFmWwtUsdKO+5jR9dY
   r+V/oasin/xbjtRv4QCK5L/bb8HarkT026bTVuFVsAf0b/ci3d++Y+ely
   G6Bir2KhkHYS18HcoYlKVr4DlSWX6vqnzazyc7Vx4a3xdDYoi+pL7Y5e7
   AFCFzlTrnwpknCOuoLI0HmXCckAJN6MD1atwCi18LCmZTBqoOA881qVKz
   SzP7VsDhPAy0eEYEkwM2yj77LvGVn/1OVlsj5TWDuJFzmZUPvu1oICbwy
   g==;
X-CSE-ConnectionGUID: Wj9vwdpETa6qsWP1T3wYaA==
X-CSE-MsgGUID: R1QtM20mRp6OT5+uf869Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85949866"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85949866"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 13:25:51 -0700
X-CSE-ConnectionGUID: tSMPoLZLReq2Kd9SiczYUw==
X-CSE-MsgGUID: WW1e3TfPR9iLfNNHw7Dgnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="263287627"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.47]) ([10.125.111.47])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 13:25:49 -0700
Message-ID: <d96567c3-df6f-4008-9678-c4fed3787309@intel.com>
Date: Mon, 27 Jul 2026 13:25:48 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Restore passthrough decoder enable on region
 re-assembly
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 sreddym@nvidia.com, smadhavan@nvidia.com, kaihengf@nvidia.com,
 kobak@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com
References: <20260727103743.63343-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260727103743.63343-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/27/26 3:37 AM, Richard Cheng wrote:
> After a CXL endpoint is PCI hot-removed and the bus rescanned, an
> auto-discovered region fails to rebiuld and is lost, evne though the

rebuild
even

> device's HDM decoder is still committed and decoding.

If we truly do a PCI hot-remove and re-insert, the endpoint device would be reset and disabled. Not sure how it would still be decoding. Also, a complete different device with possibly different size can be inserted. And the device showed up would be unconfigured. Given there's no BIOS to program the device since the OS has taken over, should it be still considered part of the auto-region?

Any thoughts Jonathan?

> 
> A single-dport host bridge/root port has no HDM decoder capability, so
> its switch decoder is a SW-only passthrough. Its CXL_DECODER_F_ENABLE
> flag is cleared on region teardown and never restored on rescan, so
> cxl_port_setup_targets() fails with -ENXIO.
> 
> Re-enable the passthrough decoder when its interleave and HPA config
> still match the region, it holds no HW state.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/region.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..011ceb5bae79 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1574,6 +1574,19 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		/*
> +		 * A passthrough switch decoder holds no HW decode state.
> +		 * It's CXL_DECODER_F_ENABLE flag is pure software bookkeeping
> +		 * that is cleared when the region is torn down. On auto-discovery
> +		 * re-assembly after a subsequent rescan the decode config still
> +		 * matches the region, so restore the flag rather than fail to
> +		 * rebuild a region that HW is in fact still decoding.
> +		 */
> +		if (!cxld->commit && cxld->interleave_ways == iw &&
> +		    (iw <= 1 || cxld->interleave_granularity == ig) &&
> +		    spa_maps_hpa(p, &cxld->hpa_range))
> +			cxld->flags |= CXL_DECODER_F_ENABLE;
> +
>  		if (cxld->interleave_ways != iw ||
>  		    (iw > 1 && cxld->interleave_granularity != ig) ||
>  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> 
> base-commit: 4539944e515183668109bdf4d0c3d7d228383d88

