Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794242727;
	b=ZXzSP7FtzedJ9z0sBbQMUTZ39JrUKAqY4Y/9QkNTmSTKVIj28i931Gc0q19H862cmu2y
	 JGJa4s9YOGWFVcKjryhx69J3ztslvCUpclRrpyW7V1UQLpy9zHAptN8SqZF2zGUAUhZWG
	 Ls1T5675ITfCyQE5hUrykO/Bc4RcROPDdYvkXEpJdSgKDb2wlHlO64Rn3Bb5iIjVYP5Ng
	 P3z+uCBjMnJd27TbGmXyTvStEuVmCZ4fr+6xhU9rSo7cJ70OG6029VX9hm7DVLTM2y5Z9
	 ZtY4/CxnWg4ujbgLoiNyvqoE0SllOnZrU8uaOzB9smPEqSAjD1ihTSTyx4Z04CN/36w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242727;
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
	bh=jeVqf209OTH/iX3ExWorI6GCfUJ5Wu/iTn7x5+54R6Q=;
	b=XaD6jqHrF9qn1Yf8gpW2wm+RwbTYvtFMLksxbkfttPvnCzt62/V3SnbLrqyh887vsabU
	 LbuBlgXB7626/YS3OeeUTf2KH3ljOHIjXUCeJWAfwvVMZKUiqE5V7MQxeKOLQJJ+KlmlB
	 89QXQRp+pU7fUWDto2zbMYhUykAIz2CLxClRQrKy2VNihKfopcVZx3RIvckDUIeaBlm2u
	 j2vBGfV7ZInAHoR9TF9TPyhmROsnQNLUUwTmR8zpf3G52ja+OTPwTxTEcfz0h8WWhWo7K
	 GnEZ5uBxNk4pNFj2xVm6dr/Lx35ri3gB2viCIsl33Hay5MMHEaX31y+o1miR/L4LN4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="F/74SQYY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.32
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A6606A31C
	for <linux-cxl@vger.kernel.org>; Mon,  9 Nov 2026 16:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A99A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F/74SQYY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/5iqK9kUdqf2vx+dKYRTUHFksGtjIU5NrtSfzQUadI7G6lNB57MaxPwlX42tXRC1dAbWhZoWNpARLOY/1VAjBXdTBsSk38pg4F0ZcP9gSqM9XaKSWpjZH0HsAHu/0LMPpm+2gEA38tXl4PkqMOwcq7Au72gzem4L0KRKuEACRm4dyDkCZRP+B/6gI5Aul3d7ozusmiknBDlsILcYL0E7uR5rG6HESdGACfFN7mnPgNkBCry+aZbf3nYUo4yZqXm4Fs2Id0t3BfIZCcX8c6vmKYNbE9UJZ0cO2ZpBA1JaWAAYckBFogAewBH6SNPhtmGDSF1Ote/oyUuTZd4cdAjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeVqf209OTH/iX3ExWorI6GCfUJ5Wu/iTn7x5+54R6Q=;
 b=y2IeWVGufBLJCIWSJ2MS4yimpuCBRT8/M8v2C0bzX8WwaovDKGD/+Xg2sKoB3Tcx+yTVNBsMoX0uIEXLYFI8PNhjkO+UFhIhi7Zd50QhA/7td8DvbSEyC4Y6u1NAoU5zp9wlUV2831qpAbpCDgsp1Opobsm0RtmseVZhXT3uwaFsMziwDtGsYbIDs1DNzdIshs1GsCUTj75MQRYCQCwz3BPXZkiLV82VYAjwushcjx9fOyUjgp8qR/le1hY35y1WgQ6PVdKKjFkpCumHQvrRlwNAN0Ce6FXSAKhqitDyRjb8AyQpSVWwfxt5iu2fMakZdX0IPbfxEw+2/+J5lzGW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeVqf209OTH/iX3ExWorI6GCfUJ5Wu/iTn7x5+54R6Q=;
 b=F/74SQYYO+FaApyRU+EwtsPiT5fnDqL2R0gOs5z2vAialRQaIFudZm7CSJLzfVJJ7cDKisuQgdkY/BBUYTbyRabiw5b6dAd1C53YbohYmBBXlNBSjKPdQDaGqr7tjca1rgwyt+DoFdBvgaPfJjf1MfZduJp721LqSd284ypRLMM=
Received: from BY3PR10CA0017.namprd10.prod.outlook.com (2603:10b6:a03:255::22)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 16:43:07 +0000
Received: from CO1PEPF00018861.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::70) by BY3PR10CA0017.outlook.office365.com
 (2603:10b6:a03:255::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 16:43:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018861.mail.protection.outlook.com (10.167.249.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 16:43:06 +0000
Received: from [192.168.86.119] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 10:43:05 -0600
Message-ID: <3e4d36ae-fc94-4148-a6b2-09a0a60bbda3@amd.com>
Date: Mon, 9 Nov 2026 10:43:04 -0600
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
Subject: Re: [PATCH v2] cxl/region: Restore a target's position from its slot
 after sorting
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>
CC: <jic23@kernel.org>, <alison.schofield@intel.com>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
References: <20261106233711.2654827-1-dave@stgolabs.net>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261106233711.2654827-1-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018861:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 359808d5-9e14-44c3-ee72-08df3e808819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|22082099003|18002099003|6133799003|10067099003|11063799006|261009223027099003|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261021121427099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	JHgpht0NwX2nWcCEtcBXyrbx8Cm8wjyTl0oesjv8BdD5vEuIqltX71TnFUiSof7LShXVDaz8wPvD0R72agIopVDiwJvnkpcyp3lt3ZUETQPZWG4dJSZ0wzAUg8Ih8gzetL3xT8vqU+gDIYrUdkGutrprK2qzP0flFYgmtdMaPppzEAgk79lAWrw2JIoea/VvNH7WbTBiF7c6WSqUKWb96bIYRCknmOq3Jp9raIBgNbHAMR1oBdzo6ELZAW2Pwz4Yaf6eRFn8LmdxRKg/nUVN9Zs63G1Wba9cfZdgnmM5649aYzv5lhzYjlfdObZtspe5FX6yErbT8iqmncCCRCDcj/YzIZpJvwNolqNpVqYO5vLjR8z6XKNKUW1Qfvx+hjGQJu82wfBjdgpN3AriKFlQzRd6fMzaqWsOhHaX4Uxm/C3qi+p8qYBuIIhrbqqeu85q3roK5LG6ZFH6ygSCj/JsEcoon/B496T5znclr8zhF41xQnfiblx8YavalugdMLr0RY/gv+f5Odyx1TgciQiEKP2AApuMdAsDpt7+7bXoRha2D8yFc2cJyXm8wwfelcMCLepRdVa2kM67WwqORmrfuIcEt3wTGkBvpicaSrSuzQzJJDY+pKIftLuNEGbD8XcMEEZlAzO7if5AO3eaNXEDjLreaLy8c5JOKneolBWp5oFngjHkaVox2g2G8ZYmfoGacZoLyeHvxwrBZb+Qiir6Ig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261009223027099003)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iiweaMMXH4KGBf5iBOPYwDqJKJtTp+U/yDZYB75imDVKlkaN+ly2sB+1IGDttOzhu9B7Z9XivFRflFn4OhRr4SYRAxMj1L9WOpnbwmWM/mwNYuHM5zflK1iVJEk5hDMgLiLyQARqkzxYfhh03Hyp36kA0BDnmzeVs5iMcLRYWc6AlAXdTiWuxRgH7r8bMqtAVavRjizsuBuNVlw7S4tQRVlycfCJgNRFDhtRglSCtzhWzm7rspTP/oOVGDgqA7LbxllF6ztMPu5/qmr1RstNxXrx5nVlQ3xL/6rW1liZuXmRjvI/lgTGNek1ahTDOc1fDgj9EvXKXi4U3+fCQcpte10kKAXN7f1Ji+fzaG6tXbJMe02u7c+h7VGHTUIAA64vSi4sxNjJzHjnMA8kd1S6aAxXo6wDoIyiKYAOI0b/JkBoAbG7hQVNYBAVYSVfbhj3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:43:06.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359808d5-9e14-44c3-ee72-08df3e808819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

On 11/6/2026 5:37 PM, Davidlohr Bueso wrote:
> Region auto-discovery records each arriving endpoint decoder in the
> first free @targets slot and sets cxled->pos to that slot. Once every
> member has arrived, cxl_region_sort_targets() calculates each one's
> interleave position and sorts the array by it. The original version of
> that function then restored cxled->pos from the member's slot in the
> sorted array, so that follow-on code could rely on
> p->targets[cxled->pos] naming the member, failed sort or not.
> 
> Commit 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for
> auto-discovery") dropped that restore. cxled->pos now keeps whatever
> cxl_calc_interleave_pos() returned, which on failure is a negative
> errno. A member that could not be placed is left in a region it cannot
> be detached from by position: deleting that region runs
> __cxl_decoder_detach(), which finds pos < 0 and triggers:
> 
>   cxl region0: expected mem0:decoder3.0 at position -6
>   WARNING: drivers/cxl/core/region.c:2314 at __cxl_decoder_detach+0x483/0x910
> 
> A decoder committed by firmware behind a switch whose own decoders
> were not committed for the range is enough to get there
> 
> The same stale position is what commit cbda6a2c2bec ("cxl/region: Fix
> out-of-bounds access in cxl_cancel_auto_attach()") had to work around
> by walking the array instead of indexing it.
> 
> Restore cxled->pos from the member's slot after the sort.
> 
> Fixes: 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for auto-discovery")
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks,
Ben
