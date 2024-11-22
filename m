Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44039189910
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315374; cv=none; b=m1vwLowEQ0ylVfhShCMCDGZyfZ4PaUZb/w18e5RUops53pCQnuperVgqIlbsFOF4dwt6Ykvdl/kwCnmL2KdsaQ28fuGF/Rcz4JVDfWVQGYV2EsbXaXwaojhFVvzQrsstDz3rDC7aPNg1bf3FblyW30XXrgECkyGgL+BgzFGk+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315374; c=relaxed/simple;
	bh=F4FURdS17CO9A58c4Yn7LOq/+UtfVTHoYevFApAVUvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/1Im4yTOMsR1JTbNceiexH/Thd+EKTsy3MvTqqCIMoiaN4zluNPgD23AcDX1jGMGB0RzirIQ8p5y+rDOV87GgcuSGYcKZyR2pyTED0qhBxhzjnlUM59bRjMyQLSOH6dvg6HrEMr4C+LCooySMcPqxh4qlhZYb1qutLgOEkP3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QN2XYF8L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QN2XYF8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732315372; x=1763851372;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F4FURdS17CO9A58c4Yn7LOq/+UtfVTHoYevFApAVUvw=;
  b=QN2XYF8L//a3Zq+9ItJJDveUkET40/lljMHh/wUUee9ZFPTbthPee5WQ
   RwNPu2QQgjCWG3joIMgxMdhXK6T62n8+zsqE5VH2wPRg89rRO3XAnjg1n
   VfYxFlFoF2VYPPZq/HppNZ7myBgu/7jTDSCcZ27clG7B+YHBcO1/f1AAU
   RGncgzJEil3e0b+aiTqqrvVEEgpFU5US8AWq5KvTh9nYVKMmam50WR+UC
   927PIxBQiS5eIyevUPQ2d3FQlfPwyGLP51UT3MmLZFvYFphJLl7rCkC7c
   /ew+YuLEk0acEw+0h9aEf9V6Z6VejI15XvfMbwgaV6HVmKxRikIyNxFx9
   g==;
X-CSE-ConnectionGUID: 4zFgNbIJQayoT1jmIrwskg==
X-CSE-MsgGUID: wB7fRdtqTvuriXXbTQzKMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="31844348"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="31844348"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 14:42:51 -0800
X-CSE-ConnectionGUID: MF4CnBVlSjm+R/7Ge45dkw==
X-CSE-MsgGUID: UorQgHFqTGmRB91jS3jDQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="90881510"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.105]) ([10.125.110.105])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 14:42:51 -0800
Message-ID: <4b319c30-78bb-4bc9-bb7a-98baa16780d8@intel.com>
Date: Fri, 22 Nov 2024 15:42:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/20] fwctl: FWCTL_HW_INFO to return hardware
 information
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-12-dave.jiang@intel.com>
 <20241121182036.00006f6e@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241121182036.00006f6e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/24 11:20 AM, Jonathan Cameron wrote:
> On Fri, 15 Nov 2024 14:25:44 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add an optional ioctl FWCTL_HW_INFO to pass command specific information
>> to user space. An array of 'struct fwctl_command_info' will be returned
>> from the ioctl. These commands are send to the driver via FWCTL_RPC call.
>> The command info struct contains the command id, the related hardware
>> opcode, input and output size for the command, and the effects the command
>> has if it's a write command.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Minor stuff inline.
> 
> Jonathan
> 
> 
>> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
>> index 4e4d30104667..7334907e27c1 100644
>> --- a/include/uapi/fwctl/fwctl.h
>> +++ b/include/uapi/fwctl/fwctl.h
> 
>>  enum fwctl_device_type {
>> @@ -69,6 +70,61 @@ struct fwctl_info {
>>  };
>>  #define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
>>  
>> +/**
>> + * struct fwctl_command_info - Hardware command information returned from a query.
>> + * @id: Driver ID number for the command
>> + * @opcode: Hardware command opcode
>> + * @set_effects: Effects to the OS and hardware when command is executed.
>> + *               Provided by the device.
> 
> Run kernel doc over the files.  (wrong name)
> 
>> + * @size_in: Expected input size, or ~0U if variable length.
>> + * @size_out: Expected output size, or ~0U if variable length.
>> + *
>> + * Represents a single command that is supported by both the driver and the
>> + * hardware. This is returned as part of an array from the FWCTL_HW_INFO ioctl.
>> + */
>> +struct fwctl_command_info {
>> +	__u32 id;
>> +	__u16 opcode;
>> +	__u16 effects;
>> +	__u32 size_in;
>> +	__u32 size_out;
>> +};
>> +
>> +/**
>> + * struct fwctl_hw_info_out - output struct for FWCTL_HW_INFO
>> + * @nr_cmds: Number of commands for output
>> + * @reserved: Reserved u32 for alignment.
> 
> As currently defined, why do we need to pad? I'm not against
> padding just not understanding the comment.
> It's more fun if there is a u64 in there (we all love 32 bit
> x86 data alignment).

If 32bit alignment is fine then I'll drop it.

> 
>> + * @commands: Array of 'struct fwctl_command_info'
>> + */
>> +struct fwctl_hw_info_out {
>> +	__u32 nr_cmds;
>> +	__u32 reserved;
>> +
>> +	struct fwctl_command_info commands[] __counted_by(nr_cmds);
>> +};
> 
> 

