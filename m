Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F2DC636CC
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 21:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBGVzm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 16:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGVzl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 16:55:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD03A846
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 13:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675806940; x=1707342940;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H0yKjxOna0TfbfR6dvbH9Mg46OfJ+a+H8AeuG0u55wE=;
  b=hJ1510bsmCf4V3dNp3NHQVL9rYjrUiHcRvI8YKXm0xVcl99oyU7FKYpn
   nA93mnnArP9eHDVv2j6Edfnxk+B15UDXWRYBppqTCKs0A2sDHirRdkWBo
   0SUffcWfMhUtW4hVFR0n0+iNvVkvud1qHRYjc7iE+tja3o6WQhpHjj5pe
   TexgxSOLP6+tA+MjxibV/yGJpze7//hfSpHRQZ3rp9DfgV8r635FbB6tM
   cW+iVquomAL1WgkhNnMTOIRSLcpv5s5wzQDI6xdrSe+vaILNJVl0tmLaf
   0GkomHlD78srqqf/8Fzkz8mGhspubsw2Dgl1TBFZU4TQqmfqCwNhgW58o
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309287593"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="309287593"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 13:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="668949148"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="668949148"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2023 13:55:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 13:55:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 13:55:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 13:55:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZAwL5e6Ub9qDWr0xw6m3t2dszEAhotfXM+abs/1Pk4bE5Bnrt6Ycy2ZoLNHBPuBhKSMr66c4YcDDv13e0sKTixm4hZ27/80RyxU2+WNxdLVtHEfcTp3mlx04kXVmTDbjO6FPt0rh1xAAaLU6rIX2COr2wXfB11YMUonLtwwS+xt/t7u/ZBxS7JjsCsMwGTWSAPLiyrOMY5fY43Y9TbcStcjXapB/9kXfD1pWyVC/djQyJrVQ/xNOiZNPll/K9HDr5x06KgddEuFyqoQO57w1JqahIDET9/rgedfN+W5izf0itO5rPzXLv+PfCL92CFKefUIeySjNR+Ym7iTp4iVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4tnCsDYpo8xt+r8apBnbXBnccDYtLQ1DdFhhegR5JQ=;
 b=PuYfSwiQmN5cuGmYLgpc1dcpuJoBBy+esIvRO01M/2LWYki89PDy0u1ZyxGwBnbIq261FknrTtVx/5eM4H3P2uenRQp0WmkbUxulYcuNUSw5TwBEKGDRKsPMOQFiud3dhbFZGglY1DQTulATbTIYb5Zx+jHx7tWgiW7OF0/5IQGQZh/zPz1ZOOID2wRXS3ao4WEqRklN8fdL6Ej/9uJwZHXgz5UYuCNpqynGX6zNTJapRMqc9jPuWrwEDIWG5Es2OGMhaUryQAt3GMPZ4U3yawmq0h9O7UtUWqpG+Y5W2n7AbtVIF+9DY36MnpZlNXQ9XnY3kaeRltO7ziWHeVXZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 21:55:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 21:55:37 +0000
Date:   Tue, 7 Feb 2023 13:55:32 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3 1/8] cxl: break out range register decoding from
 cxl_hdm_decode_init()
Message-ID: <63e2c8d4bcc4d_e3dae2947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406530747.1455071.6556733331321082239.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167406530747.1455071.6556733331321082239.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: SJ0PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 0047fa91-1434-4e3f-ee69-08db09560b02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENqv7SaBUqA8+8jT9svsVipn4VBxPmoYAJnV5VX1AxUNOYCPsnDUiFj64w90I+fup6rVdH3v0UM1L+8aoiRRHqeSRDpL3nuNsLx9UZVSKJNFihcUW250G2tlcAaTsuMgFeky8+2Uam307v5wcvv3fUzrn5uJZw81/pTEjwkldn22U1MvKg3YPGsRlGHdxzRlgWOChCJX2XZEvbaVxbSjbxu5PG7eQHCO8hins71mvVIDlgMKeTMDx17HYIzbByXVI8PljU166kqAvyBcw6PSoPmszpUZpc0+4lvDhpp3gTaysZbes6zTTj4EpfkuEvTcyF55KWDDVKxmXy6q1Lm+Zoe58aORFJqlZQ38ppLgGir7vHQ4pQdVz7yDYdQdlpDfxHWpiJ/MLrd6Xo8HO/T4CyogRB0OzuSdm+xAqY2XoNmq0n1Eo8ayHGpzgEfy+Q5abWLctb/p7jAspV4xj9N1Mbtgl1XrJ52qim3W8rZogJoGyyvE06WCy7EsCHV9Q1GtqdYLtyJ6dtlwrjrqneII9wVZzuMx2ACVnHyvOTGIlumUJkPMdWNHOdy6FSjZPB/aJalPReM+6R7oY8UGRTgA2drAPPZkpFj5mNix/ycALNiK9Krjo7zVwhLS+cFz2X6u36wOVkxdOpPpvaDa0mzeYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(86362001)(186003)(6512007)(2906002)(4326008)(66946007)(5660300002)(66476007)(8936002)(41300700001)(8676002)(66556008)(26005)(478600001)(9686003)(6666004)(6506007)(6486002)(38100700002)(82960400001)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjGwx5QWk3q4MNPhdaS8REuCCHIYhAw+nMUQCitoaaIsUnR27Mx80PAlwLO/?=
 =?us-ascii?Q?Uf8zS3hsV/G1L+A+b6h1HkjYWSsDTanvdY9mIi404ocEOYzZL6jhthokAogD?=
 =?us-ascii?Q?VQvVe82ZfFI98oSAkz6hq9h5oCt4I9KROqamLFg0WiMu+boI6wxrHn7HM96b?=
 =?us-ascii?Q?3CBxWTgFNWRq6z8M4ItB3yeBFT9J/M8a/DZluvz6zKnYokhKLgKrVDbctEOQ?=
 =?us-ascii?Q?Anoc9rWp6S2TaW2E417e2DJKFp+vt9mxf4lPhAmVgyJwBAlMCYl3OpDXup5M?=
 =?us-ascii?Q?Ei+TP+n+77Q1pb/+PgwPXHA4iJcsib2QZBeVnoFMZ63Ejsp6gTMLF9HjgJBZ?=
 =?us-ascii?Q?TOIgcjZl/kGHe8xpDwHR0hZH1gJNnHhyCZOol/URBcC3kbnXQ+gEg/ITUyEk?=
 =?us-ascii?Q?D9nShR9kDGCrsRB1/PkOKKnF8kwkJLdKSqyEso79GRdIJ0t161bgBSdpiRgo?=
 =?us-ascii?Q?Sop24IGzryFps11dOsN42gUPqhKhLkM8TyqtsBFymlgw1elr0at0N/5tBvXN?=
 =?us-ascii?Q?cN5o6zTs8h1U7w5NRu8FhIQoqDz4TxsXjxThWBvO1OxtpZFydkB45H/Qrobq?=
 =?us-ascii?Q?qdEjBYYGiPWCGsAqNbIWH0280D+Ki65m+vGKtSO2rcIPfjD8Dbh8tpfOKW0v?=
 =?us-ascii?Q?WcWTXucRCaGmdvKGbUPzNxT52sHJVA9vTPc9cO73uBFfpVF6gwdniXPxdUTC?=
 =?us-ascii?Q?F7Yv+maj1wDQavIex5cyL2H24JlPGeleL2cx5j/cnmrMwsfo6D2bIfvAF4fj?=
 =?us-ascii?Q?gcp56XoB5JjPz5m+73RodUxfsCOUiIcL0CKF8HorZ8RbhAxaUzJt6aIh90Bh?=
 =?us-ascii?Q?R7PPtkDvpRgZBo81MNxpQpxdJVRioc6hW+5CL7Sikwb6PnZO6j65F8pC1LoY?=
 =?us-ascii?Q?v3xq6B1xi13yrKaJOYWskkQ3w+PpbkLjgP6xLPkicghf6JvwSFZ55PK4vBe4?=
 =?us-ascii?Q?pLtX1JssSlEaULHOF0tlUR41WZGqinReK9B1mBSILcr6YBpCNizRT/ekRrgk?=
 =?us-ascii?Q?wu3VyMPA/uH1AMhUYzgkTYMtN3uTZLcOjtt4Cxk/4DwaqENkUCnlhwr4p4sd?=
 =?us-ascii?Q?SbR/dvK79BbGBhm0GgLFvYRveKynP2ibcRHkY6TpSq8fsqZRd33yao0xTByH?=
 =?us-ascii?Q?gQwThz/DMSgW1ZnpxBwi4JcS3yzb30++AlpSL5szOEk9QPd/XtUgkGVPdz68?=
 =?us-ascii?Q?o/YGjK/FxV75L+uz/tRpDapK0L4957BJ/2WoHcnoBIm1YQufdkUWPxn+6UIj?=
 =?us-ascii?Q?xsVZDgNK2l3NDr/Vy0pgo9g/khyWOcnMEPKXOOl/laNlhMauZuPRSDq1n0Ty?=
 =?us-ascii?Q?2Y0o7B56ZwgStFjXlqA7dW5Nq5SA9Ygg8Fs3kk9YMheihgo+IOddMlcXybn6?=
 =?us-ascii?Q?G4hmeDqSShNA+gCrKg8MJk4+b+cGPW98rgkRhkyErMx6m4bp0F9/2MP3DWmZ?=
 =?us-ascii?Q?BpeVVlL7q9KT6KpU8Qwly4VR6Lvi4hyRmgnCjO8YeKgjlEiQNWpMkPn5JayN?=
 =?us-ascii?Q?jxDfsKTJ0b8zNKiAFLde2ml7EbvE8hLIlg//x81IKu3prAMUoQuuYpZTUGTu?=
 =?us-ascii?Q?zk0KgbAs5OoSRq6yrzGmvQCm9Y90xKrOUg5nntUrMHQGFEyM7F7hpE0JWHAv?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0047fa91-1434-4e3f-ee69-08db09560b02
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:55:36.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWcZX3Fk0uGRQedz6cibcZe/Ce51kuwvqS5W7HPFbkGtA5W//RqVrNPeTcZXSH7Nv1uYgRtMx3PmoShIgJQo0X0pSCAXdTbJYl3gfty6s94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> There are 2 scenarios that requires additional handling. 1. A device that
> has active ranges in DVSEC range registers (RR) but no HDM decoder register
> block. 2. A device that has both RR active and HDM, but the HDM decoders
> are not programmed. The goal is to create emulated decoder software structs
> based on the RR.
> 
> Move the CXL DVSEC range register decoding code block from
> cxl_hdm_decode_init() to its own function. Refactor code in preparation for
> the HDM decoder emulation.  There is no functionality change to the code.
> Name the new function to cxl_dvsec_rr_decode().
> 
> The only change is to set range->start and range->end to CXL_RESOURCE_NONE
> and skipping the reading of base registers if the range size is 0, which
> equates to range not active.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Refactor to continue when size is 0. (Jonathan)
> ---
>  drivers/cxl/core/pci.c |   63 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 57764e9cd19d..a8ecc6ddb3d7 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
[..]
> @@ -410,6 +400,13 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>  			return rc;
>  
>  		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
> +		if (!size) {
> +			info->dvsec_range[i] = (struct range) {
> +				.start = CXL_RESOURCE_NONE,
> +				.end = CXL_RESOURCE_NONE,
> +			};

This should just be .start = 0, and .end = -1, or .start =
CXL_RESOURCE_NONE, and .end = CXL_RESOURCE_NONE - 1, right? Otherwise,
range_len() on this range will be non-zero. Likely moot because the
range will be skipped because @ranges++ gets skipped, but it looks
strange written this way.
