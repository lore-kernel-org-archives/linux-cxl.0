Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF61D8A10;
	Thu, 13 Mar 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904843; cv=none; b=fTuOwuhJ195IDLU2onHAmykILmNKk+Q9AMGV0+BfQLJtc4s5BaWaIA9cYXGRbqBxKsfvIMlZu6jtXynlm0H2i9kxywgTNdhP/P5+LDd2jcCNgHJ0XgJmGHcZRpM8lC8Qs6tz6klsGtsxq2bht8ITXcjvA+Ad/5VigI8hSpfh8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904843; c=relaxed/simple;
	bh=oqMznX9Nd36QyVtbCLNhEMH/gemQ9Km8Eei7KAjhxC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWB86KPKGTmTdYwI7eytEHlC3YQYHs5QmP6pPht8X2xwppu9niRm72inYJ4m/iXXKwfIsMCVXXNpjTy+VAmcG/7LPc0a/paDCNlzW5QUrS/9PuNvn13WdD6sJmhH9gP66/U1TTHUkAhrGoWBhJDZd9zT7TxEQ6jxaa6sl5W+fJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVsz8wcN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVsz8wcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741904842; x=1773440842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oqMznX9Nd36QyVtbCLNhEMH/gemQ9Km8Eei7KAjhxC0=;
  b=YVsz8wcNFG8rSziNXv7p9YgrEqzjbGx4WJW0H+NvZyUdF0sPEHJGNJuJ
   KxVSN/miN2jwtgDmu77SHi7tkgnZK+RPQPRyV1BVhwnYcYlFtgeYLQsSO
   cD9chxC7CJBS8L42vDAsxR3Ygrf1t9RiMYtHyJp4V28zkLZz525J8JBB7
   kn+EGm6Ft676yGMuMQdW9qz0HZxGg9quGAdoAOs4TIGXRCDB1pia2rhBt
   ADORp4gbILsSiCctkLzSSJbUyeDVve8c1UN7AW5qsvJjdJrLqzodi95rv
   Wbai7Cs5pwwWaz/VRWYmphuS7lRxOkqd37WTdP9fce2PNgGisn8QoLMLN
   g==;
X-CSE-ConnectionGUID: iDImOkpcTwSlU3LubxpFgw==
X-CSE-MsgGUID: LkPRswgbRCqL1yf2m+038g==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53252577"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53252577"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:27:21 -0700
X-CSE-ConnectionGUID: HUmAPeRjTqOMgxyfZS0kcQ==
X-CSE-MsgGUID: gRdjlx2oS0uGP+mByYzGgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121591133"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.86]) ([10.125.108.86])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:27:19 -0700
Message-ID: <b2bb61f0-6250-4b90-a765-c2873eccb07d@intel.com>
Date: Thu, 13 Mar 2025 15:27:18 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: Add Null check for adev
To: Alison Schofield <alison.schofield@intel.com>,
 Chenyuan Yang <chenyuan0y@gmail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250313190753.450546-1-chenyuan0y@gmail.com>
 <Z9NWdob3CSy9UDq5@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z9NWdob3CSy9UDq5@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/25 3:04 PM, Alison Schofield wrote:
> On Thu, Mar 13, 2025 at 02:07:53PM -0500, Chenyuan Yang wrote:
>> Not all devices have an ACPI companion fwnode, so adev might be NULL.
>> This is similar to the commit cd2fd6eab480
>> ("platform/x86: int3472: Check for adev == NULL").
>>
>> Add a check for adev not being set and return -ENODEV in that case to
>> avoid a possible NULL pointer deref in cxl_acpi_probe().
>>
> 
> Avoiding the NULL ptr deref seems obvious as ACPI_COMPANION() return
> is routinely checked throughout the kernel. Why the reference to the
> other commit? Do these devices have something in common?
> 
> I'm curious as to when *this* specific adev can be NULL.

You get a NULL by either the the platform device being probed is not setup correctly and the fwnode end up failing is_acpi_device_node() or CONFIG_ACPI is not set. The second is impossible as cxl_acpi depends on CONFIG_CXL_ACPI which
depends on CONFIG_ACPI. The likelihood of the first I don't think is high unless the platform device for ACPI0017 is corrupted. So in this instance in the probe function, the checking while is fine for code correctness, may not be absolutely necessary perhaps. Just my 2 cents.

DJ

> 
> Looks good to check it like you do here, or if someone chimes in that
> it can never be NULL, just add a code comment saying so.
> 
> Perhaps emit a message on NULL too.
> 
> 
> 
>> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
>> ---
>>  drivers/cxl/acpi.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index cb14829bb9be..9195001db3c1 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -823,6 +823,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>>  	struct acpi_device *adev = ACPI_COMPANION(host);
>>  	struct cxl_cfmws_context ctx;
>>  
>> +	if (!adev)
>> +		return -ENODEV;
>> +
>>  	device_lock_set_class(&pdev->dev, &cxl_root_key);
>>  	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
>>  				      &pdev->dev);
>> -- 
>> 2.34.1
>>

