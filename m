Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6898EC77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 14:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbjELOdb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 10:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjELOda (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 10:33:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959491BF
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 07:33:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHrnw0StSz67v9b;
        Fri, 12 May 2023 22:32:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 15:33:24 +0100
Date:   Fri, 12 May 2023 15:33:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 02/14] cxl: Add callback to parse the DSLBIS subtable
 from CDAT
Message-ID: <20230512153323.00000d7b@Huawei.com>
In-Reply-To: <168357882541.2756219.12547742982939088156.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
        <168357882541.2756219.12547742982939088156.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 08 May 2023 13:47:05 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a callback to parse the Device Scoped Latency and Bandwidth
> Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
> contains the bandwidth and latency information that's tied to a DSMAS
> handle. The driver will retrieve the read and write latency and
> bandwidth associated with the DSMAS which is tied to a DPA range.
> 
> Coherent Device Attribute Table 1.03 2.1 Device Scoped Latency and
> Bandwidth Information Structure (DSLBIS)
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few trivial suggestions inline. Change them if you like. I don't mind that much.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v5:
> - Remove macro for common headers. (Jonathan)
> - Use acpi_table_parse_cdat().
> - Remove unlikely(). (Dan)
> v3:
> - Added spec section in commit header. (Alison)
> - Remove void * recast. (Alison)
> - Rework comment. (Alison)
> - Move CDAT parse to cxl_endpoint_port_probe()
> - Convert to use 'struct node_hmem_attrs'
> 
> v2:
> - Add size check to DSLIBIS table. (Lukas)
> - Remove unnecessary entry type check. (Jonathan)
> - Move data_type check to after match. (Jonathan)
> - Skip unknown data type. (Jonathan)
> - Add overflow check for unit multiply. (Jonathan)
> - Use dev_warn() when entries parsing fail. (Jonathan)
> ---
>  drivers/cxl/core/cdat.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h       |    2 +
>  2 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 61979f0789aa..6e14d04c0453 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
>  #include <linux/acpi.h>
> +#include <linux/overflow.h>
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> @@ -32,9 +33,94 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
>  	return 0;
>  }
>  
> +static void cxl_access_coordinate_set(struct access_coordinate *coord,
> +				      int access, unsigned int val)
> +{
> +	switch (access) {
> +	case ACPI_HMAT_ACCESS_LATENCY:
> +		coord->read_latency = val;
> +		coord->write_latency = val;
> +		break;
> +	case ACPI_HMAT_READ_LATENCY:
> +		coord->read_latency = val;
> +		break;
> +	case ACPI_HMAT_WRITE_LATENCY:
> +		coord->write_latency = val;
> +		break;
> +	case ACPI_HMAT_ACCESS_BANDWIDTH:
> +		coord->read_bandwidth = val;
> +		coord->write_bandwidth = val;
> +		break;
> +	case ACPI_HMAT_READ_BANDWIDTH:
> +		coord->read_bandwidth = val;
> +		break;
> +	case ACPI_HMAT_WRITE_BANDWIDTH:
> +		coord->write_bandwidth = val;
> +		break;
> +	}
> +}
> +
> +static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
> +			       const unsigned long end)
> +{
> +	struct acpi_cdat_dslbis *dslbis = (struct acpi_cdat_dslbis *)header;

As for DSMAS, cast from the more obviously appropriate &header->cdat

> +	struct list_head *dsmas_list = arg;
> +	struct dsmas_entry *dent;
> +	u16 len;
> +
> +	len = le16_to_cpu((__force __le16)dslbis->header.length);
> +	if (len != sizeof(*dslbis) || (unsigned long)header + len > end) {
> +		pr_warn("Malformed DSLBIS table length: (%lu:%u)\n",
> +			(unsigned long)sizeof(*dslbis), len);
> +		return -EINVAL;
> +	}
> +
> +	/* Skip unrecognized data type */
> +	if (dslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
> +		return 0;
> +
> +	list_for_each_entry(dent, dsmas_list, list) {
> +		u64 val;
> +		int rc;
> +
> +		if (dslbis->handle != dent->handle)
> +			continue;
> +
> +		/* Not a memory type, skip */
> +		if ((dslbis->flags & ACPI_HMAT_MEMORY_HIERARCHY) !=
> +		    ACPI_HMAT_MEMORY)
> +			return 0;
> +
> +		rc = check_mul_overflow(le64_to_cpu((__force __le64)dslbis->entry_base_unit),
> +					le16_to_cpu((__force __le16)dslbis->entry[0]), &val);
> +		if (rc)
> +			pr_warn("DSLBIS value overflowed.\n");
> +
> +		cxl_access_coordinate_set(&dent->coord, dslbis->data_type, val);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list)
>  {
> -	return acpi_table_parse_cdat(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
> -				     list, port->cdat.table);
> +	int rc;
> +
> +	rc = acpi_table_parse_cdat(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
> +				   list, port->cdat.table);
> +	if (rc <= 0) {
> +		if (rc == 0)
> +			rc = -ENOENT;
> +		return rc;
> +	}

	if (rc < 0)
		return rc;
	if (rc == 0)
		return -ENOENT;

is a tiny bit simpler.

> +
> +	rc = acpi_table_parse_cdat(ACPI_CDAT_TYPE_DSLBIS,
> +				   cdat_dslbis_handler,
> +				   list, port->cdat.table);
> +	if (rc == 0)
> +		rc = -ENOENT;

I'd burn a few lines of code for readability rather than fudging the
return value.

	if (rc < 0)
		return rc;
	if (rc == 0)
		return -ENOENT;

	return 0;
> +
> +	return rc;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cdat_endpoint_process, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index dda7238b47f5..ca3d0d74f2e5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/list.h>
> +#include <linux/node.h>
>  #include <linux/log2.h>
>  #include <linux/io.h>
>  
> @@ -797,6 +798,7 @@ struct dsmas_entry {
>  	struct list_head list;
>  	struct range dpa_range;
>  	u8 handle;
> +	struct access_coordinate coord;
>  };
>  
>  #ifdef CONFIG_ACPI
> 
> 

