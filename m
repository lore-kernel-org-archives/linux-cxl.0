Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAF204C31
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524369; cv=none; b=iCqwRfF8WfQSORYiurZ5oKfzO/g25hwnVPpDGFGlgFweO7PccUJHEbOgDXJrpeL95Tt8fquN4vO/BqMl3v/0p6xJ6Cbhs0i2ikr7KXlhScKK9nWfkn47TibggXyAX6t9yIHhONCvYkq2cIEevK+bxbxDQ6WUDyNLG7BwSZYdGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524369; c=relaxed/simple;
	bh=iDXMjuQfx47eTpzDHgo3DsIqkddxdx2vBbNXhmd0AlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgqEn8PCNbyvpnCgfpFMIK53dGdsl+k6Jlvnm3LXYu2PvxaJE5l+4jERV/6Rj633THJxoeGRy7YfrLzIq2FK9UXvEaR0W3l2JPsRku0/bwNSfnA4K7bJhuMJvu7NbRdOci5U4498JkzZs2JRPxuDYTEzazAY8Y/Pua25TAO3Rus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CSHv5lSs; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CSHv5lSs"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786524362; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1mwMdRtrfR7tJaFpfa4dpBZrZqPGhkPb81a4/GWu5vc=;
	b=CSHv5lSsjBdxSFcv4WmvDh+EF4gk0I2rpnktIjfb3sOe9zhVsrr0kC9h+NMdzrxwvVYWwSBH0XnjT74lzkTHEm6LKT1fg/nvtgVP1E37S45I9AVvw3d82IhvvnwakYAUec1Xss30+0MTpBkATvJahVdW9gum9pRBHkoG+iMnGZU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8r8Axc_1786524360;
Received: from 30.178.83.207(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8r8Axc_1786524360 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 16:46:01 +0800
Message-ID: <8d3281ba-690c-4856-b408-2f5d7373b993@linux.alibaba.com>
Date: Wed, 12 Aug 2026 16:45:59 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/cdat: Fix uninitialized stack use in endpoint
 bandwidth gathering
To: Richard Cheng <icheng@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
References: <20260812060912.54932-1-kanie@linux.alibaba.com>
 <anwrGdUjKDCjr4He@MWDK4CY14F>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <anwrGdUjKDCjr4He@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/12 16:17, Richard Cheng 写道:
> On Wed, Aug 12, 2026 at 02:09:12PM +0800, Guixin Liu wrote:
>> cxl_endpoint_gather_bandwidth() declares three access_coordinate arrays on
>> the stack - pci_coord, sw_coord and ep_coord - without initializing them,
>> and relies on its helpers to fill every member. None of them does.
>> cxl_pci_get_bandwidth() and cxl_port_get_switch_dport_bandwidth() assign
>> only read_bandwidth and write_bandwidth, and
>> __cxl_coordinates_combine() assigns an output bandwidth only when both
>> input bandwidths are non-zero. Every member a producer declines to set is
>> read back as whatever was on the stack.
>>
>> Both cases occur on real topologies. The latency members of pci_coord and
>> sw_coord are never written, yet __cxl_coordinates_combine() sums them
>> unconditionally, so the latency reads are undefined on every call. And a
>> device whose CDAT DSLBIS reports no bandwidth for an access class leaves
>> perf->cdat_coord zero for that class, which is exactly the condition that
>> makes __cxl_coordinates_combine() skip the bandwidth assignment and leave
>> the ep_coord entry untouched.
>>
>> The ep_coord case escapes the function: cxl_bandwidth_add() accumulates it
>> into the per-upstream-port aggregate that is published through the region's
>> access coordinate sysfs attributes, so stack contents are reported to
>> userspace as a bandwidth figure. The latency sums are discarded by
>> cxl_bandwidth_add() rather than published, but they are still computed from
>> uninitialized memory.
>>
>> Zero initialize the three arrays. Zero is already the value this code uses
>> for "not reported" - both the __cxl_coordinates_combine() guard and
>> coordinates_valid() test for it - so a member no producer sets now reads
>> back as unknown rather than as a plausible number.
>>
>> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>> This was patch 6/8 of the "cxl: Assorted fixes" series [1]. Per review
>> feedback that series is not being reworked as a whole; the fixes are resent
>> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
>> issues are already fixed in cxl/next.
>>
>> v1->v2:
>> - rebase onto cxl/next
>> - rewrite the commit message to describe the behaviour rather than narrate
>>    the code change (Alison Schofield)
>>
>> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>>
>>   drivers/cxl/core/cdat.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 5c9f07262513..3c6a1537f89b 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>>   	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
>>   	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
>>   	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
>> -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
>> -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
>> -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
>> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
>> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
>> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>
>> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
>> -- 
>> 2.43.7
>>
>>
> Code changes looks sane to me, but I'm curious what compiler did you use
> and what level of optimization did you open ?
> Normally compiler can figure what whether to init them on their own.
Thanks for the review.

gcc 10.2.1, with the kernel's usual -O2, but the optimisation level does not
really enter into it: C does not initialise automatic storage at any level,
so an uninitialised array just holds whatever the previous frame left on the
stack. There is no point at which the compiler is entitled to zero it.

What does change the observable behaviour is CONFIG_INIT_STACK_ALL_ZERO,
which turns on -ftrivial-auto-var-init=zero and is the default choice
whenever the compiler supports it (security/Kconfig.hardening). With that
enabled the arrays read back as zero, so the bug presents as bandwidth and
latency being reported as 0 instead of as stack residue. My build has
CONFIG_INIT_STACK_NONE=y, where the values are genuinely leftover stack
contents, and they reach userspace through the access coordinate sysfs
attributes either way.
> But perhaps since the arrays are passed to the helpers in other source
> files, in this scenario the compiler can't initialize them reliably, not sure
> about this.
Your hunch is right as far as the diagnostic goes: the arrays have their
address taken and are handed to functions in other translation units, and
gcc's uninitialised-use analysis gives up once the pointer escapes, so
-Wmaybe-uninitialized stays quiet. That is why this one is not caught by a
build warning.
>
> Otherwise I have no issue.
>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
One thing to flag: I have posted v3 in the meantime, as
"[PATCH v3 0/2] cxl: Fix uninitialized access coordinates". Patch 1 there is
this patch plus one additional hunk, since the coords[] array in
cxl_switch_gather_bandwidth() has the same defect, and patch 2 handles the
RCD case where cxl_endpoint_get_perf_coordinates() returns 0 without writing
the caller's array at all. I did not carry your Reviewed-by across, as the
patch grew - could you have a look at v3 and add it there if it still looks
good to you?

Best Regards,
Guixin Liu
>
> Best regards,
> Richard Cheng.

