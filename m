Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281810A2B
	for <linux-cxl@vger.kernel.org>; Tue,  5 Mar 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678225; cv=none; b=Ed5978/hT30RdQweZvTzYAU/TLXDYa8FjoYA1rfij2BepDj02YTTQ9OHB7KnKZlNoAiJpLeiiOE1+oGswVVj1hNxkvjAyd8hy6eLb3pVvpGtT8Jbp3ZBqsH66KOPmhCm14maspQe0Fa9V8ZUZplRWE5NeL9SBjj4bPdNeht2y8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678225; c=relaxed/simple;
	bh=tGLacXX2rwbvXv5KhQD6uC9vs0co/KtRpLwB0LrNLeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2Abxw2HNs2OD78CYSCaZjTb6dqDre6wkY6O5Q26y6YMI/mPziLsgpbTySJFLhmwCaYPWNYh+H5hwo+uU+rYc3eEu4POt8LRX9eASbC5CxQMP1TLtWhLNFLmb/FZNR6hCTKl1vHqszYUUNXFNGBl8+59/cV2w9dbaZd6WMWJHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lr4WzDV6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lr4WzDV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709678224; x=1741214224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGLacXX2rwbvXv5KhQD6uC9vs0co/KtRpLwB0LrNLeo=;
  b=Lr4WzDV6YEVddv4cXDR0vzkWa6mhLWxmwFBpct/gPlM1qvq97Em7fDqX
   h7YFgBL/fT99tqpVvh6Lw8djZJrSO1jqcwRnR5peVm6ozxKjYXggzCIKV
   BZZWxhK769FNTmXcu6mGQa6PdS4O1Jcg4lTae80Se7i4sMBL6LX8ntRFw
   nyIt1eUBlgizP2peNt10hYn0MTXb4V5eXYNbEmP/wXWNSOTXYXMaTlcIt
   11yeI70yC/y3qFEY4bATZFOr6WCeGBqCDiNDLo5u1CjtsUGvC4H3qjint
   ezdTTQv+sz1g6Rs3cqicMnNEe7eztoY8DWbbZJHs1/4jkMzKlB6ynO1AM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4435149"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4435149"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 14:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9601028"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.247.118.76]) ([10.247.118.76])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 14:36:58 -0800
Message-ID: <b6b8ba4f-0911-4c69-84ab-32027fffbdf4@intel.com>
Date: Tue, 5 Mar 2024 15:36:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cxl: Add checks to access_coordinate calculation to
 fail missing data
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net
References: <20240229002542.634982-1-dave.jiang@intel.com>
 <20240229002542.634982-2-dave.jiang@intel.com>
 <20240229174427.00000e9e@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240229174427.00000e9e@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/29/24 10:44 AM, Jonathan Cameron wrote:
> On Wed, 28 Feb 2024 17:25:42 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Jonathan noted that when the coordinates for host bridge and switches
>> can be 0s if no actual data are retrieved and the calculation continues.
>> The resulting number would be inaccurate. Add checks to ensure that the
>> calculation would complete only if the numbers are valid.
>>
>> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Hi Dave,
> 
> Whilst I think the fix is right, it is getting hard to read. Maybe
> a rethink is needed on how that iteration works?
> 
>> ---
>>  drivers/cxl/core/port.c | 31 +++++++++++++++++++++++++++----
>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index e1d30a885700..2c82fe24b789 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -2110,6 +2110,20 @@ static void combine_coordinates(struct access_coordinate *c1,
>>  		c1->read_latency += c2->read_latency;
>>  }
>>  
>> +static bool coordinates_invalid(struct access_coordinate *c)
>> +{
>> +	if (!c->read_bandwidth && !c->write_bandwidth &&
>> +	    !c->read_latency && !c->write_latency)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static bool parent_port_is_cxl_root(struct cxl_port *port)
>> +{
>> +	return is_cxl_root(to_cxl_port(port->dev.parent));
>> +}
>> +
>>  /**
>>   * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
>>   *				   of CXL path
>> @@ -2142,16 +2156,25 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  	 * port each iteration. If the parent is cxl root then there is
>>  	 * nothing to gather.
>>  	 */
>> -	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
>> -		combine_coordinates(&c, &dport->sw_coord);
>> +	while (!parent_port_is_cxl_root(iter)) {
>> +		iter = to_cxl_port(iter->dev.parent);
>> +
>> +		/* There's no CDAT for the host bridge, so skip if so. */
> 
> Comment refers to skipping whereas code is 'doing more' for the other case
> so this is confusing to me.
> 
> The inverse of this only occurs on the last iteration I think.
> 
> Possibly a do / while instead of a while will do it.
> I'm far from confident though as all the levels of look up have
> me too confused.

So this is somewhat tricky. For example:
devices/pci0000:35/0000:35:01.0/0000:37:00.0/mem5

In this case the endpoint is attached to the host bridge without any switches. The endpoint is 0000:37:00.0 and the host bridge down stream port is 0000:35:01.0. In this instance there is no switch and therefore switch CDAT, but there is a valid dport. So we would skip the dport->sw_coord. However, we do need to pick up the link_latency between endpoint and downstream port. So we spend 1 iteration in the loop and skips the dport->sw_coord.

devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/0000:c1:00.0/0000:c2:00.0/mem8

Now in this case there's a CXL switch in between. So in first iteration, we pick up the dport->sw_coord. And in second iteration, we skip the dport->sw_coord. However, we would be adding two link_latency. For the link between 0000:c2:00.0 (endpoint) and 0000:c1:00.0 (switch downstream port), and the link between 0000:c0:00.0 (switch upstream port) and 0000:bf:00.0 (host bridge down stream port). So therefore we can't put the sum of link_latency outside of the loop.

Not sure how much better this is:

	do {
		struct cxl_port *parent_port = to_cxl_port(iter->dev.parent);

		dport = iter->parent_dport;
		if (!parent_port_is_cxl_root(parent_port)) {
			if (coordinates_invalid(&dport->sw_coord))
				return -EINVAL;

			combine_coordinates(&c, &dport->sw_coord);
		}

		c.write_latency += dport->link_latency;
		c.read_latency += dport->link_latency;
		iter = to_cxl_port(iter->dev.parent);
	} while (!parent_port_is_cxl_root(iter));

or:

	do {
		struct cxl_port *parent_port = to_cxl_port(iter->dev.parent);

		dport = iter->parent_dport;
		c.write_latency += dport->link_latency;
		c.read_latency += dport->link_latency;

		if (parent_port_is_cxl_root(parent_port))
			break;

		if (coordinates_invalid(&dport->sw_coord))
			return -EINVAL;

		combine_coordinates(&c, &dport->sw_coord);
		iter = to_cxl_port(iter->dev.parent);
	} while (!parent_port_is_cxl_root(iter));


> 
> 
> 	do {
> 		if (coordinates_invalid(&dport->sw_coord))
> 			return -EINVAL;
> 
> 		combine_coordinates(&c, &dport->sw_coord);
> 		iter = to_cxl_port(iter->dev.parent);
>   		dport = iter->parent_dport;
> 	} while (!parent_port_is_cxl_root(iter));
> 	/* Do final link updates */
> 	c.write_latency += dport->link_latency;
> 	c.read_latency += dport->link_latency;
> 
>> +		if (!parent_port_is_cxl_root(iter)) {
>> +			if (coordinates_invalid(&dport->sw_coord))
>> +				return -EINVAL;
>> +
>> +			combine_coordinates(&c, &dport->sw_coord);
>> +		}
>> +
>>  		c.write_latency += dport->link_latency;
>>  		c.read_latency += dport->link_latency;
>> -
>> -		iter = to_cxl_port(iter->dev.parent);
>>  		dport = iter->parent_dport;
>>  	}
>>  
>>  	/* Augment with the generic port (host bridge) perf data */
>> +	if (coordinates_invalid(&dport->hb_coord))
>> +		return -EINVAL;
>>  	combine_coordinates(&c, &dport->hb_coord);
>>  
>>  	/* Get the calculated PCI paths bandwidth */
> 
