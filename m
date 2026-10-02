Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B135B12B;
	Fri,  2 Oct 2026 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956379; cv=none; b=jDt4cAQICjCuND4yPaiTe2uEkwRuaOWMCnFpMArLTq07+XqflRAZwseAOsc8a9unsW/ovjNtGOE7IXi4siLwX1LYliTY4GYSTbQgU/u3tJrWfFhA6njubrDEyspJ1/QWwQXtdSdDv8jrI2yQd7AqPLzefxsddXgfpgH7JhB1lXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956379; c=relaxed/simple;
	bh=mVY4WGL0c2JBVVMHU5oIBoG6JJKS295nr6bnPzP4v6Y=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=o4/uBeIy7HKRPJsPpDgppu263fthM00mAE3l3Efi9wkeijgdIFH0Zcyfh6hTZFmkf1+wsiXSI+zZinmIgwPD37EsMP3E4DFLwQYU4bJg38kRF5N0nNR5kOgtjSfhJGeV4hEkrJBFUv4CMOMu/chnyA2GmXbTl6HwZKHYLaL6/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdFzCwLZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdFzCwLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790956374; x=1822492374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=mVY4WGL0c2JBVVMHU5oIBoG6JJKS295nr6bnPzP4v6Y=;
  b=NdFzCwLZhfUG8YRP16m3Z48EnKuTpMvbjKNhCK89u0dLnlyvq4BLVcvK
   ksnsZWeG0Fi2Fd8N4JAHrPjPzPRz94Iri0fhRMtFHHm+MwGubtZZ/FJEp
   H8ZGnSk+Sp6dwerq0mMfNsDuNo6tnpXlZqNCLUE6NGxduopD9OgR1Gr3L
   tOcYbHKnw1/+oe0IueNqmSEouLmVKCWc+jCDYmpY31F3/uxAkYWVVJw42
   Qh3wGAA3ecGKLHmepvBvqWXEqj3/a4Q9+fVy89r8/YDJz2gbPNARp+vh+
   XJi/8zMlZv3KL2mT4Ma3r0vrxr+umI2PLR/mpREuUmUe8FdGypCNL7rEe
   w==;
X-CSE-ConnectionGUID: fLJ7zTV+RreFufvTnFabhw==
X-CSE-MsgGUID: jvbH5CWrSWCvtmda/iysFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="113506178"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208,223";a="113506178"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:52:48 -0700
X-CSE-ConnectionGUID: aQb3EjZqT6y1VdFJzBcdQw==
X-CSE-MsgGUID: Z6UQPGumRyixm/svOqSIhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208,223";a="305775892"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.108.45]) ([10.125.108.45])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:52:48 -0700
Content-Type: multipart/mixed; boundary="------------lc2O18MPElWXN1IjKCVeNrpu"
Message-ID: <bd412198-8a25-436c-b6d6-6b6730e8c28e@intel.com>
Date: Fri, 2 Oct 2026 08:52:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/region: Add region reference in memdev attach
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-3-alucerop@amd.com>
 <6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com>
 <8ebaae42-a0c6-4e9c-be1b-ca68a4769ed7@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <8ebaae42-a0c6-4e9c-be1b-ca68a4769ed7@amd.com>

This is a multi-part message in MIME format.
--------------lc2O18MPElWXN1IjKCVeNrpu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/1/26 9:41 PM, Lucero Palau, Alejandro wrote:
> 
> On 01/10/2026 22:38, Dave Jiang wrote:
>>
>> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Use a new field in cxl_attach_region struct for easily link it with the
>>> region the memdev is attached to.
>>>
>>> This facilitates device links creation where such a region is the supplier
>>> with non-PF0 physical functions wanting to use the CXL region being the
>>> consumers.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/region.c | 1 +
>>>   drivers/cxl/cxlmem.h      | 2 ++
>>>   2 files changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 27e63e6dab7c..78ca7ebc3e55 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>>       if (rc)
>>>           return rc;
>>>   +    attach->cxlr = cxlr;
>>>       attach->hpa_range = (struct range) {
>>>           .start = cxlr->params.res->start,
>>>           .end = cxlr->params.res->end,
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index c401e3a1af06..c598561b8e5f 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -104,6 +104,7 @@ struct cxl_memdev_attach {
>>>   /**
>>>    * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>>    * @attach: common core attachment descriptor
>>> + * @cxlr: cxl region the memdev is attached to.
>>>    * @hpa_range: physical address range of the region
>>>    *
>>>    * For the common simple case of a CXL device with private (non-general purpose
>>> @@ -112,6 +113,7 @@ struct cxl_memdev_attach {
>>>    */
>>>   struct cxl_attach_region {
>>>       struct cxl_memdev_attach attach;
>>> +    struct cxl_region *cxlr;
>>>       struct range hpa_range;
>>>   };
>>>   
>> attach->cxlr is never cleared when the region goes away. Unbinding the endpoint port runs endpoint_unregister_region(), which unregisters the region and drops its reference. PF0 stays bound until the detach work runs.
>>
>> A non-PF0 probe in that window still finds the memdev and calls device_link_add() on the freed region.
> 
> 
> I do not think so. This version, see next patch, relies on locking the supplier, PF0, before getting the memdev and potentially using the attach region. Only on PF0 release can such a memdev and region disappear, so I think this is enough.
> 

The memdev, yes. It's devm on PF0. The region, no. Unbinding the endpoint port, or cxl_mem from the memdev, runs endpoint_unregister_region() under the endpoint's lock, not PF0's. PF0's release is only queued (schedule_detach() -> detach_memdev()). Until that work runs, PF0 is bound, the memdev is found, hpa_range is valid, and attach->cxlr points at a freed region. Root teardown (kill_regions()) and delete_region also unregister the region without touching PF0.

I attached an LLM generated test kernel module you can use to reproduce the KASAN complaint. Commit log provides instructions.
BUG: KASAN: slab-use-after-free in device_link_add+0x521/0xa80
 cxl_get_range_and_link+0xa9/0x120 [cxl_core]

DJ

> I added comments in the exported function, cxl_get_range_and_link() which does the locking before calling the internal function __cxl_get_range_and_link() which looks for the memdev and the attach region. In fact, it should not be possible to obtain the PF0 memdev reference and the attach region not there yet, but the code is still checking that possibility as a sanity check.
> 
> 
> Thank you,
> 
> Alejandro.
> 
> 
>> How about something like this?
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 27e63e6dab7c..38ca73f12b84 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -4076,6 +4076,23 @@ static int first_mapped_decoder(struct device *dev, const void *data)
>>       return 0;
>>   }
>>   +/*
>> + * Invalidate @attach before the region goes away so that
>> + * cxl_get_range_and_link() can not pick up a stale region.
>> + */
>> +static void endpoint_detach_attach_region(void *_attach)
>> +{
>> +    struct cxl_attach_region *attach = _attach;
>> +    struct cxl_region *cxlr;
>> +
>> +    scoped_guard(rwsem_write, &cxl_rwsem.region) {
>> +        cxlr = attach->cxlr;
>> +        WRITE_ONCE(attach->cxlr, NULL);
>> +        attach->hpa_range = DEFINE_RANGE(0, -1);
>> +    }
>> +    endpoint_unregister_region(cxlr);
>> +}
>> +
>>   /*
>>    * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
>>    * simple case of single mapped decoder per memdev.
>> @@ -4127,15 +4144,23 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>         /* Only teardown regions that pass validation, ignore the rest */
>>       get_device(&cxlr->dev);
>> -    rc = devm_add_action_or_reset(&endpoint->dev,
>> -                      endpoint_unregister_region, cxlr);
>> -    if (rc)
>> +    /*
>> +     * Not devm_add_action_or_reset(): the reset path would take
>> +     * cxl_rwsem.region for write while it is held for read here. The
>> +     * endpoint lock keeps the action from running before @attach is set.
>> +     */
>> +    rc = devm_add_action(&endpoint->dev, endpoint_detach_attach_region,
>> +                 attach);
>> +    if (rc) {
>> +        put_device(&cxlr->dev);
>>           return rc;
>> +    }
>>         attach->hpa_range = (struct range) {
>>           .start = cxlr->params.res->start,
>>           .end = cxlr->params.res->end,
>>       };
>> +    WRITE_ONCE(attach->cxlr, cxlr);
>>       return 0;
>>   }
>>   EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index c401e3a1af06..7cd3a69cd5f5 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -104,6 +104,8 @@ struct cxl_memdev_attach {
>>   /**
>>    * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>    * @attach: common core attachment descriptor
>> + * @cxlr: cxl region the memdev is attached to, cleared under cxl_rwsem.region
>> + *    before the region is unregistered
>>    * @hpa_range: physical address range of the region
>>    *
>>    * For the common simple case of a CXL device with private (non-general purpose
>> @@ -112,6 +114,7 @@ struct cxl_memdev_attach {
>>    */
>>   struct cxl_attach_region {
>>       struct cxl_memdev_attach attach;
>> +    struct cxl_region *cxlr;
>>       struct range hpa_range;
>>   };
>>   
> 

--------------lc2O18MPElWXN1IjKCVeNrpu
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-TEST-ONLY-cxl-test-mock-non-PF0-consumer-for-cxl_get.patch"
Content-Disposition: attachment;
 filename*0="0001-TEST-ONLY-cxl-test-mock-non-PF0-consumer-for-cxl_get.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkNTJmMDc3NmNiYjZlMWRmNDVhNjUxMTAxMGJjZTEyZjgxY2IyMzEzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNv
bT4KRGF0ZTogVGh1LCAxIE9jdCAyMDI2IDE0OjEzOjE5IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gVEVTVCBPTkxZOiBjeGwvdGVzdDogbW9jayBub24tUEYwIGNvbnN1bWVyIGZvcgogY3hs
X2dldF9yYW5nZV9hbmRfbGluaygpCgpOb3QgZm9yIHN1Ym1pc3Npb24uIEFkZCBjeGxfbW9j
a19wZngsIGEgcGxhdGZvcm0gZHJpdmVyIHdob3NlIHByb2JlIGNhbGxzCmN4bF9nZXRfcmFu
Z2VfYW5kX2xpbmsoKSBhZ2FpbnN0IHRoZSBjeGxfdGVzdCB0eXBlLTIgYWNjZWxlcmF0b3IK
KGN4bF90eXBlMl9hY2NlbC4wKSwgdGhlIHdheSBhIG5vbi1QRjAgZnVuY3Rpb24gd291bGQu
CgpUbyByYWNlIHRoZSBkZXZpY2UgbGluayBhZ2FpbnN0IHJlZ2lvbiB0ZWFyZG93bjoKCiAg
bW9kcHJvYmUgY3hsX3Rlc3QgdHlwZTJfdGVzdD0xCiAgbW9kcHJvYmUgY3hsX21vY2tfcGZ4
CiAgRD0vc3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2N4bF9tb2NrX3BmeAogIEVQPSQobHMg
L3N5cy9idXMvY3hsL2RldmljZXMgfCBncmVwIGVuZHBvaW50KQogIGZvciBpIGluICQoc2Vx
IDIwMCk7IGRvCiAgICAgIGVjaG8gY3hsX21vY2tfcGZ4LjEgPiAkRC91bmJpbmQgMj4vZGV2
L251bGwKICAgICAgZWNobyBjeGxfbW9ja19wZnguMSA+ICREL2JpbmQgMj4vZGV2L251bGwK
ICBkb25lICYKICBzbGVlcCAwLjIKICBlY2hvICRFUCA+IC9zeXMvYnVzL2N4bC9kcml2ZXJz
L2N4bF9wb3J0L3VuYmluZAogIHdhaXQKClRoZSBlbmRwb2ludCBuYW1lIGRlcGVuZHMgb24g
dGhlIHRvcG9sb2d5LCBzbyBFUCBpcyBsb29rZWQgdXAgcmF0aGVyCnRoYW4gaGFyZCBjb2Rl
ZC4gdHlwZTJfdGVzdD0xIGNyZWF0ZXMgYSBzaW5nbGUgYWNjZWxlcmF0b3IsIHNvIHRoZXJl
IGlzCm9uZSBlbmRwb2ludC4KClJlcGVhdCBmcm9tIHRoZSBtb2Rwcm9iZSBvZiBjeGxfdGVz
dCBpZiB0aGUgd2luZG93IGlzIG1pc3NlZC4gV2l0aApLQVNBTiwgYSBzdGFsZSBhdHRhY2gt
PmN4bHIgc2hvd3MgdXAgYXMgYSBzbGFiLXVzZS1hZnRlci1mcmVlIGluCmRldmljZV9saW5r
X2FkZCgpIGNhbGxlZCBmcm9tIGN4bF9nZXRfcmFuZ2VfYW5kX2xpbmsoKS4KClRoZSB1c2Ut
YWZ0ZXItZnJlZSBpcyBvbmx5IHJlcG9ydGVkIHJlbGlhYmx5IHdpdGggS0FTQU4gZW5hYmxl
ZC4gV2l0aG91dAppdCwgdGhlIHN0YWxlIGFjY2VzcyBtYXkgZ28gdW5ub3RpY2VkLiBUZXN0
ZWQgd2l0aDoKCiAgQ09ORklHX0tBU0FOPXkKICBDT05GSUdfS0FTQU5fR0VORVJJQz15Ci0t
LQogdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9LYnVpbGQgfCAgMiArCiB0b29scy90ZXN0aW5n
L2N4bC90ZXN0L3BmeC5jICB8IDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCiAyIGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0b29scy90ZXN0aW5nL2N4bC90ZXN0L3BmeC5jCgpkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9jeGwvdGVzdC9LYnVpbGQgYi90b29scy90ZXN0aW5nL2N4bC90ZXN0L0tidWls
ZAppbmRleCA5YTI0ZGRjMjg0ODguLjI3OWQ4OWJlNGE0ZCAxMDA2NDQKLS0tIGEvdG9vbHMv
dGVzdGluZy9jeGwvdGVzdC9LYnVpbGQKKysrIGIvdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9L
YnVpbGQKQEAgLTYsMTEgKzYsMTMgQEAgb2JqLW0gKz0gY3hsX21vY2subwogb2JqLW0gKz0g
Y3hsX21vY2tfbWVtLm8KIG9iai1tICs9IGN4bF90cmFuc2xhdGUubwogb2JqLW0gKz0gY3hs
X21vY2tfYWNjZWwubworb2JqLW0gKz0gY3hsX21vY2tfcGZ4Lm8KIAogY3hsX3Rlc3QteSA6
PSBjeGwubwogY3hsX3Rlc3QteSArPSBobWVtX3Rlc3QubwogY3hsX21vY2steSA6PSBtb2Nr
Lm8KIGN4bF9tb2NrX21lbS15IDo9IG1lbS5vCiBjeGxfbW9ja19hY2NlbC15IDo9IGFjY2Vs
Lm8KK2N4bF9tb2NrX3BmeC15IDo9IHBmeC5vCiAKIEtCVUlMRF9DRkxBR1MgOj0gJChmaWx0
ZXItb3V0IC1XbWlzc2luZy1wcm90b3R5cGVzIC1XbWlzc2luZy1kZWNsYXJhdGlvbnMsICQo
S0JVSUxEX0NGTEFHUykpCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL2N4bC90ZXN0L3Bm
eC5jIGIvdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9wZnguYwpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAwMDAuLjM5YzBjMDgxYzg5NgotLS0gL2Rldi9udWxsCisrKyBi
L3Rvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvcGZ4LmMKQEAgLTAsMCArMSw3NyBAQAorLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQorLyoKKyAqIFRFU1QgT05MWTog
bW9jayBub24tUEYwIGNvbnN1bWVyLiBJdHMgcHJvYmUgbGlua3MgdG8gdGhlIHJlZ2lvbiBh
dHRhY2hlZAorICogdG8gdGhlIGN4bF90ZXN0IHR5cGUtMiBhY2NlbGVyYXRvciB2aWEgY3hs
X2dldF9yYW5nZV9hbmRfbGluaygpLgorICovCisKKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9y
bV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxjeGwv
Y3hsLmg+CisKK3N0YXRpYyBjaGFyICpwZjBfbmFtZSA9ICJjeGxfdHlwZTJfYWNjZWwuMCI7
Cittb2R1bGVfcGFyYW0ocGYwX25hbWUsIGNoYXJwLCAwNDQ0KTsKKworc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBmeF9wZGV2OworCitzdGF0aWMgaW50IGN4bF9tb2NrX3Bm
eF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoreworCXN0cnVjdCBkZXZp
Y2UgKnBmMDsKKwlzdHJ1Y3QgcmFuZ2UgcmFuZ2U7CisJaW50IHJjOworCisJcGYwID0gYnVz
X2ZpbmRfZGV2aWNlX2J5X25hbWUoJnBsYXRmb3JtX2J1c190eXBlLCBOVUxMLCBwZjBfbmFt
ZSk7CisJaWYgKCFwZjApIHsKKwkJZGV2X2luZm8oJnBkZXYtPmRldiwgInBmeF90ZXN0OiAl
cyBub3QgZm91bmRcbiIsIHBmMF9uYW1lKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCisJ
cmMgPSBjeGxfZ2V0X3JhbmdlX2FuZF9saW5rKHBmMCwgJnBkZXYtPmRldiwgJnJhbmdlKTsK
KwlwdXRfZGV2aWNlKHBmMCk7CisJaWYgKHJjKSB7CisJCWRldl9pbmZvKCZwZGV2LT5kZXYs
ICJwZnhfdGVzdDogbGluayByYz0lZFxuIiwgcmMpOworCQkvKiBkb24ndCBsZXQgLUVQUk9C
RV9ERUZFUiByZXF1ZXVlIHVzIGJlaGluZCB0aGUgdGVzdCdzIGJhY2sgKi8KKwkJcmV0dXJu
IHJjID09IC1FUFJPQkVfREVGRVIgPyAtRUFHQUlOIDogcmM7CisJfQorCisJZGV2X2luZm8o
JnBkZXYtPmRldiwgInBmeF90ZXN0OiBsaW5rIHJjPTAgcmFuZ2U9JXByYVxuIiwgJnJhbmdl
KTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgY3hsX21vY2tfcGZ4X3JlbW92ZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoreworCWRldl9pbmZvKCZwZGV2LT5kZXYs
ICJwZnhfdGVzdDogcmVtb3ZlZFxuIik7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1f
ZHJpdmVyIGN4bF9tb2NrX3BmeF9kcml2ZXIgPSB7CisJLnByb2JlID0gY3hsX21vY2tfcGZ4
X3Byb2JlLAorCS5yZW1vdmUgPSBjeGxfbW9ja19wZnhfcmVtb3ZlLAorCS5kcml2ZXIgPSB7
CisJCS5uYW1lID0gImN4bF9tb2NrX3BmeCIsCisJfSwKK307CisKK3N0YXRpYyBpbnQgX19p
bml0IGN4bF9tb2NrX3BmeF9pbml0KHZvaWQpCit7CisJaW50IHJjOworCisJcGZ4X3BkZXYg
PSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfc2ltcGxlKCJjeGxfbW9ja19wZngiLCAxLCBO
VUxMLCAwKTsKKwlpZiAoSVNfRVJSKHBmeF9wZGV2KSkKKwkJcmV0dXJuIFBUUl9FUlIocGZ4
X3BkZXYpOworCisJcmMgPSBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmN4bF9tb2NrX3Bm
eF9kcml2ZXIpOworCWlmIChyYykKKwkJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIocGZ4
X3BkZXYpOworCXJldHVybiByYzsKK30KK21vZHVsZV9pbml0KGN4bF9tb2NrX3BmeF9pbml0
KTsKKworc3RhdGljIHZvaWQgX19leGl0IGN4bF9tb2NrX3BmeF9leGl0KHZvaWQpCit7CisJ
cGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmN4bF9tb2NrX3BmeF9kcml2ZXIpOworCXBs
YXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKHBmeF9wZGV2KTsKK30KK21vZHVsZV9leGl0KGN4
bF9tb2NrX3BmeF9leGl0KTsKKworTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOworTU9EVUxFX0RF
U0NSSVBUSU9OKCJjeGxfdGVzdDogVEVTVCBPTkxZIG1vY2sgbm9uLVBGMCBjb25zdW1lciIp
OworTU9EVUxFX0lNUE9SVF9OUygiQ1hMIik7Ci0tIAoyLjU0LjAKCg==

--------------lc2O18MPElWXN1IjKCVeNrpu--
