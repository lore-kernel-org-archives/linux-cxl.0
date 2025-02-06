Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318013C809;
	Thu,  6 Feb 2025 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863348; cv=fail; b=ND6F6CXaZx5WytuXL356Kr5R+Iz1I3rge7tuz0+yCFHGTGQjmfYu7wGUkLi8drA5OY2fWGnkUZR/TYfjCrmM44F3KmjJLOxqcTn4zAE16Hj4xqUTnuFaKrWZ5JLR8oKGVJs4SY3lpQbgHdTwHrh08IG6fsQFqo/8dET5aX7Dlgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863348; c=relaxed/simple;
	bh=UieiaSQDyXMVnolWzaB7pQ773zbTYKkJy55Q80V/gOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VFN9ZEs5xFiIbwabSX4p04tISYMpUBSFLJrGfw/Ir0tFKiX28vq17oMR52zkCFFbUGhHkt4hdIr6iJgSSTctKZz0+sKwwDMymX/Y0EztZDKyKVTsBvjj3UMe7MkbtE64Gx1bcBzPVGOcZUqg81WhwvOaH8RfYPDRN0p4kPGbxw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2r+P6cH; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2r+P6cH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738863347; x=1770399347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UieiaSQDyXMVnolWzaB7pQ773zbTYKkJy55Q80V/gOw=;
  b=A2r+P6cHPpuVO2DfjqBNyrZF8C47rCLq4121TiCJn6ekmmDNGKge/8ay
   +rFTBmb/r9qVyxBw/IFgeIcgeMgO95EoyMKhusEOV5utRJW+kVmb1aSCk
   AU0AuszyVyqINJ7EediMA77cX7GfjtdXp8IHBm41/E0JMe8FA+wguR9uS
   dqq8KVV5HWkgiekz88jkLzhkBKksT2qwcdH6QmmmOaPu+JuLjV5VosYn7
   P9x54xi/9Vgb2fra/k0rvFDjsyxlLppzk6bD4Uuypj3GWv4+D9EXoymjd
   5BElszRwz3KWihDuFymh3SWZWQpBLsXK39vung5GY4+b+JNN62dF5lH0n
   A==;
X-CSE-ConnectionGUID: Qz5MNYFXQF++yq5yfqKXaA==
X-CSE-MsgGUID: oN49r7IJQ+6x6Bj2iZICRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50119085"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="50119085"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 09:35:46 -0800
X-CSE-ConnectionGUID: xAPOuejNTtyHqmNjNOBojw==
X-CSE-MsgGUID: mbena0ySQPetkn/P2liCew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116470489"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 09:35:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 09:35:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 09:35:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 09:35:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cI6rekv+7pFtzuSql9PV/PKYcccZISANaCsx1ofwwhGrjTzleJ2wHm0N6cHnIRHeZK8m3TI3WIK2WEY5WjMAGb25NvXyFjz0HnyLOgTQjvxaRExtzOgojjXXMbhGIkugX9D2YkFhprX4GndyGwtvJmPQvdUXv2yGyjSY6SnbqKpxjtcwUly6y89OQmvDmNtmzpsloB87kpnt4JZcw5AMhX0OSIcPi8PV262AMtDOfCDhJUylLo3+aGZDqGHcnLHEg7iOTFbfbNp5wNR3sh2BQKHSKWaqAE5TWeagCwIeMTo6UdgAvxlFbSbLngpKbF8CNJtveMYEXvxmGshPe/Vr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H/XiUNIbnBomRAipNaIuBNrttA0K8kURn+FGF0Ruvs=;
 b=ILryWUCv6neja3UdTh/Fa51wQkqJmtPDNiQRIxfvyxRYDz+TWwwafk4C7g6r9/f724Hpl3uUzId+pnU626AUnlJj4f3+/6Wpo5LuMyxEmTGpdOYJ8eCpHknj9EzFJx6O9Pph94NVCPA4CdUwpSvLj+U4MnglJKCJMgGff/cMj8r++swZT97GfmSHarFlNlNjzqNaekbRekZUa+x2+JqiH7AjB3LTQiyCjaos6yEIdBEh6cFTayYF3me1wIQR9evlk1WNgtiVcYtiVn+aQ3eJ8EEjqlneywRNxke75MTIH7Xuo0vv6Mel9Qj37UP4vnSwwPzl9Tz55BWO/O+RqHbFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV2PR11MB6071.namprd11.prod.outlook.com (2603:10b6:408:178::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 17:35:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Thu, 6 Feb 2025
 17:35:41 +0000
Date: Thu, 6 Feb 2025 11:35:26 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Andrew Kreimer <algonell@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, Andrew Kreimer <algonell@gmail.com>
Subject: Re: [PATCH] cxl: Fix typo in RC description
Message-ID: <67a4f2de14167_304a14294f@iweiny-mobl.notmuch>
References: <20250206090456.12298-1-algonell@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206090456.12298-1-algonell@gmail.com>
X-ClientProxiedBy: MW4PR04CA0319.namprd04.prod.outlook.com
 (2603:10b6:303:82::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV2PR11MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe34a1a-89b5-4a27-ada8-08dd46d4ada3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WViqmo8C8SPSpak4zXFYfr5QpwEigrmdRbj46LLvV3CKG3EQIUBbeGErLah6?=
 =?us-ascii?Q?XN0n0g9tdQ1qqQ18y+FAhnaBDPUgo6cW4O/gjqqXHa/WO/BZmG/toc0wFpuM?=
 =?us-ascii?Q?G6n6CbBifx48Ite4v5si4PnRDpZscNUUng6pv1ht317oJg7DJzd5xbxm0/4P?=
 =?us-ascii?Q?i6EN/hXYpfbQO3xovQFtJAhSXCmX1YQBwaKOTXgbOmqRstJuTy76tHa9oKOy?=
 =?us-ascii?Q?sDCVL0r1HVOT8eWi/Ec+sIchgdmH5VYbm3ks7Mko4OiJQFDBk8562nxqP5fj?=
 =?us-ascii?Q?fenx3S9Fk+cduO/14F0j7HgvC0LahCDvbpGcUKdDuOp+fFaMqlVyhN5d0Hzd?=
 =?us-ascii?Q?yAiuwV/oHdJq6HdEG7DFw//Ki9W+Agxhgtuog3GVTHTCdKH69EZU5geIOrKB?=
 =?us-ascii?Q?8RQPs4WhtSZEoVPNkYom0lH2blF9blcl42yU1hUNSC8IfAJum2MztBl5NAEg?=
 =?us-ascii?Q?PgRc8Oh5Aa+prCvngeyarHc2r0dyRSDgvqpsXy3IsUGle09w7Hd8Yk13suaI?=
 =?us-ascii?Q?5RkLE94FFVhNjXkzLUvrcLuQcm565t2E2FvWRwK3oG+MSdHkoIV22s6QS6nJ?=
 =?us-ascii?Q?MgeXiIPOkeEzXy2UqYEz7VMR9vYG4ZU97t3todbGRcx6++H6WSEAlqFzZQ0V?=
 =?us-ascii?Q?En6quvt6ZRk4yYtPxQAW3vYPAXvRmeg7I3YIgKtLIGGr5967F+D1HuuqMQUe?=
 =?us-ascii?Q?XSdoa601CCZaseyG/hCAJE1A31+cMLqNogTWbWWuagkLCeoYQEgP8Ql2tTCq?=
 =?us-ascii?Q?LA8RwZuD4VzLgjq0gxL7qvTkIq8hVdmflyFOWbZp+wbZoJZ1vbAXKGQDKWi1?=
 =?us-ascii?Q?JtnNM9tkzgEpnelKMl4gNKYOqmuSb/mvVv4mpjEHy2mbZeCgJ57wu6SAnwDC?=
 =?us-ascii?Q?UBWytG2mqROOYVjy6iJprzRbASKUOjXR0gWOm6GNh9ITeavQaykh/uH8TE9k?=
 =?us-ascii?Q?e3CvHMo4fcrO6432pKUct0v6nUHVWgY92Bb875Wiyumt5RJhWiCsGo4e0x2M?=
 =?us-ascii?Q?3lGboJZqlCp3zCaMDQL2HSv554BQKYgP8ceAVVNzI+TEV7gPGnAmrN31xoMz?=
 =?us-ascii?Q?elwqsey8XfND0XPpiLHnrwN3L+28oeZpj0Ca4jjL+ZPRmfUMWES+9/Kr+Wtb?=
 =?us-ascii?Q?ak625SWLWT+aI3sbqEeisHwJh68iMjBXvTjXqKKpmX6bDj5ukI1Ny76Kt+DD?=
 =?us-ascii?Q?qcW5gC1GxaMngsCmwKmjPH49TzqcrYqcB8PudPWs+myIFhiKwOIg+SN8RLvD?=
 =?us-ascii?Q?T0l7j2F+bHv6PX4HpOXgpGwi6JEm2ezMTxfxWJtp3/7ztLL73Ykju8SiCxLj?=
 =?us-ascii?Q?910Jkj95/hyLc/UCvv07KgEsIw02Rh4EooMgdJvlK/RSmOXLTq/BohYEgE0E?=
 =?us-ascii?Q?mqg2qzbnPaFraWv3+EaZm9lSZFjm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0LXN2LJ9hvdRvndXKzWtI3j+inlMX6mFayswakvqlv+BXnQiGJcla6ByO2xA?=
 =?us-ascii?Q?x1PJI/AtdyPZ0yEGFCDP1oRb7c1uybZxA7wBaj6t6JOzEzk52WMQ2cUUe8MI?=
 =?us-ascii?Q?86pnOo29yB4RC4AKyRQWXrCuQcwIbKwIAuQAfwHJxsh8KOGlX1KlrJhVVsG+?=
 =?us-ascii?Q?yAlLEN2vb7DvMsGme6YE58B9R3lKw8U6jCWo9EJ4Lr3D4VkM1OVEqFO/6guU?=
 =?us-ascii?Q?Iu5HxScQgSWBSvqITw+Bzx1F9E++A5ekgKZ3UFi2PV+z2Pp6IQ2AfMdsBW94?=
 =?us-ascii?Q?35jhFf7i/KSUZeDpZOAMo3lmoH32/UhtSle08eVK8OQnhcLcwhYSViUfMecw?=
 =?us-ascii?Q?WSrClxQDKDdbLH9CFy2iTLNV72M1HCIhA1zpuE9rjXfmIY/m02PmVBjtN6l5?=
 =?us-ascii?Q?Jn1VarKSs3lcqWemw+0lVTmHcpWBUe0NdEWJEcSdRjmlTB3WTHy/Gvs6iN0H?=
 =?us-ascii?Q?n8exbL77cJateoRrHsN3hZcfWtcKgQWvmRIO4EcqdQj5uMQ97uTgWKxAqLct?=
 =?us-ascii?Q?kSaXX+GX0YkSco1yWJLIZ5X8u3AFg1m8IwbGvLc+cWqA4IL3y4OcOVpX6Wrw?=
 =?us-ascii?Q?QMdgVDpRm+Q0ZJpekXUVMR4jjh9sV2dIdRA/buqKVwG72DVFnLf5SzeSaJEb?=
 =?us-ascii?Q?+mjL+lAY4Vxq0qpk5do7iIGRh/dBbdMMHKvJNxdwU3CWapSqQrDhQns+U7WE?=
 =?us-ascii?Q?lFKZuZYv2F0En+W7RVZrgeJUEN/3gssMnb79AhQbAhUkjmwJs6ivU9BdBU1W?=
 =?us-ascii?Q?wgEmJlynUnOnCrXPbU9eOAjmRnJZUGpcmXfNSOKRM25bCRJV1Ax3Cg3XSrjv?=
 =?us-ascii?Q?AA/4xOXF8hDxHS/ABJiTmWTQssJf2pbirBIhA0Ehobz3Y1njf57EyF9k+D0N?=
 =?us-ascii?Q?W1eUQfuEH/cKZy203yxYZMjdeqv7p/Al6tkpLSDez13alAskrLcGaDnCFO6M?=
 =?us-ascii?Q?xgbxuKfnXDp+yyzmesaHNKp5oe0WZ7pkhSaQptuKHPcS3bmGb9vukaVrs88C?=
 =?us-ascii?Q?trrGeH6Bay+a6UQ0hTv2hE4tzpI/awnEbkLarbcDrE9no9QOaGzgOJaP42/r?=
 =?us-ascii?Q?G/AxnQdHNiVEv+L4C95hMSINChqactqQlqDJporYhwn8ekQbw9XRzTgHPjP4?=
 =?us-ascii?Q?PbUAA2srOe24HEmckcWluT4Yb7mi0GazlEunFJonJbdn+DjfmOH/5QHyDISv?=
 =?us-ascii?Q?VCmRk7hhY+33JgB/dZv3Pbny/WMtFkzIPO914DIuJ4xlBuFLHiNZD5v6vHRw?=
 =?us-ascii?Q?B9ewaPlg64KtY/K84kD9Z5xv7V+adgAZ/DPEOVadK/grL/gGoOFsjfgBZ8Y1?=
 =?us-ascii?Q?dWySyv0VYb/r6wLkuIKdW/NqAI0/tlrw/b6KRnq/jc4aAjgUO+48P3nvX8w6?=
 =?us-ascii?Q?sBARDlxWJAO3gQCJwI8Ba8fF2c6nym7l5xM3jU8rcTsk70PEHEYhvkzHB+8m?=
 =?us-ascii?Q?nxn3mNeHQff2EzpcyMWdeGt61edqhc/9xt0Ux2cVPBK6swnAe21ztfxG0YFy?=
 =?us-ascii?Q?xIuhVp/ngWLUqjfGfwBxaq6oqvSm14we2RKwFK9GaHnRLP+JUoCS2d0zeYNc?=
 =?us-ascii?Q?vNvu0NG/3WNa7dseh7AOvzxc/ZY0KfCqm1IPqY+9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe34a1a-89b5-4a27-ada8-08dd46d4ada3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:35:41.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvO6HUwbWEQ49FW+5LjsHSVSNmTNsAg5jPnGlhoS2Geg3LP2SKNTRsvUi6z4DmC473FMnm8OkMf4M/eK1k1kZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6071
X-OriginatorOrg: intel.com

Andrew Kreimer wrote:
> There is a typo in one of the RC descriptions:
>  - occured -> occurred
> 
> Fix it via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
