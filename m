Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C507BC6379F
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 01:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBXBPC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 20:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXBPB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 20:15:01 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C04B77B
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 17:14:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZOeZdrgpk1rHY0Zc61nAzsLlqLoZQkBLj6s5wTYLsZAoc5CQJ0jPplNsZtSBDGEmjlUIMllkZQh9lvbcklvoVslmpqWEMeX7GqtFiTFl7OOQ3+273dtB+ea6Gut7mp8S3igZAqOnF+/TnVvn2FIiSjQe/COwe2/9NBY9lsceQSdxVqE5EmcxQbm72fc5vb9V5WtT+S0rV2tyJ8bxejYO7ClpS6HHjnaRqUIldbXXpgVtE7VGv7JKOOk9TfjkGr5FPJt1D53jZW+FGAuAh9fYA3o5DCAIpVpL8BR6Pi7iaQnk7eufocYhO70H0W/6SkjGVPmPCGMhb1oqJul9M5pyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqtjFI2cU8joFTR8GhHJmkKi3g5bPbhGFizGg+K7zvU=;
 b=jbEAuR5Dpq7hADzvAdS134JmzgPiu6iKJnSpM+PO5f2WmGuNoKrVO5Gg4V4NMr5Gad9Jhia+YXPNY66TLV/U5yLkoNC6IeQdG66lRj9SSqdfa634TdMjT49ZJh/NxfyBf9FeBLvi91us6ARre4fwpaS9N+JdGkVs60eTyykBGHBfkKFtHxp+tDAJsbkS7HQYuBBGfnd4AyOz/eHBchcloUmyJFKbLB15aFQUg0yEo7JCtcLk+fAvcAOwuttWBS/Ma6vAGdeMpkxR053UkweJuwziOsQ1oNvewpSbSuyIbGBB3PsFVF0/stiuq6dnFszhdZoB8H8LEf0vCOuioRtdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqtjFI2cU8joFTR8GhHJmkKi3g5bPbhGFizGg+K7zvU=;
 b=uqLjRwEHsHz/iWKTgF4e6xGt08NIupZSfAo4D7lZKRqnwHgTbMQRJp+KMDnXXSAGCEy9WmydAHcQqIG4mQebev4hTYmzAqqsTmU7GHKxVLnqT2q93w0krh+3CbLF6INmeZeQlBflny+T6+y1DYYm91XIBXvRVUSaQeYo81OPDo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by BY5PR17MB3969.namprd17.prod.outlook.com (2603:10b6:a03:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 01:14:57 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 01:14:55 +0000
Date:   Thu, 23 Feb 2023 20:14:44 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dave.jiang@intel.com
Subject: Re: [PATCH 0/2] cxl: DVSEC Range emulation fixups
Message-ID: <Y/gPhE3hDnTEd6PI@memverge.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:334::19) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|BY5PR17MB3969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4d601f-6116-4704-2894-08db16048a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHttCP3hPcsW6jMivkhqb5RRV+yrWVeJ5utUIqA4TkdY4Va5F4KB78ryt1fjgapKzlkQGKhu252LzcFaTKBKg9K5K94YbSPKTPc1uMUFlH+q8bEOSH7TzUyxhQTTIpx5Q5WzHRPKVPqk+S1U1e1so68lh48srjPNx0/p8uHoo5EGx1xL/DhdJbxljtv5Ci/s083qi4fe/yB1bs5R89q5r5aPtlV2dPea+ZQfe9OLWV6cjnk2+M1LdjLvus2nbx9Pw81ss/LVXmFA8aIRXRzf8Mr8YA+SMQrli6zNhTgyvfHscVHsHxTUDKwsiIWOtSwIRqMegvbxTEJaCWK+y+/CMJGpWdkHMazyup96OovOGjA1Fy9YiFlr/7wTFUqbEgVDpNS0UHvYr3chRitShlDvCLlwEhLy4/u566IQP4sXFi52t5VBDs699z78hsaeNJyVU02L6NPdj1slv5JrFi6tRRo9tcXPbxIzEW59zpnTUjZPX3WW9ioGhB9ThCoElmJwfr1eWxHU9lWgvm4dkuJ1vvzLObPWMpdxcq/BbORB9Vcsr1HrENcoNkYe9AUf76JPUt9lViXhdb80A7Hl7daVM6NBTT4vv+PlK8KtgQP9f5lgtuLzZuLWaLv4m5awMM2LUIAUSrPUmTNH0PTDadhR3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39830400003)(396003)(366004)(136003)(376002)(451199018)(36756003)(6666004)(6486002)(86362001)(478600001)(83380400001)(6506007)(2616005)(186003)(6512007)(26005)(8676002)(2906002)(6916009)(316002)(66946007)(66476007)(4326008)(66556008)(41300700001)(44832011)(5660300002)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gdv8IFym2yhX+hspVE3xrC/8UTiV9fFniXzDxz7WOvSBmk1AK0cS52D8yi0G?=
 =?us-ascii?Q?OPvFu3Ug0BATFtNG2zo5R+FS1qb7DjvLkRDzRH2yvvbFjcMgT5uHx0HOMLEl?=
 =?us-ascii?Q?uDp1dc3qKYYaFL9fCpzDLtd6BAPsFrX1B+Y1ZrBnKmyReomDAthAEmNpUH1z?=
 =?us-ascii?Q?tv4ZQdW8+NtTkS3fEhPxjw5E+of8EDw7siXE9ksHDC6YhvGZWOf86RjnLGB9?=
 =?us-ascii?Q?SYRES8JZyAgt4v4bxZD4R5dCQ9YwGOs2GUH+ryfJMLPhvUVTLUsCTVz+tQey?=
 =?us-ascii?Q?zrRfjgF14YVEC0XVPfLm/PlTlNljozVrI8wkp9retDNm8gVPIF7m4cjjG/rb?=
 =?us-ascii?Q?X8ZIfC5omBfew143N1/dpWzSCPvcmLXR0/E5NlCB0edpD3YMmL/NQ0rJo/XN?=
 =?us-ascii?Q?naTXz8DKZEm64nTMopEPNzKV6IqP6tMdykv+qvchr5P+qIGyYpK0JU9vzhzQ?=
 =?us-ascii?Q?h85Yjq9kuN2yl2JYPiiuiYhEEjaN8Xslcn6byDYoKM++atuC/zF2yB2O2H4I?=
 =?us-ascii?Q?G0zqCzUE7pO/9f69cDOoTUPJmbN80bRnMduGaJSMG4uFXKwMOZ62d/K/UbPA?=
 =?us-ascii?Q?oD+MfV4SO5Gi2yQCJcdIo2XpidVtBy+PavDEUO4LLakCyWQiOh9yFL1FS42B?=
 =?us-ascii?Q?w058MbSWJsmpbABMI7TM3rwBqZnzZaVy7KPYA1X76iyQr9FgVBpQ0dj7gzxj?=
 =?us-ascii?Q?ApFNjOhnauDVsRDaVoh+nzzohwL/hEVgXVbf3GFilLF5kaIC8ODE1AORhTEV?=
 =?us-ascii?Q?MWR7g6aiEsVWzl0Spbb5BgJs5DNloV41m6IwBB2lgZefZAsxhsjOjRX0O9Cu?=
 =?us-ascii?Q?jFKPqfuhB1OmgLv2lx/AadGnuR8rITYOSgBKGz1nUfzK05nWQmV1msJQDZKO?=
 =?us-ascii?Q?zFVWWvusnMYoIbY73iNVICcKe6BfM//iB+b9XqLBRhr7J9yMjk3GHUruYAtP?=
 =?us-ascii?Q?pGtir7OgaAtwyslufTzXAWL6XCno1ITt8mhSQem51zb+YAk6Xlr2Pdd9PAPH?=
 =?us-ascii?Q?IH6f7AebDQofpFCVJKh50fRSXQliZCnVCEPSSuNizcq+1esSW1ABlJs4rs0S?=
 =?us-ascii?Q?P5PmN0WtOOTZf64IuaLGl3epJbfgLtBGlKPPlCHH3cppclMIGE70rVKMCPXJ?=
 =?us-ascii?Q?YlyPCKXQqbvclvLtTrLeyyTe5EwHDu3Icx5KNB5R2KQMPwU7AZblFSk/69xS?=
 =?us-ascii?Q?p/03N9Wbo3wIppCLaAM4Aewrf7uPHu7ecPevBLhLO6t1VWwSidSRShMyusaH?=
 =?us-ascii?Q?F0VqG/IuZrU+8GlbIz4BW0T3LasFwLDobuyt+D+aGasrrdUr3DtheKhZi8UG?=
 =?us-ascii?Q?du0o1eCpVuvByxSjzMeQXpQFATaXKMslwNOAfYPDwAItkZPYjeNeZk3mM4f1?=
 =?us-ascii?Q?7OxFEbyZFRvPFgvSTFP9TrGFna/F4vRFI9JvemqqKk+iXHy0es2Ms2GzosOV?=
 =?us-ascii?Q?KJqehzGqLuGEcZwC9dANWU2Exu4K0cPBnXNSnb2JohGH4Cd7Mtmq3f9xIao9?=
 =?us-ascii?Q?Qcic5zIZnv4jS/Y5Zt7IuU8CJ1f/e9+gnZ2St0dkgb0Hq7ZXUjA9+PbOq/PK?=
 =?us-ascii?Q?qt1HLObDfskQ5HNPEP2eQ4dGU35dJcW18fn90MgWPqBjLL6AW82X8XGuXsMX?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4d601f-6116-4704-2894-08db16048a03
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 01:14:55.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBJ0v0T+MYSTn6yf7PDN5dNq2JOZJpW3RciupYib8eojW96L5nMqZDuKCzhupJn7BYUhdagDj6MFysJlO4Dgxai7Jvn5tyOEQKNhSMETbUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3969
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 21, 2023 at 05:51:13PM -0800, Dan Williams wrote:
> Jonathan points out that the kernel is too agressive in assuming that
> DVSEC range registers are in use, reliably skip emulation if
> 'mem_enabled' is not set. The helper devm_cxl_setup_emulated_hdm() is
> needlessly redoing an allocation, clean that up.
> 
> ---
> 
> Dan Williams (2):
>       cxl/hdm: Fix double allocation of @cxlhdm
>       cxl/hdm: Skip emulation when driver manages mem_enable
> 
> 
>  drivers/cxl/core/hdm.c |   65 ++++++++++++++++++------------------------------
>  drivers/cxl/cxl.h      |    4 ++-
>  drivers/cxl/port.c     |    2 +
>  3 files changed, 28 insertions(+), 43 deletions(-)
> 
> base-commit: 23c198e3dfaabbc891681aecb0855b9e0ac791e1


not *quite* sure what to make of this yet, but i get stack trace on boot
on real hardware with this patch.  I'm debugging other issues with this
hardware, so i'm not sure if it's related or not, but prior to this patch
I did not have a stack trace.


I think there's two issues here:

1) The system I'm on fails to register a CFMW/root port decoder.  I'm
   not entirely sure why, other than during cxl_decoder_add(), the
   target map contains "[0,]" as the target id's, and the only
   registered ports/decoders are the endpoints.

   I don't know whether this is because the hardware just doesn't have a
   root decoder, or what.  But it makes the volatile region patches
   non-functional, and i have to revert back to static configuration to
   use the real cxl device (i.e. don't mark it EFI_MEMORY_SP).

2) Per the second bit - there's no component registers being registered
   for this cxl device (plus some spurious DOE error).


The no root decoder thing has been throwing me for a loop, if you can
help me shed some light on this i'd greatly appreciate it.  If a socket
has no decoders, should we expect memory expanders to be managable via
the volatile region system in the driver?


relevant dmesg info

[   21.928436] cxl root0: Failed to populate active decoder targets
[   21.929077] cxl_acpi ACPI0017:00: Failed to add decode range [0x1050000000 - 0x304fffffff]
[   21.933150]  pci0000:3f: host supports CXL (restricted)
[... snip ...]
[   21.965126] cxl_pci 0000:3f:00.0: No component registers (-19)
[   22.001597] cxl_pci 0000:3f:00.0: DOE: [d80] failed to cache protocols : -5
[   22.002351] cxl_pci 0000:3f:00.0: Failed to create MB object for MB @ d80
[   22.003265] cxl_pci 0000:3f:00.0: Failed to request region 0x0000000000001fff-0x000000000010201e
[... snip ...]
[   22.339973] BUG: unable to handle page fault for address: 0000000000001000
[   22.340584] #PF: supervisor read access in kernel mode
[   22.346801] #PF: error_code(0x0000) - not-present page
[   22.349059] PGD 1339ec067 P4D 0
[   22.350877] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   22.354558] CPU: 45 PID: 1351 Comm: systemd-udevd Not tainted 6.2.0+ #7
[   22.358357] RIP: 0010:cxl_probe_component_regs+0x23/0x180 [cxl_core]
[   22.361571] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 41 57 31 c0 b9 06 00 00 00 41 56 41 55 41 54 49 89 fc 48 89 d7 55 53 48 83 ec 10 f3 48 ab <8b> 86 00 10 00 00 66 83 f8 01 0f 85 30 01 00 00 c1 e8 18 0f 84 93
[   22.367000] RSP: 0018:ff4fc33844ce7830 EFLAGS: 00010286
[   22.369016] RAX: 0000000000000000 RBX: ff4f28d002dba000 RCX: 0000000000000000
[   22.372736] RDX: ff4fc33844ce7898 RSI: 0000000000000000 RDI: ff4fc33844ce78c8
[   22.372739] RBP: ff4f28d0baaf1268 R08: 0000000000000000 R09: 0000000000000001
[   22.375842] R10: 0000000000000001 R11: 00000000e0690b8e R12: ff4f28d002dba000
[   22.375844] R13: ff4fc33844ce7920 R14: ff4f28d000f9fc28 R15: ff4f28d028b45810
[   22.375845] FS:  00007fbb75a07580(0000) GS:ff4f28df09c00000(0000) knlGS:0000000000000000
[   22.375847] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.375848] CR2: 0000000000001000 CR3: 0000000133ab0003 CR4: 0000000000771ee0
[   22.375849] PKRU: 55555554
[   22.375850] Call Trace:
[   22.375854]  <TASK>
[   22.375858]  map_hdm_decoder_regs+0x46/0x90 [cxl_core]
[   22.398038]  devm_cxl_setup_hdm+0x95/0x120 [cxl_core]
[   22.398111]  cxl_port_probe+0xbe/0x190 [cxl_port]
[   22.398118]  cxl_bus_probe+0x14/0x50 [cxl_core]


~Gregory
