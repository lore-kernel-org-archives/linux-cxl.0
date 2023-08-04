Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295BDC41513
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 09:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHDJi2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjHDJi0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 05:38:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846DF30EB
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 02:38:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHLCP4MdXz67PjK;
        Fri,  4 Aug 2023 17:34:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 10:38:22 +0100
Date:   Fri, 4 Aug 2023 10:38:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Shesha Bhushan Sreenivasamurthy" <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v4 2/4] cxl: mbox: Factor out the mbox specific data
 for reuse in switch cci
Message-ID: <20230804103821.00004820@Huawei.com>
In-Reply-To: <klyeobxdmjsmbbu43pllrdu5uzcmply7ijdlaxegeriutzhxgs@ywp3ymuw5uqb>
References: <20230719091931.27799-1-Jonathan.Cameron@huawei.com>
        <20230719091931.27799-3-Jonathan.Cameron@huawei.com>
        <klyeobxdmjsmbbu43pllrdu5uzcmply7ijdlaxegeriutzhxgs@ywp3ymuw5uqb>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 21 Jul 2023 09:48:16 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 19 Jul 2023, Jonathan Cameron wrote:
> 
> > #ifndef __CXLMBOX_H__
> > #define __CXLMBOX_H__  
> 
> Unrelated but looks like cxlmem.h needs s/__CXL_MEM_H__/__CXLMEM_H__
> 
> >
> >-struct cxl_dev_state;
> >-int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds);
> >-bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds);
> >+#include <linux/irqreturn.h>
> >+#include <linux/export.h>
> >+#include <linux/io.h>
> >+
> >+#include <uapi/linux/cxl_mem.h>
> >+
> >+struct device;
> >+struct cxl_mbox_cmd;  
> 
> Would it make sense to instead move the whole cxl_mbox_cmd out of
> cxlmem.h into here? Same for the cmd rc table stuff. Then cxlmem
> can include cxlmbox.
> 
> >+struct cxl_mbox {
> >+	struct device *dev; /* Used for debug prints */
> >+	size_t payload_size;
> >+	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> >+	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> >+	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> >+	struct rcuwait mbox_wait;
> >+	int (*mbox_send)(struct cxl_mbox *mbox,
> >+			 struct cxl_mbox_cmd *cmd);
> >+	bool (*special_irq)(struct cxl_mbox *mbox, u16 opcode);
> >+	void (*special_init_poll)(struct cxl_mbox *mbox);
> >+	bool (*special_bg)(struct cxl_mbox *mbox, u16 opcode);
> >+	u64 (*get_status)(struct cxl_mbox *mbox);
> >+	bool (*can_run)(struct cxl_mbox *mbox, u16 opcode);
> >+	void (*extra_cmds)(struct cxl_mbox *mbox, u16 opcode);  
> 
> Ok, so most of these corner cases are wrt Sanitize. Do you have
> anything in mind what would require such any additional users
> in the future (such as completely taking over the device), beyond
> pci mailbox? Otherwise this feels too ad-hoc with only the naming
> being generic. Perhaps instead have some sort of mbox->type and
> handle accordingly directly in the core mbox calls? It would be
> nice to have these callbacks somewhat documented.
> 
> Also the 'can_run' name is a bit disconnected from the sanitize
> special case, maybe be rename to something like 'special_canrun'?

I thought a bit more on this and the special_can_run is too specific
as it's not the special command that is restricted, but rather could
be any command as a result of a special command being in flight.
I can't think of a better name for that :(

> 
> >+	/* Also needs access to registers */
> >+	void __iomem *status, *mbox;
> >+};
> >+  
> 
> Thanks,
> Davidlohr

