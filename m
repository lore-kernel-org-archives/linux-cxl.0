Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49456364
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707438240; cv=none; b=Dc3Hyu/V3clhRI1nam4gbIo1Gcp0VNuauaMZhzosD+jcENjW5clpDPN9qA2kQ7KPVT76/aHgqT9DjCfgnEajZ8Zz6x5d3IR2Sny7MN3Vl9cHvK0sz1IETbMuMJS6At/6DdfQEOzE1x5c3MFt8bEYnnt/l70StxQvd+r0Z+JwOWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707438240; c=relaxed/simple;
	bh=Du7+mCAtmQjqpc8eL7gxA1aUEP+ozJIH+yqUvezF1nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOblErW4d6AI9Ds7/OijkTu3V+1b8kzp1xbCI66azngAi7szRnNPdwjwBMRNmyKMfD3WgZYAYhfOuI5yIDbElDxOpOL7Yv+CupIfae09rX8oGhDvq6Abc/DW+WICfhfLz4ec5WUVJnwkgYhblUtYM28TlUOyK4QTi+w9WYHJocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMBLIBvN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMBLIBvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707438238; x=1738974238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Du7+mCAtmQjqpc8eL7gxA1aUEP+ozJIH+yqUvezF1nM=;
  b=kMBLIBvNXDndIQEpHG4BJkSgHOlitYgWtfNT8OdzowdTiKNfGdEbrQzs
   V4FbZ/JK/mNtcn2tuNG2LAuhoB3H2c+4LSTaEhMhuUOQQWzuDomM59zyn
   LmKm1gI+p+nX+LkdqdwBHkQ+jvua2XYENLXbIjlo7a4LS/dWWXPjfK49E
   b4tQvMsDSO1uNljXLb2Niq0OmHIcgwRVcb5TADw+7HyEkLMt+llT+C9od
   ZMMcRT397SHkgd7D099ELo8YYOWbGv+BnR3ae2vb5rqV9JVI9mm/S2KlS
   WBEGlEfdccfYdEcOZ+vSb42a0BlDfeOUxE+dc1+1bNrU+wzWT/lbTTYlS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="5198849"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="5198849"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 16:23:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="2028656"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.103.161])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 16:23:56 -0800
Date: Thu, 8 Feb 2024 16:23:54 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Wonjae Lee <wj28.lee@samsung.com>
Subject: Re: [RFC PATCH] cxl/region: Allow out of order assembly of
 autodiscovered regions
Message-ID: <ZcVwmvubGa/3CweX@aschofie-mobl2>
References: <20240113050421.1622533-1-alison.schofield@intel.com>
 <65a980249f50f_3b8e294a3@dwillia2-xfh.jf.intel.com.notmuch>
 <ZcU+9BxBD8IRsnTu@aschofie-mobl2>
 <65c55c67ec60f_afa4294cc@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65c55c67ec60f_afa4294cc@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Feb 08, 2024 at 02:57:44PM -0800, Dan Williams wrote:
> Alison Schofield wrote:
> > 
> > On Thu, Jan 18, 2024 at 11:46:44AM -0800, Dan Williams wrote:
> > 
> > - snip to decoder replay patch -
> > 
> > > 
> > > So one of the largest roadblocks for creating arbitrary region assembly
> > > scenarios with cxl_test is the inability to save and restore decoder
> > > settings.
> > > 
> > > The patch below adds support for recording decoder settings and skipping
> > > the reset of those values when unloading the driver. Then, when the
> > > driver is reloaded, it simulates the case of BIOS created CXL regions
> > > prior to OS boot.
> > > 
> > > We can go after even finer grained cases once the uunit effort settles,
> > > but in the meantime cxl_test can add auto-assembly regression tests with
> > > the current topology.
> > > 
> > > With the below you can simply trigger "cxl {en,dis}able-memdev" in the
> > > proper order to cause the violation.
> > > 
> > > -- >8 --
> > > From 5839392a3dbb64dbbac0630d930b1f48a8ef7ea6 Mon Sep 17 00:00:00 2001
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Date: Wed, 17 Jan 2024 20:56:20 -0800
> > > Subject: [PATCH] tools/testing/cxl: Add decoder save/restore support
> > > 
> > > Record decoder values at init and mock_decoder_commit() time, and
> > > restore them at the next invocation of mock_init_hdm_decoder(). Add 2
> > > attributes to the cxl_test "cxl_acpi" device to optionally flush the
> > > cache of topology decoder values, or disable updating the decoder at
> > > mock_decoder_reset() time.
> > > 
> > > This enables replaying a saved decoder configuration when re-triggering
> > > a topology scan by re-binding the cxl_acpi driver to "cxl_acpi.0" (the
> > > cxl_test emulation of an ACPI0017 instance).
> > 
> > Hi Dan,
> > 
> > Sorry it's taken a while to come back on this. I did find it useful
> > in testing the auto-assembly order issue as you suggested. 
> > 
> > I didn't use this one: &dev_attr_decoder_registry_invalidate.attr,
> > I just reloaded the cxl-test module to do same.
> 
> Makes sense, that can go.
> 
> > This I used:  &dev_attr_decoder_registry_reset_disable.attr,
> > with your decoders state fixup to set CXL_DECODER_STATE_AUTO,
> > and a work-around to avoid pmem_probe failures on pmem region
> > auto create. 
> > 
> > More generally, I'm wondering about the implementation of the
> > 'registry_save'. Here it continuously updates during all
> > cxl-test usage. Did you consider only creating the registry upon
> > user request and then at the next mock_init_hmd_decoder() look
> > for and use that registry if it exists.
> > 
> > Usage would be: 
> > # echo 1 > /sys/bus/platform/devices/cxl_acpi.0/decoder_registry_create
> 
> You mean wait to snapshot decoder state when triggered?
Yes.

> 
> > # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/unbind
> > # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/bind
> > 
> > And then maybe, for folks who like to acpi/unbind,bind, rather
> > than reload module, we could offer a decoder_registry_remove attr.
> > 
> > Am I missing something regarding the need to keep it updated
> > on the fly? 
> 
> I can see it being an alternate way, but not sure how to weigh one
> approach vs the other. Is the dynamic update getting in the way of a
> test case you are thinking about? Otherwise it seemed easy to reason
> that the registry is always on, but only takes effect when
> registry_reset_disable is set, and cxl_acpi rebinds the test device.

The constant work of updating the registry caught my attention, but
no impact that I know of. The dynamic approach is more intrusive and
impacts the normal path needlessly. A snapshot approach limits much
of the impact to users of the new feature.

