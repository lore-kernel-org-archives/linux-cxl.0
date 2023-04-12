Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F30C7619A
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 18:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDLSns (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDLSnq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 14:43:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE39D3AAB
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 11:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJmL6GbQbWL6OgmmZDTYasRTKu4u8bYv8gASMS/OdxOn9ryGL+ZCkkR+zkE91tX5rHW6o+neiJ/0hA6ufVW1A+lG2P+2dO+3JAAcjFgnp2XzvN2mHfyLJjqGNjVTMHoR0GM+GgffA+q+GeP3OYdFXPdlftwQgD8HA9uVx78ceKikM4xuC/eREivZuRg+OELw4qpWHssUndVIZL7+Qdxg7m0BidlHqVrCZSBFQ+3jRJ2W2qGViNbMKUEkvwzu6nDWuW6XbAP82/LTOo7bR+H/TQVrUl/GxiqIGYLh9McuysxXxYiKHTemDtjE0402H9c4TDNZLgku6yd1BNyE9DSFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zDrRqlGrAGd8SCD9O5+KErsKp/4nRRfv+77K0qYWZc=;
 b=QBlrsKefWF7uUFC1ymM+4fpEiHwpzfO/ehEi6Dwbnc1AZR1/u/Fnb7fe6MOvPQVKYDD9AU03deZE00rP3W/uJMib4urk1wwlu+YSL1thV4MIyjr8JZ1FaN8tuFf6t1Dz0qacy7kLuKo8ROe+W9M7qHDWl3TbEFn5+4jc7wchgosP7e2vU4ip5alzmcTmwAKi4Fo0wxi94CPiCKV+ZDu2018egXakNJIdHVhoWsz+ev6n7iEd/rcBTRFuYhthFkjjBwBr+6QdJMCuHStWN0V6mOIvPiF/6pEwg2sp2KTLZ5HkdOPR8pEcLVFD0T+k4q3UUMnxepETT2Fg2MvMqseuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zDrRqlGrAGd8SCD9O5+KErsKp/4nRRfv+77K0qYWZc=;
 b=a+IVc1OuYwy81zicnBvq8T+2gF6xKcyI6obstsgrgarsatn/T1fqrCBy8bwQZt1VFtf90qnodkfW2vOZMMVQcCyKT8JOMOe1Vn8jnL3Pv39G5vmvHZSLO9kysH0wUmUiru+uDImqS2oowWny4Q6cLRhJ4CQwfqVz6EkNZjCp90Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH2PR17MB4005.namprd17.prod.outlook.com (2603:10b6:610:88::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 18:43:40 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 18:43:40 +0000
Date:   Wed, 12 Apr 2023 14:43:33 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [BUG] DAX access of Memory Expander on RCH topology fires BUG on
 page_table_check
Message-ID: <ZDb71ZXGtzz0ttQT@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH2PR17MB4005:EE_
X-MS-Office365-Filtering-Correlation-Id: 253d95a9-2123-469b-230c-08db3b85d58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4r/3g8E3UfWEmAPp56eL1h2p30OPMxPZY29XVlq3GW4iZ6ORQ0aN0MAdHJRxcZ1gkEBpnK6Ds2gmNnoDi/kyl4sSetihjTE6+ywqt9esEnXcCTHjSst6Sm+ZWSjR9yhttnY62cLA+p6U8IZ216hALCi917zd4Bs8lKpv8/39asQxRYyaa/7X8fvjEIOw2U7dkP5cFBxYtlGfZxIRG3+uvd9jLaMFoAu5Hk2gfHLACHd+oSLHbMCUDcns+fU+BgeGdwDPNgMwvv1mbUMUIH+zbfAS5Ae6e193DMXOH7EHDsAhgzJjm3RGeeXB8LGilJoQCu7tGqWoownNo9fJgwLvMG97fVcfP4nZ7QCZk7pU3QCES1IJj/DcBXx8thCEuU4RKJh4MKpJAhLPwXPbJAihlzVzPP+WZtV6BM8svfQlxuqs10xmwNy9qVG4CQOvREMwaXrvmbT56Y/5E2YfZuacNyRWyIaFE1ObSshLQ//gfREqVSCLOjnrjbjFiyj65LJRQLB54d5DLt3KBNOzPJwTxaC7+q5IaVVLEunbMp5VQSadpo/TNLSjxpYjhjhFuQQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(39840400004)(396003)(376002)(451199021)(6916009)(86362001)(4326008)(2906002)(45080400002)(8676002)(38100700002)(186003)(66476007)(66946007)(66556008)(6512007)(6506007)(26005)(54906003)(8936002)(478600001)(316002)(44832011)(30864003)(5660300002)(41300700001)(83380400001)(36756003)(2616005)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZjiA43wMWDST4eaD20qsRafcH0l+liehrTrtRhnhipz01tnOKlBJ6xsbLiSi?=
 =?us-ascii?Q?Xm9o8avC1dlWOnLDxnAMlWLU7rp2km0fprh+wC/eSElKvvvcVBIyR9CsytIi?=
 =?us-ascii?Q?GraKZzurKYat97yBmOH9Crvsw61FC/7R6CdadXdrRUyvaNvWg654nTA1RR64?=
 =?us-ascii?Q?BH/PPEJ2UIgZoDQ/ZzNEfDuf37ciZL4P1WYsgZqumqyG+0qGlL8gk5BhPblq?=
 =?us-ascii?Q?7OPCJEp2ASDwvLfSz5N8SaSUQWrMLP9HyIJe0BtAONst1GhT6PHRpMxKgLrc?=
 =?us-ascii?Q?v8siq+Hn5bAOOg67u5Xx7sJ1E+FkoWzsTW11EPvLPrIqYQDNFMNGVRdFdECH?=
 =?us-ascii?Q?9d9yc/rE9ww2B3hUXRXp+HN0QipvUwSte+raLZSxAsjqYuxj7UBhEbPnXluS?=
 =?us-ascii?Q?CwehsAZ7SV5B9QDiPNL1WDgeE8ugpiM/Ohw7fhAxcwvH825KnWXD+OTXrkVG?=
 =?us-ascii?Q?U7a99FWFLhBuV09viS0DPHMvgSybv7QukJ3VdaLF12YOn74rPcCvuRJ1e+1w?=
 =?us-ascii?Q?n8YLSKADp1seIEevm1SL+pwKGcISmKo38vNJjlMiC2HvFwqJwMio/8XDDJbl?=
 =?us-ascii?Q?QiV+K5Cr68cnoWMne9HGgoUVfU3B27WZ4pnkQvGvtd5aell9DXuUlqYDwdtj?=
 =?us-ascii?Q?mUUj5Byc5JJ1mp6PlnIgZlj3ZD2TglO3XYuZza9uf+FdoiPdeD1iaD1nyd1E?=
 =?us-ascii?Q?M4u3xGFtt2aC5Kt2dbbu9OlCInxDxhvrW4PaU+iLDSQDWJN4DIFdfXHuBoOx?=
 =?us-ascii?Q?ZQJUwXmxRP3lBLkGd61r3fIRSnRCYMIc5H7YxgkyNR09Uk3QzV0nbZAAZzQ4?=
 =?us-ascii?Q?mBKGLVG1yPwmqRnujGE/fUU2Mw0sAS8/peiA43PhkcnnvmGYA3c2bf7X5OnZ?=
 =?us-ascii?Q?sZVKOszHpl/952i+GwpWKEhOsZgBGnWWoBTmH/xGWCbQ9YBiluel71s+q9MU?=
 =?us-ascii?Q?WzBDkq45GqshxbzC52yVLoUZXT3MB09q3LXDwVqKuF4Gk6NA4m5D1c5ckARX?=
 =?us-ascii?Q?iNSLPeIgeesMK2AMDpKJZLxj5vxCTqX92mAL5f8dk/PHo61DRNkNcKF5jg1E?=
 =?us-ascii?Q?90SSJ7ptKRWTMR9jkaN9KMZkGBzpTqop0XRUzbMvsMFDwQFjoOs4FXbp2LL4?=
 =?us-ascii?Q?/n6XD8bw/iqniCyOVX0cTFMRny8aeqYteha426rTF/yE/S4jYk507m3fcLKo?=
 =?us-ascii?Q?p+XTjfWm/7CmzirUu/t5b3sJ4W8m8gdJOzp3aJgSPwE2Jrp2YeJ2oFCu9JR3?=
 =?us-ascii?Q?CiDdq5WoMh4VTWz4IGBOoCIaTnlj4o1tsLU72jFUQHKDbURcIOuT7m+QsHvB?=
 =?us-ascii?Q?EFaRIuCCT1f6N/ApmsFfAZzBwMMS+68nnh2TgCyLJnZvrXYs0UctmB44u3lk?=
 =?us-ascii?Q?2w7hmKmppGJzBX6IXd2yTUVejfZ2RuZIuJuFFROwB2gVW5wsE5sUPkLdbyTG?=
 =?us-ascii?Q?qXU5KRMzK6A9NfX5RS6T7fY9UeuGlexj92xnYvdd7q7nGH+RciEZm7n9p56v?=
 =?us-ascii?Q?MRd7L4b3ntZNHV2e5xoeh2ZPxSPD1wwdy+klcUzeZFkdqmvDTzIkEfmRd184?=
 =?us-ascii?Q?vVvKItVXx6VvGIIL9PLrB411yx2MYyR13+fm+0ZcooMDN5ENObJ6yE4QFpHv?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253d95a9-2123-469b-230c-08db3b85d58d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 18:43:40.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUxKRxHRkY9NF4gvxVB9Tunqfmk8oM2U7gi4xDgh37YFyJhoYZQC+Dzxd/8+TPH451IEkl/zVdvtZ26CRzowqsE9EGBodAnuobWtd6pHRcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB4005
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



I was looking to validate mlock-ability of various pages when CXL is in
different states (numa, dax, etc), and I discovered a page_table_check
BUG when accessing MemExp memory while a device is in daxdev mode.

this happens essentially on a fault of the first accessed page

int dax_fd = open(device_path, O_RDWR);
void *mapped_memory = mmap(NULL, (1024*1024*2), PROT_READ | PROT_WRITE, MAP_SHARED, dax_fd, 0);
((char*)mapped_memory)[0] = 1;


Full details of my test here:

Step 1) Test that memory onlined in NUMA node works

[user@host0 ~]# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
node 0 size: 63892 MB
node 0 free: 59622 MB
node 1 cpus:
node 1 size: 129024 MB
node 1 free: 129024 MB
node distances:
node   0   1
  0:  10  50
  1:  255  10


[user@host0 ~]# numactl --preferred=1 memhog 128G
... snip ...

Passes no problem, all memory is accessible and used.



Next, reconfigure the device to daxdev mode


[user@host0 ~]# daxctl list
[
  {
    "chardev":"dax0.0",
    "size":137438953472,
    "target_node":1,
    "align":2097152,
    "mode":"system-ram",
    "online_memblocks":63,
    "total_memblocks":63,
    "movable":true
  }
]
[user@host0 ~]# daxctl offline-memory dax0.0
offlined memory for 1 device
[user@host0 ~]# daxctl reconfigure-device --human --mode=devdax dax0.0
{
  "chardev":"dax0.0",
  "size":"128.00 GiB (137.44 GB)",
  "target_node":1,
  "align":2097152,
  "mode":"devdax"
}
reconfigured 1 device
[user@host0 mapping0]# daxctl list -M -u
{
  "chardev":"dax0.0",
  "size":"128.00 GiB (137.44 GB)",
  "target_node":1,
  "align":2097152,
  "mode":"devdax",
  "mappings":[
    {
      "page_offset":"0",
      "start":"0x1050000000",
      "end":"0x304fffffff",
      "size":"128.00 GiB (137.44 GB)"
    }
  ]
}


Now map and access the memory via /dev/dax0.0  (test program attached)

[ 1028.430734] kernel BUG at mm/page_table_check.c:53!
[ 1028.430753] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 1028.430763] CPU: 14 PID: 5292 Comm: daxmemtest Not tainted 6.3.0-rc6-dirty #22
[ 1028.430774] Hardware name: AMD Corporation ONYX/ONYX, BIOS ROX1006C 03/01/2023
[ 1028.430785] RIP: 0010:page_table_check_set.part.0+0x89/0xf0
[ 1028.430798] Code: 75 65 44 89 c2 f0 0f c1 10 83 c2 01 83 fa 01 7e 04 84 db 75 6d 48 83 c1 01 48 03 3d 21 09 52 05 4c 39 e1 74 52 48 85 ff 75 c2 <0f> 0b 8b 10 85 d2 75 37 44 89 c2 f0 0f c1 50 04 83 c2 01 79 d6 0f
[ 1028.430820] RSP: 0000:ff6120b001417d30 EFLAGS: 00010246
[ 1028.430829] RAX: ff115d297d82b128 RBX: 0000000000000001 RCX: 00000000001e0414
[ 1028.430838] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000000
[ 1028.430847] RBP: fff3676981400000 R08: 0000000000000002 R09: 0000000032458015
[ 1028.430857] R10: 0000000000000001 R11: 000000001ad9d129 R12: 0000000000000200
[ 1028.430867] R13: fff3676981400000 R14: 84000010500008e7 R15: 0000000000000001
[ 1028.430876] FS:  00007f0a660c4740(0000) GS:ff115d37c1200000(0000) knlGS:0000000000000000
[ 1028.430887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1028.430895] CR2: 00007f0a65a00000 CR3: 00000001ab212005 CR4: 0000000000771ee0
[ 1028.430905] PKRU: 55555554
[ 1028.430909] Call Trace:
[ 1028.430914]  <TASK>
[ 1028.430919]  vmf_insert_pfn_pmd_prot+0x2b4/0x360
[ 1028.430929]  dev_dax_huge_fault+0x181/0x400 [device_dax]
[ 1028.430941]  __handle_mm_fault+0x806/0xfe0
[ 1028.430951]  handle_mm_fault+0x189/0x460
[ 1028.430958]  do_user_addr_fault+0x1e0/0x730
[ 1028.430968]  exc_page_fault+0x7e/0x200
[ 1028.430977]  asm_exc_page_fault+0x22/0x30
[ 1028.430984] RIP: 0033:0x401262
[ 1028.430990] Code: 00 b8 00 00 00 00 e8 1d fe ff ff 8b 45 f4 89 c7 e8 23 fe ff ff b8 01 00 00 00 eb 2a bf 7e 20 40 00 e8 e2 fd ff ff 48 8b 45 e0 <c6> 00 01 8b 45 f4 89 c7 e8 01 fe ff ff bf 85 20 40 00 e8 c7 fd ff
[ 1028.431011] RSP: 002b:00007fff888d8fc0 EFLAGS: 00010206
[ 1028.431019] RAX: 00007f0a65a00000 RBX: 00007fff888d90f8 RCX: 00007f0a65f01c37
[ 1028.431242] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00007f0a65ffaa70
[ 1028.431446] RBP: 00007fff888d8fe0 R08: 0000000000000003 R09: 0000000000000000
[ 1028.431651] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
[ 1028.431852] R13: 00007fff888d9108 R14: 0000000000403e18 R15: 00007f0a6610d000
[ 1028.432053]  </TASK>
[ 1028.432247] Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink xt_addrtype nft_compat br_netfilter bridge rpcsec_gss_krb5 stp llc auth_rpcgss overlay nfsv4 dns_resolver nfs lockd grace fscache netfs nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr sunrpc vfat fat intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm kmem device_dax dax_cxl irqbypass rapl wmi_bmof pcspkr dax_hmem cxl_mem ipmi_ssif cxl_port acpi_ipmi ipmi_si ipmi_devintf i2c_piix4 cxl_pci k10temp ipmi_msghandler cxl_acpi cxl_core acpi_cpufreq fuse zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 nvme nvme_core ast tg3 i2c_algo_bit nvme_common sp5100_tco ccp wmi
[ 1028.434042] ---[ end trace 0000000000000000 ]---
[ 1028.434278] RIP: 0010:page_table_check_set.part.0+0x89/0xf0
[ 1028.434518] Code: 75 65 44 89 c2 f0 0f c1 10 83 c2 01 83 fa 01 7e 04 84 db 75 6d 48 83 c1 01 48 03 3d 21 09 52 05 4c 39 e1 74 52 48 85 ff 75 c2 <0f> 0b 8b 10 85 d2 75 37 44 89 c2 f0 0f c1 50 04 83 c2 01 79 d6 0f
[ 1028.435009] RSP: 0000:ff6120b001417d30 EFLAGS: 00010246
[ 1028.435251] RAX: ff115d297d82b128 RBX: 0000000000000001 RCX: 00000000001e0414
[ 1028.435501] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000000
[ 1028.435744] RBP: fff3676981400000 R08: 0000000000000002 R09: 0000000032458015
[ 1028.435985] R10: 0000000000000001 R11: 000000001ad9d129 R12: 0000000000000200
[ 1028.436220] R13: fff3676981400000 R14: 84000010500008e7 R15: 0000000000000001
[ 1028.436454] FS:  00007f0a660c4740(0000) GS:ff115d37c1200000(0000) knlGS:0000000000000000
[ 1028.436683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1028.436910] CR2: 00007f0a65a00000 CR3: 00000001ab212005 CR4: 0000000000771ee0
[ 1028.437140] PKRU: 55555554
[ 1028.437375] note: daxmemtest[5292] exited with preempt_count 1



Test program:

#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

int main() {
    // Open the DAX device
    const char *device_path = "/dev/dax0.0"; // Replace with your DAX device path
    int dax_fd = open(device_path, O_RDWR);

    if (dax_fd < 0) {
        printf("Error: Unable to open DAX device: %s\n", strerror(errno));
        return 1;
    }
    printf("file opened\n");

    // Memory-map the DAX device
    size_t size = 1024*1024*2; // 2MB
    void *mapped_memory = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dax_fd, 0);

    if (mapped_memory == MAP_FAILED) {
        printf("Error: Unable to mmap DAX device: %s\n", strerror(errno));
        close(dax_fd);
        return 1;
    }
    printf("mmaped\n");

    ((char*)mapped_memory)[0] = 1;

/*
    // Lock the memory region using mlock
    int result = mlock(mapped_memory, size);

    if (result != 0) {
        printf("Error: Unable to lock memory using mlock: %s\n", strerror(errno));
        munmap(mapped_memory, size);
        close(dax_fd);
        return 1;
    }
    printf("mlocked\n");

    // Use the mapped_memory for your application

    // Remember to unlock the memory using munlock before unmapping it
    result = munlock(mapped_memory, size);
    if (result != 0) {
        printf("Error: Unable to unlock memory using munlock: %s\n", strerror(errno));
    }
    printf("munlocked\n");

    munmap(mapped_memory, size);
*/
    close(dax_fd);
    printf("success\n");
    return 0;
}



CXL topology at time of error:
[user@host0 ~]# ./cxl list -vvvv
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
          "health":{
            "maintenance_needed":true,
            "performance_degraded":false,
            "hw_replacement_needed":false,
            "media_normal":false,
            "media_not_ready":false,
            "media_persistence_lost":true,
            "media_data_lost":false,
            "media_powerloss_persistence_loss":false,
            "media_shutdown_persistence_loss":false,
            "media_persistence_loss_imminent":false,
            "media_powerloss_data_loss":false,
            "media_shutdown_data_loss":false,
            "media_data_loss_imminent":false,
            "ext_life_used":"unknown",
            "ext_temperature":"normal",
            "ext_corrected_volatile":"normal",
            "ext_corrected_persistent":"normal",
            "life_used_percent":4,
            "temperature":0,
            "dirty_shutdowns":0,
            "volatile_errors":0,
            "pmem_errors":0
          },
          "alert_config":{
            "life_used_prog_warn_threshold_valid":false,
            "dev_over_temperature_prog_warn_threshold_valid":true,
            "dev_under_temperature_prog_warn_threshold_valid":false,
            "corrected_volatile_mem_err_prog_warn_threshold_valid":false,
            "corrected_pmem_err_prog_warn_threshold_valid":false,
            "life_used_prog_warn_threshold_writable":false,
            "dev_over_temperature_prog_warn_threshold_writable":true,
            "dev_under_temperature_prog_warn_threshold_writable":false,
            "corrected_volatile_mem_err_prog_warn_threshold_writable":false,
            "corrected_pmem_err_prog_warn_threshold_writable":false,
            "life_used_crit_alert_threshold":75,
            "life_used_prog_warn_threshold":25,
            "dev_over_temperature_crit_alert_threshold":150,
            "dev_under_temperature_crit_alert_threshold":65360,
            "dev_over_temperature_prog_warn_threshold":75,
            "dev_under_temperature_prog_warn_threshold":65472,
            "corrected_volatile_mem_err_prog_warn_threshold":16,
            "corrected_pmem_err_prog_warn_threshold":0
          },
          "serial":9947034750368612352,
          "host":"0000:3f:00.0",
          "partition_info":{
            "total_size":137438953472,
            "volatile_only_size":137438953472,
            "persistent_only_size":0,
            "partition_alignment_size":0
          }
        },
        "decoders:endpoint1":[
          {
            "decoder":"decoder1.0",
            "resource":70061654016,
            "size":137438953472,
            "interleave_ways":1,
            "region":"region0",
            "dpa_resource":0,
            "dpa_size":137438953472,
            "mode":"ram"
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
        "max_available_extent":0,
        "volatile_capable":true,
        "nr_targets":1,
        "targets":[
          {
            "target":"pci0000:3f",
            "alias":"ACPI0016:00",
            "position":0,
            "id":4
          }
        ],
        "regions:decoder0.0":[
          {
            "region":"region0",
            "resource":70061654016,
            "size":137438953472,
            "type":"ram",
            "interleave_ways":1,
            "interleave_granularity":4096,
            "decode_state":"commit",
            "mappings":[
              {
                "position":0,
                "memdev":"mem0",
                "decoder":"decoder1.0"
              }
            ],
            "daxregion":{
              "id":0,
              "size":137438953472,
              "align":2097152,
              "devices":[
                {
                  "chardev":"dax0.0",
                  "size":137438953472,
                  "target_node":1,
                  "align":2097152,
                  "mode":"devdax"
                }
              ]
            }
          }
        ]
      }
    ]
  }
]



~Gregory
