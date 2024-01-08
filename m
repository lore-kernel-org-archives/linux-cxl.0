Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF33FE47
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7tHk5QMhz6K9TW;
	Mon,  8 Jan 2024 20:13:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A5A3E140135;
	Mon,  8 Jan 2024 20:15:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 12:15:39 +0000
Date: Mon, 8 Jan 2024 12:15:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
Message-ID: <20240108121538.00001369@Huawei.com>
In-Reply-To: <87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
	<170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
	<87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 08 Jan 2024 14:49:03 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> Dave Jiang <dave.jiang@intel.com> writes:
> 
> > When the CXL region is formed, the driver would computed the performance
> > data for the region. However this data is not available at the node data
> > collection that has been populated by the HMAT during kernel
> > initialization. Add a memory hotplug notifier to update the performance
> > data to the node hmem_attrs to expose the newly calculated region
> > performance data. The CXL region is created under specific CFMWS. The
> > node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
> > Additional regions may overwrite the initial data, but since this is
> > for the same proximity domain it's a don't care for now.
> >
> > node_set_perf_attrs() symbol is exported to allow update of perf attribs
> > for a node. The sysfs path of
> > /sys/devices/system/node/nodeX/access0/initiators/* is created by
> > ndoe_set_perf_attrs() for the various attributes where nodeX is matched
> > to the proximity domain of the CXL region.

As per discussion below.  Why is access1 not also relevant for CXL memory?
(it's probably more relevant than access0 in many cases!)

For historical references, I wanted access0 to be the CPU only one, but
review feedback was that access0 was already defined as 'initiator based'
so we couldn't just make the 0 indexed one the case most people care about.
Hence we grew access1 to cover the CPU only case which most software cares
about.

> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> > v3:
> > - Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
> > - use read_bandwidth as check for valid coords (Jonathan)
> > - Remove setting of coord access level 1. (Jonathan)
> > ---
> >  drivers/base/node.c       |    1 +
> >  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h         |    3 +++
> >  3 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index cb2b6cc7f6e6..48e5cb292765 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
> >  		}
> >  	}
> >  }
> > +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
> >  
> >  /**
> >   * struct node_cache_info - Internal tracking for memory node caches
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index d28d24524d41..bee65f535d6c 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -4,6 +4,7 @@
> >  #include <linux/genalloc.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include <linux/memory.h>
> >  #include <linux/slab.h>
> >  #include <linux/uuid.h>
> >  #include <linux/sort.h>
> > @@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
> >  	return 1;
> >  }
> >  
> > +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
> > +					  unsigned long action, void *arg)
> > +{
> > +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
> > +					       memory_notifier);
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_endpoint_decoder *cxled = p->targets[0];
> > +	struct cxl_decoder *cxld = &cxled->cxld;
> > +	struct memory_notify *mnb = arg;
> > +	int nid = mnb->status_change_nid;
> > +	int region_nid;
> > +
> > +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> > +		return NOTIFY_DONE;
> > +
> > +	region_nid = phys_to_target_node(cxld->hpa_range.start);
> > +	if (nid != region_nid)
> > +		return NOTIFY_DONE;
> > +
> > +	/* Don't set if there's no coordinate information */
> > +	if (!cxlr->coord.write_bandwidth)
> > +		return NOTIFY_DONE;  
> 
> Although you said you will use "read_bandwidth" in changelog, you
> actually didn't do that.
> 
> > +
> > +	node_set_perf_attrs(nid, &cxlr->coord, 0);
> > +	node_set_perf_attrs(nid, &cxlr->coord, 1);  
> 
> And this.
> 
> But I don't think it's good to remove access level 1.  According to
> commit b9fffe47212c ("node: Add access1 class to represent CPU to memory
> characteristics").  Access level 1 is for performance from CPU to
> memory.  So, we should keep access level 1.  For CXL memory device,
> access level 0 and access level 1 should be equivalent.  Will the code
> be used for something like GPU connected via CXL?  Where the access
> level 0 may be for the performance from GPU to the memory.
> 
I disagree. They are no more equivalent than they are on any other complex system.

e.g. A CXL root port being described using generic Port infrastructure may be
on a different die (IO dies are a common architecture) in the package
than the CPU cores and that IO die may well have generic initiators that
are much nearer than the CPU cores.

In those cases access0 will cover initators on the IO die but access1 will
cover the nearest CPU cores (initiators).

Both should arguably be there for CXL memory as both are as relevant as
they are for any other memory.

If / when we get some GPUs etc on CXL that are initiators this will all
get a lot more fun but for now we can kick that into the long grass.

Jonathan


> --
> Best Regards,
> Huang, Ying
> 
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static void remove_coord_notifier(void *data)
> > +{
> > +	struct cxl_region *cxlr = data;
> > +
> > +	unregister_memory_notifier(&cxlr->memory_notifier);
> > +}
> > +
> >  static int cxl_region_probe(struct device *dev)
> >  {
> >  	struct cxl_region *cxlr = to_cxl_region(dev);
> > @@ -2997,6 +3034,11 @@ static int cxl_region_probe(struct device *dev)
> >  		goto out;
> >  	}
> >  
> > +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> > +	cxlr->memory_notifier.priority = HMAT_CALLBACK_PRI;
> > +	register_memory_notifier(&cxlr->memory_notifier);
> > +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, cxlr);
> > +
> >  	/*
> >  	 * From this point on any path that changes the region's state away from
> >  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 4639d0d6ef54..2498086c8edc 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -6,6 +6,7 @@
> >  
> >  #include <linux/libnvdimm.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/notifier.h>
> >  #include <linux/bitops.h>
> >  #include <linux/log2.h>
> >  #include <linux/node.h>
> > @@ -520,6 +521,7 @@ struct cxl_region_params {
> >   * @flags: Region state flags
> >   * @params: active + config params for the region
> >   * @coord: QoS access coordinates for the region
> > + * @memory_notifier: notifier for setting the access coordinates to node
> >   */
> >  struct cxl_region {
> >  	struct device dev;
> > @@ -531,6 +533,7 @@ struct cxl_region {
> >  	unsigned long flags;
> >  	struct cxl_region_params params;
> >  	struct access_coordinate coord;
> > +	struct notifier_block memory_notifier;
> >  };
> >  
> >  struct cxl_nvdimm_bridge {  
> 

