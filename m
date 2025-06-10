Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926824167E
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576162; cv=none; b=BYnf7JbcBsLck7xHTks4t1xwmyLfkgWHGS9gY8SNNNikLOMRtCRgY1WjZEdbQPLfG+FAgo4tYvt8PWHF33qVy3OXxa7upi7yQ3CaB8EcUjb+SZWrXeBQsl8Hlvo+s+ilpJ+UmE+ysKNvPt/Mp5NSyb6yLzj3qWRD2GCOLSzjYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576162; c=relaxed/simple;
	bh=mOJB9L2Aqcn1SjB8V/+4GNsKqK5sjS5lW6N+7+TjUYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL+ijoxBzUYRxAUH9a8OWT/rDH5/q6TdpqoAGPErO0K/Y6N68/btQeYRvjQRXt95G44toKQG+ViPbwRUn6OVWoN4PPUXSB6wA+GiJoThYe06Hmi/ZmJlkrwXv/GEnt3FR7+JVIgxDhV/HIDYOqQZptAZBsk9aiZQJovmjbjv7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnLgUrdr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnLgUrdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749576161; x=1781112161;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mOJB9L2Aqcn1SjB8V/+4GNsKqK5sjS5lW6N+7+TjUYI=;
  b=fnLgUrdrWTP9enoD8zB5TLQMsarpUtg0JvgVbD8rK+jb8AgmSD/CLDq0
   P2FHuNPzcu3TozVaeGczjnnDzt8plcZM1JiXQ1imJl5xBq5nkFqx7Yz5w
   dQVQ9WA+M1B3IKREB5H0kssRtw7XQa4wshkx/caxI/uHi9v9YxlvzJ1mK
   RdHGJ3xWqpzsqUv4u/CyGJUFK6IgAjpHbygSRYT/QzZ/yemizJzqZZWrm
   oCRSDb+85ez9ftFlcPlbdjNcR+Jdpcuq1T3va0cNEb4dVJJ6usieMz2HH
   mjLI7AORImnxagFR4M/5qESXixmA1oOG6jceDFxyrP1xI+tBEQ2jMRqS3
   w==;
X-CSE-ConnectionGUID: Cg3MFgZ3RaSpwEU19rYnWg==
X-CSE-MsgGUID: yllLHS8/TgSrf90kYEkWAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51795576"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51795576"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:22:41 -0700
X-CSE-ConnectionGUID: AywOcM4HTxGJ1ItGiStjQA==
X-CSE-MsgGUID: dvQ/0ax7Qc6O+PDDcmLfGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="152144347"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.135]) ([10.125.111.135])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:22:40 -0700
Message-ID: <988a57c6-c86b-4e59-a372-d5cbc4a1f074@intel.com>
Date: Tue, 10 Jun 2025 10:22:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Remove core/acpi.c and cxl core dependency on
 ACPI
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250610000237.2929667-1-dave.jiang@intel.com>
 <20250610000237.2929667-2-dave.jiang@intel.com>
 <20250610103504.00004316@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250610103504.00004316@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/25 2:35 AM, Jonathan Cameron wrote:
> On Mon, 9 Jun 2025 17:02:37 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
>> cxl_core when adding the extended linear cache support. Add a callback
>> in the cxl_root_decoder to retrieve the extended linear cache size from
>> ACPI via the cxl_acpi driver.
>>
>> In order to deal with cxl_test, a device parameter had to be introduced
>> to the hmat_get_extended_linear_cache_size() call in order to help with
>> the mock wrapped function from ACPI. Even though the 'struct device' is
>> not used by the actual hmat_get_extended_linear_cache_size() function.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Remove introduction of 'struct device' parameter to
>>   hmat_get_extended_linear_cache_size().
>> - Drop comment on flex array (Jonathan)
>> - Rename cxl_rcd_ops to cxl_rd_ops for 'root decoder ops' (Fabio)
> There is a lot of indirection going on in here, but I think I understand
> why it is all there.  A few comments inline. The device reference one
> just passes what I'm comfortable assuming you will just fix it up though
> so I'll wait for v3 for tags.

Yeah I figured it's better off to push all the complexity to cxl_test.

> 
> J
> 
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 8a5815ca870d..3f6780179752 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -470,6 +470,43 @@ struct cxl_cedt_context {
>>  	struct device *dev;
>>  };
>>  
>> +static int match_root_decoder_by_range(struct device *dev, const void *data)
>> +{
>> +	const struct range *r1, *r2 = data;
> 
> I'm fussy about this, but I'd not mix a non assigned and assigned declaration
> in one line.  (Trivial comment though so ignore if you like)
> 

I can change it. Original code was just copied directly from core/region.c.

>> +	struct cxl_root_decoder *cxlrd;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>> +	return range_contains(r1, r2);
>> +}
>> +
>> +static int mock_hmat_get_extended_linear_cache_size(struct resource *backing_res,
>> +						    int nid, resource_size_t *size)
>> +{
>> +	struct range backing_range = {
>> +		.start = backing_res->start,
>> +		.end = backing_res->end,
>> +	};
>> +	struct cxl_decoder *cxld;
>> +	struct cxl_port *port;
>> +	struct device *dev;
>> +
>> +	dev = bus_find_device(&cxl_bus_type, NULL, &backing_range,
>> +			      match_root_decoder_by_range);
> 
> This grabs a reference to the device.  Do we need a put_device()
> somewhere?

Yes. Forgot to add the __free(put_device).
> 
>> +	if (!dev)
>> +		return -ENODEV;
>> +
>> +	cxld = to_cxl_decoder(dev);
>> +	port = to_cxl_port(cxld->dev.parent);
>> +	if (is_mock_dev(port->uport_dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
>> +}
>> +
>>  static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
>>  				      acpi_tbl_entry_handler_arg handler_arg,
>>  				      void *arg)
>> @@ -1040,6 +1077,8 @@ static struct cxl_mock_ops cxl_mock_ops = {
>>  	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
>>  	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
>>  	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
>> +	.hmat_get_extended_linear_cache_size =
>> +		mock_hmat_get_extended_linear_cache_size,
>>  };
> 
> Why is list set last in here?  It's first in the structure
> and we now end up with the callbacks not next to each other which looks
> weird.  Maybe move the LIST_HEAD_INIT() up, or if not move the new
> callback setting up one line to next to parse_cdat.

I'll move it a line up.
> 
> 
> 

