Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61189C54EAA
	for <linux-cxl@archiver.kernel.org>; Fri, 27 Jan 2023 10:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjA0KEk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 05:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjA0KEi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 05:04:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F921DBD3
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 02:04:10 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P3Cng37j8z67PwL;
        Fri, 27 Jan 2023 18:03:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:04:07 +0000
Date:   Fri, 27 Jan 2023 10:04:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <20230127100406.00006c65@Huawei.com>
In-Reply-To: <63d2e0f67eee9_ea222294b6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
        <63d2e0f67eee9_ea222294b6@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 26 Jan 2023 12:22:14 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > CXL r3.0 section 8.2.9.4.2 "Set Timestamp" recommends that the host sets
> > the timestamp after every Conventional or CXL Reset to ensure accurate
> > timestamps. This should include on initial boot up. The time base that
> > is being set is used by a device for the poison list overflow timestamp
> > and all event timestamps.  Note that the command is optional and if
> > not supported and the device cannot return accurate timestamps it will
> > fill the fields in with an appropriate marker (see the specification
> > description of each timestamp).
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > 
> > Open question: Should we only do this if Linux has control of the
> > error handling?  In theory it should be safe anyway given the
> > specification is clear that the timestamp base should always be the
> > same - so subject to small errors we shouldn't cause any firmware first
> > handling to get confused.
> > 
> >  drivers/cxl/core/mbox.c      | 25 +++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h         |  7 +++++++
> >  drivers/cxl/pci.c            |  5 +++++
> >  include/uapi/linux/cxl_mem.h |  1 +
> >  4 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index b03fba212799..a7317bb142ed 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -65,6 +65,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> >  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> >  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> >  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> > +	CXL_CMD(SET_TIMESTAMP, 8, 0, 0),  
> 
> Is there a use case for userspace to need to send its own view
> of 'timestamp' to the device? I think it's ok if this only a
> kernel-internal thing.

Fair enough. Easier to add the interface later if we need to than to rip
it out.

> 
> >  };
> >  
> >  /*
> > @@ -93,6 +94,7 @@ static u16 cxl_disabled_raw_commands[] = {
> >  	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
> >  	CXL_MBOX_OP_SCAN_MEDIA,
> >  	CXL_MBOX_OP_GET_SCAN_MEDIA,
> > +	CXL_MBOX_OP_SET_TIMESTAMP,  
> 
> The criteria I have in mind for commands that should be added to this
> list are things that need to have a kernel control point (like long
> running background commands), or commands with data integrity
> implications that only the kernel can reasonably manage (like shutdown
> state). While it is odd for userspace to send its own timestamps via
> debug kernel builds that enable raw commands, the side effects of
> allowing this seem benign.

Makes sense I'll drop it from this list.
> 
> >  };
> >  
> >  /*
> > @@ -857,6 +859,29 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
> >  
> > +int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts)
> > +{
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	struct cxl_mbox_set_timestamp_in pi;
> > +
> > +	/*
> > +	 * Command is optional and functionality should not be affected if
> > +	 * the command is not available.
> > +	 */
> > +	if (!test_bit(CXL_MEM_COMMAND_ID_SET_TIMESTAMP, cxlds->enabled_cmds))
> > +		return 0;
> > +
> > +	pi.timestamp = ts;  
> 
> cpu_to_le64()?

Good point.

Thanks,

Jonathan


