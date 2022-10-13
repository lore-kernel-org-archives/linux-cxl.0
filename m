Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E1CC433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 10:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJMKoq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJMKoo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 06:44:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D5E0A1
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 03:44:42 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mp5fz4CBhz67Q1M;
        Thu, 13 Oct 2022 18:41:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 12:44:40 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 11:44:39 +0100
Date:   Thu, 13 Oct 2022 11:44:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <mst@redhat.com>,
        <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH 3/5] hw/mem/cxl_type3: CDAT pre-allocate and check
 resources prior to work
Message-ID: <20221013114438.00007de8@huawei.com>
In-Reply-To: <20221012182120.174142-4-gregory.price@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
        <20221012182120.174142-1-gregory.price@memverge.com>
        <20221012182120.174142-4-gregory.price@memverge.com>
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

On Wed, 12 Oct 2022 14:21:18 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Makes the size of the allocated cdat table static (6 entries),
> flattens the code, and reduces the number of exit conditions
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

Hmm. I don't entirely like this as it stands because it leads to more
fragile code as we don't have clear association between number
of entries and actual assignments.

So, what I've done (inspired by this) is moved to a local enum
in the factored out building function that has an element for
each of the entries (used ultimately to assign them) and
a trailing NUM_ENTRIES element we can then use in place of
the CT3_CDAT_SUBTABLE_SIZE define you have here.

I went with the 2 pass approach mentioned in a later patch, so
if cdat_table passed to the factored out code is NULL, we just
return NUM_ENTRIES directly.

> ---
>  hw/mem/cxl_type3.c | 52 ++++++++++++++++++++--------------------------
>  1 file changed, 22 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 43b2b9e041..0e0ea70387 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -17,6 +17,7 @@
>  #include "hw/pci/msix.h"
>  
>  #define DWORD_BYTE 4
> +#define CT3_CDAT_SUBTABLE_SIZE 6

>  
>  static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>                                  void *priv)
> @@ -25,7 +26,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>      g_autofree CDATDslbis *dslbis_nonvolatile = NULL;
>      g_autofree CDATDsemts *dsemts_nonvolatile = NULL;
>      CXLType3Dev *ct3d = priv;
> -    int len = 0;
>      int i = 0;
>      int next_dsmad_handle = 0;
>      int nonvolatile_dsmad = -1;
> @@ -33,7 +33,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>      MemoryRegion *mr;
>  
>      if (!ct3d->hostmem) {
> -        return len;
> +        return 0;
>      }
>  
>      mr = host_memory_backend_get_memory(ct3d->hostmem);
> @@ -41,11 +41,22 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>          return -EINVAL;
>      }
>  
> +    *cdat_table = g_malloc0(CT3_CDAT_SUBTABLE_SIZE * sizeof(*cdat_table));
> +    if (!*cdat_table) {
> +        return -ENOMEM;
> +    }
> +
>      /* Non volatile aspects */
>      dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
> -    if (!dsmas_nonvolatile) {
> +    dslbis_nonvolatile =
> +        g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
> +    dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
> +    if (!dsmas_nonvolatile || !dslbis_nonvolatile || !dsemts_nonvolatile) {

I don't like aggregated error checking. It saves lines of code, but leads
to generally less mantainable code.  I prefer to do one thing, check it and handle
necessary errors - provides a small localized chunk of code that is easy to
review and maintain.
1. Allocate structure
2. Fill structure.

We have to leave the assignment till later as only want to steal the pointers
once we know there are no error paths.

> +        g_free(*cdat_table);

We have auto free to clean this up. So if this did make sense, use a local
g_autofree CDATSubHeader **cdat_table = NULL;
and steal the pointer when assigning *cdat_table at the end of this function
after all the failure paths.

This code all ends up in the caller of the factored out code anyway so
that comment becomes irrelevant on the version I've ended up with.

Jonathan



> +        *cdat_table = NULL;
>          return -ENOMEM;
>      }
> +
>      nonvolatile_dsmad = next_dsmad_handle++;
>      *dsmas_nonvolatile = (CDATDsmas) {
>          .header = {
> @@ -57,15 +68,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>          .DPA_base = 0,
>          .DPA_length = int128_get64(mr->size),
>      };
> -    len++;
>  
>      /* For now, no memory side cache, plausiblish numbers */
> -    dslbis_nonvolatile =
> -        g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
> -    if (!dslbis_nonvolatile) {
> -        return -ENOMEM;
> -    }
> -
>      dslbis_nonvolatile[0] = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> @@ -77,7 +81,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>          .entry_base_unit = 10000, /* 10ns base */
>          .entry[0] = 15, /* 150ns */
>      };
> -    len++;
>  
>      dslbis_nonvolatile[1] = (CDATDslbis) {
>          .header = {
> @@ -90,7 +93,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>          .entry_base_unit = 10000,
>          .entry[0] = 25, /* 250ns */
>      };
> -    len++;
>  
>      dslbis_nonvolatile[2] = (CDATDslbis) {
>          .header = {
> @@ -103,7 +105,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>          .entry_base_unit = 1000, /* GB/s */
>          .entry[0] = 16,
>      };
> -    len++;
>  
>      dslbis_nonvolatile[3] = (CDATDslbis) {
>          .header = {
> @@ -116,9 +117,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>          .entry_base_unit = 1000, /* GB/s */
>          .entry[0] = 16,
>      };
> -    len++;
>  
> -    dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
>      *dsemts_nonvolatile = (CDATDsemts) {
>          .header = {
>              .type = CDAT_TYPE_DSEMTS,
> @@ -130,26 +129,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
>          .DPA_offset = 0,
>          .DPA_length = int128_get64(mr->size),
>      };
> -    len++;
>  
> -    *cdat_table = g_malloc0(len * sizeof(*cdat_table));
>      /* Header always at start of structure */
> -    if (dsmas_nonvolatile) {
> -        (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
> -    }
> -    if (dslbis_nonvolatile) {
> -        CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);
> -        int j;
> +    (*cdat_table)[i++] = g_steal_pointer(&dsmas_nonvolatile);
>  
> -        for (j = 0; j < dslbis_nonvolatile_num; j++) {
> -            (*cdat_table)[i++] = (CDATSubHeader *)&dslbis[j];
> -        }
> -    }
> -    if (dsemts_nonvolatile) {
> -        (*cdat_table)[i++] = g_steal_pointer(&dsemts_nonvolatile);
> +    CDATDslbis *dslbis = g_steal_pointer(&dslbis_nonvolatile);
Removing the paranoid checking makes sense if we are going to handle
the volatile / non volatile as 'whole sets of tables'.

> +    int j;
> +    for (j = 0; j < dslbis_nonvolatile_num; j++) {
> +        (*cdat_table)[i++] = (CDATSubHeader *)&dslbis[j];
>      }
>  
> -    return len;
> +    (*cdat_table)[i++] = g_steal_pointer(&dsemts_nonvolatile);
> +
> +    return CT3_CDAT_SUBTABLE_SIZE;
>  }
>  
>  static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)

