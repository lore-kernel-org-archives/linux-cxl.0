Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744E2EDD64;
	Thu, 13 Nov 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047263; cv=none; b=d2QHPUAgdg1WjE3PTNpvh3UmdIP2jL7XHkq3M/Zy1voBt+0ALDLWS0kM3Q1aOWFdo2NtD5hUrycwYd+83ht3l0IuwnhLqfSzLx+ad4vwElrHqtQXLfQaub7knr8EpM7hKl45qESEcX4sIxSAZgoq3pDChqYP4dQS7+XXnTxynzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047263; c=relaxed/simple;
	bh=tfnYjtIiYZnDkDREZqrfJ7e+HyPAIZv6bg6q9/8JACI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLQHOkd0k2g7fJLb2I2BtsRnbmsM9zAjwupdq2rjx4hJL0cxcnJtT0uPMwowg7CoAlpKU6OtM7fc4283TkenIGmTPhrqGTEjUm887PbCXXbBokZtyi+dOWzdXhQr9ljgeKdSmJ5skAuREeAEwX03oleAqcnzvL+hBjl4ufD3K78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FukGUscK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FukGUscK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763047263; x=1794583263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tfnYjtIiYZnDkDREZqrfJ7e+HyPAIZv6bg6q9/8JACI=;
  b=FukGUscKRLsvbuTMA8OP8aUa99ojVDqIA2wbvFPVXt5Syo6GUvUwWrL1
   YhY43A4XYd4uK5pYGYWrg+FTtAfFqT2r1uuKFoW15unWxHxamBubJ34fr
   6G/utUsTDnTZb4bVCbD+wxi56LSipTR3hw/OZSQjTd60aLjdaR/a9m5Vg
   wL8ExE4MHhwiBATtseSQJoU4g9UiaL8hs9jV8wJtm7HSrQw/HHTDCvW4+
   2fPnj2UA7Gm84qQ1ppqzYjY0w5leVQJZyNrgFjEVmhv8nLIpKz25/v4hj
   H6EaZbBaN2KsyE5uCo5IRjbQ3RImvvgXmYUrnqrlGquuulrpOeV2nx9kV
   Q==;
X-CSE-ConnectionGUID: g72hn1FASviIe3mZGrz4ug==
X-CSE-MsgGUID: SRP6pqNwRfymoNEeHvpHWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="76231777"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="76231777"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:21:02 -0800
X-CSE-ConnectionGUID: q1geY38EQeelgg4HCf90rQ==
X-CSE-MsgGUID: JVr6ssPHRdOQZtf3eqaiXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="193781112"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:21:00 -0800
Message-ID: <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
Date: Thu, 13 Nov 2025 08:20:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] CXL updates for v6.19
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRW6h127k5Tzns8R@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 4:01 AM, Robert Richter wrote:
> On 12.11.25 14:45:28, Dave Jiang wrote:
>>
>>
>> On 11/12/25 1:51 PM, Robert Richter wrote:
>>> Sending optional and rather independent patches from v5 of the CXL
>>> address translation series [1] separately in this series. The patches
>>> could be applied together with early pick up candidates from the
>>> address translation series (namely patch #1 to #4 or #5).
>>>
>>> [1] https://patchwork.kernel.org/project/cxl/cover/20251112203143.1269944-1-rrichter@amd.com/
>>>
>>> Robert Richter (3):
>>>   cxl: Simplify cxl_rd_ops allocation and handling
>>>   cxl/acpi: Group xor arithmetric setup code in a single block
>>>   cxl/region: Remove local variable @inc in cxl_port_setup_targets()
>>>
>>>  drivers/cxl/acpi.c        | 15 ++++-----------
>>>  drivers/cxl/core/region.c | 25 +++++++------------------
>>>  drivers/cxl/cxl.h         |  2 +-
>>>  3 files changed, 12 insertions(+), 30 deletions(-)
>>>
>>
>> Hi Robert, I'm having issues applying to 6.18-rc4.
>>
>> Applying: cxl: Simplify cxl_rd_ops allocation and handling
>> Patch failed at 0001 cxl: Simplify cxl_rd_ops allocation and handling
>> error: patch failed: drivers/cxl/core/region.c:2958
>> error: drivers/cxl/core/region.c: patch does not apply
> 
> You need to apply it on cxl/next. There are conflicts otherwise.

Hi Robert,
I actually need a series that cleanly applies to 6.18-rc4. I'll attempt to resolve the conflicts when I merge that branch to cxl/next. Of course a resolved public branch somewhere as guidance would be appreciated as well. Patches should not be based on cxl/next. Otherwise it gets really messy when I have to drop some changes due to issues.

> 
> Additionally, patch 3/3 (@inc variable change) of this series also
> depends on patch 02/11 of v5 (store root decoder in in struct
> cxl_region). If you chose to pickup some patches from v5 first on top
> of cxl/next, then all this 3 patches should apply cleanly.
> 
> Since 02/11 is one of the first patches and it sounded to me some of
> them will be applied as well, I would prefer that order to avoid
> rebasing and resubmitting a v6 for that. Let me know if you want to
> handle this differently.

Hmmm....maybe I should just take the entire series hopefully next cycle when it's ready given all the dependencies?
