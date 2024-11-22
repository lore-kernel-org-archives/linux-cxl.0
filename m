Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2072.outbound.protection.outlook.com [40.92.48.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDEE16BE0D
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260031; cv=fail; b=B9mAiO6wzZJukt3/jnSb2A99kJD64viCEUchjYkflDHjcFrlQ+giOOZN+AEYqQFzRBmDUhoGUjh+yC0oVIkw9hOAbcnVcE5bOmsNbi+J92FcygtQVdei7aqaH0Gl0twlhS7EvNWTKiEr1fNSy491lcq2ajrC3GgvoSFRjm16iKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260031; c=relaxed/simple;
	bh=rf6P8ltLB+tF/nDxvaYkna0Kx/vzRHHJlFFnKKmOnWM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f1/Cc9Dg3eJMxGu2/KaIgd4pAiSFlghLedRLw3EeKetNCpEMk+RCfM2k9hRzbA5JtXyZyDTxgB4abX+zHr84E2qyThnJNYyTlpdPHT1/2xkfe/kd04bLCyvZEOqlr3Qm/aRx0rv1vTF2jjTC5SueBRJ0I0XJ+wm08hyw+aDiwEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SK7xWosQ; arc=fail smtp.client-ip=40.92.48.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SK7xWosQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOiVDs5gqtbpOBd0nlo7bCcWE9oVYTFOpFkkCJ3IrngEveUP9L5qAZDsMOfJG4uNx8TrGy/Q8NHa1xoHxPXcwxXNGKKgMYq94QvQAGb8XAM3f72LqDL+qiyJGIVNGMJF2sNSC8FXUa7woccQWpw0/Fvzbgxzalbl6xNDgBeDnmKBGlJrG+qd0num0Oc1V19QUiZznf7JCUzQTjCyQrwMAT0T9Qrpzd52XvZ6uL+WhKbOA/hJEZZTbxCSmurKnhMl6/+J63ZgAD9ehMBK4jEQ5EPav5jhKp5IycIdhcJL5JBUn3jK98uQ6PRWYKmsTs9GctzYSzSz51q/VTMc7eu/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edtMVvPtKVbf/DxkD1rdo03L42Mam0Vnsc7Bdv2cQCs=;
 b=y2CqVr397ElemW/tpmFkfOMCckMLmIEPdOpEaluA0DeaoJLrA8ERJHuCNPLBvefIduHIj8BUefdKwtZWHDUraicUJf5EJKpPhW4Vht9+v8tCF0BZelnkcUrOLaTOYc7LGPsLh5/PmzmnW83HCggBIzrs28AXA+IE4LGQI3r8niBraZPyNI3ftMNFwS4n79avFby+pckl1aSFk3POyGi6zLgmhOpshvsygFKeLZILE55n708RCN0jvLI8hC0j9uyE8C/zjFK7ulhiDJ0+gWULKRvupyTd+avnRkNHxKnQdJBH1uZCofVmz+wB7Qok9dyD6erWuHAmHyuWZ66yBWcI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edtMVvPtKVbf/DxkD1rdo03L42Mam0Vnsc7Bdv2cQCs=;
 b=SK7xWosQA2F3QOvjtGA/cF61yYcSV7EuGE0mMR1gd4nucvW78KL+hKRE7kVCOQd2iWgBALhIME8Oca0NYkefuoIb4O1Zw+yu0+PhA8N1GoByHAeKSepa9kFXJn6nDDz9N2ihQXMst5hs8YVLQ2BuEtrrqbZYBCYAhd2BMBVuDJDBpw8gdFPk/hGJWfN2H7kTXqROaXHHPyvJAmFdoBCUY4rxpvf3MJWNt+oW6WipQF93gPdHD7cCJSbVFKJY3nrph8pao0dLPyeRtAWTzLIk9T1rXDTNn02DAygsWevjzawUMWJnZFlZiAEM19nLz6w2VOOR6gNbNyWmNdtYIUdULQ==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by PAWPR10MB8043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:384::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Fri, 22 Nov
 2024 07:20:27 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8182.013; Fri, 22 Nov 2024
 07:20:27 +0000
From: Li Ming <ming4.li@outlook.com>
To: linux-cxl@vger.kernel.org,
	dave.jiang@intel.com
Cc: Li Ming <ming4.li@outlook.com>
Subject: [RFC PATCH 0/1] A regression in cxl_endpoint_gather_bandwidth()
Date: Fri, 22 Nov 2024 15:20:00 +0800
Message-ID:
 <VI1PR10MB2016FF2DAF7BFB4E5907F419CE232@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID: <20241122072001.94758-1-ming4.li@outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|PAWPR10MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcae56e-1722-447f-05d6-08dd0ac62334
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|36102599003|5072599009|19110799003|15080799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7lqwqokE65bOANMg2/8qhcoiC83mxH4gZT08IrvAMTR+/FjyvOFPJhuP6qQN?=
 =?us-ascii?Q?zfb8NH8Cy2oYp5RgI0Q+Pyy4CtH9PJsG/wMCfdkBQGYJXVSkFu34Gi2EA3YO?=
 =?us-ascii?Q?2GdcbgleqYA1wZyNsC/pjoo4LEhiqtRC/6Q+nQwuK1yye6mZk5jKYSP9Su2m?=
 =?us-ascii?Q?KOJTrRCFKPI0TPD2hLhZdtT6g4E5+lKRG4yq1LJiQlL+i49nE4lvUM3NfB5l?=
 =?us-ascii?Q?Tgr6x3c05Miw1Kpgo8fkvCi66m7kxAqzESFi9rqulER1YrgdgImiU17fsxWg?=
 =?us-ascii?Q?3lIAljv4QRgGoh1ji4wkm/mvIRLLaNL2jsvBy4lAfj48s3DosbC4uzdGFFJt?=
 =?us-ascii?Q?WVcBp+32aegiWjnKV+ivjvcDK3PYygtuFLCOhny5hWqNt9sXpzxRdrkuCB7L?=
 =?us-ascii?Q?gPL8n858993sV2kk4OMXGbji1YfKjA6FpucKKQrofNZ3jXxlm0NoROCrTE8+?=
 =?us-ascii?Q?JG1zP00HJcEWJBOYUByhTz+yPl2Swr9UTnN9dgSDFGr9rGCjc9d/a1tRZeE2?=
 =?us-ascii?Q?RihE8oQFH2NQf/BAiUd5D9y+043qMVxWIs6Nbb1JhmIyeSg53hMcCNGpJKum?=
 =?us-ascii?Q?1xNFsKZefZxfK3UKvIZAI2AGAF3j9CWBX5FBkf8dgGoGltwRfwAopmKvxKnD?=
 =?us-ascii?Q?F8S98mjYuAfPAbbAea51xIN1Q5joA5Lc/S3EYmZeeDsUF3TrHNzrj8GWsmJr?=
 =?us-ascii?Q?Lg/Y9Sh4O54YlmuK6tuAcEhnfQp8McFVMOe9IR3BIfWWsj7mH7UPMqup6j02?=
 =?us-ascii?Q?6TucmfMKlwBKakg8MCGLy//KivZkXnhOyBGsIAXMWWOrDCQCMh99RiSd0wm2?=
 =?us-ascii?Q?uilIbHkvep7u+2moRSPZxbPEZG1b+k9YrnkgLmIoi6dRHQVZ5CH3sfbYODxR?=
 =?us-ascii?Q?35ZP04hJZFB5HTv53hvX9hfEvIOQlAWhD8G2uc9FmuxIUAc3zFX1QiKhBXcx?=
 =?us-ascii?Q?CWKCjcsp7eD8RLaVDBAr3u8Xjp57mfWD5lzWFNnDh9/TPvzTHneA3Efh7/II?=
 =?us-ascii?Q?3k7k6BKDRGVH9ucGnpadlHOlrbt1WRO1JIqJYNu2VPFNbBcpNROLQEh1N+Pf?=
 =?us-ascii?Q?yRtiLP3Z?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+pfMOWB0j087mJv/eM+/0nMetQz7mEh23WdzYpTuw5H4afCQzuK2KBF3Xtkn?=
 =?us-ascii?Q?ou6NiWFmxMzwz6nsKUdhrMnfRC4locjY1+HY3DU/Aavh32d0JUTtH5TTJ0fm?=
 =?us-ascii?Q?stOJhhH29q5DhcTl7/zdQc3tpU3tUPr4GjxmYYsJCkuBzjX5mxGE7LUWEOGP?=
 =?us-ascii?Q?brg1251X0AacwSEWy0/qT5UloZ1BTowCwFApKhytLNZM0RPv/BTwrXLaxJ4w?=
 =?us-ascii?Q?GXTK/NsaXAKa79mdjwAB3iKq4NxGAj1aL8bDH3Mqgh6K3nmyOIq97M6IS0Ac?=
 =?us-ascii?Q?fXpbmSNSZZOUSVG9E9Y0qNH+YQ3vSGiY+YL7mDXSyUl0cjLfmbWPm/Teu4mt?=
 =?us-ascii?Q?cjB7Zet5m6xNfPTtq0RVI5535pSSNvM3lgzyWlFE4aR7Qlzg/ESE45mADT3d?=
 =?us-ascii?Q?7V2F2AG7hmtMFZz/FjMiKGslxErVG52om01p9xuVJ9RB4cJWZh/tsIdktrNi?=
 =?us-ascii?Q?K8OyXkKraFjOusRu04+eSw8jF04CFWuqTbcuF9pQymLrMsCu5tkoADn9oleT?=
 =?us-ascii?Q?n2pCgyl888hqjHcJSOQIczU5GFXDo2xqmgEIkajLDZpir2oNwECHcmqLp5lN?=
 =?us-ascii?Q?JBfDnRaorXHg3YxLjd9AeMVlXMb7M4hjwwk2bRvMt9uDSOHdRv6vwLRlFILs?=
 =?us-ascii?Q?FmsIYDUaSaoB6Pje7eyL7PiRuP/S9stqatX+WoKG0MZUSe9kIMfqF9P+IvWG?=
 =?us-ascii?Q?wM15O/L5ucVuRrKaOfJzBrg0Oc24qI6GcB0NJPhTmuxoibfWqHScqsSIt1R8?=
 =?us-ascii?Q?0Rl+olxqxrSyCInMQryyYtGegg3HNEHCMy1DzqSJyI8++7j7Ao96eEmJZg3u?=
 =?us-ascii?Q?ATkeLYEs3HOKgX2+eBFIjOttAqb4wpXzdDXsvIU6fu4YR6ydpTThJnqY79DI?=
 =?us-ascii?Q?FdfAi9wIL31iz30nggvejh/RGcY3qbKw0fjfTwu6c7MJVQwWnjaWCXrfA2Ug?=
 =?us-ascii?Q?2Bz6VN3yz+GyTbFcjcbKXp3ySrLfF53SOrNA1JSPbIer561OmSUyqUsJnmik?=
 =?us-ascii?Q?O++K6PMjdpHYY9lx4biHpAU9d3umPwT5lOTxrgLGzz4woqOe8VekqJc6W9rK?=
 =?us-ascii?Q?gc45nEO9F1SPJom5hXE7Z340+EnNPbUurVPfrTxKe6gGu1iv8oPCoaFHEEaL?=
 =?us-ascii?Q?sgqKxDmVRQTZiPD9y/RJuzdCEmPjc1vbNTUDpCQ8+upn33m8jRy7ijxsaReC?=
 =?us-ascii?Q?SMkQFOPX6/mlxMVYkMJFgx+2u3/FajPSab2N2Ae0jE96EUS3QHYDSjgRIMY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcae56e-1722-447f-05d6-08dd0ac62334
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 07:20:26.8864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8043

My cxl-test environment always hits a BUG when I tried to run cxl
test based on the top of tag cxl-for-6.13.
base-commit: a83383e2ae7c499ff7b318945d9b2fe4e3006c2c 

The calltrace is
 BUG: KASAN: slab-out-of-bounds in pcie_capability_read_word+0x1df/0x220

 Call Trace:
  <TASK>
  dump_stack_lvl+0x82/0xd0
  print_report+0xcb/0x5d0
  kasan_report+0xbd/0xf0
  pcie_capability_read_word+0x1df/0x220
  pcie_link_speed_mbps+0x6a/0x130
  cxl_pci_get_bandwidth+0x68/0x1c0 [cxl_core]
  cxl_endpoint_gather_bandwidth.constprop.0+0x352/0x780 [cxl_core]
  cxl_region_shared_upstream_bandwidth_update+0x257/0x1640 [cxl_core]
  cxl_region_attach+0x1025/0x1e80 [cxl_core]
  cxl_add_to_region+0x121/0x14c0 [cxl_core]
  discover_region+0xa5/0x150 [cxl_port]

The root cause is that cxl_endpoint_gather_bandwidth() assumes all devices
are PCI devices, but mock devices are created by cxl-test with platform
devices.

At the beginning, I tried to implement a __wrap_cxl_pci_get_bandwidth()
function on cxl_mock side so that the function can fake a bandwidth for
platform devices. But I met below error during compiling.

depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
depmod: ERROR: Found 2 modules in dependency cycles!

My understanding is that the error happened because
cxl_pci_get_bandwidth() is implemented in cxl_core module and it is
invoked inside cxl_core module, so that I cannot implement a wrap
function for that in cxl_mock module.

So current fixup is using dev_is_platform() to check if the device is a
platform device inside cxl_pci_get_bandwidth(), if yes, faking a maximum
bandwidth for the platform device.
Another option is that cxl_endpoint_gather_bandwidth() only works for
PCI devices, adding a dev_is_pci() to check the device type inside
cxl_endpoint_gather_bandwidth().

Li Ming (1):
  cxl/pci: Fake bandwidth for platform devices

 drivers/cxl/core/cdat.c |  5 ++---
 drivers/cxl/core/core.h |  2 +-
 drivers/cxl/core/pci.c  | 24 +++++++++++++++++-------
 3 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.34.1

