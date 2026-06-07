Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE58F28371;
	Sun,  7 Jun 2026 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780815775; cv=fail; b=qH5+TAfRJbkiGSfWHJKsNta+tMyE54Ux2J1O3QDxLiLIhuba5lFD0BM45ZjqQDeMprDyq2/9D128uCYPi4xCmMmPdtk9RQs0xloNrrkm9UHWGFM9nxUqR4k8/iiCIQwYxp5Khb9yckMvfGCnD2ceGYIhFEqTOHTLPHFmwvadshU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780815775; c=relaxed/simple;
	bh=8+d9jMHq32BFzJkPVHmsMlnt5FEKJLimkzrWvbIvP2c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tduCCbELW3I2ZGjYnmPvn/H1vwmAR8/kGFV9W/RGBInU/FFPQpPQQ+9xpRRDpIXWpU2ugzNs0jK19jDCznU4ecGmvpdaU+WOgtcd6eC6ICbw/BcZQs6+BixnR3PZF7lEOfRnEIOLzruZaZ6FRo0ez2SkJYfxyrsowIarJsw1L+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hZg2KLWd; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hZg2KLWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jqm8elwdo8trzhXOHwGGhMJrBQAjCN8dh8zL0E7Q203sHhw6l8mOWDiEeyIy5yR7GxMLpw7DwKNmjMZLgxpiIjsdOoERWwzYqBR01fHLxTd+Ajkw5x0VPdz9tEKkURedl54qxvFIC6R18VKwzTLqqXTmI3mRjFfWTeSFpGNhkgZlCetZDsbqVbLc04ZvZiT+7R+AIBNyjoV3LWhaA6TLimZwsCqZIWniOjEcfTzl+CBg2WLLsVk3iHQ4szJnp/r1ImysImUWR9ff1zoh98XG5ZgIbdoZR3A3RGYzlruDyaOE29kRhZvALn6YzwQ+jAHXmA1xprEcTyiE95YDrv4iZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKNayYgpdn7Dt3rSdywi6LXThIVxOUBIRjOsJ4C3MB0=;
 b=NPqGzjlszzze/tJxyrpkp7kAugTITQdL2dZOjZgVdyz1Q3Kcnlvx0RVoXi0HDO+jpCA66JHA82bJOpIlwFOG3wQ13q8Jvh+0XH5P56YVkow3p8TwDxb2GXZnBnuf7YguXg+8quBscZv19lvaS17Y3Ph77aK1bCL8OXNdNfhlGIBuuhnA7SAG33VTou6VAHFmyP/XHC3GVk3gC2RoaIW2Oe2dcoNH1S6fqHEENSt67CFUmCP2CEdNRPOrhosygw7OdARnqspGSEwuqxh0l58BAyDI0f+i8Iw6u0oRg0wuNzjnQ0foHw2ZAmyVayM/a71ZoXI7wYCv/T/dzEtc7WyegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKNayYgpdn7Dt3rSdywi6LXThIVxOUBIRjOsJ4C3MB0=;
 b=hZg2KLWdfV0tXYHKXdM0YfkglY33pf3yk8Qx4vrE96vBhPkYmT3Fr7ZrBsbdhB3iwtJ4Axrt/R+/ejaY4wwEiWH7cDt9+xDPhUfBrJ5iassv5tdZsQcC0V4u7pJL9pQeVMMSuAl8Ay6tGnJTifyoL47BQD6z9tkV+zABFqj3f1GiL9GquMBdHKuQutHq+Jwm5mjlT9Ylbk2BWdcyl3/CkoWMWM3EmFhrviBrA5b9OeB4HGHBtmJVGKrGlK4Ei01YI/G2eSOTfVFnx5aMWQc853fgnZFgMjIRLB94KsG1Pn33CCf2/+MSGFLLujgnhcH/Cttjdt9zfuaaaPR+xSfgIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 07:02:49 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 07:02:49 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: terry.bowman@amd.com,
	gourry@gourry.net,
	ming.li@zohomail.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 0/2] cxl: Convert remaining PCIBIOS errors to errno
Date: Sun,  7 Jun 2026 15:02:39 +0800
Message-ID: <20260607070241.48978-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b86be7-4796-431f-818a-08dec462c899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	U0/Pv8FPevlFCymNDS7KVUox6qOB06/Vea58qbqcPBl0vrJ+6UyNimtrFsbqhoOFxEligNCb6WcA1ZsF1dwBSaZzn/WiZy+inZWQK/kbfyMvT3uoEziYIYye1CfvyiNuoo8uBbkAa44zP8tRYOfmI7U8QeDDEndgx5waat6Y0m85X47G68DlNe99EZh6B2ppU0ngEfUuDU0GlCeViTlICe+Vgk9YgGWgYKzjDsJ+2EKxc3HazUejDC5LqcLZjidfc4kkko1st+JLR8iHElwSqSXHKVMwTyYKNcXHTZ5KdOtHs9w5ooOTICZTQVNaSr4sG1RboAFB1zLBQwp+4q8Xvu3T35U8cTSOwXK/b0kq0Ni+sIC4eYbkMlcmwBALJHGDkmh89cfFO6r+sDN3c9KekQuf0UIFhK0n7tpL7Pt48XK4EdSIsd9wgDbLcDQpiG1AWs3eOYlEME/0LMTL0OgMZj9N4ch5IvyzheJoLppaxOadWMSI8ocgHkSU5ndTqfUV6suDW4ZJsQIDUy93ACyoSMpdoAsU9Bkj+bIsZJdsxA/5/PX25hbc8e+92z8PbGg2XvwdGhL3GagbBFn7vd7fLxqjd7ivEM4xtaO5FkNVld/7DlPIsZM1AprZnRP6llcV1HZG4C2ZKSG0GfTDH2LFtG+3Pvijtd51vncWp7D2Es4czy0MiyEo41/q89jDmjsA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8MaKiEQpNPloQIUaBzM0rcQSRHAp7RaiFg54pXTi267+x7tyL1QvunnW8ye?=
 =?us-ascii?Q?TDjEmpTjUKXXVVeVhOVLfukep5VK+7papqnSTE/rvlaj7BNvoNehXqWe1Puq?=
 =?us-ascii?Q?xAPRRv7pQNDo5zi7DLam5ET9GCIfuPhbWQdpkMOdWTg4P3jTE6RNI6I3hiHT?=
 =?us-ascii?Q?cFZ26/+WRRKs7mvOpEU3SEh0t8aC01pW2+gVMIbPoerAsrZZvKLv70Z9s2ak?=
 =?us-ascii?Q?3n2y3InJ8DqEHkM1EgrUoGboxXGFtzENpDCTZD3EIRVDUv6FhbHBG1x9T73L?=
 =?us-ascii?Q?JfPedbB2JXyHqyaZtGsn/9NvxtKUbXcTfVTR0UTgMwK2Pa9JuWV+CpJKxLIo?=
 =?us-ascii?Q?LBICm4wO7v7Oucjv6CscU1JcWp9ABO02HfSnJBx8jiSf30V9psM0NIi82kYu?=
 =?us-ascii?Q?xIUqXOdWRLqU4xp7F/mEo7pnmLFPueVxLpwtA8HIqGALXVIc64KuUj1HxRFy?=
 =?us-ascii?Q?uzOWbPdiVz0m33JJUcYfC3fdhrOYANxAJnecuqTuB5zJfdZvYSa7rM6scxm+?=
 =?us-ascii?Q?0JPBTSFxtE1cqjGZxd2YdAzq9Uf8nxGogZT4YEq0yK1hGOYapilBdRW4O18r?=
 =?us-ascii?Q?jQfKjRhLwPTDi5uCepmZ0UUa+7MwiAWSvodCT1XkL3IYikuKry+R2sjgDunM?=
 =?us-ascii?Q?habQ7gFzn6vukY1o5QBIxcTBHnYo/7hyroHsJ+4atjL2Gp3CZh99J+5OTWDg?=
 =?us-ascii?Q?Hc8DoA9CN4wsBtPi0TFk9W2GErsa5UxdD4JfPySdb5OS3AuzWYxFLO0fTemN?=
 =?us-ascii?Q?2gReLbhHG+xx9AWh+RdsOeaZkt9Jo9ziIyC7YaSl3PdKJITlBilSQLn3ae1v?=
 =?us-ascii?Q?DTN72y6vLWzTQ8Q0fOQ6BtpUDf+9wUuWBCrmuhnf97fF/AqfoQO8qrr7WfuQ?=
 =?us-ascii?Q?uXc0QsT4LsbcUPQ1I5isYgBkdIJXtxVU7BaFuBGFooVi0mu0L6pGSPtJdPcx?=
 =?us-ascii?Q?+wB8lWLSMkuhqr4hHOJzNkKlpM/WpYwACmEGweyIL/VOdBCgVqt3Xu+tbJ1B?=
 =?us-ascii?Q?RvrfOTqINeyFxU29LKlh3zYSQpIrSfXTaSqEwU1DQzNxq7GrK9KOdeNRM2Iq?=
 =?us-ascii?Q?yK2BZ4/XeY+sEyM36p08uK/fVl8U2CSDQyeycARJPqCHs5LvFMe6F+zqaplD?=
 =?us-ascii?Q?y2Udf71tvsuBxjjI+nxZGsfn03K8Tmt9mu2gr8qSGylbeH6qjBPBRnboBSHR?=
 =?us-ascii?Q?9tHt+FAJBSF7Nb150nUNH3fAfzOWKWNYJkdoBM4zQPAA8sWA3npV43ANx91a?=
 =?us-ascii?Q?gEkpciPS++dR9AW/eahArVb72avsjYmP8a+BdwarhT0/lPHeUtYRYlXepGEk?=
 =?us-ascii?Q?4LMFmLCswHlU8h231RglTm0sUpD0sK1MpnFGQIh5wMNg3n41d51hWWsHvDnS?=
 =?us-ascii?Q?t1yueP5yatC1RCHpRKnbRJQ6ylcgJi5eBEevC1mfah16YOgrijJ4i71ebIQI?=
 =?us-ascii?Q?B2gIB7PuK+6H2XzwtLy+N7UKoad1h9IG82V90cs/XFL/gG45J9AkOcfSLXa0?=
 =?us-ascii?Q?ZlVdFR1sa8+RD4hU6g0wDIMAg67W/mVQyRSl6cE1agadE7WF1gKDsL2YjdIx?=
 =?us-ascii?Q?PXDYH/rXEceD2aBv7OPicCFwhIPjnGa66L3ezM0Hiwm80QVau+fUs/y1Y9AF?=
 =?us-ascii?Q?c6T7bachQvBOuplc8jmubbCqh4yIhxl08Hd13wQTNNbSWYaC1CWOhAnIPtgb?=
 =?us-ascii?Q?tnLi0aJRLvhRORZkGdZSpijB56ABhH2QOQK8w1cFNxU7kf7+x1BhzeYgLyLe?=
 =?us-ascii?Q?cBn4X7l+1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b86be7-4796-431f-818a-08dec462c899
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 07:02:49.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFil6icLSfPOGdkC1tC9dtrRdq5RSf72ExzG6WOhw4XgWGUhVyY1moOloWUb1HzxyT3y3uYnu6H5FthVAFqH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

This is a follow-up to "cxl/pci: Convert PCIBIOS errors to errno on
DVSEC config accesses". After that series landed by Dave Jiang, I
continued auditing the CXL code for PCI config accessors that propagate
positive PCIBIOS_* status codes where callers expect negative errnos,
and found a few more spots.

Patch 1 converts the remaining DVSEC and PCIe capability accesses in
update_gpf_port_dvsec() and the dport setup path that returned the raw
PCIBIOS status to callers testing for failure.

Patch 2 fixes __cxl_find_regblock_instance(), which ignored the
pci_read_config_dword() return value entirely. On a failed config read
the raw accessor leaves PCI_ERROR_RESPONSE (~0) in the destination, so
the code computed a bogus regblock count and decoded register block
addresses from garbage. Check the return value and convert it.

Richard Cheng (2):
  cxl: Convert PCIBIOS errors to errno on remaining DVSEC/PCIe accesses
  cxl/core/regs: Check return value of DVSEC register locator reads

 drivers/cxl/core/pci.c  |  2 +-
 drivers/cxl/core/regs.c | 14 ++++++++++----
 drivers/cxl/port.c      |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)


base-commit: 26aa60e0276272ae61b843a05a91748dcb1130f9
-- 
2.43.0

