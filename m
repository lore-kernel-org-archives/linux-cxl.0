Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F67364058;
	Fri,  9 Oct 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565042; cv=none; b=lehbAPjC4ZkIMbA9k0aLmzNrYqfO40J0RbQS0i18S2+ibbLZ//07ONTVmWIWrzvP7SrxqfAFuYXvoZkJyYYwfe8b/ZjF7GW35hPodGA34cL17jLLZ8aWAyx+RerSSSh0RB5YwzZfuMUwA1Z+TFkJfAZBGJ6OAHyLyzcFN/LHZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565042; c=relaxed/simple;
	bh=86uhFv3N7BRy00P+qV5sycRwbGkFF11U4hm4GvoVOOM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=JfSlRMierl96akQmR6BezudK6fD8Z6A0dg09TJj0KHRY6QPXZkmU0dqXprP3SreKWDesPUA2WnxLXRCrIblL80LumGjAWlDEA2R0hksd9L2hLnokh0mTtjmeuhX/uhwj8kKdWfTQEO55EEeDFHjUKyFcz6MEpcn8UGIs8mZfYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3JMkvAh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3JMkvAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791565040; x=1823101040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=86uhFv3N7BRy00P+qV5sycRwbGkFF11U4hm4GvoVOOM=;
  b=c3JMkvAh7yDvQP8jG3X+hrqt+kVZDnF71Ud3brOEN/BbiSSEMCc630rY
   x39zXDvOLKuQGnaTqhA7V6S9wqMTdPPUNWnJBbpdD9pzjTxpAxLM5mUta
   3nDTW0IZHQQjQEEdebRHPWMD46iP51CiCkMCQusJjEF+kz8IYNbo567aa
   T25Xy0kJbDtdM2nR0pKyMukN2Wpnjty3njBh4x/yoxYQ6rWu9KiYQRbbZ
   oO4aSPeY+FvRZiqpQ5B/SLy190C7xVu51ISmSn7Gq8CNNTNHd+HISeyG9
   bSnDHcRFP3e6T/VJRfan7fb6CA9htkP+GNyqIz7pfp5Su3mctr3OQnUND
   A==;
X-CSE-ConnectionGUID: JCbcuBXIRsG77nzRsmrXNw==
X-CSE-MsgGUID: TWu1Ai3ARkCW421DdqHrFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="464007"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208,223";a="464007"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:57:19 -0700
X-CSE-ConnectionGUID: W869UPp3RQamhjWknaRcZQ==
X-CSE-MsgGUID: SNO/2zEnRpOy1yTc8vNuxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208,223";a="440053"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.99]) ([10.125.109.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:57:18 -0700
Content-Type: multipart/mixed; boundary="------------IEOlbU9GghqArp2TjhmsEKnV"
Message-ID: <31837521-9d8d-44ac-90cb-6059b863f750@intel.com>
Date: Fri, 9 Oct 2026 09:57:17 -0700
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
 <bd412198-8a25-436c-b6d6-6b6730e8c28e@intel.com>
 <9114ec71-060f-48ae-a6e5-0b46a881c259@amd.com>
 <40fc791c-c03c-42f0-88be-7a97938ebe1c@intel.com>
 <ba7731fe-f916-4e51-977b-95a0197bf52d@amd.com>
 <3f40d953-2e91-4492-b100-c851fdb143b5@intel.com>
 <61a45ff4-e2f6-408d-a9db-26621bb4b361@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <61a45ff4-e2f6-408d-a9db-26621bb4b361@amd.com>

This is a multi-part message in MIME format.
--------------IEOlbU9GghqArp2TjhmsEKnV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/8/26 11:58 PM, Lucero Palau, Alejandro wrote:
> 
> On 08/10/2026 22:05, Dave Jiang wrote:
>>
>> On 10/8/26 11:07 AM, Lucero Palau, Alejandro wrote:
> 
> 
> <snip>
> 
>>>
>>> Dan and I addressed some concerns with "these options" but it is worse after realising now port and region can also suffer from unbinding actions. We contemplated memdev unbinding and that is supported, and acpi module removal as well (all the unwinding is hopefully right for sfc driver removal), but the fact is, current Type2 support is unsound. It is likely good enough with current usage expectations but something to improve/fix.
>> Removing the acpi module will also cause the issue I pointed out. So that isn't safe either. The only path that's good right now is sfc driver removal or the device going away.
> 
> 
> No. Adding multi PF support brings new problems. I need to look at the other unbinding options I was not contemplating, but acpi module and mem unbinding are safe. Maybe not correct semantically, but safe.

I can hit a KASAN use after free issue with cxl_acpi module removal. I attached the LLM generated test patch with reproduction steps in commit log. Removal of cxl_acpi causes region removal and thus PF1 can hit a stale region ptr from attach struct.

BUG: KASAN: slab-use-after-free in device_link_add+0x521/0xa80
 cxl_get_range_and_link+0xa9/0x120 [cxl_core]


> 
> 
>>>
>>> All this user space potential actions were implemented mainly for testing (I guess you know this). I did ask Dan about it, and I was expecting use cases where HDM decoders and regions are dynamically created, which makes a lot of sense to me, but the fact is all is relying on firmware/BIOS configuration. Richard is working on adding this functionality for Type2 and pmems, and Jonathan considers it theoretically useful as well, but the way is going to be handled requires, IMO, further thinking and maybe a change before someone starts using it (does anyone know about users now?).
>>>
>>>
>>> As a summary, if we allow user space actions (at least for Type2) they need to be consistent and somehow protected.
>>>
>>>
>>> Finally, you did not answer my question: what is the point user space removing and endpoint port handled by a Type2 driver? What about the cxl region? Maybe I am missing a necessity I can not see here, so please, help me to understand this if that is the case.
>> Shouldn't does not mean does not exist. Sure I can agree with you that under normal operations, certain things a sane user should avoid doing for type2. But it is possible currently and those issues can be triggered. However you feel about the current CXL architecture, here we are with where it is. You can either consider the smaller changes I suggested to keep the attach->cxlr sane (or with some other means) and make what you need working now with raised the issue addressed, and come back with hashing out the larger grievances later, or keep beating this horse.... "It's silly for users to do that and therefore the issue can be ignored" is not a good enough reason for me look the other way and merge the code.
> 
> 
> I'm not denying the problem. I just do not want to add some new functionality which comes with these new issues, at least until I can understand it fully. What you propose is, I think, correct, and fixing at least some of the issues. But I think this is a good opportunity for trying to address this sysfs functionality, or at least to discuss it. As I said, also when basic Type2 support upstream effort started, Type2 CXL should not be "open" to user space as Type3 (or not by default), although I think this complexity and so many different unwinding paths should be avoided ... or documented the reason behind it.
> 
>

Agreed on we should talk about this as a community and decide on next steps for type2. Documentation is always good. 
> So, I will work on some documentation about all this, with cxl devices lifespan and those different unwinding paths, emphasising the different theoretical needs between Type2 and Type3. Once the unwinding paths are identified and documented, someone  can add the reason/use case behind it, or maybe some problems with them we are not seeing now.

Thank you! Appreciate you doing that. 
> 
> 
> 

--------------IEOlbU9GghqArp2TjhmsEKnV
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-TEST-ONLY-cxl-test-mock-non-PF0-consumer-for-cxl_get.patch"
Content-Disposition: attachment;
 filename*0="0001-TEST-ONLY-cxl-test-mock-non-PF0-consumer-for-cxl_get.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3YzhhMmIzYWFlYjU0YzM5ZjU0ZWQxMjI2OTM0MTM2OTA0YWIzMDYyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNv
bT4KRGF0ZTogVGh1LCAxIE9jdCAyMDI2IDE0OjEzOjE5IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gVEVTVCBPTkxZOiBjeGwvdGVzdDogbW9jayBub24tUEYwIGNvbnN1bWVyIGZvcgogY3hs
X2dldF9yYW5nZV9hbmRfbGluaygpCgpOb3QgZm9yIHN1Ym1pc3Npb24uIEFkZCBjeGxfbW9j
a19wZngsIGEgcGxhdGZvcm0gZHJpdmVyIHdob3NlIHByb2JlIGNhbGxzCmN4bF9nZXRfcmFu
Z2VfYW5kX2xpbmsoKSBhZ2FpbnN0IHRoZSBjeGxfdGVzdCB0eXBlLTIgYWNjZWxlcmF0b3IK
KGN4bF90eXBlMl9hY2NlbC4wKSwgdGhlIHdheSBhIG5vbi1QRjAgZnVuY3Rpb24gd291bGQu
CgpVbmJpbmRpbmcgY3hsX2FjcGkgdGVhcnMgZG93biB0aGUgcG9ydCBoaWVyYXJjaHksIGlu
Y2x1ZGluZyB0aGUgZW5kcG9pbnQKYW5kIHRoZSByZWdpb24gYXR0YWNoZWQgdG8gY3hsX3R5
cGUyX2FjY2VsLjAuIFBGMCBpcyByZWxlYXNlZCBsYXRlciwgZnJvbQp0aGUgbWVtZGV2IGRl
dGFjaCB3b3JrLiBBIG5vbi1QRjAgcHJvYmUgaW4gYmV0d2VlbiBzdGlsbCBmaW5kcyB0aGUg
bWVtZGV2CmFuZCBsaW5rcyB0byB0aGUgZGVhZCByZWdpb24gdGhyb3VnaCBhdHRhY2gtPmN4
bHIuCgpUbyByZXByb2R1Y2UsIG9uIGEgS0FTQU4ga2VybmVsOgoKICAjIHJlbG9hZCBpZiBj
eGxfdGVzdCB3YXMgbG9hZGVkIHdpdGhvdXQgdHlwZTJfdGVzdAogIG1vZHByb2JlIC1yIGN4
bF9tb2NrX3BmeCBjeGxfdGVzdCAyPi9kZXYvbnVsbAogIG1vZHByb2JlIGN4bF90ZXN0IHR5
cGUyX3Rlc3Q9MQogIG1vZHByb2JlIGN4bF9tb2NrX3BmeAogIHVudGlsIFsgLWUgL3N5cy9i
dXMvY3hsL2RldmljZXMvcmVnaW9uMCBdOyBkbyBzbGVlcCAwLjE7IGRvbmUKCiAgRD0vc3lz
L2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2N4bF9tb2NrX3BmeAogIGZvciBpIGluICQoc2VxIDQw
MCk7IGRvCiAgICAgIGVjaG8gY3hsX21vY2tfcGZ4LjEgPiAkRC91bmJpbmQgMj4vZGV2L251
bGwKICAgICAgZWNobyBjeGxfbW9ja19wZnguMSA+ICREL2JpbmQgMj4vZGV2L251bGwKICBk
b25lICYKICBzbGVlcCAwLjIKICBlY2hvIGN4bF9hY3BpLjAgPiAvc3lzL2J1cy9wbGF0Zm9y
bS9kcml2ZXJzL2N4bF9hY3BpL3VuYmluZAogIHdhaXQKICBkbWVzZyB8IGdyZXAgLUEyMCAn
QlVHOiBLQVNBTicKCkV4cGVjdGVkOgoKICBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1m
cmVlIGluIGRldmljZV9saW5rX2FkZCsweDUyMS8weGE4MAogICBjeGxfZ2V0X3JhbmdlX2Fu
ZF9saW5rKzB4YTkvMHgxMjAgW2N4bF9jb3JlXQoKQSBXQVJOIGluIGRldmljZV9saW5rc19k
cml2ZXJfYm91bmQoKSBjb21lcyBmaXJzdDogYSBub24tUEYwIHByb2JlIGxpbmtzCnRvIHRo
ZSByZWdpb24gYWZ0ZXIgaXRzIGRyaXZlciBpcyBnb25lLiBUaGF0IGxpbmsgaG9sZHMgdGhl
IGxhc3QgcmVnaW9uCnJlZmVyZW5jZSwgc28gdW5iaW5kaW5nIGN4bF9tb2NrX3BmeC4xIGZy
ZWVzIHRoZSByZWdpb24uIFRoZSBuZXh0IHByb2JlCnVzZXMgdGhlIGZyZWVkIHJlZ2lvbi4K
Ck9uIHYyIG9mIHRoZSBzZXJpZXMgYXBwbGllZCB0byB2Ny4zLXJjNCwgdGhpcyBoaXQgb24g
dGhlIGZpcnN0IHBhc3MgaW4gMwpvZiAzIGJvb3RzLiBUaGUgc2FtZSBiaW5kL3VuYmluZCBs
b29wIHdpdGhvdXQgdGhlIGN4bF9hY3BpIHVuYmluZCByYW4gMTAKcGFzc2VzIHdpdGggbm8g
S0FTQU4gcmVwb3J0IG9yIFdBUk4uIFJlcGVhdCBmcm9tIHRoZSBtb2Rwcm9iZSBvZiBjeGxf
dGVzdAppZiB0aGUgd2luZG93IGlzIG1pc3NlZC4KCmN4bF90ZXN0IGhvbGRzIGEgcmVmZXJl
bmNlIG9uIGN4bF9hY3BpLCBzbyAibW9kcHJvYmUgLXIgY3hsX2FjcGkiIGZhaWxzCmhlcmUu
IFRoZSBkcml2ZXIgdW5iaW5kIHJ1bnMgdGhlIHNhbWUgdGVhcmRvd24gdGhhdCBtb2R1bGUg
cmVtb3ZhbCBkb2VzLgpVbmJpbmRpbmcgdGhlIGVuZHBvaW50IGZyb20gY3hsX3BvcnQgaW5z
dGVhZCBvZiBjeGxfYWNwaSBoaXRzIHRoZSBzYW1lCndpbmRvdy4KClRoZSB1c2UtYWZ0ZXIt
ZnJlZSBpcyBvbmx5IHJlcG9ydGVkIHJlbGlhYmx5IHdpdGggS0FTQU46CgogIENPTkZJR19L
QVNBTj15CiAgQ09ORklHX0tBU0FOX0dFTkVSSUM9eQoKQXNzaXN0ZWQtYnk6IExMTQotLS0K
IHRvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvS2J1aWxkIHwgIDIgKwogdG9vbHMvdGVzdGluZy9j
eGwvdGVzdC9wZnguYyAgfCA3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogMiBmaWxlcyBjaGFuZ2VkLCA3OSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9wZnguYwoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3RpbmcvY3hsL3Rlc3QvS2J1aWxkIGIvdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9LYnVpbGQK
aW5kZXggOWEyNGRkYzI4NDg4Li4yNzlkODliZTRhNGQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rl
c3RpbmcvY3hsL3Rlc3QvS2J1aWxkCisrKyBiL3Rvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvS2J1
aWxkCkBAIC02LDExICs2LDEzIEBAIG9iai1tICs9IGN4bF9tb2NrLm8KIG9iai1tICs9IGN4
bF9tb2NrX21lbS5vCiBvYmotbSArPSBjeGxfdHJhbnNsYXRlLm8KIG9iai1tICs9IGN4bF9t
b2NrX2FjY2VsLm8KK29iai1tICs9IGN4bF9tb2NrX3BmeC5vCiAKIGN4bF90ZXN0LXkgOj0g
Y3hsLm8KIGN4bF90ZXN0LXkgKz0gaG1lbV90ZXN0Lm8KIGN4bF9tb2NrLXkgOj0gbW9jay5v
CiBjeGxfbW9ja19tZW0teSA6PSBtZW0ubwogY3hsX21vY2tfYWNjZWwteSA6PSBhY2NlbC5v
CitjeGxfbW9ja19wZngteSA6PSBwZngubwogCiBLQlVJTERfQ0ZMQUdTIDo9ICQoZmlsdGVy
LW91dCAtV21pc3NpbmctcHJvdG90eXBlcyAtV21pc3NpbmctZGVjbGFyYXRpb25zLCAkKEtC
VUlMRF9DRkxBR1MpKQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9wZngu
YyBiL3Rvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvcGZ4LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAwMDAwLi4zOWMwYzA4MWM4OTYKLS0tIC9kZXYvbnVsbAorKysgYi90
b29scy90ZXN0aW5nL2N4bC90ZXN0L3BmeC5jCkBAIC0wLDAgKzEsNzcgQEAKKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKy8qCisgKiBURVNUIE9OTFk6IG1v
Y2sgbm9uLVBGMCBjb25zdW1lci4gSXRzIHByb2JlIGxpbmtzIHRvIHRoZSByZWdpb24gYXR0
YWNoZWQKKyAqIHRvIHRoZSBjeGxfdGVzdCB0eXBlLTIgYWNjZWxlcmF0b3IgdmlhIGN4bF9n
ZXRfcmFuZ2VfYW5kX2xpbmsoKS4KKyAqLworCisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1f
ZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8Y3hsL2N4
bC5oPgorCitzdGF0aWMgY2hhciAqcGYwX25hbWUgPSAiY3hsX3R5cGUyX2FjY2VsLjAiOwor
bW9kdWxlX3BhcmFtKHBmMF9uYW1lLCBjaGFycCwgMDQ0NCk7CisKK3N0YXRpYyBzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZnhfcGRldjsKKworc3RhdGljIGludCBjeGxfbW9ja19wZnhf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3QgZGV2aWNl
ICpwZjA7CisJc3RydWN0IHJhbmdlIHJhbmdlOworCWludCByYzsKKworCXBmMCA9IGJ1c19m
aW5kX2RldmljZV9ieV9uYW1lKCZwbGF0Zm9ybV9idXNfdHlwZSwgTlVMTCwgcGYwX25hbWUp
OworCWlmICghcGYwKSB7CisJCWRldl9pbmZvKCZwZGV2LT5kZXYsICJwZnhfdGVzdDogJXMg
bm90IGZvdW5kXG4iLCBwZjBfbmFtZSk7CisJCXJldHVybiAtRU5PREVWOworCX0KKworCXJj
ID0gY3hsX2dldF9yYW5nZV9hbmRfbGluayhwZjAsICZwZGV2LT5kZXYsICZyYW5nZSk7CisJ
cHV0X2RldmljZShwZjApOworCWlmIChyYykgeworCQlkZXZfaW5mbygmcGRldi0+ZGV2LCAi
cGZ4X3Rlc3Q6IGxpbmsgcmM9JWRcbiIsIHJjKTsKKwkJLyogZG9uJ3QgbGV0IC1FUFJPQkVf
REVGRVIgcmVxdWV1ZSB1cyBiZWhpbmQgdGhlIHRlc3QncyBiYWNrICovCisJCXJldHVybiBy
YyA9PSAtRVBST0JFX0RFRkVSID8gLUVBR0FJTiA6IHJjOworCX0KKworCWRldl9pbmZvKCZw
ZGV2LT5kZXYsICJwZnhfdGVzdDogbGluayByYz0wIHJhbmdlPSVwcmFcbiIsICZyYW5nZSk7
CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyB2b2lkIGN4bF9tb2NrX3BmeF9yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlkZXZfaW5mbygmcGRldi0+ZGV2LCAi
cGZ4X3Rlc3Q6IHJlbW92ZWRcbiIpOworfQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2Ry
aXZlciBjeGxfbW9ja19wZnhfZHJpdmVyID0geworCS5wcm9iZSA9IGN4bF9tb2NrX3BmeF9w
cm9iZSwKKwkucmVtb3ZlID0gY3hsX21vY2tfcGZ4X3JlbW92ZSwKKwkuZHJpdmVyID0gewor
CQkubmFtZSA9ICJjeGxfbW9ja19wZngiLAorCX0sCit9OworCitzdGF0aWMgaW50IF9faW5p
dCBjeGxfbW9ja19wZnhfaW5pdCh2b2lkKQoreworCWludCByYzsKKworCXBmeF9wZGV2ID0g
cGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX3NpbXBsZSgiY3hsX21vY2tfcGZ4IiwgMSwgTlVM
TCwgMCk7CisJaWYgKElTX0VSUihwZnhfcGRldikpCisJCXJldHVybiBQVFJfRVJSKHBmeF9w
ZGV2KTsKKworCXJjID0gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZjeGxfbW9ja19wZnhf
ZHJpdmVyKTsKKwlpZiAocmMpCisJCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKHBmeF9w
ZGV2KTsKKwlyZXR1cm4gcmM7Cit9Cittb2R1bGVfaW5pdChjeGxfbW9ja19wZnhfaW5pdCk7
CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBjeGxfbW9ja19wZnhfZXhpdCh2b2lkKQoreworCXBs
YXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZjeGxfbW9ja19wZnhfZHJpdmVyKTsKKwlwbGF0
Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcihwZnhfcGRldik7Cit9Cittb2R1bGVfZXhpdChjeGxf
bW9ja19wZnhfZXhpdCk7CisKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKK01PRFVMRV9ERVND
UklQVElPTigiY3hsX3Rlc3Q6IFRFU1QgT05MWSBtb2NrIG5vbi1QRjAgY29uc3VtZXIiKTsK
K01PRFVMRV9JTVBPUlRfTlMoIkNYTCIpOwotLSAKMi41NC4wCgo=

--------------IEOlbU9GghqArp2TjhmsEKnV--
