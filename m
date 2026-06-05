Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E999C3FFFA9
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672859; cv=none; b=oTcHwK1SqKjhAbK2OpDKIALFQau4gyTnL4y4jjTGTvNZ1vxAMUMP/Aqm6opmH+mRr6+o+GDaxQeCohokxzudQnhPJsnFt/zz33N58vq4CPnLkyZXmwPzc/VJA3yv5v4fFW5bQLG+LkcbNwxp/ByUpu/pOluJ/NjZUgzdcCYCfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672859; c=relaxed/simple;
	bh=QrQ15OAClP3kglMMACTGyvQ9u31VW9YNmSLEEbybGHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OonN2cxJtx8R/pEMCDlQN/1lqTk04jdBAUAXGjRz6yRhrFIyMqnMju8Hqxdv8v7KgwCLbGQNWwiDbhAJ1DG9g6K8dyu0QldNfdHA8mY8d0oKleV0XRzmaiosuGKWdSskUgD11WAMfvZL7bxIJyN1sj1Oy61Lzy4Ja/1dQ8QvK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/F2jaq7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/F2jaq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780672858; x=1812208858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QrQ15OAClP3kglMMACTGyvQ9u31VW9YNmSLEEbybGHA=;
  b=b/F2jaq7lo02R7Tfbqwi2iDExQJBlIS6ac8YPvAcG1aXdsBUUEGPiu51
   ljX0FWEaxNQ55q35ffP3d2F7SgJ+vtoSrYuPODCXJVNvmo6O4de83ocrh
   3aB5dLHQ/bzVL9KxFWtE3rUttBf+bYo4Oqr4tAwZpMg6h+JEAcgP0O2pT
   l6Qp/yglcRSEXYb5RhIZYRtxq6jZf7bRgf6iNnM6a4VW+TyU2TcVzIv9x
   +nXvUdnqEZRo9R+85rfxuzgSoh9GwJmvG5jeT22d2cxcY5n9g0lnsuHiu
   pl1v7/M0e9tHnEQXWFxYuQmkC+qMwfJ/vBTOjSXiCMKB069CsQ+hThNXD
   Q==;
X-CSE-ConnectionGUID: KonWMLNWTS2k1U3VZIMzHg==
X-CSE-MsgGUID: 3D2oDO9nTrON0zSB9Hg3BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81541193"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81541193"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:20:57 -0700
X-CSE-ConnectionGUID: 88/xIxNCQcatGv91STwPQw==
X-CSE-MsgGUID: f7kBGv9pRTy5SzBbt/teRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244930436"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.36]) ([10.125.109.36])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:20:57 -0700
Message-ID: <5f399564-7efe-444d-a6cf-2c6176e57ad9@intel.com>
Date: Fri, 5 Jun 2026 08:20:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cxl: Introduce devm_cxl_probe_mem() and fix region
 deletion
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
 <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, jic23@kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>
References: <20260519210158.1499795-1-djbw@kernel.org>
 <9e85d980-4a44-4f27-aa18-8d01630a05e6@amd.com>
 <2a9791d4-e091-4452-af92-3601253bc748@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2a9791d4-e091-4452-af92-3601253bc748@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/5/26 12:56 AM, Alejandro Lucero Palau wrote:
> 
> On 5/21/26 15:31, Alejandro Lucero Palau wrote:
>> Hi Dan,
>>
>> On 5/19/26 22:01, Dan Williams wrote:
>>> The devm_cxl_probe_mem() helper creates a memdev and retrieves a mapped
>>> HPA range for the device. At present the retrieved region information is
>>> expected to be established by platform firmware. A future update will
>>> auto-establish a region if one is not already present. This arranges for a
>>> simple CXL topology detach == Accelerator driver detach scheme.
>>
>>
>> I have successfully  tested this with sfc and it indeed simplifies the accelerator driver. Removing cxl_acpi or unbinding the related memdev works as expected removing the sfc driver as well.
>>
>>
>> I'm quite happy with this approach and I hope this is the last building block for the simplified (only with autodiscovered regions) type2 series.
>>
>>
> 
> No updates or comment for two weeks. I wonder if this is being superseded somehow and I did not notice.

Are you not integrating this series with yours? At least that's my understanding given you are happy with the approach.

DJ

> 
> 
>> Just a minor comment in patch 5 and a suggestion for maybe changing the devm_cxl_probe_mem interface call.
>>
>>
>> Cheers
>>
>>
>>
>>
>>> Now, automatic region establishment on behalf of an accelerator driver
>>> also requires automatic region teardown. The existing scheme of
>>> triggering devm_release_action() of a cxl root device to destroy a
>>> region is racy [1].  There is no path to coordinate multiple devres
>>> actions, or conflicting devres actions, without using the
>>> devm_remove_action_nowarn() workaround.
>>>
>>> Instead, move final region cleanup responsibility to the root decoder
>>> teardown path (devres action cxld_unregister()). Expand the root decoder
>>> @range_lock, renamed @regions_lock, to coordinate region creation, sysfs
>>> manageability, and deletion. The @regions_lock also prevents regions
>>> from disappearing mid-auto-assembly.
>>>
>>> Changes from the initial RFC [2]:
>>> * tested with Dave's type2 cxl_test
>>> * fix region remove by endpoints (Dave, Alejandro)
>>> * fix user triggered region remove (Sungwoo)
>>> * fix lifetime of the @attach ops (Alison, sashiko)
>>> * hide @attach details inside the CXL core
>>>
>>> [1]: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
>>> [2]: http://lore.kernel.org/20260403210050.1058650-1-dan.j.williams@intel.com
>>>
>>> Dan Williams (5):
>>>    cxl/region: Block region delete during region creation
>>>    cxl/region: Resolve region deletion races
>>>    cxl/memdev: Pin parents for entire memdev lifetime
>>>    cxl/memdev: Introduce cxl_class_memdev_type
>>>    cxl/region: Introduce devm_cxl_probe_mem()
>>>
>>>   drivers/cxl/core/core.h      |   2 +
>>>   drivers/cxl/cxl.h            |   8 +-
>>>   drivers/cxl/cxlmem.h         |  27 +++--
>>>   include/cxl/cxl.h            |   3 +
>>>   drivers/cxl/core/memdev.c    |  20 +++-
>>>   drivers/cxl/core/port.c      |   7 +-
>>>   drivers/cxl/core/region.c    | 194 ++++++++++++++++++++++++++++++-----
>>>   drivers/cxl/mem.c            |  95 +++++++++++++----
>>>   drivers/cxl/pci.c            |   2 +-
>>>   tools/testing/cxl/test/mem.c |   2 +-
>>>   10 files changed, 297 insertions(+), 63 deletions(-)
>>>
>>>
>>> base-commit: 5d6919055dec134de3c40167a490f33c74c12581

