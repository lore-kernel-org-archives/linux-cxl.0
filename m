Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B5029115B
	for <linux-cxl@vger.kernel.org>; Fri, 25 Apr 2025 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745619997; cv=none; b=d4I/u50/8tApCJqyZecjRIrEbrbZFurIjK/IPRUdGJyguavALDuoyO+ho4aafwsbxW+LmW29HJAj8utgQWgu630T+KUgeXpqENJ+8LPjt5QcEeoS2+ca520Vhbn2RhZ0YQjgn2KhY/qyI3pn1Vkkj6wr0KtdURKSnjmEFhKX/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745619997; c=relaxed/simple;
	bh=iTcAV4YFC4FzkSU2vNvs2rW76NXD9yQ7QX9bnzvv7jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXW6oCfgaxfud2QO2SrkTvrccMfL77wCE6V4luobw+3Qa7QlhcABk+QYEx72WREuj5Yd1Ga+SVwsEd4kd4TV2hQ4gCCTQxyL2IExb5jXAXOxyhCy/6FJ1LtvIaCVKas8GhNhWowb9M+zUuK1zR4PS3c0ecvlx9kmMyfMJUCFYRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwEluSh0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwEluSh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745619995; x=1777155995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iTcAV4YFC4FzkSU2vNvs2rW76NXD9yQ7QX9bnzvv7jk=;
  b=ZwEluSh0YTgJCCmEV/Rgk47T9sUXfEuqnblk4UqRY3MaRXA7UTK72ZQF
   riT580vLz+m1UwH8ECo/WOUEh3gsX9B6Nxq6dntogeYIc0g/JiKg4d+7Y
   ZMCwiRxDaASX/fS8unc67Kh+9dSm3aZVUBjP03aXyaocK6t4rOFR7eZyN
   6RzjUx+VUv4+jm833rVBsOxztJuNYHbda+aKYOc21qmPiOFU5fQiAx8fe
   46nnmvDopaTeZW3SE7e3z65Y18AfLlY7dAvDyaxYuO9/gPeh+hoZOhRKw
   KFOh6zAp5I0W9aNKUdeZN3a7E31H1xu/jFx1Iw3p7n/U5B1NhuRFpfTpZ
   w==;
X-CSE-ConnectionGUID: qMmgFJukQgeFWOeB8kj5gw==
X-CSE-MsgGUID: GKYlHSYiTFuk3p0lJK4tMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="57934256"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="57934256"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:26:34 -0700
X-CSE-ConnectionGUID: rxP2zrbNTtqfk6rdD7sS2A==
X-CSE-MsgGUID: 6HJnTt4/SHa2p6UQDh4jFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="132927547"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.211]) ([10.125.108.211])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:26:33 -0700
Message-ID: <372c9444-859e-462c-b5e0-90fc1a2a6121@intel.com>
Date: Fri, 25 Apr 2025 15:26:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 ming.li@zohomail.com
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-2-dave.jiang@intel.com>
 <20250422175446.00002ac5@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250422175446.00002ac5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 9:54 AM, Jonathan Cameron wrote:
> On Fri, 4 Apr 2025 15:57:33 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> Typo in patch title. Separate
> 
> 
>> In preparation to allow dport to be allocated without being active, make
>> dport->id to be Linux id that enumerates the dport objects per port.
>> Keep the hardware id under dport->port_id to maintain compatibility and
>> introduce a dport->id as the enumeration id.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> I'm getting my head around this still but just based on refactor in here
> we have a bit where lifetimes weren't quite what I expected to see.
> 
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
> 
> Hmm. This ordering is effectively different to that in __devm_cxl_add_dport(reversed).
> If we were to match that we'd free the ida after the
> put_device(dport->dport_dev) which I think is unwinding the reference from
> get_device(dport_dev)
> 
> This makes me suspicious of the ownership of dport->id.
> 
> Maybe just spin another devm_add_action_or_reset() to free the id?

Yes I'll do that. Same thing Dan suggested as well.

> 
> If we need this ordering add a comment here on why.
> 
> 
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
> 
> I'm not that keen on the number of places we have to call ida_free() manually
> in error paths.  I think that's because we should have another devm
> handler...

With the new change this should go away.

DJ

> 
>>  		return ERR_PTR(-EINVAL);
>> +	}
>>  
>>  	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
>> -	if (!dport)
>> +	if (!dport) {
>> +		ida_free(&port->dport_ida, id);
>>  		return ERR_PTR(-ENOMEM);
>> +	}
>>  
>>  	dport->dport_dev = dport_dev;
>>  	dport->port_id = port_id;
>>  	dport->port = port;
>> +	dport->id = id;
>>  
>>  	if (rcrb == CXL_RESOURCE_NONE) {
>>  		rc = cxl_dport_setup_regs(&port->dev, dport,
>>  					  component_reg_phys);
>> -		if (rc)
>> +		if (rc) {
>> +			ida_free(&port->dport_ida, id);
>>  			return ERR_PTR(rc);
>> +		}
>>  	} else {
>>  		dport->rcrb.base = rcrb;
>>  		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
>>  							 CXL_RCRB_DOWNSTREAM);
>>  		if (component_reg_phys == CXL_RESOURCE_NONE) {
>>  			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
>> +			ida_free(&port->dport_ida, id);
>>  			return ERR_PTR(-ENXIO);
>>  		}
>>  
>> @@ -1170,8 +1184,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  		 * memdev
>>  		 */
>>  		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
>> -		if (rc)
>> +		if (rc) {
>> +			ida_free(&port->dport_ida, id);
>>  			return ERR_PTR(rc);
>> +		}
>>  
>>  		dport->rch = true;
>>  	}
>> @@ -1183,8 +1199,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	cond_cxl_root_lock(port);
>>  	rc = add_dport(port, dport);
>>  	cond_cxl_root_unlock(port);
>> -	if (rc)
>> +	if (rc) {
>> +		ida_free(&port->dport_ida, id);
>>  		return ERR_PTR(rc);
>> +	}
>>  
>>  	get_device(dport_dev);
>>  	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
> 
> 

