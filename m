Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79E3C13E9
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159628; cv=none; b=bvdc2rs8wPUQ4V+8sPdBPIZEt7iUegteDf3+wNUzUqYjenpdagUhTHGn9spBNxadbDeXN/qrp/Ea3ScbnoS1lP2OpVjDpl0tFBxgMxzLczd0c3Y9w2r/RGXN1QEytVqoJbYbnX5H6EoWpofZN9YZmhDopnPiXPPDFiIb8kV50qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159628; c=relaxed/simple;
	bh=aMoTG87y115pGpLNN3sAHMjPwuh1IbPnxa43t9N0/4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQBIpbzC0LH2BJgaV3+fxyhelI8+rjZGvA8NEezl3pHll8vwJODp/yyVVcIJXw41BAf6ZTX2/2Z/Ctn1x/4euVMJn4AGPQT+uaDPOo0h5l6jdA61KlfFs8B+sbBLDOlvIzVsyy86YGj1gWTnq/0vdZAn0uznbqdSLoszjym7Htc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vwbywcve; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vwbywcve"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788159622; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rIoJD4YFGalG1UXofUOMJ1UYZB65Tt1R12vwESnqh5c=;
	b=vwbywcve6iOJZQxKaWCsOgyryOEo4z89aP/o2lUtAoO+k65ttoBOA0Tfi+nFqWLKNsChCJ9XBsWLxpYOWs7VC1M1TQADDJY33ArW89MAUAfhswF8zHkfXFi+orTk3wu3DeGXjUJVpI/8TjbahNX35Z5Hih9liBNI8XS+1ZzUNH8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9u1ewY_1788159620;
Received: from 30.178.67.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9u1ewY_1788159620 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 15:00:21 +0800
Message-ID: <fb5402cf-f301-44c6-ae00-755801329ebe@linux.alibaba.com>
Date: Mon, 31 Aug 2026 15:00:18 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cxl/cdat: Fix uninitialized stack use in bandwidth
 gathering
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
References: <20260812083035.372308-1-kanie@linux.alibaba.com>
 <20260812083035.372308-2-kanie@linux.alibaba.com>
 <apDbK_xjfHEV69Cp@aschofie-mobl2.lan>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <apDbK_xjfHEV69Cp@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/28 08:49, Alison Schofield 写道:
> On Wed, Aug 12, 2026 at 04:30:34PM +0800, Guixin Liu wrote:
>> cxl_endpoint_gather_bandwidth() declares three access_coordinate arrays on
>> the stack - pci_coord, sw_coord and ep_coord - without initializing them,
>> and relies on its helpers to fill every member. None of them does.
>> cxl_pci_get_bandwidth() and cxl_port_get_switch_dport_bandwidth() assign
>> only read_bandwidth and write_bandwidth, and __cxl_coordinates_combine()
>> assigns an output bandwidth only when both input bandwidths are non-zero.
>> Every member a producer declines to set is read back as whatever was on the
>> stack. cxl_switch_gather_bandwidth() has the same defect in its coords
>> array, which it hands to cxl_pci_get_bandwidth() and then to
>> cxl_coordinates_combine().
>>
>> Both cases occur on real topologies. The latency members are never written
>> by any of those producers, yet __cxl_coordinates_combine() sums them
>> unconditionally, so the latency reads are undefined on every call. And a
>> device whose CDAT DSLBIS reports no bandwidth for an access class leaves
>> perf->cdat_coord zero for that class, which is exactly the condition that
>> makes __cxl_coordinates_combine() skip the bandwidth assignment and leave
>> the ep_coord entry untouched.
>>
>> The ep_coord case escapes the function: cxl_bandwidth_add() accumulates it
>> into the per-upstream-port aggregate that is published through the region's
>> access coordinate sysfs attributes, so stack contents are reported to
>> userspace as a bandwidth figure. The latency sums are discarded by
>> cxl_bandwidth_add() rather than published, but they are still computed from
>> uninitialized memory.
>>
>> Zero initialize the four arrays. Zero is already the value this code uses
>> for "not reported" - both the __cxl_coordinates_combine() guard and
>> coordinates_valid() test for it - so a member no producer sets now reads
>> back as unknown rather than as a plausible number.
>
> Hi Guixin Liu,
>
> Please see my comments on the einj_inject patch about commit message
> clarity and level of detail. The same issue applies here.
> https://lore.kernel.org/linux-cxl/apDXSzSZVcjQ027J@aschofie-mobl2.lan/
>
> For this patch, I think the essential story is:
>
> Background:
> cxl_endpoint_get_perf_coordinates() returns success for RCDs without
> calculating coordinates.
>
> Issue:
> The output array is left uninitialized on that path.
>
> Impact:
> Callers can consume and expose garbage access-coordinate values.
>
> Resolution:
> Initialize the coordinates to zero before returning for an RCD.
>
> That is enough to explain why the patch is needed. I do not need the
> full path through CDAT parsing, __cxl_coordinates_combine(), QoS class
> selection, cxl_dpa_perf, and sysfs to understand the bug.
>
> Also, as with the other patch, please say how this was found and how it
> was tested.
>
> -- Alison
Sure, I will cut the commit and explain how I found it and how it was 
tested in v4.

Best Regards,
Guixin Liu
>
>
>> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/cxl/core/cdat.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 5c9f07262513..df9261ba84e5 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>>   	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
>>   	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
>>   	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
>> -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
>> -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
>> -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
>> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
>> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
>> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> @@ -757,7 +757,7 @@ static struct xarray *cxl_switch_gather_bandwidth(struct cxl_region *cxlr,
>>   {
>>   	struct xarray *res_xa __free(free_perf_xa) =
>>   		kzalloc_obj(*res_xa);
>> -	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
>> +	struct access_coordinate coords[ACCESS_COORDINATE_MAX] = { };
>>   	struct cxl_perf_ctx *ctx, *us_ctx;
>>   	unsigned long index, us_index;
>>   	int dev_count = 0;
>> -- 
>> 2.43.7
>>

