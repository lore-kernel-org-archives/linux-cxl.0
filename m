Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234A374E47;
	Fri, 10 Jul 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704457; cv=fail; b=WcwVVoQzQl/Ykkxv8sgzKs9FRvBXJc3RXuYnvL7PMmxYTIAdLpyy78eCR1vm2yLB2IupZK5cFYjPZPNmK6TcMTYUCfPJVgJtx7u/tGgHRbEIQwyCsHUneHL9xPspriZ6wZbQ2mc7NGkLKSabnk1GRjAVqSZjp6ulq5x/a0RgbvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704457; c=relaxed/simple;
	bh=G2bsdYeKqD65CM2plH1B2jSw+K1Bt9JhDVlgnztBmTI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=J4O8torqNSeypQ1DZ8TNf+ry/E2HxS68HpaALVFj5kBgpjeiEiCzPIPl+j+qkg24Q5oydPSqrTloDa6t5/Mim+xV9t1o62tqo0tETCtTNERI3HVRH9WxTer1rKvDKtnw9fCqYoU78Sbffl/ng/kISVgHexCsPu1aeT/73Jw0f8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZQUx5Uqv; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZQUx5Uqv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Pbe6fuZjj9kyQZU6FjBun62ap2VMYY6g8CrOUOD6xlXoJMNJMMacdQl1aNym93oqsB2RQKHnfVUZsptRREnJlXRTFeBjVGXbmKsSkvfcR8ell2GwEaeJzJzbgTF3t10BOfw/sdHv8Dm4Z4KokOqYRxfLbN180n7OHFtWQxddk2zk6Q1mikJmmJbKzwakqGpkxCRUUco/iXbWgIRhXlLqod93kCCUwauD4IlfrwNuxqMCrGh3Zk1e+iSNERgEUveeQW0vkxd4LlIyHv1o/g2k06J7xP3XXrNR6ReSGEnbmF65CxgNKg7Gkvvzs6DHc4I7J0l/v1CFvAs/a3IQiokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS2BE+wy4ePDIBKI/08vYSI6eZMbLHQk7RiSyrJARuI=;
 b=bM0SSMdqVKYW40NRwOYKdwxqXmv3Wcp/MlCIWPkBWkiDqvVIQbspStun5UBT20NUQ548Iz0abRdSvFowXgO/Dfb6vKP5XYLRk0Fcaf/2i1uSKIWNiyIm1idUriVxCi2Sslc7nQBB9x5V3rGvCnlqgNR9Um59RvQ46KzJLwXPNtDsPgadnOp0eNM0fvEvE3sgi6NAHrtjuh7EDK8U5cNCu7ZsKlLT3LBs29L3sJznHA+4ys9tf161mL0mtbqZxvf9jAG51cxM+TYkHUy/YNDLlHNVg14L2LIEjNqgGbt0skeFoBI93r7MtI86Kg/ABUWvO1q9Asa1KhFQPNQ4D61gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS2BE+wy4ePDIBKI/08vYSI6eZMbLHQk7RiSyrJARuI=;
 b=ZQUx5UqvLestSaV+nT+JnpvoXNj8DPOsHtBxpoxHXGjsluz/CdhBk9WvSMUtNkEBl22h/iKsy9tNZ8B6XjWLZ7Crl/sk9Hhnf7BTCEMOdWvWhGTC3dNtz7j3L6mV+/G0T95uQWJpDv0Zzp0JAd0r4jYqnA8nJnYmbLYe30EmD3c=
Received: from SJ0PR13CA0174.namprd13.prod.outlook.com (2603:10b6:a03:2c7::29)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 17:27:31 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::6a) by SJ0PR13CA0174.outlook.office365.com
 (2603:10b6:a03:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Fri, 10
 Jul 2026 17:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 17:27:31 +0000
Received: from [10.236.181.36] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 12:27:30 -0500
Message-ID: <944b765e-f692-43eb-ba99-c4e75b89419d@amd.com>
Date: Fri, 10 Jul 2026 12:27:30 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/4] ACPI: APEI: GHES: Validate CXL protocol error section
 length before RAS cap copy
To: Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>
References: <20260709162807.1957783-1-dave.jiang@intel.com>
 <20260709162807.1957783-5-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260709162807.1957783-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: c72c378f-538d-454d-1404-08dedea885a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|13003099007|18002099003|22082099003|56012099006|4143699003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	KGjmgIvLwoAlz3hIFp6HFynFDFV2A7m1JuQRlScdHQrZsK5A3AevF7LnRAq4QbzQJl9xwdSs5brq9KGaLdGtQKXmYdeD3HSnHD/GVcCSmnlrX6Wqin1Yii6sNMLvKgORgOUTeZU+boKzTSxilfEYR4FX5el6lxS/tCvlOfmno8A3dbndZVJLB06o/Ktd0jq6d38NMgFlu1fpBhtTh8iEl5kYBfsC7KvuaNvZP3bSFgoPACrCbQr3IqEtoG84Gf8F7pKxtWBLHxrc4wddRMzYTt0C1a+LWbXprj0ZgUOwqyoQhkA0eKIz2xmlMFAKqJFyL7pcGDaB1EpwllgKbpT+TH2QTArJtST+ZUq3qoucCA2FnP7uaJwTH81UAvWfDKwDrlVcdYK096Nvk9C2hrnNFZ7JM3Rptj98adOoluO2VkPet/L+sexJXXe3EuvujozXvSfNuX3DLT6fGGi7ZbV2PMiGNrsOOEVV/QbQpM3g6AXlg/dIhEVt+boGEDEZ4ilI6f10LXS3sONASVXYFT+TpQ1Ftb2GvKHuZJHesry8cYXXhpa0Ve35LGFOQcoTUGe+x5D46ksSqVOzKO/MKZmmPBfaxUNpsyFhHAJ4hB8FmPobkRQW3gku/O/BOrtk/7M5jP/GB+imwItPcd3gdGENng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZhFH0bTdWqpyCjyjQrJTWdE6vECLbpE7Yiz1ZERpfKUtU5A+9ahvaC7ajObivcJXSzTi0iDgsKLdFpn8cIG4kdbq9ISHtZKAsDRLWmkFo3VVp0oS/gxh5OobZh26hlqrnSxCDmAB7CcsgUFry+z6v2AmSN4c7/fKkcpiF3rEVve/6Wh5Yk7w6QseHkS1LZlidqjiz+J/Xcdr6oE0C8PSekaJqpMWz4pZiDhjdfoPaDqXJBFJNila9r2feqAf2DLK2k7JaNxLRVyF4AUTPOtbx8MuBdYmC2kbbDhHquwix78l7Sr3Nn/EWre89lOKKWTkdpKR2PvTgV5GIMfDpWAAgqz0EkCPmC5GLATUhqbR9fa8ArJKp3rFH5YXIQdl6r2EamL4SkbFmLu3bNERjberDwewPsiauQCPApUQchjkXMETxjkdOP0p3k6GrzmHEJ2s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 17:27:31.0354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72c378f-538d-454d-1404-08dedea885a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505

On 7/9/2026 11:28 AM, Dave Jiang wrote:
> cxl_cper_setup_prot_err_work_data() locates the RAS Capability block by
> skipping a firmware-controlled DVSEC:
> 
> 	dvsec_start = (u8 *)(prot_err + 1);
> 	cap_start = dvsec_start + prot_err->dvsec_len;
> 	memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));
> 
> prot_err->dvsec_len is taken from the CPER section and is never validated.
> 
> Add the check to cxl_cper_sec_prot_err_valid() to enforce the check and
> avoid copying out of bounds.
> 
> Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
> Fixes: 315c2f0b53ba ("acpi/ghes, cper: Recognize and cache CXL Protocol errors")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

You may want to check the compilation issue with the last patch isn't also present here. I think I've convinced myself it isn't,
but it can't hurt. If it's fine:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
