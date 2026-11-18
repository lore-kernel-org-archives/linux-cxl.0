Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020600;
	b=K+B3WfIiDxnk9omgA3BFaWLssBrgVz0ud7BYp1WeB6GRii5xHXafxDtFzZhg4/rINjN9
	 l826s6koFmzurf6VGxg3pFak4KKf6DWed/hnMBiniQuMKO3wgavU7jyD+JNyd99ie37H/
	 Uzzk1XmRPLws5OdaGHml9f5JhGr3BX9+kt4Rni6pqHa/RpC/lvXXj3jd36U5M2GZCu3pk
	 ZwRjY0qdJRSiEwt+4plI7fdbCXzvO7hxSObJili2gkUnFXWRm9z+M/8hsjrdLhz85lbPE
	 RsAH3RdO/Qz7HHrXrzYI0jTGiPgQz27MmKLU7jV+Sy9yXlg5pW5GQnLD0iRZZvgFa9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020600;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TjEi2hw/vnSSv9hI++pSl8KZpU/ee/lVHx9qeLt6Bh0=;
	b=BNS3/A1rr9bozJ6EwSXHjN+//udOGSHt+28C2MEaQolPuTtFnpGTTLfjXjb6ZRi2wqNf
	 ExtbuztLBXtsdYmzmJp0Pp0b4kx7+sTcSJDhIs3DLVfzr5ig0wsKUT3lc2x5yr3aSRRpN
	 5t3Fe8sH4k7Jw9RxN8inK7LfKiuSPBZHIY7EREyl+l2Bc9PMcyNf1XbR7hneGE1A/zB8E
	 5i+s1tJnwTF3fqXr2t1Mu1Z3YLkBy5NN1K3Rr9MfkR9ciRaQgVs9OQcWNK+usCJ0resmu
	 FX1ujET83Kmrgu8uhyfAgotW8l5t2+X3zbVqKdsBdTYSwT5xUQciTN3l3UwD1iVAy3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGIhx7VE;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2A60A2600
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 16:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F2A60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGIhx7VE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795020600; x=1826556600;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=u+FzBLKvDPCP027zRMvV/eDYraNYi3ks7E7AoSp3lCc=;
  b=lGIhx7VES0q8vHLQRfuiCYMxmnwO82Bj/VT+vdNdIgl3eRfO2GfypT6y
   ZNTPBdhALiI0VCWdkQtjDYckAf08dXauNZQwicQOgFb/gC+LdUAvzgDAi
   +O0m4cGhu1r0oCSfWZx4riFKVqaxrKlLJo6K1pJgMHRn9OEq9kpzCSuT7
   OmWPqTl0BaasKgnDht37GcyUBISfq/2lORKrHREOs5UTs9WHB1e3TjZR+
   Hn2IBVt02mY5ZdbQDyYOmzJmkblVTqtlDPP+DcsaM6eTVa11CmQsRVpdB
   hqbdptJdeLLcVAaq2e4sy3TjePglMHq08JSFkeuSilFcaPMz3fzXKbWk0
   Q==;
X-CSE-ConnectionGUID: hOtRhY5JRHC0NrcXqaykAg==
X-CSE-MsgGUID: Vs/hFSh+R7K4w0RaN+CJtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3831356"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3831356"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:49:59 -0800
X-CSE-ConnectionGUID: NQaEzGhqSMiJrvNEPJgcRQ==
X-CSE-MsgGUID: +39lIE40Q+mSeCZ23MCndg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10073064"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:49:58 -0800
Message-ID: <eb8343c9-4031-4c2c-92f8-23445771fbd2@intel.com>
Date: Wed, 18 Nov 2026 09:49:57 -0700
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
Subject: Re: [ndctl PATCH 0/7] cxl/region: create-region command and unit
To: Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org
References: <cover.1790658549.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1790658549.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/28/26 10:36 PM, Alison Schofield wrote:
> While working to enhance the cxl-cli cxl-create-region command to handle
> out-of-order target lists or no user-supplied target list, I ran into some
> basic issues in the existing command that need to be addressed first.
> 
> Patches 1-2 consolidate and clean up the existing create-region tests.
> 
> Patches 3-6 fix target-list parsing and validation, release DPA after a
> failed create, and move granularity validation ahead of region creation.
> Each fix adds a test case for the problem it addresses.
> 
> Patch 7 corrects the documentation to reflect that --decoder is currently
> required. Automatic root decoder selection will be considered separately
> with the upcoming create-region usability work.
> 
> Developing tests for these fixes exposed two bugs and a topology gap in
> the cxl_test mock module. A companion cxl_test series is here [1].
> 
> 
> [1] https://lore.kernel.org/linux-cxl/cover.1790641236.git.alison.schofield@intel.com/
> 
> Alison Schofield (7):
>   test/cxl-create-region.sh: fold in XOR coverage
>   test/cxl-create-region.sh: deduplicate topology lookups
>   cxl/region: parse comma-separated target lists
>   cxl/region: reject duplicate or unknown target memdevs
>   cxl/region: release reserved DPA when region creation fails
>   cxl/region: validate granularity before region creation
>   cxl/region: document --decoder as required
> 
>  Documentation/cxl/cxl-create-region.txt |   7 +-
>  cxl/region.c                            | 139 ++++++++--
>  test/cxl-create-region.sh               | 338 ++++++++++++++++++++++--
>  test/cxl-xor-region.sh                  | 129 ---------
>  test/meson.build                        |   2 -
>  5 files changed, 442 insertions(+), 173 deletions(-)
>  delete mode 100644 test/cxl-xor-region.sh
> 

for the series
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

