Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792BB28E57E
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142366; cv=fail; b=qMQVreK+CecGx2TylZVIe2kHXatsAovpCoWdV99bnqLj5NbZrxgXbYzBL31HyQVIQ/q1LlSBm8/MmxH9kJEJWkLcpkn+lQOmpV2I8F6q1Of8zHkyzacDwdNlL5OigzZpjx8YglHt5mBRFmUFvRRlwReBYQxmSGK19l9C3g+aosg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142366; c=relaxed/simple;
	bh=T3gap/EO0dpEgmEzjEbU4GMJRC7jKGgwEEZmk50GbvY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y5D5Jbjh/snGh4Hcy+dIhDNSz/9pjqaVUqyvQNe89/p46xX/GZuHm1/mkEddJMr01ZeQ2jlOFjnknb67oMlJgEIQQxLyhR3OUDM+PhN3uuiemBLhLjCcJ/aIXODQLr9nyTbdtRq2lydL19nG82NrUj9yNxEtAfk/oxRneehPyJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6NoS3Ph; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6NoS3Ph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747142365; x=1778678365;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T3gap/EO0dpEgmEzjEbU4GMJRC7jKGgwEEZmk50GbvY=;
  b=f6NoS3PheXnePcTveXuAtHi3Oy6yJxG8E38u1VA7NpCmVDEkGKFokAxi
   ZJop9yeLaTUm5VVziriNHGbZx4Dd97eXdD2rG+DqQKtc9a3PDUJgSG/+O
   km2iwDgYpSBeRo0HkeItRK+dGYo0jW3kzUxltAkiYDitCZVxQ43NBWc9M
   uHhytinuX7KOTQMQwb4gghzP8rRs4tqOeoq4YB3oJrATx2Z56csxy2THZ
   HuJQiPJwlEy64XYK47VMo5zh+uO8BEApZBSy5XteZTwMge6ZQ3dKaagMh
   F5RrUOwciSJGX/DqeAsS3YNwXjiKCSndavpHs7aHKSugnpNLp1BStNgWI
   Q==;
X-CSE-ConnectionGUID: MYL+Jo+xR12Ns2MWMnJlqA==
X-CSE-MsgGUID: 2vHr29F7SJOIdEiLw5QGHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49132919"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="49132919"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 06:19:24 -0700
X-CSE-ConnectionGUID: F4UhQHrlTNudeFpmvMqBrg==
X-CSE-MsgGUID: ywKTWvq/SfeMzWMOWjiMXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="138219534"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 06:19:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 06:19:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 06:19:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 06:19:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE/jB1CQ3nzuQIE/ScoTZ141VYBwUkLw1dCeaJhsU3dRqQH46+hoIEk6poiKYDZwzb2wvS8R1iY3u1ziYsR++sPYahzLI7o8T6bBdBe8fpH7wOvunJl8U4IhIT2LG/UDhZuUavIJWoemrk3AEABU8gqWcl3bdYUTg5ZM9Tl1tXDT2B7ZaQs790UYVi9hPyeU3SNDsk5mbvIqoDHKyDoQM+ktZyCr8Z93jl7V+x/RIIyl9BFOVKQdtGAZgS+pt0NJiTMpM7fQDV7TykhdE5wmiIoJ/55l/FTW47vNtZpSaomoUjAkXBxlAhhDysAilqJIkYkM3nBoTMFuZH2dmgCfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smQyTEr06cFqQPy1+956Jrb0SP8SkWOXuLR+onD/Gjc=;
 b=O0ZP+r7RpZ7/6xcvgbJ5FpD6ebtF9wO29riJftvE3/caOAtda8ppU4jom2xpt55tQjxY7uu/HeMVsWc9j8dM4Zr4lrzXNscu11Z3r+TT05hgjH2ssAGlMUc4dSRHyrNSiOfgkes1zNgLTLXNOBfpiIR8H7Y5o/gZY6oM3XKv+2vLrf6FNm2WZddzxikU2U/K34TfL8Hr/3flD1iIUtpdIDMpJIRGJBBcfiwqckYw8SYHtPM9fUUNtiWX5DX7i1fZQSvun7JSn8eLwwE9S9TcvYLMJIsbTu4636gcgkcnGwg9ljne3TmeUpXwTkVNi+KpqREcAvvLg2urrdixEVzkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4946.namprd11.prod.outlook.com (2603:10b6:303:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 13:19:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 13:19:21 +0000
Date: Tue, 13 May 2025 08:20:11 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Sync up the driver-api/cxl documentation
Message-ID: <6823470b675cb_3282dd29442@iweiny-mobl.notmuch>
References: <20250512235818.1396979-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250512235818.1396979-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:303:b4::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e78f656-b0c8-4cff-ece7-08dd9220c593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r1XdYpoT2YCrA4ysSbdw5jd+8cAdsqkHCPghuniLHgJw1KjO6OxF+8pRqcw8?=
 =?us-ascii?Q?/dWhq2H3MzdP/FeR4AZS80QgJPhRJ7lAd0ovnrEej3S4fzthFKsAbY5tQ/y2?=
 =?us-ascii?Q?fEBL9hE2c7IGoMTeeI7HLa7pS/Xj4OXR6EWu4KQLoPywzBTYRRxlJbhKTJLu?=
 =?us-ascii?Q?T6SXNtJhRx02TLSr3pJcMi6qOPI+h5nJWVxXGzVpqdHBmdT4dtRQ/nFpoNyp?=
 =?us-ascii?Q?WIFQGcve/KpvWbVXNALniRfTF09ohwVXsF3b3ljSWXyn0hx+b00nV8mqxWlf?=
 =?us-ascii?Q?DRayF3jDWfLFZFj2VWwTaLVcjXvr7Q3QNcXck99gg+arfaQ8R2waQ+94Alp6?=
 =?us-ascii?Q?zREUeTuAliKx8zPz10oxFuWL5p3jTBDVmQqB1CMTwutDnf/7n1VP3zinJ4w3?=
 =?us-ascii?Q?wJpcDvB0kds+oLAD8Ph+dR1aDEa3enFgKKYQS4u94gW3Xqg4A4dbloNx+ZoX?=
 =?us-ascii?Q?FItpRe/ZYhtiARpYhfSKC8Nwk5vBeZPwhYRzDd/d2/tOXjFm4Ls1zzr09Pk/?=
 =?us-ascii?Q?vteOUPulMCylto0hKx6s4MFnR2Xw9MNZEMOf6ZyaRlPpNeoDs3U2R/lJu6O+?=
 =?us-ascii?Q?aWM58ARtkelHQiZENE7Tfx+jFjKXvw2I2wUBY9lN9h06mYZf5HsX43VOfbeI?=
 =?us-ascii?Q?rDjOSNBDnlarc+24kqjIR8rOkiLK1zc/mxmN6JrxrjMxV23cU5C6l/aTBn1m?=
 =?us-ascii?Q?2bmIdN2IkB0fIQxS/UBgua+i/SiqP5ygwUmHW/q3AQvkYJuIgQb4daMZERmX?=
 =?us-ascii?Q?r38uk6VicPGMhEKLiKtgprasKyttMlynC+myrbfZc4mSifBRFqqjO75opt5C?=
 =?us-ascii?Q?LKbx4w0i4H0LBDyIwbbIO4zad1B32YRenkbfwXUussO2+3PICb4sen2+7Fu3?=
 =?us-ascii?Q?P3gCoSIHI8eN2saB7FFksdjGo56/5AYJ+XaDOZZLghKJmfmCk5zmSFArFHz2?=
 =?us-ascii?Q?yGCktAdWx5heQKNOSfY/kENw5iS9DdjB/Ga2q1nQ6Ssn8+RXAfrVQd955mmj?=
 =?us-ascii?Q?iqCr+Ft0xyV4G0RvzaadhPR/Lg75lW8q5XDxjA9sQ49g7abwhzpHN7eZhhth?=
 =?us-ascii?Q?qNd1r4r9qkggfiI/Mf0rIIJeB1HqLV31Bq6jRZMB0ES8ZR9sAEMJA0yHIzRG?=
 =?us-ascii?Q?Ub8tRUW/l89S+jUgXkNANdVcD/9Cak1TLB2h1iQIU8UvQGdKqngZzcv7mvF5?=
 =?us-ascii?Q?NWk8FpqcKxlALqsna7c6fv3a1zlAOYUpMpa5Psw+CJypXbtw9bz1r+AA04++?=
 =?us-ascii?Q?d20zyUzT7fadnckvdWUk/PuNOXQKApH9PQdHvXvKPmtNmoa01Kt2dvgKsulN?=
 =?us-ascii?Q?tm2flyEhBod0HSAUTULDQN8de6otC1yZi73a3EoznvXcnG1NZ185v+dNE8bN?=
 =?us-ascii?Q?HzQmL/c932pCG9ZOrhDlk6qmPCIytDORyUWw4yjWdMGV9WYRkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v5gvbARRiQglNWbYw2WjV8V1RwSYFEzT6lWH0KTsqBA1zEn4FmpBEUWv+cIx?=
 =?us-ascii?Q?vmqAA+PTa01Yk/4pW8jwCJY540d+Kx+OruNo2NH604W35NpjL8d0aSOLwfxI?=
 =?us-ascii?Q?Bp6k/mxX+ON+PUUa2NLVGkj7ShvrmkcIG9EfamORIhT6M2KfqPTueSC2aovO?=
 =?us-ascii?Q?yT5J7cRIJASEoDeS0uCEiuIPKTh+t5946Msb10/ufBpXgaKe/TmoA8WKs/Tv?=
 =?us-ascii?Q?1s3cMgvPDjfEGYZOhK8mYlT2aCr8zg+fa0x8AUIRq4UbAcM6EFjVReByTNw3?=
 =?us-ascii?Q?BkpK8SNwEQ7HQ0AIx5gn2PHLglpWBQLSVncwiB9nfK0Ij2aMiG/kwL12dQc/?=
 =?us-ascii?Q?eCd96EvXxwe0ARJ3M3C3sDrPWp0lFV3T/MVyMl6k/bKv5pLfM4WB/n2sPQsg?=
 =?us-ascii?Q?UfMwq8htkuRkoXLCk0ELKKecmXWJeQUtbLqugbTkJZL9HoeakkwEC2IIqlce?=
 =?us-ascii?Q?4qeuUFNxGLkTgb+FHjfPXsgOwGBzYdjdXy9c4G6m2aXVZH5k8CcsyynvQ79p?=
 =?us-ascii?Q?IHOzibNvE837fSqW4ydzVu3LT/OLcYIEZT2VY3UG+46QuncfKk9bJovHQt2f?=
 =?us-ascii?Q?rxdwEY52htroBv1eBGQm2qKzqeEWPC+wfe9H32wbsuqxaRnbW3zyjuPMh33x?=
 =?us-ascii?Q?GakLylegAD4elPAjv/JIEi4z2CqsIpXOZEC/JiWvHmZTGfhhlkkMCXsqxDrf?=
 =?us-ascii?Q?+eDjcMQ09UCuXdDOBJrNCKGKycopQhASaNSRl4d4oTxG1Yvz/3B2525xUn12?=
 =?us-ascii?Q?cU4kuco183j8OrWZRpawaGtUfzxYsGYPbPky9be3SWbOrrLtoOXxCiUWVBAx?=
 =?us-ascii?Q?19q8C8oi4NCeXIqJd9ko6g6AkhX7pF4rjCD+t4GCe+JiAuvX3kE5d4XcBEGC?=
 =?us-ascii?Q?ymszI4BMLuxIJsi4I+XNmU/a4qVJZQEXJr5LP5NFOJz9lLaR1anN2AoRfX3I?=
 =?us-ascii?Q?cSOPRukHLAvCsDWLcWUTlxio0iAdKYojxI+p45FJtgfyz/iPrkpcq6WZ426S?=
 =?us-ascii?Q?9AzBYKKWxnZDxHGkiCMJnBBEDYMlR0t0GVrHRVg753c5IUR9Ir8Kbuu/Y0/J?=
 =?us-ascii?Q?c0cy5+eW9UL8uW/+fC9TNXTdGkAIPm6gbfSC3ofxmmkosxyMKhS09kYsU8ko?=
 =?us-ascii?Q?hR+SUcMzroiAvptXhtHUzhNO1ja4CJ1wj456Uw6lcQTJq4lAR4hfeYgHnHp/?=
 =?us-ascii?Q?YGbl7seWma19+03KklU+RmuDQNRIWeKiEGktuTo2/iv/Y+zrcu8O+isxhB0I?=
 =?us-ascii?Q?2ATDfS7wtHteUX5ZxQflUcy8sV57+ajGLxyfXSiU7R5cHlcfZ23FUWN5lUVe?=
 =?us-ascii?Q?sTojcVEtF3bLWfBXIJhC9ofDFju49E/WnH99qH+FFAriDdJ+oq+TPmw/EJMg?=
 =?us-ascii?Q?vpXFPSJS7vftEpna7roXP2PyR5ekVeVMLEYLrsmaAkjv9/kWP56PvFERUJ2j?=
 =?us-ascii?Q?GU15a1hc+CxfIuFQR7D0T+GzBwWWitAEIrCKD02TjT//3CM2xquw7f4xOA1e?=
 =?us-ascii?Q?dCm2VevzcF7zxdl6TkBmSY0RQfBV2SOHDpHft7OMvU92wiTndTjzwVFYFdsu?=
 =?us-ascii?Q?sUtMWqD67FF5gqoyocXam9WIE76r/TnXHozyx3ss?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e78f656-b0c8-4cff-ece7-08dd9220c593
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 13:19:20.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSAmrr0+k6ejFvyZDXA1UN+IoX4r+dzcaIkwktJsZ0b4yR2R+/Tw90ueJVPkFx8LScMaHqABZUG8QuDLPWZTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4946
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> pmem.c regs.c mbox.c identifiers were missing. Add them to
> memory-devices.rst following their respective DOC comment includes.
> 
> Two acpi.c identifiers were available, but not used in kernel-doc's:
> 1) Add add_cxl_resources to memory-devices.rst and fix up the Sphinx
> complaint on the ascii art (escape and indent the pipes).
> 2) Add cxl_acpi_evaluate_qtg_dsm to access-coordinates.rst.
> 
> core/features.c is newish. Add a "DOC: cxl features" comment to the
> source and the doc and identifiers to memory_devices.rst.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

With coordination with Gregory.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
