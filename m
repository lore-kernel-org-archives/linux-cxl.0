Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F992D2381
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157097; cv=none; b=RDE4vQYdh2ciAGGTiBRr7tS3wWF3a235eSu5S6kkj6hYGPMUuI4Bnqgd4wxj/D2oBTdoVKcVcODuJItnVqUECw4XRF7kRjaBZxaQwM2ju2TFmw/ClgC/uImMlA7DXvX6lHQyG7Ry27pKFqvEP8/c+7smrfMRICVpBmxt6Ifaz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157097; c=relaxed/simple;
	bh=8/X+ZiAhCM0wO44o/aH/9s27PgYmBrDeae7pRna+LD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibpI6uFOW07p8+OXrekDiRXkvRdwex3MdUnDm8qjkz5cKV6Sd3haW7ov1aCpiw0PbU70UlWyVpZq6CYViU4vX49gAXtbYF/ldSCEdABPCpAGGuYE5MydPoPBXBUX5FtdUJZe/X0sVc1uA79cJn9btUO+y/IBUNBLXGe+Sh5evbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vOY37D5T; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vOY37D5T"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788157086; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O2QSOxyllTggiJNb3J6sBKRJE2Uq7Nyfio0GG130yOo=;
	b=vOY37D5TT9jsOtfoksis1sCdFo2iGegzaF03Tp+Hk+ghFisxVrmNdfLRAzR8EESU9x34wy8ztEHKROrttNy/KHRoN5Yi/kpKjVigmdJWZAKaZ8LNZEzcFg6WLBYYv+gtOgoPhNDWPvCsk15/F8JsSTrQwt5f9zVUqU3snB/d5XY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9tHAh2_1788157084;
Received: from 30.178.67.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9tHAh2_1788157084 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 14:18:05 +0800
Message-ID: <a6da695a-36a2-4b1a-a5ed-94cc42218ab2@linux.alibaba.com>
Date: Mon, 31 Aug 2026 14:18:04 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/region: Unregister the pmem region bridge on setup
 failure
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
References: <20260812061043.57319-1-kanie@linux.alibaba.com>
 <anzo3j2nWsGlZIw_@aschofie-mobl2.lan>
 <6487b454-ac7a-41c8-af9d-e2f17743f30e@linux.alibaba.com>
 <apI1Ebyv8U6ZJWYR@aschofie-mobl2.lan>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <apI1Ebyv8U6ZJWYR@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/29 09:25, Alison Schofield 写道:
> On Fri, Aug 28, 2026 at 05:06:55PM +0800, Guixin Liu wrote:
>>
>> 在 2026/8/13 05:42, Alison Schofield 写道:
>>> On Wed, Aug 12, 2026 at 02:10:43PM +0800, Guixin Liu wrote:
>>>
>>> About the subject line:
>>>
>>> Do we unregister the bridge or do we unregister the pmem
>>> region when the bridge is unboound?
>>>
>> Unregister the pmem region, sorry for the confusing description.
>>>> devm_cxl_add_pmem_region() publishes the cxl_pmem_region with device_add()
>>>> and only afterwards, under the nvdimm bridge's device lock, arranges for
>>>> its removal - and only if the bridge has a driver bound. If it does not,
>>>> the function sets -ENXIO and leaves through err_bridge, which drops the
>>>> reference this function took on the bridge and returns. The device that
>>>> was just added has no owner at that point: no device_del(), no
>>>> put_device(), and no devm action to do either later. The sibling failure,
>>>> a devm_add_action_or_reset() that cannot allocate, is already covered,
>>>> because devm_add_action_or_reset() runs cxlr_pmem_unregister() itself on
>>>> that path.
>>>>
>>>> An unbound bridge is a normal state, not an error state. The bridge is
>>>> unbound whenever cxl_pmem is unloaded or its device is detached through
>>>> sysfs, and a region can be probed in that window.
>>>>
>>>> The added device then stays in sysfs, along with the reference it holds on
>>>> the region, until the module is unloaded. cxlr->cxlr_pmem still points at
>>>> it, and worse, the name is still taken: a later probe of the same region
>>>> allocates a second cxl_pmem_region and fails in device_add() on the
>>>> duplicate "pmem_region%d", so once this has happened the region can no
>>>> longer be brought up at all.
>>> Is above an observed behavior?  ie can you reproduce this, apply
>>> the fix, see it go away?  That would be far more valuable than this
>>> excessive narration as proof of repair.
>>>
>>> More below...
>> I'm so sorry, I thought that we should add cleanup in
>> failure branch, but now I realize that this branch is never actually
>> reached.
>>
> I think the patch may still apply as-is, so before dropping it, please take a
> look at this from the teardown side rather than the "cxl_pmem is not loaded" side.
>
> cxl_acpi removal unbinds and deletes the bridge before the regions it serves. So,
> a region probe that already found the bridge can reach that check after the bridge
> is gone, set -ENXIO, and return leaving the just-added device with no owner.
Well, you are right, I test this on vm, it reached the failure branch.

I sent the v3 patch for shorter commit body and testing description.

Best Regards,
Guixin Liu
>
> If that is true (I'm not sure it is) then the fix stands and the changelog needs to
> tell that story.
>
>
> -- Alison
>
>
>> Please ignore this patch, sorry again.
>>
>> Best Regards,
>> Guixin Liu
>>

