Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620371BD9D0;
	Fri, 10 Jul 2026 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704442; cv=fail; b=P0a9l1Ov9mrDiSS2wd8542QqeTYP5BYXi+jXRzDx5DlWd6x8GS0NJ4nS9cM17VilFfinNoHpxqnrYXywbjvHosK6WZ602lJX+kpCQlnSw7XtAjb348Pe29sTGBGxw9jYU4D5bL0JXdTwLo7e/BRMkbB49XeFr//EqvtnTHgW4ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704442; c=relaxed/simple;
	bh=ZrwNZTiEBkBAWC7ejB2H8bdXJGp3ZWn11gzcwOI8Zz8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=VyZFwV1Gz2Iesv17gRbNnQ9yOGORg7xGkY07rF+xlVMVwxH/WdoZikVZYY27CRYnr0cQGj+sw21jH21CwawJS4AJgjxFZllA84VZNYevi8SnqSdYqVPedoodQpxmI3CQxxc6+3TesDZsaFojJJRTzQvfd/x6Z2C9xfS4UAEaurc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lumKCdWT; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lumKCdWT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZJL0RhykvouMqa1Bug6y9KOErhdV1kyxBJEojp1NmIGjWDw4JlS+BI0275IjKanmQMF2N33KmiQeA3nA2gnaLn4I/2CO8P07GiJ3O18P0tA3ERPNNf4rPTWp/ypgDZodlTff6+CkO8/UHCIpVqBjN25DXAdCmdaTdQ5+48vMVWewoUmaQvXo31EwXBl+/+ZeDXqYZLoAQEeuP0EYaZmYQPY1rliVMO4UtxVBkLGHUuTVJLaeYmJt0UTrKzoHU1VYv4n454JiEu+CD2t2VbHGaVw6L3JCv0QDIPxxMU3HcctKQ7rKN/dxJu8oCu/cYpqsXzboVSvsMxL/zTc02lsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fz9n+FrzJwxJG8VQOtXjduP08s03c88GEcM/ENk9xDY=;
 b=M6onOtDZ89XRYVrHC9enGds3U/Yjzyo63yeqrsV9scL5fKiif2j0XbOvQRSBO5Kl4yvsCC2VdmohsIFZWiw4taxV5dPKymRI2q42WhxCD3PRlS6u8QAnuSh8tVrsUbZUtZ7UQrKlFvnb522khzVk4qVzN/WEMxS9vNFinEQQuGDyV/c4P1OhYBMv6VftsgLhICqNpEbpb2nzUdWIMlO063uKqXfNYWoUztDQ/pT6kK1I7uucj3WUjJ5vmuA3SxQji8fe4s9aDZw6R7Kx3Z5vbDB/pt6anbRVxnafy9PRF9pxUAGvXobI3tdzkaNtWOL3Ce+hU6gW3CEdvajwmLuctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz9n+FrzJwxJG8VQOtXjduP08s03c88GEcM/ENk9xDY=;
 b=lumKCdWTB297XdOVt8HkqXy2jtPquuVJmvXRJFc7O2DYTCCIAZHGdSgolS5LhYIamJiAGjV/o3kUgfA3j6iSYFVyUkMJadHZOWrJUAaPL/psBHQnbN8EkTSsnvG9Zi5xgHpgIMRmYUqG0D1VCnlQ+np2Rfd7nqZ9iuHomoNno5Q=
Received: from BY5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:1d0::11)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 17:27:16 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::79) by BY5PR04CA0001.outlook.office365.com
 (2603:10b6:a03:1d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Fri,
 10 Jul 2026 17:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 17:27:15 +0000
Received: from [10.236.181.36] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 12:27:14 -0500
Message-ID: <f22cff2a-6023-42a6-9d37-3ad52eab227c@amd.com>
Date: Fri, 10 Jul 2026 12:27:14 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 1/4] ACPI: APEI: GHES: Use spin_lock_irqsave() for CXL
 CPER work locks
To: Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>
References: <20260709162807.1957783-1-dave.jiang@intel.com>
 <20260709162807.1957783-2-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260709162807.1957783-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 245f2be6-4bde-4308-36e6-08dedea87ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|18002099003|3023799007|4143699003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	pZk7UvVfQQFz63cLxlbOg4nvVzLqZ0u9si1opYXxNbOvUYPErPBySEouKBj+JZRMG21C1Zf5fSC7W5W4a/WDSD7C7gRIfu/mjhZHI3XdxunL4bNBUy8PLNHzolyo4xS2/R9gOjy9hdNcPCO30cAsS4Dwa7ZdvtMpsAqSid5poQvSOx2zrUi1QpvSg3GRs+AEeNG2dgYY5b9PPjhPJsAJtsm0W58NLo+4oiOzZ55w3w/miAjSA4OeNckUS+bD3ZmcR1yZso9OXAD6q+u5zfHzLw9INDLJ1byXBJir51vsIzFndmln38JbsYnDNN7VEDjjZ6nR0vvP6XnaHkwO3WsObbkw7KPFVk/4qV/YlHK2+W8Nz0IU94aXD7EzXl49/UhQTGFpPS6P0/Y2fI8r8j3nDf4+cn9lpJv4OeDSjT//IyQT/Le7Tg6xOEFXGZ2uJjJaKhVpX4dL1tPwHkN9QMpT0ChCNfSWBphxKUuPR8A7cZqfMJECK1HLmwJmT7WeEImDs3fMnc8SvQaUtb0ptp7uDow6DTMmnrviA3FXvE72DT9+l7jPOe3eB9Pw3aGM4dy24ul5UvgkvboWmI/Bq8y0deLmuE3TNNGtG5Gp6UhYYFCn9cgnMcR+Y8yzR0Qg4aSDXsk+3vO21XdfUrey8SVuew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CMMAE5AtfMMirxVGj45NGRsScQ20ijFZNyBdhG8C55HDLpY4LZgcf8jfB6nvUp5F5sPHjIlFLTRS8s1HZelvKVxnCnDMuYlAYFEncAyvkeGPomLh324I8AxIWBcNeuNl0sUok4v0oaVrQRfqTAbwrQMdYNJCWU2y+QCdOhP+Tu2ygUMaxhuY32RXK43ujhflmg/vkgSkxxH6MiUiFc81W5wuCWv6NYvLpI126LJhCoAfk5YOaMOeEKGkuhQUDYQpYE74WOh//+Q3o8XvNKiZOijwnxpVvprGmK4SirEcw20BjZtVvXVV5bXvt4ht0s5or8yScIDLBsrG5NFDPwjK7bW83wdOY3GOoqmxY8+NDwP9s9ZCSCDATPltGIf6I5q+dDWvJ6ihLgHiSkuFfgQRwun2lN99xQFG8WOsQ8SeDXomjYLzp35Q46NOyeJRpYvK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 17:27:15.8950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245f2be6-4bde-4308-36e6-08dedea87ca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257

On 7/9/2026 11:28 AM, Dave Jiang wrote:
> cxl_cper_post_event() and cxl_cper_post_prot_err() acquire
> cxl_cper_work_lock and cxl_cper_prot_err_work_lock with
> spin_lock_irqsave(). These producers run from ghes_do_proc() in hard IRQ
> context (the GHES IRQ handler) and, for SEA/NMI notifications, from NMI
> context.
> 
> The register/unregister helpers take the same two locks with a plain
> spin_lock() from process context (cxl_ras_init()/cxl_ras_exit() at module
> load and unload). If a GHES error interrupt is delivered to a CPU that is
> holding one of these locks via the plain spin_lock(), the interrupt
> handler's spin_lock_irqsave() on the same lock spins forever against a
> lock the interrupted thread can no longer release.
> 
> Take these locks with spin_lock_irqsave() on the register/unregister
> paths as well.
> 
> Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
> Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

Since the Sashiko review is for a different issue and this makes sense to me:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
