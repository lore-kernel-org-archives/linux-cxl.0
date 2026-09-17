Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF62F39C7
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610672; cv=none; b=JutS4DA+CmlXCugjrs36QoPpPCQ2u6MFUcODVur2Dev3Lh8efolFQCG4Chfwx06858cBURa/LUq1Fc70AGX8/C+1fIdsRzz+yT7U5hM+HjVt9ESfaup+td+MwalSnK+6hwPWWdgZlSmgUrEbYtwtUKG9mog8E2btjcloFXg/sQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610672; c=relaxed/simple;
	bh=ft/bwP9iuFCNZexDvWfc9Bem1aQ0r4LwyvTVoKflAWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H24jbxlMjHM5WgGpXF3i3m4jhHV61fEjbp1s/ti8j937y67jMhrSk9ohZBMTA9usW2zPaWRsNXFJe0cRw0QkCwrml6FXyP9yMr+TitNXQXA488MBrblnRP5NvqKhKVX6THOOZh1G+sBWYT3gRE2UesTUs9XwkUz00LDbufB2rmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w1gZyL3v; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w1gZyL3v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789610665; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=avkzMNcGYKbxRaTSkl1ReZKA8lgwdmwebBIe7Xuucmc=;
	b=w1gZyL3v7uHsPNVZw3kZosJ4W5PB50bqG3oxzK/eWmv0ItbltWLTmbu1UInJXkSMG01u9ntamQhZ77mvbgmRtGgYf71KS5/GDTClaLiBKn1AOZ2YdHv5xjbJj08iir/9mc8xtkhY48Gz9b+rcrEfHkfvwf8a60XOlFCHFcHYh90=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB6HFhz_1789610664;
Received: from 30.178.84.27(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB6HFhz_1789610664 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 10:04:24 +0800
Message-ID: <7ba8b95f-ee4c-4696-9c10-f9f6598d1a2f@linux.alibaba.com>
Date: Thu, 17 Sep 2026 10:04:23 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Create node access attributes for CFMWS-only
 NUMA nodes
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
References: <20260916120338.369436-1-kanie@linux.alibaba.com>
 <aqsCl1JAwiemCjad@aschofie-mobl2.lan>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <aqsCl1JAwiemCjad@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/17 04:56, Alison Schofield 写道:
> On Wed, Sep 16, 2026 at 08:03:38PM +0800, Guixin Liu wrote:
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
>
> The detailed analysis establishes that this is a regression in the existing
> CFMWS-only NUMA node support, but I think that gets a little lost in the
> forensics.
>
> Could you make that more explicit up front? In particular, the user-visible
> impact is that a NUMA node which the kernel already supports creating from
> CFMWS no longer gets its accessN attributes.
Yes, it's better, will be changed in v2, thanks.

Best Regards,
Guixin Liu
>
> Gregory's point about whether QEMU should also provide SRAT is a
> separate issue, like he notes. The kernel already supports the
> CFMWS-only path, so I think we should continue to handle it correctly.
>
> -- Alison
>
>> Fixes: 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
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
>> -- 
>> 2.43.7
>>

