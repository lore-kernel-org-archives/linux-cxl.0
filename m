Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0CD1B5838
	for <linux-cxl@vger.kernel.org>; Thu, 29 Aug 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950214; cv=none; b=Rm6aLFtJUqIOxf7+5tvT6eJlQ4q0YQiV0mTs7X+rAv4nGR3PvodPdPlmBlDSK11SlBO9mcWnJbewuUsgB8IWyFpvRWNGgpGh0I9yPdIGmu+zyGtnElhl1lIwMvJ44iRCF3xcsBa8BDltJHPL+qNLPG/PiS+AUwFbS1n22E5KUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950214; c=relaxed/simple;
	bh=3tl/9w/m745p/ovV1XYUHeradfxC0NNfUsu2ZzNeC60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7equNsYH/iTX72t8L1qKQH6X7sYr1/yismhurRXC8+KSm2yGxGmc2HNijrA9Wo2B+bdeILqhMYnrpcmL0ZwKxB3KAtvDaTg1a+z7AKHDIiDYpgTRpyZELtjC5tTJIKd13Le1YvNlqrDcYp7HEUkojmdmYnBNnepdkuBAqZfg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQElb8Y4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQElb8Y4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724950213; x=1756486213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3tl/9w/m745p/ovV1XYUHeradfxC0NNfUsu2ZzNeC60=;
  b=PQElb8Y4AdCrO7G+LEKaGMzAUWiteEPqq97O79xLxn2kQrPYCtBa+2/V
   MSQV/8ZHYYWNuL2GfFTyi3qsWss92mx0Qz8Ptg3Sr7d14X057fUs6Jo+r
   a01nZR02KGZBNtddPxVkn3nP1Q857vmkjI3n9kNqY49IGXWwyi6psHT10
   rOs172clirl2aAYXHXaSUMy5+avemb7E3WT4jS1btQePTtVRv3CenBnle
   zsFEge1TaKnEPeuTAoq1B64PIFohfHNnOX2S03OgYfy6MOcpvScbj/CGw
   mCk2I7WqJigCtx9HVb/VhaAHylzkhSSBbINmwlIBTnlNE0Ys1iYq0S+2L
   w==;
X-CSE-ConnectionGUID: ql71nnG0SUqXGcqA4WFZVg==
X-CSE-MsgGUID: qh8rVL2fTpi1Bbu6kiHxUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27439293"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27439293"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:50:13 -0700
X-CSE-ConnectionGUID: BKDNnYW8R3G+n8dTo0fnmw==
X-CSE-MsgGUID: LvefvT7AS3Kytepk2d8WmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="101153629"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.219])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:50:12 -0700
Date: Thu, 29 Aug 2024 09:50:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, alejandro.lucero-palau@amd.com,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, fan.ni@samsung.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 1/2] cxl: Move mailbox related bits to the same context
Message-ID: <ZtCmwhVYeg63G0fl@aschofie-mobl2.lan>
References: <20240827215116.536126-1-dave.jiang@intel.com>
 <20240827215116.536126-2-dave.jiang@intel.com>
 <ZtCWmAxX8766Blpj@aschofie-mobl2.lan>
 <5e33f39b-4be9-47dd-ac58-5be87023112c@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e33f39b-4be9-47dd-ac58-5be87023112c@intel.com>

On Thu, Aug 29, 2024 at 08:51:27AM -0700, Dave Jiang wrote:
> 
> 
> On 8/29/24 8:41 AM, Alison Schofield wrote:
> > On Tue, Aug 27, 2024 at 02:49:49PM -0700, Dave Jiang wrote:
> >> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> >> it. This allows isolation of all CXL mailbox data in order to export
> >> some of the calls to external callers and avoid exporting of CXL driver
> >> specific bits such has device states. The allocation of
> >> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> >> mailbox can be created independently.
> > 
> > The reasoning for this mentions 'external callers' yet this new struct
> > is added to a header file that is still internal to the kernel. It's
> > now available outside the CXL driver but not externally.
> > 
> > Does it belong in to include/uapi/linux/  and need to be documented
> > in the driver-api/cxl/ (same as cxl_mem.h)
> > 
> external as to CXL but still kernel caller. this is not for user space consumption. for example future fwctl cxl support or maybe type2 support Alejandro is working on. 

Understand now - thanks!
> 
> > If it stays internal to include/linux/ note that cxl-event.h 
> > already exists there w no 'cxl' subdir'. Maybe skip the subdir
> > addition, or mv cxl-event.h along with.
> 
> yeah I need to move cxl-event.h into that dir as well. missed that. 

w include file fixups you can add my Tag to both patches -

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> > 
> > --Alison
> > 
> > snip
> > 
> > 
