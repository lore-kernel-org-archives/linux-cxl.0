Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E584A1E13
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290355; cv=fail; b=pjas/A9f03p0cjacrF6+fXZ3pYPBG+i8RxUwskbFCVA1qYLz7AESCHeNu/QoJiDiPKsMc0/9EHehi6BxPGEJPe4ELU0gd1GkOLuRQBWXJz+7MlObXKxLKoTek149lJHsCYtJC43Ujdi70hXo0S0WM/vgvnzfTQlwF0Nlrr4etmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290355; c=relaxed/simple;
	bh=bHh/BbdOde5POT3AcIbDGtdAhqxcbAqSAHcH5Ff47E4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=YXHJKbgbSua1Bp0kxmqEY9G6+To1YVqNrtSKIhQaU8cDFGoHuKbHdNS4gTvWW0sqFq1aqSgsFxHeEN6wkEvqmOUI4TLUHa7n9BCz4IP/TSa5JJV5KohdfSxGzvDgBzxYAgigFjiZU6Rg0d8taoc/c8gyzkauW9fqgjVjkCHTzgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aTcYrZqN; arc=fail smtp.client-ip=52.101.43.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aTcYrZqN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epQpwyZHj9KMy4sDqyINSMTJ88ufLdZCrUenQWS58GFXl1EntE38YpCerbl/cx+goUPh5R86LHZZVKGR7BjZt5P2Vx8jzIiUIJrT3+pDtG47Okv/HBjtYrwhC2NwCTGJCm/Woa1lQGg3GYYlz4cqf2Z9ISzQkovrIMiQQTm+5joa6H2A3HLYZxxPW0sU8DkC1AQ1SRy/2Li/kyfU5bctY6LuGHf7aVx6I/CJKVeybqminETklWYWlYqLDxMVAD/fq3hWj9D/VQB/wojfDA602mqICQwClIsfI9XHOPkAf09mnMScmPbNi3B+W7lRzeALRy/dv9lic2KKUS+YO2jCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i46Zq1chPKeyfqSglDTpjipdMxY16BM/o45r0c/Q/rE=;
 b=Hs51TVL6nca+zQH962e+TBfQTQBuNHi6fJn6sVVnR1POI1fmc9bHRZhHscWYImTEn3e4G1pqSm9ytg9KfUR3Gb8XB/b6cAUUctejxXHzOKvixP3jz2B+4hxaHhL62ZbsNH+YcoA8AwzsXeD7fpqX6N0VjWzVcNAXlQ7EjC/lnTzQbLgzDEL9a4Fi4B0J7GWmStep62T4aMn5xJYYA0XrE058YottQ1Gj8JoEzhgJRVNH8MwxpytDMe9GnjPOT5MUo/iZciCq1akVeciPhN/EeJi+wF4jvviMkpAC6dG87R/GPvVng1jKZ5vNVVFMwOSAYN0rfKbpy+9hSISlJ36hLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i46Zq1chPKeyfqSglDTpjipdMxY16BM/o45r0c/Q/rE=;
 b=aTcYrZqNZg8qTZcwDjBYR6BUBEQz/cjwRUUD/Nf0J2AXXM8fxqSdt5/X6SnybBMKnGUuBJP4CXpBhT3tOM/u8dpztWDjMTUAq+13UY6zbl1yLgExTMkOYbv6kx3g4rwEYFOmwaETuCFZp3Z1gbw8TfUwIOjs8FwMl0tLt9zAztk=
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:19:07 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::ab) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:19:07 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 14:19:05 -0500
Message-ID: <8e22c1c2-8098-492a-8162-3dd27507c853@amd.com>
Date: Tue, 1 Sep 2026 14:19:05 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2 4/4] cxl/events: Return IRQ_NONE when no events were
 processed
To: Anisa Su <anisa.su887@gmail.com>, <linux-cxl@vger.kernel.org>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <20260901002912.958-5-anisa.su@samsung.com>
Content-Language: en-US
In-Reply-To: <20260901002912.958-5-anisa.su@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d296ad0-2694-4f06-a82b-08df085de4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|56012099006|18002099003|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	T5qvTyurtx9mgqPzk0qo2i02U5cutuQpFZ3KR3MGlqBq8gVQaKSlYhI9f7XDHIH2jK6Wd7gHzUaBL3k+u4miD6B2ksNkw1/WE56SetZlJAb2zPL0Qkulv1ztrI4zBKs6tn80OEgO8nQPy21zMuCKpUKVncfvt9GA0SwGAjSIsj/vqHnrGoePYDGw4+Kck08npOrGE5/eHcFWldOcmWdFkcZmamNMP8khdb6s6mYU6f3mU+29AtG4EC3apNX1z6mowXCVtD5HVnzTBTIFBfxsfkFr8TeyyoEHcdgDMrsT2vicmXk+CcEVyXib/U36/9k2ZHXozcctl/jYc3znle8vBRlsGYIQe8cDZaVnZx4oZcB08r8cDeSs/yNEfXYPOjmnoRXY69/xyNLMzyNrxhWqlqN1dy8osncGr4b9SlLQboLOsDbT3WU4+pluy8M3eS7Egs3mUeBppr9MCPOKCypQac2i9wzEuwGvRjia03bwhVXLM0l8msJ0H5k5BQtuOTqgHBJhm7SgwUWjixhKG7D00pGF1ID7tlK1G/XDhNGuGwYLFj/9G+VK/l52wQDLMC3dYJMeLW9cszmTzhJPlanlHfL8R71CIa3HYdPy6lJMRVRJEmSyqsZa4MBImEwt4IW/RKLahIgd93+D/HHRs44P8WQl4Cnppzdm0GF0z8X+wqTaSDCy4p5nTtm93emkITvT+8S+/2E0lW2RBERlf8PRSA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(56012099006)(18002099003)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CEP9axhvgSnkHgIeBTh+/seUTdAXJHk+QZO2wdliuTtmKJjFOKcoeNZZDdUt17bh/G9eT1R1QIzj5ve3yVkGuohoxlrrLZemnj/PuY4NnLH86vghMsPiNMfXAPx1220MX2iyBlO0JXROV2WrDCwyKVLuYCP+FarWY/TFL3QNRC0TOhpGxR4tjvB+EMG1forKw5gM1pqqwkuUxEmZLoDhLSSbz5yyOADAI2h8A/bs8ocxlR6+8auzIW7F0dP/i0iDuOiXRK5Bz2vgf1BaFJkuzo7M+4fYrbXD/eTUksPdaJUfnxVRzD7eDFyE3bBt4XuGGrDxENpn0dXziSi/ge9XJ2wyYykPswEmJYpmp2jiUvmWHCmC3Vh2W+KkuXK7+oLajBBmY48JQ7sZDQAfmByfFVvlmw0BbhA1vaQuE9KE2OQymKlwVh/qogAQYO3Hh4v8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:19:07.3816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d296ad0-2694-4f06-a82b-08df085de4db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466

On 8/31/2026 7:26 PM, Anisa Su wrote:
> cxl_event_thread() returns IRQ_HANDLED whether or not it found
> anything to do. Claiming every interrupt as handled means a device
> flooding its MSI vector is never detected.
> 
> Return IRQ_NONE unless the Event Status register names a log to drain.
> 
> Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---

I'd mention that the MSI will eventually be disabled, but otherwise looks good
to me:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks,
Ben
