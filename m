Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657192;
	b=mgOXeiWGX7MGWhKMiM0O6uNRlZUjo0cJ8ORQOEUcDVacw8jjndGzqhavajwP+oOAB1sB
	 fG9EiBym6XktJbxEOoe+TVBhQ49Q6eA1Y8PB9WUva/USTYsChTsYfOTZUFmf9r9tZHXpi
	 PlBCLRZMwLNocMlc05vRbbaO1JcqKBvMY+t3iIlCxZswTZN3+bxEf8vL2fB4CR/uUCKlt
	 Iz0FPjTELgZFkpOciq3ZGVxZh0JRyXuD10sVlKMKXrk0mj4AfD/hudlj9LOucEaPcbh1E
	 nalOziBb/Xw0kjttjO5nRObnQJ8Ima2VS7NeZWpTdyDIgj0FpsnNalR2lTN5KxdPQzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657192;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HwLWLIyUJ0kAVQURbxRObzKBu/+r1yTzSrESPfvGcHo=;
	b=Sh8RvWfqm+ZJioZY7n80uPBVN9gRRT5DvWbAKEBIrx5a8GL3Gy3Vep9MncK/rZxtkvRr
	 yI1y2nnnxvpes6dg4tplNWxzgVcWQzfvRcyALj94DR5FmmrPUUwT0ACxeFGmbErVC6CDW
	 aCPEPmcsrSZpd9+e9+YoEumPHFngUJz4OYYfCBmvbGUqM8inoj4afY9+iKsChCCv3Mfnr
	 1FIBfJdOLE8sMYzi9uuqJzV5WEeawX7vaxmHGWonNRiYCe61dVGMd3uyr3SHE1AlFSHSp
	 V+XA4Dkrolw9jMBXaVij/OG4sRhIEnpdAkGfY+jXgdZQjaqG3yZOBXVsbV3zeevGATg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="M/nLZuLd";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB4606A327
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 22:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14FB4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M/nLZuLd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793657191; x=1825193191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wWJQQku3j1kg+OxEQ5kV+vBeuHEJ5nXAZS/Tm/8frqY=;
  b=M/nLZuLdDtcWttozni7hL5k4Ttx0b8ePHlMG2QcNWzKVTspVdaAac/ZY
   P3ife+4PiBO+Fle14jz42kOvzYvMi67UYWTRW1lH80BluYjpuIW7+T9sj
   JE7l3VOvt2AShQrNnbOZ+QdyR3C5t8u0RlpCqE6KEknrR1pqQEbUnVaJx
   PX7a3/Fv47IRIBEcq5r/P5Df7zOzg1Je7eGkoqLJYDWf0RT/6kC7pD7Wt
   fHEIW3Xn2nLqPfZ6JRMIb1JjlrZqEm1m0/AzMJwPypacfIPN4kHdSLiuP
   Rc2Q8YNMKDgWRpbqAXa1eZRB1NYs4iAIKHSm616utPHvkoF3xKQxhdYIy
   Q==;
X-CSE-ConnectionGUID: PhN7mhcFShm5Xt2t/4KzGQ==
X-CSE-MsgGUID: tBXYptH6RGWQOhAlxAdjXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2247370"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2247370"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:06:30 -0800
X-CSE-ConnectionGUID: YCfzMueSQ+mxAx9b9gwnng==
X-CSE-MsgGUID: 9p1shNaJTjuRoLUgf+eWnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6558843"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.163]) ([10.125.109.163])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:06:29 -0800
Message-ID: <631519e3-11e7-4e51-bcdd-c24be4862adc@intel.com>
Date: Mon, 2 Nov 2026 15:06:28 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] cxl/region: Refactor cxl_port_setup_targets()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1793649898.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1793649898.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/26 1:15 PM, Alison Schofield wrote:
> 
> Changes in v5:
> - Update patch 4 commit message w test result & benefit info (RichardC)
> - Rebase on 7.4-rc1
> v4: https://lore.kernel.org/all/cover.1792263750.git.alison.schofield@intel.com/
> 
> Changes in v4:
> - Pass cxlsd to cxl_switch_port_setup_targets() (DaveJ)
> - New Patch 4 from Richard, only calc peer distance on target reuse (RichardC)
> - Add function comment to cxl_port_parent_interleave() (RichardC)
> - New Patch 8 simplifies control flow (MingL, JonathanC)
> - Remove claim in cover letter of a strictly mechanical refactor
> - Drop LLM tags per latest guidance
> v3: https://lore.kernel.org/linux-cxl/cover.1791860305.git.alison.schofield@intel.com/
> 
> Changes in v3:
> - Drop patch "cxl/region: Name the interleave locals in cxl_port_setup_targets()".
> - Move the distance comment above cxl_port_peer_distance() (Jonathan)
> - Name the out-params out_iw/out_ig.
> - Minor reverse fir and alignment cleanups
> - Reorder the cxl_port_calc_interleave() declarations
> v2: https://lore.kernel.org/linux-cxl/cover.1791676454.git.alison.schofield@intel.com/
> 
> Changes in v2:
> - New patch 3 adds 'switch' to cxl_port_setup_targets() name (DaveJ)
> - Add 'switch' to cxl_port_add_target() name (DaveJ)
> - Pass the switch decoder to cxl_switch_port_add_target (DaveJ)
> - Minor commit message updates based on function renamings
> v1: https://lore.kernel.org/linux-cxl/cover.1791575481.git.alison.schofield@intel.com/
> 
> 
> Begin Cover Letter:
> cxl_port_setup_targets() has grown to nearly 200 lines. It open codes each
> step of adding an endpoint to a port's decoder: finding the distance
> between peer positions, reading the parent interleave, calculating and
> validating the port's interleave, setting up the decoder, and adding the
> target.
> 
> This set is inspired by review feedback from Robert Richter on the series
> that adds mixed-granularity region support [1]. That series needs to change
> how this function calculates interleaves and Robert asked for that new code
> to be moved into a helper. Rather than tidy only the new code, this set
> splits up the whole function first.
> 
> Patch 1 prepares the code that moves. It is a suggestion Jonathan offered
> on the mixed gran series.
> 
> Patch 2 renames the function to cxl_switch_port_setup_targets(), since it
> configures switch decoder targets, and changes its parameter to accept a
> switch decoder rather than a port, both DaveJ suggestions.
> 
> Patches 3-9 extract the individual steps into helpers and add two new patches:
> RichardC's patch 4 avoids calculating peer distance when an endpoint adds a
> new target, and patch 8, suggested by Ming and Jonathan, removes the goto paths
> before the final helper is extracted.
> 
> The result reduces cxl_switch_port_setup_targets() to 53 lines.
> 
> [1] https://lore.kernel.org/linux-cxl/cover.1788475206.git.alison.schofield@intel.com/
> 
> 
> Alison Schofield (8):
>   cxl: Add interleave encoding validity helpers
>   cxl/region: Rename cxl_port_setup_targets() to
>     cxl_switch_port_setup_targets()
>   cxl/region: Factor out cxl_port_peer_distance()
>   cxl/region: Factor out cxl_port_parent_interleave()
>   cxl/region: Factor out cxl_port_calc_interleave()
>   cxl/region: Factor out cxl_port_setup_decoder()
>   cxl/region: Simplify switch port target setup control flow
>   cxl/region: Factor out cxl_switch_port_add_target()
> 
> Richard Cheng (1):
>   cxl/region: Calculate peer distance only for reused targets
> 
>  drivers/cxl/core/region.c | 243 +++++++++++++++++++++++---------------
>  drivers/cxl/cxl.h         |  21 ++++
>  2 files changed, 172 insertions(+), 92 deletions(-)
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

Applied to cxl/next:
0e3e8b653ca3 cxl/region: Factor out cxl_switch_port_add_target()
127ea4404a12 cxl/region: Simplify switch port target setup control flow
a8aaec84078b cxl/region: Factor out cxl_port_setup_decoder()
e2720e46d4ed cxl/region: Factor out cxl_port_calc_interleave()
96a2f5773a27 cxl/region: Factor out cxl_port_parent_interleave()
dfa9daea3c00 cxl/region: Calculate peer distance only for reused targets
88262ac09371 cxl/region: Factor out cxl_port_peer_distance()
d523a24a97c4 cxl/region: Rename cxl_port_setup_targets() to cxl_switch_port_setup_targets()
20ae97ad3349 cxl: Add interleave encoding validity helpers

