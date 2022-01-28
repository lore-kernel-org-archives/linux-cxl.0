Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B9EC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 15:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiA1Pwa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:52:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4550 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349686AbiA1Pw3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 10:52:29 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JlhhN3N6Jz6802N;
        Fri, 28 Jan 2022 23:48:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 28 Jan 2022 16:52:26 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 15:52:25 +0000
Date:   Fri, 28 Jan 2022 15:52:24 +0000
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
Subject: Re: [PATCH v4 06/42] hw/cxl/device: Implement basic mailbox
 (8.2.8.4)
Message-ID: <20220128155224.0000667c@huawei.com>
In-Reply-To: <87pmoebagl.fsf@linaro.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
        <20220124171705.10432-7-Jonathan.Cameron@huawei.com>
        <87pmoebagl.fsf@linaro.org>
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

On Wed, 26 Jan 2022 18:22:18 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > This is the beginning of implementing mailbox support for CXL 2.0
> > devices. The implementation recognizes when the doorbell is rung,
> > handles the command/payload, clears the doorbell while returning error
> > codes and data.
> >
> > Generally the mailbox mechanism is designed to permit communication
> > between the host OS and the firmware running on the device. For our
> > purposes, we emulate both the firmware, implemented primarily in
> > cxl-mailbox-utils.c, and the hardware.
> >
> > No commands are implemented yet.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---

...

> > +static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
> > +                              unsigned size)
> > +{
> > +    CXLDeviceState *cxl_dstate = opaque;
> > +
> > +    if (offset >= A_CXL_DEV_CMD_PAYLOAD) {
> > +        memcpy(cxl_dstate->mbox_reg_state + offset, &value, size);
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Lock is needed to prevent concurrent writes as well as to prevent writes
> > +     * coming in while the firmware is processing. Without background commands
> > +     * or the second mailbox implemented, this serves no purpose since the
> > +     * memory access is synchronized at a higher level (per memory region).
> > +     */
> > +    RCU_READ_LOCK_GUARD();  
> 
> RCU_READ_LOCK doesn't prevent concurrent writes, although the BQL should.

Indeed, odd choice that I'd missed completely. I'm don't think we need anything
at all until we consider implementing background commands / secondary mailbox.
So for now I'll adjust the comment a little to say a lock 'would be needed'.
and take no lock at all.

> 
> > +
> > +    switch (size) {
> > +    case 4:
> > +        mailbox_mem_writel(cxl_dstate->mbox_reg_state32, offset, value);
> > +        break;
> > +    case 8:
> > +        mailbox_mem_writeq(cxl_dstate->mbox_reg_state64, offset, value);
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +
> > +    if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
> > +                         DOORBELL))
> > +        cxl_process_mailbox(cxl_dstate);
> > +}
> > +
> > +static const MemoryRegionOps mailbox_ops = {
> > +    .read = mailbox_reg_read,
> > +    .write = mailbox_reg_write,
> > +    .endianness = DEVICE_LITTLE_ENDIAN,
> > +    .valid = {
> > +        .min_access_size = 1,
> > +        .max_access_size = 8,
> > +        .unaligned = false,
> > +    },
> > +    .impl = {
> > +        .min_access_size = 1,
> > +        .max_access_size = 8,
> > +    },  
> 
> with_attrs?

As before I don't follow.  8 byte is maximum size so should be fine.

> 
> > +};
> > +
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > new file mode 100644
> > index 0000000000..2854682cbe
> > --- /dev/null
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -0,0 +1,201 @@
> > +/*
> > + * CXL Utility library for mailbox interface
> > + *
> > + * Copyright(C) 2020 Intel Corporation.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/cxl/cxl.h"
> > +#include "hw/pci/pci.h"
> > +#include "qemu/log.h"
> > +#include "qemu/uuid.h"
> > +
> > +/*
> > + * How to add a new command, example. The command set FOO, with cmd BAR.
> > + *  1. Add the command set and cmd to the enum.
> > + *     FOO    = 0x7f,
> > + *          #define BAR 0
> > + *  2. Forward declare the handler.
> > + *     declare_mailbox_handler(FOO_BAR);
> > + *  3. Add the command to the cxl_cmd_set[][]
> > + *     CXL_CMD(FOO, BAR, 0, 0),
> > + *  4. Implement your handler
> > + *     define_mailbox_handler(FOO_BAR) { ... return CXL_MBOX_SUCCESS; }
> > + *
> > + *
> > + *  Writing the handler:
> > + *    The handler will provide the &struct cxl_cmd, the &CXLDeviceState, and the
> > + *    in/out length of the payload. The handler is responsible for consuming the
> > + *    payload from cmd->payload and operating upon it as necessary. It must then
> > + *    fill the output data into cmd->payload (overwriting what was there),
> > + *    setting the length, and returning a valid return code.
> > + *
> > + *  XXX: The handler need not worry about endianess. The payload is read out of
> > + *  a register interface that already deals with it.
> > + */
> > +
> > +/* 8.2.8.4.5.1 Command Return Codes */
> > +typedef enum {
> > +    CXL_MBOX_SUCCESS = 0x0,
> > +    CXL_MBOX_BG_STARTED = 0x1,
> > +    CXL_MBOX_INVALID_INPUT = 0x2,
> > +    CXL_MBOX_UNSUPPORTED = 0x3,
> > +    CXL_MBOX_INTERNAL_ERROR = 0x4,
> > +    CXL_MBOX_RETRY_REQUIRED = 0x5,
> > +    CXL_MBOX_BUSY = 0x6,
> > +    CXL_MBOX_MEDIA_DISABLED = 0x7,
> > +    CXL_MBOX_FW_XFER_IN_PROGRESS = 0x8,
> > +    CXL_MBOX_FW_XFER_OUT_OF_ORDER = 0x9,
> > +    CXL_MBOX_FW_AUTH_FAILED = 0xa,
> > +    CXL_MBOX_FW_INVALID_SLOT = 0xb,
> > +    CXL_MBOX_FW_ROLLEDBACK = 0xc,
> > +    CXL_MBOX_FW_REST_REQD = 0xd,
> > +    CXL_MBOX_INVALID_HANDLE = 0xe,
> > +    CXL_MBOX_INVALID_PA = 0xf,
> > +    CXL_MBOX_INJECT_POISON_LIMIT = 0x10,
> > +    CXL_MBOX_PERMANENT_MEDIA_FAILURE = 0x11,
> > +    CXL_MBOX_ABORTED = 0x12,
> > +    CXL_MBOX_INVALID_SECURITY_STATE = 0x13,
> > +    CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
> > +    CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
> > +    CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
> > +    CXL_MBOX_MAX = 0x17
> > +} ret_code;
> > +
> > +struct cxl_cmd;
> > +typedef ret_code (*opcode_handler)(struct cxl_cmd *cmd,
> > +                                   CXLDeviceState *cxl_dstate, uint16_t *len);
> > +struct cxl_cmd {
> > +    const char *name;
> > +    opcode_handler handler;
> > +    ssize_t in;
> > +    uint16_t effect; /* Reported in CEL */
> > +    uint8_t *payload;
> > +};
> > +
> > +#define define_mailbox_handler(name)                \
> > +    static ret_code cmd_##name(struct cxl_cmd *cmd, \
> > +                               CXLDeviceState *cxl_dstate, uint16_t *len)
> > +#define declare_mailbox_handler(name) define_mailbox_handler(name)
> > +
> > +#define define_mailbox_handler_zeroed(name, size)                         \
> > +    uint16_t __zero##name = size;                                         \
> > +    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
> > +                               CXLDeviceState *cxl_dstate, uint16_t *len) \
> > +    {                                                                     \
> > +        *len = __zero##name;                                              \
> > +        memset(cmd->payload, 0, *len);                                    \
> > +        return CXL_MBOX_SUCCESS;                                          \
> > +    }
> > +#define define_mailbox_handler_const(name, data)                          \
> > +    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
> > +                               CXLDeviceState *cxl_dstate, uint16_t *len) \
> > +    {                                                                     \
> > +        *len = sizeof(data);                                              \
> > +        memcpy(cmd->payload, data, *len);                                 \
> > +        return CXL_MBOX_SUCCESS;                                          \
> > +    }
> > +#define define_mailbox_handler_nop(name)                                  \
> > +    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
> > +                               CXLDeviceState *cxl_dstate, uint16_t *len) \
> > +    {                                                                     \
> > +        return CXL_MBOX_SUCCESS;                                          \
> > +    }
> > +
> > +#define CXL_CMD(s, c, in, cel_effect) \
> > +    [s][c] = { stringify(s##_##c), cmd_##s##_##c, in, cel_effect }
> > +
> > +static struct cxl_cmd cxl_cmd_set[256][256] = {};
> > +
> > +#undef CXL_CMD
> > +
> > +QemuUUID cel_uuid;  
> 
> static?

done

> 
> but really this seems more like something that should be in a property
> of the device. Will it always be fixed or is it something the user might
> want to tweak?

It's fixed as it comes straight from the spec. I'll add a comment to make that clear
where the UUID is below.


> 
> > +
> > +void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> > +{
> > +    uint16_t ret = CXL_MBOX_SUCCESS;
> > +    struct cxl_cmd *cxl_cmd;
> > +    uint64_t status_reg;
> > +    opcode_handler h;
> > +
> > +    /*
> > +     * current state of mailbox interface
> > +     *  mbox_cap_reg = cxl_dstate->reg_state32[R_CXL_DEV_MAILBOX_CAP];
> > +     *  mbox_ctrl_reg = cxl_dstate->reg_state32[R_CXL_DEV_MAILBOX_CTRL];
> > +     *  status_reg = *(uint64_t *)&cxl_dstate->reg_state[A_CXL_DEV_MAILBOX_STS];
> > +     */
> > +    uint64_t command_reg =
> > +        *(uint64_t *)&cxl_dstate->mbox_reg_state[A_CXL_DEV_MAILBOX_CMD];
> > +
> > +    /* Check if we have to do anything */
> > +    if (!ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
> > +                          DOORBELL)) {
> > +        qemu_log_mask(LOG_UNIMP, "Corrupt internal state for
> > firmware\n");  
> 
> is this actually UNIMP or has something gone wrong internally or is the
> guest doing something wrong?

It can't happen. I'd guess this is probably a left over from some earlier
more complex implementation.

As things currently stand we only call this function if that bit is set.

I'll drop the check.

> 
> > +        return;
> > +    }
> > +
> > +    uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
> > +    uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
> > +    uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
> > +    cxl_cmd = &cxl_cmd_set[set][cmd];
> > +    h = cxl_cmd->handler;
> > +    if (!h) {
> > +        qemu_log_mask(LOG_UNIMP, "Command %04xh not implemented\n",
> > +                                 set << 8 | cmd);
> > +        goto handled;
> > +    }
> > +
> > +    if (len != cxl_cmd->in) {
> > +        ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > +    }
> > +
> > +    cxl_cmd->payload = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
> > +    ret = (*h)(cxl_cmd, cxl_dstate, &len);
> > +    assert(len <= cxl_dstate->payload_size);
> > +
> > +handled:
> > +    /*
> > +     * Set the return code
> > +     * XXX: it's a 64b register, but we're not setting the vendor, so we can get
> > +     * away with this
> > +     */
> > +    status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
> > +
> > +    /*
> > +     * Set the return length
> > +     */
> > +    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
> > +    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, 0);
> > +    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len);
> > +
> > +    cxl_dstate->mbox_reg_state64[A_CXL_DEV_MAILBOX_CMD / 8] = command_reg;
> > +    cxl_dstate->mbox_reg_state64[A_CXL_DEV_MAILBOX_STS / 8] = status_reg;
> > +
> > +    /* Tell the host we're done */
> > +    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
> > +                     DOORBELL, 0);
> > +}
> > +
> > +int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
> > +{
> > +    const char *cel_uuidstr = "0da9c0b5-bf41-4b78-8f79-96b1623b3f17";  
> 
> I'm curious as to where this magic number came from.

CXL 2.0: Table 169  There are a couple defined so far but this is the only
we've yet implemented in Qemu.

It has to be the same for all devices because this is a spec defined query.

> 
> > +
> > +    for (int set = 0; set < 256; set++) {
> > +        for (int cmd = 0; cmd < 256; cmd++) {
> > +            if (cxl_cmd_set[set][cmd].handler) {
> > +                struct cxl_cmd *c = &cxl_cmd_set[set][cmd];
> > +                struct cel_log *log =
> > +                    &cxl_dstate->cel_log[cxl_dstate->cel_size];
> > +
> > +                log->opcode = (set << 8) | cmd;
> > +                log->effect = c->effect;
> > +                cxl_dstate->cel_size++;
> > +            }
> > +        }
> > +    }
> > +
> > +    return qemu_uuid_parse(cel_uuidstr, &cel_uuid);
> > +}

...


