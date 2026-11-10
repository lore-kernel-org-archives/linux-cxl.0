Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335469;
	b=slYzHC3t8gFYUluuTnFupRzJ9KbnHIkKlpYax2rlrcHAcxbc9nMU1VEBOqTfHu3/RSGs
	 NVQF+9m+0bOJarJMBhYmRTd/tthxJn6Ay5QN7x2X9Fboy3Fqh1b+joI32m8JmbCUoBZD1
	 xZg7aO2wKNPh6YlECu0wFd2LkLuz3X3yPOi0eDDVGF0AVxoZ5qvQLfpilCpcXIHPhcfk5
	 qHU0dH2qImIyv5gyWvuGXFTKuZhIkLgT8GDCoh6iSEb3pz5YkSanjPfLzxjAb/LvIva68
	 iusHIOhBk35B6hkTuepAX+lu4OnPWXxDZMWS0sX16LFS23vWnRYoXTm6Iw39nop0mgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335469;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=K3rrlh0igfESeJ4kuOiDc47s3JcUXW71VfaoMuIvyTA=;
	b=wrCxVbQvYmw0kiphIJXckGe6YVcehtF/wXioYU63U29UiSMVyuyauHixn/C03Lr7rQf0
	 RB7byA5geRezG2OgkeruSE7kJbFGZFFSpkvppoZ33+8ixboMAyek+yAbmRBcthExPSyHA
	 8OsMkk1W4RNKiLWszjHDtexFnOv/E7P5I4iUHq0J3ZsrY9YaIiBx1EFwfoedwd9b4PqhT
	 At8leZv10loHzQC2K/iN/cLCA5HXx+ep4szQhCYyDvlCzFaEQ4SkLDxtUMV8FTAFcodml
	 0VlnWNP82XKP8t6idQZLKFJwagFPiPa6AFjfzHUE1dcTfyndUysiBPaf4vdkEAiZX8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ShX7tHMb;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D783606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 18:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D783606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ShX7tHMb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794335468; x=1825871468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HOOBl8AZeQn6IVV/e9M2lmwqm5IWMY4cqkkhxNVfHuk=;
  b=ShX7tHMbDYgdOk5MVjBDRdJqNqx1uBcDpEL9N1lX3IOy0Ic+H3TEQHfJ
   FCk1nW4gWf70DXHx/jbLPJjd7hNHZtiliIzfcnRXv3rBgXhkW9eG5+VRY
   SWskeMaW3aX2HGzvGPRwP6jtWx8zmaRubYBeAe0oqXCvyw5M2uIMNeS87
   MIcKGRH3YMS66ZUb+l06PU23WudG8Wh9X0Lr5zv1qyG3et5PMnwbVzp7R
   qekNPZ9EzSMJrDQ0hXwWxcfjBYrtf/ZckNWTvtTVyLD7ME4ABaDJN/aN0
   ZRmKz8AXN9XyfFLdHUlhhfkFC/Z0A/b5WtmAss7CNbYECcQcKVRgWJ33z
   Q==;
X-CSE-ConnectionGUID: qScjS+ehQlWnbuJBRoMcGQ==
X-CSE-MsgGUID: ScmVDCJjQAyIpjecv8+DnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2970940"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2970940"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 10:31:07 -0800
X-CSE-ConnectionGUID: kfyiDDyWQ9yVFimVmSx5OA==
X-CSE-MsgGUID: zuTTOQ/jTL6jdIwHL4F1bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8547467"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.75]) ([10.125.111.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 10:31:07 -0800
Message-ID: <ed2f330d-e16b-44a8-9b1e-23ef043916ca@intel.com>
Date: Tue, 10 Nov 2026 11:31:05 -0700
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
Subject: Re: [PATCH 0/4] cxl/region: Update and test performance calculations
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1793847269.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1793847269.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/26 8:28 PM, Alison Schofield wrote:
> CXL regions expose latency and bandwidth through their access0 and access1
> attributes. The same performance data also contributes to NUMA node access
> coordinates and memory tier placement.
> 
> This series updates region performance calculation and reporting,
> consolidates the completion-time operations, and adds cxl_test support
> for validating the results.
> 
> This work was prompted by AI-assisted patch reviews that identified ways
> stale contributions from failed or removed targets could affect region
> performance data.
> 
> Patch 1 addresses stale contributions to region performance data by
> recalculating from the attached targets only when the region completes.
> 
> Patch 2 makes region access attributes visible as soon as performance
> data is available.
> 
> Patch 3 consolidates the three completion-time operations into one helper
> shared by user-created and autodiscovered regions.
> 
> Patch 4 assigns distinct latency and bandwidth values to cxl_test memdevs
> so that region performance calculations can be tested.
> 
> A new CXL unit test will be posted separately.
> Testing with cxl_test:
> - With all four patches, the new test and existing ndctl CXL tests pass.
> - Without patch 1, rejected, cleared, and rebuilt target cases report
>   incorrect latency or bandwidth.
> - Without patch 2, the region access0 and access1 directories remain empty.
> 
> Based on v7.4-rc1.
> 
> 
> Alison Schofield (4):
>   cxl/region: Calculate performance data once all targets are attached
>   cxl/region: Show access attributes once performance data is calculated
>   cxl/region: Consolidate region performance completion
>   cxl/test: Give each mock memdev its own performance data
> 
>  drivers/cxl/core/cdat.c      | 19 +++++++++++++++--
>  drivers/cxl/core/region.c    | 40 +++++++++++++++++++++---------------
>  drivers/cxl/cxl.h            |  3 +--
>  tools/testing/cxl/test/cxl.c | 21 ++++++++++++++-----
>  4 files changed, 57 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

Applied to cxl/next:
cbba07ba71d5 cxl/test: Give each mock memdev its own performance data
cd60d381afc1 cxl/region: Consolidate region performance completion
5911237cee95 cxl/region: Show access attributes once performance data is calculated
57f95cb59ffd cxl/region: Calculate performance data once all targets are attached

