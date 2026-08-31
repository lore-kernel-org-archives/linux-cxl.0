Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3973115AF
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162336; cv=none; b=PaUgNGpjUlnTNV6BxWETv6HM/S9MWrx8nXjHtFkbF5jEAzKL/guYIsyja1KDDXRRRzMuhzypSinpz9tgwrcOjBR1YLae8+HYKWi0GaUtbk6aur5xvltm6JAwgl6yGB76ErldsNjGA9tbcHPuIRwuyhjPsoUxdR6fsXFuxoplMLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162336; c=relaxed/simple;
	bh=HDQbfmMPiBAy8SnwMUkREq3A57CRD00DYQ8GhNidOnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaSrvB5rKhPwLfe+HmsC8OLZMqU8q6/logypoKXXf42vsjahA97k/5khKVSVmzd9WdvDwcsWS3uFwRGAErdtAvNuji6h94LIP2Q7P+F52R3dK2HKDFT8kKCIdt32PCeAhRn8ChXTbl+RNtPRlTlthqK2WGvtSmPJnbSoMnIhQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Wexif96A; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Wexif96A"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788162327; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hzuobGUoMt3PFIIr9v8pi11HfmXLDJ+QKndArRZat5I=;
	b=Wexif96Ag/GArQg1WiNtBMwr7A2cY/PHDfwU/GhrsZsPXCcakLYT+OsyyvG20+dhx5u0mww/vs3oJbeFLVrTUCmQspxmlNr7rlWC0EWp5ThO81aQkLqueKq79DhrJp3rxHFzsvi0EseKT1D+7I1z2NsKEGq9SH/Fjj2IloaaGjY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X9v0sDX_1788162324;
Received: from 30.178.67.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9v0sDX_1788162324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 15:45:26 +0800
Message-ID: <945712f4-4f63-43b1-9f18-7ecb17c0adda@linux.alibaba.com>
Date: Mon, 31 Aug 2026 15:45:24 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/memdev: Fix deadlock between poison debugfs and
 cxl_mem unbind
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com,
 linux-cxl@vger.kernel.org
References: <20260826125248.4003792-1-kanie@linux.alibaba.com>
 <apPOJD_CN-0aMXjQ@acer-nitro-anv15-41>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <apPOJD_CN-0aMXjQ@acer-nitro-anv15-41>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/30 14:31, Shaikh Kamaluddin 写道:
> On Wed, Aug 26, 2026 at 08:52:48PM +0800, Guixin Liu wrote:
>> Writing to the memdev poison debugfs files while cxl_mem is being unbound
>> deadlocks. The unbind path takes the memdev device lock and then waits for
>> the debugfs file to drain, while the writer holds the debugfs reference and
>> waits for that same lock:
>>
>>    unbind_store()                     echo 0 > .../mem0/inject_poison
>>      device_release_driver_internal()   full_proxy_write()
>>        <takes cxlmd->dev lock>            <takes debugfs_file_get() ref>
>>        device_unbind_cleanup()            debugfs_attr_write()
>>          devres_release_all()               cxl_debugfs_poison_inject()
>>            remove_debugfs()                   <waits for cxlmd->dev lock>
>>              debugfs_remove_recursive()
>>                __debugfs_file_removed()
>>                  <waits for the ref to drain>
>>
>> Neither side can make progress. A third task piles up behind the held
>> device lock: detach_memdev() runs on cxl_bus_wq, and since that is an
>> ordered workqueue the wedged work item stalls every other CXL bus work
>> item, so unrelated devices stop being rescanned or detached.
>>
>> The write side only needs the device lock so that cxl_dpa_to_region() sees
>> a stable cxlmd->dev.driver. Nothing requires the caller to wait for the
>> lock, so use device_trylock() and report -EBUSY instead. That keeps the
>> debugfs reference from ever being held across a wait for the lock, which
>> breaks the cycle. A concurrent unbind now either completes before the write
>> starts, in which case the write fails with -ENOENT because the file is
>> gone, or loses the race and the write reports -EBUSY.
>>
>> The unbind task sits in uninterruptible sleep and cannot be killed. The
>> writer can be signalled, which is the only reason the current code is
>> recoverable at all.
>>
>> Reproducer, on a device that advertises poison inject support:
>>
>>    while :; do echo 0 > /sys/kernel/debug/cxl/mem0/inject_poison; done &
>>    while :; do
>>        echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
>>        echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
>>    done
>>
>> This hits within milliseconds. Note that lockdep stays quiet: one end of
>> the cycle is the debugfs active_users completion rather than a lock it
>> tracks. The hung task detector does report both blocked tasks.
>>
>> Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/cxl/mem.c | 28 ++++++++++++++++++++--------
>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 798e5c369cfc..01d2d5855694 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -50,11 +50,20 @@ static int cxl_debugfs_poison_inject(void *data, u64 dpa)
>>   	struct cxl_memdev *cxlmd = data;
>>   	int rc;
>>   
>> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
>> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
>> -		return rc;
>> +	/*
>> +	 * The debugfs proxy holds a debugfs_file_get() reference across this
>> +	 * callback, and cxl_mem unbind removes this file from devres while
>> +	 * holding the same device lock. Blocking here would let unbind wait
>> +	 * in debugfs_remove() for a reference that cannot be dropped until
>> +	 * unbind releases the lock, so never wait for the lock.
>> +	 */
>> +	if (!device_trylock(&cxlmd->dev))
>> +		return -EBUSY;
>>   
>> -	return cxl_inject_poison(cxlmd, dpa);
>> +	rc = cxl_inject_poison(cxlmd, dpa);
>> +	device_unlock(&cxlmd->dev);
>> +
>> +	return rc;
>>   }
>>   
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
>> @@ -65,11 +74,14 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>>   	struct cxl_memdev *cxlmd = data;
>>   	int rc;
>>   
>> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
>> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
>> -		return rc;
>> +	/* Avoid the unbind deadlock described in the inject path above. */
>> +	if (!device_trylock(&cxlmd->dev))
>> +		return -EBUSY;
>> +
>> +	rc = cxl_clear_poison(cxlmd, dpa);
>> +	device_unlock(&cxlmd->dev);
>>   
>> -	return cxl_clear_poison(cxlmd, dpa);
>> +	return rc;
>>   }
> Hi Guixin
>
> The analysis and the fix look correct to me. The cycle reduces to:
>
>    Poison writer: holds debugfs reference -> waits for device lock
>    Unbind:        holds device lock       -> waits for debugfs refs to drain
>
> Since one leg is the debugfs active_users completion rather than a
> tracked lock, lockdep cannot see it and only trylock semantics can break
> it -- an interruptible lock would still sleep on the device lock while
> holding the debugfs reference, leaving the cycle intact.
>
> Two suggestions:
>
> 1. This wants:
>
>     Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
>
>     since that commit introduced taking the memdev device lock in these
>     debugfs entry points, which is what closed the cycle against
>     debugfs_remove_recursive() on the unbind path.
Well, this fix tag is already added in this version.
> 2. That same commit used the ACQUIRE(device_intr, ...) conditional
>     guard, so rather than open-coding device_trylock()/device_unlock(),
>     consider keeping the existing style by adding the trylock sibling of
>     commit bb729bf1d6fd ("driver core: Add conditional guard support for
>     device_lock()"):
>
> 	--- a/include/linux/device.h
> 	+++ b/include/linux/device.h
> 	@@
> 	 DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
> 	 DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
> 	+DEFINE_GUARD_COND(device, _try, device_trylock(_T))
>
>     and switching the lock class in the debugfs handlers:
>
> 	ACQUIRE(device_try, devlock)(&cxlmd->dev);
> 	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
> 		return rc;
>
>     device_trylock() returns 1 on success like mutex_trylock(), so the
>     default condition applies and ACQUIRE_ERR() yields -EBUSY on
>     contention, matching the behavior described above. The device.h hunk
>     would need a Cc to the driver core maintainers, same routing as
>     bb729bf1d6fd.
Sure, I will change to new style in v2, thanks.

Best Regards,
Guixin Liu
>
> Best regards,
> Shaikh Kamaluddin
>
>>   
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>> -- 
>> 2.43.7
>>

