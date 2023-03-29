Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58544C6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 17:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjC2Rdm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjC2Rdl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 13:33:41 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8D75590
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 10:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwiKhfEhL5ucalrWegl73HtaGINjKzrA0DmBYT5FQMLB889KXL6n6lwOFoffjogeNBKih3rzTKSJclNu6Uyb+6HMilSSFOWXixJchi0obYCOXiEriDzaUSufXb91GBUZ8B1Qb/2xJJdvasHAuT6E+T9P4/CaV5iUvP1SfxY1EupEbcb7EpmzFlJpk7zHv4NlDO4yXQFtbz0acLiblbiEwdlWKGytwHhQRBAefAKMqVqTsPgEwwKJaHrk4piNftLM5gH3frMJHZmk2ledBlqTzRbeWProj2zg6l+gXuA8QNH5xRtjMYSKZjST3uoGjdNrNxoxRzRm+WQiz6xGgiHr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XcI4MIcgieHzkHO5Zob5hfV9524RHlbnOo98ugK+8U=;
 b=VGA6E0Q6VVCploXTjXoK5cc1WerFBmNg5pJmFE1NaQaA6OXTBOuoGUZZ2Ezz63zKKzSdX5ksw8fSjTny8zlzvkgMu3Lmvad/X0hDNA47mkbXXX1+86Y0oSGxLff+drwtSRxLQytNBZfpR0tp7Oz844ucXAFTqmPZgKozo28VWzBvn7Mmm3gM+OIl8fIT5MmE5lM+Bl/3BHx/6RH+N/QkkFy481lO96abiNp3mqPqsW5ogMQAXR75LWC7TqJdyO+Yms91hp4PyHSslQBxz4L63meRfK4eXeUtz0JoitqhUd6zzksjJ/sM0MC6B8qyFKYJKymR3yyOvJirfKizzC99SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XcI4MIcgieHzkHO5Zob5hfV9524RHlbnOo98ugK+8U=;
 b=iawGTCYZGM85OCaalaTeY2QZNF4P1FYVmMqW/q7Bo7PWbGT0U3ROY7o2UYdbgfMLHTqePLJ54akhFxoCjl9QV+KcWNKgEegdPyY6geHceje5jwOEKeMWV5Mj6I0Yy4RTS8P/ijZlOyRP3rb6SFp/7tmIPsnEVrt+tHr0IGHwFjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB6451.namprd17.prod.outlook.com (2603:10b6:a03:4d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 17:33:31 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 17:33:30 +0000
Date:   Wed, 29 Mar 2023 01:22:46 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] cxl/port: Fix find_cxl_root() for RCDs and simplify it
Message-ID: <ZCPLJme6t+Vm9wXY@memverge.com>
References: <168002857715.50647.344876437247313909.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168002857715.50647.344876437247313909.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb58518-9749-4797-1032-08db307bb65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jwwd7x2FxvSeXUZCPq52qIZxfQSDYgYie/GrX7QmHZOWyPnRTyN+RtUuwk3meLLK8pXR409smeSwnZn/B3uCecvyfJ/5gUe0KOcp8SZW9vLZwCuWot21HBmq7jKJBKEhy2ABwRbHWJsWiW0ferwvs8gtcgxO7fRm6f9c+MJT7BCu15GLti8RuPR1TVl3Iuu4LiQqhQfCLZAW9vWAncLYSoXn6lSSPV/vyHOceSNmJ67myzYwX3df1vJ8+ZM6CZaAOqVAFKkJfjA01zU5TT+HudiYmleH2I2/8YvGJzTmiTQDZv2xXoNhj0FSxPYzo5u/5pxpPRLVZEUhaJzZFX3+sEdLWFhvTLlcdY7iZ6b7volIb+TK+dXu+J1s63THPJIB9lV7Wqd80JhVIQg+Kx6IV5lQSrMm4EtchQ663oWGvhWwS35rIyVU0timclSGRtgiPfnIGJQBlhuu/lyN34772Ydo/R3dxD9QM4NDu6M9Df6+S31Dn6G96CYjtgpvQERsVW9PEZXbmdMCxcHuGbwrIt90otBTHNwlN5HTzbMF0YrZa1Q9wwtfpY+bW5S2KnOm/MpHmqHUzEAz+FNx+EMvNyQA63oNwL4+GhgRup3UMDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(39840400004)(346002)(451199021)(44832011)(2906002)(38100700002)(8936002)(4326008)(41300700001)(5660300002)(86362001)(36756003)(478600001)(6916009)(316002)(6666004)(66476007)(6486002)(26005)(6512007)(6506007)(2616005)(66946007)(66556008)(8676002)(83380400001)(186003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/rjcxNjUFIPNXGWhyys6lGQiCf+BkzYO2wYJD5F5JDebQx77++gs19spFDN?=
 =?us-ascii?Q?HdyvM4Sy3BSdoqvDVUsMYucZSe+GwgjSpg/C5Xj0K/uvL8cfu24Lt13+vVOi?=
 =?us-ascii?Q?UPXeFlHbI7m6slK2gIuZj81iHwuERRPc14ktuMoEHkVyoRXeCKL6mHjM16jQ?=
 =?us-ascii?Q?h/32DD+DJ+9N1IThWAc8x9HoaBMu6n+rB8BVrzAfrTuHR+/dQ/BkjhsRMVa8?=
 =?us-ascii?Q?o0sjHqEFW2AnbZjHZin0vnd5BlX/nVM8M0UoRTIJKO0Q+LCgXPsWmFrKa9JQ?=
 =?us-ascii?Q?TrhsZBO5eWGcOT/KrILwLz22yJRO9oV8Sam+MUzW3f1O29e87fCnweX9jM1U?=
 =?us-ascii?Q?Yx80F+SfGHKCd/24NQVlZhMCk9Dc5xfRbd51uVqRQtaVeKpoWJbLdyWios5r?=
 =?us-ascii?Q?xHIHpYwPo9PwWhRGPK2/PgKa/Xfi/IODfXn7KKgI1JrZlAQ38o+4qHjzw77R?=
 =?us-ascii?Q?6iTrsUlz2aEkGTFiPtdKgyB7Uit0QcLZ2fir1SWHYQKBUuOl9CDvOA7t0j5s?=
 =?us-ascii?Q?Fny6oUd55pubLSPnhGFSt2QDorkd6YL0f+A0y3dvaKxIdm6qJhXH8ROIraVN?=
 =?us-ascii?Q?3LAujdOWFPyRSZ403bPmzss9rBgkoEMvuN0TW/fL4GjX6ridLmnUl0ncToKH?=
 =?us-ascii?Q?xeL3Pxi1QSBK4hmi89iaZ1Gji8bgM9R+TQcg01gxvl8dzFsGFtwHEVp2ZxNT?=
 =?us-ascii?Q?EZDNzhJ8xxj91K1qZSKYo7uZ2y4e1J+Vy3Dvhr5Mf4D7AMQg5I86WiEk9uhi?=
 =?us-ascii?Q?XRPuOORP2eeqBLA8vN+D0w/ZjfKL+xbAL6eLLqvjRfUUswAl2d63QrnmFplK?=
 =?us-ascii?Q?xgiFWUyzCaTXHmS4GcXNg/utWyEu818DNSrWO2Uomk5nZl1dlDjuodjpF3MY?=
 =?us-ascii?Q?OjXxKF8Jz153TnED8QtxEA12fmBcugySJhQdj3bGL1aVl9nYxHwgy9VuDjg/?=
 =?us-ascii?Q?KP9yCIR1jgYf5UzhBpJ8zYUZvE6dfypZVA2ds87A1yVXz/Qz69R/ch5DbFeo?=
 =?us-ascii?Q?hrAunrggHWyf67LwlpZ/0kgkPMcwJYwOf8xLjysT4uN5vW9QodsOMnxPSAoL?=
 =?us-ascii?Q?vc5w+x+kWe0ntz5q1L9LjwFSsRjmkbEZvm6nFBkKnr/XfOecFj/DZ04dYPto?=
 =?us-ascii?Q?kqbvDsZIZjeAH5e7jTsrKRLtc5Spz9Y2Fb5U2NLOuVxad+7nuIc2Nf0q6SLU?=
 =?us-ascii?Q?IacmyfjGIm8PxguW9+X/sxDIkFORtGd8oDtAb1K0P58QrS0hqzfYt/HIFrzs?=
 =?us-ascii?Q?X4hlYgpHl6uMjT/UPLgVjuamjJBSmjeOHKVoTGtv7R4wzX4EB8hlss7kHINm?=
 =?us-ascii?Q?3zUN8pX7VUQK8kw3oGJz6XG+UEtFyl3VEYRyLaCLlUIFQMTDNteIxNs2NmVe?=
 =?us-ascii?Q?Y31Pon4TY/S5fLWhGZ24SXwSAp4C00Z1eJi09pQ+XTa7z990y3A1OyyxGQOq?=
 =?us-ascii?Q?a+OI3U45JKACi4UKYRv9zh+qKyPI0LlnJTiN2HtAg36UfKWMU38mi2egmr2R?=
 =?us-ascii?Q?B0WkmvFx0aAifvMlWpP4aDahd9jJPspHCYNiRTvH6oCsOatTEOsFora9jo+U?=
 =?us-ascii?Q?kl9SXap1eyuRDShzqH6Aw7k13wifkj5K5QcMjFvMMRulV8JZQTNfe3cC15yu?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb58518-9749-4797-1032-08db307bb65d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 17:33:30.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMTbyvEHv0PSDXP5/G0HfrIA/Epo3njFh/sefFTL4boByeJCeE2E4jp3xsCN3Zex0nJbUY3EtUf9kLui9yFCpRecdXCDtjZicn1btlzC/IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB6451
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 28, 2023 at 11:36:17AM -0700, Dan Williams wrote:
> The find_cxl_root() helper is used to lookup root decoders and other CXL
> platform topology information for a given endpoint. It turns out that
> for RCDs it has never worked. The result of find_cxl_root(&cxlmd->dev)
> is always NULL for the RCH topology case because it expects to find a
> cxl_port at the host-bridge. RCH topologies only have the root cxl_port
> object with the host-bridge as a dport. While there are no reports of
> this being a problem to date, by inspection region enumeration should
> crash as a result of this problem, and it does in a local unit test for
> this scenario.
> 
> However, an observation that ever since:
> 
> commit f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> 
> ...all callers of find_cxl_root() occur after the memdev connection to
> the port topology has been established. That means that find_cxl_root()
> can be simplified to a walk of the endpoint port topology to the root.
> Switch to that arrangement which also fixes the RCD bug.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/pmem.c   |    6 +++---
>  drivers/cxl/core/port.c   |   38 +++++++-------------------------------
>  drivers/cxl/core/region.c |    2 +-
>  drivers/cxl/cxl.h         |    4 ++--
>  drivers/cxl/port.c        |    2 +-
>  5 files changed, 14 insertions(+), 38 deletions(-)
> 

Testing this, want to make sure I'm seeing the correct results.  As of
right now, I'm not seeing any regressions, however RCD/RCH combinations
don't appear to work as-expected when marked EFI_MEMORY_SP.

When not marked MEMORY_SP, we see the below topology, which I believe is
the correct result (mildly trimmed for brevity).

The memory is correctly onlined as expected at boot (single socket
system, memory is on node 1)

[user@host0 cxl]# numactl --hardware
available: 2 nodes (0-1)
node 1 cpus:
node 1 size: 128934 MB
node 1 free: 137 MB


When the CXL region is marked EFI_MEMORY_SP in bios, the memory is not
onlined - which is expected, and the topology is the same as before.
However, now attempts to online the memory in a region fail.

[root@amd0 ~]# numactl --hardware
available: 1 nodes (0)

[root@amd0 ~]# /data/ndctl/build/cxl/cxl create-region -t ram -d decoder0.0 -w 1 -g 4096 -m mem0
cxl region: collect_memdevs: no active memdevs found: decoder: decoder0.0 filter: mem0
cxl region: cmd_create_region: created 0 regions

As you can see in the topology below, the memory device is not attached
to a region, which seems to be correct as there's no step between the
root complex and the device?

However if we attempt to disable the memdev we get a failure

[root@amd0 ~]# /data/ndctl/build/cxl/cxl disable-memdev mem0
cxl memdev: action_disable: mem0 is part of an active region
cxl memdev: cmd_disable_memdev: disabled 0 mem

So the device becomes unusable in this configuration.



Is it expected that RCD's will fail when set to EFI_MEMORY_SP?  If
that's the case, then this (and the other patch) look safe and do not
produce regression.

Just want to capture this behavior, as it appears there may be other
issues related to RCH/RCD combinations.

~Gregory




CXL Topology produced by ndctl:cxl (lastest version 76.x).

[user@host0 cxl]# ./cxl list -vvvv
[
  {
    "bus":"root0",
    "provider":"ACPI.CXL",
    "nr_dports":1,
    "dports":[
      {
        "dport":"pci0000:3f",
        "alias":"ACPI0016:00",
        "id":4
      }
    ],
    "endpoints:root0":[
      {
        "endpoint":"endpoint1",
        "host":"mem0",
        "depth":1,
        "memdev":{
          "memdev":"mem0",
          "ram_size":137438953472,
          "numa_node":1,             <------ absent in MEMORY_SP
          "host":"0000:3f:00.0",
          "partition_info":{ ... snip ... }
        },
        "decoders:endpoint1":[
          {
            "decoder":"decoder1.0",
            "resource":0,
            "size":137438953472,
            "interleave_ways":1
          }
        ]
      }
    ],
    "decoders:root0":[
      {
        "decoder":"decoder0.0",
        "resource":70061654016,
        "size":137438953472,
        "interleave_ways":1,
        "max_available_extent":137438953472,
        "volatile_capable":true,
        "nr_targets":1,
        "targets":[
          {
            "target":"pci0000:3f",
            "alias":"ACPI0016:00",
            "position":0,
            "id":4
          }
        ]
      }
    ]
  }
]
