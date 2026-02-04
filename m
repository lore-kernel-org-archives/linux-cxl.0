Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3193D904F;
	Wed,  4 Feb 2026 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227812; cv=none; b=Ltz4QYeoEV0prwkTFdQrYOWuEhiY1Yx3ozqdN3qQBQtLfooFoGEGgDza4wx9TTTQg+YrnSB07Q3IfFUeKaxlpZOIqdt4CecpFeCctr83cT4Zaa8RALiCXANuW1e7q+dICQGh/z6WHZpP1k0naj1MU4bE5Zj9vbUiO+Pg3V3j6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227812; c=relaxed/simple;
	bh=lNwtYDi0bwicIthxV8qCmEihBq2QAzrN9kUn/1Dl0YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpYgJmBeORgWEUuHxER8aCZ7YEWQZWRaZUlTBtio2M3LtbSHYaNSrpznjpY2ehnp7ch8mzCS7slMwiD0R6G/JxHPkOeUe+a/CyjcoBm9hUjL4P2dwLIcfI6TYAnCOItJ97BGCwb+SHwyRMpiA2GIkc+C9WXNeQpDmsELPIkDWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDgzZivB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDgzZivB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770227812; x=1801763812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lNwtYDi0bwicIthxV8qCmEihBq2QAzrN9kUn/1Dl0YU=;
  b=SDgzZivByu/xTanwFojp/lqf33/mbNvY9uyCBP+YSrfIs2ixuXpez8Ub
   GR68vk/FGb6UA/7YFgGyFxxAIm4X9k2gVeldUu20KaOvPYlC1oCCTdivZ
   WhgXB38CjY//hheo0YRDwlNN5QE2NMg2aXc5zaM2c65yzmZObcTdMngfy
   f68Po6NcvzFqvlI9kTnX+0H0vThys7kSSaHvMPLaHY13eYH0AhXvD7ZiD
   Kb9bi3rpiw3dFHbeCAfMJ3ZX0/Ac0sbssAFoIRcHNLfDzo1SnUXdPdBNy
   3xuetbwUsWy2sAWCae7xg+JgyNmJlABlMjXAfTtYM0W63GE0TMjkGXm3X
   g==;
X-CSE-ConnectionGUID: cm9VH3ufQ1ayxA3+8i4EoA==
X-CSE-MsgGUID: lX9CGH3qQP2zLMeeQJLShg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70439099"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="70439099"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 09:56:51 -0800
X-CSE-ConnectionGUID: Vc9ni9ZoTeC62m8HH3ZyAA==
X-CSE-MsgGUID: gLAb3i0XSnyYWcBdS1rQ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="209335038"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.111.31]) ([10.125.111.31])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 09:56:51 -0800
Message-ID: <fbd47594-7404-4462-b5ff-3177eef465fa@intel.com>
Date: Wed, 4 Feb 2026 10:56:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20260110114705.681676-1-rrichter@amd.com>
 <125a0a77-b966-410c-b9e4-a7d81e462576@intel.com>
 <aYNCciQJwoTIxQgb@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aYNCciQJwoTIxQgb@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/26 5:58 AM, Robert Richter wrote:
> Hi Dave,
> 
> On 03.02.26 11:52:02, Dave Jiang wrote:
>>
>>
>> On 1/10/26 4:46 AM, Robert Richter wrote:
>>> This patch set adds support for address translation using ACPI PRM and
>>> enables this for AMD Zen5 platforms. The current approach bases on v4
>>> and is in response to earlier attempts to implement CXL address
>>> translation:
>>>
>>>  * v1: [1] and the comments on it, esp. Dan's [2],
>>>  * v2: [3] and comments on [4], esp. Dave's [5],
>>>  * v3: [6] and comments on it, esp. Dave's [7],
>>>  * v4: [8].
>>>
>>> This version addresses Alison's review comments to change the
>>> implementation to disable HPA/SPA translation handler. There are a
>>> view minor but no major changes otherwise. See the changelog for
>>> details. Thank you all for your reviews and testing.
>>>
>>> Documentation of CXL Address Translation Support will be added to the
>>> Kernel's "Compute Express Link: Linux Conventions". This patch
>>> submission will be the base for a documentation patch that describes CXL
>>> Address Translation support accordingly.
>>>
>>> The CXL driver currently does not implement address translation which
>>> assumes the host physical addresses (HPA) and system physical
>>> addresses (SPA) are equal.
>>>
>>> Systems with different HPA and SPA addresses need address translation.
>>> If this is the case, the hardware addresses esp. used in the HDM
>>> decoder configurations are different to the system's or parent port
>>> address ranges. E.g. AMD Zen5 systems may be configured to use
>>> 'Normalized addresses'. Then, CXL endpoints have their own physical
>>> address base which is not the same as the SPA used by the CXL host
>>> bridge. Thus, addresses need to be translated from the endpoint's to
>>> its CXL host bridge's address range.
>>>
>>> To enable address translation, the endpoint's HPA range must be
>>> translated to the CXL host bridge's address range. A callback is
>>> introduced to translate a decoder's HPA to the CXL host bridge's
>>> address range. The callback is then used to determine the region
>>> parameters which includes the SPA translated address range of the
>>> endpoint decoder and the interleaving configuration. This is stored in
>>> struct cxl_region which allows an endpoint decoder to determine that
>>> parameters based on its assigned region.
>>>
>>> Note that only auto-discovery of decoders is supported. Thus, decoders
>>> are locked and cannot be configured manually.
>>>
>>> Finally, Zen5 address translation is enabled using ACPI PRMT.
>>>
>>> This series bases on v6.19-rc1.
>>
>> Applied to cxl/next. Including the conventions doc.
>> 00bc604c96bb762f0f050460e25de2729edb1699
> 
> Thank you for applying the series, I noticed wrong authorship of
> a0a135b410f57702ac6a463005c656f291eb7b90, could you fix that?

Sorry about that. Not sure how it happened. Fixed now. cxl/next repushed.
63fbf275fa9f18f7020fb8acf54fa107e51d0f23
> 
> Thank you,
> 
> -Robert

