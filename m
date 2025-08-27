Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064B22FF37
	for <linux-cxl@vger.kernel.org>; Wed, 27 Aug 2025 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330690; cv=none; b=eow1RMDQESfBSufykbyrx6qOfZequOlDcPn3X8A8CJT+vXXXfWisLSU7ljsQXypmb65dT3HbqxD55SdTNmWqdvKGVvl1AFZ7neeY1rs7ORc+lmxigppvk1guIJw5GUAH8ANwLmI/PIY4Qu55hqUu6H3NASwg6r29KU2IylcssnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330690; c=relaxed/simple;
	bh=wlyqOMcjpt2ERCtv1Gf0lgDZdIipMUQOlhUwECV15RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRFjrzg885U3jR04naHoc62lFyGQQdEULT+5qavGpDQzIH7SguQnH94O/KzNljMHs1Wbg5t5ud0y6qk0yc3Oaw4mYO9t8iTu04E/LQPnBJd+cXNR6Hz6kpvemt2V/phDT3Zwx5Xou3tP3FFZRAWnC2n7bFSRctgWTDfWC50x71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4Pp5HFF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4Pp5HFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756330689; x=1787866689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wlyqOMcjpt2ERCtv1Gf0lgDZdIipMUQOlhUwECV15RQ=;
  b=R4Pp5HFFe286nZFA5V1sp0RdafBhq9RqgDmk2FLnzYalFuvN8BCFqKqN
   RfMoScQBvkP6tBHvKeMlfvMeirrtei49HCSfctmsXvPxkY2QocT+IeKFb
   /3U2OzlyqTCCyXYEg13yTzoaGo603t9MZ4mNutSjj7WSK1kj88/PdhFN7
   HHCHTpO+eQ7KN6i/A9xeXHQUZW0Mr6KyH0aWZ+TxT2hb3vgVwI/lmoRBO
   DmAgS6/yMv5OcGHamcClH+rHA3Kz4aG5s6EECQDwIMtIeFyaQ1A2S+Qr9
   9RMKlVlXpEVqf5/c2YJFVHIhJ916FmSPPLkEGRrwA6mh8UId6CNDXoJW6
   g==;
X-CSE-ConnectionGUID: /4p/Ay5bRJqmLZ9W3Kp/rA==
X-CSE-MsgGUID: pxr+xu1AS46h3mhAoJ2NuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69185490"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69185490"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 14:38:08 -0700
X-CSE-ConnectionGUID: hil0m27sRp6l5BJl8OIXCg==
X-CSE-MsgGUID: 9e9iqc5ATquShv0Psddr7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="193592414"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.29]) ([10.247.118.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 14:38:04 -0700
Message-ID: <995a8f10-f576-4cd8-8d82-b9a575b45789@intel.com>
Date: Wed, 27 Aug 2025 14:37:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/11] cxl: Defer dport allocation for switch ports
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-6-dave.jiang@intel.com>
 <aKXCid-m65ou2WVV@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aKXCid-m65ou2WVV@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 5:41 AM, Robert Richter wrote:
> Hi Dave,
> 
> see my comments below.
> 
> On 14.08.25 15:21:45, Dave Jiang wrote:

<--snip-->

>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index cee68bbc7ff6..5263e9eba7d0 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -52,8 +52,6 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
>>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>>  {
>>  	struct cxl_switch_decoder *cxlsd;
>> -	struct cxl_dport *dport = NULL;
>> -	unsigned long index;
>>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>>  
>>  	/*
>> @@ -69,10 +67,6 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>>  
>>  	device_lock_assert(&port->dev);
>>  
>> -	xa_for_each(&port->dports, index, dport)
>> -		break;
>> -	cxlsd->cxld.target_map[0] = dport->port_id;
>> -
> 
> The change of initialization of cxlsd->cxld.target_map[] could have
> been a separate patch to reduce size of this patch.

It doesn't look like it because the dport init changes need to happen first. So the target_map changes can only happen after the dport changes. But they also need to be part of the dport changes to not break things when git bisect is done. 
