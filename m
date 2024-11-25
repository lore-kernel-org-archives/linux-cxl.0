Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F738188724;
	Mon, 25 Nov 2024 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572046; cv=none; b=SO4Yhli0xLvEzjUeRE/PFyY/VtZ3FGxAo0rUn3H42PV0wTAINBtyDgmqnXGvErKZzmL3CCIQw6hz+ZO5rfjdcrHgPlX9JoSofv2CbV3q2Vv6J9fXzzNGQev5LLF0NP6aZgkpF56hFaN2goi2akO4NVdfYx0CbFqdTXUxsMWkm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572046; c=relaxed/simple;
	bh=8u41YQYJmclz4J1+W4jjBdW970YpXjz0B0zRJrxDJeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxFgXoQps9af15q0WxQhqn6ZasDP3Vi9H7lI3NcGsiRniC+9LjelHWjv6P+xzRi5634D1+GsfRHtg3UEAX4jyAS+b1duwCQ3LKY7fGOHGC763qHL23LWeGpYLW7T1fRgscoiHcc4snQxuiTt9jKC1rp4rv3q1j5Pu8XS8/zFT+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtT8OH1g; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtT8OH1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732572044; x=1764108044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8u41YQYJmclz4J1+W4jjBdW970YpXjz0B0zRJrxDJeI=;
  b=jtT8OH1gAKB/EFXdpoxb/lMh0FHJv/Ib3FkBr+Rx9tJsLvsWW2sgnN1v
   0vQ9lNbZ80aK+ruWF4Q/lS/E9sjkmbgbWW6LOM7EehaNrF7nvuN+67iIs
   oDptyxVxaYVLrE+5viTWEl1XeofTM6gczUTXNFmdtFSUV+s3xxHQ+yh8i
   Ppg7oq/TpsIz8cgO5c5nAzpakmjC9ZeGUw5tXi2lDtiauofSfXdvuRw5L
   0Xtr+BIjVMcYHcCVG1NlzfwaTV32bK6OmH0gPd3ALiyGZF/vNBPk4oT9K
   5hy/ZXf8DTVm/RXxbhtFYqnCKRz+mLd2XIwUhYQpleBa1hqEsogTd2rn6
   Q==;
X-CSE-ConnectionGUID: 3nr6UKoeTV2KP4vHQQYeyg==
X-CSE-MsgGUID: eojPfOP9TKe2hH30oXIHRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="20296349"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="20296349"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 14:00:44 -0800
X-CSE-ConnectionGUID: cKVLpf+gTy66x7ByZR0p+g==
X-CSE-MsgGUID: cg4RE0S0TOiuq/058H8hxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="96482843"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.188])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 14:00:43 -0800
Date: Mon, 25 Nov 2024 14:00:41 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/3] cxl/core: Enable Region creation on x86 with Low Mem
 Hole
Message-ID: <Z0Tzif55CcHuujJ-@aschofie-mobl2.lan>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>

On Fri, Nov 22, 2024 at 04:51:51PM +0100, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. On those systems, BIOS
> publishes CFMWS which communicate the active System Physical Address (SPA)
> ranges that map to a subset of the Host Physical Address (HPA) ranges. The
> SPA range trims out the hole, and capacity in the endpoint is lost with no
> SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, the driver fails and returns an error because it
> expects that the CXL Endpoint Decoder range is a subset of the Root
> Decoder's.
> 
> Then detect SPA/HPA misalignment and allow CXL Regions construction and 
> attach if and only if the misalignment is due to x86 Low Memory Holes.
> 

Hi Fabio,

I took this for a test drive in cxl-test - thanks for that patch!

Here's a couple of observations on what users will see. Just stirring
the pot here, not knowing if there is, or even needs to be an explanation
to userspace about LMH.

1) Users will see that the endpoint decoders intend to map more than the
root decoder. Users may question their trimmed region size.

2) At least in this example, I don't think users can re-create this
region in place, ie via hotplug.  Once this region is destroyed, we
default to creating a smaller, aligned region, in its place.

cxl-cli output is appended showing the auto created region, it's decoders,
and then the creation of a user requested region, not exactly in its
place.


Upon load of cxl-test:

# cxl list -r region0 --decoders -u
[
  {
    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":"0xf010000000",
        "size":"768.00 MiB (805.31 MB)",
        "interleave_ways":1,
        "max_available_extent":0,
        "volatile_capable":true,
        "qos_class":42,
        "nr_targets":1
      }
    ]
  },
  {
    "port decoders":[
      {
        "decoder":"decoder1.0",
        "resource":"0xf010000000",
        "size":"1024.00 MiB (1073.74 MB)",
        "interleave_ways":1,
        "region":"region0",
        "nr_targets":1
      },
      {
        "decoder":"decoder6.0",
        "resource":"0xf010000000",
        "size":"1024.00 MiB (1073.74 MB)",
        "interleave_ways":2,
        "interleave_granularity":4096,
        "region":"region0",
        "nr_targets":2
      }
    ]
  },
  {
    "endpoint decoders":[
      {
        "decoder":"decoder10.0",
        "resource":"0xf010000000",
        "size":"1024.00 MiB (1073.74 MB)",
        "interleave_ways":2,
        "interleave_granularity":4096,
        "region":"region0",
        "dpa_resource":"0",
        "dpa_size":"512.00 MiB (536.87 MB)",
        "mode":"ram"
      },
      {
        "decoder":"decoder13.0",
        "resource":"0xf010000000",
        "size":"1024.00 MiB (1073.74 MB)",
        "interleave_ways":2,
        "interleave_granularity":4096,
        "region":"region0",
        "dpa_resource":"0",
        "dpa_size":"512.00 MiB (536.87 MB)",
        "mode":"ram"
      }
    ]
  }
]

After destroying the auto region, root decoder show the 768MiB available:

# cxl list -d decoder0.0 -u
{
  "decoder":"decoder0.0",
  "resource":"0xf010000000",
  "size":"768.00 MiB (805.31 MB)",
  "interleave_ways":1,
  "max_available_extent":"768.00 MiB (805.31 MB)",
  "volatile_capable":true,
  "qos_class":42,
  "nr_targets":1
}


# cxl create-region -d decoder0.0 -m mem5 mem4
{
  "region":"region0",
  "resource":"0xf010000000",
  "size":"512.00 MiB (536.87 MB)",
  "type":"ram",
  "interleave_ways":2,
  "interleave_granularity":256,
  "decode_state":"commit",

snip

# cxl list -r region0 --decoders -u
[
  {
    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":"0xf010000000",
        "size":"768.00 MiB (805.31 MB)",
        "interleave_ways":1,
        "max_available_extent":"256.00 MiB (268.44 MB)",
        "volatile_capable":true,
        "qos_class":42,
        "nr_targets":1
      }
    ]
  },
  {
    "port decoders":[
      {
        "decoder":"decoder1.0",
        "resource":"0xf010000000",
        "size":"512.00 MiB (536.87 MB)",
        "interleave_ways":1,
        "region":"region0",
        "nr_targets":1
      },
      {
        "decoder":"decoder6.0",
        "resource":"0xf010000000",
        "size":"512.00 MiB (536.87 MB)",
        "interleave_ways":2,
        "interleave_granularity":256,
        "region":"region0",
        "nr_targets":2
      }
    ]
  },
  {
    "endpoint decoders":[
      {
        "decoder":"decoder10.0",
        "resource":"0xf010000000",
        "size":"512.00 MiB (536.87 MB)",
        "interleave_ways":2,
        "interleave_granularity":256,
        "region":"region0",
        "dpa_resource":"0",
        "dpa_size":"256.00 MiB (268.44 MB)",
        "mode":"ram"
      },
      {
        "decoder":"decoder13.0",
        "resource":"0xf010000000",
        "size":"512.00 MiB (536.87 MB)",
        "interleave_ways":2,
        "interleave_granularity":256,
        "region":"region0",
        "dpa_resource":"0",
        "dpa_size":"256.00 MiB (268.44 MB)",
        "mode":"ram"
      }
    ]
  }
]

