Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B418E1F
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802435; cv=fail; b=a5OSdLTn7ZOVPx9MwYJi0VbeJ5TPPTQfOugBc/iPsFSbpxl0xSBH3qh60PZKqiXFIv3hx2AsDAGJbitscvu7JSfO+gWiK9GkJNBqybrwWBm93qMmcVv+k0pJtU8jF6DN68+wGnxCCcp2NPMtfB1yeWuCZDmdQilXZjyIlV8K058=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802435; c=relaxed/simple;
	bh=jrux5WoQ53L0slbzTdkMmUnUCnqBWT4GGzbvX95TLWQ=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=eIpBRT49y6EM+AbAvPOb46Ny5rRZsE+631wRvqtMQrdDLHvhTuiZ/GWcidSSDx7JUk5mYAtI5ZBu88y79VyiqzKAgVoP+75/3fyYRdvOk5YyXe2VtwjnoZC+yKuEyo+QzxIEDTuDkHJR5BTgFFrRYOiPaMchWke3kM5gKY6l4+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bj50eUjP; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bj50eUjP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4Sd4QuKfrEIorx6SoAO/cVU4mEtGHPj+N6Pr+pINf85yydUbdIZwuQWzVeSqPl1DWJs8ZuPxq34PTNJf4WOLHJjUeiDuHQl6vxj32D2g6HPJ0yGTCIvslGRf4Nx5FOIARp06iBXDhEkogH5QFguOpKwGAgqR9ftPAPKDJuammVj9Pcyec/pdesXV9+DyhKHi6poubS87u0t0YcQHhcEMQpOh/LKsJayiY4vtqGFKjbOH3BO08Q3Dw+3zIZnHlSFAtNq2G1gLaV1VjWrH/gSXQoujQJ7uKMEu5Y1E5boo4juLjPkk0WummkeE5VJF2CWIN7gMLD709OfnoJD1IU5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqB9qUaMNkwt5Nw8TDdXwYM1+9uxRU/rtVg/yNlIAxs=;
 b=Y//kYLsKlXidGqFQEVdkMrHWqp9q9aJVj1wssb1YMvmNtGqJpu4G84ObkRx2vNTOnU1MLTgzE6qkihBPxmA8RI3TbYUaDjAB4PDIsUFF82F9Pt475tZ8/wVehxxXStZG3L4bdRPQpWaQyrMgEQgU9N7CpZ4ezXHLkhDWKrMMq2wjs6U9N860m9fYO+NTyTbrJ4v+wwfeSLLxGERdN1USbdI1aSJV1/krkh1A0xEUQLDUHk0+HoPB6rXY0PCL4MOSIsvopm2mS6ezHd6qmfOzAhLksl5Z3+HKHW2WOEPrABpmbaxGYsMUb3XNgdhS42pkjd7SWFvWRfJUU9/qDHSy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqB9qUaMNkwt5Nw8TDdXwYM1+9uxRU/rtVg/yNlIAxs=;
 b=Bj50eUjPdtwVa8sgQRyG4OMZQMmfm4cPpS2ozkCnbJN5VJtqL2owKeAkTG5a6L5j3ewrmMlm9bAYb0Rw6nrvER7Ce6mjNU/WqU16HhEBseqTZm8L7ADkszZ/CWYSqE3NneiEKNOdQ3m9Hhi1Gmz/CccAhhUbfmiDLSOVgi97AN0=
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 30 Jan
 2026 19:47:09 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::5a) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 19:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 19:47:09 +0000
Received: from [10.236.189.18] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 13:47:08 -0600
Message-ID: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
Date: Fri, 30 Jan 2026 13:47:08 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: RFC: CXL Isolation Support
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 73371c15-0989-4aee-85db-08de60385afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmRIdEVqRGhUbVhBbE94SEUraGRIcVNNT3FLN0NZeFNPenV1SGpkL2VJNkZ4?=
 =?utf-8?B?ZWtZRG93S0FzM0JIM2l5U1ZHbkJxYXhSMlFCWE1ZZVVvdXoxUEFYcGJPeHJl?=
 =?utf-8?B?S05sd3VGUWE1RXI5WVpUNGVRODFtNGRxb3VpTldrcllrcHArTkJOazcvcnkv?=
 =?utf-8?B?c1ZydVRNNHZEZGNMNTF0T0JtRWlzVVo0UGc4SHdUMVYwZThiWUNIbzIrbmlv?=
 =?utf-8?B?RnFIQjlUQWRoVUd1UHNhMkhOcDBaSzRhTGEzVlBMZFo0VzJ1Y0FLWnVVNU13?=
 =?utf-8?B?WHYzWGtjMVI1UDNobkhLRFlLQS90bjlkc295eTRrRUwxRmpQZEhQdlNZekFQ?=
 =?utf-8?B?V2ZQVThpU3dLbzd4VTlOZUU2MTFFdGJBMm5vU2swZjUybUVvQVgwM3VmamRx?=
 =?utf-8?B?ZGovM2x3TFQ3OTlPeEUwdFpyVExHSlhqTlN4ZW40eXlQMEFETDRZUys0NVZ0?=
 =?utf-8?B?d1NVTjNrWlgrMXBtNU10YjN2ZEdDSmdybG1vdmZLd2dkMWlrRVBiYlZoSDlW?=
 =?utf-8?B?OVJibVFRaEh5NURZM3pXcWNpSm5FQk5QQnhvUm55dUZ5MmNPWkVrZXNvcmhp?=
 =?utf-8?B?eXBWSzJMdHlNRzUzRk80V1l1aWEreGlHVk1ITklvelUzdkZXMFJIVEVRUy9r?=
 =?utf-8?B?aUczYVFFbHZuNXNXbHJOTkJWd2lUMStFemJ1eWtaUGNITXhUV0ZlNksvUVoz?=
 =?utf-8?B?TS8zbjhxcWExanllUkxlWVpuVjI4a1h3N0NtSFUzZlpkQWFNNVRoa2NtK3RK?=
 =?utf-8?B?S2JPRXhDeUZabzFhNHVrSVRGUnRTNEYxYm9VL1oxSUFpTGZKbGs0d21EQzZ1?=
 =?utf-8?B?S20vcXVQMVpDNE1YbGJraEE0ZlFmVTdvNTJrZjgvYXNkZTJVR1BWcEZJVHl1?=
 =?utf-8?B?V2ZwNzdnbVppUUJHc2w2dkVaYW9TaTRPbExSTUZnUE9HQ3o4cWVCMDJsSDVY?=
 =?utf-8?B?V24vOVh0OGsyb29maGRjM1JvMEx6ZHBlSHV1UE83L01YcFRpeXlqSDNHbmVM?=
 =?utf-8?B?djcxWlVqTkJDbE1JdWN4K3o2UmFQQ05lekhrd3lXaG5tblVoMExUN3pwS09u?=
 =?utf-8?B?dG1Qd2d0eUhtUGNReVFPbGlJNnh0aEhIRDAxSmVvbUE0LzczOXp2YUhWeHV2?=
 =?utf-8?B?dEJUbWNGc1dZYklscHU0VnNGR2pFK2R5R0U5cmg5L0t6ZS9BRGlKZWl3Skpt?=
 =?utf-8?B?RzhIMmdZMWk0TjZiWUJTZjBXVkxmSGtOZEFERXYwQ1FxVXQ0Z0MybUFlSnBI?=
 =?utf-8?B?OVRSdlhZSGJnR2QrOENwQjNsd3RhZzZ3UVJjKzFoc01iTmVFMTQyQTBNMWl5?=
 =?utf-8?B?bGlKN2NZbDByaGVuZDJFMVc2QnQvczJjVm9iS3hocGh1SUFLZlpWTjZkN3BV?=
 =?utf-8?B?UGdrbU50YTlBTkpCK09ZTHZQZVFKSWwyN2laYVJvRzc4bnVQc3U4RlBqZnd2?=
 =?utf-8?B?MWRaOGxieWxWY2JUSGZYM1FtYm1CaFdJQ1VtRVM1MDBiaXg1NnE4eSs3aEZq?=
 =?utf-8?B?cXgxUnNXa3BKbUNxWTRmZG5aM0l1MVJqSVFiSXNDNDUrajVQbmdKWGlQNTRq?=
 =?utf-8?B?ODJTWURpRkJaeTZrUUpnQzZadUpOSzJuTHR1SytabFBZTkpXRjFmdTd1eEtl?=
 =?utf-8?B?MVY5UEhWeW83aUhPY2g5cW56bmcyOWgzNU8rOFhSd2xFdTFiZ0JqZldLMFFS?=
 =?utf-8?B?NU5oZXY0S3lTdDJnMjNybU9xSFZHbGJxYXM2V2VNT0ovYS9sWlBoQTFNS3Jj?=
 =?utf-8?B?STNlRm5GVnFic0ZWSEtEWWdEdUZpckdIY0orMGJOajlJSVFKRTdjS3lidUkv?=
 =?utf-8?B?Q3dpZTBWQWdpTmlVQ0F3Q1NEbWtkekNtZnhMSDFJOUR0NXVqUncxY3dmdUoz?=
 =?utf-8?B?V2VXVFJVTjhBVlAzZkR5dlZ2RkFzWmJhSzczNFZkTHhMdGtDVGRQOHYyeUV5?=
 =?utf-8?B?clpMNUt2OCs1WUQ5RHY5aHpyVHFFUVNXZnB2ZmE0bi9FMEk1LzVCUlNuR2wz?=
 =?utf-8?B?ajQvRDVIU0s5d1p5ZHUvQURrYlRURGhuLy92K01QekR4WnJkOUtMQk1ZVW9a?=
 =?utf-8?B?dVd0ZHEwb1MxNjBFQ0IwY0tSbG50Y0NaS01zYXZ3cW1KakRCeFhQZmppclJX?=
 =?utf-8?B?dEVTUVEyNUJSdERsbUkrenJFSDQyaFgxUnluRFozUm4xSWl6MjJrQTJ2NlJm?=
 =?utf-8?B?UlVocXhpcmVLaWp1OEg3ZEJDaEdKYUFBdkwvVlV5dC9QZ01CZ28zY0ViaC9H?=
 =?utf-8?Q?P+G5EdWDmU5OyrpgspJpaUzEvoaiM5l0A4A3eUaFvM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RdxNfAfpSnRhm2sNMZebvTp4IPzaUxA5GwBcKlXjAtciuZOO4aVaubbPAa0a2NSMuF3HIQOJfxxurB1ttPJJvBdZNudi5RqSPO9LOivyrYyTTIolmcIZ3zagdoZQRkCZLoHM6+g4EloWYu5oquQnC5dXgE0DsTls0gESoNTmyfxTc8kXeQAFE8zAp/VMd151I2wPse2/fKxQUhHArmD/8EEt2Q4fzuY9YvQwZpvA81r5fGWZriTYezpbFHPPxLyuu5+ewDv6x5I+CHrr2RTPce8eBRMRxnWqNauBs+4sw/mfAjw6lP8tFi9M3kG7YsNeaIvsS2KLsQFLr86w1iIDseOTBD+E1ONKYVd7iqr0t+DBkpXa80Fi9PwT4UfP9bw+kxLIJKf5L2JVWq6xo0L0mpX7c04YH+961TmhXXmkDAgGgIg3x4+kc1oc56NlWDj3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 19:47:09.3389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73371c15-0989-4aee-85db-08de60385afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163

Quick Background:
CXL.mem isolation and timeout is a mechanism that allows the host to
continue operation in the event a CXL.mem link goes down or a CXL.mem
transaction times out (semi-analogous to PCIe DPC for CXL)[1]. After CXL.mem
isolation is triggered all CXL memory below the root port is inaccessible.
At this point writes to the memory are dropped and reads return synchronous
exceptions (platform specific, but probably poisoned data). The alternative
to this support (which is the case now) is the host system resets when a
CXL.mem link goes down or a CXL.mem transaction timeouts out.

Why I'm Sending This:
I sent out a patch series a few months back that implemented CXL.mem
error isolation to this list [2]. It didn't really gain traction due
to not having a customer requesting it. We (AMD) have heard from some
customers that they are interested in this support, but aren't willing to
help out upstream. The main motivation behind using isolation we've heard
is that customers would like to use CXL but are worried about system
reliability since it's still a new technology.

My main goal here is to gauge whether we're wasting our time here on trying
to push this upstream. With that being said, here's some info on the technical
hurdles with implementing this feature:

Technical Details
=================

1. CXL memory may be used for kernel allocations

Kernel allocations in CXL aren't a problem at the moment because if the CXL.mem
link goes down the hardware resets. When isolation is enabled, this isn't the case.
The kernel can keep chugging along until it eventually errors out trying to access
the now inaccessible memory (possibly causing data corruption until then).

In my v1 submission, I opted to just panic the system when isolation occurs when
any CXL driver couldn't handle the event. The handler for type 3 devices
(cxl_pci driver) did some RAS stuff and then panic'ed the system. I think an isolation
handler for CXL device drivers will probably be part of a final solution, but the
handler in that series was hamstrung by allowing CXL memory into the system ram pool.

Possible Solutions
------------------
Keeping CXL memory out of sysram is doable today; it just requires a combination
of udev rules, tooling, and kernel configuration options. The flow (afaik) is to:
	1) Configure the kernel to not automatically online hotplugged memory
	2) Add a udev rule to remap CXL-backed DAX devices from sysram mode to devdax mode
	when added to the system

Gregory Price has submitted a set that changes the second part of this flow to instead
use sysfs [3]. With that, the need for udev rules is removed and users (or their tooling)
can set their CXL memory to devdax mode before it's added to the system. At that point,
all that needs to be done is restrict enabling isolation to CXL devices in devdax-mapped
regions and make sure the memory mode doesn't change (i.e. devdax -> sysram).

2.PCIe Portdrv Dependency

CXL isolation interrupts are delivered using an MSI/-X interrupt, with the specific
vector being in the MMIO-space isolation capability register (CXL 3.2 8.2.4.24.1). This is
a problem because the PCIe portdrv is in charge of setting up MSI/-X interrupts,
but to map the isolation vector it needs the CXL register mapping code. Since
the portdrv is only available as built-in to the kernel, using isolation would require
restricting at least the cxl_core module to built-in.

Possible Solutions
------------------
There's a couple of things we could do here. First is to restrict isolation to when
the CXL core is built-in (CXL_BUS=y && depends on PCIEPORTBUS). I'm not particularly
happy about this approach since it removes the modularity of the CXL driver(s), but I
won't gripe if that's what's settled on.

Another approach would be to move the CXL register mapping code in cxl/core/regs.c to a
library, or always make the file built-in when CXL_BUS is selected. This is more palatable
(imo) but splits the CXL code up in a potentially weird way.

Last one is to rework the PCIe port bus driver to allow for re-allocating MSI/-X interrupts.
Jonathan Cameron sent out a series where there was some discussion on this. This support
would be limited to MSI-X interrupts only due to the PCI maintainers not wanting to add
more support for MSI [4]. This wouldn't work for AMD platforms because we use MSI interrupts
for this support. There is still a way to make this work, however. AMD server platforms
use the same MSI vector for all PCIe interrupts, so we could introduce a quirk to use that
same vector as another PCIe interrupt for CXL isolation. That would require no register mapping
code in the PCIe portdrv code but would introduce a platform quirk instead. I doubt anyone would
be happy about introducing a quirk but I thought I'd throw it out as an option.

Thanks for reading,
Ben

Footnotes
=========
[1]: CXL 3.2 spec, section 12.3 "Isolation on CXL.cache and CXL.mem"
[2]: https://lore.kernel.org/linux-cxl/20250730214718.10679-1-Benjamin.Cheatham@amd.com/
[3]: https://lore.kernel.org/linux-cxl/20260129210442.3951412-1-gourry@gourry.net/
[4]: https://lore.kernel.org/linux-pci/87plpsbbe5.ffs@tglx/
