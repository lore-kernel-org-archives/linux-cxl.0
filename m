Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9A5C678D4
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 14:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjAMO3y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 09:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAMO3U (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 09:29:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447826ADB4
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 06:20:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX2/KTxnwqBW869hYGNxeWv0VnWkMxbLKKmGqYNrtFsKtvq0uspCcHFFW4XdpFlrQQDrHzvAapQnTZ+2MYe1VmfV3LSRV2JRf2s2uTCou/7tm678VStuk6NiaxdxtAOQVqTK/1kefi3R1a8V277vNZchfOURqrFpcF6CMTWdfiL6y9u2/Gpe6PyElmca3Cz/1NkiCLupoUqp5z83tWlF4xJij/LLpLnKDXb/KfaPv54IMggBQY5Dv88zmBcutRo/hltO9m0bSR2Ctz8PVZh/37KkCrh4/cbXSSZ/8cCqnU7gJncc8sUM+EECix7fDnkRy0nrcfso+gJyeT6OSkJZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7hEEaGRDcT82ENJbvC3vru+9dItDdKQKOGg+KG227c=;
 b=XY6czwvFoTbyHrHEqip/DWZQwfVcC4vYm9CPxY1UN4Jb1CL4sP6NYRlPnO8TMwzE2goFWn7h8kCIKbqjUcbjBEybZapUNLUpEBBUglANMtG+1+CaUFBfC5XPncD6EGmNmeYIQNbPNIkKYuAWw5iiewsBfIxe6GDx83F85Pla6Bc57BmocI7cbEKu8K7j5Mu+VPCJorStxSqyoaD6lpA/kqV6U2wXNkaLK8EVmgq2R/41G4VBmfbFBhzphIpX7G256f9DkEArYQ904iKjCvubOkl30eVaKrUSFN+3DDH2CzRv6xVqsJZHD8J6NxIHKHPEuKhYrdpizGyNAIrjIPxq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7hEEaGRDcT82ENJbvC3vru+9dItDdKQKOGg+KG227c=;
 b=BOcl6MUYHXTi/KuX8xXFpQZWFPlq+CUMCpMMNFu2vU01Ngl03FprXeQRjUnA1T1N3SKDrBidkDgqSGt3HnWrhal078ptjeG06g9jf+HgDYoXmv0lCGLwcDG5lOQP9YqBBQMGVTkfRRgCV0VyQ50tRic92cpzzSuUhHsHY6U9Trg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB4874.namprd17.prod.outlook.com (2603:10b6:303:10b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 14:20:02 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 14:20:01 +0000
Date:   Fri, 13 Jan 2023 09:19:59 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <Y8Foj/12QNl0C96o@memverge.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <Y8AppXP+eP9cEz+i@memverge.com>
 <20230112172130.0000391b@Huawei.com>
 <Y8CNw/fZT5fZJZcK@memverge.com>
 <20230113091213.00002146@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113091213.00002146@Huawei.com>
X-ClientProxiedBy: BL1PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::29) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: caceab53-c63f-497d-5c5e-08daf571421d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6QiG8rlpAS34jN7uWyBpP6IZguuRHh7LRmr1g0Rw67oTJUQz77xnvCqCk8MMIO3vUkumItaGFH/Iy8HLipxLDx+wSOG1WBQ/ravAMWLw0ydunSJnTKNLZAt0IuUCpaDUzSfbS1Pe2Zno+/yQ5fIkTHcKvF1qRAdv2UEG2vJdzqxfZVJn4AhfrMhknsKrwUKuSTM1DV5yJQvhZfYTB9zr6fyoJB/pTZPATM1aLj+9uR2tdcIwYkoZLnaQGJN/xJf677FGCnrWsOx1Fh8p0TZQGOIQmje9G1/WuwHBEJ1gTMCpzcyNtizNQBFztr5aDLvRi8ipTReIbOU6BkYtNHG+SU9Lu4pJEqzneeydd2jq+adAVpSH+VDZ/LvuPym1WOnw5CNf7VUUD7Dsc5Xf8kw0B028SW+FvJ6Ya5ZnIamPlchcXfJkMwZkcCaU3sP1UGxsmZ95jsDnc8NmGt7cVph7QMtH9EE5ahJyCAvLOqTcRCOPxCRr+tLOwxgzcIQTjvyZlmiKjfbGZCbtHnIAzarTA0BLC8EWuIZ/HzXij+ycO+T+Pgx11snKzNRokAQQYIX+3f3MzY2IBMdEnrSGqCcWa9Whv4oP+L2PD0mOa5JrBvHEY+fM4VZK2uQ2Iso+1o3BdomQE6oWL6trivJfazjaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39840400004)(366004)(376002)(451199015)(6506007)(36756003)(2906002)(4001150100001)(5660300002)(4744005)(44832011)(4326008)(6916009)(8936002)(8676002)(6512007)(38100700002)(478600001)(41300700001)(6486002)(26005)(66946007)(186003)(66476007)(66556008)(2616005)(86362001)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QcwGcUUi/NQzjsI6Qkt+M57PIU6QDInm7sQIzMpHALmEAPVSvEXpZqToLdk1?=
 =?us-ascii?Q?5pU+Kbfkr/2/NYQjj22YKPKPQNq9AH3OunjGpxwuHgERXtr1Wnp0jIpLkFyy?=
 =?us-ascii?Q?1f2d/MntGbfxponzq8kGiBdMjI2DVYDgBjWJV9AccZyWYVyPnA2M+PsqA8X0?=
 =?us-ascii?Q?rVkIrk8HUOVXOvMg3PE1cb9xbgsADas6CpR8cbCIBU3zGB8xRo8dhhdKEdQ/?=
 =?us-ascii?Q?jfP+eCNR56lUEYMHw6Edi8zye3gNGCluXzNgNjMMKDckRBcrumZEjbRF/P5e?=
 =?us-ascii?Q?wgTbpyul8zPBWoWOrswQ8tjNR7LasaM4rdRyInvfyCLRcuc0xR4BHNCcI+Og?=
 =?us-ascii?Q?AO860trAqi8PGupHTuihiHx8EzTOgLpNrMyhlyyTN0SspdWPx8Pyfpo6yCRa?=
 =?us-ascii?Q?Gf/BQwf7KAlzdoqctImxR/zqbiuWjlC5gVz4HAnUGVg1TBwjECsyzTQLq0rx?=
 =?us-ascii?Q?CiAS/vb7Vd62nL1fO+z/GM6wBm4hj4wATxYpq/iyEKx2GXkIZW+uc+jRCGli?=
 =?us-ascii?Q?kOd8AfM9KmFIZHEzNQ9bjtC07qfX+nB07TrzGwx8e7hKgV1KpHp6xRwWR7qx?=
 =?us-ascii?Q?PFoNFeaW+1kFEYkDt+EJBZnvl8Tsxyi3jQ+u4+1Zo81VGYj+AtFvGCYZ0l39?=
 =?us-ascii?Q?YbNcXeKL6Y4jqSB+fdZA5cac1bkOVsFjc5vDlhIweqep1ytkitL2gFsMKNju?=
 =?us-ascii?Q?xGGAzFTZwjUVxrYXXceocYUkg5qSUd+GcqtS1kxKXFCOuY5TmG6SARcPNBgi?=
 =?us-ascii?Q?G0qv1O9cAS5dSRUm9yjbu56Hx5UMRge6t8IZEYHA0g3xShZCVZ8PHATQExI3?=
 =?us-ascii?Q?EVZVpYLO63w0VrDk9jEryB0WW8RE+1suwVEskXgLynFzyexd0x7UWEESae7d?=
 =?us-ascii?Q?CQYl7ButaQzAJ5TBVV1uYaCAj4wIeJkfAxplk/16VnJgB6IR147MaeQ4PlTu?=
 =?us-ascii?Q?pB+lEdmLZJcT/p38eiOwjkz175TBFtGMjrsGG4z7jUKFyanNfl/uGNWg3qWv?=
 =?us-ascii?Q?xJNsmEpm9Xa4E4Mn64hQcti3P9aF1Qd9l9cISJzg9kJJ76MO2XJllNLACzth?=
 =?us-ascii?Q?Yqba0nQv9SvdURWuzII7/Glnfh6YEl+lY4E/MgvXes+jUEuy99fsER2XAVjo?=
 =?us-ascii?Q?JngB+uAXyAzcZ2KOEnh1l+LZrl2djiWfoujqiKRIAmNLvFMnXkaXaDHijBXf?=
 =?us-ascii?Q?I53ZL1BFGUF2sfWJn6NtNo2EF6jyJK/E2D+ZGJfM9d/w+h2ov7l1dtjs5+Xc?=
 =?us-ascii?Q?n0qauROM3gVJMOqx0sT/jznmhA9EYHYDwQ3cj6mH6gskYd8NAED5iLCluk+d?=
 =?us-ascii?Q?xFfZSCU8SdHEu+kvHWqmjRT5WakzhyaQwbFlpBgo1mvbvFfJ+X0iIEwJS0Ya?=
 =?us-ascii?Q?63icO7oPOR3LpYbq0aY5jJ1Y4lU7/fRrrqNIsnAI5XBcrJ7x6tXJLZTZimSY?=
 =?us-ascii?Q?3HDAK/DfO9+CuNXUGzdl6fuSN1I5fAIZsj3B9t3QtHs0RlESBB+Ok+UaItsC?=
 =?us-ascii?Q?Cm5vhaVr7OE7/buGd8HjIvvLDh8khPHyqZ7SYKVVU2dO7w4plw5/3dyDk0E8?=
 =?us-ascii?Q?o1fEY98091yvcrMNj4GWXH4EzSFiqWW4tXYO/iKtXeQAtE1s50MnIcSP8Ft3?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caceab53-c63f-497d-5c5e-08daf571421d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 14:20:01.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoRj99LT/3vLnMyvXfpFGakfcnFAbCRlks2wU5kJkHL1smcoYiPeuQjdqZR/OJW+lDPrRp9KlveapNW6bP/0dYIA7TrVIUcCYnxssE+knB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4874
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 13, 2023 at 09:12:13AM +0000, Jonathan Cameron wrote:
> 
> Just to check, are these different from the on stack problem you reported
> previously?  Doesn't look like the fix for that has made it upstream yet.
> 
> What kernel are you running?
> 
> 

The prior issue I saw was related to the CXL Fixed Memory Window having
an e820 region registered during machine initialization.  That fix is
upstream.

On 2023-1-11 branch it is commit 2486dd045794d65598fbca9fd1224c27b9732dce

This one appears when registering any kind of type-3 device, during
boot.
