Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE03CC54EBC
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Jan 2023 15:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbjALPuR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjALPtu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 Jan 2023 10:49:50 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6722D68C92
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 07:39:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDkxf9oCqAKzp0eRQubIKs8r9S7Gmm8WaxpbTPevBNSUihCO4frfFNL1XPEUWs5uhKtJ6/YcGhJBPTYqYJ7E/redYGNDbbKU4lTbHiSbFOMnI2U4U7+nboaQ4lCo15Pn0SvIXMGGHM/6om0vaR1jNwDy8I2AOxZbV7cNU83Nv+YK1UZYvttnXMpBABUA85eR6z0YnC69W8wjfr+RDa2Ott68aR8uWZtLIewwSwvH31VozlHnfW1cZMw3nrQ/15dYeAJcljoxnkp8xAMlcVEBpWspnbS/wSDJU0WUmontMPytX+yEiZeWPfWjuAQoL00qrawAwiWjEAEuj2d/gsp9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEZ/x3ZJdK+RKPV9EzXaThgWSVHDYzAdwzwVoqqcsNw=;
 b=XcG3ZpxpMosq5Yp4A+WZ+xiD2aO0KVCx2VHsSr06KJDorML5hCm/4RnC64M1c9Z+nzYzCYEYfHqKnIsTV2cR/zXBWk8uYu1QMysOHkPpSjlhLW3oM3be9PSr/rn6+gE2rZRHHKdLAsJelc2CKIoUCBznLvKu8a0hePrtC5/9ohiNYmLPCgQx5jxmT6IRG4EAKzw9Y9xlmGUFMyfEAMKhBRspLJJvQUJvA/sur2/OypLZAVkF/aowsSA5lYt2VWjCgQ45sjJTzhWFcFdjrg2MdjAsXn/uQ4PLKLQCtv2klUl9ArR0eIQYTSbSVNXr+e3YoXRKJTzHz297JumBvofqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEZ/x3ZJdK+RKPV9EzXaThgWSVHDYzAdwzwVoqqcsNw=;
 b=Ey7eQ09BsHiKzuVrmSjLsFSBOjkESESA8uWKgzqGytnzDgfeWbuf2AmXwouUz/VhPXiMPsOUNbZC9DF97Sd84jp7rJAjVP2y5yqKxGWpTLENhW7juhIJ4NSzOap8m5Fsafihdd3FHKlZ2lRNF49gRkLv9Bo2s4iixz0zlkzNu74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DS0PR17MB6078.namprd17.prod.outlook.com (2603:10b6:8:ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 15:39:21 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 15:39:21 +0000
Date:   Thu, 12 Jan 2023 10:39:17 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <Y8AppXP+eP9cEz+i@memverge.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: YT3PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::26) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DS0PR17MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2edb46-1001-4055-c63a-08daf4b32ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/UzDxyDCVfq0k7TzTVyQKm0bCGTzk7r8kRTtPKaSM72Xu5Ut9BgTouGLC11D13LhtYJQpLUd9WsVkDZiHRf+CsAiN7sMpsoWJ1zx1uwIVQjjAbeI+R96qFIz8viAMZREPuuYjh/seb6HK0fwz8qJ7SqvSx7xApCjT11MFjXzLbiVcQZ47+x1Xsa4YmjtCY7wGnm7Xcn48qOOQJymmgQbQB6HhjUN9O4IevdAYvC6vONMNpahgPF14ptvpsImMR6qwyYApMKj2wXea8itXEo+30+RaJBdVi1V5vMDP9w5xMp98NOdub6tBfzo65cUZVGlqJWGKIw7oaKVwV0+A8oh3V03I4m3fXu+4SpAWeSrJUImWh+itwqC7d11AxhUilGqUmjrwv0u7ZYy6SDwYFrQYOYUm7Lv4X2S+z/nc8Ln7PxA3EganWu8GouG6dRn+jPboxBEBrB+Nbzv+/KyVqfyhI097Dy/awE/qF7whnfOEdHWJvS6lWI5dfCE3YVFXVU0cIEQ6TRwum1EcfBmWBSq7aRLRe2K5rDvLfhIgvecXccw6y6XYfbacRrxoAYmyo8/LTJ3et/Ekc4sa0Ue4dA7BRiukl84oumuNqxIhhvD7ojjlvAj1OcFbL/nRJOEQXRvGRyrUF0Z03OQiWOaawMx2+7pHX40KTVCuTIKcGvR3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(346002)(366004)(136003)(396003)(376002)(451199015)(41300700001)(4326008)(66556008)(54906003)(2616005)(66476007)(316002)(36756003)(8676002)(66946007)(6916009)(86362001)(4744005)(38100700002)(5660300002)(44832011)(8936002)(83380400001)(6506007)(2906002)(6486002)(966005)(6666004)(26005)(186003)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x9l8bckpeti0y8IBHkfYoyXbpU8TyzOARwCRef1biEpqmD58K2u9fs3EUpB2?=
 =?us-ascii?Q?TUtS34gFGvUhtCNBqnottdmnrYtpDeMkQK1rE6DPDGEi0e1LIiwriaZtBnVD?=
 =?us-ascii?Q?XCVK525o/rcKA87AuXzpZal647XwQ7qLXfggdOP+lKSgzyyVZGx5ByWgBjKK?=
 =?us-ascii?Q?f3apj6TDIzfp0Xb1nGSY9jhMSZVOPPVwpvb/wmUWEMT0CUSjweim9JlV5RJG?=
 =?us-ascii?Q?VS//XG3OW0c/4nTQvc+6uFqEJWuQzCBhZ3T+2GzbU7msS/51FTTHyHTzfRok?=
 =?us-ascii?Q?dh+JLuTZmhAXmZ3xuQtiiOEwFKpR7Ux1LDdGf6tzwZblSHttrYuGI1BlUtNB?=
 =?us-ascii?Q?itmitU0J5EgWkwFsSMGT3jySBumIBAi1pytTAKZohOqC1Vp6DeWxAdQtEF6s?=
 =?us-ascii?Q?jZMR5qijSpfTwBpMEm16XjowCdW1WDP51W10qM2ZZpp9r8qGK8m9f8ZPvniP?=
 =?us-ascii?Q?SRBrOV55Pfb7zSdUlPSs7WXCUFqMtQHAVG02o3xIdkb9nGGY7XspnksQXaze?=
 =?us-ascii?Q?wEvW/vVlakYVlKbvnsh8DNxaigL4vj36OKcQnu5nQj+2iHNovrUlkMFa1qdg?=
 =?us-ascii?Q?AtTL+LGQrdG1LUUFTHXDpCiP0B3rYjuC/12/wtyc94O8LORHE+iNamlCgFGL?=
 =?us-ascii?Q?AxAndpoGMNdN+xnrSRqRHKXMsmlfUPHRHZS+dFsIg3FqJ1SG4Or+nbTU/zZk?=
 =?us-ascii?Q?bU897+pncut7rxlOmjxQWUtokrRFHLIJ8dtNWqevl5EQeVE+XnRiLz0ZmJmC?=
 =?us-ascii?Q?IdRai5d/CCjazxuJr39bwkcti4cWwluwc3p5wqDC0UpgG5CrhK9JtU1upRr3?=
 =?us-ascii?Q?CcMeTZ99fhulynorA/M4Pj0IUqeqkx8eduBuEfRlawrJvn9WT7v+TCNMgbVT?=
 =?us-ascii?Q?SsmifrcB4ah4qNYkCVPZMgBq+uteEXOqHUWH5nRbFcFwDj6SoaKOKhQywSc9?=
 =?us-ascii?Q?GfJK5/mYrw5V6Nyxpat6GfMDrHWT4IAiEDTk7hpoOIAE6ItO0TMUmClbJf2g?=
 =?us-ascii?Q?Bt9Eu7GiMJIpLlBWyXaohxPsSb3BMWMgonsDpdUaKkCvrhTHUVc6kdjypmS2?=
 =?us-ascii?Q?ElUlJEKAX7dDzCGKCn1E5siNOtqnlqnAqWlWVrZ/tKGTxGe1qOjpY6j1sPLu?=
 =?us-ascii?Q?DPlFaknlt083f6DaWlNKpytlk53yeuKHwfBtpX9ua2+owdlqGJzxSsbou2S3?=
 =?us-ascii?Q?wYVPnYab2nTXJqpvZeY0IU5iB9tqBTTcA2zRVk7TZ5rDwSp7kD788VFOCPEM?=
 =?us-ascii?Q?QNqqWzQcBjmxVvYvWkOgsJM25ocYurm96NT3Qp68TSUWgf9EKGlau4lOim7Y?=
 =?us-ascii?Q?pIaUFJx41SlTb+ofS8pplgOAlk7FayqCrBqenmH1hd4UKx0JrwXJIm6hNRXN?=
 =?us-ascii?Q?hO1QHOJIaD3eK8wWPnLtzlsSeiu85wVEOjGALriu9Oih6ruEVJtZtVSR4jdT?=
 =?us-ascii?Q?PeeR5gyrZEiQ8qKhfGulCCHU2SjbkS0rS1EBjtaUpzDQFfIOnuICcnovQUMD?=
 =?us-ascii?Q?xn2KGptYhETK19hEcNWy1X/4fi0x+iz9QcOzTbJ+D+thwHiDEYEFPiOllLPP?=
 =?us-ascii?Q?NcmsUygkfpF2XF53OQYYb3a8gP2YyrtaJ1PX9kh+jcJm1HZe9G4TxjH8Z0I6?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2edb46-1001-4055-c63a-08daf4b32ccb
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 15:39:21.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaGgc7PT4Te8f6WLj0G3e7izWAOLdwijERb+hKRjHVV0rLuf3cXUTCq11SJzB5RKnt//TQjPq5PMGdlw//XdWXLWJYDB4sBW6D37cuj9WGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6078
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 11, 2023 at 02:24:32PM +0000, Jonathan Cameron via wrote:
> Gregory's patches were posted as part of his work on adding volatile support.
> https://lore.kernel.org/linux-cxl/20221006233702.18532-1-gregory.price@memverge.com/
> https://lore.kernel.org/linux-cxl/20221128150157.97724-2-gregory.price@memverge.com/
> I might propose this for upstream inclusion this cycle, but testing is
> currently limited by lack of suitable kernel support.

fwiw the testing i've done suggests the problem isn't necessarily the
implementation so much as either the EFI support or the ACPI tables.

For example, we see memory expanders come up no problem and turn into
volatile memory on real hardware, with the same kernels with just a few
commands.  My gut feeling is that either a mailbox command is missing or
that the ACPI tables are missing/significantly different.

I haven't been able to investigate further at this point, but that's my
current state with the voltile type-3 device testing.
