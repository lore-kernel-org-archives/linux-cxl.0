Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DA4C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 10:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJMKmF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJMKmF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 06:42:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A268EE6F79
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 03:42:03 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mp5bx04V5z67wCQ;
        Thu, 13 Oct 2022 18:39:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 13 Oct 2022 12:42:01 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 11:42:01 +0100
Date:   Thu, 13 Oct 2022 11:42:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <mst@redhat.com>,
        <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH 2/5] hw/mem/cxl_type3: Pull validation checks ahead of
 functional code
Message-ID: <20221013114200.00006ec2@huawei.com>
In-Reply-To: <20221013100740.0000471b@huawei.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
        <20221012182120.174142-1-gregory.price@memverge.com>
        <20221012182120.174142-3-gregory.price@memverge.com>
        <20221013100740.0000471b@huawei.com>
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

On Thu, 13 Oct 2022 10:07:40 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 12 Oct 2022 14:21:17 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > For style - pulling these validations ahead flattens the code.  
> 
> True, but at the cost of separating the check from where it is
> obvious why we have the check.  I'd prefer to see it next to the
> use. 
That separation made a bit more sense after factoring out the code
as then we want to pass the mr in rather than the HostMemBackend.

So in the end I did what you suggested :)

Jonathan

> 
> Inverting the hostmem check is resonable so I'll make that change.
> 
> My original thinking is that doing so would make adding non volatile
> support messier but given you plan to factor out most of this the
> change won't be too bad anyway.
> 
> 
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > ---
> >  hw/mem/cxl_type3.c | 193 ++++++++++++++++++++++-----------------------
> >  1 file changed, 96 insertions(+), 97 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 94bc439d89..43b2b9e041 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -32,107 +32,106 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
> >      int dslbis_nonvolatile_num = 4;
> >      MemoryRegion *mr;
> >  
> > +    if (!ct3d->hostmem) {
> > +        return len;
> > +    }
> > +
> > +    mr = host_memory_backend_get_memory(ct3d->hostmem);
> > +    if (!mr) {
> > +        return -EINVAL;
> > +    }
> > +
> >      /* Non volatile aspects */
> > -    if (ct3d->hostmem) {
> > -        dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
> > -        if (!dsmas_nonvolatile) {
> > -            return -ENOMEM;
> > -        }
> > -        nonvolatile_dsmad = next_dsmad_handle++;
> > -        mr = host_memory_backend_get_memory(ct3d->hostmem);
> > -        if (!mr) {
> > -            return -EINVAL;
> > -        }
> > -        *dsmas_nonvolatile = (CDATDsmas) {
> > -            .header = {
> > -                .type = CDAT_TYPE_DSMAS,
> > -                .length = sizeof(*dsmas_nonvolatile),
> > -            },
> > -            .DSMADhandle = nonvolatile_dsmad,
> > -            .flags = CDAT_DSMAS_FLAG_NV,
> > -            .DPA_base = 0,
> > -            .DPA_length = int128_get64(mr->size),
> > -        };
> > -        len++;
> > -
> > -        /* For now, no memory side cache, plausiblish numbers */
> > -        dslbis_nonvolatile =
> > -            g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
> > -        if (!dslbis_nonvolatile) {
> > -            return -ENOMEM;
> > -        }
> > +    dsmas_nonvolatile = g_malloc(sizeof(*dsmas_nonvolatile));
> > +    if (!dsmas_nonvolatile) {
> > +        return -ENOMEM;
> > +    }
> > +    nonvolatile_dsmad = next_dsmad_handle++;
> > +    *dsmas_nonvolatile = (CDATDsmas) {
> > +        .header = {
> > +            .type = CDAT_TYPE_DSMAS,
> > +            .length = sizeof(*dsmas_nonvolatile),
> > +        },
> > +        .DSMADhandle = nonvolatile_dsmad,
> > +        .flags = CDAT_DSMAS_FLAG_NV,
> > +        .DPA_base = 0,
> > +        .DPA_length = int128_get64(mr->size),
> > +    };
> > +    len++;
> >  
> > -        dslbis_nonvolatile[0] = (CDATDslbis) {
> > -            .header = {
> > -                .type = CDAT_TYPE_DSLBIS,
> > -                .length = sizeof(*dslbis_nonvolatile),
> > -            },
> > -            .handle = nonvolatile_dsmad,
> > -            .flags = HMAT_LB_MEM_MEMORY,
> > -            .data_type = HMAT_LB_DATA_READ_LATENCY,
> > -            .entry_base_unit = 10000, /* 10ns base */
> > -            .entry[0] = 15, /* 150ns */
> > -        };
> > -        len++;
> > -
> > -        dslbis_nonvolatile[1] = (CDATDslbis) {
> > -            .header = {
> > -                .type = CDAT_TYPE_DSLBIS,
> > -                .length = sizeof(*dslbis_nonvolatile),
> > -            },
> > -            .handle = nonvolatile_dsmad,
> > -            .flags = HMAT_LB_MEM_MEMORY,
> > -            .data_type = HMAT_LB_DATA_WRITE_LATENCY,
> > -            .entry_base_unit = 10000,
> > -            .entry[0] = 25, /* 250ns */
> > -        };
> > -        len++;
> > -
> > -        dslbis_nonvolatile[2] = (CDATDslbis) {
> > -            .header = {
> > -                .type = CDAT_TYPE_DSLBIS,
> > -                .length = sizeof(*dslbis_nonvolatile),
> > -            },
> > -            .handle = nonvolatile_dsmad,
> > -            .flags = HMAT_LB_MEM_MEMORY,
> > -            .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
> > -            .entry_base_unit = 1000, /* GB/s */
> > -            .entry[0] = 16,
> > -        };
> > -        len++;
> > -
> > -        dslbis_nonvolatile[3] = (CDATDslbis) {
> > -            .header = {
> > -                .type = CDAT_TYPE_DSLBIS,
> > -                .length = sizeof(*dslbis_nonvolatile),
> > -            },
> > -            .handle = nonvolatile_dsmad,
> > -            .flags = HMAT_LB_MEM_MEMORY,
> > -            .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
> > -            .entry_base_unit = 1000, /* GB/s */
> > -            .entry[0] = 16,
> > -        };
> > -        len++;
> > -
> > -        mr = host_memory_backend_get_memory(ct3d->hostmem);
> > -        if (!mr) {
> > -            return -EINVAL;
> > -        }
> > -        dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
> > -        *dsemts_nonvolatile = (CDATDsemts) {
> > -            .header = {
> > -                .type = CDAT_TYPE_DSEMTS,
> > -                .length = sizeof(*dsemts_nonvolatile),
> > -            },
> > -            .DSMAS_handle = nonvolatile_dsmad,
> > -            /* Reserved - the non volatile from DSMAS matters */
> > -            .EFI_memory_type_attr = 2,
> > -            .DPA_offset = 0,
> > -            .DPA_length = int128_get64(mr->size),
> > -        };
> > -        len++;
> > +    /* For now, no memory side cache, plausiblish numbers */
> > +    dslbis_nonvolatile =
> > +        g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
> > +    if (!dslbis_nonvolatile) {
> > +        return -ENOMEM;
> >      }
> >  
> > +    dslbis_nonvolatile[0] = (CDATDslbis) {
> > +        .header = {
> > +            .type = CDAT_TYPE_DSLBIS,
> > +            .length = sizeof(*dslbis_nonvolatile),
> > +        },
> > +        .handle = nonvolatile_dsmad,
> > +        .flags = HMAT_LB_MEM_MEMORY,
> > +        .data_type = HMAT_LB_DATA_READ_LATENCY,
> > +        .entry_base_unit = 10000, /* 10ns base */
> > +        .entry[0] = 15, /* 150ns */
> > +    };
> > +    len++;
> > +
> > +    dslbis_nonvolatile[1] = (CDATDslbis) {
> > +        .header = {
> > +            .type = CDAT_TYPE_DSLBIS,
> > +            .length = sizeof(*dslbis_nonvolatile),
> > +        },
> > +        .handle = nonvolatile_dsmad,
> > +        .flags = HMAT_LB_MEM_MEMORY,
> > +        .data_type = HMAT_LB_DATA_WRITE_LATENCY,
> > +        .entry_base_unit = 10000,
> > +        .entry[0] = 25, /* 250ns */
> > +    };
> > +    len++;
> > +
> > +    dslbis_nonvolatile[2] = (CDATDslbis) {
> > +        .header = {
> > +            .type = CDAT_TYPE_DSLBIS,
> > +            .length = sizeof(*dslbis_nonvolatile),
> > +        },
> > +        .handle = nonvolatile_dsmad,
> > +        .flags = HMAT_LB_MEM_MEMORY,
> > +        .data_type = HMAT_LB_DATA_READ_BANDWIDTH,
> > +        .entry_base_unit = 1000, /* GB/s */
> > +        .entry[0] = 16,
> > +    };
> > +    len++;
> > +
> > +    dslbis_nonvolatile[3] = (CDATDslbis) {
> > +        .header = {
> > +            .type = CDAT_TYPE_DSLBIS,
> > +            .length = sizeof(*dslbis_nonvolatile),
> > +        },
> > +        .handle = nonvolatile_dsmad,
> > +        .flags = HMAT_LB_MEM_MEMORY,
> > +        .data_type = HMAT_LB_DATA_WRITE_BANDWIDTH,
> > +        .entry_base_unit = 1000, /* GB/s */
> > +        .entry[0] = 16,
> > +    };
> > +    len++;
> > +
> > +    dsemts_nonvolatile = g_malloc(sizeof(*dsemts_nonvolatile));
> > +    *dsemts_nonvolatile = (CDATDsemts) {
> > +        .header = {
> > +            .type = CDAT_TYPE_DSEMTS,
> > +            .length = sizeof(*dsemts_nonvolatile),
> > +        },
> > +        .DSMAS_handle = nonvolatile_dsmad,
> > +        /* Reserved - the non volatile from DSMAS matters */
> > +        .EFI_memory_type_attr = 2,
> > +        .DPA_offset = 0,
> > +        .DPA_length = int128_get64(mr->size),
> > +    };
> > +    len++;
> > +
> >      *cdat_table = g_malloc0(len * sizeof(*cdat_table));
> >      /* Header always at start of structure */
> >      if (dsmas_nonvolatile) {  
> 
> 

