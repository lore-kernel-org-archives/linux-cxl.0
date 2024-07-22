Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7F1401B
	for <linux-cxl@vger.kernel.org>; Mon, 22 Jul 2024 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721688770; cv=none; b=ONmB1KZtxkRbHEplkvfxEuu1sqmhfOs68a38KLnWOhxT30ReVuugYhNW4+8FoBCqubXQ5ZUkSjoy7FiSIv4aHGK4QVv/ZSP2XhjrAb4kDeKVfTdljmnIiXxJpIiKjRWYMF+PhnCfKn6Ybd7OppCdPjBcohwRtrS0e3naFkf6heA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721688770; c=relaxed/simple;
	bh=5UQB6IkhVSicYD3E1W4au/MinSnVZ5hdNk691gisV98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOsrGtRxJtMe9o9Sr4cZO0naymNjL94whbS6o1sifMGkT7UEuSthgKZ5euoKRQ3WtE3Fb2awL4kiRJVOEQ4ALLZQwBBzbxPCTG9xW606e2Ie2XFBtgQzHlrL74nQh/fjE7z8w1yIVadjiOylgy5TgB9FNPrnIdW7DQhBoITySrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkBHkbKf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkBHkbKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721688768; x=1753224768;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5UQB6IkhVSicYD3E1W4au/MinSnVZ5hdNk691gisV98=;
  b=IkBHkbKf7dIFPL1dytnfh6smo7OSw13UnHBhErDwgc9VCbvDKTiIqh/y
   vqVJQcUfPZJ4e+7xpuPaRuiR1h/fwAKY563TXa2FZlvcAVNJBrZSrhq5c
   V8LvxxqMdpfU3w2NxLmW5LL7yHk041NolJ0iLzvbSXPx5O13vNjx/r4Kg
   Ktbx8p/kwdsCmibS+vYtBQOiFBqUG6ogrIVzxtmWymW9W8brrZstbJ+Z3
   e/eoSZ+878SKmxNIpTWBo+BVby5YPDtzz/DHMjMmhAd9eUTeQfzEi/ls0
   u1yQK2vrl09EdjIYJui52LhcIxj+aFcWqkN+VWXTKu2Er+LwVglBF0Ao3
   g==;
X-CSE-ConnectionGUID: DHlFaDKzRiWJ6PdUFcuoLA==
X-CSE-MsgGUID: FDHHlAkLS++KthmidUWThw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30710115"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30710115"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 15:52:47 -0700
X-CSE-ConnectionGUID: B/4zfOPGQ16RV5yoRehTKw==
X-CSE-MsgGUID: 1RRm/lHmTleO2Ge57FVtNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="56857938"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.188]) ([10.125.109.188])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 15:52:46 -0700
Message-ID: <c4c158ce-f3a7-411e-8e9c-c6cd92462c19@intel.com>
Date: Mon, 22 Jul 2024 15:52:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/13] fwctl/cxl: Add support for fwctl RPC command to
 enable CXL feature commands
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-11-dave.jiang@intel.com>
 <20240722152932.GD3371438@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240722152932.GD3371438@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/22/24 8:29 AM, Jason Gunthorpe wrote:
> On Thu, Jul 18, 2024 at 02:32:28PM -0700, Dave Jiang wrote:
>> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
>> index d3a735f1fe4e..de8949a28473 100644
>> --- a/include/uapi/fwctl/cxl.h
>> +++ b/include/uapi/fwctl/cxl.h
>> @@ -22,4 +22,68 @@ struct fwctl_info_cxl {
>>  	__u32 uctx_caps;
>>  };
>>  
>> +/*
>> + * CXL spec r3.1 Table 8-101 Set Feature Input Payload
>> + */
>> +struct set_feature_input {
>> +	uuid_t uuid;
>> +	__u32 flags;
>> +	__u16 offset;
>> +	__u8 version;
>> +	__u8 reserved[9];
>> +	__u8 data[];
>> +} __packed;
> 
> This struct probably needs to be prefixed with fwcl_, but should it be
> here I wonder or should the CXL defined structs be someplace else?
>

It's the "set feature" mailbox input for user to fill out. So probably should be in uapi. 

 
>> +/**
>> + * struct cxl_send_command - Send a command to a memory device.
>> + * @id: The command to send to the memory device. This must be one of the
>> + *	commands returned by the query command.
>> + * @flags: Flags for the command (input).
>> + * @raw: Special fields for raw commands
>> + * @raw.opcode: Opcode passed to hardware when using the RAW command.
>> + * @raw.rsvd: Must be zero.
>> + * @rsvd: Must be zero.
>> + * @retval: Return value from the memory device (output).
>> + * @in: Parameters associated with input payload.
>> + * @in.size: Size of the payload to provide to the device (input).
>> + * @in.rsvd: Must be zero.
>> + * @in.payload: Pointer to memory for payload input, payload is little endian.
>> + *
>> + * Output payload is defined with 'struct fwctl_rpc' and is the hardware output
>> + */
>> +struct fwctl_cxl_command {
>> +	__u32 id;
>> +	__u32 flags;
>> +	union {
>> +		struct {
>> +			__u16 opcode;
>> +			__u16 rsvd;
>> +		} raw;
>> +		__u32 rsvd;
>> +	};
>> +
>> +	struct {
>> +		__u32 size;
>> +		__u32 rsvd;
>> +		__u64 payload;
>> +	} in;
>> +};
> 
> Why all the structs and unions?

It was copied from 'struct cxl_send_command' for the current ioctl command. Will rework that.

> 
>> +/**
>> + * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input
>> + */
>> +struct fwctl_rpc_cxl {
>> +	__u32 rpc_cmd;
>> +	__u32 payload_size;
>> +	__u32 version;
>> +	__u32 rsvd;
>> +	struct fwctl_cxl_command send_cmd;
>> +};
>> +
>> +struct fwctl_rpc_cxl_out {
>> +	__u32 retval;
>> +	__u32 rsvd;
> 
>> +	__u8 payload[];
> 
> This might be better as 
> 
>   __aligned_u64 payload[]
> 
> Which will force a 8 byte alignment of the struct which will allow the
> payload to be casted to aligned u64 reliably.

ok will change.

> 
> How do you know the length of payload?

Yes will change the rsvd field to size.

> 
> Jason
