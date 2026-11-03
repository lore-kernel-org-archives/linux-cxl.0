Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793741242;
	b=qX6vT/8CuD72iiMp9f6xx5DnHnfCB0nUhAtvE2Nk5s7LrNFmWZt+OjvNy1izmFYMjtRj
	 RXka1uHaRNEzEXTIf1L4RFxgwDkFlcokTuI1n14rdcuDPzCl4ywLCxWsBrxRnFujxZWRH
	 wbII/jc4vPrH2WqCsjxX1f6fqOjMqKISkaAsNbITXzf6eLjJdL9uIFl45Wtw3aWb/8NQP
	 0ObRdQkWti/RakFCkXrCFnAwbrqGVkYi6+0kYJHdWSBdPgk06TN2OshMXu+6HFuXAtyDW
	 lVMPa102sFOp9pIpT0GnX+X5EmwGHCjMbxUkQzzRt7Lj3eQ+wTP2BXev5BOqd7edRZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741242;
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
	bh=CVo67Tlwsi6j40LPBDoVbJpF93M9WVPGxaE1uMqFUhU=;
	b=EKaFGxDQsGP15CleijSZO1dmesh9pzvanrrYFrGQqnZX2n9ZI74brdPEasJiiPPCkCa/
	 T9heUflsvx+UJYvCoC3LTBhpLV5EXUYIFR9YHbT7LliqVcRj94KwIt3a4kZivquDXkjIY
	 yTqUCeiuXRv3sK/7bnKPjddlfcyxdBn1Kj1ih7ymwXb1R7FIvA8SqPp2YMUILSamLfhXn
	 5hQY70Tl3/hM+DeSW8a1E5+qPcmt2GEy8veXW+rOq/1+UTQBwa6LSeeVWz3F0HTIVArh1
	 uZvJ+s3bD4GosVYY6BaE3EVJfOBhku6QqfWl/8EJu0ssF6njQpr/sb/ujM3rfaiMZmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FrZwMHhc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.33
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD1606A332
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 21:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61BD1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FrZwMHhc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/PiGygxKj7yGnROPYJdddQNzJPCKUrH1N5AYP3wgmeVF0HKDXVT7kCb2pis6BVnDb5YxXGJ+YQDT/SbIPI7S08MyDM9Zs3FI5A3CizKb6VX+/+4ELW3OxOxdtKN8FmoIVk9lMZkFsiKUsrxea0cBvE3ivF86LqG0aqW0LeG/DsRvT2DTSo/2KaqEzR7cQ/rk93XhBSp0g2sTu2D20mxsgaaBC4dzrdnoBsbqruaX12baXITLyO3WcQat4CAQKtfkK5F/7zbmOVAZ6+GwrQzPi6wYXgXVgNWft35Ml+dYqICRW4v7bxOO1no31f+QpogDQaxuGHAsLE61tfEUlDViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVo67Tlwsi6j40LPBDoVbJpF93M9WVPGxaE1uMqFUhU=;
 b=y8RVQm/qVBAudwYiqBRLbfKeQ37hRKvlM9zoJ2Ds9JPQab1iVWjsNXNVFAzPgI1vN258uZ6lRXG+9IoF3Ljs+Z016OuChJBklzogkNINibROc8+XbD/31mUDDd3eyTLepZ8S/XcFo6uKrkDyoUlmMNn/LFG2Bp07NGQshPFvjLPv6bSkiUUKrmWHBOxn1qM6Pkq5l2Xty/HM54PtPlXJsRDbg0Jr82+PAPnDDGRLPemjw78H9WOR+90bmFlfERbdIZmnT6pwLnkjU89NpVtM0d+8h3k+z4hKrw+vq3JM6XzYisU8grSxz+HTSrnkHhv5KrvZKz+I4hvNEDQJJ8pyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVo67Tlwsi6j40LPBDoVbJpF93M9WVPGxaE1uMqFUhU=;
 b=FrZwMHhcxEyHaw5SeqY3Go+Jhgl7nBGCfyLqzgC9AOnG2Wc0jPRkr8nID+Z09XT8VYnZQX5/HNZH+/CtOAms4n8oj6QdTiuhiVY8ApYeEw7p3BYBJz0l2JwBAuGnI1o6Vpavg+U25Lw5as6nKwRHoIAiK+iZZPiS9PpsCbNgtkw=
Received: from CY5PR13CA0025.namprd13.prod.outlook.com (2603:10b6:930::8) by
 DS6PR12MB039703.namprd12.prod.outlook.com (2603:10b6:8:4f6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Tue, 3 Nov 2026 21:27:15 +0000
Received: from MWH0EPF000D8952.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::98) by CY5PR13CA0025.outlook.office365.com
 (2603:10b6:930::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:27:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8952.mail.protection.outlook.com (10.167.249.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:27:14 +0000
Received: from [10.236.179.122] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:27:14 -0600
Message-ID: <3937a9f1-3775-4954-a1c3-e066e62efb09@amd.com>
Date: Tue, 3 Nov 2026 15:27:13 -0600
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
Subject: Re: [PATCH v4 1/2] cxl/region: Reject a repeat write of an endpoint
 decoder to targetN
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>
CC: <linux-cxl@vger.kernel.org>
References: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8952:EE_|DS6PR12MB039703:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de05f31-45bb-4e21-f45f-08df39f13aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|22082099003|10067099003|18002099003|56012099006|11063799006|261022105027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261009223027099003|261022115727099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	tHJHkBxHXRZ4Q1l7fib3bdJVRhXd+Zlccb644PA5SwV0sw9bEANNv5uGlkCq94FkqIgC0uOOCA49oaazaUSb49nqlbgbnDbrwK21xbIZp5gZ4cMMr2wAANwkDx8+VRXfySnPfyoQuK55Ddevvtw0VyWi3n+jJ6zvH+tYm5/g5aXyby4hvxlPMXDpCX5ie8Ifoelp0yzcep6iSrbqC0FESSyYzRWkRVwFiQs2kqEjp47BXyuIAwvrr7OKhQ7t6QZSs3L9hPSMIB2G9f70mzwDLdom8jPyqMsgCtWwxfQhQtI3nqMc6p8+p9UxrOLPfncPqnMePEJB5/wftg9zpQsx6G7GLLoHWaAUr7vDhLE5So7REYm0jFHBInug006Bea5CsowQy+nw44vAbKhORWNchKXgnaFiALRbPxWkLFXBGPiYIXmwyU0maVfq1HhzQfbzcYTFc0KXS8kMae3gw8TAxmes7HeIv5PACxHF8XjFYXdyDtazallXS4LTe7f/t+BzxwFiuWsmnPUnv3cm6f3MdpvjnGj3FNZJSYqg9hL9Er0qtpw93PQ1fMOkcblljqq0NBv/0ZCTJZtxP9HPi6+J95sMrxSFlCzh3fjfr+/HR5ph6wFZCJPRzNdHqkZZBUZDI760+SgU31jdAEGE4bXbt6B1mnTyMhLFAcYrEFlqsOnA6sPoKGP79qvEg9SMWXMxjjvKMYmSg/1dOPK/TXen1g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261009223027099003)(261022115727099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z9yeOHWQO1AHMJLfyaPyDpX7fmRQV4JhAxXq7jRdTQWpcXtyZ0KhI9sqagnt0VKuzipMhp1EDaH+6Bxh/B/n4wgCmf/3h4Ak86qTFZQOsYbXPFdJcKRYRSTqTP/FBueiLM+Ux8rAjK6dGabajmhJ2B1mwgkDbWVEhWjx60Vzi5xT+qh5k/uCG+cFlt/pR4go6vKxUuSRvXDHZsryxYf72p1v6DG65zIzunnh5+JdqASwGc7+4JzSu7slDH3zBrw0V4cyW06dPSnrv0B8E/dga6qc6f0iDw6jlU4qoDPxgRXEGBiZ6IfiPnF1snYHEEVDftHcIUh0DJO9Rq+7/s/3gKt4XIHr91PQCO+hRgKkvhqzfMQNHW6glDlqkemWWLzwiEPp6iMcvSMJLHki74KV1LNqHJzwH/7hFdC07CmzJVfSHWMQ11852kvU1UVVLptR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:27:14.8897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de05f31-45bb-4e21-f45f-08df39f13aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D8952.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB039703

On 11/3/2026 11:07 AM, Alison Schofield wrote:
> Writing an endpoint decoder to a region targetN attribute that already
> holds it returns -EBUSY, but leaves the partially populated region in an
> inconsistent state. The targetN attribute still names the decoder, so the
> failed write gives no indication that the region was damaged.
> 
> Filling the remaining target positions can then trigger a NULL pointer
> dereference in cxl_region_setup_targets(). This can be reproduced through
> sysfs:
> 
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $other_decoder > /sys/bus/cxl/devices/region0/target1
> 
> An existing check recognizes the repeated assignment but incorrectly allows
> the attachment to proceed, damaging region state. Remove that check so the
> repeated write is rejected without disturbing the existing attachment,
> consistent with the documented targetN ABI.
> 
> Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---

I didn't see this before I hit send on v3, you can disregard the comments on this patch there.
I skipped the Sashiko review and basically commented the same thing (whoops), and you fixed that
in this version, so:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks,
Ben
