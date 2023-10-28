Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CF7F5
	for <linux-cxl@vger.kernel.org>; Sat, 28 Oct 2023 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FO5C/HdM"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9844EFA
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 21:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698466140; x=1730002140;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MrbpmqMlFUbhA/zjFXlHvtNQ/L5Tz2gMeryYDP3lB/Q=;
  b=FO5C/HdM56xRJypLsb5h9W+Q3r/a8ah+uvsUlWvoil2jTRy2uTH4yOBz
   vvT/gBtgpxNsVD0EGmhZDms1IDBSt8UQHGuNxz1ksjNiPARmvs2uf8wH+
   XV74sDZOFCrOLibQq45kcmU02t+bbMa+2SkJHSszvg0WVKJ7/ZgdFHdDs
   KXyyIWKY9z1dlBG3kfdg0EnZNYfJlFtiX9qJC4pURN2cmEODu6mdHJ3Fy
   gjZRCbf9GeEIUey8H9saE5DtzkRt0y+D5yWFfNHl4sK6zvK+Sp95exVT/
   AdUyFFIIdBZ3tj5Wc3u8cNU7KfdoCD+R//aJaagsvGRgO6KwIR9GiQiB6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="418988635"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="418988635"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 21:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="1042765"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 21:08:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 21:08:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 21:08:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 21:08:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 21:08:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVPWsv1HKveSe2brGY6Z4+RqR/LqhdW8kFmOy9K9EtmleMZbobFWv+aogtR5uj8wysZg98Qrghz2mmajNsucnNG813EHKeKghPOgAQpOWVUjjqiiLJgi5E2ah1xKsyZYopFU2yGuvlJic8a/+LkCWQiuEHmXUdjZ+ssZB65sA1HGZP7YZpHLHq6/jeiRBHtW7uzxbZAL9lL9cpyaZH7K1hcy2/4veSWfl2RHt9pTEV7m8pJBHiVBazhk0UYB7A0Yf3Q+z4lHbbvA/8I8149sBooba2kPN+7VAwFPwB4twq0F01N5KhchISSHOVpbi61O9bOVSlKBWCeG5Pa8f028uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZvQA+zSq8kPyIFu+NAO/qZ1Ubuyvfe0vIXHaSrV5jA=;
 b=FpIuKOB6jwTISdjOsQDMXGjmyukZLcf936E5JVOOOhvGLx7BJk5cyYvgBgKDFlzxJCWBV3d+AlB1sKMvK9Pw7DGdZC+8HvwBfshwNcUmb89sbTr74S4+dkWZcvNr0eiV5sFJHoIbEB5sMFV5l9aH29214PGmvCg2wsDa1dNT4NrQAMAxWNgT2iUlgs+/sNlHJAXGOYPbQnQpaov8UZekJd+UnmVBaMczhwt5CC4M9qqpu5FCGuS/PQnZ9gplvdjN2OawvXSSsnKOE7fdSk9bykqWjycjgiWTbitfoWNWsiNgHaMlXQxKqGT2/rxl5XEjOcg3jEZ/RBIqheJYYsySyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8284.namprd11.prod.outlook.com (2603:10b6:806:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Sat, 28 Oct
 2023 04:08:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Sat, 28 Oct 2023
 04:08:57 +0000
Date: Fri, 27 Oct 2023 21:08:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v11 12/22] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Message-ID: <653c895579fd4_244c8f294bc@dwillia2-xfh.jf.intel.com.notmuch>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
 <169713688328.2205276.14682106535163902532.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169713688328.2205276.14682106535163902532.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:303:8f::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 4998c59e-fe80-427b-4768-08dbd76b9a9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SHQZnYvBYx+fNvvjeztgroVjQAf6oCBlbjnP2MnxRAADEHQWXzVjxDcIOjiKPW/9LBP3RrKmmfAimN0qNK1FwKWh9c462UrCiBmOp9zv9nTubTLQyg/tFNeAygDo4hgzrrko2Zyp5FKS2pQ9gCSwlTI0800FOtSBSK1GIHBPkQkVjH0ADw5FInrZUlPHaBTKeO0UYBrvsAHLm6c/VHf0CLx7f+y3kj35fd0DYfPYpKjI8GKQS9KJBXGsV4kdoRyogLWHhC0HMVusaSXz83SzbcoPU9iQ4t6ufGbeG2UsZVG+GX1gL82ZZ3xLusHX0dOQoxf0eRVHTe3wlVFl2PonaREUe34ika6l6r1P7ZsOdkUW1IPbTFfJvRDBs9Y4WLJpwqsKW8luvzSKhsvyGKQ+AAmOUDg+3TJIyLEgFQ7+4uukch2QCvsoA8Jtj6xC+/xSnU69KGykCxvZYmFkAdKBJd5wV6EA/wPwSbKB3LFVVqGYsCT4gpYjEde8GWoe7JIT3Dq0HuEPVgL2AfDF8YgC4N4vA1RmjqB3uACP2fehLc4/+ycYsLHC2TzDD3k7Fei
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(83380400001)(6486002)(38100700002)(8676002)(4326008)(82960400001)(2906002)(26005)(8936002)(5660300002)(66476007)(316002)(9686003)(6506007)(6512007)(66946007)(41300700001)(6666004)(478600001)(86362001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0yU8+YrGwk92KpCAiipxyELoNipVrpnORoMjver8fagVFfiEJ9w+tBggAPsC?=
 =?us-ascii?Q?dcbyaxMloj6iAxnCm8c4ny86RiHUmSUfxLUYLn29fSKYO/n1EcFYqvck2dyF?=
 =?us-ascii?Q?WITHVIo9zdJjev2ScjyHswEFj6XK1IAFwHiyPvScQgzJ0l+ulDqyBI+et/Kw?=
 =?us-ascii?Q?fE38RxxAoOcbAaRt2Fss97LcYcjk83x1KwGysrnl22aiS69J3q7OQ8qs7mzG?=
 =?us-ascii?Q?HMQU7LnHn6CHcMHJqZKxfgRaEGW/71meigN40DlMpdkgEtQSjDvUbE2B+eck?=
 =?us-ascii?Q?l8eUS4xHpOgHovS4qxxYryN36WgIXsqDnoPMovTkmpoBEbWGJ1MNkXP7cXr0?=
 =?us-ascii?Q?aQHhYZZIEn+HzBHmIuYCRHvhfFF7zQYvr/suHZaH/jT7k1Wm4hJ9frGiNl30?=
 =?us-ascii?Q?phRpTZu7sVktQUKaw3koattoDtLbJjYxz1O8U15WD02I7RpCrEbkZg6HVO5h?=
 =?us-ascii?Q?eAnjJ39bvkxcDfFHa0Umc3Er1brhx5hRerpoXhrcJt8snj46UPkbidfmnObZ?=
 =?us-ascii?Q?yC/Lj3UByDMk95tyXIFZoHSc8w8LHWAHH2VfMFJ9n6FM9yxW3iDeWBBYezzQ?=
 =?us-ascii?Q?42TV+5DitMaqjDBYC5q0jOjFNFmsTDgrKsWPunPwuQERBDjL0Klt0TfnmsYG?=
 =?us-ascii?Q?5T56sQuFVeSK9yATZ49+fWwfJuLHNR1eXZKUV0E/4aljVoeLbPGV2Avkfu04?=
 =?us-ascii?Q?wt5928P55h/0A8aO2BFuU1HSuJQusx9oDGUjOxHe5KhwpZlKQrJ1JwP30cp9?=
 =?us-ascii?Q?LmTqWUmsrJcvjYESrpuOTjJXr7FijfVk3Rki3Qi5GOnBDrPmDZppg4fPtJCc?=
 =?us-ascii?Q?Hf4vo7fYPd6F+/9Hjy7GT/v0baaRstNQ01Uh0q2r2vn4rTg1CtCQikIV/M7z?=
 =?us-ascii?Q?Ws4kwgQHGrc4M+3nBDotovdCeNZ81tchaq4Qj2nGZukltExVm+066hcz/59l?=
 =?us-ascii?Q?xXMzR82HbvXLo3Pykc7vHP0r0oP/FwtX9pgZLPGdWFye3nrBkSPWFPSltZyU?=
 =?us-ascii?Q?xLx/YjjmHeeTeXtb3zxnfEVxofuFRrN0hsjXFwK+dg+Iy7ocuO9ObveZMbmU?=
 =?us-ascii?Q?SwmadpTvAi3ktxZmjswW8JXbBedA4AY6YPW1DlQIbAg2O9TS6+Towd2OztK7?=
 =?us-ascii?Q?XY7mKSJ8JQha3mGzV1i/hbnOoAUlZqS3NbAu2h+kt76bzmQ2QOWRk6WIA7pK?=
 =?us-ascii?Q?knONaUjT+m0h51yhmDRhza5sf6b135EN+PigFmudD5u8YQeLceFRREAECylo?=
 =?us-ascii?Q?oF5y99BmrEdsZEhE1Frgt80U6jwQluGIqKUfrbwzqTfyB9sPHEvFggMu8kx4?=
 =?us-ascii?Q?0odjb+NyN9hLtyhB5GhO5dC96Xil/Vu+CQgwviyRU3HY52oberXm/cgNqNVK?=
 =?us-ascii?Q?Nv6QnVIwY1ONQkfKeGe8WKemiJdOQASkDY87iPAkEGBHyRuZwD+UbV/xjqpK?=
 =?us-ascii?Q?u6vgo9UN+tteA+S2arxigLFUDB/rcRyuWTAJfAU7kgviwtHT5jEbHIKf4gQa?=
 =?us-ascii?Q?2lu/g3mRzgNBBMAopU+2NlHZsIO93iRkvVUY2XMAO8luEob0mR4tgEEZJEG9?=
 =?us-ascii?Q?JwRe5qPrpOUCZNy6plgd20AUUgdrOPyxijqMsb0CbJCFhY3PPPAmeK9KJIVq?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4998c59e-fe80-427b-4768-08dbd76b9a9e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 04:08:56.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4H03DPcTavgxHh2LH7Lke0EocJv8acVM5HUDj1K9f5hel7Lpwvq36rUH5/vzUuvPFDC8TLbe4owEQiFp0OSPwlQqHt43renj7Ym4HfWNg0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8284
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Provide a callback function to the CDAT parser in order to parse the Device
> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
> DPA range and its associated attributes in each entry. See the CDAT
> specification for details. The device handle and the DPA range is saved and
> to be associated with the DSLBIS locality data when the DSLBIS entries are
> parsed. The list is a local list. When the total path performance data is
> calculated and storred this list can be discarded.
> 
> Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
> Structure (DSMAS)
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/Kconfig       |    1 +
>  drivers/cxl/core/Makefile |    1 +
>  drivers/cxl/core/cdat.c   |   58 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   23 ++++++++++++++++++
>  drivers/cxl/port.c        |   12 +++++++++
>  5 files changed, 95 insertions(+)
>  create mode 100644 drivers/cxl/core/cdat.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 8ea1d340e438..a1ae35bd1afc 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -5,6 +5,7 @@ menuconfig CXL_BUS
>  	select FW_LOADER
>  	select FW_UPLOAD
>  	select PCI_DOE
> +	select FIRMWARE_TABLE
>  	help
>  	  CXL is a bus that is electrically compatible with PCI Express, but
>  	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 1f66b5d4d935..f4eabfdd50ce 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -13,5 +13,6 @@ cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
> +cxl_core-$(CONFIG_FIRMWARE_TABLE) += cdat.o

CXL_BUS selects FIRMWARE_TABLE, this can just be cxl_core-y.

...and whenever drivers/cxl/core/Makefile changes,
tools/testing/cxl/Kbuild needs updating too.

>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> new file mode 100644
> index 000000000000..a858fd1b5744
> --- /dev/null
> +++ b/drivers/cxl/core/cdat.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> +#include <linux/acpi.h>
> +#include <linux/fw_table.h>
> +#include "cxlpci.h"
> +#include "cxl.h"
> +
> +static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> +			      const unsigned long end)
> +{
> +	struct acpi_cdat_header *hdr = &header->cdat;
> +	struct acpi_cdat_dsmas *dsmas;
> +	int size = sizeof(*hdr) + sizeof(*dsmas);
> +	struct list_head *dsmas_list = arg;
> +	struct dsmas_entry *dent;
> +	u16 len;
> +
> +	len = le16_to_cpu((__force __le16)hdr->length);
> +	if (len != size || (unsigned long)hdr + len > end) {
> +		pr_warn("Malformed DSMAS table length: (%u:%u)\n", size, len);
> +		return -EINVAL;
> +	}
> +
> +	/* Skip common header */
> +	dsmas = (struct acpi_cdat_dsmas *)(hdr + 1);
> +
> +	dent = kzalloc(sizeof(*dent), GFP_KERNEL);
> +	if (!dent)
> +		return -ENOMEM;
> +
> +	dent->handle = dsmas->dsmad_handle;
> +	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> +	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> +			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> +	list_add_tail(&dent->list, dsmas_list);
> +
> +	return 0;
> +}
> +
> +int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list)
> +{
> +	return cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
> +				list, port->cdat.table);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cdat_endpoint_process, CXL);
> +
> +void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
> +{
> +	struct dsmas_entry *dentry, *n;
> +
> +	list_for_each_entry_safe(dentry, n, dsmas_list, list) {
> +		list_del(&dentry->list);
> +		kfree(dentry);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cdat_dsmas_list_destroy, CXL);
> +
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index eb7924648cb0..be2fd8dcb37b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  #include <linux/libnvdimm.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/list.h>
>  #include <linux/log2.h>
>  #include <linux/io.h>
>  
> @@ -824,6 +825,28 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>  }
>  #endif
>  
> +/* CDAT related bits */
> +struct dsmas_entry {
> +	struct list_head list;
> +	struct range dpa_range;
> +	u8 handle;
> +};
> +
> +#ifdef CONFIG_FIRMWARE_TABLE
> +int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
> +void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list);
> +#else
> +static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
> +					    struct list_head *list)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
> +{
> +}
> +#endif

Why is there conditional compilation if FIRMWARE_TABLE is mandatory?

Folded in the following:

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index f4eabfdd50ce..9259bcc6773c 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -13,6 +13,6 @@ cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
-cxl_core-$(CONFIG_FIRMWARE_TABLE) += cdat.o
+cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be2fd8dcb37b..48fd7e0c5e9b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -832,20 +832,8 @@ struct dsmas_entry {
 	u8 handle;
 };
 
-#ifdef CONFIG_FIRMWARE_TABLE
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
 void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list);
-#else
-static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
-					    struct list_head *list)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
-{
-}
-#endif
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 90f3c9802ffb..e3a59b0c5564 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -58,6 +58,7 @@ cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
+cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
