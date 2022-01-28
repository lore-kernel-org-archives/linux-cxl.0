Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BEC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 16:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349936AbiA1Qro convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:47:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4551 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350234AbiA1Qro (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 11:47:44 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jljv81lLXz67Wgc;
        Sat, 29 Jan 2022 00:43:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 17:47:42 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 16:47:41 +0000
Date:   Fri, 28 Jan 2022 16:47:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>
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
        Samarth Saxena <samarths@cadence.com>
Subject: Re: [PATCH v4 10/42] hw/cxl/device: Add log commands (8.2.9.4) +
 CEL
Message-ID: <20220128164740.00001707@huawei.com>
In-Reply-To: <87zgnh9yno.fsf@linaro.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
        <20220124171705.10432-11-Jonathan.Cameron@huawei.com>
        <87zgnh9yno.fsf@linaro.org>
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

On Thu, 27 Jan 2022 11:55:47 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > CXL specification provides for the ability to obtain logs from the
> > device. Logs are either spec defined, like the "Command Effects Log"
> > (CEL), or vendor specific. UUIDs are defined for all log types.
> >
> > The CEL is a mechanism to provide information to the host about which
> > commands are supported. It is useful both to determine which spec'd
> > optional commands are supported, as well as provide a list of vendor
> > specified commands that might be used. The CEL is already created as
> > part of mailbox initialization, but here it is now exported to hosts
> > that use these log commands.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 67 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index cea4b2a59c..0ab0592e6c 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -46,6 +46,9 @@ enum {
> >      TIMESTAMP   = 0x03,
> >          #define GET           0x0
> >          #define SET           0x1
> > +    LOGS        = 0x04,
> > +        #define GET_SUPPORTED 0x0
> > +        #define GET_LOG       0x1
> >  };
> >  
> >  /* 8.2.8.4.5.1 Command Return Codes */
> > @@ -122,6 +125,8 @@ define_mailbox_handler_zeroed(EVENTS_GET_INTERRUPT_POLICY, 4);
> >  define_mailbox_handler_nop(EVENTS_SET_INTERRUPT_POLICY);
> >  declare_mailbox_handler(TIMESTAMP_GET);
> >  declare_mailbox_handler(TIMESTAMP_SET);
> > +declare_mailbox_handler(LOGS_GET_SUPPORTED);
> > +declare_mailbox_handler(LOGS_GET_LOG);
> >  
> >  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -137,6 +142,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
> >      CXL_CMD(EVENTS, SET_INTERRUPT_POLICY, 4, IMMEDIATE_CONFIG_CHANGE),
> >      CXL_CMD(TIMESTAMP, GET, 0, 0),
> >      CXL_CMD(TIMESTAMP, SET, 8, IMMEDIATE_POLICY_CHANGE),
> > +    CXL_CMD(LOGS, GET_SUPPORTED, 0, 0),
> > +    CXL_CMD(LOGS, GET_LOG, 0x18, 0),
> >  };
> >  
> >  #undef CXL_CMD
> > @@ -188,6 +195,66 @@ define_mailbox_handler(TIMESTAMP_SET)
> >  
> >  QemuUUID cel_uuid;
> >  
> > +/* 8.2.9.4.1 */
> > +define_mailbox_handler(LOGS_GET_SUPPORTED)
> > +{  
> 
> Here is where I get a bit wary of the define_mailbox_handler define
> which from what I can tell just hides the declarations. This makes the
> handling of things like *cmd rather opaque. There is an argument for the
> boilerplate definitions (_nop and _zeroed) but perhaps not these.

Agreed. I think these macros got a bit too clever.

I debated keeping the CXL_CMD one but that then forces us to have
ugly mixed lower case and upper case function names, so I've dropped that
as well.

I'm debating whether to go with
[EVENTS][GET] = ...
[EVENTS][SET] = ...

vs 
[EVENTS] = {
    [GET] = { ..
    [SET] = { ..
},

For now I'll go with the [][] variant. The other one may make more
sense as we add more commands.

Reorganizing the code a little gets rid of the need for the forward
declarations as well so end result is less code than with the macros
even if a few corners are a little repetitive.

Thanks,

Jonathan

> 
> > +    struct {
> > +        uint16_t entries;
> > +        uint8_t rsvd[6];
> > +        struct {
> > +            QemuUUID uuid;
> > +            uint32_t size;
> > +        } log_entries[1];
> > +    } __attribute__((packed)) *supported_logs = (void *)cmd->payload;
> > +    _Static_assert(sizeof(*supported_logs) == 0x1c, "Bad supported log size");
> > +
> > +    supported_logs->entries = 1;
> > +    supported_logs->log_entries[0].uuid = cel_uuid;
> > +    supported_logs->log_entries[0].size = 4 * cxl_dstate->cel_size;
> > +
> > +    *len = sizeof(*supported_logs);
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> > +/* 8.2.9.4.2 */
> > +define_mailbox_handler(LOGS_GET_LOG)
> > +{
> > +    struct {
> > +        QemuUUID uuid;
> > +        uint32_t offset;
> > +        uint32_t length;
> > +    } __attribute__((packed, __aligned__(16))) *get_log = (void *)cmd->payload;
> > +
> > +    /*
> > +     * 8.2.9.4.2
> > +     *   The device shall return Invalid Parameter if the Offset or Length
> > +     *   fields attempt to access beyond the size of the log as reported by Get
> > +     *   Supported Logs.
> > +     *
> > +     * XXX: Spec is wrong, "Invalid Parameter" isn't a thing.
> > +     * XXX: Spec doesn't address incorrect UUID incorrectness.
> > +     *
> > +     * The CEL buffer is large enough to fit all commands in the emulation, so
> > +     * the only possible failure would be if the mailbox itself isn't big
> > +     * enough.
> > +     */
> > +    if (get_log->offset + get_log->length > cxl_dstate->payload_size) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
> > +        return CXL_MBOX_UNSUPPORTED;
> > +    }
> > +
> > +    /* Store off everything to local variables so we can wipe out the payload */
> > +    *len = get_log->length;
> > +
> > +    memmove(cmd->payload, cxl_dstate->cel_log + get_log->offset,
> > +           get_log->length);
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> >  {
> >      uint16_t ret = CXL_MBOX_SUCCESS;  
> 
> 

