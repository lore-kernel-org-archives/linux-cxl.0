Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C22DC33F;
	Wed, 17 Sep 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102231; cv=fail; b=sed1XvZFwn+Mvykog+w9PsQ1WmbJLaYa9qVPx5o1vGXcrxy5+7WSLmha/5vK3jPgQaWGTgwBn1RDo6QgYLlE2YDD6SJ6reDaSkDUC2Cd+LuL9LQaml9YsgZqLNJiWqspmqsOn5bXASvuvrQoQ9bm8OwEBvS4rAC2KJSAUDWCDcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102231; c=relaxed/simple;
	bh=ae7zuRNrtjhetV7R7J6YKhpzLrUygZeg6IL81McXs5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ulOqvefNm+U/nL7mnUJuYe4SW2/bbNK3F+K/puQjZYr4Zhh7r0AWyrumrHzYg+G1W7CaA8zbGcWk4iP3w8c4WLXH1b7odQqAXLnCL7w4aeRBUYTJEZQEZDVBD6P2/z30aMeN1JRQhesSSmSYHEiy6kuftHT6BGPGeVL19X2olsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DVASoCJT; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DVASoCJT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lr8ibOerT0p+WZJ6kcplBgleUEFhs5QcSgOxtnOKMn48SjFfx4qfYXt72atymQQmg2NHqd62AP4EU58fmkaokCcv01gTS2oTfCqC2f1KIUobMmglifh0tRGx38rIEhu9/TYeKwyUmq4NN30O2ic038Q1FEQKr2HBaJjOdRMOY4XlPoVel9XSkEn5yBd5mfwTC6n/2MuhUvldQ3NT6lNBHCtB3ciOmSZ1ceSrlPnbT2/K3ShPyEQXRC9g4rkqZYHLD3G+YBQs9SlsdrBjNzqq9JQOvYVNRtnRHvYu2r3TxjhlzJ2UjO+TFYIyeXBUEfW/w/do73T5YjG8VIsV1tQjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIcwSK7I4fG6iOO6zWu0mjTHtEabhWFjDWo7BIqVUkk=;
 b=giIJ0KWBXVhwZ3NeVz6rq5DBqdN4sdVNiTdgV99HfFVVgRjb4gRxV03VzCt0+aYemK7wzNMI9RDdeggRcC7imVTPnzVkboiLH3CLH3ocAaBXPUIuZTcwBPJ6KuLfU77nsJ9vaev9d9OcQLfzIzVMH4JRPQruCqyex92FAsZQPByJ/KWTF97jJ3PwfpuFoJpMd1DZ0UBlW10RX/bQ694VzrPdCZU3nzzBmFeQBjuyzCLJ1vj65jcTCn4ZnHz2vdHzRsNWjezz1Ij8RBkirh9U81F2bLPd8L3ox9YLF3lwCcJnMwIBEZqc3oTucQvZwafAqPINLE8ymqBFf3KIItOarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIcwSK7I4fG6iOO6zWu0mjTHtEabhWFjDWo7BIqVUkk=;
 b=DVASoCJTd4qsgyJ60IC2HNMqUy6mWrJnfM2EWGI+Ah8djk7C/xCE/rzKfYf9Dnk8Q4Si0m2TW0SEYowlGhBFia6s07mMf9DhKBwoexJCTSKVtCmPVxjk5yk3/m6ugPnwCEHjMO5PR0SUPjk+VQLDkfE7GbVqg/nmG90ON7AWbds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 09:43:45 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 09:43:44 +0000
Date: Wed, 17 Sep 2025 11:43:39 +0200
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aMqCy670eTu-ZYUO@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-12-rrichter@amd.com>
 <20250915115948.0000415a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915115948.0000415a@huawei.com>
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 574467f2-33a6-47d5-851b-08ddf5ceb163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU1RbnhRbUlzMFdjQlQ0SmFrR3hpcVE4TWsvV1FrWGlQTW9iRGRHWVc5VzRI?=
 =?utf-8?B?aXdaeTdNK3oxZkRKZXVoMEFrMGNwY1NTakhUcHZNTTNTR1lTYU4ycDUzK2Zr?=
 =?utf-8?B?NmRNMnRDUDNOOCtOdFozUzA3NE5TQnNDOVo0YXhuRmkxRFU1b2RUaEtsWjFl?=
 =?utf-8?B?RDBvL0Jjc0xOcFZKenBsSXY2S1hMNWFFQnRPVkVnM213TUVWR3BHK3lUSHZp?=
 =?utf-8?B?a1RHZG9xTTB4azJGd2tQK1ZuL1o0T0tucURGajJlblZWVEJaY2VpRHB5Umll?=
 =?utf-8?B?UHozWW9USDJMeUJKdTV1L1lsT3BPMlhQaE9rQVJNdm9qKzB2SklpL0ZVcFdJ?=
 =?utf-8?B?Zld4R2hPTVhXZlNjWmJEc2pDOHhnVjU5VWhpS2RWaklidWcyS3ZTZkFablFk?=
 =?utf-8?B?eVZsMW1Menc5OW4yV2NvMmV2aDYyd2U0WFgrWlZ3blBFUlp3NWxNVFhzdk5U?=
 =?utf-8?B?RUJUVG5neEZpbFRKdTRFS29IQkwwVllwUGxoWFI5SjBPUEpjUGw5MHJESEI2?=
 =?utf-8?B?RVZJTm44ejlBajZiV0lpYUdrcjZmLzBBTUlDdkZaY1QrL2ZiWmI5Q3hIdGRs?=
 =?utf-8?B?MWdhWVBLNHlkWklZSk93dnFBL3JLRnIxTFdtRHRzZGRydjcyaENpblNiYldW?=
 =?utf-8?B?ZmMydzMvV0EydTgyOWJoLzYxK293TVhJUjNvMDRGZXZlNlBnQzZsbUN2NGo1?=
 =?utf-8?B?UUFlaG1GRnpSZUtyZER2bVRRWVp1K3RMWHF1R0Roc2lobm5rZzcxUEdIejBU?=
 =?utf-8?B?YnFBQTBBaE0zcnpSU0w4cTdpT1QyT25YMXFrVXdEUlJ0R3FrUFFIRm8zQzdv?=
 =?utf-8?B?bmk4RTVYU1VMOUluTHAyVTZFMlNlUnNYY2I4aFMya2w2RGRCQmFheTJUL0gv?=
 =?utf-8?B?RnhmT01jdmRqR0dMUUlvVkdVK0VPWnpnRmM5OVd6NWR1WEliS1RHN1QwL3RX?=
 =?utf-8?B?NzJhYkUrRlcwNEFaZVdESG4zY0Y1b3BYMmVMeTAvc3VhVEwwUS9zTW1qMnNM?=
 =?utf-8?B?ckU5NGhLSzJQRnJidkVxVW45VWxBbTZORGowb3dubC85ZTR5YWc2WlNqZ0x0?=
 =?utf-8?B?VkJmK2NWM3d3SXRvdW9vWkpjMnREd0hsekhLRHpSYmkyNCtSNTUyYU03NnhW?=
 =?utf-8?B?VThtd2ZESEtPWUpKVEdMMTlmUHVHbmNnNm5KejJkVTBsZE1mOHFEZEl2Q3Iz?=
 =?utf-8?B?K2JZMjRQcWRyQVRMeldlSWtucXFTQ3lsUmtlVEpSN3M5YXgra3NnM25aWjhk?=
 =?utf-8?B?OFE0SVN0MjNaOXhuZ3RSYk1wY0tXN3dQOCtZd3pzZUlSMVlXUjFXY0ZkZHRl?=
 =?utf-8?B?UGZySVNJRHZ1eGxIaXRxdDFQK3oxeVdGdlVHQnRISWdMb0Z4bEFzdFJiZHpL?=
 =?utf-8?B?RExLcnB5NVZaMXZYYkZ1RWdwK3RPNHAzUVdicVh1WHFmclRHUmVGNlRzOHND?=
 =?utf-8?B?YnpmRmovdDZEOGFnQnJyeHRXb1BJZVhjM3NBYnF6Y1VWRTNLQ1BndGFOTE9B?=
 =?utf-8?B?dzc4RHZhV1pwZVpWSXF4M2EwRjMwTFR6T20ycXVzQk9qbkFrV2wzK0RjcXM1?=
 =?utf-8?B?TDM4TzQ2Z200Q3N1amlST0diWVh3WU01bWw0ZHRFOWVRQTVnVU94ZysxbEJ1?=
 =?utf-8?B?SFZqRktlc3Z3aVdHTjVkTUp3aXNHRTJBWDFlckpDbzByVnNFc2NORlppYzNi?=
 =?utf-8?B?cWNjQzVPQWtIWXBSekdhejhselZMUDhjNEpITDNWSDFPb2VTRlBqNDZKY1Y1?=
 =?utf-8?B?aGtuaXhvRlpiSE44OWVIbzhpZkhPemlPek4zY0JGUGtHYmZVWWlJbGwrSmxK?=
 =?utf-8?B?ajN2Y3MxWlJZZGJTb0dzenFFL1VTZ0w1cGprQzdqOUFQOUxzMzhoQVhJSUhr?=
 =?utf-8?B?Sm5ab3NWQ2xvcXlQNll2YnR0RzdiR3lER2x3NWZQb0JTN1ZEQ0ZOUzlXVVVW?=
 =?utf-8?Q?duAZkR0ap2s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djc2RGFhMnN0ZzBUaEthc1RzYlZCTjkzVWs3bStkNS90QU1ubDdNT1Q0Y1dI?=
 =?utf-8?B?REpDR05lbzM3UzZvRWE4K1kwSDd5R3ZURlBodXZyNCtydlFycE1rZG95QVUr?=
 =?utf-8?B?UXhoOVR6RHk2L3gyRDM2Wjd5NEd5RDI4ZHM4ckdxQTduNHB6T0Voc2J0d3JY?=
 =?utf-8?B?Wjd2dXVEbEZ4WGx4T0NoZ3NvUHF4cThDVUQxazczbXFIK05pTElCanNsRnIz?=
 =?utf-8?B?QlIvTitWODBmOHAyMVJCYmMxa2J5SnRxUkZKR1Qxc2s0bTVGZUxNVFRQKzBJ?=
 =?utf-8?B?TUtvWHphWU9nMFB2NXk1a241c2VkRStLWnppcjdQdUdQYkx5SmdoWlR0VTI1?=
 =?utf-8?B?MVVWb2I1RVpQMFFnYmIxa2ovQnJXWFlBSUtOcmxmQjJzamdoOWl2QVpyM1Zp?=
 =?utf-8?B?VDBKYmY4c2dyNWtFUG9yZzBIYzZqeU5sNzZ5SjREZHFmM1hORjlqSElKa0o2?=
 =?utf-8?B?azdLTVJhaW02TE1tQWlYdGhOUTN3ay9zL2NqOW13YjFET2tMdnBld2Flek9V?=
 =?utf-8?B?NWNnVTVYTThWN3RUcGVnNkJ0c1ZjWEpnZEIxT3hic3MzOXNqclZnUWFhbWI3?=
 =?utf-8?B?djNiUzdNMnBtOWxwOTZqOWQvQy9tU0pORlN3Y3hXZ3ZDM3QrUlNneUk5cVRv?=
 =?utf-8?B?Ym9QbUpjdkxCRldWUEdWd2FKT3d1cGZXQmhlZVJ5NHZpV1dFbGllZEE1Vjdi?=
 =?utf-8?B?ZVNUd0pSR28yYWlFclZpR3p2QjNsUkdZWmx1cERjUEJIdW5aMWJkNzVwMnYz?=
 =?utf-8?B?cEtJZE5YS0NkSm03NjNNVUhGVVpQVUQ2T0FqNWZ5U2Vic2RrNmYyWUpYSjhL?=
 =?utf-8?B?aTdqZkpxOU5sSGVDSXpHL1BYMTVNRkhUT25qWjA4RnhTSTFnWHhiV2ZuMUFh?=
 =?utf-8?B?Mlk4YUw4MXlXZ2JQMExtK2pwMGpkVmV6TW1KVW5jby9OZmRGYVNFb0JiV1B2?=
 =?utf-8?B?TnJVY1FDR0lOZHAvb25EOXBGbzRNQ3dMSnVKM0tPUnAzM0FTNDYwOHBXOGFq?=
 =?utf-8?B?dkNXV3V3RFBYRnM3Y29YU2kvUHl1UUZudFFSajF1d0xUVmI2OEN2TkNtREdu?=
 =?utf-8?B?SE8xb2RsTWVUR1VIbndsWDhXZ25VQ2tDTzlTWElLZGlSa2hoRndxNkpWeHdt?=
 =?utf-8?B?UVF0ei81bFBxRDdXeFMvb08xTXFVRWowZmQ1bFJ6WGFwajBLNHU3Zy95NjE3?=
 =?utf-8?B?RUVlYVdITGFPdzNsQUJNQlNmNGNkYUF0d2NBOUNoVi9XZkRKTWJVemJkbVRy?=
 =?utf-8?B?TjFKeSsvdEg2bHlrR1hsU3BWczFwN0F0MUUrZG5xZUhKQ3F2ZDByMmJ2emZI?=
 =?utf-8?B?RmJNQzUzMUs4c3BKM1ZqWGlYMldCZU9xVWtRNlZoYWVhZVgyNnJMeWpvcXpz?=
 =?utf-8?B?aER5cVlPUVFSM0ZiU2gvd1JmbUNzOGZwR1FjNWMzcmRQTEhqYmtLMDBLN2Zy?=
 =?utf-8?B?NDVZTzB4N2UrSVhMQ2JYSzcrWGc0aDE5NGVSb3FTalF1dHNpbEN0RS96K0RK?=
 =?utf-8?B?SXZtZUZEM0R2MitiQU1HYjAzak1wcG80MWRVaEF5STBJbndkNHNLS0o4QitO?=
 =?utf-8?B?OXRhZVRPR3dsNFZGaVMxc0FDdW0yQ2JGS3ZUclFVbTFuUko0YVBUYW4yZXVp?=
 =?utf-8?B?aEVsY1BLQmlkTlNqWWpqaDlXNGFvd1RUNlcxcXpLSTJPNDBzVHhKZVlUUnhW?=
 =?utf-8?B?VDQ5MHlZK09aQVBMNi9kcDhzTW5vNUtvNTJpWno3cDBxVXhKT1UzcVJteFM4?=
 =?utf-8?B?ZWl5UlFOckVqRHRzS0dzRmphRVFRQVVIV0FIaXhRNkFVeUdSKzg2c21DWUUz?=
 =?utf-8?B?K1pldWo2bTJOUzFmOW5IemtRMTVOdThJNDJ1VlBIVWMrcnIxM1Jnc25BUm4w?=
 =?utf-8?B?djh1T2g0ZmFQWS8rdTZOVjl3RFZ5Ny9JcjdJSHhlNVlkYTNGTnA5cEwyWmZn?=
 =?utf-8?B?VjVuS1NxRjBHUkxSaXZraHMzbFhVTE9zYUhLVDdIajk0M3hiMk1HZURHVzVx?=
 =?utf-8?B?RzhMTWN3R25vdHNqR290am0vUXhNeDk5WGtqK3U3SGZ5NE9TeDlCcjFLaFBF?=
 =?utf-8?B?UmtFRmdPbTRTeU9pOGZtMnF6WlRGOTBkOXNSSW9NaytxN2owUk9JbFhKTC9N?=
 =?utf-8?Q?n4/2vlrKTrC9zXXgX9LWZhO8r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574467f2-33a6-47d5-851b-08ddf5ceb163
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:43:44.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7VqdFNY91hlfelNrmB/Xr+CxHmLg3xhe6pJ96B8XgcNxZ40AeB9dsWK6J455i3c8b3kt6TNq2J5K5BodztUcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

On 15.09.25 11:59:48, Jonathan Cameron wrote:
> On Fri, 12 Sep 2025 16:45:13 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Add AMD Zen5 support for address translation.
> > 
> > Zen5 systems may be configured to use 'Normalized addresses'. Then,
> > CXL endpoints use their own physical address space and are programmed
> > passthrough (DPA == HPA), the number of interleaving ways for the
> > endpoint is set to one. The Host Physical Addresses (HPAs) need to be
> > translated from the endpoint to its CXL host bridge. The HPA of a CXL
> > host bridge is equivalent to the System Physical Address (SPA).
> > 
> > ACPI Platform Runtime Mechanism (PRM) is used to translate the CXL
> > Device Physical Address (DPA) to its System Physical Address. This is
> > documented in:
> > 
> >  AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
> >  ACPI v6.5 Porting Guide, Publication # 58088
> >  https://www.amd.com/en/search/documentation/hub.html
> > 
> > To implement AMD Zen5 address translation the following steps are
> > needed:
> > 
> > AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
> > call (Address Translation - CXL DPA to System Physical Address, see
> > ACPI v6.5 Porting Guide above) when address translation is enabled.
> > The existence of the callback can be identified using a specific GUID
> > as documented. The initialization code checks firmware and kernel
> > support of ACPI PRM.
> > 
> > Introduce a new file core/atl.c to handle ACPI PRM specific address
> > translation code. Naming is loosely related to the kernel's AMD
> > Address Translation Library (CONFIG_AMD_ATL) but implementation does
> > not dependent on it, nor it is vendor specific. Use Kbuild and Kconfig
> > options respectively to enable the code depending on architecture and
> > platform options.
> > 
> > Implement an ACPI PRM firmware call for CXL address translation in the
> > new function cxl_prm_to_hpa(). This includes sanity checks. Enable the
> > callback for applicable CXL host bridges using the new cxl_atl_init()
> > function.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> A few minor additions inline.  
> 
> J
> > ---
> >  drivers/cxl/Kconfig       |   4 ++
> >  drivers/cxl/core/Makefile |   1 +
> >  drivers/cxl/core/atl.c    | 138 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/core.h   |   1 +
> >  drivers/cxl/core/port.c   |   8 +++
> >  5 files changed, 152 insertions(+)
> >  create mode 100644 drivers/cxl/core/atl.c
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 48b7314afdb8..31f9c96ef908 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -233,4 +233,8 @@ config CXL_MCE
> >  	def_bool y
> >  	depends on X86_MCE && MEMORY_FAILURE
> >  
> > +config CXL_ATL
> > +       def_bool y
> 
> Given no help we can't turn this off manually and it's down to
> whether ACPI_PRMT is configured or not.
> 
> To me this feels like something we should be able to control.
> Not a huge amount of code, but none the less 'so far' it only
> applies to particular AMD platforms yet ACPI_PRMT gets built
> on ARM platforms and other stuff even on AMD (CONFIG_AMD_ATL_PRM)

How about default y where possible but have a menu entry to disable
address translation?

config CXL_ATL
	bool "CXL Address Translation support"
	default y
	depends on ACPI_PRMT

I don't want to make it specific to AMD.

> 
> 
> 
> > +       depends on ACPI_PRMT
> > +
> >  endif
> 
> > diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> > new file mode 100644
> > index 000000000000..5fc21eddaade
> > --- /dev/null
> > +++ b/drivers/cxl/core/atl.c
> 
> > +struct prm_cxl_dpa_spa_data {
> > +	u64 dpa;
> > +	u8 reserved;
> > +	u8 devfn;
> > +	u8 bus;
> > +	u8 segment;
> > +	void *out;
> 
> If reality is out is always a u64 * maybe just give it that type.

Will check that.

> 
> > +} __packed;
> > +
> > +static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
> > +{
> > +	struct prm_cxl_dpa_spa_data data;
> > +	u64 spa;
> > +	int rc;
> > +
> > +	data = (struct prm_cxl_dpa_spa_data) {
> > +		.dpa     = dpa,
> > +		.devfn   = pci_dev->devfn,
> > +		.bus     = pci_dev->bus->number,
> > +		.segment = pci_domain_nr(pci_dev->bus),
> > +		.out     = &spa,
> > +	};
> > +
> > +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> > +	if (rc) {
> > +		pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa, rc);
> > +		return ULLONG_MAX;
> > +	}
> > +
> > +	pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %#llx\n", dpa, spa);
> > +
> > +	return spa;
> > +}
> > +
> > +static u64 cxl_prm_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> > +{
> 
> > +	pci_dev = to_pci_dev(cxlmd->dev.parent);
> 
> 
> 	return prm_cxl_dpa_spa(to_pci_dev(cxlmd->dev.parent), hpa);
> seem fine to me and shortens things a little.

Ok.

> 
> > +
> > +	return prm_cxl_dpa_spa(pci_dev, hpa);
> > +}
> > +
> > +static void cxl_prm_init(struct cxl_port *port)
> > +{
> > +	u64 spa;
> > +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> > +	int rc;
> > +
> > +	if (!check_prm_address_translation(port))
> > +		return;
> > +
> > +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> > +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> > +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> > +		return;
> 
> So other error values are fine?  IF they don't occur no need to be explicit
> just check rc < 0 and return.

This is just to check the existence of the PRM, but it will fail (if
exists) here as parameters are a stub only. Both error codes are
reserved for firmware or kernel support respectively. Else, it returns
the PRM's error code, which is ignored here.

> 
> > +
> > +	port->to_hpa = cxl_prm_to_hpa;
> > +
> > +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> > +		dev_name(&port->dev));
> > +}
> > +
> > +void cxl_atl_init(struct cxl_port *port)
> > +{
> > +	cxl_prm_init(port);
> Why not just rename cxl_prm_init() to cxl_atl_init() and get rid of this wrapper?

cxl_prm_init() handles the PRM specifics, while cxl_atl_init() is used
as an entry for the core module to enable address translation. I
thought it would be misleading to name cxl_prm_init() different. The
compiler result should be the same for both.

-Robert

> 
> > +}
> 
> 
