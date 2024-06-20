Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E281AF6AA
	for <linux-cxl@vger.kernel.org>; Thu, 20 Jun 2024 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898701; cv=none; b=A4PcJPNXxNfx4JLJsUVgxuWsTHPnAGlpNFoUwVFKM8seP5dudsG77JEjfL1dg4lKPzQRy5U/fwurc8eHMbj7VSoN9kGb+ry4bUZvMp/itMPndKPPhZYR2nkov84nI2qdXIhxQgae8051CaOhT0uoipjk5ChccFlKN3hFBCjUZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898701; c=relaxed/simple;
	bh=agCwqOeNiTlCBNAJlb/Z1ovWMBbWxNCSgy7+apBHXNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnO4zrUDSKggvJ27n6tNq0AsqusUYc0v1YLtwH+84TFFloen0S5j5WjN+ZtFv1Fs9UKJbk1ycuVUI9jyJI8IPz5rJp8rx7Qa1n2CY8JkI9VUgudVeaISfq3TpiOP8gVvt67DZ9C6lF8YIAQVcjW0iSCmHQTg2+DR/LU8SwulFzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhMr87vh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhMr87vh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718898700; x=1750434700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=agCwqOeNiTlCBNAJlb/Z1ovWMBbWxNCSgy7+apBHXNs=;
  b=hhMr87vhiIELmi3YAf4CGPlEWlp+QY9h+bSePAbdEfkfwU+poIT9KW6s
   eEO9xlKgySoaX4teK2R3tqRtbwPge84YoBUpa1b62jJD3PxZDonoVvmC1
   TWwhqFyfmjXE9gU6zXi0NaOb60HrMzvZJBKfMsR/J+X8P1TNmRcwGy4kP
   JSwE5lMCoaKgL6eGYrbam9aIJDus7A6rDFKl6i50dEBJ3k2nlMnvzMlAL
   Ac82G66Op4Lo5upwrvz4XKQBfkJzFoAr9mdj/GjQJzHM6TF2aZOdbRx3X
   WnLmwYg6VNCMa/++Kb2v1z90zLiBdP0p7K85hP+DbUrhMrm9kxYjzGlSb
   w==;
X-CSE-ConnectionGUID: +zAswfrVQICbY+7xBjj7qg==
X-CSE-MsgGUID: 3KPX3rDITJ23u0NsNIQXHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16120106"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="16120106"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 08:51:39 -0700
X-CSE-ConnectionGUID: 7uaMk55MQxiho9lCN0+/jA==
X-CSE-MsgGUID: Qo6DET4hSGWqdbX+PQo4hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="47234517"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.70]) ([10.125.108.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 08:51:38 -0700
Message-ID: <e6b3a936-9c45-4d34-bf7c-2b68e2ad79ae@intel.com>
Date: Thu, 20 Jun 2024 08:51:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <be14ee00-6d43-4db1-ad63-beac6aacb814@intel.com>
 <b9bbf3bc-9125-4cbb-b127-613b841dc9a8@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <b9bbf3bc-9125-4cbb-b127-613b841dc9a8@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/19/24 2:24 AM, Shiyang Ruan wrote:
> 
> 
> 在 2024/6/19 7:35, Dave Jiang 写道:
>>
>>
>> On 6/18/24 9:53 AM, Shiyang Ruan wrote:
>>> Background:
>>> Since CXL device is a memory device, while CPU consumes a poison page of
>>> CXL device, it always triggers a MCE by interrupt (INT18), no matter
>>> which-First path is configured.  This is the first report.  Then
>>> currently, in FW-First path, the poison event is transferred according
>>> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES
>>>   -> CPER -> trace report.  This is the second one.  These two reports
>>> are indicating the same poisoning page, which is the so-called "duplicate
>>> report"[1].  And the memory_failure() handling I'm trying to add in
>>> OS-First path could also be another duplicate report.
>>>
>>> Hope the flow below could make it easier to understand:
>>> CPU accesses bad memory on CXL device, then
>>>   -> MCE (INT18), *always* report (1)
>>>   -> * FW-First (implemented now)
>>>        -> CXL device -> FW
>>>           -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>>>      * OS-First (not implemented yet, I'm working on it)
>>>        -> CXL device -> MSI
>>>           -> OS:CXL driver -> memory_failure() (2.b)
>>> so, the (1) and (2.a/b) are duplicated.
>>>
>>> (I didn't get response in my reply for [1] while I have to make patch to
>>> solve this problem, so please correct me if my understanding is wrong.)
>>>
>>> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
>>> to check whether the current poison page has been reported (if yes,
>>> stop the notifier chain, won't call the following memory_failure()
>>> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
>>> page already handled(recorded and reported) in (1) or (2), the other one
>>> won't duplicate the report.  The record could be clear when
>>> cxl_clear_poison() is called.
>>>
>>> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>>
> 
> ...
> 
>>> +
>>> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
>>> +{
>>> +    struct cxl_contains_hpa_context ctx = {
>>> +        .contains = false,
>>> +        .hpa = hpa,
>>> +    };
>>> +    struct cxl_port *port;
>>> +
>>> +    port = cxlmd->endpoint;
>>> +    if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
>>
>> Maybe no need to check is_cxl_endpoint() if the port is retrieved from cxlmd->endpoint.
> 
> OK, I'll remove this.
> 
>>
>> Also, in order to use cxl_num_decoders_committed(), cxl_region_rwsem must be held. See the lockdep_assert_held() in the function. Maybe add a
>> guard(cxl_regoin_rwsem);
>> before the if statement above.
> 
> Got it.  I didn't realize it before.  Will add it.
> 
> 
> BTW, may I have your opinion on this proposal?  I'm not sure if the Background and problem described above are correct or not.  If not, it could lead me in the wrong direction.

Patch looks ok to me, but I'm no RAS expert in this area. Lets wait for comments from Jonathan and Dan. 
> 
> Thank you very much!
> 
> 
> -- 
> Ruan.
> 
>>
>> DJ
>>
