Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0B1F0984
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662269; cv=fail; b=T7lar2yzq1gLCFSA5R9MM180SYyHFzEBh7udGtj/ROms3nsFju4faLU8xYUCRDeJgO4kFd1Q3bmiZ0HTjG+YiVnD0Vjr3s0XVKofSqzveEZgBN2N9WiHmI6he7+kxDgkLkgNdpYzOda42MFmlom/k3nvBHewzmSC+6/aAlPks1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662269; c=relaxed/simple;
	bh=pPeZoqqoO7RR9X2muCEtnU7TsiFd6MLKPnGavyLgmP0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ibrZkZypVvoseSBVqCcZARai/WFtesPGuHpovThqlYEp+3BcP2Rq4oW1GdOrnGm36hJsYgcmMFiifGdULFWLdYARArwxvVIYaRkHgzp4P+hMVLSdRJMhYvRAC3qkEJo+UnHiiV7T9DlsYkQ7yBtd9wBcMhVxDrVt5FZsfBYwnyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F58qXRRK; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F58qXRRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749662267; x=1781198267;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=pPeZoqqoO7RR9X2muCEtnU7TsiFd6MLKPnGavyLgmP0=;
  b=F58qXRRKJo71FQM8IbMQz9xjNHZg4IB/DxhE3rLS7rzEsUM/47uwcMOd
   ITg79qpEc1d/Y+IWt9U74jWAmDginrpttkYVU97NfMKTNQ7CwzP0JuviE
   qhFiTDhA6u3baOUbszylZ0SzY6Ok0CkVPyQkbrWeHq1M62Zfu4Sy2DlyR
   2sX/4JeF33sFswqk361U0AxCAO+c054Kr33JPoppUTBgkuBb3Ue5cgKMr
   /57++UyinATlkBqR5R7u9rzEXyabJ3tsmJB7QMutkNP+/fzKzbF6U33Mr
   Fw+4n0JYXpEQN03kFMI9QjaYWNvF9BilMERnAxC0Nz+OaLGSXrBXcX/5W
   A==;
X-CSE-ConnectionGUID: nMRfNnFIRHGhK8bpbkc9UQ==
X-CSE-MsgGUID: Py/Sm1k8TmqN23x9Cpw0wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="54443081"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="54443081"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 10:17:44 -0700
X-CSE-ConnectionGUID: w0diXLImR3+hDM7hb6YKkA==
X-CSE-MsgGUID: DcVBXD0TSwGOATURR6Z0fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152149403"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 10:17:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 10:17:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 10:17:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 10:17:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfMMSYm6g83suIeOQQGLUglbrm2T44imfWTsQ5A89sc8uzMPTT4G4tYwnsCMuB3xrtYkE67ZRVYje3sLWQwMs+26wNLafLrJ2JjitNN0+AeZfLRnree8NWeFtO3StYRHQfIu56bbRETiO+WNirX0evnUFm6If8y09suxDDsgKi37qkzddLwPrP25Gqe5dBsed49Ql6cm7OwbjcTAu+C1VzkkvI26sexoaqnlr1yjuP5C0uNljmzqDoIu0KmWIxRogZ1v6msrz0rfDNbQLhdpQ85yutgUVRiPDJmoduGlwhTJ74DM/ZH5smYYjjxAsyui2wNrYvQFMWfO5rhe7Y4B2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlYj3NRtEC7YxPtBhu5IyueBT1q8klh2VosLVICpRDI=;
 b=MJYcPWnr0o647SJhxEigVpnb9wXce4vNkehUe4GtaRsx8cxWc//L9AsYJTXaC9j3yg8VSi1h2Rkb0B1PWI5inQueGFrptDvpEgktp+V3m7fcmcAzk8ssxMZGzViHIdsXXYsoPlVWatc5vEd4uUqAbAgTglhYtZgNy16UDYYyK7R1J3I8cvletVVF7w+Nz6pNqLuJoDiO7UJqUkYVfP3tk/LqIbJsqpOFCyEXSu4O1a1zfzoeN7NtTBA1JFxTpz/wTT4fQx8QeDcmvii9Xh4Fgxx4VS+aCKXdHbvdz0h/FaQGm7XYEp3L/lqihAgAvzg4qvlTeqYi0O/qG2ePFjaVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8247.namprd11.prod.outlook.com (2603:10b6:208:449::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 17:17:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8813.021; Wed, 11 Jun 2025
 17:17:24 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Li Ming <ming.li@zohomail.com>, Alison Schofield
	<alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Tony Luck
	<tony.luck@intel.com>
Subject: [PATCH] cxl/ras: Fix CPER handler device confusion
Date: Wed, 11 Jun 2025 10:17:21 -0700
Message-ID: <20250611171721.2048408-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 244bc932-eef2-47a2-53ee-08dda90bd54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eGCc5j5839AmdtXzXm9GEW2R3bCIBEJWl2nb0zkBZB3PvTvCMamgyM9ah45+?=
 =?us-ascii?Q?iu8YDY6Dui5o/RqEKpiAcMqy+wU5kRYNsaU+1N4QuNzeBz/zTflGQRE7j0vv?=
 =?us-ascii?Q?BCVG15laDFM1P8MDTtp5Qg6pVtjlnElzB1t6oPsT5Dm7BI8sK91R6S90fNoU?=
 =?us-ascii?Q?7QLrKg1RaV+Q6a/QCDlTpiFBKpt58tF7db2RL8N5sTMG0zLv0FV3m3Dhz3SK?=
 =?us-ascii?Q?q+4MoGZKShDe+qtJbXKFLE6z1yxcZ7QUPol9qH0X4cquOhDgvt55f0mIptkN?=
 =?us-ascii?Q?M2oBmzjbW/v+z/vpaJNPTq2p5TjvNJqy+/AYYt9HKauJSUuij2Sh4SeG+PPx?=
 =?us-ascii?Q?e8f/t6qxx5IeFG2emiCj5NvHS/4DHgSZl9nlY0T5seZL1GSM5oirSt2nlVJw?=
 =?us-ascii?Q?4U1W+Xcvyak4R+8xY6tcCmvbbLwDbq1E01uJc6/cveqsW5J/EdCy6Ce40tdL?=
 =?us-ascii?Q?F00eZXd6z1dExTDnSzuHWEDggc9/7znqQZUrNqnKl/Zx+iFGOVijITQwph+u?=
 =?us-ascii?Q?sbJ6E1RnV80jVol99y1z3e4rn8CxfkQEvESL61nzFwhIYiWMvZ8HMQU+8EQE?=
 =?us-ascii?Q?hh2WH5efUqj3yHF8sk0dZ4Q1/wTSvLeMD86byYHqa3UO+UlrvbLJyRK4XwJH?=
 =?us-ascii?Q?aUsMYqRqfT3n2wClLHAWLe1n9Cn1XMvfsAw1zDiybWZ4BSApty2IHAxLbd6L?=
 =?us-ascii?Q?quX/zD49XBpu8NTobjEh8cccgXwi1OXwkxzuUtCtrmLYRY24TbCQsPDifNQ7?=
 =?us-ascii?Q?jIVEBTpbQVLMww7D8GUlsnLFEfE3CqE25qIaa1j824rzZVLnoduttlP9smNJ?=
 =?us-ascii?Q?dIwJufW3jaN2iGWSqeMqBEwu8aRyTCRetuYiEIyl5Xmz60mAFjI6arvpUmDz?=
 =?us-ascii?Q?5hFppsD+ffF4FlfJCngnTpDMfMRAm4QUzK2rGJHcikKNt/iEHwaOEyGdBZFl?=
 =?us-ascii?Q?w/D2R/gvvj3LE2zjYDPMGud0y8UohjAjyXD/4YOKT+gOzfXc8HaX3lt8jp8S?=
 =?us-ascii?Q?5Fxnx7/4AWd/Raa/+tU3a1XXDzkmEJBTYk8KUBwS8hgk7OicmdVR/Ouu/kv4?=
 =?us-ascii?Q?9VdOyZEJxbZ4eYDdWI43kI1NwFpqx0weEUUPKC2W7aOBIuy1BVkU6MtBWeUK?=
 =?us-ascii?Q?QvVbazEZjEsn9dd+4sQju5bAyDGNvbfCId6RHXYqhm2VzgZws2VMrWGzExFG?=
 =?us-ascii?Q?Na0pEM00BGh6Digf89kZbMTeqT4z4VGuC6ThqXa/Jy3uvshHV7+rejphhbmN?=
 =?us-ascii?Q?qZ9cF1mwBZFyqKLbF50fucaYzfWERoWaNLdxV5f6KcQYu0RyI/IdzWVKxLOg?=
 =?us-ascii?Q?MSEGPJcD7PQcTUKkCgBDRVAbn3attSg17KwqiK0y/+6yvnbbcB3b2ii5FFs3?=
 =?us-ascii?Q?+D3s3dYABD9EcYozdfrwHMF0ZGqyYwZvi4E1Asgldy7sSeLh8gqN8sCeo9O6?=
 =?us-ascii?Q?M8+YLn/EHAA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SpH7lKRaT2ir/vCHMVhaEHYtVHx6FNT2vQDdlO56TgOAayw0ONfLWIuf2SZx?=
 =?us-ascii?Q?NgCrt0XG6dC5a0CdUIQ1JW+HXrkxRbkiUUvnNLwQJjIMm8yBnXvfoRtVp3BJ?=
 =?us-ascii?Q?r5NZkSKlkhps0M3HXOZcz0ki+i3ssioX+C8NqZtaR3mnbxescrnlas4Ne9LK?=
 =?us-ascii?Q?xZtKR+wNUnjbbgqiKRixIKDQN84/Ud+eIiemQ753uir/7FBFdNNYmTgmngvz?=
 =?us-ascii?Q?v10fqAFXt2RIxB6QvmOu1CLDj2/Ea77Jq3r5vxSsMlJXAoG0GMmNSkrg3dJA?=
 =?us-ascii?Q?UN1xyepoNp4efitjRh5FS5H9eu9dPOyrdMhFrZ2GJsPFhW1Ee+908OKm6IVV?=
 =?us-ascii?Q?dyJywqRR4YJLgRRVCAIMV6fiEUcf2ua/DWB59uNnrFFmIH4QoJI08V8RLpdm?=
 =?us-ascii?Q?ogAEMsDDJPBWDs9dvDOrMGtaZPN5ymSau66sdoS1qs3ZUfFTMhBfWPZQjRrm?=
 =?us-ascii?Q?H/wZqCGij8yDN5DyzoWALhcjCUXsNSpNa+sQyzYBYFUmRN8sQ10VEj4SV5D/?=
 =?us-ascii?Q?+nxc/++ae5WHsB3GHWxRAqIgMmNRCrmHgO5UPP/FOt8XCd2Yis8SR/kRkXox?=
 =?us-ascii?Q?QmHBSrdQSvYgrVw0zCzQEjot/y3PiJVHwIl6j42i0T9HU1DI3czljSuhPKCn?=
 =?us-ascii?Q?184lQaCbsGPa7FP4K+b9NLM0nb0D2uz1OAI6qBZDB21QPUwRe3yK3t1eTqvQ?=
 =?us-ascii?Q?PAukM94KOUqzumntShQNbScNUUr1uGbbeQCCrf2VNncPGO8jaPNnFUXr+UX9?=
 =?us-ascii?Q?FAEDh3wa+a+mfgJQ8u8fZEeQyJenn70zf8SZSmdbEMntZAMy24fj4WNuX7Ta?=
 =?us-ascii?Q?2+4n6Amme4LGzOuXVWzkloZBy4XKNMH/XsBOeZtuXLjh1ATyZDbh48bUiETw?=
 =?us-ascii?Q?Hkr0fVFCAmF5wfNvKc963gjObMVsOwgGFsVICTGGkK7jJGX/fxvmKkdLzxzl?=
 =?us-ascii?Q?SYLIYx7wLQMgLrutOGlVIzFCOQwCXFyw2yZb8zbYsOja+F28kGxG7QxX/UO2?=
 =?us-ascii?Q?xMJRY/jcsyiFcwkAhtmw/26AdpUS6rr4XfOmKGoxHbdV/rkJUVONbjbDRCkS?=
 =?us-ascii?Q?k3M/ihFcsVQG5dSUNjly4SKGYg/FVHTJcCYziI6+fDM8fKFiNrD1DMb7Hen5?=
 =?us-ascii?Q?DbxnXqYHx5s8C5LXJbXvDwSb6OYPg5OMXItwWBsKaZF8PWE+HSCRZvSNUpwl?=
 =?us-ascii?Q?AN00qrEVAke/8GV+inmb7ivRp+OQNWEMrFGy/1od6ihJIGdg77AlSFVask6i?=
 =?us-ascii?Q?HXgNwd5a2hmvWob67ku0oEuwLaCAGvaU2uTgJS28BJx3J+nO9AGUyA53yU9y?=
 =?us-ascii?Q?u/S98owLPGP9ve8xDk4M7ptT/Omd+nliNwz9tdLs+0JJv5rHGolotkBCuTOL?=
 =?us-ascii?Q?rCTZktCdvbMecS5gylmjbmyrpULkMmEGTjEtZeFEf49BofhRbKxrCPFhJZ2l?=
 =?us-ascii?Q?hj6PT8loh7HvJKh+GS4uHEM0qhDr3/4sZf707OBc0iHcqtNKIEfGjUmDjnzE?=
 =?us-ascii?Q?vlaIagTfikrY2ds2vUoh/QZmB0m/Se2lu1KNnBPZWgCETGYUe9ejbEN087/j?=
 =?us-ascii?Q?j2M2tWSWKcejKoEPdLTNKEOV3Oe+sfdNTbh5GwSEaWLo0YxJuASKAmvLVQKh?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 244bc932-eef2-47a2-53ee-08dda90bd54d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 17:17:24.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMY0VmBRwU0hFn5G1Nx08wHub2u7UXVFGN4XEeKcAahwAG+eZgU4aBFTKBPBUjKSd0qQgmq8K34HoGlNIc8p2f4wvG1D43tqI1NDk5sSlVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8247
X-OriginatorOrg: intel.com

By inspection, cxl_cper_handle_prot_err() is making a series of fragile
assumptions that can lead to crashes:

1/ It assumes that endpoints identified in the record are a CXL-type-3
   device, nothing guarantees that.

2/ It assumes that the device is bound to the cxl_pci driver, nothing
   guarantees that.

3/ Minor, it holds the device lock over the switch-port tracing for no
   reason as the trace is 100% generated from data in the record.

Correct those by checking that the PCIe endpoint parents a cxl_memdev
before assuming the format of the driver data, and move the lock to where
it is required. Consequently this also makes the implementation ready for
CXL accelerators that are not bound to cxl_pci.

Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Terry Bowman <terry.bowman@amd.com>
Cc: Li Ming <ming.li@zohomail.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/ras.c | 48 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 485a831695c7..1173eaff7e2b 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -31,40 +31,38 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
 					       ras_cap.header_log);
 }
 
-static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
-				  struct cxl_ras_capability_regs ras_cap)
+static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
+					 struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
-	struct cxl_dev_state *cxlds;
 
-	cxlds = pci_get_drvdata(pdev);
-	if (!cxlds)
-		return;
-
-	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+	trace_cxl_aer_correctable_error(cxlmd, status);
 }
 
-static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
-				    struct cxl_ras_capability_regs ras_cap)
+static void
+cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
+			       struct cxl_ras_capability_regs ras_cap)
 {
 	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
-	struct cxl_dev_state *cxlds;
 	u32 fe;
 
-	cxlds = pci_get_drvdata(pdev);
-	if (!cxlds)
-		return;
-
 	if (hweight32(status) > 1)
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
 				   ras_cap.cap_control));
 	else
 		fe = status;
 
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
+	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
 					  ras_cap.header_log);
 }
 
+static int match_memdev_by_parent(struct device *dev, const void *uport)
+{
+	if (is_cxl_memdev(dev) && dev->parent == uport)
+		return 1;
+	return 0;
+}
+
 static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 {
 	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
@@ -73,13 +71,13 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
 					    data->prot_err.agent_addr.bus,
 					    devfn);
+	struct cxl_memdev *cxlmd;
+	struct device *mem_dev;
 	int port_type;
 
 	if (!pdev)
 		return;
 
-	guard(device)(&pdev->dev);
-
 	port_type = pci_pcie_type(pdev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
 	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
@@ -92,10 +90,20 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		return;
 	}
 
+	guard(device)(&pdev->dev);
+	if (!pdev->dev.driver)
+		return;
+
+	mem_dev = bus_find_device(&cxl_bus_type, NULL, pdev,
+				  match_memdev_by_parent);
+	if (!mem_dev)
+		return;
+
+	cxlmd = to_cxl_memdev(mem_dev);
 	if (data->severity == AER_CORRECTABLE)
-		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
+		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
 	else
-		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
+		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
 }
 
 static void cxl_cper_prot_err_work_fn(struct work_struct *work)

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.49.0

