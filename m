Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63866C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 12:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJMMf3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMMf1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 08:35:27 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1277A503
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 05:35:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id r19so862412qtx.6
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gozgW6W4zcxbp7BYJvo59EouJU4f/yerB3KkmxDpsx8=;
        b=FJA5ppSNG4xaKAGyTpVrxLWoJIhWpSU6tM9oxiik7uNlpHe5FG1ikbISzXmssLzm81
         g1WuGn4QUV2q8vJg/KuajCCSzVmdXNr5fKgwJT3RP+8Ev72c+RxeW3QMXDFUSRW27gSA
         9qX5qK05fAwMWAONsvwry2zkGjc8qS7ETsXB3Fl4aY5p/3rQTBiGrNgAOKeENehJEHPm
         pwglM1W0wT+N383LmFJRxI6/rIxweDWR3mWjS4aIofiv2IqmCaVeJKnOePTEaNDL9yw3
         7AbJogT3eQKV12vKzXW5UYpUNYWRGT0X8bIDMhd3bGpaDLZk0V5xkaBzVzPbEKHQVvmB
         zRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gozgW6W4zcxbp7BYJvo59EouJU4f/yerB3KkmxDpsx8=;
        b=5T0owsAVLHW3OjznF27JJOTMeaT5zfJ6SGg5OK02+35+ssLTi9Pfytqkr7lcOC76mz
         2lODsYHlHD3KmAqi+Cri/ZAIfgKabjXobVebnRXmU2Tjlaf5XvQmgEXhz73GlOw4yvuE
         qugABQ2OHPz9AzvEhIQBMYnajmt9LT8qwX6rBN2ZMKVI7FY8klHQaz7G9ZmT17rjroHQ
         U4wwCtgyGCRBvgnleZ1T9h1G1U9Xd5OI6geE49vpUItuSjaFEt9RxQSN1PV5/FH75APD
         xe6iofldlfVyf65iHUkzvY7ieklCU6zdJUvB825gCTKYwYzOjhmvXhHvPuULXwD2jNie
         DTUw==
X-Gm-Message-State: ACrzQf0hs3c7Q5wUEsixSTL0+GbgcHqEyozlvpKfV+6PQEwOlU00O1Ya
        yYKCSBMNG0wClrsKg45KjQ==
X-Google-Smtp-Source: AMsMyM5T5X4/5hiCtyI5IbuIYTXINSAus/WICqfXG2JFz0CTadvo+fatND4Ka7rXWscCJRxUcsIdjg==
X-Received: by 2002:a05:622a:18b:b0:35d:5ba6:ef55 with SMTP id s11-20020a05622a018b00b0035d5ba6ef55mr26772763qtw.603.1665664515311;
        Thu, 13 Oct 2022 05:35:15 -0700 (PDT)
Received: from fedora (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y11-20020ac8128b000000b0039a275607c3sm8575516qti.55.2022.10.13.05.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 05:35:14 -0700 (PDT)
Date:   Thu, 13 Oct 2022 08:35:13 -0400
From:   Gregory Price <gourry.memverge@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, a.manzanares@samsung.com,
        Ben Widawsky <bwidawsk@kernel.org>,
        Gregory Price <gregory.price@memverge.com>, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: Re: [PATCH v7 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <Y0gGAW6eRPuv1Y3b@fedora>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
 <20221012182120.174142-1-gregory.price@memverge.com>
 <20221013095749.0000052d@huawei.com>
 <CAD3UvdRYH2NVck-kLYLQcBym-5TY0WXWj7vCzcRi5yEuVfgzcQ@mail.gmail.com>
 <20221013125313.00007016@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013125313.00007016@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


fwiw this is what my function looked like after the prior changes, very
similar to yours proposed below

static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
                                void *priv)
{
    CXLType3Dev *ct3d = priv;
    MemoryRegion *vmr = NULL, *pmr = NULL;
    uint64_t dpa_base = 0;
    int dsmad_handle = 0;
    int num_ents = 0;
    int cur_ent = 0;
    int ret = 0;

    if (ct3d->hostvmem) {
        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
        if (!vmr)
            return -EINVAL;
        num_ents += CT3_CDAT_SUBTABLE_SIZE;
    }
    if (ct3d->hostpmem) {
        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
        if (!pmr)
            return -EINVAL;
        num_ents += CT3_CDAT_SUBTABLE_SIZE;
    }
    if (!num_ents) {
        return 0;
    }

    *cdat_table = g_malloc0(num_ents * sizeof(*cdat_table));
    if (!*cdat_table) {
        return -ENOMEM;
    }

    /* Volatile aspects are mapped first */
    if (vmr) {
        ret = ct3_build_cdat_subtable(*cdat_table, vmr, dsmad_handle++,
                                      false, dpa_base);
        if (ret < 0) {
            goto error_cleanup;
        }
        dpa_base = vmr->size;
        cur_ent += ret;
    }
    /* Non volatile aspects */
    if (pmr) {
        /* non-volatile entries follow the volatile entries */
        ret = ct3_build_cdat_subtable(&(*cdat_table)[cur_ent], pmr,
                                      dsmad_handle, true, dpa_base);
        if (ret < 0) {
            goto error_cleanup;
        }
        cur_ent += ret;
    }
    assert(cur_ent == num_ents);

    return ret;
error_cleanup:
    int i;
    for (i = 0; i < num_ents; i++) {
        g_free(*cdat_table[i]);
    }
    g_free(*cdat_table);
    return ret;
}


On Thu, Oct 13, 2022 at 12:53:13PM +0100, Jonathan Cameron wrote:
> On Thu, 13 Oct 2022 07:36:28 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > Reading through your notes, everything seems reasonable, though I'm not
> > sure I agree with the two pass notion, though I'll wait to see the patch
> > set.
> > 
> > The enum is a good idea, *forehead slap*, I should have done it.  If we
> > have a local enum, why not just make it global (within the file) and
> > allocate the table as I have once we know how many MRs are present?
> 
> It's not global as we need the entries to be packed.  So if just one mr
> (which ever one) the entries for that need to be at the beginning of
> cdat_table.  I also don't want to bake into the outer caller that the
> entries will always be the same size for different MRs.
> 
> For the two pass case...
> 
> I'll send code in a few mins, but in meantime my thought is that
> the extended code for volatile + non volatile will looks something like:
> (variable names made up)
> 
> 	if (ct3d->volatile_mem) {
> 		volatile_mr = host_memory_backend_get_memory(ct3d->volatile_mem....);
> 		if (!volatile_mr) {
> 			return -ENINVAL;
> 		}
> 		rc = ct3_build_cdat_entries_for_mr(NULL, dsmad++, volatile_mr);
> 		if (rc < 0) {
> 			return rc;
> 		}
> 		volatile_len = rc;
> 	}
> 
> 	if (ct3d->nonvolatile_mem) {
> 		nonvolatile_mr = host_memory_backend_get_memory(ct3d->nonvolatile_mem);
> 		if (!nonvolatile_mr) {
> 			return -ENINVAL;
> 		}
> 		rc = ct3_build_cdat_entries_for_mr(NULL, dmsmad++, nonvolatile_mr....);
> 		if (rc < 0) {
> 			return rc;
> 		}
> 		nonvolatile_len = rc;
> 	}
> 
> 	dsmad = 0;
> 
> 	table = g_malloc(0, (volatile_len + nonvolatile_len) * sizeof(*table));
> 	if (!table) {
> 		return -ENOMEM;
> 	}
> 	
> 	if (volatile_len) {
> 		rc = ct3_build_cdat_entries_for_mr(&table[0], dmsad++, volatile_mr....);
> 		if (rc < 0) {
> 			return rc;
> 		}
> 	}	
> 	if (nonvolatile_len) {
> 		rc = ct3_build_cdat_entries_for_mr(&table[volatile_len], dsmad++, nonvolatile_mr...);
> 		if (rc < 0) {
> 			/* Only place we need error handling.  Could make it more generic of course */
> 			for (i = 0; i < volatile_len; i++) {
> 				g_free(cdat_table[i]);
> 			}
> 			return rc;
> 		}
> 	}
> 
> 	*cdat_table = g_steal_pointer(&table);
> 
> 
> Jonathan
> 
> > 
> > 6 eggs/half dozen though, I'm ultimately fine with either.
> > 
> > On Thu, Oct 13, 2022, 4:58 AM Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > wrote:
> > 
> > > On Wed, 12 Oct 2022 14:21:15 -0400
> > > Gregory Price <gourry.memverge@gmail.com> wrote:
> > >  
> > > > Included in this response is a recommended patch set on top of this
> > > > patch that resolves a number of issues, including style and a heap
> > > > corruption bug.
> > > >
> > > > The purpose of this patch set is to refactor the CDAT initialization
> > > > code to support future patch sets that will introduce multi-region
> > > > support in CXL Type3 devices.
> > > >
> > > > 1) Checkpatch errors in the immediately prior patch
> > > > 2) Flatting of code in cdat initialization
> > > > 3) Changes in allocation and error checking for cleanliness
> > > > 4) Change in the allocation/free strategy of CDAT sub-tables to simplify
> > > >    multi-region allocation in the future.  Also resolves a heap
> > > >    corruption bug
> > > > 5) Refactor of CDAT initialization code into a function that initializes
> > > >    sub-tables per memory-region.
> > > >
> > > > Gregory Price (5):
> > > >   hw/mem/cxl_type3: fix checkpatch errors
> > > >   hw/mem/cxl_type3: Pull validation checks ahead of functional code
> > > >   hw/mem/cxl_type3: CDAT pre-allocate and check resources prior to work
> > > >   hw/mem/cxl_type3: Change the CDAT allocation/free strategy
> > > >   hw/mem/cxl_type3: Refactor CDAT sub-table entry initialization into a
> > > >     function
> > > >
> > > >  hw/mem/cxl_type3.c | 240 +++++++++++++++++++++++----------------------
> > > >  1 file changed, 122 insertions(+), 118 deletions(-)
> > > >  
> > >
> > > Thanks, I'm going to roll this stuff into the original patch set for v8.
> > > Some of this I already have (like the check patch stuff).
> > > Some I may disagree with in which case  I'll reply to the patches - note
> > > I haven't looked at them in detail yet!
> > >
> > > Jonathan
> > >  
> > 
> 
