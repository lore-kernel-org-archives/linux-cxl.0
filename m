Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B81EB64DD
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Aug 2023 17:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjHCRMW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjHCRMU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Aug 2023 13:12:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7263035BE
        for <linux-cxl@vger.kernel.org>; Thu,  3 Aug 2023 10:12:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RGwJJ72Tnz6HJNZ;
        Fri,  4 Aug 2023 01:07:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 18:12:13 +0100
Date:   Thu, 3 Aug 2023 18:12:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Shesha Bhushan Sreenivasamurthy" <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v4 2/4] cxl: mbox: Factor out the mbox specific data
 for reuse in switch cci
Message-ID: <20230803181149.00001b11@huawei.com>
In-Reply-To: <20230803174751.00003201@Huawei.com>
References: <20230719091931.27799-1-Jonathan.Cameron@huawei.com>
        <20230719091931.27799-3-Jonathan.Cameron@huawei.com>
        <klyeobxdmjsmbbu43pllrdu5uzcmply7ijdlaxegeriutzhxgs@ywp3ymuw5uqb>
        <20230803174751.00003201@Huawei.com>
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

On Thu, 3 Aug 2023 17:47:51 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 21 Jul 2023 09:48:16 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Wed, 19 Jul 2023, Jonathan Cameron wrote:
> >   
> > > #ifndef __CXLMBOX_H__
> > > #define __CXLMBOX_H__    
> > 
> > Unrelated but looks like cxlmem.h needs s/__CXL_MEM_H__/__CXLMEM_H__
> >   
> > >
> > >-struct cxl_dev_state;
> > >-int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds);
> > >-bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds);
> > >+#include <linux/irqreturn.h>
> > >+#include <linux/export.h>
> > >+#include <linux/io.h>
> > >+
> > >+#include <uapi/linux/cxl_mem.h>
> > >+
> > >+struct device;
> > >+struct cxl_mbox_cmd;    
> > 
> > Would it make sense to instead move the whole cxl_mbox_cmd out of
> > cxlmem.h into here? Same for the cmd rc table stuff. Then cxlmem
> > can include cxlmbox.  
> 
> That makes sense but I'll do it in an additional patch as the chances
> of that sort of move being rebase pain is very high.
> Rebasing this is nasty already (just did so on top of the currently
> cxl/fixes and it wasn't as bad, but still not trivial)
> 
> Maybe we can squish it in with this patch for a final merge.
> 
> Having had a go at this, it gets a little fiddly to work out what
> to move - for example the event logs are general and can turn up
> on the switch cci (I think anyway) but hopefully not a DRAM event
> record.
> 
> For now I've gone for moving less rather that more, particularly
> as not that many messages are yet supported on the switch-cci.
> 
> Ideally the switch-cci.c file wouldn't include cxlmem.h at all
> and would not use a struct cxl_dev_state.  That makes the handling
> of register mapping a bit more ugly as the status may or may not
> have been mapped before the mbox mappings.  Let's see how bad it
> is for RFC v5.
> 
> 
> 
> >   
> > >+struct cxl_mbox {
> > >+	struct device *dev; /* Used for debug prints */
> > >+	size_t payload_size;
> > >+	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> > >+	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> > >+	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> > >+	struct rcuwait mbox_wait;
> > >+	int (*mbox_send)(struct cxl_mbox *mbox,
> > >+			 struct cxl_mbox_cmd *cmd);
> > >+	bool (*special_irq)(struct cxl_mbox *mbox, u16 opcode);
> > >+	void (*special_init_poll)(struct cxl_mbox *mbox);
> > >+	bool (*special_bg)(struct cxl_mbox *mbox, u16 opcode);
> > >+	u64 (*get_status)(struct cxl_mbox *mbox);
> > >+	bool (*can_run)(struct cxl_mbox *mbox, u16 opcode);
> > >+	void (*extra_cmds)(struct cxl_mbox *mbox, u16 opcode);    
> > 
> > Ok, so most of these corner cases are wrt Sanitize. Do you have
> > anything in mind what would require such any additional users
> > in the future (such as completely taking over the device), beyond
> > pci mailbox? Otherwise this feels too ad-hoc with only the naming
> > being generic. Perhaps instead have some sort of mbox->type and
> > handle accordingly directly in the core mbox calls?   
> 
> I don't like the idea of dragging the stuff related to sanitize and
> poison into the general mbox code and I do like the ease this gives
> of doing something special for the weird corners without making too much
> spaghetti. So whilst I agree it's a fair bit of complexity for
> a few small corner cases, I think it's striking roughly the right
> balance between device specific and generic.
> 
> > It would be
> > nice to have these callbacks somewhat documented  
> 
> And spoil the fun? Sure I'll add some stuff.
Was definitely a useful exercise. One was never called and the other
one was only used in one local path in pci.c so no need to have a callback.

Thanks :)

Jonathan

> > 
> > Also the 'can_run' name is a bit disconnected from the sanitize
> > special case, maybe be rename to something like 'special_canrun'?
> >   
> > >+	/* Also needs access to registers */
> > >+	void __iomem *status, *mbox;
> > >+};
> > >+    
> > 
> > Thanks,
> > Davidlohr  
> 
> 

