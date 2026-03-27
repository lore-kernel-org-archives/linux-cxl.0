Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9C37F759;
	Fri, 27 Mar 2026 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640218; cv=fail; b=CPPr7XjqU55NscNZRuZ/6r1C6hGVoMCAYSCM4eZyngNTgwkzyR5FK4VJJA+2Jb86kZ95FFjn1y0OVv/mIq2TXOspMPdGT4l8lDebwM9PqemOsROE74xfhDYxbBv3A3Bna8+KLPNDnKC0obzzKhK5MRFMizlOfUqWi8tcN+9qefE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640218; c=relaxed/simple;
	bh=wMC3+GaZh8nFafBrLFVPsOLuubtq+52Zn8k90OE61Ag=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=fHQnBDtnP+7s0tEr3MFmPgSqTQ1ippDClyN9LiJI7+LiJAlMrd7Ksop3RkQB/AsS6/gSqK9E2DZ5kX4fWifAE+g2gsTe5BdHi15CBydcolzGNMNlLL4xqDBMnoATiDt1tfto17AFAuf8f7N8Uimd8+JozYc/eyExqQyY5vzwTAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UaLnKOKh; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UaLnKOKh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmLfCxpilF1d5iN9B66f5Ibywbu4nCsQW6fwwQGoKGA+bBWloyXebqN3HYM5YaverVUVtljLkMA//CUBCzhtaSiu0/DJbiArKzUugGHcLclqvYhG05oQuBUvEZOnClHGDJZPBUT9ROuO/oi5j6iN7dLblkOAaZshLPrlkVXdS/THHVxA80ZK2H4gvPadXGR271dfFgM5+WmJdTRYrZduE5kW3P6LvSZUldnaPlGK6i6OplV1Zzr5epaB1UNskobt3s6NIWihutdJumHIjZCW1gZ+uOxaJeQEqres5pIZ/HeDyI03uLyf0vENa02DH7gbgohwhs6fqT7rGLcDbNeGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHEe4OAGsCgMKFn0bG1DY9zF9/x5B7KLD3ZfiJ33N+w=;
 b=Y1zQHDfJrxcaj8mFLpF4rGsRUYapxpEaSZVG3ZZtgT/AcC/P+U0pij825F2KwD05atNDKhnvS1ULxR+JYNAS+PDUNQHW0wFK8JH8Im/BARIKm74Wgl5Rs91R5NMkikDmTZ/r98cULjE5n9qtqjeN53vRZgP3PqnrkU1qv7KKgWfoz+4ft66L0KoFAwdEhGfcqjKD/pwyyhrntz74iPfdpMeiZvbCT9LcNDyI5z2Y+6Hs8sY0wc+nJ4yXu7GccrKxXCFkWkvWmLk8xa3Xy8p+LNs5kkjXPDDgyJBmQZfy2htPuugLjgOb39ncETpXpH0Kp0ICKG5CCaeyzVvRSqYKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHEe4OAGsCgMKFn0bG1DY9zF9/x5B7KLD3ZfiJ33N+w=;
 b=UaLnKOKhOA04L3WaQO+mYhEfzq8fT49bkWjAvuvgofoJ7bzlkYwyw5pIfr48pI+/ckdt2cgafQDW+xQEY7IGKRHssRdsAzBhGNrLkpTRJJiaKL9zbi/9fNYtE0Cuufw00aeh9KTbODrMGnluLfXyWH9fmYWKWtGnRbgHJAbvdZQ=
Received: from SA9P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::30)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 19:36:46 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::b6) by SA9P223CA0025.outlook.office365.com
 (2603:10b6:806:26::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Fri,
 27 Mar 2026 19:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 19:36:43 +0000
Received: from [10.31.193.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 14:36:42 -0500
Message-ID: <3c39d7c2-0f30-4151-bdba-7c715fd7533a@amd.com>
Date: Fri, 27 Mar 2026 14:36:42 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v24 07/11] cxl: Add function for obtaining region range
To: <alejandro.lucero-palau@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-8-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260323113117.2352709-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce1cd20-f03b-415b-bd1a-08de8c382d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	K/Kx9sX/De7WiSB/jD6h0X32SdcpDCzQQpk+I8/E1uXxzfHVXzzYV19SFyRy0rkcIBLw+YU01HV2ZdZCu+uRTmHsMGab4ajcwIeaLjlH/72IUq94BuYGirSaRf6yzFfzGAbS8aPWs5Q6tVNWXRubvOX2k484I1ynZvjdchD21/PAbf64VuA8Im5QNllxjSi2/UbEdkzLE8QteV5FoiPR7IP1ktVm9KR0iBALL0UjEsjfchynqS0l+syNra0fAESvtJvzotCnRuHRud6JO0eNKDf4ll3iGr9E0KhymFNq/VwtoL8KMUTVEwt2J/IAm5lQROyBUqwPzgXGOlu0CLt9RT5DiykIS3x7OIeh9zQT+X3dR26jSc0Ekii8Lli04Lt+OxhoYa/aTAF6vqNoNQH4JFB+vMx+43R4N1HnEoRhRWP6iEkTqk923hjsfjhNg0TiLYHZZu3DvBEHF39YpaphDbhM1YXkyXtzulIPdsb2ajH2qmu1lRsZmd2hmW4oyoEhDtaoOew3O3oQVPzCRurFiG81AX78yDUfOC6OBFAKImxlBvnh5Bb1LocjBhwbu/bjQI2Q9WOunKF25f/pyU5fCK8OdRYCvStZh40dxnCUHN31UqGRdXltLcOyHS7DzzDry4Mfpe7H7VNt01VfyhGvYATnyYT9gFPT38HWaZV6h1Gu0+wzd7FB3p2phZBkuGaGxnJuF/dprWgehKLVH2Dnu/cVw/NMDOpnob3YuxZGi6533SxgaahHcjscwsR7U9eRJdT8j/nokyEOjtBIE39rQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6AE6x3Mhh8ou91rvCyGFubrS74NCY9FnQQKV6ABFQ5X8Zx3yGdK49fVgx7Cju0OK6h1xmEEb4lBJgSWEAmX83mcBh4lV0193UXVr2ULxQfPI+HQTi93UswL8+jwcuYqFkKKBn9Gtx8Y+7SCFcB/fpkMHY9NrFroMIDy41wgR6ccDONLuKer4/kr1g+jaMk53gfDlDuY2zPg0jDhD+uaAx0UpQ44NwHDGj4mrAoFT/sWq8hAHC9NAk02UIYqnMDbdn8Q5aCBKWDpJeWllaOOC+HP4R/4q0T67pUKczEPy8k3lhywWJ3K9AnqUZhjG6Uw4cLQWOBkz2rjS1RHz1Ywn1Uyu3khQ9riWfYvwGQAXOxcoxRm9OEdyWCacBVPL32e7GXOT6x3jdNxG81kFmfviboH+GRcm+0OiIa/ZZVrJuywCJEFtqBQpATG1WVIF4XF7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 19:36:43.8768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce1cd20-f03b-415b-bd1a-08de8c382d4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

On 3/23/2026 6:31 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Type2 drivers can create a CXL region but have not access to the
> related struct as it is defined as private by the kernel CXL core.
> Add a function for getting the cxl region range to be used for mapping
> such memory range by a Type2 driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
