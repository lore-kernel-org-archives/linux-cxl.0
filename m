Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEE1C352A1
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 00:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLGAJ4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 19:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGAJz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 19:09:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6865C8
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 16:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670371794; x=1701907794;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iwRyhtPw/JZTjLRyNX53ELKfpmHTlFtnTf/y6ejjUQk=;
  b=mwiRMg7OZ4vWd/b27mo46bR9+UB9K1ntertxlaTyJ8raLrGD/g4gjD0n
   CuO3xu5aCkqbQCY2lzfbtvWdy1U6JgmXsQoh+oXo3IJgg8hJ6u37xwCPx
   6qIiJDIqpKAgHa4mTHJ+Sl/8XMDdIwm3oGE8nPz3uw9Hxv7ZKrNmlxFU7
   NfRCt3rTywXjT/fa17Qc9s6CJHujawsX72MFnV/7RjAcs9JCh7eEUqgYx
   VRp9Bw/mmu64iB700YU4woKW09wOdS2FeZu/qS2kAJfMGOThNNjS6Z7fC
   Gikfc8qF/iqmsxvLMO47OPnRCxKSZOk0bfTT6RLjMTxwBim2RMfjYo/YU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="304389236"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="304389236"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 16:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="820764463"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="820764463"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2022 16:09:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 16:09:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 16:09:53 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 16:09:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7Usuns7S1xyMb/HsyC1EwDWJBtOhcNyOxkh8m2b5oQCgnN/v1ev6Lsj86K1M9L+sbAcjEN4sFJCef9ZlT68cwrfvz7puavkMe3SB8UKLDnq+OCeohJDKzxuCj5zOd2xo04ytocnYtxdhEqv84aAToKRq5WjOvu7nZu0O2woaHZbwu4vzrtjeErghUBUpFposH0ABKgLGTZCMQMAk8QJynRVosg9v5WNZHm5j4hrfubEs6gOhFIjNFfoN9h0zUCZE954YzaozXds71ifou94pSAyLiVN66TnA+eEf+cfM86A/yak+eDXCcaejFszoZ1xeimdBrhC+NDWNNragOPTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhbSK3CqU1DKPHPrwjVBj+iYnESlsLNrIk7IVA9V+Gk=;
 b=J7uHW9xV4y+WRmhAj3EhVFHRwsrBnkfeMhtIh7mysgv6nEaPPA2p9pG9W0iGUAHScPyssDqhqNbljSBLI4FMjnz4o4X9fhNBQiWNlchkojIjsUJ54yrWqgmMskbVFc8vHS9FLtySZeb4xP0nCQXnaA2mNmAAiOUAkze8X9414Mwza+sY1OTLLPd4fUKMVUysfI4ygCNLotQvMy93NmLSHGFV6MZdxDZ+lpxoyJpcaK0msyo8KwvTbfQSgg+7AGHQtUstOzHUDNuqR/j1wlpNGTV5w8Iu/O0WWHlP0kBbDOfW9+Z2dMvQzWO7LVcn/shbWzuPYFcZ3e+Out5RTZVO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6615.namprd11.prod.outlook.com
 (2603:10b6:806:256::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 00:09:42 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 00:09:42 +0000
Date:   Tue, 6 Dec 2022 16:09:38 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] cxl: BG operations and device sanitation
Message-ID: <638fd9c2d11b3_3cbe029448@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221206011501.464916-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221206011501.464916-1-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: c257358c-1756-4169-6a5f-08dad7e7566f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuEB3DOz5r7+z3oDJx/UGCIsLaSlcD3ZKdlA40z9AUe8C/YD5QumbEEkQD9fPil6vN7J1PC2LEuRcVm8KiVdB01nKc36XSjkg+K0rYRfDU2GhJG0WTW+Q1D+CZol/psFlHZVBc+KJvmDSfoG26PWkZCuEuigx0Vs6shj0fe/dsAM/7QqR10MQNBCvHE5hh1EcQzZzo36wFVvrYzgMhXZjXS2oASPpKrneu/vqN1Q0KMdDz8pW0QOF4bE2PNcwgp/uOxXiljZO+fLxP090qaLGHyuYNbRIaiceXWrRyx508ZJ+jcpM7OQ+xnP7XFVvDIOYM4lay98rHdqSn9KsAc3VR4jT9pbjojqG7kA6MFN6efLDmGithMRqSGQLxoGCQ0naO4jGV6TZQuiQkW3SQzcNYKodKwqNPUfhI2lulsKNjlrTYrH/zx5ZYb4y/k8Jo+tka+v2ddiHm5IifM3mYiOViAY8vrws+lQDW7Xl1wCKna7ilKWlLtlrc5dDuu8pDKsSbd3KTCrELebdKSMaNq6qslskly8eiYor3IHd2Syzo4XdpeCQYIuXY1ZvjfJL3jQcbcHrpmWDglU3GW67TzcLENhmk0g8vWKxYUURcdFsxNStXcL81fqXpe7iUjuoovI2H9V4JLnsjC0KhbC3jzKGeEF9mieGFAXrx3IJH8PRvVdc+U0MXcXC/HTs8nlL1lLER0XvkObIyFfb3v+siukCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(86362001)(41300700001)(2906002)(316002)(186003)(38100700002)(8936002)(83380400001)(966005)(478600001)(9686003)(6486002)(82960400001)(5660300002)(6512007)(26005)(6666004)(6506007)(4326008)(66476007)(8676002)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bM3VSjl973igXVBFCOPFrSTln2dMoABu7/SgvZFqd4L36eIYtIViCr4OgWnO?=
 =?us-ascii?Q?3Uz6YIhdbxFsNt1W5HIMP1nHUDAQLpHlu82SKajQT78KAIpLouujsUUqbAJF?=
 =?us-ascii?Q?Ibg4abqUL7qt8mM/VhA5QLySTo+Dt/m5m9M2cWhwtmASMsNqbyKEpIPr/BX1?=
 =?us-ascii?Q?H2/E3G/JnyToXnuMBcAbTGiuhSJgXSNT7B6l1Gkva1JWTIXwN5ZZxBIaZDYS?=
 =?us-ascii?Q?uqsWbOEuUCdZtkyVeVBoVubDN/97Qk9JQ8UTwbCS5Z2zbEZVz9ttlX1kg9IY?=
 =?us-ascii?Q?fyxZLHY8fSJo5wvZT0mGXtf2ChSfK50kjsNdZbNuQkHOpSo8YdXJuqalQnvg?=
 =?us-ascii?Q?BfShzGHnC/G8FNs33npp5zzB8tyo4QkQCV5V4FRIZGbgV011kvqnno7P96yB?=
 =?us-ascii?Q?Z3qGxHrEBUx93UvkL4jKEEsnELJ4AC5oe2OYbxMV53XjdQM6II0D1aQ51MRr?=
 =?us-ascii?Q?adS3+lWndi8IiJveUONL9vszlNQWDfLCg+3ab29bDh0NiDjgo1QhxJ5EbnHB?=
 =?us-ascii?Q?JNRWoTfCOebHCmoN7hJU5yTBBCm/V5iOnhdp3O4elYlAstI1sZkeMAI1dsMW?=
 =?us-ascii?Q?3WUjfkdf/sL0MDaxr4bYkuYgiYTvkAHPZZPiGlpmfGeFWkvgkaXiWOlxfjHJ?=
 =?us-ascii?Q?OQgcO89ALf2Iy0JVP5MZpwKOG0PXgru4pSdJ+nbAi6CuX5yWU0lJ5nADKG/C?=
 =?us-ascii?Q?OslrxcyIB2TdalF/8+/kI3tighXtSfm0R0YYJ472/sgVGW59wXHsDd7ROIjF?=
 =?us-ascii?Q?FNqW8zFD1G3mOgAP3EenoC+j453sJeoXm+3/AJ9ifPCxNpXAyA6aUl9VBJXy?=
 =?us-ascii?Q?uNvOmBPYL2C7VH+qJSqqha+kYt5hZ9QSyT0s6ICHmKNeqvgIpyjA0Y4QxO9j?=
 =?us-ascii?Q?c80/Es19KxKX90kidZJQbQSphTS3nMjIVv4AvnINgBdJT0lIeehU4/aanl07?=
 =?us-ascii?Q?gl8jNMKS/hulGcc9mD8tyLPP8XyAZZrbub+RQdd7FOLyn/NajxtiWjzuZXS0?=
 =?us-ascii?Q?xhRbGYWptrbf2nWKH4cdql3DQ32KYIl0M92bislWVmUFCPRAayPGrfVS8d2G?=
 =?us-ascii?Q?iFPgMWs/9RdaSUHTEEoUCHkruA5s+WKZ+ldKXUp8eDrAeVdS8+XmD1ljRT5F?=
 =?us-ascii?Q?ljD5yUEHAhWEPYQnCP472oK+smIu0jw6XtgiuvsWaKXZuJKkCoR7FYCAqFJr?=
 =?us-ascii?Q?v4BuBaGSIwIB2wfiPlQuKizle7v5dX3y14uIxJQ1iUSlWJUL+3EtwFhM9UFT?=
 =?us-ascii?Q?FtcpAx6+KvV5sNQovMRvAfW1ybZH1OkxDgxZoE2KWgyD6dyVqVHOtENAYjxE?=
 =?us-ascii?Q?ue1kTIAFskmMMNRBNSgwoSuiBlf5d2cYDDaizWhplwcgFfU2surf5WT9Yu02?=
 =?us-ascii?Q?X0AgxgawZRBhwW4RSpzzYT6u8GxRLGla7+1UsouEOUlKhhEllb0bHpsfO6z2?=
 =?us-ascii?Q?7VZrmrBxnT7946Ct16YyV4RiRhuucf5iahxwm7NuB3N1WlHdkgiBptjzE54q?=
 =?us-ascii?Q?S7G8+jgDX6yLYiJ8jukag/xKIG3utqtZBMu1K7L8lSY7CWAmzvt+vvK3L+Bm?=
 =?us-ascii?Q?IjKQD88GWShlRs+RWrqxV/ShHxbDloxueeOj0mBQ7TzOcOQD06eJ9BuFlpJ4?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c257358c-1756-4169-6a5f-08dad7e7566f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:09:42.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbwm93YXNZMnBpOB9abMQRGtMKvb6nmFoX2vn1UtWpkeDSy8ytZp7YecpZMLFQKfADQVrsSxKH9s6XuJWtBp0SnO66DST4bWSoO+E4f35Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> Hi,
> 
> This series adds support for the rest of the security related cxl operation
> which are not strictly dependent on PMEM.
> 
> Patch 1 adds the required background cmd handling bits. While this is currently
> only polling support, the idea is to follow up with an irq support once the
> bits land in Ira's event work. All polling-specific code has been marked
> as __maybe_unused.

I will take a look, but this tends to put me in the mindset of this is
v6.3 material that should wait for its user. Was that your intent?

> Patch 2 implements the sanitation commands (overwrite and secure erase).

My concern with landing non-PMEM secure erase is that it is not scoped
by partition type, and there is no existing appartus like there is on
the nvdimm side to make sure an erase event does not collide with a
device in active use.

However, this is just my reaction to the cover letter, maybe you covered
that aspect in the patches.

> Patch 3 adds a support for secure erase mocking.
> 
> As for testing, while I used the mock device to test the secure erase command, I
> ended up hacking up a prototype[0] for qemu to support overwrite and bg commands.
> So while the some of the paths this series introduces have been exercised, there
> is of course a lot more to do.
> 
> Applies on top of the 'for-6.2/cxl-security' in cxl.git.
> 
> Changes from rfc (https://lore.kernel.org/linux-cxl/20220804045029.2905056-1-dave@stgolabs.net/):
> 
> * Patch 1:
>  - Added a cxlds->mbox_irq flag in order to separate the polling-specific requirements.
>  - Made bg workqueue concurrent.
>  - Address iteration mem commands style (Jonathan). Now just rely on cxl_mem_find_command + check
>    bg flag + callback.
>  - Don't error in cxl_mbox_check_cmd_bgcmd() if conflicts() callback is not defined (Jonathan).
>  - Error out in cxl_mbox_send_cmd() upon corruption in cxl_mbox_bgcmd_begin() (Jonathan).
>  - Do not prematurely add all bg capable opcodes (Jonathan).
> 
> * Patch 2:
>   - Rework polling delay hinting (Dave).
>   - Rely on CEL to see if command is supported instead of unconditionally sending it (Jonathan).
> 
> * Added patch 3.
> 
> [0]: https://github.com/davidlohr/qemu/commit/64a93a5b824b59d3b547f06f7fbb1269fb4790ce
> 
> Thanks!
> 
> Davidlohr Bueso (3):
>   cxl/mbox: Add background operation handling machinery
>   cxl/mem: Support sanitation commands
>   tools/testing/cxl: Add "Secure Erase" opcode support
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  19 ++
>  drivers/cxl/core/core.h                 |   3 +-
>  drivers/cxl/core/mbox.c                 | 317 +++++++++++++++++++++++-
>  drivers/cxl/core/memdev.c               |  54 ++++
>  drivers/cxl/core/port.c                 |   1 +
>  drivers/cxl/cxl.h                       |   8 +
>  drivers/cxl/cxlmem.h                    |  65 ++++-
>  drivers/cxl/pci.c                       |   4 +
>  drivers/cxl/pmem.c                      |   5 +-
>  drivers/cxl/security.c                  |  13 +-
>  include/uapi/linux/cxl_mem.h            |   2 +
>  tools/testing/cxl/test/mem.c            |  27 ++
>  12 files changed, 497 insertions(+), 21 deletions(-)
> 
> --
> 2.38.1
> 


