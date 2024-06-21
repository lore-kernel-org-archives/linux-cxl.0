Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3413D521
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989656; cv=none; b=OTDwurDl/R9ZvvjwgJiRgz9t5/rlbnsLGjVNGpnmh2N/YpC64ITsK/rXQV19WE2ahNP+K553I4SpI/nog03+shXFdi52zdfTctkNlHaj0YLZPyW7iuVaqIp+Xp8bBsp5R/DVSNwm609KobDJOI54eoCTsD07YI1iN10cIG4Q7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989656; c=relaxed/simple;
	bh=NxfoTkEFV8+znvuscLOuxiGVOVYs2AW/jE7SWQYH5Ho=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhA2eH58L3fOgqR5OIx4qHIKi5WrVr5xMXZIfj3MqbfX3rZ3uWlPi+Su9wyXCeJq4vIl5dv0f1F/9c4g4skH3/aqgsnQarqFuR5Xv9v1dcmZd6UyCz0aGK5zwyF852vpSwNI/UoN80i1iXEbq/nyeWuhuwFdEna/7y3jeD8mQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5P192ctsz6J9bP;
	Sat, 22 Jun 2024 01:07:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BF071404FC;
	Sat, 22 Jun 2024 01:07:30 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 18:07:30 +0100
Date: Fri, 21 Jun 2024 18:07:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v2 -qemu] hw/cxl: Support firmware updates
Message-ID: <20240621180729.0000585c@huawei.com>
In-Reply-To: <o54dzo3ofnyov7hhh2kcktjfsvvu7oxfqyilu5vl4wrdnzl3ma@iy447qho7kit>
References: <20240205172942.13343-1-dave@stgolabs.net>
	<20240422165126.00006567@Huawei.com>
	<o54dzo3ofnyov7hhh2kcktjfsvvu7oxfqyilu5vl4wrdnzl3ma@iy447qho7kit>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 12:37:00 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Hi Jonathan,
> 
> Just now had some cycles to return to this.
> 
> And I was not able to reproduce the overlapping behavior I
> mentioned in the kernel support - I guess this might be an
> incorrect test I had in place. So sorry for the false alarm,
> and for the record, below is the pasted actual byte ranges
> sent by the driver for a 52k image.
> 
> prev range: 0-0 ... this range: 0-1920
> prev range: 0-1920 ... this range: 1920-3840
> prev range: 1920-3840 ... this range: 3840-5760
> prev range: 3840-5760 ... this range: 5760-7680
> prev range: 5760-7680 ... this range: 7680-9600
> prev range: 7680-9600 ... this range: 9600-11520
> prev range: 9600-11520 ... this range: 11520-13440
> prev range: 11520-13440 ... this range: 13440-15360
> prev range: 13440-15360 ... this range: 15360-17280
> prev range: 15360-17280 ... this range: 17280-19200
> prev range: 17280-19200 ... this range: 19200-21120
> prev range: 19200-21120 ... this range: 21120-23040
> prev range: 21120-23040 ... this range: 23040-24960
> prev range: 23040-24960 ... this range: 24960-26880
> prev range: 24960-26880 ... this range: 26880-28800
> prev range: 26880-28800 ... this range: 28800-30720
> prev range: 28800-30720 ... this range: 30720-32640
> prev range: 30720-32640 ... this range: 32640-34560
> prev range: 32640-34560 ... this range: 34560-36480
> prev range: 34560-36480 ... this range: 36480-38400
> prev range: 36480-38400 ... this range: 38400-40320
> prev range: 38400-40320 ... this range: 40320-42240
> prev range: 40320-42240 ... this range: 42240-44160
> prev range: 42240-44160 ... this range: 44160-46080
> prev range: 44160-46080 ... this range: 46080-48000
> prev range: 46080-48000 ... this range: 48000-49920
> prev range: 48000-49920 ... this range: 49920-51200

Excellent. So I guess we can drop the comment.


> >> ---
> >> Changes from v1:
> >>  - robustify part transfer checking (Jonathan)
> >>  - implement abort
> >>  - increase runtime for full transfer
> >>  - no longer prematurely mark the slot
> >>  - fold both cmds into a single patch
> >>
> >>  hw/cxl/cxl-mailbox-utils.c  | 217 +++++++++++++++++++++++++++++++++++-
> >>  include/hw/cxl/cxl_device.h |  16 +++
> >>  2 files changed, 228 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >> index 80a80f1ec29b..74054855b1fa 100644
> >> --- a/hw/cxl/cxl-mailbox-utils.c
> >> +++ b/hw/cxl/cxl-mailbox-utils.c
> >> @@ -60,6 +60,8 @@ enum {
> >>          #define SET_INTERRUPT_POLICY   0x3
> >>      FIRMWARE_UPDATE = 0x02,
> >>          #define GET_INFO      0x0
> >> +        #define TRANSFER      0x1
> >> +        #define ACTIVATE      0x2
> >>      TIMESTAMP   = 0x03,
> >>          #define GET           0x0
> >>          #define SET           0x1
> >> @@ -815,6 +817,9 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
> >>      return CXL_MBOX_SUCCESS;
> >>  }
> >>
> >> +#define CXL_FW_SLOTS 2
> >> +#define CXL_FW_SIZE  0x02000000 /* 32 mb */
> >> +
> >>  /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
> >>  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
> >>                                                 uint8_t *payload_in,
> >> @@ -846,15 +851,204 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
> >>      fw_info = (void *)payload_out;
> >>      memset(fw_info, 0, sizeof(*fw_info));
> >>
> >> -    fw_info->slots_supported = 2;
> >> -    fw_info->slot_info = BIT(0) | BIT(3);
> >> -    fw_info->caps = 0;
> >> -    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
> >> +    fw_info->slots_supported = CXL_FW_SLOTS;
> >> +    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
> >> +            ((cci->fw.staged_slot & 0x7) << 3);
> >> +    fw_info->caps = BIT(0);  
> >
> >I'd add a comment on this one for what it is. "Online update supported"
> >Given this is trivial I amend the patch on my tree.  
> 
> Sure.
I started doing this but then realized still some nastier corners below
so probably better you do a v3 as you are setup to test this.

So ignore my previous email, you can fix up Fan's stuff as well ;)


...

> >> +    /* allow back-to-back retransmission */
> >> +    if ((offset != cci->fw.prev_offset || length != cci->fw.prev_len) &&
> >> +        (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
> >> +         fw_transfer->action == CXL_FW_XFER_ACTION_END)) {
> >> +        /*
> >> +         * XXX: Linux is happy to send overlapping chunks,
> >> +         * so just verify no gaps.
> >> +         */  
> >
> >Does the CXL spec allow overlapping?  I see text about parts being
> >in order (with an exception for back to band transfer). So I think
> >we need to reject any overlap and make sure Linux doesn't do it!
> >
> >
> >The 3rd example in the imp note implies that overlap definitely isn't
> >allowed.  
> 
> Yep, hence the above comment, which also happens to be wrong. And, per
> the examples in the imp notes, it looks like gaps are in fact allowed
> (0-100h, 160h-260h is considered valid, for example).
> 
> >  
> >> +        if (offset > cci->fw.prev_offset + cci->fw.prev_len) {  
> 
> So this really turns into 'offset < ...'
> 
> >> +            return CXL_MBOX_FW_XFER_OUT_OF_ORDER;
> >> +        }
> >> +    }
> >> +
> >> +    switch (fw_transfer->action) {
> >> +    case CXL_FW_XFER_ACTION_FULL: /* ignores offset */
> >> +    case CXL_FW_XFER_ACTION_END:
> >> +        if (fw_transfer->slot == 0 ||
> >> +            fw_transfer->slot == cci->fw.active_slot ||
> >> +            fw_transfer->slot > CXL_FW_SLOTS) {
> >> +            return CXL_MBOX_FW_INVALID_SLOT;
> >> +        }
> >> +
> >> +        /* mark the slot used upon bg completion */
> >> +        break;
> >> +    case CXL_FW_XFER_ACTION_INIT:
> >> +        if (offset != 0) {
> >> +            return CXL_MBOX_INVALID_INPUT;
> >> +        }
> >> +
> >> +        cci->fw.transferring = true;
> >> +        cci->fw.prev_slot = fw_transfer->slot;  
> >
> >Why?  This is only valid for Full and End.  
> 
> oh it occurred to me that the spec was implying that partial
> transfers do want to be the same (Slot=X) regardless of only
> caring about the actual value at the End transfer. I wasn't
> sure, so took the cautious side.
Ok.  If it's vague in the spec and reserved otherwise in these cases
then perhaps just a comment.

> 
> But if this is not the case, it might be useful to update
> the spec and be more explicit.

Go for it. :)


> 
> >  
> >>              return CXL_MBOX_MEDIA_DISABLED;
> >>          }
> >>      }
> >> @@ -2319,6 +2519,9 @@ static void bg_timercb(void *opaque)
> >>          cci->bg.complete_pct = 100;
> >>          cci->bg.ret_code = ret;
> >>          switch (cci->bg.opcode) {
> >> +        case 0x0201: /* fw transfer */
> >> +            __do_firmware_xfer(cci);
> >> +            break;
> >>          case 0x4400: /* sanitize */
> >>          {
> >>              CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> >> @@ -2390,6 +2593,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> >>      cci->bg.runtime = 0;
> >>      cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> >>                                   bg_timercb, cci);
> >> +
> >> +    memset(&cci->fw, 0, sizeof(cci->fw));
> >> +    cci->fw.active_slot = cci->fw.staged_slot = 1;  
> >
> >Why not set staged_slot to 0 on init?
> >
> >"If 0, no FW is currently staged for activation."  
> 
> I prefer following the spec convention directly here.

I'm confused.  My assumption was convention was nothing staged
Perhaps a spec reference?

I'll push out a new tree early next week.  This looks nearly
ready to go - I'll try and remember to tag a 'stable' point
in the tree as I keep promising to do and forgetting.
That will be the appropriate place to base new features rather
than on top of the bits that are less mature.

Jonathan

