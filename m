Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725473769E7
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953053; cv=fail; b=kShMD5SkhNlgsrCloa+zMf24JcFNtbu9a3QutpbnoD+VXmGCpQ3A6C8nb13P/DWhjyujOvaeADCwLqNJRkzTkARRJRISKhEF2cdyCwL/O0/vxP3XOK2WPDAuSFF5/zGu5cZTxiuLwzPOXMC74WNDLyg+IGb118ozdfgj+bzS0hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953053; c=relaxed/simple;
	bh=O/PQnhBtsN4DjZL+yspBl9uj3zKlQPsB+qDl79vAU6M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=j4OYfOdXa7tzex6SNF21SdFcUm9iRgxEksxtoX9Y+KiRjzVcI14V1u8qd1yPuA3f/74EQlZLoKUxlCFSqsY3UapQ4g53IzzjlCeolsot3mTrewYlq7AC3tuWsN8OMRKItAhMnfrTUjw78lZE2F1wV7Psmv6edHzl6Bs9Lc8JRG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1l045NyX; arc=fail smtp.client-ip=52.101.61.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1l045NyX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh1KR90txDvs7V0d+4jg04gu2bn0EHaWSbK0csegonIfsMmDQ+Bx9HLDU/2cfHdaD32pwOYWK8xoSOXujG55UMSREwDkO0wWSQtaMYp27t/hYLgTVaIw99jhusOCZ8MEdy1GIGkjRaRztf9f599HEQYejY1sTngU7kXF9NbFhKYVcmDHWN3Jt5JI/wyRkQzzWFDgfGglPiwMKaPZ7myQLtlFdmznyKR2jenR+/Qu5l/5tH48Ucopa6eytHCRJv7g/vpKnTxNaiZXBSYkPPyWswEmFn6Jw8SBQD1QwrnBsbTerEdD6GrLrCZzCsDti8gA6IjICC8iz5IjCy1HDJ4f3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zlaDZ0ml28aLzQmvQmw4VdUgGOtPKEerr0GggoFTOc=;
 b=KpPQYDEG9LWEsuBPyRuIbQ+sH3VkZN89NA2S874lb2C/NoimFvTtdc+aKPTwsFQwdfVNR+sywYExLcFRWLopHuUp8yunsPab7/T5jmvPinfvSO/baux4hvmCFU57ov3RVhc0jA9kQQ6Z6yu6LF5dOHVGf0G0BitUDFGqvIt+3VZ+Y6UdxBE4VM2NIWAz9Mv+MvcnL1wmPWwE7JO1BKBbgDuFCMHTgEuCG89epUYDI4dIadbIHa2MYlupDp4K9189w3fXlbQaTPoMR9XPpPfs7Re+kE/nTOOJsobacMDFcRIGcD8T9aFk8O996MFVjyoqCsOxvebQD2yIDy9XjJsTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zlaDZ0ml28aLzQmvQmw4VdUgGOtPKEerr0GggoFTOc=;
 b=1l045NyXYL5zCGxAbDySNG/L2quVh7sx03r4bOqDZ7fvCJPmQfZQyXk73DfsU+QKFPe1QY/SSD4ZbgQxX01Iq/7x7brUfz+6AcEfGTK4yeM+YlE6UbNVTdJeqmeCkLo5BQb1gsbSKPPvBJYJ4zlcL3AOcxX1f+2CnpNGs8GQUwc=
Received: from SJ0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:a03:39c::26)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 21:10:45 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::83) by SJ0PR03CA0351.outlook.office365.com
 (2603:10b6:a03:39c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 21:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 21:10:44 +0000
Received: from [172.31.129.70] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 16:10:43 -0500
Message-ID: <fdbc0f06-cd3a-49db-8f86-3e856b97a0db@amd.com>
Date: Mon, 8 Jun 2026 16:10:43 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/5] cxl/hdm: Add BI coherency support for endpoint
 decoders
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<gourry@gourry.net>, <dongjoo.seo1@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-4-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260605003329.2584012-4-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7fac5d-78ca-4897-6ea5-08dec5a267a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3uwxjYnOZnyAxtho8LatplgWIIiT51V0I/gp9Oi3/u49ujkLqfI4UqhXNjqviMPtuUKuBrVFFEZnUrvCae0PF+cjJv0aKvXrbjisQQEUU4+WATFttgIcjdlGayqC+QVfqdyhIUEQXHkA9faRN5/PVer50QrH2Oz8pfxG6yf69ycfknFQ1VO4HdTa8qNzqsTz1SgqzOtwtnlrZDJ/nmWgwbREjfl9XlcYzYfGrpN9kaX+F0khJXio2U+ESe1wjASPno3YS6SxiDPB0LaaAV6XxL0XKDcMRCTA/Xsji/HLUTcZ2Z3fVi091HS0gvw43FQLvVl6/ooCJ34DxH0DtYGyIewL/Fm+LthtgRBvIbgwlNBmeJq53lVZSsMPppS19VHeoaxJHy7eKV8vXobZ+GLxNW5ZfDv+G2vEJhR+btye3ys+ghwJX5E6yqk8M22JanmRr/PnQp+hhuN/QhRgacF/1WRUMJr//voEUgTW+mTRZnW/qBO5+fbW57Zi6JK1WoIdv5liZqU1T4R6Z8NLInQK9Nw9dbxifaWHQYYYYLWZZFUVFvKMN1M+EFMEBTwQ3aGnaX09l1TVSUsO3RxS/9dQroZT7yLvQINFmTIpEHFzH0EspmoSw8xRbFdBVuS18jTRCRrbGjAJyRF/0T7xKG/yarISVzq9afS0MUAmG6G+G6ZydW0RoywF0SMhzyKtknUEQKp5ugN2ruT4g0blYZi7U84+QO+6mPPiGv19bY1qi8E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7IZ9JuAEPhG07NFr6h7f+PQiLNqQ3gCDE+bw5ryYg2t4KBScyK2DuAAa6Z/SofG3IUbu8Hj3zjtrlnAgaJ0ilBH8ggYW5QYKbikHiDEg96svUCkfzvNjvXIJLCUCPXPzw/yQKhjCnS3VTAXa39w3uxDSVIuAchk8AKjjWy4RNhziGRvIwJr29xq3gAxXiSZ4O+jKzBpsM67fYxJ982Jxt5LJ/X6IZG9o5ezu5osGIgvOlSw619+O0M2TUZGxrpCezmq2IVKr50BC12+IH7iOmCpp9LE67X4xaSo5gVlPoUr6OR/GZPmhMvjq1hnxOz+n2I86Ky8X4NPh8d1B2aYF4TWVWb0ND5KaH6Yg/xbfqIUPs8/ANEdlM9XgndMNP+nrEW6yCYvwzwslcv1KnMA3xZsGwA6TLVkupwS14p1tEkRhXMi+XOXLzfr9Pqkoyh7T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 21:10:44.6891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7fac5d-78ca-4897-6ea5-08dec5a267a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696

On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
> Cache the HDM decoder's Supported Coherency Models on struct cxl_hdm.
> Region attach consults this to verify the HDM supports the region's
> coherency type.
> 
> For uncommitted endpoint decoders, init_hdm_decoder() defaults
> target_type from supported_coherency: Type 3 devices default to
> HDM-DB when the HDM is device-coherent-only, HDM-H otherwise.
> 
> Pre-committed decoders with the BI bit set are not supported because
> endpoint and port enumerations are independent -- at decoder
> enumeration cxlds->bi is not yet known, so the topology cannot be
> verified.

Would it be possible to allow unlocked pre-committed decoders and
just disable CXL.mem on them until we verify the endpoint supports
BI? It may be possible to just disable the endpoint decoder, but
I don't know if that comes online before CXL.mem is enabled
on the device.
