Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793394275;
	b=eFR4dEAo2B8YKuOmq5KBrS19t2LZ3IewJuRNTbVLc7Qphkd7j35t3Do18WTvynvH0T+w
	 v1QSfcDLaCy4byxEZpih38Jk8Vm9khRe8ixKzHUje9E/vyBSvS1rEGL9QIlFiqC85xYZ0
	 MFqDy8W2/2Kx5kqoMJO+eSVCazlnggl/79cxA1DTE0s61MCL64GEiCO8MkaWcgVon8G9/
	 s1STjBpUc+hgudP9odPGNCsqGpz4oBji9fqu/O/E0R4yc1rrBoPs8dvsevMsL3Ss3/Vyw
	 LaSa4zs3KOu6b8rosLl4IbFgTtjnoKgbqxtHn4IEqs2jMcZu9QPQpToZ9zRE83Vg7tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394275;
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
	bh=AbNLLGwpGh0+KyD/EzfOZD1GECVGyo7SffLbOJJEBaU=;
	b=l2zOjMlVjd2u5E5VgDTxq9fPLlclghkuwaF0kYPqMmeYRL+rlHNlmsEYjIqsoK2p36zm
	 DDgjc2eUmPYsL9nt7AMGXwWIeRBGjaNi/jtSvWmnXigUl2QxPbuLzkymR9sk4rDxI9aOG
	 mLUk7LDrvwIQRkF5Ul+gmhrWk5ATuYh8yMof4VaC86zzyuJR3a8btF1o+FZq5Xr2xP8su
	 Q9l1vR/yV063x0J6d4ygDkRcej+8C8aZ2rQYxMK3DDpxDh6P7Np+LOGi94VFq6l0UmO/d
	 Xtsz02g/QaQ4tRSHs7s0OQN9XR+GN/adpj83vN0Bxi1k2qCbPesFhW+I33CbsdbPkYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1R4aOqYI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.41
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22B9606A331;
	Fri, 30 Oct 2026 21:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B22B9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1R4aOqYI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCfv+kY+vy9+k1m7X4gj8uZHmZGjmm1V8b/xG5d6uo1vSnGQ8HYZ6JWipYMG9/rhdsSwoR4zvnPEzFtCAEaWzMbBA78/ssIerrCW93/Oq7xCVmj44OOsBoze/jwo9Jd9T9DuXfXbc7omLDR0GEbxNO03fr5RJmQdUSBLWbq2k4dwdgICca751hRVpYHb3IM5nFZJ3JLZuFkqeU/jW8G3M16hngFiOoz5N3zzpNcrhymURirYluIf7J9Sq1gGxKOTc7jCwhQowsguOtT3yIlNFvm16hDJvRZ7VPyXgY7kwr/nhHxlSPET5D8tiTYZEqd0v8Gl4305RENJAoO/Y1LDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbNLLGwpGh0+KyD/EzfOZD1GECVGyo7SffLbOJJEBaU=;
 b=cXwA7zn5JQmhKTDkABlbXLa6Ba5l2o1PAk7XNKhxOFLlG7ACYINKbaHAGrnSkt+fJUZBIjEwulWgB1ZUTz35fc136mc2U3OlPHtqJX02lbI8tam8dnch9FDtcgcVuP0M+gvAJ5Vtf0XW64DPsUfV9n0isEWaaBbFyqwJNHWXqK3k49UpPGWLPMWlZxNOXIHHu9MM+58bfQWoEX5sH8PaCmptDii/y39ipvl4eIT0VY+mLryXnww6gno8Qpzctw2IR4BVMD7Wa3fEupeHpN1RAV7a4fIkk1ayPPRW2rCEm75BmOrHVzn4acUgNGr6SPZPAFCyYutfTvhKpDDOGwkAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbNLLGwpGh0+KyD/EzfOZD1GECVGyo7SffLbOJJEBaU=;
 b=1R4aOqYItli1SM3l41mBq0L5Qfac0C4+omo2TjKlvjH9cOpvTBtOdggofLdas0pbqH4SPtvbYr9aAZS+j+dzBR6mVxth8qrz/yMutSdEHK7BD1mJTeGGKPDxiQGPx/BQiCHQsdmgUN9E69MfNrAumCsLaLYuZWyp3LQaL7Lvn0c=
Received: from SJ0PR13CA0232.namprd13.prod.outlook.com (2603:10b6:a03:2c1::27)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 21:04:28 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::94) by SJ0PR13CA0232.outlook.office365.com
 (2603:10b6:a03:2c1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5 via Frontend Transport; Fri, 30
 Oct 2026 21:04:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 21:04:28 +0000
Received: from [192.168.86.104] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 16:04:27 -0500
Message-ID: <715b5f44-2f0f-4c96-886e-a78d57ee17f0@amd.com>
Date: Fri, 30 Oct 2026 16:04:27 -0500
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
Subject: Re: [PATCH 0/4] PCI/CXL: Guard reset recovery against inaccessible
 devices
To: Richard Cheng <icheng@nvidia.com>, <jic23@kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>
CC: <ming.li@zohomail.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>,
	<newtonl@nvidia.com>, <kristinc@nvidia.com>, <mochs@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260929020405.9724-1-icheng@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260929020405.9724-1-icheng@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 606ae44a-50e9-491b-4728-08df36c96305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|376014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|261021121427099003|261028144727099003|261026121527099003|261026140227099003|10067099003|261022075727099003|261021123027099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	LyJGu9kyAwUI87WlNLpUd+yyuJ2kmGq7gcbaSg7LlaZc5Gekw9VI2XTKzM+NNNoEUAqiWLKg/opJfTQECuusOE3pwNPw93ZGKHhoECvXGYQ42vSJ60WOOjLtWx8pJyWrkfsRGSHgMrxPCc0ie8v/iQGfy4RRSZG51EHuwpZCTN91RcudS7XlNJdfvivbOqRf+cru6AbgkymvVV8h1oJoTv4eaJCZqIjecwOmSO1IH5UKdKN+hhlJMoqgNlChMbK+4rFxfEZVHOEKyvMzQRoZ3zAe+/x9Y4BHqTvbtHlgghl/ctnOtoXcgLjbOERTtG+hPI4XF957/MfUKia6qpuG8G0yFyyHDu0ybIuLpD6pcbOuiNd/uJknpilzq4d8FvInLGzIM6GCRTCiBerWhJ0oUI84uRfeauaxnYhgLXiIkgWsXPpG5jM9qKfEc8XhcthLUBbUZrtBwUbGHq0R8h1eWJ6M/mpsZbFVIcs6vQ+LFB92yUlVojGQkS7I3jQrrgmFiWnjFeJMXSEvCFmHJzCbl0YTFonDPEWmGkAni1dQU5/xAsaxxL9hBHFXOtbLHXIrwUbNW99Qdj3wRx5sTu9mkfmz7z/vgcZ3so5gN8hEbL+0QaB2FddXwFbq8EB2h3PYseXerXZ/9PW9KLHR9FyYcOYGxCeP0suspdpJgcE55ge8TPT8uOBrpz2WTyWjfeHo6p7WR6LrmjY6s1VfTHxzmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(261022075727099003)(261021123027099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HTgH3sffimiBvcNbAAJloC8wCE6ubtpyvh7r2AyOWR7McHziXl+KegmICQ7BTSYemwfl9ZBYn1MUMcL2kxnd1LloeF4mx9I8MODrjEBMCvPytxFTNDIRx6Exb/vleXYPnpZ+SPtcuRcUveLJzvoTsTKc6rm9Cvnyq9zIbl8BvTY71b/B5r9nGwbGrvrMf1JplBqhxwzZTXrb64nlyG7n8NIF9H0p3DtAad0QCcCpW+Rc7HksEmcHoj3f1wMi7GXlCo+OY+XumHIT0mOlssCKmJRRxWmAeokLRZWNAvJTtKHAJzEL8NkPmtREvyBFXDCOzL0wTDrn85uVFw0PE1UqS78beqHlOOMUyGvLY7iUmxhKfQvdUwPcAShIvTshhaBtWXJIzsSt3iEE0h9aTSrQjpANOjcl1TEUGYYZDPfDevkxW3ZEsJibGCjIgiI8VwAG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:04:28.6740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 606ae44a-50e9-491b-4728-08df36c96305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704

I noticed that linux-pci isn't CC'ed. Seems like a big oversight considering 3/4 of the patches
are in the PCI code...

I'd resend to this with that list in the CC, or at least include it in a v2.

Thanks,
Ben

On 9/28/2026 9:04 PM, Richard Cheng wrote:
> During FLR testing, PCI configuration reads returned all ones. The
> kernel could mistake this for reset completion and proceed with MSI-X
> restoration. The resulting MMIO access triggered DPC containment.
> 
> This series addresses four issues:
> 
> 1. Reject all-ones responses in pci_dev_wait(). Use Command-register
>     polling for VFs, whose Vendor ID legitimately reads as all ones.
> 
> 2. Return -ETIMEDOUT when readiness polling expires, preventing fallback
>     to another reset method.
> 
> 3. Check configuration accessibility before restoring PCI state, while
>     preserving driver reset callbacks.
> 
> 4. Skip CXL decoder MMIO accesses when configuration is inaccessible
>     or memory decoding is disabled.
> 
> 
> Best regards,
> Richard Cheng.
> 
> Richard Cheng (4):
>   PCI: Reject all-ones responses in pci_dev_wait()
>   PCI: Return -ETIMEOUT when reset readiness polling expires
>   PCI: Skip state restoration when configuration is inaccessible
>   cxl/pci: Guard decoder accesses after reset
> 
>  drivers/cxl/pci.c |  6 ++++++
>  drivers/pci/pci.c | 16 +++++++++-------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 9eb6419022d81aac6d1d9ead0e1865b451153da5

