Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AA2066DE;
	Wed, 25 Mar 2026 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402503; cv=fail; b=oFXu6D7pjoKk6e0/n3hNzuEL5hfDLIeW8EdvlobVFrKnaZ3ffgX1jobBxCDCNfcCfDP9VDk96f9FGW/95rIOkMnkC704vZiVL+lRMXO4eMXj3D6tWnxM14K+25lxBMxMzfADnuhydMbgBP4os8bltAB+Z0HKK183TSqToI5690o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402503; c=relaxed/simple;
	bh=DOtgN4o7p/eXtyY9WMJJRs6tnzwbaQap3c9xuPzYIcY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Cg+0DN+hjJKehBGzShMgNfsGdO/peAUsvt8yUBdKDPHtAX+5x34YoRR6Gyea8KkGxBTUO8ONaFjjL2l6Czry+M3il+KY+RpCQaCyOvDpbBXem+gYaNfbQ8LmUQFBJYv18Ppyo6Szh8f3pV1Zt8trqrXeFNyb9gWTxdwRG0rdSic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKmufixF; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKmufixF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774402502; x=1805938502;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=DOtgN4o7p/eXtyY9WMJJRs6tnzwbaQap3c9xuPzYIcY=;
  b=gKmufixF97yrp5RiekPlm1kSOms7LjfdQAgus8kCcDlgP2//bw6HSZO8
   5wlYqZySRNj0xz36cv7P1+nwogJQkqhgoVHnSjKnj/JRz8IDK3J61GB61
   ROyWLYiXedkztO+jbW8BAerMfgmo4C3VuspUOJqQOi7MtwU4oo0kuPyzS
   TwEJLoG8XRHRQM31lgCbHQqnX84FU0Af/dvcEkge7RQN7ldqSbmUUx+xb
   vXKcxe1UqWb/3YF+c76LhFt8V5n/05ACC/jiT3XdBasnIjGRrZIWHxA+B
   RGboXA1wOzHhUd6C59HStHkHFF+BMNDd9OGP4X2qm9L7fYuJOEjjlcbUt
   Q==;
X-CSE-ConnectionGUID: lzTN1oG3QbOXB1hE9D9mgw==
X-CSE-MsgGUID: 4kH++OCqQY6qPECIjPQnuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75319406"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75319406"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 18:35:02 -0700
X-CSE-ConnectionGUID: oQ34IPdwQQOMyl3/Wpi6dw==
X-CSE-MsgGUID: 9jSfgC1NQ2WAIiCK4DSG3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="262451181"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 18:35:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 18:35:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 18:35:00 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 18:35:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic/pSGXmLWMBy61tzH+zaKxPplGduHLKUznfm2Vx+dsxaSFX3oogoLvlH4in7QCuaopbJWQvBdteHvWPqNxrue8ZXzAxWQLglMqvPlcbDkdl0WFQQ/fcEZrRnvALbh/RQgdhL/c/9aTb6pAvEt+P2jZsrJtS5KWZ2WJqB1RmfC+1X+OePxwPG1UPcNmeaSP9M27bqZGgqBOQXNx2xW9r4ATaNe/SW7AThWBbKEsZtt5pkvoIIJYLyJ7zs+BXeTJ1Vu+RF3ct0f2nZvL/RG6obL+mEmTe/Rqkhrbndd8oymqRQAJTH0bHpt4uIV3d2XVeMq93Inw0RqprCMHegRn9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBXU7zLE/EQE0+c80FSnBwmPVMRyjYgH5/z5IwWK7RE=;
 b=M4tJtrzS5Nk9oLnqDuiDJKx1sP1ypBxLdAhzwMJyiHM9nUljWwBijT/UKiStYFmL3ACO0nwAgITouKxtQIp67UXDGf4tvBbmYCiXuVe0/vUk/hxNOF1Ce/B5s1xplnct8FKEjoDG51IIDvzyY+NQciqBCAsxIDMJf+uIYrc1czy9X5+rbaCvUnt3BsxhCdd6E6ZK6bOoqWXgK0utNAtAxZm7qUjJbbuX/LYIcb/W6WJtPupJwvh3SCTqyP9sNQ3TVMKxsZo4PsIRVZEdckNNrCp9Zfibin5nMn6HhBUdK3YQElTEYdw4dKsLYTRsp3SoTpspfqSVtX6r9Tg354Y4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9109.namprd11.prod.outlook.com (2603:10b6:208:572::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 01:34:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:34:57 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Mar 2026 18:34:54 -0700
To: Sungwoo Kim <iam@sung-woo.kim>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
CC: Dave Tian <daveti@purdue.edu>, Sungwoo Kim <iam@sung-woo.kim>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Message-ID: <69c33bbeae7e5_5162110077@dwillia2-mobl4.notmuch>
In-Reply-To: <20260309000810.2632065-2-iam@sung-woo.kim>
References: <20260309000810.2632065-2-iam@sung-woo.kim>
Subject: Re: [PATCH] cxl/hdm: fix a warning in devm_remove_action()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:303:6b::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: e0107d82-25ea-4958-255e-08de8a0eb901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: OhUdUfTTfA1ICd4bb/L08xxyhlxF0BL4F/+1Onqyo7kwWj9SshTlx89XAe2SBKF5ZaiCaSdsPmFU2NwrlAPwDJkp5kCs+xjnxxluwDNLMpUUd1Vn1K5mTS+2vcVjtgkY+wXcGjDT7H//HVrjrYM9Ohec8mulbpQMovxNFdGvhV3s+aeZA6fb0DrAdAFg+mt2zLsVEuXP9mla6oCI7TftLL0vKuQm51y+BWinEnjUud6B9cE0iV90ImLZs1/l8J14nSglo2HjjG90PVO/gLPIBNPTssv8xev66VCTd3HEBYhbgkINJ9DLUcnN85df+p5u2aLyz1rzCMxPLrdgonOS4OZM63/QuWog9xERxqWCFkO5WZyI2iXEG1o8ORdLEcR2ayCZ16C1TRadWu4WH5lykS1tluXL0fCUknOazmYfPs4BnNgg0tPXago+PZbDu6lKZYG5pIlcaTyFP4s7fQv1emzrCBrbNHsisHeEx7k0/giEUpGbrhzuoZef4Kmfsl09lggWLufrPWnb/vGmpo1I7mA8KF1IpjeLrtA0lE8XTJAiX/ZOESsnwXdKKQWuyBhZ7DIhX1mcxTcGe+56NMO1U9Rj0wYvcfuEma82l7hYAR6pJx9+NHAZzaUVobSdYwdG0jZBtISTFN5Q1bVwnM+wNCyBBfQeQZ6+8zOSVxOtS4zaa1IgNHF4m59N6vNesk7/GQvBmPIh1Wxnx7pWdo0lwVY6nFSTvCiuzO6UTmfFgJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUJEdzZBOWJZUXZKZmx5d2xmckl2ajVTWFdIOUt2QjErVG9YSnlYWFNRV3pG?=
 =?utf-8?B?MVNRbzI0cE1qR29QdVgzNUN1V3dFcHprcmM1V1B1Ny9aVEp4eXJOaDFMYXBr?=
 =?utf-8?B?RzQ4bVNtYUhDN2xmZzZnL1J3M0YyU2MreWVjcXU3T24xQUtnTlBoWVpHbWpO?=
 =?utf-8?B?TENhd0NMR3pVOFN0UWxxeFhqUGwzY091WGxFb1FoM1RISVMxdk9TMmZoNUtJ?=
 =?utf-8?B?cmx4RUdrZ1UrZWQ1WVBHWCtPSmhFRnE5UXBHSlMxeHQ0RWVTUGZSaUM0N0dx?=
 =?utf-8?B?OE52L1JQemU2OEttdWlyNzdPcTBoY3NsYzErVTNqQzFEVmdJNEFlZnBxaW1X?=
 =?utf-8?B?L0JyQlRDUnhUTUEwbFR5ZzdGUlRBbE8wWGJWZzA3ZWdsREFmWDIrVUx3bk1j?=
 =?utf-8?B?SllBcFhWQTFjY2Y1eUl3ZCtYNTZuZlZuUDFEcThURFd0emw4aG9hMTh5Ty9V?=
 =?utf-8?B?WmhOaVZ4Z2lTenFPWVVabUNGbmEvUUZ5dENOVnpmMDhtYXBtYlkzbStKUWtJ?=
 =?utf-8?B?QWZwRHhUaTlPZ1YvRms2NE5URWphODArZVMzaWhYM0lnRmVsWFRxak4rYWRL?=
 =?utf-8?B?RnptV0RwQVg2elpndCtVdVJ2U1V0NnhIeGsvZnVzbzg4aWdGVHdwOEJGaVZF?=
 =?utf-8?B?eTcxdmNraXZsdlpsR0RSSG5UUm0xR0NlazFXSEdBRnFHbnFTK2xqckJSNTAw?=
 =?utf-8?B?N3RITEloOS9SS0ZNY2FibHlVUk5NdFJ3b2czdkpqMnR4UllOYnFBaWQyVkRH?=
 =?utf-8?B?dEh1NS9wUXgvYVhWYlV1SFZjVm53SXRXN3hURXhwZEN6MkIwT1NmOEdMQ2t6?=
 =?utf-8?B?Q2h5WlR2S2Y4L2JacjQyYllreUJnMjFmSFkrTDJub2twNHBmV2NteU9sNDVV?=
 =?utf-8?B?R3lFZGltZG1aM0ZTQlQzVFdMUGN4ZThPdHBITG9kSGZBem16eEh6ODdicDNP?=
 =?utf-8?B?R052RDRpeWl0ZkFEVWN1blE1czFCMDgxOTRINU9UZkxkd0MyeENZWWxENHZI?=
 =?utf-8?B?RkhVNGNLUkI2K2lqbTBiM3lCY0h1Qk5yYUwxS3Fjell5bWN6dzNLcmJyWVNX?=
 =?utf-8?B?dnk2eVpBMkhFZk1jMlRQbm5EdlN4OVoyL2RPRzh3cVgzcVM4N1czemRXWExC?=
 =?utf-8?B?UFFkWFliMkMydnh6SksweGx5b1c1d2N0RGFqU1RYT1pCT1E2dUVvWTR5RFlO?=
 =?utf-8?B?MytKUTdvQ3c0SG8vd3cxWXdYMWU5VkwrWHk3NkFPcFoxN2pWcWtodGFRbW4x?=
 =?utf-8?B?aG5RcFp3OHBUeFhZOXJrZlQ0RUtqeUtENC9sMTg0QWF2UGVaQzJuOEt1c3R3?=
 =?utf-8?B?cjVud1IrRUxrWmpBNUYyMy8zRzdOMEdaQjVmWkxzMitMSkpJR0pyL1FTWWRN?=
 =?utf-8?B?c2FUbDM2L0ljbERBV0pnR1YzY0paK1I5SEk2Z2FacUdBV0dhQzBWSThmazRG?=
 =?utf-8?B?aTZ2cmIvL0MrYjFlZ00yRXNoeTlWcGtaTXh1OEVBUlFKbXE5M1NHUjNMa2w0?=
 =?utf-8?B?WUp2QWIzTERNODgvUzEzL1BGN2hESDd2TXRPekh1ZTFMZ0xybmhoYS9FenBF?=
 =?utf-8?B?RStSNnZ0MEphNkdKbXR5eEhodnhPSUtZYytZMGczdERUbXBxS1JpYnFOeStO?=
 =?utf-8?B?Q1k1Ly9udzl3WTh3anJIbm1qQ2NhRWhrQ0dXOFZBZUEvU1M2VjZzUHlmc3Rx?=
 =?utf-8?B?SVZVSDBnL0pCL1QvblpSTEZtU1hZR3EwZVZWNWI3bWlEd09CVG14bWxuSWdt?=
 =?utf-8?B?WE9JQWdpajBrU2RXZW4ydmhqNnp6UUZBNzBsdzR0SlhnUzM2TTJQbml5N1dU?=
 =?utf-8?B?Q3hRTVZCQk4xV3k5TklVVENnVks0cWp5WGI0SDZzbFk4NDRaRW9scE1yUHRp?=
 =?utf-8?B?bTBNUkxHZDA5cVgxMlVGNThpWDhkZUNMdlRxdWFPT0NtU3IwSkY4QTIrWEJ5?=
 =?utf-8?B?Z1RYZFowL3Bqb0pISnV0b0VPeS93dFQybTRUMXNHaFczaG5sSWFVdmd5Vmcr?=
 =?utf-8?B?ZXZJSVoxbzVXK1Mza1VxNTV1cUJhc29iVjg4QUNUb3hxSXR2RkJGNElkcWRY?=
 =?utf-8?B?amQ3OHJOeHhjTWhlZW1EemdwVmxqZnpGOEI1WU9GMy9zSmd5TTRMOVI1UEdZ?=
 =?utf-8?B?WHZRQ1oyTHFvOWtVZ2pDdGg4cWQwRE10QnR2YkFvT0RSQUd0NWV5dmVwcXhO?=
 =?utf-8?B?anhLZlFpMVhndHphQWVkbmNncmphZStybWNTODIzRHVxTVYxSDRlazhNcUZC?=
 =?utf-8?B?SVMxVytZbUtXT1Q4cTBmeE9EUjBkMlR6c3I0NTFmdUtCa2VJbmZUbGNweWxv?=
 =?utf-8?B?OTY5am5hQjB3OUFQNXYyMnh4M0tUTldjbldYN2NZcGQ0TlhHK3FGcS8vTXY1?=
 =?utf-8?Q?CQoU5aO7wiYAN0HI=3D?=
X-Exchange-RoutingPolicyChecked: MeGrOGq6j/9gr4jIy+/jL+2N3XlDU4aW6+9CApxNh9o20/mZXqPp0Amynz4/3XIG6GT2MPF7l10tWgwLO/ACuLqWEwbAkEYK9T0ZtQy/LuzKoZ1iozfNjgpo5W5ByJHWW5OXKRaDt1LsEtXNjfZ130/USldW/ATlJwrANdhTBX+8oN9E8Rpp1coibgkABzdiIgDkW6eh5UIifOFV0mTeB7oRqSg51H0dne3pVKrI+ZkkxvbqgnWfY1sXXUToleMx7B8Xl3oVIOYYPMtuyIrS17LIEuOD7NrPcKE5gE4FPI/cf21PZhdx4wmEKKzQQkxCdyut79QGM0NUtFCuTz0Jww==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0107d82-25ea-4958-255e-08de8a0eb901
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 01:34:57.3803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/9kO4ld2L4ostHnP7oVPCCpSxxdCtfYc+XM412WKvwV0pE7BTV/r1Y9qBNAobfo+7sKUtaXllXYiI9GmMpkBM+0gr2Ax+Zfg3iDeDDSE4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9109
X-OriginatorOrg: intel.com

Sungwoo Kim wrote:
> In the following race scenario, devm_remove_action() can be called
> before devm_add_action(), triggering a warning because there is no
> action to remove.
> 
> To fix this, extend a critical section to embrace both
> __cxl_dpa_reserve() and devm_add_action().
> 
> task 1:
> cxl_dpa_alloc()
>   __cxl_dpa_reserve()    ...(1)
>   devm_add_action()      ...(4)
> 
> task 2:
> cxl_dpa_free()
>   guard()
>   if (!cxled->dpa_res)   ...(2) pass, due to (1)
>     return 0;
>   devm_cxl_dpa_release()
>     devm_remove_action()  ...(3) warning, no action is added yet
> 
> Warning log:
> 
> WARNING: ./include/linux/device/devres.h:160 at devm_remove_action include/linux/device/devres.h:160 [inline], CPU#0: syz.1.6464/25993
> WARNING: ./include/linux/device/devres.h:160 at devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline], CPU#0: syz.1.6464/25993
> WARNING: ./include/linux/device/devres.h:160 at cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572, CPU#0: syz.1.6464/25993
> Modules linked in:
> CPU: 0 UID: 0 PID: 25993 Comm: syz.1.6464 Not tainted 6.19.0-g15a37b05f387 #10 PREEMPT(lazy)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> RIP: 0010:devm_remove_action include/linux/device/devres.h:160 [inline]
> RIP: 0010:devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline]
> RIP: 0010:cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572
> Code: 01 31 ff 41 89 c4 89 c6 e8 a9 91 1d fe 45 85 e4 0f 85 55 ff ff ff e8 4b 96 1d fe 90 0f 0b 90 e9 47 ff ff ff e8 3d 96 1d fe 90 <0f> 0b 90 e9 63 ff ff ff bb f0 ff ff ff e9 68 ff ff ff 48 c7 c7 f4
> RSP: 0018:ffff888129f77bb8 EFLAGS: 00010282
> RAX: 00000000000000f3 RBX: ffff888102f64000 RCX: ffffffff837301d3
> RDX: 0000000000080000 RSI: ffffc90001c5a000 RDI: 0000000000000005
> RBP: 00000000fffffffe R08: 0000000000000001 R09: ffff888123f98000
> R10: 00000000fffffffe R11: 0000000000000000 R12: 0000000000000001
> R13: ffff888102f64040 R14: dffffc0000000000 R15: ffff888102f64000
> FS:  00007fae0488d6c0(0000) GS:ffff88827086d000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000012f7d6003 CR4: 0000000000770ef0
> PKRU: 80000000
> Call Trace:
>  <TASK>
>  dpa_size_store+0xfb/0x230 drivers/cxl/core/port.c:269
>  dev_attr_store+0x58/0x80 drivers/base/core.c:2437
>  sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
>  kernfs_fop_write_iter+0x3d6/0x5d0 fs/kernfs/file.c:352
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x68e/0x1050 fs/read_write.c:688
>  ksys_write+0x12a/0x250 fs/read_write.c:740
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fae0399c669
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fae0488d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fae03c15fa0 RCX: 00007fae0399c669
> RDX: 000000000000000a RSI: 00002000000001c0 RDI: 0000000000000009
> RBP: 00007fae03a32c71 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fae03c16038 R14: 00007fae03c15fa0 R15: 00007ffe53519fb8
>  </TASK>
> irq event stamp: 1021
> hardirqs last  enabled at (1029): [<ffffffffb7d04c4b>] __up_console_sem+0x7b/0x90 kernel/printk/printk.c:347
> hardirqs last disabled at (1038): [<ffffffffb7d04c30>] __up_console_sem+0x60/0x90 kernel/printk/printk.c:345
> softirqs last  enabled at (1016): [<ffffffffb7b73b93>] __do_softirq kernel/softirq.c:656 [inline]
> softirqs last  enabled at (1016): [<ffffffffb7b73b93>] invoke_softirq kernel/softirq.c:496 [inline]
> softirqs last  enabled at (1016): [<ffffffffb7b73b93>] __irq_exit_rcu+0xb3/0xe0 kernel/softirq.c:723
> softirqs last disabled at (1005): [<ffffffffb7b73b93>] __do_softirq kernel/softirq.c:656 [inline]
> softirqs last disabled at (1005): [<ffffffffb7b73b93>] invoke_softirq kernel/softirq.c:496 [inline]
> softirqs last disabled at (1005): [<ffffffffb7b73b93>] __irq_exit_rcu+0xb3/0xe0 kernel/softirq.c:723
> 
> Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
> Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>

Good find!

However I am not a fan of the fact that this duplicates this subtle
dance in multiple places. It looks like we can just make it by the case
that __cxl_dpa_reserve() establishes the remove action before returning.

> @@ -679,11 +686,28 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	int rc;
>  
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
>  	rc = __cxl_dpa_alloc(cxled, size);
>  	if (rc)
>  		return rc;
>  
> -	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> +	/*
> +	 * Add the devres action while still holding cxl_rwsem.dpa to prevent
> +	 * a race with cxl_dpa_free(). Without this, a concurrent cxl_dpa_free()
> +	 * can observe dpa_res set (by __cxl_dpa_reserve()) and attempt
> +	 * devm_remove_action() before devm_add_action() has been called,
> +	 * triggering a WARN_ON in devm_remove_action().
> +	 * Also, devm_add_action_or_reset() cannot be used here because
> +	 * cxl_dpa_release() tries to hold the dpa lock that is already held,
> +	 * causing a self deadlock.
> +	 */

Also, I agree with Alison, this is good detail, but way too much detail
to carry around permanently in the source directly.
