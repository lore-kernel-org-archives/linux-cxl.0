Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DA1C7EE24
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 13:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbjFFNyc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjFFNyc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 09:54:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BFEE7E
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 06:54:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbBk33GGxz67QqC;
        Tue,  6 Jun 2023 21:52:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 14:54:25 +0100
Date:   Tue, 6 Jun 2023 14:54:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 10/19] cxl/memdev: Indicate probe deferral
Message-ID: <20230606145425.000067b8@Huawei.com>
In-Reply-To: <168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:32:32 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The first stop for a CXL accelerator driver that wants to establish new
> CXL.mem regions is to register a 'struct cxl_memdev'. That kicks off
> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
> topology up to the root.
> 
> If the root driver has not attached yet the expectation is that the
> driver waits until that link is established. The common cxl_pci driver
> has reason to keep the 'struct cxl_memdev' device attached to the bus
> until the root driver attaches. An accelerator may want to instead defer
> probing until CXL resources can be acquired.
> 
> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
> accelerator driver probing should be deferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
> 
> The first consumer of this API is a test driver that exercises the CXL
> Type-2 flow.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c   |    2 +-
>  drivers/cxl/cxlmem.h      |    2 ++
>  drivers/cxl/mem.c         |    7 +++++--
>  4 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 65a685e5616f..859c43c340bb 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -609,6 +609,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited
> + * a probe deferral awaiting the arrival of the CXL root driver
> + */
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);

Whilst the above comment talks about deferred, there are paths where it's
potentially another error pointer currently.  Maybe suppress those at
source so the comment is 'precise' or make the comment above incorporate
those other error pointers.

> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		goto err_endpoint;
> +
> +	return endpoint;
> +
> +err_endpoint:
> +	device_unlock(&endpoint->dev);
> +err:
> +	device_unlock(&cxlmd->dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
> +
>  __init int cxl_memdev_init(void)
>  {
>  	dev_t devt;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6720ab22a494..5e21b53362e6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1336,7 +1336,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		 */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	parent_port = find_cxl_port(dparent, &parent_dport);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 7ee78e79933c..e3bcd6d12a1c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -83,6 +83,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport);
>  }
>  
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 584f9eec57e4..2470c6f2621c 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -154,13 +154,16 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	if (rc) {
> +		cxlmd->endpoint = ERR_PTR(rc);

This can be other errors than defer.  Which seems inconsistent
for the above check.

>  		return rc;
> +	}
>  
>  	parent_port = cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
> -		return -ENXIO;
> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
> +		return -EPROBE_DEFER;

This is a little inelegant as we aren't setting this in the same
function as were the endpoint is otherwise set up.  
Partly that's a naming thing.  In wonder if can pull out the bit
related to the endpoint from cxl_mem_probe() to a new
cxl_mem_ep_probe() at which case this will feel more logical.
That would be fine for this case, but the one above doesn't
really work for that...

Perhaps this is the best that can be done.


>  	}
>  
>  	if (dport->rch)
> 

