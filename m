Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F244221F20
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499924; cv=none; b=fAutnUv6xyTHWTX1gpyPpmDL6KVFaprrZj0c0xLGoKeERLB92XCUcV+QzQkVcu228WAfMLCi41ISjqs4V88lKK39LcAqw7r0nL29Ob0mpT3MGCe+BImFF/Hcx5vzscQZ0jG7MaSElsYYKmaXtYDAHSiaocW8lrVJmsPLYdiVyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499924; c=relaxed/simple;
	bh=wVERQorshqY1l7tqGDqVJJ+VEk+D9Hlm6jvv/THbBAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VF/IONON8eoBZqMqIPDtVZagx/ceWJabC2ThUHc1+typmRDnBbtu/FPedOTVKgB30T6g56+5GodedPkiP8q8PbmVwxdgfDQ8CdaE6m+qL/j47qZ/6hHZ9ZZt9v+GnkJ6lLy6X0d5qPgmiETEiDnWbAhR5JQiZWkvObchAQ5YoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x0Qpw+uy; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x0Qpw+uy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786499919; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Vi4ikxg0WuxQc4Iy28sF+AK/LNj/cch7oxlheH4TrfU=;
	b=x0Qpw+uyo3GOkihq819ZCW2gmhveqpV7jdlyQd80Nk+TP5tX3d4oOcZ95fFCWFLdzwMSmZ1MNN7vLxp5l5sl+VlVWIUe/8yh0SakaCudYPXxD6AltmDteVTg5eYSHzVdH5iklhOXi9k3aPRS6K5Z5kyyjjqcHCuhkbebYs97YEk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8q1KOq_1786499917;
Received: from 30.178.83.207(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8q1KOq_1786499917 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 09:58:38 +0800
Message-ID: <0c1cc925-71e0-4b83-a7b6-76f6058484ab@linux.alibaba.com>
Date: Wed, 12 Aug 2026 09:58:36 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] cxl/core: Fix dport use-after-free via the
 einj_inject debugfs file
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
 <20260811113608.2815625-4-kanie@linux.alibaba.com>
 <06658b3d-74dc-4d89-88c0-38b2ff098c75@zohomail.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <06658b3d-74dc-4d89-88c0-38b2ff098c75@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/12 00:03, Li Ming 写道:
>
> 在 2026/8/11 19:36, Guixin Liu 写道:
>> cxl_debugfs_create_dport_dir() creates a debugfs directory holding an
>> "einj_inject" file whose i_private is the 'struct cxl_dport', but it
>> discards the returned dentry and registers no cleanup. The dport is 
>> freed
>> by free_dport() when the devres group of its host device is released,
>> while the debugfs nodes live until the cxl_core module is unloaded
>> (debugfs_remove_recursive() in cxl_core_exit()).
>>
>> So after unbinding the dport's host, e.g. unbinding the host bridge port
>> or the ACPI0017 root, writing to
>>
>>    /sys/kernel/debug/cxl/<dport_dev>/einj_inject
>>
>> calls cxl_einj_inject() on freed memory and dereferences dport->rch and
>> dport->dport_dev.
>>
>> The leaked directory is also named after the dport device, so 
>> re-adding the
>> same dport (bind after unbind) hits an existing name, debugfs creation
>> fails, and error injection stays broken for that dport for the rest 
>> of the
>> module's lifetime.
>>
>> Save the dentry and drop the whole directory via a devm action on the 
>> same
>> host device. The action is registered inside the dport devres group and
>> after free_dport(), so it runs before the dport is freed. Propagate the
>> failure to __devm_cxl_add_dport() rather than continuing with a dport 
>> that
>> has a dangling debugfs node.
>>
>> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/cxl/core/port.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 1215ee4f4035..76bda54ed986 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -813,13 +813,18 @@ static int cxl_einj_inject(void *data, u64 type)
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
>>                "0x%llx\n");
>>   -static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>> +static void remove_debugfs(void *dentry)
>> +{
>> +    debugfs_remove_recursive(dentry);
>> +}
>> +
>> +static int cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>>   {
>>       struct cxl_port *parent = parent_port_of(dport->port);
>>       struct dentry *dir;
>>         if (!einj_cxl_is_initialized())
>> -        return;
>> +        return 0;
>>         /*
>>        * Protocol error injection is only available for CXL 2.0+ root 
>> ports
>> @@ -827,12 +832,15 @@ static void cxl_debugfs_create_dport_dir(struct 
>> cxl_dport *dport)
>>        */
>>       if (!dport->rch &&
>>           !(dev_is_pci(dport->dport_dev) && parent && 
>> is_cxl_root(parent)))
>> -        return;
>> +        return 0;
>>         dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>>         debugfs_create_file("einj_inject", 0200, dir, dport,
>>                   &cxl_einj_inject_fops);
>> +
>> +    return devm_add_action_or_reset(dport_to_host(dport), 
>> remove_debugfs,
>> +                    dir);
>
> I think we don't need to worry about devm_add_action_or_reset() 
> failing, missing this debugfs directory seems like acceptable, but the 
> failure cases of this devm_add_action_or_reset() will cause dport 
> addition failure.
>
> So I think just like below devm_cxl_dport_ras_setup(), do not check 
> the return value of the function.
Sure, changed in v2, thanks.

Best Regards,
Guixin Liu
>
>
>>   }
>>     static int cxl_port_add(struct cxl_port *port,
>> @@ -1240,7 +1248,9 @@ __devm_cxl_add_dport(struct cxl_port *port, 
>> struct device *dport_dev,
>>       if (dev_is_pci(dport_dev))
>>           dport->link_latency = 
>> cxl_pci_get_latency(to_pci_dev(dport_dev));
>>   -    cxl_debugfs_create_dport_dir(dport);
>> +    rc = cxl_debugfs_create_dport_dir(dport);
>> +    if (rc)
>> +        return ERR_PTR(rc);
>>         if (!dport->rch)
>>           devm_cxl_dport_ras_setup(dport);

