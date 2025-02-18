Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C43269804;
	Tue, 18 Feb 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885077; cv=fail; b=oVhUY204UYV+68dFtMtJfpOZhKuQyoOP76zwMj+RZC4ZrXPPWeDHImcWmZmTobFCwjVGIaQ4HXbE69vWo3pZull/hUfO+PtWAYeYm4h6cZlmUsHsSctfQCSq2jZUbfs6zu+YSPa4nnq9UveBSCbaXazMrmwJlM8IdmH86Xdc/Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885077; c=relaxed/simple;
	bh=FTKjq4C0T6fwBWfeifnoQQI6UgFUWgKqS3O+ZHbDF1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aRd13a30ksyV9FI+OexPTuoj/wmCic8t7T5BS4g5X6Et33zfhZIchiyC1DfsuOd2Nm1WsY9yxqqroarsPOaAmwu1ZkYs3XMLewcmbAVptjhWEylcDgpzHRMfDpkud1cZ44l8vJFtjKnkophIAHCx0Ly4VrSH4/LOIiuJU6L/8wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=31UiLWRK; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="31UiLWRK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLrEMsaNyELBK4h1aOSal7U4G7uuhKkqndrKrjMfqXKft3k8eVH9d/jjaOr+6YhEL2zcLA4icxzP4Otj5B0doykhGAr8+2rcegi/gAAzpKmV5K5aCX9cXCjLY1eFBSMjc7Q8yZcwBdJNUkC4i9aXUBcxNfIeKs8JnGhQeP177QFE9lNoZlKcjPfotOfSDB+kTUIHy6o4mzfln3zsjm8SebiRjtfWFaOb5uWxwXi60z/MudChayCXyJSGm9W2zUHBHbCC9egFLdCwxNBCkhcVgczcOAiikjAJ1F6IHjm/xzLqAt9bLMQbVXJCyy0Uts1L8IvF0uCdEDjbd9VA4k1RvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIjohDLJbLCE1V2pbGpBzzDOyClI+oG1mc/qRATYU0Y=;
 b=hI3scKq58pikxekNM0fwkitngPX5uJLCukeP2i1UKKXVW1bf9Ad3JZEnDejIGTlnZ4l6/pFkROI9oi5S5a1AVnWgo6ZE2oSs8XNh93KazkL4GAAO76OV2vuIMMBCglOdKN3NA9qg0NR1tbwljy7BFFA6pqrrN0PljX/icFmJF7F0B5TQZFwIWmPD+klyTWHJdn2wIEV85oSNUulYGb0/FzqSvI10TTJQh7YEG94Ze9iWVfKwimrC94ArJ33hudJvVgil89kENm8djmtgTLuLrIf5haT9UB+iRFJ1FlzQ28iVtmMnVC0wkHx9/FIFF1Tw7/iV8rjG9MnGjhiyZCoACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIjohDLJbLCE1V2pbGpBzzDOyClI+oG1mc/qRATYU0Y=;
 b=31UiLWRKF1ItpFKGdbhFQbmJU3n6WRcg+fbVjZF0advcPnXs7iwWO3unBcAvbQUaNQnVDBd8kBZ5dgZiJWU6raLaea/CLy86V82YkiOZ57LRnYkqcds/Yd6Hr20vh2C6Gfdff54JCBHPD0PyXp4bAz8ZYdLL0HY6iHABjnXVCH8=
Received: from BL0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:91::20)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Tue, 18 Feb
 2025 13:24:31 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::f4) by BL0PR05CA0010.outlook.office365.com
 (2603:10b6:208:91::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 13:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:24:30 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:24:27 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 00/15] cxl: Address translation support, part 2: Generic support and AMD Zen5 platform enablement
Date: Tue, 18 Feb 2025 14:23:41 +0100
Message-ID: <20250218132356.1809075-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f397e47-5ca1-4788-c082-08dd501f93ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0Q4dWcyblJDNG1FOG9NcGRMeHg0emE3cFdjVlphQkxrSXpzRHBscUZCMXFY?=
 =?utf-8?B?d1pMT2RlcXJsYmNIZXRHbkhuTTA2NCtJMk1VS3FuRDZRRWhJQVByVU0wTS9a?=
 =?utf-8?B?cG1mQStOQlBTUXN0dEpDVzJ0N3Vkc3JJUW5HbGNmQjNmVW9lYnRYa0EzVzdh?=
 =?utf-8?B?c24vY1JKVHpkNWRkTGw1YTNyUFgvOEhVRDJ0aE1iZmFhaTlCZmwzUU5KaTdT?=
 =?utf-8?B?NWQ2L0JQcUs5NktabVBDeXZrNk5kMnA4QnZ6TTViQ2U0S3lSZXV3dGR4Zjl3?=
 =?utf-8?B?UEpXemNOLzJnN0JlSVdJd3crNzhtRFVGa0U4SnVkSlByc1orWG5scEdnUlEw?=
 =?utf-8?B?ZCtPMUROeWdrc1RtSFRLWUVnZG5UaVIrZ1NQRkZ6WUtFYWpyelRabUgzK3NT?=
 =?utf-8?B?dnpzZ3BkZU01UTVUUTlXMGJKOXQvRUE4dDJnb3ZsUkM1ejRlYURVb3RUZGh4?=
 =?utf-8?B?MzAwSCswSHJURHJ1R092amE0YTNrZDFzKzg3U250NGIrcW5BRWl2Q3ZXT0FW?=
 =?utf-8?B?RDR5UUE2bnpua3E5TG5RKzlVWEltSDFaMTNDUHo5TkFmNis3SThsWmlGeDRU?=
 =?utf-8?B?YmpFbG5zcnR4Y2RVNzhFTUEwTnI0RTZBTE9YUUZ0akdTZ2NOOHNZR0tqTWNj?=
 =?utf-8?B?NHRsTFRXcmgvMmtWMGoxZkY1aGFxcFV1ai9pbmIzRzdybEl5MGNGOU1MTDlW?=
 =?utf-8?B?VDllTTQxRi9aZFN6VEw4NjhQdFRjaWpiLzJTWWl3Q0Q3cnQyVmJrWndEMU80?=
 =?utf-8?B?NnJPZ01heE13bm1GUE5QMHdlWDBzMnVKL2wrMy8rNzFSTDMzNjNIM1ZxS2tJ?=
 =?utf-8?B?cUs2Q0dKRlJVNU8xMENBQjlLcWREeGtwY3diTXJJWStFZG15aThrN2NsV3Z3?=
 =?utf-8?B?bHBxelpJbEhXV0lRbjdUbjlzeVJ3L2ExeEJZaXBKVTF4b0U0OHh3U25lZjJu?=
 =?utf-8?B?OXMvZ2tQSk9hd0d3VzFhd3J3ZjdaZFM3aXlyb1pPa0o2QUN3S2MzaDJIa0Za?=
 =?utf-8?B?UFRWMUpteDAzWFdSRnVzSGdpTnpmZko2VStCOFFZd2VabU5HQmpVMXNkZWhC?=
 =?utf-8?B?MjVBNndjZ2F2RVZEeUJ5blh6YXMyTWQ5M0JvSTV6ZGxXQ0lYSGJmdnl6UVN6?=
 =?utf-8?B?RTlKS3U0KzdTTDJpT3NWd25BbTRoQngzTEpwN1VjTmV2RGNKbFBIVnF0c2Mr?=
 =?utf-8?B?a1dUcEN4ZDZ0WCtiTEVMWHdhOEtMcmd0YU12alpyMTF6SnJlUG1NUm1MRGJ0?=
 =?utf-8?B?d0pNWmNRTnducDJwd3ljcXNKVm1MdkdGbFg3b2pYc2QybWRBYWRJaHV2cVVG?=
 =?utf-8?B?T3FIVFphV0RmNXdQY3BtOUJoOEtqUXBPdXIxTHZWL214RDNoRGMvbE82NUF4?=
 =?utf-8?B?bTZiZmk1dkRjSHNkd2NFNWpjckIzbXRqVWpGUDh4ZUZad21SUTY2RU9TaTBu?=
 =?utf-8?B?MzRkNm9paFJxZkpuNmN6amVWU2xldFBVYkdZdndBTHlhL3g4dzN5WWZicXVh?=
 =?utf-8?B?dXFlSWQ4ZHFhVE1Tb2prNSsxV2g1L3NXRVM0ekhiWHhodmtURzBZS3RTL3JT?=
 =?utf-8?B?NUxqN0dTRnpwUUJRdEc0Yktud1FqNVpyc3lMbmtjYlB3dHZxUGYzdzJRWDhF?=
 =?utf-8?B?cWlKaXFKNWxwbTkyNEZHREQ2UUhLbEQvNlh2THVsUmpVL05sYTZOL3pXbjF2?=
 =?utf-8?B?QXVDeG1TZ1lYSVZRenlIa1AzTGdTVXdteTd0QjlDU1ZTUmVhQnNQQ09OYVpR?=
 =?utf-8?B?ZGJycU5nTGk3UmN4QkEvdWRUTUlWK1gzOWl5YTIwbHBxbFVmOThZWlRpUGRl?=
 =?utf-8?B?MzdjcmM3Vk5BYjEwZFFkdVhRSkJ5WmoyT1U0aWZiUGZ2T29WVU5zSEhxaWFi?=
 =?utf-8?B?VkhFUFMrZ3BiWGNrcE9FbU1iaFl3VUg0aWFHUktibG5DekNqZGtMZ0JCbW44?=
 =?utf-8?B?MXRXSk1mOFlvdWdiTWtQOHBFQzhCVmR6S2ZMclMzcEZueUl2VXRXZ1NOL1o1?=
 =?utf-8?Q?Vrt9EP0O7B+fCWyOTlAUYQMIGmiS9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:24:30.8863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f397e47-5ca1-4788-c082-08dd501f93ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

This patch set adds support of address translation and enables this
for AMD Zen5 platforms. This is a new appoach in response to an
earlier attempt to implement CXL address translation [1] and the
comments on it, esp. Dan's [2]. Dan suggested to solve this by walking
the port hierarchy from the host port to the host bridge. When
crossing memory domains from one port to the other, HPA translations
are applied using a callback function to handle platform specifics.

The CXL driver currently does not implement address translation which
assumes the host physical addresses (HPA) and system physical
addresses (SPA) are equal.

Systems with different HPA and SPA addresses need address translation.
If this is the case, the hardware addresses esp. used in the HDM
decoder configurations are different to the system's or parent port
address ranges. E.g. AMD Zen5 systems may be configured to use
'Normalized addresses'. Then, CXL endpoints have their own physical
address base which is not the same as the SPA used by the CXL host
bridge. Thus, addresses need to be translated from the endpoint's to
its CXL host bridge's address range.

To enable address translation, the endpoint's HPA range must be
translated to each of the parent port's address ranges up to the root
decoder. This is implemented by traversing the decoder and port
hierarchy from the endpoint up to the root port and applying platform
specific translation functions to determine the next HPA range of the
parent port where needed:

  if (cxl_port->to_hpa)
    hpa = cxl_port->to_hpa(cxl_decoder, hpa)

A callback is introduced to translate an HPA range from a port to its
parent. Not all ports in the hierarchy must implement this function,
e.g. on Zen5 only the first root or switch port that connects the
endpoints require address translation.

The root port's HPA range is equivalent to the system's SPA range and
can then be used to find an endpoint's root port and region.  

Also, translated HPA ranges must be used to calculate the endpoint
position in the region.

Once the region was found, the decoders of all ports between the
endpoint and the root port need to be found based on the translated
HPA. Configuration checks and interleaving setup must be modified as
necessary to support address translation.

Note that only auto-discovery of decoders is supported. Thus, decoders
are locked and cannot be configured manually.

Finally, Zen5 address translation is enabled using ACPI PRMT.

This series bases on:

 [PATCH v3 00/18] cxl: Address translation support, part 1: Cleanups and refactoring

Purpose of patches:
 * Patches #1-#2: Introduction of address translation callback,
 * Patches #3-#12: Functional changes for address
   translation (common code).
 * #13: Architectural platform setup
 * Patch #15, #15: AMD Zen5 address translation.

V2:
 * rebased onto cxl/next,
 * split of v1 in two parts:
   * removed cleanups and updates from this series to post them as a
     separate series (Dave),
   * this part 2 applies on top of part 1, v3,
 * added tags to SOB chain,
 * reworked architecture, vendor and platform setup (Jonathan):
   * added patch "cxl/x86: Prepare for architectural platform setup",
   * added function arch_cxl_port_platform_setup() plus a __weak
     versions for archs other than x86,
   * moved code to core/x86,
 * added comment to cxl_to_hpa_fn (Ben),
 * updated year in copyright statement (Ben),
 * cxl_port_calc_hpa(): Removed HPA check for zero (Jonathan), return
   1 if modified,
 * cxl_port_calc_pos(): Updated description and wording (Ben),
 * added sereral patches around interleaving and SPA calculation in
   cxl_endpoint_decoder_initialize(),
 * reworked iterator in cxl_endpoint_decoder_initialize() (Gregory),
 * fixed region interleaving parameters() (Alison),
 * fixed check in cxl_region_attach() (Alison),
 * Clarified in coverletter that not all ports in a system must
   implement the to_hpa() callback (Terry).

[1] https://lore.kernel.org/linux-cxl/20240701174754.967954-1-rrichter@amd.com/
[2] https://lore.kernel.org/linux-cxl/669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch/

Robert Richter (15):
  cxl: Modify address translation callback for generic use
  cxl: Introduce callback to translate an HPA range from a port to its
    parent
  cxl/region: Factor out code for interleaving calculations
  cxl/region: Calculate endpoint's region position during init
  cxl/region: Calculate and store the SPA range of an endpoint
  cxl/region: Use endpoint's HPA range to find the port's decoder
  cxl/region: Use translated HPA ranges to find the port's decoder
  cxl/region: Use the endpoint's SPA range to find a region
  cxl/region: Use the endpoint's SPA range to create a region
  cxl/region: Use root decoders interleaving parameters to create a
    region
  cxl/region: Use the endpoint's SPA range to check a region
  cxl/region: Lock decoders that need address translation
  cxl/x86: Prepare for architectural platform setup
  cxl/amd: Enable Zen5 address translation using ACPI PRMT
  MAINTAINERS: CXL: Add entry for AMD platform support (CXL_AMD)

 MAINTAINERS                   |   7 +
 drivers/cxl/Kconfig           |   4 +
 drivers/cxl/acpi.c            |   4 +-
 drivers/cxl/core/Makefile     |   3 +
 drivers/cxl/core/core.h       |   4 +
 drivers/cxl/core/port.c       |   4 +
 drivers/cxl/core/region.c     | 323 ++++++++++++++++++++++++++++------
 drivers/cxl/core/x86/amd.c    | 259 +++++++++++++++++++++++++++
 drivers/cxl/core/x86/common.c |  14 ++
 drivers/cxl/cxl.h             |  19 +-
 10 files changed, 583 insertions(+), 58 deletions(-)
 create mode 100644 drivers/cxl/core/x86/amd.c
 create mode 100644 drivers/cxl/core/x86/common.c


base-commit: ed50d9abb9177ba106f47e2c48e1bf1804a6956c
-- 
2.39.5

