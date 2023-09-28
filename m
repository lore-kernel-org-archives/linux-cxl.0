Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD7E732FD
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Sep 2023 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjI1RpJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Sep 2023 13:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1RpI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Sep 2023 13:45:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEEDDD
        for <linux-cxl@vger.kernel.org>; Thu, 28 Sep 2023 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us; s=s31663417;
 t=1695923062; x=1696527862; i=fan.ni@gmx.us;
 bh=ujZuSH7pJTuERoyk1zrQYazejmFdOmpFJ5KjSYZMjqQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=N7et0/CO3ipRi3VOPGv3RuSgD5gknP/UMhgMXY2kofsvh8a1JvCLXpybkeDNev6IcsNLgh03ve5
 3C/1El6yqAZkE/2279UAS7ICE/LhUT3FWDmnoPp6NZzRkuxFdWlG6iLe0KhBHRV0cvrvZbMtfqpiG
 k2fC7aKSYwxXBhhubg4Y1wX8ZBIgcNULeenOlGibg6GM8s8qbrZGOnBYlqWfi93+o1PuT1VvI+n+p
 IYCEvUQ2qNKWv9UBt3xyNuR8oM8ZqiIXEAN8lhCGZWKxNYTM9Vyrw1GdfXUXe0tOvsm65zq4PFtas
 O/6JPPGja64gTIbmYWxRXUZsdbvT8ZDvxxXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbg4-1r4gMj1IT6-00Kxtz; Thu, 28
 Sep 2023 19:44:21 +0200
Date:   Thu, 28 Sep 2023 10:44:07 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Michael Tsirkin <mst@redhat.com>, linuxarm@huawei.com,
        Fan Ni <fan.ni@samsung.com>,
        Philippe Mathieu-Daud? <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 03/19] hw/cxl/mbox: Pull the CCI definition out of the
 CXLDeviceState
Message-ID: <ZRW7Zz-otBXXPcY-@debian>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
 <20230925161124.18940-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925161124.18940-4-Jonathan.Cameron@huawei.com>
X-Provags-ID: V03:K1:1Ha3u1ceO3qsAZKzX99E9RF9wJc67SZOKdnqYHCP97uPXFCNANF
 zByQDLtcisLRAmyXnfVcfxw3wXzOYE8rTKoHys4lZ2FNSZa3woEjaSMsAHUGrntmnhFwHH4
 bCAite6VvlIp10tNlofMobBxi7/ROGKZ2UN1QTS1xVuoBI7vOU1+bVLZOHUDWBmzt6+rptz
 n1kMYDlhgIGLPy4WRPP2A==
UI-OutboundReport: notjunk:1;M01:P0:jrL1rh+Mdms=;0pyerTgJPwVTbl4nBK3xywdtjGN
 oUUSd+OU9eGCMSKMEZ3pzN/3uTbSQhLNBXojyFnHu9QY6qxQ8pLrG+9he8wvCcWJg6a1pYTpD
 0SeKHD/Y9jnByKx2FquhioGLV7wuOdsHdyz2a0H9gZBdbdG+vcl3O+z1DB0wU5MiIrcA96hNH
 LAIvLJZ4SjqCml15kjj6s/1C3QR8shfVfHoHiWTwBdfyjzabxXPkxXZw0v5rvO1e4iRj2gNog
 HBy8Y0bpQnV7D+6Cf/V4reEXtkgGU+9ZDBMVPiGFsCIcw5obnWniucD39BNGNbNRa7u2FQDYd
 B7mHda8Q8gu/2PKeZEfDxnELFgKH0TZYjhaLnm3I9LDu0qMJVBKCGFWHwF8jVcTZsheS6IiOP
 sCZLeZCv0Bs5b8ru4FDWALJiamtxugZGDPzOGpAP25V0hpaO0kVZpE2Klcj+6RlvpA2y3oNd/
 TGX7f7IOOCqTvXsaYT8ULgTSWU4sYyV+jValIpwsnqJgHnkyUh3RmFBjk7Xu359zBtAs9SVXh
 urxxscrShhDQ607F7ti9IS8b8jS2T6FC+L29rm+9nv1OmN9nMXLprjjc+LyMILJZUA0b+vbtx
 iSlxN0Fvac2EvFNbE+N69bcjVcbB8/36Q+7npMBKTJ4TJ9jBRE/1M/4XNBRpzDeCLhCnThHB0
 LnSDhzjpoaIA8MSHRUBEtL2sS98H4npMNowms3Ods6rXsFITQe/m1v3HfkcnY9auc/2Bh3n8x
 tLIHarsesxOVSu4hOWW43ti0pDqV3fanE3243jEqsd4VDQkzbxwG51JfJpOxgQiKVeLwlklUk
 GYvPLKafEJammVQnGlXoefe8ra17TDuhtpvk6MCIk5NV42T3w+LoJ27TIZkPEsLtB5qJgwKcz
 olNyFwwKOfQoM7OlAJQqUWsunm+J9uGRGDj48FE6KgP04Qr1QnZBkivCwmSnTJP1n0djreQ5P
 /IHaZw9H3oNmIlBDoowld6a92Bg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 25, 2023 at 05:11:08PM +0100, Jonathan Cameron wrote:
> Enables having multiple CCIs per devices. Each CCI (mailbox) has it's ow=
n
> state and command list, so they can't share a single structure.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_device.h | 45 ++++++++++++++----
>  hw/cxl/cxl-device-utils.c   | 31 +++++++++---
>  hw/cxl/cxl-mailbox-utils.c  | 94 ++++++++++++++++++++++---------------
>  hw/mem/cxl_type3.c          |  5 +-
>  4 files changed, 119 insertions(+), 56 deletions(-)
>
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index d7a2c4009e..c883d9dd8f 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -111,12 +111,13 @@ typedef enum {
>      CXL_MBOX_MAX =3D 0x17
>  } CXLRetCode;
>
> +typedef struct CXLCCI CXLCCI;
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;
>  typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
>                                       uint8_t *payload_in, size_t len_in=
,
>                                       uint8_t *payload_out, size_t *len_=
out,
> -                                     CXLDeviceState *cxl_dstate);
> +                                     CXLCCI *cci);
>  struct cxl_cmd {
>      const char *name;
>      opcode_handler handler;
> @@ -140,6 +141,31 @@ typedef struct CXLEventLog {
>      QSIMPLEQ_HEAD(, CXLEvent) events;
>  } CXLEventLog;
>
> +typedef struct CXLCCI {
> +    const struct cxl_cmd (*cxl_cmd_set)[256];
> +    struct cel_log {
> +        uint16_t opcode;
> +        uint16_t effect;
> +    } cel_log[1 << 16];
> +    size_t cel_size;
> +
> +    /* background command handling (times in ms) */
> +    struct {
> +        uint16_t opcode;
> +        uint16_t complete_pct;
> +        uint16_t ret_code; /* Current value of retcode */
> +        uint64_t starttime;
> +        /* set by each bg cmd, cleared by the bg_timer when complete */
> +        uint64_t runtime;
> +        QEMUTimer *timer;
> +    } bg;
> +    size_t payload_max;
> +    /* Pointer to device hosting the CCI */
> +    DeviceState *d;
> +    /* Pointer to the device hosting the protocol conversion */
> +    DeviceState *intf;
> +} CXLCCI;
> +
>  typedef struct cxl_device_state {
>      MemoryRegion device_registers;
>
> @@ -173,11 +199,6 @@ typedef struct cxl_device_state {
>              uint32_t mbox_reg_state32[CXL_MAILBOX_REGISTERS_LENGTH / 4]=
;
>              uint64_t mbox_reg_state64[CXL_MAILBOX_REGISTERS_LENGTH / 8]=
;
>          };
> -        struct cel_log {
> -            uint16_t opcode;
> -            uint16_t effect;
> -        } cel_log[1 << 16];
> -        size_t cel_size;
>      };
>
>      struct {
> @@ -196,10 +217,12 @@ typedef struct cxl_device_state {
>  } CXLDeviceState;
>
>  /* Initialize the register block for a device */
> -void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);
> +void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
> +                                    CXLCCI *cci);
>
> +typedef struct CXLType3Dev CXLType3Dev;
>  /* Set up default values for the register block */
> -void cxl_device_register_init_common(CXLDeviceState *dev);
> +void cxl_device_register_init_t3(CXLType3Dev *ct3d);
>
>  /*
>   * CXL 2.0 - 8.2.8.1 including errata F4
> @@ -245,8 +268,9 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
>                                        CXL_DEVICE_CAP_HDR1_OFFSET +
>                                            CXL_DEVICE_CAP_REG_SIZE * 2)
>
> -void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
> -void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
> +void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payl=
oad_max);
> +void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> +void cxl_process_mailbox(CXLCCI *cci);
>
>  #define cxl_device_cap_init(dstate, reg, cap_id, ver)                  =
    \
>      do {                                                               =
    \
> @@ -347,6 +371,7 @@ struct CXLType3Dev {
>      AddressSpace hostpmem_as;
>      CXLComponentState cxl_cstate;
>      CXLDeviceState cxl_dstate;
> +    CXLCCI cci; /* Primary PCI mailbox CCI */
>
>      /* DOE */
>      DOECap doe_cdat;
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index eb7195272e..327949a805 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -62,7 +62,14 @@ static uint64_t dev_reg_read(void *opaque, hwaddr off=
set, unsigned size)
>
>  static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned =
size)
>  {
> -    CXLDeviceState *cxl_dstate =3D opaque;
> +    CXLDeviceState *cxl_dstate;
> +    CXLCCI *cci =3D opaque;
> +
> +    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
> +        cxl_dstate =3D &CXL_TYPE3(cci->intf)->cxl_dstate;
> +    } else {
> +        return 0;
> +    }
>
>      switch (size) {
>      case 1:
> @@ -123,7 +130,14 @@ static void mailbox_mem_writeq(uint64_t *reg_state,=
 hwaddr offset,
>  static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t val=
ue,
>                                unsigned size)
>  {
> -    CXLDeviceState *cxl_dstate =3D opaque;
> +    CXLDeviceState *cxl_dstate;
> +    CXLCCI *cci =3D opaque;
> +
> +    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
> +        cxl_dstate =3D &CXL_TYPE3(cci->intf)->cxl_dstate;
> +    } else {
> +        return;
> +    }
>
>      if (offset >=3D A_CXL_DEV_CMD_PAYLOAD) {
>          memcpy(cxl_dstate->mbox_reg_state + offset, &value, size);
> @@ -143,7 +157,7 @@ static void mailbox_reg_write(void *opaque, hwaddr o=
ffset, uint64_t value,
>
>      if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_=
CTRL,
>                           DOORBELL)) {
> -        cxl_process_mailbox(cxl_dstate);
> +        cxl_process_mailbox(cci);
>      }
>  }
>
> @@ -223,7 +237,8 @@ static const MemoryRegionOps caps_ops =3D {
>      },
>  };
>
> -void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_ds=
tate)
> +void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_ds=
tate,
> +                                    CXLCCI *cci)
>  {
>      /* This will be a BAR, so needs to be rounded up to pow2 for PCI sp=
ec */
>      memory_region_init(&cxl_dstate->device_registers, obj, "device-regi=
sters",
> @@ -233,7 +248,7 @@ void cxl_device_register_block_init(Object *obj, CXL=
DeviceState *cxl_dstate)
>                            "cap-array", CXL_CAPS_SIZE);
>      memory_region_init_io(&cxl_dstate->device, obj, &dev_ops, cxl_dstat=
e,
>                            "device-status", CXL_DEVICE_STATUS_REGISTERS_=
LENGTH);
> -    memory_region_init_io(&cxl_dstate->mailbox, obj, &mailbox_ops, cxl_=
dstate,
> +    memory_region_init_io(&cxl_dstate->mailbox, obj, &mailbox_ops, cci,
>                            "mailbox", CXL_MAILBOX_REGISTERS_LENGTH);
>      memory_region_init_io(&cxl_dstate->memory_device, obj, &mdev_ops,
>                            cxl_dstate, "memory device caps",
> @@ -284,8 +299,9 @@ static void mailbox_reg_init_common(CXLDeviceState *=
cxl_dstate)
>
>  static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
>
> -void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
> +void cxl_device_register_init_t3(CXLType3Dev *ct3d)
>  {
> +    CXLDeviceState *cxl_dstate =3D &ct3d->cxl_dstate;
>      uint64_t *cap_h =3D cxl_dstate->caps_reg_state64;
>      const int cap_count =3D 3;
>
> @@ -303,7 +319,8 @@ void cxl_device_register_init_common(CXLDeviceState =
*cxl_dstate)
>      cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
>      memdev_reg_init_common(cxl_dstate);
>
> -    cxl_initialize_mailbox(cxl_dstate);
> +    cxl_initialize_mailbox_t3(&ct3d->cci, DEVICE(ct3d),
> +                              CXL_MAILBOX_MAX_PAYLOAD_SIZE);
>  }
>
>  uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4bdbc2ee83..376367c118 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -73,8 +73,9 @@ enum {
>  static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in, size_t le=
n_in,
>                                           uint8_t *payload_out, size_t *=
len_out,
> -                                         CXLDeviceState *cxlds)
> +                                         CXLCCI *cci)
>  {
> +    CXLDeviceState *cxlds =3D &CXL_TYPE3(cci->d)->cxl_dstate;
>      CXLGetEventPayload *pl;
>      uint8_t log_type;
>      int max_recs;
> @@ -102,8 +103,9 @@ static CXLRetCode cmd_events_clear_records(const str=
uct cxl_cmd *cmd,
>                                             size_t len_in,
>                                             uint8_t *payload_out,
>                                             size_t *len_out,
> -                                           CXLDeviceState *cxlds)
> +                                           CXLCCI *cci)
>  {
> +    CXLDeviceState *cxlds =3D &CXL_TYPE3(cci->d)->cxl_dstate;
>      CXLClearEventPayload *pl;
>
>      pl =3D (CXLClearEventPayload *)payload_in;
> @@ -116,8 +118,9 @@ static CXLRetCode cmd_events_get_interrupt_policy(co=
nst struct cxl_cmd *cmd,
>                                                    size_t len_in,
>                                                    uint8_t *payload_out,
>                                                    size_t *len_out,
> -                                                  CXLDeviceState *cxlds=
)
> +                                                  CXLCCI *cci)
>  {
> +    CXLDeviceState *cxlds =3D &CXL_TYPE3(cci->d)->cxl_dstate;
>      CXLEventInterruptPolicy *policy;
>      CXLEventLog *log;
>
> @@ -159,8 +162,9 @@ static CXLRetCode cmd_events_set_interrupt_policy(co=
nst struct cxl_cmd *cmd,
>                                                    size_t len_in,
>                                                    uint8_t *payload_out,
>                                                    size_t *len_out,
> -                                                  CXLDeviceState *cxlds=
)
> +                                                  CXLCCI *cci)
>  {
> +    CXLDeviceState *cxlds =3D &CXL_TYPE3(cci->d)->cxl_dstate;
>      CXLEventInterruptPolicy *policy;
>      CXLEventLog *log;
>
> @@ -205,8 +209,9 @@ static CXLRetCode cmd_firmware_update_get_info(const=
 struct cxl_cmd *cmd,
>                                                 size_t len,
>                                                 uint8_t *payload_out,
>                                                 size_t *len_out,
> -                                               CXLDeviceState *cxl_dsta=
te)
> +                                               CXLCCI *cci)
>  {
> +    CXLDeviceState *cxl_dstate =3D &CXL_TYPE3(cci->d)->cxl_dstate;
>      struct {
>          uint8_t slots_supported;
>          uint8_t slot_info;
> @@ -242,8 +247,9 @@ static CXLRetCode cmd_timestamp_get(const struct cxl=
_cmd *cmd,
>                                      size_t len_in,
>                                      uint8_t *payload_out,
>                                      size_t *len_out,
> -                                    CXLDeviceState *cxl_dstate)
> +                                    CXLCCI *cci)
>  {
> +    CXLDeviceState *cxl_dstate =3D &CXL_TYPE3(cci->d)->cxl_dstate;
>      uint64_t final_time =3D cxl_device_get_timestamp(cxl_dstate);
>
>      stq_le_p(payload_out, final_time);
> @@ -258,8 +264,10 @@ static CXLRetCode cmd_timestamp_set(const struct cx=
l_cmd *cmd,
>                                      size_t len_in,
>                                      uint8_t *payload_out,
>                                      size_t *len_out,
> -                                    CXLDeviceState *cxl_dstate)
> +                                    CXLCCI *cci)
>  {
> +    CXLDeviceState *cxl_dstate =3D &CXL_TYPE3(cci->d)->cxl_dstate;
> +
>      cxl_dstate->timestamp.set =3D true;
>      cxl_dstate->timestamp.last_set =3D qemu_clock_get_ns(QEMU_CLOCK_VIR=
TUAL);
>
> @@ -281,7 +289,7 @@ static CXLRetCode cmd_logs_get_supported(const struc=
t cxl_cmd *cmd,
>                                           size_t len_in,
>                                           uint8_t *payload_out,
>                                           size_t *len_out,
> -                                         CXLDeviceState *cxl_dstate)
> +                                         CXLCCI *cci)
>  {
>      struct {
>          uint16_t entries;
> @@ -295,7 +303,7 @@ static CXLRetCode cmd_logs_get_supported(const struc=
t cxl_cmd *cmd,
>
>      supported_logs->entries =3D 1;
>      supported_logs->log_entries[0].uuid =3D cel_uuid;
> -    supported_logs->log_entries[0].size =3D 4 * cxl_dstate->cel_size;
> +    supported_logs->log_entries[0].size =3D 4 * cci->cel_size;
>
>      *len_out =3D sizeof(*supported_logs);
>      return CXL_MBOX_SUCCESS;
> @@ -307,7 +315,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_=
cmd *cmd,
>                                     size_t len_in,
>                                     uint8_t *payload_out,
>                                     size_t *len_out,
> -                                   CXLDeviceState *cxl_dstate)
> +                                   CXLCCI *cci)
>  {
>      struct {
>          QemuUUID uuid;
> @@ -330,7 +338,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_=
cmd *cmd,
>       * the only possible failure would be if the mailbox itself isn't b=
ig
>       * enough.
>       */
> -    if (get_log->offset + get_log->length > cxl_dstate->payload_size) {
> +    if (get_log->offset + get_log->length > cci->payload_max) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>
> @@ -341,8 +349,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_=
cmd *cmd,
>      /* Store off everything to local variables so we can wipe out the p=
ayload */
>      *len_out =3D get_log->length;
>
> -    memmove(payload_out, cxl_dstate->cel_log + get_log->offset,
> -            get_log->length);
> +    memmove(payload_out, cci->cel_log + get_log->offset, get_log->lengt=
h);
>
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -353,7 +360,7 @@ static CXLRetCode cmd_identify_memory_device(const s=
truct cxl_cmd *cmd,
>                                               size_t len_in,
>                                               uint8_t *payload_out,
>                                               size_t *len_out,
> -                                             CXLDeviceState *cxl_dstate=
)
> +                                             CXLCCI *cci)
>  {
>      struct {
>          char fw_revision[0x10];
> @@ -372,9 +379,9 @@ static CXLRetCode cmd_identify_memory_device(const s=
truct cxl_cmd *cmd,
>          uint8_t qos_telemetry_caps;
>      } QEMU_PACKED *id;
>      QEMU_BUILD_BUG_ON(sizeof(*id) !=3D 0x43);
> -
> -    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dst=
ate);
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
>      CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
> +    CXLDeviceState *cxl_dstate =3D &ct3d->cxl_dstate;
>
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIE=
R)) ||
>          (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIE=
R))) {
> @@ -407,8 +414,9 @@ static CXLRetCode cmd_ccls_get_partition_info(const =
struct cxl_cmd *cmd,
>                                                size_t len_in,
>                                                uint8_t *payload_out,
>                                                size_t *len_out,
> -                                              CXLDeviceState *cxl_dstat=
e)
> +                                              CXLCCI *cci)
>  {
> +    CXLDeviceState *cxl_dstate =3D &CXL_TYPE3(cci->d)->cxl_dstate;
>      struct {
>          uint64_t active_vmem;
>          uint64_t active_pmem;
> @@ -442,13 +450,13 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cx=
l_cmd *cmd,
>                                     size_t len_in,
>                                     uint8_t *payload_out,
>                                     size_t *len_out,
> -                                   CXLDeviceState *cxl_dstate)
> +                                   CXLCCI *cci)
>  {
>      struct {
>          uint32_t offset;
>          uint32_t length;
>      } QEMU_PACKED *get_lsa;
> -    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dst=
ate);
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
>      CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
>      uint32_t offset, length;
>
> @@ -470,7 +478,7 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_=
cmd *cmd,
>                                     size_t len_in,
>                                     uint8_t *payload_out,
>                                     size_t *len_out,
> -                                   CXLDeviceState *cxl_dstate)
> +                                   CXLCCI *cci)
>  {
>      struct set_lsa_pl {
>          uint32_t offset;
> @@ -478,7 +486,7 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_=
cmd *cmd,
>          uint8_t data[];
>      } QEMU_PACKED;
>      struct set_lsa_pl *set_lsa_payload =3D (void *)payload_in;
> -    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dst=
ate);
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
>      CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
>      const size_t hdr_len =3D offsetof(struct set_lsa_pl, data);
>
> @@ -507,7 +515,7 @@ static CXLRetCode cmd_media_get_poison_list(const st=
ruct cxl_cmd *cmd,
>                                              size_t len_in,
>                                              uint8_t *payload_out,
>                                              size_t *len_out,
> -                                            CXLDeviceState *cxl_dstate)
> +                                            CXLCCI *cci)
>  {
>      struct get_poison_list_pl {
>          uint64_t pa;
> @@ -529,7 +537,7 @@ static CXLRetCode cmd_media_get_poison_list(const st=
ruct cxl_cmd *cmd,
>
>      struct get_poison_list_pl *in =3D (void *)payload_in;
>      struct get_poison_list_out_pl *out =3D (void *)payload_out;
> -    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dst=
ate);
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
>      uint16_t record_count =3D 0, i =3D 0;
>      uint64_t query_start, query_length;
>      CXLPoisonList *poison_list =3D &ct3d->poison_list;
> @@ -586,9 +594,9 @@ static CXLRetCode cmd_media_inject_poison(const stru=
ct cxl_cmd *cmd,
>                                            size_t len_in,
>                                            uint8_t *payload_out,
>                                            size_t *len_out,
> -                                          CXLDeviceState *cxl_dstate)
> +                                          CXLCCI *cci)
>  {
> -    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dst=
ate);
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
>      CXLPoisonList *poison_list =3D &ct3d->poison_list;
>      CXLPoison *ent;
>      struct inject_poison_pl {
> @@ -629,9 +637,10 @@ static CXLRetCode cmd_media_clear_poison(const stru=
ct cxl_cmd *cmd,
>                                           size_t len_in,
>                                           uint8_t *payload_out,
>                                           size_t *len_out,
> -                                         CXLDeviceState *cxl_dstate)
> +                                         CXLCCI *cci)
>  {
> -    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dst=
ate);
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> +    CXLDeviceState *cxl_dstate =3D &ct3d->cxl_dstate;
>      CXLPoisonList *poison_list =3D &ct3d->poison_list;
>      CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
>      struct clear_poison_pl {
> @@ -745,12 +754,13 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
>          cmd_media_clear_poison, 72, 0 },
>  };
>
> -void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> +void cxl_process_mailbox(CXLCCI *cci)
>  {
>      uint16_t ret =3D CXL_MBOX_SUCCESS;
>      const struct cxl_cmd *cxl_cmd;
>      uint64_t status_reg =3D 0;
>      opcode_handler h;
> +    CXLDeviceState *cxl_dstate =3D &CXL_TYPE3(cci->d)->cxl_dstate;
>      uint64_t command_reg =3D cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAI=
LBOX_CMD];
>
>      uint8_t set =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAN=
D_SET);
> @@ -759,12 +769,12 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstat=
e)
>      uint8_t *pl =3D cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
>      size_t len_out =3D 0;
>
> -    cxl_cmd =3D &cxl_dstate->cxl_cmd_set[set][cmd];
> +    cxl_cmd =3D &cci->cxl_cmd_set[set][cmd];
>      h =3D cxl_cmd->handler;
>      if (h) {
>          if (len_in =3D=3D cxl_cmd->in || cxl_cmd->in =3D=3D ~0) {
> -            ret =3D (*h)(cxl_cmd, pl, len_in, pl, &len_out, cxl_dstate)=
;
> -            assert(len_out <=3D cxl_dstate->payload_size);
> +            ret =3D (*h)(cxl_cmd, pl, len_in, pl, &len_out, cci);
> +            assert(len_out <=3D cci->payload_max);
>          } else {
>              ret =3D CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>          }
> @@ -790,20 +800,30 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstat=
e)
>                       DOORBELL, 0);
>  }
>
> -void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
> +void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>  {
> -    cxl_dstate->cxl_cmd_set =3D cxl_cmd_set;
> +    cci->payload_max =3D payload_max;
>      for (int set =3D 0; set < 256; set++) {
>          for (int cmd =3D 0; cmd < 256; cmd++) {
> -            if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
> -                const struct cxl_cmd *c =3D &cxl_dstate->cxl_cmd_set[se=
t][cmd];
> +            if (cci->cxl_cmd_set[set][cmd].handler) {
> +                const struct cxl_cmd *c =3D &cci->cxl_cmd_set[set][cmd]=
;
>                  struct cel_log *log =3D
> -                    &cxl_dstate->cel_log[cxl_dstate->cel_size];
> +                    &cci->cel_log[cci->cel_size];
>
>                  log->opcode =3D (set << 8) | cmd;
>                  log->effect =3D c->effect;
> -                cxl_dstate->cel_size++;
> +                cci->cel_size++;
>              }
>          }
>      }
>  }
> +
> +void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payl=
oad_max)
> +{
> +    cci->cxl_cmd_set =3D cxl_cmd_set;
> +    cci->d =3D d;
> +
> +    /* No separation for PCI MB as protocol handled in PCI device */
> +    cci->intf =3D d;
> +    cxl_init_cci(cci, payload_max);
> +}
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 18ad853f5b..0529745786 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -716,7 +716,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **=
errp)
>          pci_dev, CXL_COMPONENT_REG_BAR_IDX,
>          PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, m=
r);
>
> -    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate);
> +    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate,
> +                                   &ct3d->cci);
>      pci_register_bar(pci_dev, CXL_DEVICE_REG_BAR_IDX,
>                       PCI_BASE_ADDRESS_SPACE_MEMORY |
>                           PCI_BASE_ADDRESS_MEM_TYPE_64,
> @@ -922,7 +923,7 @@ static void ct3d_reset(DeviceState *dev)
>      uint32_t *write_msk =3D ct3d->cxl_cstate.crb.cache_mem_regs_write_m=
ask;
>
>      cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3=
_DEVICE);
> -    cxl_device_register_init_common(&ct3d->cxl_dstate);
> +    cxl_device_register_init_t3(ct3d);
>  }
>
>  static Property ct3_props[] =3D {
> --
> 2.39.2
>
