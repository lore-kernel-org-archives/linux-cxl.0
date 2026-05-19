Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF013769F0
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207259; cv=none; b=gdI3z7doxoiwpRPAVHlXV+ZkcO2qcuCEvtOVWRlqD9JVZAp2i4Q0N5H8KKEqw7hZP8+YYTCfT6zCn8BhlElKCetiZY7pC0Xr08NC2cZtiS7eyf0dPqAJTe3tnYGMcnkdbRZrJZ28RkoQn3Fcu81A+/3ZqFzA//OrCJ+AUkVSrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207259; c=relaxed/simple;
	bh=tLfAzdeoIxuV8PkeKb1dLr1W/hYoNkguOx3ekNyxlgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G14nVEprYK66goLPXTSiurnqkrME6eSSGTlQZA01aK6OzQsEw76DUy7RtbyJnONuK204z4W5d7FUeEv64VwtmsUVX9bDcX0S+Dv25F2802ntW6jdMcLuaXbbJm53gbuYuhtsg2x1a9rKS5B/Jrofbz7U8XPhqfmA6KgY7xjcEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZsy0ucj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZsy0ucj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779207257; x=1810743257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tLfAzdeoIxuV8PkeKb1dLr1W/hYoNkguOx3ekNyxlgE=;
  b=jZsy0ucjDYYrd5SrLYC3Se789Q3Ih2FNxnDz5p7biHV+KSjuXPOOoLtU
   EYEsh3SSlKaJ8fkZSlrcjEyXncVtnxdjuNrI5Wv2qY1pO0FOQbHEG7/pa
   j4Z+Jo2Aq131YzMOhutD0Ws9aC6WkygpC+YRQKTRMqyOdWQsN/Q1bGDSj
   s41DzHp+5MXvsjCtUdxnWkewyoUjwzp5waGBw5x75vhGp1fI/1ntdWEfm
   fHllc1R53IV4G+ykuDgafHPOZwfDDVTAkEd5bwBKmTeusAIqnC0+bnUHR
   ueXjDwcZgSXnj4pH+0kHJAwzYGWXBsUInNq4yd6GXh+T43/AV72B04Exl
   Q==;
X-CSE-ConnectionGUID: ZCcnAkfVSvi1suL9C+BG+Q==
X-CSE-MsgGUID: 3x0HuC0XRr6564+Ghu+kSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80053921"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80053921"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 09:14:17 -0700
X-CSE-ConnectionGUID: pTZaQSFKQbS4oGulXWJ9Aw==
X-CSE-MsgGUID: n+fjAppWSHm9dihSaGuRRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233449517"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.143]) ([10.125.109.143])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 09:14:15 -0700
Message-ID: <389a2b6a-6b1e-48bb-9353-76b2cf74951b@intel.com>
Date: Tue, 19 May 2026 09:14:14 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] cxl/mem: Wire up BI for Type 3 device
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Davidlohr Bueso <dave@stgolabs.net>, djbw@kernel.org
Cc: jic23@kernel.org, alucerop@amd.com, alison.schofield@intel.com,
 ira.weiny@intel.com, gourry@gourry.net, dongjoo.seo1@samsung.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <20260516022037.1761453-6-dave@stgolabs.net>
 <3e918936-d252-4a1a-83a5-9de2b895539a@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3e918936-d252-4a1a-83a5-9de2b895539a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/18/26 2:29 PM, Cheatham, Benjamin wrote:
> On 5/15/2026 9:20 PM, Davidlohr Bueso wrote:
>> Setup BI flows during cxl_mem_probe() after endpoint enumeration and
>> EDAC registration.
>>
>> BI setup failure is non-fatal - the device continues to operate
>> in HDM-H mode without back-invalidate support.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> I would mention why this patch is split it somewhere (cover letter would be fine).
> I think the reason it's split out from 2/5 is that you need the HDM setup portions
> before enabling the device. You could possibly reorder the series so that the HDM
> set up is first then squash this into the current 2/5, but that's probably overkill.

Given how small this change is and stand alone, it would make more sense to be with 2/5 so the reviewer can see how it's being used when reviewing 2/5. Also, when you need to do git bisect, it would make more sense.

DJ

> 
> Also, I'd change the subject from "Wire up" to "Enable" since that's what it seems this
> is doing.
> 
> Thanks,
> Ben
>> ---
>>  drivers/cxl/mem.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index fcffe24dcb42..f2d01a218895 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -150,6 +150,10 @@ static int cxl_mem_probe(struct device *dev)
>>  	if (rc)
>>  		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
>>  
>> +	rc = cxl_bi_setup(cxlds);
>> +	if (rc)
>> +		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
>> +
>>  	/*
>>  	 * The kernel may be operating out of CXL memory on this device,
>>  	 * there is no spec defined way to determine whether this device
> 

