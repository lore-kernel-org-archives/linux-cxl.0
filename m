Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E340C636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjAaQsW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAaQsV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 11:48:21 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89337683
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 08:48:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k28iJmj0ejT30OMixRSwbvvIGQXQFXh4bxkul9Z/MJrMZ84rL4TqE0f5O7k4CU1f1WCNk/VCtxIsB3X2VFWmhiuKdwK897ShuYXlxG0Xli7k7OEDWlhE/G4/gqj9v8gxlwogl8XlX45j+g+N0JudIGaU1aB5lOuOY6HYbIVbsdHOQov9/hBuVvcUpRyh18VM7sSzhLilcVoIQ/e6GOCPHLKNpTGrCyYFHzKQ0KyJ2kbX0I2vPZPrUSZD3n240/eJ2VDAXw2LoqtSb5lku3WfibNhO8RXOrCXYMSk543BdO32Cr7wy5mAV9keXyQ8JIsxjeFaUvA+9yEe8l6rYe1H4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dDhpAILtiplXQkjXVYHBWJhpT411w7kwr985u3k6Mc=;
 b=Ly7d7lWnIBoD0pbPWxCk7F/WHPNy9YJVuZQNeafqUMQzZ8oXuAieotJapLJhotWyWngEuGiUO/Bx2xSujvhvM/Z/MbESlsQZLxzk3HvDFwUqwRYVLKp7wYulM+HewC16qHReEWjLO7CwwhZH9h43zGuxerxpMfiB59ddgSzrm7jTAZcAHQQRUuKQAelifebnPqTNGGUVAaJMq8msAO2mnB8na9OHVgx5Xlhx0G0iJTFhDKkanqtm4bhIMaApa0zl5eqBfwWPNgfOWS4lmbOueT7qhC4+GU/kykiTEjSvtpwpcRXE/cw3j3radzv7kWB7QmRrT92vI+lMU9KHQs8f/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dDhpAILtiplXQkjXVYHBWJhpT411w7kwr985u3k6Mc=;
 b=LITMXRY4TBqkIJSEi4goFd6POI8EMFLqnQB+/xTHuTXPjJxPbQJzUy9HeHF64+EGPMDeeEWvPUB33P0ZUSpyDgrv8r8mO9vK1tZnjsmCTxnOhXBk1iNij4cIy99KpWKUfeIjz30D3HTXdhJ/X6ZzIwvYbuWeeVHzV4OlogVnAU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB5567.namprd17.prod.outlook.com (2603:10b6:510:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 16:48:14 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Tue, 31 Jan 2023
 16:48:14 +0000
Date:   Tue, 31 Jan 2023 11:08:47 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH 1/2] tests/qtest/cxl-test: whitespace, line ending cleanup
Message-ID: <Y9k9D1y1gT4jZ0Zx@memverge.com>
References: <20230131163847.23025-1-Jonathan.Cameron@huawei.com>
 <20230131163847.23025-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131163847.23025-2-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: YT4PR01CA0356.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::21) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff86ade-bec6-4bb8-90a0-08db03aaf20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxuLrhXasLwsfphwDV3qJRFX1l9lxonDiZqhZFcQ25ajXS+DaWHKvquRLRlLoBUJVynNMVFys3+p+3eoKfhJDUmiMqffY5xoGnsqN4Q2yTtmCMx/+NMNGrEFQkhT7JaJhoCvimZbSe2S6Rt3Cw7cqmv2laovR5dhz8qilLXkPBV+mNOg3/vB258GG3LUoPXLCfJVOKrf9i3igQwpcU0mLGyaiznbEPF5xLgMGonqmyBPUOvliG2Qk9BByi0rBKUoJAKyppIRn/nS+/wUL4SMJZLVp4nl0q+b+ZYq6yUd+b16uM4qo9x48b4LHlX+C32UBb1lEnyPRKFL4BuAxsshKN5hTXTQIfOBplgZ7PkuDvsR6WvbDbvtaD3ahpN/X2qUTKATqdXrb5EZ+FjOwjLcugg2aGAG8Lbt6nEKwrvLQHJi0kyclccfSetpjOnSpbMC048XuhZzDSPowbu0FSS6Rk/8944YJW57nhjTRYLTf19JWEA8i0d23HGzDhX55SsIZeESis3xPdjbpcm1CuWPoZlYjw1WgpjmGFDUguLmkWf/vycFfwOHHc2XUgwObUNMDZ+Do8Ptted/HaH1l+4fMmFJcsJFhfnqDmsY8TZ1/8OxnFlF8IvW6RQ+RLXvzutKpUENXk75tYtCmxPINivxkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(396003)(136003)(346002)(376002)(366004)(451199018)(8676002)(4326008)(66556008)(66476007)(66946007)(6916009)(54906003)(316002)(2906002)(8936002)(41300700001)(5660300002)(44832011)(7416002)(4744005)(38100700002)(6506007)(6666004)(83380400001)(36756003)(2616005)(186003)(6512007)(26005)(6486002)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lvUNGL8/Iki+l2hDNAgxpVYD0lyOwWmNcvw6fAj1NaFEBQ6IqsEovDThwJkj?=
 =?us-ascii?Q?IqbgXOT1la3Mey1ilEun0Q14wHkMfEXnWsfMVwMxJylZS/D8yaq3BWEGCPC6?=
 =?us-ascii?Q?vlVb1shm26PGnLHNkFe6uQpIn9uZraaD5HY+vXE6lzUqNdhitu1N9eynNzLV?=
 =?us-ascii?Q?nPJiXiR39Ud7t3tMeS9wY37MgbeQ04pFeeVUdHgiMDmXPqGkNQbdPlouvUe6?=
 =?us-ascii?Q?EDP/NvNSM0agyCHzAXxlGxZSRHu/cTYXU7HXFTAzfnorlykHSHfvLfKmnmYw?=
 =?us-ascii?Q?BsV92raearQDIaRPCwa37aPuJh2KlUve4aD3KNcbdgCn5SqoCQVZSqwLGH3k?=
 =?us-ascii?Q?ZULvWwFhJVqdZejmd3K88ab9vwrKHVJg64OjgMqF336rXpnemNI3HTBLXbUL?=
 =?us-ascii?Q?MMU+xMFa9ZW54xV5vRRu6T5ZTWnW/dcZnJEOamO7hu3x2KM72Ja27g4qmonB?=
 =?us-ascii?Q?7BBJz39qmqyM4RW4rcLCMtf1juO/qEY/vtlG3sA8Ss8OerJHQ/plTUw0FFa0?=
 =?us-ascii?Q?/XLIWhWgar1xg2LEZVHY1/O4Vhd7FTyHAt1jo2XQQKkZvq3eg5aQoObDGtAD?=
 =?us-ascii?Q?FO9wOlSgdtR9i6rdxncvvebQ8HI468xeKaTGLvZ/fUyBH1Z+wo7PzFBFg+OS?=
 =?us-ascii?Q?RDddQ6+1A32DdK+TA3cj8+hnOmqveJEraqfKXiT7qxHkZETSkVl5/OKrLttS?=
 =?us-ascii?Q?0EAIMm6vt72yEtBfctIrAIiChHlFk4NrpkZKdC4wgis/EizugHsY24ShIR9t?=
 =?us-ascii?Q?pmSeKWG8kJLzw/Uw9PrPXhwC+/Vn6/KanT01iC3pzDysgbpAkSBvwFbonqyD?=
 =?us-ascii?Q?INaUskEbKEAUr8GKh1WRmKWaPNpzQKsNKVOtJGea2JPj/uY5DeNR27h3bZOZ?=
 =?us-ascii?Q?IsbC5e2PGiz2Y45KllJLfdaGRJWJxo0cMwL0H12hgaYp1f6HvGOcvTDSrP0F?=
 =?us-ascii?Q?Mi+yAvhJflrD+ZQBG+eIhed23S2lQJ1Itdyj89CkpeIk0fnz8ZK9HVw+QKaT?=
 =?us-ascii?Q?zh6tWOe3sILTPo3JIjhTHmmOQ2FdD8T1tiCGUv/2866bJCFnKL1OEdNAmnvV?=
 =?us-ascii?Q?z25o/LyD/lRu+37dukGexGYLDOvSrvd3WR8fjz0Ep8I0TAtr6IkePHxG75lW?=
 =?us-ascii?Q?HPo3Egw9NMLXqNg+VTHYPKd9Ebxkiex28OMqliM0g3GHzfyx2sl2c4ZkgZF5?=
 =?us-ascii?Q?dcqXtNTZv1/t2EevVGU6lOTuQnPwXK5WQ7jl9IeBFwqX5aojtSq2ZeiFeJLS?=
 =?us-ascii?Q?A6gm3kJ+l3zqDh6IRZpgZcFTGIfzR72lRF8ukYDggPLgbbeum+GE2fl8YFlD?=
 =?us-ascii?Q?6dmc2c+lix05z1hBAKTCvCRPHRiYsa+KSRNL6vQAF+vMi241s7vqCEGz8Q8b?=
 =?us-ascii?Q?/dftT4+0LVKJN1Sd5ed7ckMGAh+jOV/d4DsOUPP32sBqK9V9BigFX78DpdSJ?=
 =?us-ascii?Q?HkYLeZv6nFa7OHEgIynK7f32vJz1M+iY5zBBUsqCkedMqFYwxFb5hvl9Dc/v?=
 =?us-ascii?Q?9LVENI70Mg4agl23MDxg7vtvxy9IcYjGTBJ6rqbk7etxgewQpxbBJ5LsbKBO?=
 =?us-ascii?Q?KF0EFyVeowEG2ooVTAK3uC/j4EBzRYuSgqERUBLWLkixwKL4biT5yBGnBWt9?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff86ade-bec6-4bb8-90a0-08db03aaf20b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 16:48:14.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBiaWZz5WMDQadOVw0BRfpMmdPCCcf8G8oNPtXZfxvlYctlbwbQs6cdexrd8jixR3lWCrv9pww8wZS1lVjslEX8LBDYhF/60R1P9CjovcUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5567
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 31, 2023 at 04:38:46PM +0000, Jonathan Cameron wrote:
> From: Gregory Price <gourry.memverge@gmail.com>
> 
> Defines are starting to exceed line length limits, align them for
> cleanliness before making modifications.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Changes since RFC v4:
>   Naming consistency improvements.
>  
>  tests/qtest/cxl-test.c | 84 +++++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 38 deletions(-)
> 
> // ... snip ...
>

changes lgtm
