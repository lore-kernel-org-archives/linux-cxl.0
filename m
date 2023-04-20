Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F3AC77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Apr 2023 00:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjDTA6U (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Apr 2023 20:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDTA6T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Apr 2023 20:58:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D540E2
        for <linux-cxl@vger.kernel.org>; Wed, 19 Apr 2023 17:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBby4XyBXftzSnu1mY67sr8yQCbJr724yhJtMTBCRp41239RiUp3tnUZRGk5bGypkPpfT5ZqhkvnOflGRDA7i+lX6hTM3zifQPLIg9V/eJlnfWu61xZWiqmjEsYqfmXQu6fgjSamgyrxeRXX2/VMp60heEpLcpRZUY2H/ni2fBQpIMnElt3ypTQxxJnomTc3TPo3vNp5AGUvOKjkHDbrEbMn+m3FM21VBOYsO8glOyEh3fZRPj9bHOMHpIY9OAzwkDobYafJhArlICw4S2Xl0vpozm8+fq4QB8Oqfvss1u9THLubhzVdJwZ1/EDZuSBeYyoRZpSw5qyh5D+CHbhOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN8ssPs6LtQsneSo21JvJAxVpVoNInfUhhavHS7U450=;
 b=dD9uRbzQ2z6HvuuAYJuAzuZpVuNb8ueXyx1/uVWUdvhVq2V6eo1OWz+0gtpuP+RuTpLe8WI6eNob6HrvonSA6fI5L8zANrKGnUc7/+Qh7CPzzdvmPyRNNArq4w1iEaCjIrCLod43JY/AEDC04HPYVa3RxntGy9u7CuE3gW39AmZolHA8Pl36Bx+cjgsozNxcK6cfYNdUB5U+Av+ZaPoHKRyqleV0mquBRarBF+VifOyV17UJkkobI7uZuLjs2hN/mjrpaYejpwfjtV4GVocq292me/dXF9g9XdDd1wv1fMK2IZZsZvfINdkdFmj8ASPykE6ApMZyJUnWrb8o6ahoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN8ssPs6LtQsneSo21JvJAxVpVoNInfUhhavHS7U450=;
 b=cWl3XiG+f33kXBOgQuLh7mX4oexO99CgTaYrgBOSoyjxXX9LIZ6kTbNRRmn+4zT9Mf90vKROoppIHrocCmMWlR5ot+e4FPTvroM/tWMHch4Ka3xEnmevtUDV6K3+ZM6twllYgNNGhJDrjbP8b6PBL0CQYjZV8OMoMiR5MYhk+/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB5745.namprd17.prod.outlook.com (2603:10b6:a03:400::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 00:58:15 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%7]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 00:58:15 +0000
Date:   Wed, 19 Apr 2023 20:58:10 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [BUG] DAX access of Memory Expander on RCH topology fires BUG on
 page_table_check
Message-ID: <ZECOIrOqXZgSOLsb@memverge.com>
References: <ZDb71ZXGtzz0ttQT@memverge.com>
 <ZDfp/+7uTyh2wWcX@memverge.com>
 <643e3c0f22afd_556e2941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643e3c0f22afd_556e2941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f77e819-1342-45bc-13ff-08db413a5296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Cy1HcUpeyBSNvahNLQSjKGLwIq9mckYwijBxBZbK3ceJasLYQfRLz7jQf2UIONcsYa+ma/UE84vshyoQ2SSOAC3DKm3qTqMivpT9wSuQOMrnAL8yehGbEg5bLx92z3X9UKc5PdHD62usi29w0z1BAapIFQybKEwnzitgJA/5sR24HpAC++62+wjQljxWtY31tCDpSIendErpzUb3TRs9+jbCgYUK+BPsoM5O0Cy14RAXnJyFgYP87OS6hAzlKcYQnPA10XmK9VszK1SwgW5W9JrPdaBCCnoFZNsMMaEZM2Qepxv/p0z4XIWOFv+7PCphBIl/nG50DDGQ+o7iNKcvHvMB/lxwRJe8bctLNsEYUkLiEFN1TiHEY7S/+WE7eGiUGng9V/YrmeF8CLNCGs+k07epsmaaaQdHziYK4zObLHuSsHQsemTvPgL1qsudJugfV8C+2MaKdG+e3CvIARKK+TNGISUWePra2XITjZHWI9U+Ykp+CmRD+Cb38T2baPD7KrxJLT0bG+s4CYyzBWRh6gbq/OdmHXFG88xZ+aYe5XvqSzn85xFN0BgnZGitt00
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(346002)(376002)(366004)(396003)(451199021)(6486002)(6666004)(86362001)(478600001)(6512007)(36756003)(2616005)(26005)(83380400001)(186003)(6506007)(38100700002)(6916009)(316002)(66476007)(4326008)(66946007)(2906002)(66556008)(44832011)(8676002)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?otmEJdtayzCOqlMzniaCOlESs4pWV7fzBpP3LAwF0DLekQnx9iDTpggRYCPi?=
 =?us-ascii?Q?qq53qFogiIIu3SmsagnZd9/FeqcAo0g2XT1ENh7DbPPHamwKo3KlbhZqO9Li?=
 =?us-ascii?Q?lNwXGMRxosq6gsD/YlF7Bc22yRgsLq6Oicp4CkbVgva7nzVIJQIzJzUURVdp?=
 =?us-ascii?Q?pT0nQlaeCeG8YgqzvJJH3wnoiRZyZ/w66XkB5xnb3d+eOSp97IQTTTiBjoJ/?=
 =?us-ascii?Q?pjJUKPBgDu1wTSX/3KWmHmvnMyuTB26ZnnlDTVr4hpqzitsOXekDTeLk5Qtd?=
 =?us-ascii?Q?XR8aIQqzp5voQKKzE4nLnt7IvQwZRXjcIgOJsteJbDYrEtETTapvGi6y3R+d?=
 =?us-ascii?Q?61XBLQsTATvJCpcBAgvGcLzcWwGEXCGVZ1nACufgRtaJZE/c2H5tMj8mDaIv?=
 =?us-ascii?Q?WnuBuSDtGUzjAID9ITs28SvYoMmBw6RifEhmlEvosQhUH4rccUlni5jEwGjP?=
 =?us-ascii?Q?8h6UObpHtAiIk7dCMm0ewYvbfsHW/CC7txsIsaIX0SIAmkLNbgJ/N+/b47tO?=
 =?us-ascii?Q?hEakflbVt+RYwq7qOCQlKyx12bsQ/cLjcqz5EEhzq9o6Z1HC20/fTqc/Fx/C?=
 =?us-ascii?Q?Dmz4whXVLiMtFfz9EUaFDoSxenkH1AcEyLpiry7lfcw9vRBgXtsAyoz7D5b9?=
 =?us-ascii?Q?mFRhVy7Z319x9k6KG6tfhUP5mHQ6Bd7Q8O5dGsJhcvSKm1PKEz6smTE12Jcx?=
 =?us-ascii?Q?gERnZy1MQyc/RvAzzn5jmpumUVMm6SzeM8kGfeNb5Bds2ZVewqHEfO9p5oFD?=
 =?us-ascii?Q?GrPXv38flqbN2aIWNYslDBe884HgmjwHI2poD2/uHmIHHveIAbdQhI4jJ3y7?=
 =?us-ascii?Q?yMBdt8fE2n2QYQ0GWDRW4yNCaKpvzc4GEk4GU3VVUAjmQP14SILtAvKNKXuf?=
 =?us-ascii?Q?zzaJ4VLSCArH/orIAJg1frOh/Yl/2qkVa9TYrLE7IZSR/DDMhzjGZMYDnLRR?=
 =?us-ascii?Q?2b9z1X4mlP8IQSjMjU7PDR0mSYutLiHcTOL/ucS1vBgvJb5sJS3EC+kXZOJc?=
 =?us-ascii?Q?EdOvS2PHfCLB4zaI8uxGuCICmQfa6FVlHbxTIkR8Zs/QuEfpALXX4qnlVNKp?=
 =?us-ascii?Q?cGB6jQB+XkGC2ESkBXcy190uzDXHrQCmiKiV1EF7g1hDc2Y49dAm+4dcZyZc?=
 =?us-ascii?Q?tVgXBK65MvWbOLqkgxSEkI1AcN5GNwSDHf7+CGk7wfwOiU0y4CEzCg/ZHUr+?=
 =?us-ascii?Q?af1FAEkD86bCCLHXb0kO7KNUrvMZsAS7BpE+W3Re6I6zEmIDLDuzDIF5PjQp?=
 =?us-ascii?Q?OZxEZEyxo6fTcyp1yjol9rhajyX0HgGX8kna0lJIBFE5UcmqPFmWjj6ec6NK?=
 =?us-ascii?Q?+PJw4zDtaUvelngfHGuny810mgtb5r+uMzWSzqMB2sXjj6ysd1BsURVcti9/?=
 =?us-ascii?Q?y/VLmxNQsP1F0Nnl/rzWxaO6E1n2U1GZAOx6+EdOHCplNGtxAgiuiXUcxd+A?=
 =?us-ascii?Q?KwTw7aONPaF2ez0/Dua8+9EPbcFbr8jlmJkwkyZmWqM0md/nBHIY995vh0QK?=
 =?us-ascii?Q?w+ooPwkMMOGypsKYn/svLNL0dhKP7kSp7/CpbwaVRODeZ4GP2LUoVP/+e9C8?=
 =?us-ascii?Q?hHXT+grA8m2O5QKsmYbyAKqoRzgoLkQijDDMc+qEX9+VebvzCo8ZR7iRgFiH?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f77e819-1342-45bc-13ff-08db413a5296
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 00:58:15.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HU4UPA7ZDiyjyWMi6awoBaGG2BmTYB+CstToCfz9YzsQ75nYfdPn4J6okcfZtHkXG3FQxXlHvvFmOp4MydFg2IYypYPyFqJWm2zr9TNa/H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5745
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Apr 17, 2023 at 11:43:27PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > Why NUMA-mode works under these conditions without crashing the system
> > is escaping me at the moment,
> 
> Why would it crash? That range is valid within
> 0x1050000000-0x304fffffff.
> 

Basically I was expecting a page-fault in NUMA to produce the same
effects as a fault fault in DAX, clearly this is not the case and either
the switch from numa to dax is causing 

> >  given that the page faulting system goes
> > through the same driver.  But my guess is that pfn-to-page mappings are
> > off in some way when placed in devdax mode, whereas they're correct
> > under numa mode.
> 
> pfn-to-page is pretty simple, its the pfn to page_ext that's concerning
> for CONFIG_PAGE_TABLE_CHECK.
> 

Testing CONFIG_PAGE_TABLE_CHECK=n now, will report back when done.

> > Note that the above code chops off the first 768MB of the dax region and
> > the last 1.25GB of the dax region.
> 
> Yes, if the core-mm picks 2GB for the block size (which it does for
> systems with more the 64GB of memory, then it will align hot-added
> ranges.
> 
> > The CFWM is required to be 256MB aligned, but this code will force
> > anything mapped into that area to be 2GB aligned.  I don't think it's
> > safe to safe the BIOS is wrong.
> 
> The *minimum* alignment of the CFMWS window is 256M, but if they don't
> want to waste memory on Linux they had better make it 2GB aligned.
> 
> BIOS looks ok here.
>

FWIW i have a QEMU instance with 64GB that puts CXL devices on 256MB
alignment as well, so QEMU instances over a certain amount of DRAM
produce the same effect as hardware - lost memory.

~Gregory
