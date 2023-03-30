Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AA9C6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 17:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjC3Rfv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjC3Rfv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 13:35:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AFE6A47
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 10:35:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnVpn5d6nz6J9ZP;
        Fri, 31 Mar 2023 01:32:01 +0800 (CST)
Received: from localhost (10.48.159.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 18:35:46 +0100
Date:   Thu, 30 Mar 2023 18:35:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/port: Fix find_cxl_root() for RCDs and simplify it
Message-ID: <20230330183545.00003b06@Huawei.com>
In-Reply-To: <168002857715.50647.344876437247313909.stgit@dwillia2-xfh.jf.intel.com>
References: <168002857715.50647.344876437247313909.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.159.148]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 28 Mar 2023 11:36:17 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The find_cxl_root() helper is used to lookup root decoders and other CXL
> platform topology information for a given endpoint. It turns out that
> for RCDs it has never worked. The result of find_cxl_root(&cxlmd->dev)
> is always NULL for the RCH topology case because it expects to find a
> cxl_port at the host-bridge. RCH topologies only have the root cxl_port
> object with the host-bridge as a dport. While there are no reports of
> this being a problem to date, by inspection region enumeration should
> crash as a result of this problem, and it does in a local unit test for
> this scenario.
> 
> However, an observation that ever since:
> 
> commit f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> 
> ...all callers of find_cxl_root() occur after the memdev connection to
> the port topology has been established. That means that find_cxl_root()
> can be simplified to a walk of the endpoint port topology to the root.
> Switch to that arrangement which also fixes the RCD bug.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Even without the bug fix being needed (I've not chased that one through)
seems like a good simplification to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pmem.c   |    6 +++---
>  drivers/cxl/core/port.c   |   38 +++++++-------------------------------
>  drivers/cxl/core/region.c |    2 +-
>  drivers/cxl/cxl.h         |    4 ++--
>  drivers/cxl/port.c        |    2 +-
>  5 files changed, 14 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index c2e4b1093788..f8c38d997252 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -62,9 +62,9 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
>  	return is_cxl_nvdimm_bridge(dev);
>  }
>  
> -struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct device *start)
> +struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>  {
> -	struct cxl_port *port = find_cxl_root(start);
> +	struct cxl_port *port = find_cxl_root(dev_get_drvdata(&cxlmd->dev));
>  	struct device *dev;
>  
>  	if (!port)
> @@ -253,7 +253,7 @@ int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
>  	struct device *dev;
>  	int rc;
>  
> -	cxl_nvb = cxl_find_nvdimm_bridge(&cxlmd->dev);
> +	cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
>  	if (!cxl_nvb)
>  		return -ENODEV;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8ee6b6e2e2a4..4d1f9c5b5029 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -823,41 +823,17 @@ static bool dev_is_cxl_root_child(struct device *dev)
>  	return false;
>  }
>  
> -/* Find a 2nd level CXL port that has a dport that is an ancestor of @match */
> -static int match_root_child(struct device *dev, const void *match)
> +struct cxl_port *find_cxl_root(struct cxl_port *port)
>  {
> -	const struct device *iter = NULL;
> -	struct cxl_dport *dport;
> -	struct cxl_port *port;
> -
> -	if (!dev_is_cxl_root_child(dev))
> -		return 0;
> -
> -	port = to_cxl_port(dev);
> -	iter = match;
> -	while (iter) {
> -		dport = cxl_find_dport_by_dev(port, iter);
> -		if (dport)
> -			break;
> -		iter = iter->parent;
> -	}
> -
> -	return !!iter;
> -}
> +	struct cxl_port *iter = port;
>  
> -struct cxl_port *find_cxl_root(struct device *dev)
> -{
> -	struct device *port_dev;
> -	struct cxl_port *root;
> +	while (iter && !is_cxl_root(iter))
> +		iter = to_cxl_port(iter->dev.parent);
>  
> -	port_dev = bus_find_device(&cxl_bus_type, NULL, dev, match_root_child);
> -	if (!port_dev)
> +	if (!iter)
>  		return NULL;
> -
> -	root = to_cxl_port(port_dev->parent);
> -	get_device(&root->dev);
> -	put_device(port_dev);
> -	return root;
> +	get_device(&iter->dev);
> +	return iter;
>  }
>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..808f23ec4e2b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2251,7 +2251,7 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  		 * bridge for one device is the same for all.
>  		 */
>  		if (i == 0) {
> -			cxl_nvb = cxl_find_nvdimm_bridge(&cxlmd->dev);
> +			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
>  			if (!cxl_nvb) {
>  				cxlr_pmem = ERR_PTR(-ENODEV);
>  				goto out;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f2b0962a552d..06ca12418f7d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -658,7 +658,7 @@ struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
>  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  				   resource_size_t component_reg_phys,
>  				   struct cxl_dport *parent_dport);
> -struct cxl_port *find_cxl_root(struct device *dev);
> +struct cxl_port *find_cxl_root(struct cxl_port *port);
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);
> @@ -758,7 +758,7 @@ struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
>  bool is_cxl_nvdimm(struct device *dev);
>  bool is_cxl_nvdimm_bridge(struct device *dev);
>  int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
> -struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct device *dev);
> +struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
>  
>  #ifdef CONFIG_CXL_REGION
>  bool is_cxl_pmem_region(struct device *dev);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 1049bb5ea496..f243132fb174 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -119,7 +119,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	 * This can't fail in practice as CXL root exit unregisters all
>  	 * descendant ports and that in turn synchronizes with cxl_port_probe()
>  	 */
> -	root = find_cxl_root(&cxlmd->dev);
> +	root = find_cxl_root(port);
>  
>  	/*
>  	 * Now that all endpoint decoders are successfully enumerated, try to
> 

