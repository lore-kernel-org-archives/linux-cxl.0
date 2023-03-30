Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F88C761A6
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjC3SZ5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjC3SZ4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:25:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ABDEB69
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:25:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnX0B1Q3bz6J7dq;
        Fri, 31 Mar 2023 02:25:14 +0800 (CST)
Received: from localhost (10.48.159.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 19:25:52 +0100
Date:   Thu, 30 Mar 2023 19:25:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/region: Move coherence tracking into
 cxl_region_attach()
Message-ID: <20230330192552.00003f54@Huawei.com>
In-Reply-To: <6425d20ac14fb_c722294c9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168002858817.50647.1217607907088920888.stgit@dwillia2-xfh.jf.intel.com>
        <20230330182807.0000662a@Huawei.com>
        <6425d20ac14fb_c722294c9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.159.148]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 30 Mar 2023 11:16:42 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Tue, 28 Mar 2023 11:36:28 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Each time the contents of a given HPA are potentially changed in a cache
> > > incoherent manner the CXL core sets CXL_REGION_F_INCOHERENT to
> > > invalidate CPU caches before the region is used.
> > > 
> > > Successful invocation of attach_target() indicates that DPA has been
> > > newly assigned to a given HPA in the dynamic region creation flow.
> > > However, attach_target() is also reused in the autodiscovery flow where
> > > the region was activated by platform firmware. In that case there is no
> > > need to invalidate caches because that region is already in active use
> > > and nothing about the autodiscovery flow modifies the HPA-to-DPA
> > > relationship.
> > > 
> > > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > 
> > Looks correct to me.  Might be worth making it clear in the patch description
> > that for auto discovered regions, we have exited cxl_region_attach()
> > before the point where you set the flag.  
> 
> Sure, added:
> 
> "In the autodiscovery case cxl_region_attach() exits early after
> determining the endpoint decoder is already correctly attached to the
> region."
Thanks.
> 
> 
> > I'm also fairly sure that in previous flow the cache flush was happening on
> > each target being added rather than just on the final one being added which
> > would be a significant overhead also avoided via this patch.  
> 
> No, it did set the bit multiple times, but the actual flush itself does
> not occur until the region is activated in cxl_region_probe() (the only
> caller of cxl_region_invalidate_memregion()).

ah. That makes sense.  Bit isn't magic :)
