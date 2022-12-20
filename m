Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1FFC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Dec 2022 19:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLTT1q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Dec 2022 14:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLTT1p (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Dec 2022 14:27:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21983186A3
        for <linux-cxl@vger.kernel.org>; Tue, 20 Dec 2022 11:27:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flilmcRpaB51Hw2fj/1ZOKarjQq42G8umEJZ8lmAOmY+lBw6ri8Kyar9LgQPce8uAbySFD6pB7QAuAC7m5r8WucMIgiyPjkyv2xDnuyxeG0nmTWH++mJK7qrHkuXf0HPLZtmzotijwH1UpBsyRRxJAL86YqBGYIP7HFSIc3kaJuxL7EW+NEqwbEGq/82j7BeUPZfkb98uqcLx78J3eyVVbbNSjkCa89i+wTdyiVoy7fDXzDW2z71D9hpJ0UPkK0fzTxR29KRgHT5IVdhzQV4cmHU+uBbUk32stlvEXbYiblx9Q78ORAoc3oa7mujzHB5zHiJU3TtwcPDSnj9irhKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3as4TVMyY5VlHxb0SQhyBYmcK0FgnGrCFr4RPlXlxak=;
 b=SHOHBBlkQimsHEjN8WXaT88gTc93SS/epjSCQy7d09fMPHTW01Z6Hwja48UcWOxz015RM5T4zaoEdMSIzRMUNG4jdce/U6GwntUYNTZATJjh+sbb8RpjAZVm4O4u//RTQEnANBHgMq+9EZX5SE55Kv4qkSpy6OMPSMfMZ6dktVgy7N3tF4sWk46c3chfXsCzlkvuosGM7INvNgWoCg33R0F5+vzDDScultcwKbIFJB+EH24OQ6mkJW3yUQ5yqZQHoZJ+mpbj4SfMkE03XtFcxNKapAvJ0qvTsEFavfmhqoqibWrOjA7lU3qwGK5/raWAbQz5/gJAf1Kzegvck5Jyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3as4TVMyY5VlHxb0SQhyBYmcK0FgnGrCFr4RPlXlxak=;
 b=f1HXI/vC0OSbvsgWCMBWhHMlYDm4HQAaqGx9NSeC3OFN1gdeNbE1Z/f3/MTKLnglL728ehmqofV5MJGOFZOW2yptaXRD36z6EjwGZ8Qi2br4a97WgkcyXcUTrzKxOr/RJ908hvwZiWEIAQfmJvom+nIMefXeUdvGjh863kkgsgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DM8PR17MB4885.namprd17.prod.outlook.com (2603:10b6:8:28::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Tue, 20 Dec 2022 19:27:41 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::3299:1f35:894f:69df]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::3299:1f35:894f:69df%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 19:27:41 +0000
Date:   Tue, 20 Dec 2022 14:27:31 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <Y6IMoxKZOc7eUPCg@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
 <20221128150157.97724-4-gregory.price@memverge.com>
 <20221219124211.000032b7@Huawei.com>
 <Y6CNcuIzUVmKL0SM@memverge.com>
 <20221219172502.00001338@Huawei.com>
 <Y6CloIiuruB/h7qp@memverge.com>
 <20221220153453.00000436@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220153453.00000436@Huawei.com>
X-ClientProxiedBy: BYAPR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::41) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DM8PR17MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: c7825579-8a48-40a1-ce14-08dae2c042da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLDdqofaarON+tCe3anyIhvdv3U8NRnaZa873BCAHtK10T2mPMFICr6WkmWOZm73NFzDeGxv86DmXDC+CjPmlJtEV/uhTOwxCQ+quNQ1/JZeF119MLKhMAfMLryU9lhb1LWXUDXO8AlEdf3Mo+RCbov2z3JLt0uSc1fn3Qu0ak1xpJSdq97nJsOEP+uUovw7V4o+T4JS/9BN7IFOWpnRSg/P0QUYy9r+PXSTPom/UxnrqLlIn+zvEOqMHHzWNGcQ6H/j4klFmOneeiXDlR+sijzG5VaWUka+kI4EHeWn87+mvWNaOVP3Fh2CTDkC3Ir1PN6MMN0Gqeo2/VTA4z/Pd4hZsgKNa0IGxzBXgRtLaXhqafodQz3ORo+lD+QQGHkk1lXY3gjz3oqyr4JWJLvelJJApm9Nnp+HMDtnQ9ZVFkRrFsW86aV0gdchtOL9gUE366l9Vqpgm0ewN/YuGxXQDA+LPpJUlj7fN0cgKWzJwakHYT5k/ro321tMoP47zN/sE2SLUXVrjxFb6hhQlcnPYqvP5fHuumrShIMFQUKKTx58zveiqZgw80KMIHmnC4PDVkFvF2D0TYeVLad1EyzaYpiLi8vvqAhII70/5xzN3vY9J4+O3OxkxroBuDjVuLxqZVFOK+F39tUB89KOn4gdWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(39840400004)(346002)(451199015)(2906002)(86362001)(4326008)(478600001)(66556008)(6512007)(2616005)(26005)(8676002)(41300700001)(6916009)(316002)(8936002)(7416002)(6666004)(6506007)(38100700002)(5660300002)(83380400001)(6486002)(66946007)(44832011)(186003)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ffx1kAt5+T18ihhKFMZrC6SldC02KHNQdSv4TGD8EPkPi6spKFbks7nvea+Y?=
 =?us-ascii?Q?Q05FucWYRDNMQuRsEIuKgiSzd+/oaXEqU7pk10TEfBKDydVWY7GR49fj+4Y8?=
 =?us-ascii?Q?hB+EURaNS9dyGeHl3kA0Q0B7G3957qt6LXRq9TiL913cNb8qraShNIYngqOL?=
 =?us-ascii?Q?faLNESP5bqgRwa9ThzjaEOM8bxji7LM4uGXYJxcMVNz/lMn8WxJqIH6zsHzf?=
 =?us-ascii?Q?Hd29Mpljif7s6Pg+G+MDoX3+DkSr0vkGY/XWRaEBb+JAwbrJd8OlVC+Mz7i+?=
 =?us-ascii?Q?ln2Ms6UefNEDJOG+OaPFvryubDyA/jAibNdTgz3Zog/CLA7naYTgGi6sVhTq?=
 =?us-ascii?Q?JKnilPShuIQTeHn9tsnRrF02XOYiLyW89pzl0tfWKuEqo7s9452BPJT1ZAW+?=
 =?us-ascii?Q?tYZ9WHQ7IBs8f1hA8/hzLiUnu6vShaqGa46aOmbPpEc7FbK0kE1jA07zaRaQ?=
 =?us-ascii?Q?w97kpOt5uwZA03IV1VlClURADceefoCbc6torM236FJnMXHiOM0ASKMvToiE?=
 =?us-ascii?Q?5qZT12kFBwegOFMHaObZuCBU37DKOmrM9vPZjZCjkiOjHllixNuo3Z4RtBRP?=
 =?us-ascii?Q?ohnNWDRJsT78Thm9kDzu1rBWv3QUYNqNbaRfGijgfpsVRH2Yc5uWPHSRG2CX?=
 =?us-ascii?Q?7HQTKyTf437VGvEF4T9BpYc9w1TlPZx8vrdxrKJOlWOVQvK45UGpN/a1pfiW?=
 =?us-ascii?Q?EYGmcJSpIrgoF6O9ZCwFt/t/kF3KhJqvicyV9Wb7rOwSEDafUyAuWBDb69BB?=
 =?us-ascii?Q?V9AYsttg9xNqoMwhBN5Wr/TJrNMOJP2GYFSUexSlMxiWAv7f61YDSZXGKQKq?=
 =?us-ascii?Q?XgaF/pqE/L2UnFCJTXMNjP3pUpIPHvWlEC6aWAIbc3SdXyuo5h+GK8wPldsh?=
 =?us-ascii?Q?qXBNrSrtC31jisXQoZJSNs7snUDAvUkm9aDeDfVMc5Q35LKqIqL0eXa0zPOJ?=
 =?us-ascii?Q?2cfN4NbYbJEW0GF1AO/hvgYIDtU0K9gUYjah7Hi7l8Ojbgrt8AJoDALxGLtL?=
 =?us-ascii?Q?nWuaqot5T/i8V687X2R5k8uPgL/9Dh2yVFmmy8MFxnSBZDUJRgSSCmUv4gZE?=
 =?us-ascii?Q?kPAOWzk3iY6EcE1lwwzCEsZHCVxX1Jj025znfI4nzyphnjpjqxJzqpEtJJrQ?=
 =?us-ascii?Q?PlOGMP2bFelIVqwEpaorJ0C78/A9gLDByNB+3xqKVuGfB/pwRVL7Qt83PFcB?=
 =?us-ascii?Q?BrBce8LdSygrbk0K9Txq1E/RfSHynVJywc0zEBSkGSrxPi7MTHE6GFvAR4VL?=
 =?us-ascii?Q?aQ3jOsq2rbVM4MOwhQB6bnKTbu96LQVsgB6O15e4cQFmJXFUHQ2/zhWtumrG?=
 =?us-ascii?Q?MOobm4oYOEF6rjafz1RMHExfTCrKyuyVdoXMWtjeI/O2rSH7rU0V2NXwwrej?=
 =?us-ascii?Q?9LxVQRPinqx7QLNX1jjujWcdcP6AWDBqd2Yn9p9Qlu9wJzgr1W+dUicxBIjw?=
 =?us-ascii?Q?xev7YdSLFZN3ciQgCDpS9um5jCa0dS0Vb6GRchy5t5LizZr0y7tB6+/o7Vu2?=
 =?us-ascii?Q?7JvjiO8yowT12pbHAr9JRt7Yz2PQ4m0rZJOGYOWRs1dBZq2e2ohQtr79C2NQ?=
 =?us-ascii?Q?IXu1PV5+0KfrC+6T8G3zLi9Gz7zpoBebmozqLtkK+KHR5icBPZh7C4Zor8FK?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7825579-8a48-40a1-ce14-08dae2c042da
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 19:27:41.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7uwI1QLwrOMGiLHNRlCHpEBA4F+y5le7gaFI+FtwhjTvxz/DXSyfmHdypL8PE03aRtBKBNA9ALqg/cGoR/jFv/bsiyfuFy90ObMVLfz3w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR17MB4885
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Dec 20, 2022 at 03:34:53PM +0000, Jonathan Cameron wrote:
> > However I don't think this is successful in creating the dax devices,
> > and therefore the reconfiguring into ram.
> 
> Sure. I only bothered testing the it in some dax modes rather than via kmem.
> It 'should' work but more testing needed there.
> 
> However as you've noted, that only applies to the pmem regions at the moment.
> I wondered if you'd scripted the HDM decoder setup etc for test purposes
> (so what the driver will do). Alternative to that would be enabling the driver
> support. Not sure if anyone is looking at that yet. Final alternative would
> be to port the existing EDK2 based support to work on QEMU.  All non trivial
> jobs so may take a while,
> 
> Jonathan

Also, I'm relatively new to this corner of the kernel (mm, regions, dax,
etc), so i need to spend a week or two with uninterrupted tinkering with
how adding new memory regions from these devices is actually "supposed
to work" in a dynamic-capacity world.

At least in theory, the partitioning of persistent and volatile memory
regions on one of these type-3 devices should end up looking a bit like
dynamic capacity when doing runtime reconfiguring.

For example, considering

Device(512mb PMEM, 512 VMEM), I'd want, at least i think

CMFW-Volatile:    max window size(1024mb) - Numa 2
CMFW-Persistent:  max window size(512mb)  - Numa 3

Then we'd need the kernel support for

1) Online 2x256mb volatile regions in Numa 2
2) Online 2x256mb persistent regions in Numa 3
3) Offline persistent region (256mb:512mb)
4) Reconfigure device to 256Pmem/768Volatile
   a) change decoders in device accordingly
5) Online 1x256mb volatile region in Numa 2

The question is whether you can do this without offlining the other
adjacent regions.  I just don't know enough about the region subsystem
to say what is "correct" behavior here.

On the device side, I need to go look at the mailbox commands to go
about implementing the reconfiguration / decoder reprogramming.

I guess the "decoder" reprogramming is essentially changing the
read/write commands to adjust based on v/pmem_active vs v/pmem_size?

I suppose I can look at this chunk next.
