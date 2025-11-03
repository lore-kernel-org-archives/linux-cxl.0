Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E4306B3C
	for <linux-cxl@vger.kernel.org>; Mon,  3 Nov 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213648; cv=none; b=oCzXK/YXB6giXzHyr1kvpEoLI2tFEELfy9acRRcLvuUFc9Dqb0uGTNfZWQdWhdLDRReOCBjTnajAqBLiS2JKYSmQmxaNwGx7QjYxpDEe8V9vQiSEXDQcq4i99Eyp/G/PKVTprGv+tXKLV+AZ5+KHWZ3Zt++2reIQGh5ObBKe9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213648; c=relaxed/simple;
	bh=LYxCztkWGlL1rMULFRLZX1hRWmLaiUjZNsJh7HNLuFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9W2IUW42di9C+XSibmUEJ8tqgAvhx4DkW9E585nTW3RhxT7DaUK5gMaQ2sXio9xtsdXJ/9HUWFp8+2CUm8HiF2EjH3u80rrwmR0Ruwa4i16Mdqt2gRwMTjGLquSdxLD9r+G/rMLQl692cxWy2vBCntGPpzCoFQMpbw6c8lRf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLSN/7Ow; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLSN/7Ow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213647; x=1793749647;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LYxCztkWGlL1rMULFRLZX1hRWmLaiUjZNsJh7HNLuFY=;
  b=TLSN/7OwAWfTSV94PmeotvohnAY0uPSTBmR+jAi0csCB48llSNJPZJ2u
   wttO1JSZ05nS88F2VvifcER5ipKUYguiNw5RKcu0L4X4aI+k0qWlcI/46
   6iKl5fOFUVfmCMe540CtXjyoJlxXLrRxt/ouWxLMp/0PUE1jKr97QFd9Y
   NLa6EKwkxqIbnBguyYHNbxelGG8R9XzGdKvINzM74MKsWTRq0IhzT33aD
   VuaY/9nx2J2BOIgMpirtTr+vVAx3Gr8HB2FkvvG5Ln95nLq6JBOqlZLGH
   /KfAfydV718zS6eKzrehmOE3Q4veIumhuHpyrpWJRnsWbqeUdyDn3lHZD
   w==;
X-CSE-ConnectionGUID: ZEgwbOFMSi+P1tD6ieOwkg==
X-CSE-MsgGUID: 3uFydBfZS2+61VienXICjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64451649"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64451649"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:47:26 -0800
X-CSE-ConnectionGUID: IpI6k8W9RG+pbwH7SY7stg==
X-CSE-MsgGUID: Yc/6mkrjTZifp28TRjdnVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186679017"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:47:25 -0800
Message-ID: <82ad4eec-2b1e-4683-89f3-375518f896bc@intel.com>
Date: Mon, 3 Nov 2025 16:47:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] CXL: Add a loadable module for address translation
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1760429439.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1760429439.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 1:24 AM, Alison Schofield wrote:
> Changes in v4:
> - Rebase on 6.18-rc1
> - Sync to a rename: EXPORT_SYMBOL_FOR_MODULES per a 6.18-rc1 patch
> 
> Changes in v3:
> - Rebase on latest cxl/next
>   This set is posted for review based on cxl/next because it depends on
>   SPA->DPA translation work only in cxl/next (the poison by region offset
>   set). When cxl/next becomes v6.18-rc1, I'll rebase and resend.
> - Replace __mock_exports with EXPORT_SYMBOL_GPL_FOR_MODULES()
> - Replace (u64)GENMASK() w GENMASK_ULL() (DaveJ)
> - Refactor cxled lookup in cxl_dpa_to_hpa() (DaveJ)
> - Move struct cxl_cxims_data to cxl.h (DaveJ)
> Below is new functionality in v3:
> - Add and EXPORT cxl_validate_translation_parameter().
>   This consolidates param validation in region.c and exporting it enables
>   testing.
> - Add a test of cxl_validate_translation_parameter() to test module.
> - Add a random test of the exported CXL Driver translation functions.
> 
> Changes in v2:
> - Rebase on cxl/next
>   This set has dependencies on patches only in cxl/next.
> - Make the new helpers static by default, exportable for tests (Dan)
> - Restore useful dev_dbg() message for invalid position (Jonathan)
> - Create and free cxims data struct in test module (Dan)
> - Make some test module comments kdoc's (Jonathan)
> - Move a block comment to new helper (Jonathan)
> - Remove useless check for ULLONG_MAX (Jonathan)
> 
> 
> This series refactors CXL address translation code to support testing
> and adds a dedicated test module for validation of the translation
> calculations.
> 
> The work is presented in 3 patches:
> 1. Extracts the core translation logic into standalone, testable functions.
> 2. Provides access to XOR interleave calculations also with a standalone
>    testable function.
> 3. Adds the test module that validates both Host to Device, and Device
>    to Host address translations.
> 
> The CXL Driver functions are made available to the test module using
> EXPORT_SYMBOL_FOR_MODULES() for cxl_translate only.
> 
> The companion CXL Unit Test script is posted separately.

Applied to cxl/next
1df783ccfa2d45b4c29ccf2104986e112885ad76


> 
> 
> Alison Schofield (3):
>   cxl/region: Refactor address translation funcs for testing
>   cxl/acpi: Make the XOR calculations available for testing
>   cxl/test: Add cxl_translate module for address translation testing
> 
>  drivers/cxl/acpi.c                     |  41 ++-
>  drivers/cxl/core/region.c              | 204 ++++++++----
>  drivers/cxl/cxl.h                      |  19 ++
>  tools/testing/cxl/test/Kbuild          |   1 +
>  tools/testing/cxl/test/cxl_translate.c | 445 +++++++++++++++++++++++++
>  5 files changed, 638 insertions(+), 72 deletions(-)
>  create mode 100644 tools/testing/cxl/test/cxl_translate.c
> 
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

