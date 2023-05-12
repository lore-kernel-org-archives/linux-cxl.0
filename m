Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD17EC77B7F
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbjELPrr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbjELPrq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 11:47:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1130CF
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 08:47:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHt32097cz67Ct9;
        Fri, 12 May 2023 23:29:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 16:30:43 +0100
Date:   Fri, 12 May 2023 16:30:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 12/14] cxl: Store QTG IDs and related info to the CXL
 memory device context
Message-ID: <20230512163042.0000456e@Huawei.com>
In-Reply-To: <168357888523.2756219.11912716889990252182.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357888523.2756219.11912716889990252182.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 08 May 2023 13:48:05 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
> the return package. Create a list of entries in the cxl_memdev context and
> store the QTG ID and the associated DPA range. This information can be
> exposed to user space via sysfs in order to help region setup for
> hot-plugged CXL memory devices.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Trivial inline but my suggestion of needing to carry the full list
will apply here too...

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 001dabf0231b..9d77b7e420ce 100644
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
> @@ -215,6 +216,19 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/**
> + * struct perf_prop - performance property entry
> + * @list - list entry
> + * @dpa_range - range for DPA address
> + * @qos_class - QoS Class cookie

coord?

Run a W=1 build and it will moan about this sort of missing description.

> + */
> +struct perf_prop_entry {
> +	struct list_head list;
> +	struct range dpa_range;
> +	u16 qos_class;
> +	struct access_coordinate coord;
> +};
> +

