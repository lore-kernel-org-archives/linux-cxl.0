Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B7516132A
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023631; cv=fail; b=E4NaoaFbsPt/r5bG+ofMVuMYtUAirvKHIxwaCzIbAaFGhYquG3Q51o29lNOLHA93A27+mDe4hyVlS8mBZ+ns66jVRJBlmHB7/mwr8zpckkWDgyfsmWOrC15YojruDuGlPuOhZTLo4cx5pKE/zHK1GSoVuUwv7shpVeyEzML1vsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023631; c=relaxed/simple;
	bh=oW/TgEAnMLbTD0i4IBm2PY0qe+0G2anx4yDDZnVre60=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=qUA5YD6dLAlwBnXWpI0Z1vj+3IpEQ7aZWJt9HBB4EnJNFYKVve3PO1X+CSjLzB3f1kpR79scMlCvxhEUqAbhot6lzPxGHzSeSgWabLxF510F7r9OnE2KhnENArBHYrdk3gRshctbpxuLsR0VJKPKf2L1DRZim+rHx99Ko2be7/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jHcw+YXs; arc=fail smtp.client-ip=52.101.57.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jHcw+YXs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj/lYiuVRoq9sdgyqoslTKRHog5EL+MKc+AvPL2mXvFFQlooh9KlopnZ9C3F9yT6lxluje+3rOgieAd41hpwTrHF8PEqXpFXumORAb0CPiZViumNdcSrzaoI0Fe08vJQ3Fw6aj5sRnh+0pidYru+BTDZZtyp/W5jr6XBUeYPHPvSe4gkjCjprpu/z9rBkBKDTJV0asuO9i/Gzgf57/mbAp/Xkarke5HpUXMTQJf2Hh2pnJw/SDbwEtiA5DSF+xkEmV17Plup/ro/Yj6SqufsxmtXQmaJuonbGSvwd9JD+D+04PWTPLbqmYJBvz6spESCR/kuQ/oXyjrTJfi3gtRo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hzl9vl7pHgDnnsAzUOIrlmwwYp1w+qkZmxIe9A3BBE=;
 b=pPhVdfhwlY4+JiS+8ViOs+uboWusd49fx/zo0DcGoPngWgJodLmchyAtKgdYHOY5zWILwYZGO31ibqZiHXyJmSB9hU5v/VMCVXDqm6h3QoZXRQmZXmUF66Et57+WPaspfLwA0Egt+Ipyxde57tx+svEA1zUDUjat5OGMnBohTctdqB6JV5wNWHiK86gApiaDQ1fuk8GARDS+w5AmIEUJbZyQAe7AgNDnxufzLFwLk3n5pBtajhE0I1eiCsQOwjoN/kfkQ4cUCSY0ITL1QON6WG1S8okcdXHLHtt9wSDZCuE9//Kf0UwLJ8r80dFDFxjQDJ0sw1sR5yDF1F9Qb1+1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hzl9vl7pHgDnnsAzUOIrlmwwYp1w+qkZmxIe9A3BBE=;
 b=jHcw+YXsE+GUD+Xf+9EIhyypSYW/zEF8HOEXFB4HfY3k6Pu6rJ7nKuS9kVjNT1VXwVHlFFZFRVswCTzFxl2g+WOoFq4cv9+atHwlIR/pNMh2dkVvG9xGRmHkX817sEBpX4uzuOC/30+7TRTddqdA+Qwa/2atfZ1BbYO4GHyD4lE=
Received: from CH2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:610:58::18)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 16:20:25 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::ef) by CH2PR20CA0008.outlook.office365.com
 (2603:10b6:610:58::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend
 Transport; Fri, 20 Mar 2026 16:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 16:20:23 +0000
Received: from [10.31.194.50] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 11:20:22 -0500
Message-ID: <a8843959-a000-4dd8-8560-699346772dd9@amd.com>
Date: Fri, 20 Mar 2026 11:20:21 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/6] cxl: Wire BI setup and dealloc into device lifecycle
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-5-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260315202741.3264295-5-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: a085f563-c487-4946-3668-08de869c96c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	/tr1B8bKccTKFT9hUZcOg3O42fSqUWS6LgUa/zhl06BjEvA2x438XUwsfRJjj8krks/3S/Q57gr656UB6/pOYoAsh7IpABHVkydgTWRim+aFpmMvOhu0bpba2YwTMaxm7EY9ytD5Cg2lB6BB4IYfhD6AXdKepkWXfuqgCKVP5eDXvhxG1ed9oQpxQlnMAztr9/gnQC7uWXGR6cM3CSDPfdyFFVoeLlgCKPMDNYCTo3s492x2XaLZ9jKxqkm3qySqGy4bA72i5Jarj24vvEfUlUHqFuqsKrSgoxdtlYmfkFGQ8PlNmUPiulTgutcyQq80QQWgJyaUR/3O7hFq7mdie9xihoVD3JquCWM8NL/Ls5B2vOq1PQW998Ev1Qu4DQltpur7DmF+0fARv41Rc0QgtSZ1Jp2ywhj/C2W1Zr//qqhN7HLLfdfSl2VNNWPQfoYQ4G50RoUInpwiOAMNnHzGV3Cm9+vm8NMGSNq4YqvuUP6NFe++s1wRlZaWd2r52r9I2WOnboyhiYpPf8XGrWZMQq0WtOnxumgCAuyZ7vi//qVT60VhYXZ0q8KrhF+DabAlcJ8C2riF+DUNZyQrrSd5Qaxe1ljCDjGJCUeSlcwXtN+wx7sv6LshtjLN12pn0W9UMKmYPFWV1nBJzagZ/IysIMP1hc+430LepBi8NWcV+RzCnhpe74ZS88zAeaXXOayP4EHYpaGYUwp86cS4OMwBYsreLZ7Kjr8cBk+baWC5aP8+zYzq++o72ft/VDEmJZW71dtugJ1IMOPfw0zRj4q+lQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X4wNzRCBqNQYplUb6KT6pzzNId6wzAwHpo8ZVQjx/LQK4aNW7fE8d2K3KwhrIZ7O3nnCt2EkpO/KVLT+eIA4KQ49eJ+wD3eBQ0jxkAfhNsc/a88ze0G417RN1ZCJmCWPrPuneq9ipwJ4enQ9UhpQ2qJ5xUGHb0Wt0sK3JBN1WgAAlVTKao9iPgdUNQe+8T4TAd4kzGL3egWHIrZLkUwDapuaIFdumZ3+D+KfcDK/8cP3OhOqlSX9FctV2vcKkp+lIuI1BAC6uXxWvvkVxlzAW3BSnZSCNy+5BjTJSOm9V+vuYcTCEKypyrDxsFwm1JwqFV7ZRpSDUPCN6jCp+uQOYxHdTz2s5KBvqOJlO4mfkamAKDvfrJgr1DmxPby0XYpWKdxObJ6kSNEAWitE5fuL4xouzLweGj4P/ZAO7QwwTltDRuJFwvWgpILqSlkv3GHF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:20:23.5371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a085f563-c487-4946-3668-08de869c96c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

On 3/15/2026 3:27 PM, Davidlohr Bueso wrote:
> Setup BI flows during cxl_mem_probe() after endpoint enumeration and
> EDAC registration, and tear down BI during endpoint detach.
> 
> BI setup failure is non-fatal - the device continues to operate
> in HDM-H mode without back-invalidate support.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/mem.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fcffe24dcb42..3adee41885c5 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -65,6 +65,11 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_debugfs_poison_clear, "%llx\n");
>  
> +static void devm_cxl_bi_dealloc(void *data)
> +{
> +	cxl_bi_dealloc(data);
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -150,6 +155,21 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
>  
> +	rc = cxl_bi_setup(cxlds);
> +	if (rc)
> +		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
> +
> +	/*
> +	 * Register BI dealloc after setup so devm ordering ensures
> +	 * it runs before the endpoint is removed by delete_endpoint().
> +	 */
> +	if (cxlds->bi) {
> +		rc = devm_add_action_or_reset(dev, devm_cxl_bi_dealloc,
> +					      cxlds);
> +		if (rc)
> +			return rc;

Can I ask why this isn't at the end of cxl_bi_setup()? It would alleviate ordering
concerns and make more sense imo. The only reason I can see is that you're worried
deallocation would fail and don't want the device to be usable in a half-on/half-off
state. I'm not sure that's a concern since it looks like disabling BI on the endpoint
can't fail, at which point the hardware above would fall back to HDM-H requests?

> +	}
> +
>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device

