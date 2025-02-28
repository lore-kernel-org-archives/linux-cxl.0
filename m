Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C951F09AF;
	Fri, 28 Feb 2025 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767677; cv=none; b=BUaeSomdK2a9BMMiD/97spH8CwHEwyHciRQJMKjG98E2ZkYS8LG2uJkGaqyVAvsihKH0QoaDgWdhstBYd5iQFOAvTZw3LG5gdha/fL8jnyleK6uWMXbZBxnYRtjDfUd1qUBECTFVNkaV5WmCXtUlH0IpZ/lDIcD5yEIcjl1tKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767677; c=relaxed/simple;
	bh=YvlNVVZWhItDH8VpooX0xWem+IyaI415jHJZcKprnzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxMwM1ULTARVg4LQLOe1kTMaosyRD2TzwRtni3mV9ubvkg4rgtirwCPf+5NvtAmJEhcvJqDx/EnICd+5K7mGTBreYHt+GNk2DzS2GLj1f0lXvUo9ITtaa7ektYVvCsLSLh7qTFmOFKQJbb04p57/fxJARPleOtPlDzABbosoj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PB+7Tdez; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PB+7Tdez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740767676; x=1772303676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YvlNVVZWhItDH8VpooX0xWem+IyaI415jHJZcKprnzQ=;
  b=PB+7TdezTpuNlKGRryFBzgQdpwkwAvisCm1bFZrEagR2gYJYaA01qbiJ
   yfDXj1x3aQUuQvvkEKOQh949FLpFcslp0WNMgUe3hlT5tfAZjyRwunjm6
   zRUdQLFrBYb3AYHoc6fc+UNjATNtOh61X8oRpcJj+G70QIotM/6ZC8n26
   RSnT8ujIx2FrdQ5LVQuyE40b2LRIIQFL6Q3r8ympTXOTWpQQMKjA+GYSy
   JTQQublBmfCDZUdHcvkOvg5W9B594Z3PnPaImqlvH7tFNPs5RUkCH7Jtd
   minqoFMj2hzEbLKoRQpmpgIIilN2Hz8qNeQN9xVC9Q8MGqc5gNyuXTUNH
   g==;
X-CSE-ConnectionGUID: ixxlZaicRBaAKuii80bgvw==
X-CSE-MsgGUID: 4VzMeY9CR3OoHVsTsoMbhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53117241"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53117241"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:34:35 -0800
X-CSE-ConnectionGUID: k6Y+Rt/HQfGaeCHmncXfUQ==
X-CSE-MsgGUID: 5ByvKEnwTC6JqCHLGDpeDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122546843"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.168])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:34:34 -0800
Date: Fri, 28 Feb 2025 10:34:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] cxl/hdm: Verify HDM decoder capabilities after
 parsing
Message-ID: <Z8IBuE714QNscgfJ@aschofie-mobl2.lan>
References: <20250227103251.390147-1-ming.li@zohomail.com>
 <Z8DdafbX6_tbM4DW@aschofie-mobl2.lan>
 <4c97ec3a-3435-4e79-8265-6a82ae930c3e@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c97ec3a-3435-4e79-8265-6a82ae930c3e@zohomail.com>

On Fri, Feb 28, 2025 at 10:47:12AM +0800, Li Ming wrote:
> On 2/28/2025 5:47 AM, Alison Schofield wrote:
> > On Thu, Feb 27, 2025 at 06:32:51PM +0800, Li Ming wrote:
> >> devm_cxl_setup_hdm() only checks if decoder_count is 0 after parsing HDM
> >> decoder capability, But according to the implementation of
> >> cxl_hdm_decoder_count(), cxlhdm->decoder_count will never be 0.
> > How does a check against the spec maximums benefit this driver? Is there
> > a bad path we avoid by checking and quitting at this point.
> 
> 
> My understanding is that no a bad path on driver side if the decoder_count is greater than the maximum number spec defines.
> 
> Driver just allocates cxl decoders on the port based on the value of decoder_count. But I am not sure if hardware will have other potential problems when it didn't follow the spec.

I had the general thought that the driver is not responsible for
compliance checking the device, unless it affects function. Excessive
decoder_count's sound like they cause needless allocations, so let's
stop doing that - as best we can. 

Is it sufficient to clamp at the spec defined max values and continue
with only a dev_warn_once or even a dev_info?
ie. for a device: decoder_count = min(decoder_count, EP_DECODER_MAX);

That'll avoid failing a device that previously snuck by with an
excessive decoder_count and protect against excessive allocations
in the driver.

> 
> 
> >
> > Might this catch silly decoder counts that the driver previously
> > ignored?
> >
> >> Per CXL specification, the values ranges of decoder_count and
> >> target_count are limited. Adding a checking for the values of them
> >> in case hardware initialized them with wrong values.
> > Similar question - is this catching something sooner, rather than
> > later?
> 
> 
> Yes, the check is at the beginning of HDM setup during port probing, if value is wrong, will break HDM setup.
> 
> I'm not sure if I fully understand your question, please correct me if I misunderstand it. thanks.

I understand now. This one is different that decoder_count because 
it was heading to failure anyway and seems good to fail sooner.

> 
> 
> >
> >> Signed-off-by: Li Ming <ming.li@zohomail.com>
> >> ---
> >> base-commit: 22eea823f69ae39dc060c4027e8d1470803d2e49 cxl/next
> >> ---
> >>  drivers/cxl/core/hdm.c | 31 ++++++++++++++++++++++++++++++-
> >>  1 file changed, 30 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> >> index 70cae4ebf8a4..a98191867c22 100644
> >> --- a/drivers/cxl/core/hdm.c
> >> +++ b/drivers/cxl/core/hdm.c
> >> @@ -138,6 +138,34 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> >>  	return true;
> >>  }
> >>  
> >> +static int cxlhdm_decoder_caps_verify(struct cxl_hdm *cxlhdm)
> >> +{
> >> +	/*
> >> +	 * CXL r3.2 section 8.2.4.20.1
> >> +	 * CXL devices shall not advertise more than 10 decoders,
> >> +	 * CXL switches and HBs may advertise up to 32 decoders.
> >> +	 */
> >> +	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
> >> +		return -EINVAL;
> >> +	else if (cxlhdm->decoder_count > 32)
> >> +		return -EINVAL;
> >> +
> >> +	/*
> >> +	 * CXL r3.2 section 8.2.4.20.1
> >> +	 * target count is applicable only to CXL upstream port and HB.
> >> +	 * The number of target ports each decoder supports should be
> >> +	 * one of the numbers 1, 2, 4 or 8.
> >> +	 */
> >> +	if (!is_cxl_endpoint(cxlhdm->port) &&
> >> +	    cxlhdm->target_count != 1 &&
> >> +	    cxlhdm->target_count != 2 &&
> >> +	    cxlhdm->target_count != 4 &&
> >> +	    cxlhdm->target_count != 8)
> >> +		return -EINVAL;
> > Maybe instead of manual bitwise checks try
> > 	(!is_power_of_2(cxlhdm->target_count) || cxlhdm->target_count > 8))
> 
> 
> Yes, It is clearer, thanks for that.
> 
> 
> >
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  /**
> >>   * devm_cxl_setup_hdm - map HDM decoder component registers
> >>   * @port: cxl_port to map
> >> @@ -182,7 +210,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> >>  	}
> >>  
> >>  	parse_hdm_decoder_caps(cxlhdm);
> >> -	if (cxlhdm->decoder_count == 0) {
> >> +	rc = cxlhdm_decoder_caps_verify(cxlhdm);
> >> +	if (rc) {
> >>  		dev_err(dev, "Spec violation. Caps invalid\n");
> > Can you move the dev_err to the verify function and include the
> > specific invalid capability.
> >
> >
> > --Alison
> 
> Sure, will do that, thanks.
> 
> 
> Ming
> 
> 
