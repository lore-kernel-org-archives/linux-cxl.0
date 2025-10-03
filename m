Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E926E6FA;
	Fri,  3 Oct 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508075; cv=none; b=LFZaz04Z2C1AmthpZB7As22KEbB0oyXhGsvq4R5ejBvBLN8RrmFhCEDzfxu7RYj8p+aBcK7prT3ZrhJus0t5SA2i5jJTg4+99IlfHMJ6sxBUN6BHhqjiccPtAqOQ5y15a+wUxEMORTalQkiV2YS4LvIIpRbnA2GgJLkjqiSknKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508075; c=relaxed/simple;
	bh=dQk/Wx+OgHdP1VW5xgsNaKcBpPnk3gpbOYRqWi4IHb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioEAkIFLOnYCRS+xqJpod28uVe+z7ozjkUR+35429K9g1OG/sODQ6d6+LAt69x5FWKZc5J6O1/cS8rFTJKABWu4RDdGG75edrkYHJ0hR/FlUifzeFEepI6PWnxGBLim02JGeslyMspYuauBOHBfOH2vOguFF6NVOzqQ+gwYMpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0Rq4wS/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0Rq4wS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759508073; x=1791044073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dQk/Wx+OgHdP1VW5xgsNaKcBpPnk3gpbOYRqWi4IHb8=;
  b=m0Rq4wS/Qc6xIjfURLnaGqRYVsAkcV9IpTTcnn9sGUwbB4iRTSb/wPH2
   s6WuMa/W/IgFgbmNeP71v5J7Bt/AATa1El8sNAbAqxWr22dgZftq1M2tr
   7Ik57XGJ8z7ZpXq1LPoUq/bVM6PUFSz52QKsBVIQuirQkgjgIdTBuClo5
   UqHoQXSmNVHLWN5r1/Sq4y2NxgUEdNj2CBZGA/QqM3wKWObWydI0WeTHf
   3PoRN8fpdtIW9+miId+2fMQaSdErjzUu2AxnC5a38BisW06YFWqCjlHjY
   MW8qA0t3LgaS+ypqVmsoEm71GmlHOvmCiwlsK6CKsIZsGBJD8DxU22iXF
   w==;
X-CSE-ConnectionGUID: eQAtFzUAT5OXzz57Ex22Fw==
X-CSE-MsgGUID: 4Dt3/cYYSOODt5ETpQpG2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="72040002"
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="72040002"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:14:32 -0700
X-CSE-ConnectionGUID: ZMZQXFJRRB+0QS9GM/gmDA==
X-CSE-MsgGUID: 54SLd7gFQtqWOk0XMIhkDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="179250311"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:14:30 -0700
Message-ID: <43ca6827-2bcc-41d3-8a7b-3aec24f2b0e1@intel.com>
Date: Fri, 3 Oct 2025 09:14:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
To: Vishal Aslot <vaslot@nvidia.com>, Gregory Price <gourry@gourry.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Zijun Hu <zijun.hu@oss.qualcomm.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
 <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
 <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/2/25 6:03 PM, Vishal Aslot wrote:
>> ________________________________________
>> From: Dave Jiang <dave.jiang@intel.com>
>> Sent: Thursday, October 2, 2025 10:32 AM
>> To: Gregory Price; Vishal Aslot
>> Cc: Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 10/1/25 10:48 PM, Gregory Price wrote:
>>> On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:
>>>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>>>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>>>>                                       &dpa_base, info);
>>>>                 if (rc) {
>>>> +                       if (rc == -ENOSPC) {
>>>> +                               put_device(&cxld->dev);
>>>> +                               rc = 0;
>>>> +                               continue;
>>>> +                       }
>>>
>>> How do you suggest actually testing this? I briefly poked at this in
>>> QEMU trying to commit decoders, but i found myself incapable of
>>> exercising this path.
> 
> I tested it locally with our BIOS (UEFI) where we commit and lock all decoders and
> all except decoder 0 are zero-sized.
> 
>>
>> It may be worthwhile adding a cxl_test test case for this.
> 
> Yeah, sure. Would cxl mock tests be the right place to explore this?

Yes. Under tools/testing/cxl. Let me know if you need help with that.

DJ

> 
>>>
>>>>                         dev_warn(&port->dev,
>>>>                                  "Failed to initialize decoder%d.%d\n",
>>>>                                  port->id, i);
>>>> --
>>>> 2.34.1
> 

