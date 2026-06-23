Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119E371048;
	Tue, 23 Jun 2026 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179694; cv=fail; b=TXrWlwlcGcFd+p2glrNgfeCnRUvv6yli8ibmzMU3MmSn82aqxyV9eGZQY4Y1fXCRvqGqGlmRqdKEbQw4Bh7+0QWlBEJocl1RFR9VqQUAqlPSQ4Gie8aDudar8SCL3HtipNeIE1fM9VM8e5YOZkUNwGRF0bKpJ4kOyK44zM/ZuAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179694; c=relaxed/simple;
	bh=UX/jQh282pE+FwC2bO5wxMJKcXY7IjV9sDghWcNbaII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eZql0pWdCiqZ0miEM9UbqouYv6vwDACOdRwzpk/Mss8ByY75P2OKgx77sjFbksDT3Jsm2DoRAMFayq/nW82jxg8VgYXz1sxjAdsafJOacwNA5WYaV1WjHb+wMkHMAtvrrBhkDR6p7jK9jCQ/Wdf91KMNJWMyWB5MOYKDMCfGp7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CkmB7Ql5; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CkmB7Ql5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTt1xqFPqk1mIBAnTPocRz2lz9i99etQtWM1bL7MLOZuGoXWwKP40285BQFjZYaAYeVnHr+eIV6xOAEgoVFpNBpRLw2zuRlJVoXhsMuCHFJSnevMN2IE+Lu7P6WjP0emupd+VuelFfkFTc6PTutsVjYYryPWAKj/hbRESWUaIkFvdoPVQfRYk4Ig8ZB6/bQg+x9T8YCuN9ng/+nmggaRptEsqJsqRibZuX00vKYdd02k+Ko+2CI+5aEn8vdhrSMHQoCgad853T4wkow+fQ5YlOTAUOYgNVjT6r1AVijsSHgEh6CSGgAaQtnA0hy5kxNOxyy6/tx3bixPzauOTAOrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziao22BZBVIi6In/zJA82XsphRldGCU9HK/COXTRj+k=;
 b=yO3G6GYz30+XF35x1YPbGb523QZUiVQyvkxtrfx8/0RlFYdygppuFkSZgfUHulz9p3Q1hUN+hghBtSb1mekdkZdkVgeEcBj0T3exDDSPy1yZtVhymystJ3P0g1f+dtcwBv5/LZjhFS+9wrQFMw6g7CW3V4Vh4G7VCWrVGtA5z1HJu0zN9TdE2GqYBNQEKeYH9LzGx7bkLQqv4zrLB0A9RjT3yTbqYDpLzsSQXlLolJJoATZMxrH/RIEU8qwOIPD1MffXYjSOd/WmerE/3jJjXWQZQLD+GcbCY9Wdb1RJZfmkDQen5yxPP1JJZ1JxWzHi4rYNoh3Pg0JOdR+DfRpJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziao22BZBVIi6In/zJA82XsphRldGCU9HK/COXTRj+k=;
 b=CkmB7Ql5DoZK/dVQmPenFcCbvV9Tm84ZzxnzDGb6mw2VxXo3yzItQc58DskhM9zaZhV0tLvjS39pjJ3LKod18xaUwvHdQOHSqqFsV9kddxcuDvnGwSdB8cgJ/E5/Di7MmLI2cB8v1KSICPeZquEbPayFqcdgamSetgvhmce3qjyuODEhJhXVFr03PDtmzDlapkA+8d+syshwCqw/Ajz/UirrElnu87fs+DIbdHqEzwrc3hSpkPw/ipx5gpiqDoznveRPSb9dDi6oJnUf7gT7mq1nn/dhATXjA5eH3S83R/1D8Vucaf2Iu6UhUkhPqTYXBW+cBm8qFkI572+WuahkoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 01:54:49 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 01:54:49 +0000
Date: Tue, 23 Jun 2026 09:54:41 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, shiju.jose@huawei.com, ming.li@zohomail.com, 
	alucerop@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH] cxl/features: Bound Get Feature read count to the output
 buffer
Message-ID: <ajnm3jW3EO9SuCWr@MWDK4CY14F>
References: <20260611094944.31638-1-icheng@nvidia.com>
 <e3450695-1182-43a7-ade8-2d056efbac0c@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3450695-1182-43a7-ade8-2d056efbac0c@intel.com>
X-ClientProxiedBy: TPYP295CA0008.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::9)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: 461da516-53f9-407d-b0c0-08ded0ca6711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	sE0R9w71lwe5zeTubDq0fSRyvIovnNRAtCu2ybMWcj/eUBr6DjzoZ9VZBZDxvZJ9lzSVU/DgjTt9DikP8dm2PHr8Ji7Wbh6zxNDhqe/aVY23Vl2vClUBdsGluhLhsm6b5Wg3m7Wl8h7lKo/C7CFErFahB6/WRzdb3G+5W7Atdfn1M8q90uHnwsMtwnYZfQ69GZhJ2/cqkg+yHDXAGbCMgnpGNYwxw+T8OMxqMOEmp+qQ+9fMkHtmw9Tx6k4Dqt/nE9Rn/FW2nsiy5GPZpgmBk71Bh4KKWqANOq/9Sl0qmiPpXzf3NO0H1kj/ETB+eCahIGsfl/6dBKj9mUiWGVuSWAh7QgiZ0zrzKOW+rZ4/FadAJBX+vPgmXtlNbll3ZnBEH2C+rJUKH+zZ02fzHqZ1sYH8/k0hw0HD4nyf12kEbtlQlp2qq38wAlhGXob8mJ0LJAU/8KoJV6CpnZzLl+OOML7xtJ5Jfdh+0/ZG7Bus2eQb9tfVFg+6WJYJRYrTt+zFH1aP8zMRXo22zzCrpzGHuYUOOiCXdbYnR2E1D3MGAsqWGHuXzXqk1RJqRhP3WnkYdTDfMfZOX8Z3clz5w26GfS93AjNEY2tIL1xpBNa6zX0ynNMkQLVPLd8l9UFRWh8ylhENdYe3neji5LIMo4TFtSM/rZgTPXt1LEyLsvpSiu8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Io3m8uSgp3Ets0bUR1u/Pri9Z/ptLvYu/X2qGjtELaQBHlXN/YmKqs/vWUJq?=
 =?us-ascii?Q?ISMT7uMiZQybanYvgz6xIYQzfjq1ElGDVd3n3j2KlJH5GGf5ypND1NP3lXcd?=
 =?us-ascii?Q?hXQXVDYD+HzdtWK0MvYqvwFoMEbpkciHTM7RKq1KYfuhm72Mb56IOxTYvQEn?=
 =?us-ascii?Q?DafNxSScjr67HhbzZsZXdQ52vLinbXpwNm+whPFQvtRyOSxhlxohSTXmeUCM?=
 =?us-ascii?Q?71LHRZGpXl2fINSMrOpE30OB5oKuXyAAJ9F1rLKN6GUoEGjrBMgNOxS8Gc8F?=
 =?us-ascii?Q?ACiGZhGnvW54q3AH/BMeW2oLFoAlBGIdhGmGL6q5d7JLmdcT66Mg89mMrVvp?=
 =?us-ascii?Q?zoDqybzNrynON6dCrMdY51mdrAq/LdoR5oATnrtuvmFR7GZ5p0kRWHzUDWt1?=
 =?us-ascii?Q?12+LSpZaeZmmkjmltfUi9MoNWUquqnSeV3wPJlE59cKLVmqSERjAqHZwSEKN?=
 =?us-ascii?Q?q7P3xp6gJLpubq41imjePBmeWHO30anykjVDss/RV2ntNkIcqroK2ePxxPuh?=
 =?us-ascii?Q?ToIxne70L1Or1LGpiGbxYdCP0FRY5u3qAyS2eD7svwxSICEsWMyVhBdz/4tw?=
 =?us-ascii?Q?3I9itjS8NcRu554G3VD4F4mb+LQyAhYir6Tq2ecO/VjZZ9tBMVOtLuyiOnLk?=
 =?us-ascii?Q?fbmSvp+83sClx2t/gxbhDtXb7oKF3wZ2brFL8F9QOwnv+tLEDvozw6smveBT?=
 =?us-ascii?Q?th6qpE9ibTAukNE/qqbXIFrpE63tI++YNeCwY3XL9AH2+Jqv9wXgkAkhRm/h?=
 =?us-ascii?Q?eBb3u3FKsceb08hE30GqJeyYPPevpCIfXmKxN9fJyA3Bc+ttaNfL8wleUf4X?=
 =?us-ascii?Q?HW/Bquewglj1TAyLQCIVFXclthS1ho/x2+NX+estNc4AXWPyYDmr4zQZsROj?=
 =?us-ascii?Q?MFsSCil3iVYcwpAvrBJgoNC+D/nBkdjcwfgFOjIXEwpTb+BT8wg9xPF6rbh6?=
 =?us-ascii?Q?e5TM0c8McbUtXqdEqHCb33Z9tU+VWIakyeHuP5CIDi2dc+ugUuGOlXzsg3cc?=
 =?us-ascii?Q?YoEyyzMAxQcfRtqlZ5QUWhz0Mu+HJiRUQkzXAFQWTJvsfBEMtrJpDmmM5Hhp?=
 =?us-ascii?Q?uITzKDJygouNN40gtGvvO2vr0D6tMOx2If6i3PCBRayWVraTcnifyZyJk4XT?=
 =?us-ascii?Q?rFeHZqN0u/GURsmiLBxVQG6y9Gt4j0j1IU/JlOGFA+Q/wZbh3p3eagUHB1d2?=
 =?us-ascii?Q?uJ2uSVlNjcdSCHDJQkarvzDkKk40vX4RuRr33rL5NzHQ3JcIfnT976OBGzps?=
 =?us-ascii?Q?Ll+67OABL1I66OQu37RPTf+cfXXTHYlTMakEAdzGFbKX5lmdWHmM14shtuz8?=
 =?us-ascii?Q?aobJwJMrTtVluGg+wl3FEoJFbSsvYC4fD0Gfzs2xfPy4osokttvvT/Sh3f8Z?=
 =?us-ascii?Q?IPA9ZvDZQUga601yfRqrwIeCQjQUml+0gVpNT7hGAtKdqFDLNg++Bdz0qgl8?=
 =?us-ascii?Q?8FHVCRpss0avPR+RESBgrgAMxFTSI8v2zIgfE4GMf6oUugYqDYyLm3fLIQec?=
 =?us-ascii?Q?c1YsXaiiF0il/W0uyQ1vxuRGA0XL9WPe72KndOZaRD8FLy4LcqiLbSBUi2XJ?=
 =?us-ascii?Q?khvNjhpra4/TGXXDseoia78Mww+Zatef70sTdURB3FlOOf/t3nYEAjy9uFuM?=
 =?us-ascii?Q?Z2EqTVGRJ5h7pBveC8trcQY4HKKZJVyszvDm51oDaM4AeHbtNXQNLuTeKMh1?=
 =?us-ascii?Q?oye9Q06FfzSOmWMqwIA918KMEvkZQ5B8vAvnlB/6GSFLpJ8P1zMZrx+8sO3L?=
 =?us-ascii?Q?uLhWXfdVBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461da516-53f9-407d-b0c0-08ded0ca6711
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 01:54:49.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXm8lCvl9yf+q4AziRGiVLswLtREcE1d4BM/9BWZtoh8lQa713Aohv8hXn57gCDC5xTQSOTf2C40wX6hKnwXGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581

On Thu, Jun 11, 2026 at 08:28:00AM +0800, Dave Jiang wrote:
> 
> 
> On 6/11/26 2:49 AM, Richard Cheng wrote:
> > cxlctl_get_feature() sizes the output buffer rpc_out from the
> > user-controlled fwctl_rpc.out_len, but the number of bytes the device is
> > asked to write into rpc_out->payload comes from a separate
> > user-controlled filed, cxl_mbox_get_feat_in.count. Nothing ties them
> > together, so a small out_len with a large count makes cxl_get_feature()
> > write the device's feature data past the kvzalloc()'d buffer. A heap OOB
> > write reachable from FWCTL_RPC. Reject requests where count exceeds the
> > available payload room, before the allocation.
> > 
> > 
> > The issue is triggered via the following reproducer [1], with error log
> > [2].
> > 
> > [1]:
> > """
> >         #include <fcntl.h>
> >         #include <stdint.h>
> >         #include <string.h>
> >         #include <sys/ioctl.h>
> > 
> >         #define FWCTL_RPC      _IO(0x9A, 1)
> >         #define GET_SUP_FEATS  0x0500
> >         #define GET_FEATURE    0x0501
> > 
> >         struct fwctl_rpc { uint32_t size, scope, in_len, out_len; uint64_t in, o
> >         struct hdr { uint32_t opcode, flags, op_size, rsvd; };               /*
> >         struct get_feat_in { uint8_t uuid[16]; uint16_t off, count; uint8_t sel;
> >                 __attribute__((packed));                                     /*
> >         struct feat_entry { uint8_t uuid[16]; uint16_t id, get_sz, set_sz;
> >                 uint32_t flags; uint8_t gv, sv; uint16_t eff; uint8_t rsvd[18];
> >                 __attribute__((packed));                                     /*
> > 
> >         static int fd;
> >         static int rpc(uint32_t il, void *i, uint32_t ol, void *o) {
> >                 struct fwctl_rpc r = { sizeof(r), 0, il, ol,
> >                         (uint64_t)(uintptr_t)i, (uint64_t)(uintptr_t)o };
> >                 return ioctl(fd, FWCTL_RPC, &r);
> >         }
> > 
> >         int main(void) {
> >                 uint8_t in[48] = {0}, out[8192] = {0}, o8[8] = {0};
> >                 struct hdr *h = (void *)in;
> >                 fd = open("/dev/fwctl/fwctl0", O_RDWR);
> > 
> >                 /* 1. enumerate features -> pick a real UUID with readable data
> >                 h->opcode = GET_SUP_FEATS; h->op_size = 8;
> >                 *(uint32_t *)(in + 16) = 48 * 64;          /* get_sup_feats_in.c
> >                 rpc(48, in, sizeof(out), out);
> >                 int n = *(uint16_t *)(out + 8);            /* num_entries */
> >                 struct feat_entry *e = (void *)(out + 16);
> >                 int b = 0;
> >                 for (int k = 0; k < n; k++) if (e[k].get_sz > e[b].get_sz) b = k
> > 
> >                 /* 2. Get Feature: out_len=8 (zero payload room) + non-zero coun
> >                 memset(in, 0, sizeof(in));
> >                 h->opcode = GET_FEATURE; h->op_size = 21;
> >                 struct get_feat_in *g = (void *)(in + 16);
> >                 memcpy(g->uuid, e[b].uuid, 16);
> >                 g->count = e[b].get_sz < 32 ? e[b].get_sz : 32;
> >                 return rpc(48, in, 8, o8);                 /* -> OOB write below
> >         }
> > """
> > 
> > [2]:
> > """
> >   BUG: KASAN: slab-out-of-bounds in memcpy_fromio+0x234/0x730
> >   Write of size 8 at addr ffff00016b629648 by task repro_fwctl_get/3637
> > 
> >   CPU: 41 UID: 0 PID: 3637 Comm: repro_fwctl_get Not tainted
> >   7.1.0-rc7-cxltest-kasan+ #1 PREEMPT(full)
> >   Call trace:
> >    show_stack+0x28/0x48 (C)
> >    __dump_stack+0x2c/0x50
> >    dump_stack_lvl+0x80/0xb8
> >    print_address_description+0x84/0x220
> >    print_report+0x54/0x80
> >    kasan_report+0xb4/0x130
> >    __asan_report_store_n_noabort+0x20/0x38
> >    memcpy_fromio+0x234/0x730
> >    cxl_pci_mbox_send+0x6c4/0xc00
> >    cxl_internal_send_cmd+0x114/0x228
> >    cxl_get_feature+0x18c/0x2a0
> >    cxlctl_fw_rpc+0x5f0/0xeb8
> >    fwctl_cmd_rpc+0x2c0/0x598
> >    fwctl_fops_ioctl+0x30c/0x4a0
> >    __arm64_sys_ioctl+0xc08/0x1380
> >    invoke_syscall+0x110/0x188
> >    do_el0_svc+0x110/0x1b0
> >    el0_svc+0x48/0x108
> >    el0t_64_sync_handler+0x88/0x148
> >    el0t_64_sync+0x1b8/0x1c0
> > 
> >   Allocated by task 3637:
> >    kasan_save_track+0x44/0x98
> >    kasan_save_alloc_info+0x48/0x70
> >    __kasan_kmalloc+0xa0/0xd0
> >    __kvmalloc_node_noprof+0x3fc/0x6a0
> >    cxlctl_fw_rpc+0x5b8/0xeb8
> >    fwctl_cmd_rpc+0x2c0/0x598
> >    fwctl_fops_ioctl+0x30c/0x4a0
> >    __arm64_sys_ioctl+0xc08/0x1380
> >    invoke_syscall+0x110/0x188
> >    do_el0_svc+0x110/0x1b0
> >    el0_svc+0x48/0x108
> >    el0t_64_sync_handler+0x88/0x148
> >    el0t_64_sync+0x1b8/0x1c0
> > 
> >   The buggy address belongs to the object at ffff00016b629640
> >    which belongs to the cache kmalloc-rnd-04-8 of size 8
> >   The buggy address is located 0 bytes to the right of
> >    allocated 8-byte region [ffff00016b629640, ffff00016b629648)
> > 
> >   The buggy address belongs to the physical page:
> >   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eb62
> >   flags: 0x17fffc000000000(node=0|zone=2|lastcpupid=0x1ffff)
> >   page_type: f5(slab)
> >   raw: 017fffc000000000 ffff000080016c00 dead000000000100 dead000000000122
> >   raw: 0000000000000000 0000000808000800 00000000f5000000 0000000000000000
> >   page dumped because: kasan: bad access detected
> > 
> >   Memory state around the buggy address:
> >    ffff00016b629500: fa fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
> >    ffff00016b629580: fa fc fc fc fa fc fc fc fc fc fc fc fa fc fc fc
> >   >ffff00016b629600: fa fc fc fc fa fc fc fc 00 fc fc fc fa fc fc fc
> >                                                 ^
> >    ffff00016b629680: fa fc fc fc fa fc fc fc fc fc fc fc fa fc fc fc
> >    ffff00016b629700: 00 fc fc fc fc fc fc fc fa fc fc fc fc fc fc fc
> >   ==================================================================
> > """
> > 
> > Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
> > Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > Reviewed-by: Koba Ko <kobak@nvidia.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> The oops log can probably be trimmed. And the reproducer isn't necessary in the commit log.
> 
> However, can the reproducer be add to CXL CLI unit test?
>

Hi Dave,

I want to make sure you want it as a in-tree unit test
or you want a follow up ndctl patch which can cooperate with
cxl_test ?

I suppose the latter will fit better ?

Best regards,
Richard Cheng.
 
> 
> > ---
> >  drivers/cxl/core/features.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index 3435db9ea6b1..3f949225da6d 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
> >  	if (!count)
> >  		return ERR_PTR(-EINVAL);
> >  
> > +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
> > +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
> > +		return ERR_PTR(-EINVAL);
> > +
> >  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> >  		kvzalloc(out_size, GFP_KERNEL);
> >  	if (!rpc_out)
> > 
> > base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> 
