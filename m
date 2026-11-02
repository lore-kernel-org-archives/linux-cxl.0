Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657264;
	b=GGyZfFwhyto2GsevdX+YhaDgUatye4/CwLrllyrTnfBj+8YLFv95gAfPXHAjkDn99d6n
	 ruw77jtEiSnEBqGITgj7StEpl6Z7fnRg8eySFHj/yhPPF1b6lkDyfjzyzaPt5M4fFaB1G
	 yXGykyKdVV1inINzCKyF0/hgS+EaJpixC6tBGJhoZgsBf978pIPnP9cxE8kAYp7Q9XlHr
	 KRhvJTRccyRqcmoDjGIu0KORrw+V4E+xrl0+vKD19qBZJ+dJ5+v8YEulTJ+CUnZzHYKo3
	 DYL3j95METYE6WtyOpmfPtiPuBeWrDvo/X3nNKg2v6pinIiwvn1fcVUY7ATEczBOtBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657264;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dKnfhIseJVs2rsH31VTzF91Hx1JrrS+ebtdpiiataSA=;
	b=qM/irz12HmQzWzNXiyeA/qAQ9BBEZ5x90w0IrjTo7F7kmB3ct/J2IOTobIuQXgLlIOhY
	 LHoN37hNyJqdqWsqaZ2Vajg0ulMa32MOJu3FYUBSZ6g/5Idcyl8048GeWNWdLS0ArbK0i
	 zu6QlkKaXTQjDfK8Nh0edKYbGafuPWxkDVBs1WU0kokDiLzoR6ORo7NGSsLD08hGbNwLi
	 0BHxf2H7weyIGPLgKEB7tDP6yqGi12fL1GLvodCHmkwkzhGRQ1zQxPGLno2dq5lKaFE8H
	 To7yH628+FOzya0y16tJVv/Fn628ZoEkKBjEMpkwKzOL5o0rUDYbwod4t5ryVvUsVMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="g/uXe5LK";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A3606A332
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 22:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F16A3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g/uXe5LK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793657263; x=1825193263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6KHX5j7T4BNpYn33RQTz53TMpF6xpxLtg9KZ7A8Up6E=;
  b=g/uXe5LKDTphsTX1UCEFY52qxVHSw4ew6Ly/tuEsIM2bvJ6OiMReiHtt
   AnKE/BAzqG4wQ1vdGXRv/Jc4b39/Wgw4c+0clPoa0M0yikluATBedBjsj
   Pl8AeAGOkNHl6Norspv4rHaxj8s7AGLwmcxCbD0l/IVWvm50z9Xiw7LHe
   10VytwJRd/Dk6plW/wHf/p+kml1C7CZym458fgIGWSG2l9pVG4f+zeiD5
   ADK5k5H+u0+IQ6FnxhosYX7cZAADjftTPFCbYiyaE9nNsRyq5V8f0c7lz
   Cq6f8n+dj8LmlzRo+uwQCZmgWPCtzmWzGtJIc4K/Z81xlbWHwK9XafNtR
   w==;
X-CSE-ConnectionGUID: 8vpVUAruSNC+3jX7w4FgdA==
X-CSE-MsgGUID: ydXgE7VrQ/Kb+r4sgf1tJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2247462"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2247462"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:07:42 -0800
X-CSE-ConnectionGUID: 16tovKZ/Sc6L04mxZMK5xg==
X-CSE-MsgGUID: H4H1DK6KRVW+hRqq9K3wCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6558994"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.163]) ([10.125.109.163])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:07:41 -0800
Message-ID: <6c38b909-506c-490a-9372-c8d576cf7e28@intel.com>
Date: Mon, 2 Nov 2026 15:07:40 -0700
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
Subject: Re: [PATCH v2 0/4] cxl: Add KUnit tests and documentation
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1793645996.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1793645996.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/26 12:15 PM, Alison Schofield wrote:
> 
> Changes in v2:
> - Use explicit hex designators in the decoder count table to match the spec (JonathanC)
> - Generalize arch option and add help ref in testing page (AnisaS)
> - Explicitly initialize the mock return_code to SUCCESS (MingL)
> - Add a 'Maintaining KUnit tests' section to testing page
> - Wrap long lines in testing page (JonathanC)
> - Rebase on 7.4-rc1
> v1: https://lore.kernel.org/linux-cxl/cover.1791949910.git.alison.schofield@intel.com/
> 
> 
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
> Alison Schofield (3):
>   Documentation/driver-api/cxl: Add a testing page
>   cxl: Add KUnit tests for HDM decoder encoding helpers
>   cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()
> 
> Gaobin Huang (1):
>   cxl/mbox: Treat unknown device return codes as errors
> 
>  Documentation/driver-api/cxl/index.rst   |   1 +
>  Documentation/driver-api/cxl/testing.rst | 139 +++++++++++++
>  drivers/cxl/.kunitconfig                 |   4 +
>  drivers/cxl/Kconfig                      |  16 ++
>  drivers/cxl/Makefile                     |   1 +
>  drivers/cxl/core/Makefile                |   1 +
>  drivers/cxl/core/tests/Makefile          |   5 +
>  drivers/cxl/core/tests/mbox_kunit.c      | 250 +++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                     |   6 +
>  drivers/cxl/tests/Makefile               |   5 +
>  drivers/cxl/tests/hdm_encoding_kunit.c   | 159 ++++++++++++++
>  11 files changed, 587 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/testing.rst
>  create mode 100644 drivers/cxl/.kunitconfig
>  create mode 100644 drivers/cxl/core/tests/Makefile
>  create mode 100644 drivers/cxl/core/tests/mbox_kunit.c
>  create mode 100644 drivers/cxl/tests/Makefile
>  create mode 100644 drivers/cxl/tests/hdm_encoding_kunit.c
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

Applied to cxl/next:
533928808ac1 cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()
a0481710d758 cxl/mbox: Treat unknown device return codes as errors
70965c844464 cxl: Add KUnit tests for HDM decoder encoding helpers
feade4648c97 Documentation/driver-api/cxl: Add a testing page

