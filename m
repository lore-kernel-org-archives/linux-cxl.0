Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328F356778
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419902; cv=none; b=lQHc455tEH13v+Q17rgCP4j3HN64abLRiGJmJSJcUo4koxy9KxKL6MUsKWzUqUAgtGIpMgxekCFbqIM4IeszRqlrOwMK1n0i2pjLAUxOcxRj3XjqJ8bAsnlTRiRwW+7fgkUbRHRwpsxLWaJA+b70lV4F5E38y/c7gK/nFsZYQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419902; c=relaxed/simple;
	bh=5w+LBy0PAEenUJPyoZyxFB3+CM1V+DWrNjckbWTdQQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I22i3uVpWQCFIOandZDdGn6MdFaTdUf+okZV23OhLcGqkySFVbxQ9hkTAdCRWbpH3x2qzexGW0osIUUxDdt/AwQ1DQZExDWdQdr28uUlnxTyYY+TKbV77mG7Q/i7PG/jU9yDK6rze+FXjPrcX+CFE3y7XP3K3xhgtIkgMv6lXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoK+mbnA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoK+mbnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789419900; x=1820955900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5w+LBy0PAEenUJPyoZyxFB3+CM1V+DWrNjckbWTdQQU=;
  b=UoK+mbnA+9Kv5eMFlbwHPjkWTdhvI6TrmU83Pq7BMHBajYmGTwcRsptO
   D0QJk8aWVqTJhGbp8X3TtODc2DpB1/0LwLNp94HVnB7EHAcyDymjPl0KE
   rJlLxU0v1jhuwV8i/ea2tdUlWpOSlw8jmd+EXmLmWBY+OTa1puEK/LpIT
   c40iCY6NnBsy6DmTdDRf7pDbaFqK9WB/lg7vU4/fjP5rib+GN+ea5Nq9h
   92HQKUf7aVuYi8tOucrrIACjFyI5uIXMmJeSxdNTiD1M9nm7bejOBwB+H
   nrk567+TL+3m7K7NpuXwa9JQXND6acXc/UHsgLh8E6zMsfREBG0H78+mU
   g==;
X-CSE-ConnectionGUID: jidNCN2WQJCzU2I+drkbTA==
X-CSE-MsgGUID: UKFcDq6iS3u6VtoBGf6xUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77338904"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77338904"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 14:04:59 -0700
X-CSE-ConnectionGUID: g898QpXmQ9e4tEBFMDXA2w==
X-CSE-MsgGUID: MeMCjbJlSt+/W2oE/1x+/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296237333"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.142]) ([10.125.108.142])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 14:04:58 -0700
Message-ID: <c81280ca-e764-4699-ac6b-221e12ed7b1b@intel.com>
Date: Mon, 14 Sep 2026 14:04:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] cxl: Fix uninitialized access coordinates
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260831092216.540644-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260831092216.540644-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/26 2:22 AM, Guixin Liu wrote:
> Two fixes for uninitialized access_coordinate reads found by inspecting
> the CXL bandwidth calculation paths.
> 
> Patch 1 zeroes the coordinate arrays that cxl_endpoint_gather_bandwidth()
> and cxl_switch_gather_bandwidth() declare on the stack. Patch 2 zeroes
> the output array of cxl_endpoint_get_perf_coordinates() when it returns
> early for a Restricted CXL Device.
> 
> Testing:
> 
> Patch 1 was tested on a QEMU CXL topology with a switch and two volatile
> endpoints sharing the switch upstream link. The kernel needs HMAT
> generic-port coordinates for the host bridge to run the calculation at
> all: without them the host bridge dport coordinates stay empty,
> cxl_endpoint_get_perf_coordinates() returns -EINVAL, the endpoint DPA
> perf is never populated, and cxled_get_dpa_perf() fails before either
> gather function touches its arrays.
> 
>   -machine q35,accel=kvm,cxl=on,hmat=on
>   -object acpi-generic-port,id=gp0,pci-bus=cxl.0,node=1
>   -numa hmat-lb,initiator=0,target=1,hierarchy=memory,\
> data-type=access-latency,latency=100
>   -numa hmat-lb,initiator=0,target=1,hierarchy=memory,\
> data-type=access-bandwidth,bandwidth=1G
> 
>   cxl create-region -d decoder0.1 -m mem0 mem1 -t ram -s 2G -w 2 -g 256
> 
> With a temporary printk added after cxl_pci_get_bandwidth() and after
> cxl_coordinates_combine(), an unpatched kernel
> (CONFIG_INIT_STACK_ALL_PATTERN) printed:
> 
>   REPRO ep_gather 0000:35:00.0: after cxl_pci_get_bandwidth
>       pci_coord[LOCAL] rd_lat=0xfefefefe wr_lat=0xfefefefe
>   REPRO ep_gather 0000:35:00.0: after combine
>       ep_coord[LOCAL] rd_lat=0xfefeff94 wr_lat=0xfefefff8
>   REPRO sw_gather 0000:36:00.0: after cxl_pci_get_bandwidth
>       coords[LOCAL] rd_lat=0xfefefefe
> 
> The latency members read back as the pattern-init stack filler, and the
> combine step sums that residue into ep_coord. With the patch the same
> probes read 0x00000000 before the combine and the CDAT latency values
> (0x96 / 0xfa, the 150/250 ns QEMU puts in DSLBIS) after it.
> 
> Not covered: the bandwidth members keeping residue into the region sysfs
> attributes requires an endpoint whose CDAT reports zero bandwidth for an
> access class. QEMU synthesizes non-zero DSLBIS values by default, and
> supplying a custom CDAT with a zero entry was not done.
> 
> Patch 2 is not tested: reaching the path requires an RCD, which needs a
> CEDT CHBS of the CXL 1.1 version, and QEMU only emits CXL 2.0 CHBS
> entries and has no RCD device model.
> 
> v3 -> v4:
> - rework the changelogs to state the failing condition, the consequence
>   and the fix rather than narrate the walk through CDAT parsing,
>   __cxl_coordinates_combine(), QoS class selection, cxl_dpa_perf and
>   sysfs (Alison Schofield)
> - say how each issue was found and how each patch was tested
>   (Alison Schofield)
> - drop the -EEXIST claim and the rest of the v2 framing that assumed
>   cxl_pmem could be unloaded or unbound
> 
> v3:
> https://lore.kernel.org/linux-cxl/\
> 20260812083035.372308-1-kanie@linux.alibaba.com/
> 
> Guixin Liu (2):
>   cxl/cdat: Fix uninitialized stack use in bandwidth gathering
>   cxl/port: Fix uninitialized coordinates reported for RCDs
> 
>  drivers/cxl/core/cdat.c | 8 ++++----
>  drivers/cxl/core/port.c | 4 +++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

Applied to cxl/next:
ab3b6103ac16
6cb3057628ad

