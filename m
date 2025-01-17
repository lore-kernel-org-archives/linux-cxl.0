Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A0113C9D4;
	Fri, 17 Jan 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149508; cv=fail; b=sIDD/GlpccWkF8GMPGQgkMAokdLTKSvl4ZMq1ZVq6L2SGd9iKuE+3SFfpEOcsN8j26LCI65IGWl4jfHtlA32jwfXP3vt/XOhY562u/IGqrl3Ty6f1d61vcCLKDQNP/y8dUIG9+3RwsZa6oEC2NWm7PUPiWGItzjU6DNt6JhqQJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149508; c=relaxed/simple;
	bh=0SW/BgNu3zZuejjD768dDGP4qnxPtcvpaduuTHor/CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u4DfOH9avwK8+pFk84E3MX0QO/H1hHLsSV5imfb6AqDjQ99m/N5on32gx6jWVnxqoUcWDdbC1w0VmGRO7LZI9bP8S5LhvQUE/3N+h9d8a/Ap36ntmp32lC2gpbyDwZYubqP9uj4MHtZAXiZKRfQtAmjgl/g88OSTMSWIyaCcdXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fIeLaotK; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fIeLaotK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAyHIWB/fbIJcxBMg1wpyJhswwn/OAUwKWK5Bpi0VvwP6D5UtXMOy1usU7VfAXYsnfMrp22E2uF7lVMbXzcnsMM/8InuRzFGlrk1QyELKoNG/Zai6JrbYrtTClSdtxCuNx6fXem1IgwcOE3o3gWxT60LnObqIS44dIL6LToikwznMfq+hVkJCKe1vHcdH1hc25n568CnoZXWWEPT6AEtvcRVZEuWZWhWwRvFIUHq1E5rToNkQOCZSDNx/wZVESoEnmlA5WzVkHSVoYsGwljJxNsEnXZLHKjLB3f5pXipucskiHtcCnknVu6AwVkmU1NlzFSeY6iL9Pqud7Lk69Y9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5w8lkskIEr/Z9gGLYIg/kjFMUrmaQKz5VmfR/AOWXM=;
 b=WYY6eq8GMr6Za6TQJ8DD/hsP6VP6lKmN0w2TkqDXDYvD7hGoSui/xz75WGQ6Wm6auifZr4HhOXiMtc90/1VyBAXqGKVlcFTr9UkQg/oApaapr5ovhJ4A7F1+93fOZ6yoMt8UEG6v5iPpca/brH7glFFKMvJrmb02ygAqNBPrJJXVqDnEVzmGeaU8pa7SaN/6Zhajt7/xbsiwNuIDObNadEXaHz/SD+YGthAJ+9FBfR6+RGj05S+DtzM4DFuwp+W0w45ji4kW0GAGwdblmobOyfr/GYRBnPKrJP43fs7ghNwj0j8UFI2ecl51dsPScG7r8gJ5gWsna7nFehoa5Yyacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5w8lkskIEr/Z9gGLYIg/kjFMUrmaQKz5VmfR/AOWXM=;
 b=fIeLaotKZavpcCU2YgydaCsiU0boN05DKiM2NUyb0V4XNT9ACHrctVVuq9oUJ3G8sv0t8mfD3n2Nu2t+q6q77/eKgH2O2w6/mMVtC7JvBUitH6FUOgicNCYYFmqiLM5QEoAKqT1iEq9z1cUEElicONuhzHMXRHFX6L3kI1IFYC0=
Received: from BN8PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:94::42)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 21:31:44 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::ca) by BN8PR03CA0029.outlook.office365.com
 (2603:10b6:408:94::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.17 via Frontend Transport; Fri,
 17 Jan 2025 21:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 17 Jan 2025 21:31:44 +0000
Received: from [10.236.177.252] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 15:31:41 -0600
Message-ID: <6efb6772-dbab-4412-8efb-95a698ec1ce5@amd.com>
Date: Fri, 17 Jan 2025 15:31:40 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/29] cxl: Modify address translation callback for
 generic use
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-13-rrichter@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20250107141015.3367194-13-rrichter@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: ca869e70-244b-49e7-312a-08dd373e56ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTB3Y0ZhaVFHdHRZbDJRbDlCdHlka3Z3VExFLzRFdjRodmJoSEd6ZGFvSVVV?=
 =?utf-8?B?dFo3eVJIU3h3aHhsd3ZKZ0xLV1kwZTZWazI4ekFGMTNUNGpVZmROQUdJMFVX?=
 =?utf-8?B?WjQ5QUE4N2YzV2dibU5nM0wrd2xMMXBqNmI5WTQ3b09MY2Zxa0NjOXRDai9y?=
 =?utf-8?B?Q3g3cktJenRCaHYzelhyemVFK290RGo1WEtyZENzQ3FoMEQvanpJcGpRekQ0?=
 =?utf-8?B?MkFMd0xIaTBZWGNOMFZKaDR4cU9KbVpUWXR5bXhIbXdOazhQMUFia1BpeGJI?=
 =?utf-8?B?a1FZWEt1dlhLVm9MRFpTU2hLdzkyUTBYRS81YW9ScjRFemlvWW5oWmZKOFZ4?=
 =?utf-8?B?a0k5V1pUUkZERXprK0dHc3Npd3J4U05lOElBVEF0UklpS2dmYi85ZVBrM1hQ?=
 =?utf-8?B?ZVkzS0swMnVpRHdxNUJuRDVuTmFiOG5xRzBKUVhmSXQybVJFQkVjTy8zTWtB?=
 =?utf-8?B?cXBTeUJicTUyUnpsQS8wcFd5RXZtY2U5V2hwOXRzUDRkemlrMXJ5amV5cjBE?=
 =?utf-8?B?RjNvMkFmcjJOMkpQY05qbGdXZXAramNRc0NHcGRTNCtOVFdSNHZpZ1pVb2Ny?=
 =?utf-8?B?YW8zM1dEWUdjdGJzUUVPaGM0T090OHJxZUtnTDAxMVRkN0tNdFB0VTNKZktk?=
 =?utf-8?B?YjNaWmlDRUlZV3ROTVhEcUFobkFBT0g4alcraTBqdy85YmxqNS8rUmd6czJX?=
 =?utf-8?B?SjdFRFFKeUdyQkhoa1hVLzM5WU0xbnN2V09MWFJUaU9XVmlaOUVyWFJtWHNa?=
 =?utf-8?B?M1Y3ZXp2amtJTGplWFZOTTJjdlZ0Q0pJaGZJb0pKOGtSWjZjMmUxS01XY0o2?=
 =?utf-8?B?ampGeko3REcvRW1ablNzazQwdlFiN082dzFCYXRtSDNrWHN6WUZNOE91Szdu?=
 =?utf-8?B?clFqZDVBdWNadmp5b25BdU1CN2YwNSs0eDlsMU0yZ2sxQmtZRXE3L2dkQUhp?=
 =?utf-8?B?QXR1eHlxSFFZY1gvRjVhVzFpQUpHQjc1N0RxSmt5RlVKdXV0MmhGV0lLNSto?=
 =?utf-8?B?elBCSzBsODRkWGFpbFFVS3NPb1hVR1B0SGZNaWZ2L3Rxak1UZnhHTVJBRy9J?=
 =?utf-8?B?eFBvSFV6NnNia1d5cEdwNkEvMWVEK3VxS2g4a1BUbStrUnp6cHR4RGJRSGpR?=
 =?utf-8?B?QkRoaFNVKzhuRVdxTWhqRG5VUDFKRGJnVHY4OVk5L2ZLQjlBcE11UEVabFVs?=
 =?utf-8?B?bXRqQklBeFBMSTNkc0FRK05qaE5mYmt4QUMvRU1NSVRyQ3p1citKamJsZzVX?=
 =?utf-8?B?SVhFN1hFMU5keWtsZlNITDFPeURKbGJYVUNEVDgyUzNZVTVNK0dRVjBqeWRW?=
 =?utf-8?B?SGVGT2VDVXZQYVNhWkdjaXl4Q0Q3WTlyNFd4N242YnpPbk1zTTVTa0RST0Np?=
 =?utf-8?B?RkYwT2VPWVAzQyt6OWxEbzhPY1Vqc2xQeVJwMXNYQkJaNHh0YXp2Q3JXaVdP?=
 =?utf-8?B?NlJhNzBQSG02NjN4RHBhMHBaaS9CWlplKzdvMng4TkJDS2pJOWZxN2RsL1E2?=
 =?utf-8?B?ODg2eHNUbUhJWEQxbWRWZGFXL2tjdTlyWHB4VlgxUlJjZzNZRW04OGhFdUJh?=
 =?utf-8?B?NkxMT0xyVjNjQUhCN0xLRGtZWTA5UXg3bjdNcUZ1RkNoS1dCVkRaWlFGU1Bo?=
 =?utf-8?B?VDZVRThMMGdjcFhXV1h5WjZMVDFDTGY1dTVYOTVpSWRkRkhteDdjVkFDM1d5?=
 =?utf-8?B?Y3NVSTQzYkM5MFQrRlVvWmpDNzk3OUtUV3A1SmNQUGxYU1hTak1WU0N0ZXdi?=
 =?utf-8?B?SXdwdjBHU3MxY1NlVk9aaHB6Z0dXeWYzY2ZLNm9sUzdkWkdaVUZaaXFCU0xL?=
 =?utf-8?B?Z0dtcFZJbEpWWC9DVHF5djJxVXZwdktONm5DV1JRdjUrS2VMNyt2bTN2Yy9B?=
 =?utf-8?B?bkMzenRZT29KVXlqQm1sNmhEY2NDVWhQTlFMdDFWY2xqK3RoSDRubWo1M3VL?=
 =?utf-8?B?RkxuNE1TamlVYWI5NVZiZ0I3UEw5U2JsVi9yU1FWTVlacGIxbUMxWCs5TUY3?=
 =?utf-8?Q?cUVQwB3HaaKDueeAW6S1CwwA3TXDVY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 21:31:44.1204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca869e70-244b-49e7-312a-08dd373e56ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396

On 1/7/25 8:09 AM, Robert Richter wrote:
> The root decoder address translation callback could be reused for
> other decoders too. For generic use of the callback, change the
> function interface to use a decoder argument instead of the root
> decoder.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c        | 4 ++--
>  drivers/cxl/core/region.c | 2 +-
>  drivers/cxl/cxl.h         | 5 ++---
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..b42cffd6751f 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -22,9 +22,9 @@ static const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>  
> -
> -static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> +static u64 cxl_xor_hpa_to_spa(struct cxl_decoder *cxld, u64 hpa)
>  {
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(&cxld->dev);

I think this needs to use cxl_find_root_decoder() instead of to_cxl_root_decoder() since the
cxld is no longer guaranteed to be a root decoder (as per commit message).
 
>  	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
>  	int hbiw = cxlrd->cxlsd.nr_targets;
>  	u64 val;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6fcf56806606..9443507ed4e1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2925,7 +2925,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  
>  	/* Root decoder translation overrides typical modulo decode */
>  	if (cxlrd->hpa_to_spa)
> -		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
> +		hpa = cxlrd->hpa_to_spa(&cxlrd->cxlsd.cxld, hpa);
>  
>  	if (hpa < p->res->start || hpa > p->res->end) {
>  		dev_dbg(&cxlr->dev,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b3989dc58ed1..be7685fe8a23 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -443,8 +443,7 @@ struct cxl_switch_decoder {
>  	struct cxl_dport *target[];
>  };
>  
> -struct cxl_root_decoder;
> -typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
> +typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
>  
>  /**
>   * struct cxl_root_decoder - Static platform CXL address decoder
> @@ -459,7 +458,7 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
>  struct cxl_root_decoder {
>  	struct resource *res;
>  	atomic_t region_id;
> -	cxl_hpa_to_spa_fn hpa_to_spa;
> +	cxl_to_hpa_fn hpa_to_spa;
>  	void *platform_data;
>  	struct mutex range_lock;
>  	int qos_class;

