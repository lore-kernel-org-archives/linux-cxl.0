Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018FC29115D
	for <linux-cxl@vger.kernel.org>; Fri, 25 Apr 2025 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620068; cv=none; b=d2DeaIK7TfMklSXFRwPVfbGGiIrQvNeReKpYf58f0qdI6tktVJTOeL1fOf0nEDAK1QObYKgZg04V0H1vPXdB/Fqu9tIUOUiOU/rHYjUE0ZXXy5CFM6R699Z6ikYSsj+ButZ6nz/GajEjxp83GuTVOwRovS6fZuHxebMnFWDwFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620068; c=relaxed/simple;
	bh=+pQfCk45S1hm4Fsdbw/fx2xCs7AWIdsFtCEOJFbZf2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcF5B9qDOkEVfTidsmkAioBaJxP7r+C79/HCeK2t+I5lmq+y1EM6g6CZ4c+JRPBqDTWns0LBsSThkH/fSzOK3dxZUU+ivVtU7XQ/wbauQM95r1lPlXiArpkr93GBU+9qr/Tt8VJE4iG84Z3+wYRBHkovtrJ6c5X1XiqU4FfWEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNM8M9d9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNM8M9d9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745620067; x=1777156067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+pQfCk45S1hm4Fsdbw/fx2xCs7AWIdsFtCEOJFbZf2Y=;
  b=iNM8M9d96ajJTEUqy4aoJMvcQtnTlBXYK2sPo9Z+DA8QXHaJzJA6b3m6
   Ni7Henms+NCTzTZNAW8cVozAjfAfUxKb7QcIZ0HyA1lvJkmJ/m2c1cdwh
   Jn51gByUTumwqXMZWY+/1AikeoZ43vBDGeH4TD4W9NLjRcS1eL9qJg2so
   rUKXBF0UzT1QLzhKqObrU2YXamlA0rppGhIy+wLEGx87iz03VzREYZKU4
   Qr0NhVfPz00kLFc4/gmJEaVHrovS8iB5gyPQb72f3Sg1Cp1/mb/4hvDMG
   iyWXRlncBevL1xMEFQ+37rdlqja7adsa0hPteDyZD+SKPKYN5x45w3hOV
   g==;
X-CSE-ConnectionGUID: hz1Y6nNTSHyIP6PTKfzZGQ==
X-CSE-MsgGUID: jD/brvN0TUWKztrvFlTRSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="57934324"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="57934324"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:27:46 -0700
X-CSE-ConnectionGUID: 0+wtdErXSViJHMg8ncIYRg==
X-CSE-MsgGUID: fiRBUVwWTme1FS729D2kfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="132927717"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.211]) ([10.125.108.211])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:27:33 -0700
Message-ID: <af5c4654-7523-4dd3-97fd-4802de409286@intel.com>
Date: Fri, 25 Apr 2025 15:27:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 ming.li@zohomail.com
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-2-dave.jiang@intel.com>
 <6807f007c6e3f_71fe29431@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6807f007c6e3f_71fe29431@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 12:37 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> In preparation to allow dport to be allocated without being active, make
>> dport->id to be Linux id that enumerates the dport objects per port.
>> Keep the hardware id under dport->port_id to maintain compatibility and
>> introduce a dport->id as the enumeration id.
> 
> I think ->port_id is now a poor choice for a name given the potential
> confusion of "which one of these ->id ->port_id is the one read from the
> hardware?". So I like ->id is the name for the logical id, but lets do a
> lead-in patch renaming ->port_id to ->port_num since that is the
> hardware name for this i.e.:
> 
> #define  PCI_EXP_LNKCAP_PN      0xff000000 /* Port Number */

Will do

> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/port.c | 40 +++++++++++++++++++++++++++++-----------
>>  drivers/cxl/cxl.h       |  4 ++++
>>  2 files changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 0fd6646c1a2e..e90e55bc11ac 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -159,7 +159,7 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
>>  
>>  		if (i + 1 < cxld->interleave_ways)
>>  			next = cxlsd->target[i + 1];
>> -		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
>> +		rc = sysfs_emit_at(buf, offset, "%d%s", dport->id,
>>  				   next ? "," : "");
>>  		if (rc < 0)
>>  			return rc;
>> @@ -739,6 +739,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>>  		dev->parent = uport_dev;
>>  
>>  	ida_init(&port->decoder_ida);
>> +	ida_init(&port->dport_ida);
>>  	port->hdm_end = -1;
>>  	port->commit_end = -1;
>>  	xa_init(&port->dports);
>> @@ -1044,14 +1045,14 @@ void put_cxl_root(struct cxl_root *cxl_root)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
>>  
>> -static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>> +static struct cxl_dport *find_dport(struct cxl_port *port, int port_id)
> 
> This also feels like it needs a rename (find_dport_{by_num,by_id}) to
> avoid future confusion where someone gets confused about whether a dport
> is looked up logically or physically. Even looking at this now in
> isolation I do not have the context to say whether logical or physical
> lookup is required.
> 

Yes will introduce a prep patch to change that. I agree about the confusion.

>>  {
>>  	struct cxl_dport *dport;
>>  	unsigned long index;
>>  
>>  	device_lock_assert(&port->dev);
>>  	xa_for_each(&port->dports, index, dport)
>> -		if (dport->port_id == id)
>> +		if (dport->port_id == port_id)
>>  			return dport;
>>  	return NULL;
>>  }
>> @@ -1105,6 +1106,7 @@ static void cxl_dport_remove(void *data)
>>  	struct cxl_port *port = dport->port;
>>  
>>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>> +	ida_free(&port->dport_ida, dport->id);
>>  	put_device(dport->dport_dev);
>>  }
>>  
>> @@ -1114,7 +1116,7 @@ static void cxl_dport_unlink(void *data)
>>  	struct cxl_port *port = dport->port;
>>  	char link_name[CXL_TARGET_STRLEN];
>>  
>> -	sprintf(link_name, "dport%d", dport->port_id);
>> +	sprintf(link_name, "dport%d", dport->id);
>>  	sysfs_remove_link(&port->dev.kobj, link_name);
>>  }
>>  
>> @@ -1126,7 +1128,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	char link_name[CXL_TARGET_STRLEN];
>>  	struct cxl_dport *dport;
>>  	struct device *host;
>> -	int rc;
>> +	int id, rc;
>>  
>>  	if (is_cxl_root(port))
>>  		host = port->uport_dev;
>> @@ -1139,29 +1141,41 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  		return ERR_PTR(-ENXIO);
>>  	}
>>  
>> -	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
>> -	    CXL_TARGET_STRLEN)
>> +	id = ida_alloc(&port->dport_ida, GFP_KERNEL);
>> +	if (id < 0)
>> +		return ERR_PTR(id);
>> +
>> +	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", id) >=
>> +	    CXL_TARGET_STRLEN) {
>> +		ida_free(&port->dport_ida, id);
>>  		return ERR_PTR(-EINVAL);
>> +	}
>>  
>>  	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
>> -	if (!dport)
>> +	if (!dport) {
>> +		ida_free(&port->dport_ida, id);
> 
> Rather than sprinkle ida_free() throughout this function, just make
> allocation do all the allocations in one go, something like:
> 
> static struct cxl_dport *cxl_alloc_dport(struct cxl_port *port, ...)
> {
> 	struct cxl_dport *dport __free(kfree) = kzalloc(&port->dev, sizeof(*dport), GFP_KERNEL);
> 
> 	if (!dport)
> 		return NULL;
> 	id = ida_alloc(&port->dport_ida, GFP_KERNEL);
> 	if (id < 0)
> 		return NULL;
> 	
> 	dport->dport_dev = dport_dev;
> 	dport->port_id = port_id;
> 	dport->port = port;
> 	dport->id = id;
> 
> 	return no_free_ptr(dport);
> }
> 
> dport = cxl_alloc_dport(...)
> if (!dport)
> 	return -ENOMEM;
> rc = devm_add_action_or_reset(&port->dev, free_dport, dport);
> if (rc)
> 	return rc;


Thanks. Will do that.

