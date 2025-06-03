Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A119E975
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984058; cv=none; b=ZJTmlr+5CbfFGamT1j3qLXIk93bsPHCju7NO3fdRQ8EaGh0x2/DE+FescHj1IqkxY8aSRSrHoDvVEbwVnG9kFjBqXHilfcvBCUUcXIg3gBPGaNYAOhySTsKjbxeMBlG0y7kLs9oFxkI7p/4/jLz83Ld4tQgTEvVznIjWb5Hg/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984058; c=relaxed/simple;
	bh=s8GYQUktnYi6PsXanohGK9YuvM/bamZqGjzEwEL0XUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lt6zMhVI+DuNiSFoPU8CiNq1ValZ992xGiMCGqK5/d9BrMtqOHI4gSbfrfyuhMv4Fk3bpt7xvcrZWSCy46zxqEbKRE6EeFxp6i9uMvWJJRgeW2m1Ypy6SWIYNSy+cP4tnSH9t1nlEuqvsoAkO79b+lvAmoYdlIgJb2tgjHPWj70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExBXhj6J; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExBXhj6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748984056; x=1780520056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s8GYQUktnYi6PsXanohGK9YuvM/bamZqGjzEwEL0XUY=;
  b=ExBXhj6JAxEY3roBn2Eo/hWWfIn08jt+sIf1RvwXRaVdwwC7u78y5ZKz
   ZXsYp+fvWTEAw4ilgUXkxGqfpZuKfK82KxYka30X16OBP5AXfD23bJlZb
   4MoHgDvwU3eMmI4yTPD+rMED8Aw4eUwe6n6eL0x7mYUQZqEK47p6gfgyQ
   mTPV6gd/+BIhfJRtwzi5x3BgXFHlIcIoIGWRLJed+VOTs5v27aP9HTQfd
   F6v4kUIMgznlnACwneA7yAz1I+zB9I2ZfKRSmfa4pFanKvHRefIV4V4ng
   U1zMX8rTMrohA/wRnxNCH8XDL4XB7FkjWzyt1xIA7SAFP8KxYWc+cyCf7
   g==;
X-CSE-ConnectionGUID: IetupCj+RKyHy0bTMJ9C3Q==
X-CSE-MsgGUID: 6Z3t2vbvSgmdbmW2mrCoGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="76430204"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="76430204"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 13:54:15 -0700
X-CSE-ConnectionGUID: lITmhK8FR2GLYTltPTOH6g==
X-CSE-MsgGUID: CyZC68+gR1C8WiwG8rDUtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="150022810"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 13:54:15 -0700
Message-ID: <4ef6bcb3-93bc-4e9a-8158-9a27bf1c2267@intel.com>
Date: Tue, 3 Jun 2025 13:54:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/driver-api/cxl: Introduce conventions.rst
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: fabio.m.de.francesco@linux.intel.com, Jonathan.Cameron@huawei.com,
 rrichter@amd.com
References: <20250603185254.3730099-1-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603185254.3730099-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 11:52 AM, Dan Williams wrote:
> There exists shipping platforms that bend, break, or otherwise lean on
> ambiguities in the CXL specification. Without driver changes to accommodate
> these deviations, end users are left without CXL subsystem RAS features.
> Specifically, provisioning, error translation, and other flows require the
> CXL subsystem to understand the platforms CXL topology beyond undecorated
> memory address ranges.
> 
> Those isolated compatibility problems risk growing into deeper upstream
> maintenance burden if different platform vendors arrive at diverging
> solutions. For example, there are multiple options for resolving
> low-memory-mmio intersecting large-interleave-ways CXL windows. Linux
> should only entertain one solution to that problem.
> 
> Now, with the ACPI Specification Working Group, situations like this would
> be resolved with the "Code First ECN" process to codify Linux expectations
> in a specification. In the absence of such a process for the CXL
> specification, create a file in Linux documentation to detail the
> motivations, assumptions, tradeoffs, and proposals for amending
> specification language.
> 
> The goal is to capture the issues such that platform vendors arrive at
> compatible solutions for these problems and serve as a repository for
> potential specification updates. The expectation is to update
> conventions.rst along with CXL subsystem code changes to accommodate the
> platform topology.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/driver-api/cxl/conventions.rst | 48 ++++++++++++++++++++
>  Documentation/driver-api/cxl/index.rst       |  2 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/conventions.rst
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> new file mode 100644
> index 000000000000..662dbaf1f045
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -0,0 +1,48 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +=======================================
> +Compute Express Link: Linux Conventions
> +=======================================
> +
> +There exists shipping platforms that bend or break CXL specification
> +expectations. Record the details and the rationale for those deviations.
> +Borrow the ACPI Code First template format to capture the assumptions
> +and tradeoffs such that multiple platform implementations can follow the
> +same convention.
> +
> +<(template) Title>
> +==================
> +
> +Document
> +--------
> +CXL Revision <rev>, Version <ver>
> +
> +License
> +-------
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +Summary of the Change
> +---------------------
> +
> +<Detail the conflict with the specification and where available the
> +assumptions and tradeoffs taken by the hardware platform.>
> +
> +
> +Benefits of the Change
> +----------------------
> +
> +<Detail what happens if platforms and Linux do not adopt this
> +convention.>
> +
> +References
> +----------
> +
> +Detailed Description of the Change
> +----------------------------------
> +
> +<Propose spec language that corrects the conflict.>
> +
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 965ba90e8fb7..721a2dacf8fc 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -12,4 +12,6 @@ Compute Express Link
>  
>     maturity-map
>  
> +   conventions
> +
>  .. only::  subproject and html
> 
> base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21

