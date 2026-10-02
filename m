Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA004E535F;
	Fri,  2 Oct 2026 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955098; cv=none; b=rdNUH9F9XkeAMjou1IwwqpXjDxtBC8uDWVHYQrJEkHRPv+N5jdle7De39FfqcNNA7aZZ10cu+NNxHfkuv0omvUH+VqAfllV8KyuiWP/84Yoa5tXRXNYpO5tI7/YMPDY76aH5U5FGoowVTDcNwoD1F3b/WYU57vwUyPBcbL35uVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955098; c=relaxed/simple;
	bh=0pHH0aNoIlIQ7IdWKO+2+w8hQu4Wo22MtctOvE4EaqI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=hY3IjKI2I87hi9ptcWGsXQet35GYRclEuidKmIEgORGBqYAA7tTCOoyr51bdKxzhdzKC9oz3c/6PQzM0rkMqT1QoH7p7qaEzi3ksaHyFENgl2/TjSjEsI5jFJ0mVf/DNh1m+JohH4W0ISYHZO78Xzu+P5StDA1CfC4rL7lO9yvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrNQ70Zl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrNQ70Zl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790955096; x=1822491096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=0pHH0aNoIlIQ7IdWKO+2+w8hQu4Wo22MtctOvE4EaqI=;
  b=IrNQ70ZldJO81GDMPyyTy38urKiX0FHn+G1YnoX7HVNnlytrPyhta8Pg
   3MwV19kERO8FiTBt7urUw7GLn50IeXXyI1CZfDjXtT08k3ZWfCxiP/R8S
   kKU12bByd5nviU31FS5KThsm4gV2yOapyxP0JSQyW3BRJVnq3CpKgxOMy
   RSnY6BdGLaNK2+3sgqluER/hUK1MM9Hg1vJEXFfUo6n2GenNnI5xHkFq1
   QKUPPpv+ZxQbI40gW5QKjwYpffK5zaYhLVCVjWrJ91D2xy6NE54GvQ3Um
   n7e29rX/tTCNQW2BRTOblbPPtM9NWSGM7yTErVVK2K89HCPECVIfmcPk0
   g==;
X-CSE-ConnectionGUID: YmyLRcfySOKXHmxednbCYQ==
X-CSE-MsgGUID: chlYX61CS0COndR8ZCI7jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="102297628"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="102297628"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:31:35 -0700
X-CSE-ConnectionGUID: pIhOdqZ7R862mltKoOWSAA==
X-CSE-MsgGUID: vlcae5+bTGG/d4dykkSO9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="280016054"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.108.45]) ([10.125.108.45])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 08:31:34 -0700
Content-Type: multipart/mixed; boundary="------------lW9kp0c0SlE0q00cmPWrJACh"
Message-ID: <86f1bc50-65ef-4894-a2f0-211ccd394fdc@intel.com>
Date: Fri, 2 Oct 2026 08:31:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] driver core: Check for supplier requiring PM at
 link creation
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-2-alucerop@amd.com>
 <9e8a45df-1755-495f-8e80-52c65b832dc9@intel.com>
 <b7fd6cc3-1aca-440f-a87d-d0d94ae9eed3@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <b7fd6cc3-1aca-440f-a87d-d0d94ae9eed3@amd.com>

This is a multi-part message in MIME format.
--------------lW9kp0c0SlE0q00cmPWrJACh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/1/26 9:32 PM, Lucero Palau, Alejandro wrote:
> 
> On 01/10/2026 21:31, Dave Jiang wrote:
>>
>> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> PM initialization could not be necessary for some devices.
>>>
>>> Avoid checking for supplier PM initialization if so.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/base/core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index 4c0c373998a1..bf0513beafad 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -840,7 +840,7 @@ struct device_link *device_link_add(struct device *consumer,
>>>        * SYNC_STATE_ONLY link, we don't check for reverse dependencies
>>>        * because it only affects sync_state() callbacks.
>>>        */
>>> -    if (!device_pm_initialized(supplier)
>>> +    if ((!device_pm_not_required(supplier) && !device_pm_initialized(supplier))
>>>           || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>>>             device_is_dependent(consumer, supplier))) {
>>>           link = NULL;
>> A no PM supplier can now be linked at any point: before device_add(), while it fails, or after device_del(). Maybe replace with a helper like this?
> 
> 
> I would say you can not use a device as supplier before device_add() happens for such a supplier, and if it does happen after device_del(), something is wrong with the caller.

Yes that would be a bug, and device_link_add() is suppose to catch it. For PM devices, the device_pm_initialized() test is the gate. The change you made skips that test for no PM device case. I had LLM created a test module for verification, attached.

Essentially the logic in this patch removed the check for 2 states that the original code used to block.
1. before device_add(supplier)
2. after device_del(supplier) 

> 
> 
> Your suggestion is likely making the code more legible, but it does not change the functionality I added. Does it? Not saying it would not help, but I can not understand your comment for suggesting it which seems to point to potential problems I did not see.
> 

It does.
- before device_add(supplier): this patch creates the link, and the helper refuses it.
- after device_add(supplier): both create it.
- after device_del(supplier), before last put_device: this patch creates the link, and the helper refuses it.

delete_region() or root decoder teardown can unregister the region while the endpoint is still bound. cxl_get_range_and_link() can still be called on a region that has already been through device_del().

Without the helper, it's possible where the PFx driver can device_link_add() a deleted region that is still around due to endpoint still holds a reference.

DJ


> 
>> static bool device_link_supplier_ready(struct device *supplier)
>> {
>>        /* no PM devices never enter dpm_list, so check registration directly */
>>        if (device_pm_not_required(supplier))
>>                return device_is_registered(supplier);
>>
>>        return device_pm_initialized(supplier);
>> }
>>
>> ...
>>
>>        if (!device_link_supplier_ready(supplier) ||
>>            (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>>             device_is_dependent(consumer, supplier))) {
>>                link = NULL;
>>                goto out;
>>        }

--------------lW9kp0c0SlE0q00cmPWrJACh
Content-Type: text/x-patch; charset=UTF-8; name="mock-pfx.patch"
Content-Disposition: attachment; filename="mock-pfx.patch"
Content-Transfer-Encoding: base64

Y29tbWl0IDA1NTFlOTFlNjNjNjAwOWI3MTc5MjEzM2UwZWYwY2ZmMWMwYWY2ZGQKQXV0aG9y
OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4KRGF0ZTogICBUaHUgT2N0IDEg
MTQ6MTM6MTkgMjAyNiAtMDcwMAoKICAgIFRFU1QgT05MWTogY3hsL3Rlc3Q6IG1vY2sgbm9u
LVBGMCBjb25zdW1lciBmb3IgY3hsX2dldF9yYW5nZV9hbmRfbGluaygpCiAgICAKICAgIE5v
dCBmb3Igc3VibWlzc2lvbi4gRXhlcmNpc2VzIHRoZSBtdWx0aS1QRiBkZXZpY2UtbGluayBw
YXRoIGFnYWluc3QgdGhlCiAgICBjeGxfdGVzdCB0eXBlLTIgYWNjZWxlcmF0b3IsIGFuZCBz
ZWxmLXRlc3RzIGRldmljZV9saW5rX2FkZCgpIG9uIGEgbm9fcG0KICAgIHN1cHBsaWVyIGFj
cm9zcyByZWdpc3RyYXRpb24uCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9jeGwvdGVz
dC9LYnVpbGQgYi90b29scy90ZXN0aW5nL2N4bC90ZXN0L0tidWlsZAppbmRleCA5YTI0ZGRj
Mjg0ODguLjI3OWQ4OWJlNGE0ZCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9jeGwvdGVz
dC9LYnVpbGQKKysrIGIvdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9LYnVpbGQKQEAgLTYsMTEg
KzYsMTMgQEAgb2JqLW0gKz0gY3hsX21vY2subwogb2JqLW0gKz0gY3hsX21vY2tfbWVtLm8K
IG9iai1tICs9IGN4bF90cmFuc2xhdGUubwogb2JqLW0gKz0gY3hsX21vY2tfYWNjZWwubwor
b2JqLW0gKz0gY3hsX21vY2tfcGZ4Lm8KIAogY3hsX3Rlc3QteSA6PSBjeGwubwogY3hsX3Rl
c3QteSArPSBobWVtX3Rlc3QubwogY3hsX21vY2steSA6PSBtb2NrLm8KIGN4bF9tb2NrX21l
bS15IDo9IG1lbS5vCiBjeGxfbW9ja19hY2NlbC15IDo9IGFjY2VsLm8KK2N4bF9tb2NrX3Bm
eC15IDo9IHBmeC5vCiAKIEtCVUlMRF9DRkxBR1MgOj0gJChmaWx0ZXItb3V0IC1XbWlzc2lu
Zy1wcm90b3R5cGVzIC1XbWlzc2luZy1kZWNsYXJhdGlvbnMsICQoS0JVSUxEX0NGTEFHUykp
CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL2N4bC90ZXN0L3BmeC5jIGIvdG9vbHMvdGVz
dGluZy9jeGwvdGVzdC9wZnguYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
MDAwMDAuLjU1Yjc1MmViZTljYQotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
Y3hsL3Rlc3QvcGZ4LmMKQEAgLTAsMCArMSwxMzQgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9ubHkKKy8qCisgKiBURVNUIE9OTFk6IG1vY2sgbm9uLVBGMCBj
b25zdW1lci4gSXRzIHByb2JlIGxpbmtzIHRvIHRoZSByZWdpb24gYXR0YWNoZWQKKyAqIHRv
IHRoZSBjeGxfdGVzdCB0eXBlLTIgYWNjZWxlcmF0b3IgdmlhIGN4bF9nZXRfcmFuZ2VfYW5k
X2xpbmsoKS4KKyAqLworCisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cisj
aW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2lu
Y2x1ZGUgPGN4bC9jeGwuaD4KKworc3RhdGljIGNoYXIgKnBmMF9uYW1lID0gImN4bF90eXBl
Ml9hY2NlbC4wIjsKK21vZHVsZV9wYXJhbShwZjBfbmFtZSwgY2hhcnAsIDA0NDQpOworCitz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGZ4X3BkZXY7CisKK3N0YXRpYyBpbnQg
Y3hsX21vY2tfcGZ4X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJ
c3RydWN0IGRldmljZSAqcGYwOworCXN0cnVjdCByYW5nZSByYW5nZTsKKwlpbnQgcmM7CisK
KwlwZjAgPSBidXNfZmluZF9kZXZpY2VfYnlfbmFtZSgmcGxhdGZvcm1fYnVzX3R5cGUsIE5V
TEwsIHBmMF9uYW1lKTsKKwlpZiAoIXBmMCkgeworCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAi
cGZ4X3Rlc3Q6ICVzIG5vdCBmb3VuZFxuIiwgcGYwX25hbWUpOworCQlyZXR1cm4gLUVOT0RF
VjsKKwl9CisKKwlyYyA9IGN4bF9nZXRfcmFuZ2VfYW5kX2xpbmsocGYwLCAmcGRldi0+ZGV2
LCAmcmFuZ2UpOworCXB1dF9kZXZpY2UocGYwKTsKKwlpZiAocmMpIHsKKwkJZGV2X2luZm8o
JnBkZXYtPmRldiwgInBmeF90ZXN0OiBsaW5rIHJjPSVkXG4iLCByYyk7CisJCS8qIGRvbid0
IGxldCAtRVBST0JFX0RFRkVSIHJlcXVldWUgdXMgYmVoaW5kIHRoZSB0ZXN0J3MgYmFjayAq
LworCQlyZXR1cm4gcmMgPT0gLUVQUk9CRV9ERUZFUiA/IC1FQUdBSU4gOiByYzsKKwl9CisK
KwlkZXZfaW5mbygmcGRldi0+ZGV2LCAicGZ4X3Rlc3Q6IGxpbmsgcmM9MCByYW5nZT0lcHJh
XG4iLCAmcmFuZ2UpOworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9pZCBjeGxfbW9ja19w
ZnhfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJZGV2X2luZm8o
JnBkZXYtPmRldiwgInBmeF90ZXN0OiByZW1vdmVkXG4iKTsKK30KKworc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kcml2ZXIgY3hsX21vY2tfcGZ4X2RyaXZlciA9IHsKKwkucHJvYmUgPSBj
eGxfbW9ja19wZnhfcHJvYmUsCisJLnJlbW92ZSA9IGN4bF9tb2NrX3BmeF9yZW1vdmUsCisJ
LmRyaXZlciA9IHsKKwkJLm5hbWUgPSAiY3hsX21vY2tfcGZ4IiwKKwl9LAorfTsKKworc3Rh
dGljIHZvaWQgZGV2X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQoreworCWtmcmVlKGRl
dik7Cit9CisKKy8qIGRldmljZV9saW5rX2FkZCgpIG11c3QgcmVmdXNlIGEgbm9fcG0gc3Vw
cGxpZXIgdGhhdCBpcyBub3QgcmVnaXN0ZXJlZCAqLworc3RhdGljIHZvaWQgZGV2bGlua19u
b19wbV9zZWxmdGVzdChzdHJ1Y3QgZGV2aWNlICpjb25zdW1lcikKK3sKKwlzdHJ1Y3QgZGV2
aWNlX2xpbmsgKmxpbms7CisJc3RydWN0IGRldmljZSAqc3VwOworCWludCBwYXNzID0gMDsK
KworCXN1cCA9IGt6YWxsb2Nfb2JqKCpzdXApOworCWlmICghc3VwKQorCQlyZXR1cm47CisJ
ZGV2aWNlX2luaXRpYWxpemUoc3VwKTsKKwlzdXAtPnJlbGVhc2UgPSBkZXZfcmVsZWFzZTsK
KwlkZXZpY2Vfc2V0X3BtX25vdF9yZXF1aXJlZChzdXApOworCWRldl9zZXRfbmFtZShzdXAs
ICJwZnhfdGVzdF9zdXBwbGllciIpOworCisJbGluayA9IGRldmljZV9saW5rX2FkZChjb25z
dW1lciwgc3VwLCBETF9GTEFHX1NUQVRFTEVTUyk7CisJcHJfaW5mbygicGZ4X3Rlc3Q6IG5v
X3BtIGJlZm9yZSBkZXZpY2VfYWRkOiBsaW5rICVzXG4iLAorCQlsaW5rID8gIkNSRUFURUQg
KEZBSUwpIiA6ICJyZWZ1c2VkIChQQVNTKSIpOworCWlmIChsaW5rKQorCQlkZXZpY2VfbGlu
a19kZWwobGluayk7CisJZWxzZQorCQlwYXNzKys7CisKKwlpZiAoZGV2aWNlX2FkZChzdXAp
KSB7CisJCXB1dF9kZXZpY2Uoc3VwKTsKKwkJcmV0dXJuOworCX0KKworCWxpbmsgPSBkZXZp
Y2VfbGlua19hZGQoY29uc3VtZXIsIHN1cCwgRExfRkxBR19TVEFURUxFU1MpOworCXByX2lu
Zm8oInBmeF90ZXN0OiBub19wbSBhZnRlciBkZXZpY2VfYWRkOiBsaW5rICVzXG4iLAorCQls
aW5rID8gImNyZWF0ZWQgKFBBU1MpIiA6ICJSRUZVU0VEIChGQUlMKSIpOworCWlmIChsaW5r
KSB7CisJCWRldmljZV9saW5rX2RlbChsaW5rKTsKKwkJcGFzcysrOworCX0KKworCWRldmlj
ZV9kZWwoc3VwKTsKKwlsaW5rID0gZGV2aWNlX2xpbmtfYWRkKGNvbnN1bWVyLCBzdXAsIERM
X0ZMQUdfU1RBVEVMRVNTKTsKKwlwcl9pbmZvKCJwZnhfdGVzdDogbm9fcG0gYWZ0ZXIgZGV2
aWNlX2RlbDogbGluayAlc1xuIiwKKwkJbGluayA/ICJDUkVBVEVEIChGQUlMKSIgOiAicmVm
dXNlZCAoUEFTUykiKTsKKwlpZiAobGluaykKKwkJZGV2aWNlX2xpbmtfZGVsKGxpbmspOwor
CWVsc2UKKwkJcGFzcysrOworCisJcHV0X2RldmljZShzdXApOworCXByX2luZm8oInBmeF90
ZXN0OiBub19wbSBzZWxmdGVzdCAlZC8zIHBhc3NlZFxuIiwgcGFzcyk7Cit9CisKK3N0YXRp
YyBpbnQgX19pbml0IGN4bF9tb2NrX3BmeF9pbml0KHZvaWQpCit7CisJaW50IHJjOworCisJ
cGZ4X3BkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfc2ltcGxlKCJjeGxfbW9ja19w
ZngiLCAxLCBOVUxMLCAwKTsKKwlpZiAoSVNfRVJSKHBmeF9wZGV2KSkKKwkJcmV0dXJuIFBU
Ul9FUlIocGZ4X3BkZXYpOworCisJZGV2bGlua19ub19wbV9zZWxmdGVzdCgmcGZ4X3BkZXYt
PmRldik7CisKKwlyYyA9IHBsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcigmY3hsX21vY2tfcGZ4
X2RyaXZlcik7CisJaWYgKHJjKQorCQlwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcihwZnhf
cGRldik7CisJcmV0dXJuIHJjOworfQorbW9kdWxlX2luaXQoY3hsX21vY2tfcGZ4X2luaXQp
OworCitzdGF0aWMgdm9pZCBfX2V4aXQgY3hsX21vY2tfcGZ4X2V4aXQodm9pZCkKK3sKKwlw
bGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3RlcigmY3hsX21vY2tfcGZ4X2RyaXZlcik7CisJcGxh
dGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIocGZ4X3BkZXYpOworfQorbW9kdWxlX2V4aXQoY3hs
X21vY2tfcGZ4X2V4aXQpOworCitNT0RVTEVfTElDRU5TRSgiR1BMIik7CitNT0RVTEVfREVT
Q1JJUFRJT04oImN4bF90ZXN0OiBURVNUIE9OTFkgbW9jayBub24tUEYwIGNvbnN1bWVyIik7
CitNT0RVTEVfSU1QT1JUX05TKCJDWEwiKTsK

--------------lW9kp0c0SlE0q00cmPWrJACh--
