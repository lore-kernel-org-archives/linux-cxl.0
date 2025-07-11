Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3923505F;
	Fri, 11 Jul 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277814; cv=fail; b=UuTaX4A8jEec44wnmTAe4PK2i9upGKMBbCPtC7cFwTPxiwAbPxe2MJxMefwxFBcpEktudPI4xX/H01YlGmDrPJQSJX5nAOAKD1a6LVCWc0vKbRArhw9PG3l8PM2bhfNVIthMixFTGS/5RRxi5bPIHA00ieAyKHNgcp2igEtmf/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277814; c=relaxed/simple;
	bh=nx7c1fMXZmSjzwcHFq0kQJBRI26ZHWzH6MHagX3/4qM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q7WOjS3eq2qxCtSoR25mjFHe0zvvBnG+csAKpiQSLNFy3NKwnIVg70vICw1vFllQ9EueJb5uNFzBnVtGGFxIXHcC3VeH/Efo6NjiwlAqnSJj76H0CamQ606EOJTz4CdBOGM1/nJS9LWq/gVlg/TKQR9AqXikbdcT5H7CbObAXB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfMNusvZ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfMNusvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752277813; x=1783813813;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nx7c1fMXZmSjzwcHFq0kQJBRI26ZHWzH6MHagX3/4qM=;
  b=CfMNusvZuvqUq2ewV7K6mhFUSr2BgvzpbObJ+hyapF6eTRssLfUOTwKD
   zE4tjYAkBq3jC13KRqNNPziIh0S7tuBGc/PoxSPCqh4dW2ZsCeBPMa94P
   hOULkWhO5mApcc2ANDpIZhIM1gZUdhwXlnELyC9S7/JOMA+r5mMY6/5mS
   DxksLclhr2Y6jvmwPlgw7JjVwdpvbfpcMgtbbCUpU2Mw7kDKn5Wv+Hk2F
   Ogico4UINlvPpD6/M+eh/Izxl1xZaU0cNHw35+/mDGyhz3oDL75Q52VpG
   YaGWI69mCLcOCIJKmTtPaNaa11Zg/NfgcaST/ZjCSNkizpr0mE1yvUA0m
   Q==;
X-CSE-ConnectionGUID: Ro6MYE3QTQWfQO+vDwB2Bg==
X-CSE-MsgGUID: 7fthGdd1SniZRgs6U1ZtJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54547718"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54547718"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:50:10 -0700
X-CSE-ConnectionGUID: 1j0vIQ0zQs68lSPX4UHS5Q==
X-CSE-MsgGUID: sAfHV8g4QQOQzqt1oJ1SMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162048671"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:50:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:50:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:50:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:50:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/w2oRVV7Yy+cvQ9OjES9o6bAK2jI+LlJkH3l0Mx9pM1dt3blxFmgtQ/pXCKSgBqpSjcDAAs5K7Z7ItJHC/FmBF1qug9xzKvxnQ2S0qcjI0j06ER2YX0Wgq12WFxXKvhRZxiZmJIwQEW5yEe6cxdHLng1IGYkHZ6dlvK3jn0LCRyn6FzOknPxE22eYPGMj2LN0pBWMZLvEpiBeOqcdj+aLwkqtDFwN0F5/tSDPnmG3akQpe3GnC3Y7dOdTVVRIKIQTdn2F+LNB2qQK6hImt6XrGAPQzZ4AzXPWBd/wEAD1QErDxG4Q9dkGm/6aml+kKdpsx7ek7+dofo6A7CNsBLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPBmEfxz+d9zW57nu4D4EKGIkqIwWLLdj5xVBpVSyNo=;
 b=J2Fa3uEALo8cwh7ansDl6L472/58winz0DQrg1U1ihVh5UCEG9TKwRmEpT+dc5N5a5RL0Qy28fd6qCyOm3C/804tPfh/1NV9+61hPhz6f4Vrfe80uRo4o3a9OJZ90OEp9dHcq3QUH5XQ7yhEVT6yKfT3S0DcW0TXYA0SQIMzhf+rCxxx9moebDhVtlrXEGXGBkjMUUpWsQDH/qruk2FvyHpY7BA1QirNmfQrdrqz8n+IYYdMiTIgyLxQP1aXWnzrV5luFJ9feS8/ROY0/au7GS7HNvS6hY/JYJqgGyrZOwhh20sQ+aDDs0eL2r06c30Ju6iumZ7CvcuMnYnuFCEZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 23:49:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:49:35 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>, "David
 Lechner" <dlechner@baylibre.com>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio
 M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Ingo Molnar
	<mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Shiju Jose <shiju.jose@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>
Subject: [PATCH v3 0/8] cleanup: Introduce ACQUIRE(), a guard() for conditional locks
Date: Fri, 11 Jul 2025 16:49:24 -0700
Message-ID: <20250711234932.671292-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c65d7b9-3a6e-4d3f-7d29-08ddc0d59726
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jQUCZQivgJrWL6Bs7Z/JKltlXY2Njq5CEey5AX/M0cyq1PN0aARWCtrNJUDw?=
 =?us-ascii?Q?3TjkZtZYyjTWuL1kJ504RH1/gDgfYFS4EYSbFh40U+2IGVab1iKgjKFTeOU+?=
 =?us-ascii?Q?etXtTrDSbXvEeYuiLFmTav9p8bI9lnFmwypWLiQDLoH5NUJ1v5eVFRvopSml?=
 =?us-ascii?Q?vOLlFwVOnu6VFGVVxzzaXz5XP48c/SkF/c+oxzGEOo5fhrFDyvKLK17XYViG?=
 =?us-ascii?Q?7k7UlCMVSpkHlgpaFYA/WrLiVmJMUz09mF2ZWXYQ2URr0HoHLqGhgsSlFcbn?=
 =?us-ascii?Q?KbW3+YIB3418dnhoUyKOaO87AdTJBSwUJwS2M2wMPJ2MlYrvkSAhWfPUGRn4?=
 =?us-ascii?Q?+Rj8tN6gIDD6jEdhsKbRyUwFgFzGPL1YCnonhYRGUYffHfhvPLpusqEz3bBO?=
 =?us-ascii?Q?malCoXZb0xtJS1lGCA0bCGEJhOlPJhLDGxbyQIrYJB4u2kbVMiOLCc5VGSMs?=
 =?us-ascii?Q?pUZqiMukLblTR/RVEcKYV1399dcZei3p1l1EtywqgVrli/M5sMnSBa27enFd?=
 =?us-ascii?Q?upM0fO6cdMJ+V8U8fyMX1ITKpQZBIDt3L/ZFlMuByNmfaxND8tSA0PToLLwn?=
 =?us-ascii?Q?LH2YpZpHN1iU1vb2VWecsqr60mGWgEy/NKXiuDrc52dJ5W4rR40Pu3CnrbHd?=
 =?us-ascii?Q?FpY+L+2I7qmyxBjvI31fmaNGiCrP5jWb5kriaCV3PIXRU9+/IyG8CxHewXov?=
 =?us-ascii?Q?3OnplIC+aZqmUo8iuyHBST2cMre5HY6Ix3GoSJXfaoKUMk+IdJq5QDDYQTeJ?=
 =?us-ascii?Q?e02+jRFH40Jv80ljDJtFSHMGdXnJ0uyVivtsoQ2+4seI7bzEQOXS05YpYu/r?=
 =?us-ascii?Q?79K/KIYemaDulItJ8FHlkWxgwVejzHlV2nzjoOXcu4dHbAzwUzTqIxZB35q0?=
 =?us-ascii?Q?7oAGXPC+nWV3FFFXV8CVi8Yi7VI/mQSOXigBIcsH/y0K3lyWo8yyk7NC7z2e?=
 =?us-ascii?Q?ClrUv/Ed3Nvb3ROydZCJjO/cH+T0lcwHTHGy5xoYf2zOmgHL7DV+q8YE8aQw?=
 =?us-ascii?Q?CSynSHwNLbPxLsB1KfAVb+uMfvr1HFB2mYLdsKgPK20cJsao2qetjnGB8pSW?=
 =?us-ascii?Q?49+kjhWvY8HFlepaZuL0mk8YQIiapJkJcQGsjMPx0dcK1rfuOF2dCUA8ah3Q?=
 =?us-ascii?Q?7DAh/+g0q6jdDaa94ELlPqXsqkQxMxpfpWJKXfzlCcITU7xNxCVUjEQdJRIN?=
 =?us-ascii?Q?wgsfI7btNQxuuPoMqAfvUtM9d6RtF2LDoTD0ZxvnepQRUBlWNV1sVjOwBmEv?=
 =?us-ascii?Q?Dh5NuTqJtRYL/O1m5LMP1P2Q2Zt9pk6Hz3tlm2GsQA3XC3csw0ORt+VM7vGQ?=
 =?us-ascii?Q?QnkSllKMYGQ+Bawn1hqh/zsnjft/SY/+0xUySlKeiFhWwLLITvxYNWTGFTCK?=
 =?us-ascii?Q?9NLyoE/TB+3qLI4lICDs7kNjalPZVLawuBajPlewILT9B4rtHMTBcVTP40vA?=
 =?us-ascii?Q?HWUEQLhWbRk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQUq330em0Q+cPf6D2YQFL5OzCL5EPnYpXwKWLY2F75nrkQ8GasJfHGajYjH?=
 =?us-ascii?Q?HbDRHm1X+YEWposMm9cMjih7H5rlGWPhUG/VlL62J06k+/cbe9xALKptEJlK?=
 =?us-ascii?Q?j6Mhkr9wpAHj3eM9C8UnrOOg8DFCd0PZc+GzLThybefanNqi0h/x0OYkUx69?=
 =?us-ascii?Q?M6tkr1TS3M7yK9jp7TYd/WOI4jMdiFbvM2/RE73Z118XCIA3au8GE0UXQv0/?=
 =?us-ascii?Q?urTs+2OSqpVAj9QArX6JP7jO6aiEsMXArXX2HLN0x8SBIjPUAV+Zhf3Dx3g8?=
 =?us-ascii?Q?MlasRNMBd0Qz0nRO1pPtfp0G/fqt4Sv3FWp4x7PLSV/zn+s/v9caJ9ws0C9S?=
 =?us-ascii?Q?fhTTbRkyEAA1z5LHtvOXQ5JIAprCX5O37coaFe9f1hC49YKpx5pM7XcjaJR7?=
 =?us-ascii?Q?nbZEfL+LmhVIJBmpUPCJ/VxYVjGSw6s6jQxThxqGDbbqE9ZRkmTpy0POq3jl?=
 =?us-ascii?Q?vB48Mp6zEsFhiJMVMYL180MTe/zSazWfzbEXFR/8VWyIAGi3gR4JtlU/mkT+?=
 =?us-ascii?Q?+Txl5kJxaGxwkqpFMT70OUIT44YB7lnM8VwbAWMu7W8EFgwvpk9b5GEdBzMc?=
 =?us-ascii?Q?rr80s0/bRIp436UtdzaDk8Ui88LMwI4alA1mkrFeaU90jdSyLyyr+ZYCeaNc?=
 =?us-ascii?Q?lYRsWeMah6LufNkFJBBRf6wmvagdGT7FhsoJ1k4NBDRPTop+DM1zGTCl6mKu?=
 =?us-ascii?Q?BuuesHXDmZW20ixYD3r/QHdT2BeO+gdLJ7TjGqTV0AthPgT39KTmqgbkxnzL?=
 =?us-ascii?Q?b6QPx5irbu+UgEx+GpTMUSFY3/AzYueusGc1iJA6RlS8N1tF+o2z6WVRxfEf?=
 =?us-ascii?Q?+Nxc94TTQ9sdKDR7+JiOn+MDpgObwtWdZ8G4ljfevSIh33zuYhGAiuWT9e2I?=
 =?us-ascii?Q?aRxip4jPwrfENdh+xgOoNdHmFfllyBpUM31ILQEpnqmcxOn/7VWrBG8LBC4U?=
 =?us-ascii?Q?ESB6S0V9TOrNbcupfMdp97UXR139fSPfvtMYGYydSVSv4ctyuesqSB/t8xe1?=
 =?us-ascii?Q?nEalh4BqEjzNgmIoH2mJlulavhm1o8jNgNo4sDPBsoLcFVcJ1KoPfqwuFaSR?=
 =?us-ascii?Q?tNBRXqiE52WKC5y9paoCXhyTCIKlTS2WG1M1xVMdiqX4DszpQIsPc40chtgy?=
 =?us-ascii?Q?wPkGbXG/PBMw1A7nuiFXEx09EHXhFFdyWa6MenTI/oHMX3C+vQHHhwHEvnf4?=
 =?us-ascii?Q?xEZAFPlUsnOG74uKxMeBJJDHFEOwbs4vILCp7nuaI7cXun27zqb/YU/wpDNo?=
 =?us-ascii?Q?n0AS3z9ISPZyUXpQe99XmTMrcgfeNZFyl1+EQPiEmILPzBA870GM0e9Esnn3?=
 =?us-ascii?Q?xiE0owe7unOsWupuXssEYi5GixLQXKvH2xsF1HKrcMqyjK8aAbQ8r3rDRI7r?=
 =?us-ascii?Q?OKjmskaxexIPCiDpKkd+PswQJYtru5CR7dUtlh+2lJcn0ikAzui2D+3D1sEP?=
 =?us-ascii?Q?VLbBSfqMK7Tb3K9+PXC3Lj703Me3taOq/ArZ/4Wk9szA2Rrzi5zpG9CBnV6N?=
 =?us-ascii?Q?9XHL3qZccUmOeBvFe01VLBuhWnVQuv8d3SkrbFMAneypTpvcWFP1DiL5ejQS?=
 =?us-ascii?Q?qOfD/NvZGyvaYjZhSD87L41KX3knjWGrsymwO5ABkxNForJquFw2YvxG2tuf?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c65d7b9-3a6e-4d3f-7d29-08ddc0d59726
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:49:35.5066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rvm+1F0yYTL19VkMe7rbGce59fnRt4vcEwi4SH1ISwxWbjpp2oVPf0xf96uP2aEUec6KKzpwXYfmvGLQ7HVCs2q3LqlmmPQ3uzqZCp5e9ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com

Changes since v2 [1]:
- Pick up Acks and Reviews
- Whitespace fixups for cleanup.h changes (Jonathan)
- Use consistent local variable style for ACQUIRE_ERR() (Jonathan)
  - Not addressed: switch to less compact style ACQUIRE_ERR()
- Not addressed: pickup checkpatch change for ACQUIRE_ERR() style in
  this series (Alison)
- Drop the cxl_decoder_detach() CLASS() and convert to a helper function (Jonathan)
- Refactor attach_target() to make it easier to read (Jonathan)

[1]: http://lore.kernel.org/20250619050416.782871-1-dan.j.williams@intel.com

For those new to this set, the motivation for this work is that the CXL
subsystem adopted scope-based-cleanup helpers and achieved some decent
cleanups. However, that work stalled with conditional locks. It stalled
due to the pain points of scoped_cond_guard(). See patch1.

In the interim, approaches like rwsem_read_intr_acquire() attempted to
workaround the pain points, but started a "parallel universe" of helpers
that is not sustainable.

    0c6e6f1357cb cxl/edac: Add CXL memory device patrol scrub control feature

Peter fixed all of this up in a manner consistent with existing guards.
Take that proposal and run with it to unblock further cleanups of "goto"
in unwind paths in the CXL subsystem.

Potential follow-on work identified by this effort:

- __GUARD_IS_ERR() asm helper [2]
- Checkpatch fixups for proposed ACQUIRE_ERR() style [3]

[2]: http://lore.kernel.org/20250514064624.GA24938@noisy.programming.kicks-ass.net
[3]: http://lore.kernel.org/aGXDMZB6omShJpoj@aschofie-mobl2.lan

Dan Williams (7):
  cxl/mbox: Convert poison list mutex to ACQUIRE()
  cxl/decoder: Move decoder register programming to a helper
  cxl/decoder: Drop pointless locking
  cxl/region: Split commit_store() into __commit() and queue_reset()
    helpers
  cxl/region: Move ready-to-probe state check to a helper
  cxl/region: Consolidate cxl_decoder_kill_region() and
    cxl_region_detach()
  cxl: Convert to ACQUIRE() for conditional rwsem locking

Peter Zijlstra (1):
  cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks

 drivers/cxl/core/cdat.c   |   6 +-
 drivers/cxl/core/core.h   |  32 ++-
 drivers/cxl/core/edac.c   |  44 ++--
 drivers/cxl/core/hdm.c    | 118 +++++-----
 drivers/cxl/core/mbox.c   |  13 +-
 drivers/cxl/core/memdev.c |  50 ++--
 drivers/cxl/core/port.c   |  27 +--
 drivers/cxl/core/region.c | 473 ++++++++++++++++++++------------------
 drivers/cxl/cxl.h         |  13 +-
 drivers/cxl/cxlmem.h      |   4 +-
 include/linux/cleanup.h   |  95 ++++++--
 include/linux/mutex.h     |   2 +-
 include/linux/rwsem.h     |   3 +-
 13 files changed, 480 insertions(+), 400 deletions(-)


base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.50.0

