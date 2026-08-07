Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265732853E0
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146657; cv=fail; b=PT1AScPQuJSfPFLFszlWcaDl90B0fHhmayKVHmECqp9KW39abvtNFnTc+/rTGoK9Ns6bsu3B1Y9Fm/zziP2JeI3vaWnx5gYN9filrkRpB6Vic7tzkaUxNiZBBdouOV9d11ylVkwedEU9rbaTf1rI2az6ZKtT+8LzNT5pO0vDuAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146657; c=relaxed/simple;
	bh=5L+EfViVrxvDP/xMr0bYN7NE5qffoLqakxj8n2Psey0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EdF4/oSOD+6hx3xX/8X/UJ02GoLtWEz9G+LR5ncKkGt3MSUDKgjdtpYBVHcla1wdpmpV14S6Fwmj0v0V00g58OWtKusFiNHnin1mDKSHXKmi/r5+dcCyHlawaBFyKHXGmJAOc0IpmFnUi6WeXZf/jAy2M7TLjdAD2XbMRDNH8sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAMbCh9l; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAMbCh9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786146655; x=1817682655;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5L+EfViVrxvDP/xMr0bYN7NE5qffoLqakxj8n2Psey0=;
  b=IAMbCh9lIwyZGNo8w97Oq1hVfOr1pVJAUd7fr99YqqptDSh4IPE6RUnq
   M0v28/eSnA1yMrDoaX2KXvcqK/Rb/Yp7HncG1PlnwvpLyxGFR6q69Xro2
   CHHQEddHlK96g23PiU7XbnCULifT5Tw4DLdPcxzExkVdWQ0zwHXmyO2+a
   j48qSi5yMwr56J/RD8UP/+yQQDv+urFvLSzZxrUjfORBa57bsEAC4ULE6
   zXPju+JF0YFHtoaDbAXQtK0GOY1s/hQG56AQGfPtXMdaHpupU+C4lsFbS
   KoYDzNpn+KtgJbumDwwbcw5oAgMO08t648L3JfP1vtGSv2erSIrBSpXxz
   A==;
X-CSE-ConnectionGUID: HBimg+LpTMaqvH+nu2dKMg==
X-CSE-MsgGUID: qjy93fL8SnaLpRO+nCMb9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86969834"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="86969834"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:50:53 -0700
X-CSE-ConnectionGUID: MPI21jQVSbOHyqkW2Cy+UQ==
X-CSE-MsgGUID: huT7QhD8QD+fS9mAhx0l+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="261998934"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:50:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:50:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 16:50:53 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:50:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI0h8U3/uSHPLM7jp0z7hGtXNXxYTORztu+eStp5QBTlG9tKw5/wCXmuSoqc20TrHjfQCIXqpE46V8C+ONVB5nLoeIyM2+JF6Xkw57ugNIy3gq9ZRD2AcgZPGFq/H4jqWFJEgmPt6ZGFFgogjLJ8uIAbm3yuiH60Qs+8+/5JkXoiStWRYoeCTR7rbXQ0oxVBTsO85a4yklWGwusoXeQAYjEtCw17oChkcADgxQayWihdfL8hJAWv5CQ5d5wpRxrqkKOqacAN+uys5v8nvGeaJ1PSgrM/HwAzGWdQbK5D9nU0S9//tl7NpBcalbM5A2IFoVAptPdWdy+WwZBWLff+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLrazxjuD0P2m704egNlW7Bq3RYOy8b+Z9Hr9GsLgWw=;
 b=EJyASkvZ6Eu4tAbmVgsE1O8nWTo9yq97ceaiY8/OmS2cqx4bD00BD6cwRKEFuAiSvAIn4sVq4HiswlbPoVYJeMXmLQCbpLB/D8clkefy5MGrd0KFedaVdkf6lj+XQlWgHb5boz8SPyYvoSsBBiDMia6uwiAy92Hs3+VLa91idK7b61/mP/wSI/MrfnsWCUu5W+kuHfkOwAcYf0KR+AaksK5etJqtiU2m3O4/19UGXsRTg2Gv+MZTGNM16ABYtgKyDPOvWttfvupKyfNMcyEezW0yfAuZdYZ8iCuD6gnbVcJ/kUINe6NgulgZSZrXm9kpiDVARGGtDJEmczHpd+5Qaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DSSPR11MB9617.namprd11.prod.outlook.com (2603:10b6:8:375::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 23:50:51 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 23:50:51 +0000
Date: Fri, 7 Aug 2026 16:50:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <linux-cxl@vger.kernel.org>, Srirangan Madhavan <smadhavan@nvidia.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v4 2/4] cxl/hdm: Only interpret interleave settings on
 committed decoders
Message-ID: <anZvVw7C0EiQt0of@aschofie-mobl2.lan>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <48e04e2688a636d90b6e49f3e0c2dca78f773c4f.1784595445.git.alison.schofield@intel.com>
 <d7a9b8e0-8b70-4440-88c7-6ee5f33eec2a@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7a9b8e0-8b70-4440-88c7-6ee5f33eec2a@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DSSPR11MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0d6f16-1a24-4c32-804f-08def4deb60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Kctprj2NAOrVQMhVbabQhaGf3F5utsc+Jfe2GbOeAtEG5pNk4VhX5CkAPURbJI4vJADF4HboWdqUd170vbIfMZB21RlFyjcJXQDT6RlyW/JUW9h4pMKpbMxqMGajm1v6DUOEIr1XkSlr38PgFBfkrkNG+270opITN4zCT9VmeriIT5/qqzKb2lAX5IRbZiai96pEhucHXLfWhkRMVddaWVIq++bFJHL2rR0e3zbPFeavb3XxXS6WZOVECQWH7V3WVJ5xYOsmMGm570+DkxEi/uaF33hAQKnUhlX5WcE7tXuelu/RZcy/2RLq0PcEBvBcUe8pPUMV1BRVixhyjsNyPxWdohvpJxdnUiHrFZOacj0aoxxzSAb5NB/Q1v3lcRSdkCJWiyI8QfPyWRg1o0kPe+IUbXLRSiRGx09vqS4jhNv6pMzBxAvZ+3Bpee77bqTxegSDIXOUPjZ8Pt1VAKPjRa9fH9W9aK0EXP/k1GVZiw2ANUg1wkL0FOmurj8NWpPcYB7x9Spz29scFs8MlaWIVYtfARUDxPJIOUarzJrT69QOAInUAMaAv63qJeEGNxeQ0rhevs+fmgD43RRwMH7884UZol7MuJ6FqYRUzsH6FEKBi9UmsLiIclTSoc9IZo8sgFNNbGP3CE4nHAZ+SgI+IW/gYMwpncEEzJ2ETCYTn0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzZzcG5wQ0tIM013OWJTU2xCaVpKQ0JOMmpaZ3hnYWZzRTFNMkVhUmYrVHdX?=
 =?utf-8?B?bnZ0RmJpZE8xOG0rOVRUNE5sTnAvUnBVU2Q4bWgvT1E3Vlg4OFZwUmhNQWNt?=
 =?utf-8?B?TjJENDFJUFpBSC90UHRaQ2RweE1QVDFTUFQxRlRtWFRkSDg5dVVkWmlKLzhk?=
 =?utf-8?B?N0h3L1YxYi9zYUR1NkhVQitiTTF0RE9LYno2VjlSNHdyWDVxVnltaWt3YTlM?=
 =?utf-8?B?aWQrOFV0U2xXMGh3UHZVQjdXK2NNMXNVRmgyWDhNL3paUzVqQ1dZRDlBSndB?=
 =?utf-8?B?b2FvcmlNT0YrdE8zWFZxMmpHaUNhaFhMRm41ZkJoVmw5SkpqZ0VjVDlQanFr?=
 =?utf-8?B?Vm5JU2QvWW9OdUpIUHprelk4V0hOSU5XR3FGNzFWcll6eGFsVmRORS9mRVNr?=
 =?utf-8?B?SGNFOUV2Z0czTnNycFNHWCtEdytyMUloUmtNS0ZLeSsrbWRONXpDSStlSExa?=
 =?utf-8?B?STYrUGVOSjNxVjlLczRjU3lGTmZ6ci9kNVVJUG5UWm1yOGE3VTRHOUdZQ2pz?=
 =?utf-8?B?QWhLWVl6MUZWa1pqdHFCMHA5d05vSzgyN0s1MkRVZEpncnlRRTdqN3JPb05Z?=
 =?utf-8?B?RkdqQmZ2WVh1ZVp5VEYyNjdBYXl2c21TMmZPeU1jQzR1citmZ2c4aUZocmwr?=
 =?utf-8?B?Vk9xUm4wZ0dOT3FrSVkzZ2NSRW1Ca3FYWFVVa2pzZW5GV216Z3Q2L0lPTFZv?=
 =?utf-8?B?UEhVQW1vS2RjQjAyUkEyK21IZGVDNDAyWDBld1JSNEVDRWdwSWZuSlZMOTIr?=
 =?utf-8?B?VTVEZGNBUW81TGtkSDRxbzF4MUdENkRCMTRpTXRzK2J2YysxT1JRQlBWZFpZ?=
 =?utf-8?B?QWRSbXRSMk96SFdzbTNXdlI0SmlHVjZyYlBsTWFEQkVibVMrREJFSjNFVDlh?=
 =?utf-8?B?MmFSVHhwVXdDUnZlS2gvK1ZGWnlHbU4rVEp1YUErSGlhZm5HSkFKT0VaNlJl?=
 =?utf-8?B?OXZFYjM1d1NxUnBaVXVTcVQyR2k2Y0ZENnJUc1hqaTdrUW0yMTNJK3phSkp4?=
 =?utf-8?B?ZExCMEVJeThEcWx4RzVIUGxuSkh6bWtkVkMyTTdDd2ZRVVo1bWY0ZmZza1I3?=
 =?utf-8?B?QzQ0YW5vajAzcFBpSkRTeXFPZjhUd1NzdExDVzQwRy9qUVE4eEFDOVQzd2Nr?=
 =?utf-8?B?d1BvblJOaW56N2ZFZ3dqNGRnQU5XVG16V2dZam9nMkpCQVVQUzU2TmFrRzYv?=
 =?utf-8?B?TGsvM1RkcjNGVHcxLzlnZVpSVVRlcUpxS3VnN0JBSzBZcWYvVjRRQlUrekp0?=
 =?utf-8?B?bFVSUGtqcStFcG0yOVNKTTNTZXlGcWJqcmFkeU9mV3JqcDJUMk5EZmhCaTd5?=
 =?utf-8?B?azMrUjRFZ3FEMXJ1MEpROHo1OXRGNVpiUlMwOXlWSmphM293NGtNSnBwTFNE?=
 =?utf-8?B?Z05MVG9YMWp6OFl4c05uQllMNURzdlBlaWhNRmUvUkt0Zk8wWEd1TGFJZ3BW?=
 =?utf-8?B?WTMwWkV3VHpGajNwR0tFdHFOL3pLcHpRUmsxdGZEK0RPbHVhWlVPWnNNY3Rj?=
 =?utf-8?B?b0dqdUcrRklGdTlPNzRJRVg4SkV2N0dlam1XNlBoaGMzVlV5cGVDSWNjTGtL?=
 =?utf-8?B?K0NsaDlXaFl6OXNrc0xJbFk4d3pWQ0tQcUtUaG84dzRkOUMzbllGM1dxMFla?=
 =?utf-8?B?eEo5angxbjdMYU9WcThadzBWZlRBaWk3eTVlT1YvMzJoSXBUWDdqV2U1UGtS?=
 =?utf-8?B?bWhnTGdtRDZFTG4wb0oyZG90QUFHK01xbUlEVVFGbUo0V1ZjNzhxVVNuZm9X?=
 =?utf-8?B?Vlk0M3FwTzVObWgybWpoNDluMDhOaHhEVXdnT0JPd0lUT2VyZ2ZjZlVHRDVN?=
 =?utf-8?B?alJGQjlYWXNrQWFycFVFc1JkdUlHWkJUU1ZXSHEzZmRmN1Vuemk2dDNFTURh?=
 =?utf-8?B?WjdXalY0eU1Eb05oOCtja1FFRkxUOG5kN3hxRThTVkh2RHdtaUQ3aEtneXov?=
 =?utf-8?B?NDF6a1pXQkZGVDdZVFpNazIyMkU0cjRVZkFNcU9kQ0NFMWh2QUg0UVFHbndH?=
 =?utf-8?B?dlpvL2pnQ24wUGZnYzdOckpURHdYTy90WkhwdEg4cm15b2d4ZWJQZ3dzQkk5?=
 =?utf-8?B?OFlMcmRyR3p3TmoraUlocUJrelk4LzNMcVBnNTIvYmR2Y0M5ZXZ1NEQxSG13?=
 =?utf-8?B?VzNMVUg5WStjb00yR2V3ZWRER2FBR2R0RFN5cyt2SUhLVUQ0QVJLRU4rOStv?=
 =?utf-8?B?S0tBSlBWYmN4WUZPQWNwdDJFTGNSODBIdUk3SHFnc0Nzd0dZRHNvYlg0NTFV?=
 =?utf-8?B?VjlkUkg2MXg0OVl5YW5BemRicFhFMG9IS0VyS3lEYU9kNStvUmhWK0ZZZkNh?=
 =?utf-8?B?b1pPVVNWTUJ3TWw1UFNnenI4Rm54WkxNQnhOMDlCeWh4SllSQ3NPa0FURXIz?=
 =?utf-8?Q?sPDWXKJdsNUHVnP8=3D?=
X-Exchange-RoutingPolicyChecked: MXIwHnQCgQURk7GhmI6CpaO6ZMjjWGJvXaWMCcFrLDwsKlAyN+QK0r5blsl8OAwIs1WyUBuf9RmNB7fmjc4GYrWtY3+iIV+30tJWt4iuLSOSgOHc7rHtfkbhlpbZJY/5F4KeYZgR8HtTIinVnFn89Ha/l4derS0SsI7jpnrcXzKlv1NyNTO4+loQhvhcoPJ/Q0cZcgWwkAHqw5G9+dddj3DyePsA0zuqzlNPdp8Rqn+MKW1xDhVtWcRRpJpR3tlsewYcXLJeNX2qhtDjf9sw1FJZT8sax69UplFfEnDGRohcoI42oVY1ivsVdxmYp7NDLitjISV8au5vIpy9f0C+sQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0d6f16-1a24-4c32-804f-08def4deb60c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 23:50:51.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dnrb5DEg8mD/wNOiRnIeZZmSeqkfxUa1/ypdnaEdiAhz3s9FTD/T0TriYyVee5UcHG42itK8Eyq30l4d4eKMzapB+X3pJcrXX++Tne3qVVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9617
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 02:26:57PM +0800, Li Ming wrote:
> 
> 在 2026/7/21 09:59, Alison Schofield 写道:
> > Decoder enumeration reads the interleave ways and granularity fields
> > from the CTRL register unconditionally, then decodes and validates
> > them for every decoder. On an uncommitted decoder these fields are
> > stale. They hold whatever was last latched and are reprogrammed when
> > the decoder is committed. Interpreting them serves no purpose, and
> > rejecting enumeration on a reserved encoding in those stale bits can
> > fail an otherwise usable decoder.
> > 
> > Decode and validate interleave ways and granularity only when the
> > decoder is committed. On an uncommitted decoder the stale register
> > values are not interpreted. The interleave fields are set when the
> > decoder is programmed at commit time.
> > 
> > 
> > Reported-by: Li Ming <ming.li@zohomail.com>
> > Closes: https://lore.kernel.org/all/171d58db-3555-4a79-a9f9-8a3c2e14d91d@zohomail.com/
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >   drivers/cxl/core/hdm.c | 33 ++++++++++++++++++---------------
> >   1 file changed, 18 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index d81df45d8005..1f995191baf5 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -1064,21 +1064,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >   			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> >   		}
> >   	}
> > -	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> > -			  &cxld->interleave_ways);
> > -	if (rc) {
> > -		dev_warn(&port->dev,
> > -			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> > -			 port->id, cxld->id, ctrl);
> > -		return rc;
> > -	}
> > -	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> > -				 &cxld->interleave_granularity);
> > -	if (rc) {
> > -		dev_warn(&port->dev,
> > -			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> > -			 port->id, cxld->id, ctrl);
> > -		return rc;
> > +	/* Interleave settings are only valid on a committed decoder */
> > +	if (committed) {
> > +		rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> > +				 &cxld->interleave_ways);
> > +		if (rc) {
> > +			dev_warn(&port->dev,
> > +				 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> > +				 port->id, cxld->id, ctrl);
> > +			return rc;
> > +		}
> > +		rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> > +					&cxld->interleave_granularity);
> > +		if (rc) {
> > +			dev_warn(&port->dev,
> > +				 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> > +				 port->id, cxld->id, ctrl);
> > +			return rc;
> > +		}
> 
> There is a "if (committed) {}" block before these changes, maybe we can
> combine them into one.
> 
> Besides, there is a piece of codes related to a committed decoder handling
> in the end of init_hdm_decoder(), maybe we should put all committed decoder
> handling codes into one "if {}" block?

Restructuring not needed now that I've dropped the patch in v5. (but
good ideas ;))

Your v3 ask led me to add this patch, but in hindsight, I should have
just answered your question and not jumped to a code change. The driver
didn't need the values but userspace does, so they are left untouched.

The hardening the series keeps is in the bounds instead: P1 rejects a
decoder whose interleave ways exceed its target count, and a new P4
bounds the walks of cxlsd->target[].

-- Alison
