Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDCD33B6F9
	for <linux-cxl@vger.kernel.org>; Thu,  7 May 2026 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778196993; cv=none; b=LteMCK+q9JdlD7ckfJRph+NxTK52MO6gVBIBg3Qjh03UAFOQsxsswoa2qzjjalMFUPrsp0UbOvZoM2UYWMi720DN/4kpJ1nGfvbAJjtJ8LpmpsX+N0jaMZYF30d0lfPA2qNXvDcmSMMtAJ6YjhH5YiX18w9pwzpVpGfpbl+8OKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778196993; c=relaxed/simple;
	bh=/x7c13v2p6Ep/kcFRC4rcQlkwEoB5Hp0x+ZFJh9UGwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=da8lT9E3X/yDBB9WzHSdcj89wwOyvwvVylYPNsRmhY+NsuLT39EkAXUNFZ1NbAYhwk0qj9KhwLJipJHgHCmfokzhVwsVJLrLoP7P7Fmq57z0VGRpd7ACXu9m/dDQaw0TaIhXoECay6QnxR3a0u/7Il03JsdVw06bmlqOFpsbLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bW9ylkNK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bW9ylkNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778196992; x=1809732992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/x7c13v2p6Ep/kcFRC4rcQlkwEoB5Hp0x+ZFJh9UGwc=;
  b=bW9ylkNKiHBXTUpYajmnhwD5Lg/V4s+bC1J6fRDgNissOKIBMhN8VfGs
   boxAtzkfnp6bHVEH1xyF66RcWqoQ+1h4nQqSr3Sg6j5hWpIUfReHU3VNZ
   UcXahEm49FeGSRYhJVqEqTD/fNLrIqLgeuH+hOUYB9YRh8Xl7/xSQ1cae
   I4x+2oa1DMRuxkj55I2XrQHUYvrds6VqgGsMTQ2W7u/Bk7/A3spZ+ANXp
   iHkVL863qRhwkQ9tZWW+ed1BUL2j1KX81EtnoIIAU1qkd7MBhuldEq5eZ
   jN57Pb9FQFhfMlNwWxTUoOp6BlX02nDtnp65WNHdl0NPwjRbTUNOsQkvC
   Q==;
X-CSE-ConnectionGUID: 5XuP0i4RQjianlki71lo2g==
X-CSE-MsgGUID: 5kN2h9k7RfSFMU0G1s/xPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90622704"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90622704"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:36:32 -0700
X-CSE-ConnectionGUID: 4pJptaSrTJCIIaPiAO8enQ==
X-CSE-MsgGUID: sg6FDLZIQs+8k+Ik9xMUSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="238401209"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.240]) ([10.125.110.240])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 16:36:31 -0700
Message-ID: <73b149b7-9af2-41c6-9ca3-1ff6bc3ece28@intel.com>
Date: Thu, 7 May 2026 16:36:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] cxl/test: Refactor platform device enumerations
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-4-dave.jiang@intel.com>
 <afrHW-6Rn9TEbwIj@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <afrHW-6Rn9TEbwIj@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 9:45 PM, Alison Schofield wrote:
> On Wed, Apr 22, 2026 at 04:02:33PM -0700, Dave Jiang wrote:
>> Split all the host bridges, rootports, upstream and downstream ports
>> enumerations to separate helper functions. This should make adding
>> type2 hierarchy easier later on.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  tools/testing/cxl/test/cxl.c | 327 +++++++++++++++++++++++------------
>>  1 file changed, 217 insertions(+), 110 deletions(-)
>>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 903223013e41..5fd73f0634c6 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
> 
> snip
> 
>> +static void cxl_usps_remove(void)
>> +{
>> +	for (int i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--) {
>> +		struct platform_device *pdev = cxl_switch_dport[i];
>> +
>> +		if (!pdev)
>> +			break;
>> +
>> +		platform_device_unregister(cxl_switch_dport[i]);
>> +	}
>> +}
> 
> snip
> 
> 
>> +
>> +static void cxl_dsps_remove(void)
>> +{
>> +	for (int i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--) {
>> +		struct platform_device *pdev = cxl_switch_uport[i];
>> +
>> +		if (!pdev)
>> +			break;
>> +
>> +		platform_device_unregister(cxl_switch_uport[i]);
>> +	}
>> +}
> 
> The bodies of cxl_usps_remove() and cxl_dsps_remove() appear swapped.
> ie the Usps one iterates the Dport and the Dsps one iterates the Uport.
> I think these above need a switcheroo, and then the call order below 
> needs reversing:

ok will fix

> 
>> +static void cxl_switches_remove(void)
>> +{
>> +	cxl_usps_remove();
>> +	cxl_dsps_remove();
>> +}
> 
> skip to end
> 
> 

