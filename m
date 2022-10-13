Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B02C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 14:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJMOk3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMOk1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 10:40:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D496786FF
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 07:40:25 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MpBxM14wMz67PTQ;
        Thu, 13 Oct 2022 22:39:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 16:40:22 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 15:40:22 +0100
Date:   Thu, 13 Oct 2022 15:40:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, Ben Widawsky <bwidawsk@kernel.org>,
        Gregory Price <gregory.price@memverge.com>, <mst@redhat.com>,
        <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH v7 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <20221013154021.00007b02@huawei.com>
In-Reply-To: <Y0gGAW6eRPuv1Y3b@fedora>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
        <20221012182120.174142-1-gregory.price@memverge.com>
        <20221013095749.0000052d@huawei.com>
        <CAD3UvdRYH2NVck-kLYLQcBym-5TY0WXWj7vCzcRi5yEuVfgzcQ@mail.gmail.com>
        <20221013125313.00007016@huawei.com>
        <Y0gGAW6eRPuv1Y3b@fedora>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 13 Oct 2022 08:35:13 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> fwiw this is what my function looked like after the prior changes, very
> similar to yours proposed below

Makes sense given only real change is exactly where the size comes from ;)

FYI, I've pushed out latest version on top of qemu/master
at gitlab.com/jic23/ as tag doe-v8

Just as soon as I finish bouncing patches to a machine I can push from
I'll push out the rest of my queue.

My current thought is to slide your series under the rest of that queue
(so directly on top of the DOE set - v8+ depending on reviews).

The other series coming through is Ira's event injection but my guess
is that will take a bit more time to stabilize.

Jonathan

> 
> static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>                                 void *priv)
> {
>     CXLType3Dev *ct3d = priv;
>     MemoryRegion *vmr = NULL, *pmr = NULL;
>     uint64_t dpa_base = 0;
>     int dsmad_handle = 0;
>     int num_ents = 0;
>     int cur_ent = 0;
>     int ret = 0;
> 
>     if (ct3d->hostvmem) {
>         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
>         if (!vmr)
>             return -EINVAL;
>         num_ents += CT3_CDAT_SUBTABLE_SIZE;
>     }
>     if (ct3d->hostpmem) {
>         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
>         if (!pmr)
>             return -EINVAL;
>         num_ents += CT3_CDAT_SUBTABLE_SIZE;
>     }
>     if (!num_ents) {
>         return 0;
>     }
> 
>     *cdat_table = g_malloc0(num_ents * sizeof(*cdat_table));
>     if (!*cdat_table) {
>         return -ENOMEM;
>     }
> 
>     /* Volatile aspects are mapped first */
>     if (vmr) {
>         ret = ct3_build_cdat_subtable(*cdat_table, vmr, dsmad_handle++,
>                                       false, dpa_base);
>         if (ret < 0) {
>             goto error_cleanup;
>         }
>         dpa_base = vmr->size;
>         cur_ent += ret;
>     }
>     /* Non volatile aspects */
>     if (pmr) {
>         /* non-volatile entries follow the volatile entries */
>         ret = ct3_build_cdat_subtable(&(*cdat_table)[cur_ent], pmr,
>                                       dsmad_handle, true, dpa_base);
>         if (ret < 0) {
>             goto error_cleanup;
>         }
>         cur_ent += ret;
>     }
>     assert(cur_ent == num_ents);
> 
>     return ret;
> error_cleanup:
>     int i;
>     for (i = 0; i < num_ents; i++) {

Might as well loop only to cur_ent as the rest will be NULL.


>         g_free(*cdat_table[i]);
>     }
>     g_free(*cdat_table);
>     return ret;
> }
> 
> 
> On Thu, Oct 13, 2022 at 12:53:13PM +0100, Jonathan Cameron wrote:
> > On Thu, 13 Oct 2022 07:36:28 -0400
> > Gregory Price <gourry.memverge@gmail.com> wrote:
> >   
> > > Reading through your notes, everything seems reasonable, though I'm not
> > > sure I agree with the two pass notion, though I'll wait to see the patch
> > > set.
> > > 
> > > The enum is a good idea, *forehead slap*, I should have done it.  If we
> > > have a local enum, why not just make it global (within the file) and
> > > allocate the table as I have once we know how many MRs are present?  
> > 
> > It's not global as we need the entries to be packed.  So if just one mr
> > (which ever one) the entries for that need to be at the beginning of
> > cdat_table.  I also don't want to bake into the outer caller that the
> > entries will always be the same size for different MRs.
> > 
> > For the two pass case...
> > 
> > I'll send code in a few mins, but in meantime my thought is that
> > the extended code for volatile + non volatile will looks something like:
> > (variable names made up)
> > 
> > 	if (ct3d->volatile_mem) {
> > 		volatile_mr = host_memory_backend_get_memory(ct3d->volatile_mem....);
> > 		if (!volatile_mr) {
> > 			return -ENINVAL;
> > 		}
> > 		rc = ct3_build_cdat_entries_for_mr(NULL, dsmad++, volatile_mr);
> > 		if (rc < 0) {
> > 			return rc;
> > 		}
> > 		volatile_len = rc;
> > 	}
> > 
> > 	if (ct3d->nonvolatile_mem) {
> > 		nonvolatile_mr = host_memory_backend_get_memory(ct3d->nonvolatile_mem);
> > 		if (!nonvolatile_mr) {
> > 			return -ENINVAL;
> > 		}
> > 		rc = ct3_build_cdat_entries_for_mr(NULL, dmsmad++, nonvolatile_mr....);
> > 		if (rc < 0) {
> > 			return rc;
> > 		}
> > 		nonvolatile_len = rc;
> > 	}
> > 
> > 	dsmad = 0;
> > 
> > 	table = g_malloc(0, (volatile_len + nonvolatile_len) * sizeof(*table));
> > 	if (!table) {
> > 		return -ENOMEM;
> > 	}
> > 	
> > 	if (volatile_len) {
> > 		rc = ct3_build_cdat_entries_for_mr(&table[0], dmsad++, volatile_mr....);
> > 		if (rc < 0) {
> > 			return rc;
> > 		}
> > 	}	
> > 	if (nonvolatile_len) {
> > 		rc = ct3_build_cdat_entries_for_mr(&table[volatile_len], dsmad++, nonvolatile_mr...);
> > 		if (rc < 0) {
> > 			/* Only place we need error handling.  Could make it more generic of course */
> > 			for (i = 0; i < volatile_len; i++) {
> > 				g_free(cdat_table[i]);
> > 			}
> > 			return rc;
> > 		}
> > 	}
> > 
> > 	*cdat_table = g_steal_pointer(&table);
> > 
> > 
> > Jonathan
> >   
> > > 
> > > 6 eggs/half dozen though, I'm ultimately fine with either.
> > > 
> > > On Thu, Oct 13, 2022, 4:58 AM Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > wrote:
> > >   
> > > > On Wed, 12 Oct 2022 14:21:15 -0400
> > > > Gregory Price <gourry.memverge@gmail.com> wrote:
> > > >    
> > > > > Included in this response is a recommended patch set on top of this
> > > > > patch that resolves a number of issues, including style and a heap
> > > > > corruption bug.
> > > > >
> > > > > The purpose of this patch set is to refactor the CDAT initialization
> > > > > code to support future patch sets that will introduce multi-region
> > > > > support in CXL Type3 devices.
> > > > >
> > > > > 1) Checkpatch errors in the immediately prior patch
> > > > > 2) Flatting of code in cdat initialization
> > > > > 3) Changes in allocation and error checking for cleanliness
> > > > > 4) Change in the allocation/free strategy of CDAT sub-tables to simplify
> > > > >    multi-region allocation in the future.  Also resolves a heap
> > > > >    corruption bug
> > > > > 5) Refactor of CDAT initialization code into a function that initializes
> > > > >    sub-tables per memory-region.
> > > > >
> > > > > Gregory Price (5):
> > > > >   hw/mem/cxl_type3: fix checkpatch errors
> > > > >   hw/mem/cxl_type3: Pull validation checks ahead of functional code
> > > > >   hw/mem/cxl_type3: CDAT pre-allocate and check resources prior to work
> > > > >   hw/mem/cxl_type3: Change the CDAT allocation/free strategy
> > > > >   hw/mem/cxl_type3: Refactor CDAT sub-table entry initialization into a
> > > > >     function
> > > > >
> > > > >  hw/mem/cxl_type3.c | 240 +++++++++++++++++++++++----------------------
> > > > >  1 file changed, 122 insertions(+), 118 deletions(-)
> > > > >    
> > > >
> > > > Thanks, I'm going to roll this stuff into the original patch set for v8.
> > > > Some of this I already have (like the check patch stuff).
> > > > Some I may disagree with in which case  I'll reply to the patches - note
> > > > I haven't looked at them in detail yet!
> > > >
> > > > Jonathan
> > > >    
> > >   
> >   

