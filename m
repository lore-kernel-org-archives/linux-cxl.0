Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7291D6A1
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23927ED2
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 09:17:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S6WmT68lSz6H8xD;
	Sat, 14 Oct 2023 00:14:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 13 Oct
 2023 17:17:42 +0100
Date: Fri, 13 Oct 2023 17:17:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Fan Ni <fan.ni@gmx.us>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	Philippe Mathieu-Daud? <philmd@linaro.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Gregory Price <gregory.price@memverge.com>, "Klaus
 Jensen" <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>, "Klaus
 Jensen" <k.jensen@samsung.com>
Subject: Re: [PATCH 04/19] hw/cxl/mbox: Generalize the CCI command
 processing
Message-ID: <20231013171741.000029ce@Huawei.com>
In-Reply-To: <ZRXEKxUTwrP_8U0v@debian>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
	<20230925161124.18940-5-Jonathan.Cameron@huawei.com>
	<ZRXEKxUTwrP_8U0v@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 28 Sep 2023 11:21:31 -0700
Fan Ni <fan.ni@gmx.us> wrote:

> On Mon, Sep 25, 2023 at 05:11:09PM +0100, Jonathan Cameron wrote:
> > By moving the parts of the mailbox command handling that are CCI type
> > specific out to the caller, make the main handling code generic. Rename it
> > to cxl_process_cci_message() to reflect this new generality.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---  
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Thanks!

Unfortunately I've changed how this works for v2.
The aliasing of the mailbox buffer into both the input and output
payload lead to an annoying bug when I was implementing
Get Physical Port State via a tunnel from the Switch CCI.
Having wasted too much time (as I'd forgotten this aliased) I've
changed this code to take a snapshot of the input data instead.
Cleanup is simplified using a g_autofree().

I should be ready to post a new version early next week with this
in place.

Generally I've expanded my testing and the supported commands
etc so hit a bunch of cases where the many many length values in nested
tunneling (there are 5+ IIRC) either didn't correspond to each other
or weren't being read.

I'm not sure a uf real implementation is obliged to check the stuff
that is redundant information, but we probably want QEMU to do so.

Jonathan

> 
> >  include/hw/cxl/cxl_device.h |  5 +++-
> >  hw/cxl/cxl-device-utils.c   | 51 ++++++++++++++++++++++++++++++++++++-
> >  hw/cxl/cxl-mailbox-utils.c  | 43 ++++++++-----------------------
> >  3 files changed, 64 insertions(+), 35 deletions(-)
> >
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index c883d9dd8f..0e3f6c3c0b 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -270,7 +270,10 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
> >
> >  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> > -void cxl_process_mailbox(CXLCCI *cci);
> > +int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
> > +                            size_t len_in, uint8_t *pl_in,
> > +                            size_t *len_out, uint8_t *pl_out,
> > +                            bool *bg_started);
> >
> >  #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
> >      do {                                                                   \
> > diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> > index 327949a805..f3a6e17154 100644
> > --- a/hw/cxl/cxl-device-utils.c
> > +++ b/hw/cxl/cxl-device-utils.c
> > @@ -79,6 +79,25 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
> >      case 4:
> >          return cxl_dstate->mbox_reg_state32[offset / size];
> >      case 8:
> > +        if (offset == A_CXL_DEV_BG_CMD_STS) {
> > +            uint64_t bg_status_reg;
> > +            bg_status_reg = FIELD_DP64(0, CXL_DEV_BG_CMD_STS, OP,
> > +                                       cci->bg.opcode);
> > +            bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
> > +                                       PERCENTAGE_COMP, cci->bg.complete_pct);
> > +            bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
> > +                                       RET_CODE, cci->bg.ret_code);
> > +            /* endian? */
> > +            cxl_dstate->mbox_reg_state64[offset / size] = bg_status_reg;
> > +        }
> > +        if (offset == A_CXL_DEV_MAILBOX_STS) {
> > +            uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
> > +            if (cci->bg.complete_pct) {
> > +                status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
> > +                                        0);
> > +                cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
> > +            }
> > +        }
> >          return cxl_dstate->mbox_reg_state64[offset / size];
> >      default:
> >          g_assert_not_reached();
> > @@ -157,7 +176,37 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >
> >      if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
> >                           DOORBELL)) {
> > -        cxl_process_mailbox(cci);
> > +        uint64_t command_reg =
> > +            cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
> > +        uint8_t cmd_set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD,
> > +                                     COMMAND_SET);
> > +        uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
> > +        size_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
> > +        uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
> > +        size_t len_out;
> > +        uint64_t status_reg;
> > +        bool bg_started;
> > +        int rc;
> > +
> > +        rc = cxl_process_cci_message(cci, cmd_set, cmd, len_in, pl,
> > +                                     &len_out, pl, &bg_started);
> > +
> > +        /* Set bg and the return code */
> > +        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP,
> > +                                bg_started ? 1 : 0);
> > +        status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, ERRNO, rc);
> > +        /* Set the return length */
> > +        command_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_CMD, COMMAND_SET, cmd_set);
> > +        command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD,
> > +                                 COMMAND, cmd);
> > +        command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD,
> > +                                 LENGTH, len_out);
> > +
> > +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
> > +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
> > +        /* Tell the host we're done */
> > +        ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
> > +                         DOORBELL, 0);
> >      }
> >  }
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 376367c118..239acc659d 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -754,50 +754,27 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >          cmd_media_clear_poison, 72, 0 },
> >  };
> >
> > -void cxl_process_mailbox(CXLCCI *cci)
> > +int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
> > +                            size_t len_in, uint8_t *pl_in, size_t *len_out,
> > +                            uint8_t *pl_out, bool *bg_started)
> >  {
> > -    uint16_t ret = CXL_MBOX_SUCCESS;
> >      const struct cxl_cmd *cxl_cmd;
> > -    uint64_t status_reg = 0;
> >      opcode_handler h;
> > -    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
> > -    uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
> > -
> > -    uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
> > -    uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
> > -    uint16_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
> > -    uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
> > -    size_t len_out = 0;
> >
> > +    *len_out = 0;
> >      cxl_cmd = &cci->cxl_cmd_set[set][cmd];
> >      h = cxl_cmd->handler;
> > -    if (h) {
> > -        if (len_in == cxl_cmd->in || cxl_cmd->in == ~0) {
> > -            ret = (*h)(cxl_cmd, pl, len_in, pl, &len_out, cci);
> > -            assert(len_out <= cci->payload_max);
> > -        } else {
> > -            ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > -        }
> > -    } else {
> > +    if (!h) {
> >          qemu_log_mask(LOG_UNIMP, "Command %04xh not implemented\n",
> >                        set << 8 | cmd);
> > -        ret = CXL_MBOX_UNSUPPORTED;
> > +        return CXL_MBOX_UNSUPPORTED;
> >      }
> >
> > -    /* Set the return code */
> > -    status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
> > -
> > -    /* Set the return length */
> > -    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
> > -    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, 0);
> > -    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len_out);
> > -
> > -    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
> > -    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
> > +    if (len_in != cxl_cmd->in && cxl_cmd->in != ~0) {
> > +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > +    }
> >
> > -    /* Tell the host we're done */
> > -    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
> > -                     DOORBELL, 0);
> > +    return (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
> >  }
> >
> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> > --
> > 2.39.2
> >  

