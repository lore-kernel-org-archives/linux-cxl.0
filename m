Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F5377A96
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786500643; cv=none; b=lKnU4pv/zz1zVXJgYDlqA+F5Z2NsBnEwSP0QuAvWYPX/UvTgiv7vdGPve6tK1Yy/3mw52pNEQVXUDfIpsgx4y/1jZ6/MqgxerxJjbCTJDV3C8TaYbI4imQxjYfI5FX9bVf0mRniUSJYoiy15BBDPsjiaQQsCQz6QifCKw3y50JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786500643; c=relaxed/simple;
	bh=FaNOeAl9YiakBJYQhUCpGSFm3PVT9RjJssUPWFr8WME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY/56AIQWsxOIuM+/TRjcZl3ffquJ2e18FTBpDxlX5K+qeiy01CuOJO0lhQ5h2/RLgFLICVjaGq0+Lxykg3CJByLcKv4x3V07ed83qgLfpyiNJ7nP6RPtNfdKxp0yUu5O/MYGfX7EYvUlmvkrvzPOQk54mWTLrJr35BF7fJrpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F3lsiCJJ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F3lsiCJJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786500637; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ElOqstlwKohdV9tlpfEwVrNCUTrj8rK7/fh0JwLZZYM=;
	b=F3lsiCJJoBQpxwS+b8Shop8SXGatdmb0UYsGFnm/JCifwN1VGkcd2iHfW74R4DMBiZuldhMxgVborZzZoQ61MezE01VXWFe6WVS9UoXAFQLgbS6Mp4uahrhrL3fga4HvyrIcoJMOq7uuH4w+8xV8le9PnxR6mhh1DlIs9w5Tck8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8q0fLx_1786500635;
Received: from 30.178.83.207(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8q0fLx_1786500635 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 10:10:37 +0800
Message-ID: <f43fe1df-e7ed-40a8-882e-2963968c10cb@linux.alibaba.com>
Date: Wed, 12 Aug 2026 10:10:35 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] cxl: Assorted fixes
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
 <ant-ttVtO_tFY_rt@aschofie-mobl2.lan>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ant-ttVtO_tFY_rt@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/12 03:57, Alison Schofield 写道:
> On Tue, Aug 11, 2026 at 07:36:00PM +0800, Guixin Liu wrote:
>> This is a batch of fixes found while auditing drivers/cxl. They are
>> independent of each other and can be applied individually or dropped in
>> any combination; they are only sent together because they came out of the
>> same pass over the code.
> Hi Guixin Liu.
>
> Thanks for taking a look at CXL and putting these fixes together. I
> appreciate that the intent here is to make the individual fixes easy to
> take or drop. From the maintainer side, though, a grab bag of independent
> findings from an audit has somewhat the opposite effect. It leaves us
> with the audit results and the homework. :)
>
> We have been working through this kind of cleanup in focused functional
> areas, like features, HDM enumeration, etc. Please take a similar approach
> rather than collecting unrelated findings into a single series. Address
> one area at a time.
Sorry, this is my first time sending patch to cxl mailing list,
I will pay attention to these next time, thanks.
>
> As part of that work, please check mailing list traffic and cxl/next for
> fixes that have already been posted or merged, and review the pre-existing
> complaints reported by the Sashiko bot against your patchset:
> https://sashiko.dev/#/patchset/20260811113608.2815625-1-kanie%40linux.alibaba.com
Sure, I will check before,

but why dosen't Sashiko reply directly in the current email? I can't 
reply Sashiko.
> Please also follow the conventions we use for fix commit messages. They
> should not narrate the code change, but rather describe what happens today,
> why that is wrong and its impact, then state how the patch fixes it.
> For an example of switching from code narration to behavior description,
> take a look at my recent reply to a commit message w similar issue:
> https://lore.kernel.org/linux-cxl/ant2Z1mzHCrzmzXn@aschofie-mobl2.lan/
Got that, thanks.

Best Regards,
Guixin Liu
> This up-front triage is becoming increasingly important as we see more
> AI-assisted audits and fix submissions. Without it, maintainers end up
> determining whether each finding is still present, already being
> addressed, significant enough to fix, and where it fits with ongoing
> work. That review burden does not scale with the volume of AI-generated
> findings.
>
> Rather than reworking this series as a whole, please apply this feedback
> to focused CXL fixes you submit going forward.
>
> Thanks,
> Alison
>
>> Guixin Liu (8):
>>    cxl/features: Validate the fwctl RPC input length
>>    cxl/features: Bound the Get Feature output by the user output buffer
>>    cxl/core: Fix dport use-after-free via the einj_inject debugfs file
>>    cxl/pci: Fix NULL pointer dereference in reset detection
>>    cxl/hdm: Fix out of bounds read of the decoder target list
>>    cxl/cdat: Fix uninitialized stack use in endpoint bandwidth gathering
>>    cxl/mce: Validate the memdev and endpoint before use
>>    cxl/region: Unregister the pmem region bridge on setup failure
>>
>>   drivers/cxl/core/cdat.c        |  6 +++---
>>   drivers/cxl/core/features.c    | 15 ++++++++++++++-
>>   drivers/cxl/core/hdm.c         | 12 ++++++++++++
>>   drivers/cxl/core/mce.c         |  8 ++++++--
>>   drivers/cxl/core/pci.c         |  8 ++++++++
>>   drivers/cxl/core/port.c        | 18 ++++++++++++++----
>>   drivers/cxl/core/region_pmem.c |  6 ++++--
>>   7 files changed, 61 insertions(+), 12 deletions(-)
>>
>>
>> base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
>> -- 
>> 2.43.7
>>

