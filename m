Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25628641D
	for <linux-cxl@vger.kernel.org>; Mon, 19 May 2025 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672411; cv=none; b=iOJymrJNsc2IxCY9nvoD3dNgJBLmanzIW//9YEEn1p0zROBu4O7x2dLFngh7y588wjVeWEor8K1glAMI6xIxuyOkeh3jSDHGgrUI48/mHn34CIi/2oxU/c1RcQFSNaD5Db9UpBb0/dvY8bkb3HzxPvCBCwXTI7GAghHMop/HL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672411; c=relaxed/simple;
	bh=slCYxMypjGm0x7EzMEm0ZKlhu5U3VXDejvR0ckRSyPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apsb14NFGXBKY5oeeC/oHtTIyYxawVsNudaJ8o9oKr6GuHDdHgXaf5GYWxG5u3A59Hryp1r3R7rnE/W4N5ecG35HNAXjm6YVHqmR9OYPlb/FeZZ5Q0UOBR2P7OSkX+vMOKs+fpFmx5PQou1SREFEpWROfcsbg9DwGv88sy7wrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ml35V+IH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ml35V+IH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747672409; x=1779208409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=slCYxMypjGm0x7EzMEm0ZKlhu5U3VXDejvR0ckRSyPI=;
  b=ml35V+IHQGvEkrR0rvtboJnt/1TThXN2BUoL6tmRqYu1o8Esjo8+JEN+
   7s0Fv6GHbhDDWn9rJcCuCdYRFEbxTAnBqUITyZOx97YQDFA3YqU/yaFcl
   BsB4YHEamQ2zG4IIyzDm7vdHeY9GlEgv4PBAmEBtzbcTX7LuTtbcAU1M0
   sKrrUIs9/zflTuVT1AqpLwEXsF+T7ruglMcIO4MnmJW1+YCM5j0MPLvPy
   c7g7RK0uSlzKeY0RhHAnyCpPQJEs/Xe/Bq3IO4QTtahiKzaSb4ZK/ZrN4
   jh91DAstgh0V7E3erFn1K1X9K0AFw1ueuqLO1z0pwvcCB0CJYFZaHx6ga
   g==;
X-CSE-ConnectionGUID: OtCaQhT3QFqqxx2dQargHA==
X-CSE-MsgGUID: Z4FFygH1THyENvwZrdNdpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49718803"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49718803"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 09:33:28 -0700
X-CSE-ConnectionGUID: 34qo85DnS8eTAytOiG+tKw==
X-CSE-MsgGUID: gxpP0o1JTDKJrGWwvUIDgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="144297659"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.109.80]) ([10.125.109.80])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 09:33:27 -0700
Message-ID: <431bc155-de69-4e07-82f1-33c654b6d907@intel.com>
Date: Mon, 19 May 2025 09:33:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] cxl: Rename find_dport() to provide better
 function intent
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-4-dave.jiang@intel.com>
 <36ee7c17-4a06-4288-89d0-547c23afb8e6@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <36ee7c17-4a06-4288-89d0-547c23afb8e6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/9/25 2:20 AM, Alejandro Lucero Palau wrote:
> 
> On 5/7/25 01:43, Dave Jiang wrote:
>> Rename find_dport() to find_dport_by_num() to indicate that the function
>> is trying to match a dport by its hardware number index.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/port.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index e9c02e4d0d4c..1d7a4a2ef6ad 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1045,7 +1045,7 @@ void put_cxl_root(struct cxl_root *cxl_root)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
>>   -static struct cxl_dport *find_dport(struct cxl_port *port, int port_num)
>> +static struct cxl_dport *find_dport_by_num(struct cxl_port *port, int port_num)
>>   {
>>       struct cxl_dport *dport;
>>       unsigned long index;
>> @@ -1063,7 +1063,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>>       int rc;
>>         device_lock_assert(&port->dev);
>> -    dup = find_dport(port, dport->port_num);
>> +    dup = find_dport_by_num(port, dport->port_num);
>>       if (dup) {
>>           dev_err(&port->dev,
>>               "unable to add dport%d-%s non-unique port num (%s)\n",
>> @@ -1275,13 +1275,13 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, "CXL");
>>    * devm_cxl_add_rch_dport - append RCH downstream port data to a cxl_port
>>    * @port: the cxl_port that references this dport
>>    * @dport_dev: firmware or PCI device representing the dport
>> - * @port_id: identifier for this dport in a decoder's target list
>> + * @port_num: identifier for this dport in a decoder's target list
> 
> 
> Not sure this change should be in this patch. It makes more sense to me in the previous one.
> 
> 
> Also, maybe adding some reference for easily seeing where the identifier comes from:
> 
> + * @port_num: hardware identifier for this dport in a decoder's target list

In the process of doing that, I realized that this entire comment line gets dropped in a later patch because we remove the port_num parameter. So probably no need to change since it goes away entirely.

DJ

> 
> 
>>    * @rcrb: mandatory location of a Root Complex Register Block
>>    *
>>    * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
>>    */
>>   struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>> -                     struct device *dport_dev, int port_id,
>> +                     struct device *dport_dev, int port_num,
>>                        resource_size_t rcrb)
>>   {
>>       struct cxl_dport *dport;
>> @@ -1291,7 +1291,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>           return ERR_PTR(-EINVAL);
>>       }
>>   -    dport = __devm_cxl_add_dport(port, dport_dev, port_id,
>> +    dport = __devm_cxl_add_dport(port, dport_dev, port_num,
>>                        CXL_RESOURCE_NONE, rcrb);
>>       if (IS_ERR(dport)) {
>>           dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
>> @@ -1764,7 +1764,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>>         guard(rwsem_write)(&cxl_region_rwsem);
>>       for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
>> -        struct cxl_dport *dport = find_dport(port, target_map[i]);
>> +        struct cxl_dport *dport = find_dport_by_num(port, target_map[i]);
>>             if (!dport)
>>               return -ENXIO;

