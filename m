Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F026E7849A
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 10:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbjJBKLn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 06:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjJBKLg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 06:11:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF4BD
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 03:11:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzcBw0pccz6K63G;
        Mon,  2 Oct 2023 18:10:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 11:11:31 +0100
Date:   Mon, 2 Oct 2023 11:11:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] cxl/mem: Fix shutdown order
Message-ID: <20231002111131.00001e59@Huawei.com>
In-Reply-To: <65176326ddc98_168c46294e8@iweiny-mobl.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
        <169602898991.904193.3059334392093961032.stgit@dwillia2-xfh.jf.intel.com>
        <65176326ddc98_168c46294e8@iweiny-mobl.notmuch>
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

On Fri, 29 Sep 2023 16:52:06 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Dan Williams wrote:
> > Ira reports that removing cxl_mock_mem causes a crash with the following
> > trace:
> > 
> >  BUG: kernel NULL pointer dereference, address: 0000000000000044
> >  [..]
> >  RIP: 0010:cxl_region_decode_reset+0x7f/0x180 [cxl_core]
> >  [..]
> >  Call Trace:
> >   <TASK>
> >   cxl_region_detach+0xe8/0x210 [cxl_core]
> >   cxl_decoder_kill_region+0x27/0x40 [cxl_core]
> >   cxld_unregister+0x29/0x40 [cxl_core]
> >   devres_release_all+0xb8/0x110
> >   device_unbind_cleanup+0xe/0x70
> >   device_release_driver_internal+0x1d2/0x210
> >   bus_remove_device+0xd7/0x150
> >   device_del+0x155/0x3e0
> >   device_unregister+0x13/0x60
> >   devm_release_action+0x4d/0x90
> >   ? __pfx_unregister_port+0x10/0x10 [cxl_core]
> >   delete_endpoint+0x121/0x130 [cxl_core]
> >   devres_release_all+0xb8/0x110
> >   device_unbind_cleanup+0xe/0x70
> >   device_release_driver_internal+0x1d2/0x210
> >   bus_remove_device+0xd7/0x150
> >   device_del+0x155/0x3e0
> >   ? lock_release+0x142/0x290
> >   cdev_device_del+0x15/0x50
> >   cxl_memdev_unregister+0x54/0x70 [cxl_core]
> > 
> > This crash is due to the clearing out the cxl_memdev's driver context
> > (@cxlds) before the subsystem is done with it. This is ultimately due to
> > the region(s), that this memdev is a member, being torn down and expecting
> > to be able to de-reference @cxlds, like here:
> > 
> > static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> > ...
> >                 if (cxlds->rcd)
> >                         goto endpoint_reset;
> > ...
> > 
> > Fix it by keeping the driver context valid until memdev-device
> > unregistration, and subsequently the entire stack of related
> > dependencies, unwinds.
> > 
> > Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
> > Reported-by: Ira Weiny <ira.weiny@intel.com>  
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for cleaning up the whole area whilst fixing this.

Jonathan

