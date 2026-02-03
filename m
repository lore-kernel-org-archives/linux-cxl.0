Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F133EBF0C;
	Tue,  3 Feb 2026 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077241; cv=fail; b=k6V4kWyPKF/I3SLyzQClef9I9aE3gtohECCLvhPUemus1K+FHI8Kvjq5lwMtcrh2/GB7vyeTYzWZ5Rqy/oSUuvXSNtplv2r10c1iuEEGuaPFCzK+qxLe9V5E033YAtH3vHQOMfUkr/DZUWm0o5T2MxkZbCfNObGOzl0WF/i8DKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077241; c=relaxed/simple;
	bh=LtwPXRiltnhrw8iZ+NeptCNckhX0bCEQsE+Eha1B1MI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=UqZQXexTm2Zu+RCkwYNvBXDn1ffBkR+kQHU701I8OEI6r3vJw3SgH68b/fUyD0/jhtoVK2pnmpxayNoc1b2hngJLk6wl3zTkdpHRK/OjCASsW6BDzlWgCp3vEmOBeu3Onu8ecmZyMKBDzsYGzRpzpf6LM6FvResbiOitjWRQCEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AALkgHT9; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AALkgHT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770077240; x=1801613240;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=LtwPXRiltnhrw8iZ+NeptCNckhX0bCEQsE+Eha1B1MI=;
  b=AALkgHT9typ6Dw/x6z8gwxlUHQPxuluzpSr9am0nuNJvTgPiRx282+be
   wHwHabVWGY6nf55hfXJO4QrpsFPabWTmHnfoESVDS84Oefd2vLbiU4LtW
   fHFG3EVYtACVchrp1w0eUXKx3Sn9DvyNyUFgMB5leNTvmo4eTv2wAGLVg
   7o34zl+jCqEL7x+FTvQraG391TYMEENQlWo/HGLMqsfuNKG2cuovfPATI
   dQUqArpDLQamQ3h/PjiJrIWpCtb8TNhInkmW2kaQvubIvtvpykFcL021t
   wBAZwVCev8KEeWPfo+EZjhFjEfBlRdhM+jq2awHnjMqPRXTjEpk05uIuj
   A==;
X-CSE-ConnectionGUID: rDjMFQr2Rxq4H8yppxMa/Q==
X-CSE-MsgGUID: RVg4NtTZRpSsZrhkMq76VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88818817"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="88818817"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:07:20 -0800
X-CSE-ConnectionGUID: 7CxtCvYtSAGNcU2LLzq3RQ==
X-CSE-MsgGUID: zK4w3memRRijQJQJn2e6ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209886516"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:07:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:07:18 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 16:07:18 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:07:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZn6YLRhvpMSd0fS4j4ej6A1FSqpOslZ4twaOR/tJ0MN82VcKMjRZ8+NtBWY8FxLqDeFPKFtW2Ba7A/GujEaOvDXNaMLBjoKRuGySLy4iInAwv+ynFtCm+6LecazVW53JvIcHIZ3JMV4EoYBZh06LFS9ReXr4KKDYJelyhJLlWQpBRV/Ql5xHolkwUm/L6rExKBbaqzVELI8tP+gkZesj48WAfkgO7YJsBjBmOO5hF66sL4DsJTcK9PPtPUTDVTAeZJ71RJ3YUiE3NV6F6USUG5pzfFQlCpAQF7v4O5LYigzGmQp9GjiamdgFbV2+hmY15t6irkxzGtVzUbtvtmY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRWxm+VkouLxDUXQX4YVow29YB9drV3T6WTxGIdKeFg=;
 b=b/vW8D/48TBLkl4CPMkOD6bFXL+NYhVq/CVwpiIZlxMgJKJw+0b+8kLswZwOT2HDiU90yrn9oXa6AyJP3cce2a4+8pn3xDHviD5N3xS5WBDC8s0ab70O1TaOr8tOOSD0OKBZFbBBxf+fomlPx8zymUH2Rhcal9BtM1aTC3lqDAt2RY+KJZmzFWEZdyLwSDN47rTlpT5tf7Xq88rAALV0WW6ZCgIAVoVdpzdniIbNYmO2S2DGgkFkjaz9CcL0/z16g8uRaA/SF9CFeR9napTIq52hISzb+w1QOdn7UDfL8P1QHwdk+9mSIY3AAQR4fM8c1FStvQxRxWccuHn4tKDehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8201.namprd11.prod.outlook.com (2603:10b6:8:18a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 00:07:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 00:07:16 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 2 Feb 2026 16:07:13 -0800
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <69813c31200a6_55fa1005a@dwillia2-mobl4.notmuch>
In-Reply-To: <20260201093002.1281858-3-ming.li@zohomail.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-3-ming.li@zohomail.com>
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport
 adding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 9965f5a4-8087-458c-7596-08de62b83063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnlacVNHWnByRDg2R2NqUjhid2NWR2RIWjdUczgxUW1yZ3FKUHh3MGZBUFVL?=
 =?utf-8?B?ZUVtT0RucXBXZW5BSm1ockdpbk9iQWV6ZnpLM09jNHUyTHNkUXMwN1Q2U2Jo?=
 =?utf-8?B?UmhlbUR3dktVWGZSYkJyMnRqVUFUUURGYzlJNVR5QWRaVG1qLzJONHYrWWhQ?=
 =?utf-8?B?bjZSNW5oR0xxSjFwQnNzejJqakE3WDRKSTZGQll1Ykc2dnova09VbHVlSGlk?=
 =?utf-8?B?eXNEL3dCaVAvODZRa2srR2hjdkkrZWlVaHdoMEU5NWNhL0I3L3NKQUVCZS96?=
 =?utf-8?B?S1RNeks1Z3JMdDNodTMvVDd3RFd4b3kyUGdDWVQ2Ry84S3lJL3NGUmswd2Z1?=
 =?utf-8?B?RnJSK2RwQXY1YmtFL1d1RUtYc1ZFeE9DK0x1cTczOGQ5dTZEZ3hYYUducS9W?=
 =?utf-8?B?Zm5ENko2Mzk0QXBMQytIMXF3aGhjR2d2dGlHdlBxbWEzTDJnT2FDRE5GMXlU?=
 =?utf-8?B?cEF6RFZCZUp0VkpQMWtzTS9FWW54U1ZJTmdwelhIVnp4akNiaFJpY1VOUlU1?=
 =?utf-8?B?aGpqL2NMaHozVE51ZnBySnh3STFHYmdOZVV0OVl2dXN2RmRmQS8zMmE4bnNU?=
 =?utf-8?B?YmlJRE5rSU94cVdLeTJjU2VQLzdDemdSbXlFM2pyakcxM21mY3BHVHJ5bFF1?=
 =?utf-8?B?dGtDZ1JTTDdML05oOVBYTFF4QklCM1dnekFLVVdQNE5WNk9GZEJtWkJJckNk?=
 =?utf-8?B?OWFuNzdjVE03VUdHZC91allJUDAxbld6RlJSNE5ncG5ub1lXYnlqZUF1Yktz?=
 =?utf-8?B?SDdIRUU1VlNqM2svYTh0YmxOYkIzcUF6Sk40NEtIaXREQzYwQVdkSytTc25o?=
 =?utf-8?B?SVhDV2UrSWcyZTVEZllyVWFOaUF1MWw2TVZaTXhudXRlbzMrbjRmN2h2cEty?=
 =?utf-8?B?NVpITlJZR0I5TTFHMmxYT0F0NVdnOXlxNzR5NTYwQld3MmVXK1p0VlJwdW9j?=
 =?utf-8?B?Z2c4Nm1UN0lDSGlKeXBWVTBQWjNFQTJxTUZlYVJqeTh4a3RtVURxKy9kUkJT?=
 =?utf-8?B?bmE5NmlCSGVkUGFiclM5Y25KL0l4U25KYkVHdnp0WWY5MkpzTGViMlp5WEJO?=
 =?utf-8?B?ZjlSTnB6TWxWcyswWm9CSHlwcExRV0lRUFQ3RGlleUVSM0IyRGQ2dmtBandE?=
 =?utf-8?B?aEpLTU9DN2IwQS8yOW9ESmw5Sk5UQ0FjdndPekdRbXZhUFZsL3lBYjZXOVdX?=
 =?utf-8?B?a2dMNUU0bGEvZEhmUWNER014LzVVVmZzTFFNNjVhaExZV0xQVzE4S3VXSGMy?=
 =?utf-8?B?b3lIRmNwMUFTQzZ1ZTFyUHRkV25pRE5IaXA3NDRObmxoZlhDRzNmWW9Sclgz?=
 =?utf-8?B?a3E3a2R5M29kRWRudjhMWThYODM5NitQWXlLQlNkN1drYlpsc1FDN0Uwa2Fi?=
 =?utf-8?B?dm5GaWdYcGxNOTFLWGh2K21LWTJZdzlaRjdKRjVuYWs4cFdtZ2pOb3paUFY1?=
 =?utf-8?B?L3c3akhYMWRiYmp0QloyMFFZeXJDR1V4Smo3V2cxRWduVEpITDJ1bGZTWjU3?=
 =?utf-8?B?RWxBTDVOa3IyWi92QTJCY1QvcjhqOGs3TTBIQmN3V3doYmRYRkw0UldscjB5?=
 =?utf-8?B?ZExpTTRSdklUN2g1UkFPM2IzQ3hqWVdzSEtNeXUwb1VDMjRuRHh4VitJQzhM?=
 =?utf-8?B?VVM4Ym9mRVlWeFNpd0txanRISUh3b2pXdHpMNVBFN3dWV1Ayd0p2QjNET20y?=
 =?utf-8?B?UHYwWmFwOUFkNHpndXVVZzdoTWVVUkNSQnVRK3V6TThZTkxubUxnem8rN3lo?=
 =?utf-8?B?N3JzSVhvdVo0TGJYVkJxMDFhSlhVZmlId05DTlhDa0p4RmZQS0Z6c2xZSUNi?=
 =?utf-8?B?NUxOclFJdVZtQVZkTjZ5ZWUxRm1HU0hGZ1ZwWDJVQm5zQXByS05sNFRuY0h5?=
 =?utf-8?B?dDhnd1ovSXNjNUlMdEsxWmlSc2NDdXlyVE9mYkNUalk2NlRzbUJHTDV6d0tk?=
 =?utf-8?B?Nlc2eTRoVU85TlNwRE1nVkJBSUZXR202Z0txaFpneTFvRmdXckFUSjFHY0RB?=
 =?utf-8?B?YlVhamI1MHVhUWFPRC9vVDBLTjVWR1dRR1ppZXZ5T08waW5qaWdIL09yUTJT?=
 =?utf-8?B?ZDFubHdXcVRadHZ0a21id21RcTE4cWNFbDlReUV0U3lQOExjbTA2MFY4SnZH?=
 =?utf-8?Q?88Q8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdWR3FlVlJ6NmZWUnJSZWFTZjltcE54dTFXdjJxSXRGQnd0cjMvN3V0S0gr?=
 =?utf-8?B?bUVxd3pOTExhZlNrRWZaTnIwK21nYzJNZjBxQmZ4MmNPTDlzcnJERjRjM01U?=
 =?utf-8?B?RDNJVzVuTHJWZmpjU3pKQXZFbDVCSTh6WGE3QkxFaDNMcCtFK1AzdDM1OTZx?=
 =?utf-8?B?akZKMFVmYWZncmQ0UytrWTlZZ3JUcDlVVkI3cVZIL1F0WVNEY0VIMFFrY2lw?=
 =?utf-8?B?UWJvVWlCOUNrUDZ3eUxsSFkxN2JITElFL1h5cUlGZjlKMXp6THpMeDRqTmdw?=
 =?utf-8?B?ZjhYWkF2SFh4alplZUo3ZWdWUW02MGRxbGMwWFg0R2ZZZkttVFZSNU5ld0FC?=
 =?utf-8?B?Z1l0Yjljd29WaVZNdHlaT2Y0YkFsMGZwZmNxTXdXSFc4eVFtWmRRbHF3YjRH?=
 =?utf-8?B?cmFQUFY1cE1WZU5sb3EwR3dpZW5BdEVOWERaWlVIT3BCZUJlbEJOM3FjNWhB?=
 =?utf-8?B?dGtKY3RyMWpoaEUya0RIdzNEemhXR3V6M21qMGJiMGJyZjcrRUVzcGcrZkNI?=
 =?utf-8?B?RHo5WHlRMHBFSUlaRHcyNkZWdG1RS2x6Ymd2dFhuUmd0QVF2WXNMWjZMTXpa?=
 =?utf-8?B?aVZBQ2p3eHhZQnQ5MnkycmZiM1QwcUs4THpic0NNcnZxM0xpVmtEZUhQTWhB?=
 =?utf-8?B?YytHZzZ1ZklrZnZldlhuelBXd3BuRXM0QVZnaW5ZcW9VZ3FrV0NyUG9rNjN4?=
 =?utf-8?B?Sm5sODUyWS95MGxIM0tTZFN2VXpiVWRqMTljMzVNZXJ0REVyM2V5a0lzRERx?=
 =?utf-8?B?RERoWjQ3R0hqcjk4d1E1cmphbTJwelJuWjloUHNuR2ducURjaHhndWw0dUtD?=
 =?utf-8?B?ZFRYbTRkWGh2Unc2dFYzci9RMUF4N1BOV0REa1J4azFrWUhSYmt5KzYxSlAv?=
 =?utf-8?B?U0p3VnVXeVIzR0FKTzRYYXdDcXlLakhBU0MzR3JYUDRmUTIzS2ZTNmY1Vytp?=
 =?utf-8?B?UXlMNHhmUVlGbGlvZDRNU2lBWkhFUjUvTEExck9lS3pTZWVuZ1FubzVodEFG?=
 =?utf-8?B?U0hBYTJDaFhWd2s1SEM3SmI1bzhLTzFSOUlEekVTdzU4WWNhNGxxVTRYelY1?=
 =?utf-8?B?VE5yLzdVYlBvZFU5OHJFbjRLN1RZNDE1YlRkejYyUEQrU3Via1F0azlKaVRj?=
 =?utf-8?B?cXMycHlMMFFGVml3RjdUblBacnlvQ3VHR0NiaVkwRDdTWWQ0ZmdOMUpSeHEz?=
 =?utf-8?B?SHo2WWRwNzZmVUgxNnVsb3lJV3FLampEMXpINU9mSXBLZjdOb1ZSUkJIL0Zw?=
 =?utf-8?B?dktBY29pUy96Q3hIK0RhSENiMGM5UmowZzJEekhsUnE2MkZsSElsYlEyQzdp?=
 =?utf-8?B?STREZHNOTjI0YVVMRzFra1BTUUpxWWpodjlKZkNDUzVwMnRuTHVLdmQ3WkZG?=
 =?utf-8?B?ZEhJS2hrTEJzU2JTdEFRVXFicExzcjZ4WXdjY0Zrb3ovaWtNaEpCVk85TE1W?=
 =?utf-8?B?RmhFRTJGbDA3NU0yclBEMDhsUkJ6QmtNQktIKzE4VExzNlZFbkwwamZKVSts?=
 =?utf-8?B?TkpiQmZzbFhReUk0djdYZXhHaWhuUDRTRVBmVTFzUWVLVEk5bmFYZWxNV3dw?=
 =?utf-8?B?WjJWdkxZaE5YWUxoK3lYaThhRTNsYmdzK1N5ZFhPSmNpaTRxZDZnaUxLVGJI?=
 =?utf-8?B?N2hlZ0dDR3FNUE1JR3dtUXNzcUtqRHRobW9tc3VwTUNZTFdFRmdpdmQwRkRq?=
 =?utf-8?B?Sjd1ZTUzampwbXhsNXFwM1AzQnVoR3p2WFVtdkV0aUlDL01LaFg2QmwzMXpV?=
 =?utf-8?B?cEM2WCtKNDFLaVp4K1V0SGVlSW4zQU45a2FCRVV1bDJqQ3NHNDFHZmY5eUdE?=
 =?utf-8?B?TnVlVkRJMzF6QzZsNDM5Z0l6TWgwZDZJeHZIeFBtRkhOQ3YrMkE1S28wR1pq?=
 =?utf-8?B?UWVqSjBQQzdob2tnWFlpRmZLN2J4QTZDcnhYcnlpMDZ3NTJGaUhSWnUybGV6?=
 =?utf-8?B?WjMzdDVkaVFrM0FFNjVFSEpQVFZ4NE50WEJtK2hpTC9VNGg1elVzTzhHakEr?=
 =?utf-8?B?cU41VWlRNXpveGhQd0RkZkVXZUtxTEh5enVpM1pTUVJ6UmN3ZU5IM1VibzJy?=
 =?utf-8?B?ZU1hL1d0bWtIZXFyTFg3aXZjT2FJWkdTYkd0NVc2V3FqSURnQ2JrWDhpb1JC?=
 =?utf-8?B?RjJYYXlOclJYRFBWampyNEw2Znh6NzA0aDh6RzI4VmkrM09ZeXhRayttVWE2?=
 =?utf-8?B?M2RPYXpzd01Tb1dwWEpaYXBnWkdIQytFajlaWFNBbU5RN0x4SzBPZ1FCOEty?=
 =?utf-8?B?VUlBS3Q4bHRGTkJIUzNkNWhQT3NqcmhrUVNRWkpoSnp1bXdwL3k4YjY0Mm5E?=
 =?utf-8?B?TG0wMUdyMGlEblY4ajhTeXliVjZRUDNNTk1yYmR6Wms3VTcyWTAyd2d5enhx?=
 =?utf-8?Q?5FsKL0e+QNV582NE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9965f5a4-8087-458c-7596-08de62b83063
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 00:07:16.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcILQYJdfM9899j8JIyEBejabudJ/myJmPFWQ7sRvc8KICAT332j52OONoRM/bemeG59km6Y2DS7jDnrem1eeO2JsebBsCS80LkxJy/SXzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8201
X-OriginatorOrg: intel.com

Li Ming wrote:
> When CXL subsystem adds a cxl port to a hierarchy, there is a small
> window where the new port becomes visible before it is bound to a
> driver. This happens because device_add() adds a device to bus device
> list before bus_probe_device() binds it to a driver.
> So if two cxl memdevs are trying to add a dport to a same port via
> devm_cxl_enumerate_ports(), the second cxl memdev may observe the port
> and attempt to add a dport, but fails because the port has not yet been
> attached to cxl port driver.
> the sequence is like:
> 
> CPU 0					CPU 1
> devm_cxl_enumerate_ports()
>   # port not found, add it
>   add_port_attach_ep()
>     # hold the parent port lock
>     # to add the new port
>     devm_cxl_create_port()
>       device_add()
> 	# Add dev to bus devs list
> 	bus_add_device()
> 					devm_cxl_enumerate_ports()
> 					# found the port
> 					find_cxl_port_by_uport()
> 					# hold port lock to add a dport
> 					device_lock(the port)
> 					find_or_add_dport()
> 					  cxl_port_add_dport()
> 					    return -ENXIO because port->dev.driver is NULL
> 					device_unlock(the port)
> 	bus_probe_device()
> 	  # hold the port lock
> 	  # for attaching
> 	  device_lock(the port)
> 	    attaching the new port
> 	  device_unlock(the port)
> 
> To fix this race, require that dport addition holds the parent port lock
> of the target port. The CXL subsystem already requires holding the
> parent port lock while attaching a new port. Therefore, successfully
> acquiring the parent port lock ganrantees that port attaching has
> completed.

Are you seeing this case fail permanently? The expectation is that the
one that loses the race iterates up the topology and retries.

So yes, you can lose this race once, but not twice is the expectation.
