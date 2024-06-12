Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF031A67
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718229377; cv=none; b=hpEk9UJ5qLhZfvSBxBQuSiSTrQdK9VnhmJWJc/bopu4OGKOB+cpn+kwZcvbsuJ7YNEqDj5T9Eg5XI8CTofXbit7UdQYvzi5L2OZNmVmaubiMieh0V961Ngu1shdqFfeRahX0Po0fKYdBLQ80c8b8Cpf0NJ82N7iVIQZ2jeS+z3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718229377; c=relaxed/simple;
	bh=ovXI5G0i1EZQlYJLCBcLjzJy9Rtji+LAbmcLAABHTuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX8lzESt3/WaYGpI6z6ZSWUpStFqN/2P2rHea5jNeSHXyBJfOD73bIKHWycLggmPmEzad+C5E3FvlWKNU00sOejcwKFk82DvFal2GuaMEUwVgmYkSH01RnYZYAX3yo4rqgDmP09CQfhl4RckcPG4M9sp28149ljXi+YJby1hCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vut95ESa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vut95ESa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718229376; x=1749765376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ovXI5G0i1EZQlYJLCBcLjzJy9Rtji+LAbmcLAABHTuI=;
  b=Vut95ESa2q0aihl/vAzjJ97NN9IG0L885TRF4WYz2p1As4HLAWoVHqhu
   ibO5E/wOnoXZY+rjKp3zLV/RLvZJsiAfw/8yFsY7IFHMVISapFcumYZ2S
   NyqAxY2vG+DlCFcREYAb9GUDlryYlLvpV04cUIwpz1tDunwkaoadv7xwK
   EuJrD/52KBLgb18OMavxoeDCB4DHjmgwCgMnDWlTSDZLrsY3f0LDuQNUB
   D4/JY4d5B9HTzlDtTDX8uGoECMXroDGVh267peKffIBV3N7k2hD1LT3DX
   y4hvdSZAkvo2KxtvNKQWYGIUa6z/LyIRBZ4dHgNT7pZiR6f9p6hbpT2Jh
   w==;
X-CSE-ConnectionGUID: O/6gAluiSVqT+CK4z12PkA==
X-CSE-MsgGUID: ul6ofQVYQN6Vt7KCiYIDcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12042051"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12042051"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 14:56:15 -0700
X-CSE-ConnectionGUID: yrrlSfhyT52dHfcTL+wZRQ==
X-CSE-MsgGUID: io0DT7srQSiyC15VtJ0B1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="70720409"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.20.178])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 14:56:15 -0700
Date: Wed, 12 Jun 2024 14:56:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	jim.harris@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7] cxl/region: check interleave capability
Message-ID: <ZmoZfZPcGNYCqQGL@aschofie-mobl2>
References: <20240612032544.39149-1-yaoxt.fnst@fujitsu.com>
 <66691eedbe8_31012947f@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66691eedbe8_31012947f@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Jun 11, 2024 at 09:07:09PM -0700, Dan Williams wrote:
> Yao Xingtao wrote:
> > Since interleave capability is not verified, if the interleave
> > capability of a target does not match the region need, committing decoder
> > should have failed at the device end.
> > 
> > In order to checkout this error as quickly as possible, driver needs
> > to check the interleave capability of target during attaching it to
> > region.
> > 
> > Per CXL specification r3.1(8.2.4.20.1 CXL HDM Decoder Capability Register),
> > bits 11 and 12 indicate the capability to establish interleaving in 3, 6,
> > 12 and 16 ways. If these bits are not set, the target cannot be attached to
> > a region utilizing such interleave ways.
> > 
> > Additionally, bits 8 and 9 represent the capability of the bits used for
> > interleaving in the address, Linux tracks this in the cxl_port
> > interleave_mask.
> > 
> > Per CXL specification r3.1(8.2.4.20.13 Decoder Protection):
> >   eIW means encoded Interleave Ways.
> >   eIG means encoded Interleave Granularity.
> > 
> >   in HPA:
> >   if eIW is 0 or 8 (interleave ways: 1, 3), all the bits of HPA are used,
> >   the interleave bits are none, the following check is ignored.
> > 
> >   if eIW is less than 8 (interleave ways: 2, 4, 8, 16), the interleave bits
> >   start at bit position eIG + 8 and end at eIG + eIW + 8 - 1.
> > 
> >   if eIW is greater than 8 (interleave ways: 6, 12), the interleave bits
> >   start at bit position eIG + 8 and end at eIG + eIW - 1.
> > 
> >   if the interleave mask is insufficient to cover the required interleave
> >   bits, the target cannot be attached to the region.
> > 
> > Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> [..]
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 36cee9c30ceb..7fe617122d33 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -848,11 +848,21 @@ static inline void cxl_mem_active_dec(void)
> >  
> >  int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
> >  
> > +/*
> 
> Minor detail that can come in a follow-on patch is that this needs to
> be:
> 
> /**
> 
> ...in order for the kernel-doc system to autoformat it like it does
> other 'struct' documentation:
> 
> https://docs.kernel.org/driver-api/cxl/memory-devices.html
> 
> However, the reason it needs to be a follow-on patch is that this file
> is not currently included for parsing and needs something like this:

We'll need another revision of this patch to address the cxl-test module
dependencies so how about adding the "/**" in the next revision.

I'm suggesting this because cxl_mem.h contains other kernel doc
comments that are not being picked up because cxl_mem.h is missing
in Documentation/driver-api/cxl/memory-devices.rst. There also seem
to be other ommissions when compared with the kernel doc notations
in drivers/cxl/ :  core/cdat.c, core/hdm.c. I say 'seems' because
I guess it could be intentional.

Can Yao add the kernel doc notation in the next rev of this patch
and then come back soon and sync memory-devices.rst for all of
drivers/cxl/ ?

-- Alison

> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 5149ecdc53c7..e33ee67ac1a2 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -325,6 +325,9 @@ CXL Memory Device
>  .. kernel-doc:: drivers/cxl/pci.c
>     :internal:
>  
> +.. kernel-doc:: drivers/cxl/cxlmem.h
> +   :internal:
> +
>  .. kernel-doc:: drivers/cxl/mem.c
>     :doc: cxl mem
>  
