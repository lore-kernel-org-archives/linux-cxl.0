Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBE61C68E
	for <linux-cxl@vger.kernel.org>; Tue, 19 Dec 2023 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SvgF40cYNz6K9K3;
	Tue, 19 Dec 2023 23:13:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CEA6C140DEC;
	Tue, 19 Dec 2023 23:15:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 15:15:09 +0000
Date: Tue, 19 Dec 2023 15:15:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <brice.goglin@gmail.com>,
	<nifan.cxl@gmail.com>
Subject: Re: [PATCH v2 3/3] cxl: Add memory hotplug notifier for cxl region
Message-ID: <20231219151507.0000226f@Huawei.com>
In-Reply-To: <170268217159.1381493.10875292326564731198.stgit@djiang5-mobl3>
References: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
	<170268217159.1381493.10875292326564731198.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 15 Dec 2023 16:16:11 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> When the CXL region is formed, the driver would computed the performance
> data for the region. However this data is not available at the node data
> collection that has been populated by the HMAT during kernel
> initialization. Add a memory hotplug notifier to update the performance
> data to the node hmem_attrs to expose the newly calculated region
> performance data. The CXL region is created under specific CFMWS. The
> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
> The notifier will run once only and turn itself off after the initial
> run. Additional regions may overwrite the initial data, but since this is
> for the same poximity domain it's a don't care for now.

proximity

> 
> node_set_perf_attrs() is exported to allow update of perf attribs for a
> node. Given that only CXL is using this, export only to CXL namespace.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

What is end result of this?

/sys/devices/system/node/node/access0/ 
/sys/devices/system/node/node/access1/ 
With just the bandwidths and latencies?
No targets or initiators under accessX/targets or accessX/initiators?

Or have those been set up earlier?  In which case do we handle
the worse bandwidth being inside the host CPU?

> ---
> v2:
> - Fix notifier return values (Dan)
> - Use devm_add_action_or_reset() instead of adding a remove callback (Dan)
> - Add Ying review tag
> ---
>  drivers/base/node.c       |    1 +
>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |    3 +++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index cb2b6cc7f6e6..f5b5a3f11894 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_NS_GPL(node_set_perf_attrs, CXL);
This feels ugly as namespaces usually about what is providing the facility not
a 'who can use it' control.

Also, I'm aware of at least one other user who will want this in the not
too distant future.  So if we want to namespace it, I'd prefer a NODE namespace
or something along those lines.

>  
>  /**
>   * struct node_cache_info - Internal tracking for memory node caches
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d97fa5f32e86..1765bf716484 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4,6 +4,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/memory.h>
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
>  #include <linux/sort.h>
> @@ -2960,6 +2961,42 @@ static int is_system_ram(struct resource *res, void *arg)
>  	return 1;
>  }
>  
> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
> +					  unsigned long action, void *arg)
> +{
> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
> +					       memory_notifier);
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct memory_notify *mnb = arg;
> +	int nid = mnb->status_change_nid;
> +	int region_nid;
> +
> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> +		return NOTIFY_DONE;
> +
> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
> +	if (nid != region_nid)
> +		return NOTIFY_DONE;
> +
> +	/* Don't set if there's no coordinate information */
> +	if (!cxlr->coord.write_bandwidth)
> +		return NOTIFY_DONE;

Could future proof a bit to allow for RO memory by using read_bandwith here.

> +
> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
> +	node_set_perf_attrs(nid, &cxlr->coord, 1);

Hmm. Assumption that the access attributes from no CPU requesters is the same
as the CPU bothers me a little.

> +
> +	return NOTIFY_OK;
> +}
> +
> +static void remove_coord_notifier(void *data)
> +{
> +	struct cxl_region *cxlr = data;
> +
> +	unregister_memory_notifier(&cxlr->memory_notifier);
> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -2985,6 +3022,11 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> +	cxlr->memory_notifier.priority = HMAT_CALLBACK_PRI;
> +	register_memory_notifier(&cxlr->memory_notifier);
> +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, cxlr);
> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.

> 

