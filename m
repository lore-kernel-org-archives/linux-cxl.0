Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F72C05027
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 18:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjAWSQk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjAWSQj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 13:16:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446B272C
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 10:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA62oerronco/sBQdpCpej+o/jMO1H5JL0KEYX9cu4xyZ2duFPVJI7CulWIYBLnqD9gwFsiKJ2Jfu+/9SzVACpk5nc2kFHH1YIN2mjqZ3v47Cd2D51WssLhAANsJd1epNBDjyUzEyMqaCU87CIUU5eOHuO8CSXPSFPbY7blssC9YIx3RcQzktc+pucuFiMMCqLyZVN0aZlC9onusLJTEH8nJrRVjgI5/yVMV+qRvyUyZgMLrG5DP4e9MoaGLijtbufZQ66B1JfZuqPltbqv3QVxXnNe7x8HdrLK2lD7quZ3IxNLfjD6O0e8YjwJbPEPZ9MuyNykNUTViChBN1VeOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFPeE9iLGQlKjGuVDum49q/UVp55MTSSefFQaOogiJg=;
 b=d4R67/1bOG6NzLjwQMAPlchapvKKZm6meyZRL5wLIjQg2VzEkUEtFXnjGOl30HtafrNoO0+RaF5YMr5YAe3+yi5LQ0kdye+YNcRsVeBjnh80nsngLq/0+6t/W/x+KrbmB4Q1l6Au4wk/xoopGA60jik24fgAqU+Blcysn+6S6o0rgI3AdLcebvxMM21A9u9xLZi9/QBHGDf5g8/ihWGVad7mmNW62oxLyfYoCCxQq61ViHUsPjh0gWRl71eC8fmLQMPsF6SspIcXME/ccbCmt2uyLMXri73eelYpnZ0EFk3M7SMaDUoNAmdLwDTUlA6FUTPPNe5HBmg9arHAwP2Bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFPeE9iLGQlKjGuVDum49q/UVp55MTSSefFQaOogiJg=;
 b=CJxYBTMsh1+qN18c549fwbIEw+//08GRxGdo+x1fwxZPP0UDumlrpW7n+cQJmDDERRpWKtLofTkDck1tltOYiYqIoJnEI2vCQsNnbrtrhk6bPDw8+HdO7O5G/bwE69e4XYnoxZEtcVUL0MocQgFSaN+rOz0PR+JlT0Xt1VE1AMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by BY1PR17MB6831.namprd17.prod.outlook.com (2603:10b6:a03:524::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 18:16:37 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 18:16:37 +0000
Date:   Mon, 23 Jan 2023 13:16:31 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: cxl nvdimm Potential probe ordering issues.
Message-ID: <Y87O/3E/66XAhpls@memverge.com>
References: <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
 <Y8hG4OyJL7l9oD2f@memverge.com>
 <Y8hJKcy1993SFLLJ@memverge.com>
 <20230119124244.000015b3@Huawei.com>
 <20230119150449.000037f2@huawei.com>
 <Y8oeYfyqNuSIIxCt@memverge.com>
 <63cad185343a1_c81f029469@dwillia2-xfh.jf.intel.com.notmuch>
 <Y8sNfC1YQVj/DfBU@memverge.com>
 <63cb1881b078a_3a36e5294ab@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63cb1881b078a_3a36e5294ab@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|BY1PR17MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: d5615194-4d2f-4f3a-5522-08dafd6df75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhijLZp2EDUYhSwN+41UmZxJBRC45FyUtFrH0u3DgiRdi2BcvGuiiPlOaUKRy3/aTWzCO1V21a29dt1pOcQ7VxifuI+qZIngP8yUb2wde+U+AsiJ8YH9EbCBGTHZGOHNO80NtjAX51H6CVlIiHs7CFIOFq7za7G0fZsMnKbEkzLE1Reqg1Bndorp+UM1mMXgHamBa7GvNOCwq1FG/y36UUXsXy50ZmqA1hdWUmvwJijBX9FP9eKsqLdgmz160g1Eyn1V8M/2lQs0/AzzTEbpTFO/a4I84y0GZOqN6ReQ8NCCtUHw10Kr3xhyNg+EjMIRsb3kS0VBZ+BLOTCNzTtFW5JpNgeoI2rXW8Fy46xKi1Z0shAuZXTyvxgiEV0oOhjuj/2LBcf2UNOAhYy6Gxdynrt2Y4YYdvx8S+8cNEtB2nM6MswFL6G3ffjDLGoSRm2FsS5MDwy8DnZ5AtJ6fmiWwaBM5CfkBYAgdykMdZet9sXjm/MVBsuMlmEcwP7W6vgG6whjgDhZKE2eCTj503dcWRWDt1fjBLxixXZsO3taZPQMHilNhUsnlHikAUWCILSG5gh7qmoLzfLBt1gnTYPNQ/lJCPzn8oSxRIGJNuM3iVJtd3Z9npeXqte4I+WtdErcfAeaMm/xh+i9nnbrvOjF8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(39840400004)(376002)(136003)(451199015)(38100700002)(83380400001)(7416002)(41300700001)(86362001)(4744005)(2906002)(44832011)(8936002)(5660300002)(4326008)(6512007)(26005)(8676002)(6916009)(186003)(6506007)(6666004)(66476007)(66556008)(316002)(54906003)(2616005)(66946007)(478600001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ie7fKjXk6w5MJb9ssnscpvgqHRzOWXUYUSaTn6UZqUKYzuLWfEhXjR9iild9?=
 =?us-ascii?Q?bP08qaubE9B8z5omtA7aOks4kGisn6ft8l78S0UaDplDFaX2BlpFoZwf5QvF?=
 =?us-ascii?Q?prDxN0sg/TtNkuAR/1NVT10x8g8LtR3EpcSpzAMPpIasVdPwc023imbLkTL5?=
 =?us-ascii?Q?yXDVtxCO7YHAvQKEoeNpqi9bei2ttvsBuS1V6+8iru7KTTFfcZDUNtf9zVBI?=
 =?us-ascii?Q?STcmLrU3JEYlgfhKoKtupZ2kTFlfU+goNQundo5z5M8lkP1jGhCgzNjsUQnb?=
 =?us-ascii?Q?VqO5k7163pUHPfB74kYsu5pXGGZY05okmzLz+xfXQKvd10uYilouz4KY1wUq?=
 =?us-ascii?Q?Wm7UaSvbX4CK3didDg2gioP+yQ8thQHrRmImWIN1tR0eHql/Qpx0dTDGSU+Q?=
 =?us-ascii?Q?KcVU9Rc5Xwn7pJu96zTlWirFTdh47054pUdBaajVJyi8TXNWfbTlcdbRnnhZ?=
 =?us-ascii?Q?AqjehdJeotlKHaZXBeQd2LQmxw1vymnVvqigbCPB+uJba1JC1WG1128wPLsV?=
 =?us-ascii?Q?mPDilOb1q33lYXsKxrHUP4Ywe1UOk25zKCidnkLA8dANNt1un10VBQMCd12Z?=
 =?us-ascii?Q?nTa9+LFcll8GUewIbcV9MeVhYoC/bjDACgatIQxvEAPSrtqnS8GcoSwHUz71?=
 =?us-ascii?Q?EAHcny0xb22veL/hSrumQdSyNUtj9898OMbWuAb+T3VSD/Ef8ti1Cs09OW7X?=
 =?us-ascii?Q?PpOpXgj+rpbWAu9VAqtWctPFoSe9kENXca/V7mM+TCYvO1qy3pWy79neVk7f?=
 =?us-ascii?Q?1/wwSsTHzwRMtdBolq8BSRC32LsXscLcKe621Y7/QSnPJuyZBm9LEELTyvn/?=
 =?us-ascii?Q?jFpGbf0LytSCl1VJ9giESacQ8Jme6AK4IV86NCEMMLMDFOvuvCQ+1hFoub2E?=
 =?us-ascii?Q?D/aQkzs8ycfO5bPghw2w/XM8dmYbyqI490joF2DMLlsnKnV44/lL3CjfJAAT?=
 =?us-ascii?Q?9I70fsZJ3pBrFGAZM+kz+VD9uW+KPfaaBbpwmEOU0ErjPCPJFU67n65C5fe+?=
 =?us-ascii?Q?8Tt6w2QRgf+qNd1sfDKEK24x9yvEHme9y9xuJJoh/3hHGP9KfUl5NtWMabrX?=
 =?us-ascii?Q?Bn1jUJx2ncaXQDljBvZXIOEvpktZqLTPOcjB0mqzP5dcFx3Dx0WwrYRrBvnB?=
 =?us-ascii?Q?k1oTAVhy/K1MJM0BpClkVM2GMQiRAWuzpx9kNhPhESQldxs7I+Mz0I1iO/sF?=
 =?us-ascii?Q?mtaapZDLkDP1Sa/Mj7nfQc7AXiklPwdqBgytME7AZ29rx7Qv58tu9jJTO7eD?=
 =?us-ascii?Q?4+WA3Nb4PYkoEUzU2mjRA+Y0S0Oc5vq2pB8BYyXOWSTwebGrdqcsq0wp7eNh?=
 =?us-ascii?Q?vq35J8wEd3uq4ai42TwLUMb3vJydSup9Lw4Vs2nWHHIN+eEWodRkyRNt80vn?=
 =?us-ascii?Q?+5QKqrRsixyqU46Ggtv9UKX5yi6cuUnT7KTmVuChUPhHw3gNmoqmqTl4AOBm?=
 =?us-ascii?Q?g4SO3DfskyDGf7dACJ3nscQMpNDyq5QelYNqqnJDghQh0fsiuonOxEWMe2xN?=
 =?us-ascii?Q?x3zgCqgGk6qPQy0QWD5eFdHprdoU/7leUfzZFtiPGYNMK8f0zO/xg2CgPxnQ?=
 =?us-ascii?Q?2aSBJEXV5o1wm3eKbKcKCIISLMXDlaymkUS9bGoZe6TXvN88D8C9nzdG6uO3?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5615194-4d2f-4f3a-5522-08dafd6df75d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 18:16:37.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMvd2YeI4PK7O+09BlrOtFU7aTh/WMrpthgh9Oyo3mjJnWKPbuJU0LeF4qfRARP0yj8tyFTOU96fZm6swAiyyK8utzifq25+EjcoGkjCUHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR17MB6831
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 20, 2023 at 02:41:05PM -0800, Dan Williams wrote:
> 
> Which mode are you referring?
> 
> The next steps for the kernel enabling relevant to this thread are:
> 
> * ram region discovery (platform firmware or kexec established)
> * ram region creation
> * pmem region discovery (from labels)

On some bios there is an option for "legacy cxl" which produces the
nvdimm-esque behavior described above.  After further investigation,
supporting this would require a bigger lift than i expected since the
existing emulated CXL devices don't carry any kind of node assignment
and we'd have to plumb that through

Not worth it, better off working towards the new stuff.
