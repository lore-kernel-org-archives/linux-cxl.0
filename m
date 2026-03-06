Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC2336886;
	Fri,  6 Mar 2026 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760222; cv=fail; b=bC3OQC1otLxB3SlbpyQ1yBIzjoRIkVRXqX2Jm3EfYxrrZfoUfFf1otHn3cfy8punWB9j8wHgfoNSn/QKLVc9Y0BLMbs6lOJ4zZGFJ2EOpjSw+K7STNAJsA+8jZfnIAn8kAlG2lPezTwCdp+1NPI7ebleanAcKynj6CMOvL5bnSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760222; c=relaxed/simple;
	bh=zjOX3vNX+DIiRWMf7ppIG8+ZbJo0MxWCnZrQb95YeBY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=OFvjLe91P9WfVoTxVZ2NBQzGTny/UpGjSbkNxAyVQ1beKu3CJOwXpurFcQlIiBqKsmZYBYbfG5asbclPrVEBmI6+mVA0YjIyBsyla56L9HoorhdpyzXXdEBS5T/FBwV/XPSheMIQALULNmmUEWc9MFj/q3HpKhRNoYQ68Esrv40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzLBrwxH; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzLBrwxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772760221; x=1804296221;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=zjOX3vNX+DIiRWMf7ppIG8+ZbJo0MxWCnZrQb95YeBY=;
  b=JzLBrwxHGwvJpKACsvvI+lVdeXAWGIPct1xrPjcAfLnmv8pD/IIADoyx
   6ZS90e1Z94tJdDbKK9R5i+It/e4A7//v6VjyPOYs+nYHV5xsuxRizLhzl
   DCSzGwbmRbti8sAzSHoS+iv63IvRlXzRoRJ1Y6Nhr60a2yPfsOhbAIENs
   uslxrXnNYD8KGyR0eNsPgqdBV8982tO0k8U1eX/3cHZrTWqmsU07/K8+X
   D79DE0hrJvRVaMe1NdDv3gvK+wcrxRPDrSIDC6oy1r04YR6rueA7aT47O
   dkHuPJnWRQJ0bPP2Mumaxl+VRKyNGX7mXZI7z2PtL3sftqy5zcI6KvhYR
   g==;
X-CSE-ConnectionGUID: CRqgEmsDTgenOjb+eUQabA==
X-CSE-MsgGUID: a8rxOzfdSyurMkuh/cWXVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73565148"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73565148"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:23:40 -0800
X-CSE-ConnectionGUID: I4/lCFTjRFmTJz4SJp6UoQ==
X-CSE-MsgGUID: d27eH7vUQo6a6HP2mRg1lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="216036816"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:23:39 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 17:23:39 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 17:23:39 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 17:23:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxKdJ1ib+xmD51qnUdfx9Z1VBnh5nnSJcK/FNsmJIcSnhVStMqvsUpm55RzaJEBrjjcevcoKagjfxNZQvWFLU0HjdBLJjDBT6XvDUgv1FAGNsFRMX4iUaQhNOPsF4Z68SOI0L6bDcLBpRYp+rLp4NYG0fi1GGN5QHMZzNd2HnQ+cck7M2aw+vRzn5Oo8Dr0ZTux7DcQdYDK1KfV/Fcw2q0tGXAvehHqsHJvOx/4XbS1EHduYw/NxjkbZ71+zCM6x2PXuLRdU2CqiJez5B/KiRddiD5nWM+mRZragAdExdNN3WAhAJCOD5MsQECwCWWG2G9oji38balPUoMrnTKYnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OTV/JIO/jUFq13LLKi+uE/gAau35rf9ptpzJCds9sQ=;
 b=UnEo7B0agc2joClXcdsvNKnPtvr8SLSZc3NbpneC7YoHd3PR+y5qcH0h+YHfO93ZS+RAkqvxh/blfD7WJFlaIRzQKQSbwkCTS+/55VURNs0AxNAOo/Mgw0r7GKB6IX4MyZbbUd8G2OUTLWQBUW8+C13we1gY0xdJKoFbtBJAO2X9Tou+yQ1ENnZt1HZE6HifbRRoUjPVKErrHaDaEJCG0Ob34tri0mGLED0oi78ImY1sPY7koev6QUdTSIP+c56tNkQiltJihQRV/BKnK6qrVQGCaaCM1YVhl/kacbfC9SuXcR4mCZSn9Lvx8bhRYYU+PL/oYULnSj6UjI5Z/kUJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 6 Mar
 2026 01:23:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 01:23:36 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 5 Mar 2026 17:23:34 -0800
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <69aa2c9631aef_6423c10077@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302200429.803417-1-gourry@gourry.net>
References: <20260302200429.803417-1-gourry@gourry.net>
Subject: Re: [PATCH] cxl/acpi: fix CXL_ACPI=y + CXL_PMEM=m link failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e73ad8-7d12-4e3d-2991-08de7b1efd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: dJ5vRcJ0OIP7Ot9cqOad7kefPwE0J5DnKEaGCdMtOiKnnMTrZ/xh0RoFXHJcOxCV2GlmrB4O65Jt7lOBk0q4A60aIa907oY38C9RRc2N+O38vzWXsscLR78ynoWSIFg/0J452/5SiBOnQaRqmAPtoIZEZoPpa/uKt601nXaclrqww8hLQvJSxG1y30K4jr1/qgZamDACMSazRDaDZIhKWOPEzvmmX9K3SZNty+YCnxT0XlV4uNF1zSHCV4VpRXX/LYwur0mEr3VSmBPa/eNIpH4zcb5/3VbU9tMtp/47bfOgUZkl/eUXDY8XGO4q4ZneXLUpOgpWThCxs/ajOpnWWtsy8qrp/4mU4waqYLx/K+/MshUfWHsRNiT5hayKIoGe9ijghwxuHWdYEchKMbHRtrVVjhWbckNIqRssQnGW4w8VJM8NxvUpgsVriv7m2DYA13tu+a1UHECN4Wohh9zKlxUAck4d8YZNZQNEmSB0jCWR6ZFFcEWbiYNr5uxRXnm9J1Ca+0L/EcdtjUVmGYauCJgVhk0LiH8747GF+Ec2mob0j/Z0QqNH/w6VBiUmIxBgsqz0tDwjHQoVg0EUqxR8WvsBzzbb2njEuqIOJtEk4oMTqzYSSUK5PERvCfhXy3gFWNza3KiwjwWsTI1OyzTn1Iuu1HE+WSIUeT9eRKxnixfWgRC8zJxnW01vboqnzsHt7gBIGvPVAzwLjkHBnUiRNvv6b/cotY1N9eFWyuVhTcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDBKRmkxZE93RjEvVEg5WWxpZkh3V2MyNmhBTXNQZyswK05xQ1k0SGM4b2FB?=
 =?utf-8?B?THJ0UUtsYi8va3IzRTIvd1diRkRSR0N4MTVDcVlQWEZUbjhUSHFKNm56MHF2?=
 =?utf-8?B?SzVhRVVvbTM5MFVjWk51Y2RPSDNsTjMrN2s1Y3prQUEyVXF4QUxGRjRhc3ZI?=
 =?utf-8?B?eitMYUpoQzZsU0VOZnpNSWR1VHhRcTZWem94TWxPY3N5MktiaDM4cXE4czlt?=
 =?utf-8?B?eFU2VFhLWkFHL2I0MU5YZnkxbTJWTHV3R3lzY1Q4QXp5dVF2ZTZzNS84SERK?=
 =?utf-8?B?Tk5DZWJLVnU3ek1FaHVrc2E0WFBYMm5RV3NtWDJOQi8yOHVUc0RyUS9MeDNU?=
 =?utf-8?B?cko5MktsemJpTmQzdUp3NDNCTENmTEJqTVhUM0pMYW1oWUFubkd6b3czTitx?=
 =?utf-8?B?RW9BQkh5cTNwemU2c00vYTRPNjhSRzlUaE0zeFRJSDhRSFJ1OXd5T251VkFp?=
 =?utf-8?B?SEV0NVdoczh1Z2FEamY2bmRQZ01RWkc5b254clJCL3czUHlwOHVUWFY3a2tx?=
 =?utf-8?B?N3laY2NiNVBrQjFXRmw4a0wyQkhRVThJOW12S29MTllRa0d1YmsrR0lQMnNo?=
 =?utf-8?B?Y21LaVZHbDYvZm80VisrWnl1M3VhNHNHWWw4a1lqUW1qY0ViamlmZ1hYaXVq?=
 =?utf-8?B?eUl0YXg3MThldWxNMndkMFIxSm8rUkVWeVh4eHNzQ0xqSWcveUpaQ3VOOGhD?=
 =?utf-8?B?aWJiem00REdGbmIvOE5FWnFxNmFoSHB6UDJyMDRJSjRJRVhRYWtUazVIenZF?=
 =?utf-8?B?elhNOW9EeWZhTENadDQ4bkR6enRBT0tKQWtvMXJhWVhralJIdDJBbzNsYVlq?=
 =?utf-8?B?RlhHQzhuMU5PRHlEczU3MGxMcWpKSGZ4VW5NRHo1RjUxQ2I4VTY4cXB2NDVR?=
 =?utf-8?B?WVBkUmlJbEQwTDJXMzlTaDh3R0U1SzRRcHlrK0NEaTIwY1NZTCt3WGtiV0ht?=
 =?utf-8?B?a2pQZExFaWpzTTgwdnN1a210ZHNZTnhqRG5YNEg2c09QV0NDZkQ0d3BaZ0Jj?=
 =?utf-8?B?WEJoakg2R3lPL1hGS2xLalFtS2RuMXBCM3ZOQzhSRXBRUks1Q01iN2pSbGVS?=
 =?utf-8?B?REZQL2NUR2RaTkNML003dHJoa3VPdUxCUDNyYVdvMENRbUlCRTYxM0NuUS95?=
 =?utf-8?B?NEFkdXkrd1d1Zm9iVGpCT3hmY2lXcjFqczJXRWt4bW9WbEIrdDBCcm9WT2kv?=
 =?utf-8?B?a1o2MFREZUFIYzV1bHZWVWErTm1PVTkvOVJVUW5vQmlaWUk0OTRmZ3ZCa3J3?=
 =?utf-8?B?enErNEprTmcvQ0FSV2JFVURNdVpoeGxsdHdtZG1VcHk3Wnl5TW51V1hrTDB4?=
 =?utf-8?B?SjB5S25zUXVkWVRLVXN5WUdoK29TbTgwUnAwQVppQmJLR2Q0NzZBU2ZZaWZt?=
 =?utf-8?B?WE9ibStjUGV1ZCtRajJFY3hrNXlqVFU3TE9jU0czeEpmYnlOMFlRVzN2a3Zt?=
 =?utf-8?B?bXNpcWp0d3U1eGl1R1oxQlJHWjRsT0JBYVZTaEI4eE95K05jYXA5eEhRVExv?=
 =?utf-8?B?S1NTMVBER091T1ZkUE1rUEpNeWViVU1PRnVLTmtSNysrOWk1azBnZURNQVpL?=
 =?utf-8?B?aG5KeXZvOEZwSmlhd01od2tybDZvMWhQZVhRZkZXYnNTMjBPSW51S2p1TGF0?=
 =?utf-8?B?dUUwK3NlUE54ZG5lcWdwcE9OOUZVRjdqSkh0Rm9LV2JtUkJVck5WTjVCZGJ5?=
 =?utf-8?B?VHI4RldZVFpLaXMrNE1uN1JBRFRMSVloSm5FT3lQR2xtQ1NUY1pRNVFNWGNs?=
 =?utf-8?B?M1FnWHFrZjd4YU9RVjlhTlNGMjA3ajkyM1ZoNHZnQ25vdy9ZQ25wMUlobzc4?=
 =?utf-8?B?SVR2ZG96bWZiZWtxLy9aTis4dE9Zb3ZHYTRjdCtiOTFscTlYbjVBSTYzakxo?=
 =?utf-8?B?Q0ZJMGx6aHJKMk5ZZE9oTHlCK1E3UWVhWmFObnlpR01TTkQvWE1iR2NrazRL?=
 =?utf-8?B?MFdDM1NTYWd4VDhKNFhLNmV5WGVIbTl5TnRkRm5RZmQ2d25pMlY2eDdiQ0ti?=
 =?utf-8?B?Zzl3TzlTNDZnL3czanFpWFhEd2lFT0JFODBxbkVIWm9ydDdPZE5ON3Babnph?=
 =?utf-8?B?VlBsNWpmV0hURjBISWFGTUpTM2VQcXd2dXpOVmdRK3hRRENuVStoczFjTDk1?=
 =?utf-8?B?R1hRSDRwL0k2bWh2dlpvLzR5STdySDE0dExFcml4TFg3WE9wa3h3cURHQ2Ev?=
 =?utf-8?B?b3l5enVBZCs5T2RTaGpnWml1aS83SDlEdVNwSmd6ZlFIVUJNQ1hpK1dTVkQ4?=
 =?utf-8?B?dDk1bC9OUDFEV2Evd1BMS0F2Y0NaZEhmUHpFdzZFK1NJRU9ySVNNKzdWcXFO?=
 =?utf-8?B?Z1BnOEYrME5OR2pvdVlhTCsySElQUUI4cWNIUktBcFczWk9yQ2t2Ri9tcjhW?=
 =?utf-8?Q?eeHTvfO7L5K8l1Lc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e73ad8-7d12-4e3d-2991-08de7b1efd91
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 01:23:36.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TE3ikW5tmjGKah1JujfKH0btymhbmdsoEA4zP7Ms9xuTogavlujlaG1HUFX3vi9eltPFnj2qo5bFSZGHZeXKAG0ihe70q2OtL2LhtKFW8uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
> cxl_pmem.ko") moved devm_cxl_add_nvdimm_bridge() from cxl_core into
> cxl_pmem, creating a symbol dependency from cxl_acpi to cxl_pmem.
> 
> When CXL_ACPI=y and CXL_PMEM=m, the built-in cxl_acpi attempts to
> link against a non-built-in cxl_pmem, which the linker cannot resolve.
> 
> CXL_PMEM depends on LIBNVDIMM, so LIBNVDIMM=m constrains CXL_PMEM to
> at most =m.
> 
> Change IS_ENABLED() to IS_REACHABLE(), which returns false when a
> built-in caller references a modular target, preventing the link error.
> 
> The result is if the pmem/nvdimm symbols are not reachable at build
> time, then at runtime it will always return -ENODEV.
> 
> Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..7065413eda9f 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -952,7 +952,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		return rc;
>  
> -	if (IS_ENABLED(CONFIG_CXL_PMEM))
> +	if (IS_REACHABLE(CONFIG_CXL_PMEM))
>  		rc = device_for_each_child(&root_port->dev, root_port,
>  					   add_root_nvdimm_bridge);

I think we want this conflict to be resolved at build time. The nice
thing about a new CONFIG_CXL_ACPI_PMEM symbol is you can check your
config to find out why your CXL PMEM is not working. Otherwise,
IS_REACHABLE() hides this subtelty.
