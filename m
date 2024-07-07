Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A791876
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jul 2024 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720316914; cv=none; b=HHFIg2bgShGAzU2TMGPPrg5mQ34eZAnXDb5ICMte19O6zn2HMsxsiFF2ijAN/kJ/kipfD8RZRUIcsdalMEKu1mIHKO8k0gHsz6mgjk8V1dua9AP6ne3aWVolsYAFAp9HUPo5xZokv1U5cj383eJTgxVKn2GqD1hh/OWbhQUZUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720316914; c=relaxed/simple;
	bh=N0qhRfvkZrl5f1Ro+NTjKs5DgbfoaXrPFKMWu+pWeok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8JTlOC79lldWwGu8qO2SYvAopHskIGlctEayKpdXx5+/neoe4yU40xay7XHhf574J2HeYTyY0Fsxw7Ba1ibOPvJTEKTB5/YQ2fDmkrokDc5WpJMUQtE8pnBRO38Mx2W7MHqeseNjO40jmUofa9xX5rOxxNzpE7PEzNabKaAEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEOm6XeC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEOm6XeC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720316913; x=1751852913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N0qhRfvkZrl5f1Ro+NTjKs5DgbfoaXrPFKMWu+pWeok=;
  b=lEOm6XeC7BYLUHC856fqBB/5YrRLQ/3qQphOobN33GQ5wogIOW4YtzHx
   lr2WchNLYixsHO0TmQIM5CC2+/9QSTJYaohOnq0Rs62vZqKuUhs7pJXlH
   DI/+HtdPRe0Ne3/Y2pwSbzAhVm6rP2Rc/+6NF62rlm6nFYH/1NZf15dvL
   r0VkOVX3n7V7TTYDMSErFCziyu8GBcLsELyyyz7nFQPboPsKt2unkGk9B
   BECd+qk/ykN5j1v5eMQOMAShAwKlJS7LU4EPrqdYfPPqDJ4BKaGozVwN4
   AFFYtcu1W8OHYXi3OnISD8IZ5tzKni+moZUC7EpZ/m5tk3TjhJrLHZcwq
   w==;
X-CSE-ConnectionGUID: dAE6yfbbSsGaG0BKXKYSsA==
X-CSE-MsgGUID: 9gz1T8o5QLudfjNHSY0AUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="20454062"
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="20454062"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 18:48:30 -0700
X-CSE-ConnectionGUID: ctnY66euQR6BwPxo7pWBTA==
X-CSE-MsgGUID: iTLtbf4aT4CTWluE+vyjkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="51602484"
Received: from pgarg3-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.105.130])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 18:48:29 -0700
Date: Sat, 6 Jul 2024 18:48:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/test: Replace ENXIO with EBUSY for inject poison
 limit reached
Message-ID: <Zonz67MFZMzBryoa@aschofie-mobl2>
References: <cover.1720052137.git.alison.schofield@intel.com>
 <e13e59c43a456f56e275d039cd0f67c6117230c8.1720052137.git.alison.schofield@intel.com>
 <TYCPR01MB6464AD7628D9B17C13BDE1598DDF2@TYCPR01MB6464.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB6464AD7628D9B17C13BDE1598DDF2@TYCPR01MB6464.jpnprd01.prod.outlook.com>

On Fri, Jul 05, 2024 at 06:15:24AM +0000, Xingtao Yao (Fujitsu) wrote:
> > -----Original Message-----
> > From: alison.schofield@intel.com <alison.schofield@intel.com>

snip

> > 
> > -static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
> > +static int mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
> >  {
> > +	/* Return EBUSY to match the CXL driver handling */
> >  	if (mock_poison_dev_max_injected(cxlds)) {
> >  		dev_dbg(cxlds->dev,
> >  			"Device poison injection limit has been reached: %d\n",
> >  			MOCK_INJECT_DEV_MAX);
> There is a tiny issue here, we'd better replace MOCK_INJECT_DEV_MAX with 
> poison_inject_dev_max, as this value can be configured through 
> /sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max
> 
> like:
> # echo 128 > /sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max
> 
> after injecting 129 poisons, the “Device or resource busy” occurred, but the debug message
> still output:
> [ 7664.280587] cxl_mock_mem cxl_mem.0: Device poison injection limit has been reached: 8
> [ 7664.280591] cxl_mock_mem cxl_mem.0: opcode: 0x4301 sz_in: 8 sz_out: 0 rc: -16
> 
> 
> Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> 

Thanks for testing and thanks for finding this issue.

I've folded this fixup into v2 of this patch. Since it's cxl-test, and
it's a dev_dbg() message, and it's directly adjacent to what this patch
touches, I expect that will be OK. (as opposed to a seperate fixup)

--Alison

