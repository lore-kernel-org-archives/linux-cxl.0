Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C63C4B79;
	Thu, 11 Jun 2026 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171396; cv=fail; b=f7zLB6jHmni++L/tnQ2oyfpDSK09s+T4Qv33oQHhAxjS3EhA+32Oe4JWsovFGD2RA78MZ7PB/+jM8vEU+MgCAPny7JRB6ZM8XCE+FzglY/ae9gBQRfyMXhbQCwObrBOFHtkvf6LEt4UZG4KZ6FVlngJaCnNruALWGNmm0W+o05Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171396; c=relaxed/simple;
	bh=/u0X1pmeilWJDbQFftmEpQKFENe5apa0O8HI4rXEpbw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iuszY1grR0yozJTtIdTnEsdx2ghK9vAz+KtcfRT0IQWL7Y8zXfHaWzmlnF1dMlJr9Qxw+wda6aO86xQjv/+3hxzKOcV6UzQUYuje6eL+Uo67+WKfpBHIa37uX48vxoE2q5yRNn77dZ40KyGM7iLBeIm6YDsQlxeNjmAvfzOS5gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DPVGYfPC; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DPVGYfPC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0Z/kCKPvprQGMwkP/8ZaA5moTLTAZunUFjYsRw9F6ezJSRmTOxlGjwoXvqsIcOpJ1n3CwtWVxbnpJUbjy6NSXAxu6qCPQJUGn8zufLj9tkJeAglbxhvAZfENvetNxz1HnaC6lPsH3Wy6zrKrNaGuV+6epeFjcc8VR0vT06k6YLK1urVPwzZhsC5nS/6EGiaN0p6Hv1cyBHKiCDd9+NTw8fJnPT+EzM+pqQRA/Bd/svRekHGZpy8LexYVnUu2B1TgWXUWxX8jtSFEPDmwzf0yGISfGWdmlrKaBoLdMmngfKxpSt5oC6nhrzRBAbPpt8XNbWa1fy0/3iOQTnseY9xDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKOwmKlR5fMkLNnOuiNdfmGzGgzMDm9QLgKz0DzXkws=;
 b=KD+R6MhzoVwKs7S6AYFyodDXlUxNpCc3I35TnBzO1rBOx/T7LLW5behhCmCzaDbyIlSYPc7kl54YZ89/iPEhfsyxs40tfaaLIZE7Fg04rG/I/4yMPFtQSvaCXLOhDRxXJiajexzJpuhXrxLr7l82yd9pnInwKHOxShQMVNHuRrKKB6ssH1mT4n5jYCrrMtGMq5A2k/8q1S1Wyrs5PkwocJmHlZ26qCqLxx2Ruaynoaw3rgrxnOqyf7D/sdflfklA7pNbedAhXZnigjKQ6i/6k5w2PBQso/rdbnOzyqcZxYnDG7d6WcB4gPJiYnHm40DKdDTi5kvfTUZtGkaVIw68nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKOwmKlR5fMkLNnOuiNdfmGzGgzMDm9QLgKz0DzXkws=;
 b=DPVGYfPCeKZOxE14jwS6VuwwTieEIGN0x+QvudB1MZOoAq27K4KNHneEDwgdCISF4fqtxjZcKoo6weGCK4hHRFWjOv5wi7dDqJonbzrDz0s0kNYa0sfOwHy5Em0TUzYrRylSJbB+Q7KvyARozEq8Chw6YLnnaWShYcyS0q0F/kgZB/NodF9XAUTyig1yps2veqg7+nCUBEf9/VqK+Nu3o3HYTXTtB1gztOsa+QC1eHZC9HnPahMKTqXZZCngVLNwHck75UDWC2U4yFE/7SCkPcIcSzB41zsS0x2tYZMVljK8woW1wTcYHNPhYHk9Obk2cPZVkae6/hjjVyHKzNSiIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB9726.namprd12.prod.outlook.com (2603:10b6:8:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 09:49:50 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 09:49:50 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: shiju.jose@huawei.com,
	ming.li@zohomail.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] cxl/features: Bound Get Feature read count to the output buffer
Date: Thu, 11 Jun 2026 17:49:44 +0800
Message-ID: <20260611094944.31638-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6fe4e1-0867-49c4-c14a-08dec79ec7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|11063799006|5023799004|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	s8y5Hsbz/36taQUkAuUwZUXMpmC4Em1Yy9auG/59/ucG91lXz3hWG7RfYI8VS2y6l0lHHZCmSTbukEi64h05mZVu4sLJxKWp+Da0x7pbMpGGqt/4a9Bv5P32ex7FGS8XYrXH+zHYOJr9Vclqi8xGP1cQDEwDWCflxsa1m/8Uec620M8qGEyYjualIBFiCytKn39dL2fx9WpyyW5P8oFVmohM0xG5pcByXGmUBWQd8/jKxs31L7cvpKplIHC0IegZ4rA9S9c/Uq8fYRl0lTCxB4IRiPeMPyIIM4aiPq73/M6jXAID+wyWRGcdhwW7/Doh+UWeodZuZlJbtG2JVTQj6/VoL165WbJpIy+g6fIGcY4Ehstx0IYUYrtnWOTfAFUoKoTyllTwnSDfmZhkpSggTWELEtD6rogZa39DK692vcgAIC8lg4bFRk9fgO5cKZbv23803GrLU0Z+t64+9IVpMI0oH4eM4Jj/X4nbI2qWcvVk7BdrGdVdXrjj43W4wgHlwwPy9TRNJzNjonaJrSHAs10f3tgZSIVx04eYMfVj7MWSrWi4txCqFoCKPKI/rBGJyVUbp8b6idiczGCc805owPs1KEMmv05kUW+pLyc6DbVSH4AKJ9al7fiAJ/X6Lns2IWI3gsg8uHRtHmpNW9v87liQpiarXzBvjEaOFxOXcqTX1Rn7sSZl3VKIDsJ8yL0s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(5023799004)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQaOFuCFxzmJQgIGcPWWZXCtTTQww422aIXTcRf5/zVQAYKEj4oW3r3iE4OO?=
 =?us-ascii?Q?uYRV0MLv5HPJy03f60t6+nrMs+wKDv6JC/ugY+YbYcFGf5h4DWOknH/7RUjm?=
 =?us-ascii?Q?i7lBq73Y7An/rtx3uwqm60Ao4AI4QWMfI+Su3RkgIyZzR+rADqCwU5F/NhWU?=
 =?us-ascii?Q?GY/XfF2GaKhhlEb4klCzFQ+eR/8tHbhKAzD1WRJ/DElGKxsrb4yFdnCZhO+v?=
 =?us-ascii?Q?H3dT9cHvAt9Xp/fSufqCWYEJKkZBCmlWq/IUmkseK+Xa6f+4WeWR9DH/G9dY?=
 =?us-ascii?Q?KgZYncBU84z9QcIXI2qTsJUEuTZtJNFGbScSVX5O2s/BC6D5C0Ol3zRmVilL?=
 =?us-ascii?Q?NFC80WMRn2F0CRHuBoiJOCHClOwURaDqdsPlSUwRj/iw6me00jznQsoj6JsB?=
 =?us-ascii?Q?VMiWGb27+Wc915EWLLLhrFUy4QWjtwpXmQPAzfUaIF4rlFPzTaeaC+gkLJVE?=
 =?us-ascii?Q?NGiQBS+bm3bxODTJmS8RtSkM+aUw7eFIOCBeakhvIwOtQVmYgkFTz1mWGUDJ?=
 =?us-ascii?Q?WHdpK2yn4EeFiDtvLdsN4lGjDw8n1N2xSUnkGCkdoDzXHrHIkXVTSvBzFCL9?=
 =?us-ascii?Q?vJYQ3TSaYWUCEcAN/nEoczOPtZh6ttaptf2LZoLGyjLpADmTOtLHBYxt2+kE?=
 =?us-ascii?Q?FQDgiHYd81CfoMjycDXikRpofHlgdOzs25U7Ip9vXTZloprhNdn6bif5z2Tj?=
 =?us-ascii?Q?hmM40TATmJwJoPTkdwVigYPu18vcp+fV5Zx72qQXRU63vBpdYyXDiN2upKfr?=
 =?us-ascii?Q?uAPfbTc7tPnfAXygvqIuGPfUxj+rBi2mZJ+KbDOHdtQUgmdxy56hA9/Z3yfQ?=
 =?us-ascii?Q?rGTproC0dJiMSN03oY7uyYaHb3tALMtsh+wyEn0W9nHAkrLOtmjVbA+k/Zwb?=
 =?us-ascii?Q?ni8W8s2ngQzIWKVRZtjesbjdjY1QgndC5UDBOc3EAOC/OyQOGoTPwl6TLQCa?=
 =?us-ascii?Q?747cJCmL99DwsoJim6Z9l+cAY/F1OM0QlM9oyy1e7TTF3G7lQZW+u0r5v+EK?=
 =?us-ascii?Q?qN2VfwIpDlXqpDkaIpUA7DfJ/XG0SL6P0Z4l/dYk0rXR9kwZL/T7gPKI4PP5?=
 =?us-ascii?Q?YCOUpGpqwbFjzkRGerqMFXN3iNPy/m4iSV6eC3BtB/M5Kf7ka3p9JHod2mKR?=
 =?us-ascii?Q?CAYt9EpvDk875PWhogn0dh74JlY9jSmMP0dAiDusnDUsOzJhdxhR5DvZb+Wt?=
 =?us-ascii?Q?pLWIJNgMcrF8YVQY/4yG4CSkbhd/+5JvXgUcx1ZxMLpVtI+gHevh7jobZpgr?=
 =?us-ascii?Q?O4Hft5eNnLqqUeYG4FnUFpFaWDe8iF+WqWVx1oNLhS6UJlXAFnp8JIaFNsRQ?=
 =?us-ascii?Q?VNqE5BZqH3mdfkLI9NGIHoctLY4YKhI2ehJT9gl7ZmLWnuyxkx1KauPa8X/V?=
 =?us-ascii?Q?coPPbhpoqJHQrOxqxGeqaurULw2UuPjoe0hah4YnqMmNpXC3IrgXP93ckvnY?=
 =?us-ascii?Q?J5RSbyiQjQPo6eIudSSm/H8npuJ0f0a1bJiNWA08sxVt+sP1lvVa6N18Rn+8?=
 =?us-ascii?Q?JolrUvtHEiIzHavWQV4dyNisG+oGAQ92hdhat2Bo4c2CJsulhci5A3AVhHC4?=
 =?us-ascii?Q?5xJxSR1dwDCq/LN0djZupNoFm/WWfDFjLg9RNAz8GcxtyaZI2PMmVfjpTquh?=
 =?us-ascii?Q?7fulUuR7q8HhbfkwBwMDJLgqawmEJyMd5OJvd+l0oXYzWD9E0czdUtPWzRoZ?=
 =?us-ascii?Q?TS9Z7pBCUUC1arfex77HCo1Pcl7OzF4wDm0RWUK/JQ+o2KwG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6fe4e1-0867-49c4-c14a-08dec79ec7ad
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:49:50.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KH3ZWmmA2z5mJZmooXSSFJVwfY3hR4N6i0a51ns2Sjl5+9LlBxre5vLSrQ+B4sat77q4cxz8xSW1yTfZItzE3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9726

cxlctl_get_feature() sizes the output buffer rpc_out from the
user-controlled fwctl_rpc.out_len, but the number of bytes the device is
asked to write into rpc_out->payload comes from a separate
user-controlled filed, cxl_mbox_get_feat_in.count. Nothing ties them
together, so a small out_len with a large count makes cxl_get_feature()
write the device's feature data past the kvzalloc()'d buffer. A heap OOB
write reachable from FWCTL_RPC. Reject requests where count exceeds the
available payload room, before the allocation.


The issue is triggered via the following reproducer [1], with error log
[2].

[1]:
"""
        #include <fcntl.h>
        #include <stdint.h>
        #include <string.h>
        #include <sys/ioctl.h>

        #define FWCTL_RPC      _IO(0x9A, 1)
        #define GET_SUP_FEATS  0x0500
        #define GET_FEATURE    0x0501

        struct fwctl_rpc { uint32_t size, scope, in_len, out_len; uint64_t in, o
        struct hdr { uint32_t opcode, flags, op_size, rsvd; };               /*
        struct get_feat_in { uint8_t uuid[16]; uint16_t off, count; uint8_t sel;
                __attribute__((packed));                                     /*
        struct feat_entry { uint8_t uuid[16]; uint16_t id, get_sz, set_sz;
                uint32_t flags; uint8_t gv, sv; uint16_t eff; uint8_t rsvd[18];
                __attribute__((packed));                                     /*

        static int fd;
        static int rpc(uint32_t il, void *i, uint32_t ol, void *o) {
                struct fwctl_rpc r = { sizeof(r), 0, il, ol,
                        (uint64_t)(uintptr_t)i, (uint64_t)(uintptr_t)o };
                return ioctl(fd, FWCTL_RPC, &r);
        }

        int main(void) {
                uint8_t in[48] = {0}, out[8192] = {0}, o8[8] = {0};
                struct hdr *h = (void *)in;
                fd = open("/dev/fwctl/fwctl0", O_RDWR);

                /* 1. enumerate features -> pick a real UUID with readable data
                h->opcode = GET_SUP_FEATS; h->op_size = 8;
                *(uint32_t *)(in + 16) = 48 * 64;          /* get_sup_feats_in.c
                rpc(48, in, sizeof(out), out);
                int n = *(uint16_t *)(out + 8);            /* num_entries */
                struct feat_entry *e = (void *)(out + 16);
                int b = 0;
                for (int k = 0; k < n; k++) if (e[k].get_sz > e[b].get_sz) b = k

                /* 2. Get Feature: out_len=8 (zero payload room) + non-zero coun
                memset(in, 0, sizeof(in));
                h->opcode = GET_FEATURE; h->op_size = 21;
                struct get_feat_in *g = (void *)(in + 16);
                memcpy(g->uuid, e[b].uuid, 16);
                g->count = e[b].get_sz < 32 ? e[b].get_sz : 32;
                return rpc(48, in, 8, o8);                 /* -> OOB write below
        }
"""

[2]:
"""
  BUG: KASAN: slab-out-of-bounds in memcpy_fromio+0x234/0x730
  Write of size 8 at addr ffff00016b629648 by task repro_fwctl_get/3637

  CPU: 41 UID: 0 PID: 3637 Comm: repro_fwctl_get Not tainted
  7.1.0-rc7-cxltest-kasan+ #1 PREEMPT(full)
  Call trace:
   show_stack+0x28/0x48 (C)
   __dump_stack+0x2c/0x50
   dump_stack_lvl+0x80/0xb8
   print_address_description+0x84/0x220
   print_report+0x54/0x80
   kasan_report+0xb4/0x130
   __asan_report_store_n_noabort+0x20/0x38
   memcpy_fromio+0x234/0x730
   cxl_pci_mbox_send+0x6c4/0xc00
   cxl_internal_send_cmd+0x114/0x228
   cxl_get_feature+0x18c/0x2a0
   cxlctl_fw_rpc+0x5f0/0xeb8
   fwctl_cmd_rpc+0x2c0/0x598
   fwctl_fops_ioctl+0x30c/0x4a0
   __arm64_sys_ioctl+0xc08/0x1380
   invoke_syscall+0x110/0x188
   do_el0_svc+0x110/0x1b0
   el0_svc+0x48/0x108
   el0t_64_sync_handler+0x88/0x148
   el0t_64_sync+0x1b8/0x1c0

  Allocated by task 3637:
   kasan_save_track+0x44/0x98
   kasan_save_alloc_info+0x48/0x70
   __kasan_kmalloc+0xa0/0xd0
   __kvmalloc_node_noprof+0x3fc/0x6a0
   cxlctl_fw_rpc+0x5b8/0xeb8
   fwctl_cmd_rpc+0x2c0/0x598
   fwctl_fops_ioctl+0x30c/0x4a0
   __arm64_sys_ioctl+0xc08/0x1380
   invoke_syscall+0x110/0x188
   do_el0_svc+0x110/0x1b0
   el0_svc+0x48/0x108
   el0t_64_sync_handler+0x88/0x148
   el0t_64_sync+0x1b8/0x1c0

  The buggy address belongs to the object at ffff00016b629640
   which belongs to the cache kmalloc-rnd-04-8 of size 8
  The buggy address is located 0 bytes to the right of
   allocated 8-byte region [ffff00016b629640, ffff00016b629648)

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eb62
  flags: 0x17fffc000000000(node=0|zone=2|lastcpupid=0x1ffff)
  page_type: f5(slab)
  raw: 017fffc000000000 ffff000080016c00 dead000000000100 dead000000000122
  raw: 0000000000000000 0000000808000800 00000000f5000000 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff00016b629500: fa fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
   ffff00016b629580: fa fc fc fc fa fc fc fc fc fc fc fc fa fc fc fc
  >ffff00016b629600: fa fc fc fc fa fc fc fc 00 fc fc fc fa fc fc fc
                                                ^
   ffff00016b629680: fa fc fc fc fa fc fc fc fc fc fc fc fa fc fc fc
   ffff00016b629700: 00 fc fc fc fc fc fc fc fa fc fc fc fc fc fc fc
  ==================================================================
"""

Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/features.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 3435db9ea6b1..3f949225da6d 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	if (!count)
 		return ERR_PTR(-EINVAL);
 
+	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
+	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
+		return ERR_PTR(-EINVAL);
+
 	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
 		kvzalloc(out_size, GFP_KERNEL);
 	if (!rpc_out)

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.43.0

