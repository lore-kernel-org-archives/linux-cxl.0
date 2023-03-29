Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2603C6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 22:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjC2WPK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjC2WPJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 18:15:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E159DE
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 15:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTp8ChSJSxkqav3MIbkvLIv39rsVcETZ3TGEF49nNM+TWL+SNrUaxeYwNfhiZHrMIiJ+AMDaTXVLCRWCY56RhuM4ZSfl2lSXrxFuz9cUCFSCMwefWHdDR6axk52sDXDRe40On+Nkv4l5TSk7DfiMY/3nMGGScI3EewJiS44Lk6jqjDW/tpFb0PtzT5z94qH7i6gSvhz6hKDe2ZIeQ+7ioBPP4soyBI4F5QQHYCor/5R8ALnDWQ4merZF6n13PZiHnKevJqe2J3R3y/IuFHRKJl8ppfZwTqB23oONef0K4ZkNeDm6ICqo6jgQGjVu17TUVfMR9Jl7pwUTvdOZc9ge1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7cXGRs9JZImimWxJ0UFfaLH8ahjoGNTjsmjVL1tLc0=;
 b=SIMQ5LrxQ1Nzxbc/U8Q5YV904Fq9qWiuauoNPJS5Jc5raPFt6aX2g0TblM6fwCXVXl0qgwkUjeQ6p91e22jDmEgUh1k/8kVj0VzSyqKkffN3Jua0KAYMpY3JXWYhlAELVAIsQ2ageKqO5voaiQPUZdlnME26hicevnXIj03YvUJrue2t+/MO1XG5C9ZF9/TMtH792jo2i+X93vEUVPBZaf2LK1arX6TK6uCu0r+Fsv4f/UbSjCTJn2KLpeEWIMDMBDgr7eN73oMZCbjz0L9Tzyq0YpbptyqVaxmo5D3Nj5a1dYLDEcoIo7lq7840G4gtd8yVX801OfoQdUlH4wGHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7cXGRs9JZImimWxJ0UFfaLH8ahjoGNTjsmjVL1tLc0=;
 b=mO0V37RI5uM2ZgN3JrTuROD+BlQ5qE8keAt2OpUKcbZgtqyYQccR6oJ92oKgCMHllxrNg3tziqJIhEgMY/8HRDU7dWUWj41JJphUU2+4PSKZP2e9aSSql57pPRCsvDteCOb61tywzhznmKNqTk7sw94GClrHakqj6ZCGj+1RbkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MN2PR17MB3789.namprd17.prod.outlook.com (2603:10b6:208:206::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 22:15:00 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 22:14:59 +0000
Date:   Wed, 29 Mar 2023 06:27:42 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] cxl/port: Fix find_cxl_root() for RCDs and simplify it
Message-ID: <ZCQSnlEmhGXF5gnW@memverge.com>
References: <168002857715.50647.344876437247313909.stgit@dwillia2-xfh.jf.intel.com>
 <ZCPLJme6t+Vm9wXY@memverge.com>
 <6424b0295461c_c72229470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6424b0295461c_c72229470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BY5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MN2PR17MB3789:EE_
X-MS-Office365-Filtering-Correlation-Id: 7331216f-6256-4271-aa38-08db30a3090b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0i+Fs22mWasDTKBSgnnnK4Mm5p3vcKaTmQDs3tlNFndn2EXbrRWTV1oVgbHHDAzyWsQm2WYWK4CUNhcCPPLsKnfTSs1OuNBT8yPE+gf6mTdgIzB02L4D0V8CrdbNkDXmQO/R5f40dHrMOUZDrHKxPbYZZ94oQ1zHDacjg6cg+5qcVX4HGWUJAwFZm0RaoLdvCS4A/jS3NlOXFA0cBTrydQDant46kHMaggdvyX/TbE84q/39bi3NM7y+/2S3VNgIMakvIHX0tw+c2DyXoAK0BlOcFSB7ZhcxdQ2MimGi+EXfc2Ylq19p8KU60e3Z8oGXlqGKjGo0GZKZEJJAKGAds69aSSqMok9EXf2qmbty+ldGe7AMhY2dFh/Hhu8upKnPwPjC7IxAPi1SvrmqFixFptAVp0s21DM6exsGoZjqDmhLj9L+lj7Bn9jpk0E1xLRJXwn2VehQQcDbtwzD4qgpC1ukx6cwh5NHPNIpyCR/az4daEFSo+KPDgrZm5uwRYLz+xVD8NCn5u17Oae2k4Q4Vmy7vEqIPREA3uwCY6FYcppQ0opA03v7FAzbUATxenPZW945BNbD6aVcKkWKVJYlnvbeSxweoUGSQPVeTSHP+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(376002)(346002)(366004)(396003)(451199021)(6916009)(4326008)(41300700001)(316002)(478600001)(66556008)(8676002)(66476007)(66946007)(44832011)(38100700002)(83380400001)(186003)(2616005)(5660300002)(36756003)(86362001)(966005)(2906002)(6486002)(6666004)(6512007)(26005)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Jf4dCo290GGCtAsTj06154r3rQez8g2Xa7ARMfQDfbcG5uOXAHxOU3vKJgY?=
 =?us-ascii?Q?0QJ36dIjWrvgGYnp5zPHIXUb0lnEvz7WNidj4PFUJukoCDIC1NhxhnkuYtSm?=
 =?us-ascii?Q?jd3Z5LWqgAZu1GIAF1xuUB2b749NaUCtjCPajyD1yLZbTuC/lJnD8bC0tq8T?=
 =?us-ascii?Q?2BcxdwnDoJJ5FVlbYtmnL8Q/6OZoCRIdAGFPuXVw5s3RKVfmdwroW6ZEjy3y?=
 =?us-ascii?Q?vLT0IrjScHw7i4ZcVr/NvH5pVj/94xSkgmEQQM42sWAFSTg78JL0j1j8VRXN?=
 =?us-ascii?Q?WJW5QPB32Yivd3hOXccrpS/lizJPtoACeKS/1sLvd1XUVuqHgNO4glbcYb98?=
 =?us-ascii?Q?lvn3ek1/U1G0L859U7cRO9i4JV7smpRMpU6kGBlLnUguGfIIEQ/2tFd0Nxpn?=
 =?us-ascii?Q?kxE0h1DQTuwrJFT71E9M4B5d0JPbxgZzsxbcXEXUpZRapstu9nhcMXO9Tarv?=
 =?us-ascii?Q?HsSpDUZHvq7OzO1o6KXDi3EjDPyDk370iCTe4rucTFT09DicunPXJ7hJ/JP1?=
 =?us-ascii?Q?MtYUU9pRHUeABmLhMAftSyr/jfHY6cClEby+3/i0/LnvbdjeBy8hX2saI/A3?=
 =?us-ascii?Q?Bz4E3u6Dom/8IM/RFBK6WhDSJGRJv74C0F8PWUXF3FcPoUqExavELHOc2E+u?=
 =?us-ascii?Q?VNN4bOwTY3So7JPqvatWTTMt974J5m7mOrrKlQbSJWQ34946B/4K3TnAMOw8?=
 =?us-ascii?Q?+5YZ7PWXvUbiCfjy+/bg8EGjogaB1rZO3Owu9238+612QAgq/pAjX5GI/4Jq?=
 =?us-ascii?Q?/r+AZCXBPzgiKcVtxvaWuIZGWzOOeiTkgK8S0Claow87X45680L8JoncCTDC?=
 =?us-ascii?Q?2dBMer6F7qo30QlL+zq1gm0eeocw0c1oMVLd6w2Nj/UfWy0rFEVzAFA593rq?=
 =?us-ascii?Q?aQl3Qsj/5y15W6c87bvaUZ8IjGaW40sFsbYNx67PsRuj9bMBYO45HvsfCxuz?=
 =?us-ascii?Q?hPRTNIkwDw0exOfFVS6jTb7yTC/h6gT6RNGxDHxL+n3sK2/jo/QcguIpH3Hg?=
 =?us-ascii?Q?Bg/yY0qDUf+jhLXBtuOENsy9k+zzXk3Mgd9a+6y29HXIrJ0puRN5ah5tr3mv?=
 =?us-ascii?Q?E6GEBLBafs25pS9z4G6EHVNiePkoOjqZhZAMXgR1GP3UBufH+v0f2Fx4e/+m?=
 =?us-ascii?Q?bPQHYzuvXzVPJjwA9/ry8+J8cd2plH2uosKQ2EjFVQLiNhncCfZzWwAX4tSI?=
 =?us-ascii?Q?FPnZQ43wzNgPUuOM3jMVpIezhP0yvmN4ldnqpRQPHIt3+/SaiWF9oGZTQtfl?=
 =?us-ascii?Q?xXIUgb5/JDzkRBZmG6yBZ4pBH8dTEymBxD/nJBevGlF95Vfuq/yrzoFh/JA0?=
 =?us-ascii?Q?9L1tS0wojGN/KmP7LSfv3GVkDG0puqCT1PhL2FplJW49AhjgqECDtQ7gVHBT?=
 =?us-ascii?Q?zTkqiowfueKqwvrk6/RFyjRmr9UCP8H/g/qk8ROmqrVs0xD0sCGdxV7ByB0e?=
 =?us-ascii?Q?dSb2RGx4EDBXbxUIOk0MTvUeqx/vM7Xb9Dz5Q2Lkuj5X/9XXoIKH16WzH5q3?=
 =?us-ascii?Q?Sb6KOv3JkSO435i4o2a8D04eVsmKnRSfg9p6DLtWp0zZjOnCsJSU7VV8Hvse?=
 =?us-ascii?Q?LgVf3jxk13eTlPFXipyhuE2SIljIWfIHVv7WcM3NUjdB2499dnLkPt/+pGqj?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7331216f-6256-4271-aa38-08db30a3090b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 22:14:59.5469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8akvlL2IyN+Q1wgwdGIVcO+3vMak+lPKvr5Le+/Ez69NDYH213/TAnbH8w/Hw4z5Pp8KED3d5yCOUD2ipcNwe/S1iz3X2ngwAmg2yC8usI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3789
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 29, 2023 at 02:39:53PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > On Tue, Mar 28, 2023 at 11:36:17AM -0700, Dan Williams wrote:
> > > The find_cxl_root() helper is used to lookup root decoders and other CXL
> > > platform topology information for a given endpoint. It turns out that
> > > for RCDs it has never worked. The result of find_cxl_root(&cxlmd->dev)
> > > is always NULL for the RCH topology case because it expects to find a
> > > cxl_port at the host-bridge. RCH topologies only have the root cxl_port
> > > object with the host-bridge as a dport. While there are no reports of
> > > this being a problem to date, by inspection region enumeration should
> > > crash as a result of this problem, and it does in a local unit test for
> > > this scenario.
> > > 
> > > However, an observation that ever since:
> > > 
> > > commit f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> > > 
> > > ...all callers of find_cxl_root() occur after the memdev connection to
> > > the port topology has been established. That means that find_cxl_root()
> > > can be simplified to a walk of the endpoint port topology to the root.
> > > Switch to that arrangement which also fixes the RCD bug.
> > > 
> > > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> [..]
> > Is it expected that RCD's will fail when set to EFI_MEMORY_SP?  If
> > that's the case, then this (and the other patch) look safe and do not
> > produce regression.
> > 
> > Just want to capture this behavior, as it appears there may be other
> > issues related to RCH/RCD combinations.
> 
> After I posted this fix testing revealed the need for a few more fixes,
> now posted. Most importantly for accessing range register defined
> regions is this new fix:
> 
> http://lore.kernel.org/r/168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com

Are these patches on top of an unpushed cxl branch? I'm having a hard
time finding the base patch to apply these to.

Thanks for the help,
Gregory
