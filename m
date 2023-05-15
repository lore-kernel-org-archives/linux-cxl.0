Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE61C77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 11:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbjEOL4I (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbjEOLz2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 07:55:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A15930D1
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 04:49:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKczy2NSvz67lGm;
        Mon, 15 May 2023 19:47:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 12:49:11 +0100
Date:   Mon, 15 May 2023 12:49:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] hw/cxl: Add scan media mailbox command support
Message-ID: <20230515124910.0000138a@Huawei.com>
In-Reply-To: <20230426021418.10186-3-dave@stgolabs.net>
References: <20230426021418.10186-1-dave@stgolabs.net>
        <20230426021418.10186-3-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Apr 2023 19:14:17 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Trigger the background command and when done go about adding
> entries to the poison list, or not. Randonly decide how many
> random addresses to generate.

Hi Davidlohr,
I'm not keen on random when we have an injection interface already.
Just make the QMP qemu poison list injector allow injection beyond
the poison list overflow then random etc becomes a userspace test
script problem not one for QEMU to emulate.

> 
> Currently never udpate DRAM Event Log.
Yeah. That's true for poison in general.

All the patch sets got reordered so many times there wasn't a good
way to add that without dependencies. After everything is in place
I'd like to circle back and fix the log part up.

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>


Various things inline.  Biggest is I don't think the poison list clearing
is correct from my reading of the spec.

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 127 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |   3 +
>  include/hw/cxl/cxl_device.h |   8 +++
>  3 files changed, 135 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f346aa8ce3b2..7f29b840a2c9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -80,6 +80,7 @@ enum {
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
>          #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> +        #define SCAN_MEDIA             0x4
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -852,6 +853,9 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
>       */
>      QLIST_INSERT_HEAD(poison_list, p, node);
>      ct3d->poison_list_cnt++;
> +    if (scan_media_running(cxl_dstate)) {
> +        ct3d->poison_list_dirty = true;
> +    }
>  
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -932,6 +936,10 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      /* Any fragments have been added, free original entry */
>      g_free(ent);
>  
> +    if (scan_media_running(cxl_dstate)) {
> +        ct3d->poison_list_dirty = true;
> +    }
> +
>      return CXL_MBOX_SUCCESS;
>  }
>  
> @@ -974,6 +982,103 @@ cmd_media_get_scan_media_capabilities(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void __do_scan_media(CXLDeviceState *cxl_dstate)
> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent, *p;
> +    uint64_t dpa = 0;
> +    int n_dpas;
> +    GRand *rand;
> +
> +    rand = g_rand_new();
> +
> +    /* how many dpas to "detect" and add to the poison list */
> +    n_dpas = g_random_int_range(0, CXL_MBOX_INJECT_POISON_LIMIT/4);

Not sure we need to do this and it's a pain to use in testing given
random entries.  Maybe just let the QMP poison injection path
log a bunch more after the poison list is full?  That should give
us something nice and simple to test.  If you want random injection
then write a script to poke that interface appropriately.
 
> +
> +    do {
> +        /*
> +         * TODO: limit it within the device dpa space (same for
> +         * inject poison). For now generate some random address.
> +         */
> +    retry_dpa:
> +        dpa = (uint64_t)g_rand_int(rand) << 32 |(uint64_t)g_rand_int(rand);
> +        /* 64 byte alignment required */
> +        if (dpa & 0x3f) {
> +            goto retry_dpa;
> +        }
> +
> +        QLIST_FOREACH(ent, poison_list, node) {
> +            if (dpa >= ent->start &&
> +                dpa + 64 <= ent->start + ent->length) {
> +                goto retry_dpa;
> +            }
> +        }
> +
> +        p = g_new0(CXLPoison, 1);
> +
> +        p->length = 64;
> +        p->start = dpa;
> +        p->type = CXL_POISON_TYPE_SCANMEDIA;
> +
> +        QLIST_INSERT_HEAD(poison_list, p, node);
> +        ct3d->poison_list_cnt++;
> +    } while (--n_dpas);
> +
> +    g_rand_free(rand);
> +}
> +
> +static CXLRetCode
> +cmd_media_scan_media(struct cxl_cmd *cmd,
> +                     CXLDeviceState *cxl_dstate, uint16_t *len)
> +{
> +    struct scan_media_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +        uint8_t flags;
> +    } QEMU_PACKED;
> +    struct scan_media_pl *in = (void *)cmd->payload;
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    uint64_t query_start;
> +    uint64_t query_length;
> +
> +    query_start = ldq_le_p(&in->pa);
> +    /* 64 byte alignment required */
> +    if (query_start & 0x3f) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    query_length = ldq_le_p(&in->length) * 64;
> +
> +    /*
> +     * TODO: Any previous Scan Media results are discarded by
> +     * the device upon receiving a new Scan Media command.
> +     */
> +
> +    /*
> +     * The host should use this command only if the poison list
> +     * has overflowed and is no longer a complete list of the
> +     * memory errors that exist on the media.
Reference.

> +     */
> +    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +        ct3d->poison_list_cnt = 0;

Clearing the poison list definitely needs a reference.
I don't think this is valid, but might be reading things wrong.
I think the cycle if you get a poison list overflow is...

1) Call scan media / scan media results (including handling of
   premature stop and restart etc) that gets you the full list.
2) Clear that poison either using command or impdef host specific
   write of full cacheline.
3) Rerun Scan media request on full address range.  (see under
Get Poison List Output). 
(On this last one: I'm not sure what you meant by timeslicing commands
 in the BG commands kernel series, but if you meant breaking them into
 smaller memory address ranges then this will not work).

If the list being rebuilt is under the limit it will clear the overflow.
If not we go around a gain a few times and if no progress made give
up and mark device dying and power down machine ASAP.


> +    }
> +
> +    if (query_start + query_length > cxl_dstate->mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    if (in->flags == 0) { /* TODO */
> +        qemu_log_mask(LOG_UNIMP,
> +                      "Scan Media Event Log is unsupported\n");
> +    }
> +
> +    cxl_dstate->bg.runtime = MAX(1, query_length * (0.0005L/64));
> +    ct3d->poison_list_dirty = false;
> +
> +    *len = 0;
> +    return CXL_MBOX_BG_STARTED;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1014,7 +1119,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_clear_poison, 72, 0 },
>      [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
>          cmd_media_get_scan_media_capabilities, 16, 0 },
> -

And there it goes again ;)

> +    [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
> +        cmd_media_scan_media, 17, 0 },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> @@ -1048,7 +1154,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>      opcode_handler h;
>      uint8_t bg_started = 0;
>      uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
> -
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);

Move this up as it's breaking up the reading of the register and the separation
of it's fields.

>      uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
>      uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
>      uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
> @@ -1064,6 +1170,20 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>                      ret = CXL_MBOX_BUSY;
>                      goto done;
>              }
> +
> +            /*
> +             * If the device updates its Poison List while the
> +             * Scan Media operation is executing, the device

Line wrap seems a little short.

> +             * shall indicate that a media scan is in progress
> +             * if Get Poison List is called during the scan.

Spec reference (as that text is cut and paste from spec ;)

> +             */
> +            if (ct3d->poison_list_dirty) {
> +                if (h == cmd_media_get_poison_list) {
> +                    ret = CXL_MBOX_BUSY;

Not a valid return code for Get Poison List.
Also the text under 'scan media in progress' flag in the poison list
output suggests to me it doesn't fail the command, it simply
sets the flag to say the data might be wrong / partial.
So this needs to set that flag and carry on otherwise.

Scan media includes some weasel words that means a device might
not update it's poison list anyway or set this flag, but I think
it's sensible to make the default in QEMU that it does both update
poison list and set the flag.  Don't think you setting flag and not
updating this list is valid....

> +                    goto done;
> +                }
> +            }
> +
>              /* forbid any selected commands while overwriting */
>              if (sanitize_running(cxl_dstate)) {
>                  if (h == cmd_events_get_records ||
> @@ -1157,7 +1277,8 @@ static void bg_timercb(void *opaque)
>                  __do_sanitization(cxl_dstate);
>                  cxl_dev_enable_media(cxl_dstate);
>                  break;
> -            case 0x4304: /* TODO: scan media */
> +            case 0x4304: /* scan media */

Better to build these, then we don't need the comment.

	MEDIA_AND_POISON << 8 | ....

> +                __do_scan_media(cxl_dstate);
>                  break;
>              default:
>                  __builtin_unreachable();
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3e63dbd83551..0bc017061f30 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1213,6 +1213,9 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>  
>      QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
>      ct3d->poison_list_cnt++;
> +    if (scan_media_running(&ct3d->cxl_dstate)) {
> +        ct3d->poison_list_dirty = true;
> +    }
>  }
>  
>  /* For uncorrectable errors include support for multiple header recording */
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index cd7f28dba884..8db63c1f7cd1 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -376,12 +376,18 @@ typedef struct CXLPoison {
>  #define CXL_POISON_TYPE_EXTERNAL 0x1
>  #define CXL_POISON_TYPE_INTERNAL 0x2
>  #define CXL_POISON_TYPE_INJECTED 0x3
> +#define CXL_POISON_TYPE_SCANMEDIA 0x4

Invented?  Nothing special about these I think.
They come from the same 3 sources as other poison does.

>      QLIST_ENTRY(CXLPoison) node;
>  } CXLPoison;
>  
>  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  #define CXL_POISON_LIST_LIMIT 256
>  
> +static inline bool scan_media_running(CXLDeviceState *cxl_dstate)
> +{
> +    return cxl_dstate->bg.runtime && cxl_dstate->bg.opcode == 0x4304;
> +}
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -413,6 +419,8 @@ struct CXLType3Dev {
>      unsigned int poison_list_cnt;
>      bool poison_list_overflowed;
>      uint64_t poison_list_overflow_ts;
> +    /* list modified while doing scan media */
> +    bool poison_list_dirty;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"

