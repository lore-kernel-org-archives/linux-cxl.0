Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5329AC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 10:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiLSKHk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSKHj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 05:07:39 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245326FC
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 02:07:37 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbFhr21b1z6H7dv;
        Mon, 19 Dec 2022 18:06:04 +0800 (CST)
Received: from localhost (10.45.149.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 10:07:26 +0000
Date:   Mon, 19 Dec 2022 10:07:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 3/6] hw/cxl/cxl-events: Add CXL mock events
Message-ID: <20221219100723.000021a9@Huawei.com>
In-Reply-To: <20221010222944.3923556-4-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
        <20221010222944.3923556-4-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.149.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 10 Oct 2022 15:29:41 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> To facilitate testing of guest software add mock events and code to
> support iterating through the event logs.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

An FYI for the next version as I hit an issue with this when
testing resets (there are lots of other issues with resets
but this one crashed QEMU :)

> ---

> +static void event_store_add_event(CXLDeviceState *cxlds,
> +                                  enum cxl_event_log_type log_type,
> +                                  struct cxl_event_record_raw *event)
> +{
> +    struct cxl_event_log *log;
> +
> +    assert(log_type < CXL_EVENT_TYPE_MAX);
> +
> +    log = &cxlds->event_logs[log_type];
> +    assert(log->nr_events < CXL_TEST_EVENT_CNT_MAX);

This assert triggers on a reset as the function is called without
clearing the buffer first.

I'd suggest moving the setup of any dummy events over to a code
path that isn't run on reset.


> +
> +    log->events[log->nr_events] = event;
> +    log->nr_events++;
> +}

