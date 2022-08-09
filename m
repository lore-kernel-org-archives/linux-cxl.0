Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D10C19F2D
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbiHIKS6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 06:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbiHIKSp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 06:18:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA1623BE5
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 03:18:43 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M289C3hyxz689Mk;
        Tue,  9 Aug 2022 18:15:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 9 Aug 2022 12:18:41 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 9 Aug
 2022 11:18:40 +0100
Date:   Tue, 9 Aug 2022 11:18:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH v2 2/3] cxl/region: Fix x1 interleave to greater than x1
 interleave routing
Message-ID: <20220809111839.00003b43@huawei.com>
In-Reply-To: <62f163e4227ea_1b3c2945@dwillia2-xfh.jf.intel.com.notmuch>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
        <165973126583.1526540.657948655360009242.stgit@dwillia2-xfh.jf.intel.com>
        <20220808120306.00000847@huawei.com>
        <62f163e4227ea_1b3c2945@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 8 Aug 2022 12:28:36 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 05 Aug 2022 13:27:45 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > In cases where the decode fans out as it traverses downstream, the
> > > interleave granularity needs to increment to identify the port selector
> > > bits out of the remaining address bits. For example, recall that with an
> > > x2 parent port intereleave (IW == 1), the downstream decode for children
> > > of those ports will either see address bit IG+8 always set, or address
> > > bit IG+8 always clear. So if the child port needs to select a downstream
> > > port it can only use address bits starting at IG+9 (where IG and IW are
> > > the CXL encoded values for interleave granularity (ilog2(ig) - 8) and
> > > ways (ilog2(iw))).
> > > 
> > > When the parent port interleave is x1 no such masking occurs and the
> > > child port can maintain the granularity that was routed to the parent
> > > port.
> > > 
> > > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #via qemu  
> 
> Thanks Jonathan.
> 
> In the interests of being able to make a:
> 
> "these commits have appeared in Linux next with no known outstanding
> issues"
> 
> ...I'd like to note these review and test tags in the merge message.
> They will still be in the history just not in the commits directly.
> Similar to what I did here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tag/?h=libnvdimm-for-5.17
> 
> The current state of cxl/next hit linux-next last night. Let me know if
> you have any heartburn about that.

Fine by me.

I normally don't even do that if I'm rushing something in. Just rely on
the link to the thread in the actual patch description for anyone who cares.
Maybe I'll start doing something like you are, though can be a pain to gather them
up on a large pull request.

Jonathan

> 
> > Now this is resolved, I'll get qemu fix sent out (hopefully later today).  
> 
> Good to hear, thanks.

