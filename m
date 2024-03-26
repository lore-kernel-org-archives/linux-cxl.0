Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560413D89D
	for <linux-cxl@vger.kernel.org>; Tue, 26 Mar 2024 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490842; cv=none; b=Jo0PqgcEXlc7887O1DewR05evuCjngaDNWmwhS1oI7REk/Ko2wwP6HzkQhj3Yz3wWfoj6JlNN5CHlrnY4Yb1xBWPTNalE2hL9N/8HVeEmAyePloOBDthNRpjn1pT6qczs2oaWIBQcmS5xXO/f2Otv+jSxirc10nOZuCWkMw1/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490842; c=relaxed/simple;
	bh=Z5Th7fMatMiumaAtS4dcCW9awDIU7jEuz4ZtaRe+Tos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFmUlSqzCdKZdibljQtrSfdl3ejcJysv7K3yjKWjuEgkAgUgPUh6+zs7pFOIMhHmt54hyL2UKP+FTi29NTPe9gk7tE0AWByoJ/mLIH86xN6dEY40wiyw7pgStmtWVzU/Kh+xRyYOq7BYdBLAtYIDeg/LSdLwnV1It2kbcDUil5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+P35VLq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+P35VLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711490840; x=1743026840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z5Th7fMatMiumaAtS4dcCW9awDIU7jEuz4ZtaRe+Tos=;
  b=W+P35VLqqt2PKa6Xj2vxF88qXecMnsXlhlDB7b7ezT7dXEL3StZX4efX
   avFQTlvtBhZU0jhoRLXd69t+T8sFX4tkI25DIm29SO+bhOiG9wobzA2L2
   +ej86WXO2vww7A7M44tccL/Qu6sMYLsl2MvKos73z6VrnmHsl6YYF2EYD
   IXCDmbKSYO03oakxE6cVvECrSFOBXSn6CYQB6K08W4cepeeRVJSP/DoCK
   NoZyS7Iaq7M8TJKOqiodd8ZaW5eE0zFyizmUEadBIb6ndxP1ACwsGvqs0
   Ar42+PI8KnCMakvVzAO7/OX07OhayiPaKSO8UcbAyDKMRVW8vJYSmt94F
   w==;
X-CSE-ConnectionGUID: Ffgeedw3THGPizPsxF8OEQ==
X-CSE-MsgGUID: 8sQ9sT6gSX2PMjB+16TYRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24058948"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="24058948"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 15:07:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="53553985"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.112.247]) ([10.212.112.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 15:07:18 -0700
Message-ID: <cc7c6252-6e92-48b1-96c2-54b9424f9ca3@intel.com>
Date: Tue, 26 Mar 2024 15:07:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] cxl: Change 'struct cxl_memdev_state' *_perf_list
 to single 'struct cxl_dpa_perf'
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net
References: <20240205193218.1657243-1-dave.jiang@intel.com>
 <20240205193218.1657243-2-dave.jiang@intel.com>
 <20240325171051.000033fb@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240325171051.000033fb@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/25/24 10:10 AM, Jonathan Cameron wrote:
> 
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 5303d6942b88..20fb3b35e89e 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -395,13 +395,11 @@ enum cxl_devtype {
>>  
>>  /**
>>   * struct cxl_dpa_perf - DPA performance property entry
>> - * @list - list entry
>>   * @dpa_range - range for DPA address
>>   * @coord - QoS performance data (i.e. latency, bandwidth)
>>   * @qos_class - QoS Class cookies
>>   */
>>  struct cxl_dpa_perf {
>> -	struct list_head list;
>>  	struct range dpa_range;
>>  	struct access_coordinate coord;
>>  	int qos_class;
>> @@ -471,8 +469,8 @@ struct cxl_dev_state {
>>   * @security: security driver state info
>>   * @fw: firmware upload / activation state
>>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>> - * @ram_perf_list: performance data entries matched to RAM
>> - * @pmem_perf_list: performance data entries matched to PMEM
>> + * @ram_perf: performance data entry matched to RAM partition
>> + * @pmem_perf: performance data entry matched to PMEM partition
> 
> Just noticed in review of DCD but these are in wrong place in docs.
> Intentional or accident?

Most likely accidental from moving code around.

> 
>>   *
>>   * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
>>   * details on capacity parameters.
>> @@ -494,8 +492,8 @@ struct cxl_memdev_state {
>>  	u64 next_volatile_bytes;
>>  	u64 next_persistent_bytes;
>>  
>> -	struct list_head ram_perf_list;
>> -	struct list_head pmem_perf_list;
>> +	struct cxl_dpa_perf ram_perf;
>> +	struct cxl_dpa_perf pmem_perf;
>>  
>>  	struct cxl_event_state event;
>>  	struct cxl_poison_state poison;
