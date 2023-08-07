Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D78BC001B0
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Aug 2023 14:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjHGObJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjHGObI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Aug 2023 10:31:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8A31BD4
        for <linux-cxl@vger.kernel.org>; Mon,  7 Aug 2023 07:30:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKJYT1X15z67bHh;
        Mon,  7 Aug 2023 22:27:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 15:30:43 +0100
Date:   Mon, 7 Aug 2023 15:30:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>,
        <kwangjin.ko@sk.com>
Subject: Re: [PATCH 2/4] cxl/mailbox: interface to add CCI commands to an
 existing CCI
Message-ID: <20230807153042.00007bed@Huawei.com>
In-Reply-To: <ZM0qNhbVxsSEs7nQ@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
        <20230721163505.1910-3-gregory.price@memverge.com>
        <20230804161414.00006eaa@huawei.com>
        <ZM0qNhbVxsSEs7nQ@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 4 Aug 2023 12:41:26 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Aug 04, 2023 at 04:14:14PM +0100, Jonathan Cameron wrote:
> > On Fri, 21 Jul 2023 12:35:06 -0400
> > Gregory Price <gourry.memverge@gmail.com> wrote:
> >   
> > > This enables wrapper devices to customize the base device's CCI
> > > (for example, with custom commands outside the specification)
> > > without the need to change the base device.
> > > 
> > > The also enabled the base device to dispatch those commands without
> > > requiring additional driver support.
> > > 
> > > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++++
> > >  include/hw/cxl/cxl_device.h |  2 ++
> > >  2 files changed, 21 insertions(+)
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index ddee3f1718..cad0cd0adb 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -1383,6 +1383,25 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
> > >      }
> > >  }
> > >  
> > > +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256], size_t payload_max)
> > > +{
> > > +    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;
> > > +    for (int set = 0; set < 256; set++) {
> > > +        for (int cmd = 0; cmd < 256; cmd++) {
> > > +            if (cxl_cmd_set[set][cmd].handler) {
> > > +                const struct cxl_cmd *c = &cxl_cmd_set[set][cmd];
> > > +                cci->cxl_cmd_set[set][cmd] = *c;  
> > Don't interleave definitions and code.
> >   
> > > +                struct cel_log *log =
> > > +                    &cci->cel_log[cci->cel_size];
> > > +
> > > +                log->opcode = (set << 8) | cmd;
> > > +                log->effect = c->effect;
> > > +                cci->cel_size++;  
> > 
> > So my gut feeling on this is based on the large amount of overlapping code.  I might queue it
> > as it stands, but I'd like to see this refactored.
> > 
> > 1) Single copy routine used in all places that copie in any new entries to cci->cxl_cmd_set[][]
> > 2) A single cel_log builder function to be called in normal path and after an update. Just rebuild
> > the whole thing rather than trying to append to it I think.
> > 
> > Something like (so far untested but I'll poke it with Fan's code in a few mins)
> > 
> > However this is all proving rather costly in space so maybe we need a better
> > representation for the sparse nature of cxl comamnds - a job for another day.  
> 
> I'd certainly considered the issue of space, but it seemed better to
> blow up the size in one commit and then come back around and change the
> structure out from under the work this unblocks.  What we save in space
> we sacrifice in complexity, but the structure seems simple enough that a
> change shouldn't take a ton of scrutiny to get right.

Makes sense.

> 
> One downside of the approach here is what happens when there's an
> overlap and custom devices build up over time.  As in - if i steal the
> 0xFF command group for my custom emulated MHMLD DCD Everything Super Device,
> what happens if the spec finally comes around to defining 0xFF as a real
> command set?

We don't support your command unless it's in the vendor defined space.
Opcodes c000h-ffffh are all yours to do what you like with :)


> 
> tl;dr: Should the copy function error on overlap detections?
Maybe.. If it's easy we definitely could do that even if it's considered a
bug if it occurs.
> 
> Quick read-back through the spec, I don't see explicit carve-outs for
> reserved command regions for custom sets, might be worth a discussion.
8.2.9 Component Command Interface
"Opcodes C000h-FFFFh describe vendor specific commands."

Jonathan

> 
> For now it shouldn't be an issue.
> 
> > 
> > 
> > From 8ab48adfb2b481be0702b84a0d172a4f142b0df6 Mon Sep 17 00:00:00 2001
> > From: Gregory Price <gourry.memverge@gmail.com>
> > Date: Fri, 21 Jul 2023 12:35:06 -0400
> > Subject: [PATCH] cxl/mailbox: interface to add CCI commands to an existing CCI
> > 
> > This enables wrapper devices to customize the base device's CCI
> > (for example, with custom commands outside the specification)
> > without the need to change the base device.
> > 
> > The also enabled the base device to dispatch those commands without
> > requiring additional driver support.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > Link: https://lore.kernel.org/r/20230721163505.1910-3-gregory.price@memverge.com
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > --
> > Heavily edited by Jonathan Cameron to increase code reuse
> > ---
> >  include/hw/cxl/cxl_device.h |  2 ++
> >  hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++++++++++++--
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 0c9254dff9..2a3050fbad 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -297,6 +297,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
> >  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
> >                                    DeviceState *d, size_t payload_max);
> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> > +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> > +                          size_t payload_max);
> >  int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
> >                              size_t len_in, uint8_t *pl_in,
> >                              size_t *len_out, uint8_t *pl_out,
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 37703f254f..852e5a046b 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1353,9 +1353,9 @@ static void bg_timercb(void *opaque)
> >      }
> >  }
> >  
> > -void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> > +static void cxl_rebuild_cel(CXLCCI *cci)
> >  {
> > -    cci->payload_max = payload_max;
> > +    cci->cel_size = 0; /* Reset for a fresh build */
> >      for (int set = 0; set < 256; set++) {
> >          for (int cmd = 0; cmd < 256; cmd++) {
> >              if (cci->cxl_cmd_set[set][cmd].handler) {
> > @@ -1369,6 +1369,13 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> >              }
> >          }
> >      }
> > +}
> > +
> > +void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> > +{
> > +    cci->payload_max = payload_max;
> > +    cxl_rebuild_cel(cci);
> > +
> >      cci->bg.complete_pct = 0;
> >      cci->bg.starttime = 0;
> >      cci->bg.runtime = 0;
> > @@ -1387,10 +1394,19 @@ static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[
> >      }
> >  }
> >  
> > +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> > +                                 size_t payload_max)
> > +{
> > +    cci->payload_max = payload_max > cci->payload_max ? payload_max : cci->payload_max;
> > +    cxl_copy_cci_commands(cci, cxl_cmd_set);
> > +    cxl_rebuild_cel(cci);
> > +}
> > +
> >  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
> >                                    DeviceState *d, size_t payload_max)
> >  {
> >      cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
> > +    cxl_rebuild_cel(cci);
> >      cci->d = d;
> >      cci->intf = intf;
> >      cxl_init_cci(cci, payload_max);
> > @@ -1399,6 +1415,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
> >  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
> >  {
> >      cxl_copy_cci_commands(cci, cxl_cmd_set);
> > +    cxl_rebuild_cel(cci);
> >      cci->d = d;
> >  
> >      /* No separation for PCI MB as protocol handled in PCI device */
> > -- 
> > 2.39.2
> > 
> > 
> >   
> > > +            }
> > > +        }
> > > +    }
> > > +}
> > > +
> > >  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d, size_t payload_max)
> > >  {
> > >      cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > index 9a3c8b2dfa..abc8405cc5 100644
> > > --- a/include/hw/cxl/cxl_device.h
> > > +++ b/include/hw/cxl/cxl_device.h
> > > @@ -297,6 +297,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
> > >  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
> > >                                    DeviceState *d, size_t payload_max);
> > >  void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> > > +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
> > > +                          size_t payload_max);
> > >  int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
> > >                              size_t len_in, uint8_t *pl_in,
> > >                              size_t *len_out, uint8_t *pl_out,  
> >   

