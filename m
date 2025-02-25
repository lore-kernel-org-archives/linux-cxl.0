Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FACD221576
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523230; cv=none; b=Hy9+EbV+mbc6lsbcgYK0uGqlzrvgr8sR/97fqaN/gaiIzI41a7O0UfeswY2YkW6xjn5iE0rhPh6+2kcMUpgTxF0FbwylGsrveFAInKFz3IFiFmP+G4HVIQ7GyEp0MAWTGqhBUZSBwPjjyFb9ePfWOl7jE69DpXGVQvFMCIEFuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523230; c=relaxed/simple;
	bh=g4xf4gt74R1KB4HwG8jJkbOgWj83R4jXUx2VSbh6OP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHFVaxrgPQ12TTUjX+9I5mBPndPRWbbCCldVCo9zI3869zuozY1v2D2krw2U6Fy1ruZoZXl7mnQMSS5Q3oOPlGPWxxxwEZeidIJpC2BF47eUhaof5n6w/9AjbjBHeweb2vQuCucuMfXCBoCXs1pNG1zlmklAjsbA2sREscKWirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWI/yL/1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWI/yL/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740523227; x=1772059227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=g4xf4gt74R1KB4HwG8jJkbOgWj83R4jXUx2VSbh6OP4=;
  b=iWI/yL/1SX9thXiJiM9uaIUkM4Or3lhgQMcOdAPF6+9BfaoaqTxgzd2k
   emV88tYZSJq4bI8h1d3w4Bi9sNtxU5OVijg5xk0njKLgSkjI8XYzEnzvN
   LHJYX+cVHtDwCGNl5EBSIlEHO8RrDOb+GfvpZyTImbBeOXgzQfcqC3Mya
   S2iXsnlTxnAxEQR3S2e5tPpXi9jjiGal9JIwtPUX0R0ormaAE9oupRBnn
   ZoJ9X9kdyB4kdI+t3IdssCILrd/rR3OUJGBQV7uqa9ThVcQ6ktxXGSkYr
   RuFu6MzqN+zZM7KOmfsUtILOENqsO2fOsTfmFe83BbW2AA4XBC2onleuq
   Q==;
X-CSE-ConnectionGUID: q+Z0gKzOT6exsc/F8FqR7g==
X-CSE-MsgGUID: 9nvftpSrQnCKPPlQ2hnVew==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="63818584"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="63818584"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 14:40:27 -0800
X-CSE-ConnectionGUID: jcDX396YSqKRuL//KVWP5w==
X-CSE-MsgGUID: InyiUGLkQ6KvNJKmKYs+jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="117143488"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.175])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 14:40:27 -0800
Date: Tue, 25 Feb 2025 14:40:25 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: linux-cxl@vger.kernel.org
Subject: Re: ndctl cxl test suite fails in arm64 QEMU
Message-ID: <Z75G2UKmx7G59u7P@aschofie-mobl2.lan>
References: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43568B03-6832-4EB1-BF46-EF0F176509E2@linux.dev>

On Tue, Feb 25, 2025 at 01:09:57PM +0900, Itaru Kitayama wrote:
> Hi,
> 
> Has anyone noticed the ndctl cxl test suite failures I reported below on arm64, QEMU emulation?
> 
> https://github.com/pmem/ndctl/issues/278
> 
> I’m using Jonathan’s latest CXL capable QEMU [1], and the latest CXL kernel [2].

Hi Itaru,

Looking at region.c:size_store() it seems that alloc_hpa() is failing.
(kstrtou64 is arch independent and it works for me with same script &
value)

Check the dmesg log at the time of the failure. alloc_hpa() may be
emitting a message.  (In the run_qemu.sh cmdline add '--cxl-debug')

Sounds like Marc is on to something and maybe the KASLR is known
to cause this problem.

Thanks for posting to this list and send any further questions or
comments. Happy to have you using run_qemu.sh and the cxl tests!

Alison


> 
> [1] https://gitlab.com/jic23/qemu/ cxl-2025-02-20
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/
> 
> Thanks,
> Itaru.
