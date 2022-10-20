Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74409C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 15:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJTPwJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJTPwI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 11:52:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C80357570
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 08:52:07 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MtX9l06fgz688J2;
        Thu, 20 Oct 2022 23:50:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:52:04 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 16:52:04 +0100
Date:   Thu, 20 Oct 2022 16:52:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 9/9] cxl/pci: Add (hopeful) error handling
 support
Message-ID: <20221020165203.00002101@huawei.com>
In-Reply-To: <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <166336990544.3803215.2332306189095144106.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Sep 2022 16:11:45 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Add nominal error handling that tears down CXL.mem in response to error
> notifications that imply a device reset. Given some CXL.mem may be
> operating as System RAM, there is a high likelihood that these error
> events are fatal. However, if the system survives the notification the
> expectation is that the driver behavior is equivalent to a hot-unplug
> and re-plug of an endpoint.
> 
> Note that this does not change the mask values from the default. That
> awaits CXL _OSC support to determine whether platform firmware is in
> control of the mask registers.

Hi Dave,

So I just implemented correctable error reporting and it never gets
to the handling in here.  My perhaps wrong assumption is that the
device would use ERR_COR messages to indicate those?

They get to the AER handlers (which print appropriately) but because
they have been corrected are never reported to the PCIe drivers.

https://elixir.bootlin.com/linux/latest/source/drivers/pci/pcie/aer.c#L956

I guess we will want a hook for those as well so we can log the
extra info on what the error was when they occur.

Jonathan
