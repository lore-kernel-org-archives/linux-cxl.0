Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E0CC54EAA
	for <linux-cxl@archiver.kernel.org>; Fri, 27 Jan 2023 12:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjA0MOa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 07:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjA0MOS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 07:14:18 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14007F31C
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 04:09:13 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P3GXt02fPz6J9d0;
        Fri, 27 Jan 2023 20:07:25 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 12:08:14 +0000
Date:   Fri, 27 Jan 2023 12:08:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <20230127120813.00004f65@huawei.com>
In-Reply-To: <20230127095706.00002d36@Huawei.com>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
        <20230126185620.52bfkr7cksjyjghk@offworld>
        <20230127095706.00002d36@Huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 27 Jan 2023 09:57:06 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 26 Jan 2023 10:56:20 -0800
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Thu, 26 Jan 2023, Jonathan Cameron wrote:
> >   
> > >Note that the command is optional and if
> > >not supported and the device cannot return accurate timestamps it will
> > >fill the fields in with an appropriate marker (see the specification
> > >description of each timestamp).    
> > 
> > A few questions (which I'm missing from the spec):
> > 
> > - How to verify if a ts was actually set? I would assume that if SET
> > is unsupported, GET will also be, and since you set the ts at
> > bootup, it should never occur in reality.  
> 
> I don't think we care.  If a record comes back with the magic code (all
> zeros) that is in the spec. Get can still be supported.
> 
> > 
> > - Does "unsupported" return type mean the command cannot mean that
> > flat out the device cannot handle timestamps or is it more that the
> > device cannot handle nanosecond resolution?  
> 
> Neither - it just means that it cannot be set by this means.
> There is no provision for anything other than nanoseconds, but there is also
> no statement on accuracy.  So if you only do seconds, multiply the number
> by 1x10^9
> 
> The device might have another means of setting it. MCTP for example
> or in theory might have an RTC.  The OS can only tell if that is true
> when it sees a timestamp.
> 
> 
> 
> > 
> > ...
> >   
> > >@@ -65,6 +65,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> > >	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> > >	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> > >	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> > >+	CXL_CMD(SET_TIMESTAMP, 8, 0, 0),
> > > };
> > >
> > > /*
> > >@@ -93,6 +94,7 @@ static u16 cxl_disabled_raw_commands[] = {
> > >	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
> > >	CXL_MBOX_OP_SCAN_MEDIA,
> > >	CXL_MBOX_OP_GET_SCAN_MEDIA,
> > >+	CXL_MBOX_OP_SET_TIMESTAMP,    
> > 
> > Why no GET support?

Missed this question in first reply.

Original thought was don't provide something we aren't yet using.
After Dan's review I've removed userspace direct access and not restricted the
set here. So adding Get makes even less sense at this stage.

Thanks

Jonathan


