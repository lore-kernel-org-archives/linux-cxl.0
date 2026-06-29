Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DAC36C592;
	Mon, 29 Jun 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747450; cv=none; b=cwKwA5R7rCK7TREjDN+JvYv/bvPvStQC4H4+h/gmO6JKOtX3G24va2qDEDIjvOJ1A3JTzjHIgkd5JPuWWv2dGowT98OBU+cyhyadJKgFbpfNTvRwinkHmzHVa6V+cKt/UhkgVf8nKSlnroh/p69o4gMtuIlDSJPppAXG58Sh4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747450; c=relaxed/simple;
	bh=WVyPy43w4WK+B4xHT92zyLgIAMj2MJGMMJ9hEp5clM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7LPV6f6uoDP+pFcjlDerar3Y//LH316vxWEtvxkt4/zYWMrZdXJjxW5poBCHZTo8hL3ukh5aAuYLlj8vXqf5a5shxO1MvJQBmEisLpQl31TFiWx6cwGNQcKnURQk8NU8nR7MIS/fLhQ4q6MI27k5jUWRxQ0S5yC0x4KZvrI3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekD8zKMv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekD8zKMv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782747448; x=1814283448;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WVyPy43w4WK+B4xHT92zyLgIAMj2MJGMMJ9hEp5clM8=;
  b=ekD8zKMvMENVZBKJNIOMVhd+Z47RMNsLUjicVq1Gq7mpfm5EUbXBd3HU
   2+frhUvBv2IqhUh5iUNDwugq1VyIUSnwK8XcAA1RAMa6Rpns8gGsSas+q
   FtTgja5Xi+f+Kx+aDejqNye3NG6a1dbYhGFRmjChiEK8ykDANlh3OVnZs
   Oy+TCi3o6C7nbi4kQffl89WHt84C5ADnXmShCQzOy3iFRIGXygZ6zMBqN
   yUfNktjfwtX8ypjBE63Yyhr/q3nX0oHnt0xvobHdLan6Q+jLMVQSRal5K
   haJfOURrauKa4nmieYV8hwvcr6zsvWX7H7H3WTzsMk1lfgMNhLxv4QLG9
   g==;
X-CSE-ConnectionGUID: YZi3560OS12HWmF1aJaqtA==
X-CSE-MsgGUID: p/cOhee0TS+yqHk3sxrTng==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83470677"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83470677"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:37:28 -0700
X-CSE-ConnectionGUID: oM2pl2hlR/id9VZwIupaCQ==
X-CSE-MsgGUID: od85TOSZRQm6wB2wgyfaAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="248625928"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.194]) ([10.125.109.194])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:37:26 -0700
Message-ID: <e9df1bb6-29fa-423c-9fc8-96c048fcb668@intel.com>
Date: Mon, 29 Jun 2026 08:37:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/features: Reject Get Feature count larger than the
 output buffer
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Zhenhao Wan <whi4ed0g@gmail.com>, dave@stgolabs.net, jic23@kernel.org,
 vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com,
 iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com,
 kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260624134737.49166-1-icheng@nvidia.com>
 <ajxEGmGxOhryENl4@aschofie-mobl2.lan> <ajxHwh3s2lM98aed@aschofie-mobl2.lan>
 <aj4pYfg51dWr__mw@MWDK4CY14F>
 <e97b6cfb-f6e9-4be4-aac2-121330b6c56d@intel.com>
 <akHUATTw75mXrjWn@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <akHUATTw75mXrjWn@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/28/26 7:12 PM, Richard Cheng wrote:
> On Fri, Jun 26, 2026 at 09:17:03AM +0800, Dave Jiang wrote:
>>
>>
>> On 6/26/26 12:27 AM, Richard Cheng wrote:
>>> On Wed, Jun 24, 2026 at 02:10:26PM +0800, Alison Schofield wrote:
>>>> On Wed, Jun 24, 2026 at 01:54:50PM -0700, Alison Schofield wrote:
>>>>> On Wed, Jun 24, 2026 at 09:47:37PM +0800, Richard Cheng wrote:
>>>>>> cxlctl_get_feature() sizes its output buffer from the user's
>>>>>> fwctl_rpc.out_len, but the device is told to write
>>>>>> cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
>>>>>> separate user-controlled value. Nothing bounds count against out_len, so
>>>>>> a small out_len with a large count overflows the kvzalloc()'d buffer.
>>>>>> A heap OOB write reachable from FWCTL_RPC.
>>>>>>
>>>>>> Reject requests where count exceeds the available payload room, before
>>>>>> allocating.
>>>>>>
>>>>>> Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
>>>>>> Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
>>>>>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
>>>>>> ---
>>>>>> Changelog:
>>>>>>
>>>>>> v1 -> v2:
>>>>>>     - Drop the reproducer and trim the KASAN splat in the commit message
>>>>>>     - Sent the reproducer as a regression test in ndctl separately.
>>>>>
>>>>> This patch itself looks good. Looking at the other bounds checks
>>>>> Sashiko suggests, I'd rather see this all fixed up in one patch or
>>>>> patchset, rather than dribble in as multiple patches.
>>>>>
>>>>> Maybe it all fits into one patch, like this:
>>>>> cxl/features; Add bounds checking for get/set feature commands
>>>>> or maybe it works better as a set.
>>>>>
>>>>> Either way, doing in one swoop would be nice!
>>>>
>>>> Oh, seems I'm reading patches out of order.
>>>>
>>>> Now I see this: 
>>>> https://lore.kernel.org/linux-cxl/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/
>>>> which looks like it covers one of Sashikos's complaints.
>>>>
>>>
>>> Hi Alison,
>>>
>>> Thanks for pointing this out.
>>>
>>> Then that would be no problem for me, I'll append my fixes with Zhenhao's patch.
>>>
>>> so my original fix + sashiko's complain about cxlctl_set_feature() and cxl_get_feature().
>>> I'll put them in my work and send as a serie.
>>
>> Hi Richard, I see sashiko pointed out some existing issues on the series. Will you create fixes for them or should I go do that?
>>
>> DJ
>>
> 
> Hi Dave,
> 
> I've sent out v3 of this here.
> 
> https://lore.kernel.org/all/20260626104102.53892-1-icheng@nvidia.com/
> 
> I've made the fixes of the bug sashiko-bot pointed out here in that serie.
> 
> I also see it's mentioning more pre-existing bugs on v3, I'll do them in seperate patches,
> or are you refering to the issue in this one ? if you're talking about the latter, I've
> included them in v3.


I'm talking about the complaint of pre-existing issues.

DJ

> 
> Please take a look while you're available, thanks.
> 
> Best regards,
> Richard Cheng.
> 
>  
>>>
>>> --Richard
>>>  
>>>>>
>>>>> -- Alison
>>>>>
>>>>>>
>>>>>> Best regards,
>>>>>> Richard Cheng
>>>>>> ---
>>>>>>  drivers/cxl/core/features.c | 4 ++++
>>>>>>  1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>>>>>> index 85185af46b72..9c714ee42a41 100644
>>>>>> --- a/drivers/cxl/core/features.c
>>>>>> +++ b/drivers/cxl/core/features.c
>>>>>> @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>>>>>>  	if (!count)
>>>>>>  		return ERR_PTR(-EINVAL);
>>>>>>  
>>>>>> +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
>>>>>> +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
>>>>>> +		return ERR_PTR(-EINVAL);
>>>>>> +
>>>>>>  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
>>>>>>  		kvzalloc(out_size, GFP_KERNEL);
>>>>>>  	if (!rpc_out)
>>>>>>
>>>>>> base-commit: ef0c9f75a19532d7675384708fc8621e10850104
>>>>>> -- 
>>>>>> 2.43.0
>>>>>>
>>>>>
>>

