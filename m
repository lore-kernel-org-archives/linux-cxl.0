Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730922;
	b=3Oaxqp+pNR1XI2kkXH7NpVMdm+wcioEjiVa/+SpOODo1EIUWuHy+oVzze2NNgGoF8X1+
	 WL27tfvMj3FLeTYAy6mvREG3z7VzDIIAIEdfWNm2Ag5tYua0DTatn0ZZMXXATr/UnV1cI
	 FyLQmvPer2XIeRvwa4zQjPLOU4syPa+a7QJkxlrgN6ceM3LsVGo27wtKkiOAEPjEA3G5r
	 4wJGetEdYQEAwlphxv1Hd+f6qhlxS5vP/2PtPpiVa0/1AU4AAffEnNA3nk8hJM33jdJji
	 e3rZzsPshF2j3nlCD7iT3CTVdztkfoJuVIkCB1kALnsufKs35GeoWOdDqQawrVjUOgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730922;
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
	bh=YmhwDzVbTCRJTHtmmvk7vxMYhnYJ21J9pVm03ELVEkc=;
	b=uRESQ1+dtMMyQuT62UyUJnQHYx7Ir0eYGBDil1ngeL6fINj1GYfeFDecppszptisJ8JW
	 q/0QsYzhcymAzXlLRSxFQ19poo5sHV8PCbaJGCaVISJY118zJEKP4PCFxh/pAOCj3hGnJ
	 vo6x75thdTMG8hOdBWyEk+HE7AM7/j6BOn6ZjaL/J707XA0ESIOd6Is/ZMjgS2PLdn0rG
	 ZxIuO7HgYPxmvqrXkdq7GKjf9x9YAp7cCZoyusaO/8t1h8jkXkpZQkrvATequYtNVwENg
	 6pYbreAwciLg8TPLUnpjDwI22oqANXbDgnsgM5iIzxG+4FUOaujN2TOi6no5ote8AkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EIOsAmKI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.39
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7F606A328;
	Tue,  3 Nov 2026 18:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C7F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EIOsAmKI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDiNKAmiP3ea62wKw1Zmh4r7+AKi0yrsbfbHRrFyp6XwffHWHEHQjlA1LH6M2sBtZ+OIV0+tOTKU7v1ime6I/J5YX1UQzg1rTs+ib1NLHCkRPItXrQJhpPqa9oUn0L1VlW4n3AuZ/ILk9kALhkKBTw1EQpQ+f53nxocyYx52x00tH8urtpihnyyBUgoRnG4ad4LTAtPJrNL+XbyqdpOHaag1ZSFH/7oQNjAYpKUjoUAjf1xx/od03174iFi+pFW/WyEIs+1DKSfpV/0sLk70KB4fgWk8cMGTg2VbpBVyiNzcaVCHNG42eHmejlZXKiyRro6PMu+POWFFK5WxKy80GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmhwDzVbTCRJTHtmmvk7vxMYhnYJ21J9pVm03ELVEkc=;
 b=MJKY87RA74AXS7Me6oB0cet//HAk+cqSHafMCY6q/zukxW1zN/u9hlg2sgi3smjpfiNi2wfs4Nq3EBvTcqlZFd7szZwpAuikSGlzUqYyCkuS6K1ZT+EClM7IuZJhXVO3sOLkK8vdsTyfu0+bZ98OpxWdU+wRngFjqH/MWCOX78xvffDSlARohkgSFsAsy9ugKnUUquN3lOjQ+snGsX617US9MKQM0F5U1sWvOkPeukvAGzkzpdVkrfOgwcp+3FnFKDWSF6NDzkXZKQakF70ebURoWD8IaYcl6BIKdQMx7HibbS5qL+v9DGlfn5o624cQNZ/HkWMeui3GY5OcNMlKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmhwDzVbTCRJTHtmmvk7vxMYhnYJ21J9pVm03ELVEkc=;
 b=EIOsAmKIW8DJPiRRDfBU24l6FMIEA7BEWE+VfzUIqWyVXlBPdSqUrRUOIFw5Z8ECnZA08z8LBB2MJ1KYswTASrTDwv/wwg11xFv9vtIFZBwuEOFT+I0oVKZqGyKhg+DmIS7HFzMKCgAwJkHEUwOZKiwHrECKux32+vfzDPLSQ+Y=
Received: from DS7P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::12) by
 IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:35:17 +0000
Received: from DS4PEPF000001C0.namprd21.prod.outlook.com
 (2603:10b6:8:25e:cafe::1f) by DS7P221CA0030.outlook.office365.com
 (2603:10b6:8:25e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:35:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C0.mail.protection.outlook.com (10.167.23.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Tue, 3 Nov 2026 18:35:16 +0000
Received: from [10.236.179.122] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 12:35:15 -0600
Message-ID: <aaa772ba-554a-4bef-8910-e271580c2a5b@amd.com>
Date: Tue, 3 Nov 2026 12:35:09 -0600
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
Subject: Re: [PATCH v2] cxl/port: Fix endpoint RAS error unmasking
To: Richard Cheng <icheng@nvidia.com>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>
CC: <iweiny@kernel.org>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kaihengf@nvidia.com>, <kobak@nvidia.com>,
	<newtonl@nvidia.com>, <kristinc@nvidia.com>
References: <20261103063409.18275-1-icheng@nvidia.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261103063409.18275-1-icheng@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C0:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a8cf9f-a21c-4360-3df3-08df39d934e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|23010399003|10067099003|22082099003|18002099003|56012099006|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	xqroXe88M8bRcVU3cgEtl+xnlGGvl78w/aIGK1TPIE3g74POsRwzCaBbLn83pfrZK0zZ0DxWxvmPAYaXDCLk0VSSgq1y9q9sf88Wy3xT+aY7PrZmx5nBaO/MMJcFZzjmUMQNReoD1erY6EIJxLPrZvyUSQ8u71t/V0miiG044EGfapQ6/yobe91u2qmwbH5z5DieB15+xiLzEr5OCfNZtprTLsQQ/6k9y4wOgOvYj8s5kLwVPcJjX4dTvV9vLY8kNSquKKqHSExgUUwc0lxGGeiVGAbKUa4Js3vrW8xuuPoMBThHCC4tSteFaHnCajUekAWqtUNeXqq2ZpkBCgj72mFnwP9Hsi16t0RTe1p9K3xzSrmJUTvj5PLjfVZs28uZVcBDXrxMQ4Bqtqbewg45QSEhqpWIGpSWN095rz+4o4BdDGHA+4otVDnH5pZM02bVpV5blBRvYBkuIJiBt/DRt/wkVVUN+WP0NPVvc8WB50ZM/BnKhspFXiMNAZTOB0Kf9LFHgQ5Pj6IFfW7chfj//GWWdALKdgF3BnsxVy2r0mHpPqsCp511gbbFpGZ7DLXcDyIzqP7LeU6cxlnYJkrewRd9BgXKzaLDxzCDTfjlWX60IJsnxJ0jdjkfvKFoeRWlVtpm+fqJthWJj0TduPPwiN9eCl9ebrNEl1dDWjWzdlCfzA2UNKoTchkitGe4eAxI1EaVhyxfn1Srv1BjdBuuzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dwloea1P4qEvntk/zKAKqRNymzikZvhm9+Qo1k4xQQ02ym3Ppd4Ci1YWeMwanIcCEBTHgKhhwF+s+LGk/KsNuZqM4v4q82Uai3JxzOH7MlrZVrM6occfegQI5U10k+AqD3wLo7diqRGr41PvtfiF6eR/kWOKaRMfXqK+iTWzET//kk8oyj2wvfs268X+Gcc71wL4MqKln6tY86tTWoRyvgyOCK4tcKBGHVzK/6ffTfXCBlebgSvzaNnWlQ9Tr6LhgjOl76HS6pdeYG1MCm2gjBLYPPPXbhLZwNPdOKj2mQOsldHSfLmEsaL8nscsAxVQ4ui7PAWu8tGzge5bb46JgJmYOQpc+bOUdLP2fWnPQL8hn5cqIVoRpLpaRoraSBXcAmR0dxXriGKHsfTr/dPBdg1SlbF4PcHSgFUGFmdcsXmPIXjDiJ5XBHhXPYn4W0Fz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:35:16.7478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a8cf9f-a21c-4360-3df3-08df39d934e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS4PEPF000001C0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748

On 11/3/2026 12:34 AM, Richard Cheng wrote:
> Moving endpoint RAS handling from cxl_pci to cxl_port left
> cxl_ras_unmask() checking whether port->uport_dev is a PCI device.
> Endpoint ports always use a cxl_memdev as uport_dev, so this check
> returns early and leaves the CXL RAS error masks unchanged.
> 
> Resolve the PCI device directly through the memdev's parent. Rename
> helper to cxl_endpoint_ras_unmask() and its param to endpoint to make
> its endpoint-only scope explicit.
> 
> Fixes: dab7162d0ae7 ("cxl/port: Move endpoint component register management to cxl_port")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---

...

> -static int cxl_ras_unmask(struct cxl_port *port)
> +static int cxl_endpoint_ras_unmask(struct cxl_port *endpoint)
>  {
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct device *parent = cxlmd->dev.parent;

Two small nits:

1. Maybe just use endpoint->uport_dev.parent directly and drop the cxlmd part? It's less
readable, but it's future proofing for when/if CXL.cache devices come along.

2. I don't think you need to rename the port parameter if you change the name to endpoint. It's
self-explanatory at that point and cuts down on the diff.

Both are really up to you on whether you think they're worthwhile, and the change makes sense as-is,
so regardless of whether you implement the above:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks,
Ben
