Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA0C25B4E
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 17:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjAXRXl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjAXRXg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 12:23:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBBB4A1E3
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 09:23:33 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1YC92jRXz67mcQ;
        Wed, 25 Jan 2023 01:01:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 17:04:25 +0000
Date:   Tue, 24 Jan 2023 17:04:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 5/8] hw/cxl/events: Wire up get/clear event mailbox
 commands
Message-ID: <20230124170425.00003e66@Huawei.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-5-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
        <20221221-ira-cxl-events-2022-11-17-v2-5-2ce2ecc06219@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Dec 2022 20:24:35 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> CXL testing is benefited from an artificial event log injection
> mechanism.
> 
> Add an event log infrastructure to insert, get, and clear events from
> the various logs available on a device.
> 
> Replace the stubbed out CXL Get/Clear Event mailbox commands with
> commands that operate on the new infrastructure.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Hi Ira,

Before I forget.

In similar fashion to discussion on poison overflow timestamps,
the timestamping in here should take into account the
set timestamp command results so should look like the code
in cmd_timestamp_get()

https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-mailbox-utils.c#L165

One other trivial comment inline.

Not sure if you are going to get back to these.  I'm happy to just hack these
changes in if that is easier for you.

Thanks,

Jonathan

> 
> ---
> Change from RFC:
> 	Process multiple records per Get/Set per the spec
> 	Rework all the calls to be within events.c
> 	Add locking around the event logs to ensure that the log
> 		integrity is maintained
> ---

>
> +/*
> + * return if an interrupt should be generated as a result of inserting this
> + * event.
> + */
> +bool cxl_event_insert(CXLDeviceState *cxlds,
> +                      enum cxl_event_log_type log_type,
> +                      struct cxl_event_record_raw *event)
> +{
> +    uint64_t time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
As noted, this needs to be more complex to take into account that host
and device timestamp base can be different (or it might not
be set at all for the device yet).

> +    struct cxl_event_log *log;
> +    CXLEvent *entry;
> +
> +    if (log_type >= CXL_EVENT_TYPE_MAX) {
> +        return false;
> +    }
> +
> +    log = &cxlds->event_logs[log_type];
> +
> +    QEMU_LOCK_GUARD(&log->lock);
> +
> +    if (cxl_event_count(log) >= CXL_TEST_EVENT_OVERFLOW) {
> +        if (log->overflow_err_count == 0) {
> +            log->first_overflow_timestamp = time;
> +        }
> +        log->overflow_err_count++;
> +        log->last_overflow_timestamp = time;
> +        return false;
> +    }
> +
> +    entry = g_new0(CXLEvent, 1);
> +    if (!entry) {

No need to check. g_new0 failure results in application termination.
https://libsoup.org/glib/glib-Memory-Allocation.html

(this got pointed out to me the other day in an internal code review!)

> +        error_report("Failed to allocate memory for event log entry");
> +        return false;
> +    }
