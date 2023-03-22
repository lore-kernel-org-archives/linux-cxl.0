Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA96C6FD20
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Mar 2023 01:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCVBvN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCVBuu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Mar 2023 21:50:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233F959423
        for <linux-cxl@vger.kernel.org>; Tue, 21 Mar 2023 18:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLtJFPJP5dm5d6e2e37RiNBh1cQrD3xqbPI4l8cFzjLLMGYbR02Z4ht1TE3cTLDOM+cBEyby5j7FVbT1jxtZe3rWZCNWUpXLclzm44My/x92i2oeY12LwmOWy45Qq4wzC8x1Rqdchzqn9lJZG68Ob8RyYGzAs7BCP9yrdBPraFIs6GiuidwIPZIzDjyaZw7E288QamhU72uZF1/4D1q27Q/N9VEd2Y7gCMXAnREdi5YTAFegVh3epE7ecdkdoyiLCFDu8TTbnRxCdGLQvNbbKpRFQenTjBbBj5zKcv3Jx3RVUVFXezrkk8k83GIUewh1WuhF8jUWVC9jx56uXITBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8waPJsCD4q6BvFYn/Z+FxF5wYT2oMEBtX/103032O+o=;
 b=JMaVowFUQKH5mnCkHEg+KzYmUTE54jc86up3MvQTxm8pyrCxTtt8JfV+p5XuvirmrXGIj9oRKOpejWL/7oy4MvzfeaI9v6eXXqcZNtPbvCp6m24CesdQM3iX9fxFNrjuj1uH2zl8ANhIN1cRUZRDeuyBBrwYITfeCQY7s9gneJxf60ssCnIonDUpIL9qlb6Ci7S93xdN9bml7Li/fOl8u6nNEmKHG9uGulOcSokUNcZrY61sw3MJPoI/9qxwQlVghbNFv6B5lUWerPS1M5uul9tDE7qDWU+zTH38dBZTTd5MqXi63AxcYEndTVhU7DTj0Klcff5sxvDN55EoJRiqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8waPJsCD4q6BvFYn/Z+FxF5wYT2oMEBtX/103032O+o=;
 b=JC5lzuMy6Bml1uBV3JGXdWLL7FOM8veX2UdAStetgojvKS6IxtjDnbRjII/kIuX7eNHGlC2HShHCiwMbHgH/ZsJGmP0jQj3A/U8+4d492I9R8Mzhi16dpIryC90L93PJbEBIu4rvwqxgcQ8zCzfiqtANDbTRDCYI0KW2sVjeVOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB5069.namprd17.prod.outlook.com (2603:10b6:a03:3bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 01:50:43 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::12d5:2d24:8d15:1c05%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:50:42 +0000
Date:   Tue, 21 Mar 2023 21:50:33 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [RFC] cxl: Multi-headed device design
Message-ID: <ZBpe6btfLuuAS35g@memverge.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: f93f3fb9-f406-4269-b868-08db2a77d822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RTjJf//djMCXa/kYtslgrhxKKiJzI80vubKcTKR0iU+KcqTCXIr0JXM0PhAO1IkZF2Ms//5TwRvKRlb/PbakNcvAqNsIJuqdXiIJ1wC+qNYCnWxZihv2Hj9ocwctUl5E5lnzmN4aVTMJHP4Kx9B2qZa9bkm3WTgLWyt2wavKoN7zPwbwYERlaeDPt45NCCHgIHWmd4C+PuE2gHcImvVxnrXqCrcf4cnfcBJ5IXlpap9e7CHN/fEr2jWlw8lHIFdP2O3Cmh1e+dAZuhjit4hDRzGpOSCVxX3EyJMXdQd6Ouqgl1OtO1uLS1Lv/JQ3DrPdH14jd9O7zojWm6PPMJ0UX/d5btj+7BGRIBOOyhh34UoSqM3pxZk+GX7KQMRfMGRvwzP6Oie4R0R6FzF5+jZMDWnDL3HgejWP5qayGhiNPcQRuIy5vDVf9YwW4f4BvrX+y9+5j3URMqW0rtXNxPCQcwJhk7IWm0CMDccwgT/JBQrrxnEHTVRxD94wiQop6G6JvLK2lJlGOBYNoaoAz9N2RLqioYLyhLaDcNNBEtC/8J05RmH1YNrmZt8yd1Wqn6gxfMi3lmbQAJPLkQ910hFxwSZ02c/1h5/b47C0zOSDR5Ccx+ar7ndZN5PwTD+RT1c70JTzKOsGgVlG7LpG9NpOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(346002)(39840400004)(396003)(451199018)(8936002)(44832011)(5660300002)(30864003)(6512007)(41300700001)(36756003)(86362001)(38100700002)(2906002)(6486002)(186003)(6666004)(83380400001)(478600001)(2616005)(6506007)(26005)(54906003)(4326008)(316002)(66946007)(8676002)(66476007)(66556008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1Z3andVcVZGLzFaaEZZMGdnOGNUTTFLL29sWTZVUEUxdXUxYkx2U09LWHhm?=
 =?utf-8?B?WlVHdkFpbTdpelNQL3F4VE50Yy8xcSt6NU9pSlBaQkU1bXBveUsrVkZ1b0dw?=
 =?utf-8?B?c3BZME56V1dqcDgyOWJLY3MvZ3hhVm93TTd1MjNUU0Nzd0xlaHFpdVdiQUNn?=
 =?utf-8?B?NXE4RG94UDAvNVNSY2VwSVltKzV6cy9lWjNTc0xib0U5ellyU244RTBiMmo2?=
 =?utf-8?B?MDRzWkNoNkd4dVRpa1BVVlhmZTB2ZVU3NGY2YzRLWUZ4UURVckJKK2d2RERt?=
 =?utf-8?B?bWpuQzRXYVEydHBZZlFTanBrOEpVcGNEWHpDei9XbUxoRGh1QllBS3lYbzNX?=
 =?utf-8?B?emhRN2tNK09hejljQ0REa0RTanRSQnQrV3prSWFZTnZFdlUxMS82TDVxVlRV?=
 =?utf-8?B?OTRLZ3NiRFdlSFJxT0cyMmRrZlY2UU5LNVdiaWtXN0EzdlA3OHVpM2xHeW1p?=
 =?utf-8?B?TFdyalBuV2twaTQyd2gxdUpDWHB2TkV0RExpWlpPblp2cFg1anRCcURSVzJZ?=
 =?utf-8?B?VkhBelBZM2R3L1F4eWlrcHVCZkxYMlh5L2wrRFJicTZFOWp2QUMyR2kxelFH?=
 =?utf-8?B?L1FGbnR2ZVRMdHdKNmJDakhwdGdrUVloOWdaT1o0QjN6TXBKQVRHMUR6U2M0?=
 =?utf-8?B?YzdLSVM1MmRrNHp3aXBtdi94aVpSNTlzSUpXWGNmUUF6aktJdldBSTZDeUhR?=
 =?utf-8?B?QXRvWUM3K1ZHS3lxQ3JTSXJVYlZiTXJmRFJFM0w2eFNMQXZXdTFaL2d0a2dp?=
 =?utf-8?B?TFUvOExWeGVhSlVrclFDeUMzV3FDOWNTTHh1N0hvTEZWYmlhampWQnI3QURN?=
 =?utf-8?B?OWpWVldHRTZzQ2wxREZXVSs2Nkw5YXdSRXl6dFlSQ3R4TStWZWJPRTBjeFVz?=
 =?utf-8?B?V2N1Z1lUOUlIUy9mUWRyeTI0UHhxeUZzMVBQblFWSHNiSFdhcytXZ2x0WElV?=
 =?utf-8?B?c0VCWk41Z1FrSWhvWVd5V3J4VHBGTUdyYklXS3Bhb1U0eFd5djBzRDdwTi9a?=
 =?utf-8?B?VHNlVHNSbXViV3dqakVHd1ZZWmV3U2t4cEhQUkF2WTZlQmpWYlJ3Zng0emZ5?=
 =?utf-8?B?b1JPTE5NSlFHMU15SU1QZHlNV1N3OFhpLzQxTXd5dmlmZWRDYzRGWUQvZEhr?=
 =?utf-8?B?QnRDZFJDakpIWlp2NGIzQklOWGFOelIvV3UwZXdWTGlVRkoreDRiZE9iY0V0?=
 =?utf-8?B?bDZxaDVVZlJOTVI5b3B4dGgrUXBXY1A5TnpILzJHZXE3dmlPU3l4OHBxSlFQ?=
 =?utf-8?B?OFltaHYvTUZVeklwVHlib1NVTGVJWDBQOUFWL01aa1FKY2RVd0hGOTA1bkZ6?=
 =?utf-8?B?aTlqbWRRZlZCaVBXWHgxZTBMSmp4enRNcDhJRHR0RTJQRUFNUWlSSmNmbWE1?=
 =?utf-8?B?TXpQWk9sSTZ0aXlZOS92aGJZWGhkZjhNQzJWNkhnVHEwR0xrQjVlNnRWU0l5?=
 =?utf-8?B?QktHRzNTR1dUYkY3VGd2enBhQTVHS3d1TzV3ekRsMU1HazNxN3lXN0NQTVFK?=
 =?utf-8?B?ZFNoS3hBRWFYQms3S0toTzBITjdEZlBwVFVOUS9YUDFrUFdwMkU0WERzY2s4?=
 =?utf-8?B?d1djNXpObGlrcWl3c0kwUnRUSU1KdnJPL2xYNkJMMzY3LzJLZUN3RXAvQjZj?=
 =?utf-8?B?RGxjNWZIN0JlYlNTQ0lXYVNYT2ZiMjJ5VENqVjhiMXFIbWUwRjVXcE9JM1BJ?=
 =?utf-8?B?RTc4VjdQRlE2OVcxUFlFZEFVbUgwN24rcFd2akRKNWFjcE5ZVWYrTEtUVzVk?=
 =?utf-8?B?TGl6OElqd0NFVjduR3FHemZtaE8rb3dkcDNvVWp2SS9GWEJ0NVJ2OFQ2UEVH?=
 =?utf-8?B?a3puNmxRRVBqNDdJSzQ0M2tkdWlPSlpuT1lxc2kzc1FrQXRBQVlIUENodjJr?=
 =?utf-8?B?WVMreHFpUG5XazAxOU4zZXVBNDdDeGZvS1RvVGFLbFJqbFk3dE9zNWlJUnR6?=
 =?utf-8?B?Zkl0b2lnZFJCREJxelV0NTNGMGpSTUY4S1JMYUZCMDRaSUpqNnVnSy82N01B?=
 =?utf-8?B?WkNzRVhLQ3hia2NBTllzbm9GRm9XTmduZjBwb0k0ZW02RUh2emtGRHFwZW9X?=
 =?utf-8?B?Yi9hVExOcVZsaE9XTmVrbHZBakx5SS9oRnd4T3FVb3hLTXpwMkJyTnBGUXMr?=
 =?utf-8?B?MDc1RVJja01wSmhvaHFRZFBxbExrK1pjODhNTm0wL1hjSHZwLzZ0R205VjFl?=
 =?utf-8?Q?H3gJEjRAFZraN1f440lH3RU=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93f3fb9-f406-4269-b868-08db2a77d822
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 01:50:42.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZmUFlqBiUxp/1B4ail0GATUv/4krLctTAArLdUWPtjHwlftQtL3f4AD78DkCbBVznJF97ebhbMA1PWZbPzEQa7Gcx/OVWoQQTdcCfdcj2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5069
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Originally I was planning to kick this off with a patch set, but i've
decided my current prototype does not fit the extensibility requirements
to go from SLD to MH-SLD to MH-MLD.


So instead I'd like to kick off by just discussing the data structures
and laugh/cry a bit about some of the frustrating ambiguities for MH-SLDs
when it comes to the specification.

I apologize for the sheer length of this email, but it really is just
that complex.


=============================================================
 What does the specification say about Multi-headed Devices? 
=============================================================

Defining each relevant component according to the specification:

>
> VCS - Virtual CXL Switch
> * Includes entities within the physical switch belonging to a
>   single VH. It is identified using the VCS ID.
> 
> 
> VH - Virtual Hierarchy.
> * Everything from the CXL RP down.
> 
> 
> LD - Logical Device
> * Entity that represents a CXL Endpoint that is bound to a VCS.
>   An SLD device contains one LD.  An MLD contains multiple LDs.
> 
> 
> SLD - Single Logical Device
> * That's it, that's the definition.
> 
> 
> MLD - Multi Logical Device
> * Multi-Logical Device. CXL component that contains multiple LDs,
>   out of which one LD is reserved for configuration via the FM API,
>   and each remaining LD is suitable for assignment to a different
>   host. Currently MLDs are architected only for Type 3 LDs.
> 
> 
> MH-SLD - Mutli-Headed SLD
> * CXL component that contains multiple CXL ports, each presenting an
>   SLD. The ports must correctly operate when connected to any
>   combination of common or different hosts.
> 
> 
> MH-MLD - Multi-Headed MLD
> * CXL component that contains multiple CXL ports, each presenting an MLD
>   or SLD. The ports must correctly operate when connected to any
>   combination of common or different hosts. The FM-API is used to
>   configure each LD as well as the overall MH-MLD.
> 
>   MH-MLDs are considered a specialized type of MLD and, as such, are
>   subject to all functional and behavioral requirements of MLDs.
> 

Ambiguity #1:

* An SLD contains 1 Logical Device.
* An MH-SLD presents multiple SLDs, one per head.

Ergo an MH-SLD contains multiple LDs which makes it an MLD according to the
definition of LD, but not according to the definition of MLD, or MH-MLD.

Now is the winter of my discontent.

The Specification says this about MH-SLD's in other sections

> 2.4.3 Pooled and Shared FAM
> 
> LD-FAM includes several device variants.
> 
> A multi-headed Single Logical Device (MH-SLD) exposes multiple LDs, each with
> a dedicated link.
> 
>
> 2.5 Multi-Headed Device
> 
> There are two types of Multi-Headed Devices that are distinguied by how
> they present themselves on each head:
> *  MH-SLD, which present SLDs on all head
> *  MH-MLD, which may present MLDs on any of their heads
>
>
> Management of heads in Multi-Headed Devices follows the model defined for
> the device presented by that head:
> *  Heads that present SLDs may support the port management and control
>     features that are available for SLDs
> *  Heads that present MLDs may support the port management and control
>    features that are available for MLDs
>

I want to make very close note of this.  SLD's are managed like SLDs
SLDs, MLDs are managed like MLDs.  MH-SLDs, according to this, should be
managed like SLDs from the perspective of each host.

That's pretty straight forward.

>
> Management of memory resources in Multi-Headed Devices follows the model
> defined for MLD components because both MH-SLDs and MH-MLDs must support
> the isolation of memory resources, state, context, and management on a
> per-LD basis.  LDs within the device are mapped to a single head.
> 
> *  In MH-SLDs, there is a 1:1 mapping between heads and LDs.
> *  In MH-MLDs, multiple LDs are mapped to at most one head.
> 
> 
> Multi-Headed Devices expose a dedicated Component Command Interface (CCI),
> the LD Pool CCI, for management of all LDs within the device. The LD Pool
> CCI may be exposed as an MCTP-based CCI or can be accessed via the Tunnel
> Management Command command through a head’s Mailbox CCI, as detailed in
> Section 7.6.7.3.1.

2.5.1 continues on to describe "LD Management in MH-MLDs" but just ignores
that MH-SLDs (may) exist.  That's frustrating to say the least, but I
suppose we can gather from context that MH-SLD's *MAY NOT* have LD
management controls.

Lets see if that assumption holds.

> 7.6.7.3 MLD Port Command Set
>
> 7.6.7.3.1 Tunnel Management Command (Opcode 5300h)

The referenced section at the end of 2.5 seems to also suggest that
MH-SLDs do not (or don't have to?) implement the tunnel management
command set.  It sends us to the MLD command set, and SLDs don't get
managed like MLDs - ergo it's not relevant?

The final mention of MH-SLDs is mentioned in section 9.13.3

> 9.13.3 Dynamic Capacity Device
> ...
>  MH-SLD or MH-MLD based DCD shall forcefully release shared Dynamic
>  Capacity associated with all associated hosts upon a Conventional Reset
>  of a head.
>

From this we can gather that the specification foresaw someone making a
memory pool from an MH-SLD... but without LD management. We can fill in
some blanks and assume that if someone wanted to, they could make a
shared memory device and implement pooling via software controls.

That'd be a neat bodge/hack.  But that's not important right now.


Finally, we look at what the mailbox command-set requirements are for
multi-headed devices:

> 7.6.7.5 Multi-Headed Device Command Set
> The Multi-Headed device command set includes commands for querying the
> Head-to-LD mapping in a Multi-Headed device. Support for this command
> set is required on the LD Pool CCI of a Multi-Headed device.
>

Ambiguity #2: Ok, now we're not sure whether an MH-SLD is supposed to
expose an LD Pool CCI or not.  Also, is a MH-SLD supposed to show up
as something other than just an SLD?  This is really confusing.

Going back to the MLD Port Command set, we see

> Valid targets for the tunneled commands include switch MLD Ports,
> valid LDs within an MLD, and the LD Pool CCI in a Multi-Headed device.

Whatever the case, there's only a single command in the MHD command set:

> 7.6.7.5.1 Get Multi-Headed Info (Opcode 5500h)

This command is pretty straight forward, it just tells you what the head
to LD mapping is for each of the LDs in the device.  Presumably this is
what gets modified by the FM-APIs when LDs are attached to VCS ports.

For the simplest MH-SLD device, these fields would be immutable, and
there would be a single LD for each head, where head_id == ld_id.



So summarizing, what I took away from this was the following:

In the simplest form of MH-SLD, there's is neither a switch, nor is
thereo LD management.  So, presumably, we don't HAVE to implement the
MHD commands to say we "have MH-SLD support".


========
 Design
========

Ok... that's a lot to break down.  Here's what I think the roadmap
toward multi-headed multi-logical device support should look like:

1. SLD - we have this.  This is struct CXLType3Dev

2. MH-SLD No Switch, No Pool CCI.

3. MH-SLD w/ Pool CCI  (Implementing only Get Multi-Headed Info)

4. MH-SLD w/ Switch (Implementing remap-ability of LD to Head)

5. MH-MLD - the whole kit and kaboodle.


Lets talk about what the first MH-SLD might look like.


=================================
2. MH-SLD No Switch, No Pool CCI.
=================================

1. The device has a "memory pool" that "backs" each Logical Device, and
   the specification does not limit whether this memory is discrete
   or may be shared between heads.

   In QEMU, we can represent this with a shared or file memory backend:

-object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=4G,share=true


2. Each QEMU instance has a discrete SLD that amounts to its own private
   CXLType3Dev.  However, each "Head" maps back to the same common
   memory backend:

-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0


And that's it.  In fact, you can do this now, no changes needed!


But it's also not very useful.  You can only use the memory in devdax
mode, since it's a shared memory region. You could already do this via
the /dev/shm interface, so it's not even new functionality.

In theory you could build a pooling service in software-only on top of
memory blocks. That's an exercise left to the reader.


================================================================
3. MH-SLD w/ Pool CCI  (Implementing only Get Multi-Headed Info)
================================================================

This is a little more complicated, we have our first bit of shared
state.  Originally I had considered a shared memory region in
CXLType3Dev, but this is a backwards abstraction (A MH-SLD contains
mutliple SLDs, an SLD does not contain an MHD State).

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 7b72345079..1a9f2708e1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -356,16 +356,6 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256

+struct CXLMHDState {
+    uint8_t nr_heads;
+    uint8_t nr_lds;
+    uint8_t ldmap[];
+};
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -377,15 +367,6 @@ struct CXLType3Dev {
     HostMemoryBackend *lsa;
     uint64_t sn;

+
+    /* Multi-headed device settings */
+    struct {
+        bool active;
+        uint32_t headid;
+        uint32_t shmid;
+        struct CXLMHDState *state;
+    } mhd;
+


The way you would instantiate this would be a via a separate process
that initializes the shared memory region:

shmid1=`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
./cxl_mhd_init 4 $shmid1
-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd=true,mhd_head=0,mhd_shmid=$1

./cxl_mhd_init would simply setup the nr_heads/lds field and such
and set ldmap[0-3] to the values [0-3].  i.e. the head-to-ld mappings
are static (head_id==ld_id).



But like I said, this is a backwards abstraction, so realistically we
should flip this around such that we have the following:

struct CXLMHD_SharedState {
	uint8_t nr_heads;
	uint8_t nr_lds;
	uint8_t ldmap[];
};

struct CXLMH_SLD {
	uint32_t headid;
	uint32_t shmid;
	struct CXLMHD_SharedState *state;
	struct CXLType3Dev sld;
};

The shared state would be instantiated the same way as above.

With this we'd basically just create a new memory device:

hw/mem/cxl_mh_sld.c


This is pretty straightforward - we just expose some of cxl_type3.c
functions in order to instantiate the device accordingly, the rest of it
just becomes passthrough because... it's just a cxl_type3.c device.


This ultimately manifests as:

shmid1=`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`

./cxl_mhd_init 4 $shmid1

-device cxl-mhd-sld,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd_head=0,mhd_shmid=shmid


Note: This is the patch set i'm working towards, but I presume there
might be some (strong) opinions, so i didn't want to get too far into
development before posting this.


==============================================================
4. MH-SLD w/ Switch (Implementing LD management in an SLD)
==============================================================

Is it even rational to try to build such a device?

MH-SLDs have a 1-to-1 mapping of Head:Logical Device.

Presumably each SLD maps the entirety of the "pooled" memory,
but the specification does not state that is true.  You could, for
example, setup each Logical Device to map to a particular portion of the
shared/pooled memory area:

-object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=4G,share=true

QEMU #1
-device cxl-mhd-sld,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd_head=0,mhd_shmid=shmid,dpa_base=0,dpa_limit=1G

QEMU #2
-device cxl-mhd-sld,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd_head=0,mhd_shmid=shmid,dpa_base=1G,dpa_limit=1G

... and so on.

At least in theory, this would involve implementing something that
changes which SLD is mapped to a QEMU instance - but functionally this
is just changing the base and limit of each SLD.

It's interesting from a functional testing perspective, there's a bunch
of CCI/Tunnel commands that could be implemented, and presumably this
would require a separate process to manage/serialize appropriately.

=======================================
5. MH-MLD - the whole kit and kaboodle.
=======================================

If we implemented MH-SLD w/ Switching, then presumably it's just on step
further to create an MLD:

struct CXLMH_MLD {
        uint32_t headid;
        uint32_t shmid;
        struct CXLMHD_SharedState *state;
        struct CXLType3Dev ldmap[];
};

But i'm greatly oversimplifying here.  It's much more expressive to
describe an MLD in terms of a multi-tired switch in the QEMU topology,
similar to what can be done right now:

-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=12 \
-device cxl-rp,id=rp0,port=0,bus=cxl.0,chassis=0,slot=0 \
-device cxl-rp,id=rp1,port=1,bus=cxl.0,chassis=0,slot=1 \
-device cxl-upstream,bus=rp0,id=us0 \
-device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-device cxl-type3,bus=swport0,volatile-memdev=mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k


But in order to make this multi-headed, some amount of this state would need
to be encapsulated in a shared memory region (or would it? I don't know, i
haven't finished this thought experiment yet).


=====
 FIN 
=====

I realize this was a long.  If you made it to the end of this email,
thank you reading my TED talk.  I greatly appreciate any comments,
even if it's just "You've gone too deep, Gregory." ;]

Regards,
~Gregory
