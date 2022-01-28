Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E91C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 17:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiA1Rwt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 12:52:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4553 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243013AbiA1Rwt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 12:52:49 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JllLF0ls6z67brf;
        Sat, 29 Jan 2022 01:48:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 18:52:46 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 17:52:46 +0000
Date:   Fri, 28 Jan 2022 17:52:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 09/42] hw/cxl/device: Timestamp implementation
 (8.2.9.3)
Message-ID: <20220128175245.00007f6b@huawei.com>
In-Reply-To: <874k5pbdlh.fsf@linaro.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
        <20220124171705.10432-10-Jonathan.Cameron@huawei.com>
        <874k5pbdlh.fsf@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 27 Jan 2022 11:50:08 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > Per spec, timestamp appears to be a free-running counter from a value
> > set by the host via the Set Timestamp command (0301h). There are
> > references to the epoch, which seem like a red herring. Therefore, the
> > implementation implements the timestamp as freerunning counter from the
> > last value that was issued by the Set Timestamp command.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 53 +++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |  6 +++++
> >  2 files changed, 59 insertions(+)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 1a87846356..cea4b2a59c 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -43,6 +43,9 @@ enum {
> >          #define CLEAR_RECORDS   0x1
> >          #define GET_INTERRUPT_POLICY   0x2
> >          #define SET_INTERRUPT_POLICY   0x3
> > +    TIMESTAMP   = 0x03,
> > +        #define GET           0x0
> > +        #define SET           0x1
> >  };
> >  
> >  /* 8.2.8.4.5.1 Command Return Codes */
> > @@ -117,8 +120,11 @@ define_mailbox_handler_zeroed(EVENTS_GET_RECORDS, 0x20);
> >  define_mailbox_handler_nop(EVENTS_CLEAR_RECORDS);
> >  define_mailbox_handler_zeroed(EVENTS_GET_INTERRUPT_POLICY, 4);
> >  define_mailbox_handler_nop(EVENTS_SET_INTERRUPT_POLICY);
> > +declare_mailbox_handler(TIMESTAMP_GET);
> > +declare_mailbox_handler(TIMESTAMP_SET);
> >  
> >  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> > +#define IMMEDIATE_POLICY_CHANGE (1 << 3)
> >  #define IMMEDIATE_LOG_CHANGE (1 << 4)
> >  
> >  #define CXL_CMD(s, c, in, cel_effect) \
> > @@ -129,10 +135,57 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
> >      CXL_CMD(EVENTS, CLEAR_RECORDS, ~0, IMMEDIATE_LOG_CHANGE),
> >      CXL_CMD(EVENTS, GET_INTERRUPT_POLICY, 0, 0),
> >      CXL_CMD(EVENTS, SET_INTERRUPT_POLICY, 4, IMMEDIATE_CONFIG_CHANGE),
> > +    CXL_CMD(TIMESTAMP, GET, 0, 0),
> > +    CXL_CMD(TIMESTAMP, SET, 8, IMMEDIATE_POLICY_CHANGE),
> >  };
> >  
> >  #undef CXL_CMD
> >  
> > +/*
> > + * 8.2.9.3.1
> > + */
> > +define_mailbox_handler(TIMESTAMP_GET)
> > +{
> > +    struct timespec ts;
> > +    uint64_t delta;
> > +
> > +    if (!cxl_dstate->timestamp.set) {
> > +        *(uint64_t *)cmd->payload = 0;
> > +        goto done;
> > +    }
> > +
> > +    /* First find the delta from the last time the host set the time. */
> > +    clock_gettime(CLOCK_REALTIME, &ts);  
> 
> Could you consider using qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)?
> Otherwise by introducing a dependency on real time you'll loose the
> ability to get deterministic execution via icount.

I don't have a strong opinion either way, so Ill go with 
qemu_clock_get_ns() and see if any comments on it in v5.

I've also updated the commit message as the catch all errata
which was F4 included a clarification that the timestamp
was as implemented here.

Thanks,

Jonathan
 

