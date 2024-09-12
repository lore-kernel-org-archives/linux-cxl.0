Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0357A1E51D
	for <linux-cxl@vger.kernel.org>; Thu, 12 Sep 2024 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726103197; cv=none; b=pPfjBTOp+qKM3TzjEISrFmjRuXt37zLL1fXFW/LTf77bMsWfpRCCRWWxSjnRklGzrKVbaLz9Mz0sJJEF5PeXRxCADEh9o+NjTeHZohSdahHatQlK1UNHt6K7IwabFFSEbWfUtu5FNOx/wOirQtSML90MktNX/ouWg7lUe8UA8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726103197; c=relaxed/simple;
	bh=kaI+p7sVIt84JE0ZIqZ3fEO5rxQnRwI22uUsIJ8kVNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0fca0tpfmFNSA9m/3xn1kKd/eCQfs3kTvp8290B79vgqxo3Ic8qlZubsv4nUTYS61eODgNjFXJK1JfiHdV98+QT9pjBBw9UVsR+ASSVpbA7lLkdi68Wlk1xljfB04qm/CkXJ1cvhi2240tRoaIrytlwAbonmEDaes4LZk+GNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3KFAlBj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3KFAlBj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726103196; x=1757639196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kaI+p7sVIt84JE0ZIqZ3fEO5rxQnRwI22uUsIJ8kVNA=;
  b=E3KFAlBjhofiZldE+7e6L3ZlMxejApnihQACXRY+Q45bit/ANwprmTo1
   9Dqr3u7Ozd2wnm6eLyYA3wKR/KcUykTmKxrVzUtcI5CWzvNOXIaCHe5Iu
   0rmyatlVDz7pQ5G4trRNnsG/HVK3yC1XFkCttSxLhVsFUChMFIRXS/w4y
   xxeJBGabpy69kqBKazbZh54MjxpyKu+sJTGmpNV9XckPoEp909Q9zja80
   8IQdElOxJ3RPObQwmuKgNhBrRdzbreraGC79pYi5SHyoS20XLXSoVlIrq
   tiq0Z1oZ5WCUuuVEVcTwqJ+AItXRQwHqbrPskmUjaZBtbTh95rGIyye9/
   Q==;
X-CSE-ConnectionGUID: EjEtOkybS9ODki/MJjVK+A==
X-CSE-MsgGUID: Eh1X6uYaSaWs3WMh2WyEmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="35526792"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="35526792"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 18:06:32 -0700
X-CSE-ConnectionGUID: ukFncjO+SCa6NnvEjBPyGA==
X-CSE-MsgGUID: kJxqgSxUQRKmwRQA4o0O6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="72139172"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 18:06:31 -0700
Date: Wed, 11 Sep 2024 18:06:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net
Subject: Re: [PATCH v8 2/3] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <ZuI-lQssSZd8ml7K@aschofie-mobl2.lan>
References: <20240904001316.1688225-1-dave.jiang@intel.com>
 <20240904001316.1688225-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904001316.1688225-3-dave.jiang@intel.com>

On Tue, Sep 03, 2024 at 05:11:51PM -0700, Dave Jiang wrote:
> The current bandwidth calculation aggregates all the targets. This simple
> method does not take into account where multiple targets sharing under
> a switch or a root port where the aggregated bandwidth can be greater than
> the upstream link of the switch.
> 
> To accurately account for the shared upstream uplink cases, a new update
> function is introduced by walking from the leaves to the root of the
> hierarchy and clamp the bandwidth in the process as needed. This process
> is done when all the targets for a region are present but before the
> final values are send to the HMAT handling code cached access_coordinate
> targets.
> 
> The original perf calculation path was kept to calculate the latency
> performance data that does not require the shared link consideration.
> The shared upstream link calculation is done as a second pass when all
> the endpoints have arrived.
> 
> Testing is done via qemu with CXL hierachy. run_qemu[1] is modified to
> support several CXL hierachy layouts. The following layouts are tested:
> 
> HB: Host Bridge
> RP: Root Port
> SW: Switch
> EP: End Point
> 
> 2 HB 2 RP 2 EP: resulting bandwidth: 624
> 1 HB 2 RP 2 EP: resulting bandwidth: 624
> 2 HB 2 RP 2 SW 4 EP: resulting bandwidth: 624
> 
> Current testing, perf number from SRAT/HMAT is hacked into the kernel
> code. However with new QEMU support of Generic Target Port that's
> incoming, the perf data injection is no longer needed.
> 
> [1]: https://github.com/pmem/run_qemu
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Link: https://lore.kernel.org/linux-cxl/20240501152503.00002e60@Huawei.com/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>
> ---
> v8:
> - Fix uninitialized is_root (kbot)
> - Fix checking incorrect return value. (Alison)
> - Remove goto from cxl_region_shared_upstrea_bandwidth_update(). (Alison)
> - Add ** for kdoc. (Alison)
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


snip

