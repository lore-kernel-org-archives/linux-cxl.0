Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084BC05027
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 11:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjAZLuQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjAZLuP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 06:50:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421BD41098
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 03:50:14 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2f6j2nbZz6883d;
        Thu, 26 Jan 2023 19:46:05 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 11:50:12 +0000
Date:   Thu, 26 Jan 2023 11:50:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl: Remove check for g_new0() failure
Message-ID: <20230126115010.00005289@huawei.com>
In-Reply-To: <20230125-ira-cxl-events-fixups-2023-01-11-v1-2-1931378515f5@intel.com>
References: <20230125-ira-cxl-events-fixups-2023-01-11-v1-0-1931378515f5@intel.com>
        <20230125-ira-cxl-events-fixups-2023-01-11-v1-2-1931378515f5@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 25 Jan 2023 21:37:28 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> g_new0() will terminate the application if it fails.  Remove the check.
> 
> Fixes: fb64c5661d5f ("hw/cxl/events: Wire up get/clear event mailbox commands")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Squashed into original patch.  Thanks,

Jonathan

> ---
>  hw/cxl/cxl-events.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 2536aafc55fb..4cbc838e8ff4 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -124,13 +124,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds,
>      }
>  
>      entry = g_new0(CXLEvent, 1);
> -    if (!entry) {
> -        error_report("Failed to allocate memory for event log entry");
> -        return false;
> -    }
> -
>      memcpy(&entry->data, event, sizeof(*event));
> -
>      entry->data.hdr.handle = cpu_to_le16(log->next_handle);
>      log->next_handle++;
>      /* 0 handle is never valid */
> 

