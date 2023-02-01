Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFA9C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 16:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjBBQ3H (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBBQ3G (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 11:29:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B0C61D7F
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 08:29:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNjzYQmPXoJIhuIlNNp7GYNWJnaIVacUA7HKBlXp6/T/FHRUESzXQ5y3CSZpKbFeUnqPAtc7gDYB+TtFh+uEPYh3rLWS7p2B3GHTXaV0PseVNFxae9pvZYMvkVRgbw3Fo+x6dRtLWgLmv60rc75245yD+BU5nmUOyECaEDEqudkR9Ez7B7DVod0NFPDDwgS9rJFRGxuK1Nxg2EdKZD4Y9fArzKXFtx7zLcDxmlBAhb65YmTNbPPFFkDM91pPHdC8pOd05NRhB17W92orchQf5K2kwyCT4ERVDWLIBLkZhy2VGXoYsjjm7DIrZj0r0v8by3bmwQRcrxOz9hg7c/e65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgKJcvKFt+skkWWn5jgj8MapwAiR9w8hC8CGLC/NzDg=;
 b=Pm8rJuyAXD7JrSMUBPbsJGhP644RoVeVG9AVtSo/Zu8teudAVft0W8m8ziJwyibTR6bJTKPmbszjTxAf0M2XkEmGzzyHN002uQj/w1QP52QhMoqUk+nfPX88l0gRNF54HwPuJd6DmjGUfl2ByrdteiIcmkKAcoUn81gVtW6xQ8B7bDDh55E2eeAoVTd2alzRNEytXRiCo0HPFZq7b8JW2bqYelMdhNQd81U58wo9fhMFsb2i9iKCX4g/FYsr6MWqsaoc3aSSCsYR3wwbOyVe29C5b0hSHQuKBDrNZdlLBeKIVpnj0tvNVEqYBw21p6daxGOE5TCh0Av/9WCTJSGv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgKJcvKFt+skkWWn5jgj8MapwAiR9w8hC8CGLC/NzDg=;
 b=tEynsLneQRrH6CohT4XPLpbcVzXLgW37qwosnPZQgnDZZ0GoIOD/jZSh0cxPK798E2ndsi8UgatqdTsbhZpzptcq897iNOoaasAqZM9jr1/UNJmWb4xUOrdEvG2Nn5sjg+qf4LYYICAiM+u0OcvZsJoboTTgtbNFhcH0GyHrSdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by CY8PR17MB6330.namprd17.prod.outlook.com (2603:10b6:930:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 16:29:03 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 16:29:03 +0000
Date:   Wed, 1 Feb 2023 17:05:51 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Fan Ni <fan.ni@samsung.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9riPw7ccA34FQG6@memverge.com>
References: <Y9ll5S3Y4BZkakNn@memverge.com>
 <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
 <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
 <Y9meWfDiCGbca4nP@memverge.com>
 <Y9mhe2xPGRE1/7cC@memverge.com>
 <CGME20230131235012uscas1p11573de234af67d70a882d4ca0f3ebaab@uscas1p1.samsung.com>
 <20230131235003.GA336751@bgt-140510-bm03>
 <Y9n4zjtwf+w6xnmW@memverge.com>
 <Y9rWskfaz9dLoW+l@memverge.com>
 <20230202160314.00002cfa@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202160314.00002cfa@Huawei.com>
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|CY8PR17MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 819bb3ae-6bf3-4d20-fde8-08db053a98ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24bXsmiOGPmhjkjsQb1vp2J0QxIQdOpi3a0dtvY3wBYMKAgZ8Gn1vMpxHWSnfEBIJ9q9h+S3wDh/JugT+F59loul/DDtm3XeMXDe0DsJrjM5wAlzZ3z5g1srwtNVuSX7DrRrwy8ZY13f0aP7nRPORXK4tygxg2YEevsR4EgfqrkKJuoRd4w5aLayGQBJoNe8kDqq+GWr+4duOzCj+vDmbbQuFTKsTVNMoUfIQb6dppFipHp2N/7aJnfcuVUFvtO99KzOhT77yWc7XvcXr1wwUagVCU/9UycNuCnfu/fy2v+Orxo5P1YB3qseHno0hhvN5CPpXiqp4G2tFphUeNVHduoIIgjREKuxZ6w/JpOcG+gIGomXHCPnNR0wOniNiBolHaBVf3t7r4UVxGYnlM9QueISZWNNo2sBN0s/DkRuRHqx9nraZ26wVzDt5+XTD2mvDozKWUFR+2DiRiujpUuNdAYaLZiaDDjsO8IbJ4zioJs4wBUdMHlT4xlQn6BrNBNLqUy6PN321ptOMJGf2Q+ZT+gZXnTaws0MB7XCSLt3j5bkJTOuN7ljt6EZne1vNzGhzrJWsnMvBa+35Xtl6pokhDxVAgBDlUaUnptE1+6CsP3YNuSK/LtLKKuko62EWsEUVQldHXPAsUkEswIegAls27tneflZTWnSMY6qrbiApATrEGYl7WZmV9yHzzRUHdQq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(136003)(396003)(39840400004)(451199018)(66899018)(83380400001)(6666004)(54906003)(316002)(2616005)(2906002)(36756003)(38100700002)(6506007)(66476007)(8676002)(66556008)(66946007)(26005)(6486002)(478600001)(186003)(6916009)(6512007)(966005)(41300700001)(86362001)(8936002)(4326008)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wY5yXc0kGEjRIRRI4JUaNYEj20o1y2+0rEmrmnzDH5cYBiaAOCd8cEoN8Zig?=
 =?us-ascii?Q?m3i/ZjostBlmC7xbMEvPuDOkZdZvoAEvd71nmTQAhLBM7TWDXoBnDLnfDJC5?=
 =?us-ascii?Q?axUYquzOyVapmdlQuc4n6tiXsJIjK/WZnilNlgsIY1jqW13doxQgjsNAhIUG?=
 =?us-ascii?Q?rJ/Lsg8vRFGDHu3hLgx5mqXYGcILZaKspl4KVwenaHpkoLkwLkmw5G3yq3eH?=
 =?us-ascii?Q?qCW+3R16JcxbCsfRJv8jXi1I4eeXOS4QF0HZJY6Q4ExMK4qazKyz0UhCcVHb?=
 =?us-ascii?Q?BQgWPvDZc47AZIMj/YOseeAz4mNh0f2k3GLgvh/MPNn2wg37tbZAI/7YKiti?=
 =?us-ascii?Q?JmbnMwpDSfAN8ldlPhcZlJzp7gbYw853/wNrJE0x7UR4xKLmvCBCPlkKk6Xt?=
 =?us-ascii?Q?IRuSzY/yESlDTEszS5GEI0cAiuUEUlyWrrmQZQZ29CVGXjRtePiQB1j6NWba?=
 =?us-ascii?Q?mUVcx+aCCLoQ6kUFCD2/P+9j15+rFItJeIkFMdVgQRE2UiXC8Yepj9VOZOoI?=
 =?us-ascii?Q?Xr+niM2gjhFVj/BWLYo8yBR/ceT6HdM/r7c5F8V42JwmgEghAHxkeP8D7l6j?=
 =?us-ascii?Q?WC8vjeI3cuZ/DOf55vxM5G2cwTXHzyIZzSsOFoYOd5qx5xc6DoCdD4yRouZD?=
 =?us-ascii?Q?1sSIVCCPYqbcvcCblobMzR1dHFqvJWHeAQwlU6sJn3KAzI1cmOe3KI8gtnti?=
 =?us-ascii?Q?1zrGkThRglMFCgNU0Q00Q2MNmkT9oma3ommkAwaZ/UJnRwYTknLjzqEekV2i?=
 =?us-ascii?Q?zQrvoYxBVy2zDZxJHlEBS+psquu+h0TOr5FserDy709ru8NBJzENJ9GeRj2U?=
 =?us-ascii?Q?jrOc7lEguzZpOUy9g5QGbaGalli8eJ1GXbJMgXAfwUtTtUWgyO5HW4xJ+rca?=
 =?us-ascii?Q?0GtYL4VdFAsWfQfQ3cc0yUprv62kt80/4eE480yzEsm7sKQ4rY7XsSQ7JxVI?=
 =?us-ascii?Q?u0ErDYAuP/Ph+JGSEiAHqyIlEaIABCSqVSf6p9RTengeGH4RZnpPwze86y5G?=
 =?us-ascii?Q?HOPxFR6tM3YJCTmo4wY5TfaYrgrViYsmJ6pvm8p6dfmlQ4tJZHYVty64yOQL?=
 =?us-ascii?Q?ZsfxaACBU3SwBpxMsvQJHZbAlS0Y8WqzNr8BII4VzwZfjwxCGLOVIwZd490S?=
 =?us-ascii?Q?Z02Hn5ywNWfQ1+Ovw5nCxzVSVpbYKXVvQjAsiNc7M6g2LdYu8ucewMIMuRlk?=
 =?us-ascii?Q?NbXZR772i8d5+HnW8jXUHBfwMX4yl5qjF7i4EdWPZWkacIgFUsqIpC9FKkwz?=
 =?us-ascii?Q?Qvl5YjWtD8GQELZH9lE/ZXlvzu9Tl+YkIR/5p+Mb8XsqsDdQ3qnkK705QxiX?=
 =?us-ascii?Q?hRV8le0LMy58PgHzkQICafEDAnv5+mfEJMUNVwfsmMQ3T7gFwdH9oA8OOscY?=
 =?us-ascii?Q?mwYpFWV6AvYUMhI6Nb1NQ5qccfzxUxaAnZ5T0TA6nyDtOIwcBsnSbLKgbK3r?=
 =?us-ascii?Q?Ww6u4g0klZ0y2hPQ74shRJZyu3Q7rZp33K0ud288int2PUNvabgGlOZT8tTt?=
 =?us-ascii?Q?1DusnwIpTNRHo0+0KVkFsIqv1THI5wU8Je8j7mXGiTR+dlSLj8jm3Z9fck97?=
 =?us-ascii?Q?2MuXnEFTtAti7hhIl/FqhQN9dWwA9mRZ++DKL6rhdBZQHsAAzQgP3hkdkyVX?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819bb3ae-6bf3-4d20-fde8-08db053a98ab
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:29:03.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFJgYFmCEwVehLS+oLIYW29ou+7GZ6wZ8Ron2nmaGdUO9Z2mxCcxNUCNAa1wmmPP1xR0JdtI13cO78C0q2d+93z6BWNTWHKrCvV/hDxm070=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR17MB6330
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Feb 02, 2023 at 04:03:14PM +0000, Jonathan Cameron wrote:
> 
> Note that there is another QEMU issue that needs resolving if you intend
> to use this as normal memory and it's worse under KVM. Effects the
> corner case where an instruction crosses the boundary from normal memory
> into CXL memory.
> 
> Thanks to the various QEMU folk who are helping us figure out what to do
> about this for the explanations that follow!
> 
> We currently handle the region as MMIO - in QEMU terms, no actual relationship
> to what the OS sees (as need to mess with the address
> mappings on each access for interleaving). That's a problem for KVM
> (which may not cope with sub page granularity remapping under the hood).
> 
> https://lore.kernel.org/qemu-devel/ff3f25ee-1c98-242b-905e-0b01d9f0948d@linaro.org/#r
> 
> Also a problem in TCG because the handling of executing out of MMIO takes
> a shortcut.  It is fine (though very low performance as using a fall back path)
> for fully in MMIO regions, but not the corner case where the start of the instruction
> is in normal RAM (with all the related fast paths and instruction caching) and
> the end of the instruction is in the CXL MMIO region (a CFMWS window).
> 
> Currently looks like the fix will be to use the slow path for this case.
> Patches welcome!
> 
> Anyhow, in meantime beware.
> 
> Jonathan
> 

This all tracks, and is similar to what i've seen on other hypervisor
platforms when attempting to execute out of MMIO.

The reality is that CXL is not MMIO and not RAM or ROM or any of that
and is intended (eventually) to even be shared between QEMU instances.

That means it's likely going to require its own MemoryRegion model and
some deep dark corners of TCG and friends are going to require some
updates to make that work.

Whether it's worth the effort when the intent is to just let the
hardware handle that in the future, i don't really know.



Some speculation here:

The crux of the issue, as i understand it, is the invalidation path.
MMIO doesn't traditionally have a mechanism to tell the caches "hey
i got updated, boot this cache line", so whenever your compiler accesses
MMIO it - at best - does a fetch-and-discard, meaning that instruction
translations can never be cached.  That's the source of the slow down on
the QEMU side, you're constantly re-compiling the translations.

On the KVM side, it likely requires a VMExit to handle the MMIO, and
when it sees that it's an instruction fetch it probably just falls back
to emulator mode to execute the instruction before re-entering.  Maybe
there's a mild optimization where it continues executing until it leaves
that MMIO region, but you're still getting QEMU performance over KVM.

So that all makes sense to me.

To me, the solution here isn't to change QEMU, it's to change the kernel
to try to get it to aggressively keep executable regions out of CXL by
marking CXL regions into a new zone type that essentially says "Use this
as a last resort only for X pages".  But that would likely require
adding migration code to the likes of mprotect and friends.

In the meantime, sure would be nice to have a userland program that
grooms software to detect this problem and migrate X pages to DRAM.


~Gregory
