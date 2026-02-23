Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0A18DB37;
	Mon, 23 Feb 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868009; cv=fail; b=t+ZiUGfpEOwGtVmj2wvayFIot5RHzivB5iJW2lKu0z3HtmpK0Gb8Enid68UYuts4XgvUtiPX4/MZ4f/EyEE76cuOEtcooJJ0QyrvoeWjoqbtYR400OGmT5DWvJhwgpkSYp4qhr5KxIPkCoSgnUF7jxxSzUe5+TGAmhtaefRzH2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868009; c=relaxed/simple;
	bh=hGrfxsh0wQGPoOng+d2EoCY5NMgnGR+heGROHWSJ5Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lJLqf7R7Yh3WZbM8gEVUMvBnZgRu8q7QN8em2UYVpCR4h2JhLeR4EywKBQp9VI6plmLRTMqhuVCb4yjhTFv6QqPn8Fz/nCJrH6OC5y5k8ka/xvEPVFPOBXNSjrcZJvf3aufV/YUThFoVOU6SnesCJcesv1wde/oPhUPTe7vHErc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lh1U4scp; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lh1U4scp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myNoMW1TDF8PKDz54MONPybD5tzC9m5V5gZ6bZzdAqg5XXUk0oIddTk4aGBO/gEil7CNdVDtMmjUZH2gwnsuvMwHq3BX2b0VrSDvy3tzmuLylQ2y0g+8XZVnGGYWZXCU7VAlcEtQjd5GgBHU0XlXQL91AzMmWbjXP+rKGPpPbtHHt3NPhxpe4/chc5wIn+bvPwD4xh0KBklVeWBF7dQl/7aGQK28gglT2Q7FYmx5hdi8EKM3NZ5eQ0oudj+Mn6b0+xv0xAn3qe9m17cS8Q7ZaoNCJV+8JR4+f5ZGJA1qNySRw1mA6k+My0/Dx63INyAI9Use+yToTmUwXXpODihbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZtbhSOvXkPHUy5IRT177yTXW+fzfhxMUPoe8O5RYHc=;
 b=n7aYDxSI/AiRaIOEaKc96TT2kE7+eF0JL6widNNxLpiWDld2aMHY6rHPK3nFscbSLlWCMwOwBARI71q2QdfazB0/m+y9Oq2sMDvlguIWlhv0/qXme5kF1Ps/Bji7sNsIjcsC8o6yp6amFIBx/dA8FSLl0PJUgbkxeTiT/Inj6QO1lT8wiRXGU/skEMU9whfNJsLgD+s0m3orWpUtSHLAWMC1EjY2Dk8Xl9B7KzqB8cUiKTcy96IzNUPWQlUMjnCr1vPXUz1i4RFHhTWKnh/gLpoBfGdp0YfjKdZ2yLx86CHD1JpXpG6sosP/Nhb5L97gGTrJrZjYhjLhvmu06p09Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZtbhSOvXkPHUy5IRT177yTXW+fzfhxMUPoe8O5RYHc=;
 b=lh1U4scppXltHjbIvQkoc3wZvpj8FjyAY7e/ITlgdvS55Q9WrSHJz3caZz9roGlLThtQo26Am6aJeiClzGfQwt3d/BvkGJDTcN/l/HI9s/zXPBODINgMX+bbYj1eWPKkBR39HKASmUC+tmk7SI4COp6pehvjxALCD13KASehxJ8=
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Mon, 23 Feb
 2026 17:33:16 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::6b) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 17:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 17:33:15 +0000
Received: from [10.31.207.109] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 11:33:14 -0600
Message-ID: <85d7abf8-3b3c-4199-a680-1453f77b3fd5@amd.com>
Date: Mon, 23 Feb 2026 11:33:13 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core: fix test_bit misuse with CXL_DECODER_F_ bitmask
 flags
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <20260221021810.1390342-1-gourry@gourry.net>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260221021810.1390342-1-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 5695ff80-2a53-4029-c39e-08de7301a08f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3p1UGJRa2Q5WUlkbkFJMDh3Vk5mOGxQYy9tQy85R2p0ZmN5bHRPVDdBQ0kw?=
 =?utf-8?B?ZldpZ3JLbGs0K01GdlA0MjJJL1lkZGk5MXhlRmdlNy8vUWpFa1FDWHJCMS9j?=
 =?utf-8?B?eVVUb3lPdUttTDg3dHA1VkVUVFRGelhzSitYYVd1Zkp6eERlYmNoRTJ2R2tk?=
 =?utf-8?B?OWJrNEliTVRlenR0d1B1NXJVL2w2di91akF0NFAvK2d4QXVzWld0eldkaHhu?=
 =?utf-8?B?QkhFVGxrMGYyUjJVaFg1Rk8xN2xjaCt1TkJQQ0FVcGFmQmFNVDMrU0xPcXJN?=
 =?utf-8?B?cUFzYnJDWngwVWc1YzVFdHR0b0t0aldnb1l5TThmT1dmbU16V3JHUDduWXkz?=
 =?utf-8?B?ZC8zeklFMFl2c1hHbHBOZnc4TDIrVnQ1U0l6a29SaUVrUmlsTmJtL0Z2TE04?=
 =?utf-8?B?aVA2aVdlaUVSWjlQS3o2dGdaRTJvQWlmQ3Z0ZyswODhVLzFhdS80NFpYY3do?=
 =?utf-8?B?ajZDazRxVkpQY25XQnFWNUJvdC9RTVVjK1hiK2RvTm8xRUk1VGJCcm9May8v?=
 =?utf-8?B?Z00vNTEwMDUxNVVRVEkvTHJFY1Y0SXJoY09ucDJTZmJRSktjWDR5ZnFibm14?=
 =?utf-8?B?OXhQZVNIbHdZWVVWdERTY2REb2t3MENTUDdUR0V6MU40ZHhtSXQ2YkxpRS9h?=
 =?utf-8?B?RTlqeVM5SWdvUHB3dVFUS25rMXVoNk5xTDVSbjNFbDBBR1FKT29kOHRCQkMx?=
 =?utf-8?B?UUs5NHI4amxHY1d6cFFZYmwxWjFibGxMdGtzbHVIWUx4c2hpVktwV0xWOERp?=
 =?utf-8?B?Qkllb1Vpemxac2E2SGl3bU52WHZIY0lOekxsMnNBR29xeitjbWdSK3p1VVoy?=
 =?utf-8?B?cnYzcXByUERMeDFOazdxVWE5V0dMUk8vS1BhQVJsNit2WjFnYmhOSWcvdXh5?=
 =?utf-8?B?engyUFBERkNLWS9XQXFGVDROdGNVMEZaV0c1bHNMZlBLcTlySFNXeG1SdTV1?=
 =?utf-8?B?bWt0NVNsUU8xRExPd3p2SFJJakdpT3N0ckVtNjQybVdPWndZTHpuU1llYnFj?=
 =?utf-8?B?NWpXNFdaNFpmbDl0MUxXWTd5R2Nqb29ZczQxZUpXdTBxOEFtdGtTdSt0ejBl?=
 =?utf-8?B?UENmVzY5eHhUaEVWZHNuWmh3d1dkTVVsd1dYL2o1UlRQalhMSUhyNkY4K3Jl?=
 =?utf-8?B?bDRiQ2pETlcrMWZaU0tYelZFTmdvckN0RUZoL1dFNmNQRnc1dzJBZS9USENv?=
 =?utf-8?B?WmNSYWt4VWQvUjJ4Q3BRWHNXdGUvKythT0hOMCtlK0NGTmdvUnJ5MUJVOFpT?=
 =?utf-8?B?ZU82U29PSFBYenh6dnlsZndqSXlNcTkzNlNKR01iYnEzc0tlRFdYRlNySjVr?=
 =?utf-8?B?SEk3bFowNUM1QkpXdkZuUzY0cDc3KzgvVmNid3RDZ1ZobHZWNEhMaFBKK3Vn?=
 =?utf-8?B?anQrQ1B3eWZ2ZXgrdzNRYlZMTUNxdnRQRDRxc0c3VnNnTjRBRC8wTmJYT1o4?=
 =?utf-8?B?Ui9CZjVqSnhQa1JmZWEzRVlvUEljeXB5dGhOQWdtcFRxVVNVYktFWXc5b1Rv?=
 =?utf-8?B?UTU2QjBXUWhpbldvZ1h3RkIxR2ExYk5QNDVFN0R4SUpiYlE5UllIYzU3RCtM?=
 =?utf-8?B?Yzh1SlNsSG1KUUNlRUZWd1NvaytzRXYyaHlETXZwQ3hubkE4cGs5YjFYajlX?=
 =?utf-8?B?OVJIaGRzYS9GakYrNlRkZEJ2cGVvOHc5aXZGSzE5a2NNZjhyU21MOEozdG9n?=
 =?utf-8?B?eTdzTFVOR3FYQk1SYmhabmpuRWF4bmlzaEVpWWpBdlIvVHh5UnRCZGtISDkr?=
 =?utf-8?B?Y1Nob3VFa2xJSjREREwvTjdUSEUvL1kzekFKNzZXZTZGdGU2M0ZFMkY1USs0?=
 =?utf-8?B?SWxtbTYzVnNsTG9UcnZFMWRwUFJ6Rmprdy9SV05QVjA0d1dMcmJaN1RpcTZO?=
 =?utf-8?B?clpxdm1XOW9wa1BnL09lNDdXclA3NG50cmhiNDVHS0s3TkZnZXduTnBrQ0Er?=
 =?utf-8?B?bE41RnRYRVZXODZIdTh5SHBsOUhsWVFkZUlIbThCS2R0ZTNLR0FGSjNLa050?=
 =?utf-8?B?MzFkSE5HR2ROV0VhSW5IVkFSV3hvV3FiNUUxRmYweWZyY0xhUHFHRUdjT212?=
 =?utf-8?B?MWk3R0dlbkwwRXlmTWdHeVUzbFdFT2hPOFR0My9pOGM3djM2eXV6N3hISHRW?=
 =?utf-8?B?RWtlT1pqS3QxUFllUGxMS01Ma3hsMEdvZ3E2YmI3S01iZmo3YXFBL3JON0o4?=
 =?utf-8?B?bnBOUDVoT3dXVm1VcjJLWjJrelpNU1duZmZrM0lCb2dPWVUxc2Nrc29SMmhP?=
 =?utf-8?Q?q7zn5x+5cxoMqE+l0ZrWBjF1wd7jbfzbOuA7u2vs4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jNcCUzL6iO7E7B7lmYd8KMA0jp8mKmXppKE3kxI0gJ3EVhD/syT83yWfb8hlC03Reqnf1u9cxf5BSl2vwWqB0QTWk4nJOip6QudE1Idmggb8HrrAk88RVfLnO+U2tZRy4Pb69l/kFiy+G4WnwJnPmuYj+3qZJbiM65vQgIyZuPSQV/L8RyQAyePBgJFJ28Wt8w3HND/fRtNyevBEubi/3H9l4SoJ+g6G3Lu+LZQDVQ/rcJh5u6IF95ZhYt58csdI/T/t1PjOsbpB4XdMm6fDBO1aSQgT06VND2Vsn7bxfV91JounpKBnkhVdjl6U7qThfzYEq4J0HGOx9tIWwpbtq6EsGF4OsKuZUxp4UcohcTmq3iU7oPm1zU1Za/6CON058gmo9LD9UbfyCsZ3xmfQXkx6Uv4oTwRzA7NfE0eAFzva2U6B+IBi3VfO0Ah1S6Ud
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 17:33:15.8351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5695ff80-2a53-4029-c39e-08de7301a08f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9

On 2/20/2026 8:18 PM, Gregory Price wrote:
> CXL_DECODER_F_LOCK (BIT(4) = 16) and CXL_DECODER_F_NORMALIZED_ADDRESSING
> (BIT(6) = 64) are bit masks, but three call sites pass them to test_bit()
> which expects a bit number.
> 
> Replace test_bit() with direct bitmask tests, consistent with every other
> use of these flags.
> 
> Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
> Signed-off-by: Gregory Price <gourry@gourry.net>

Alison sent out a patch [1] two weeks ago for this. I suspect you found this bug
independently, so I figured I should point it out. Otherwise, I would add a Reported-by (or some
other tag) with her name.

Thanks,
Ben

[1]: https://lore.kernel.org/linux-cxl/20260206181404.1025991-1-alison.schofield@intel.com/
> ---
>  drivers/cxl/core/hdm.c    | 2 +-
>  drivers/cxl/core/region.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index b2db5967f5c0..c8fcb9d9aa3d 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -904,7 +904,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>  		return;
>  
> -	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
> +	if (cxld->flags & CXL_DECODER_F_LOCK)
>  		return;
>  
>  	if (port->commit_end == id)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index bd4c4a4a27da..385be9cb44cd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1100,12 +1100,12 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  static void cxl_region_setup_flags(struct cxl_region *cxlr,
>  				   struct cxl_decoder *cxld)
>  {
> -	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
> +	if (cxld->flags & CXL_DECODER_F_LOCK) {
>  		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>  		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>  	}
>  
> -	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
> +	if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
>  		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
>  }
>  

