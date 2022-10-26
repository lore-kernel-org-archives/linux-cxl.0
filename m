Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DE3C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 21:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiJZVID (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiJZVIC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 17:08:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A127FAA54
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 14:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsrhHMTOTMA9HkZI9sma150G7Z+patwPhLYD2pd9k/CupX+oGPqOOoRDVdjWJ0q0EXOpL0za6dBv3p6mj5EUIchbc1ugGoaSssd2MX7h3I49i+16Pb0lRWls21xNdmF2tNkYU3zhzlYXY70KkQPq1A619wiXDZwKHmcgTx2a3F+6ydPr6Ri9ykVG/yqbek8UAr/LBZh3J5kLyxCb7UOZYhin811zmbniyfbTP15+j4tRqJFgyyTAj9aQnFNrYrC9Ye38uOXoru+hiRqFXCwKs5NjH1JCtbyxnc7RCQEVE0dT+UL9NVdxIbwoeBbMy8vb1Wwi3S8mHs6GW8b92jzrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tXLf/q2qomREGN1Cd3AyTjw4/EKaiTQznv0jifv50M=;
 b=CDjhLdQsInnIKPC8/WRV+RhRi/mKqykYBzfqiiWmRaPdbh9yj3KK3vXSK++FJ9xFuRemjo9exiTNdJyArlRUEmMs3dEU4v7dkU1DJgbuSV0/zWkuZprk4uipPBYO4EXP94pgGn69n7MwZEj8a3IDYvH+zD2GQkYP3T9HlqbPbZJY0q/Z79dpG4YuDSEAh17nYR3k1jpwpW2ynQzabUQTSyXlH+jN+dM3st+SH9iWcVMMah1CTe48ayvI9GIo50JRxquzzFbYcF90f9MAZ4A9G/s/ybtsZ+w3ZvJz1Piz3zk3B+XlMpPSptnx1Du+n6CzFmZjyO18yGQ3N2b5gvtRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tXLf/q2qomREGN1Cd3AyTjw4/EKaiTQznv0jifv50M=;
 b=cOXaxBxzuaNKVUiCX8+QO1U8lI3rTH8Lc5yX5YDTOslj2RP8l52y19sFDb+tlCFwPvbBd8i6D7veHgv7seLRxyV5AuAHSwJ5aAexnZ6G3UgkiEMLKt5ZuXerWORXpR1DHLxSLNyGuO+XhqS7SKcd4PKt+U/WxePKlVtZYTfNkt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by CH2PR17MB3927.namprd17.prod.outlook.com (2603:10b6:610:86::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 21:07:58 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 21:07:58 +0000
Date:   Wed, 26 Oct 2022 17:07:53 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl: set cxl-type3 device type to
 PCI_CLASS_MEMORY_CXL
Message-ID: <Y1mhqcCirwpQU5lH@memverge.com>
References: <20221006233702.18532-1-gregory.price@memverge.com>
 <20221026160545-mutt-send-email-mst@kernel.org>
 <BN6PR17MB312197C4CA958ED267BB576683309@BN6PR17MB3121.namprd17.prod.outlook.com>
 <20221026161044-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026161044-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|CH2PR17MB3927:EE_
X-MS-Office365-Filtering-Correlation-Id: a423e456-8f12-4ece-605c-08dab79628cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vknjgLffcSoUOq7P5L/MwEVwQXMZsASsPtvFBrpI2b6Sko85nQdkINjkhPVwuESYzXRVReynJHo3kK7fg+qtqO2riUUeN32u4E1nwZmCalbaH+x3aoPVZvAT+G4XttOJts/Y5Y1yycRJ5hwPsf97B79KvYTKc0VmiQNHkeGn/TGbqOOOWGVMizHhSprlQDLpl5hxcpWkmnIXLtjLGPisIYh+5uH6yoT0D8vDGRaYnUqmKPIQJ26LUmszRIu00pDrQwOYLlGi6FbIJtNlkB83HkVMduRClETQRHEmYXaYF3vjYd6ij6+VcR4vSnvb05EFYrtxfM0q6d/PWHml7njrf0rwYyc4whkSLm600ph5GVYvFSIRiXLoquNZ3tho9MC+rFPlIQbviK64zE0YdxNjnh30c3Yp5XkV1uFeJcgOQ4gxH+8nRz/puVch74VxmAKC1aZWr1o+omrXZcfoecg7ZHSzlozLjnIgNVEafHZah6x/XOfbDZCb+bzwZSld1c0Tzvaaa7y9WBGVoTwczfOFaDOVyzbUhZ8BT+aK+AYlJoIS3pGwXUeh4TAgCAPEzX5ppez1FSfXZ1YS4fBmKj7nDhJN2fXnEuxUBmYuU9rnB9EqEyjup3aGKmtEAxJQ8MhvBC37HYUrvBAQZ1D8uomswEAfrjyps//EMj4fAfWh2E9Oj8NLfRKqclX9EzdyUPJa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(346002)(396003)(39840400004)(451199015)(6486002)(2616005)(2906002)(186003)(8936002)(478600001)(5660300002)(44832011)(83380400001)(6512007)(26005)(558084003)(41300700001)(38100700002)(36756003)(4326008)(6916009)(54906003)(86362001)(66946007)(66556008)(66476007)(6506007)(316002)(8676002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5umm4O7ucVUpTD1YKmE7y+BTiFla5Wr9UiZGWnm5DMduwrZqpIrZ1FTLLLoM?=
 =?us-ascii?Q?QZ+Lyh6bdE7EWs7gyzAd/7Ti2A34yjgAaeILN1eh4jftv4+wPsZAme1PSq7U?=
 =?us-ascii?Q?Bcv+TKcacoy0dGhvpAbqqalTOPXG5ZMpPIMmkefNssbs3XmSYqBjt90MzaCd?=
 =?us-ascii?Q?6rrTI6nodEodBi3SAVdppeb6Wh7HnR3ZxyH3MyueUZ2Ls4xyCFpaH2ExuYXe?=
 =?us-ascii?Q?K6HabYGn3VcumsmcOEjYWjqBAzgU6Yzusxrhcc0/yMyxTk/ZlUDz0Au1mVKa?=
 =?us-ascii?Q?uIrzPqOoPwqlL9wkZCVJoRbiN2IAZMbHdYPdgc+Aaf0YOoM5CinrtHXZ5lkf?=
 =?us-ascii?Q?i5zyCZFbXSSxjZmhxOOC/B7xBPsn5V20dFxH2kEVuYoEfkK7f8PX9VBZvYxB?=
 =?us-ascii?Q?DAQ12e/qeAcepId6cqyU/VYzmrKuymQMAM+id6FcPeqx1Th/0Tw+3yoleoSI?=
 =?us-ascii?Q?QqPc6zjPlg7C79yrtqW8uBT2K1eJ5TEHn6DFaZE8aNYvxkNcdAkgDbwSSI8+?=
 =?us-ascii?Q?EZtQfsC5Ro5XI/jbR05k7RSh15yK81VRYM70t6gddI2Vp6XIP84p56kbDDnU?=
 =?us-ascii?Q?GVOgygniZn2vCXOt847f4pOBcoB7WXj/aiEZYqeqJ8N2+Ueb+10egaBaDQjz?=
 =?us-ascii?Q?0bvWwsXn2rSNIe+cWiqRRwmcEDvNE4i8wrvp5UOGInDJEMWeTIAD+541bqvM?=
 =?us-ascii?Q?xv72fQXjnxKgGeXvzjdFwqfONhpMWjIcnXEFenXpS/sU/qS+Jjc3e45TxKgL?=
 =?us-ascii?Q?6P4O2AkxoDk+oAG4R+vF8uZwytgcNu7bSqLU+31pquj6wk+1JN3dhw4D2lmd?=
 =?us-ascii?Q?zQ5z6usmUud4Yh2eHBLFXvD5CWKwr5qBC2qkHXo+LONUwoM1i5weq+4kc80A?=
 =?us-ascii?Q?bzUh0Sh9hQmuVg5EU5IuF2SxfLgzAt5BmXVvDwPhTEN0QISJUAeuJWqRl/xX?=
 =?us-ascii?Q?H40UqL+D2LK6AEe65pAXqVO/5D8PaUchQ5eLRurAdodqLeMF31aNO7X30+0L?=
 =?us-ascii?Q?Zlw1Rp9aTklDmm4gLTUtx/hlzt7qIcsMnNdFIaPaFDwLmxPLLCvbj6Ie4B6t?=
 =?us-ascii?Q?2fwBr3eoccXcAXEHsmCKbXkgfJenWDP8voGV8vGeT3rcH/gC3x8OzbxuhEBB?=
 =?us-ascii?Q?RUKhw1iD5GjIgXeKsZjOw6568cqJaCRcAfOGJCgzaOroiE8YrJHD6UufyIdX?=
 =?us-ascii?Q?ArLAjsPlN3TAWioK4wKC4yWFeKwLcDcc2TM79tpf4lKwTOn04xZOVcX3w86q?=
 =?us-ascii?Q?V5ESjFVx9O8tCQOGGt14OD6dSXESf8cOUQINDUz1xqcPfLHtH4Nu/dG/K3Aw?=
 =?us-ascii?Q?ivfthwAdq8MSNHm3d9A1WyVeqGmKTZ125JG2YJv+B3yxwHgHTHMLjy1iXbYH?=
 =?us-ascii?Q?kSOkvmJH0Ia4bC/UM473MHQExA9csL1NMIHyZwhR7nsdiHVniTzH+xx4Y0dt?=
 =?us-ascii?Q?6Q8CYUckV6xSnU6NU8Q3HTcCXJuVLyBwK9fHx1I5E7VGlb9D3rQrR6HrTgqh?=
 =?us-ascii?Q?+jIlAF5RsasxuzhviBh9sOyh63aZ3ESmVuv7xjWyD3I6QIn+Nyuw0S3uaTjY?=
 =?us-ascii?Q?y+vEpFkhBNK+VKdVyZ4WrPi6vbk5bN0tJwvYfJuO5zOD3d9TePe1fK0bqWQk?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a423e456-8f12-4ece-605c-08dab79628cd
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 21:07:58.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGF/1THz9cVZlTvItUPIX8NkZiWX4SF+fSFvOrenXcNPtbQc0ELNYNh78pJGMtodqnWTCMl4h8eYgZedGLGEk3wuyJdcVVs4lIQyn7K4k7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB3927
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Oct 26, 2022 at 04:11:29PM -0400, Michael S. Tsirkin wrote:
> He does but in the end he sends patches not pull requests.
> I don't care really as long as someone will send it up.
> 

Jonathan will submit this, it's not a critical issue so it can wait for
the larger feature set.
