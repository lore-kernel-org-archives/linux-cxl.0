Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69869C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 11:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiHQL3f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 07:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHQL3e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 07:29:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8555245F
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 04:29:33 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M75Jk1jf0z67bHh;
        Wed, 17 Aug 2022 19:24:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 13:29:31 +0200
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 12:29:31 +0100
Date:   Wed, 17 Aug 2022 12:29:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH 2/2] cxl/pmem: Fix failure to account for 8 byte header
 for writes to the device LSA.
Message-ID: <20220817122930.00004f27@huawei.com>
In-Reply-To: <62fac0de2685b_dfbc1294d2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220815154044.24733-1-Jonathan.Cameron@huawei.com>
        <20220815154044.24733-3-Jonathan.Cameron@huawei.com>
        <62fac0de2685b_dfbc1294d2@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 15 Aug 2022 14:55:42 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> [ apologies if this is a duplicate response ]
> 
> Jonathan Cameron wrote:
> > Writes to the device must include an offset and size as defined in
> > CXL 2.0 8.2.9.5.2.4 Set LSA (Opcode 4103h)
> > 
> > Fixes tag is non obvious as this code has been through several
> > reworks and variable names + wasn't in use until the addition
> > of the region code.  
> 
> Looks like:
> 
> Fixes: 60b8f17215de ("cxl/pmem: Translate NVDIMM label commands to CXL label commands")
> 
> ...to me since any transfer that got within 8 bytes of the payload_size
> would fail.

Makes sense - go with that one.

> 
> I notice that cxl_test worked around this bug simply because the mocking
> does not attempt to emulate the actual mailbox transfer, just the
> logical data transfer. I apprecitate having QEMU to back up the unit
> testing.
> 

