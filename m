Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E26C761A6
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 18:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjCaSx3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjCaSx3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 14:53:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443BDE3BD
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680288808; x=1711824808;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=16SGVW+bKTz/3Qtp5pOS/DsE32i1wlVCf8Wb2EbG19o=;
  b=kXfqUqWr8J2NCqhBKy8AtQAcZvTWsfvk1mEYgbr9c0hw4jOj0sNL6jHU
   sliUEaGrcIccBv11qFu9dnqRoiAXJC/DSa72VqPqeDf9mJepq7hOLJtXq
   l32tf2NLf+iIgcdtBQRnRstYOLXd7t2LNlgNh/9YMv46ZrfkFyf+RqRZG
   gsIgjaGbX7w237d0wnvtTtcxxL/rrf6qilK3w0ilOC830IrGSvnABNfDg
   Uxul8FAemI4P/RPARBRA5SC4femA0pRvMc63KBfEmMqOaWXRoaO8Q7BqT
   qL7mx2zjYVJDOocOUSfq1KemQWtFKV5hDa8xwaD7mT3JXOm7i2+jopQSt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343203722"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343203722"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 11:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="635396491"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="635396491"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 11:53:27 -0700
Message-ID: <1603daf5-cf49-19fb-a8ea-180ba2eef0a5@intel.com>
Date:   Fri, 31 Mar 2023 11:53:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 04/12] cxl/memdev: Trace inject and clear poison as
 cxl_poison events
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org
References: <cover.1679892337.git.alison.schofield@intel.com>
 <9074fc4d2ac3fb1aa1c4db7ea55fba85c4f3864a.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <9074fc4d2ac3fb1aa1c4db7ea55fba85c4f3864a.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/core.h   |  2 ++
>   drivers/cxl/core/memdev.c | 16 ++++++++++++++++
>   drivers/cxl/core/trace.h  |  8 +++++---
>   3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 57bd22e01a0b..5b673eca8f12 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -71,6 +71,8 @@ void cxl_mbox_init(void);
>   
>   enum cxl_poison_trace_type {
>   	CXL_POISON_TRACE_LIST,
> +	CXL_POISON_TRACE_INJECT,
> +	CXL_POISON_TRACE_CLEAR,
>   };
>   
>   struct cxl_trigger_poison_context {
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a83619c31f61..71ebe3795616 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -6,6 +6,7 @@
>   #include <linux/idr.h>
>   #include <linux/pci.h>
>   #include <cxlmem.h>
> +#include "trace.h"
>   #include "core.h"
>   
>   static DECLARE_RWSEM(cxl_memdev_rwsem);
> @@ -285,6 +286,7 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_mbox_inject_poison inject;
> +	struct cxl_poison_record record;
>   	struct cxl_mbox_cmd mbox_cmd;
>   	struct cxl_region *cxlr;
>   	int rc;
> @@ -313,6 +315,13 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
>   	if (cxlr)
>   		dev_warn_once(dev, "poison inject dpa:0x%llx region: %s\n",
>   			      dpa, dev_name(&cxlr->dev));
> +
> +	record = (struct cxl_poison_record) {
> +		.address = cpu_to_le64(dpa),
> +		.length = cpu_to_le32(1),
> +	};
> +	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
> +
>   out:
>   	up_read(&cxl_dpa_rwsem);
>   
> @@ -324,6 +333,7 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_mbox_clear_poison clear;
> +	struct cxl_poison_record record;
>   	struct cxl_mbox_cmd mbox_cmd;
>   	struct cxl_region *cxlr;
>   	int rc;
> @@ -363,6 +373,12 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
>   	if (cxlr)
>   		dev_warn_once(dev, "poison clear dpa:0x%llx region: %s\n",
>   			      dpa, dev_name(&cxlr->dev));
> +
> +	record = (struct cxl_poison_record) {
> +		.address = cpu_to_le64(dpa),
> +		.length = cpu_to_le32(1),
> +	};
> +	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
>   out:
>   	up_read(&cxl_dpa_rwsem);
>   
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 65d81d27cb85..5e5e29995d3e 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -602,9 +602,11 @@ TRACE_EVENT(cxl_memory_module,
>   	)
>   );
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
>   #define __show_poison_source(source)                          \
>   	__print_symbolic(source,                              \
