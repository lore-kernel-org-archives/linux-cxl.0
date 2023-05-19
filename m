Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF23C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 15:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjESPOy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 11:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjESPOw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 11:14:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72554132
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 08:14:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN9MG06wJz67Q1L;
        Fri, 19 May 2023 23:12:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 16:14:49 +0100
Date:   Fri, 19 May 2023 16:14:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 1/5] hw/cxl: Use define for build bug detection
Message-ID: <20230519161448.00001983@Huawei.com>
In-Reply-To: <64668840a067b_114f6029416@iweiny-mobl.notmuch>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
        <20230517-rfc-type2-dev-v1-1-6eb2e470981b@intel.com>
        <20230518105416.000054c9@Huawei.com>
        <64668840a067b_114f6029416@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 18 May 2023 13:19:12 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 17 May 2023 19:45:54 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > Magic numbers can be confusing.
> > > 
> > > Use the range size define for CXL.cachemem rather than a magic number.
> > > Update/add spec references.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > I guess we should do a scrub to move all refs to 3.0 soon
> > given it's horrible having a mixture of spec versions for the references.
> > 
> > For future specs, we should only do this when sufficient X.Y references
> > have started to appear - I think that's true for r3.0 now.  
> 
> For the kernel side I think Dan is taking the 'if you are updating it then
> update the spec' but otherwise leave it be.  So since I'm touching the
> code I updated it.
> 
> I agree, it is a pain to have to look at the 2.0 spec but you can do it.

Only if you are either a member of the consortium, or happened to have
grabbed a copy in the past I think.  I've had people mentioning they can't
get it today.

Jonathan

> 
> Ira

