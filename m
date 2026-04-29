Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E416396567
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497303; cv=fail; b=Lx+Kb6QUlhlsCknx/Lt5XKrKES8v6WBLtpn4cPKJ6B+UbPWQgbFxV95AEDJGC60RgAEPcdxLfvIyS7d3N8ic/02wjcq2dnkuYVTKDvnwJ+Vj1lYY70d944rfSI6JFUgnsVRBlGA3OsE83ZZRc++ypSEA5djMtIsnv68zCmiV3dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497303; c=relaxed/simple;
	bh=fSg9k9c/uLPpRJpZyGpmwh+4NcGvBfAAhrtul1uf+Nk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NBgp7WoP6ol3RDk/zrQmAzZpFctLTeeAmAzgdxaj++rDYdbopS0XoG5ANHHntasUu8K1q8tWzjq5DpAthhaCPHN0ef0pZ/f036c9B80Dut6pagTvrhwGMnUW7qlqZa1kx8GQhYDMWaW5JdLb7j8kKtsH4RgsYIPQ46x4tpMFbko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4MOowmUV; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4MOowmUV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHRaB/M3RkAgRqSSvzVtiwX59W0Qgw0KzLktQ1h5RWqVwOD7/iGTbesd4tBCKy/5NLHaH9HgoUaQrF466CH9DNaQuE1RAwht//mtVXt/MDQ0Vfq2RCEyhXwTTR1xfW2xH8QElBRRWQnXqOOCrY3Z5RTUG0sBQ1QOefjfQAOQ4UvkIAN0ZOqyXMtRptZ6Djob/VbCwzDil75Nhyb2uJ06pNCKsZNEyQRGXEJfJOqH1y2TmyHEl+Syt2MFZ4M9R+5BNe+7brpcM6qMsB7GM98/pU6jjH9gnmRtZDgV3/MxVdQ83M1mQiUUd+JTETehQjLKU2WwN7oHmJ6A1L9r2G7t3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNz4OKW0wYFL5usDx79wQiqzkcYKa+yl2QrltYJJnjg=;
 b=L9YPZusuOZoyZ0g2hrV2BcfbOAR2f1/V7xs8htd06WVAvgS9Pid6Ts0SKw57wrL/q+jB5j3+1WTprB3rFYxra+L+Ag6sru4A8TQgglLwXreFxbXHb5STng37t4a1vusXklGtb7jhk7KGqo9pHFlP02fCxXf+3Ete9YAcCGBAnnsevzrDR4Hgkye33OaCF2qSUoEk9RoGIDD3pnh8360vA7D7AFSIPUqMDuaFFirgSoxk12wwn5YvtZrGOe0H+jYXyrbEWFiTCXK4FlbuFlV5b95o8EBoXZSh6o2aQYdkzKBK+vrk+7ItP9lxi77vWVZSWPDSKfGfMweiPMuAbhAGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNz4OKW0wYFL5usDx79wQiqzkcYKa+yl2QrltYJJnjg=;
 b=4MOowmUV3hVzj6bisOvP6UXBzN0PzzZ5tmtmQ6KSNJ4If5IZeFGJTtZNmaKY4YIvRS1CzPT/oshOhpsfyS71cTW0FzXpAgn8c4WqSQfxOt2k6t/Hpkm77rXaJhf3y77CfMVRMlusoMbfDWXh3hXmvEpwYUJascWbIg2uOf+Vyqc=
Received: from PH0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:510:5::28)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 21:14:58 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::13) by PH0PR07CA0023.outlook.office365.com
 (2603:10b6:510:5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 21:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:14:58 +0000
Received: from [10.236.188.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:14:56 -0500
Message-ID: <0c647fd0-08bf-41bd-815b-59e14f793a92@amd.com>
Date: Wed, 29 Apr 2026 16:14:56 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v26 7/8] cxl: Avoid dax creation for accelerators
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<djbw@kernel.org>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-8-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260423180528.17166-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: f01075a3-9cda-44d4-f5c1-08dea6345e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TK5nhQuf+a/J8TywSJOHfJ6yRToGf+Mgjm50llu9ppcOM0BiN3rnakzWKN/RxW9LgL0VP7LjXNPh0oP8t4jCPJha7VYqpBrPMzpJT5y54W9n26O8ilcxREw+5z3hL2VrTM58MbczkrammunuqE9XquyayT2/sBi48mThEkZpPa37lR3Tjj4QBGgKvG5scjOdByqil5wuZE07MHeCU3o0yv3ThecOR524NdW2GZ2norc1uq7tsOiv2p4OiV+jhBH9lWkcFrq3oLA/p7dld42Bn37HQyxPsGb8Whflve86unfFq7npjYRLoki7nVyA7wI+muo34dydXWq8A2xdNnY7FW8o0P19ArzRiU0Qt7spI5i9dEv1BOqfE0Eev5BGR1ph9cm5kZGydNlWXWUWVRhH+UvcbJvCncZWn6v2J4Jaot1nACz/y3btZYhoJvDiu4eAmsjosRN8Ol2mhBbVZt8sDf4Rp9hCi5mj62TAyCu1fz5ygbv5oNAMzVsWCcrMy0eeHBSWwLi428L9cKjUzUrK687/0/K1iA/fSKTph9tB4kwskUUtATvzyPeRc066zMq4aP8qW8eOI5Q4YrzpfZ0bhMuLgHUjaJUXgzgDw5KYglw274JSaC7Pcff48p0/4RGcojBYJXNnJpng5mn7tM+FTtmM06yUvyz1ghNPQ3TtUpvEEFaDq3xxsCyX7wbaQcaOGZfhL3KbTWWrY74uDPossaV5eZfn0pBj/URwvOd4r3wzzvkGhhsxGKhGNgM3uUarnO6e9zzuBkoAjPWze9zPNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TSapy13QPKtoLEAi001heVXORSlmJcIWTYLcBSYmm9bfqvraJjY2pF9HorSIf/MASVUT9cv8dy6svuZ8fvDcfRjkSNFLvO3xWIk4r+wuX4Km3w4Q8HaaW9c7iyuMGFl7LKVnv4oqcI0oHSz7UHa+wzBVwRsNMaHAoUcTi8PtGgAuvC4RytXOxPge5+bilSxDkrGpPVV4ZCLsQnj+z4+rsDDfus5Hv0dlhpbPjPy+t5AY5H/X+FKtIRhMAkErL9ZlRXSeb4xDyTSKTZza7oWB89Ik93P2CWg1V9CWvXbKeKs6uvGYawAICt2OxIVxr1gHrXd4WeCc1DrXJhrcrR3908xjlLj6fbl+vHAAELx2bBNVTCRjlZa19VdUxKiA4u7+4rY7Q/I16N1SxnqrRS2YDdFwlDyHGkfMyOWb+ezror/ghILynnfR9lFJUN71HasA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:14:58.3016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01075a3-9cda-44d4-f5c1-08dea6345e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184

On 4/23/2026 1:05 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses like DAX.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 68f5a1fd1b1c..3af2aed6c6f1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4165,6 +4165,13 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
> +	 * Skip device-dax registration.
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM)
> +		return 0;

This should probably go before the call to cxl_region_can_probe() to avoid
taking the cxl_rwsem. Not really a deal-breaker but would be a good optimization.

Thanks,
Ben

> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.

