Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C363CB
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610616; cv=none; b=AqNBcRpKnvmrxMi1JlYUcvSezYWSpEd0v0cwxGDVKnvkW6ARe0k8xy9nBKp9Tj/V5/LUlLUvwjWK6HQwWwhrYEB2xD4KNbBOaYsYD/JbQEwYqSLN9jqaZhEgXR3hnkt7Ic/OB/t2NLzO37ChXaA9V+VMSkKxBEUlrTCNJ23qCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610616; c=relaxed/simple;
	bh=0tVYT+wSb+9hOqsS0E38Aj1VLCPgbCUmoZOi8zXO4Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBx+gWzzUZnr1j3N0oX3l+1VJt6fCdu1CWmPBmXiLc3wEvTPmJNaeEzpaU6N74u+UgyhWjoWmK66VSm1talrORaRzhzKFVWnjXUqTQw01WXBS3lC/2e0INU4k6GUOFvNm5kzR7+MDRmKXWen8f1Dw0xgUdtHetJkmbxCDceC1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xV06fQhc; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xV06fQhc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789610610; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8gzbtwRcIdmkqh4syihUHuvGsmlmPv1htouLwBCSNa8=;
	b=xV06fQhcVUprxyNmWCb2pym0zXNXkBDmNmMRWGjSlTB4jxEf0BQDgXt72vXevhw3zZ/SrGEkoxk577fX3VeVXhCyzxWrMH+OPHG8dXFTXbTkqVHEGs4B8+XOjeI/4qS7u78elj/VpnnSwvqQ5p3eWPL/OrJKg1K8s4wtOiV3I8Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB6PS9w_1789610608;
Received: from 30.178.84.27(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB6PS9w_1789610608 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 10:03:29 +0800
Message-ID: <b9965fdb-32d2-4f1c-8794-ee64de5ad47f@linux.alibaba.com>
Date: Thu, 17 Sep 2026 10:03:27 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Create node access attributes for CFMWS-only
 NUMA nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
References: <20260916120338.369436-1-kanie@linux.alibaba.com>
 <20260916190059.66a15306@jic23-hlaptop>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260916190059.66a15306@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/17 02:00, Jonathan Cameron 写道:
> On Wed, 16 Sep 2026 20:03:38 +0800
> Guixin Liu <kanie@linux.alibaba.com> wrote:
>
>> A NUMA node that only backs a CXL fixed memory window and is not
>> enumerated by SRAT has no memory_target in the HMAT code. When the
>> first memory of such a node comes online, hmat_callback() exits early
>> at find_mem_target() without creating anything, and
>> node_update_perf_attrs() only updates attributes that already exist,
>> so the node never gets its accessN sysfs attributes at all:
>> /sys/devices/system/node/nodeX/accessN/initiators/* stays missing even
>> though the region's own sysfs reports the coordinates.
>>
>> Commit debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated
>> by SRAT") handled this by having the CXL region notifier call
>> node_set_perf_attrs() directly for such nodes, but
>>
>>    commit 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates
>>    directly instead of through HMAT")
>>
>> replaced that call with node_update_perf_attrs() on the assumption
>> that the HMAT callback has already created the attributes. That
>> assumption does not hold for CFMWS-only nodes.
>>
>> Restore the distinction: when the node is not backed by a real SRAT
>> pxm, create the attributes with node_set_perf_attrs() instead of
>> only trying to update them.
>>
>> Tested on a QEMU CXL topology with a CFMWS window whose memory is not
>> described by SRAT or HMAT: after the region's first memory block comes
>> online, node1 has no accessN directory before this patch; with it,
>> node1/access0/initiators/{read,write}_{bandwidth,latency} appear with
>> the calculated coordinates.
>>
>> Fixes: 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Ah.  I should have caught this one.  Indeed looks correct.
>
> My only concern is it is relying heavily on the fact we only do this
> once which is not apparent at this layer in the code.  You need to go
> looking in cxl_region_perf_attrs_callback() for that.
>
> It is also a one way gate so even you tear down all regions in the NUMA
> node (so the CFWMS) we don't do this update again.
>
> Anyhow, I think all we need here is a note that this function will only
> be called once per CFWMS and thus it is fine to register the sysfs attrs
> here.
OK, added in v2, thanks.

Best Regards,
Guixin Liu
>
> With that added, this looks good to me
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
>
>> ---
>> checkpatch reports one "Prefer a maximum 75 chars per line" warning:
>> the 2e454fb8056d reference line above is 84 columns because checkpatch
>> requires the quoted title to match the git subject exactly, and that
>> subject is 62 characters long. Wrapping it instead produces a
>> GIT_COMMIT_ID error, so the long line is the lesser evil.
>>   drivers/cxl/core/cdat.c   | 5 +++++
>>   drivers/cxl/core/core.h   | 1 +
>>   drivers/cxl/core/region.c | 5 ++++-
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>> ---
>>   drivers/cxl/core/cdat.c   | 5 +++++
>>   drivers/cxl/core/core.h   | 1 +
>>   drivers/cxl/core/region.c | 5 ++++-
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 5c9f07262513..e28c40159d94 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -1072,3 +1072,8 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>>   		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
>>   	}
>>   }
>> +
>> +bool cxl_need_node_perf_attrs_update(int nid)
>> +{
>> +	return !acpi_node_backed_by_real_pxm(nid);
>> +}
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 35eaf636adc9..19a5b8edbfda 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -229,4 +229,5 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>   
>>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>   					   struct cxl_dport *dport);
>> +bool cxl_need_node_perf_attrs_update(int nid);
>>   #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 27e63e6dab7c..636435733754 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2630,7 +2630,10 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>   
>>   	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>>   		if (cxlr->coord[i].read_bandwidth) {
>> -			node_update_perf_attrs(nid, &cxlr->coord[i], i);
>> +			if (cxl_need_node_perf_attrs_update(nid))
>> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
>> +			else
>> +				node_update_perf_attrs(nid, &cxlr->coord[i], i);
>>   			cset++;
>>   		}
>>   	}

