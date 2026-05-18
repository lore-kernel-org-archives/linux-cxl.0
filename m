Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAAF371053
	for <linux-cxl@vger.kernel.org>; Mon, 18 May 2026 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139763; cv=fail; b=Ku4FAdCyWlU3opeBn1MavXjcAq8NOtd2CsmbJHTbWf7EnpwvotgZYZWJH0htlX0Jnq/GHRxB21doA8euO5BCGB72mkvpEmqaeOekH/0HxO5GMb6QhGZkTHECrCcHF7ssNNMjfFqSOWqB5lL8pFhICNxnoWF6Dq4oJLifEqe9LLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139763; c=relaxed/simple;
	bh=3fNxJfJZJBxU9BmYDfBjyTZlEgWlWUy0xbGipWc+aFs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=uBd00y7Lox4zq4EAdV3/FP4WhhVlA8XETQ3VB6bNbxblMHWurAtAiGw2Fb5JtK46S+NZwYY+vzSd7wW5gH4JqbCVBfwdu4p68XKcw8yh6dbJ8k/CqTZ9D9P9CyTUa8TAZXBnAQbGAhYi51TEdPDglgpF29bRcXeMd/l8g/Yf8kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BTMxr48Y; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BTMxr48Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci3qDjZJ0UH42vbopkNr/wNUxdDqoAxE44/E3boQO4MWIFhUfKhYEmdaHNgFT8kqRAKvAli5f5RMPaX9XSikwkvBuKjKRSGDKSrbp7wJc4E8gTVxRLaWeG17pE3FSktvR5QUBUbGYUGe/J48tfD/t5SZDLm4eOMtF9TJE7dNjSt8LIL9fUOlI2wzE0n6Q2djAzAI7Iz2hBsEbpHJvdwUOWOCnr3wSaG3s4je0e/Zo0PaOYazuljAciOR8DPRS6TCtc9O+oFkDwjUq9NTEEoXtZk+C79LUN0claUdenpX2KvCg4yPzXHMSTvNdQeNjpjdG3OrOMqs7Jbrng4TYTNJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZzTVYK6SyTIBjbviepIqPneTTo3Y/Pz4cxwtt147s0=;
 b=OttAZfWbjEdZAlio8THue0RY+Jy7Ocw6QJms4jsKMMPtgP3IQHBVsG0OVCFKHNQGLb0cMWJbr9zoOgTbf8MkGigGPU7ydHZx75cYZGx0dJVFUUTuklNav/YuFp9mDZw0yzJCUG4j0rLQaGJJVA+SMHxhKu7X98zknA9hYjZbcnv+Ymo99ktbMiamj4H8v4kW26QDMmhc+w0j7SjXcBNa7ymn0y19paJ4hltNtuM8ygn08A9Ahl/qvTu81tk4EiY2Q+W9JTXQOr43lzj/CSV4LRlJJ+N9kXsWISjjjeuCTdF6JLlekviisBLhzicgSLAOt7odaG9b97WoVR9D2zCwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZzTVYK6SyTIBjbviepIqPneTTo3Y/Pz4cxwtt147s0=;
 b=BTMxr48YubY6F7he3a7iymuGSqVlYYmH2RmNPMSpzJzEhsGI39jSwj8f7s6HpYb4dQKsym2Na02cbsaYqc3yAZDkpIbbW90+cSIb6YvMEbZZ0mckdDSFfLw9b4KnJjuPfpKM7dMXQa468C61g/9SeCHqL1vCoiRIsLnLlHfJQD4=
Received: from BY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:1d0::28)
 by DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Mon, 18 May
 2026 21:29:15 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::bb) by BY5PR04CA0018.outlook.office365.com
 (2603:10b6:a03:1d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 21:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 21:29:15 +0000
Received: from [10.254.60.74] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 16:29:13 -0500
Message-ID: <3e918936-d252-4a1a-83a5-9de2b895539a@amd.com>
Date: Mon, 18 May 2026 16:29:12 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 5/5] cxl/mem: Wire up BI for Type 3 device
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <20260516022037.1761453-6-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260516022037.1761453-6-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DS7PR12MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac058e5-2c50-42d5-e091-08deb5248335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|22082099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	LK5sMqOTOCX1lqUQa2kGD2r2fokcpvRjuWOLBFPqHNEsGSoxQ4R1yImZ+j1i9WK6h5zr5l0NFTZwvH1aV9D8bH2m5LbLq2gJZZXrK8/gKwoEfpOlkoO6r5H7LjuPbf3rkuT+p629JN5+lIXld+8PZ/Is0CqPcEzarqeOoEfXXCPv62V4n1qFdrb/VH5u23+1SQJw3oKV1S3r2wB2RF1+mhVcR+ZlzAm/0+VRk8lSTV3hIrxNSkHC40HMr9lhaRNimhAOlCoD0juwAU8UICflT0farOemv4T46YyJD7knYEC7QpAbMqpZD8o60W01GYF87tqnYEUGndg3lsdDRvOP1Iraj3x3mQcFhRIJjS6H01qljLH+Y1TasuPkxZOFBzTD7nGGDlYRYaCc+PvNo4ZnfLPbMcc77At3GgjmVMA35GSWxL2VBCyjiytT1kz+v7k/dZr5O6ZQy8y5sskHPGy8X3yB5LIBzm3iItdDx8gGGKRfDhROHRmdXt2EQ5ceLOjNElfSDiivsUOdBTIVU+sXM8BQBfXZiCA3Uaq73e3RgPYrqh6lsj5RUA3Ju9moNJS7xo2cVCGryKpMT6lWItHSARmbDwCJuZes3A1RLZCCmmX/Ty78+8CPGqw5xl0L/OOWdljMNYJCGiiR+ErkEr6QR7huEo+tA6EeR+JIVjeuFOGoaWLtFr4FDJbeYtx3upoI+Q9jEMi5phs5pgFZ6xNH+z+TTXsuBC9GykjOmOJZElQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SBQKUwtlMz/tvFditDnbht26qDZopJOEeRTg/v2PW5IEzkLGm0ojNl8ZTAE3uDyj83qX/wCAh+IXyEgZNZxYQnRbXw5QVdEGDW/EbqTw4HGg2H6y5lx17Pq4eLPjJOWhjXGyyLy/2siN5V8uOxm1aXqYK2Llp4ME+OKbFvSOV69Xa/LStU6spHIhPJUL1pPZLqI5MroCzSF5AUSNnfLfEbpvQ2blA+UigX/Ni1/GZQ1Fr0QXD5GYydaqDn7+XdmSC6gUNQJ4gC9CY2MnCkmUplvPKgkSnbi+0Re5Wv7zaejWhhCh8XS8dDGJLpk/hrJ4/qCkOOqB33H4C6mPWkaEiLIdI65oeXwfQD527I1Ut/IyV22ChGgI4PDLneunjRcn9EZxXiQeElZawXHBlZNH+XFzII4LFfPQpiWxgt8StzMSpLL1i9JJ+Ba/S/qTrH0c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 21:29:15.6630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac058e5-2c50-42d5-e091-08deb5248335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549

On 5/15/2026 9:20 PM, Davidlohr Bueso wrote:
> Setup BI flows during cxl_mem_probe() after endpoint enumeration and
> EDAC registration.
> 
> BI setup failure is non-fatal - the device continues to operate
> in HDM-H mode without back-invalidate support.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

I would mention why this patch is split it somewhere (cover letter would be fine).
I think the reason it's split out from 2/5 is that you need the HDM setup portions
before enabling the device. You could possibly reorder the series so that the HDM
set up is first then squash this into the current 2/5, but that's probably overkill.

Also, I'd change the subject from "Wire up" to "Enable" since that's what it seems this
is doing.

Thanks,
Ben
> ---
>  drivers/cxl/mem.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fcffe24dcb42..f2d01a218895 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -150,6 +150,10 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
>  
> +	rc = cxl_bi_setup(cxlds);
> +	if (rc)
> +		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
> +
>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device

