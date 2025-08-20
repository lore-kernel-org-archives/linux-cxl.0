Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCFC7FBAC
	for <linux-cxl@vger.kernel.org>; Wed, 20 Aug 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703217; cv=none; b=SRG18WHOutdcuEwmeUE5XxOpZBxsVWONYOb91fPKrnuD2u56dBnJngfItWG+GytIuXOwBtFAE0eGlzZASTxdkV4Vb7B7kOmQoJc25UOE98CmQm4lJiL4dkWpjWRHGPFXXce8TX7v/DtWVPzOJObh6WvwRB0rmRSGQGiB3PIl214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703217; c=relaxed/simple;
	bh=ddx0oTzZilocsUMjXXXwyxha3gV+4FJ7ylkKWWwUsvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKE+HBsbyvfWjS62raBdnhyudE20rDcNfFG/PUMcEsQEql8wzGuz2QdPuACLhEwWjyl1g6023qmyzutcaZfkleiFD4e4Ty74roDU7/8mtloWu3FaYUPW//mtrAQDT0/RaTs83X6zpWczo1tiM6YTrUZxMSG0vAdou9CadOUokAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InOkdeM/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InOkdeM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755703216; x=1787239216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ddx0oTzZilocsUMjXXXwyxha3gV+4FJ7ylkKWWwUsvY=;
  b=InOkdeM/guyKqtPJpK0GJ4/Nwq+TYGE4o7fH7kNmR76wnftus2AZlhl1
   M2x5TUHqyv9okqJJsRemzPQTD72D49tl2Odoztq6Soap5QpnFLefsVsm+
   Qa+HIwEbh8jNyjtGsVUG0XrZKn23sB7Wwq08xOSEhHclMdpDAZVQvLQ8T
   8Hq0CYE6yBp1CQXnsGomD95acVVCgs4xEt45+9w94yRmqZDnas71G7O7b
   Ah7HkHkCEqJ/kOo3Kyp7KRyUtmBMX+Qmt2Ep6NTBp3NCSV00jqDcLClFU
   StwDJ+2ZT/YXJOnu3hoRkC0pqtqDKuXYoRFgQtLyiIdFlGF0RndljOhZf
   w==;
X-CSE-ConnectionGUID: VhpHpuynQeCF+hemrA3ewA==
X-CSE-MsgGUID: 3RIy2BJdQrmc2sX9EWd58Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58120521"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="58120521"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:20:14 -0700
X-CSE-ConnectionGUID: RybuoviNQT2T1sNc0MsyBw==
X-CSE-MsgGUID: aa/iqO1LQ/G7U+ZOLdhjzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172383421"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.205]) ([10.247.119.205])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:20:09 -0700
Message-ID: <a5eeaa15-9ef7-4b9a-88dc-10de9f1cb551@intel.com>
Date: Wed, 20 Aug 2025 08:20:04 -0700
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
 
>> +	if (IS_ERR(new_dport))
>> +		return new_dport;
>> +
>> +	cxl_switch_parse_cdat(port);
>> +
>> +	/*
>> +	 * First instance of dport appearing, need to setup the port, including
>> +	 * allocating decoders.
>> +	 */
>> +	if (port->nr_dports == 1) {
>> +		rc = cxl_switch_port_setup(port);
> 
> Can't this be done with port creation? I don't see a reason doing this
> late at this point.

The main reason we are doing this is to move the port register probing until we know the CXL link is established. Otherwise when cxl_acpi does probe and calls add_host_bridge_uport(), that devm_cxl_add_port() can trigger errors if the platform BIOS enables PCI hotplug support on Intel platforms. The error messages "cxl portN: Couldn't locate the CXL.cache and CXL.mem capability array header" is observed. Essentially we can be trying to map registers while DVSEC ID 3 and/or 7 has not appeared yet. And in turn because that got pushed out, so did the decoder enumeration. 


