Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D81139D;
	Tue, 17 Feb 2026 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366922; cv=fail; b=E6I8FjqEnC+1u+5vQkbQRsczBoRHYAtYYcX/jot5Q/WCaIkR5RlCoebTmY4v2Ka1t9BXB9uj+nl9sGPIYMFLSj9FfdJTewe0bug6y178Y2AKpEPp7S2XWUVPX7ntsrTKQhIzn5Q4ExevjZCl6gPJuvIUnoYq6dRof4pzs88kfGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366922; c=relaxed/simple;
	bh=07f596FHhkKrwnHoEDciRFqRC4QBVDoo48mG6ZK9Sjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u7r57kUqrBOKgfp3f4/2Is8j32G1JoYtNoB354zEF50ryVAcK8JgZVqUuQ72E2jn3peJZ2cvWAWc5XDqdB3xhArETUrcrXaekd+dYakUMRdlt6ixob1GNGOZzPcroZYYXwFphfsOgIsnIc3PIWu/9krR/8frncttXWBwydaAxjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ldBhw1yc; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ldBhw1yc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA1tfN9xvhPbdMku0XrEU6U7N/qiP/4G+zU9mKkNXzAXt2CGu409Sxd4Mxydg7dar19sGlz6/Y7cGw7yikdZOkc4VBdIK4LPgrS9s1+fQPkvFALE22AZ1/aEnqNzfEQazDuqrtynFbJYVkwZlM+qEZK5ItHCFq+7LXWJCvpU43TaHKc9sApmYFTIRo6RN+Tyk3xGcIRQ8Z+IDsanNd/c9H4K/b2H1e8se//TNlh2DF2ysaE9zHH8fixdhCPlaJJMcYaQD6DC8CetWX+W4eQwrtDjMGOu+NydvcdpOgRUlegVgfoyJs408eOZznvk1VA/QV2q9LOYKgwrS9DgjG2+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVfWk6z+2vQlUdTp6O5tK9MJs9fHEdBuOitF6ssuhFs=;
 b=Q+/TdY+pJupNJDCuqo3eOriwPTnHSnnyHMWXLeZiU7gP3vk+vdk49j2kl2/rdSGDSt/4reBS2Q+WQPLRHtEeWcRK6JhDAefSMlmnXMYJ0+3Nc5xVJyJ4gTMrySLegkEhhfBsV7/aZGOhv/t0mf63MYHXTQ5snPScQhUyOE+Ufl/YwxC3U3pvg4VXz8+gdHOfegE1uqoQIQ+GvUNwoHTS2UaVCE2074npKuOBPuX+rMnz/bcEyepaV6F51FNTFM1K20gyYmOQVq5AL+6BsjpfbR9lIDg/F34hgKBzKAAoxCc6TWzka0X35f22K5ToiPrxh5KVaab1wZV3F33QcGQNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVfWk6z+2vQlUdTp6O5tK9MJs9fHEdBuOitF6ssuhFs=;
 b=ldBhw1ycZtrSU4NX0f2xtCyJiCfQ85M1/WdZkCHyjef76U0kLx1Zc05w1htdLjW98d5fmIDnhQafhzl3uO25RLXSSiEn7I0YZA/u2e3lQ8AwEzuoTXEJwQa+V2A8uLY2i6ZWt9de6w1bbfaToRZ62tjMDozXK3Gs84Nxsyw4maI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) by
 IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 22:21:57 +0000
Received: from DS4PR12MB9707.namprd12.prod.outlook.com
 ([fe80::d9f8:9ebf:8ce:6e6b]) by DS4PR12MB9707.namprd12.prod.outlook.com
 ([fe80::d9f8:9ebf:8ce:6e6b%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 22:21:57 +0000
Message-ID: <e5deb402-b07a-4fd5-9de0-570bfe9ad715@amd.com>
Date: Tue, 17 Feb 2026 14:21:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax/hmem, cxl: Defer and resolve ownership of Soft
 Reserved memory ranges
To: Gregory Price <gourry@gourry.net>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260210064501.157591-9-Smita.KoralahalliChannabasappa@amd.com>
 <20260213144704.2780265-1-gourry@gourry.net>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <20260213144704.2780265-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::35) To DS4PR12MB9707.namprd12.prod.outlook.com
 (2603:10b6:8:278::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9707:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: abfc9602-d3c2-4a89-4213-08de6e72f603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmVEam5EVFBXMHFqZk4xZHlGcTh0N3l0b0Q2VXM5dlV0aURHb09NZ1AyTUpz?=
 =?utf-8?B?d1dScitTeEpERE1UQkhzMEw4UGNnR3VXcHJqak03Sk1ZbFl1b3M2dkZlaTNJ?=
 =?utf-8?B?dFoxUnI5U1RFNjdYUEUzcDBnZWtHam9yeHFkb05Jbk5XS3NPWTgwTUlLUWND?=
 =?utf-8?B?T0ZMYS9DelUzRFpva2xjSUoxZllZaldxWkN0YmI4ZEQxTnFIS2tNWGJKQ3Zi?=
 =?utf-8?B?TjVGT2hmdEJwYlYyZUR3R0VIeWQ3NFFuU0EwaUw4bDlnWXZGMlFHbTg2SUl1?=
 =?utf-8?B?NzlBL20vWVd2dERhUjZWNTZ6M1I4TEtEK3RpeTFsWm1IWFBZY0tTM1lPR3NE?=
 =?utf-8?B?dkZFNnRRYXREV2JDOGxQTXpHd0FnemJ6ZGpCN2JaYlFyK3hKKzJvLzdobzRm?=
 =?utf-8?B?bHpkVndJMkFPYno4cnpzSEQ5UEJndHB0WE81TDdYSnZSbzVUR0REQWMyZmti?=
 =?utf-8?B?c3VVVWlBQ3YyaFFHR0tOT00xRVdPbDU1dDE3bEM5Z1lKYU9FOTNDV1BBTEpz?=
 =?utf-8?B?ZE5xZXdFN3JPZkllc1I5U2k3TW9zQXlLUFpEV01UZG1FQXhSemNrK3p5Y3Rp?=
 =?utf-8?B?S0FqYkpGOXZLcDZOcTNYK3pzSDhvMFJKSFJSb1Azc0RVRVBrQWF3K0tvSFhO?=
 =?utf-8?B?cXo5L1lBMUd6dURmV0FtbEFMWFYyeEtXeXVBUXcxaTlCYzlERVJOKzdyb0sx?=
 =?utf-8?B?RkM2dzFsaEQvWjNBcFA0ZGJ3SFl2aVJOQ21NT2NaakQ5REh4K21HT2FGcWdu?=
 =?utf-8?B?MXJEcmFOYXlMaWJiVTg3ZVgvOFBwVzhGMEVnZEcrV3d4L3dHM0Uva2ZwOVNt?=
 =?utf-8?B?VUlqRklyTG5YTm1qRS9SR0xnSzBDVWFSazRQVDJsY1F5SnhOY2JmUXh6U2JC?=
 =?utf-8?B?NGgyTnlPZm1saFlGQ013TWU5NEx4RzRic3ByWWc1c1pVYUpHWDgrd09pR2F6?=
 =?utf-8?B?K29UMldiampWZE10MEpNUGZLVGhGdUVuKzFTVkVhQ2pZZ2dSclg5dlh4Y0tJ?=
 =?utf-8?B?K1hDZmY1SjFwQ2Nua1l2VU1CWUxwdlRPT3BobGlBM21nckgwcExBMEkwL0dK?=
 =?utf-8?B?SGVCeld4T3hxWTd0QnZsM0p6NElnb1ZGK2liZ2FCZzFGd0ZNNnJwWkVTUkZR?=
 =?utf-8?B?U0F0UDJhNnRDN1psQzVDQzV5aGprRDV0T1FqUDBqRnp3OWgwSTB5SE93YXJP?=
 =?utf-8?B?MTJTM2tlWXAxNC9GNENrSTJuQVE2RE96V0F4ZDdTSXdMV3lkZlp0TWtNYitQ?=
 =?utf-8?B?YW9nWFRrYmVCZngxVFBNWldRNnFoTVd3WFdUM0llYlloWjY3Z3J0UFZoZC9h?=
 =?utf-8?B?R3ZldnRUT0FxaEttanB6emFvVEtBK2NSdktsRzN2OU9jekFLK1NBeGFJNjlH?=
 =?utf-8?B?OVhMSGtYZzhZMmQ5S01FNkxIOHIxb29qR1U4NHF6ckdaaWkwTEVjV0hRYzhh?=
 =?utf-8?B?clkxZWRzL3RDM0RObmVBN3VhNVVKSHlvV0s1NHRmTzBFVjNlcm12S0xNZnBI?=
 =?utf-8?B?S2FIMDZsakU0MW5QN2JzTHA1SVZ2UW9jS3Eya05Gd3RVamdQY0Vub0xPTW96?=
 =?utf-8?B?NUlreHF3bjBieno5RXg4cXN3bEhHNG5WRDVJSUVWcUxUWEVUaEluMG1YRC9R?=
 =?utf-8?B?d3psN283dmdvMWE1YnRGaGM0Wkd6M2RRaVBCYUJjVUpqWm9yYWN3WTl4U2ZM?=
 =?utf-8?B?VUJFU0RhbjU0TkErbVFUM1RERzNOemoyTjlhL0Z3WUJRSFQrOVBueVFhUkdL?=
 =?utf-8?B?ZzRzc2VOTEc1SUVCU24xUHJKZWFUaG9hblFvbWJLQkpSRmNQMGFKbVQ2Ym1L?=
 =?utf-8?B?S2gvcFN3anNaYkZDeC9yTDJ6V1J3eUFZVU1BK285SytJd1lqMWROcW84Mk93?=
 =?utf-8?B?OVIrZDdVNHF2eVgzRElNTUwwYlg2dXpxdlNGUlhFV2VseUdKZ1p0VlNwU0x5?=
 =?utf-8?B?YWpLSFB2dm50UjBKTHJKRGdIUFhHYU12eFBZTFp3N1VyU0N4eDU3UDNXR2lS?=
 =?utf-8?B?NVJoQ2dLb2pPV0lValNhcVlhcUdoREYvcWp0R2pTY3huQXAzWEM2L3ExNGpq?=
 =?utf-8?B?VnR2T09OM2Jyc3RlZzRRVmFoTW02a0thdmw4Ly9qdGJ4UUVlRUk4dndoUTN1?=
 =?utf-8?Q?rJ+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9707.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTVsWktEcmJnRkU1ZUdEL0Urd2J6Zm5Ea2JlTzhteWdVNHFZOUxxZWJGZDR5?=
 =?utf-8?B?UjQyYkJJLzhLbS9rUG9RdzJnVFdKREtGN2plQTRIRitJc243L0gzOGh1Tjdh?=
 =?utf-8?B?S2dHSGYvbk5oSzdNelNGWHYwZUlSZ3FhcjgxRFdDbWE1MDl0YURvWUpEQmtj?=
 =?utf-8?B?LzhPZ1B3bUgvNnB2ekdMSzEraHVaSWJYTmk3YUxsT0IrYUNhdVoxY2NvVHlI?=
 =?utf-8?B?V0VWdXRGb1Bqdmh5TEw2ZFR2NnN3RU1BUExXSFZEYnVjeGEzNmhkM05Ta2xs?=
 =?utf-8?B?R3NkandrN0lPSStLcTFpa3Y5NlpqeUtVRHNuaFNmYUl6bEN3M1lXditvY3BY?=
 =?utf-8?B?Y0VxYndzSlpRbTZFRFBDeWNlOUFMcjVyWHA1UngybFgxUzBFK3QxU2k1THZS?=
 =?utf-8?B?ZEVXanlGMGF6NGJKZlN6bDQ4aDFpMjVkSHZtZ2x4dG90bDM5QWdKOGZLK1cv?=
 =?utf-8?B?MS9BVEtUN3kvcE5KUVFwSjhpbkdON3pINDRWdjdZbUhVN1V5czVnR1VYb0pO?=
 =?utf-8?B?MEJUVklVYzVsWGdDdkVrbmhMVHA0am5PWmxONG5laldEMU9aMDFkYmQ3Rklz?=
 =?utf-8?B?UzlaSTZrOXlrYXFBTFYzUkw4dHhZQ1d3d3FMZk0vcFBrUnMzZTZQcy9WVElZ?=
 =?utf-8?B?NzluTjk1bmlyWFJCVTV3TTFNZWZBazFFVjhNam5OT3NUN0ZsU2JCWi9WaHBO?=
 =?utf-8?B?cG16MnpuMlJDVUVCTzMxbTFQc2l4S0ZWdnNzVmU3YWJYY0ZuNE5QaXVwMzhX?=
 =?utf-8?B?TnNGRTVBb1BTZzdtQjZyUERxWjQ2bklURS9CL2dPazJiYTYyczdlSkxKUFlN?=
 =?utf-8?B?K3VvUklZMExzdjF6R0wwNmxFZjRoVjduMXl6RkV0eDlKc3Rnc241QUVzTVFq?=
 =?utf-8?B?ZmY2cEdwN3JjZHI3WlBUZ2dRN3ZSZWRueUo3bURXL0lKVm5obUlhNTlYRjYw?=
 =?utf-8?B?cTNvS08zd0t1SWRKYVllNitmbXgxQ0Vqc0tXeENQcVFERzk4ekFSR25Ud2gw?=
 =?utf-8?B?MVhSMDZIdDBMUnhESEx5SCtOM1NYRWtYcERvOGtaSFZHWlRCR3gxNFRhVXhQ?=
 =?utf-8?B?aGpvNVMwbUw3K1JZbnFNcXRBbHA0UXJuUjI2VmlRd3BFOUgwNTlCaG52SFNT?=
 =?utf-8?B?TFdsWmQxTUdEUW5Bd1pRYjFXZEt6b05MaHFIV1B0Ny9QczBFUThrclg5TFBy?=
 =?utf-8?B?ZmJjY0FvY2tzVFlBaVhwWWdVbFF2Z3JwNGRRSFUyRnBEWlN2anNET0ZtSjcv?=
 =?utf-8?B?Z1BsNjNuSDgxY3hOYjRrUHZNMjBXUDZzaGw2SmJPN1NuNnhkajJMNGwxOFNG?=
 =?utf-8?B?K2FGak12aHRqWVRZUDNMMlJoeEtlRUNZcHJmTzZ4TTlROE93RVV3bjJQK3Uv?=
 =?utf-8?B?NGFjUUpmSXZPaWFCTjZqUzVxNXU2MmM4eXVGQ0MrUXhJMUlUT0xnZnlWTXF6?=
 =?utf-8?B?bjFYSHU2VkRqSzUxWFF5NmlTYVNBMHZNNEFqZGl4QUZINEZ2R0dSQ0U0dnE3?=
 =?utf-8?B?NFJLYW1rRkVka2p0cHhkUlRjZ2U3RWxKV3Vtd2xrVVgrOFphamhXSXRSS0ZW?=
 =?utf-8?B?SGJ1YldoalV5NWYzWkNsc3JyU3U3dWRYQVN3TzE3K3lwV1RIOTJveDArTi81?=
 =?utf-8?B?ZkJmOWg3bDEySXlsMGd2Z09OdkVTNFU2Q0NsNE56NS9ZZ1EvaW1pSXU3NmRq?=
 =?utf-8?B?RXZIL2gzeWVqR0xGWUZYZ1Q2aEpiSFpuVG55cm55S01pV3BmcmJ2Q2N1VUZy?=
 =?utf-8?B?ZkdlSG1SbjBxcng0NXRIcngvMnZLOXVrVTZqN0dXM01MTlFiWkVMV2FIK0NC?=
 =?utf-8?B?R0dFY0huTCtLZXF6YjJJbWlUbFkyS2VuTGFOQ2hmbjVtNEZEamZKR2ZuZ0pn?=
 =?utf-8?B?TlNnQk94S3dBaUJKMXFlMkpRQVF0ZjdvN2xIdHdua2pCZDF1K1FGZkprSGt2?=
 =?utf-8?B?ZVBjc2UyOUh3RkhpWEVGeEF1d3BPaW82NllyY3p6c0lQbnB2dkh1S3REMSta?=
 =?utf-8?B?eFNldlNZQVJsMDNRd213Y1Y4ZWtnSVRnZ0o1Uyt6aFVQSGg2SzEwTjJTUFF1?=
 =?utf-8?B?SnVkbmg0OStxU1ErMW1LRXdRWWhtZklzUzVicVJnVlhOeUxxZ0FKa3A1RlBH?=
 =?utf-8?B?MTVpRHM0bjZrTmhSL1BDRGVTdFhOVmM1eUpzdlVOTXUxS001cjU5OWE2bXo3?=
 =?utf-8?B?NUxXVmZ2MjdJdzJsVVMvY3dEL0xvOUpvdlpEeDNaSVIwRzZLaWlJZmIzNkMz?=
 =?utf-8?B?cG1kSzhBQUtvRDE3QzRaZ3VxZlp0Z2FUaDhSVnhZc0J1RXN4R3dxUXNkTHIz?=
 =?utf-8?B?clcxT1NQcVkwMU4xUmUwb1R5Wm4vSmE1UHFhZ0FibzdqK3pKckRHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfc9602-d3c2-4a89-4213-08de6e72f603
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9707.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 22:21:56.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCDYK1xg1ILUfbVAqUtQDPOmxRtH8zASjaq2UDKuCd28L72GN5pV2Zg9ROdVDO/gUKx5Dqq1rodPlIHo0kPBcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698

On 2/13/2026 6:47 AM, Gregory Price wrote:
> On Tue, Feb 10, 2026 at 06:45:00AM +0000, Smita Koralahalli wrote:
> 
> This is a review generated by kreview-0811365ff2
> Reference: https://github.com/masoncl/review-prompts/
> 
> This is not an automated email, I thought this looked valid, the rest of
> the text here is auto-generated.
> 
> ~Gregory
> 
> ---
> 
> [...]
> 
>> +static void process_defer_work(void *data)
>> +{
>> +	struct platform_device *pdev = data;
>> +	int rc;
>> +
>> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
>> +	wait_for_device_probe();
> 
> [...]
> 
>> +static void kill_defer_work(void *data)
>> +{
>> +	struct platform_device *pdev = data;
>> +
>> +	dax_hmem_flush_work();
>> +	dax_hmem_unregister_work(process_defer_work, pdev);
>> +}
>> +
>>   static int dax_hmem_platform_probe(struct platform_device *pdev)
>>   {
>> +	int rc;
>> +
>> +	rc = dax_hmem_register_work(process_defer_work, pdev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, pdev);
>> +	if (rc)
>> +		return rc;
>> +
>>   	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>   }
> 
> Is there a potential deadlock in the error path here? If
> walk_hmem_resources() encounters a CXL-intersecting range first
> (calling dax_hmem_queue_work(), which schedules process_defer_work
> on system_long_wq), and then a subsequent non-CXL Soft Reserved
> range fails to register, the probe returns an error. The devres
> cleanup then calls kill_defer_work -> dax_hmem_flush_work() ->
> flush_work(&dax_hmem_work).
> 
> Meanwhile, process_defer_work calls wait_for_device_probe(), which
> waits for probe_count to reach zero. Since devres_release_all runs
> inside really_probe before driver_probe_device decrements
> probe_count, this looks like a circular wait:
> 
>    driver_probe_device
>      atomic_inc(&probe_count)
>      __driver_probe_device
>        really_probe
>          dax_hmem_platform_probe
>            walk_hmem_resources -> hmem_register_device
>              CXL range: dax_hmem_queue_work()
>              non-CXL range: fails
>            returns error
>          devres_release_all
>            kill_defer_work
>              dax_hmem_flush_work
>                flush_work(&dax_hmem_work)  <-- waits for process_defer_work
>                  process_defer_work
>                    wait_for_device_probe() <-- waits for probe_count == 0
>      atomic_dec(&probe_count)              <-- never reached
> 
> The trigger requires both CXL-intersecting and non-CXL Soft Reserved
> ranges with the non-CXL registration failing, so the window is narrow,
> but the deadlock would be permanent if hit.
> 
> Would it be safer to cancel the work instead of flushing it in the
> error path, or to avoid queuing deferred work during the initial
> walk?

Yes, you're right, that's a real deadlock. Thanks for pointing this out.

This might affect any wait on the work — flush_work, cancel_work_sync, 
all the same problem.

Just using dax_hmem_unregister_work (which only grabs the mutex and
NULLs pointers) avoids the deadlock but opens a use-after-free: the 
worker may have already copied fn/data and be mid-execution of 
process_defer_work(pdev) while devres tears down the pdev underneath it.

Your suggestion of avoiding queuing during the initial walk is the right 
approach I think. Set a flag when hmem_register_device defers a 
CXL-intersecting range, queue the work after walk_hmem_resources returns 
successfully. Something like:

static int dax_hmem_platform_probe(struct platform_device *pdev)
{
	..
	..
- 	return walk_hmem_resources(&pdev->dev, hmem_register_device);
+	rc = walk_hmem_resources(&pdev->dev, hmem_register_device);
+	if (rc)
+		return rc;

+	if (defer) //defer is set under DAX_CXL_MODE_DEFER
+		dax_hmem_queue_work();
}

I think this works but there might be subtleties I'm missing. What do 
you think?

Thanks
Smita
