Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF423505E;
	Wed,  1 Oct 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358777; cv=none; b=CXd4QC2l7tAXacPKgISGjp79HLHM05KqMgJmGH1fT1X++NUIERwUGWaXdZMq4UWaDfQ/aGFETIdngjPxE5zfg4G62xUeREtt3Ct/62TMeu569ijsd6CT+YyO0ObUrLfSkpYsh5D3x6o1H58FijB5u0vyyolYBPcbgUzp36fhxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358777; c=relaxed/simple;
	bh=oOiWhS9nB6/6NfyETAyD3O7VzbBmXHnv2cjX6z3htnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2JZ+P8Me4jzZs5/K/hW2oeOC4PtcXpC0OzW5bpCWa3GxQI1n/poZHdXnJhoxPKowBLJU+rPnvbnwW6OdAOQy+zpr5vbIRKL2gSg9x4C7kqmTJ5G4nmHgOce2JkEdFB4XYCSQR7qrTu0nvK4j9wz4IjYl7b08nzv/SoBMdliL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibfakvEq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibfakvEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759358775; x=1790894775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oOiWhS9nB6/6NfyETAyD3O7VzbBmXHnv2cjX6z3htnk=;
  b=ibfakvEqRnunKdPnah8A26+abElB2vvaAjS1mNHKMVoyL9+BWbZ9MDen
   NuQUVaIzbaFHsfsYu6ZRnOpn6I6rTQxXhHSg60BZf3bkbl5citrO/UBoD
   E5+JncQvdL9SxqGNwbtExUTo8bXXaHRrtsARHeDomF6daDOdp0L/tcfaW
   GfM2tscq52sfGwBOShNCypIHf5oApG0D3IWXo3gpVXDlA90IzW1Xsvb+2
   qUwfQzysYLKLgZ7YLTEYhxBbz35rTO9Cyk4aFNjK43omgAKc5QlTH7bpm
   NV4tkaAOmc0NqR8df0SQ4px9633togd2p6yby6bW6uRXxVwGDAEx9NXec
   w==;
X-CSE-ConnectionGUID: cen6kSypSju0z4IKQfJSuA==
X-CSE-MsgGUID: 4Y5cCbt6T8Cj5Q5xhXXh+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61556715"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="61556715"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 15:46:14 -0700
X-CSE-ConnectionGUID: BkiZc6BqSkiXfTm6Yzt+Dg==
X-CSE-MsgGUID: LTQFEUSbRu6JdD2D3Q9p9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="202629285"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.109.218]) ([10.125.109.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 15:46:13 -0700
Message-ID: <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
Date: Wed, 1 Oct 2025 15:46:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/25 3:03 PM, Vishal Aslot wrote:
> Thanks for the quick review, Dave. Yes, forgot to put the commit message. :)
> About the copyright message. Should I not be updating the year to 2025 in it?

I wouldn't bother unless you are doing massive changes and in that case it would be adding NVidia copyright anyhow for you. Also, typically linux mailing lists prefer responding inline and not top posting.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> ________________________________________
> From: Dave Jiang <dave.jiang@intel.com>
> Sent: Wednesday, October 1, 2025 4:28 PM
> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
> 
> External email: Use caution opening links or attachments
> 
> 
> On 10/1/25 1:37 PM, Vishal Aslot wrote:
>> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> 
> Missing commit log?
> 
>> ---
>>  drivers/cxl/core/hdm.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index e9e1d555cec6..97a5f27f5b72 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -1,5 +1,5 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>> -/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>> +/* Copyright(c) 2022-2025 Intel Corporation. All rights reserved. */
> 
> Stray change?
> 
>>  #include <linux/seq_file.h>
>>  #include <linux/device.h>
>>  #include <linux/delay.h>
>> @@ -1050,7 +1050,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>                         dev_warn(&port->dev,
>>                                  "decoder%d.%d: Committed with zero size\n",
>>                                  port->id, cxld->id);
> 
> I wonder if we should make this dev_dbg() now that it's a valid case.
> 
>> -                       return -ENXIO;
>> +                       return -ENOSPC;
>>                 }
>>                 port->commit_end = cxld->id;
>>         } else {
>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>>                                       &dpa_base, info);
>>                 if (rc) {
>> +                       if (rc == -ENOSPC) {
>> +                               put_device(&cxld->dev);
> 
> Why put_device()? Should we enumerate this decoder instead of pretend it doesn't exist? essentially only a dev_set_name() and device_add()?
> 
>> +                               rc = 0;
> 
> Don't think this is needed since the continue will put it at start of the loop where rc gets written by init_hdm_decoder() return value.
> 
>> +                               continue;
>> +                       }
>>                         dev_warn(&port->dev,
>>                                  "Failed to initialize decoder%d.%d\n",
>>                                  port->id, i);
>> --
>> 2.34.1
> 

