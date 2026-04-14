Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BF17A2EA;
	Tue, 14 Apr 2026 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776141471; cv=fail; b=DTFX7Bw1UzDKeTGDWkT3eRT8Qx9owZZyVMwRRxJyTwXhXDWDtk4h0CaxptN8AN5+vEh/TJAZRtg2meTe+/jSZD5o4lNEiad27erBe8KusahTgNoCuOyfYFMjXDY2NExNihQZB+eNlHGEEYpwkV0g/muzDH6L2Cr9t0CqsSdbyoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776141471; c=relaxed/simple;
	bh=f2SU1OQSehHrrUOE7Q/OtYAojU8nrfDPDTShZNmQ/u0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klWtDJP7s4E2QnUThCUJqUA2XR4TrdA4SBMXXGW+DIKYYRuIXvEQsQBtRK8h4mnXnUsVcHAQv0cyqjOcUQRWLWczL1DdNwSqeN8ycMiZ0XgH/CbCcdfUUsgy8gL5eQzfn61EJMQxLYEQycklAvzMXVwrpMNckYXKRskM8dRCaN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIkhzqSK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIkhzqSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776141471; x=1807677471;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f2SU1OQSehHrrUOE7Q/OtYAojU8nrfDPDTShZNmQ/u0=;
  b=cIkhzqSKr/lELu6fcC1wdjDHucq1VpnvoH0PRp7zbC/+2GpUpxI5d3aK
   uGqMSt0iYqf8oDHCdNHDKFex+23XIgv3ndOBjO2MV20u6TBoJV+/BsP6P
   J6oDbyU+IV0kMPxnH1AH3Cv8GkOQEFqx07YJDLMkKauuJZd3bDhdNNdxz
   Znsnl4XxXhGUXfVU9oj2b93ix3Vh2e8wzmiBQ8YfROP7z//c8pC0Bc8IG
   ZD6OjSms7hBspO+CwUV2kp68V8zylJ7xxUSm4Lye5RxFjD5fBsDfVzIHC
   bjT8cPGK+rCUvUPazFmJqI6ZsILPrsvyB8zonyJ+0CUmHmHqMxKDuwApH
   A==;
X-CSE-ConnectionGUID: 8yi6IhjwTh2XDdDJxXyZ2w==
X-CSE-MsgGUID: kmK/0Vt8R1usoOd/uMrLfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76965780"
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="76965780"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 21:37:50 -0700
X-CSE-ConnectionGUID: Fy5vhrMCRH+i3l2uy8pb1Q==
X-CSE-MsgGUID: rJLQ/U6KScKh1Es3C1DRzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,178,1770624000"; 
   d="scan'208";a="229913025"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 21:37:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 21:37:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 21:37:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 21:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLZWPbg2DfqexF5xraw6YxSzeYNif/IxwquKciiQIVJfZgCzrKvoP8mHDNr2PI/B/whsvSWUwwLSSh+Xn8di76VodEqEFf8pEnDyNqw+zDL2eVerbci+ogxLIQ/TrNoRrWev8Vwk+DhCHFyVoS283xAY/xYVXjE1PSvDfSmSqhATFFoajWcdUAnEXHJVC8bHYBjKmF1cvnLmJQD1VkR8SiOiJEoViTm91tY1GYlYOr3EYdVeldtmYiAoB3NE46NLb0KbbxbK8jsUxUMC6O55/1Ma0FsxFuYdlvz9FKu/pBTrFZNrej5GhH5/eV03Vp9iIYVZJao3PBJz0CjjpVYzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkEKQByJ0B6kJcVzsb7v/e7VI+0Aac6ubRaJADdCQwo=;
 b=Q9x05bBYnd4uLWblf9Vlwh3QYxcrw+xLZ3raBAgWizF7Kr4Op5GPin7LSUEUHOFPUThsL1v4ADf7wD5tYZkEtQAKW07ndVL9R6gLuAuJx2ashfdbFv0PKk7Jjvp6DvQqiJRopbfjhENUDFgDIb0C6H/WpOBTQgrsC4RdXzGPwKG5xUnWOqYdmXf/MUY7r1YxB7TP89/zFnCauCAtQ4bK7fA6BGKJrN4fK2sfaj7rs+Oeb7UdDi8gQHZ0cFMgd1CAPRkdzJbIboaYkgbqgE1PP7ZTWE2gWfkPEtg2Ip72ZHXuNqmxOKZJclt5n+mRrMax61BvJFXcdhvNOGaQHdE49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 04:37:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 04:37:41 +0000
Date: Mon, 13 Apr 2026 21:37:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: KobaK <kobak@nvidia.com>
CC: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Validate partition index before array
 access
Message-ID: <ad3EjUssy1sLzrr9@aschofie-mobl2.lan>
References: <20260414024527.3399590-1-kobak@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260414024527.3399590-1-kobak@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN0PR11MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f1892b-db4b-465f-c75e-08de99df9047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QOxLB7uTGpnBS8NaTCeW+qxrTYQAWf9+plcSJZs5DkdctBYCR8HuPgNgQXpBnIBFRXU1LxFto5VLfe//DHof/QiiCADHEydfKmgsnjC7YVldT9SwHhGvCWzX1qbGEEDUDkGZvhH0ed21fFad/35XJmxXxpqQUD8jwF8E+bD9edfqTldEpi2fZMR4HT8sbnmVsmNNyCH11cNTgDtu5NQQIUNVcVz4NZUFtQ19RXLb2+TD/LHt4po8zt5pOLjZoRzuNaEmDWmX0kaqYZZExb9oWMnLXwgh1jWDjKWpUYWxMsaLPz6V10lshDD9udQznptIZ/qXSixh9g+/n2xhmPJtVCxbNFPdEGPGBM7nMMnN7/WKqm5DLAdcO52Vm2EhJmoL0oIG+ZnJn4is0sbhqSObu78C+mO1f0KRrMHwUuISDlZ5PMGNuK/FTZrlqYw2sYNcpkK7rVStnyhTNyeVHst+Nx79AigoWpkamC7I/q9C5eqcVx8KdijPitj5TdmJNFPl42HOebWJ8mK2qKtGMC+0QkHgZJLcCqGCvkbDFbKZRuf9kY7mM3KEyMqUReFzBwW1Jsi/Hnd4UarvyTsG498Se6VMgvBG/e0mGMlBHuiMowIHYSLdiaXZeWZBlFMf7zOavpeoZd0CvdNarn/iyezf6OHQMGkaJUI2VQI0y8SwUuepZmo2e/bjyEaynN+rW5iZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tWCdab2iHf/5HduWaDAUph8PLLxJLMkIlDZYC1sdz77UYDjSarplTPBKmZ5Z?=
 =?us-ascii?Q?7uiBG6QZkQ1Z3K1s2AmbrUP06zhcnhSTIHA60LIcTXiwhZYg7sxu3v2UO01d?=
 =?us-ascii?Q?wZMVAGq3s0QJ3osHsa6dSUZZAAtZ9Mfq4Dy+Qh7COu8RMiINfdd3WKjPePox?=
 =?us-ascii?Q?07GXYhbe1wWbicsJhafC2e1XYDOqhV3xW1d4fmS9o79zh0TNBG6+PHLccA+c?=
 =?us-ascii?Q?oyrveiRoES/qaPKjAUaCoTF9t9JiyfRIZaXYv98gScJsQPzcEdT0JZAVxh3N?=
 =?us-ascii?Q?MKzxBV1bRae0AWKjvnimZqbMGKfSjaTakxKVdISBn5v4dQ5Kba6Ga7oW2mmU?=
 =?us-ascii?Q?A/0GzLlCHN9ZNo0AjvZbZnx85VWFuzF1z410cddOPZH3gLLWbhqhFbwW+h5Z?=
 =?us-ascii?Q?FVfNJMepfKBBZreR5xpJLsbd42EHq2FysKKia8a4EJgIkwlSCxyT+LB82PiG?=
 =?us-ascii?Q?+tnQ3WDYN3WXACD+3YccLwkfLSc2aaBFM7fg+3q4XJig5LwmJE/5CBvz2dfp?=
 =?us-ascii?Q?bDxdlvtMEde4E8ts5J7cDxXVEDdhkC6MqTeYB+1CjFvMzqExfI+AB3VpIrtp?=
 =?us-ascii?Q?ElcefjOBM1Bq9Dgt3m6GAJ8JDANHUlj23J2VG19ILxzysegk0jU3VkB4y40B?=
 =?us-ascii?Q?++7Wkw8+QfBsaBMYZdzqka3VdoIepvqTST7yvLpwOGnPW/z/0t9sZNf10oOG?=
 =?us-ascii?Q?Mbq5Sb1kRV6B9xcqR4YQ79/gD/BUB8ijyZAkAT2Vxdsr6oqusOzwiLKdZh8z?=
 =?us-ascii?Q?nlK9OH6er/Jqt++ciiNewLPlWEecKUT1Kmmwuxr5N1akb1RB8i23A2smX04q?=
 =?us-ascii?Q?v7jazb1KeRmWhX5O31UX+ua7tHHx6drPThcA8l3wRRGpHWMVOWtwWRlvYw9T?=
 =?us-ascii?Q?PdhQ4W/vwGoKrs2dvkUYw3FsSgH6Rf8C9f5DpTlOk9LaZ6bsodMWypjk60/F?=
 =?us-ascii?Q?Rs3n5sv04MR7GbNhi3xwuISn0zabOQbfrWhvxIXEMvnBvaSJVEr8xpnURSlZ?=
 =?us-ascii?Q?xoSg8cmoEZkPNjgNfgf6B6GLyy5p5HfadSnIucK1LNvu6Jb9sx6k7/SC7zat?=
 =?us-ascii?Q?H6ThzOfjfT7sQL1QDnDgqsiGATKI0mt0Vxlcx5p12sQkh/PvJT8TCOXO14Y4?=
 =?us-ascii?Q?+ZA96zFc8VMxIvUlR1Fg2GjCgqiuMSRg1uo981dRptrgdYmVw4YB6XtEKEYW?=
 =?us-ascii?Q?tJFMnZobA29YsmH/Ko06UPImfs4Z7VER6uQX/j3LEjjPEdZC1X4jUEecd/aE?=
 =?us-ascii?Q?BLz4MoH3ztyMLNx8RX73H8CDhO05dzxlDrEGK8TKiuKeTE5zsjGu6hXqTl2I?=
 =?us-ascii?Q?vu8Lgy/2wGbhHRa/QwuQ1AhL3X/eZ2pdzvuaP/GstyWD/zfQxKPNkaupTuEp?=
 =?us-ascii?Q?jgRwrp7Y6THcS9bG0URdrKvuyiKiTfuqtj8Q7+wclKLZ5u0aCcGlaINy55Yk?=
 =?us-ascii?Q?ulI8ujEhHrLEuXfuQ9J6X2u4Y5/wQytHRqU2LAJVurx3L2b20i50xXvMkMXV?=
 =?us-ascii?Q?atcMVA2Tyr700gQ06sEB/AUIISLvOCP5EBcu1VMyC17yK1jqj9/PrTj2lwWc?=
 =?us-ascii?Q?1j7xPyp60SGfcfZuaYZZuTajltiNMFCkEzMa9JCwzC0eoegtjglrI5oHU9AC?=
 =?us-ascii?Q?HBNJRFOP2uTyexfq4MEVO5kRKnyUl2hYu8N/m19aoNMiMCG/Xxzq1po0/J+K?=
 =?us-ascii?Q?upWovY6ELhuZhxGDS6V0QOns1BF60vWgFtK6KGsAPRCsYupyolZ9bQdS8z8t?=
 =?us-ascii?Q?YhQ93pB5OVnWSI1jMuwlw2EMBUjZ914=3D?=
X-Exchange-RoutingPolicyChecked: mDh8gSNS9zWTIvL4ROIySlIVIDi9o9uMJfj+biXeppZun+l6KLO9kZ0zmqUXYBlmy+q8nGmh60iYmpxmf8l/spsxq9yKHCZ+2bWZKfTxT2AuROYi2dqG1CU4iE902pV1wCS3eb2EJ0KNKg5ABkJygPoMG7M0tSnLHsLe/f+7XbolpvRnEWVh13q2MU8FZEjVvFOWnGCQE38CHeEep6lqda6+cYehNo4eahIDhLcW/s8n3MKLUM+0MD9C5QGymaG/yT2LuddOuxe4x2zOmvWvraiwclwtH0Fw0PvE7+vA1sO2htGUjzb6/fVXM/MFQGI5qGzqn0uBp1cOUDr3PJuodg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f1892b-db4b-465f-c75e-08de99df9047
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 04:37:41.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGl5dA4D8LIHEJcd6stbuKXmkW2dVtvi/vuWTd6hD4P35ZSh4e/0iC3U5yAFnh4re3erEYa166Kxq9JWxgmfrFqAdsX+/YxJ/X4/Z+ccoEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com

On Tue, Apr 14, 2026 at 10:45:27AM +0800, KobaK wrote:
> From: Koba Ko <kobak@nvidia.com>
> 
> construct_region() reads cxled->part and uses it to index
> cxlds->part[] without checking for a negative value. If the
> partition was never resolved, part remains at its initial value
> of -1, causing an out-of-bounds array access.
> 
> Add a guard to return -EBUSY when part is negative.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")

The above tag added the check for part < 0 in construct_region(),
so that's not the fixes tag. Like I wrote in v1, I don't see the
obvious tag that deleted that check, else I'd just tell you.

> Signed-off-by: Koba Ko <kobak@nvidia.com>
> ---

Need a changelog here.
See https://docs.kernel.org/process/submitting-patches.html#commentary


>  drivers/cxl/core/region.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index edc267c6cf77..de749b54fd62 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3712,6 +3712,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	int rc, part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
>  
> +	if (part < 0)
> +		return ERR_PTR(-EBUSY);
> +
>  	do {
>  		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id),
> -- 
> 2.43.0
> 
> 
