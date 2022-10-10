Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56142C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 15:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJJPZi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJJPZf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 11:25:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561D657573
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 08:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzvHecqbLJVEqp2raDH+vUrLiaIHFGgJioh9wHsfyc8YEeogp7ls+8FuqpgYIMscjHgFF50kAODwTutk1ZEXVxf/r5OIg+67W9WVlRip3zXiQnoum1bA+AV5uYehiUCo4+jANBIJPAek7QDIuO7OVAlgGLCnP9sp7F4rzPYN3srwE13dxHFhbvKqpVgbNssae20DRhHD5zp1Akz6+Mlgh5j/LIU11ODU8fkMYLvxaes4KCGaxgk3cMnucar4rBZz0uItw+R1B8PvVusbNnGF7MGuTWjjhrltwUl1SUaJ1YPCZf+9dC7FutcGTGx4OQ3BrcvLkdUBPDrr/k/0GswMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URviAwFUgt9C6jojsiVOF7kKCZJijZKnDhzNk4RtHPs=;
 b=FtTidGYa5937fx6+1CAV70R/XKqLBcznVoAACI6E3t1ROEKHVuC4yh3XS6jNqyEJlHwjIJR5iGY2mxpFbC9UGofNAR+u6o5kN/ReTPX+56pII4iQwe+HtLgdx+vjjyVykmFbilh84eeKFYSGCp8pOyC4uKHY0SANOo3RqSASaTMRQJl+0enVaMkOoboY3iTlWk8EAAhDWGXLnq2GB1D2vHeZf2LWKsnFIKRMYGLs0sHX2Cp57oeGlTo0I74mAMvvwd6axsgkwQXpP/e2mJcI8h5l+RNz+wSg0R/K/9IF+yoPouJxwVnv3uLWKznLCrL++5Xwp0WzY5r3rdaq7NDSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URviAwFUgt9C6jojsiVOF7kKCZJijZKnDhzNk4RtHPs=;
 b=lLsMdYXXbJ3kV8hCMLUxRDPSGmYUjQCcO3PsMvukLYYiz9VEmW2OqfhzpBOuPrJqDlO6giRrLHoFHj8BaKtp/Me/KoZusUBK3w23FPGaFyNfn/ol8hQp6GKQ344NJqQbpwp5XcLvVVb2qM2UrNHQjUPxroiqlQgJNgfBgoUJLg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SA0PR17MB4268.namprd17.prod.outlook.com (2603:10b6:806:e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 15:25:33 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4%5]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 15:25:33 +0000
Date:   Mon, 10 Oct 2022 11:25:31 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <Y0Q5a2Wx3qFB2eKI@memverge.com>
References: <20221006000103.49542-1-gregory.price@memverge.com>
 <20221006094557.000035ab@huawei.com>
 <20221006095007.00001271@huawei.com>
 <Yz75ppPOwYCvNamy@fedora>
 <20221006174214.000059c7@huawei.com>
 <Yz8QlQ9yLFrWxWsN@fedora>
 <CAD3UvdT1ZHJDaqj05C+n7t4rM7yhjZyM6fooXAfG12rAYnBqmw@mail.gmail.com>
 <20221010161809.00006f8e@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010161809.00006f8e@huawei.com>
X-ClientProxiedBy: MN2PR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:208:178::32) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SA0PR17MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5faaed-9a75-44b4-c79b-08daaad3ac19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mv+TbUk/PPmjTCGVUQJDqEQvhJoPu4B3ChNOm5Ko1igT+pnuAWLb9M6JCwxMJPff2h44MZp2/g0iB3JAt1zLR84DSotxLgnopak/PVG2ckE6bEdbTM1C1MjJiEwRwr4UkY0XFj65U+VNae7KaDH4AimQa4gp0zC1pD7bRJbbsYvWMeeKjvDEAkjMSXYif41zBJwPSxqYQMYHA+Xu1QhbHUPIIrCCV9dLDQHPvQMnxxe7cVe9NnGudnv6EB9V2BoBGCllEuOG6VQiCNMzEnUIKGzJ5HUxLzRlnf8UAi5j3i+R8P07sM5jM1Mw9eW5vy1LFxJaqKCotru7G5irH4ylEGEnpPIqGbMyb2uD3QlfrWRKFX+6bz8+daUljySztUpszCkkVg1GG4bN506HQhUxFTrk46Tq9nRX4stkiyh0p/fUnw+qYaJsDOnH5xVZ5yYamTp73HwN1VILx/Ccs0BlGF9hqd8Q7p4P4nMBWulbADaZE7AKNRkEfCV4tTVmnXL7wd8Gs9+EL/wmS/Ho22M9EHW85eiFJQFOhTPDU/Chu3JrVoe/rPwdFGEaXGXCiKPp1S9yVVpWCBgtnmGKcJwtRu5j7PBq9Fbn0hky+QMFGdAOYmDJZThB2TfRG6dLnG1G3VoAZ9K9193UDrgLx8G6rvNRbhcAz/JDezBVb27Zy6VwxqYPRdETZe5UU98IbJLUxYXWA8JWMI9SKlhYWjlP03oCNHKmjin3CeyF3Cy57Xeh2jnG26bzHUhfP2NeY/hYL6PXR+nE1TitwBeFnH9dbKCwsQp9wv7kpyrUrzpp4eQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39840400004)(136003)(376002)(396003)(451199015)(316002)(6916009)(54906003)(2906002)(6486002)(4744005)(186003)(2616005)(66476007)(41300700001)(83380400001)(66556008)(66946007)(478600001)(8936002)(8676002)(4326008)(5660300002)(966005)(44832011)(6506007)(26005)(52116002)(38100700002)(36756003)(86362001)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlCDQ9pj2X8DolJdqZjGm635lYkaO9ExACDLY5IYl4tEwofegmJmx92zTi50?=
 =?us-ascii?Q?OwJbh6hR0qPzKL9/CG6OTziYxTh4rC8+hX5wNgbJVPf6dn07VO2huBuFHFL/?=
 =?us-ascii?Q?OWPp3uHCoU87S98A0m0e/2Ck4UpyeMr0EiRWXfBDaVKGlpGl0CqT6yozSW2j?=
 =?us-ascii?Q?wjNRjbhckKOKVX+I9UNXTBijDxfbcBUtj9jaCGbfufSJ4zH42skpK5Jhm64W?=
 =?us-ascii?Q?0RIziNepDPlBFVirx1bF12fGa0+izfkrX297refexp/esBfmUZhqh+Hcvwdv?=
 =?us-ascii?Q?J3kwVHPZggTgYBEkIl/wf/FpwOcdzZc1+wLEsQjeT4X+rzumpdavGJ7eU4iW?=
 =?us-ascii?Q?yCwop9DnUHD9on30wzFkF/PCJ219jkM6fyRi6AS1hUborA+MKzqqrfuSqGuz?=
 =?us-ascii?Q?K+j8dkpV9fHajzlNccfK2G7JyTd0gRcd13FlZj2BlBPEyYy3mKBXUC7RBYjq?=
 =?us-ascii?Q?Ez4W6X+273c9t7ia5zdanIy1Nvx1ZHggko7yWCBFu/NLNNQWKHKU1U4Xf407?=
 =?us-ascii?Q?C/NYhWJeeXjpw2KAVr+ctC2Tk/XVAhAiJwu7YjUnlILbEiIh+ohDxnKniRAU?=
 =?us-ascii?Q?BfK7ONB8PeZQDPbz8hO8gI381e0PdOjXEa5LRPP/2xffVqtu8nbKotU+Ykju?=
 =?us-ascii?Q?sZqf3ezDRx8vDJaEsIQwJAbXTayPucKgXXY7GcPnFb2a3/DJi+9wpnbVY/1U?=
 =?us-ascii?Q?dtCQc1XmgkFtBay2vj4e3vbdmFeNQg/FB4Vd82KTpn1uRaOpF7Ts2FoxfgBh?=
 =?us-ascii?Q?a34I7RgRrYy/ELCO9x2dLhW5taqIUz3dCNE9lsZo1KYtbSqj8ZRy38N5GkQP?=
 =?us-ascii?Q?dGEAj2QgFoMJobQioChCeSX6vrXISkWj7hDwivjODOaZ0laXzhj9yijyM/6K?=
 =?us-ascii?Q?ZCLy9gJfKXaUMWPx8kTYC+6BtkvQeOeY+pVRWHKA1GKqqGib2oqqg9iRGNrm?=
 =?us-ascii?Q?8ZNicRXmQwfzpqty4+XAgx2iXaDat1yFUHfLcgjRFO8n9M6V32d3ZoTUn3PU?=
 =?us-ascii?Q?EtJc9noAXkvBLTgNk+5JgSanmi5/9dPn1LOh9yjNGsQXKCR+2whc9O56U9Dt?=
 =?us-ascii?Q?0dhhcbRV4r7bqybmCRGXrnNkUE6DwFxBpwVcd5D16esECw3SIbYjQG9lft07?=
 =?us-ascii?Q?74Bu1tH4fzjGiuorBkUk5w33e5XhKvi05g0lLstw5QC3fbF+Kkww/KknUwxX?=
 =?us-ascii?Q?TjPd6GD69KB2lcvc0SyR7X05r6PQA55jfTcjFRasDeKoaSBRvql/84atquWi?=
 =?us-ascii?Q?i4f72kOgAmmrSIYt4fw5SU8mkmQbLY+szss1A+aIbRVkEGe3BBGi7WaxTeSl?=
 =?us-ascii?Q?CDKqLQ5F98jBqi/pdwIv6wCr1N26A3908SG5Iqj9exySuWVg/uUkZ2zHN/dK?=
 =?us-ascii?Q?JRhIKpAXLE32BvPA8HthOcB1ILFwlpzui1ze0lS3AGeKfxlH69jps5bT2vKI?=
 =?us-ascii?Q?5ORy6RQge7DO0YeKUNb63jvk2eEUMFpObu0/uBeFgzUZdY3W+SmNsa4vE+T8?=
 =?us-ascii?Q?gmhnlz5j7UA48BnewCQIhhCXeGNsQyAtbkzPxbe+AZu67dtDnMGbfp/I5AEa?=
 =?us-ascii?Q?QbX6sXlNQe6kxgneJedtdjWAD55P+4kGx6ljN2eVGnNqXrl7ODwqB/6nGtVc?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5faaed-9a75-44b4-c79b-08daaad3ac19
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 15:25:32.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfEvlHJNov2eSbmxcFNocZ297VHQymOpHoN7imQtuUBRXjXC1EMJ/U7f4ujkPWJbi7P5e7klrBe56jxHBk+SxE4A1NOmf8CCBUPOOIdqeGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4268
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> 
> https://gitlab.com/jic23/qemu/-/commits/cxl-2022-10-09
> There are a few messy corners in that tree but it should work. I'll be
> pushing out a new version in a few days.
> 
> I updated that in latest version to build the tables based on the
> memdev provided.  We'll want to add the volatile support to that alongside
> your patch.
> 

I will rebase my --persistent-memdev and --volatile-memdev patch on your
branch and send out the commits when i'm done.  I may also add the
scafolding for the partitionable-pmem field but not actually expose it.
