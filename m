Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76135CE79CF
	for <linux-cxl@archiver.kernel.org>; Wed, 20 Sep 2023 12:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjITMwn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjITMwn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 20 Sep 2023 08:52:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1DA83
        for <linux-cxl@vger.kernel.org>; Wed, 20 Sep 2023 05:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG2fsvFW/NLZUbsJCSRL0uIKgQsuXRTIkXXtAKTrK6a+8yWZLu2/cIHWmZovI22XlQ4xNSm0aWmcf8hKiYpO/gezBko2Jbg7OAtKGz7/AIy/4rGrgNmgfUqwTPDQ2HMB05nf0ztBmHAmX8y9x6eAiMM6GBgn/NGUp/HzfTK5+qgJ1gM/pfEoLzhU0iWRJ+GLyWrDOnhlFjZjL+ZuKQT09IJZMmG4UwdZy3Smrdn8k8ZgD+9m+OdgDzIvIeMRM7JFQu8pWXoTbX/RT994vOm659laUvmkuCFX/J7eqW3LriAinVh0kd5ycM0Od456PwrLDFevioPF6hhdFWlmnES/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y32/qGKstVOgFgyqbsQ2aIJdNi06h8aKvItmQPgRE6M=;
 b=h1UdK6Z4BWFG9cXLB9l5+KQW4plgEG//8cS0W5y66aUkGprxlsih2HXhPhqTjkCaLy/7+4w3hq9QNuP1iuIIu48nrjOJod/2a+2btUcBCtjBizG+bYxY6C0OuMXHgkREbFBwWZvfmyrv169VcIQmjJ2sTZXEEU1WEAqqcfuLWwpPg3fCnYmssPxalspZO/GgAwL4kRe6E71k0wkIyrqIVIMBAY/txAdF8D11GMDcFOGcFr8bRdBIM6YDD/Fr4LhD/qeXxOIwUxgQ5TYZUif9VjZ/lmfslxbERjDpdJHAoa2gaB1LYK3xOXdIQo95rp4TRL25tQ8jlJth6uXlu5UDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y32/qGKstVOgFgyqbsQ2aIJdNi06h8aKvItmQPgRE6M=;
 b=NNZhrotWDXLAkRaX1H7nYxGUOdVfRTPm62tkvqGFycL2wpOcfz2MnncFaax/1SWkrsCGhLAeTQf5LeTxTpFRgG2VQEwVZ3utUGqi6hszQl7U9bhbSa8JBbCPjP4NeE0Uu77AxrbFHezu2UpQzuTPXk2F0GBykr2H5zcowNlme2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM8PR17MB4981.namprd17.prod.outlook.com (2603:10b6:8:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 12:52:34 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:52:33 +0000
Date:   Wed, 20 Sep 2023 08:52:30 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, junhee.ryu@sk.com, kwangjin.ko@sk.com
Subject: Re: [PATCH v4 1/1] cxl/vendor: SK hynix Niagara Multi-Headed SLD
 Device
Message-ID: <ZQrrDu4lGwmGdUPk@memverge.com>
References: <20230918173656.504628-1-gregory.price@memverge.com>
 <20230918173656.504628-2-gregory.price@memverge.com>
 <20230920134618.000065a9@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920134618.000065a9@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM8PR17MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 78869ce5-0945-40a8-8b41-08dbb9d87511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIOqH4ntT5USLcwXwX9uEjjYk+U2ACT7Eaa9k8EgpO8MY/GS9Zg0OxiNhuhGvO4akmPwIf3dT5EWbTWj7gqebFDgE7/+35CFTYhjJ/VD9C/t7kIxZasGT/Oa6T3IVFjPMv39OV6GGV0KzaM9CqjtJWVBf/c55uyxfXtKLjwEXSuSWZmhvwaSmrMH6+WQroxwdzjS3G8bmZwxs9OYdZbpGY/ijvemEkGqJwTW8r1+ND7wwgtxHiwGtzRKVxZORtfedD95ahkDTJAk9yTeAdeTmaMjf9EKNJIwRmfFq6lPMw1kn3md1w8haWK3yGQyV4HTFNa4/jhf3l00mNWUnB3/BCFZl2muZ306r7qww4s+PR/QyCkSy+hWPx9E4HgiDXrYE/k+lnCVRNFDc4WEqNrdwCUmeoBr7FRuDQSFEwyq6bPZKIdytdCoGJSPUSQ4DWzjF/1ZxPwcn9SYEXIzbhwblmbyl2pcQWPpkb3wNrm+3q/6LIaU0/RBCVZuJHwe8XG8J48u4q7tueK0JCWAZMxGzQwLtIAl+5+BXS5ANO+INsl6A1qrfs5SAJkmDV2TnKm8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39830400003)(136003)(186009)(451199024)(1800799009)(4326008)(41300700001)(38100700002)(8676002)(2616005)(8936002)(316002)(66556008)(66476007)(66946007)(6916009)(6512007)(83380400001)(478600001)(44832011)(5660300002)(26005)(6486002)(6506007)(2906002)(86362001)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vJ9iwYHSdLy/D6IHfG+hK8X8Tws/coVDdkegzgFfedxt5G9FMNb8ubE+DHA?=
 =?us-ascii?Q?Qb2npOoJXnxdcNwJxJdAaWnJfaQjh47oVWUOCN7coz6E9Q0tyW+ljbXuY3by?=
 =?us-ascii?Q?C65+LdeBVEpTkc3OatwM3ko31EUM3PnuNbXHQ3pFvD929En/szf+HapcOkWo?=
 =?us-ascii?Q?9JwoVwr6me4F5sKoLmkVS9C1F6egWe7mZ+U6v4A26WmdlEJixnkNpGQ8m/Am?=
 =?us-ascii?Q?grEBmzJgn6rxA3+sov/ElZD/soGqg4eZSIFIobHWjYkMl3giftWb3LGp0F08?=
 =?us-ascii?Q?389iyzSYqmPzHmdenR4XoK3s0MS+CgM8NXydxd9LigsroZKu9AEq0UfYmPZt?=
 =?us-ascii?Q?tQjZoRHUHnnPXxcuXyCsWzurq29w19CmbBJAJvDNKIWyh3XLt/nVqo+FoRnm?=
 =?us-ascii?Q?lKqXaHjprJ1v9M7FfuzA2MWi5kWgtWJ65de7Qj1M2h7xoFB7iBY41FLuRkJy?=
 =?us-ascii?Q?zBMHskVMnLAfqwTgf219SLdQmIO1K/3ps0b8Ebi4Ni7RivBbkCOyebcm/MZR?=
 =?us-ascii?Q?IL1JheeBKQ+jXK+xXI20u5yCqvFRLksX1iwexcOvA/0trsU7JiEFb3ufn68h?=
 =?us-ascii?Q?0JxmT9vn8LUhoWAbDhWcWakK7erdvsle/62rBWlHX7lMJCkoIyVIGdtmCGw1?=
 =?us-ascii?Q?dy9gtWcC1mU1b0/mfLoNfNINSDB4nMZfA+owTzvaVEGvlAmn7iYRJpdoO3Ev?=
 =?us-ascii?Q?4gOC7xDiFB2xdjuE4hYkEWlpJ7cCRSLujQ+eBfH/HcMScoq1EmYnGdunkzJe?=
 =?us-ascii?Q?03Ccs/vdPcaqopUU3Lnf5KvG31oFLznbT497k+5EYpZhfCikqlMxhrEEHVjA?=
 =?us-ascii?Q?lOE5C4UNIzbFKFj/3/Lq2KJ8MX5a2H6ajdFFTSML0nfGDvec+yUwRPwESeWs?=
 =?us-ascii?Q?wvnc4P4ObhjLD9VsWjjKyzJDLw38YXztH49+1lszz7QP2nawazkyKz4nNqKU?=
 =?us-ascii?Q?CeZhBH7x+umrYjVWbCtZQJJke4PIdAgeGSMbjwhoOFt8TSxFYS5CHImO0kzM?=
 =?us-ascii?Q?tRgLreFCv4yjNNHW9B/pPDCjsNAEGDA2XqjlpboJToAT9iwMgzqn5E+VRkte?=
 =?us-ascii?Q?L/AqFcvR6wYc3F15+wqirKXd7xX6SGYxLQbcxBknxNKEG3igryJX4jhkwR3j?=
 =?us-ascii?Q?mPhKvsN/giBMUVqVpF/wlRXaSfK9zilqjf9oV9NI8AyGSL1D8MFys4Kwtojt?=
 =?us-ascii?Q?VPRaeFeWnosNctHEpD0NyWsnGbIv+5EIBgcemLZJXTUz5O8w4DWQMXjhkOmz?=
 =?us-ascii?Q?0ObyQePNZqI5xLUI4GdEaw9SWTHOVjGawxnmJNZDTk+KOhTT0Rgou+XAZypG?=
 =?us-ascii?Q?UYqqcB8AamOHpo0zdae0EV8GtoiXBLFMbKFOLcM+P6NbS6dSBvy26Xivi2mE?=
 =?us-ascii?Q?s1P2bp6KSYY3Rhoe/4TX92X42Y7zoHSPhvi0lZnGOn3+CrxfuNIi3pGayzhl?=
 =?us-ascii?Q?xOefqB+P57+Rj1WQBqw5wz3FTB6+f2yLDTAIJdTiBOb2TXLOk+whgRWr8QDW?=
 =?us-ascii?Q?cUUOmUB0VxJ8befnJRaP2zdnJ+wCO/af4bo5cMt8B75x9TYkvFtb8QROqmRD?=
 =?us-ascii?Q?GEzIwiWpCFsUyEq0x0qQW3UErUY2Uzo9eL09MmCNjMZ7nIyfS9YqO0DsdPIf?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78869ce5-0945-40a8-8b41-08dbb9d87511
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 12:52:33.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jSouXyEcVpnJywjeMd2GulkGi/+PWUjsBLa4yCcIsjG2U2NNFbws5tR8Nb4zaGeWAv5WL5d5B9mNGBa8fp85IH30DNSxBNaK0Rv+IbU7jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR17MB4981
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Sep 20, 2023 at 01:46:18PM +0100, Jonathan Cameron wrote:
> On Mon, 18 Sep 2023 13:36:56 -0400
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > Create a new device to emulate the SK hynix Niagara MHSLD platform.
> > 
> 
> Hi Gregory,
> 
> Seems this doesn't drop in directly on top of the rest of v3.
> The mhd_access_valid check has moved from being a class thing to
> an instance thing.
> 
> So for now I've reverted that bit in my local tree and will probably
> push out later.  Whilst here, some trivial formatting stuff inline
> that I was carrying.
> 
> Thanks,
> 
> Jonathan
> 

BAH! It seems i've edited an old version of the commit!

Disregard *facepalm*, I will send a new one today.

~Gregory
