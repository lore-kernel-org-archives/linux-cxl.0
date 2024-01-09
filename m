Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB123B1
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bb2pSV55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704766636; x=1736302636;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kQAmrcOdH8VdFXFezT5HqpafbrnKbnNm1GopsYo5InI=;
  b=bb2pSV55JWXalh/Tm5hv3gHJUMHkjlm0Zert0LoOGJVlJU+GluN/Tdfd
   UernT7vDiQQzyW7vKzbzKxZ8OwSLsnFpcsS98KF/qgphUmBJZ78wLc3g5
   F1jzBdUjg0825YCoYAha9hGPnHqhnpE7d6P5CzCOgEEQLkWkTizhXJjoI
   uPEsCJ2c6RXUWLSWF/wQCk47VrhGC8DHYEr8kuftIeFgunBnisrfC/RaV
   3ThHOI8VIAeAptP2jCNQuld/x0Mhx5V6xK8xGpGOgBxy9LrwRDw2I17kX
   E1WF2nh6W6UNPhI2P7YaFSaXkWeIjdNzSVkMtmcKWweGOADykQ1qTUONS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388501821"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="388501821"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 18:17:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785052524"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="785052524"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 18:17:13 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
  <linux-cxl@vger.kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  <dan.j.williams@intel.com>,  <ira.weiny@intel.com>,
  <vishal.l.verma@intel.com>,  <alison.schofield@intel.com>,
  <dave@stgolabs.net>
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
In-Reply-To: <38be52cf-a4ea-402c-9b14-47a80427f0c8@intel.com> (Dave Jiang's
	message of "Mon, 8 Jan 2024 11:18:33 -0700")
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
	<170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
	<87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240108121538.00001369@Huawei.com>
	<38be52cf-a4ea-402c-9b14-47a80427f0c8@intel.com>
Date: Tue, 09 Jan 2024 10:15:15 +0800
Message-ID: <87wmsj8d70.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dave Jiang <dave.jiang@intel.com> writes:

> On 1/8/24 05:15, Jonathan Cameron wrote:
>> On Mon, 08 Jan 2024 14:49:03 +0800
>> "Huang, Ying" <ying.huang@intel.com> wrote:
>> 
>>> Dave Jiang <dave.jiang@intel.com> writes:
>>>
>>>> When the CXL region is formed, the driver would computed the performance
>>>> data for the region. However this data is not available at the node data
>>>> collection that has been populated by the HMAT during kernel
>>>> initialization. Add a memory hotplug notifier to update the performance
>>>> data to the node hmem_attrs to expose the newly calculated region
>>>> performance data. The CXL region is created under specific CFMWS. The
>>>> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
>>>> Additional regions may overwrite the initial data, but since this is
>>>> for the same proximity domain it's a don't care for now.
>>>>
>>>> node_set_perf_attrs() symbol is exported to allow update of perf attribs
>>>> for a node. The sysfs path of
>>>> /sys/devices/system/node/nodeX/access0/initiators/* is created by
>>>> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
>>>> to the proximity domain of the CXL region.
>> 
>> As per discussion below.  Why is access1 not also relevant for CXL memory?
>> (it's probably more relevant than access0 in many cases!)
>> 
>> For historical references, I wanted access0 to be the CPU only one, but
>> review feedback was that access0 was already defined as 'initiator based'
>> so we couldn't just make the 0 indexed one the case most people care about.
>> Hence we grew access1 to cover the CPU only case which most software cares
>> about.
>> 
>>>>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>> v3:
>>>> - Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
>>>> - use read_bandwidth as check for valid coords (Jonathan)
>>>> - Remove setting of coord access level 1. (Jonathan)
>>>> ---
>>>>  drivers/base/node.c       |    1 +
>>>>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/cxl/cxl.h         |    3 +++
>>>>  3 files changed, 46 insertions(+)
>>>>
>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>> index cb2b6cc7f6e6..48e5cb292765 100644
>>>> --- a/drivers/base/node.c
>>>> +++ b/drivers/base/node.c
>>>> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>>>>  		}
>>>>  	}
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>>>>  
>>>>  /**
>>>>   * struct node_cache_info - Internal tracking for memory node caches
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index d28d24524d41..bee65f535d6c 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -4,6 +4,7 @@
>>>>  #include <linux/genalloc.h>
>>>>  #include <linux/device.h>
>>>>  #include <linux/module.h>
>>>> +#include <linux/memory.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/uuid.h>
>>>>  #include <linux/sort.h>
>>>> @@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
>>>>  	return 1;
>>>>  }
>>>>  
>>>> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>>>> +					  unsigned long action, void *arg)
>>>> +{
>>>> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
>>>> +					       memory_notifier);
>>>> +	struct cxl_region_params *p = &cxlr->params;
>>>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>>>> +	struct cxl_decoder *cxld = &cxled->cxld;
>>>> +	struct memory_notify *mnb = arg;
>>>> +	int nid = mnb->status_change_nid;
>>>> +	int region_nid;
>>>> +
>>>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
>>>> +	if (nid != region_nid)
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	/* Don't set if there's no coordinate information */
>>>> +	if (!cxlr->coord.write_bandwidth)
>>>> +		return NOTIFY_DONE;  
>>>
>>> Although you said you will use "read_bandwidth" in changelog, you
>>> actually didn't do that.
>>>
>>>> +
>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 1);  
>>>
>>> And this.
>>>
>>> But I don't think it's good to remove access level 1.  According to
>>> commit b9fffe47212c ("node: Add access1 class to represent CPU to memory
>>> characteristics").  Access level 1 is for performance from CPU to
>>> memory.  So, we should keep access level 1.  For CXL memory device,
>>> access level 0 and access level 1 should be equivalent.  Will the code
>>> be used for something like GPU connected via CXL?  Where the access
>>> level 0 may be for the performance from GPU to the memory.
>>>
>> I disagree. They are no more equivalent than they are on any other complex system.
>> 
>> e.g. A CXL root port being described using generic Port infrastructure may be
>> on a different die (IO dies are a common architecture) in the package
>> than the CPU cores and that IO die may well have generic initiators that
>> are much nearer than the CPU cores.
>> 
>> In those cases access0 will cover initators on the IO die but access1 will
>> cover the nearest CPU cores (initiators).
>> 
>> Both should arguably be there for CXL memory as both are as relevant as
>> they are for any other memory.
>> 
>> If / when we get some GPUs etc on CXL that are initiators this will all
>> get a lot more fun but for now we can kick that into the long grass.
>
>
> With the current way of storing HMAT targets information, only the
> best performance data is stored (access0). The existing HMAT handling
> code also sets the access1 if the associated initiator node contains a
> CPU for conventional memory. The current calculated full CXL path is
> the access0 data. I think what's missing is the check to see if the
> associated initiator node is also a CPU node and sets access1
> conditionally based on that. Maybe if that conditional gets added then
> that is ok for what we have now?

We do need access1 to put NUMA nodes into appropriate memory tiers, just
like we have done in hmat.c.  Because default memory tiers are defined
with performance from CPU to the device.  Is it possible to get access1
always?

--
Best Regards,
Huang, Ying

> If/When the non-CPU initiators shows up for CXL, we'll need to change
> the way to store the initiator to generic target table data and how we
> calculate and setup access0 vs access1. Maybe that can be done as a
> later iteration?
>
> DJ
>
>> 
>> Jonathan
>> 
>> 
>>> --
>>> Best Regards,
>>> Huang, Ying
>>>
>>>> +
>>>> +	return NOTIFY_OK;
>>>> +}
>>>> +
>>>> +static void remove_coord_notifier(void *data)
>>>> +{
>>>> +	struct cxl_region *cxlr = data;
>>>> +
>>>> +	unregister_memory_notifier(&cxlr->memory_notifier);
>>>> +}
>>>> +
>>>>  static int cxl_region_probe(struct device *dev)
>>>>  {
>>>>  	struct cxl_region *cxlr = to_cxl_region(dev);
>>>> @@ -2997,6 +3034,11 @@ static int cxl_region_probe(struct device *dev)
>>>>  		goto out;
>>>>  	}
>>>>  
>>>> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
>>>> +	cxlr->memory_notifier.priority = HMAT_CALLBACK_PRI;
>>>> +	register_memory_notifier(&cxlr->memory_notifier);
>>>> +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, cxlr);
>>>> +
>>>>  	/*
>>>>  	 * From this point on any path that changes the region's state away from
>>>>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index 4639d0d6ef54..2498086c8edc 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -6,6 +6,7 @@
>>>>  
>>>>  #include <linux/libnvdimm.h>
>>>>  #include <linux/bitfield.h>
>>>> +#include <linux/notifier.h>
>>>>  #include <linux/bitops.h>
>>>>  #include <linux/log2.h>
>>>>  #include <linux/node.h>
>>>> @@ -520,6 +521,7 @@ struct cxl_region_params {
>>>>   * @flags: Region state flags
>>>>   * @params: active + config params for the region
>>>>   * @coord: QoS access coordinates for the region
>>>> + * @memory_notifier: notifier for setting the access coordinates to node
>>>>   */
>>>>  struct cxl_region {
>>>>  	struct device dev;
>>>> @@ -531,6 +533,7 @@ struct cxl_region {
>>>>  	unsigned long flags;
>>>>  	struct cxl_region_params params;
>>>>  	struct access_coordinate coord;
>>>> +	struct notifier_block memory_notifier;
>>>>  };
>>>>  
>>>>  struct cxl_nvdimm_bridge {  
>>>
>> 
>> 
