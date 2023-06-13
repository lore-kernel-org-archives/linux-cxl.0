Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE54EB64D0
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjFMPvg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjFMPvf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 11:51:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2358618C
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 08:51:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QgY1S3VjKz6J79p;
        Tue, 13 Jun 2023 23:50:52 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 16:51:31 +0100
Date:   Tue, 13 Jun 2023 16:51:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6 0/7] cxl: Support device sanitation
Message-ID: <20230613165130.00006259@huawei.com>
In-Reply-To: <20230613162611.00007b0b@Huawei.com>
References: <20230612181038.14421-1-dave@stgolabs.net>
        <20230613162611.00007b0b@Huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 13 Jun 2023 16:26:11 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> Hi Davidlohr,
> 
> > Testing.
> > ========
> > 
> > o There are the mock device tests for Sanitize and Secure Erase.
> > 
> > o The latest (v2) qemu bg/sanitize support series is posted here:
> > 	https://lore.kernel.org/linux-cxl/20230418172337.19207-1-dave@stgolabs.net/  
> 
> That doesn't seem to have support for reading back the security state so
> the stuff this set adds fails before it gets going.
> Am I missing another series?
> 
I hacked in enough to get things to carry on...

Following might be something I've broken locally but on basis
it might not...  Note my QEMU is odd right now as I'm in middle
of a big refactor of the CCI handling, but this should still not happen
even if I happen to have broken QEMU side of things in some weird way.

My base is more or less mainline + background set as queued on CXL
tree plus this set.

However similar traces to below happen when I poke a 1 into
sanitize

 This appears to be:

        WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
then
        WARN_ON_ONCE(!list_empty(&work->entry));

triggering.

------------[ cut here ]------------                                                                                                                                                                                                                                    
 WARNING: CPU: 3 PID: 617 at kernel/workqueue.c:1663 __queue_delayed_work+0xb8/0xe8                                                                                                                                                                                       
 Modules linked in: cxl_pmem cxl_mem cxl_port cxl_pmu cxl_acpi cxl_pci cxl_core                                                                                                                                                                                           
 CPU: 3 PID: 617 Comm: bash Not tainted 6.4.0-rc6+ #790                                                                                                                                                                                                                   
 Hardware name: QEMU QEMU Virtual Machine, BIOS unknown unknown                                                                                                                                                                                                           
 pstate: 014000c5 (nzcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)                                                                                                                                                                                                         
 pc : __queue_delayed_work+0xb8/0xe8                                                                                                                                                                                                                                      
 lr : queue_delayed_work_on+0x70/0x98                                                                                                                                                                                                                                     
 sp : ffff800008a23b10                                                                                                                                                                                                                                                    
 x29: ffff800008a23b10 x28: ffff0000f6de5880 x27: ffff0000c14d9c80                                                                                                                                                                                                        
 x26: ffff8000085510a8 x25: ffff0000c0a490d0 x24: ffff0000c14d9cd8                                                                                                                                                                                                        
 x23: ffff800008a23da8 x22: fffffffffffffff2 x21: 0000000000000000                                                                                                                                                                                                        
 x20: 0000000000000001 x19: 0000000000000000 x18: 0000000000000000                                                                                                                                                                                                       
 x17: 0000000000000000 x16: ffffba73a9885008 x15: 0000aaaad5a0b6b0
 x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000000000 x10: 0000000000000000 x9 : ffffba73a9885078
 x8 : ffff800008a23c98 x7 : 0000000000000000 x6 : 0000000000000000
 x5 : ffffba73a9884ea8 x4 : 0000000000000100 x3 : 00000000000000fa
 x2 : ffff0000c14d9e98 x1 : ffff0000c0028600 x0 : ffff0000c14d9eb8
Call trace:
  __queue_delayed_work+0xb8/0xe8
  queue_delayed_work_on+0x70/0x98
  cxl_pci_mbox_send+0x404/0x580 [cxl_pci]
  cxl_internal_send_cmd+0x48/0x110 [cxl_core]
  cxl_mem_sanitize+0xbc/0x140 [cxl_core]
  security_sanitize_store+0x98/0xf0 [cxl_core]
  dev_attr_store+0x20/0x40
  sysfs_kf_write+0x4c/0x68
  kernfs_fop_write_iter+0x128/0x200
  vfs_write+0x1ac/0x2e8
  ksys_write+0x74/0x110
  __arm64_sys_write+0x24/0x38
  invoke_syscall.constprop.0+0x58/0xf8
  do_el0_svc+0x60/0x168
  el0_svc+0x38/0xf0
  el0t_64_sync_handler+0xf4/0x120
  el0t_64_sync+0x190/0x198
 ---[ end trace 0000000000000000 ]---
