Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129037C90F;
	Fri, 26 Jun 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490629; cv=none; b=VM3YwbyPOUtZX0iJG0Bzz2iiWh8bWmJkFMV+wx0YEAMccLumBUmCL2E4omOLY9HlYxJEFZVNVrrYYR5TRkQrwcwAfT2n3lGLhha0R92hBXIv0o+Mi9mn0XqKuArt3wg2128Tv6Fb0WQCM6ptOW982OW2HYipC7abmQkxy/DZYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490629; c=relaxed/simple;
	bh=Sj0GmlGTM+/ztv+2EJ6a82JwG1UUKq/y0yaNrf9HdcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpD0/WMtZGx3N/MCHuyv/oLXkPtDJXUo5JIWhaZioxiHfsnBmwkp7cOULHBnbSEhRbE+TjOprKcr7817jjIvJHY0evM/Z3aJpgZKkUf2sErmLIVaNGFdlU4M3u74omztLDi9ZS+/c0/uHb22u6VSktH08OdankBBzEjAfMisFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSdKdAG8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSdKdAG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782490627; x=1814026627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sj0GmlGTM+/ztv+2EJ6a82JwG1UUKq/y0yaNrf9HdcU=;
  b=KSdKdAG8WSfpggAxOrRLDNIdUUHUZrjcflLu7kAKJGf9BkW9Iazup+Ft
   kQqFAivsUw33Jp+kNDIFBkRXTgauUOFxHbBRGydV2mWixkwqUAO824Axf
   bvRJ30LvUtJKUY/rqOy5+8o6rFljqpys03iU99wNjfgXUI/oQVf39921g
   lDml9hxkbhFJY+eF1nIUNr0iw+Iguq5NTSQX2mHRhUxdFAGv3AmS8UIs4
   rcGTsOeMRmcyT7MH22lGUFpLXdS7nS/AlPajRPYT2Hg3DOHPSAyusa8dC
   cD2JtULk2ML1/zvMhsU+euIZpD1s0El4I6Xp2b8WmJ5/spvDudGGCEF9A
   g==;
X-CSE-ConnectionGUID: Imily9hKR4eeykV77DjAvQ==
X-CSE-MsgGUID: fRVP5mLRTvKMYTcJ/7oI4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="83295288"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="83295288"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 09:17:06 -0700
X-CSE-ConnectionGUID: VX6xha95ShKH8tsYlKqAdw==
X-CSE-MsgGUID: /31sroTDSPSfPdiI7kA6KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="256258229"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.96]) ([10.125.109.96])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 09:17:05 -0700
Message-ID: <e97b6cfb-f6e9-4be4-aac2-121330b6c56d@intel.com>
Date: Fri, 26 Jun 2026 09:17:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/features: Reject Get Feature count larger than the
 output buffer
To: Richard Cheng <icheng@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: Zhenhao Wan <whi4ed0g@gmail.com>, dave@stgolabs.net, jic23@kernel.org,
 vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com,
 iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com,
 kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260624134737.49166-1-icheng@nvidia.com>
 <ajxEGmGxOhryENl4@aschofie-mobl2.lan> <ajxHwh3s2lM98aed@aschofie-mobl2.lan>
 <aj4pYfg51dWr__mw@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aj4pYfg51dWr__mw@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/26 12:27 AM, Richard Cheng wrote:
> On Wed, Jun 24, 2026 at 02:10:26PM +0800, Alison Schofield wrote:
>> On Wed, Jun 24, 2026 at 01:54:50PM -0700, Alison Schofield wrote:
>>> On Wed, Jun 24, 2026 at 09:47:37PM +0800, Richard Cheng wrote:
>>>> cxlctl_get_feature() sizes its output buffer from the user's
>>>> fwctl_rpc.out_len, but the device is told to write
>>>> cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
>>>> separate user-controlled value. Nothing bounds count against out_len, so
>>>> a small out_len with a large count overflows the kvzalloc()'d buffer.
>>>> A heap OOB write reachable from FWCTL_RPC.
>>>>
>>>> Reject requests where count exceeds the available payload room, before
>>>> allocating.
>>>>
>>>> Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
>>>> Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
>>>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
>>>> ---
>>>> Changelog:
>>>>
>>>> v1 -> v2:
>>>>     - Drop the reproducer and trim the KASAN splat in the commit message
>>>>     - Sent the reproducer as a regression test in ndctl separately.
>>>
>>> This patch itself looks good. Looking at the other bounds checks
>>> Sashiko suggests, I'd rather see this all fixed up in one patch or
>>> patchset, rather than dribble in as multiple patches.
>>>
>>> Maybe it all fits into one patch, like this:
>>> cxl/features; Add bounds checking for get/set feature commands
>>> or maybe it works better as a set.
>>>
>>> Either way, doing in one swoop would be nice!
>>
>> Oh, seems I'm reading patches out of order.
>>
>> Now I see this: 
>> https://lore.kernel.org/linux-cxl/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/
>> which looks like it covers one of Sashikos's complaints.
>>
> 
> Hi Alison,
> 
> Thanks for pointing this out.
> 
> Then that would be no problem for me, I'll append my fixes with Zhenhao's patch.
> 
> so my original fix + sashiko's complain about cxlctl_set_feature() and cxl_get_feature().
> I'll put them in my work and send as a serie.

Hi Richard, I see sashiko pointed out some existing issues on the series. Will you create fixes for them or should I go do that?

DJ

> 
> --Richard
>  
>>>
>>> -- Alison
>>>
>>>>
>>>> Best regards,
>>>> Richard Cheng
>>>> ---
>>>>  drivers/cxl/core/features.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>>>> index 85185af46b72..9c714ee42a41 100644
>>>> --- a/drivers/cxl/core/features.c
>>>> +++ b/drivers/cxl/core/features.c
>>>> @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>>>>  	if (!count)
>>>>  		return ERR_PTR(-EINVAL);
>>>>  
>>>> +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
>>>> +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>>  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
>>>>  		kvzalloc(out_size, GFP_KERNEL);
>>>>  	if (!rpc_out)
>>>>
>>>> base-commit: ef0c9f75a19532d7675384708fc8621e10850104
>>>> -- 
>>>> 2.43.0
>>>>
>>>

