Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A702877F2;
	Thu, 13 Nov 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064661; cv=none; b=RKO4WzldxPjG0ez4kaDaanhmJt0AJoNfIMDKgFk0K4wP6p39XWhH0NK8ZB8NVRGuytkrN6+NWyleO3HwvEGz5sIFpO7PpCLcYq+cM5hHCDuyD9xehXB2fZBwBEa4p1O1/w7H6pzM9TyOIEz+QG+CLSZgZIOsKQlSX5oUWi5/VHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064661; c=relaxed/simple;
	bh=f4sFwUgnBUvJYUFsb1Ku0sojQCW1RQagTJ73LIpedgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkyDuWbNp33edeR8sfG3nSO9JPwA2irn/guWDQof3x/4BbdZ6gEAIxhzWLmCvSA7uPSbRny1vaRLlwW+rWMAL9+tFAW9gXVrzpPfSUDs1KmlRDqPfxJ9x7eKchg+Q4XTsjhPnczw0SMFFavicb4HdljOHOTK/4NgSAF3wkrI7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKAtwc1A; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKAtwc1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763064660; x=1794600660;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f4sFwUgnBUvJYUFsb1Ku0sojQCW1RQagTJ73LIpedgo=;
  b=WKAtwc1Ay7gs3iWP1/hDyUuV1B0Zrchcpq1J5W5R1ydkw5jo0QLpNGs5
   jNLj+9RO1BxwkbYsIJK8xh8dml3K0chTUjYS9QHqh8Dau5JX+jwUNZPst
   d8zCeWdyrzLvYdRUQvc9jSYFpx2zz+78TzQZ+D/VhEoBxldisJTKawTYf
   FTjKwWWeQ25e+TmMzU8WxAvuALBX/gkI1M8EsPnfW+XrD3gv/pjDMoPlJ
   Em329ChQxxQ+Fh/Ga4T0LdOo3AvZxbS6o+fIdYubWX588r2DorDGr+87s
   22fBTaLvn6P6SnD44SHMRRgpf9eQAbap2ApDeZf9EuTXfJWTRJWrkeeZp
   A==;
X-CSE-ConnectionGUID: 0XDrgrDxTQGQHlQUfY69Vg==
X-CSE-MsgGUID: /Tr+2ttQRzu+7iUV17QKkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75474196"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75474196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 12:10:59 -0800
X-CSE-ConnectionGUID: 4Kz2Ff1XRMq6U6n6QpBsDg==
X-CSE-MsgGUID: /alKok+sSLO7k3mTPkJYBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="193691919"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 12:10:57 -0800
Message-ID: <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
Date: Thu, 13 Nov 2025 13:10:56 -0700
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
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRYLJmjBsggjzA99@rric.localdomain>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRYLJmjBsggjzA99@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 9:45 AM, Robert Richter wrote:
> On 13.11.25 08:20:59, Dave Jiang wrote:
>>
>>
>> On 11/13/25 4:01 AM, Robert Richter wrote:
>>> On 12.11.25 14:45:28, Dave Jiang wrote:
>>>>
>>>>
>>>> On 11/12/25 1:51 PM, Robert Richter wrote:
>>>>> Sending optional and rather independent patches from v5 of the CXL
>>>>> address translation series [1] separately in this series. The patches
>>>>> could be applied together with early pick up candidates from the
>>>>> address translation series (namely patch #1 to #4 or #5).
>>>>>
>>>>> [1] https://patchwork.kernel.org/project/cxl/cover/20251112203143.1269944-1-rrichter@amd.com/
>>>>>
>>>>> Robert Richter (3):
>>>>>   cxl: Simplify cxl_rd_ops allocation and handling
>>>>>   cxl/acpi: Group xor arithmetric setup code in a single block
>>>>>   cxl/region: Remove local variable @inc in cxl_port_setup_targets()
>>>>>
>>>>>  drivers/cxl/acpi.c        | 15 ++++-----------
>>>>>  drivers/cxl/core/region.c | 25 +++++++------------------
>>>>>  drivers/cxl/cxl.h         |  2 +-
>>>>>  3 files changed, 12 insertions(+), 30 deletions(-)
>>>>>
>>>>
>>>> Hi Robert, I'm having issues applying to 6.18-rc4.
>>>>
>>>> Applying: cxl: Simplify cxl_rd_ops allocation and handling
>>>> Patch failed at 0001 cxl: Simplify cxl_rd_ops allocation and handling
>>>> error: patch failed: drivers/cxl/core/region.c:2958
>>>> error: drivers/cxl/core/region.c: patch does not apply
>>>
>>> You need to apply it on cxl/next. There are conflicts otherwise.
>>
>> Hi Robert,
> 
>> I actually need a series that cleanly applies to 6.18-rc4. I'll
>> attempt to resolve the conflicts when I merge that branch to
>> cxl/next. Of course a resolved public branch somewhere as guidance
>> would be appreciated as well. Patches should not be based on
>> cxl/next. Otherwise it gets really messy when I have to drop some
>> changes due to issues.
> 
> This conflict resolution was not trivial as code was moved around and
> then modified. It will be error prone and time consuming if someone
> else does the conflict resolution.
> 
> In the cxl tree the conflict resolution is most of the time done in
> merges which causes a headache when rebasing patches again on top of
> each other or when forward-porting patches to that tree. The merges
> basically hide the actual resolution and the patches that are involved
> in the conflict. Recreation of trees with merges is also not trival.
> 
> Compared to conflict resolution when doing a (hopefully rare) rebase
> of the cxl tree, it would be much cleaner if patches are on top of
> each other. There are no conflicts once rebased and you don't carry
> them around any longer. I don't see much benefit else. Also, the
> author should resolve the conflicts who best knows the code.
> 
> If you prefer merges, how about this: Have separate branches as long
> as there are no conflicts with mainline and merge them in. If there is
> a conflict with one or more branches, base new patches on top of that
> branch or create a merge point to port the patches on top of that.
> That branch with the patches in can then be merged into mainline, but
> there are no conflicts then.
> 
>>>
>>> Additionally, patch 3/3 (@inc variable change) of this series also
>>> depends on patch 02/11 of v5 (store root decoder in in struct
>>> cxl_region). If you chose to pickup some patches from v5 first on top
>>> of cxl/next, then all this 3 patches should apply cleanly.
>>>
>>> Since 02/11 is one of the first patches and it sounded to me some of
>>> them will be applied as well, I would prefer that order to avoid
>>> rebasing and resubmitting a v6 for that. Let me know if you want to
>>> handle this differently.
> 
>> Hmmm....maybe I should just take the entire series hopefully next
>> cycle when it's ready given all the dependencies?
> 
> Patches apply cleanly on top of each other, there is nothing that
> blocks.
> 
> Let me know how to move forward.

So currently we want to apply the 3 patches ahead of time right? Can you 1. post the series against 6.18-rc5, 2. provide a public branch (github or kernel.org) that merged this branch with cxl/next (given there are expected complications) that I can reference? That's really my preference.

> 
> Thanks,
> 
> -Robert

