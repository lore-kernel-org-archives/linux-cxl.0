Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017CDC05027
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 15:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjBBPot (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjBBPos (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 10:44:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93AB7B425
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 07:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRYxfWZ4aKCoeGd9oe2hgOB+AZRxffiTCWxVni4DWVrukee5z6fsdpB9JaCDASIPmC6wkaNK/Pw0z9CwDqtbb93zYP7/IPZEbGepevkxNc5B8viriz6G9eeWCGiVSIyebp11L/MZgkXYICZYOFi0VkeFHr6HdeXiiIqEPFKi/mZT6c9DGYSY4aL57r/TiGUkDjwZkwj1AjJSVuoEIUPh9rnSXuHj5hB5BjFKSTA6iY/0cgepxR7kyoSQeVFAUsliIF5nDX4ttHeOZh/D2a3u81psLuPb1HbwJ7wePkblyRjoO1uyCUO5F/Hl3P3prf1oEhYSGchGSHQpf8YMKgLVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqTsCyORWPsUFMxzJxjegIW9Y2cLwrLiV3xE3jWPzjY=;
 b=H9P5RqfNWTC/nj9AV7czlkpYC59mTLxVSagqiYWK/oJ4PbuaHf/2krNvA9VyB7HANWOqL+z5rM/FyW3HM8gZVYW2y2ajgrfpLAdSzH14ca4PCV1YsA52RAOKRwOQKp4x94djBF2+g9H3+wJcwUWUOV5zZoMxgcnZAdwlgjuq4FmKLNz0NDM88j0vS1xTTmKQuD85STfu56SJy51Py4J2pzHnxie72vCXS5yWccv36mM56A7XKp1DlMHnNbLRb6GBI/lRkTGODPDOmcJvupue4skhfgaJKCk5EBiW7gZsMbedqvYZxMzhcB1QftijFN7OzeMnAcDhyN4Pj+4k5dBRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqTsCyORWPsUFMxzJxjegIW9Y2cLwrLiV3xE3jWPzjY=;
 b=voKsC2/GYTZ7h5TL0C8o5+o6IE6RgUD/i7gUPXEGbsk2cvL+rTToPYM72PbQJKWNH0CXG4qWQIkXHo2zks6gYaDyBY+ZuRbmGsA5HiaeGio1paKhRwmSlkSHd4bECEuszF9AtSNbV9DvilzwfKhP6FOoKlS+gky79y39KuwpGFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB4726.namprd17.prod.outlook.com (2603:10b6:a03:377::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 15:43:35 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 15:43:35 +0000
Date:   Wed, 1 Feb 2023 16:16:34 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Fan Ni <fan.ni@samsung.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9rWskfaz9dLoW+l@memverge.com>
References: <Y9h2VhGuraZfEJfD@memverge.com>
 <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
 <Y9ll5S3Y4BZkakNn@memverge.com>
 <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
 <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
 <Y9meWfDiCGbca4nP@memverge.com>
 <Y9mhe2xPGRE1/7cC@memverge.com>
 <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
 <20230131235003.GA336751@bgt-140510-bm03>
 <Y9n4zjtwf+w6xnmW@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9n4zjtwf+w6xnmW@memverge.com>
X-ClientProxiedBy: BL1PR13CA0345.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::20) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB4726:EE_
X-MS-Office365-Filtering-Correlation-Id: cb36fb55-16f7-4063-03aa-08db05343ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iujrgy0N+GFsA0w1BfWJq8aA3lH07Urw6ygvAL7WIJXTVBUc393J0/PFZ9MLFvNP13/mpeYOLWhqfYUsjouhy1IpX7p5aLlNUB9m95JyyCO0Dlys05MN+DqxXRZN6N2upLrOE4ax1LWYD3R4IpQ68qF8TTBRX33MHmunGqp+AMZndRjYioEdSvjniAKQxISS3Hdl1NSUvck+lQPq1nhaXg9V8i4Tq3ycR01iGX2bmneccd4twqMzZcEC+ySsV7U4vO4bXOkk9N6JSDa5r+7/ulRUUhFVFzr3m6U8CWA1UmxVPKZzWVXPgbnsCDrsQXGsezKigOTuRZUsQcyPgzYYPvvPs3Kqw6aJDUdAJSwovqot+k7t4Mc7i6fcC6FDwu/YcjX33TAhLTRV1R0WwXEtxn25Kcs/ua04MD8vzmt/CEoq8pRf6RHSzKtOnpQVb+n5oFmTpE8lNV1NamyDZsZaR/OITmX1gXnwPN+E+79p5DfFUYItvNYWUjqiNoS3S7zyEInXgk36rD44JviwUXjrKuDohsTPhxnRXhl3IHabbmlJV1AkHPunhqdkuLOY6+5rmv94mzZYho9GnMiWnRYWJ7j6oavAd7z6w/YUQVfsq4lfzd+ZlSVb/GSNFioLLJtLE6Fr6N/1A1e9IupLzmaASyaRq1wF5lqYWipg+VSPQAsSvuSBIozTzgidI1EpRnAg0Fj2be4xVaeYLlfNWXXGEvbZuTy8kvE4UMA4YzR1KcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39840400004)(366004)(396003)(376002)(451199018)(38100700002)(86362001)(36756003)(2906002)(54906003)(186003)(6486002)(478600001)(966005)(4326008)(5660300002)(41300700001)(8936002)(44832011)(66556008)(316002)(6916009)(8676002)(83380400001)(66946007)(6512007)(66476007)(26005)(6506007)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vQjeyDDnRQKnSmhEgIi+08I6cbl3/9g3NtPpkT6IHlPUJVed0r8i8ciBwTXL?=
 =?us-ascii?Q?19PEucroBTiHHUyqf54wEkRErB4QwE4iMWuu9vJfzGl0jByc8rVn/SkZIQKT?=
 =?us-ascii?Q?ZG0yUWD21k4sKWRdthhqJHDzHkygCRcU4N1cBv20Tnwl8NiAFbRqnYBa3+IO?=
 =?us-ascii?Q?FdVTxMhbl+xe5lB5fQD+ZLF67F+6Mv0BpHnl8sCU/mzWna1mAnBaSOeZT5nf?=
 =?us-ascii?Q?vubfCpkwUABxQnRHIrLMrEgXZN0MbBqdnbLfx+8sARwQjaXYFJLKU7e+Vl9n?=
 =?us-ascii?Q?UmPtT9lexGlWOaRgN7aJ18IclC1N2O8lWQI6Xr+hT7BN5eOlk1CAlAhGCqt2?=
 =?us-ascii?Q?0iC0QrjbukdUkhYX+C4zgJ+CSjQ4psHuMpTIFMuiPrYftPs+7XOoyGcpuMqq?=
 =?us-ascii?Q?4Gmx3PH6ZVaya2iQcrd4sdQ2Ks8+1nGV+FLUjPtybIJNwzmqfI4S5ZfaVSqA?=
 =?us-ascii?Q?Mwi0Ak63wwWb+OIungbYbNYeVlln+++c5ea3AYnirV43akPHSN/EDtoJ9g3Y?=
 =?us-ascii?Q?edp6QlLvgRxgPdHa495WaJHtwUBabuih3zyEX402wsg3LbwhZLiS3TPJ0+cJ?=
 =?us-ascii?Q?ReO7T5zi4PSf9PcKk6Zb0PXjLLev+pZEfA6w21I/G8uId0nMLanakf/pLW/R?=
 =?us-ascii?Q?RiYfwhKmFY6j1Iq0ioepVD6pfh6Jme8x+Lo64pfYfCNVbFbFiKvT37eF5rcn?=
 =?us-ascii?Q?ppavh8p5wensGtkZtY+hVHNnIPDJznuSdRnYNghV7YR6XCbLJt5yo/ErGW8Y?=
 =?us-ascii?Q?B7wnoOpkq0jTdBb4usWV2pXQ/ixoXazFV4akZJ/zsvmzUpBhuKVysq2lDzX5?=
 =?us-ascii?Q?w/0Pik7TxvgNwmXr4iOFcAhBxOrAItB2wltwVn3zY++ITlahpxv0RnmdWI2w?=
 =?us-ascii?Q?ROf3AlBU4H/aaVBpoT+puk+7+fpsyjkn9TyLHOCUViYHdZf1RWASu5XgOfzF?=
 =?us-ascii?Q?UvvPFkiVSJ32xnnIqE8AYRQNdYp7XBGbJKlZL3Kn1rKtXik35g4WTsr6LWZa?=
 =?us-ascii?Q?uQNRnRQjKRZ/LXt+F3cY2MxTEJgoJbG66U14AyeESor9Zq4KbU3nrs9CpTlZ?=
 =?us-ascii?Q?EOX7hxIdKKa/H+iSQdagbVxG8076qhZRfA4+bY/kO9Vb5wmPw4lxUt1u0+g3?=
 =?us-ascii?Q?nQxnxGnKgMHcUuZlDf93ObNRuiCGxxoT0408OJYANVZn88JOWOrP202gY0or?=
 =?us-ascii?Q?d9vWmGgNEsBF/hnRZvMKB4o27AgoQCLr08wVdA05qvklBRfHDSpE7Xxq91Fn?=
 =?us-ascii?Q?JEaWWq2jny1c3fA0sdQCPyo6PJN3CGcLtqJj26dZwhKnnHdpZ77LfOKcyV1L?=
 =?us-ascii?Q?bQSbgFyZJkC1sfbXCTLNLpPQD9NESF91I0SG5qmZVsnzygBJH0xRr4E60GAK?=
 =?us-ascii?Q?ZNXld+mxzVK1HVtoPhK7u2lO0VvFXdL0jWSvrtGtcHuQX+hruKvVjHiWVnLx?=
 =?us-ascii?Q?xjJ/Xs7zDmojY4Wz6fkvv7JGfLuC33t27naC3OgXSwSRIgegVYOtXq2JHvmm?=
 =?us-ascii?Q?OksAul0gRUe3HvYMO8lO4bjDWZWnD7Lw4XcjLG2c4wCidFDPqVd1JkR3/e2o?=
 =?us-ascii?Q?8t9tKYQF01d5jN9OX/LK7cXHQklJt4stcYU3zIuygLteb3DIUE9Be6N17P0p?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb36fb55-16f7-4063-03aa-08db05343ea3
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 15:43:35.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo1dE1HHcPpbRTaBHP3VmWxBkr4WIA+Ada+iRilZEEPQVxr79L+aArsbpJ/I/N4seuV8bPmuwaBmPmhK9CUlVnWNrgakwFaV0+aUbEvxThg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4726
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Feb 01, 2023 at 12:29:50AM -0500, Gregory Price wrote:
> > Are you using single root port configuration? If yes, the following
> > patch should have fixed the issue,
> > https://lore.kernel.org/linux-cxl/20221215170909.2650271-1-fan.ni@samsung.com/
> > 
> > > [   97.476231] RSP: 0018:ffffa30000d23d20 EFLAGS: 00010292                    
> 
> I did not have this patch.  This should definitely make its way up.
> 
> ~Gregory


This fixed up the stack trace for me, but memregion is still failing to
successfully complete.

It looks like configuration and decoder commit completes, but then
cxl-cli bails out because writing

echo region0 > /sys/bus/cxl/drivers/cxl_region/bind

results in "Failed to synchronize CPU cache state"

I presume this is because of either a logic error or because the memory
just isn't actually hooked up yet, but this is the relevant code:


static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
{
  if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
    return 0;

  if (!cpu_cache_has_invalidate_memregion()) {
    if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
      dev_warn_once(
        &cxlr->dev,
        "Bypassing cpu_cache_invalidate_memregion() for testing!\n");
      clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
      return 0;
    } else {
      dev_err(&cxlr->dev,
        "Failed to synchronize CPU cache state\n");
      return -ENXIO;
    }
  }

  cpu_cache_invalidate_memregion(IORES_DESC_CXL);
  clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
  return 0;
}



Looks like i can bypass this with CONFIG_CXL_REGION_INVALIDATION_TEST
but just wanted to report back incase this is not intended.

On x86, this invalidate_memregion() call maps to not having the
hypervisor bit set:

bool cpu_cache_has_invalidate_memregion(void)
{
  return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
}
EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, DEVMEM);



I presume if i enable the invalidate_test bit in my config this will
work, but if anyone can validate that this is expected behavior without
it, that would be great.

Thanks!
~Gregory
