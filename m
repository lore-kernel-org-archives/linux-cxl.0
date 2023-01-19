Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26751C00A5A
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 14:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjASOXd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 09:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASOXb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 09:23:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D87172A
        for <linux-cxl@vger.kernel.org>; Thu, 19 Jan 2023 06:23:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsgeRQptbdtmN8xtCN0myZaFWPgvm4yg36QxH41IPxoCYC2Qbr392FWNwLZOMaciVYrsq1oFn6I0WNAUW2hjprdsZphbyZ7zknTJ5pR1itSascVDIt2LeWzbkbhJ4a3lfFz3GsLrsEyPsdlT3tYrXZNsLMvGV+zLsRySCu8H0jGQC+P8pxdbzA7eiXVq+UULIpTpTj57Qot6V2AdKA/JFiFRi5sHMhKdJDfPjXRPZvC4nNFFvd7g3zJAT1zcq/wubBy6+1lVQ9S1iI54O2cqcuVRICrBW/Q+bNBphYd+QjnOXf0OuI98NXYEwg/4bDA9a4UqnyoueecnL/rKR8dzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AbGcOnks9CEjFxobq4fB0sMm/vCdmA2SbxljyRwFrQ=;
 b=TsiOz+Re3aesZgSa0sRDlOHa2Ymf3ecCJZb8t4is0DY6vBymaMabWZqd1mYnTHS2srYCbji7xOS52PleBknnJxtfEqpopTIn94A+9MjWj6nJqwMf9Lu15kujBSmFC95ddOHGmhjmO/vE3RU/Jjj63JPlhfNYedmQEzbMbWlngMsPuvHzvcRcdrBNfwaq7fhyGpMDck3mLp8Zb2SlXerGDjIS/I0Oe1rAd2kQZIbbpG/RZnsofRQdKZRjJj9+uTNuyEbduTcsyqA5KY+dB/LxN2GVu0tdMGqE5TNB8BOI+RUXT1iACWXhv2Bb8RdQWGIIvzt49aW8yQA2UsLZpgDIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AbGcOnks9CEjFxobq4fB0sMm/vCdmA2SbxljyRwFrQ=;
 b=a6hWQ0Fp5x/2EZmxma4F/PJg3gepiV9lC6zwb6e9qTZZhsr57oYITMDIWUse3GQpXAVrddc7r++jjeJOaPNQQ82djLvLD/8JzD5RCnPF70aXzu99ANSp9qmutEXvmUWfHN/QuHccruCrDuVlS17tWccT2WB15YbkiW/s3xZ3GPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by CO3PR17MB5758.namprd17.prod.outlook.com (2603:10b6:303:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Thu, 19 Jan
 2023 14:23:29 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 14:23:29 +0000
Date:   Thu, 19 Jan 2023 09:23:23 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>, qemu-devel@nongnu.org,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <Y8lSWz9wr1xFbMQo@memverge.com>
References: <20230112172130.0000391b@Huawei.com>
 <Y8CNw/fZT5fZJZcK@memverge.com>
 <20230113091213.00002146@Huawei.com>
 <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
 <Y8hG4OyJL7l9oD2f@memverge.com>
 <20230119101946.000079e5@Huawei.com>
 <20230119064755-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119064755-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|CO3PR17MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0fa6d3-7668-487f-ded6-08dafa28bc0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9WXSsGJBeZgI0stPjxgQzMaCK0/rJtV45ICMeMq/Z3qAXfTjFKlJwk26pwqFrDRVbI6YaLAtlmll/r8yeFKSz2WKG9XBRa8QO1mt4aTlvJXKpynxCoIOdNBZU1k1f4htk2V3fWnULjXST6o8fx1GYOfyB3kOTl5McGRfBsAg+KGDqqQgaNQuE6SR86yPn2UhZTAqg8IVo7T5cJmao3TC9VLbrRBFiqRHQ4J7AbLihM6khEkI2zgJ9U8BF48M6V16SjXOBYPY+SsiMkQ8sTY8fRGWQE4YaVVGprRH7yHTZW23hhJ3hVtXLzZVuRV0Pw3tAwXFOZzdIZQHOle9xVVStA8So4PHrYdw7OX24BU1qkEYQ1xeNtdDuK33x+sC7pkDLWSOfH2evVTd5y+n160Fmci0mIF0/8h8fAg3FEv0r6BNMiwkyS/dgRqUXGLlYTzKvCw3hkxajCOJdqnGTh/Rc33326gZlc5Vy/gM+Gxc/tr31SRFVa3yUtNDV23wOT4AckCY3TE2g9N3zKVgdbcI3qhuuL6odUbson38W3XoumJE+VEhvkQd2oCKL1ViEepOY2m+D1FI/llmGYkoywR6l7I1atCYPZnW/X4FVqqz1N/NP9Ir4LyLBDWrImTxlI2R2yxQBrJjorfZG426djacQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(366004)(39840400004)(451199015)(6512007)(66476007)(66556008)(66946007)(186003)(26005)(41300700001)(8676002)(6916009)(4326008)(36756003)(6666004)(478600001)(6486002)(316002)(54906003)(6506007)(86362001)(5660300002)(8936002)(2616005)(4744005)(44832011)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m5l9JXeF6GvA8qj/yupYigy3lsHNDfvRYowfoWauE/4RcjK9fPaZ7e1AyeiH?=
 =?us-ascii?Q?h269M86jpLVRBY9Xwy5wubjb5bf25yEjyrzyydO3417sI0RRdYu+Wj5GWDbU?=
 =?us-ascii?Q?UWQAD9Q4Z3jq5wbxkqW1NjAzqhSpnn5Ak3KU7GpNugMEzbk/I07IacZdPuDv?=
 =?us-ascii?Q?4xi19pZWoP58V/zjL8EYHLhEJToswdNvgWbQyLScQvuex7TszhgF+0XJWyCc?=
 =?us-ascii?Q?hr1NTzkn3/DMnMRlyJ150NKN4RWrecxPK+olO5M5hVGkUL/x7Tra9er2Yti2?=
 =?us-ascii?Q?FTjZTg0JVHaC7FLattbrOhagoLXInY7PcRKHwvafJ+Lko8cys2yUSCvSVFtK?=
 =?us-ascii?Q?mJh2Uep19Tel+QGL141X4uH7m8Hi4vJvC159FyJzEy6crPyOa5/NyUVdp4vj?=
 =?us-ascii?Q?7TExv8etfx5SqpDxNWBcgZC517/okTHxZp21B2D2xCQNrDQElB3wu8EULkvG?=
 =?us-ascii?Q?WykcrVW3QdDpE7toK2Imjwtksr6KnueR31YBXs2Y9shYL+H+Lyc6USwDnN4I?=
 =?us-ascii?Q?ieQ+4X97oCJl+PAaG3/qu/K48Edu0/ZspZfOZAlcWZQ4rsDp8UcgXY2SF5Aw?=
 =?us-ascii?Q?/E634eSvbJtppX+Q3qPy8hFPxBzm1kr41GkyqE7ZZn5UpRqyTk8wgk3Uj1O8?=
 =?us-ascii?Q?kAJLdOTf+cZTiKft8kELhjhqVp6untZdyM0FyJh++YI0K7xfMoUPEF+SNLkI?=
 =?us-ascii?Q?gzBmlcEcPSsHG0ZITa8B7v6rlXAliMR2OtezFcwDRT3t5pP/pVaaxbeelx3R?=
 =?us-ascii?Q?UKlk1Kr4mgSUPUBo7Vbl6E3y9SNZxVmNzk4PKa6qLOujvfvo5zR1uv8kL7Pa?=
 =?us-ascii?Q?TljJguJdjdKn2OzGUTJIpNtagZO9gmRS9H+t6mMQG301ns9cakx7NHEEGxqa?=
 =?us-ascii?Q?Q01bUT/lJuUdRcTnVJxM9wKhfj2iYGlG35zP+DdYkmwW/RbQbOaLUFciY/zQ?=
 =?us-ascii?Q?WwsJ8l4saKQovBq7m0wu+zwylnuDlqEA2ml8Gb4F2uxKLxZ2PUXMLMR/dOSI?=
 =?us-ascii?Q?k+fXAkKq83ggwDke1eKcVSBQA4/kiQfUFUuEKKkU4EoyX9Z7oxCcLIySX0tA?=
 =?us-ascii?Q?1OpOgTlisADtKHGq8qFywnZFssGbaRuBe2Mi9pGbPS7P0skAzMoqPIoJi+hS?=
 =?us-ascii?Q?93sl0fVIEHjNiUEFkAtZ5xKowwcHkvZkuD7IXjG/Do9pidZL3ASz84YCy3jD?=
 =?us-ascii?Q?4RTDV2KjYnR3TEGeMK1eiGGMldLYN78jFb2kzaBq4y8pLyDJ/OCGw4WfO/UQ?=
 =?us-ascii?Q?qxnDjrQkheo+RdV+ehUXkIKoQsuHcoz/kxH9wfALZAt9eQXse87JdD4X98eU?=
 =?us-ascii?Q?ac+GK8mzbkkRKHL690nNvoY3JmVzGai+80dUr6jL7ClCy/4djPjwCE0+A/7d?=
 =?us-ascii?Q?EfDf/AzCf5F5TmlccMSlYxu+C3gHXRHUaxVYRPyQCQwNI9l31MHjpUOCGEZm?=
 =?us-ascii?Q?QztXqkWbkzKt3lP3GZN2M+qMuE8AkZrUnFMB0mgDIuGwVRKF3rNwAG1K35Fp?=
 =?us-ascii?Q?kHgPQMpqjVThoW3+qeOO4XRUJWMpeGgsmHNyLdlgHQa9lE/Icdh6RAdPDfa9?=
 =?us-ascii?Q?SH24YtTSnSp66B/FOpgWCapC/89XRlCDPoVAhLF8Yh8XDZZqe7oDVD5hdY72?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0fa6d3-7668-487f-ded6-08dafa28bc0c
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 14:23:28.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oS3mzdvZfRxkT4c6ed7UMpBLkTOlgWRc7Hn6fxV70xswQqAoyKsp7WVhohh/p9scRbepRh4fnbOrzvBOfdjEZK//pfvfVHdKXs8vunivn5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR17MB5758
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 19, 2023 at 06:48:11AM -0500, Michael S. Tsirkin wrote:
> > 
> > I clearly need to run some more rests as not seen this issue (and I've
> > had a couple of reports of it now).  I guess I never tend to be running
> > a completely clean tree on either side + testing is mostly on arm64
> > (though I doubt that matters). It's not the pass through decoder issues as
> > that is visible only when bringing up a region.
> 
> OK so I should drop this from my queue for now?
> 

Even with this trace, I'm fairly confident that the DOE line + this have
fixed other issues, i'm seeing less general instability on the x86 than
i did before, and when loading in non-volatile mode i don't see any
stability issues.
