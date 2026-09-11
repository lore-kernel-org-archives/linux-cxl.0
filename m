Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCC30B51E
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097266; cv=none; b=dYA/VAbWaYvA46kUGz5lEp1Wis2qFA6jgDkcaIE2cp2Yovb7wTDf8LogripTAGNsmYSr9zEj7v8Sw1PhmDowKDnFuTFW2DiXgTHtf7TkhXy/VLTGGptzP5gdwOBGvHgnnvzTCWq9zFt36s3E0BZ+AvblWXegKj8AmTO4WudWHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097266; c=relaxed/simple;
	bh=H6w2Arz0RbWDQaPoS05t1wMSlcGHoLC3HCZiBuazB3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M31g/Ve3HA56nMTvPwAwRw1a1MQzeuVKAbVTk8J4Wzck+3x4rz0KPjzmS034GmZLs7Hs1rS3tF6hYOYl+7mZpnGgnzSd5DC5DQqYkRd6nUp3/VyJzMSaaHYAx6MBFspKMipvprUmWpNA2nPyhDbiu0WxWRr376kPKxoPAF4AuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PrpymxSI; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PrpymxSI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789097260; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ctGma1CINg2IQ65Wat4iF95qIcwM/zzuPvfX6baLUx8=;
	b=PrpymxSIkDvtZwLjwAqCSj3lT1/N/IE/sJ0uZqUEnobR+StzxJLSlfY1oLNCuaTDpBsaWITqGY+OAbkPkP4TgQAI89cmpsQ5reL6qN0MuU1T745n8TPBav2IMw64n7MfJV4bfkbqNaPEsadxGNMeoXL146zua+HOoK3Jjrsrrbs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XAj5ukY_1789097258;
Received: from 30.178.68.176(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAj5ukY_1789097258 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Sep 2026 11:27:39 +0800
Message-ID: <63f9cb3b-075b-49ef-a9d2-7dc1d5c757b8@linux.alibaba.com>
Date: Fri, 11 Sep 2026 11:27:37 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/core: Fix dport use-after-free via the einj_inject
 debugfs file
To: Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
References: <20260828074752.3336779-1-kanie@linux.alibaba.com>
 <20260910230256.47075bea@jic23-hlaptop>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260910230256.47075bea@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/11 06:02, Jonathan Cameron 写道:
> On Fri, 28 Aug 2026 15:47:52 +0800
> Guixin Liu <kanie@linux.alibaba.com> wrote:
>
>> The per-dport einj_inject debugfs file retains a pointer to the
>> 'struct cxl_dport', but its lifetime is not tied to the dport. Unbinding
>> the dport host frees the dport and leaves einj_inject behind, so writing
>> the file dereferences freed memory:
>>
>>    BUG: KASAN: slab-use-after-free in cxl_einj_inject+0xa1/0xf0 [cxl_core]
>>    Read of size 1 at addr ffff88810880ac90 by task bash/1690
>>     cxl_einj_inject+0xa1/0xf0 [cxl_core]
>>     debugfs_attr_write+0x61/0xb0
>>     full_proxy_write+0xfc/0x1c0
>>     vfs_write+0x1d4/0xe60
>>    Allocated by task 213:
>>     __devm_cxl_add_dport+0x1e1/0x14d0 [cxl_core]
>>     cxl_port_add_dport+0xd6/0x200 [cxl_port]
>>    Freed by task 1622:
>>     release_nodes+0xfa/0x2c0
>>     devres_release_all+0x113/0x1a0
>>     device_unbind_cleanup+0x76/0x260
>>     unbind_store+0xde/0x100
>>
>> The stale directory also prevents recreation on rebind.
>>
>> Remove the per-dport debugfs directory when the dport host is released.
>>
>> Found by code inspection, then reproduced on a QEMU CXL topology with
>> KASAN (the einj_cxl_is_initialized() guard had to be forced open, as
>> QEMU emits no EINJ table). Unpatched, writing the leftover file after
>> unbind gives the splat above, and rebind hits "already exists in
>> 'cxl'". Patched, the directory goes away with the dport and rebind
>> recreates a working einj_inject.
>>
>> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Reviewed-by: Richard Cheng <icheng@nvidia.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
> ...
>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 625e4aa427db..62a9c2038d1f 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -814,6 +814,11 @@ static int cxl_einj_inject(void *data, u64 type)
>>   DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
>>   			 "0x%llx\n");
>>   
>> +static void remove_debugfs(void *dentry)
>> +{
>> +	debugfs_remove_recursive(dentry);
>> +}
>> +
>>   static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>>   {
>>   	struct cxl_port *parent = parent_port_of(dport->port);
>> @@ -834,6 +839,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>>   
>>   	debugfs_create_file("einj_inject", 0200, dir, dport,
>>   			    &cxl_einj_inject_fops);
>> +
>> +	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
> I'd move it up a couple of lines so it is closely coupled with the setup function
> for the directory.
Sure, moved in v4, thanks.
>
> This is an interesting corner, we don't fail on debugfs registration failing
> but I think we should potentially fail probe if a cleanup function fails to be
> registered thus leaving us the hanging reference you point out in the first place.
>
> Jonathan
As Li Ming said in v1, missing debugfs dir is acceptable, we should't fail
the whole dport addition flow just because adding debugfs failure.

And if devm_add_action_or_reset() fails, the remove_debugfs() will be 
run to clean the dir. Best Regards, Guixin Liu
>
>>   }
>>   
>>   static int cxl_port_add(struct cxl_port *port,
>>
>> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

