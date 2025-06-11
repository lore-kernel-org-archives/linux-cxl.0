Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB6D18787A
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667862; cv=fail; b=Wlcs4gGnxBKhgJyBDkyH9jicEd3W8X29pOVHllhq+BJVWjP+GmsG7UqOGKRukmyAWXOUinvfjf3znDS6dKRgBkcLlCBNqYS2m5Ethu7dvS1cKvseK22+yzK81hp1Pul3Q/Fuj9gwspqrBV7v/Ev/yIqu9tGoaCpFHMybmvW8O0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667862; c=relaxed/simple;
	bh=v8eLPUC7Rb9SD2VFmplyd2jaL6nuEkfXBzXMXtRAYFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F2AMbFx78QYqOZLQy1EzuvJPn2nPt+Lx0RhCO/bpHKDvZ68PvzFHP0DVUWpPxH/UGTMmyNj8xOn0ly7o3JP4e9dAlc0JwjCAQ7k7ltPVC6iORhyT7IErO7JKQiRUq/bmJjJP/FqdPSCwPu7hUG3E2A6uNC0P6DdnHX4aHF0FV38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BzkvtepD; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BzkvtepD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoRjbFIDGm6iw0p8RviUmldAuaXJ2LAIJqBrJCHluF+P9W4FkiTWXwgw+ZzQVODz0k5fvtjjlFJV4xaSxWUw3P1i5Qet7s+cKFlzEXidJhRGHG0rCYpQkgeZ7mdn4yX3XMbRL2qAgxR+JyNld0djMdpudgbwWmO8gppENgxJRIPFyDyVN5K4nCo9ZE5/5iw9gJjw5qBRJVcypErFCgOhzKxV1gC+h3kCyX/EIR19VCrShMVseL9RleoQq5vXU9lvul66dq2V4weTWYTjI3ub1lypSC1iWLmuRDPguo3of2o8e2tufEMi9PQdUpfT087OBwMJbGIIwk23Rb27wANX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVji389e8SqnnFJXd5ZPQi4aRA4a0ii01YZa4SWF5Pg=;
 b=ZCY+a6mpJKB4yBz5NutRLKQ1+9B2sYAyoSVAiVfDEXQSBDqqINESQEs94UJdKoMeKvdGaOVdA2dYv2HrabKYGDy8bSBAiZHvVskN4wWqYqkbL9qIe5gMTRp0xY3tz8prvfO+whFYihBgPvZtPQHVybglWHNIthOWQaXB1JChnksCCaADXmtnfQFPEMLdbP6bNuuBJlNvqFw+pe47/xQOaBwhztKcltyOFqiXVUMqzkUNa2kjm2cO6VT5Qf1IQtCWtqd6zMt5+eMh2akqkwsARjGD+suZMWEvzc8kt1u+4/TW/ciEQML+XYYFxa4pTgZzHWwua/ViP6g0YgXnHnKrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVji389e8SqnnFJXd5ZPQi4aRA4a0ii01YZa4SWF5Pg=;
 b=BzkvtepDh4d5ujSd89wpeaLEGm6ASR5s7A1AQMRn+rSyLPAcGCZG8KfCNO2QoIxsu9NfFsUHowkQZO6Io5i47m3b/GTwU0wLoAU5ohftSULnw/WMK3E+QyuRed40q+9yxR5JTZbTvvta5GvYedXmZuiHh1p5NB2EALpk0/V4HVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 18:50:58 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 18:50:57 +0000
Message-ID: <90446530-8817-40a3-a1e0-102ece46ddba@amd.com>
Date: Wed, 11 Jun 2025 13:50:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/ras: Fix CPER handler device confusion
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Li Ming <ming.li@zohomail.com>, Alison Schofield
 <alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Tony Luck <tony.luck@intel.com>
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250611171721.2048408-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0345.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:f7::7)
 To DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: ed69d088-f7d0-45a0-4896-08dda918e6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXM4em9vYVJTeE5zVFYvUFhVMkIzQURZZ2dvYzNaWmZFbVBIbHJaODI1d3Yw?=
 =?utf-8?B?a3FGRjlwUFVmb01PZ1k2Tlhzcmo0cGZOYUR2MnRNTGNKN0NYRlc4WE5LR0d1?=
 =?utf-8?B?Y3hPQ1lJSmJ3SkxFQ0JjVDlJY2dOQjlHejdiSHV6K2w4aDJPTWgwNW00c3cx?=
 =?utf-8?B?OFpJbnA3SWU0RmlRM2w2aEhrcFpjK05EbjNldTBWWTVsZ2dwa3dEZ2w5SVlT?=
 =?utf-8?B?RUJ2c1M1Nk1JcUFncUloRUlXd1Z2OHV4N0JYaUZtMDBjNUNOdS9VckVhQlZL?=
 =?utf-8?B?NDZFRE40WUwrT3o2TDJXMzdwMXNFd3ZaekZiakJhbmRuYVdnOVBhYTVRQTdn?=
 =?utf-8?B?TTZET3doS2xIa1NoM0llT0YzQWxjM29MY2RwdE9mSWx3QWZjZE9mN0t1akZp?=
 =?utf-8?B?dDZEa1k4NjRBMkJXZVdJT0lQL0hLcExKZVZ2V3pUODdDTERCZ3NuQlp5TUJM?=
 =?utf-8?B?MFUyQmplWDhCQXQ5V0dFM1llU3N1ZS94RWpEOFZjd0h0dlFYVmIxTlZ5Mjd2?=
 =?utf-8?B?Z3VhekFEQ1YvT1VGUGhFT05ESnAwckJwa2c3OC9kU3FKanpDUnZraW5hcWIr?=
 =?utf-8?B?NmRJSFY3M3kwdWxLTCtXcStXV2VXV2R1U1RMS3R4ZUdBSnFxa1JRUjVWZFNX?=
 =?utf-8?B?WHpldXIvWFpLMzJmQ29xZWFIYlc3dlA2UU5aUktOenFWaE0yc1ZSTEsxd20r?=
 =?utf-8?B?Yit6ZGFVOVdGNCtQdWFEaXdCYURHRkorWVdCUHNObUdMUWMrdGIwQkh1aEtG?=
 =?utf-8?B?Y3B0Wmk3WTI1TTBoblZTQmNKVnQzc2lORGFxbHNBcjMvWGJqS1dkNmtzMHJo?=
 =?utf-8?B?T0RZWWdMVlFHNmloUms4RnNBK3FHeEY3V3U0ZXcvRjRFd2xKVTlhNkNVTnlF?=
 =?utf-8?B?bTVjemFKcmhYODJYWWR5YTQ5eW5SWkVIcWh6RllyVHEyWnpjbXBFWng3Qkkr?=
 =?utf-8?B?TmJtclgwNEQraUs5blNKVWJlUW1QVGI4RVRiSjNpMUZmYjVTRWFDM2FtNy9T?=
 =?utf-8?B?TkRybXZQbGJFTnlrSEs2Y28vRXA1MlFaU2xyaWNPYnhwbUVEWkprSzllMVRr?=
 =?utf-8?B?eCttT2twc09MMEpaRU9nV0hnMHdhamdsOVkzN3dzZ1UzcGNPQXNBYWdldjhU?=
 =?utf-8?B?MWNMZVNqbkY3a3ZJd3cxQmVHUWszNU1JU2ZoQlIrQnowbjRxN0xXcWY0Sjg3?=
 =?utf-8?B?RTYzRzgzSDhaMG5ySTJ2NWhJMUlsa01qa3ZnWVRsSDRtaTNWUy9WOUh4RGNp?=
 =?utf-8?B?K1h4cGZJRWtMRWduMHRpRngrek43TlhUYWxRaG5BTEtKNHBiMThZMmhEWE1K?=
 =?utf-8?B?NHZMM2I3M2FjS3hOa0RWSXl0RDdHaW1lSjV4Z0hsSDRURThPN2U4Rk1Sbi9D?=
 =?utf-8?B?eW5jK2VDTEZMeGpYbmJsZTQ2NlBBUStualdWMjV3K3dLZkt1OFF3cjR2eVNn?=
 =?utf-8?B?S1BDZjV4ZTJoK2ZFYnlBV1lpcldxWUpMVnZXUzc3ZGovd21wS3orekYzWm5W?=
 =?utf-8?B?R2wyMEVOdHhVL3IzOHR6WDNBWnlLNG5qNkVIdkhlWFpQdlJJbXdHNHZHTUN5?=
 =?utf-8?B?TVFVb2JIWTNPVkY2Tlp0aTNUei9jY1NKektXNmU3NEtVWDdnd1FjelBVVjRp?=
 =?utf-8?B?SjdDMjhxV2JaRUlicGJXd1I1UU9qUUJQakZtRHVRUHhLUzd0S3pTa3ZpYTNp?=
 =?utf-8?B?ajVPUEhFZUxtdmpKVS9TWmlBVlFxS1Z1dlBoV0hGQ1pyMkVONUQyTFRCVHoz?=
 =?utf-8?B?UDBaeXVKcVk3Wk4wbmVMVHhoaDl3aGo3MlBYU002Yk5aVlNGeWxxcS9saXhJ?=
 =?utf-8?B?bTR1NFFqd3d3REVFUjY5bm41bnE4U21TMHZNS2ZUOHM5WUxCUXJzcE5CdmVW?=
 =?utf-8?B?blQxRHIycTlyay9mVVg1TVBRV0d1c25qNlQyR2UrVC83MWthMFlWVjVhYUpl?=
 =?utf-8?Q?D0g2im5lDbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHQ3OUNjQm1MMlJrUlluM2o4c0VoWFdxZ1VsWFVwWE1JcEEvWVVyOGZuM2l6?=
 =?utf-8?B?QVgvSml5emUvc0VFMVh6dkZJeDdpMThRQ21FSG9CaDFHVTRldzNlZzFDWWM1?=
 =?utf-8?B?SktqYXBReGxFUTFRaGlUbkNPdWNZSTRaR1VGcUgwUHZZaDY1cEZlMllqb3l1?=
 =?utf-8?B?SjZhWWtVN0QrZGdMR2hWd29GeXlCYU9EK3VLMEJybkdnQXVnc3psa1VxSEJE?=
 =?utf-8?B?VzBIVmtiVldhVEtZcmIva09qMW1Fa0RRbDM3eGExeDNYekNRandzZG9qSC9t?=
 =?utf-8?B?a1hCMUNlZjNNeFBOT0pMM2pZb0c2Q1BCUEtXYVprOUY4Q3BjaEoyMnNmemxF?=
 =?utf-8?B?c3JxcGlxVXRRdGxQMHVINDdQRVhNUUhRaDErZkd6T1hTamdZU203MCt3NG81?=
 =?utf-8?B?ckx1QTFPclRkeDlJTFpRT1FSY01XRFoxZ093cE5iam5pZjROMkFxbXBReVJR?=
 =?utf-8?B?bzB1Q1VPRXJ1MDJEcGpHa3ZKRWgvano3UFJkcjdmaE1yaUVrUWc5UFZlbkc4?=
 =?utf-8?B?V0xlN2krdmxVRGNpODFCTnlLSmgraWREbGFhR3FjTnZHRExlMnczdVRqOVNG?=
 =?utf-8?B?MkxuVnNrYm56TlR4cDVBZy85UnhYVktlNEQ1TmRLK0NURmVuYzJSdk5uMmdj?=
 =?utf-8?B?TUtiVndoR3lTRlFXcEpFdFhRNXJ3Yk02SHdaRE8vVTNSQ0NtR3hpWEpHYUFm?=
 =?utf-8?B?ZEJUMjkxMUhDZmYzR2hvb29QcFJsR0d4dGpkMWpKakxMK3Y2TWRGQ1lONW5k?=
 =?utf-8?B?dGpIOWpzMjh4dUVzbWtGSjdiZnJzNEJ5N25PdENnV3o3MVlrQUN3UDNaTGlx?=
 =?utf-8?B?OHhRaE5UYzhMRDZCcXQ3TXl2VjJKVFNuNzQ3UE9JTUl2dGc5NU9Eb3RSZXZK?=
 =?utf-8?B?LzEwbVorRjhKSEN4RHd5eWtlVUd2UytjZjA2UkJ3Y2luaUFxZWdOeWxESmg1?=
 =?utf-8?B?eWxCMDBMOW1QSnZYc0ZRcU9GSmRUY0VNZHhCVEMzWU9ZU2VqVStQNTIwbG12?=
 =?utf-8?B?MVFzMk12YTRiUFVoOE43Y0NxdmtwSTZUbUZEbWpJeFRZZFBVREJwdUJ5dzJX?=
 =?utf-8?B?UXhpOEFIUVFoV2ludXRzUW5VaHdVS3AxN0hEL1J4SmZJL2Ztczk2amhDNHll?=
 =?utf-8?B?Si9hOUFwa2NpZHJOMUtRL1BuQnl3cGgzblZ6WXFOckNnRk1WMGJ2aVhvTnRC?=
 =?utf-8?B?MTRJeGliQlRqOU5mMGYwNjl4NkVMVlo2Z3grSFpoNlJNaWNOUmx0YldrNC80?=
 =?utf-8?B?WXgxdTN5a29FczBFRHQvYzBKK0NBM0QwWHBrbGYxL0hNNEZVQVJkWndqUmEv?=
 =?utf-8?B?V1VheVYxZFhvL25MeHlTRnJOTkhJb2x6ZXNrK2hXdXVGekZ3d2RIWktIVEh5?=
 =?utf-8?B?WFJGVGhjeVNDOXRBd0R2SEF4TTBpSi9lamdWOFJhSFZ1YVU3eXdVelFOcXBB?=
 =?utf-8?B?QlcyRnJObjRscHZQaTRJMVpGTVVrZkcxSXh3REVsMVFXWTdycDNZQ1JiWVJU?=
 =?utf-8?B?M2lsWk5TSWQzUVNwbnRpbUdSQXNTcXhBcFhKbDd2OUk2N044Qzl6eGtOSjhI?=
 =?utf-8?B?a3l2eTQzUERNTlRWRVJibVJtVkxIT0cxTmZCVHZINE5NZEt0THlZOHBLL2Zp?=
 =?utf-8?B?VnY5Unlwb2pVWE1qQkNiV2w2QkptNHZhSUtSZmI3L3dUbFcxb2dKdnJCdEhX?=
 =?utf-8?B?cDBheG5mY2sxNmpvMmRhUThZYUFIbVJGa3dmbzNEQVlyQVFiZnlsRjlJZWl4?=
 =?utf-8?B?NnVOYWhUZzg4SzNyV3BwYzF5NjNicWt6MDNRVmtPUy9mOGdOcDlod1hzWjY3?=
 =?utf-8?B?WUVhVHY2TjRwQWJRVzFSd2xpdGNVL1NiK2VrR25MUHVtcFM1Z3ozNWJBQVlz?=
 =?utf-8?B?azBJaDJ4d0RtelF4U0dHVGZPcmYvajZuQnBGMkxoRUtaamlabHBJSE9hZjJR?=
 =?utf-8?B?dC94cXlGbEtxNW5RUFJpb2RnMWFsTCtYZkFKMUNybzBkTDJWM2FJYlIrTWVP?=
 =?utf-8?B?M0U4WXdDaUdWMFN0dlBSKy9oQ2dXR0RYelhBN1UyeEVGVldBUVdVZ3UrZVky?=
 =?utf-8?B?OUx4WEJYaXQvVTVqSDJBeFhjSjIwbUFYOVNUeDNNdlAwQjc4b0tiVFppdUFo?=
 =?utf-8?Q?+T4KKAw02QIEvxDZkaTm9fk/r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed69d088-f7d0-45a0-4896-08dda918e6b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:50:57.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmNFoNAH7BmXREanfsfpWirpdXa1vTbXSUN0NInpqNP08UDsGwz9UnITo31NiHnQcbsvTcPfw5+XhRTNqgWjJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407



On 6/11/2025 12:17 PM, Dan Williams wrote:
> By inspection, cxl_cper_handle_prot_err() is making a series of fragile
> assumptions that can lead to crashes:
>
> 1/ It assumes that endpoints identified in the record are a CXL-type-3
>    device, nothing guarantees that.
>
> 2/ It assumes that the device is bound to the cxl_pci driver, nothing
>    guarantees that.
>
> 3/ Minor, it holds the device lock over the switch-port tracing for no
>    reason as the trace is 100% generated from data in the record.
>
> Correct those by checking that the PCIe endpoint parents a cxl_memdev
> before assuming the format of the driver data, and move the lock to where
> it is required. Consequently this also makes the implementation ready for
> CXL accelerators that are not bound to cxl_pci.

Hi Dan,

The AER CE/UCE trace routines access the pdev->dev and pdev->dev->parent.
Doesn't this require a guard() lock for all callers?

-Terry

> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Cc: Li Ming <ming.li@zohomail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/ras.c | 48 ++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..1173eaff7e2b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -31,40 +31,38 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>  					       ras_cap.header_log);
>  }
>  
> -static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> -				  struct cxl_ras_capability_regs ras_cap)
> +static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
> +					 struct cxl_ras_capability_regs ras_cap)
>  {
>  	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> -	struct cxl_dev_state *cxlds;
>  
> -	cxlds = pci_get_drvdata(pdev);
> -	if (!cxlds)
> -		return;
> -
> -	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	trace_cxl_aer_correctable_error(cxlmd, status);
>  }
>  
> -static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> -				    struct cxl_ras_capability_regs ras_cap)
> +static void
> +cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
> +			       struct cxl_ras_capability_regs ras_cap)
>  {
>  	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> -	struct cxl_dev_state *cxlds;
>  	u32 fe;
>  
> -	cxlds = pci_get_drvdata(pdev);
> -	if (!cxlds)
> -		return;
> -
>  	if (hweight32(status) > 1)
>  		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>  				   ras_cap.cap_control));
>  	else
>  		fe = status;
>  
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> +	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
>  					  ras_cap.header_log);
>  }
>  
> +static int match_memdev_by_parent(struct device *dev, const void *uport)
> +{
> +	if (is_cxl_memdev(dev) && dev->parent == uport)
> +		return 1;
> +	return 0;
> +}
> +
>  static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
> @@ -73,13 +71,13 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>  					    data->prot_err.agent_addr.bus,
>  					    devfn);
> +	struct cxl_memdev *cxlmd;
> +	struct device *mem_dev;
>  	int port_type;
>  
>  	if (!pdev)
>  		return;
>  
> -	guard(device)(&pdev->dev);
> -
>  	port_type = pci_pcie_type(pdev);
>  	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
>  	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> @@ -92,10 +90,20 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		return;
>  	}
>  
> +	guard(device)(&pdev->dev);
> +	if (!pdev->dev.driver)
> +		return;
> +
> +	mem_dev = bus_find_device(&cxl_bus_type, NULL, pdev,
> +				  match_memdev_by_parent);
> +	if (!mem_dev)
> +		return;
> +
> +	cxlmd = to_cxl_memdev(mem_dev);
>  	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
>  }
>  
>  static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

