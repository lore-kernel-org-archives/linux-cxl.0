Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC7350A08;
	Tue, 10 Mar 2026 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170958; cv=fail; b=W9mUu2NViVh/rhovZ0bMcxctg41IMwjjSRQDsEeQpSJaBMS6yEUeFgMk2Vh469Sun8bFH2q4mcOsh30izDOqLOSvo3mvvkFtuaBp3FrvrX9SkbVgUGRtbskfYBRVgtI1PQXZPJEyMbbeJHT79Afly4vKGkBJ6o02EgnrKo0n230=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170958; c=relaxed/simple;
	bh=cfOASGwyuKcSH46blfixMU0VbxTz2cjBGcsN06F+eUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cT2bBr9ur7UB++ko1vXvOa8YcVLEFgjwJrhy+XRVLeZZ9MECALdY+NG/yN6DzQ4AlHs2i/7y5Vj0CXZyup7ofUGIRcKqxwNsmnRMFI7dWuqI63TFM5tUH6Ep1HPtn9WRW9phE/wxwNCZWK/IDQYLKskLvDBBEKkk3WuyOPMi7Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5AypxOp; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5AypxOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773170957; x=1804706957;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cfOASGwyuKcSH46blfixMU0VbxTz2cjBGcsN06F+eUc=;
  b=G5AypxOpF0SsukUxAnR0SoONkQnJRw6gZd2oCm7gB7Xs1HFoA/svDtG7
   d8mXV8gdD1Laox8ivubBtVKb6UNYxGoOyYxQPNXu8zBSeg5688CRqK19/
   rfxUnSGPuZ7qjcpSooo+SZN4v4taTlH7RO0f4Zkpmi7aILxlgEhdQfdyP
   CxZJiwmHRFhrAJWNxpn94gBC5270tmJ1MZKKy6TQ7pr8eHBDNsa+bETNR
   Bl8l+2nyU2/d0cIKPzHZKcYZaTPKLVxYsY68F6PbADcupdBx/fQ0cYTGz
   tkTASWVq2JTcGPCC6a0hst5RWku7i/5/i3A49KDRF75Ub6eYgIMid81DB
   w==;
X-CSE-ConnectionGUID: FWn6YKu6QD6azXJS00kfVQ==
X-CSE-MsgGUID: 64EUXBQ8TN+MEl7CHiKmLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78087871"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="78087871"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:29:16 -0700
X-CSE-ConnectionGUID: PJBO3w8cSBODK1pure9t0A==
X-CSE-MsgGUID: o4CW06otRZSMuNEQl0XXiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216963125"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:29:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:29:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 12:29:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrsRE9JgFqAG4Fr+uK4CXAuO86kS8ub2lKscLTAaAFw9Ue2S+gxpq1Ms1dQrbBrdGAsN7NRXzPTdWkXFO4F4HLD1F+SMqunDtVuCBNkkgFf6UozxM1ja63YJfht37+Xd5T2hJlB1dfCVhxY6Gon+GG8Do1cfd8Nfkxar8cYFHAyllsKmJNOOkG7MxNFEtb52KFiAyiAXmFrsAqLBpySY2sir8y2LztDYk8pEAbs6LT/qwQ3YgBbqncQNwsg9AzHP/bzaV9prrWCfzYROVefI9dZaVJz7bWkG1xZTQLcua6WQi411TZadkJlIXwoYO6aTkHCO6il0JaprVqzPPPdXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5qGB0Ay2XEPV9dtbS96mOzoXT1aJnvkZpdOskRYJlM=;
 b=WgP2QX/eySIpZnkG8++6gNDhYmCu8ahLZz9zVHwqxxeSpDs9Nd637BVrw7/nJfAfPYXtmKW2sgGsJGPwNlxR81VI7MtxSfTfFcYrm2anXq5+s7/iVJQBSitmg0WPgZ35ODtOTE3MT/6+J8g10XT5zBbxnSbQgPlO0u1WFModOgEb+Ve8AwksLRz8Lhy0umd1QRdZ1DWf8eIFA0X/zzK1bkELE0lrHlx4mk+rAW+2Ae7RXcSkU8HD8DHOtDZuwdO5dOIGluTdtl/iveHo4G/kEmKYkEIWYdLLXLuC1ekm19XLU93e/cNDQYbss8X9NmVmj0hw6WApjneZWEgH86nPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7630.namprd11.prod.outlook.com (2603:10b6:8:149::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 19:29:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 19:29:11 +0000
Date: Tue, 10 Mar 2026 12:29:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/7] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
Message-ID: <abBxA-Ahtlh5UUm5@aschofie-mobl2.lan>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-2-94fe919a0b87@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-2-94fe919a0b87@zohomail.com>
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: fc99ce8e-cb03-4b1a-c47d-08de7edb4e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: uWd8kg9yVsLycUeASLlbHi1ltoopI/e5gNMbxWsVnkxdkOMyNEAhEkg2RKz3HBBotE108UQJU7boJ51flVIBnyqS2ElDn+eXP6MhA7QMqsyp6Dj04pKiMOWyk01gJw+enfUGywto8SgTkO6hj5G2sB5P9gg9FUN0A6dPOtHq3t6EsU2IYC/FaIVOG/pT0ZFg2q1q1tcIkoMXcyxEt3n4uL3dkHo5PAPuc+pLQaf+VJx9vthekfY1JtCuRmWuWif8Y6J75fuZBdWWGC1ZmfVD1Dj7OVsRUhMq8oxD8fYxSuD6aRb5JauZ525brri6skCT3x91HHYPQ5wylpa2Yn6cDF7RPAz2edFShgHZXgDCZHSGpXlmWruiYQww7n52fUVwGJal3+puobrsuuA/pa7+O9KPTBLAdxoNTsJmQqf3FObFxyBIQXbVCm6mNF35sxlwSadrhRtG6hbXwZELIqfHkSXAuAuV9ssCMpwjSyu5k4txbZhaumiO1qCZIqjIiWhVRF1A6r5WD40t4RG8O3iZz//LU8lSvxCHIAdHuPS61KQ+lqLzwNfaKYCtUXbtAL7KKehvEVY4Gb2mqcGGaeqXTmX8QtV7f8H2WyimIyiyor3me/3FOSuSiSPM06+fIikrGapM5C9ngmFKNEejafbDuwJkPuN0PxP8n4LoCqdiHCgHMIkAks8IijfAKCpzo+TiQSNWstVIW3Z20Sd6tZDjji3TjiULh7fGkUPCtQVdlB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HmvkBJYZ6vKLmD2pjXFuerzYdsx3dd1h0zR6p86qfxjHAJF0HFS6q8hYS9Z?=
 =?us-ascii?Q?jkfIJf0SUmr7SksVaTHPGyvlo+dCOvXJXr3e9GVCYfzBsBBHLgPToeNnYDBJ?=
 =?us-ascii?Q?N4Upb2bbpTYv932fPugFe+vXm1KHPfD8LvCEbZIVpV1JnWvQkTvEN3WYL1At?=
 =?us-ascii?Q?6IeDX5rmVSezjh9A8TW7HVWNoOJjFX2tlPfXmW7bIWCOZU7YqniNLBDplDQq?=
 =?us-ascii?Q?jwHSI4k81RKDinVRYrwMtWGs5miy/Y0sKoU0nxkDJSenIOQ6dQelKnyItaSq?=
 =?us-ascii?Q?Rt4FS4/wQ1KkfwBnw051335K6inlRJyZ5kHO07FWGoQv/+F2f7TlPjaLIW8w?=
 =?us-ascii?Q?JUOdmyofx21bGiNY6hnK21DbjJswp3fwIs2ImQInS4U/2BplMI+AK5L7rgbI?=
 =?us-ascii?Q?v8CsF7W7cR4oapVDplGib2jtmxQxVsMPWavvS8Xf82IcrzwYFMrQUSkQyJZT?=
 =?us-ascii?Q?7bdJQpLlLk5OKRVZmW/gvYLVt+dmSZVWerFpB15fnuZX26SzXRpRx8p4ZS5A?=
 =?us-ascii?Q?ztwUXb4WlRkKm2ct5oLWWXSCiOvugp2HLt781Pp8pn/joRHtA9aLklIKI63E?=
 =?us-ascii?Q?ryv48VHkk3t5WH+G496qJURaU9kOV8BfQYfMEKEfqxUWV/dCls76lR574tTE?=
 =?us-ascii?Q?JwwPLxUFJ3uRT6o3qEhw2wqj8Njgil5Jsvh+t2uFlyOLtj3lAwdHhH2V1AFx?=
 =?us-ascii?Q?I6ky3C0bQdqnbLtEYxsUgNugeoEsVehu8QRmtFedevSBrN2A6voJXUuEyG4L?=
 =?us-ascii?Q?iE7/aMLRjLWJiVbQlnexLbjySNEG4G4542P2aBmdnO2Wf0GxtUTIdwO5HpjP?=
 =?us-ascii?Q?KtXZ9UAiAH1j8cOubhf7F/t2d2+QmbCvUzxo64SSkHFvHGpK1bJl2qJmk1wM?=
 =?us-ascii?Q?2RKkgR3QWeDxoO+eZleHqUhWwlXFIhTvHNuGZS5Y0w+FEOLHFpLBdPJzM2Qd?=
 =?us-ascii?Q?MhB5ZEr6Mp0QaqeE1v5/wEq5marq3s1iGal0dBv8wBv0bpQNh7yompN75ueQ?=
 =?us-ascii?Q?27h056BHmvfXatqB9h6srj9M1Wa/im8OyTo7GBAUVDmKZPjJ9H9se2idryBo?=
 =?us-ascii?Q?+DtlAF4v4fAFSwJyBXomDFAhz3gZe/6nw9915dDSsdPkRT6xjHTKBSObm0/A?=
 =?us-ascii?Q?LU5kTyZEgXdKKKL4jjUuJ4KiWewIgKZG02qhigixQUQUk2rQJFMDQAcAuW64?=
 =?us-ascii?Q?VILvJF7nI81MpvFsxYIo/MKUpiNAv+hsX3EuzfA6GFHOgNqmFyTgOQnsxy8U?=
 =?us-ascii?Q?kSWV41C6Qi0RIJ/lgQ6nwkosCGZwGKRufMgANTbe1mJ4IfHVwFkSJkCSO+e0?=
 =?us-ascii?Q?Qfwu0H7K7rx4HjXtUIfmkwHWeqfbxhFO22wASINq+2G7BltiUkoS37Ggx7FF?=
 =?us-ascii?Q?qVtdIM9hdIr/1JfUdmrCzYW6lrHH0QekJPYNi3cPWgRhxuGhvTt1J3AYZvOd?=
 =?us-ascii?Q?aTb13oPrF19Kkth93BR356o6tJvjCWCQM54PGhQSVD/8xIqxe5LDdUGIskXP?=
 =?us-ascii?Q?UFOXW98yeP/YjV2kKCpS6Od5U2+Mhsw5iG3ZDh2Uyd3e6tg6jxYzT+B/82Cw?=
 =?us-ascii?Q?Wrene+XTJhOsfGZ+/h7ZQcBWrdzl1ncbyJ1ioSmN9a7SXTMvCxFipu8o0QO2?=
 =?us-ascii?Q?CuHQaiZFunNqjkFquhZjPIYWSjuGeki1tzO5ZJG5svADGQh4XLfyTkjO8xiE?=
 =?us-ascii?Q?wsfjHV8MPfxd6mhecm32yz1SeAcGCCeVBzSZYrusFXI9z+NoCwcTlq9M8S2f?=
 =?us-ascii?Q?/64dykoREfzSCm0CBhYFqmw2cg30TNA=3D?=
X-Exchange-RoutingPolicyChecked: whvf5dl+M/zU4BwaS1CbeFfFjXK/i43/dgceVI4SRmU17WzfsnotNLKryOnqbM2SlukpTDskWGGb+eF2QInhAIk0tqebSZ3eVnFGQxU2RmIsUpw4KiqFGqHhV8N7z2r0ee0WQ/gUf3Svp7iv8MhftWd81XyyztQ5BDE5T6v0GZU/LS8oekxSFe3O5JiO8LtemClP7m734KpUyqgsJqL8wIT415DsxfL/cDgpNkVjVxBHU5f8ZI5tWoE7hqjTQeD46oZYqjBKHzrUBTLYfnSQGn+kC/TViW/GuNV2yj0iD3I4LXjgopmPtSnoqQ0JGSMHHlrjo9wdCDcNZFytWh61uQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc99ce8e-cb03-4b1a-c47d-08de7edb4e87
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 19:29:11.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT+kmyJQzdHVyNAtBOx1S37gWq3sCVBRa4V0yaexDp84EC/OpKGAA9o3mpPRwynh714RytlFXhRnmzCZ32EF0qA57Q9nkj6eLf/CNBFsoBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7630
X-OriginatorOrg: intel.com

On Tue, Mar 10, 2026 at 11:57:54PM +0800, Li Ming wrote:
> CXL memdev poison injection/clearing debugfs interfaces are visible
> before the CXL memdev endpoint initialization, If user accesses the
> interfaces before cxlmd->endpoint updated, it is possible to access an
> invalid endpoint in cxl_dpa_to_region().
> 
> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
> interfaces until CXL memdev probing completed.
> 
> The following patch will check the given endpoint validity in
> cxl_dpa_to_region().

'The following patch' makes it sound (to me) like the patch that follows
right here in this email. Probably better to say 'A follow-on patch...'
meaning it follows after this.

Maybe DaveJ can fix that upon applying if this does not rev for
anything else.

I don't see a fixes tag and like I commented in the cover letter, this
is low exposure as the debugfs interfaces for poison are aimed at expert
users, who I'd hope are not reconfiguring their regions while injecting
poison. So I'm good w no fixes tag, if that was your same reasoning.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/memdev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 273c22118d3d..8ebaf9e96035 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -295,6 +295,7 @@ int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> +	device_lock_assert(&cxlmd->dev);
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	lockdep_assert_held(&cxl_rwsem.region);
>  
> @@ -331,6 +332,10 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	int rc;
>  
> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> @@ -355,6 +360,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> +	device_lock_assert(&cxlmd->dev);
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	lockdep_assert_held(&cxl_rwsem.region);
>  
> @@ -400,6 +406,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	int rc;
>  
> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> 
> -- 
> 2.43.0
> 
