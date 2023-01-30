Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF39DC54EED
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 17:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbjA3Rmd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 12:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjA3Rmc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 12:42:32 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694ED1AF
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 09:42:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhooHniz9YmqBWp+5gHtqmWrpcZJVtibZy3qw3yN1fEtxLG4aM+id0AGtWJTyTvQIU9aZYt/FhhF5okbOSuaYFcTNRIlVvVnAgyEbPwywPNV3FllKGEAi4dTebWq9JUEMa3K+so5ZhcjDVQPTkLxg1RWqGbq8JvFaU1FfS/F0nTYjf5jSv6A+fxdiu0o0Ig4luYrD55doieISE66/A5PipMFJ6ANBzQOTyAAD2mvvo4avZde6HbnVX/F3ZiO96Ee6zoOm2IT++W1YI4fINy01Ej/scpwZOLCWM9qoJqPwrUpo1bpJ2WWxHvq2YGF+ENcCPgpr9UO4Zv5CoxOKj9AIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZsTjbOABOIOTgwJDafT8iKxSAZtgXuy+if/zmSIUIg=;
 b=Vp368OOsZCJjFw1ZOWlrXxR0FsKZYIsiDibti93ZEldeCbfC6US7D3II1zean53Bcr5xSAhoLfnthUgsU/YbZQF4ZmXeV9dtvwldTdxPGzNz6ZxnvZ2dsEgcujydB0hTf2LpyoOaOL1FrG5vpCq5ynUZvHe5Q34KVzlzuTKGbDaurnUnmUlYtydRhWvTqzeeduM9e5s/Y5CLzQVxJP4xyJwIDDg27thyBOgfX2PS32CmLN/c4e+vV/J95UmslSrGa/Yg4ftQZSDUTs+A59dITVBsR9ujtD02pMpSI6axsAFxtm24nsB9Bmrgb4TX0PgiGr+4nANgA/sHNOr1T9g99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZsTjbOABOIOTgwJDafT8iKxSAZtgXuy+if/zmSIUIg=;
 b=ZlXwlSdaXRLSzuxcMsPe1s3CX9FCfCSirw9Bjy6YSAGKh127pSriUJ2kaClrcmo/jb1IlDU1V4rPfadRK2Q79+CBJZOAnOyPYShPhGifXDIu7FOPswE4eMzuJAFxDYvkCuK0QYd0Yh4PRDIVRhA/nsv0Lq11/oZ40qKBrPw4bXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by BL3PR17MB6090.namprd17.prod.outlook.com (2603:10b6:208:3b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 17:42:28 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Mon, 30 Jan 2023
 17:42:28 +0000
Date:   Mon, 30 Jan 2023 10:07:29 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/10] hw/cxl: CXL emulation cleanups and minor fixes
 for upstream
Message-ID: <Y9fdMfLakqY4/049@memverge.com>
References: <20230130143705.11758-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130143705.11758-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY5PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:a03:167::16) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|BL3PR17MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: a51091f7-76d6-4c79-7690-08db02e95af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zlp2ghT1r7CZQIcPxKwIHIJic6HAscTx/7SeSa+IW0tp0+kQ3rK8pgVaWhW/26mY9xBzmUQ0DMVK5nn4l8t74lIefYy/vA4NKsghY3oXZcpwMJf3b2IikekJ8DPgB5lwfyiHfpVcIPokI4+n04RZuei0VG7HIJ4iR0n1veeJ4jvv+Ty/08PWlqj9OWg//hKkizjweV+yQak/Bkzl8Y8JjxQJnyAEc2krgXvnOvEUH8Em4sYLiuqZzJD4A69XAfXazGCK1BN9T79UEMQd+itS4PHlImVofjl4d8MwqtmHIojSO7LNaWrRLYm5z97EpKuOaNUiLFZjQlSjWNj+xE2B82BS22/75+DhcPalmgwmWhBCFfUMcGVW9TUJnMAw80DfoU6tAvUdvUxqIy/UmJFPgqG63iZQhHZ+q+lmRlsQFVEt0XrNxsW+rM7zzmyOuH0ZGSaCukldODKfucUqnfqTvbvPmiKySK35+AVEwHJIEQjDHHS4PtWUi5EXTo3z36tM0ZaRkwQ3ZhWTCmWQ1xqERF1iVEXYPIkf4Uo9EogjEZ8Twv2mhOuH9JGY0m1B+ebgjsFsCP1fIT5fUQ1aSbhtUz5Dr2sRiHLWDTVkTUkg03ZcoVg2AGVCUWczlUWrdY5pYOn2gsyInlWllYq9HkIcC20CefnuIRHmNd9e1KVfVW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39830400003)(396003)(136003)(366004)(451199018)(4001150100001)(8676002)(66556008)(6916009)(66476007)(4326008)(41300700001)(66946007)(8936002)(83380400001)(478600001)(86362001)(316002)(2906002)(38100700002)(6486002)(6506007)(5660300002)(186003)(6512007)(44832011)(26005)(966005)(54906003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wBz6vxieEgYSmXTutbc1va/giyuX5MqhmwkQ4oACcMTFOuhNN2/gOKUu3CvG?=
 =?us-ascii?Q?dsx/MPVXw0aKxezrkeB+Uduqy//BurOCKBmvP6UA5KzsIZeHwWC7wQ2RnTTx?=
 =?us-ascii?Q?vk1ubf7A9W/Y7ECZsaemgDhyRv0xxFZBSUL1RHa9AMbq3cBXogHzNzvvfBmh?=
 =?us-ascii?Q?CicczBLqlBdhQE3MnqFKVD+1qeLUkujdgIGdHdXYxWcA45pM2tCr/WY76Vo6?=
 =?us-ascii?Q?orZD4q2pn5KG4nZ79TaFl1Aclw/0xfyHU0Dkuv8c6fYzVZGD4yxUNQjMGc8i?=
 =?us-ascii?Q?Fg1gBCjNrfQZBMJnlILKGjSD9vfRWLEjoPsny3xz02B8CGgq8UBt6rxPlEQq?=
 =?us-ascii?Q?RhRChORqXs7uZrzG2TarpBZyQxiWO1v6R1Vqb31nU69XdjiLpBLOWpgTQgsI?=
 =?us-ascii?Q?hzsmccgyukfauo/I2AwCg0L/hAvxuMUQu35O3hRMdgIz6jiHkpprXbkmrIeC?=
 =?us-ascii?Q?sySX7hrIbtMMjfVb8w4mvyefBRI2UCSNdDl5jSEF8pMCMDGuyNj/b+0STF35?=
 =?us-ascii?Q?/TiaV2yDxDyqdhZsy5SGuGv3na3K9CThA3yOPbJjV9gYdUHhOVuXad6gtgvt?=
 =?us-ascii?Q?rk6HjXAYP2UPT4ozVdlLBmBP4a8NXunWawS3A0B81rmlMBcMyHVO3vZ+YR4K?=
 =?us-ascii?Q?6tdK/JXX7ayAedYH5NL5ggqanlWFh0TQIKj+qGHaBovseKVeigCFZqZcv7mz?=
 =?us-ascii?Q?/wGzbOINiLzq6Utwotr2kxOauz3n/AMqPBxU4ugL9qs2rpm/GWtpY/XPnEWa?=
 =?us-ascii?Q?wxTKXqUtC3qubHA5+Zw1z6hajSoVldHypUXypw52ELNk0S0p6eK+y/WBPKdZ?=
 =?us-ascii?Q?IhOdOfHaxgsjR1dvTCEKsRpOI5hZRtz5wkiAZUM7tQ9CymhBWqajouBwJrlR?=
 =?us-ascii?Q?o3O/cWfOsBIFA/FmxpCVGt/DwxNiHjPdcgPisHziPGLTRW5beh/88NQOhSmY?=
 =?us-ascii?Q?pUrqo4WX3ZEZ6hvmWSlZ7k8WwFmPOmLXeK1ql4v4D4NMA3Dhng463d0ATIwI?=
 =?us-ascii?Q?5MDQ4ghj4qP1OnUVElfuSTx9o68YekMhy0BIX697fhUK9SMQDpqtpTyfvXhH?=
 =?us-ascii?Q?U7HsCIBS1zaRacDKqirj3iqHrsxVM968w/XDZ8bpyNAHiuKsGIzTXEl52RHd?=
 =?us-ascii?Q?1OXHm7CgU9F3cbvStaDstz0X9QdWYvucjIIEuyaXaYa/jDM7+9TyvlU29zln?=
 =?us-ascii?Q?VAZEoJi31uGlZVQ/qufNEbTgDNzVjY5esDMalWmTIpZMfsynQPk8ZKMZHB4a?=
 =?us-ascii?Q?wyLgTmEHADcKkHaoAllBQT6Eaczq7P1BVSLtUeKszNVqCYY66jHwcRuxPQQg?=
 =?us-ascii?Q?v9S/byr2CA9/YYZk0WasatP/9uVIEUpCWmufNHt4RmJlwJkR935+XT3vmmvl?=
 =?us-ascii?Q?7+1P2Aate/kPbCTyTBQD6oqahGTHRhOApYYp8xdWQuB9rR7WG9RCXpWTBwpn?=
 =?us-ascii?Q?fHlNJO42oAox+KORqru6XX246YmqzOJZyx7onzI/LlSpUbuw3sjzKyQb4coI?=
 =?us-ascii?Q?sLfKJeQcc7JxXmYLk1bb4YYYHV1NpnoXq9qlk4LILB6nTWm+8z7hvHJjvspZ?=
 =?us-ascii?Q?7yxGTmqy5ojx80knIEGc2gxzYWhWfSW1mD32kLQbcu4ABAGygoWcpgolXNbE?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51091f7-76d6-4c79-7690-08db02e95af1
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 17:42:28.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+0H53Quljf9RQBXw3zl147K0KxMIuFjQFdZXcxnomGpH+ql2CGJ/ViwzQFAUv5IgYeLZa9XMp29HdyP0l2R0EchWRKlrJaiNk/Hy3cQ2eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6090
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Tested and reviewed this series (except my own patches, obviously).

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Tested-by: Gregory Price <gregory.price@memverge.com>

On Mon, Jan 30, 2023 at 02:36:55PM +0000, Jonathan Cameron wrote:
> V3: Thanks to Michael Tsirkin
>  - Update tests/data/acpi/q35/DSDT.cxl to reflect dropping of the duplicate _UID.
>    Usual dance with marking table to be ignored by test then making change and finally
>    updating the table with the new version and dropping the entry preventing the tests
>    from running.
>  
> V2:
> - Various minor issues found by Philippe, see individual patches.
>   Note that the const_le64() patch matches changes in a set of Philippe's that was
>   never applied. Philippe may send an update of that series before this merges.
>   If that occurs, drop "qemu/bswap: Add const_le64()"
> - Picked up tags.
> 
> V1 Cover letter.
> 
> A small collection of misc fixes and tidying up pulled out from various
> series. I've pulled this to the top of my queue of CXL related work
> as they stand fine on their own and it will reduce the noise in
> the larger patch sets if these go upstream first.
> 
> Gregory's patches were posted as part of his work on adding volatile support.
> https://lore.kernel.org/linux-cxl/20221006233702.18532-1-gregory.price@memverge.com/
> https://lore.kernel.org/linux-cxl/20221128150157.97724-2-gregory.price@memverge.com/
> I might propose this for upstream inclusion this cycle, but testing is
> currently limited by lack of suitable kernel support.
> 
> Ira's patches were part of his event injection series.
> https://lore.kernel.org/linux-cxl/20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com/
> Intent is to propose for upstream the rest of that series shortly after
> some minor changes from earlier review.
> 
> My three patches have not previously been posted.
> 
> For the curious, the current state of QEMU CXL emulation that we are working
> through the backlog wrt to final cleanup before proposing for upstreaming can be found at.
> 
> https://gitlab.com/jic23/qemu/-/commits/cxl-2023-01-11
> 
> 
> Gregory Price (2):
>   hw/cxl: set cxl-type3 device type to PCI_CLASS_MEMORY_CXL
>   hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
> 
> Ira Weiny (3):
>   qemu/bswap: Add const_le64()
>   qemu/uuid: Add UUID static initializer
>   hw/cxl/mailbox: Use new UUID network order define for cel_uuid
> 
> Jonathan Cameron (5):
>   hw/mem/cxl_type3: Improve error handling in realize()
>   hw/pci-bridge/cxl_downstream: Fix type naming mismatch
>   tests/acpi: Allow update of q35/DSDT.cxl
>   hw/i386/acpi: Drop duplicate _UID entry for CXL root bridge
>   tests: acpi: Update q35/DSDT.cxl for removed duplicate UID
> 
>  hw/cxl/cxl-device-utils.c      |   2 +-
>  hw/cxl/cxl-mailbox-utils.c     |  28 +++++++++++++++-------------
>  hw/i386/acpi-build.c           |   1 -
>  hw/mem/cxl_type3.c             |  15 +++++++++++----
>  hw/pci-bridge/cxl_downstream.c |   2 +-
>  include/hw/cxl/cxl_device.h    |   2 +-
>  include/qemu/bswap.h           |  12 +++++++++++-
>  include/qemu/uuid.h            |  12 ++++++++++++
>  tests/data/acpi/q35/DSDT.cxl   | Bin 9636 -> 9622 bytes
>  9 files changed, 52 insertions(+), 22 deletions(-)
> 
> -- 
> 2.37.2
> 
