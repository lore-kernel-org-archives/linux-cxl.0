Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9817C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 14:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJLOKq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJLOKp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 10:10:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F727286B
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 07:10:42 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MnZJd1Yrpz688N8;
        Wed, 12 Oct 2022 22:09:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 12 Oct 2022 16:10:39 +0200
Received: from localhost (10.48.128.94) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 15:10:37 +0100
Date:   Wed, 12 Oct 2022 15:10:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <mst@redhat.com>,
        <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH 3/5] hw/mem/cxl_type: Generalize CDATDsmas
 initialization for Memory Regions
Message-ID: <20221012150911.0000507f@huawei.com>
In-Reply-To: <20221011211916.117552-4-gregory.price@memverge.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
        <20221011211916.117552-1-gregory.price@memverge.com>
        <20221011211916.117552-4-gregory.price@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.128.94]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Oct 2022 17:19:14 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> This is a preparatory commit for enabling multiple memory regions within
> a single CXL Type-3 device.  We will need to initialize multiple CDAT
> DSMAS regions (and subsequent DSLBIS, and DSEMTS entries), so generalize
> the intialization into a function.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

Hi Gregory,

Main comment here is that DOE isn't in yet.  Some of the changes
you have made in here should be review comments on that series rather
than here.

I'm also not keen on taking the various allocations to arrays,
particularly when seeing the hacky result in the free routine.

Just spin some more pointers and 3 more allocations (once persistent is
added).

Jonathan

> ---
>  hw/mem/cxl_type3.c | 275 +++++++++++++++++++++++++--------------------
>  1 file changed, 154 insertions(+), 121 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 282f274266..dda78704c2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -24,145 +24,178 @@
>  #define UI64_NULL ~(0ULL)
>  #define DWORD_BYTE 4
>  
> +static int ct3_build_dsmas(CDATDsmas *dsmas,
> +                           CDATDslbis *dslbis,
> +                           CDATDsemts *dsemts,
> +                           MemoryRegion *mr,
> +                           int dsmad_handle,
> +                           bool is_pmem,
> +                           uint64_t dpa_base)

Rewrap this to be just under 80 characters per line.

This is building a lot more than DSMAS.
Could rename it, or could break it down into functions
that deal with each type  of entry.

> +{
> +    int len = 0;
> +    /* ttl_len should be incremented for every entry */

ttl_ ?

Given you now allocate outside of this function, probably
more appropriate to just add the entries up there.


> +
> +    /* Device Scoped Memory Affinity Structure */
> +    *dsmas = (CDATDsmas) {
> +        .header = {
> +            .type = CDAT_TYPE_DSMAS,
> +            .length = sizeof(*dsmas),
> +        },
> +        .DSMADhandle = dsmad_handle,
> +        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0),
> +        .DPA_base = dpa_base,
> +        .DPA_length = int128_get64(mr->size),
> +    };
> +    len++;
> +
> +    /* For now, no memory side cache, plausiblish numbers */
> +    dslbis[0] = (CDATDslbis) {
> +        .header = {
> +            .type = CDAT_TYPE_DSLBIS,
> +            .length = sizeof(*dslbis),
> +        },
> +        .handle = dsmad_handle,
> +        .flags = HMAT_LB_MEM_MEMORY,
> +        .data_type = HMAT_LB_DATA_READ_LATENCY,
> +        .entry_base_unit = 10000, /* 10ns base */
> +        .entry[0] = 15, /* 150ns */
> +    };
> +    len++;
> +
> +    dslbis[1] = (CDATDslbis) {
> +        .header = {
> +            .type = CDAT_TYPE_DSLBIS,
> +            .length = sizeof(*dslbis),
> +        },
> +        .handle = dsmad_handle,
> +        .flags = HMAT_LB_MEM_MEMORY,
> +        .data_type = HMAT_LB_DATA_WRITE_LATENCY,
> +        .entry_base_unit = 10000,
> +        .entry[0] = 25, /* 250ns */
> +    };
> +    len++;
> +
> +    dslbis[2] = (CDATDslbis) {
> +        .header = {
> +            .type = CDAT_TYPE_DSLBIS,
> +            .length = sizeof(*dslbis),
> +            },
> +        .handle = dsmad_handle,
> +        .flags = HMAT_LB_MEM_MEMORY,
> +        .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
> +        .entry_base_unit = 1000, /* GB/s */
> +        .entry[0] = 16,
> +    };
> +    len++;
> +
> +    dslbis[3] = (CDATDslbis) {
> +        .header = {
> +            .type = CDAT_TYPE_DSLBIS,
> +            .length = sizeof(*dslbis),
> +        },
> +        .handle = dsmad_handle,
> +        .flags = HMAT_LB_MEM_MEMORY,
> +        .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
> +        .entry_base_unit = 1000, /* GB/s */
> +        .entry[0] = 16,
> +    };
> +    len++;
> +
> +    *dsemts = (CDATDsemts) {
> +        .header = {
> +            .type = CDAT_TYPE_DSEMTS,
> +            .length = sizeof(*dsemts),
> +        },
> +        .DSMAS_handle = dsmad_handle,
> +        /* EFI_MEMORY_NV implies EfiReservedMemoryType */
> +        .EFI_memory_type_attr = is_pmem ? 2 : 0,
> +        /* Reserved - the non volatile from DSMAS matters */
> +        .DPA_offset = 0,
> +        .DPA_length = int128_get64(mr->size),
> +    };
> +    len++;
> +    return len;
> +}
> +
>  static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>                                  void *priv)
>  {
> -    g_autofree CDATDsmas *dsmas_nonvolatile = NULL;
> -    g_autofree CDATDslbis *dslbis_nonvolatile = NULL;
> -    g_autofree CDATDsemts *dsemts_nonvolatile = NULL;
> +    g_autofree CDATDsmas *dsmas = NULL;
> +    g_autofree CDATDslbis *dslbis = NULL;
> +    g_autofree CDATDsemts *dsemts = NULL;
>      CXLType3Dev *ct3d = priv;
> -    int len = 0;

There are changes in here that aren't necessary and just result
in a much harder diff to review.  Why rename len to cdat_len?

> -    int i = 0;
> -    int next_dsmad_handle = 0;
> -    int nonvolatile_dsmad = -1;
> -    int dslbis_nonvolatile_num = 4;
> +    int cdat_len = 0;
> +    int cdat_idx = 0, sub_idx = 0;
> +    int dsmas_num, dslbis_num, dsemts_num;
> +    int dsmad_handle = 0;
> +    uint64_t dpa_base = 0;
>      MemoryRegion *mr;
>  
> -    /* Non volatile aspects */
> -    if (ct3d->hostmem) {
> -        dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
> -        if (!dsmas_nonvolatile) {
> -            return -ENOMEM;
> -        }
> -        nonvolatile_dsmad = next_dsmad_handle++;
> -        mr = host_memory_backend_get_memory(ct3d->hostmem);
> -        if (!mr) {
> -            return -EINVAL;
> -        }
> -        *dsmas_nonvolatile = (CDATDsmas) {
> -            .header = {
> -                .type = CDAT_TYPE_DSMAS,
> -                .length = sizeof(*dsmas_nonvolatile),
> -            },
> -            .DSMADhandle = nonvolatile_dsmad,
> -            .flags = CDAT_DSMAS_FLAG_NV,
> -            .DPA_base = 0,
> -            .DPA_length = int128_get64(mr->size),
> -        };
> -        len++;
> -
> -        /* For now, no memory side cache, plausiblish numbers */
> -        dslbis_nonvolatile = g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
> -        if (!dslbis_nonvolatile)
> -            return -ENOMEM;
> -
> -        dslbis_nonvolatile[0] = (CDATDslbis) {
> -            .header = {
> -                .type = CDAT_TYPE_DSLBIS,
> -                .length = sizeof(*dslbis_nonvolatile),
> -            },
> -            .handle = nonvolatile_dsmad,
> -            .flags = HMAT_LB_MEM_MEMORY,
> -            .data_type = HMAT_LB_DATA_READ_LATENCY,
> -            .entry_base_unit = 10000, /* 10ns base */
> -            .entry[0] = 15, /* 150ns */
> -        };
> -        len++;
> -
> -        dslbis_nonvolatile[1] = (CDATDslbis) {
> -            .header = {
> -                .type = CDAT_TYPE_DSLBIS,
> -                .length = sizeof(*dslbis_nonvolatile),
> -            },
> -            .handle = nonvolatile_dsmad,
> -            .flags = HMAT_LB_MEM_MEMORY,
> -            .data_type = HMAT_LB_DATA_WRITE_LATENCY,
> -            .entry_base_unit = 10000,
> -            .entry[0] = 25, /* 250ns */
> -        };
> -        len++;
> -       
> -        dslbis_nonvolatile[2] = (CDATDslbis) {
> -            .header = {
> -                .type = CDAT_TYPE_DSLBIS,
> -                .length = sizeof(*dslbis_nonvolatile),
> -            },
> -            .handle = nonvolatile_dsmad,
> -            .flags = HMAT_LB_MEM_MEMORY,
> -            .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
> -            .entry_base_unit = 1000, /* GB/s */
> -            .entry[0] = 16,
> -        };
> -        len++;
> -
> -        dslbis_nonvolatile[3] = (CDATDslbis) {
> -            .header = {
> -                .type = CDAT_TYPE_DSLBIS,
> -                .length = sizeof(*dslbis_nonvolatile),
> -            },
> -            .handle = nonvolatile_dsmad,
> -            .flags = HMAT_LB_MEM_MEMORY,
> -            .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
> -            .entry_base_unit = 1000, /* GB/s */
> -            .entry[0] = 16,
> -        };
> -        len++;
> -
> -        mr = host_memory_backend_get_memory(ct3d->hostmem);
> -        if (!mr) {
> -            return -EINVAL;
> -        }
> -        dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
> -        *dsemts_nonvolatile = (CDATDsemts) {
> -            .header = {
> -                .type = CDAT_TYPE_DSEMTS,
> -                .length = sizeof(*dsemts_nonvolatile),
> -            },
> -            .DSMAS_handle = nonvolatile_dsmad,
> -            .EFI_memory_type_attr = 2, /* Reserved - the non volatile from DSMAS matters */
> -            .DPA_offset = 0,
> -            .DPA_length = int128_get64(mr->size),
> -        };
> -        len++;
> +    if (!ct3d->hostmem | !host_memory_backend_get_memory(ct3d->hostmem)) {

I don't immediately see why we need this test here and didn't previously.  If it
should always have been there, put that as a review on the DOE patches not here.

> +        return -EINVAL;
> +    }
> +
> +    dsmas_num = 1;
> +    dslbis_num = 4 * dsmas_num;
> +    dsemts_num = dsmas_num;
> +
> +    dsmas = g_malloc(sizeof(*dsmas) * dsmas_num);

As we aren't likely to add any more entries after non volatile
I'm not convinced making everything arrays then indexing into them
is worth while, particularly as it's causing huge amounts of churn.

If this style of preallocate then fill makes more sense (I don't particularly
like it breaks up the handling of each element), then propose that in review
of the original series.  Having this level of 'style' of function
change here makes for a hard to read set.  We can still change the
original patch.  I'm not yet convinced it's worth making that change.

I think I'd rather see the allocation and fill all in the factored out function.


> +    dslbis = g_malloc(sizeof(*dslbis) * dslbis_num);
> +    dsemts = g_malloc(sizeof(*dsemts) * dsemts_num);
> +
> +    if (!dsmas || !dslbis || !dsemts) {
> +        return -ENOMEM;
> +    }
> +
> +    mr = host_memory_backend_get_memory(ct3d->hostmem);
> +    cdat_len += ct3_build_dsmas(&dsmas[dsmad_handle],

There isn't a specific connection between dsmad_handle.  This code
kind of makes it look like it's not just that we've decided to use handle
0 and later 1.

That's another reason I'd rather not do this with arrays.

> +                                &dslbis[4 * dsmad_handle],
> +                                &dsemts[dsmad_handle],
> +                                mr,
> +                                dsmad_handle,
> +                                false,
> +                                dpa_base);
> +    dpa_base += mr->size;
> +    dsmad_handle++;
> +
> +    /* Allocate and fill in the CDAT table */
> +    *cdat_table = g_malloc0(cdat_len * sizeof(*cdat_table));
> +    if (!*cdat_table) {
> +        return -ENOMEM;
>      }
>  
> -    *cdat_table = g_malloc0(len * sizeof(*cdat_table));

Looks like I'm missing an allocation failure check here in original
code. Please put that in a review of that series rather than introducing
the change hidden down in here. 

>      /* Header always at start of structure */
> -    if (dsmas_nonvolatile) {
> -        (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
> +    CDATDsmas *dsmas_ent = g_steal_pointer(&dsmas);

We should not be introducing new local variables down here.
Style wise stick to old school C style of all definitions at the top
or within a scoped region {}.


> +    for (sub_idx = 0; sub_idx < dsmas_num; sub_idx++) {
> +        (*cdat_table)[cdat_idx++] = (CDATSubHeader*)&dsmas_ent[sub_idx];

for a local index j is fine.
Using a more specific name for what was i is fair enough.  Belongs
in review of original patch given that hasn't been accepted yet.

>      }
> -    if (dslbis_nonvolatile) {
> -        CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);        
> -        int j;
>  
> -        for (j = 0; j < dslbis_nonvolatile_num; j++) {
> -            (*cdat_table)[i++] = (CDATSubHeader *)&dslbis[j];
> -        }
> +    CDATDslbis *dslbis_ent = g_steal_pointer(&dslbis);
> +    for (sub_idx = 0; sub_idx < dslbis_num; sub_idx++) {
> +        (*cdat_table)[cdat_idx++] = (CDATSubHeader*)&dslbis_ent[sub_idx];
>      }
> -    if (dsemts_nonvolatile) {
> -        (*cdat_table)[i++] = g_steal_pointer(&dsemts_nonvolatile);
> +
> +    CDATDsemts *dsemts_ent = g_steal_pointer(&dsemts);
> +    for (sub_idx = 0; sub_idx < dsemts_num; sub_idx++) {
> +        (*cdat_table)[cdat_idx++] = (CDATSubHeader*)&dsemts_ent[sub_idx];
>      }
> -    
> -    return len;
> +
> +    return cdat_len;
>  }
>  
>  static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
>  {
> -    int i;
> +    int dsmas_num = 1;
> +    int dslbis_idx = dsmas_num;
> +    int dsemts_idx = dsmas_num + (dsmas_num * 4);
> +
> +    /* There are only 3 sub-tables to free: dsmas, dslbis, dsemts */
> +    assert(num == (dsmas_num + (dsmas_num * 4) + (dsmas_num)));

This alone is a very good reason not to do allocations as arrays.
It looks extremely fragile to me.  Lets just pay the cost of a few
more small allocations to keep the code easier to maintain.


> +
> +    g_free(cdat_table[0]);
> +    g_free(cdat_table[dslbis_idx]);
> +    g_free(cdat_table[dsemts_idx]);
>  
> -    for (i = 0; i < num; i++) {
> -        g_free(cdat_table[i]);
> -    }
>      g_free(cdat_table);
>  }
>  

