Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40C1272D4
	for <linux-cxl@vger.kernel.org>; Tue,  5 Mar 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654051; cv=none; b=VgYzMpa9f38yJ0VXg3gKtGS0/sacMznDBgCw5FmVCfmuJf0uQWI9QZ2CtRUsBlVyRDKZgpfTsfGSelaorVE9uOdn8sP96v+oLSpju7oamWiLgMyqn6OasBA7haz7l7j3vAI49di+gbMi1Xi5azq4fzNmdr+jJY5bcdfgpT3mUgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654051; c=relaxed/simple;
	bh=FPypIi1ZzjBDMgvP7lwCOMNl72w2mJgFWBNTOB+Mg/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6on6MAZPqcP/kNJpdUbe2rh6C3pNB2SiblYEF8OneAIkc+/B8VkkX+IJZHmFq+VSIC1ICiH5j1LdXFBOCLD42yCBWDuoc4YaFVxzHB42lxY1GUx7HJHtwUtE2ua45LAcJz3nmYuriyc4yL4+DwQ8vhdyv0RpWbXI/pSJqmYIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQAG0PAQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQAG0PAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709654049; x=1741190049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FPypIi1ZzjBDMgvP7lwCOMNl72w2mJgFWBNTOB+Mg/0=;
  b=hQAG0PAQm1ECJmJ0OJOR9jHjV4kjScwxTPqD8pnpIpCypoh726JXN8kP
   f5CckuIzR4DDlAO9CwrRco+GCAlqTGUMUevtU5D4znU9pBCgI/rDyJWeZ
   DdKJFhM5SVkh/GtQJP/zMP2T4vU3U2UisHyg04sow7O5v+81jyIQhA/Fj
   GWIxXiaKoPTvitHfngYlcigeF89DA4kDiFQsGNXH60swk8V9aXLK2qF75
   ODMn97cbYodiQDSTih0ObrACrVCAeFyOp5GTFvsl6gy1+001wJtdJrSex
   dEdL1HCHWhZq0NeQSl82p9NlPCfJbUMEtSnCy0ccj3Kx5WSzMK9ZkJ2zT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14927960"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14927960"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 07:54:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14108259"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.247.118.76]) ([10.247.118.76])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 07:54:04 -0800
Message-ID: <8c57996e-a217-49c6-bf94-e2c290b90ef1@intel.com>
Date: Tue, 5 Mar 2024 08:53:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl: Fix the incorrect assignment of SSLBIS entry
 pointer initial location
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net
References: <20240301210948.1298075-1-dave.jiang@intel.com>
 <20240305103455.000064bc@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240305103455.000064bc@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/24 3:34 AM, Jonathan Cameron wrote:
> On Fri, 1 Mar 2024 14:09:48 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> The 'entry' pointer in cdat_sslbis_handler() is set to header +
>> sizeof(common header). However, the math missed the addition of the SSLBIS
>> main header. It should be header + sizeof(common header) + sizeof(*sslbis).
>> Use a defined struct for all the SSLBIS parts in order to avoid pointer
>> math errors.
>>
>> The bug causes incorrect parsing of the SSLBIS table and introduces incorrect
>> performance values to the access_coordinates during the CXL access_coordinate
>> calculation path if there are CXL switches present in the topology.
>>
>> The issue was found during testing of new code being added to add additional
>> checks for invalid CDAT values during CXL access_coordinate calculation. The
>> testing was done on qemu with a CXL topology including a CXL switch.
>>
>> Fixes: 80aa780dda20 ("cxl: Add callback to parse the SSLBIS subtable from CDAT")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Hmm. This is far from a minimal fix.  The end result is nicer though so fair enough.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Pity there is no direct variable containing the count so we could do
> a __counted_by() - don't think you can do maths in that unfortunately.

Right. And even if there is, the endien conversion makes it complicated. I suppose it'll maybe take leXX_to_cpu() wrapper around the count?

> 
> 
>> ---
>> v3:
>> - use var for sizeof() instead of struct (Alison)
>> ---
>>  drivers/cxl/core/cdat.c | 30 +++++++++++++++---------------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 08fd0baea7a0..0363ca434ef4 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -389,36 +389,38 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
>>  static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>>  			       const unsigned long end)
>>  {
>> +	struct acpi_cdat_sslbis_table {
>> +		struct acpi_cdat_header header;
>> +		struct acpi_cdat_sslbis sslbis_header;
>> +		struct acpi_cdat_sslbe entries[];
>> +	} *tbl = (struct acpi_cdat_sslbis_table *)header;
>> +	int size = sizeof(header->cdat) + sizeof(tbl->sslbis_header);
>>  	struct acpi_cdat_sslbis *sslbis;
>> -	int size = sizeof(header->cdat) + sizeof(*sslbis);
>>  	struct cxl_port *port = arg;
>>  	struct device *dev = &port->dev;
>> -	struct acpi_cdat_sslbe *entry;
>>  	int remain, entries, i;
>>  	u16 len;
>>  
>>  	len = le16_to_cpu((__force __le16)header->cdat.length);
>>  	remain = len - size;
>> -	if (!remain || remain % sizeof(*entry) ||
>> +	if (!remain || remain % sizeof(tbl->entries[0]) ||
>>  	    (unsigned long)header + len > end) {
>>  		dev_warn(dev, "Malformed SSLBIS table length: (%u)\n", len);
>>  		return -EINVAL;
>>  	}
>>  
>> -	/* Skip common header */
>> -	sslbis = (struct acpi_cdat_sslbis *)((unsigned long)header +
>> -					     sizeof(header->cdat));
>> -
>> +	sslbis = &tbl->sslbis_header;
>>  	/* Unrecognized data type, we can skip */
>>  	if (sslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
>>  		return 0;
>>  
>> -	entries = remain / sizeof(*entry);
>> -	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
>> +	entries = remain / sizeof(tbl->entries[0]);
>> +	if (struct_size(tbl, entries, entries) != len)
>> +		return -EINVAL;
>>  
>>  	for (i = 0; i < entries; i++) {
>> -		u16 x = le16_to_cpu((__force __le16)entry->portx_id);
>> -		u16 y = le16_to_cpu((__force __le16)entry->porty_id);
>> +		u16 x = le16_to_cpu((__force __le16)tbl->entries[i].portx_id);
>> +		u16 y = le16_to_cpu((__force __le16)tbl->entries[i].porty_id);
>>  		__le64 le_base;
>>  		__le16 le_val;
>>  		struct cxl_dport *dport;
>> @@ -448,8 +450,8 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>>  			break;
>>  		}
>>  
>> -		le_base = (__force __le64)sslbis->entry_base_unit;
>> -		le_val = (__force __le16)entry->latency_or_bandwidth;
>> +		le_base = (__force __le64)tbl->sslbis_header.entry_base_unit;
>> +		le_val = (__force __le16)tbl->entries[i].latency_or_bandwidth;
>>  
>>  		if (check_mul_overflow(le64_to_cpu(le_base),
>>  				       le16_to_cpu(le_val), &val))
>> @@ -462,8 +464,6 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>>  							  sslbis->data_type,
>>  							  val);
>>  		}
>> -
>> -		entry++;
>>  	}
>>  
>>  	return 0;
> 
