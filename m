Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC249E13A
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 03:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095896; cv=none; b=Qp9M1lJcQ6QJ2fFcxndNalxhvYB6Ia05v7qCAu+3CDTv0EzkuDZYYsmPKGgYdnom0LfemwRD3HxN8QjGiMjAsbTXrqZwbPe1r1doC8/fx1dko39P+o1IUZesWu4WelMrPNV7Y6desC5UcrriuIFBoSb6r9Xjbt+KS9vwE9ErIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095896; c=relaxed/simple;
	bh=bjPqM+VcAh+a8P+z2VF87uFLQb8BoJHn2ALVw76/q5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lX2a33OFjc3XQUrBOX7J2pv79wSrZKfCSZ/CAb2vyb8ZRl9ahFBWK2VRoOd2xrjxzH5evADgUldfkbN8c95OMmKaxymSeYzGlI/G0NCf2W35JMZ+ptsgADVpNKltSkCw/xhJH5bqqHWok1V/oS389AsDsFzdXQKLSy3ih4tqs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bCwtoeUj; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bCwtoeUj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789095890; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3kVmsQaMhqsIG0MvYJHhgvzSNDEwObtxOXNo3bJOxEY=;
	b=bCwtoeUjTcxLcxr3iDFhbJHNbtIBzEcREMqyShRpEaPW7DOq/3XU1di6a5fg2cKuSe6lIQMz3KSqcKtGNQYwOPT3j7Vo+8WCTREAS+pAl5ItMgGc67gN/Od5GDIKQ//SzMTztNGqVt+x0+JCfq/0t4PkZfwa7SXPgJTTXxR1j+o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XAj1iZq_1789095888;
Received: from 30.178.68.176(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAj1iZq_1789095888 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Sep 2026 11:04:49 +0800
Message-ID: <08cbc221-a4b5-4674-ae5e-4e7b5df9293e@linux.alibaba.com>
Date: Fri, 11 Sep 2026 11:04:47 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
To: Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
 <20260910094017.4032170-3-kanie@linux.alibaba.com>
 <20260910220329.20b62302@jic23-hlaptop>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260910220329.20b62302@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/11 05:03, Jonathan Cameron 写道:
> On Thu, 10 Sep 2026 17:40:17 +0800
> Guixin Liu <kanie@linux.alibaba.com> wrote:
>
>> The poison debugfs handlers take the memdev device lock so that the
>> region lookup sees a stable cxlmd->dev.driver. debugfs holds a reference
>> on the file across the handler, and cxl_mem unbind removes that file
>> while holding the very same device lock, so a handler that waits for the
>> lock deadlocks against a concurrent unbind.
>>
>> Both tasks then hang. The unbind side is uninterruptible, and it also
>> blocks the memdev detach work, which runs on an ordered workqueue and so
>> stalls every other CXL bus work item.
>>
>> Take the lock with the trylock guard and return -EBUSY instead of
>> waiting. An unbind that wins the race removes the file first and the
>> write fails with -ENOENT.
>>
>> Found by code inspection. Reproduced by writing inject_poison in a loop
>> while unbinding and rebinding cxl_mem, and confirmed fixed by the same
>> test.
>>
>> Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
>> Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> Probably not one to rush in but nice to clean up the deadlock even if it
> is a little hard to hit.  If it is possible to test with a hot remove
> flow even better.  You should be able to do that with emulation in qemu
> if you don't have hardware capable of safe hotplug operations.
Sure, I reproduced this on hot-remove situation:

debugfs writer, state S, waits for the memdev lock
       cxl_debugfs_poison_inject+0x25/0xa0 [cxl_mem]
       simple_attr_write_xsigned.isra.0+0x1ca/0x2c0
       debugfs_attr_write+0x61/0xb0
       full_proxy_write+0xfc/0x1c0
       vfs_write+0x1d4/0xe60
       ksys_write+0x11f/0x250
       do_syscall_64+0xe2/0x560
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

irq/28-pciehp, state D, holds the memdev lock, waits for the debugfs 
reference to drain
       remove_one+0x27f/0x3d0
       __simple_recursive_removal+0x183/0x4a0
       debugfs_remove+0x44/0x60
       release_nodes+0xfa/0x2c0
       devres_release_all+0x113/0x1a0
       device_unbind_cleanup+0x76/0x260
       device_release_driver_internal+0x3eb/0x540
       bus_remove_device+0x28a/0x540
       device_del+0x371/0x930
       cdev_device_del+0x1d/0xf0
       cxl_memdev_unregister+0x1c/0x70 [cxl_core]
       release_nodes+0xfa/0x2c0
       devres_release_all+0x113/0x1a0
       device_unbind_cleanup+0x76/0x260
       device_release_driver_internal+0x3eb/0x540
       pci_stop_bus_device+0x122/0x170
       pci_stop_and_remove_bus_device+0x16/0x30
       pciehp_unconfigure_device+0x1b4/0x3b0
       pciehp_disable_slot+0xf9/0x2e0
       pciehp_handle_disable_request+0x81/0x100
       pciehp_ist+0x29f/0x410
       irq_thread_fn+0x8b/0x160
       irq_thread+0x189/0x320
       kthread+0x329/0x410
       ret_from_fork+0x33b/0x670
       ret_from_fork_asm+0x1a/0x30

cxl_port workqueue, state D, waits for the memdev lock
       device_release_driver_internal+0x96/0x540
       detach_memdev+0x79/0xb0 [cxl_core]
       process_one_work+0x6b0/0xfb0
       worker_thread+0x4dd/0xd30
       kthread+0x329/0x410
       ret_from_fork+0x33b/0x670
       ret_from_fork_asm+0x1a/0x30

With this patch, the hot-remove flow completed normally.

>
>> ---
>> checkpatch reports "do not use assignment in if condition" twice, on the
>> two ACQUIRE_ERR() lines. Those are pre-existing: the unpatched file and
>> the Fixes: commit report the same two, this patch only swaps the lock
>> class on them, and the combined form is what all 40 ACQUIRE_ERR() call
>> sites in drivers/cxl use.
> We should fix that up. Oddly I thought we had, but guess not.
I think we should fix this in checkpatch.pl, like this:
     if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s &&
    +    $c !~ /=\s*ACQUIRE_ERR\s*\(/) {

Best Regards,
Guixin Liu
>>   drivers/cxl/mem.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 798e5c369cfc..3959ec963026 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -50,8 +50,13 @@ static int cxl_debugfs_poison_inject(void *data, u64 dpa)
>>   	struct cxl_memdev *cxlmd = data;
>>   	int rc;
>>   
>> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
>> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
>> +	/*
>> +	 * Never wait for this lock: the debugfs proxy holds a file reference
>> +	 * across the callback and unbind removes the file under the same
>> +	 * device lock, so waiting here deadlocks against unbind.
>> +	 */
>> +	ACQUIRE(device_try, devlock)(&cxlmd->dev);
>> +	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
>>   		return rc;
>>   
>>   	return cxl_inject_poison(cxlmd, dpa);
>> @@ -65,8 +70,9 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>>   	struct cxl_memdev *cxlmd = data;
>>   	int rc;
>>   
>> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
>> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
>> +	/* Never wait, per the inject path above. */
>> +	ACQUIRE(device_try, devlock)(&cxlmd->dev);
>> +	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
>>   		return rc;
>>   
>>   	return cxl_clear_poison(cxlmd, dpa);

