Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE87C004D4
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 22:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjASWap (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 17:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjASWaG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 17:30:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A5A731D
        for <linux-cxl@vger.kernel.org>; Thu, 19 Jan 2023 14:13:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaIGXbL2WjWV+KrOoWpii4cee7nXBR2Rp9JJId+vXIdHIB2Vz7p0XZH6rden6wsXfOfEa05PpgFCW3MUQamkbnm82sWqhuv8CKK0hLyEAtyWS8OR0vNEq3gST8QXJwS09YDUO5CyJqE4kGkBg1vn1zOBgcESejE2NmmQ4bl6GIn0guOsVcanGiEEQBDNXQ7+qRQRSPyZrldIShb//4vaGfDfVOxZvlLlP666VmHYWKccwTN5Eqd3Xy61u70pDJD20T4a/sMGNrN96EjfRFqCkc7LQ864UjCQP08bQU9d4FvRiBgKEF9gkmWgb1M5cXAlZJFTQJwnwPKB7+PsqhqTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYbk+yy/EM4kGOh3uhQ7vHTmarYxoItI8j67XVEfhYs=;
 b=lRNrWzuYmLz9Pptl/1ww9QvQoRhMeLJ2K0SkbG+fMAlgMZ76kPR94WulrmMfcbdkFCLGFs9OlpmaFH4C33E8LyuwZZM1+Tmk1FNd58NeOP2T66a7yWaccO/WovN/JIVjqENCfiwQzbxN+5GyuSKgDE9Dvp2TUDwCNaYoi3GpSFLO33Jjcd1MiT36lypWHoUdc4SMQJJgyvC8iMr9vk2gd7B6TZTPC5iOu76qY7XQlHxN36fq7NmmjdFWyWfNxiXVzad7J8KaWd2miy1gC3PAHyXNDt7otiawu4hrZCflE+vOP46rUaKv3BJmEViFCzG/6+q/BQY+VXFr35IuvynE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYbk+yy/EM4kGOh3uhQ7vHTmarYxoItI8j67XVEfhYs=;
 b=ZusvfRvTfEhz2LlNd86qlmQjyNOOa3jUMGzMhOSo+0CIZCqWYt6+KlEvrBtdVstKE3C7P/MeRNQP4TDmObANHtOPdQVk4CMRavbJaF/at+aJg32qL6AHfM/MT+Jny/QEpnw5ajFKpYxAd0zn9qR4wdnMlAgqH+FX8L2qby/yOu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB4472.namprd17.prod.outlook.com (2603:10b6:510:15::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 22:13:46 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 22:13:46 +0000
Date:   Thu, 19 Jan 2023 17:13:40 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, a.manzanares@samsung.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <Y8nAlDYxCtC/vINL@memverge.com>
References: <Y6CNcuIzUVmKL0SM@memverge.com>
 <20221219172502.00001338@Huawei.com>
 <Y6CloIiuruB/h7qp@memverge.com>
 <20221220153453.00000436@Huawei.com>
 <Y6IMoxKZOc7eUPCg@memverge.com>
 <20230103155629.00007466@Huawei.com>
 <CAD3UvdQ7nZab7Y+tbc1Ox-zqzse4C16dwv6qtOAgfe4dA6_crQ@mail.gmail.com>
 <20230103181524.00003e14@huawei.com>
 <Y8l6wYKstOB/iBzT@memverge.com>
 <20230119173112.00005acc@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119173112.00005acc@Huawei.com>
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df4b8eb-a549-496d-a997-08dafa6a6ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vn6rQa5NuQbjPS17SlR7ZNNKRnFE5+0dgLoD0VIBtwXVBinJm+bWKfUENS+C0jeMElp7Km5Ds8/zxwLEWq7IPSw13emVQ8/NSwF+IrE6rHPet+RxVSpQQlLZnX6Q/v5fIr2UHA5c3/Q0ya2KLv1ZfPtb/Gfr3p8mJlwN338Jy/n03byBvmRIwcWYfeJ2uP+DFr00n6RUOFvygRRTxXSE1chg+1aNkL4hjsRKKtvKMiDEw9cXczGX62LDTTK7rJmgkUgODAfNPYEvPHgsE46EijG6wTYZOtNK9yPkhWyhM5Ph+iN7M/DNKpTdv+SnBHx7woi9PjNP2kKcXZdUmmkGpL827/eDXkggB9vVVte7+QjW/heno/8ZiLp4HiXjZftzAUUyA+eHYiqKqIBSRh8qKGTz3LRGMP9DLAKWrKsGJXObRdnwakRxJ9OZxMCZwFsh5sBcUgZ7ix09OCOaFNh3QeKJ3jiv5YxDaa7p7s4X7ph81bOJU+9Lyrau7RCz8TljPlSDTQsQSysnKvEQCcAO+my/QJ6KwlGQLDqZa/JbG1W3W+5xWASEnPAbJCH6DHxs41oYu0dOmOZr3BoxfLdWHShc8ZbWIjGZIp7f0NDTyRwCrTgfPJoU44yA3Quzw9qGhu8XJBpMInMYZUIWnYujMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(376002)(39830400003)(451199015)(86362001)(5660300002)(7416002)(41300700001)(44832011)(8936002)(38100700002)(36756003)(6486002)(186003)(54906003)(478600001)(26005)(6666004)(6512007)(6506007)(316002)(6916009)(8676002)(66476007)(4326008)(66556008)(66946007)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FYaBFc7Tn40/CDVShj0Pjc4xBPoKa88CQCKEL9zdu80IV4ZcHUw5K/WFtStL?=
 =?us-ascii?Q?WW9UUG/4WMc9i16+GCeX8yenMbk6vsrCpKBFO54dC5UoeB7HO7kaOuuYrFcc?=
 =?us-ascii?Q?EmbXgnM/XZAWPv1eD9TKkUmNBTx6o79bodrnVGy7SbfuVucKglBCxHLX9xHh?=
 =?us-ascii?Q?aqU72PC4AzpEmdInn8C9cCMgL8V3AYi1ByvKw/VvgQSRwQFgvjmrGa+j7uxF?=
 =?us-ascii?Q?nPgDl2ypUpkoL2p7qHl+qbssqmxUE2JgyE7yR7SXXsTrm6s/8ypOZpadUTOB?=
 =?us-ascii?Q?cmV6KuxUcFksHIswhKgRZELkULcRM+ETW/EXto3JQBliSsF1xefGO6TN35Zb?=
 =?us-ascii?Q?9ihdNtOzXjH8a/xUTe2snDQp1Kdh0FLuEA+FRHZ1NUySJitVI+R4FJz7e96K?=
 =?us-ascii?Q?cIspQxYHRAvlb88ZBch1hF/vDqsMEZnRHVobpx68CcamFa2tPFCzIT1z5Suh?=
 =?us-ascii?Q?Sa8pFX/mblqcKfWQ5p6eHVDWUhAqopzUcR6QK6XxzzLgGdHi7nkoCEsl2CXN?=
 =?us-ascii?Q?UB+/f+I+h/HU2nQon0oH7rvP0ZPeQYbCDRF6/DnFAWZ/wKNVrmIUHfRhJD+g?=
 =?us-ascii?Q?yP+outt/h6HwYYSMOZ55glppHYOlGCG2AXoir5r065GjpoODhepHODNB4WYF?=
 =?us-ascii?Q?xb1rzTn/nZsFV6xHD5Zp+WOmpHx7Th2GxRoF+/kD5/ufhTyUHV833AcZOy0C?=
 =?us-ascii?Q?WExBjQhmmBbyuhS10LhvMW5wBJw5+PrSRjAbOFstpdOyMAyM+l+y89sLszx0?=
 =?us-ascii?Q?rIfz3EAhxfEaQNXaWhReQCU2/QRjWWddryk942L98QXhdpsj0sACnm0eZpEI?=
 =?us-ascii?Q?OLTFELdQJfVkNNS1zGqbZ8abNG1V2CaLBNntPUNHkLdU8ObOstbPNLLIhc2H?=
 =?us-ascii?Q?PN/ajqhH8vl3+Lk3u6ti2UQmo+rVcSCwDtyq6Yg+TIAiLqMzrgzB4DgKck6h?=
 =?us-ascii?Q?DYLk4InY82JYFmyT2fSME4COD4wotDfjtlIYoJsyp33z7UTm/y1krozcLegW?=
 =?us-ascii?Q?53iphQAEbXlQY2oLCJZ4kl4SR/M/QQPiUEDlrsdoG3Ngxss3fsIxO4iurCMS?=
 =?us-ascii?Q?umrqYjo2UEnezYxjNxT+8Y8MP9w8Ai0aC5GUPl+Z/5q0Hnk7vtS40hR/87ME?=
 =?us-ascii?Q?cUi7Hk9SfrDYJmaqQRQl8fgBwDjYhpOrow5kURkOKBrEPrYwOAijDDhex9tu?=
 =?us-ascii?Q?8J3/vGOQ5vNtU+cs4T/kPjVqYr+N9uW2y3gO64F4Je04UVt2J+7Ud7sDLHhQ?=
 =?us-ascii?Q?aZl34ScVvdrpQv3yJNdNjuzLjog7vrubX6wjLSdr8x3OUzv7yhgNHZsbzjG5?=
 =?us-ascii?Q?oT87SasrwoxacxXyXDRvD5CGhHuMGMs6cWYPgRAh+26mvFTKzX98V0Rw75SX?=
 =?us-ascii?Q?risZY1K+oN1AOW2GEfjsfutWPIF2nzQAoO8LzBsO06C2xVa7BdGUIzu1ewjW?=
 =?us-ascii?Q?ZeFLa+bqN3uVhAzgrCj/eI7Ow1QdyssHc357saA6u5UaaleALkotQDKrdqiA?=
 =?us-ascii?Q?KBdL1IpICxCU3xkl2yfUwwfLrtEy4aSqywI9b5YExtnRJYT6F6UJMp7pVvpH?=
 =?us-ascii?Q?afnCCPHS53t0Ca3RjQMCKuEY5OzNN2URhwtVA6NayYD8lOir5mMmtiGEY6YV?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df4b8eb-a549-496d-a997-08dafa6a6ed8
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 22:13:46.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3enZPVUBF4R0fd4n64IuWPfDXgwe+aTVcXjtLSj1X9lrxbrnQYeI5lz3olHhAkob4W3em6+EFKPraBtAfyzDKjC4sDC0AdzA01Tt547R4U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4472
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 19, 2023 at 05:31:12PM +0000, Jonathan Cameron wrote:
> On Thu, 19 Jan 2023 12:15:45 -0500
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > Found a bug, not sure how we missed this, probably happed with rebasing
> > and some fixups. We're presently reporting the volatile region as
> > non-volatile, 1 line patch.
> > 
> > Jonathan do you want a separate patch shipped or would you rather just
> > apply a fixup to the commit in your current branch?
> I'll fix up as I'd only squash the patch in anyway.
> 
> If tomorrow is slightly less crazy busy than today I'll push out a new
> tree with this and the pass through decoders support RFC
> (I'll post that to the lists as well)
> 
> Jonathan
> 

Aye aye! 

One other change to consider: the .EFI_memory_type_attr right now is set
to RESERVED.  Should this field actually be EFI_MEMORY_SP? Or is there a
reason for explicitly Reserved?

0: EfiConventionalMemory
1: EfiConventionalMemory w/ EFI_MEMORY_SP Attribute
2: EfiReservedMemoryType

I remember reading a while back that the intended marking is
special-purpose rather than reserved, but i'm hitting my wall on
knowledge.  

Dan may know, but I couldn't divine the correct setting from the kernel
(obviously this is EFI level code, so i didn't expect to).



One other thing that I am noticing:  When a CFMW is registered, an
nvdimm_bridge device becomes present in /sys/bus/cxl/devices -
regardless of whether the type3 device is persistent or volatile.

This makes me believe we aren't setting something up correctly in the
CDAT or something, but other than the below changes everything else
looks correct.  This could imply a kernel driver bug, but i've been
validating against real hardware and this behavior is not seen, even
with functional CXL memory expander devices (which the BIOS obviously
has a hand in setting up).

I started validating the DVSECs, but likewise i didn't see any
indication of error either.



diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 919cdf141e..4daa0cf0f6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -132,8 +132,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsemts),
         },
         .DSMAS_handle = dsmad_handle,
-        /* Reserved - the non volatile from DSMAS matters */
-        .EFI_memory_type_attr = 2,
+        /* Reserved if NV - the non volatile from DSMAS matters
+         * otherwise label this EFI_MEMORY_SP (special purpose) */
+        .EFI_memory_type_attr = is_pmem ? 2 : 1,
         .DPA_offset = 0,
         .DPA_length = int128_get64(mr->size),
     };
@@ -187,7 +188,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     /* Now fill them in */
     if (volatile_mr) {
         rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
-                                           true, 0);
+                                           false, 0);
         if (rc < 0) {
             return rc;
         }
