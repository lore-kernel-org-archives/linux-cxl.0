Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646032877CB
	for <linux-cxl@vger.kernel.org>; Mon,  7 Jul 2025 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751931559; cv=none; b=EJsffRxxoCKCLFPfJYolkHwWuDX5SUWYVbqgZUvAkeal+Kp0uvNJwShCjjwH+8Rp7JlQ2zlTO15PjoKZRZRwfahdC6sncXoIJg3WwJ1XuNH/EVN+j1bWMG+nT81olJowqzmMef/+pc1AvZkBYJIq/a7reH6IRNZKM1wdAApECtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751931559; c=relaxed/simple;
	bh=do8Yvnsp+oHgmg88+qWsAG4XcEfsI7/3lZh/qBhZpcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUGi7yVT+b/sp6Ev1OiVFQ7wHTeK1jJbCAvP0n0iuYVIml8G1dIDzYv5Ftp7Zc34TzqQ+YWfUOM5yedoJNQhsmnrL/5c7uFYx4gdn+N+TKtuLs07ci2zBizR7P01sA/NhwMVNvzz389tSz7bK9Tdj1Wrl9u8lxtDN9ntvOu6YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLLcEj/M; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLLcEj/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751931557; x=1783467557;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=do8Yvnsp+oHgmg88+qWsAG4XcEfsI7/3lZh/qBhZpcc=;
  b=YLLcEj/Mo9ViH3zCGz7bsT9zgtr8yqUi+CpNz1IzGEqzTt216MzmCnrY
   +4+QHRiMvkBDftN/E5IYeF8BcwvfZcvt6+fAz6GbXekxac0GYsELYkJUo
   hvsMFHY+HW2pe4VMjFXn1+ux4YV7uVkF3eofTZtkjs0FKrU6KORNMSWJJ
   JU+9gOlrxlMEzcfjZu+TBzf2mgbApQQrn2MfkkR42sDPMTFOuepOr/ggc
   vLTDhs5MHo8LBZ896kXwwzsmweherk7CTXD/sS8ivYUfSJHjWGo04Y+fZ
   KKt6vspzImraZLewd5j9c9AGvN2ViMjdzQD6b4O/gJYgdU+5ji1cR4OXx
   g==;
X-CSE-ConnectionGUID: 0dePsvr1TKe31pMW+Cx49A==
X-CSE-MsgGUID: fqlt69rrTya6TN6o8umVJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65223694"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="65223694"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 16:39:16 -0700
X-CSE-ConnectionGUID: kX4HQy3ISjq12dXGtKPIgg==
X-CSE-MsgGUID: GWiTHwQJSzaJ8UvhmyvP0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159680453"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.125]) ([10.125.110.125])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 16:39:17 -0700
Message-ID: <c06a8221-32e9-4271-9036-2c9f50be3c7e@intel.com>
Date: Mon, 7 Jul 2025 16:39:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] cxl: Move enumeration of hostbridge ports to the
 memdev probe path
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250703232710.3141436-1-dave.jiang@intel.com>
 <20250703232710.3141436-10-dave.jiang@intel.com>
 <20250704110741.00006737@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250704110741.00006737@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/4/25 3:07 AM, Jonathan Cameron wrote:
> On Thu, 3 Jul 2025 16:27:09 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Current enuemration scheme in cxl_acpi module creates the ports under the
>> root port by enumerating the hostbridges after the dports under the root
>> port is created. However error messages "cxl portN: Couldn't locate the
>> CXL.cache and CXL.mem capability array header" is observed when certain
>> platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
>> probe is running before the CXL link between the endpoint device and the
>> RP is established, then the platform may not have exposed DVSEC ID 3 and/or
>> DVSEC ID 7 blocks which will trigger the error message. This behavior
>> is defined by the spec and not a hardware quirk.
>>
>> Setup an association in cxl_port to tie the host bridge device to the
>> associated cxl_root. The cxl_root provides a callback that's setup
>> by the cxl_acpi probe function in order to create a port per host bridge
>> that was previously done during cxl_acpi probe. Add the calling of the
>> callback in devm_cxl_enumerate_ports(). The observed behavior is that
>> ports that are not connected to endpoint device(s) are no longer
>> enumerated. This should also remove any excessive noise of port probe
>> failing on those inactive ports.
>>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v5:
>> - Updated with new devm_cxl_port_add_dport() and friends.
> Hi Dave,
> 
> One of the bits of code that I was confused by in the patch that
> added devm_cxl_port_add_dport() goes away in here. I'm not
> sure why.
> 
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 1089fce24293..c624f4801b68 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1789,14 +1789,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  
>>  		guard(device)(&port->dev);
>>  		new_dport = devm_cxl_port_add_dport(port, dport_dev);
>> -		if (IS_ERR(new_dport)) {
>> -			if (PTR_ERR(new_dport) != -EEXIST)
>> -				return PTR_ERR(new_dport);
> 
> Interesting. Is this in the wrong patch?

Shouldn't have been deleted to begin with.

DJ

> 
>> -
>> -			new_dport = cxl_find_dport_by_dev(port, dport_dev);
>> -			if (!new_dport)
>> -				return -ENODEV;
>> -		}
>> +		if (IS_ERR(new_dport))
>> +			return PTR_ERR(new_dport);
>>  
>>  		dport = new_dport;
>>  	}
> 
>> +static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
>> +{
>> +	struct device *hb_uport_dev, *hb_dport_dev;
>> +	struct cxl_dport *dport;
>> +	int rc;
>> +
>> +	rc = get_hostbridge_port_devices(cxlmd, &hb_uport_dev, &hb_dport_dev);
>> +	if (rc)
>> +		return -ENODEV;
>> +
>> +	struct cxl_root *cxl_root __free(put_cxl_root) =
>> +		cxl_hb_uport_dev_to_root(hb_uport_dev);
>> +	if (!cxl_root)
>> +		return -ENODEV;
>> +
>> +	guard(device)(&cxl_root->port.dev);
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		find_cxl_port(hb_dport_dev, &dport);
>> +	if (!port)
>> +		port = find_cxl_port_by_uport(hb_uport_dev);
>> +
>> +	/* Port already established, add the associated dport if needed. */
>> +	if (port) {
>> +		if (dport)
>> +			return 0;
> 
> The sequence I badly explained on v4 still bothers me here as I think
> it might be possible to hit that if (dport) with dport never initialized.
> Even if it isn't, I'd be surprised if the compiler / static analysis can
> see that there is no such path.  So if we think it can't happen, just initialize
> dport at declaration. If it can happen, I think it being null is still the
> right answer, but maybe I'm missing something.
> 
> 
>> +
>> +		guard(device)(&port->dev);
>> +		dport = devm_cxl_port_add_dport(port, hb_dport_dev);
>> +		if (IS_ERR(dport)) {
>> +			dev_dbg(&cxlmd->dev,
>> +				"failed to add dport %s to port %s: %ld\n",
>> +				dev_name(hb_dport_dev), dev_name(&port->dev),
>> +				PTR_ERR(dport));
>> +			return PTR_ERR(dport);
>> +		}
>> +		return 0;
>> +	}
> 

