Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954C189513
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749487889; cv=none; b=M1Ls4PqC8j2lzkOdBdfULR9kD4Zs1JuntRvcG8cC7E4v6Nut5V/MAUL2BuATlICYgG8YTy5FVOqkFgMYWN5EHpdTFXjZJYWChshoy98lG04m0ahzwzCcpzBlKbIQH9n5LZcLS7MWTZACYzl3MUfPBR2bYzNGH9P9194Bp4I9OY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749487889; c=relaxed/simple;
	bh=2JKuz9nZG6GESCqspdQ7bOGdSE5TuriqIYJFH5bxThY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaRFR2Bz6irMnUNogkcjdeKZeBQ+H3IyEh/OYPrMpCA52FWu0aBhk9Bpzy20chYue8RxRmEXq5E3g4t3rwemb/LP9AEvPDxHX9uY+GdaiqAcd+NwHeRVxmTB7tUKcfjTDvhggntfH41hxi9t8TJfPK01haK3l+dygLJBedQMfr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWyCoL5D; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWyCoL5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749487887; x=1781023887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2JKuz9nZG6GESCqspdQ7bOGdSE5TuriqIYJFH5bxThY=;
  b=KWyCoL5DV9bECDx6x/CtISuuAP6HixLpziG1X/j4ttFmVz4WPDSt3Tt7
   BFpXKBT3dKoO1wvJy6ATb7R1Z925eqpUpCPpmelhw0XcJ9qiAdETr7ZJY
   KhiED76QZRag5ODD96myTuPYtE2a385jVm5XekSNHQXxHfbqWF7dB9FIH
   Uo3uk5gHgqgaOUdLRgkuCDFLls+I48plGKguMtaK414du1BfFHTS8G/9N
   Xqy/sUWgTIVcG+YpBj/qaU5LlklvPw4Z+VXPHyyUubPUV3OK7vRwbmcMG
   rNC+HNYluhSL7gVLAlPrIrzzHxL/tLMF7UHglvm3gMM8e7UIp1lrwhfEm
   Q==;
X-CSE-ConnectionGUID: 3n6tOSeqTZ+OxiOQZ3xoog==
X-CSE-MsgGUID: CzHj97IGRPmQeiF+A5a4oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69133819"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="69133819"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:51:26 -0700
X-CSE-ConnectionGUID: EYr83CLoTdCAJ9s/MUkhCA==
X-CSE-MsgGUID: jFpDZv2AQOGnYUZhbZ7Aqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="146469776"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:51:26 -0700
Message-ID: <1e31a20f-9b9a-4bb5-ba13-3ab2365a8a98@intel.com>
Date: Mon, 9 Jun 2025 09:51:25 -0700
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

Applied to cxl/next

Rebased against v6.16-rc1

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

