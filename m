Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B42BE65F
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954983; cv=none; b=DAFtT+n4ybJNbRMRWWeURy009DqBMc9cb4WZ3pMB9gZognswDk8YEFyHdaqqRrzluhcYyz9nIQhMHhRspyRRiA+P6bCAcv50qxuRlF8/Bne0U2RtN6sKFRHKAEyHdjdCYtb8eS+CE6Gq3LjGlZML0gYQm7Ex6oIB+0BEbiikEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954983; c=relaxed/simple;
	bh=F2UPI+NDD+7DAZF71eH9F5AAZ3YNKEkBbyCuPmTeAXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/FpjiTZMvXasdRB/qzInKAILKj15K5CCL7d0q5qiMg7+R+WDaNUmhUftq80ncrW7tYBV70yLV8KRQbO7KJY0UBsUpUXCdakqhPT5W/PdN5sirNZXF8l05qxajoxcNge8gAz5Sis4V3EpKJx+9/AuNLW3cHboBD1nYliyCyjkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1DMDk/f; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1DMDk/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776954981; x=1808490981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F2UPI+NDD+7DAZF71eH9F5AAZ3YNKEkBbyCuPmTeAXQ=;
  b=g1DMDk/fOMKpm3n/p5VC+XOz5u2mhOiz6B/EapJ3rgsQWMQVl0jZ2cE8
   TVDrnjkF+gRiyn/SqCxTG9Z/9H11IaOZojp9syXxadmM6vStYbOTp0pWg
   WWhbLjHZDSy49kg/C0TWl6mDr2bcMEK1cxcZYDSN1cW6ROPbP9mOnNYT5
   juIlvLk5MG3qWEb5wPtOuaw1vU1yxZfu01GIQSR5IHX+0asCpO9z2yyOO
   HyJnC8be5VVIAJfzK8jnQWBsNd0L38VAcUip3SEpfgsSuAslny4SzvYlg
   LwciF6/mZb5jU9+eCskImS11I05tNblWlEgai1d7vKB4AnvxcN+FEy4E6
   A==;
X-CSE-ConnectionGUID: CEcgx5hvQeCUpUkWOJBrfA==
X-CSE-MsgGUID: 0ZjyM3McQXqUYzH/if7Htg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="103386890"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="103386890"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 07:36:21 -0700
X-CSE-ConnectionGUID: ic0VaJ6ETw2uhwqZyNnXTg==
X-CSE-MsgGUID: IQiiOqYTRtq+wXSon0tUcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="226148347"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.12]) ([10.125.108.12])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 07:36:18 -0700
Message-ID: <0a2b55cf-7df4-42e9-86b9-c5422a802085@intel.com>
Date: Thu, 23 Apr 2026 07:36:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] cxl: Fix double unregistration of CXL regions for
 type2 devices
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-8-dave.jiang@intel.com>
 <e0806e00-f727-4399-ab40-f10fbf881662@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <e0806e00-f727-4399-ab40-f10fbf881662@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/23/26 12:10 AM, Alejandro Lucero Palau wrote:
> 
> On 4/23/26 00:02, Dave Jiang wrote:
>> For a type2 device cxl_memdev_attach_region() is provided as the callback
>> to devm_cxl_add_memdev() call. In cxl_memdev_attach_region() a devm
>> action cxl_endpoint_region_autoremove() is registered to remove the
>> region when the device is removed. And this action calls
>> unregister_region() on trigger.
>>
>> When the endpoint port driver is probed, discover_region() is called
>> to register a region. The call tree becomes discover_region() ->
>> cxl_add_to_region() -> construct_region() -> __create_region() ->
>> devm_cxl_add_region(). In devm_cxl_add_region(), unregister_region()
>> is also added as a devm action.
>>
>> When removing the cxl_test module, the platform devices are removed
>> and that triggers the endpoint driver removal and calling of
>> unregister_region(). And then when the mock type2 device driver is being
>> removed, the devm action of unregister_region() is called again, which
>> causes a kernel warning about double unregistration of the same region.
>> Add a check to see if the devm action is already removed before calling
>> unregister_region() for cxl_endpoint_region_autoremove().
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> - Need to add a fixes tag when the patch commit that introduces
>>    cxl_endpoint_region_autoremove() is stable.
>> ---
>>   drivers/cxl/core/region.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 61a3efdbf3c9..1a7c0895bb88 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -4296,7 +4296,8 @@ static void cxl_endpoint_region_autoremove(void *_cxlr)
>>       struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>>       struct cxl_port *port = cxlrd_to_port(cxlrd);
>>   -    devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +    if (!devm_remove_action_nowarn(port->uport_dev, unregister_region, cxlr))
>> +        unregister_region(cxlr);
>>   }
>>     /*
> 
> 
> Hi Dave,
> 
> 
> Yes, I saw that problem and reported to Dan:
> 
> 
> https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#m467dc88199645865a05b5fef858a67f3a608895b
> 
> 
> I thought about adding similar check in my impending v26 but I ended up changing the linking of the created region from the root port to the endpoint device only. This avoids the problem you report for the cases of removing cxl_acpi before accelerator driver or cxl_mem unbinding the accelerator memdev.
> 
> 
> You will see that later today within v26.
> 

Thanks. This series will adapt to whatever the final resulting version we merge upstream.
> 
> Thank you.
> 

