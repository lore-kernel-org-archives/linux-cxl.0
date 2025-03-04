Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD01FE45C;
	Tue,  4 Mar 2025 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082643; cv=none; b=CeD1R+vfRqCJXo0V4sQcAKTTVbUVFtBvTcA7Gpv6vwpEKzkTttnZ85McVtUvDwJUvxHCKBx50pGOBL6bfCxhDCtwgVhbBtzEJQ/ujyNUrREjFx1FlmXgKjYWUYZ3b+b/74mx+sejaimr/ntMepux+3wJPGaJYMwIuJtEdoo3VVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082643; c=relaxed/simple;
	bh=eNXhgmOKAPFYBgsCFJdUGTMScTQzlKVdSjJw46yLA0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwMcqvYAgYHBPOglYoCImU7N236RS+cFhrBI5Cu90RCxw5dFBJYbePRVm4kPNl23TGDHSfpaIUOtJ7YsfJYbAaAgZknrt/aGrQ+JhYUVRMM4Z09EE1w8jf9V6B/iCZUdrqVxJq4ybfhvAtlq5yPPm5B5SlqMQ7BPNJ1U0KbTVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f06wEpVy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f06wEpVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741082643; x=1772618643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eNXhgmOKAPFYBgsCFJdUGTMScTQzlKVdSjJw46yLA0g=;
  b=f06wEpVyCHr4WtJzYHiWCeEW5xXyt4hiS0l+n0Q4/xiTXLW33ej27eC9
   v67rEQ6aA35l/huAtRXRldIxJPZ6G+nR+2CMsnDscVeV17+D+fjuN8DDD
   0Wt/x2full2Hu2AsvKsOJXb4/lt7VILUyF/5HnkFSn6oQ81pGlNEnDSSC
   KKvBXLvhz0/nnMCzMFQue0gzqTpUSg4JG+7cOFLvk55zPLTfOfwSgBlIh
   H6/oJapQW5sNsH487DNDeS0gWXD55AKK6rlAv7+kuXNczbRXhi4EGy6hy
   gcLanPNNV85OTv+VXNjyE6/zEcChBEXpz2xKzsHplp9HRHMh9mDjF1Mlx
   A==;
X-CSE-ConnectionGUID: H9a2og+LTXe4mPh3cm7jAw==
X-CSE-MsgGUID: rMsk3JpnRcevOJG9q5WFlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45642543"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="45642543"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 02:04:01 -0800
X-CSE-ConnectionGUID: EUZ1qz/HTE2Nx7HNvM+Tjg==
X-CSE-MsgGUID: yeGfgjNiQcuPnSV3cQjV6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123270024"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 04 Mar 2025 02:03:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 03B5018F; Tue, 04 Mar 2025 12:03:56 +0200 (EET)
Date: Tue, 4 Mar 2025 12:03:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Message-ID: <20250304100356.GI3713119@black.fi.intel.com>
References: <20250304043415.610286-1-lizhijian@fujitsu.com>
 <20250304092219.GH3713119@black.fi.intel.com>
 <7e01507e-deb2-4acb-a2b7-530beb0d92dc@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e01507e-deb2-4acb-a2b7-530beb0d92dc@fujitsu.com>

On Tue, Mar 04, 2025 at 09:44:38AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 04/03/2025 17:22, Mika Westerberg wrote:
> > On Tue, Mar 04, 2025 at 12:34:15PM +0800, Li Zhijian wrote:
> >> The leak is detected by the kernel memory leak detector (`kmemleak`)
> >> following a `cxl create-region` failure:
> >>
> >>   cxl_acpi ACPI0017:00: decoder0.0: created region2
> >>   cxl region2: HPA allocation error (-34) for size:0x0000000100000000 in CXL Window 0 [mem 0xa90000000-0x1a8fffffff flags 0x200]
> >>   kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> >>
> >>      __kmalloc_cache_noprof+0x28c/0x350
> >>      get_free_mem_region+0x45/0x380
> >>      alloc_free_mem_region+0x1d/0x30
> >>      size_store+0x180/0x290 [cxl_core]
> >>      kernfs_fop_write_iter+0x13f/0x1e0
> >>      vfs_write+0x37c/0x540
> >>      ksys_write+0x68/0xe0
> >>      do_syscall_64+0x6e/0x190
> >>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>
> >> Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >>   kernel/resource.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/resource.c b/kernel/resource.c
> >> index 12004452d999..aa0b1da143eb 100644
> >> --- a/kernel/resource.c
> >> +++ b/kernel/resource.c
> >> @@ -2000,6 +2000,8 @@ get_free_mem_region(struct device *dev, struct resource *base,
> >>   		devres_free(dr);
> >>   	} else if (dev)
> >>   		devm_release_action(dev, remove_free_mem_region, res);
> >> +	else
> >> +		free_resource(res);
> > 
> > It should use {} as per coding style:
> 
> 
> The script/checkpatch.pl is happy with both of these 2 styles in practice.

It is but the coding style prefers then use {} around all branches, see:

https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces

	} else if (dev) {
		devm_release_action(dev, remove_free_mem_region, res);
	} else {
		free_resource(res);
	}
