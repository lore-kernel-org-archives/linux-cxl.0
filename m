Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD825394A
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328979; cv=none; b=ptVGzGOGQBjcL26/2CiZ8tsXVMOc02ZtVjXcXa/eTo8qNoX1/Zip49shdLF9qOPyeM67iDMi8e9WlZS+OH3nOAQKUdc4K3xYrJ7KQR3QN2I2xZxBGLbkQWzomutUhgLh5JxrT14yurPGrGS01MTgJjKpI6YhQBDHg+A1ySV9ktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328979; c=relaxed/simple;
	bh=FWNPG2FmAf4/AmQNlDOh2BPTPBimiZ/3YUTxmKbAlBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmpVMwUjbN4dNBBC8MavCTOhJ66aiuc3V467m5iIXBvp+dDJ/qDpv+StTvmmkz5DXiFzZ+K7RDoTyJnfm0e0SB8AUWVaR1IWo/6j+uknwzRtT2fZeEkYtFT+xxsSrgvJkVgA2WjcWTJsu2C56K7zSE3YBwQ8coz3rCHgqIEMPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0NGrlm4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0NGrlm4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747328977; x=1778864977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FWNPG2FmAf4/AmQNlDOh2BPTPBimiZ/3YUTxmKbAlBQ=;
  b=e0NGrlm4uCSTQyyuldWQz4LOKjaeHzG5xcryBMx/L7KJm7+DKivre2Rq
   eNv7TLQ6z5UFyQj4HZmqSC5RxgxQchBARxj9f0C9b9v9XyLnswkz9TmcN
   jrZQGE1fYLZXZM6j9O3r/zW9kwNBX9L1URDoRswTOj/TTp4tv46WfUXXC
   0PreyEii6FR4JIDFXukfA+rlk7Sfd7duOpjGW/Dtlb0EsbZV5KL4yZQEH
   T0DnC1gBup+pEuxKjo5zs30ZJlS2INTMDFjeuSKGrcLxE3oGgvOx5ajOu
   AVcjU1AEnXSNz71HV0B4RB+cRAZ+SSRJqySjALGKvV8VBT+/CyvqN4LmV
   A==;
X-CSE-ConnectionGUID: 61W/12pKQY6ppf2sKuFEPg==
X-CSE-MsgGUID: rEmh/wN3S+O9+qphVukiow==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59934671"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="59934671"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:04:54 -0700
X-CSE-ConnectionGUID: bGTmpBzMS2qutpk22/fygw==
X-CSE-MsgGUID: ILp1QD65TpGC9PfuJ+dUJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="161731169"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.47]) ([10.125.109.47])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:04:52 -0700
Message-ID: <a8f8f39f-ff3b-4623-9568-070ee8137b25@intel.com>
Date: Thu, 15 May 2025 10:04:51 -0700
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

Ok I'll fold it into previous patch.
> 
> 
> Also, maybe adding some reference for easily seeing where the identifier comes from:
> 
> + * @port_num: hardware identifier for this dport in a decoder's target list

ok 


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

