Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADC9C6FA92
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Sep 2022 14:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiIVOWG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiIVOWA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Sep 2022 10:22:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989EF3731
        for <linux-cxl@vger.kernel.org>; Thu, 22 Sep 2022 07:21:58 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYHR92wN2z689Rn;
        Thu, 22 Sep 2022 22:17:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:21:56 +0200
Received: from localhost (10.81.208.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 15:21:56 +0100
Date:   Thu, 22 Sep 2022 15:21:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/7] ndctl: cxl: add monitor support for trace events
Message-ID: <20220922152154.00007386@huawei.com>
In-Reply-To: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 14 Sep 2022 13:47:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> This patch series for ndctl implements the monitor command for the cxl tool.
> The initial implementation will collect CXL trace events emitted by the
> kernel. libtraceevent and libtracefs will be used to parse the trace
> event buffer. The monitor will pend on an epoll fd and wait for new event
> entries to be posted. The output will be in json format. By default the events
> are emitted to stdio, but can also be logged to a file. Each event is converted
> to a JSON object and logged as such. All the fields exported are read by the
> monitor code and added to the JSON object.

Hi Dave,

FYI, I just wanted to mention that we will be aiming to duplicate a bunch
of this functionality in rasdaemon.

As that is handling the equivalent of many of these events on our systems
from other components we don't want to grab the data via alternative tooling
and then have to merge it later.

Absolutely not a problem to have it in this tool as well. I mostly wanted
to raise it because longer term we'll need to be careful to test with both
solutions if there are any changes to what they are being sent.

Thanks,

Jonathan

> 
> ---
> 
> Dave Jiang (7):
>       ndctl: cxl: add helper function to parse trace event to json object
>       ndctl: cxl: add helper to parse through all current events
>       ndctl: cxl: add common function to enable event trace
>       ndctl: cxl: add common function to disable event trace
>       ndctl: cxl: add monitor function for event trace events
>       ndctl: cxl: add logging functions for monitor
>       ndctl: cxl: add monitor command to cxl
> 
> 
>  cxl/builtin.h     |   1 +
>  cxl/cxl.c         |   1 +
>  cxl/event_trace.c | 236 ++++++++++++++++++++++++++++++++++++++++++++++
>  cxl/event_trace.h |  23 +++++
>  cxl/meson.build   |   4 +
>  cxl/monitor.c     | 235 +++++++++++++++++++++++++++++++++++++++++++++
>  meson.build       |   3 +
>  7 files changed, 503 insertions(+)
>  create mode 100644 cxl/event_trace.c
>  create mode 100644 cxl/event_trace.h
>  create mode 100644 cxl/monitor.c
> 
> --
> 

