Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F81337A839;
	Thu,  2 Jul 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013645; cv=fail; b=SeNxUSh9WaY/Alx5f8bCd+akuD7DhfBa7DCLIXkyPkumDnlH2kYY4AbfuA0sZePVIXO4jdySUKmucznmOYXy9YFgdxHR9JrwbXutMKUwDjKRGoAu/CupbMpiO1XkTKPnXJeZ2RrpAN/zpfr4agM/iTDUuYtSk68mQDo9l1zURBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013645; c=relaxed/simple;
	bh=Aht7PLb26+09pZX8g2Dz9ZaG8TQlgszBa/42BeffRQE=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=BVOdKrvroQm6Jb5GWvxnD1YjIOWLMVUKzIOw7EIRYB0DxzhF+9K+GC17YlKj72c4kulgH0oWRpfM+Qc58gdqlmqixIL3OrqDos3zUtXM7BKPaRrkdFnMxBy8ir14ITMYjj1gg/+0HvbmEXV4MxXeDWpnXKQ2PQRTjo6pxLjICFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jJRNH/55; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jJRNH/55"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4UOC1+nAQ2tDST6ohAm/8DDs7mWrrRaAHT6uqI5xoxytjeyPL7TXB828AwMQd2NuCqty6eOUNrIYEAw9tvZbxouqnJOdnytUNgRrGvN3qonWC+gZutUU3VgPUeh4knkUELcM5DFx0sgDpxDKyneaOpcnTfj7GL8k3/dn4l3E5Zvk3g7V3AO+6jieacD1g6kx9Fsdvp/K5KI/WVH9ZWvVf6PaB/TeuQO20L3Lx98ywIgIiNs6KfIM9w2ZK3u3D957ObPTaKxZHKnvPSVW4paBa3tvB21RKp8MuaUu513mO2jbUGPqA0B1MyAcugEsamUE2v0m0bMrAw7yYZPNt2aKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyU8jgp8DFO+4/4o5t0h2KqM9k83CiQMli6/a7lZNzQ=;
 b=cnDeJZT1amSqZN7JO6XewzhxjwXNpczKlJ9gMCoPsgyhXLG+tEh16hFHeR3eRupOg5jIKXismNFBNa6y/FkQLspaNvcrexDrgUgXJZsW9xajGnKjmxgB6llu02GT9IvAl5Ct4D/nM40HTy7rA24vEo9qQE8kq0vY0pj3vyImnVQw/k2HsB99nrQjML6jrlpaPmRBev8ju/fPEBPNVJrtMsd4vOdOkwOvUMk4R9XJANikZZuRReEHU800W65SDMeCRW4iVQgQQDqupaieSEOr9NeRMREHvTkitVrWEOBq/EzRunA5f1hP/a36O6pYKD3QqNAkhA/55xAb7RgenBoGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyU8jgp8DFO+4/4o5t0h2KqM9k83CiQMli6/a7lZNzQ=;
 b=jJRNH/55LDBgsayi3lwwO09PSdNw5t0K+44PXnHL+tmeDMCGEe2UstObTB86SZUjQUA4GozG/vegp8VUQgxevMPiUOPBBlp/OeBT5h71+v8G7koRBPhETWD8j0+RJNqP6v5DWBvnWWHOJKZHikK0fOZSaH2Wvv6E3aOJC3lUhFrA/1RZMG5uMvM+w9n5EAFQHSPycbTKjkoC9b9B+qC43mmX73cNuV3U6IyFdtfq2Bn1iD0EE8P50IHayhkrGjOcFDZAUqGycH2WcxJN4yjj0XPn8NXUnoiQv+QmLgAKh+N1y04HfznJlPfxfLSe+cLU1ntdFRPaLmZWvJjNvk451g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:33:46 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 17:33:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 13:33:44 -0400
Message-Id: <DJO9KV3KOPWY.3ESKX5RFMW2M0@nvidia.com>
Subject: Re: [PATCH 2/2] mm/migrate: exclude hugetlb folios from
 MTHP_STAT_NR_ANON accounting
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
 <20260702172548.37075-3-npache@redhat.com>
In-Reply-To: <20260702172548.37075-3-npache@redhat.com>
X-ClientProxiedBy: DS1PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:8:23e::14) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ccbd98-b559-49d8-7071-08ded86011e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|11063799006|4143699003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	DiLI6HT6T6ih440n4QIWA+CpbUyyeht5utNTackNKjoT/MNZaL3I9Z+MObwo6RW7GiKJaqb1ly2i7E/kPmrRV/Y3uBA+69IgbCRpQyCmc3Jo545aoPYShaLTm7x3cfJRqmHOvQqIvReSAuRomr6i1jskhxak8Q93IDgFNnkPU12I4qtxXwYyU17BxSeILZFrcwRwbrK6Rl+9vBntAcDjx9pBdrwLZqu0g6DMXIjnF/n1bADvZar96v33NtQ5kaj1M4JaMR9bd8vSt56SuobVY+jIRm/0XO5S7ePpRdLCtySJLyunJgIXmAbcF0qb2RdFN8FczkSyGglqUiqIPJj5/alTAA84UGONBkMai8vetsLRf4mOR0B/NAfZ7r9f4Vo2+mPqqpxqmJZOUFXIXhLeJqkRr+U5YY6AYXmCLemA40Mdi0fC0cQVhJTg/qbcmD/Wxy/zOZn2u5TLIClf08K4DyNXh0DlTxPJm5bsc1FFhN9yRKt+l7ReRur0f0kkUdO6LDyH2pOhw3yES4RQir70RVCs8Il9HBGMHYd2yPOiB/bIPXGOl+gMlEZ9r2q7jB+CKf71XZ5+Z9TKOyDJkOSTW/w/c32SglWKfemfTFePYhDztIju9DU3lA1dll/M+I5DCjRqDdQ1CAAxFKT9li6lgDwJtuvh8MgDLip/oD5Y3gw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(11063799006)(4143699003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0d3MThORXI1aTROcm5BZko1Z25GM25rRmdsS2RyYVQzbWN5YzFlek10aHBz?=
 =?utf-8?B?UXdxbXR6emlaUFRNTm1LWVEyYUVVZGtpcWJIb1JVK2IrdWovNzBLdTdpRjRH?=
 =?utf-8?B?dEpEbUtqdkx3KzkxbU1ySkZtazgzUnRLaE5RUWxMVlkva0hvWVhOcjdPamdH?=
 =?utf-8?B?R2ZZMXhLYzJHTmZFRkJ0V0w1Uk4zL1lySnVxOXQyZmRYR0Z3TXRySHUrcXE1?=
 =?utf-8?B?UzUvUGlQUnZIMFEwdDFzWEhBUEpHaktYMU54czg4cUZ1TGVRZFYzU25xV3Ji?=
 =?utf-8?B?bUgvQlpyNTBlZ3hsa1Z6VkNla3ZoM2t5SlhwUEdRNEhJeHpIcUdreXBqWGdr?=
 =?utf-8?B?RnJkRlRHeUtWd05ucVhOM2txZjBuWTRDbmdkWEhoRWh2NFoxV1BkaFpRZ1RP?=
 =?utf-8?B?VWpQU1BTUU41M1JXNThlb3B6ZkxsUHVocURKMllxbEk4Q1JIbWJjU0dQTGVO?=
 =?utf-8?B?K2RjRVk2enlqdzJadUhHT2RyTWQ4SHNibDRBVGgxMXZmekpybERxZWFvaDBl?=
 =?utf-8?B?ZjBjSjI3Uzh0ZXE4QUtISUNUS1Nva2pUQTRuYlBITmZUY2JGVzlab0ZteG9B?=
 =?utf-8?B?WWl3aHBjeWZSemNpMkVEYXRPN0RiM2dOUThDTVVML1pNQmdxNkQzNGRCbzdF?=
 =?utf-8?B?WVNKVzZma0lpNHJ5bCtrS1FBdHBqQVovcmZ1Ym9wUHliWk03N1JDc21tMERE?=
 =?utf-8?B?c0E0eXdhcDRoWWlOQ2IwUzR5UkZINDlYcmFOTnJESHlEeFhNTXQ3dlNmNkIy?=
 =?utf-8?B?NWdRV3BxTlJvTnRSMGswdk10ZWYxTmZnMWduVWFDWVdSRFpmZTlTOUx3SDAy?=
 =?utf-8?B?bjExejRPT3Q4aVd1ZlhMd2tTUW9DOGlKeDNGcWVJUVZsMm5oeXdaOWVaTXhk?=
 =?utf-8?B?QjNkOE5Eek9LWUYzTjdBVXJxN2tQd2dBc1YwcGx5YjdzNytxYUJXZEt4a0ZG?=
 =?utf-8?B?MWMrRDhKZjNvTjZoaDFHaUxVY05INnZMYlRKZW5RMWlmenNDSFl2TExzZ04r?=
 =?utf-8?B?NlgvUmgrUkhPUy90anBpb1d0VVB0aDJoQzFYdDN2QTUvajlKRFBHQmtoMGNN?=
 =?utf-8?B?Q1JuNENvcXpJcWRjS2ROUWxlQjFEV0ZCVVhZT3dpMkJoZnRYVERYbkFOZFZO?=
 =?utf-8?B?Tm9zdWhTcUJOY0RKSVlkU0ljbVB4bTNVTHREcmcvMFZyK0hHQjRVSHV5NHEy?=
 =?utf-8?B?a0pzQU9kc2o3WnNONUo1WHJBZlF6aXZhTStqZGFBMVdUREFEd1owcTNEaDhh?=
 =?utf-8?B?VGRETjZ6Uyt6dVBCc0U1Ti9lWllVNkpqQU5ZdGxXZXVURVpVdjk5RGNOb2RS?=
 =?utf-8?B?WGt6azF5eFlJTFFGVlRUV3JmNDRLSndCSUxnVlhwbU1YM3BOcXJXS2dTRWxj?=
 =?utf-8?B?b3duMy9SWE5KamFxeDBNMDFMOUxzMDg1RFR0Ym96S3VoVm12VzdhUElBb0tG?=
 =?utf-8?B?MkNtN0Z1UHQ1MHNtSDQzb0t4SWdtZVZDRlQ4UTVrU0x2TkgxM0ExU2pXc2gy?=
 =?utf-8?B?ZDR5QUo1QWxPUTNqdnpoY3BsczYwejY1Y3lCRDlWRkQzMG5MdjNSQS8vZklB?=
 =?utf-8?B?TXpocmQ1NTk0NGpZcHJVaG5hRldtY0lsUzl0Yk10cjVWeUZ5MUJqU3htNEp1?=
 =?utf-8?B?N25IbEwwSGgxZmdPMVEwVFpEaGhIT2ZwczVKVlgrMUE3MGZvemZMWm9LeGtZ?=
 =?utf-8?B?blk4dllDMUEzTGJiNUliSkxqQjFqbkZJeS9CU21KWVFYdlRZSW83SEJyTHcr?=
 =?utf-8?B?OGx4RHRuU1JYdS9jMEtZa3JvazJBMnZnWUg5a0I5SCtpc2NyR20zRVRZL0dD?=
 =?utf-8?B?U3NZQ3dZYlpUSmhaMWM0Njh4MW9XekVNRjJGQ1pBRXE1VlYreklYdU00Mk4z?=
 =?utf-8?B?NFZXK0l1TFNNdmFlOTQ2WERlM3Y3VEtZejRmbEdWNnZVaHo1SE9zOGhuV200?=
 =?utf-8?B?NVBWVXlSbkJFbjFsbmhaV2lWSWo0L2VNRlNVN1VPRitFaFFNVFhwRm9HMUVz?=
 =?utf-8?B?SnUvdlZtbitBZlNjSjB5R3hPcmZmc2VhbCtNQXZwbER4Y1NvRVNOd3pWZGFT?=
 =?utf-8?B?TlV6TGxyNEFiWHU0enRrRktyQlhEYllLN0plNFFndzYydlBBRHc5WW1PdkF0?=
 =?utf-8?B?NnlaQmt2ajR0dUdtd0s3UWFYejMxZEFqMUlic3ZpRkJqZkVIam1XZkIvRW5m?=
 =?utf-8?B?RmNDZ3RYekRRNHRkMjdsT29pOVdUSXB6YkFmcWZBWFlsQSs1OUk1T2lKN1lL?=
 =?utf-8?B?OWJQUUxLS1pqK2hoY2t2UjdKUUc2WmRua3RKaWVPM0ZYK2RBQWEwZW9Na3c4?=
 =?utf-8?Q?FdXj/duPskIz9YI4LP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ccbd98-b559-49d8-7071-08ded86011e4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:33:46.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MknQ9mebtchH99RsfSvdgppzTFSK8Ar9JZG9jbJNOV87DqpZtbrDmuS/899nuf87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395

On Thu Jul 2, 2026 at 1:25 PM EDT, Nico Pache wrote:
> __folio_migrate_mapping() increments MTHP_STAT_NR_ANON for the
> destination folio when `folio_test_anon(folio) && folio_test_large(folio)=
`
> is true. However, hugetlb folios satisfy both conditions despite having a
> completely separate accounting system; they use hugetlb_add_anon_rmap()
> which does not touch mTHP stats, and their free path also bypasses the
> mTHP decrement in __free_pages_prepare().
>
> This causes MTHP_STAT_NR_ANON to be incremented on each hugetlb
> migration without a corresponding decrement, permanently inflating the
> nr_anon counter.
>
> Add a !folio_test_hugetlb() check to both places in
> __folio_migrate_mapping() so that only actual mTHP folios are counted.
>
> Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")
> Co-developed-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/migrate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
LGTM. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

