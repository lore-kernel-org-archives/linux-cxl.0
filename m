Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6991C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 14:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjFAOcV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjFAOcU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 10:32:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C3298
        for <linux-cxl@vger.kernel.org>; Thu,  1 Jun 2023 07:32:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX7pH42Szz685S1;
        Thu,  1 Jun 2023 22:30:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 15:32:15 +0100
Date:   Thu, 1 Jun 2023 15:32:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v6 09/11] cxl: Store QTG IDs and related info to the CXL
 memory device context
Message-ID: <20230601153214.00003782@Huawei.com>
In-Reply-To: <168451604884.3470703.10173844932484539394.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
        <168451604884.3470703.10173844932484539394.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 10:07:28 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
> the return package. Create a list of entries in the cxl_memdev context and
> store the QTG ID and the associated DPA range. This information can be
> exposed to user space via sysfs in order to help region setup for
> hot-plugged CXL memory devices.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v6:
> - Store entire QTG ID list
> v4:
> - Remove unused qos_list from cxl_md
> v3:
> - Move back to QTG ID per partition
> ---
>  drivers/cxl/core/mbox.c |    1 +
>  drivers/cxl/cxlmem.h    |   23 +++++++++++++++++++++++
>  drivers/cxl/port.c      |   38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2c8dc7e2b84d..35941a306ea8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1260,6 +1260,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	mutex_init(&cxlds->mbox_mutex);
>  	mutex_init(&cxlds->event.log_lock);
>  	cxlds->dev = dev;
> +	INIT_LIST_HEAD(&cxlds->perf_list);
>  
>  	return cxlds;
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a2845a7a69d8..708d60c5ffe1 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -5,6 +5,7 @@
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/cdev.h>
>  #include <linux/uuid.h>
> +#include <linux/node.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -254,6 +255,21 @@ struct cxl_poison_state {
>  	struct mutex lock;  /* Protect reads of poison list */
>  };
>  
> +/**
> + * struct perf_prop - performance property entry
> + * @list - list entry
> + * @dpa_range - range for DPA address
> + * @coord - QoS performance data (i.e. latency, bandwidth)
> + * @qos_class - QoS Class cookies
> + */
> +struct perf_prop_entry {
> +	struct list_head list;
> +	struct range dpa_range;
> +	struct access_coordinate coord;
> +	/* Do not add members below this, contains flex array */
> +	struct qos_class qos_class;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -292,6 +308,9 @@ struct cxl_poison_state {
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
> + * @ram_qos_class: QoS class cookies for volatile region
> + * @pmem_qos_class: QoS class cookies for persistent region
> + * @perf_list: performance data entries list
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
> @@ -325,6 +344,10 @@ struct cxl_dev_state {
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
>  
> +	struct qos_class *ram_qos_class;
> +	struct qos_class *pmem_qos_class;
> +	struct list_head perf_list;
> +
>  	resource_size_t component_reg_phys;
>  	u64 serial;
>  
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 03af92217192..e5d7ad5b1e16 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -104,6 +104,42 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  	return 0;
>  }
>  
> +static void cxl_memdev_set_qtg(struct cxl_dev_state *cxlds, struct list_head *dsmas_list)
> +{
> +	struct range pmem_range = {
> +		.start = cxlds->pmem_res.start,
> +		.end = cxlds->pmem_res.end,
> +	};
> +	struct range ram_range = {
> +		.start = cxlds->ram_res.start,
> +		.end = cxlds->ram_res.end,
> +	};
> +	struct perf_prop_entry *perf;
> +	struct dsmas_entry *dent;
> +
> +	list_for_each_entry(dent, dsmas_list, list) {
> +		perf = devm_kzalloc(cxlds->dev,
> +				    sizeof(*perf) + dent->qos_class->nr * sizeof(int),
> +				    GFP_KERNEL);
> +		if (!perf)
> +			return;
> +
> +		perf->dpa_range = dent->dpa_range;
> +		perf->coord = dent->coord;
> +		perf->qos_class = *dent->qos_class;
> +		list_add_tail(&perf->list, &cxlds->perf_list);
> +
> +		if (resource_size(&cxlds->ram_res) &&
> +		    range_contains(&ram_range, &dent->dpa_range) &&
> +		    !cxlds->ram_qos_class)
> +			cxlds->ram_qos_class = &perf->qos_class;
> +		else if (resource_size(&cxlds->pmem_res) &&
> +			 range_contains(&pmem_range, &dent->dpa_range) &&
> +			 !cxlds->pmem_qos_class)
> +			cxlds->pmem_qos_class = &perf->qos_class;
> +	}
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -197,6 +233,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  			if (rc)
>  				dev_dbg(&port->dev,
>  					"Failed to do perf coord calculations.\n");
> +			else
> +				cxl_memdev_set_qtg(cxlds, &dsmas_list);
>  		}
>  
>  		cxl_cdat_dsmas_list_destroy(&dsmas_list);
> 
> 

