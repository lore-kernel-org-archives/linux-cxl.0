Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7E2BD04
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229551; cv=none; b=rYSEtyC7T0c83uJEtieV7FXkj7nqQ0WNxj79aFvTE3L1ffz5+bS5M053gi5RPkTpHGijrmEEVEOxeK4cLD8vkonQ8DEG+Lf2Zf/RvXtAQPSl2R7IZhxRylj82ohIZqKV0BS9yFCk55tRYytrZpeXcgrcDta2XRci1u5VRAe1XE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229551; c=relaxed/simple;
	bh=6xQiHr7WwX7T0wpnLCEYBSjEhDGJpL6a70zsiVlg16M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoPrEdj5mL/Ej9Jyzxxmh6tO7htXsJ1g2gq0cEXiBsRpctEhBtdcdoxuMDY1yEpcXWwvrGKByRCc0tnkT9q5ug63psGHtY6DjC8akH0DOnvdxmwDPRi2Sg/IMt+qMQvUqBakkiuocsDbU3JZ3poM1+u4MfRsfAwq9x7Rc74eSiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ys7m1Kq/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ys7m1Kq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758229550; x=1789765550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6xQiHr7WwX7T0wpnLCEYBSjEhDGJpL6a70zsiVlg16M=;
  b=Ys7m1Kq/Fefc3LQAB2yAxqXormOECnCuspsw/ui4G2L9kJBYqysEcsXG
   V5KzYVPRCmW7kj7RexnQVsxIVkI4j3oWQRh2BVgVm+6rI7KmlJr+5QcxP
   huYy1fhpLPupXV19CRp4WKr7D/S+6TiZBTIJMWwJJHIVENU5AGXmHJNZ6
   m8Wkm0jiwGKtPHj5AXuwIZL+cw6sZTDq9yOdlxmwc9PFYpYR3HRNW2OWq
   0zAYvU77IK61XJ9mPXBAzMRvio5qQP1lSyg9XJlVyMdDrudwiIxluFKF2
   UEBxtwzJFnmQvmmAASAmQvQQk54H6V36I8XKQHetCOeXQlwWwBNZ5AHuC
   Q==;
X-CSE-ConnectionGUID: 5QY7KNcySkaM/JgZQXmeKQ==
X-CSE-MsgGUID: R69Dm1TARQOZjute9vn5sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60639861"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="60639861"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:05:49 -0700
X-CSE-ConnectionGUID: R4AKF+fKRm2rxRSthiLs/A==
X-CSE-MsgGUID: lnTsUNsBRgydk8v+BcFfAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="180939798"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.28]) ([10.125.108.28])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:05:48 -0700
Message-ID: <b928abb5-17bb-4c6c-863c-5f32db3b07d5@intel.com>
Date: Thu, 18 Sep 2025 14:05:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Move port register setup to when first dport appear
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>
References: <20250911204406.2454689-1-dave.jiang@intel.com>
 <68cc5df08dbe3_18f197294e6@iweiny-mobl.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <68cc5df08dbe3_18f197294e6@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 12:30 PM, Ira Weiny wrote:
> Dave Jiang wrote:
> 
> [snip]
> 
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 76dd06d282df..416d45516d82 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -867,9 +867,7 @@ static int cxl_port_add(struct cxl_port *port,
>>  		if (rc)
>>  			return rc;
>>  
>> -		rc = cxl_port_setup_regs(port, component_reg_phys);
>> -		if (rc)
>> -			return rc;
>> +		port->component_reg_phys = component_reg_phys;
>>  	} else {
>>  		rc = dev_set_name(dev, "root%d", port->id);
>>  		if (rc)
>> @@ -1200,6 +1198,18 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  
>>  	cxl_debugfs_create_dport_dir(dport);
>>  
>> +	/*
>> +	 * Setup port register if this is the first dport showed up. Having
>> +	 * a dport also means that there is at least 1 active link.
>> +	 */
>> +	if (port->nr_dports == 1 &&
>> +	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> 
> Should this be
> 	    port->component_reg_phys == CXL_RESOURCE_NONE) {
> 	                             ^^
> ?
> 
> to match with 
> 
>         /* Note: endpoint port component registers are derived from @cxlds */
>         endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
>                                      parent_dport);
> 
> in the memdev probe path?


No. port->component_reg_phys gets set in cxl_port_add(). So by the time the first dport shows up, we are using it to setup the register and then setting that back to CXL_RESOURCE_NONE. So therefore the port probe happens when it's the first dport and port->component_reg_phys is a valid address. 
 
> 
> Ira
> 
> [snip]

