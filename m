Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E102166308
	for <linux-cxl@vger.kernel.org>; Thu, 26 Sep 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382368; cv=none; b=cgadODWYcKCOlZgvEyYNOPRaMA9b2c1Mur4tmsX3NrQm7dLsCp//ax8oAsyDlPQ1aFvRKRfF39Ke2zcED5kvxPNlz9X0AyOxQMYQhTaXfnqRy4ybUYqMEA1ylhIRRtgm3Ape9Zn+iIBaK+p8SeCjitQXBMXEZCmhNG/8EJL3U/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382368; c=relaxed/simple;
	bh=mCPB2JGL203N6hPd2/PcHtie9K0HKstrghNUjatBfeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGUmitwzyhCxqwCTa/Jc7Y1cXPCvsBOrvkQJy6DrZSN3KmgN0w9NL6F5l166X19eZgEN0ZVupfXeIJmqh3F3p4/CRz8hpS7kxo3mB+rLwpHZ2AEckLTZShzVlveGd+oTQAAp/4Kb1/UzJ+hmx2a9mxqX4DWlaeSpJjl5cwpTslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnJCTqSS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnJCTqSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727382365; x=1758918365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mCPB2JGL203N6hPd2/PcHtie9K0HKstrghNUjatBfeQ=;
  b=KnJCTqSS6xRPgCiu5kha5pPS5AvUtMkFrhjbDsE7UBtc9V8wWQB1/oJP
   Ir6CDBIUCy42hsZvPNwQchDkYVDFDUvpvXySwwqX4kYmbrZN2p4ae7FT4
   cOQl9nT3a7X5j6TJkZJRHnX93eaAWr9xE5biPMJA4ARx0PZlaC091vH69
   7JS8BOZox4FwYsGgEccvL/RdCJ9iKmm898Rtq6y1z9BYX3fYHUxeb36Av
   9GvPssFCtmYtdSK2xbM2MiJ6TW22LhkY4KkS5JiZELjH2jC0ZgOx1y7J4
   dah9FJcOW95MMiOtsSrQ16Ss/tfeu1lRbx2xlkYAjkQjFXz+NkGjNRsRg
   g==;
X-CSE-ConnectionGUID: 8+nzmQxFTji9oVQUckxnNw==
X-CSE-MsgGUID: PQr0/ZxnSQ+NmwiYfJVypg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="51926463"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="51926463"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 13:26:04 -0700
X-CSE-ConnectionGUID: XtEeeFuXSgqGcqOzxSTN0Q==
X-CSE-MsgGUID: CL26gL0dRQOYDFxcT9LyuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="71967968"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.194]) ([10.125.111.194])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 13:26:03 -0700
Message-ID: <42cc0e18-0cfb-4ce6-8c67-13700502c24a@intel.com>
Date: Thu, 26 Sep 2024 13:26:02 -0700
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
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-9-dave.jiang@intel.com>
 <20240726190257.00003a60@Huawei.com>
 <f57c9889-450f-40de-a3be-55c1fa5d7eaa@intel.com>
 <20240926173718.GD9417@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240926173718.GD9417@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/26/24 10:37 AM, Jason Gunthorpe wrote:
> On Tue, Sep 24, 2024 at 04:44:19PM -0700, Dave Jiang wrote:
> 
>>>> @@ -1030,6 +1032,7 @@ static const struct file_operations cxl_memdev_fops = {
>>>>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>>>  				       struct cxl_dev_state *cxlds)
>>>>  {
>>>> +	struct auxiliary_device *adev;
>>>
>>> Why an auxdev? It can be any convienient dev to which a driver
>>> will bind. Why not spin one on the CXL bus for this purpose?
> 
> IMHO bus members should adhere to some kinds of rules about the bus
> itself. Devices should have the same set of paramters/etc. I don't
> know what cxl_bus is, but I'd be surprised that something with that
> name has SW only entities on it as devices??

So I did do the conversion yesterday and it ended up looking something like this [1]. cxl_bus has cxl objects that are hardware representations (endpoints, ports, decoders, pmu, etc) or software representations (regions). So it's probably ok to keep all the cxl stuff on the same bus. I don't have a strong feeling on whether use cxl bus that already exists or using aux bus. 

> 
> aux bus was specifically for SW only entities that are just for
> linking software components.
> 
> Jason

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?h=cxl/fwctl&id=231da137a959331cc5bc80ef4acb3d7e667bfbad

