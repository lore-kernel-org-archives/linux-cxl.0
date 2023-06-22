Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC62EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 13:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFVNwo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFVNwn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 09:52:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FBE2
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 06:52:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1vm37lfz6GD3S;
        Thu, 22 Jun 2023 21:49:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:52:40 +0100
Date:   Thu, 22 Jun 2023 14:52:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 06/12] cxl/memdev: Make mailbox functionality
 optional
Message-ID: <20230622145239.0000396a@Huawei.com>
In-Reply-To: <3ce55a00-ae25-c58a-841c-e405692978da@intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
        <168679260782.3436160.7587293613945445365.stgit@dwillia2-xfh.jf.intel.com>
        <3ce55a00-ae25-c58a-841c-e405692978da@intel.com>
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

On Thu, 15 Jun 2023 14:30:35 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 6/14/23 18:30, Dan Williams wrote:
> > In support of the Linux CXL core scaling for a wider set of CXL devices,
> > allow for the creation of memdevs with some memory device capabilities
> > disabled. Specifically, allow for CXL devices outside of those claiming
> > to be compliant with the generic CXL memory device class code, like
> > vendor specific Type-2/3 devices that host CXL.mem. This implies, allow
> > for the creation of memdevs that only support component-registers, not
> > necessarily memory-device-registers (like mailbox registers). A memdev
> > derived from a CXL endpoint that does not support generic class code
> > expectations is tagged "CXL_DEVTYPE_DEVMEM", while a memdev derived from a
> > class-code compliant endpoint is tagged "CXL_DEVTYPE_CLASSMEM".
> > 
> > The primary assumption of a CXL_DEVTYPE_DEVMEM memdev is that it
> > optionally may not host a mailbox. Disable the command passthrough ioctl
> > for memdevs that are not CXL_DEVTYPE_CLASSMEM, and return empty strings
> > from memdev attributes associated with data retrieved via the
> > class-device-standard IDENTIFY command. Note that empty strings were
> > chosen over attribute visibility to maintain compatibility with shipping
> > versions of cxl-cli that expect those attributes to always be present.
> > Once cxl-cli has dropped that requirement this workaround can be
> > deprecated.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
