Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3265C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 10:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjEWKj5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 06:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjEWKj5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 06:39:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B640FF
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 03:39:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQW114f1Fz6J7Bm;
        Tue, 23 May 2023 18:35:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 23 May
 2023 11:39:49 +0100
Date:   Tue, 23 May 2023 11:39:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <nifan@outlook.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v7 3/7] hw/cxl/events: Wire up get/clear event mailbox
 commands
Message-ID: <20230523113948.000009f3@Huawei.com>
In-Reply-To: <SG2PR06MB3397AB10C301F4F596EBD688B2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
        <CGME20230522151125uscas1p1ac7cc62cf284544e2b827d7cacaba8cd@uscas1p1.samsung.com>
        <20230522150947.11546-4-Jonathan.Cameron@huawei.com>
        <SG2PR06MB3397AB10C301F4F596EBD688B2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 22 May 2023 12:50:34 -0700
Fan Ni <nifan@outlook.com> wrote:

> The 05/22/2023 16:09, Jonathan Cameron wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL testing is benefited from an artificial event log injection
> > mechanism.
> > 
> > Add an event log infrastructure to insert, get, and clear events from
> > the various logs available on a device.
> > 
> > Replace the stubbed out CXL Get/Clear Event mailbox commands with
> > commands that operate on the new infrastructure.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---  
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 
> See comments below in cxl_event_insert.

...

> > +    memcpy(&entry->data, event, sizeof(*event));
> > +
> > +    entry->data.hdr.handle = cpu_to_le16(log->next_handle);
> > +    log->next_handle++;
> > +    /* 0 handle is never valid */
> > +    if (log->next_handle == 0) {  
> 
> next_handle is uint16_t, how can it be 0 after next_handle++?

Intent was to deal with wrap around.
We are fine with reusing handles after sufficiently long time that
there can't be a confusion, just not 0 as that has special
meaning when used to 'point' to a related event
(see definition of Related Event Record Handle)

> 
> > +        log->next_handle++;
> > +    }
> > +    entry->data.hdr.timestamp = cpu_to_le64(time);
> > +
> > +    QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
> > +    cxl_event_set_status(cxlds, log_type, true);
> > +
> > +    /* Count went from 0 to 1 */
> > +    return cxl_event_count(log) == 1;
> > +}
