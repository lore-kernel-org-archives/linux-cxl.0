Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0C1CAB5
	for <linux-cxl@vger.kernel.org>; Mon, 22 Jul 2024 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684537; cv=none; b=QzwgzCII6fCE0Ssz7PXTpS8CJUeuQ9qQuJ2ffLifGDbx3TdDcasL9TRDuCLuuLf706U6h/2eCAuz33dcNethWuMa7kN8ufVTLjXFBnmnDxH56L3aDwE5KvCMKy/bj6speNkxGNWZJR168nVOocX7yp+fgAAn1jzROApdjbqJ8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684537; c=relaxed/simple;
	bh=3XT4TMHcGHo48P9GsevC6OJEgTXBJzE9oJF2WDWINw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YC3JLkus22wPgZxQe5yBiRfxGr2qdkItMJjhjHcm6MTsylfcjF3umw5oc6mubGU5M6JfopXWI69PRbSeEN4QKx55+fT7fftitGiwm/6cvi2eWrWe8paqXhmot5PiiblMg2I8p7iHd715GvnEDPKUYdm0bL5RpluXWMB0ci/9F0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5WiQO9y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5WiQO9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721684536; x=1753220536;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3XT4TMHcGHo48P9GsevC6OJEgTXBJzE9oJF2WDWINw8=;
  b=S5WiQO9y9gjsjBfTXK0sluHiwTEzzgu/UqYtnegKwqljuQ1+6s9qrdEX
   zIcmn4E244mA5iChTx8DU8PKpqXKuXRePUq8DNq8RIC1+1WFtW/ypl7pi
   uyBjbYXRXlC5yuY+IVUPKy5IbRsS8+s6v/H97zbyJGHRnmQcvBOTEKbZZ
   WGZxFBv35RcgOGsgtWI+Tp/AS3j+HQDQtDIMXJrtIhRAMC9PBxf7XEDXe
   9O9K0ULAw12DIHA2EWb6OcbvYB4dhEEemK7aE7XBXwEZ7k/ux6vrQUMU+
   32BooInaLJlTyix+TqCMBVisnKeGxUXu4Ptw2hmaPailcGIVHaiijFNC3
   Q==;
X-CSE-ConnectionGUID: MdNGY6biRr6MMcjm0x3poA==
X-CSE-MsgGUID: XJqikSALQu2Fi10/aJ7e4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="23149727"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="23149727"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:42:15 -0700
X-CSE-ConnectionGUID: i0xuohBeQdygntKkNVGVXw==
X-CSE-MsgGUID: TY0rKlIJRC2pegy7H4N7+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51903414"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.188]) ([10.125.109.188])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:42:14 -0700
Message-ID: <bed7cc94-559e-4843-8215-8ad528804e15@intel.com>
Date: Mon, 22 Jul 2024 14:42:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/13] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-9-dave.jiang@intel.com>
 <20240722153104.GE3371438@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240722153104.GE3371438@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/22/24 8:31 AM, Jason Gunthorpe wrote:
> On Thu, Jul 18, 2024 at 02:32:26PM -0700, Dave Jiang wrote:
> 
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 9f0fe698414d..0f6ec85ef9c4 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -13,6 +13,8 @@
>>  
>>  static DECLARE_RWSEM(cxl_memdev_rwsem);
>>  
>> +#define CXL_ADEV_NAME "fwctl-cxl"
>> +
> 
> This should be in a header?

yes. will fix.

> 
>> @@ -1056,11 +1059,27 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>  	if (rc)
>>  		goto err;
>>  
>> +	adev = &cxlds->cxl_mbox.adev;
>> +	adev->id = cxlmd->id;
>> +	adev->name = CXL_ADEV_NAME;
>> +	adev->dev.parent = dev;
> 
> It goes there
> 
>> +static const struct auxiliary_device_id cxlctl_id_table[] = {
>> +	{ .name = "CXL.fwctl", },
>> +	{},
> 
> But then how does this match work? Shouldn't it be CXL_ADEV_NAME ?

Yes will fix.

> 
> Jason
