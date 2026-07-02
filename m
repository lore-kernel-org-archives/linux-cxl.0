Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6A37A83D;
	Thu,  2 Jul 2026 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013499; cv=fail; b=FDfJfKWMEqk1kuhXb1rXqLZ4/CVWFMLFcFo4Afz15EUPL7wD68IdR4n4owvo+m+f6NpqPhiVr5fui995QYd/tfr4nP1i8yCqvxU1KkhLwLorcrsHJI0P7BcujRL9CKG6tvp6SFIvYdVGUKZZ1neNj+TDHNWgHbZhlZao2Eovs9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013499; c=relaxed/simple;
	bh=B/vTZcqKewyRdB3fE8eYDbQw7MfP2tMe5DtEV6Y9JMo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=tANKeOvxyZckoX7rjkRRCsXl+/yKl30CnHkGMRNIsTiDcX8T70CDeMAkDhyLv01rt8Wsits31tGdGtluq3lTWKKHV/bkaji7ut6M9/N6PCfj9KIri2uGad/u5Vqtff+4E2B29ax72z/GDN988wY8J2jDLXz1loNPzVcfm+RIu/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GMjAWx1h; arc=fail smtp.client-ip=40.107.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GMjAWx1h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vabs8sQ743ZGCHulCD7Tyr3PE2I0M3OfV4DGVR2MVYpDf5R+Vd8ucg4mHgTtbwX/rmcFZolRnbZ/LMh7tY70fowawCHDisUMWsQeJsGRQhm675BTjPCtXsS9kv8P50G2bq1wSp9TkcYbc1SXDK8sIV6wT7qqhhbqbt9kGoILyUKtw3Ksb4tk9weRbPQ34gQOsOnYiGVbvztAc7ZiViQSt2jWI0rbNBuaiPzMtuqJYMa1s9G65E63AUXqu0WHL9BQx2+t9fdyMprEqLgFZpZRcoWaDuo3ot8VLribqUCFwPr6CSzCqnRbD1zul+Du8OA6Da9+CNCP3O7l5+IAXYoJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo5yLoeXuWuf+nAD//wcllhz2d3upNpzx7rbpTebLjU=;
 b=Pq7ke5/vaffFvyyY61Pfp9V3YsFktAl+mBxgjrvmFYbzco3A273FF80R/mAGHeKo+kOKANmn5caIVzniUEg1hXUiHp3f2QxqEgXuU8cDOLJ9RuiRIfb6xc6CEqxwhhKBlPGVKLBIvEOZAyHXQ8RfuyobTLTBfBaQCoWmHH/i0wIfwDJ3lLcn8/3zBa5RB5nKtINZmKPidK1+/ZNlgcVqK+WRNFIQe+HPczbbn89zhmjtEy2YcEKC+gjpf6nC4n3rl1CLE5fOvgktF0wofrFqd/aS4stAXR+cxiiY5WVMYoc+xgmoaoSepOWL9o15NXSAITS/haMdvhpCZpDrS6YhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo5yLoeXuWuf+nAD//wcllhz2d3upNpzx7rbpTebLjU=;
 b=GMjAWx1hWtkjjGIsfjc3Rl109Na0duVnHmV93q6lk6d2hu4dfXLz5UM8nw/dW0lXnGCfEQW2Tz8OOYeLO5McIZsJ+GLQ0IFj2vd2nxHRpjhG+1e8NKdWI02E1e7W2PckW+7BDKA5JMHWXRIMSY/UXhZ1xHyfFdbzb+Z7yxWPyik3aImz9ljXtxANZ5uFO6BaW9Tbd1PtNflTqW/1ftP79dibLrICz2YwCSKt1hPt7r69KcwRp+D2NeHeXC/1FB62l9ZmLpsJUFZd5RkYIHBRBsEuBEZLjejdZywHVMKj5q3rVFx19HriK5aj7OYhkKft12bufJDaqsAIoj1mSIak0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:31:29 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 17:31:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 13:31:25 -0400
Message-Id: <DJO9J36YGJFJ.3FT7EBHAFZ7N@nvidia.com>
Subject: Re: [PATCH 1/2] mm: decrement MTHP_STAT_NR_ANON in
 free_zone_device_folio()
Cc: <ljs@kernel.org>, <willy@infradead.org>, "Oscar Salvador"
 <osalvador@suse.de>, "Andrew Morton" <akpm@linux-foundation.org>, "Matthew
 Brost" <matthew.brost@intel.com>, "Joshua Hahn" <joshua.hahnjy@gmail.com>,
 "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park" <byungchul@sk.com>,
 "Gregory Price" <gourry@gourry.net>, "Ying Huang"
 <ying.huang@linux.alibaba.com>, "Alistair Popple" <apopple@nvidia.com>
To: "Nico Pache" <npache@redhat.com>, "Barry Song" <baohua@kernel.org>,
 "David Hildenbrand" <david@kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260702172548.37075-1-npache@redhat.com>
 <20260702172548.37075-2-npache@redhat.com>
In-Reply-To: <20260702172548.37075-2-npache@redhat.com>
X-ClientProxiedBy: CH3P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::26) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: cefc28c8-fdff-4add-67c2-08ded85fbec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|11063799006|4143699003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	kmID3InOUPGZRcOMT2DZqhgVp08cowxlAsp2B9N4omPop05CZ+ZuhrtEp+xSoF2f4TWN/JLQKYNqTo1ZzUft/hVJc1YIikYzMYnvKcVdyGT43P4+TfMYpNU/eLvkB0seWPOrUVBOaNcdN97aoZgcFYBkVvZPiiSXoecH8D6AlmiOBOUsSgNiBiOhenBPkeC+9Zvv8deoQl5R+ljE1vJZTV+kKVjSWpOhPScEj13cAdfSyCK4kvDLVPgXA1cOIUOFHm9x3U1f4YZLsWJsDffU+oBqBLvPROHc9QKecTpd9I+PoXDlwYwcOR0/NDaN1ugw29l5Oxt4RHeD1QqnkQaUAc57TvIMh+0H+h8kF5JRMzlbtOGq76zk9g2va5m7RWKnyPu6AHDfCEwFBK6TsnPEfXNrUm7DNBNhFIbUsKTONrBhwQW/KKiwLLxoF9qb6HOlEkAGjTzAe5AwwMX2xJ2WsoeJhBOrI9wuV1gYVTVKXN7ZoV+vtqAObkXlO78P+2NNiNq+7ZrU8t+/i/Lza+gZycUNbspMnCL/tw7gVdoAn20J1+3SOmlW35RRfH2X07jKeyih00rSFHrJ6QVPUoce8TmYzj9532CWB4KDP0HtaVz3S/R17HbCYnNxwyBz7AufJnIoEOIO4ZHC3Wgz+HrmMlX62NLDSzxswjCFb0gpqs8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(11063799006)(4143699003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QURBS0FrMzhFMEdsNnNHT2RBQWlnVjJLNENnS1dEZEJQbGNabS9lZVVyaHVu?=
 =?utf-8?B?a1BPdW14WkF2elgybERHTmF2RjVoQnZrbE1kUjIxN0NvVitTZFR3QWNVM3JL?=
 =?utf-8?B?ZTZ2OCtCa0ZrY2pEWXNQTVpyUmYxOFV0Zmk5c2hreGNGM3VKd3lRVkZMOVlr?=
 =?utf-8?B?UlRHOEo2RzRtNmY4eXBQdWlxcTcrZDVRcloySGZMeWtYcytCejVFK0V3RDBC?=
 =?utf-8?B?VjhuWUJxOTh6UFZTYjgvS2hMR3k1UWYrZmRheVBIdnA5ZG4yZmI3dERaZkpM?=
 =?utf-8?B?RHp4bU9lclJ4b0dYRmhNaHV0aENSeStyMGFZT3VrQlBUTWJ4N3htangzN1pv?=
 =?utf-8?B?eGlNQmNSZWdHdzZYRHF3V3d5bkthekNxQjArbS96MnVDblNTZHBSMEJ2UXli?=
 =?utf-8?B?VnR5RUduSmlORzQvWTBMVG1ZMENaNDlJaXNDQ1JlR0Z1TVdjTURtTUhyZ09i?=
 =?utf-8?B?dlViaU5McHltbUpySlkxQmZvblV1TlZTSzBoM29jcGl4M0JlTnB4dUIzUGky?=
 =?utf-8?B?QUZyV0tMdkdseHNDYkh1K01QcUFEYjJHVGcrZHRqSnE0T3JNUHFpOGdmNldI?=
 =?utf-8?B?N085OWpWSGFqYlgwV3lieWVhSElYWnByN3dPanFmQ0RFemYwVGVxNUp3SDlj?=
 =?utf-8?B?OVBTNWhOYnc0R0JrYnhQcmE0SUl6VVNuS1U0U1MvaE5tY251S2xzbTlDNGJR?=
 =?utf-8?B?MEVnSXZNMEtvWExuUnNEV3Z2K3ZkVW51RWxWMzA0WGN0bFZXNG5WTmsvMWR0?=
 =?utf-8?B?RnZJK0ZnaEhTbUs2YWFjWE5HQlJBTmJFSEhmTE16WVlXdmxNd2JKdEt0QVJX?=
 =?utf-8?B?S3JGZDRyVVR6NmpENzRaQnAvdGpPZUsrYkJFUlFlWnZyU005dXpuRnlKUXU0?=
 =?utf-8?B?RmdpTU1iK3ZKb1pvZkcyRGpGTGNlbURueTJwTTlhRkVQWVl0WU5sYzdlSlZ0?=
 =?utf-8?B?UldRWGNrVjN5M0RvWWpNdHRnb1ZKR0xxcCtsTnJOanlTVTE0cXFCTkZMUWtq?=
 =?utf-8?B?bFVyZ2Z0TlJuQ050QmE5NHhCTGtMWDdTdFpiN09CV2N2cjA3MUVNbnFNOVQ3?=
 =?utf-8?B?Qy9zK2RBWUdvdU9QRjVmQnpPR3Z0SFdUbGVjNlc3MzVQRTFPdGFwenRBUWpw?=
 =?utf-8?B?SmtzZHFXTEw1T1cwWk4rLzF6N2hjb2NlRDRZdUJJQTFqODFVV3VjSW9NTE40?=
 =?utf-8?B?bGJWd2NFWTY0dGRSWlU5ak44cm5hcnVGOUk4aXlGUXBzQjdvb2NNcmdjYmtD?=
 =?utf-8?B?azJnbDdaVzFnVDZYUlppb0UrclFqSTQwYjllRGNEYk9nRnNEMlU3NjB1ZlNp?=
 =?utf-8?B?aGh1UGVZZk5BVUdrQ2lBNFpDQ0tHT3pHQXN6OE9FRm13YlZWWFhtUkUwZGh4?=
 =?utf-8?B?RUkzeE5pcDZyVnBTVFhBaE41K09aT1k5UVZEZkQ4QldDWkhPV2dBSWFnK0Ft?=
 =?utf-8?B?TE9WWEt5S0RYdi9JeTRRQ1BNQTdZRjhsQ2lZblpHazJoWDJsL0pJdEJObzVX?=
 =?utf-8?B?bzJJc1l2SlVlMHZVUnY2MHhGekVjQ05la0phem56VERkaDg5YXU4OEg0aDVm?=
 =?utf-8?B?RTBrc2IxWTZDR2ZJOWdEaG5VOTN5eHhjbDZHays3dmRGZFFnVENKeUpnV2N2?=
 =?utf-8?B?djZuOFNwb21JaVZMVllXdG5qYlBtN2Z2N1E3QlZST291QS83Y2Z4U0Z0cWFJ?=
 =?utf-8?B?a0ZvZFRWTCtGRDI4VlQ2b0hiVjFwa1FrcjVKWm1WbTNtdGI2dEMrczdjRXVt?=
 =?utf-8?B?NUYyNDJKYldCd3V4bVFEeDVKNVIrUEZkRGtDdHVOTzU1dFlFV3dVSVkvbzZ6?=
 =?utf-8?B?VFhFeGIySHEvN3kxWlM2eWZ6RGJJaTVCNS9KZElON3lmODA4QVZNazNpT2pQ?=
 =?utf-8?B?UThGM3E1Q1RTazJvSCtrRWVtalV2N2cwc2U3RGw2clF3N3RHU1NRenFyeStS?=
 =?utf-8?B?OGcrcHJUVGpWZjZFUzUvY0o1c3FqZzMrRy80Nno1MDBYeUhKNU1uQTFBbDJ2?=
 =?utf-8?B?bTE5R2R4U2JEekNzNTFpSjhOZk5tSzN1SE1DeVJuQUZTaG9RQ3NWQXp5ZDkr?=
 =?utf-8?B?bHVna00rdjFGVG1paEFpUE9UWW1yV0hQVk5aQTdhY3NTejRpV1pENHF2UWxQ?=
 =?utf-8?B?bXlrelRJckxlNGFYY1hqZFlxNXFhYVFTUm5jWUpha3F3QW5oRFJyc2tqQ0N4?=
 =?utf-8?B?cmFMcldTRkZYRGY3ZmRPdTdnbXdIMDZpM0Jpd0sxeUVTcEd3RW92a3FOd3I1?=
 =?utf-8?B?NGhxN3VKNnRydHdNRlBUOTdxQzdTeUNLQ2hqWExZZFlUeEMrc1JOSVoxT1hB?=
 =?utf-8?Q?GkzPhc4fP/k5Ur2uDQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefc28c8-fdff-4add-67c2-08ded85fbec1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:31:26.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GA3MCN8RJPYuRk1igE4jTlN+P/Cqf/Rx6Rjh1mrQ4eE26JeNqFApDiRDEdiGhBFz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395

On Thu Jul 2, 2026 at 1:25 PM EDT, Nico Pache wrote:
> When a zone device folio is mapped as anonymous, folio_add_new_anon_rmap(=
)
> increments MTHP_STAT_NR_ANON. The corresponding decrement lives in
> __free_pages_prepare() in page_alloc.c, but zone device folios are freed
> via free_zone_device_folio() which never calls __free_pages_prepare().
> This causes nr_anon to remain permanently elevated after zone device
> folios are freed.
>
> Add the missing mod_mthp_stat() decrement to free_zone_device_folio()
> so that the counter is properly balanced.
>
> Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")
> Co-developed-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/memremap.c | 1 +
>  1 file changed, 1 insertion(+)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

