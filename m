Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9F0C04A95
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Oct 2022 21:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJVVtN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Oct 2022 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVVtM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Oct 2022 17:49:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ECFFAE76
        for <linux-cxl@vger.kernel.org>; Sat, 22 Oct 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666475351; x=1698011351;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fTfvbxsF1g5nVVkpLdNxQPVmx2XWKZwZF8a/tMMZgBU=;
  b=BNRea727ZS4ar+iEvVDDFJxVJjhp7Ige/8Qs7dn7+6j0IEQbkpu2kvt+
   vcHdauzDtKXw+DS0BdYxI3aRux/tO5/BdCol8t/+msyd3Kjv4tQ+giE0U
   y6WNM20B01nddRDAvG1ageYNGy3BbSQ0aTsBsuGbsxtiKGVe+4s07cdK1
   DDg+55l9g7H4hkRZEvQbGxWmXPv373r1tmnTFNgb98+ikakUHB/cNlg54
   pvlKh89v4CszcU7B24b1Rdn5neo1SORu+hiY7dbBWhDvfnFrk4YI6WXD5
   AOyFqngCudDgrlkrbcAio/AmmxNW61OqK90zSppexlRkaeE2cwWGcEig8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="369278715"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="369278715"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 14:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="756180533"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="756180533"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2022 14:49:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 14:49:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 14:49:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 14:49:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 14:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+g3WqiA8Cn8xGTjj6EC9+z3QqAWAsxm2fUNI5FjigLLrFw7MUnJTpgonZQWoTV15bzRl6pceR3fbGznQ4ncAadrpcHlVzN8FiBfoxlJQDZXAK1c8kxm0mGegQscthDFTzHbVdisMUGpJGCOWKsGdMFYefqEcEUw3y59fQFxbyhvUgw/sZS6K86BMMtrFlHopr+BIDLtpMZKL5sVci4a84OS/Uupouqwnn9Wbq3pWEsZ1yS1V7YMdwf3/YpCfCQ6rBFaUrOgb7U3S5vrVpufxmV8UDqbDshdAV3SkIIMpxvZJEHPTn5smuD+PrcY3YGPa8SN0zZek98IxYrSIKzyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amaDno3TupQWtvNZo0RJgcPBA6RonKwMPTze+V/AhSU=;
 b=A6cV6TT1UeemB2daiyeocufJX34ahLUaPkaGx0nbEXh3Nsdr3Zbgbo4Xio2Qt3ySYrSwumd1ueC2quatYhk1Qpnb1AcVLMGaO6LCi5QI0XoFhK42jyHEIkouHRfa9hCatm+l1xIYGKf1HyPg5jY/o9j1FdTzx3Lbu5Z/XhXKlGfuEpTRitY/Yay81oE31mjyr9kFjnK+bGcV7MWcdT/PTreG2E87pNP8qSm0kBHyBXtAzkyHmTUUdCEA41iYR/cX+8IGGDQutFX3/cGEYL753AHmqmlcDrFFAiplXW0rZZGNbcJRxx8GnNRWVF2G6epIZPSDGVBAAkvdkqje0mdg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6185.namprd11.prod.outlook.com
 (2603:10b6:930:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sat, 22 Oct
 2022 21:49:07 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Sat, 22 Oct
 2022 21:49:07 +0000
Date:   Sat, 22 Oct 2022 14:49:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2] cxl: update names for interleave granularity
 conversion macros
Message-ID: <63546550ac59c_14192949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <166559536239.2130185.18009064249679668239.stgit@djiang5-desk3.ch.intel.com>
 <20221013132135.000054cd@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221013132135.000054cd@huawei.com>
X-ClientProxiedBy: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY5PR11MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be141a9-81a5-464e-3aec-08dab4773ea5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gb/Wy7+LJTsJxjcKBRIvzTbTvcfE7f66kSSn33A5VsiHdterlQnp0Hn/IKEv8qM5bbcCX7nm5F0KvL9VAkPAoBrGnpyLb0ZcremKnECa5j67oiY2l/eCev8JyRpiTtx/aGLn4tPiB++LZ72IBlw/EpP9CzUNlL3m5nCORgPtk0C9EfTeqjk4m/4qY862giE4QaRhRWjshKLlwG65sJg+mO97sLf0qLCBUiwQM6SGVGcxTNhO9j6Jm9ELMGTtjHuvpcrjV3UnaEwNb/04HDpIwOqT8FzWIJmRoI5izoMDH5yaWs6dHMS2iMgunncESqxJBlyHLlKKhyAI0NYs+YSoX5SPIYzoIMISOJ7gQQCXpI/I1kXjLTUjtzTtbvdH6SyXTl0Wi9U0MTzaXyPMkZrkqwjHUaXdGNMV5Ys+NVSfmBSsz6ORVr81TEQoyOwVcBt8VTe/lsIyKWQBsVTsMr53Vg8ebMKot8QrFpDtZyrIZWYNteaciye+1P3RlvPvQRRRGn2aSFseWPA3CnI91o5qhRxf7VIAlDbaxQpEfPdh83t8Z46HeN/o2kNRsZPS3HbMrwR7kjy0Mc+FAAHIEoT4rMkW+0PyUMBpQCUeMKihv6QF+zKsQCXBIsO1DJyR9HJD5Ia9x+SqQ8bXANAqDKxX5c54NZxEXTGkYShtorXw9j7ulolKmQPdpi01Di6RGYoK/N+Ujl7+KTmjtKp7qUQMiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(82960400001)(86362001)(41300700001)(9686003)(6512007)(26005)(4326008)(8676002)(6506007)(4744005)(6486002)(5660300002)(8936002)(66476007)(66556008)(107886003)(478600001)(6666004)(66946007)(110136005)(316002)(6636002)(38100700002)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?foSd6AnJ9uRiBSrxODVEJtn9gBlFAprWw/HdgFKI1uAhpFIIFJ8u+NaoTVTw?=
 =?us-ascii?Q?CD41nmo2v9XnXl5XvE7RsbHg59+NBARhHCTEg+Y9bk2icoR+IDhNTVpeIO3p?=
 =?us-ascii?Q?BmfN7bddpk+wAkk1r5ti4uVFK2UCcS/NWixxTDsiFBIDer4GI/mvmvToU9h1?=
 =?us-ascii?Q?+b0ipUkmWhhExPw7R98Zf2tSh0C/gxqzG2BXZTYufL1+lwvJPez0sjNKGOn1?=
 =?us-ascii?Q?By5zuaUl5qWBEloqOg4eUItJstQeA3Azrz5JlkiEp3nENbI+b+Szh1oKNNoK?=
 =?us-ascii?Q?LXpSxh2d2Yw34CBlc9psp9CVUzjsHSpybUnrarCJY8c4jRGmxr1iSaDWh/8S?=
 =?us-ascii?Q?K9uowfx6ZND3xzhWZndMTKiCyxt/Pv1Aa0m8omCQZ5exditduDFMpeV2vIPq?=
 =?us-ascii?Q?6yrWIEsO5dkXbd2Jllf82ChpIl+OK31cvQ1p4kJ63G+OPNYmQ3qpIxA6VtnJ?=
 =?us-ascii?Q?yzMB5fONe0LvSFurvxEMu2sWtQyvjD56anPPHnqpstmaD9nNPgju70eN6Dsn?=
 =?us-ascii?Q?6WHlrK/Z8zfF33ZJtNYfLr6xIX3bJ3RJl+5fXRHbBqx+kz/lmv7chjNzhpeW?=
 =?us-ascii?Q?7pfmrD/j5s3EE6vGHu/ybplq0+IVbK1vT/+KDZFBCM5ShKUPNRJ4uGX9vrb5?=
 =?us-ascii?Q?sq99G51ohSXuNsDmEqG4dx9KD67m2k2SIJyBXL78IVwL27A4KavWds6Ex3Q9?=
 =?us-ascii?Q?nxAzAdR3loXfTYt9PGwuGCKiBotdcmjPEqpVC5ovzIhG/cwN+eMdBLCA8JTs?=
 =?us-ascii?Q?8aboutOCsysz8JyefnU0YSkHIIKrMRJuzNFW+JAPNFKMfAl+I7mrnmm+4NFB?=
 =?us-ascii?Q?VHefaC7nUG+NmMmrisblTLCz34Lm3cwtAUMfCGD4ZsquRE/c+VY0KXK+rd53?=
 =?us-ascii?Q?fPUcnyYexcHrp6/qm07tOkZOaDP2drZp5kuT+74Tt8A5nq+eOCKxa00nlDS9?=
 =?us-ascii?Q?xsXg0xBY/lzmk7PUj6xJ/5y45uNqyz3Q5Fozr3IUOaJj6XCPBiJmyF2/rvRe?=
 =?us-ascii?Q?H/7TetH3RYIt9IsgiBLD1K4WdzitOKBETNo+ENL/S5yE4PrGov3grTXfe6VD?=
 =?us-ascii?Q?3U+2L0+LUW1y3qjRQUqqfuE7QsP1SHPTFIsDPuMgkRAnTvpIZiWhPq+UaqZw?=
 =?us-ascii?Q?+yWIto/Prq1f/WMpiHxQD4PtY02vJUiWElCMvphTK3oDhehpWF/4Iei4iOEY?=
 =?us-ascii?Q?VgiGREUfiZhds5dTmsIBZcKAHCjVpUi4u1KVxWUIhlOc46F3aiHdP2MsxO4R?=
 =?us-ascii?Q?TGJHqbHx6KTjvNvp/WFJ3JDwEOni9dGy9kfF7oMSQNeLDwqft1YHBo8xuH9x?=
 =?us-ascii?Q?pcCTeFx+l6CrgJ6+Ctt1lFADpDT1USvJ4lL9VYneDXkbObx4tqtS9jf0bSz7?=
 =?us-ascii?Q?4Pd0gdHtUEImBWBQMUmhY/CULvxalsdQCvFgbkg46NEaBfIlQrsaiWYnNuHg?=
 =?us-ascii?Q?RxrIQ0MWS0QdFv22fWQliQlTGCEXgfUbl9ML2LzEl47WahGZk+R2e0TOazKF?=
 =?us-ascii?Q?tnn9oKsoPvFMxnXlnQvSYYpjJC6hYM6JnFOtPkv8D2HZCFwxSg76pc2V75IX?=
 =?us-ascii?Q?QJ+qMaf7Pe+87lTtxzz4eyXc4Y36fyTO/O1vWD9YvjLtE+z8cPSHJiJE4dy0?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be141a9-81a5-464e-3aec-08dab4773ea5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 21:49:07.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jh4FOw8rS0tebq4cJviGRdpxBsStNWejyqapDJVVu5cfEv2fho0d9eJneyrqs4AuwaRkqE6Gu1G/PnN0JX5RpkE1MauSgdfpGi/PAu0BYMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 12 Oct 2022 10:23:23 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > Change names for granularity macros to clearly indicate which
> > variable is encoded and which is the actual granularity.
> > 
> > granularity == interleave granularity
> > enig == encoded interleave granularity
> 
> I'm not that bothered, but just wanted to note we have uses
> of eig for this already.  Maybe better to pick either enig or
> eig throughout ?

Yes, please 'eig' already exists for this purpose, and I would keep the
cxl_ prefix. Same on the 'eiw' patch.
