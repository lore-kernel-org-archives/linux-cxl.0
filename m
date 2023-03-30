Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A7BC6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 19:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjC3TDP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjC3TDM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 15:03:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC5DF76C
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 12:03:09 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnXlY5Bf0z6J9Tw;
        Fri, 31 Mar 2023 02:59:21 +0800 (CST)
Received: from localhost (10.195.247.161) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 20:03:06 +0100
Date:   Thu, 30 Mar 2023 20:03:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 04/12] cxl/memdev: Trace inject and clear poison as
 cxl_poison events
Message-ID: <20230330200306.00005575@Huawei.com>
In-Reply-To: <9074fc4d2ac3fb1aa1c4db7ea55fba85c4f3864a.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
        <9074fc4d2ac3fb1aa1c4db7ea55fba85c4f3864a.1679892337.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.247.161]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 26 Mar 2023 22:03:10 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> The cxl_poison trace event allows users to view the history of poison
> list reads. With the addition of inject and clear poison capabilities,
> users will expect similar tracing.
> 
> Add trace types 'Inject' and 'Clear' to the cxl_poison trace_event and
> trace successful operations only.
> 
> If the driver finds that the DPA being injected or cleared of poison
> is mapped in a region, that region info is included in the cxl_poison
> trace event. Region reconfigurations can make this extra info useless
> if the debug operations are not carefully managed.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Ok. I guess adding this info makes sense for debug logs.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/core.h   |  2 ++
>  drivers/cxl/core/memdev.c | 16 ++++++++++++++++
>  drivers/cxl/core/trace.h  |  8 +++++---
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 57bd22e01a0b..5b673eca8f12 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -71,6 +71,8 @@ void cxl_mbox_init(void);
>  
>  enum cxl_poison_trace_type {
>  	CXL_POISON_TRACE_LIST,
> +	CXL_POISON_TRACE_INJECT,
> +	CXL_POISON_TRACE_CLEAR,
>  };
>  
>  struct cxl_trigger_poison_context {
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a83619c31f61..71ebe3795616 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -6,6 +6,7 @@
>  #include <linux/idr.h>
>  #include <linux/pci.h>
>  #include <cxlmem.h>
> +#include "trace.h"
>  #include "core.h"
>  
>  static DECLARE_RWSEM(cxl_memdev_rwsem);
> @@ -285,6 +286,7 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_mbox_inject_poison inject;
> +	struct cxl_poison_record record;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_region *cxlr;
>  	int rc;
> @@ -313,6 +315,13 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
>  	if (cxlr)
>  		dev_warn_once(dev, "poison inject dpa:0x%llx region: %s\n",
>  			      dpa, dev_name(&cxlr->dev));
> +
> +	record = (struct cxl_poison_record) {
> +		.address = cpu_to_le64(dpa),
> +		.length = cpu_to_le32(1),
> +	};
> +	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
> +
>  out:
>  	up_read(&cxl_dpa_rwsem);
>  
> @@ -324,6 +333,7 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_mbox_clear_poison clear;
> +	struct cxl_poison_record record;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_region *cxlr;
>  	int rc;
> @@ -363,6 +373,12 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
>  	if (cxlr)
>  		dev_warn_once(dev, "poison clear dpa:0x%llx region: %s\n",
>  			      dpa, dev_name(&cxlr->dev));
> +
> +	record = (struct cxl_poison_record) {
> +		.address = cpu_to_le64(dpa),
> +		.length = cpu_to_le32(1),
> +	};
> +	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
>  out:
>  	up_read(&cxl_dpa_rwsem);
>  
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 65d81d27cb85..5e5e29995d3e 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -602,9 +602,11 @@ TRACE_EVENT(cxl_memory_module,
>  	)
>  );
>  
> -#define show_poison_trace_type(type)		   \
> -	__print_symbolic(type,			   \
> -	{ CXL_POISON_TRACE_LIST,	"List"	})
> +#define show_poison_trace_type(type)			\
> +	__print_symbolic(type,				\
> +	{ CXL_POISON_TRACE_LIST,	"List"   },	\
> +	{ CXL_POISON_TRACE_INJECT,	"Inject" },	\
> +	{ CXL_POISON_TRACE_CLEAR,	"Clear"  })
>  
>  #define __show_poison_source(source)                          \
>  	__print_symbolic(source,                              \

