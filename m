Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CDB36920C
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525424; cv=none; b=FxcF7PMcsF8UXkifybOCShJS23BRi/lgM6XUuEDyOWYAr7yrxrrfdoEazMO/qaSOJt0EqAbjIwikePkUTf7sB+5AmL2GfkHU46l2SzuYhGC6NnvTw8Qg0r9kJTcrofDMr5inVZJvcq7/JJYWOl/+BmJeeIdqeisH11zINJqYs4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525424; c=relaxed/simple;
	bh=puT/ppyGNW9K4uhsVUxK2IaxkKQ5g83w65cyGw5+uNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oer+1mlzX+X+/XgLUDfAUqggouOXXKYew+Y4XQR+gYNKgjPMU7jQLqXAXCnBgsgUPzbqqwYu+99tkhgz119X5s9zjQCmpVghggL+F3A28KJFLnIMJW8JX/KgczW44yq9m+cKSJ7SWY0Xle9enDg0Hwn/ci4F3r9/wOm94fxnYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u90hduyc; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u90hduyc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789525412; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=D2Vd93Xxo8fnHooGRkQzdFblSLYSVhR33i+MffFi558=;
	b=u90hduycFE8IxjHfwZReNAbTir6SxwbRdB3udgBzgS3HJxRwWQMCQvbcahnVyPsIZJLf6aRroLa4fiznDAXPbSg+Zq5GqsAiF8l+lNUVhTKdSUPDCdsJ6AUjYdSIz2HzX1dFW+6E189NM1bZgLieF5atvCWgZtNLJmrp7iQtUq0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XB3O-WM_1789525410;
Received: from 30.178.84.130(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB3O-WM_1789525410 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 10:23:31 +0800
Message-ID: <d732049c-8c55-4932-85bb-d39995268d5c@linux.alibaba.com>
Date: Wed, 16 Sep 2026 10:23:29 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
To: Alison Schofield <alison.schofield@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
 <20260910094017.4032170-3-kanie@linux.alibaba.com>
 <20260910220329.20b62302@jic23-hlaptop>
 <08cbc221-a4b5-4674-ae5e-4e7b5df9293e@linux.alibaba.com>
 <20260912000908.5df0b62f@jic23-hlaptop>
 <87a780a4-7e69-46df-bbce-a3c021a0b44b@linux.alibaba.com>
 <aqmeBfIj08J4Uqsv@aschofie-mobl2.lan>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <aqmeBfIj08J4Uqsv@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/16 03:35, Alison Schofield 写道:
> On Mon, Sep 14, 2026 at 08:08:26PM +0800, Guixin Liu wrote:
>>
>> 在 2026/9/12 07:09, Jonathan Cameron 写道:
>>> On Fri, 11 Sep 2026 11:04:47 +0800
>>> Guixin Liu <kanie@linux.alibaba.com> wrote:
>>>
>>>> 在 2026/9/11 05:03, Jonathan Cameron 写道:
>>>>> On Thu, 10 Sep 2026 17:40:17 +0800
>>>>> Guixin Liu <kanie@linux.alibaba.com> wrote:
>>>>>> The poison debugfs handlers take the memdev device lock so that the
>>>>>> region lookup sees a stable cxlmd->dev.driver. debugfs holds a reference
>>>>>> on the file across the handler, and cxl_mem unbind removes that file
>>>>>> while holding the very same device lock, so a handler that waits for the
>>>>>> lock deadlocks against a concurrent unbind.
>>>>>>
>>>>>> Both tasks then hang. The unbind side is uninterruptible, and it also
>>>>>> blocks the memdev detach work, which runs on an ordered workqueue and so
>>>>>> stalls every other CXL bus work item.
>>>>>>
>>>>>> Take the lock with the trylock guard and return -EBUSY instead of
>>>>>> waiting. An unbind that wins the race removes the file first and the
>>>>>> write fails with -ENOENT.
>>>>>>
>>>>>> Found by code inspection. Reproduced by writing inject_poison in a loop
>>>>>> while unbinding and rebinding cxl_mem, and confirmed fixed by the same
>>>>>> test.
>>>>>>
>>>>>> Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
>>>>>> Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
>>>>>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>>>>>
>>>>> Probably not one to rush in but nice to clean up the deadlock even if it
>>>>> is a little hard to hit.  If it is possible to test with a hot remove
>>>>> flow even better.  You should be able to do that with emulation in qemu
>>>>> if you don't have hardware capable of safe hotplug operations.
>>>> Sure, I reproduced this on hot-remove situation:
>>>>
>>>> debugfs writer, state S, waits for the memdev lock
>>>>          cxl_debugfs_poison_inject+0x25/0xa0 [cxl_mem]
>>> ...
>>>
>>>> With this patch, the hot-remove flow completed normally.
>>> Nice. Thanks for doing that.
>>>
>>>>>> ---
>>>>>> checkpatch reports "do not use assignment in if condition" twice, on the
>>>>>> two ACQUIRE_ERR() lines. Those are pre-existing: the unpatched file and
>>>>>> the Fixes: commit report the same two, this patch only swaps the lock
>>>>>> class on them, and the combined form is what all 40 ACQUIRE_ERR() call
>>>>>> sites in drivers/cxl use.
>>>>> We should fix that up. Oddly I thought we had, but guess not.
>>>> I think we should fix this in checkpatch.pl, like this:
>>>>        if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s &&
>>>>       +    $c !~ /=\s*ACQUIRE_ERR\s*\(/) {
>>> There are a few other macros that are wrappers of ACQUIRE_ERR
>>> that should be covered in such a patch as well.  If you have
>>> time send a patch!
>>>
>>> Thanks,
>>>
>>> Jonathan
>> Sure, I have already done that, please see: [PATCH] checkpatch: don't flag
>> ACQUIRE_ERR() assignments in if conditions
> Hi Guixin,
>
> I tried same about a year ago and it was not merged, find it here:
>
> https://lore.kernel.org/linux-cxl/20250815010645.2980846-1-alison.schofield@intel.com/
>
> Note that we in CXL land decided to keep using this syntax and ignore
> those checkpatch 'suggestions'.
>
> Send me link to your checkpatch patch (can't find it? ) and I will review it.
>
> -- Alison
Here is my patch:

https://lore.kernel.org/all/20260916020921.3480730-1-kanie@linux.alibaba.com/

Best Regards,
Guixin Liu
>
>> Best Regards,
>> Guixin Liu
>>

