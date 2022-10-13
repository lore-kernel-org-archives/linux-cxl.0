Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A65C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 10:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJMKrS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMKrR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 06:47:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A298FF2510
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 03:47:15 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mp5lP5S9xz6865q;
        Thu, 13 Oct 2022 18:45:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 12:47:13 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 11:47:12 +0100
Date:   Thu, 13 Oct 2022 11:47:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <mst@redhat.com>,
        <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH 5/5] hw/mem/cxl_type3: Refactor CDAT sub-table entry
 initialization into a function
Message-ID: <20221013114711.00005623@huawei.com>
In-Reply-To: <20221012182120.174142-6-gregory.price@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
        <20221012182120.174142-1-gregory.price@memverge.com>
        <20221012182120.174142-6-gregory.price@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 12 Oct 2022 14:21:20 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> The CDAT can contain multiple entries for multiple memory regions, this
> will allow us to re-use the initialization code when volatile memory
> region support is added.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

I'm in two minds about this... We could integrate it in the original series,
but at that time the change is justified.  Or we could leave it as a first
patch in your follow on series.

Anyhow, I went with a similar refactor inspired by this.


> ---
>  hw/mem/cxl_type3.c | 137 ++++++++++++++++++++++++---------------------
>  1 file changed, 72 insertions(+), 65 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 220b9f09a9..3c5485abd0 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -19,117 +19,93 @@
>  #define DWORD_BYTE 4
>  #define CT3_CDAT_SUBTABLE_SIZE 6
>  
> -static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
> -                                void *priv)
> +static int ct3_build_cdat_subtable(CDATSubHeader **cdat_table,
> +        MemoryRegion *mr, int dsmad_handle)

subtable is particularly well defined.  Maybe
ct3_build_cdat_entries_for_mr()?

>  {
> -    g_autofree CDATDsmas *dsmas_nonvolatile = NULL;
> -    g_autofree CDATDslbis *dslbis_nonvolatile1 = NULL;
> -    g_autofree CDATDslbis *dslbis_nonvolatile2 = NULL;
> -    g_autofree CDATDslbis *dslbis_nonvolatile3 = NULL;
> -    g_autofree CDATDslbis *dslbis_nonvolatile4 = NULL;
> -    g_autofree CDATDsemts *dsemts_nonvolatile = NULL;
> -    CXLType3Dev *ct3d = priv;
> -    int next_dsmad_handle = 0;
> -    int nonvolatile_dsmad = -1;
> -    MemoryRegion *mr;
> -
> -    if (!ct3d->hostmem) {
> -        return 0;
> -    }
> -
> -    mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> -        return -EINVAL;
> -    }
> -
> -    *cdat_table = g_malloc0(CT3_CDAT_SUBTABLE_SIZE * sizeof(*cdat_table));
> -    if (!*cdat_table) {
> -        return -ENOMEM;
> -    }
> -
> -    /* Non volatile aspects */
> -    dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
> -    dslbis_nonvolatile1 = g_malloc(sizeof(*dslbis_nonvolatile1));
> -    dslbis_nonvolatile2 = g_malloc(sizeof(*dslbis_nonvolatile2));
> -    dslbis_nonvolatile3 = g_malloc(sizeof(*dslbis_nonvolatile3));
> -    dslbis_nonvolatile4 = g_malloc(sizeof(*dslbis_nonvolatile4));
> -    dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
> -
> -    if (!dsmas_nonvolatile || !dsemts_nonvolatile ||
> -        !dslbis_nonvolatile1 || !dslbis_nonvolatile2 ||
> -        !dslbis_nonvolatile3 || !dslbis_nonvolatile4) {
> -        g_free(*cdat_table);
> -        *cdat_table = NULL;
> +    g_autofree CDATDsmas *dsmas = NULL;
> +    g_autofree CDATDslbis *dslbis1 = NULL;
> +    g_autofree CDATDslbis *dslbis2 = NULL;
> +    g_autofree CDATDslbis *dslbis3 = NULL;
> +    g_autofree CDATDslbis *dslbis4 = NULL;
> +    g_autofree CDATDsemts *dsemts = NULL;
> +
> +    dsmas = g_malloc(sizeof(*dsmas));
> +    dslbis1 = g_malloc(sizeof(*dslbis1));
> +    dslbis2 = g_malloc(sizeof(*dslbis2));
> +    dslbis3 = g_malloc(sizeof(*dslbis3));
> +    dslbis4 = g_malloc(sizeof(*dslbis4));
> +    dsemts = g_malloc(sizeof(*dsemts));
> +
> +    if (!dsmas || !dslbis1 || !dslbis2 || !dslbis3 || !dslbis4 || !dsemts) {
>          return -ENOMEM;
>      }
>  
> -    nonvolatile_dsmad = next_dsmad_handle++;
> -    *dsmas_nonvolatile = (CDATDsmas) {
> +    *dsmas = (CDATDsmas) {
>          .header = {
>              .type = CDAT_TYPE_DSMAS,
> -            .length = sizeof(*dsmas_nonvolatile),
> +            .length = sizeof(*dsmas),
>          },
> -        .DSMADhandle = nonvolatile_dsmad,
> +        .DSMADhandle = dsmad_handle,
>          .flags = CDAT_DSMAS_FLAG_NV,
>          .DPA_base = 0,
>          .DPA_length = int128_get64(mr->size),
>      };
>  
>      /* For now, no memory side cache, plausiblish numbers */
> -    *dslbis_nonvolatile1 = (CDATDslbis) {
> +    *dslbis1 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> -            .length = sizeof(*dslbis_nonvolatile1),
> +            .length = sizeof(*dslbis1),
>          },
> -        .handle = nonvolatile_dsmad,
> +        .handle = dsmad_handle,
>          .flags = HMAT_LB_MEM_MEMORY,
>          .data_type = HMAT_LB_DATA_READ_LATENCY,
>          .entry_base_unit = 10000, /* 10ns base */
>          .entry[0] = 15, /* 150ns */

If we are going to wrap this up for volatile / non-volatile 
we probably need to pass in a reasonable value for these.
Whilst not technically always true, to test the Linux handling
I'd want non-volatile to report as longer latency.

>      };
>  
> -    *dslbis_nonvolatile2 = (CDATDslbis) {
> +    *dslbis2 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> -            .length = sizeof(*dslbis_nonvolatile2),
> +            .length = sizeof(*dslbis2),
>          },
> -        .handle = nonvolatile_dsmad,
> +        .handle = dsmad_handle,
>          .flags = HMAT_LB_MEM_MEMORY,
>          .data_type = HMAT_LB_DATA_WRITE_LATENCY,
>          .entry_base_unit = 10000,
>          .entry[0] = 25, /* 250ns */
>      };
>  
> -    *dslbis_nonvolatile3 = (CDATDslbis) {
> +    *dslbis3 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> -            .length = sizeof(*dslbis_nonvolatile3),
> +            .length = sizeof(*dslbis3),
>          },
> -        .handle = nonvolatile_dsmad,
> +        .handle = dsmad_handle,
>          .flags = HMAT_LB_MEM_MEMORY,
>          .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
>          .entry_base_unit = 1000, /* GB/s */
>          .entry[0] = 16,
>      };
>  
> -    *dslbis_nonvolatile4 = (CDATDslbis) {
> +    *dslbis4 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> -            .length = sizeof(*dslbis_nonvolatile4),
> +            .length = sizeof(*dslbis4),
>          },
> -        .handle = nonvolatile_dsmad,
> +        .handle = dsmad_handle,
>          .flags = HMAT_LB_MEM_MEMORY,
>          .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
>          .entry_base_unit = 1000, /* GB/s */
>          .entry[0] = 16,
>      };
>  
> -    *dsemts_nonvolatile = (CDATDsemts) {
> +    *dsemts = (CDATDsemts) {
>          .header = {
>              .type = CDAT_TYPE_DSEMTS,
> -            .length = sizeof(*dsemts_nonvolatile),
> +            .length = sizeof(*dsemts),
>          },
> -        .DSMAS_handle = nonvolatile_dsmad,
> +        .DSMAS_handle = dsmad_handle,
>          /* Reserved - the non volatile from DSMAS matters */
>          .EFI_memory_type_attr = 2,
>          .DPA_offset = 0,
> @@ -137,16 +113,47 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>      };
>  
>      /* Header always at start of structure */
> -    (*cdat_table)[0] = g_steal_pointer(&dsmas_nonvolatile);
> -    (*cdat_table)[1] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile1);
> -    (*cdat_table)[2] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile2);
> -    (*cdat_table)[3] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile3);
> -    (*cdat_table)[4] = (CDATSubHeader *)g_steal_pointer(&dslbis_nonvolatile4);
> -    (*cdat_table)[5] = g_steal_pointer(&dsemts_nonvolatile);
> +    cdat_table[0] = g_steal_pointer(&dsmas);
> +    cdat_table[1] = (CDATSubHeader *)g_steal_pointer(&dslbis1);
> +    cdat_table[2] = (CDATSubHeader *)g_steal_pointer(&dslbis2);
> +    cdat_table[3] = (CDATSubHeader *)g_steal_pointer(&dslbis3);
> +    cdat_table[4] = (CDATSubHeader *)g_steal_pointer(&dslbis4);
> +    cdat_table[5] = g_steal_pointer(&dsemts);
>  
>      return CT3_CDAT_SUBTABLE_SIZE;
>  }
>  
> +static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
> +                                void *priv)
> +{
> +    CXLType3Dev *ct3d = priv;
> +    MemoryRegion *mr;
> +    int ret = 0;
> +
> +    if (!ct3d->hostmem) {
> +        return 0;
> +    }
> +
> +    mr = host_memory_backend_get_memory(ct3d->hostmem);
> +    if (!mr) {
> +        return -EINVAL;
> +    }
> +
> +    *cdat_table = g_malloc0(CT3_CDAT_SUBTABLE_SIZE * sizeof(*cdat_table));

This bakes in assumptions at the wrong layer in the code.  Out here we should not
know how big the table is - that is a job just for the ct3_build_cdat_subtable()
part.

Various options come to mind..
1) Two pass approach. First call ct3_build_cdat_subtable() with NULL pointer
   passed in.  For that all it does it return the number of elements.
   The the caller calls it again providing suitable storage.
2) Allocate in ct3_build_cdat_subtable() then copy in the caller or use
   directly if only one type of memory present.

I've gone with the 2 pass approach.  Let me know what you think of it
once I send the patches out in a few mins.

Thanks,

Jonathan



> +    if (!*cdat_table) {
> +        return -ENOMEM;
> +    }
> +
> +    /* Non volatile aspects */
> +    ret = ct3_build_cdat_subtable(*cdat_table, mr, 0);
> +    if (ret < 0) {
> +        g_free(*cdat_table);
> +        *cdat_table = NULL;
> +    }
> +
> +    return ret;
> +}
> +
>  static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
>  {
>      int i;

