Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D584C54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 15:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjAMPuF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjAMPtn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 10:49:43 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58667BCE9
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 07:42:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+4wgjC1Jyf6Yje1TpiPFRXZZOEJ2bCr5HZa9/9X2bqkqNOHjOV7TuiRoyV2d/URVtblFuQWOx4t5W2Xhi2sKh0TGr1tMC6tiRWfEu5FL1DzQf1I7N34DGJPh4ZOT445KKS9U64y5j3WiWAGwASxOxjdJ/ICWB06ne4Zv4CR5fBMh5JhvRpxKjnFR5srXuw0S1GiJOIGTNaRUQs78nPkKH+KvxST0aRffMyhBAGOSfyD5nXfo/2l8G4+K6Xn7VoY8OaHL6jCF0GIXYfap68Rfgo8a8Ng8U3NksqzGVykELDcQUuXP9I6fw8ToieMN3tiNIgArNPU15T09pIpGCp0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYD4yM2tWfSpoZPmtGflIoMimlcdW2U5QHskEptCvKk=;
 b=Av98Olu58wKL5zHqsPntWpSlG5SElXqqfnXiINq24airTvxRM/DeY1nJqULcuOSPL0jr7bLma01jt2UVk1uysWpfNqNz5gevyR1TT6UlYDYSFau4wmQtVaRIaY+6/wtW0/xHXjRUG/vr9eT6UiJNyWIMUVXGV+o0lirznWri+Nh12wxHq1M2KCt6N1RULYbp2OItZrfwz+13vlOY8wPgptQ86hardtkkTH7VwEMYfv/gDaXNOPsNPH5Ff2XiLsm6NklzeypHRsPKXHkcJrdKztgh1EUImM2FV7FUjacOdAO5m3mZG+yF4W69nfLwjQuAuqwqFyvB9XJWZzx+BTUsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYD4yM2tWfSpoZPmtGflIoMimlcdW2U5QHskEptCvKk=;
 b=v1jeKR6fZiZD28i342ZVSKmJe3Q37dQg5exf7IHnOrQyI+zwy3GoKu5Os0jVPFOgqo6+uwOY2zTlfGJfIiF4jt99w+hUPo0M1TSA/sW9zEt0tU4LMgXueT9eShMuEIh/ygOThdtMJ/UiVWKc0NYHYqfkVqo/TAqyW04W+wcy3eU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by IA0PR17MB6419.namprd17.prod.outlook.com (2603:10b6:208:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 15:42:15 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 15:42:14 +0000
Date:   Fri, 13 Jan 2023 10:42:12 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <Y8F71NmRNQgyvdZ1@memverge.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <Y8AppXP+eP9cEz+i@memverge.com>
 <20230112172130.0000391b@Huawei.com>
 <Y8CNw/fZT5fZJZcK@memverge.com>
 <20230113091213.00002146@Huawei.com>
 <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113151206.GA20583@wunner.de>
X-ClientProxiedBy: MN2PR10CA0033.namprd10.prod.outlook.com
 (2603:10b6:208:120::46) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|IA0PR17MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fe7ddd-e3cd-4db2-54d7-08daf57cbe88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peHwcpfuSCmKE6384DhOysdvXHoMgzL6E+ueJx+5foK8Db4UuCx4HxnnWVvpC+6i/qw9c7GYC7P8invasVF5gvz6pDj9d0jokMG6WMGf4xOvS3R2JDGJXj+TyDPd8lXEAODm8SDY6T2gJU1RHAolUkhfNlrjVNJcuXYpO3LAX1vLrqzrdV1HVIhQU3hYyoyzZGvbibUgcNXZyVOhdr6cwuVVycs7SF/G3w73ivC46KC2PX5Mk51wcWSMytADraCeA+okCTjkVxYYiwPKRyxCQBvPSBjROSUIQ+nrhlJY8CDu/wm4G5LFA1HObfMWJooLDRh8S6jlON8gMDSQ6D/EBX352mvG3LimrClI2DePyr6A/8lvuO/ZYRIEbOEjX3U5k0gTQZqavYH8fD0v2/k/pNbpZiUMnsDlgFClWQFtKfumlT2iW3swb21WclqtydJaqrRBGYooXm9YW2kDZksNvrfPo64RqPRsL2eAjTv2wib3mrowgujQzWVLWLwK2SOYkeO9J2SFTMybsamEohfcPOGBpq2ZBazw63XVbRE0Wg8YmUDspqxWxoC25fTi8EL9PVhXA+1iTabBXRDUGrbym8G4bSwWw0l41ztuPqEx6mtM29JlgS1xeAYx3OX+jcbtXuBFW0dv8Yq4eJrCcW3p1Qvs60SWosWE77Ycq4oOqvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39840400004)(346002)(376002)(451199015)(4001150100001)(2906002)(6506007)(966005)(6486002)(6512007)(26005)(478600001)(186003)(8676002)(66946007)(2616005)(36756003)(316002)(66556008)(66476007)(6916009)(54906003)(4326008)(41300700001)(38100700002)(44832011)(86362001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9yiKg+URp86wTzWYfEkGgPgLq3s3uEXHJhqh1oe5T1kF9nwzxQn89kVCNEur?=
 =?us-ascii?Q?oUljiSLTDPCOcpyCNueK50/lfj64wND2XzW2DMrAnkmwncHixVmWq/+OyLlA?=
 =?us-ascii?Q?htwe6M9Bj+tBIW8s2PPcAP9g0RW2tlnrbV5N/Hx7HPhyBa8ohmyy8yxdSJ+d?=
 =?us-ascii?Q?YSxvbD5ArwRLBePr3RW5yuTACyoy4U9J0yxZUeAXsxko9HO6BpdzJFmSoEPh?=
 =?us-ascii?Q?tOpyBXL1vdjrmSjSZMjfbulAA1U648TYx+EsLWfHIZTHYRDIlATvIIbx7gXo?=
 =?us-ascii?Q?4ZbQkfKeFQ45YYOoIHzDAD/1eKg9Zn+u/e2CVnd85YBMsRSGfLpYIAP4xMxO?=
 =?us-ascii?Q?Y3Bl46TIO8B7ps+7YORflvrzk+pHQgcdYEuuEL5uXjFBW+a1Jc7r728cFmNu?=
 =?us-ascii?Q?XoQXWaQjBVaPeA6qyIpvePhf1gtn/zruw0Am+UizXq0+k3FQLnMc71+JNJIy?=
 =?us-ascii?Q?k+DK8DG2GXvhxKD8A8amhRoVqK+6tm/L67Tj+ZAjVXYJbW+/MKahwCnG65xc?=
 =?us-ascii?Q?STviZ3GfILukdiSZXnll7bbNitQxcCobIuRt1HsMGPE05EZB/1vl2p7cYwB5?=
 =?us-ascii?Q?j3pxGvxcYZIVisMVVfxIFMTDhM0GaXJHJEo6JWK8X96FLYWm3MMo0M6l2GKq?=
 =?us-ascii?Q?6KQzuaTTWFuMI77TmvlZHGyFs2yKa1nHge/3n5AoyL7z9ge2AVE2ofqUo4Yv?=
 =?us-ascii?Q?kMUfkWyi8YE04+7Ed8c000CjEkhKEmpT14XYFEX91OhR71lDSX0KSAsU2SUz?=
 =?us-ascii?Q?4Mw8vyiy+HAr1I9BR3fn4TQu1qs/KSB1GRr3r5kCECAWMarqOiS3kSzJco0D?=
 =?us-ascii?Q?Khf0Iv8TOC8dSDgVi7k7+QTy9TOsg6/pImJfBSq9gh26Ay44Sx6q3530gOj2?=
 =?us-ascii?Q?LDBJsAiEGWLDjDm6PIPBlwH/TkKS11nochOtsIQQW7kYBWNPvXh0rbarNR+P?=
 =?us-ascii?Q?u1Uq44WHOwETaMwHs2HaK7aH4tjV56YG/EQuH+ev7h78OhhPbyoI1gvvbMSw?=
 =?us-ascii?Q?zcH/ZZ3VDY6WhaB1XqP5r8uczblQwCgI8mMfcde4g0j2FHWpYjdGn2KYR4Nd?=
 =?us-ascii?Q?hqzNxFDo7PkBZgmlmLbC1iX+ckkkHbKouG1XTYT/e4KXa01ccu9LTDnWJ4od?=
 =?us-ascii?Q?LmZFziaF0MRVpwzhpBUTx9HpAF2OP/OcObsVIXSDguhJRdaK9bvZkpc8zX4v?=
 =?us-ascii?Q?FSOBV1zMiXXdOhiTW0GJuxhhQgjPhW/qBUlKsP7Axn1XYH49KAZHDtzFyZIu?=
 =?us-ascii?Q?cto8+1T8EuBw1zoKLaxbPbqhxCOZ/jV1ZtkuAoL/OHM5NYZn5QBocrEnX3Mt?=
 =?us-ascii?Q?w1p4aCtr462Y/L9U2A/geuWWDyjAF9QdWbelFpE4lc2VauVDZenorsqCWjBz?=
 =?us-ascii?Q?1nOa/zG0aRRFyoY7Ik0t9HJz30a0c14hc7euTsKxiLbLZ2kexHGIr/+mdf9+?=
 =?us-ascii?Q?j+palCtxgkFzS7xskZok55O9bUG45pi/ja47hxXf1WK95/B0Y/pdfnEsbYkN?=
 =?us-ascii?Q?Ebl604shdvRwe0Ie6N9kqos7ksW+tDdhXwhYa3RV1hXM8MY9GltaTIwdKxWs?=
 =?us-ascii?Q?pvUiiUVNZwNrrYFVDbDnQ7+6L1DbJRBrnoXkbXvlQvY8POpDdePMsRLOpwO6?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fe7ddd-e3cd-4db2-54d7-08daf57cbe88
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:42:14.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GCcAdrl8Kv66IE+kplK/xu2cUsGKmWCoF1dY2+4mhrvJYkkqJUIbYIVOTPlBW8iqJm+Q0R/g1Obt/9jGYKgCqfEL2lv6sMUitP5Xy2PCkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR17MB6419
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 13, 2023 at 04:12:06PM +0100, Lukas Wunner wrote:
> On Fri, Jan 13, 2023 at 02:45:11PM +0000, Jonathan Cameron wrote:
> > On Fri, 13 Jan 2023 14:40:26 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > On Fri, 13 Jan 2023 09:19:59 -0500 Gregory Price <gregory.price@memverge.com> wrote:
> > > > On Fri, Jan 13, 2023 at 09:12:13AM +0000, Jonathan Cameron wrote:  
> > > > > Just to check, are these different from the on stack problem you reported
> > > > > previously?  Doesn't look like the fix for that has made it upstream yet.
> > > > > 
> > > > > What kernel are you running?
> > > > 
> > > > The prior issue I saw was related to the CXL Fixed Memory Window having
> > > > an e820 region registered during machine initialization.  That fix is
> > > > upstream.
> > > > 
> > > > On 2023-1-11 branch it is commit 2486dd045794d65598fbca9fd1224c27b9732dce
> > > > 
> > > > This one appears when registering any kind of type-3 device, during
> > > > boot.  
> > > 
> > > I meant this one
> > > 
> > > https://lore.kernel.org/all/20221118000524.1477383-1-ira.weiny@intel.com/
> > > 
> > > Sorry, should have dug out a link in earlier reply and save a round trip.
> > 
> > Ah I'd forgotten we were going round the houses somewhat on the right fix...
> > https://lore.kernel.org/all/20221128040338.1936529-3-ira.weiny@intel.com/
> > was another proposal and Lukas had yet another.
> > https://lore.kernel.org/all/cover.1669608950.git.lukas@wunner.de/
> 
> I'll respin those fixes shortly, together with the other DOE patches
> I've accumulated on my development branch for DOE+SPDM:
> 
> https://github.com/l1k/linux/commits/doe
> 
> Ira kindly tested them this week and reports that they don't regress
> CDAT retrieval for him.
> 
> Thanks,
> 
> Lukas

I'll see if I can't get this branch installed and test if this fixes the
issue i'm seeing.  It may take me a bit to get back to.

Thank you!
