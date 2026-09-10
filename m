Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C823357D19
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032823; cv=none; b=D/VBEGmUVtCLG2wilnqe1+tFK3jOcVKhEG/Pb5LvsZ/j9xxyBhVR83LN+W/oaBdw+dgXXPYQmZ+Olh77QvAPMeKUZqiDUHhbbzJXIlpJiRaDi/uWEIVG5aAHfvXgjIVGdjR9zQBVUvWk8qTFSMGm+7kLKrKRLCm0x892t8zQc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032823; c=relaxed/simple;
	bh=jTfl2GJnS+VeImDj9pcswDC5bJwwSf3rmwW2mr6F3Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8YH90RaGjn6OERY2ipX3EZ9cGv+yG8pck9lny9KMcaxvQePbQ8Jf7Gy47xJHfgs6mUEXXcBoYCx0UZ92VW9M5dqB8r/AxRZyCg1mYN6ew84y0U85m8xf5Tb6hQQ326BVYlCh+FYdV05I8hVPaM7E0fdx2lHmrEdqgnLr+e2S0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rAq8vagd; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rAq8vagd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789032816; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G9UxlrWZR/vR6zm7wypTV2y1EmDWnzJG11tE37UaGXU=;
	b=rAq8vagdOKyZEHnxGSGWtiWbuTRp2bHs/xUxr7hIPdxvqVaC4QBZuIhcAwEC0LtQ+U99X8aTGBQLmws6n3w/AtE2QTcTxT+iHSqS/xs+vh00EqROBDrYjrWH5pESiA1BFTAN7rILHRMKJFKag0gi8qQpNPOENA04seJqO8cztEY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XAhFvQQ_1789032814;
Received: from 30.178.66.249(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAhFvQQ_1789032814 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 17:33:35 +0800
Message-ID: <28266062-a909-464c-ab05-2dec9af428e7@linux.alibaba.com>
Date: Thu, 10 Sep 2026 17:33:34 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cxl/memdev: Fix poison debugfs vs unbind deadlock
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org, driver-core@lists.linux.dev
References: <20260831124809.889829-1-kanie@linux.alibaba.com>
 <124abd10-a6df-4256-b994-37c92218bac9@intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <124abd10-a6df-4256-b994-37c92218bac9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/10 00:28, Dave Jiang 写道:
>
> On 8/31/26 5:48 AM, Guixin Liu wrote:
>> Writing a memdev poison debugfs file while cxl_mem is being unbound
>> deadlocks. Patch 2 fixes it by not waiting for the device lock in those
>> handlers. Patch 1 adds the trylock guard it uses.
>>
>> Patch 2 does not build without patch 1, so the two need to travel
>> together.
>>
>> Testing:
>>
>> Reproduced on a QEMU CXL topology whose type3 devices advertise poison
>> inject support:
>>
>>    while :; do echo 0 > /sys/kernel/debug/cxl/mem0/inject_poison; done &
>>    while :; do
>>        echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
>>        echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
>>    done
>>
>> Without the fix the unbind wedges within seconds. The three tasks
>> involved, from /proc/<pid>/stack:
>>
>>    writer, state S, holds the debugfs reference and waits for the lock
>>      cxl_debugfs_poison_inject+0x25/0xa0 [cxl_mem]
>>      debugfs_attr_write+0x61/0xb0
>>      full_proxy_write+0xfc/0x1c0
>>      vfs_write+0x1d4/0xe60
>>
>>    unbind, state D, holds the lock and waits for the reference to drain
>>      remove_one+0x27f/0x3d0
>>      debugfs_remove+0x44/0x60
>>      release_nodes+0xfa/0x2c0
>>      devres_release_all+0x113/0x1a0
>>      device_unbind_cleanup+0x76/0x260
>>      device_release_driver_internal+0x3eb/0x540
>>      unbind_store+0xde/0x100
>>
>>    cxl_port workqueue, state D, blocked on the same lock
>>      device_release_driver_internal+0x96/0x540
>>      detach_memdev+0x79/0xb0 [cxl_core]
>>      process_one_work+0x6b0/0xfb0
>>
>> The writer is in interruptible sleep and can be killed; the unbind
>> cannot, and because cxl_bus_wq is an ordered workqueue the wedged
>> detach_memdev() blocks every other CXL bus work item behind it.
>>
>> With both patches applied, 46 unbind/bind cycles against the same writer
>> loop all completed, no task was left in D state, and the writer collected
>> 10920 EBUSY returns from the contended trylock. Note that lockdep stays
>> quiet either way: one leg of the cycle is the debugfs active_users
>> completion rather than a lock it tracks.
>>
>> v1 -> v2:
>> - add the device_trylock() guard and use ACQUIRE(device_try, ...) instead
>>    of open-coding device_trylock()/device_unlock(), keeping the style the
>>    Fixes: commit established (Shaikh Kamaluddin)
>> - cut the changelog down to the failing condition, the consequence and
>>    the fix; the call graph and the reproducer live here instead
>> - say how the issue was found and how it was tested
>>
>> v1:
>> https://lore.kernel.org/linux-cxl/\
>> 20260826125248.4003792-1-kanie@linux.alibaba.com/
>>
>> Guixin Liu (2):
>>    driver core: Add conditional guard support for device_trylock()
>>    cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
>>
>>   drivers/cxl/mem.c      | 14 ++++++++++----
>>   include/linux/device.h |  1 +
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>>
>> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> Please rebase the patch series on Linus tags rather than cxl/next. Currently v7.3-rc2. It would be nice to get sashiko coverage.
OK, changed in v3.

Best Regards,
Guixin Liu

