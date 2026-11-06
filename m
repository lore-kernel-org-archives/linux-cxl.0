Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986206;
	b=Xjbn+V/ycEMEw8Bw5kw/HhADm53uGahUktGYBtdBAFRSL+d+lwxjMu5K5nsXdGrtCn5u
	 0PESpoYMfqY8S6ZgOOCis8ynHQNk8ub568rIXs13Ujrj4G0gxjxuutIDqPkPw5LSSplhi
	 ZkPfiR2IapgrEKgFz2i0xzDk9mutZPrkrWCE/mjcLG+MVloYOLJXJaC9gyRuoB/ZOtTig
	 31HccRmdPT4/grDtyBdIwtBY7W5uQ0JzJO5/T7TS8fdrVMnuN5qLhh23ddBhngikp88N/
	 W9uhPbUnomDPPhA0lqnY6qP5ZSdM278+aZGsNiwpAlpsYXTx9uvlLxIijW/ZAvokayw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986206;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=g3oOBE/LmXoIAmbqztO4y3rB6He+YJNTb10VFy46wP8=;
	b=amtPqdmvBxQZYosBi6p2XcCD/Ok0hW4OK9EKmCwQcXUuJLIHRDoMNlkZ09FPXodPwoIN
	 cRTMCRzsRHTEs7S1R2WPExiP53N1kR53YChL4p/CGF3O/FaTQAHfZWHw36sYreuxeI+/h
	 stfzJ7VfjPJmbRhV+PpDgU7FcY7IyOGptG+cmNNEO7Aj3Q/0Y353U2yQYq4kElClIrKxj
	 mtjPAuwavapvhw8CJlXmCRp+8j4paLKY0O7G2Ma8xyUTdKk4+c8OmTyW8zbRJTn3/qfTX
	 54h/mrTRIYqKDCgKUBa7rOVJAN2j8TLB25vrPcYAtkhdu71iDV1dt9mXTwDSQvpnjbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="M/Y5qbEg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.18
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24A606A329;
	Fri,  6 Nov 2026 17:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE24A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M/Y5qbEg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GD9hidHoV5UM4d5CnqBsdjqLjiasBozIFoIXU7FPCxAeKU3PILExXIKhEqs1FKfmPE7xgoFdZsKY5DYwEty0386v6NxNigadY262hJvAg8ZPXhSgHB4PD5Z2ddbkLw2/AQc0iPVByPlOZ0xaWhHQnqULzH9AGwPtHlRgC3XneINraliWa4nQMT2IgFxVjTE2xwPGdlk9H+uCUdM3Q0rQFEkSASDlqUB0xd0COB8xiQpFEsxjellLbzTiG9RkDurzxlEU5w2plDoVjclwr2kmb9v64+/O7F61f7fvowfZ5LMRw8+iUpiBA/GAEnsvDDL0t7JZOuLMGDFE1A5UyfBz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3oOBE/LmXoIAmbqztO4y3rB6He+YJNTb10VFy46wP8=;
 b=hHx1lk0OQrdZ0rI3JLM8NNW8DqHDmHMUdNjfgeD8P0IZx6WWb1CP13dhDX+XrUk16HI3ZFKS+vLw3RaqyB0d9d7RG5fKas0xmkT2Yi7PBF/uNIXZXF3IMQzXLDqDejNcttpX4yLgLaYU31BUajJ/c54/Ru2PxWcsdNaWjK8/bOPw1yuST6TCtqTGNOIl5CS1767FfeQpZhV2Wl/BE0jV3y89JKSWk9Fuj4heAq6ez5UCA5B1I1L1nTNCTeeOoYMBCGRKvCLzlgkgZR/xV30QnSjTW9rhRog2R8QFD6JT57tWLVWvniX+QXfObsVcrc78Lb5vGNZeozWpgxHB8o1rDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3oOBE/LmXoIAmbqztO4y3rB6He+YJNTb10VFy46wP8=;
 b=M/Y5qbEg3Vpi9HEKaVF1SGLzU8tbkGoKh1IHvX0WqMyggrZnSeR2iXBdRrYokjuricIYcvMmoqYN7DdbU0c/oxrekQ2pAHa29q7oqYrnitsTGIS4+eTHoD6yeYvj0e3G5AZlzJ8XpT9NCUarVJP/HBis1zYX6R5GXoObVux4y3I=
Received: from BN0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:408:142::24)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 17:30:01 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::17) by BN0PR08CA0017.outlook.office365.com
 (2603:10b6:408:142::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:30:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:30:01 +0000
Received: from [192.168.86.116] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 11:29:59 -0600
Message-ID: <68be7924-bac8-4b99-9c2d-3ebe35a3f0bc@amd.com>
Date: Fri, 6 Nov 2026 11:29:58 -0600
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
Subject: Re: [PATCH] EINJ, CXL: Use PCI domain for CXL root port error
 injection
To: Alison Schofield <alison.schofield@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown
	<lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Pei Gao
	<pei.gao@intel.com>
References: <20261105184643.907678-1-alison.schofield@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261105184643.907678-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e9f503-0d51-4974-5a9f-08df3c2b964b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|10067099003|11063799006|261021123027099003|261102130727099003|261009223027099003|56012099006|261021121427099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261022105027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DqI1zlq0s+GraddmuX1p8X8EPM6HtVrBTLn+GD168iNlCrjiBI94wNRMP7ayL484ygl2Xq0lH8hMTzpreWw7WVfuY1tYAHF+WVBIsLvh6MRFwGAjZF9XqSi34oEWTR8T/qlhOqNbu6/UKbZEw6JzwmkICrc2yZkqnLqNiSnzCz5FrR2yupDqaZH3NsjYU5IKbfOIIVo6NHJsqDbj2GlOC08i0OV/E10uQEMsR1jzEIHMbHyIvxoGZ8ZjC2kd1Pi5URlZ6fLDZTH8UCkmxYhElNaMjVy4GD5wMI4+gXs/V9ucGmCYKhMmeBlpR8FPh0qQj+tdT7wt4WBZahn5EMM0YllhpQWxu8FuU14d+2eyY51A/gYtCIpjOMWKPhXPdiA8vafmgTnu2zaTncmT0d00UhNJGdut3tpbVBJ+f7q0DNxNx/tbJuTCkl5vnmN3A8aZCCpvKKxi3lRUwnZRALuGoWRd3y8wslAwfu/h+3Qr2Xb2dK8/5A429UoOwTptS2MLXgcSk3Bp6/8VZzyXiVbRaoU/WcVyARIL/X2CIleOhFqH3mMsYLV3FYJzOSJudWvhX7UN3/gvaDU/kz2jhkY3t3FB1GXF9HoTx6A10Ja6Ze6TlEFqtuN232sxQypEe52nI9DmJLfFUWT3oWdeR/DC4jcfO+pQc93FEXoThWI3K7NBCasW5oDz8n9c9dEWwdCxj7wvecrpjAthFXrlg7YlAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(261021123027099003)(261102130727099003)(261009223027099003)(56012099006)(261021121427099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rsNTP3QNjCETp12Hn63WeX7U0I6sHvIOxwM51kWOCy+Kw9SwGoDeFIn/GBJcoCix6tNqyg44yoAbailR40a8RTujV6pkHHFiTDiDIHsSHDXg/rukhFhHQZRIzcfnRc23YuTCRDTbE9krmNOZxLAq+ELddxsMS8VPeHq1ajSfRvfpG7H4rqdpnUg+P/QGC7Sjl/BD4EVCuJ30XCzVPkAtoVkNheu4H79K+90WDVfPIv5gWVOPCED0e5VymEMyy4VutguQwIEfL3AJmh7yyUSQRYhDn/zDNRj/sXIm1h2k+3QcqLReNV3ooQM49VTujyviEID6TcTtL5G7mjmrfj77VdP/a0MCIj7Rs3D9Zltbr8AH2wmGI4PkmtOCydvXLUqTsFzxGa7sAFThfK45dJdLpozzFOpyokrJDnoBwSiYm213ojG3mXLdrRw3Udrx6Bj8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:30:01.2252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e9f503-0d51-4974-5a9f-08df3c2b964b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

On 11/5/2026 12:46 PM, Alison Schofield wrote:
> CXL protocol error injection identifies the target root port to firmware
> using its PCI segment, bus, device, and function (SBDF).
> 
> The segment is taken from the PCI host bridge's domain_nr, which is
> only populated for emulated PCI domains. On ACPI systems, firmware
> receives segment 0 even when the target root port belongs to a nonzero
> segment, identifying the wrong PCI device for error injection.
> 
> Use the PCI domain of the target root port to obtain the correct segment.
> With the host bridge lookup removed, cxl_dport_get_sbdf() can return the
> SBDF directly.
> 
> Reported-by: Pei Gao <pei.gao@intel.com>
> Fixes: 12fb28ea6b1c ("EINJ: Add CXL error type support")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

> 
> The ACPI EINJ SBDF field limits the PCI segment to 8 bits, while PCI
> segment numbers can be 16 bits. A segment greater than 0xff would be
> silently truncated, potentially targeting the wrong device.
> 
> I'm unsure how likely systems are to use segments above 0xff. Is this
> a practical concern? Would a range check to enforce the ACPI limit
> be warranted in a follow-up patch?

I don't think I've ever seen a segment of 0xff, so I think it's probably uncommon.

I think a range check would be a good addition since it's enforcing the ACPI spec and
it's relatively low effort, but that's just my opinion :).

Thanks,
Ben
> ---
>  drivers/acpi/apei/einj-cxl.c | 29 +++++++----------------------
>  1 file changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> index e70a416ec925..4c8f014378bc 100644
> --- a/drivers/acpi/apei/einj-cxl.c
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -47,25 +47,12 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>  }
>  EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, "CXL");
>  
> -static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
> +static u64 cxl_dport_get_sbdf(struct pci_dev *dport_dev)
>  {
> -	struct pci_bus *pbus;
> -	struct pci_host_bridge *bridge;
> -	u64 seg = 0, bus;
> +	u64 seg = pci_domain_nr(dport_dev->bus);
> +	u64 bus = dport_dev->bus->number;
>  
> -	pbus = dport_dev->bus;
> -	bridge = pci_find_host_bridge(pbus);
> -
> -	if (!bridge)
> -		return -ENODEV;
> -
> -	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> -		seg = bridge->domain_nr;
> -
> -	bus = pbus->number;
> -	*sbdf = (seg << 24) | (bus << 16) | (dport_dev->devfn << 8);
> -
> -	return 0;
> +	return (seg << 24) | (bus << 16) | (dport_dev->devfn << 8);
>  }
>  
>  int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> @@ -87,7 +74,7 @@ EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, "CXL");
>  
>  int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
>  {
> -	u64 param4 = 0;
> +	u64 sbdf;
>  	int rc;
>  
>  	/* Only CXL error types can be specified */
> @@ -98,11 +85,9 @@ int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_dport_get_sbdf(dport, &param4);
> -	if (rc)
> -		return rc;
> +	sbdf = cxl_dport_get_sbdf(dport);
>  
> -	return einj_error_inject(type, 0x4, 0, 0, 0, param4);
> +	return einj_error_inject(type, 0x4, 0, 0, 0, sbdf);
>  }
>  EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, "CXL");
>  
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

