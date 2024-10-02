Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1732B19412A;
	Wed,  2 Oct 2024 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903745; cv=fail; b=FPeIun2KiS9537AW8Tk0XF3W9P0rtXk5arLeP0VBz/ZZGb5EixpC405hhZTeYFcPUQH7yGnH9AQ74R+RhWUCpXUjV0kfaIxV0FLZ1ziCwWf1PAHU4PxCHd946rDLevylxb/iCRPQSBC892N8eyCdxFBQLEyOPQ7h47tYDMrR/gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903745; c=relaxed/simple;
	bh=pJ54kajssKNifTXZNf/DMk/eLDm1kY+Pq1vNJiI6VNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XRGXLgDdO8ahMYe0LsaLIgKFYXZq9ZIBAspGAh2G2PkA/CafNDS6PvRXeIEEKwtySHUpZmqkQLzmjz8hfHZGXK+NKoLBv45wNEnMBQ/0aeo0k/jiVYofPoLVe8wJF35wk+VpKM4MRB+c8Bc7idycLDbG4CtpwfEzvdxK9l3vB7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BVlnx5+9; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BVlnx5+9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKRsjwc4KDqjsaudWXbHtv+lDgf+oJPamnm8bnLe9WpurGOgw6c7AG8YT4IcfRX3NXIlQ4Xj3gYvFS7pX4Bi2GY7IyUF1QrlYOQlbDM+atUwYx+Qm9AxNx0UkG0DS2qn6+i3H8scTCCo+7lWKxZu5MRSB91Oy/P9PqOJH7ycgqLLmIy9+QyCZtE1r5h1DGwvcoO6oas2FUj++TJiWsNKGk0IIn6aH7o+wvRGxpO0dYpqjPc0GRiisd+6Mc7kS0r35LRbmUgxqJy76TjmEip9f82mf7knlKSy4gIqFBlRmC5ICx9YFJJ3K11dTVyER7dLFt1x/17bLAsg5YXRwadg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs8u0+zyA5Su7o9NQEAITwtue1IO7T1aojrXbTflgoc=;
 b=KDvczBukCnsAkomViy9/nJFfFYV4R6nZ/3n38/yS2P0COuitKMTQFC1a1ec2JBpHjG7twkpf5aoc1TPbTqE1RU4QONvJNvqskagTyribVujJXFyYNnZVjloaKLJGLAUK1PE9Jm3QZAW2+jmtGRPXRCXy24WXrwcQi45iSR65bCofvc630gW8pyCreXVYuNrdlilHxND0FaMPFIVJ7JcwK9QysSNGqkcFreht3LuM8CbxfiKycnC1+l6twUae9F2JfUKBB5N9LOPEciQNjqTgjRYMwPiyvmzVCaCH4IA4kPUyosQrAvgMuRu/5V0OQZTjT6/X44jH9EWtRiUlT+IbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs8u0+zyA5Su7o9NQEAITwtue1IO7T1aojrXbTflgoc=;
 b=BVlnx5+95UfbQvi3Nao4ZujfcpyyrzbPm1PC1uugBBs9MdkslsCrMDOGmGcjbNAF6ZTnxujeCySlSYYdEZjgWaxhEt1pdWz6RtLyS4hE2zDys2Mif8z7u2KmJ0xJ/o+dKhO3QlCPcjmRFGQvBcE6kJw726zQERDa/tdrG5vms5k=
Received: from BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 21:15:40 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::a3) by BY3PR10CA0025.outlook.office365.com
 (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 21:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 21:15:39 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 16:15:37 -0500
Message-ID: <e0f08438-69cf-4e79-abf2-f5f3240d9517@amd.com>
Date: Wed, 2 Oct 2024 16:15:35 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] cxl: Separate coherence from target type
To: Huang Ying <ying.huang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-4-ying.huang@intel.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240925024647.46735-4-ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ceaec8-c88b-4675-8754-08dce3275dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3VKOHYvS0t4c1JTS2ZpS1VpTnV1NE9ZbEFlalo5TG01Z3U0eFJ4RHB6KzEw?=
 =?utf-8?B?Tm8zNmVaNk83L0JEd2k2ZHNkM2NGTzFkc0tCNzYreEp1a25DZzRMSXh5TXAx?=
 =?utf-8?B?R3BOOHQ3NGNmckFUMkdqYWs0K0pueTdPdWMxOWVzako5R202OUM3Wno2dTh1?=
 =?utf-8?B?TTNKT0k2L280cnd0NTRvNGdmQUo1TFRybHVyUU1wQ1QzbTYyczgrZ29rTnRK?=
 =?utf-8?B?RW51QWpmcDMyMHVVdHZRdmZvc3ZWOWdYMVJWUU9vdEwzTDRzUG95Vmw3TjVP?=
 =?utf-8?B?aTJ3aTJHSXpMcnlyYlpqb0NRMjdsalg5THhyQXg2QU1ycnlERjl6aTZHN3pU?=
 =?utf-8?B?c2NrRzlLczdwZnBkbitPK1p2emdUZXdjQk5tRm8vVGRFUnR6bjd5MnhtY3BY?=
 =?utf-8?B?TzVBcXh0SzFxQU55NHBndm9UdVhtVlZ5b2c5YWU4bUQwak8rSXY5OC9pK1Zs?=
 =?utf-8?B?RzllSU5zbkJBTEoxTUtwVU5KNnd0blB4ZmUyU2hQZFhWcnJPeitXNnNuN2I5?=
 =?utf-8?B?Y0lBeU56Y0g0bi82U2k3L2tPMllQY1c3a0ZjRXVETnpDc2NjK2FJdkNyUW5E?=
 =?utf-8?B?bVRiNWxuN1ZqbEtBOGVhenFtMWFBUnVUNG5aQ3E5Q2UreVY5SHBlOGs0QWQ3?=
 =?utf-8?B?MHlkLzlNNTk0OGd3VU9JbHpVb3hlUnhXbForNS9TaFkvU3RtUW5Mb1hNdHox?=
 =?utf-8?B?V1F2amJkOU9kTXNKR0dYY3hMVEFNYzIvd2trOXhEb25zci9YQWI1L09tVFZN?=
 =?utf-8?B?L0s5Uy91M2xmRkJTTDRSLzgvaTkrMSs3OFMwUmNsMW9jRjh6aVZxM0NLZnh4?=
 =?utf-8?B?STNNdjFYRkkrV1p5ZGtlS1ZtK1djaHBsVHV2M2lEcE4rckhva0JLZ1BaNjgw?=
 =?utf-8?B?UkZleVYyRjQyc1YzMENaMHZiNitLRWt6bU9oZ2xob3FyY25qdVJUeEIwRTNk?=
 =?utf-8?B?RG03ZkdkTWdkOERwQkJUSDNuNmkyMXZMTjB5SUFDbmtNbFBYOVBWQ1hFSlAy?=
 =?utf-8?B?M05QV0h2RlFrUzFRSlpNbE14L1VVanRxMU5LTmsvUWNMbmdQS3F5N25yMFow?=
 =?utf-8?B?dDdwdWdFVjJqN2JuZGlqeHp1czBuWDBMWURlMFduRi84eGY5a01vVVd6RXRM?=
 =?utf-8?B?ajVRV056REdVS2t0M2RMNnZZd2N3ZW1VL0JkRndKVGdOa256dUErb2w0T3Uw?=
 =?utf-8?B?ajRNeEhqZFdzTGlBSy9jbEVTRDFwd1F5cHByL3NCTlpUZFZGaG50bHltcmRX?=
 =?utf-8?B?ZmE3T2wycVFNaFA5MEN0aHhwR2RhRjJwSndsdzJZOWFZem9MTDVHNGo5OUV0?=
 =?utf-8?B?NnlYVG9XRXlDMm9kOTZmeUpNRGtDV0JFbnRhYlRpMnAwblE1REtBSytpL0JB?=
 =?utf-8?B?NmVpNDR5YnRRL1VCZmRIOEN1N3poNUUvMm9DY2J0YzI3QzBuNzFENTR6cThI?=
 =?utf-8?B?R25YNzRzZXlBemQvRXNQVGxuU2tYZ2Mwc2N1and5VjFTYXNvYUkrbGlUWGkx?=
 =?utf-8?B?MTh4TnhWbmt4TmNTQnJjZVNkQTdubnM3TXNnWTZET1E4RC9pb2FNUEVBYTF0?=
 =?utf-8?B?NEt1V0trakQxQkRlOFZ6UldxVndrZ1pyTlNkYVlMN3F0eGZWQlNzZENPczVZ?=
 =?utf-8?B?aEJxYk1xZFRUOUxuK2Iydko5Mzl0aWdMUVRFdTJZTDZoejhsbWNCanJma1Zi?=
 =?utf-8?B?VnYxSnViZGtab1pkUU9TU0dkQ1dJOW0zZXo3bG96Rnhna3MwV1JIODFlVWwz?=
 =?utf-8?B?NnErbGFkak82bWlQYnNSUDlRakRUUXhjNi9ZWVZKLzJtckd4NThyczZiRHRs?=
 =?utf-8?B?WlpQQW5zSUlXdlFZTjZWUmJtaFBPZVk5dVg2c0JNSUk1VC9nWVhxMExYUG8v?=
 =?utf-8?Q?VIhY5L5ioxIXN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 21:15:39.4414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ceaec8-c88b-4675-8754-08dce3275dc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

Hi Huang, quick comments in this patch and the next.

On 9/24/24 9:46 PM, Huang Ying wrote:
> Previously, target type (expander or accelerator) and
> coherence (HOSTONLY (HDM-H) or DEV (HDM-D/DB)) are synonym.  So target
> type is used to designate coherence too.  However, it's possible for
> expanders to use HDM-DB now.  So, we need to separate coherence from
> target type.
> 
> Accordingly, the HOSTONLY field of decoder ctrl
> register (CXL_HDM_DECODER0_CTRL_HOSTONLY) need to be set according to
> coherence.
> 
> The coherence of decoders can not be determined via target type too.
> So, accelerator/expander device drivers need to specify coherence
> explicitly via newly added coherence field in struct cxl_dev_state.
> 
> The coherence of each end points in a region need to be same.  So, the
> coherence of the first end point is recorded in struct region.  Which
> will be checked against the coherence of all other end points.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c    | 22 +++++++++++++++-------
>  drivers/cxl/core/mbox.c   |  1 +
>  drivers/cxl/core/port.c   |  1 +
>  drivers/cxl/core/region.c | 37 ++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h         |  9 +++++++++
>  drivers/cxl/cxlmem.h      | 11 +++++++++++
>  6 files changed, 71 insertions(+), 10 deletions(-)
> 

[snip]

>  
> +/*
> + * enum cxl_devcoherence - the coherence of the cxl device
> + * @CXL_DEVCOH_DEV      - HDM-D or HDM-DB
> + * @CXL_DEVCOH_HOSTONLY - HDM-H
> + */

Could I suggest mapping the coherence type to the expected device type(s) in this
comment? My thinking here is that the coherence types aren't exactly straightforward
and having the device types they correspond to would help ease any confusion, especially
since it looks like we are expecting type 2 driver writers to fill this in manually. I'm
thinking something along the lines of:
/*
 * enum cxl_devcoherence - the coherence of the cxl device
 * @CXL_DEVCOH_DEV      - HDM-D (type 2) or HDM-DB (type 2/3)
 * @CXL_DEVCOH_HOSTONLY - HDM-H (type 3)
 */

> +enum cxl_devcoherence {
> +	CXL_DEVCOH_DEV,
> +	CXL_DEVCOH_HOSTONLY,
> +};
> +
>  /**
>   * struct cxl_dpa_perf - DPA performance property entry
>   * @dpa_range: range for DPA address
> @@ -438,6 +448,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	enum cxl_devcoherence coherence;
>  };
>  
>  /**

