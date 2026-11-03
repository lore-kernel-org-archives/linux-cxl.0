Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793728481;
	b=PzWxDAcpUBoeXqF7PGKa92ZfFgkWNWUeFp0EF+AnBd8JoAt7dtWh5MZd+K77UnN+giC4
	 2T8gSHWh5hXrfWILuDau+plk/TT0lxuaRo392VBahUOgEbhawgiHdcnzie1/vJ8vxBYpG
	 j7iHIyJSrkwPzLUbcWXV1xuyol/lOAooK45gDOnqdltc3KvPG0ZmBb4uywphbrCGDv5RG
	 2A5O4jEzs/eSW+n4RjAg9sFktYU9p9eMXKeoynhJg8zoY2eHzKl7KT4JVyaclBJ6Mg2eA
	 g76xFFwiGvrBpGiwY5pzKUoN8sEsdIWsfiCmZH/e98mRjqHoAE5ukli0uLqAZBSHXCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728481;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:CC:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Hr9E/4yHzfsl42jRyFIr+8xb2rlordrRkW/EPNlysFM=;
	b=WSkSsQhutn5q2zU4FnkD6VuplgKk5E8xmKswV0+Pdtfi9pRC4JulXIiBxYP5xDH2nguY
	 K8F82YWJ7BWlLlOFmVSdy4Nw9SXt4wN90Q1pnyLpMA6F7NhxbbjP85vfFDuzC/M497d2/
	 +M/73RXzw20x9Rik1u7ZxDTfXUMv4ogOA6pyKvibBswQWm1FcOn9TQ6czjSTd+61W+cT3
	 ku7g7ZCyONsy1OIyFIETgGEYcxAlUPAR+eVVh4ELIoj/RS2B3zMN5Qv91vma6q/BMmv2e
	 1DTGlRrrWJOw4lnF7qHno2/AF//85l5dNpf26XrC92LJxBHP6ochjrPnJFlGP6B5bJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W8oUcvhx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.4
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFF606A330
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 17:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFEFF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W8oUcvhx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORszAwEIE+WjiGXAZi1MRFoNQvi2NaA9YIHvRSWlMqCmmOdA22HdFON2mjlmV3M+ELuTVew6jtpsjw0HVhGIDbZ9ABO9iO+vRd9YUf6TlJTGXHUW2D5zUknfm7JD+DsAN8VG73mIycCPpgO4m+xVZ9z4/xaTjOH8LhzbITP8NhUu45aHnCOcTZvlmwynwDQskqDl+aZA21t1DG+Hyk0XG50YXoCK5pqHnLJDVFk8rgSzRd0T7T7dwz4zGykPk1S2IHNJ04L3aqGTzHveW7GEdB95nT8Tgy2IswuvSnswqkWgKOcaiM3O3M1ji5BjKH2GxPbLpoCWuRcifDhVsu40Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr9E/4yHzfsl42jRyFIr+8xb2rlordrRkW/EPNlysFM=;
 b=ynek2FA+xuxiqTUroPB2s3lidpCEACtD10DeMFQE6uDQr8vfsAhxIOtuwBTDMkoeT4R+lKlKBQNZVHA8orYzToaULgZJ16f+xMXAT9hWUXrfcAtHDaAcE8bfhv3ILUXDojZiPCbX5tSJcZqvfhQV/JurgZ2oBHjac4JJfdX2gpxp6oRaULwstx7VGgmjbi4KAiGzajQt7ms+rqmsKroDa8rny5XtatBQ8rm4qJ066ltO6kkZPgYQSyF0AKtn3+XkOy3TI12rsKMXzdRPTreDG1RDRzatVXEmKiok35FvxFs6F7t2gJJijg8plwofxEVsIz5nkD2F9sj/FOaFZOj8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr9E/4yHzfsl42jRyFIr+8xb2rlordrRkW/EPNlysFM=;
 b=W8oUcvhxxJAbDMi0g8mqoWABWze+zweu32MCIfjLL0JkzvizRt6cCOIdtsKArwDNVbVDFGX8n2jL+nvi5wOYOL0TV5gnWgQ7LcAXJiMPlVlK0WGjkXbcih+KSMs0I/zRE9LuysL4C/bNG/Iiw5mcZ9FFl8hNYzqvOx+GaiDee1o=
Received: from SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 17:54:33 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::71) by SJ0PR13CA0026.outlook.office365.com
 (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 17:54:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 17:54:32 +0000
Received: from [10.236.179.122] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 11:54:31 -0600
Message-ID: <b6e42005-aa25-4135-97f3-0ef54e7e6e64@amd.com>
Date: Tue, 3 Nov 2026 11:54:30 -0600
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 2/2] cxl/Documentation: Describe clearing a region
 targetN position
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>
CC: <linux-cxl@vger.kernel.org>
References: <3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com>
 <e87248b8d13d3f07741243a45891365450c66881.1793653629.git.alison.schofield@intel.com>
Content-Language: en-US
In-Reply-To: <e87248b8d13d3f07741243a45891365450c66881.1793653629.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e01edab-e7d0-4c05-e980-08df39d38432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	oK5i91bYOuWIdTkG2FNUVBx/FfUAiXmkhbQNa1N/b6qSU/UGWKlqaLKzGByUIGfQUKpsG92a4RKWJWnUSlBSvYbJtFtckRVqbV0QaY0kBpGS3o6T1K76wF4TMGqMXI+SbZpJLyc9s6l4HWeajTk7SIFLVm99yaiVI/r/zXTlQd6HgriSPmhjLj1PLQ8s+M+n49i4WY/j1GBZTx9BVVHNaU1OoOQMB3OfDjKar6Efz6ArTysSEVcdLV+nsn+oxLltErcDT5U5FJm3n8x9BFMy2DcgR631vTW0MizWwRY01jqephJ4VM9rLVoguvGS5crl7Jvv2KvCWBuHAi61ikdu6jVeBTmdicXSoxy5ITK2qVmfhQGSiGPJxu+39cT3Ea10BUZCKt7KQUW193pMqRIoBDYO3YgJw/Le80LBgVhPisxOta86LOh7CJEZeCjynriSNqWbsTC1ZlTpzoFj6wf59cKxZb49AHblmFisI40ikzy5VAeGLR9WPYAK8bcALqV2fhvdWX84yX62sD7/8AaVf+Du84h5FOAS6ONFkDKmmmxZEwh3dSKc7nQZ3r7XAMKvYkOosyKcpuHWjSA8nCQjVNkZLLZJLvYC2zdxPou6+x+bidmrW6k3nd+27uwO40jyEiP4WPYTr9lzAXB2GfoGWL4tNt4lutVtUXYI5dwy3NrtmpcRaRwh+Nikkly59kbGjLNBTzvpNEUrhF1QWMX4gQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qFSebdSVXl6gxnrKtIvTDI8q/Lz8+5SEScCgcNhJadOoJsp7r0Pfe9SBRLMuVdm71h0Rp6VRQBbXclvgNoCUyFOlbCFgQYbj+tq2CAaYfvt7jcaohIGYs3hNgwG13AaqAKXkMdUAQzuvbTFXRef42+dLvMkIBpksPf5PsAsIWJVPYK00/+D6w72W+yiV/sZVhXe0HpsWQiMIpiK+p64C/kELQglj3Burt1nndh6IVHdGPb8ZWeGRtJR0XRrUFLlCi+qEdjoJFj5tC8sK52cPEOh+1hgylKH0tOpgHjLC3BaY1kO4BIOSxGWLBOxMgkR5h5g2FNOFEJYfJztaSQqci5nDNyNuY9VvEPju5ahhaFG7V13JSgf/OuEOCn+TcVp8xbGse3VcKIwjq/kjDKJBBB5ow8PCn4oKhGqemgwCrcara+iocokYcKZCKaP5vLOX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 17:54:32.7425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e01edab-e7d0-4c05-e980-08df39d38432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

On 11/2/2026 3:19 PM, Alison Schofield wrote:
> The region targetN ABI documents that writing to an occupied position
> returns EBUSY, but does not describe how to clear the position. Clearing
> a position is supported but undocumented, leaving no documented recovery
> path after writing the wrong endpoint decoder.
> 
> Document how to clear a position by writing an empty string, how clearing a
> position decommits a committed region, and how the region can be committed
> again after all positions are filled.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---

Quick question: Can you clear any position, or do you need to do it from the end backwards? I've never
been very clear on when ordering matters for decoders :/. Might be good to mention it if so. Not a big
deal either way, so:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks,
Ben
