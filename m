Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2AC4A23;
	Fri,  3 Oct 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508424; cv=none; b=pXe2asswhbqJxMx2ZvFE02UvLNLc7CeN+9SHOl4T0UNxdRC8oxmB7cYKSAFdfrv6TN78IHePG8OzOBB275fQu4lER2jnkVwj1Fuxx9rW9Fy8L02TFbPgiTuJ+NIQck2PzXcsASGsYQIzwyqs2KOVxAhmIJB7Rul9ZwflElVaWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508424; c=relaxed/simple;
	bh=mM1hNAXwkwPhKdnhixFoQokzvASPkj77teXZPwtDJ7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Obul34KWKDff1YZiTJvq9hAjXdIXY5G6xOjM285+lTjckMq/0uySghaMOc3IMSikUh+INFz6otEia9yNflqCtA6NM2I++i1vfMWiA8vCc194ZpTl/4JSAojfdQOUeNPyLB7cT+xjFMG3yM9KsfT94foV+Z1Xa0aq3JLl+20meHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbTBvAnz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbTBvAnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759508423; x=1791044423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mM1hNAXwkwPhKdnhixFoQokzvASPkj77teXZPwtDJ7k=;
  b=QbTBvAnzIVzFWZAwZGwdxnIUbMmhjHquKMKULakuadn3dDlRQQoTPtKq
   aEDXvVwsDf2nqq1MDqjHgYmBSd2O1nho3lRYxkYffksuhg45cKRihdQT2
   quTxmCjj7ICRVKCt4gsjWhgNZqrzUlUS4bmLQsWocGOYpfy+CmQATxEE4
   E6twB08h6qDFpIp+uPIkS9OfFBbndjMsCjVewwBcLtAw3eYbFAUliM+v4
   NdUiURIpb/dzBlB14HGWltS131EEwseSZf2bJvfKNMHmFynpABm/ngW2r
   DWqaPL7hWKrOxV+yVF2aZsgcC0dw4ao6HmEaj8/qOWaqG1NIOK0e9p46V
   g==;
X-CSE-ConnectionGUID: zN4BvM+yRlKxzPAs0AcHRw==
X-CSE-MsgGUID: mDqHsb9cR5SNHs7766dBxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61754159"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61754159"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:20:22 -0700
X-CSE-ConnectionGUID: 2yjUvoHCS/OspiWTLjMUsw==
X-CSE-MsgGUID: kJnAWF/aR9eBNb6ildd7yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="183605567"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:20:21 -0700
Message-ID: <427afe0e-0fd6-4361-ba27-350760e68147@intel.com>
Date: Fri, 3 Oct 2025 09:20:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders
To: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Zijun Hu <zijun.hu@oss.qualcomm.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/2/25 5:59 PM, Vishal Aslot wrote:
> init_hdm_decoder() fails with -ENXIO if a
> committed HDM decoder has zero size.
> 
> The CXL spec permits committing zero sized decoders.
> See "8.2.4.20.12 Committing Decoder Programming".
> It says,"It is legal for software to program Decoder
> Size to 0 and commit it. Such a decoder will not
> participate in HDM decode."
> 
> This patch updates init_hdm_decoder() to return
> -ENOSPC if the decoder is commited with zero-size.
> The caller leaves the decoder allocated but does not
> add it. It simply continues to the next decoder.
> 
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>

Hi Vishal,
Next time please post the next version of patches as a new thread and not a response to a previous discussion. It would make lore [1] viewing easier. Thanks!

[1]: https://lore.kernel.org/linux-cxl/aN_cUPzzwUy-s36n@gourry-fedora-PF4VCD3F/T/#t

DJ
 
> ---
>  drivers/cxl/core/hdm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..50164fd1b434 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1047,10 +1047,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>                 }
> 
> +               port->commit_end = cxld->id;
> +
>                 if (size == 0) {
> -                       dev_warn(&port->dev,
> +                       dev_dbg(&port->dev,
>                                  "decoder%d.%d: Committed with zero size\n",
>                                  port->id, cxld->id);
> -                       return -ENXIO;
> +                       return -ENOSPC;
>                 }
> -               port->commit_end = cxld->id;
>         } else {
> @@ -1210,6 +1210,9 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>                                       &dpa_base, info);
>                 if (rc) {
> +                       if (rc == -ENOSPC) {
> +                               continue;
> +                       }
>                         dev_warn(&port->dev,
>                                  "Failed to initialize decoder%d.%d\n",
>                                  port->id, i);
> --
> 2.34.1
> 
>> ________________________________________
>> From: Vishal Aslot <vaslot@nvidia.com>
>> Sent: Wednesday, October 1, 2025 8:57 PM
>> To: Dave Jiang; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-cxl@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
>>
>> External email: Use caution opening links or attachments
>>
>>
>>> ________________________________________
>>> From: Dave Jiang <dave.jiang@intel.com>
>>> Sent: Wednesday, October 1, 2025 5:46 PM
>>> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-cxl@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
>>>
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 10/1/25 3:03 PM, Vishal Aslot wrote:
>>>> Thanks for the quick review, Dave. Yes, forgot to put the commit message. :)
>>>> About the copyright message. Should I not be updating the year to 2025 in it?
>>>
>>> I wouldn't bother unless you are doing massive changes and in that case it would be adding NVidia copyright anyhow for you. Also, typically linux mailing lists prefer responding inline and >> not top posting.
>>
>> Ah, understood. Thanks for the mentoring.
>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> ________________________________________
>>>> From: Dave Jiang <dave.jiang@intel.com>
>>>> Sent: Wednesday, October 1, 2025 4:28 PM
>>>> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-cxl@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
>>>>
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 10/1/25 1:37 PM, Vishal Aslot wrote:
>>>>> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
>>>>
>>>> Missing commit log?
>>
>> Yes, will add one in v2.
>>
>>>>>
>>>>> ---
>>>>>  drivers/cxl/core/hdm.c | 9 +++++++--
>>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>>> index e9e1d555cec6..97a5f27f5b72 100644
>>>>> --- a/drivers/cxl/core/hdm.c
>>>>> +++ b/drivers/cxl/core/hdm.c
>>>>> @@ -1,5 +1,5 @@
>>>>>  // SPDX-License-Identifier: GPL-2.0-only
>>>>> -/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>>>>> +/* Copyright(c) 2022-2025 Intel Corporation. All rights reserved. */
>>>>
>>>> Stray change?
>>
>> No, it was intentional but I understand that for this small update, I don't need to update copyright info. I'll undo this change in v2.
>>
>>>>
>>>>>  #include <linux/seq_file.h>
>>>>>  #include <linux/device.h>
>>>>>  #include <linux/delay.h>
>>>>> @@ -1050,7 +1050,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>>>>                         dev_warn(&port->dev,
>>>>>                                  "decoder%d.%d: Committed with zero size\n",
>>>>>                                  port->id, cxld->id);
>>>>
>>>> I wonder if we should make this dev_dbg() now that it's a valid case.
>>
>> Yes, makes sense. I'll change it to dev_dbg() in v2.
>>
>>>>
>>>>> -                       return -ENXIO;
>>>>> +                       return -ENOSPC;
>>>>>                 }
>>>>>                 port->commit_end = cxld->id;
>>>>>         } else {
>>>>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>>>>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>>>>>                                       &dpa_base, info);
>>>>>                 if (rc) {
>>>>> +                       if (rc == -ENOSPC) {
>>>>> +                               put_device(&cxld->dev);
>>>>
>>>> Why put_device()? Should we enumerate this decoder instead of pretend it doesn't exist? essentially only a dev_set_name() and device_add()?
>>
>> That is a good point. The decoder has been committed so it should be accounted for in the OS.
>> I'll remove put_device() in v2.
>>
>>>>
>>>>> +                               rc = 0;
>>>>
>>>> Don't think this is needed since the continue will put it at start of the loop where rc gets written by init_hdm_decoder() return value.
>>
>> Agreed. I was being paranoid. Will remove it in v2.
>>
>>>>
>>>>> +                               continue;
>>>>> +                       }
>>>>>                         dev_warn(&port->dev,
>>>>>                                  "Failed to initialize decoder%d.%d\n",
>>>>>                                  port->id, i);
>>>>> --
>>>>> 2.34.1
>>>>

