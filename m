Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9814EC38142
	for <linux-cxl@archiver.kernel.org>; Fri, 27 Jan 2023 19:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjA0TH1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 14:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjA0TH1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 14:07:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC957C333
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 11:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674846442; x=1706382442;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S2iJzFKVyzXQyDKDYbM3WchNf9I/iKuMNHxStA99e0s=;
  b=Vs16IE2s6mjpoNGor2k05oUMoXgJoAymrXZfXSVcCqcb+iVO9AppG2M8
   vxyQxOO7jV6t9paLB6hZ/Kg9XbQz3rro5BQZ1Lsj5TDGoBfOM0WO083jZ
   IENUMrEVrYdc6XQ+trjliMRe7vPMn/3qvuh2r/Ngtor862jx3K/d0uT32
   1ZO4ldsrNcauJeZO/fSSXCCA5x0/e6FmQ8Z4+QXy3zhyek3/qZxSg26DC
   nYhbA8N7E7XbF0kkEXTDPlNqZO9eLbnT9ZkwX96i/9q8AV3LCUO2IHN7C
   6v272ddcb3PdNZDHrufTe6+TOzrk7V/RHwKKsBQoDHegCyB3mKbuQlbty
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="325835532"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="325835532"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 11:07:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="787302403"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="787302403"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2023 11:07:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 11:07:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 11:07:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 11:07:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 11:07:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No9sTHo+wfkySyZzOryCsABh6BtRFTJDd4rjqakO8oPDjGAIdhaMu7Xal5QCXhGWhp2DsYQcyDxLU/AhPKAAauFlGpiTheE4LvUPzuZPUNWw2mWcltO6KkLaSmO4/Q1P66IfrYk632ivnBjrLzA0MWnjbRlfOJi8cLww3/I+uM1+T9VCQEuYJTfcvir/WG0m53aVTzOlFTYDNX6F6nVH4OUT1DX4qtAVrreGZaJFo0vd5XUcM2ZIt13JEnL5VVeZq41kIHvSeelHqwR5RZm1t2qic4WyVFNMYVcfymFfGRhb4sLyVaPJ6LzbS9jxyYu7iPaZPgR7FxD87fTgN/dffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcvaYLou4r/SS43yut6YKkuBkxlF541Tp0ewhxDLsYw=;
 b=D6PclaPgdftm5GbztGY40FPS5r18DPzI6vRJsvj9GT0Opuxifzw9d1zfmTxsZHwXzS2lV1Mqx6KnsQRJdIRBaUVVx/jJUNGMEw03V3wBk4sJaKmjFlFm5Vi+SzsEMoipSiV3UvHJVPeM3IhsjmpN7kM9U00L63xHS5DWuV/4Svh8nVt0ezu9VKWx+UfCQSi8KT+CaRwKrRKDurGeiMvr8oGPYjxhlB4H651rwFKvsmxXPQagLjrBOEjqi4GGKcEER+kQ59TSfuXmuqas5IR0uvfMC5AuXP5JGkvUdwdpGtlnxQdZZIVINa5zCe3TeT0uBPwH5u1DXCuK7lOc1YSKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.23; Fri, 27 Jan 2023 19:07:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 19:07:05 +0000
Date:   Fri, 27 Jan 2023 11:07:02 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <63d420d6dc5fa_3a36e5294cb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
 <63d2e0f67eee9_ea222294b6@dwillia2-xfh.jf.intel.com.notmuch>
 <20230127100406.00006c65@Huawei.com>
 <20230127121013.00007966@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230127121013.00007966@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: b00aecaa-e85b-4876-4f52-08db0099addc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCRv1k/CkiLhNsuA4Pis42Bj/97TWMTTQd8wgN2DwusZtCdyZQaXYUcT0KdPVFN6Gcs9Y5awcCj/oldG1irwo7H3MKRvHM5EkrWxat6dooBr6Aqxs8SL6IOmq93M0L38QjfI4oquqTFnh7gk8pm0v5jJCaXZCwLSKMkca2Jxjwin5kiCjnn9XhVObF/H4TdUd7ZumB2SYc/offowdzfVgoCHHbF1WSHiaK3eYbthQT1HuPofEzTZuibuL6qr7N4SjJMU08dURk2Q3Ahu0jFalIRuKAwgCcq3gmYpNpd/XOvAaPSEGVoh+RpWvMjGOpSi0k2ehwaLOzWjHF4VKcqhJx50pHNiSOtWuOLGnUevb4DCyXpNVkD9NNlWvAQu00qHEe/FmiPGSLQJMZhuTgaqyJ5Xp233eumwoEzOsPDqFDhp0pGied2074u1zD7njzmZ1MFF5JgC0RJW6Y0DU6DS5GAHUkPBeTYWwTr60/DJJ7EC1WQk8pZ6C9bHs6odRJ+osG2fOWeCm/mSKiY/MtjEP+kn6cUMfYkDohqm2x/YR6u2FZ7NGNcirubFYV1ys+Xwuk6z43eH5REA6F+zHZ5a0XJUXq+N0JOnZ8ZTGKi+GibI3Pr2eD1lA1yfu2zwNddox750ZL7tWz2NsiNAyODM8a8QkVmxhkUU+fr8FIKdsKrbGSrYuMMonjkV3oJu0/t1nf8TKmgcdc2W8dZsxSBc+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199018)(41300700001)(54906003)(6666004)(110136005)(83380400001)(66946007)(66476007)(66556008)(4326008)(86362001)(6486002)(478600001)(316002)(8676002)(26005)(38100700002)(6506007)(186003)(5660300002)(2906002)(53546011)(9686003)(82960400001)(6512007)(8936002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXrz7Eh0kJU/jAb88SyT6XpVvcz12PuehfsTFObjDYpKn8ZJATtwOJrvA48H?=
 =?us-ascii?Q?KLljq07RO0c0IAYxoqeM4e6kCVxL55T8xC/VuaMbg22LivE2A127Gz14j/0f?=
 =?us-ascii?Q?meHiGMCiFiai+IosBRloyCqykhis8GxNftsryimV+lcdfyQGFBjBFAyTtNxF?=
 =?us-ascii?Q?xqYrnyEiPWaAHy5Ozt6wTLJRhgkz0CtfgsMad9ZCStBGPNq49IPqDQPzOeRp?=
 =?us-ascii?Q?5KBOx0ztj0AyRg02bMC+ZxqAi9m3ousrbqJL83vF4TasyfNnw/+yn2XUcRz2?=
 =?us-ascii?Q?s5BIZ5PU4lcNRkw98KOJTt3s/Jbh2UM+5zIHE5YXwOndv/Wrkal/7e5cdgQ3?=
 =?us-ascii?Q?sWlabTJ+4XRCrO7yAkztmw3JlTFvLxAYkgg5UXPmOU3cS2bwPLrnDc6YQeDe?=
 =?us-ascii?Q?fshwtXIST5YzqK6FoPRrM9u//fOBkEbA20gnTA3VoPPPsJrYpYO9bVA6BOcB?=
 =?us-ascii?Q?qxHDDsxgLKcxRe6bWNX8M+CDdaEQXbdIWlbfSiQlMJVRiRkfvMbQNkU4JrSM?=
 =?us-ascii?Q?KdG7RiU0xmzJoVxbcAcFaGSPnhY1zcyHeoKfoZxpceugZ5et1SJ97o5gMJUq?=
 =?us-ascii?Q?vOumAFs8A5shZO3ZP8MUy27R1iJ70t0DPIciheSl/qAufTTp3BrVPieewl7X?=
 =?us-ascii?Q?KRVFnyaNKRNvFFMA+KdZiWJcluE2FQd/+GPfr5w8gs5Smuhzb3QTzBH+Q4gY?=
 =?us-ascii?Q?GT+m8xuaYSgLuSqUxhWJFBYCciZdP1lQmPoom9R1zLBiThERy5uXhwYz1iEC?=
 =?us-ascii?Q?hnrKkocPZ2jt7KXgYNSnjVYg0yFUyXTS9udr8VCxuF2JekfC0eOmYJQ/7rFH?=
 =?us-ascii?Q?fvU9OvlBFd4Dk/WgK7Hvg0QrXeAbZfr2/CUG7IlDkkCZKOY0EKg2O7pb7SU7?=
 =?us-ascii?Q?mrYAf0IiSExPTxkl6ucEG3u9GS3xc+TRE3ORYdomv2dzLUCsopvGSKNER1ix?=
 =?us-ascii?Q?4iTeo5yxOy9czSDkoYaWOr2G4Y9FD4SRjPxnm8v6YiFLyElVas+g/zcImY8f?=
 =?us-ascii?Q?vUmJhszJaXEIfcco1bv7MSKNOpaKQOZDxGreRltzQ9shWgGsSqFMAAtKs4Gp?=
 =?us-ascii?Q?06t3RuXC5QsMuK1g8C+l6D1SitBOob+bmY6+WiPXz81PirN8tPfyJKTlRHkl?=
 =?us-ascii?Q?q3GBsE1f610CJAYrZG9E6/ibKbqbfIHvD+5fuUgeIacaP7IvNKe9j3KB5KkD?=
 =?us-ascii?Q?IUDro2nl2yI5ibp97/N6OfzK6YOy4RLX63f3o0B5ljM/ILkSWSHlHwPEJ4C0?=
 =?us-ascii?Q?KlwYemwMckRKf81LzUd0wQSoD+xRN9PmdcY3i2NDteqabd9GN9mayb9ieYF8?=
 =?us-ascii?Q?en0Qh6/5XM0uXTZJn3KpoMmmAeGIE34mD+Nqd5ihusJ0TUpGFA9zbRqwYx8e?=
 =?us-ascii?Q?FriWFUTE2KD3Jceq877O7EdoecmIZQvJ26xBgmFHurizvoPTfh9DbcW8FoHL?=
 =?us-ascii?Q?br+OXfIEnb+bqz5bb6UlOv4Iy54IvWHXlYPFMOIP3I48ytvmV7uZ/gan5nNu?=
 =?us-ascii?Q?ZkigdTNRwTq+ljAYbb1Z8CtkGUzns52DgRWtiPEzAZRbmsT77T7/2g7CF6/m?=
 =?us-ascii?Q?p8xjidgsWHvkFBtVV71A9qHx5WFvL830xwr55V4UogPmtEao7SXlCDh9QV/F?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b00aecaa-e85b-4876-4f52-08db0099addc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 19:07:05.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVezZwhiBBVMLDdzFP8LJLuk1/Zgj9LxvUKS57JRnv8TDAu7u41A5KB84SXq1ooEQvYNB0l2Bxy+Ij/yGZk8QmY5+CydSPWyCM0jWDZIe34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> > > >  /*
> > > > @@ -857,6 +859,29 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
> > > >  }
> > > >  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
> > > >  
> > > > +int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts)
> > > > +{
> > > > +	struct cxl_mbox_cmd mbox_cmd;
> > > > +	struct cxl_mbox_set_timestamp_in pi;
> > > > +
> > > > +	/*
> > > > +	 * Command is optional and functionality should not be affected if
> > > > +	 * the command is not available.
> > > > +	 */
> > > > +	if (!test_bit(CXL_MEM_COMMAND_ID_SET_TIMESTAMP, cxlds->enabled_cmds))
> > > > +		return 0;
> 
> One side effect of dropping the userspace handling is we loose
> the presence in enabled_cmds (based on the CEL).  I've replaced
> this with specific handling of the Not Supported mailbox return code
> and suitable comments on why I'm not considering that an error.
> 
> Hopefully that compromise makes sense.

That does make sense.

That also has implications for the debug messages that will say that the "set
timestamp" opcode is unsupported.

What do you think of the following to try to clarify the distinction of
supported opcodes that are used internally by the driver and the ones
that are wrapped by a user command?

-- >8 --
From d36b9ce647e615be8241d7fbf86ce555c72cc2a4 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 27 Jan 2023 11:00:52 -0800
Subject: [PATCH] cxl/mbox: Indicate internal vs user enabled for command debug

At initial enumeration provide an indication of whether the kernel will
use an opcode internally, and / or make the functionality available via
user ioctl command.

Given that 'enum cxl_opcode' needs to be updated before the kernel can
use a CXL opcode internally, use that list to populate known_opcode().

For the QEMU CXL emulation this results in the following debug messages
at startup:

 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x100 Enabled: 0 User: none
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x101 Enabled: 0 User: none
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x102 Enabled: 0 User: none
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x103 Enabled: 0 User: none
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x200 Enabled: 1 User: Get FW Info
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x300 Enabled: 0 User: none
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x301 Enabled: 0 User: none
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x400 Enabled: 1 User: Get Supported Logs
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x401 Enabled: 1 User: Get Log
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4000 Enabled: 1 User: Identify Command
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4100 Enabled: 1 User: Get Partition Information
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4102 Enabled: 1 User: Get Label Storage Area
 cxl_walk_cel: cxl_pci 0000:35:00.0: Opcode 0x4103 Enabled: 1 User: Set Label Storage Area

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c | 48 ++++++++++++++++++++++++++++++++++-------
 drivers/cxl/cxlmem.h    |  1 +
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index cae43cea00cd..45206465fd4d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -587,6 +587,40 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 	return 0;
 }
 
+static bool known_opcode(u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_FW_INFO:
+	case CXL_MBOX_OP_ACTIVATE_FW:
+	case CXL_MBOX_OP_GET_SUPPORTED_LOGS:
+	case CXL_MBOX_OP_GET_LOG:
+	case CXL_MBOX_OP_IDENTIFY:
+	case CXL_MBOX_OP_GET_PARTITION_INFO:
+	case CXL_MBOX_OP_SET_PARTITION_INFO:
+	case CXL_MBOX_OP_GET_LSA:
+	case CXL_MBOX_OP_SET_LSA:
+	case CXL_MBOX_OP_GET_HEALTH_INFO:
+	case CXL_MBOX_OP_GET_ALERT_CONFIG:
+	case CXL_MBOX_OP_SET_ALERT_CONFIG:
+	case CXL_MBOX_OP_GET_SHUTDOWN_STATE:
+	case CXL_MBOX_OP_SET_SHUTDOWN_STATE:
+	case CXL_MBOX_OP_GET_POISON:
+	case CXL_MBOX_OP_INJECT_POISON:
+	case CXL_MBOX_OP_CLEAR_POISON:
+	case CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS:
+	case CXL_MBOX_OP_SCAN_MEDIA:
+	case CXL_MBOX_OP_GET_SCAN_MEDIA:
+	case CXL_MBOX_OP_GET_SECURITY_STATE:
+	case CXL_MBOX_OP_SET_PASSPHRASE:
+	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
+	case CXL_MBOX_OP_UNLOCK:
+	case CXL_MBOX_OP_FREEZE_SECURITY:
+	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
+		return true;
+	}
+	return false;
+}
+
 /**
  * cxl_walk_cel() - Walk through the Command Effects Log.
  * @cxlds: The device data for the operation
@@ -607,15 +641,13 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
 	for (i = 0; i < cel_entries; i++) {
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
+		bool known = known_opcode(opcode);
 
-		if (!cmd) {
-			dev_dbg(cxlds->dev,
-				"Opcode 0x%04x unsupported by driver\n", opcode);
-			continue;
-		}
-
-		set_bit(cmd->info.id, cxlds->enabled_cmds);
-		dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
+		if (cmd)
+			set_bit(cmd->info.id, cxlds->enabled_cmds);
+		dev_dbg(cxlds->dev, "Opcode %#04x Enabled: %d User: %s\n",
+			opcode, !!known,
+			cmd ? cxl_command_names[cmd->info.id].name : "none");
 	}
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..21f97d631823 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -299,6 +299,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
 	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
 	CXL_MBOX_OP_MAX			= 0x10000
+	/* update known_opcode() when adding opcode support to this list */
 };
 
 #define DEFINE_CXL_CEL_UUID                                                    \
-- 
2.38.1
