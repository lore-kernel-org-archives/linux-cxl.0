Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5CAC7619A
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 16:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDLQe5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 12:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLQez (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 12:34:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5566A6E
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 09:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG+HjrNyc4UfkIjW+VJ+TdD60PMI3ZKu2mxvBdxsQI9D2SaJMjD7oViQjd9oPXP1A4dnq9Y8nWEkND/BZBxJD2LKt8VvcRD2zM8FPHYGxFOsFdpZAkmSpmQ/WCEUUcgOIVjFa83sStFmeMBAz5lXnLYrrObSYTtZGv6IpmxoYQkW3bJ1q/o/LyXySAGT38MBLrRB1osk7lrM3+NPyjVzwPHPa9yzBI3S3EpQkXqSY9wiqODQ4hzBTgbfolX4qABhVUFEW15UUdPZXHTJv7K9ZukdmYHiP9ZZnsFLijk+6yLyo/+ULffxJVmxxpfxz2IdYL1RZXfX3fNoLiBZnYBnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hIj0nVhsMBQYcGr4RfUDhyMJkcxdJpv7I5gJkldxkQ=;
 b=ZurDFZ+V+b2QCP1GejIYXPPUHqYzdFeiWWhluAocEtvfKNdd4Uem7TJPvDoLXiFWEHUXdXGerX8yxoS7W9mX1s+5hCnk2JZXAMrTCuEj+2S7JAbV0PsfKFX4E4SK1z8MTfyH3n6yEnfc/+mxRY9ajJMJ+6gSbOFh/xcsbTNDNIEEiAsviyUn07niQcFjik38MQ243sZVGjiesTtfL+IMQMqlzNg5UEUUZyeSIPiSig35R8L5rPvJPsrrVy2Ik5o+m2s+3mXJgxAqt9ij7kJhwHkPeOA6GRPZKlb0rnEE6L1y3PB1XQtKKe/OQrE99O932UJbXtqiBM5t6Vf5yigXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hIj0nVhsMBQYcGr4RfUDhyMJkcxdJpv7I5gJkldxkQ=;
 b=aTetL5u3asytfz/xuoAytiFf2AROTYOnpV5skkM96zL2b+qGrn4UNyrAN4LNErneaWaPbsbITCqCEO5CJn0wgOG+u7aUu+xdtQlVK7Mw/LeHcduRGbRzjShWd8pmawPRheKCyo8P2DxX60E1nktNyU9PBXwFXu/ualu8lKMewvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH7PR17MB6108.namprd17.prod.outlook.com (2603:10b6:510:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 12 Apr
 2023 16:34:41 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 16:34:41 +0000
Date:   Wed, 12 Apr 2023 12:34:37 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Dragan Stancevic <dragan@stancevic.com>,
        lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM =?utf-8?Q?li?=
 =?utf-8?Q?ve_migration_over_CXL_memory=E2=80=8B?=
Message-ID: <ZDbdnRE39Py4X4bT@memverge.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <ZDCv3lxLbquITy8M@memverge.com>
 <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZDV+f7+QH5W/vXAt@memverge.com>
 <87bkjtzu7e.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
 <ZDbNoNN0nkzn4xe6@memverge.com>
 <efe5dad7-8e58-b416-8108-bb692c726302@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe5dad7-8e58-b416-8108-bb692c726302@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH7PR17MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: d1847cb5-9f47-4678-6c06-08db3b73d0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(376002)(39850400004)(451199021)(38100700002)(2906002)(8936002)(44832011)(5660300002)(36756003)(86362001)(83380400001)(316002)(478600001)(54906003)(2616005)(6666004)(6486002)(6512007)(186003)(26005)(6506007)(66946007)(6916009)(4326008)(41300700001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1847cb5-9f47-4678-6c06-08db3b73d0b0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:34:41.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJHDooXr8Rux98MNwajAGGRtRcLCZs7YqyiaprFxJp3oYabYTpDcOYYxnEaC0SimqhPi0r8XJOwj9gEx/WSESXhksN4deqOHUIG5tP3kXhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB6108
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 12, 2023 at 05:50:55PM +0200, David Hildenbrand wrote:
> 
> long-term: possibly forever, controlled by user space. In practice, anything
> longer than ~10 seconds ( best guess :) ). There can be long-term pinnings
> that are of very short duration, we just don't know what user space is up to
> and when it will decide to unpin.
> 
> Assume user space requests to trigger read/write of a user space page to a
> file: the page is pinned, DMA is started, once DMA completes the page is
> unpinned. Short-term. User space does not control how long the page remains
> pinned.
> 
> In contrast:
> 
> Example #1: mapping VM guest memory into an IOMMU using vfio for PCI
> passthrough requires pinning the pages. Until user space decides to unmap
> the pages from the IOMMU, the pages will remain pinned. -> long-term
> 
> Example #2: mapping a user space address range into an IOMMU to repeatedly
> perform RDMA using that address range requires pinning the pages. Until user
> space decides to unregister that range, the pages remain pinned. ->
> long-term
> 
> Example #3: registering a user space address range with io_uring as a fixed
> buffer, such that io_uring OPS can avoid the page table walks by simply
> using the pinned pages that were looked up once. As long as the fixed buffer
> remains registered, the pages stay pinned. -> long-term
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

That pretty much precludes live migration from using CXL as a transport
mechanism, since live migration would be a user-initiated process, you
would need what amounts to an atomic move between hosts to ensure pages
are not left pinned.

The more i'm reading the more i'm somewhat convinced CXL memory should
not allow pinning at all.


I suppose you could implement a new RDMA feature where the remote host's
CXL memory is temporarily mapped, data is migrated, and then that area
is unmapped. Basically the exact same RDMA mechanism, but using memory
instead of network. This would make the operation a kernel-controlled
if pin/unpin is required.


Lots to talk about.

~Gregory
