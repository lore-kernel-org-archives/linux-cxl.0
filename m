Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFA7C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJJPbs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJJPbr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 11:31:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D9C1C13C
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 08:31:45 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmNC80pmMz687hH;
        Mon, 10 Oct 2022 23:30:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:31:43 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 16:31:43 +0100
Date:   Mon, 10 Oct 2022 16:31:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH 2/2] cxl/pmem: Fix failure to account for 8 byte header
 for writes to the device LSA.
Message-ID: <20221010163053.00003207@huawei.com>
In-Reply-To: <20220817122930.00004f27@huawei.com>
References: <20220815154044.24733-1-Jonathan.Cameron@huawei.com>
        <20220815154044.24733-3-Jonathan.Cameron@huawei.com>
        <62fac0de2685b_dfbc1294d2@dwillia2-xfh.jf.intel.com.notmuch>
        <20220817122930.00004f27@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 17 Aug 2022 12:29:30 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 15 Aug 2022 14:55:42 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > [ apologies if this is a duplicate response ]
> > 
> > Jonathan Cameron wrote:  
> > > Writes to the device must include an offset and size as defined in
> > > CXL 2.0 8.2.9.5.2.4 Set LSA (Opcode 4103h)
> > > 
> > > Fixes tag is non obvious as this code has been through several
> > > reworks and variable names + wasn't in use until the addition
> > > of the region code.    
> > 
> > Looks like:
> > 
> > Fixes: 60b8f17215de ("cxl/pmem: Translate NVDIMM label commands to CXL label commands")
> > 
> > ...to me since any transfer that got within 8 bytes of the payload_size
> > would fail.  
> 
> Makes sense - go with that one.

Hi Dan,

I was assuming you'd pick this up as b4 will happily pick the fixes
tag out of the thread and there weren't any other comments.

Let me know if you want me to resend with the tag in place.

Thanks,

Jonathan
 
> 
> > 
> > I notice that cxl_test worked around this bug simply because the mocking
> > does not attempt to emulate the actual mailbox transfer, just the
> > logical data transfer. I apprecitate having QEMU to back up the unit
> > testing.
> >   
> 

