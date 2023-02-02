Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E916AC61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 18:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjBBSzq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjBBSzp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 13:55:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFF610254
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 10:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COSPq5j66LWok9pM94nBg3Q9Dn/84fZNytzsmBlGDHyoZtGjGlriDacgWVMZ2dOiGXHmXSbrXXTpL23oqTYKnUOdaaY7+ONyDX2tV1Ntn/++41SzGS9tvaWG7+uumlXjLKYkuKWjXZRvECqo+LphmgZmKNydfFOhvz68xD7gDP5M+xTHUce2Hq0wej0/FkQWLdK97eEEGH30ms25X3J1V0Jzz/YLb6DsQOn2af2NHD6G90IY/HQyQc6pCgimhznQmzOM2WKxJAQVBlMFroq6u4UhCjxz77NX4k0pHf/8fnKK8Ns4LIPppdBlA5kipLouaTHaeQfpq54sV/ytj0EoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nxTn/zvciszuU3HB+6u/HEB7H1/A2A5Gy/PYNDut6g=;
 b=Zcx3N1FNHfZSdD7McdcYwbulMKiaEm7RA2V4coo2r6ulPDGz2DQUILJbIqs31I2pX70p3+c8k2tMUu+x9Z5tdJZnK6WUZ/3WKjQT5Aez91jFLgtlxkDNBVSkKbeGLZEP1kehsMCi+QvDfTqpX7e2NsxkQ2fDhVFDpMDp0dmVSwV2IPTfGLoHjGMzMyclegsidSJ7ZYRPkU4lfrhJVQ7IWDt4M1zrBLlVSnzf6C7SPO7qE3ncqY4qORU+1lwBUbG1zUehWSVxPARjPSUlSO++YSK/laPbp9TbclnwznrZbZJ0twHFOAX10ak4mfWXi4ScVWRIl/GeJcuq+pzH+8FuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nxTn/zvciszuU3HB+6u/HEB7H1/A2A5Gy/PYNDut6g=;
 b=JTAsei1E8EPLB4Ww38uliis4+Jy3i3hN7wUa1OaaVi4wpNlm7MFU693H2AJcserO+KkQaHhLfvdT95FKf0jtqS+xCOsujKtO0oBfgNYPaATcIKIJHEtWNm9IqyRDVtS5Ste3N5/H/+RL0etY+XGOxueGYOsZ9dL3Tof2MjT8qH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB5053.namprd17.prod.outlook.com (2603:10b6:a03:3bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 18:55:42 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 18:55:42 +0000
Date:   Wed, 1 Feb 2023 19:44:47 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9sHf+rczFO8q+jz@memverge.com>
References: <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
 <Y9meWfDiCGbca4nP@memverge.com>
 <Y9mhe2xPGRE1/7cC@memverge.com>
 <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
 <20230131235003.GA336751@bgt-140510-bm03>
 <Y9n4zjtwf+w6xnmW@memverge.com>
 <Y9rWskfaz9dLoW+l@memverge.com>
 <20230202160314.00002cfa@Huawei.com>
 <Y9riPw7ccA34FQG6@memverge.com>
 <63dbfe79dbb44_ea22229468@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63dbfe79dbb44_ea22229468@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BN0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:408:ea::13) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: da0f2e86-ff77-4100-0695-08db054f154f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1chSjEa0zRK8PYlwUz6uAk8CDd5hWJ2kd6ZNSymzhzdQIgguxuy/k5ppqBI2yr59VZLxKIUqHn0jjZgsCs3g8qGWzm4FSJY/roZI+JjdhaZVZuhj0kFDWSBz8S4IICkj6jweCubUu0GcZQV6OhbhApTyMQydJT4B5B3CXiTn8Lu5lm5DBOVQgMOtLms2G/p+ZWeeQdKJROMAc502Cc0vzw4wZid569zTI8IYfxIU9RKBuaAGHlCYLithJBfqeeAxQHalgzfxIxDTdehXSbRhiIIwXXjHTs2AYTP4iZQ54TiOSQyRYh8kEUBFnqMsGc4dq4uDLf+Zt40/GehquJjIAsZCWUT9EFfOsFM+Dk81x45QcxiITzMPwZhJQupSgqU00jOQ9kx+XtpbSMJcgJ4E38YyroSDDZ+EC+GawzBarthw0+GMVcourObPDsW2BKp2Hbau07CA3JguTq6bp1RHSlGXXLLkberMXKcsVp4adJOaMEwtzIeHn7kV0xoFoVf292T+OIEa3Sg1LpyEvIG1H+4Qx0FJUzN647txqMGJ/Q4eG+/p8/USMtqgt94/lPnsEL6iGaYiB0tpFnwPQRNpCP03xd6WnneJBV8K+7VBo3LcynnD+8Pz0RBxAgKmNS9cVuuRSZg7lW/kjoJrKk5gJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39840400004)(136003)(396003)(376002)(451199018)(2906002)(44832011)(36756003)(6506007)(26005)(6512007)(478600001)(186003)(2616005)(8936002)(86362001)(6486002)(5660300002)(41300700001)(6916009)(4326008)(8676002)(38100700002)(66946007)(66476007)(66556008)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t7d+g9ftxU9AKeDwJFAZ2r/VUdwxJXYpTuKeZc/dpUlrQoyOmnz+rLsBogiz?=
 =?us-ascii?Q?aGJlUYPZC5HakxYXv8Oa7TsS8KSVXVYbZsEjs/MGakQq8AGIjAwsaydgDLmX?=
 =?us-ascii?Q?IzUYfGtdJ+Lo9ptixGd1VjTYyTPw1aKCfULG0j00t0RWImjdajgfPyBL2qOj?=
 =?us-ascii?Q?bSRinYgP0oCFXJVds+SVWWPOP2ma4dO3lj6khbSrlrsjsMjHpxDOtR/VbzDx?=
 =?us-ascii?Q?b/NWi5HaAQ9uycHrlDfFxuozohMQUNihE6GZKrSeQAd+ba9OWNZcLDJ9kIxZ?=
 =?us-ascii?Q?wOJ44CCu1qI3ObH3SoqiYnxqUdaLdbGuBEWCg1Vts97r0t7ClpRYy6FgV2xK?=
 =?us-ascii?Q?hzt7nwzUIFUqyj+zaEO3vIbBI9dYgj5FkBiHfYODPXzsrOLIKUI07WnjCBN/?=
 =?us-ascii?Q?3pW8EtytHw4SvbhZMfomFrGAz24fwxo2xHHK7QtlMTyt3oEbpPpcBC8K5P0y?=
 =?us-ascii?Q?QUwrPNagnhNkY7FG3xHhxun4KBbEevonxdKcolokcQafWPX/Oc/aAgEgrGCX?=
 =?us-ascii?Q?lYZKKuXD8U0RHNV/6UiT2LuG6AQHzjzrcYCRjKKIpe7jQtsE0sq6S2oEa7mb?=
 =?us-ascii?Q?/InZeESk2/JxCMPYOtxZJGkAPeNKg4vNseybd3Rjh708aWZ6quj1w76T2iD/?=
 =?us-ascii?Q?lnbaaIM9yUYouFlNRNqaEtGiNB5DjbMfLego0/UkhMChU/x0vlUMhiQSh/xQ?=
 =?us-ascii?Q?3rkDZ93Dnrak6TZoh8nu8eDR9doRcY+GuqA9t86ayica+Tm+oFQVXzz0+d6K?=
 =?us-ascii?Q?7/2p8wcwDhMkqvvCyINboRkCI52+wBNmcJidwPCH8qMl0C/+bJ0g3RVChYGe?=
 =?us-ascii?Q?pPU7u+i6zvELt3/h1YJ2X3GGVj/5VR+NQhpnnrlR5TGsd2+nokpV7TZbtNa5?=
 =?us-ascii?Q?b9m2z+T5+tL/rA/TjdilXfurtpmcJtFUi/zEF5f+i4qMxkT4Zjz6I9EWyVFQ?=
 =?us-ascii?Q?VHl+U/mlnqnPAwNhweWy5IJu5kMLfEfRgY2m5equWKdvNiIHCcZuJ9Wzvfur?=
 =?us-ascii?Q?Tn8NdMLW0tsLikqNHW0HME6pQrYLJX40Xp+iYbcB8ZKHJ3ld2dzYvfySP6lK?=
 =?us-ascii?Q?GUnbK8cs2QlsnEllkAfMRhC4Dj584CmW7S9ys0MhedYk5yPuPnm+azIFKV0G?=
 =?us-ascii?Q?uRKTv632EN/ZQMeNgwoTFFZvjnrh+Pur8QjPrEhnF6aUklqCYVAsj5e+M9QP?=
 =?us-ascii?Q?Dxl5Jz5/U//5Rjbc+JxSrH2eoQ1KC8cifFIp8aBanlkv2/48FjKR2rd58miL?=
 =?us-ascii?Q?F4GHAWM3aqCPqxB4sS/zjUwJyRynMB2yYhEVxf7cUFTxZq380POugAx7Iefw?=
 =?us-ascii?Q?KFdwgtaB3WPxN4HsF//UaDACzS01BTNYROlFtK0LVdJdukU40huevuqlJFjk?=
 =?us-ascii?Q?gVKv2dtVnP1oJNRwfyp3V6NXxZZaK1/+Sz0iQ6HXAQoeKhcI2wq3lILjdfG9?=
 =?us-ascii?Q?YFaNoWJ+KtrKn8UPEyO6EvtfTsNaqYXVCyDJ0TK1daryNZ6v+LNRowTVpUTX?=
 =?us-ascii?Q?DIpVn+FjrcqK6bDjIgYoxE88ZeKvYNFfnbbVMVWUxESOf8OQG+UHcumWOiZF?=
 =?us-ascii?Q?4O9Kr/xQwLEZM4JnXmrCptHwijRvsV7LuqleRclF/Q8I6fc5ikqFeHyPbLsu?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0f2e86-ff77-4100-0695-08db054f154f
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 18:55:42.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkLfY+UpINXbRSn0CKdVYd2SKJ3MeHzYx/Dd1WtARo6t00PgvEzxcuv5XYYipXSdLTe5TXLpZZcUUa1NRhcYf57aLtBYRgTihaBVUQ17eQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5053
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Feb 02, 2023 at 10:18:33AM -0800, Dan Williams wrote:
> Gregory Price wrote:
> [..]
> > To me, the solution here isn't to change QEMU, it's to change the kernel
> > to try to get it to aggressively keep executable regions out of CXL by
> > marking CXL regions into a new zone type that essentially says "Use this
> > as a last resort only for X pages".  But that would likely require
> > adding migration code to the likes of mprotect and friends.
> 
> No, this can't be the path forward as far as I can see. QEMU is a test
> vehicle for CXL enabling, there's no expectation that QEMU is running
> CXL emulation in production. The quirks of how the QEMU-CXL memory
> behaves are not something the kernel should worry about mitigating. CXL
> is "System RAM" especially in the case when it is mapped by
> platform-firmware. If it's not suitable to be treated as "System RAM"
> then the onus is on platform-firmware to keep it out of the general
> purpose pool.
> 

Eh, you're right, just spitballing.  On real hardware this isn't an
issue so there's no reason to change the kernel.  QEMU should just model
the hardware.
