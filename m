Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7B4A1E13
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290362; cv=fail; b=YkAMCIWIs8sdoAH1qS7VK63CAa1KcW7AYVtgTtx9j82J6+eUtvKfchDTHfYKBg7+kCunCnWh9LIVA82SDHBoUMlDC2DC2x7L4cnbBwnFBUiPmKyqJpCH+KRe8L7rj3SCU0DM+IICDqLHTXhmpS5iQK3sDtSHcfwr6pLuuJ8Y/lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290362; c=relaxed/simple;
	bh=Q0QApBL783arlZrA7k+v388ST+KF5gMhNvcH1eHT9+s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=dQj5NJpKDbtR5CF8rEOXNNoFMDR7bsZYgpBM6FAsrZORhKNW/9uQ8FDAzUI1BuZq/wvl9PGxfW85AULT4zRrsxk4lxKgjBIRLxS9Ukb3NNVCwgvrnO63HXElvBmfjNuotx3yYbe7B8ny6EmKLlkkh2XyfpbxotETbPaC4dDbVR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XXYwDE6N; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XXYwDE6N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC9Q7U8W7k7OroFixkvVaFVewtBfVWJyoG6U2m9i7Zn7pAfrKcWShf/uSBJ4HWlH4DJKcXeghGn3dAguruP6+y4eU/EXDoOwFit7ICcbFAm+nlXMoEHSmyhwNhSjDArpt2FDIZyrfu6heekLs+pW8NA/21MMwabQeWjb0JURGubvQ9U3030F1zJTc8/XyN6vjCGa8bDXPhJNAAVk1KEaKwb0xmmDvUZZIXbZ7KWW9eFIGYSUiuBgzdOrYROHVZmQDMWutAqVq2QnCDtKsZO+j5gmHJQSWXeZq8ZheRPfgmQxzfTJW3LCC5k855Vu7RGzrDvxrFnHxD5tmWZ+r2hvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U45GJ2frlGmuruCAOoExYj2lha10sMsEjKCyXkQ/FfU=;
 b=K2b+o4VvHnBRc2Fw6Z1AFdx6S5LSdK38TkjeyZ12I3zPGSxM8k9Q1JtuLXR4OXzz468Y+jbuKX4yWMZIltkhomV3ZUvsPpBoMxO7oCdtzpPDIexA+ZkifOwfYCYUO+gPd8xbdbbmuPThSkcUfyaaScaURn0mGbqaefoGevGsuONG+Np0/GCKvJI3VmfkQTYSjNrzP6g8lOxYmmr9VhKTIo6JEzaRYpWH59D6KleFj3hH4rSXHWLL8xQYRJuCyWmpjyq9zM1gEG/rbHDIURgO+pVJd7qzLA4lx1VgXfJGDRaD6XHxMVuPObR55AzSUlbFRSq0kOIIjhBEoFAQXIcUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U45GJ2frlGmuruCAOoExYj2lha10sMsEjKCyXkQ/FfU=;
 b=XXYwDE6NTOJM86RutytWzrBLv2e0IXm0O4TIHtR/AJ+V/vZ1AoxOJtHIEc7ZEwzHe8Q2ARF3uUxDAKPIRDRX5A+BecJy9MYXxdCBpk+p2zbRPiEOiJb/ZL7SRJiY2QrcuJW/6xZaRi+m6ptFw7DoPiMXRJsl/B/x9Ice//Tuw1A=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:19:13 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::9f) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:19:12 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 14:19:12 -0500
Message-ID: <0ef743e4-2cc9-4823-b6de-e2babb1e1353@amd.com>
Date: Tue, 1 Sep 2026 14:19:12 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2 3/4] cxl/events: Bound the per-log Get Event Records
 loop
To: Anisa Su <anisa.su887@gmail.com>, <linux-cxl@vger.kernel.org>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <20260901002912.958-4-anisa.su@samsung.com>
Content-Language: en-US
In-Reply-To: <20260901002912.958-4-anisa.su@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: b02c2024-44e2-4381-1446-08df085de839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pU7Zy2VBH+KLwnsasmWogtncyk3YaazFFUm6/vb9Cg7n+YZHzWus3K1npqATGrQd9W+mAejZBN2JF4LzSjCYJeXxDhN0RYpkixVUo4xENvlKd+PrmdGh6aF9zuPbrCgq4cIr/KCnN/Me25ApKGEY/A4YvdRpl7rqdnAq7gUNa64TtEK68KDqCu/+dOFztc/8P1iP15fxCfcKNL6XAUZxcHxWZZ3ZbiwaT3mh2kCC+xfQ6CZwLItgB5kVqn/qPrmjxXTtzRv6X5hTE/GBmprRPjVoErFLg1QiDFYXWNT2Dejhm3FLa16Iz0QI+FNNarS8HsnGEU/1zAxHFLT6AF0o5llvgKeVva9F2fPeYED6Q+FOubn0bmf2SrCLgL6sGBT3oqiCjaZj+syucF5+1jUX4MSf4mA9BR1ZTSp7KDF3PvPzLj4OUEssSSZigBNDcowu5CPhALop02lmfij3PQ6iIN/viZcmc7HmHXTcuhWyKeKX5nEhRHaqbDLcxmyWWeC2jfwAxNI6lR+HSAQsRGGbViNGsP520JRIsrhDdx5RjJoHYnXGCG0ucrkLd78+D0+21tjGBqfY5aHM2p2v9CuW+4D3GoxrPj472g/KZgdjBVUNyGLalxUNvI+zMCDOVg4BGmhxIh4Itlo9FltA+UpQ3Iyyp/7QEF6STbL2cRczQgwrKJy2lhg1GYuaUncRxgCeau9m2F0rCEvJgff+emH6Kg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yQ7AdNoSWH5cQcr/sTAOoyS+UdI530j+P6l6EQUBuyoGskjS1ShQQqbsH9lwG4LW5cMqJx1w0N8juS6GdVILLmsfor8SnymIpaaTnLszAiLTjQKcArnee1UTvCbDsmdXMQgRaW9YRur3UdkyuNqRIIzC8ihYwx6IHBWUZxxfIOlEPM+YfNKf0ueB0psp1NhaGe0xRGbUBP8D5MFqay+HpNbuOBXYjmfX8ZniL0lQND9yx9OlLZLQmLwvjOmtuXdSGBjVxCiRzsTIdVgggg4ynF6+/MFbXQuhivZ77fK9/3KbqR5DteI6IXsR9+jwetA2IdXOQn0J416A+nbs6sHfvUgobEHVUqMolrr/9F0G8RzQk5g2cWp/ikPYis0X1S7uqw3bsGwRttl8Yt8lIQfh53tuU/AoNkwLR2yzNVNjEk+s1Jj4anq2rYopSA1CW/Rp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:19:12.9668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02c2024-44e2-4381-1446-08df085de839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE

On 8/31/2026 7:26 PM, Anisa Su wrote:
> cxl_mem_get_records_log() re-queries a log until the device reports it
> empty. A misbehaving device that never stops reporting records keeps the
> event thread stuck in this loop, and there is no cond_resched() to let anything
> else on the CPU run.
> 
> Cap the passes at 128 and reschedule between them. Each pass gets up to
> a full mailbox payload of records from the log, so the cap is a generous
> upper bound. Report hitting the cap as an error and let the caller give
> up on the log.
> 
> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
