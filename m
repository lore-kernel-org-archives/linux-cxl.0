Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3C3C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjELQdS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 12:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjELQdR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 12:33:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9801BF2
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 09:33:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHvR73tPcz67l0C;
        Sat, 13 May 2023 00:31:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 17:33:13 +0100
Date:   Fri, 12 May 2023 17:33:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC 0/3] Apply SRAT defined PXM to entire CFMWS
Message-ID: <20230512173312.00004f11@Huawei.com>
In-Reply-To: <645d6f5f52ff7_1e6f2942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1683742429.git.alison.schofield@intel.com>
        <645d6f5f52ff7_1e6f2942f@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023 15:42:39 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The patch that created fake NUMA nodes for CFMWS windows  
> 
> "fake" seems the wrong word to me. These are first class Linux NUMA
> nodes in the end. So to me it's the "patch that extended SRAT proximity
> domains by the potential performance-class windows in the CFMWS", or
> something like that.
> 
> > not defined in the SRAT, made wrong assumptions about the
> > SRAT defined entries. Specifically, it assumed an SRAT entry
> > using cfmws->start, uses the entire CMFWS range, start through
> > end. The assumption is wrong, and so the ACPI driver, needs  
> 
> I also wouldn't say it was wrong, just incomplete. I.e. this is just
> extending the heuristic to say that if the BIOS describes *any* portion
> of a CFMWS window with a proximity domain, might as well reuse that
> proximity domain for the entire window since everything in that window
> is expected to be of a similar performance class.

Some strong assumptions in this statement.

A platform might not care about QTG groups because it's not doing any fancy
QOS stuff (or at least not enough of them to cover 'similar' performance).
At that point, you could have just a few CFMWS with a wide range
of different characteristics.  At somepoint I think we'll need to do
something more sophisticated to cover that case.  Maybe not yet though.
The moment we have platforms doing interleave or not in the host bridges
we will get very different bandwidth at least, potentially to different
parts of identical memory on the same device.  What fun ;)

Jonathan

> 
> > to examine the SRAT created memblks more closely to discover
> > partial definitions of the HPA range.
> > 
> > This work-in-progress addresses that issue. The first 2 patches
> > introduce numa helpers that are used in the 3rd patch, where the
> > ACPI drivers parsing of the CFMWS is updated.
> > 
> > The patch commit logs, especially Patch 3, describes more
> > of the approach as well as other approaches considered, and
> > questions. So, perhaps, scan 1 & 2, and dive into #3 and 
> > confirm or refute this approach.
> > 
> > I did not include our NUMA or ACPI friends in this posting,
> > because I want to get a direction check from CXL folks before
> > addressing how the helpers can get merged into the NUMA arch.
> > 
> > Thanks for looking!
> > 
> > Alison Schofield (3):
> >   x86/numa: Introduce numa_find_node(start, end)
> >   x86/numa: Introduce numa_remove_memblks(node, start, end)
> >   ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window
> > 
> >  arch/x86/include/asm/numa.h |  2 ++
> >  arch/x86/mm/numa.c          | 36 ++++++++++++++++++++++++++++++++++++
> >  drivers/acpi/numa/srat.c    | 32 ++++++++++++++++++++++++++------
> >  3 files changed, 64 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.37.3
> >   
> 
> 

