Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D93B5301;
	Fri, 20 Mar 2026 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010902; cv=pass; b=Kxh4aLPk9oPhyN+oUBamS2qmTUMrc/HPNBl9U6wRMMa9bXOtIq0ycVKgsl5cqM539Nqq6mqM95LtsFJu89m4/p67gamJ9uL8o2srKo7FwXZzl4zKOnwS6a4MsWtaP9EP7RZQ6qT+EL8q2z/ts9vMHnoewznpC/aS3i+J658qM3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010902; c=relaxed/simple;
	bh=+PyzxKJilkIOIesVrrfeQLB8PO6/fb0P4Lud5EpgyCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ic1xxstTlVAASNQYruWsbnto5Gr9uS/yNZmNR8C6N2sPSZbTUN1Ki5lBKkS3+oRBYJ3sswXGPdEL9YU1r/RUN5pOhg6soq7x2dRhL2Hd8xt4TKjr7qYma+mfqojGtL3/rjjBynZogOFCbXRB9ZdPJeQC5YELpA3nd96pirOUels=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=aEjDhJ7g; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="aEjDhJ7g"
ARC-Seal: i=1; a=rsa-sha256; t=1774010884; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BP8iXDKOcXWlYKHTi+TP9/6PS6fcG5vkXDv4jU6Dtm/8mXg3C7JkTXTUJfK4l0i1ejXzgMxW2cf+m9wq3jGBU6trEXA3/e/WTkM0bFTrUIkmTs8dT3IT2cYKB4WmK/85RGae2n/zqKvsTLbzDmdg8U7Q4LHZTY/PlIjndtK+hGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774010884; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uNgCbnR5n4DiybXQvNWh+zZG2Bw+8I090Wrc1Jw2RWk=; 
	b=Jn017N+QXRjA6OL0Kr0060oij96V4rwg/L4bkEhKN7TeFhX75tNtruluOExasb1w0tGcqHKHq2HH9XeOtqjaQKFPkepkHtRjY0wXrWNS0f+kZj/ee99B+IPEvtbVX2Cl0tRyrliI6gM1HTtvUo7z/JsUWIsx6W/89HfqxNtGhng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774010884;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=uNgCbnR5n4DiybXQvNWh+zZG2Bw+8I090Wrc1Jw2RWk=;
	b=aEjDhJ7gnwS5AL9fQgpGebLU7qLNdA4S0+TJkcjzBzOBUTUvXoU9ggJa4LacqeG1
	UKqpFPOhuz3LL3uD7aXMcxKOzOsfEdAcAAnr0UayNpY5tFW8RfkpKLUhK/ABO671Hhj
	Cpufu+sONivDnzi5qk0D7a2fTpZdcVazhQautxlo=
Received: by mx.zohomail.com with SMTPS id 1774010883089342.0726550327257;
	Fri, 20 Mar 2026 05:48:03 -0700 (PDT)
Message-ID: <c770c29c-9d2d-435a-8b48-c51770c9a9a6@zohomail.com>
Date: Fri, 20 Mar 2026 20:47:56 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Hold memdev lock during region poison
 injection/clear
To: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20260319-hold_memdev_lock_for_region_poison_inject-clear-v1-1-05243c5a9572@zohomail.com>
 <69bcb13ff3e50_7ee31002c@dwillia2-mobl4.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <69bcb13ff3e50_7ee31002c@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112284318bfb421259ed1336669c400006237628d3f8e400798a52f5b632426492da6964d3aaa0c51e5a6:zu08011227b896ef461063745f2a97379400004d47467d59540e33d2141236c310478be783f4258cd1ee9a5d:rf0801122d47379310c932713b725f735b00006aa5ec772baec7c3837d26b3483eb8a3a66568706d5dbe2910f6883a45085b:ZohoMail
X-ZohoMailClient: External


在 2026/3/20 10:30, Dan Williams 写道:
> Li Ming wrote:
>> cxl_dpa_to_region() has expectations that cxlmd->endpoint remains valid
>> for the duration of the call. When userspace performs poison injection
>> or clearing on a region via debugfs, holding cxl_rwsem.region and
>> cxl_rwsem.dpa alone is insufficient, these locks do not prevent the
>> retrieved CXL memdev from being destroyed, nor do they protect against
>> concurrent driver detachment. Therefore, hold CXL memdev lock in the
>> debugfs callbacks to ensure the cxlmd->dev.driver remains stable for the
>> entire execution of the callback functions.
> I took another look at this and there may be a simpler way to ensure
> this safety.
>
> In the case where we already have a region you can be assured that
> the device is not going to detach from the region while holding the
> proper rwsems. Maybe that was what Alison was referring to about it
> being "ok"?
>
> However, the problem is that cxl_dpa_to_region() is sometimes called
> from paths where the memdev has unknown association to a region like
> cxl_{inject,clear}_poison().
>
> There are two ways to solve that problem. Hold the cxlmd lock, or move
> the registration of debugfs *after* creation of cxlmd->endpoint. With
> that ordering it would ensure that debugfs is only usable in the
> interval here ->endpoint is known to be stable.
>
> If that ends up simpler, we should go that route instead.

Hi Dan,

CXL subsystem has memdev debugfs interfaces and region debugfs 
interfaces for poison injection and clearing.

Memdev debugfs interfaces are possible to access cxl_dpa_to_region() 
before cxlmd->endpoint initialization. So the solution I used as you 
mentioned, holding the memdev lock in memdev debugfs interfaces[1]. It 
can solve this problem.

For region debugfs interfaces, as Alison and you mentioned, 
cxl_rwsem.region lock can ensure the retrieved memdev is not going to 
detach from the region. So I think region poison injection and clearing 
interfaces are safety, we don't need any changes for them.

So my understanding is that the patch[1] is enough for the issue, no 
more changes we need for region poison injection/clearing. is it 
correct? Or I missed some scenarios?


[1]: 
https://lore.kernel.org/linux-cxl/20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com/T/#m06e52a3473395598ab6dd482a6c01b1568ef8b9a

>
>> To keep lock sequence(cxlmd.dev -> cxl_rwsem.region -> cxl_rwsem.dpa)
>> for avoiding deadlock. the interfaces have to find out the correct CXL
>> memdev at first, holding lock in the sequence then checking if the DPA
>> data has been changed before holding locks.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>   drivers/cxl/core/region.c | 112 ++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 88 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index f24b7e754727..1a509acc52a3 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -4101,12 +4101,70 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
>>   	return 0;
>>   }
>>   
>> +static int __cxl_region_poison_lookup(struct cxl_region *cxlr, u64 offset,
>> +				      struct dpa_result *res)
>> +{
>> +	int rc;
>> +
>> +	*res = (struct dpa_result){ .dpa = ULLONG_MAX, .cxlmd = NULL };
>> +
>> +	if (validate_region_offset(cxlr, offset))
>> +		return -EINVAL;
>> +
>> +	offset -= cxlr->params.cache_size;
>> +	rc = region_offset_to_dpa_result(cxlr, offset, res);
>> +	if (rc || !res->cxlmd || res->dpa == ULLONG_MAX) {
>> +		dev_dbg(&cxlr->dev,
>> +			"Failed to resolve DPA for region offset %#llx rc %d\n",
>> +			offset, rc);
>> +
>> +		return rc ? rc : -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_region_poison_lookup(struct cxl_region *cxlr, u64 offset,
>> +				    struct dpa_result *res)
>> +{
>> +	int rc;
>> +
>> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>> +		return rc;
>> +
>> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
>> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>> +		return rc;
>> +
>> +	rc = __cxl_region_poison_lookup(cxlr, offset, res);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/*
>> +	 * Hold the device reference in case
>> +	 * the device is destroyed after that.
>> +	 */
>> +	get_device(&res->cxlmd->dev);
> This is what made me take another look at alternate approaches because
> this reference count is messy.
>
> A region always holds an implicit reference on attached memdevs by
> holding its endpoint decoders. The only value of a reference is making
> sure that if devices are removed while the lock is dropped you can be
> sure that no new memdev aliases the allocation of the old memdev. The
> pointer does not necessarily need to be live for that.
I consider that the cxl_rwsem.region and cxl_rwsem.dpa will be released 
after the function, so it is possible that the memdev will be released 
after this function returned and before trying to hold the memdev lock, 
it will cause the holding memdev lock operation accessing a freed memdev.
>
>> +	return 0;
>> +}
>> +
>>   static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
>>   {
>> -	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
>>   	struct cxl_region *cxlr = data;
>> +	struct dpa_result res1, res2;
>>   	int rc;
>>   
>> +	/* To retrieve the correct memdev */
>> +	rc = cxl_region_poison_lookup(cxlr, offset, &res1);
>> +	if (rc)
>> +		return rc;
>> +
>> +	struct device *dev __free(put_device) = &res1.cxlmd->dev;
> I do not like magic mid-function scopes that are not generated by actual
> allocation functions.
>
>> +	ACQUIRE(device_intr, devlock)(dev);
>> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
>> +		return rc;
>> +
>>   	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>>   	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>>   		return rc;
>> @@ -4115,20 +4173,18 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
>>   	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>>   		return rc;
>>   
>> -	if (validate_region_offset(cxlr, offset))
>> -		return -EINVAL;
>> -
>> -	offset -= cxlr->params.cache_size;
>> -	rc = region_offset_to_dpa_result(cxlr, offset, &result);
>> -	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
>> +	/*
>> +	 * Retrieve memdev and DPA data again in case that the data
>> +	 * has been changed before holding locks.
>> +	 */
>> +	rc = __cxl_region_poison_lookup(cxlr, offset, &res2);
>> +	if (rc || res2.cxlmd != res1.cxlmd || res2.dpa != res1.dpa) {
> Nothing does a put_device() on res2.cxlmd->dev.
>
> So, it seems it would indeed be altogether cleaner to eliminate the
> cxlmd->endpoint validity checking altogether by reordering
> initialization and teardown.

__cxl_region_poison_lookup() would not get the res2.cxlmd->dev reference.


Ming

