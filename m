Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6121BEB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Jun 2023 15:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjF2PUT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Jun 2023 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjF2PUQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 29 Jun 2023 11:20:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671ADAA
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jun 2023 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688052009; x=1719588009;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RMFwBKvGy9CNHBpMsfPO2jogrkU9bT68famiEXoDjd0=;
  b=Dkz5f4e/Ha9W8HWzFyG19Vrq5pxjQ5b9anPNFBmo78GeS3kTiTJ8Jz0X
   K8+Cl1ypp/6xypZE6096dn/pJd8bdgLZsu0W5sHN9L0pfqYlqmobWLNY/
   HBp9/qVux0jdVblzfRy4pXDtFPjLggAif698Is/aSiIUpb67JuBe47CDT
   lZKGqJ5CyHYNGRHkxaWywb5QuB4MyrVxb74YiwfQU5MdG+LM6+3noW9O+
   nDUeCqYT6w6jAeONQsw4fqRzQYTqztbzLeJTrj649Z3ElfZNWFO5zT0WJ
   d7josC5sAu/sAxsiolu4A38/V14IhVcyNrgp6nvH7UHJCpwh6TYmlNtb9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="351959293"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="351959293"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 08:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="1047808538"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="1047808538"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2023 08:20:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 08:19:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 08:19:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 08:19:55 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 08:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWs3U0+h/2PmlyD0QOJcDJq5B6Tt2Z1fs94jsdFjpSyHEXFeU6TJ3AMXFmwmh3gRjOtULdBq7SqkD4J/A09PF+otVRiPlMRx1i9Ph880kAZk+DKCGlZ+bYx0Gx4UfLXPAMB1EujzyQcNeoxQo7r5Cd7fsCsKiRv/+YAuZ5aUkC34vGn10Y08ZuiXsAmrLlm62SUFSctwPrpaLxT5qYLxn9dwk2km28LdCyl/5ICbyPu66u/KrgBIScWO/Nc3IG7xQL6KsSJNQLq39YEaPM2IwU/XgVaJKMVSha97+VJOhdq2rSnspHYmYJ7c1Uqxhvp0pBOJoroIhtC6XE2n/PLthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKHkHDIA01m/p28EqF8n+Lgzxu3oOGtreJ+6sMSpEZw=;
 b=mezFOMppLVVPnLWmmfW8OK2nNUJ0BajePmghDhz+4ll1LUuwnI5Em7XQVWJ95+4uM9wz1D2km0tpHm/z3qCEiuVNsGFvLLi3PqSkyJkyIHpi0kq4s/3FKTG4CSpaa0xzONESslOZ9w27mGsWRj5ifSInUpSeBk4dix+dlsRYsipScf6/XliysgxLuHRn5QDaSVqzE8CZ8uopkA8owdz/F5K0dkrX8P1IMvd0255j8diJgS0cEYOocqju7PY0btnQWAUa+Ty6WNm4cnbctDbWw971/wiBp3kCKiN31RLVdOfBCCKoEUqYbq9JKr8XLHWZiWphlb7TkK2ETC65qlIgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 15:19:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 15:19:51 +0000
Date:   Thu, 29 Jun 2023 08:19:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/mem: Add support to handle DCD add and release
 capacity events.
Message-ID: <649da1107ab01_7645b294fc@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
 <20230622180130.00006273@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622180130.00006273@Huawei.com>
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BY1PR11MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: d8173045-045c-4507-2075-08db78b448a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcSj9xWG5Myi1SHPx64QLFPJBy2sr84GjuaB8HKROl9S14sZNuHJ5/TerIRNrLa1BMS3Ktyagtner6sNlNG2yuT/r4ZIG4R2S2Zhxhqr/KUpL+Noto4fUrixtS870BGpeRdDOwaqPhWNuFw8deiiOaFxoU4BgbabTZiHhNc2aKcT/K2f7GTYSbfukFscRZSP10h2uGEPbLMFHoqKRWptdBWYgBhvN/ZcOl1tR0TqmtM1k1SfwkGUIPh+sasPRmNRw5NyvtAZI/UOPLdrLpkMZ9RYlyw1YldwI7l40F/Ut+61nbszxFQqV19Ya9y90UbLjJa7rdTtCwEGLXmOmuPFmJnpjtZ2n2WboYNJByLLFoXnNYQPdzpSEOKogHeHHVNjGblqDLDAHUdmZkcarBbVbZt5GVAVZFNgdyCJjgzVsvoJfY9PN07aImpS+3f4eA4KPDs4ga7SwG4BXaSEcSvFRB/HZXjdjHdih1T2KofxcvSeBMdtUcR66Tclm9xyKyZIOg5HSacgBtSUUZ/267sP5xmhvqqxmqckg1mm73Y3IHj/rHTK47dNEgNfpg/9SxGq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(38100700002)(66899021)(82960400001)(2906002)(44832011)(186003)(9686003)(26005)(5660300002)(30864003)(86362001)(478600001)(316002)(6486002)(8676002)(6666004)(6506007)(66476007)(66556008)(8936002)(41300700001)(83380400001)(4326008)(66946007)(54906003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gBZoE8QHzAcYVumTEU0jEhiTcAIvxDOwMwPIlOlRWMn7DW+C/X1YVs535nkF?=
 =?us-ascii?Q?F3Qvwme9LY5BaNr8Et603uxc7tiBjsi1Rfda0vncPXaUMJoWBlBDlICzcIrN?=
 =?us-ascii?Q?BX2zBs6zhM8+nTBWXpVzlB2DOaFXFinc72KjPmjUq/dw0m6LZ3XCak7b81cG?=
 =?us-ascii?Q?sI1URW0WIJv52ZXlNRNflUnzhKPXyA6PPcBVvq/KlE0GKlWYXNUYY3qFPy9e?=
 =?us-ascii?Q?eXTsAka4uBn/Sa7UPsG2ikwMdc119hoTEkxZPONJ8pkkP25G9y6SGXSCNGWb?=
 =?us-ascii?Q?z4mv2wIlrJZBoMd3sfzauF+N0at+v64rJCsTGfQgZhJlSCWstaulesT3AoIn?=
 =?us-ascii?Q?KDx27zdI0BMrjKJuoQ35106iA6X518uUhCRfyPdjIU5f6ZmSReFpILqXiZ2u?=
 =?us-ascii?Q?YvoimvRg8NQkXchnAFFXPavTgTkbceWl/Cp4hAc/SizoThfKKuMPWCWzUuQg?=
 =?us-ascii?Q?KZMHNw+ls0IlRfkHMGAu7liT9Vn9WX6lX4EN1RpY/IXD+pd51HERRaEuA9Ai?=
 =?us-ascii?Q?53eJVXI/DioaJ/8nkiJg6qNJdS4te4pqnfzOT9E3GND2LHSIWyzm4fhr1Ebg?=
 =?us-ascii?Q?wpJqW+xgnZZhDIbsoUteKrVi9/kau55bToA4vpahBPLDkZdZDnFiBTfvGW+d?=
 =?us-ascii?Q?SWdPPEDKHOPAnFRBSONu2iImUy9shzlTC6i30E81NKI0fEtzqQxdC4c+dtok?=
 =?us-ascii?Q?HD06SO3lqK43pwo9lYgET+r4/HO4dcUzxn6SRX33zdq0qIrWMM22SfhmvsgB?=
 =?us-ascii?Q?RPcTWZUD6DISKbbjE3SAizV/rLtuidWzJBrArQDug6FqR3ZtlHQNlpTwytYw?=
 =?us-ascii?Q?HCH9+RksMSyIE+0/heLOSmR0rwZ+FFLT1SOQayEXmRkYYs+ak5r97gfMA/PA?=
 =?us-ascii?Q?0tS1ijaaxWj53ebx1iEui08fS8NdPK0JVC7mxELtpRWqhQnA9AUGTtR0Irit?=
 =?us-ascii?Q?iqzCsaOI+VZX1/gDjqTUmxgtVVpjiFZa+7kKBMVloPSBOiOnQ7bneOEkiC3K?=
 =?us-ascii?Q?dF8RP3BOyZ9M57RV/Yg2KvCwDd5ypn3UejMOpt+a0EEbrUXoLyw/FyO24zJW?=
 =?us-ascii?Q?lg0tsI8YufUv1m7R2Ha+Y+9aYSDOB1e3sYUABZgRlWDwgyAO8x4/KYIGTkaw?=
 =?us-ascii?Q?q52G4c62JPAMZIoqb1NA5iqjs6g8v9b6cQr3e+KSGi3PcpWqdU/1dIMIdl2y?=
 =?us-ascii?Q?79g3CuGo4BWRzQmf/+d3mIorDy6/G0+cGs4Oelr9tCoz6BBasFxerAMNxoRg?=
 =?us-ascii?Q?JsVAAPK3vBAssVQL4eimQLox2CLWCqO4sFVBHsLhZSJECwvk388Sy3D7DuVJ?=
 =?us-ascii?Q?5qoiZMd9p5bQGJd6Fsx+407N6/FyWsTt9BrOls5/qfXddnMO5S+tZ1YKQ4XE?=
 =?us-ascii?Q?46zRW4ZSUgt9QIMKP6fNGYsN6srHfwBHD1PvaXvkmK3cy6LGrxMp8Er9K5jH?=
 =?us-ascii?Q?o9xwyCh75b+qb1h3kFX/hfrI9N0Q8AbvNYNdWCo9dj6bNict37twlXu/jXtr?=
 =?us-ascii?Q?kSEcBDnyQFQGLQ7OJ9ScE0nHyDNpTK1mcaVwTvOwJd9Hyn+/cIrXSRGgidOf?=
 =?us-ascii?Q?N+LhRvIXqZZA66V7MPOu3ZLD4P6ls3sFAq7kCXgB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8173045-045c-4507-2075-08db78b448a2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:19:51.5116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yjmNeWqhyqRBbC1meVYocBXdPa9lwhK1kTrdMWLieZd2wc6LP46ihxotpsW5FMecSFUyvreQnAo20rBozGQnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 14 Jun 2023 12:16:31 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > A dynamic capacity device utilizes events to signal the host about the
> > changes to the allocation of DC blocks. The device communicates the
> > state of these blocks of dynamic capacity through an extent list that
> > describes the starting DPA and length of all blocks the host can access.
> > 
> > Based on the dynamic capacity add or release event type,
> > dynamic memory represented by the extents are either added
> > or removed as devdax device.
> > 
> > Process the dynamic capacity add and release events.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > 
> Hi,
> 
> I ran out of time today and will be traveling next few weeks (may have
> review time, may not) so sending what I have on basis it might be useful.
> 
> Jonathan
> 
> > +static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
> > +				struct cxl_mbox_dc_response *res,
> > +				int extent_cnt, int opcode)
> > +{
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	int rc, size;
> > +
> > +	size = struct_size(res, extent_list, extent_cnt);
> > +	res->extent_list_size = cpu_to_le32(extent_cnt);
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = opcode,
> > +		.size_in = size,
> > +		.payload_in = res,
> > +	};
> > +
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +
> > +	return rc;
> return cxl_..

Fixed.

> 
> > +
> > +}
> > +
> > +static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
> > +					int *n, struct range *extent)
> > +{
> > +	struct cxl_mbox_dc_response *dc_res;
> > +	unsigned int size;
> > +
> > +	if (!extent)
> > +		size = struct_size(dc_res, extent_list, 0);
> > +	else
> > +		size = struct_size(dc_res, extent_list, *n + 1);
> > +
> > +	dc_res = krealloc(*res, size, GFP_KERNEL);
> > +	if (!dc_res)
> > +		return -ENOMEM;
> > +
> > +	if (extent) {
> > +		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
> > +		memset(dc_res->extent_list[*n].reserved, 0, 8);
> > +		dc_res->extent_list[*n].length =
> > +				cpu_to_le64(range_len(extent));
> > +		(*n)++;
> > +	}
> > +
> > +	*res = dc_res;
> > +	return 0;
> > +}
> blank line.

Already done.

> 
> > +/**
> > + * cxl_handle_dcd_event_records() - Read DCD event records.
> > + * @mds: The memory device state
> 
> >  
> > +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> > +			      unsigned int *extent_gen_num)
> > +{
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_mbox_dc_extents *dc_extents;
> > +	struct cxl_mbox_get_dc_extent get_dc_extent;
> > +	unsigned int total_extent_cnt;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	int rc;
> > +
> > +	/* Check GET_DC_EXTENT_LIST is supported by device */
> > +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> > +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> > +		return 0;
> > +	}
> > +
> > +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
> 
> Put it on the stack - length is fixed and small if requesting 0
> extents
> 

Ah yea good idea.

> 
> > +	if (!dc_extents)
> > +		return -ENOMEM;
> > +
> > +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> > +		.extent_cnt = 0,
> > +		.start_extent_index = 0,
> > +	};
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +		.payload_in = &get_dc_extent,
> > +		.size_in = sizeof(get_dc_extent),
> > +		.size_out = mds->payload_size,
> > +		.payload_out = dc_extents,
> > +		.min_out = 1,
> > +	};
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +	if (rc < 0)
> > +		goto out;
> > +
> > +	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> > +	*extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
> > +	dev_dbg(dev, "Total extent count :%d Extent list Generation Num: %d\n",
> > +			total_extent_cnt, *extent_gen_num);
> > +out:
> > +
> > +	kvfree(dc_extents);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	return total_extent_cnt;
> > +
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extent_cnt, CXL);
> 
> 
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 144232c8305e..ba45c1c3b0a9 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> >  #include <linux/memregion.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/genalloc.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > @@ -11,6 +12,8 @@
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  #include "core.h"
> > +#include "../../dax/bus.h"
> > +#include "../../dax/dax-private.h"
> >  
> >  /**
> >   * DOC: cxl core region
> > @@ -166,6 +169,38 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> >  	return 0;
> >  }
> >  
> > +static int cxl_region_manage_dc(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	unsigned int extent_gen_num;
> > +	int i, rc;
> > +
> > +	/* Designed for Non Interleaving flow with the assumption one
> > +	 * cxl_region will map the complete device DC region's DPA range
> > +	 */
> > +	for (i = 0; i < p->nr_targets; i++) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +		rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> > +		if (rc < 0)
> > +			goto err;
> > +		else if (rc > 1) {
> > +			rc = cxl_dev_get_dc_extents(mds, rc, 0);
> > +			if (rc < 0)
> > +				goto err;
> > +			mds->num_dc_extents = rc;
> > +			mds->dc_extents_index = rc - 1;
> > +		}
> > +		mds->dc_list_gen_num = extent_gen_num;
> > +		dev_dbg(mds->cxlds.dev, "No of preallocated extents :%d\n", rc);
> > +	}
> > +	return 0;
> > +err:
> > +	return rc;
> 
> Direct returns easier to review.  

Done.

> 
> > +}
> > +
> >  static int commit_decoder(struct cxl_decoder *cxld)
> >  {
> >  	struct cxl_switch_decoder *cxlsd = NULL;
> > @@ -2865,11 +2900,14 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
> >  		return PTR_ERR(cxlr_dax);
> >  
> >  	cxlr_dc = kzalloc(sizeof(*cxlr_dc), GFP_KERNEL);
> > -	if (!cxlr_dc) {
> > -		rc = -ENOMEM;
> > -		goto err;
> > -	}
> > +	if (!cxlr_dc)
> > +		return -ENOMEM;
> 
> Curious.  Looks like a bug from earlier.

Actually no.  This is just a bug in this patch.  The put_device() in the
'err' path is still required.

Digging through devm_cxl_add_dc_region() in the previous patch there is
quite a bit of clean up which can be done which I think will make this
next section of code much cleaner.  I'll update this patch after cleaning
up the previous one.

> 
> 
> >  
> > +	rc = request_module("dax_cxl");
> > +	if (rc) {
> > +		dev_err(dev, "failed to load dax-ctl module\n");
> > +		goto load_err;
> > +	}
> >  	dev = &cxlr_dax->dev;
> >  	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> >  	if (rc)
> > @@ -2891,10 +2929,24 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
> >  	xa_init(&cxlr_dc->dax_dev_list);
> >  	cxlr->cxlr_dc = cxlr_dc;
> >  	rc = devm_add_action_or_reset(&cxlr->dev, cxl_dc_region_release, cxlr);
> > -	if (!rc)
> > -		return 0;
> > +	if (rc)
> > +		goto err;
> > +
> > +	if (!dev->driver) {
> > +		dev_err(dev, "%s Driver not attached\n", dev_name(dev));
> > +		rc = -ENXIO;
> > +		goto err;
> > +	}
> > +
> > +	rc = cxl_region_manage_dc(cxlr);
> > +	if (rc)
> > +		goto err;
> > +
> > +	return 0;
> > +
> >  err:
> >  	put_device(dev);
> > +load_err:
> >  	kfree(cxlr_dc);
> 
> I've lost track, but seems unlikely we now need to free this in all paths and didn't before. Doesn't
> the cxl_dc_region_Release deal with it?

Yes it does.  I've realized that a large section ~70% of
devm_cxl_add_dc_region() is doing _exactly_ the same thing as
devm_cxl_add_dax_region().  The only think that devm_cxl_add_dc_region()
needs is the cxl_dax_region pointer back to track it.  So I've created a
lead in patch to factor out devm_cxl_add_dax_region() so that it can be
reused in devm_cxl_add_dc_region().  After that this code is much more
straight forward.

> 
> >  	return rc;
> >  }
> > @@ -3076,6 +3128,156 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
> 
> 
> 
> > +
> > +int cxl_release_dc_extent(struct cxl_memdev_state *mds,
> > +			  struct range *rel_range)
> > +{
> > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_dc_region *cxlr_dc;
> > +	struct dax_region *dax_region;
> > +	resource_size_t dpa_offset;
> > +	struct cxl_region *cxlr;
> > +	struct range hpa_range;
> > +	struct dev_dax *dev_dax;
> > +	resource_size_t hpa;
> > +	struct device *dev;
> > +	int ranges, rc = 0;
> 
> 
> 
> 
> 
> 
> > +int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range)
> > +{
> ...
> 
> > +	/*
> > +	 * Find the cxl endpoind decoder with which has the extent dpa range and
> > +	 * get the cxl_region, dax_region refrences.
> > +	 */
> > +	dev = device_find_child(&cxlmd->endpoint->dev, alloc_range,
> > +				match_ep_decoder_by_range);
> > +	if (!dev) {
> > +		dev_err(mds->cxlds.dev, "%pr not mapped\n",	alloc_range);
> 
> Odd spacing. (Tab?)

Changed already.

> 
> > +		return PTR_ERR(dev);
> > +	}
> > +
> 
> ...
> 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 9c0b2fa72bdd..0440b5c04ef6 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> 
> 
> >  /**
> > @@ -296,6 +298,13 @@ enum cxl_devtype {
> >  #define CXL_MAX_DC_REGION 8
> >  #define CXL_DC_REGION_SRTLEN 8
> >  
> > +struct cxl_dc_extent_data {
> > +	u64 dpa_start;
> > +	u64 length;
> > +	u8 tag[16];
> 
> Define for this length probably makes sense. It's non obvious.

Done.

> 
> > +	u16 shared_extent_seq;
> > +};
> 
> > +
> > +struct cxl_mbox_dc_response {
> > +	__le32 extent_list_size;
> > +	u8 reserved[4];
> > +	struct updated_extent_list {
> > +		__le64 dpa_start;
> > +		__le64 length;
> > +		u8 reserved[8];
> > +	} __packed extent_list[];
> 
> Going to need this in multiple places (e.g. release) so factor out.

I'm having trouble identifying how this is getting used in multiple
places.  But I'm also unsure of how this is working against the spec.

> 
> 
> > +} __packed;
> > +
> 
> 
> 
> > @@ -826,6 +894,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
> >  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
> >  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> >  
> > +/* FIXME why not have these be static in mbox.c? */
> 
> :)
> 
> > +int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range);
> > +int cxl_release_dc_extent(struct cxl_memdev_state *mds, struct range *rel_range);
> > +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> > +			      unsigned int *extent_gen_num);
> > +int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds, unsigned int cnt,
> > +			   unsigned int index);
> > +
> >  #ifdef CONFIG_CXL_SUSPEND
> >  void cxl_mem_active_inc(void);
> >  void cxl_mem_active_dec(void);
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index ac1a41bc083d..558ffbcb9b34 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -522,8 +522,8 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> >  		return irq;
> >  
> >  	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> > -					 IRQF_SHARED | IRQF_ONESHOT, NULL,
> > -					 dev_id);
> > +					IRQF_SHARED | IRQF_ONESHOT, NULL,
> > +					dev_id);
> 
> No comment. :)

Fixed.

> 
> >  }
> >  
> >  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> > @@ -555,6 +555,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> >  		.warn_settings = CXL_INT_MSI_MSIX,
> >  		.failure_settings = CXL_INT_MSI_MSIX,
> >  		.fatal_settings = CXL_INT_MSI_MSIX,
> > +		.dyncap_settings = CXL_INT_MSI_MSIX,
> >  	};
> >  
> >  	mbox_cmd = (struct cxl_mbox_cmd) {
> > @@ -608,6 +609,11 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
> >  		return rc;
> >  	}
> >  
> > +	rc = cxl_event_req_irq(cxlds, policy.dyncap_settings);
> > +	if (rc) {
> > +		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
> > +		return rc;
> > +	}
> 
> Blank line to maintain existing style.

Done.

> 
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 227800053309..b2b27033f589 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -434,7 +434,7 @@ static void free_dev_dax_ranges(struct dev_dax *dev_dax)
> 
> ...
> 
> > +EXPORT_SYMBOL_GPL(alloc_dev_dax_range);
> > +
> Single blank line seems to be style in this fiel.

Done.

> >  
> >  static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, resource_size_t size)
> >  {
> > diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> > index 8cd79ab34292..aa8418c7aead 100644
> > --- a/drivers/dax/bus.h
> > +++ b/drivers/dax/bus.h
> > @@ -47,8 +47,11 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
> >  	__dax_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
> >  void dax_driver_unregister(struct dax_device_driver *dax_drv);
> >  void kill_dev_dax(struct dev_dax *dev_dax);
> > +void unregister_dev_dax(void *dev);
> > +void unregister_dax_mapping(void *data);
> >  bool static_dev_dax(struct dev_dax *dev_dax);
> > -
> > +int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
> > +					resource_size_t size);
> 
> Keep a blank line here..

Done.

Thanks for the review.  Based on this review, the previous patch review,
and more issues I've found along the way; I'm thinking you should hold off
on this series.

I'm working toward a very new V2; with my SoB line and all the rearch I
think is needed.

Thanks for looking!
Ira
