Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021634;
	b=fcAutNL6auMoJ/3/cae7heXYDwZ8S6SE+k9jTcFnIkosUFbZfNAQR89IsJrHRHZsfxhP
	 q6ujOTS6NNuhfTYgxt+QB10rjQnCUIYrz9UzqFo/pJJ41XGrsUHnbKj1X8eAs/r8kyQEt
	 p0AuyMfyyIfc/GBB2t8ZucitIBjFZ05mrC7VjmNbgw9LTW9dvN8dJ7bxM0oqMNnTzOIvZ
	 K+LQfTsb4/cmiR3poFNyMDtNfJT/nXGM2cn0nVh3CpETAGSLvX14DYndzaHwB6SOaUZIM
	 Fw4AQIvoz3KlxOJG9qjRwU+R+XG0t1MU62/o1JWViWmVBbDQVL9dJ4xTBsPd3v5AA1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021634;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=G57BgKNpRCrGLI08I4incyJAKGErej9t+47ErUAZwhw=;
	b=4aBZ7x7lE8N+WxPUTwkNWI5f+wMtGkCaCDjdjw0PqA813K46YCVZ2g3xegtk45TK1hCM
	 7gtIS8jecH4u57oGkA7GXlgMxA8ePyQpSgpReXJ27hjjWWzDPDZCXsdDjVMSOerAudcIk
	 rbWy83QQx4AcPPN+285Q7ImonJh/WSX+oVZlwvyjWRFrT8/ryIgHrThF1n3YViPxH4XRX
	 hcSzJTafp82ZQJplvSu5zajicZG6q2UA7ZU/EZBGF9YepIYoP+pDlYpVLcEpoAlhb4XT2
	 3DngAlEU1wgqfK9jWBJ/D+OmA9Wm2UFa6jwOOaR20TXjtb1U/QEV+BMMvk0ckvkGXxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jvqmjg67;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D922606A334
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 17:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D922606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jvqmjg67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795021633; x=1826557633;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XNv56MscUEdffZxLAgEUgz8Kl8H123kuKF3lwfNIFkg=;
  b=jvqmjg67We+0dMIMUOHfZkd04D8dvIZ73mhdSmx8nY//Y7UcZ8VWllid
   p/3I36w2qk48ljXQTeLkAWnAY3cgipYPmy5sCRs3Z3GXlO2McGblJU+ap
   0+HpGxRt/dBQTkbA14cNyls1LG2rnaq+YGaRuGl3i4VQmYhkYx2IcVT+3
   BDROm2kJecv4R/P7Q/Od1gNDDAkE1ju65dqRteYrOktK6GJeK6lBpO8hL
   vFfmhIV7Ztkx+UdJW41eVu2mTKX98hHMUdjwc7PaLT4us/4wGOt8ESccd
   mR1aoa0XnM2U16QMUM2QxMR2K2uwemgr5wL84GLnG8Hgyx0Ku3wzVKCOw
   Q==;
X-CSE-ConnectionGUID: sQG/yqZ8TDCro3oBDGX4Dw==
X-CSE-MsgGUID: 0CXhmnPBRoqVsAs1DcuNGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3870266"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3870266"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 09:07:12 -0800
X-CSE-ConnectionGUID: Q4UPLQ/0SW+RhKx+XkMU6A==
X-CSE-MsgGUID: qSX7ZaSZRVODukitnsX3cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10199230"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 09:07:12 -0800
Message-ID: <3e876401-5d0f-47d6-8a44-4430a777e6c3@intel.com>
Date: Wed, 18 Nov 2026 10:07:11 -0700
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
Subject: Re: [ndctl PATCH v2 0/3] Add CXL region passthrough >16K gran test
To: Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org
References: <cover.1788489571.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1788489571.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/26 7:52 PM, Alison Schofield wrote:
> Change in v2:
> - Skip immediately if test decoder not present
> 
> 
> A companion kernel series,
>     "cxl: Allow passthrough decoders with >16K granularity",
> fixes region setup for valid topologies containing passthrough
> decoders beneath a wide parent interleave and extends cxl-test with a
> topology that exercises the issue.
> 
> This series consolidates and simplifies the existing region creation
> tests, and then adds coverage for the new topology.
> 
> Based on: https://github.com/pmem/ndctl/tree/pending
> 
> Alison Schofield (3):
>   test/cxl-create-region.sh: fold in XOR region coverage
>   test/cxl-create-region.sh: deduplicate decoder and memdev lookups
>   test/cxl-create-region.sh: add passthrough >16K granularity test case
> 
>  test/cxl-create-region.sh | 163 ++++++++++++++++++++++++++++++++++----
>  test/cxl-xor-region.sh    | 129 ------------------------------
>  test/meson.build          |   2 -
>  3 files changed, 149 insertions(+), 145 deletions(-)
>  delete mode 100644 test/cxl-xor-region.sh
> 

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
