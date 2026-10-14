Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C99541DDF0
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011162; cv=none; b=b4bdHi78keQZsjQwwSKeMylVc5/PAZszjmJbARQa6WdD9LC/QcVuJN9qw9mi1+nWNbrCmfRZrYEZoLxaIouYKQl2ML0vUPOm0l9L6KPwT5l68js0xywe+IDPuaE//ZaZw9Wbn87sPia1eXXSvQiGgtI1AGJqG5n3ZPYmRZkWeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011162; c=relaxed/simple;
	bh=MLhT4VAkXmZ3D1zM82caZwspFMoBnQSTcO/SI7wJ64M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4EC6p5Bf97E1ysyhicT0S2xVSKCqbeI3xZT8iEqNP+Iz+TcKPj0sGkLyZaXtbBGwdaoB9iUUeW4Zo4vXvhZyWYRhzgvsrNP586BTSsm8McEzmGybSWJHrCOsImx3ifePr/eoChDWWXpluKT4NztNPbVtxSV2JV1dXjh+NdNUgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOHg3Sh+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOHg3Sh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792011159; x=1823547159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MLhT4VAkXmZ3D1zM82caZwspFMoBnQSTcO/SI7wJ64M=;
  b=SOHg3Sh+iJ8BNg+jyD+2ka8OzNgKbcxV+ZrYOzYUqJD14O/I2p87uGG5
   uul6sHT0S/2K8de0hsP5VYPN6b6sKJBOBSOrgqntLbJ+ZoFghTL9IY617
   SQ1Sg2tqEwEwgxnzFYoftb/gDQnGQ3NuqCm6lnQbXbKGiPQNvO6A6ojTU
   gzEol/+Twkgyg6yPqfvfMFhKUnbGEH8j/vP9ICxf7dhWCLJCyz3eyieWk
   N1QJzqooZA8LlAFCRRLBeDHwEJTRA36MeTsJOjq0e1kNSDpp/W9Qd1o01
   ucN6IxajjFvGGh564ZD4kvyb+fkjQvvvGnAmgvLSuJ11Jdrcjv4lgWtlB
   g==;
X-CSE-ConnectionGUID: Ts3FX8ysSbawP46h6LEQ6A==
X-CSE-MsgGUID: jaaI/w1SSQ2pIv6EdoZdcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="648906"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="648906"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 13:52:38 -0700
X-CSE-ConnectionGUID: fzGr4JjwTcWdnB7R5vmOUg==
X-CSE-MsgGUID: gdA3YypjRlOGx7JPNr/cUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3361647"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.36]) ([10.125.110.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 13:52:37 -0700
Message-ID: <9247c159-2ea0-4a69-b795-0583cbd078a1@intel.com>
Date: Wed, 14 Oct 2026 13:52:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cxl: Add KUnit tests and documentation
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791949910.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1791949910.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/26 9:17 PM, Alison Schofield wrote:
> The CXL subsystem has no KUnit tests. Its automated test coverage comes
> from cxl_test and the ndctl suite, which exercise the driver stack through
> an emulated CXL topology. KUnit complements that coverage by testing self-
> contained logic and error paths in isolation.
> 
> This series introduces CXL KUnit infrastructure and documentation describing
> how it complements the existing cxl_test coverage.
> 
> The first KUnit suite, a collection of related test cases, exercises the HDM
> decoder interleave encoding helpers, providing a starting point for testing
> self-contained CXL logic. The second suite exercises mailbox command handling,
> including error paths that are difficult to reach through cxl_test.
> 
> The mailbox tests also demonstrate the value of regression coverage. An
> unknown device return code can cause an out-of-bounds read and allow a failed
> command to be reported as successful. The series corrects that behavior, then
> adds tests that reproduce the failure without the correction. With KASAN enabled,
> the tests also expose the out-of-bounds read.
> 
> Together, the two suites establish a pattern for adding KUnit coverage
> to CXL, both for existing functionality and for bugs as they are found.
> 
> 
> 
> Alison Schofield (3):
>   Documentation/driver-api/cxl: Add a testing page
>   cxl: Add KUnit tests for HDM decoder encoding helpers
>   cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()
> 
> Gaobin Huang (1):
>   cxl/mbox: Treat unknown device return codes as errors
> 
>  Documentation/driver-api/cxl/index.rst   |   1 +
>  Documentation/driver-api/cxl/testing.rst | 120 +++++++++++
>  drivers/cxl/.kunitconfig                 |   4 +
>  drivers/cxl/Kconfig                      |  16 ++
>  drivers/cxl/Makefile                     |   1 +
>  drivers/cxl/core/Makefile                |   1 +
>  drivers/cxl/core/tests/Makefile          |   5 +
>  drivers/cxl/core/tests/mbox_kunit.c      | 249 +++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                     |   6 +
>  drivers/cxl/tests/Makefile               |   5 +
>  drivers/cxl/tests/hdm_encoding_kunit.c   | 156 ++++++++++++++
>  11 files changed, 564 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/testing.rst
>  create mode 100644 drivers/cxl/.kunitconfig
>  create mode 100644 drivers/cxl/core/tests/Makefile
>  create mode 100644 drivers/cxl/core/tests/mbox_kunit.c
>  create mode 100644 drivers/cxl/tests/Makefile
>  create mode 100644 drivers/cxl/tests/hdm_encoding_kunit.c
> 

Nice! For the series,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

