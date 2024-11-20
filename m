Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB113B7A3
	for <linux-cxl@vger.kernel.org>; Wed, 20 Nov 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127758; cv=none; b=Uc0heu8Rkyuhv1Lg352wL5k6oCu+X3K5ifKKhJKzt42bP7XsvF1hr3MCPtVqWpZWg0616hLSpxGVDhvgjEGeO1hxNHfAU4REFqkOGmIXVYbA6YBiJ6S/idQ9rwPfnDx9XRT7dF8sFooiel3ej48KtsxTuw6eEQ/5QKJPJniJpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127758; c=relaxed/simple;
	bh=sXLzpNr0qj49R/I2tUmMSXx2VHUP60cDT5xvSRbaSf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5UztS8wdNhqTsgimBFEZRt9z6MUToly/aHZ96qaak9ae6lTuXBJjNydiAM8z33UWN5w3cTy7BLx8WKE9ifU5rbXCgJjF1S597Ragr/UIrQOx9ImK8u8hqg4km4uGzWjcWfp5LtL0GoaWfYdoFT/rR1mVnMnPshlMrD9Wz5+D8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FB4K5MES; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FB4K5MES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732127756; x=1763663756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sXLzpNr0qj49R/I2tUmMSXx2VHUP60cDT5xvSRbaSf0=;
  b=FB4K5MESyyuvBasJo16/3s4+RePNc55rNr1oj7HXLDLoSJuNpz6nsVgo
   xaZi4aaeZtBM6dp7TDl5l6UfQar6jloTkJ5Jyf6LCi310raGemNLHkExb
   qtrynpHE1PfVJS8Gd6pOPd+3NT6eQPt+Xd6gcWmYDoQvutm3bqtHN0NKn
   qB5s0PMMfxOoY76OIyEOL4fMI+6NniDB4rOrnK3k0TWHFoYWh7xk4bblg
   JlIaBMjspMz+SsePMb7UtbTtnC4l2Zjf4+OiSWy9el9gFUI1oWQB8j9kD
   HtqPISv661vEnO4IOgiOzOC1hIvd3dZRZ9gO0SEVcT0f1vf7Bojcx3MdB
   g==;
X-CSE-ConnectionGUID: Cb+jxwOoTuemp00m+ZwhDQ==
X-CSE-MsgGUID: e/MftGCXQUqx4GEyS4r4gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="57603219"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="57603219"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 10:35:56 -0800
X-CSE-ConnectionGUID: iLuHi2jjTWON7xDCjq8kbw==
X-CSE-MsgGUID: jiGRzOmtSSiS3UVDG5c4zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="94817597"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO [10.125.109.160]) ([10.125.109.160])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 10:35:54 -0800
Message-ID: <6fcb774d-e594-48be-b17e-031dd4692a0c@intel.com>
Date: Wed, 20 Nov 2024 11:35:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 09/20] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, shiju.jose@huawei.com
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-10-dave.jiang@intel.com>
 <20241120180134.GB876522@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241120180134.GB876522@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/20/24 11:01 AM, Jason Gunthorpe wrote:
> On Fri, Nov 15, 2024 at 02:25:42PM -0700, Dave Jiang wrote:
>> @@ -1721,7 +1742,25 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>  	mutex_init(&cxl_mbox->mbox_mutex);
>>  	rcuwait_init(&cxl_mbox->mbox_wait);
>>  
>> -	return 0;
>> +	fwctl->cxl_mbox = cxl_mbox;
>> +	dev = &fwctl->dev;
>> +	device_initialize(dev);
>> +	device_set_pm_not_required(dev);
>> +	dev->parent = host;
>> +	dev->bus = &cxl_bus_type;
>> +	dev->type = &cxl_fwctl_type;
>> +
>> +	rc = device_add(dev);
>> +	if (rc)
>> +		goto err;
> 
> If you don't call dev_set_name(), don't you have to set dev->id to
> something unique?

Yep. I missed that and found it yesterday while testing.

> 
>> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
>> index e5ee2d46d431..e49903a9d0d3 100644
>> --- a/drivers/fwctl/Kconfig
>> +++ b/drivers/fwctl/Kconfig
>> @@ -19,5 +19,14 @@ config FWCTL_MLX5
>>  	  This will allow configuration and debug tools to work out of the box on
>>  	  mainstream kernel.
>>  
>> +	  If you don't know what to do here, say N.
>> +
>> +config FWCTL_CXL
>> +	tristate "CXL fwctl driver"
>> +	depends on CXL_BUS
>> +	help
>> +	  CXLCTL provides interface for the user process to access user allowed
>> +	  mailbox commands for CXL device.
>> +
>>  	  If you don't know what to do here, say N.
>>  endif
> 
> Keep sorted
> 

ok

>> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
>> index 1c535f694d7f..bd356e6f2e5a 100644
>> --- a/drivers/fwctl/Makefile
>> +++ b/drivers/fwctl/Makefile
>> @@ -1,5 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_FWCTL) += fwctl.o
>>  obj-$(CONFIG_FWCTL_MLX5) += mlx5/
>> +obj-$(CONFIG_FWCTL_CXL) += cxl/
> 
> Keep sorted

ok

> 
> Jason

