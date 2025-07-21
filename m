Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7329E0F4;
	Mon, 21 Jul 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119884; cv=none; b=Im0IKRf9YMC+zZpkoy9T1vVZW2raT5gDmW2MpJFGodCYv10IGDaCCwFJ5yXykH14Eglp8ltnuCcF63EqrnyzdI+TG8j+7EjH/BFmiAGDXZj/MPbeZD7om/fbrWzyRqhTW+KeYmBv01W2xjBqP/Z81XXnemyQGfbGiCoAOkTa1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119884; c=relaxed/simple;
	bh=hwiJVOkPsDP+VbcOhbMS3wVsh07jJzA4kLK+6c47NJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eC5eVKvCJfDQnXE848mAPgi0QLrv6vCoerZRPPoXMe6Ikze7VRaEUOrU1YiNsC95IGF5lU+hX6pFXKMkwlxGN8J96deMGQl/AmRd73E954SbhdtCLFH8oLID+N5D3gF2BbRWSZSnDmSpBKVuVOr0t/PQy7CIB7TO6U3RIF9JXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsuY0DoC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsuY0DoC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753119881; x=1784655881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hwiJVOkPsDP+VbcOhbMS3wVsh07jJzA4kLK+6c47NJw=;
  b=GsuY0DoCDtNnCNTtzBmK4Zw6yHsPnrvPm0Bwl73WIrV+FFvC+/H9z4gi
   F6WEZcSW9oUr+GqLgjgTLpiUk+Y5QFZUQ8aN8GUifXqUrPxmL3L1Gk+Yp
   /8M2RACMkmSQ880Qc6iQbHIl9c38gqa4yMXiGp6L+lxvB7Lm0owmEuvBS
   n6cFkB62JWBjM1DWpSdLi/nJRqPGdFB4K8F1QAB80WB1tXyQ1ZxJyPS2O
   7+GGTuInQ85AHhQskPqn6dK0AevwGUD8GUAJc/kcenPy0uEIe8Gbcf/6n
   TBdKm25AovJyJipFHuu/3bW3jF0KGOu64jJ93VLeFm9eSibQtZ7dwrkYh
   g==;
X-CSE-ConnectionGUID: Yja2G+x4RRK6pkJUolBedQ==
X-CSE-MsgGUID: 19+czQY/TaKu20u93HyoBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55302250"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55302250"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:44:41 -0700
X-CSE-ConnectionGUID: GBqSdmuZTTuckkyKlm3+5A==
X-CSE-MsgGUID: a+nYiIWLTmiMb3sFnN8yXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="159319342"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.247.118.153]) ([10.247.118.153])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:44:31 -0700
Message-ID: <29bc0425-7e04-4026-a9b4-d0319bb98855@intel.com>
Date: Mon, 21 Jul 2025 10:44:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/20] cxl/pmem: Add support of cxl lsa 2.1 support in
 cxl pmem
To: Neeraj Kumar <s.neeraj@samsung.com>
Cc: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 a.manzanares@samsung.com, nifan.cxl@gmail.com, anisa.su@samsung.com,
 vishak.g@samsung.com, krish.reddy@samsung.com, arun.george@samsung.com,
 alok.rathore@samsung.com, neeraj.kernel@gmail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev, gost.dev@samsung.com, cpgs@samsung.com
References: <20250617123944.78345-1-s.neeraj@samsung.com>
 <CGME20250617124058epcas5p2324bd3b1bf95d47f553d90fdc727e50d@epcas5p2.samsung.com>
 <592959754.121750165383213.JavaMail.epsvc@epcpadp2new>
 <45c254fe-fd74-46e7-bf06-5614810f7193@intel.com>
 <700072760.81752909483184.JavaMail.epsvc@epcpadp2new>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <700072760.81752909483184.JavaMail.epsvc@epcpadp2new>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/18/25 5:51 AM, Neeraj Kumar wrote:
> On 10/07/25 10:18AM, Dave Jiang wrote:
>>
>>
>> On 6/17/25 5:39 AM, Neeraj Kumar wrote:
>>> Add support of cxl lsa 2.1 using NDD_CXL_LABEL flag. It also creates cxl
>>> region based on region information parsed from LSA.
>>>
>>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>>> ---
>>>  drivers/cxl/pmem.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 59 insertions(+)
>>>
>>> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
>>> index ffcebb8d382f..2733d79b32d5 100644
>>> --- a/drivers/cxl/pmem.c
>>> +++ b/drivers/cxl/pmem.c
>>> @@ -58,6 +58,63 @@ static const struct attribute_group *cxl_dimm_attribute_groups[] = {
>>>      NULL
>>>  };
>>>
>>> +static int match_ep_decoder(struct device *dev, void *data)
>>> +{
>>> +    struct cxl_decoder *cxld = to_cxl_decoder(dev);
>>> +
>>> +    if (!cxld->region)
>>> +        return 1;
>>> +    else
>>> +        return 0;
>>> +}
>>
>> return !cxld->region;
>>
> 
> Thanks, I will fix it in next patch-set
> 
>>
>>> +
>>> +static struct cxl_decoder *cxl_find_free_decoder(struct cxl_port *port)
>>> +{
>>> +    struct device *dev;
>>> +
>>> +    dev = device_find_child(&port->dev, NULL, match_ep_decoder);
>>> +    if (!dev)
>>> +        return NULL;
>>> +
>>> +    return to_cxl_decoder(dev);
>>> +}
>>> +
>>> +static int create_pmem_region(struct nvdimm *nvdimm)
>>> +{
>>> +    struct cxl_nvdimm *cxl_nvd;
>>> +    struct cxl_memdev *cxlmd;
>>> +    struct cxl_nvdimm_bridge *cxl_nvb;
>>> +    struct cxl_pmem_region_params *params;
>>> +    struct cxl_root_decoder *cxlrd;
>>> +    struct cxl_decoder *cxld;
>>> +    struct cxl_region *cxlr;
>>> +
>>
>> probably need a lockdep_assert_held(&cxl_region_rwsem).
>>
> 
> Thanks Dave, Sure i will fix it with V2
> 
>>> +    if (!nvdimm)
>>> +        return -ENOTTY;
>>
>> -ENODEV?
> 
> Sure I will fix it with V2
> 
>>
>>> +
>>> +    if (!nvdimm_has_cxl_region(nvdimm))
>>> +        return 0;
>>> +
>>> +    cxl_nvd = nvdimm_provider_data(nvdimm);
>>> +    params = nvdimm_get_cxl_region_param(nvdimm);
>>> +    cxlmd = cxl_nvd->cxlmd;
>>> +    cxl_nvb = cxlmd->cxl_nvb;
>>> +    cxlrd = cxlmd->cxlrd;
>>> +
>>> +    /* FIXME: Limitation: Region creation only when interleave way == 1 */
>>> +    if (params->nlabel == 1) {
>>> +        cxld = cxl_find_free_decoder(cxlmd->endpoint);
>>> +        cxlr = cxl_create_pmem_region(cxlrd, cxld, params,
>>> +                atomic_read(&cxlrd->region_id));
>>> +        if (IS_ERR(cxlr))
>>> +            dev_dbg(&cxlmd->dev, "Region Creation failed\n");
>>
>> return PTR_ERR(cxlr); ?
>>
> 
> Thanks, I will fix it in next patch-set
> 
>>> +    } else {
>>> +        dev_dbg(&cxlmd->dev, "Region Creation is not supported with iw > 1\n");
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>  static int cxl_nvdimm_probe(struct device *dev)
>>>  {
>>>      struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
>>> @@ -74,6 +131,7 @@ static int cxl_nvdimm_probe(struct device *dev)
>>>          return rc;
>>>
>>>      set_bit(NDD_LABELING, &flags);
>>> +    set_bit(NDD_CXL_LABEL, &flags);
>>
>> Ok here's the NDD_CXL_LABEL set. I think the driver should be probing the label index block and retrieve the label version and determine how to support from there instead of hard coding a flag.
> 
> Hi Dave,
> 
> We actually write label index information into LSA during namespace/region label updation.
> During that time we update its major/minor.
> 
> So during first time updation of LSA we must need some way to inform nvdimm about LSA versioning.

Gotcha. I'm not sure I like adding just a single version (flag bit) to the flags for __nvdimm_create(). Maybe we need some refactoring on the nvdimm side to allow passing in an enum for LSA versioning looking to the future. Thoughts? Also I wonder on the CXL side we need to add some checking of LSA size when retrieved from Identify Memory Device payload in order to make sure the LSA we want is supported properly by the device. 
> 
> 
> Regards,
> Neeraj
> 

