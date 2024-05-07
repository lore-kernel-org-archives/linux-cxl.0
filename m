Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05F1649D3;
	Tue,  7 May 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097176; cv=none; b=SOB+jPcNN18cjG91DpW+XKl1b6pfVgKUXqgR5zT09lPSRqrZpibL0nZtGRkEkzQrylzccCbgQTHvpvcvWAP6kfD81uyVVrAtshwtntVEuXHiMCxJq+VAiSS/afziTZmKJccx35pgVkWsFc3m2sIKWsFlVBNOqx5FnZ3b6/bqpjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097176; c=relaxed/simple;
	bh=oATHeOCDE4cJRmzez2BOUIoT8jvPZHsD3t1b1GDNdSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahdlC68gfrWbC7L7e5lSYZhSoNYrUktsyYLYugk8vZK7KyJO6WVlf2h8YOq5zVt0WJcyI5OiHqpOVycaBVnMFSjRSEp9KePx7HIFSzjykjwowmlHJ1Bkr0eLrdv8AZW+RPEoM/qISQl0yks/KGd34fSysOLkJc98VeFO7g3dUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVzrSY41; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVzrSY41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715097175; x=1746633175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oATHeOCDE4cJRmzez2BOUIoT8jvPZHsD3t1b1GDNdSo=;
  b=TVzrSY41auyJUqQR04J/rpBcUY0MQ7RnUQjcZiASNhw5EYJqjvf/T9Gt
   Drc3qg3vRtBGmR6h8TZm5kB/KhNWw9PeRzCAtXXxdGvalcUZsLRe3woEZ
   0UmyBAv3KJFOmRB8xOXXorm7ARyZGm8xF+7o034fODXVs24xso4YS8ac3
   o5KdCuLUDgPVD8orzkbdQJbTBhaaWSInkfLGPFodWs0JFIfeZ79Zr+zI6
   VAZTV7pvWoPmK1eipOLfKVWaELb9tVagSIjIjYYLr4RPEhDq2xOOLlwvJ
   uIcv5Dq1vBL3mSb9GJ7Pwm9ymYfca4PmPg2nVVGqobeQCpaxoriaHpDva
   Q==;
X-CSE-ConnectionGUID: /OVPfpzeTXu2b4MmNWeADg==
X-CSE-MsgGUID: WBFNy7hASXa+e2FLOljT8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10839797"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="10839797"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:52:54 -0700
X-CSE-ConnectionGUID: XD28RgZ7Tu2MAYcICRY2fg==
X-CSE-MsgGUID: 6lk8MhRUSFWB58AJas18ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="29140265"
Received: from kinlongk-desk.amr.corp.intel.com (HELO [10.125.110.95]) ([10.125.110.95])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:52:54 -0700
Message-ID: <0a086052-5ed0-4b5f-b676-338662c2dbea@intel.com>
Date: Tue, 7 May 2024 08:52:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Ira Weiny <ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240428053715.327444-1-lizhijian@fujitsu.com>
 <662fc9659f6ab_19ca3929435@iweiny-mobl.notmuch>
 <0782e741-5478-4b62-866e-f966ab5cad91@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0782e741-5478-4b62-866e-f966ab5cad91@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/24 7:42 PM, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 30/04/2024 00:23, Ira Weiny wrote:
>> Li Zhijian wrote:
>>> Move memregion_free(id) out of cxl_region_alloc() and
>>> explicately free memregion in devm_cxl_add_region() error path.
>>    ^^^^
>>    explicitly
>>
>> BTW you should run checkpatch.pl which will check spelling.
> 
> 
> I remember I've done this check, but it seems the it doesn't work for me.
> Did I miss something?
> 
> $ ./scripts/checkpatch.pl 0001-cxl-region-Fix-memregion-leaks-in-devm_cxl_add_regio.patch
> total: 0 errors, 0 warnings, 23 lines checked
> 
> 0001-cxl-region-Fix-memregion-leaks-in-devm_cxl_add_regio.patch has no obvious style problems and is ready for submission.

Pass in --codespell parameter. And make sure you have the codespell dictionary installed (i.e. /usr/share/codespell/dictionary.txt). 

DJ

> 
> 
> 
>>
>> I'm not following what the problem is you are trying to fix.  This seems
>> like it just moves the memregion_free() around a bit but the logic is the
>> same.
>>
> 
> Sorry, I think my commit log may be misleading. In fact, this patch mainly fixes
> the memregion leak in devm_cxl_add_region() when it gets an invalid mode.
> 
>>>   	default:
>>>   		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
>>> +		memregion_free(id);
>>>   		return ERR_PTR(-EINVAL);
>>>   	}
> 
> Additionally, to maintain consistent error handling, I also moved memregion_free(id) from
> cxl_region_alloc() to devm_cxl_add_region() so that devm_cxl_add_region() can
> free memregion explicitly in error path.
> 
> 
> Thanks
> Zhijian
> 
> 
>> Ira
>>
>>>
>>> After cxl_region_alloc() succeed, memregion will be freed by
>>> cxl_region_type.release()
>>>
>>> Fixes: 6e099264185d ("cxl/region: Add volatile region creation support")
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>> ---
>>>   drivers/cxl/core/region.c | 9 +++++----
>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 812b2948b6c6..8535718a20f0 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -2250,10 +2250,8 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>>>   	struct device *dev;
>>>   
>>>   	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
>>> -	if (!cxlr) {
>>> -		memregion_free(id);
>>> +	if (!cxlr)
>>>   		return ERR_PTR(-ENOMEM);
>>> -	}
>>>   
>>>   	dev = &cxlr->dev;
>>>   	device_initialize(dev);
>>> @@ -2358,12 +2356,15 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>>   		break;
>>>   	default:
>>>   		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
>>> +		memregion_free(id);
>>>   		return ERR_PTR(-EINVAL);
>>>   	}
>>>   
>>>   	cxlr = cxl_region_alloc(cxlrd, id);
>>> -	if (IS_ERR(cxlr))
>>> +	if (IS_ERR(cxlr)) {
>>> +		memregion_free(id);
>>>   		return cxlr;
>>> +	}
>>>   	cxlr->mode = mode;
>>>   	cxlr->type = type;
>>>   
>>> -- 
>>> 2.29.2
>>>
>>
>>
