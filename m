Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B1FC77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Apr 2023 00:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjDTAwA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Apr 2023 20:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjDTAvm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Apr 2023 20:51:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C532901D
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 17:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW857wPHxpY1icg6wgJ4XK/uUO6M239NL5arj+CBHApJInW/fkgedQ5d6+xRfPfmcFa6P2AVmAD7gRHflpMnZj5IW4msJuptnDnBkqYOzNaREVp5xrcf/yL1jhZA7v8X0kxTLbgKKDSSk4VMQSXHo1c/Y9H/KwA/rA8QtslZe2ewDe6gOxgqcnoQBsJJoGMUWkXJrJyk/lT2lFRAgtimpnkFBDJ683O/P+SWmIjC2RLItGG7MERyyTkcCQcHJXqHUVPrLjqwi3X81wAo8LN1WRiZZvD5N5EvL4XxZsdYLj4NnZfzEoAYpIy4v462Z3zrsvKG6jUPmr66qS7Ntp0KjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OyE2tIEUhhyG2x+T6wgtp2CH66S+pyf+5zCkOdhxDE=;
 b=HHvGbgSo+lm2EEWugXXrmCfZeKlg9u482uPcy6317LLmg7M45RGFTNPRFr03+W/8KEwmqskGQAKlz9PnRABi9oDOYLU+33hUXVarAR3ZkrxD1iOG3TzAWEGL9XdTEC63CRFn2lcvT6ANyg4dryaotqB1qL1hpFVe0RK5DIQjsdiWZY2WFBTnAtiFFfgO37JVpaqQHxOCyFSYG7dPwTP1PktUQr8uVCC4kU866+EbvH0As9HgMTalXN7EjqtA0FnReWhCL1MfBXgZi4NyZAuxD8Wu5ILDWoe5+Lc8yTpioMj9ecUJqusMgpMOb3bRv1QT40oyRiS6O851qF84/GmFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OyE2tIEUhhyG2x+T6wgtp2CH66S+pyf+5zCkOdhxDE=;
 b=QhTzC45g4lcXPB+aPvDFjrX8/QLTDs+cDLQSSfdlT3m0vsjR1760m7ZjEa1IrKsqVgHm6ccMajheSMXcw/vFNrimBkFy+irnPY4YROnBbTaCAyE/pUNfdyfbo2MueOX8Bwwu99L37FWEw4TvqV1eYMB7vdB5q7bkvRIbU90JxZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6412.namprd17.prod.outlook.com (2603:10b6:8:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 00:50:24 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%7]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 00:50:23 +0000
Date:   Wed, 19 Apr 2023 20:50:12 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <ZECMRAEvfpvZiADT@memverge.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <ZCRhhUDcmypVKu0X@memverge.com>
 <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCRzh0VLSVF/7jya@memverge.com>
 <64252d214f0b_c7222942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCUPlnQYVRCumy2O@memverge.com>
 <ZDtz++B25suuoYoY@memverge.com>
 <643e2fed87bd3_556e2941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643e2fed87bd3_556e2941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca18eaa-804d-4e31-4442-08db41393943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rJ2VjClKSW282josd9fBFP8WR6RDLRSZ3FMe6RR2OfAuR+oS6zyEgPUeo6S8sxrIFk5AMaFARrT7AdnTJ60CKf2S89lb3GNxr/kXgojSCXSgdcxSBoLYeOSo74Fcfw4ILdz6m/dyL2MZ83K8HP5vcySRQIBKXF6DgwUu1STnmPM+sUIEp0cOFaE7xWsdqdBtnN+tExQcXXYwn2hRcn+jQly9kbD6/rn9QXmp9VFIqfs3a3bC7y6RpQtzL9P5wM6S6BYVJG5LnWoaN5Z7GB/FuSlQXJOibX8C3evw15ktj04WGDpwS37Ee4/6jNahSGZ1YK8F0d7G5zssT24GS3+41iLLoJp8qoi9XCtX6nWdpG7+DhigRmHxlkK/WFMx1gu0C7Ce2/3ppmV8QN40rVfFY+O8lrOINPd0xiTiWu0QwCJzv8qDO0iZkx3wpQud9weGF5//MpT6cHyFrDk75Gb2JYWsA6efgYYHdfGeH3yb/D7+z5ovGfduS3HcC99f0EdJ+/OSVpsUKQBC5ZAwaWD2aP/Nj5mkJRlO5PHvLJjmkM6Nab346OdY5xYc2lFiWRp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(366004)(39850400004)(451199021)(66946007)(66556008)(6916009)(2906002)(66476007)(86362001)(2616005)(4326008)(5660300002)(44832011)(8936002)(41300700001)(36756003)(478600001)(316002)(6486002)(6666004)(6512007)(26005)(186003)(6506007)(83380400001)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GBvdR6lwjNyVAtLbLgcqR6hbtk0tlbGeHQ3QkSNCPVgeoNdkIxjPtwvAFaa3?=
 =?us-ascii?Q?GR0TKhsdOoKMKWc5nG/IOOdqs+P0/Um++27HdHfLS9jxIXRA2GT3skl02tpP?=
 =?us-ascii?Q?eTDsA7Eq9U88H617ntSoWbwzOW2qlNvRPg8LY49EOUn/dkPlJ8NCSOONDdyW?=
 =?us-ascii?Q?zTGujO6x7UxZYF2dIt7UeVOU5XP3qdI6ZjtPQCnvkPX95qzFIyYWBu/8Bdlw?=
 =?us-ascii?Q?2eZVtXWvrzOeHJXAfiV3IjStso+Hc23VDqe1Mbkyn00OjQ+t2Lbtr5Fkyctq?=
 =?us-ascii?Q?5RlmIV0kssxYwcMi9Tk68V1UKFVd3s56eijqCYi724zz/IVAp81Gb6Fv2Xjm?=
 =?us-ascii?Q?RG+qgV053SfbU9Yc44qpByOhT1p37h5X5Navrf8ns7lPrN/8R3U+8lh9a5Qd?=
 =?us-ascii?Q?Wq/4qqSsU2AMjUllKQd9N+jUOj7hqUG62huVksFFmGh2HL1/adJ46mpzxSRU?=
 =?us-ascii?Q?YRsjOR4ZGtLyPEM+mj5GLxJXFQ7U95jV9l+ZnIvHPZvoTcF4Wa4N+GaoXfzj?=
 =?us-ascii?Q?sg7Y8Nm5iDCUvbhiAmHwiRG/DHyG8cDqzliIYQkYNVnLveFc0P1rFbDxpYOU?=
 =?us-ascii?Q?NQTQqvxCHwDU8ddpKCLkjNrIWtIbkNhC1lemFcQcsz119/CsRUAKET/zsAlC?=
 =?us-ascii?Q?+2myFg+zYvFV2rQ8Rt7fAKCywc/Mcg2Yp/ETdSIkYihpJIKM6k9IoHXFCLcF?=
 =?us-ascii?Q?wY3K6LB93fcECg0and6m8AFMctTgrV3ZbuNUSS9CsT0NiISCL5IF96ciEDbW?=
 =?us-ascii?Q?KDweQvW/e7eMStSg6QdJ3swckvkfidUEXhjkzcVLBsRQw27Yg0JodT/K5nBb?=
 =?us-ascii?Q?Q73TPaHIrlX03k01Lq3yTW7bJQEv1Hah4Fjy4qNb5LwynFuXwkHzmnlM4ytd?=
 =?us-ascii?Q?lfu0LEK61guIrHwBKH4HwcVRm+znjm9x0zy4j0fCH6a5hDfya3JovrlT99fp?=
 =?us-ascii?Q?uidWQTh15Zb/DDcM3OGcfDftZIj5TDSqojHJ60thmVbrcCsb+QzMyM1xmdQt?=
 =?us-ascii?Q?4Agm+XS3RbomXn04hajDblwyysIXA/YtW7pDwI5sMvFbdLZ0JGbpK6DP1Ejb?=
 =?us-ascii?Q?WbZtHbgi+aW4PVCiNiozTqHad+TZ1hU2fD6UM3vlMDTe/m5h9U9u+mROV+E3?=
 =?us-ascii?Q?b07Az4dYisVputOLlK32FXUJo7ltREdIDRGzYwLgk/X5UZL4lbeFFoLt/7f+?=
 =?us-ascii?Q?lsJiQ6u/756VFFwnViQSS8Gj1f0CrNOTFThIO5PhGCcvjsK/tjY2BP+p1rNF?=
 =?us-ascii?Q?TR0c6y08ET0OFDqePDp3xdReuGafeUB8BSvc2E0C+3al3IZWY5d4slgTxsaZ?=
 =?us-ascii?Q?5ImXF83VeoK9mLr+V25dmOC+chodkmIWAfrCtGodPh6CPO0j9gwF5xM19Oai?=
 =?us-ascii?Q?IF55ey80EKdlYf9ypROpJsvHh9CDmMFY6kxmGE3iCdROQaF01pqO4WHnDyTq?=
 =?us-ascii?Q?InX4f7QW4K8lGtwKPtbDH5tTAfdqr1iqGitMKF0Av/M6Yc+p6vj2uiyCaJbx?=
 =?us-ascii?Q?+46LOpqozNSNwe/8Cg2sSI2SkEFqW1/AMGTAu0sNco0v7RObs1PbGjiI2+w2?=
 =?us-ascii?Q?cjOg823+DAeUieezeMNkojWBC/yBatsa0zPDrIXHTzCKAY0ofhaCaFodn5lD?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca18eaa-804d-4e31-4442-08db41393943
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 00:50:23.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwpxWqHYz2pvP7FewqgukNy0aX+74Uhk6VRc80yF9n13uEnpGvU6sZhnP/l4BUDNol3OsljAfUd8NjpX2Tj6cPneBaApj905QUgIvGJbbKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6412
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Apr 17, 2023 at 10:51:41PM -0700, Dan Williams wrote:
> > DVSEC CXL Range 1 Size Low: 804
> > memory_info_valid == 0
> > memory_active == 0
> 
> Is this CXL_DVSEC_RANGE_SIZE_LOW(1) or literally "DVSEC CXL Range 1 Size
> Low" which Linux calls the offset CXL_DVSEC_RANGE_SIZE_LOW(0)? If its
> the former, it's valid for the second range to be disabled. Linux stack
> should have failed cxl_await_media_ready() otherwise if this is
> referring to CXL_DVSEC_RANGE_SIZE_LOW(0).
>

disregard, i was looking at size_low(0) but i misread the output, the
real value was 804b, so the lower 2 bits were set (which is what is
expected).

> > All this considered:  It's still head-scratching why shifting the HPA
> > read from the range register successfully produces a "working device",
> > but I suppose that's the definition of "undefined behavior" :]
> 
> The needs the platform vendor to weigh in, but that may not be possible
> if this is evaluation hardware.

Mostly i'm scratching my head at the fact that the device is programmed
with base:0x0 size:2gb where the HPA is almost certainly not 0.  I
originally attempted to set the value of the register to the expected
HPA and that caused what i presume was a machine check (haven't
investigated further yet).

What's confusing about this is one assumes that the CPU puts the HPA on
the bus (0x1080000000 in this case) but the base register has 0x0 -
which should produce a failure.  Instead it works.

Just a real head-scratcher, but i'm going to close this as "hardware's
jacked" at this point.
