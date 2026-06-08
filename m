Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67F36F420
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953047; cv=fail; b=cMUL6+2HDDTf0XIqy3NdYL9iALSkkWFclUnhydbCQ1VUyUAlObknbYURThiN0gfW/bAYiyxDeYANH10C5geXxOcq+t/NmpsJujSYUbaGSR4s5ARCPBjDuHqn+LbQrg3TqSvc6jLfnIO0uTSLOd7lttbwXeR0yrCvBDn3bfKw238=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953047; c=relaxed/simple;
	bh=eQQF1r66rjuxEjbEHlOdUiznnR4xfdVpvneBK2qYQSM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=XpEypZsm2CodY85ohnjzuOVyApdJ5kUcLECCa+M+BDOcfnN/zE+zt/7hhkkQrP4QLshYmsF+dv2sLUrlNrAEJxjdDOs232RIcW2jF7jxoPIPiP4t3DRrJYPX9wWQ5Ex02Ok3bggdBDPYuUnZN0684Qmr1dlCGSDkNZnz3AAJLmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d12CbaRs; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d12CbaRs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b84l5oQ1FvwWgCJwltrRJ15opWzYKZ5WYrX55dyEwEuZHWRYaz9mPnfkpRZh9UnWR63sv/IjPaD2OypzkQZJhWEptHdQ5qjf9EZaaXOxNwK7jywXgOl9nh86zDWjO1ea1NotdGjfEAjr9ISMDu3wZBSOt1LPq9sHjUJaYBf+X7x6RgT6UrkMR0UCg0Y4Wvd6Mjit9V6Hch+N3fOyvbJ1AXoupsQlcUMhHyeZ6WXOy3HHju3ezIfLfrAe3swMy4VnuSQXvTuTEl20cDI65d3NaUqsyZX7E5G6un+hzZI26MJYTy8hIJsmptJ0gHbtbsSOlO3JWRHDmqrnb5re1yZ0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHkCgH1xhNvS1ZBgcUKdG/mdOgmGgEqgwLLxP4hUPqg=;
 b=USmKFxAnjQ8lLnn+BG0q8bYLvCkFtFu09/AzWNZPS1x6hSIudedkxZz6i7GPV99U2MoUJmF05AadGVWB+hSK6/bgAJNKlLCBOa8NAfOShXovBRP6hXzDBVtibQm7bP+5k+WpbPT3aHUqUmpG3YKJqOyz99uB5REvWJnUc2iwc2FgMY9r2xgpGhAmVA+hHY/mZTGdWBEzC1q1gyHUpmLg7zD8gPhFzsk5XSJZHYA5Us7byn3uCgF57tsUc34th+O6YOt225/AoqEdtPL/i7Y1vmNIJXgqjRuqp5ChbdKhdGPv+Ji2twtNUBV6+HlPwZwo7AOXO8wOU4dx5S0NFs5U9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHkCgH1xhNvS1ZBgcUKdG/mdOgmGgEqgwLLxP4hUPqg=;
 b=d12CbaRs4TD6LZl+/c6RX5F/cEzxSa7Nba3iFQuCiCqcBy2Jk4mlm4iflokqRs2v0cMvZnqsuieMi2IsxCnKN//MlLxRHtfhShz9J0YmMB6x3DfSYXjHPcDyTw2Ipfo0+dQ6Bu3dcpWQr+y+haHC9FIN2F/aqVjYtgW1eB1f34Y=
Received: from SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::25)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 21:10:41 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::42) by SJ0P220CA0009.outlook.office365.com
 (2603:10b6:a03:41b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Mon, 8
 Jun 2026 21:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 21:10:40 +0000
Received: from [172.31.129.70] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 16:10:39 -0500
Message-ID: <214761c7-6d89-4d76-928d-da8fe5c9027a@amd.com>
Date: Mon, 8 Jun 2026 16:10:38 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/5] cxl/hdm: Rename decoder coherency flags
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<gourry@gourry.net>, <dongjoo.seo1@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-6-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260605003329.2584012-6-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ede0ef-fe69-4c23-bd2c-08dec5a26568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	c4Uiss4l0hhfVYPwkymYPWKyPUDMOyM+W6LPV+44UrFg91QUC5JXUsZa5qoPIweDRAbcIb587aJEGHYxK0HWPf7vzG+COaU2hESZVAvj8alyn605QHy8WGR3of+G9O+rl+672SAi1EYudnqJ/oS3gjov/I/++353Bm5NPeVcqbHO5YOWYql2gHoeTkYeXi0g8QDib2uSFId4tnqwTCa2iuRaPJobtOIJoGhs+7lk87uA8cADk9jlyMhFK+Dc6mj0wtLeHnKp0pklS1UE7Lt1GffVFBg+jKz9D2ENaKgH8Vh7yVgazIskoUgTZxw1K2PUi/4yM8jw5VhcVcua5o6WUYsFFKlw46wB2+b+/FXNVdp30ydONurQ03rVIHYp+5hwqNzJ1aKMxXPOVIlHJA2yNiSlOsd3re7ZHtjuPaSrfcy4zI+nfnCl2+dhP6D0YanwH5W9tS8ET1YsTYX4xnYpW+IqYedKD9YE4EKfOo0wyvECgVitlUYlUVGc/hqa3nCkkfdoEkwbLGqMFtsa2R+3WLzALSyOzdwCGUL6rtPhqZH7cwj2CigbFRkPhpYYRNFkm6Sbb2Yh0HIDwS1HP+2+buI3JujsDC3twA6z0hGYzP+JuIffyEmVGPvgNbkiH5otXG4H0qWAIDjBtN8KNXPZ4yfrZx5/u376GcRJK8LkvfqEnun8yBU7EyRbZJhz69t9qeyLRyNMriOoVy+8ZmxRYqvFifPyeRaIUIUWtDic75Q=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nIBfqCilEDReFCFYsv++UBayTxzpGUjfs8A1PxsSkPBQXvpd+5iJpBNdMsvThm1iRD41M9E+kJ0A6k6jaxP4L3lTEvPWyZwvF1ZLEa2bxwrAyH48FPvJFxv1U4JgBxe40a6LXr3IbJuGw/O9PunMbnTF8SFDM7mx6KC9rWmZJzAuRBlRx8xUvR7D/3F1V1oIWNMrCyqbB0bek7D/AIPEQpyVB0aKnd+WT5y+d+Pn9urnfVUbK4rSNl2S9IKkoP1WtfOT1wTWi9EyLc8fooacot1Ne76RSkePOKSiiCJvElGx1laEK8gA0NZE07IER/s6eTrGrs2H1DXlWkqkkCrVgN1I7US9gbXBwt7QHXfEeaKJFt8wYgcCQtkhrrNx9plWvXBzlgt67wvnYnPwO2hbHI4iT64Q5hhcvQDMyhjBszCqGefDV+evcEKUYmYGZCKE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 21:10:40.8564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ede0ef-fe69-4c23-bd2c-08dec5a26568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911

On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
> Align with the ACPI CXL Window restriction naming and convert
> CXL_DECODER_F_TYPE2/F_TYPE3 to F_DEVMEM/F_HOSTONLY. Type2 and
> Type3 coherency models was named prior to Back-Invalidate.

s/was/were

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks,
Ben
