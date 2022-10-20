Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE5C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 16:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJTQL2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiJTQL0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 12:11:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9F188582
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 09:11:24 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MtXbz2jrSz67M3B;
        Fri, 21 Oct 2022 00:09:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 18:11:21 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 17:11:20 +0100
Date:   Thu, 20 Oct 2022 17:11:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 9/9] cxl/pci: Add (hopeful) error handling
 support
Message-ID: <20221020171119.00004e8c@huawei.com>
In-Reply-To: <032c48b4-f1d5-6458-ccde-04ce8b1a7f10@intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
        <20221020165203.00002101@huawei.com>
        <032c48b4-f1d5-6458-ccde-04ce8b1a7f10@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 20 Oct 2022 09:06:50 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/20/2022 8:52 AM, Jonathan Cameron wrote:
> > On Fri, 16 Sep 2022 16:11:45 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >  
> >> From: Dan Williams <dan.j.williams@intel.com>
> >>
> >> Add nominal error handling that tears down CXL.mem in response to error
> >> notifications that imply a device reset. Given some CXL.mem may be
> >> operating as System RAM, there is a high likelihood that these error
> >> events are fatal. However, if the system survives the notification the
> >> expectation is that the driver behavior is equivalent to a hot-unplug
> >> and re-plug of an endpoint.
> >>
> >> Note that this does not change the mask values from the default. That
> >> awaits CXL _OSC support to determine whether platform firmware is in
> >> control of the mask registers.  
> > Hi Dave,
> >
> > So I just implemented correctable error reporting and it never gets
> > to the handling in here.  My perhaps wrong assumption is that the
> > device would use ERR_COR messages to indicate those?
> >
> > They get to the AER handlers (which print appropriately) but because
> > they have been corrected are never reported to the PCIe drivers.
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/pci/pcie/aer.c#L956
> >
> > I guess we will want a hook for those as well so we can log the
> > extra info on what the error was when they occur.  
> 
> Are you suggesting having that function call pdrv->err_handler with 
> either going through ->error_detected() or a new callback like 
> ->correctable_error_notify()?  

Probably a new callback to avoid any side effects.  Probably a question to
ask on linux-pci...

J
