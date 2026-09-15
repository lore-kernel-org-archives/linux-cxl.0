Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD743DEA5
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789451600; cv=none; b=gSL3wDTcdoun7iagx50Fiyue0vaV7e2mWSib40qgBBL56HAZwK7edtDNf25753B5+nCZgExirqjnR48zDcYjnyfIHwt6494atj2Bm9kb5raghNPk8w5qXBSqirMG9zoEqp1rhmewOSXJn1K4cjf8xVPfjJZ475r4UBoS65al5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789451600; c=relaxed/simple;
	bh=/nhNyKvlO9kVN0fWioGWTr7oPR0xIBxPQu5r+x2ThIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKqWtq2AOMmt/GY5WLz+iMjvVQtERiZ+ruCq4116dA1sQoZ09MqhtrqGIMNY+/5bnGqHhqVjkD7IM3YZoMy/9jnli/6hORY6Mf6Lc9e9ZdGJi07CKRecCfG9t6I8d0h0bJwAUqq0/6HjH7bm7bVTsTtz1yKzp6ZYbqQ4IVHWxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AvhpjjDY; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AvhpjjDY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789451593; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ByaPduq/TGdZ9PPNB2tE+ypPgVmWReIsupehIvKra90=;
	b=AvhpjjDYQEGbKCgPR58WHcdEfT1ONgmJ/vvMpfs0oCO6RiiQJN50BHR+yY81FGncG9mCimRZdoZwKbYOxYO0bwBeRZd459Ya/GzN61MTX9/zplVIFRi80Sh26DcUnEMuKQgZ1EKsUNPr7haMkwTzD6q4hor5HZu3oWHfK/8HpxI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB0GdTx_1789451591;
Received: from 30.178.84.235(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB0GdTx_1789451591 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 13:53:12 +0800
Message-ID: <f11c68e8-5b42-4e78-9cb7-721a52b26973@linux.alibaba.com>
Date: Tue, 15 Sep 2026 13:53:11 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cxl/core: Fix dport use-after-free via the einj_inject
 debugfs file
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260914121843.718493-1-kanie@linux.alibaba.com>
 <11bf2aee-166c-4601-8865-f239cac240ac@intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <11bf2aee-166c-4601-8865-f239cac240ac@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/15 05:06, Dave Jiang 写道:
>
> On 9/14/26 5:18 AM, Guixin Liu wrote:
>> The per-dport einj_inject debugfs file retains a pointer to the
>> 'struct cxl_dport', but its lifetime is not tied to the dport. Unbinding
>> the dport host frees the dport and leaves einj_inject behind, so writing
>> the file dereferences freed memory.
>>
>> The stale directory also prevents recreation on rebind.
>>
>> Remove the per-dport debugfs directory when the dport host is released.
>>
>> Found by code inspection, then reproduced on a QEMU CXL topology with
>> KASAN (the einj_cxl_is_initialized() guard had to be forced open, as
>> QEMU emits no EINJ table). Unpatched, writing the leftover file after
>> unbind gives a KASAN slab-use-after-free report in cxl_einj_inject(),
>> and rebind hits "already exists in 'cxl'". Patched, the directory goes
>> away with the dport and rebind recreates a working einj_inject.
>>
>> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Reviewed-by: Richard Cheng <icheng@nvidia.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Applied to cxl/next
> 9185b1a3043c
>
> Can you send a follow up to address the sashiko complaint if needed? Thanks!
I'm sorry, I messed up, sashiko is right, I will send a bugfix patch for 
this.
I should check the devm_add_action_or_reset()'s return value.

Best Regards,
Guixin Liu
>> ---
>> v3: https://lore.kernel.org/linux-cxl/20260828074752.3336779-1-kanie@linux.alibaba.com/
>>
>> v3->v4:
>> - move the devm_add_action_or_reset() call next to the directory creation
>>    (Jonathan Cameron)
>> - drop the KASAN stack from the commit message (Alison Schofield)
>> - rebase onto master (v7.3-rc2), per Dave's request for patches against
>>    Linus's tags rather than cxl/next
>>
>>   drivers/cxl/core/port.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 625e4aa427db..82513b46f634 100644
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
>> @@ -832,6 +837,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>>   
>>   	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>>   
>> +	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
>> +
>>   	debugfs_create_file("einj_inject", 0200, dir, dport,
>>   			    &cxl_einj_inject_fops);
>>   }
>>
>> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713

