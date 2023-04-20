Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C065BC6FD18
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Apr 2023 01:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjDTBaG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Apr 2023 21:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjDTBaE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Apr 2023 21:30:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2119B5
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 18:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YswUZeTYk8nnF7oY2QslITtGS+FHfs4jjtl1kKvotFda1ajti1m0kOpbaNcMen4Ifa8UCEDkv3tl8hKL+FsMXw/hy/Uq2q3S720N6aZh5RW5t4KvDJppUGndNpc2v4VTne9hwm1dr9CGvcukem3d7IvOxYUof7oIp+97luuCS53o4D/35AR2a36u1gViE9pZ07UtlqvM27MorXdSdDxkaeDbd/pBgL9Xy+84CW0dO6Sbomcms1fC1W3Y0BFi0SSG6PHN2ZsaNbAKsWAnTHOZbln2Vht8P13gp3FFKJf8/dg/2YSQWX2ub3/m4yOWxXH+uQ7YcBFnfAwBcKigduNcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peYhvUI8J2PrWIm51wyLYNQs32NQGlFQ8yQFnvGjkeY=;
 b=LTGrK6SG28Q1miywWO4wExB7hYgz6tj8FdH41YgLyginXKj5nmFXOr9Sluaa+i+D+idLXhTCgbpRMYMGEcMuqglcPKftZCujRoTcy6E7MwSnbURpgaZVcniirB/l8/fuC0kR9NeQVaaDiADLqk0Dw/g95+/Sie3Url5rFt29pyz5yiR1F9qFhMzsYhJU08hh4pR10jSa060DONXw8p9adDCT1I+ZydONeyIiUvxyE1mUU92QV9yanOqUJ8BiQ6Bml5wR48h3fvYvP2Xxp4QAXZQdj7ey48FMeYzTxX8AxVA+nBjK6nTi+W+hZINAIuJ37tYmn4Qat4LwFgrAbrRFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peYhvUI8J2PrWIm51wyLYNQs32NQGlFQ8yQFnvGjkeY=;
 b=x/d39y4ZA+wRX5+X2cdUL6H9NouD9nhwMeSdhRKbTjY/+RGZpBY+x2UrRGXc1J4yzY6Qrny743DKh89sj6TmPsFUd1RedST3kTQt2T5/6+cbxkwUQYe+gEqkQfIsFTn6F7+RKv6Uv1rhXqbeq2pet9i2wpQ9xm7v3o9FiRLxKGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6719.namprd17.prod.outlook.com (2603:10b6:208:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Thu, 20 Apr
 2023 01:29:58 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%7]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 01:29:58 +0000
Date:   Wed, 19 Apr 2023 21:29:51 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [BUG] DAX access of Memory Expander on RCH topology fires BUG on
 page_table_check
Message-ID: <ZECVjxh/Xgwa4Tpi@memverge.com>
References: <ZDb71ZXGtzz0ttQT@memverge.com>
 <643e3a2344460_556e294a2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643e3a2344460_556e294a2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MN2PR19CA0060.namprd19.prod.outlook.com
 (2603:10b6:208:19b::37) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e721946-11c3-436a-ac30-08db413ec0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qL/PX9kjoq52k4F5WuM2cA+vw9gbyttB2IwpULF8/4FrMDjV7zi9NG6aBC/dyeGzDjcRRBUcAgMW9mabiuS6ShozY5dj6Qu4oKProFYdBprcrb4zH0UuqJA9DzcrttfpbaFLpXM3CTOwIXg1/5FTheu6QMhHZfhBhsfrtTglAS+HtmHQ3Rb65F5F0ONhpeaastrDHD0GMdmsuxouvuIFhzusDdz/7+t5R1RUJNMyEgC1RRoDQnoX5OH564neXoKbs265qP1V/k1tiGZBTH0Uo1v3P/bjIJN/pFNiS3Xh1oWPvJrE+g4wLhkAEhqV26SDTHSBD6bSRH3FMfmMrir9ljQ0/AFALJsaL8Q9lvGV8JXvkcrolmHjKa91tp0qfpObhs4Y0d9fp79ucLpA6tKPOQH5vjRGhdbV7EtUVWqPBR6EhIKJJJ+bm1+K14T+Fpj/Sj5Ik25MEdVeGLkixVWapU3IAMveU15cu3nEruvzaJdHMOy5HKnO0Ag3FAVarKugzqIaQPQepXzvuLTwyKUuALqd+KRhHDRD0sJE0o7TgZZ+ctA8a7fZi5kWxyGoD4MQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39850400004)(451199021)(6916009)(316002)(66556008)(66476007)(66946007)(4326008)(36756003)(186003)(6506007)(6512007)(26005)(38100700002)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(6666004)(8936002)(478600001)(6486002)(86362001)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xd+vz7dCNg2OaOKNSMxNmX0dnbAc0kE4i+1O6jiwTBReIyHOgBoIT0kA7Eay?=
 =?us-ascii?Q?YN2YcYcso/aJc+jHXXDjbAMC9r4yOvKtpHKbfJzrq4s4NqH1/jHWKQ/KTsS/?=
 =?us-ascii?Q?fxnBuD7n3GVFadnOejmK3Ni+xoXkQEpKjhwOP6jauLw2skfLkQSHs+mfYf/f?=
 =?us-ascii?Q?tBXWcs3OSAwRfH7QuyyxlHMjfX7TVhhfl5SkPlbrAJiyCcBVVnz2omc981P8?=
 =?us-ascii?Q?P56emNKrbikAEqGW9b2TaSDv6juhL9YFsjN09prIJkH+0gzoKlXnjMSzI56C?=
 =?us-ascii?Q?fjGgvlCKFX4b2xiPimSuy2/z1lThTvMivH4tbOfXZz4xHriy2ciFE0KK31eq?=
 =?us-ascii?Q?OoR73B64Dgqn7LStTfw+aIRW9AEHFrcnISQcm9xhp1oKXSQFx7w+OinsVRSg?=
 =?us-ascii?Q?KU73Wx0gS3vHGVUKTxA4X4y5nNosCvXOJzeglXL0JMyx8HvpBKF7tpNTc2kr?=
 =?us-ascii?Q?HmZc7ptR/9CehMXlJiTTQ9v+rM3cRf2kS4iCVybE5UVhZ2HtqtMAjoHSjzuv?=
 =?us-ascii?Q?NjPotqoXdXkGvc1PIAFhWN0cMwUgFsAILiBzzoOWSt0wTJQnXe6keozP+Ctm?=
 =?us-ascii?Q?1NTd9Qo3POniDnDGpyxq5YLMiqen/YsRnac4f7Vy97HnnfTUeB5FBP5JHwut?=
 =?us-ascii?Q?Khx63hNzFfxsnYFscOZunXHhiVH83scLtObIWrVpMtEVwKdyAIqADZQojxMJ?=
 =?us-ascii?Q?ZE9OwWIwIrY408UVhKvcsy0PeWNjqj8sFZRvIf4IwqvKkGX50g9K+/0iYGYr?=
 =?us-ascii?Q?RnicxgwGd2JrQgE+jaG21YKp82RKjJIpR4UVPt+ThEoMagtROyXHgg3UbJtK?=
 =?us-ascii?Q?A5UqnT+esVu0i7jMNjCgK98WQH+NTViVCm8SNKcaumQGicPW58WmC1HrfcVP?=
 =?us-ascii?Q?N8KLIfKhFoi1Mv19phkxn+sbPuYWyBLxMpXLc2Rk3k+5wqYwQQ55KpODS6Dg?=
 =?us-ascii?Q?7a26pwnrajGRUabYQSXlPwQKaG7p4nvFjMsWd/n56rPeSJjSopqIjPhgXmFi?=
 =?us-ascii?Q?HN1ROPwXn7miJJeG6hficgfnWrnuUteYCbLZzLsTK6joNu7cGh3qIK4Kc+sD?=
 =?us-ascii?Q?5PZ3xbitQ+Pam+GA7jOKkqIvvVBBjxV57zMqhtoelCBnDf3DcC9mqx+4caf6?=
 =?us-ascii?Q?K+UUEzRR2YlBuaDh/HUS0oK9Aw6DPTKat4L94WjbojtSwk2qW4Yw9haOZWPq?=
 =?us-ascii?Q?o4R4HJ5UefxEIOwnJPMRZmCHq21reeuv4gEiGg46BmffGrLzH2N4mKsNdz3T?=
 =?us-ascii?Q?ScrTDMYFBFse5xBaiG53sEfEJSLmmIdiTXfWsibXAL4z420oikZjpzI1LFpj?=
 =?us-ascii?Q?KOmwHFtEUl5MQxY3LfLEibURCIXXT9U1ydeXjb/qg02PYCyoh78w6zLyOUaw?=
 =?us-ascii?Q?ggGKvjOCHrAKyZdTdlbVrHCcFNjHBk1Ab/ifxH28+utK9W4hDO0c5rxAh/Wn?=
 =?us-ascii?Q?Xk2icHz1K+XeIGcEvPoTs0Y+jef4iMiWSdou5MhOQF5pZFlM9dRvHOvqePVJ?=
 =?us-ascii?Q?g3fy3ZFXnLHv6SxGq4WIIQjxzkscZYc9nQVWHFL7o7mqFM8jWpQkuiZnz/QV?=
 =?us-ascii?Q?KuWSsf3xcLR4BpuyvJ6kbQL2YY42PZ9U6CBogboHcD66sJvh2jN480IYI+1e?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e721946-11c3-436a-ac30-08db413ec0e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 01:29:58.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIoi50x7LrO+snlRNPQP9KAB8DJu6Iq7RPJXjCsRqsKdTJ6+QhWZ7eSO+04/LMY6lIztF4cS+/3s+wEOIpAJVlKCTx27nmCVVNV87fMCUIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6719
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Apr 17, 2023 at 11:35:15PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > Now map and access the memory via /dev/dax0.0  (test program attached)
> > 
> > [ 1028.430734] kernel BUG at mm/page_table_check.c:53!
> 
> I have never tested DAX with CONFIG_PAGE_TABLE_CHECK=y, so would need to
> dig in further here. A quick test passes the unit tests, but the unit
> tests don't have this, "map dax after system-ram" scenario. Just for
> completenees, does it behave without that debug option enabled?
> 

Confirmed passes without issues when this debug option is disabled.
Also confirmed on production hardware with a release build where this
check is disabled.

So something is up with page table check code and going numa to dax.

> 
> i.e. just touching the memory fails, no need to mlock it? This smells
> more like the CONFIG_PAGE_TABLE_CHECK machinery is getting confused, but
> I would have expected its metadata to be reset by the dax device
> reconfiguration.

Yes, just touching is faults, without mlocking it.

I dug in and the page_ext for the page is NULL, which is what causes the
BUG().  I don't know the subsystem well enough to know why converting to
dax would cause the page_ext to be NULL.

The reason why this got convoluted with the other hardware/firmware/bios
issues is that I was thinking the alignment issue with memory blocks may
have been part of the issue, but clearly that's not the case.

~Gregory
