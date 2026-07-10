Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E7374A1C;
	Fri, 10 Jul 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704456; cv=fail; b=he6YVjifTtpAn9xSK6RK/AoPZPMXtNUIbye+YJc6UzmqA0UIPClXAQmWJVSvxcaBKXEUqx/znCAss/olLn5+Fg+Q/fkL2Z1hCbybb3D79XUWEsU7+Mwi13YOqYZIMeSmzHRCsGb4xyMC+eBMYp9UIMA/r/TpX7VZjfcnDyCt4eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704456; c=relaxed/simple;
	bh=MTGqUl3cbTqqJGvResMinH/rK1RRc2CboL0U2ca/xm8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=LrhOwjELftyxk1gd5GRl2u3QeuCS+UBRBRmVmmRBv69oJ0mGbyDmpJgwO5IHqJ7afoHsl4zo5AaexzFp0W/9oiWrcWH/AtpEdmaYZty6Oc8LJ1zIvgmdb3RXtX0mTmfft1JmP7ismeQvimk5/6bvWIUrTCFEbDvn753apTUB3kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qPrX+KDC; arc=fail smtp.client-ip=40.107.200.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qPrX+KDC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLTtP5IBEO3vFUdrNjxP6RuAJswp5Zy1dZqXaZ4EXFGIw1IYLENmXdkWRL9K6dyj99ojPRi8jKmFRu1i/SA9tr0ZGD23CGsxuYI3CxWQKJme6i9gBkzX49gJkDB7VZ8xZHSktROpx9gnS+eqqdz9tQIGPFOjlQ0bdQ2u75yltaak47UV8seelmc+8tavjTp/il/DUPsceVO3CLetZBbpuc8OLlu/Q+2WhHYeQK4jaXsEIMr6Ni/n8z5XPCKK1TS4QLjwDhJw5g+eWifNhtMJG/cVTDfIvlM+DvnAF3HQ94f5b2vtKxKyCA5NI032kqFLj3XSQuXPyj0wXnvHM3XRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af6Jy58wUwHAnD8tinzq3QFc/1rOh0wMP4R/k+rLo14=;
 b=a5oEX46n7awweoSnSWx5OfCYXVl0tzyDzYyz0/QLqYxmCpUayUPUB16yI+vmtNGcUoHdcR06soRb9jq/AJxsyN4rMY4aVleN+jCATFBM0i1L/3Ttgv12myo8YD3Y0IVI0XA9uD6p0Sy/GCkq0KbccVQfwI/E3g0qyFt3M3XFJQRHrjTmKvrXD9KmMJOZIbfUhXYUKPnejN5hJvRsGn0+UtgbOSZRHEv3N0ShRsNqyNrT/YugvYfNwfHKXyVXc6YU961KlnJufJgSfLP7nLPcJiqQdLib5NCPlhbqK4woVpMlj15l2UXGSIOnyHv+yeKdwsyo8eH9dbbRVr9mBtjZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af6Jy58wUwHAnD8tinzq3QFc/1rOh0wMP4R/k+rLo14=;
 b=qPrX+KDC9MrqJbzItTbALK8U5yUKAUR6vqi9cYo2vOIV9nYfOTDewax3XuYgpgbJnape3VteyGHpnJxPk4c8mhGtGxF5QJExg2ASEYgwg4cyc7XJg10uZL54tITRNz1U6tF08jVGzlCuQvwkgRBee6LA967HecP+fC9+aP0bC8A=
Received: from MW4PR03CA0267.namprd03.prod.outlook.com (2603:10b6:303:b4::32)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 17:27:27 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::6a) by MW4PR03CA0267.outlook.office365.com
 (2603:10b6:303:b4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Fri,
 10 Jul 2026 17:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 17:27:27 +0000
Received: from [10.236.181.36] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 12:27:25 -0500
Message-ID: <14768103-dd71-4951-ad24-03c9a0f50cf9@amd.com>
Date: Fri, 10 Jul 2026 12:27:24 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/4] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
To: Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>
References: <20260709162807.1957783-1-dave.jiang@intel.com>
 <20260709162807.1957783-4-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260709162807.1957783-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c03db8c-998c-49ad-f85c-08dedea88367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|4143699003|22082099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	uXDEQild4mCtZxVFseFIZxrJ7pxtRmyZb49f4EDX6SRT97KfsijmdNMS/Tb/U7y0XG5zrpj7hxVsm0Wb5539+5fAxi/4NqWMr6Q4ayPr5tweua4yJN+2dmWruMXxOYEt1hHVjNDZm439sYUv6usmtrV3VoWMHqeWEdz3Ndhxk/UcSMQY6x2iuUpxNEIWv+cp04C078ArY3tc/9+qP2V8B0ul8rrQeSxKbirEzUqRClQ95YP59RWE//d78Lbdebkx6pEZtbW5hp3WQiyewtsu98u1GqMlSUVFBHYFUcC0RZI4zn6rg/X4Au4qX0xY2dDrKF+blzM+scivW+jjn+dGnLc53Xq3iz/70o/Kf3AhsncVeuvR9+XuExaM9UK7xSkeHeXoS2Id4yUz0cbysQs8VSJfGEIrElCmNOx3YFwGaYiX8kXZhGaszVHQDDd+fS8TbJeLztWS0Vd1l7/fUHYYEH0N1Qqt0SZmtWGiibZvOMCMDwcboRkpMS3F12cl2+DAiucNlF+W0/EaOhjgeb9FOCAyVVSAMHol4D22MbdnWcg7WLPHkk4WWTXQieiXZQEqxdhSdsipwq7KetKiyTAcAw9AVeHL0nJYGwaUZd0B4kgRlyfZmBZKKCMNMhA996hHAAs40XD/FoXnd9SGjS6u8BJc+WCl/lQERSSLXcqaARGoOpnz6gQa0v2FC2KP41iy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(4143699003)(22082099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3LoJtSpweEtttTfo/C7BfOdkl6r15uycWZoxe8aKtwBvy3UaPLoXepNZQAnEPUB95b5GrWDVQmFYFNq+mPciNzZXUJl+RJew5W5om4ujx1ZUrTjzC4GWP6x7/+7Nc8jAys3YGICk17Tp+jgjUOolwDyJheFmu1wSFU/J+yT7ljfZFA1EAvc9roJMua4T+tirNymqt0VBfJ0wORhLXyn76+R9A9zQGKN4RYezKgLSRhSGhDAG53DpFZfWcvdYbvXzPO0PPcoMUKBRP/yUhPKrsVWgsFtFBjBDKeoEK0f9+cjp0afez0gPx549yXT3YyU7u5M6Vk+hSgzGP6L29ELZHWnUMlQv9FIDuSLmvfXmH0J16aO/TKUf9jb6+eQ7vGHKtVjX+VeGnMNZxddDSSgjKeiQCD9X4dkEMkT/IrzDJfZhWbht4cJJX8f0k9Tqabag
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 17:27:27.2413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c03db8c-998c-49ad-f85c-08dedea88367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

On 7/9/2026 11:28 AM, Dave Jiang wrote:
> "#ifdef ACPI_APEI_PCIEAER" is incorrect. It should be
> "#ifdef CONFIG_ACPI_APEI_PCIEAE". Currently the section wrapped will
> always evalutes to the stub because of this. Use the correct CONFIG_
> prefixed symbol so the code is actually built.
> 
> Fixes: 95350effc3ad ("ACPI: extlog: Trace CPER CXL Protocol Error Section")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc..60c2b90adf0a 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
>  static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  			      int severity)
>  {
> -#ifdef ACPI_APEI_PCIEAER
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct aer_capability_regs *aer;
>  	struct pci_dev *pdev;
>  	unsigned int devfn;
> @@ -167,7 +167,7 @@ static void
>  extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  				int severity)
>  {
> -#ifdef ACPI_APEI_PCIEAER
> +#ifdef CONFIG_ACPI_APEI_PCIEAER

Seems like Sashiko is complaining about bugs that it already highlighted in patch 2/4 (I think?). But it did point
out a linker error here that needs to be fixed. Should be able to fix it by adding CONFIG_CXL_BUS to the #ifdef
or a new nested #ifdef CONFIG_CXL_BUS. Either works for me, so with that applied:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

>  	struct cxl_cper_prot_err_work_data wd;
>  
>  	if (cxl_cper_sec_prot_err_valid(prot_err))

