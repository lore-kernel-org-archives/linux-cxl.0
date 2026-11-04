Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793815970;
	b=bNS4jOBQtMAP4OOXo+RwfmMHiBh59pj9ASEGCplykC7SakOKCDgusPX3XzN313fQ5z8+
	 MsCR+Rl3ojZ9Brn0xdmnZKFydhBooFw10KJ27m88TMG+ByGWNXc+lZKL151xRHruCd1KQ
	 qlsI/2Dp0SFnpGkBmBmVqaShkB+FtbSBKcL5Fzxa9U3D4nki0ZkyvX7IUTYSsB5buOasD
	 aaj4WTOb2m1CotN/biAvjZM4feJ1CNYQ9e5G0+OotwtGzzL2oIrm0ABwwvI52ZdHb9FHa
	 ZP0C/teym882JmU7xDDz1NtYQA3FuCQRIX2tR9AQKcycTSPKZQCRHDCxlM7snQEE56A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815970;
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
	bh=ZCwhWkJ1DvxwlcSfpyhjJUjU5+kwI4ebFCbFWetN3A4=;
	b=UY7kbPeTA4Y3dlIKNnYw+j5a9JmueUdv3IDL+bZn1Pk6IMQtKIE/1eDlvl3bnPA/iR+w
	 eIOlfx/TUkvk9nPAROihzEfp1V6cDBhiZGtC09TErM0wQa6k/KaYoPB8Qi/0O02gMZiAz
	 iW+SEeUx3wauMZS6OxaJu5Yukrtr95GLJS2uMr5QdT0/d/2g24EE8ugIKyfsFg/I+mn15
	 EoAF9dJSbML4az6KyL3nTgwg4RLwHiOR00pMj3uuMJ09PiVCk3qc5ddV7/MZ1bx1vuy5N
	 XemKRuIDwK0cb/A+OlPaG34MF3Qz7jIpPPrz7WqAKbThp6CGBcnkADxfXx8hIrPh/uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QdjxA5M0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.58
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0954606A336;
	Wed,  4 Nov 2026 18:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0954606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QdjxA5M0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euTErrL8NHOFG/bqsiNq8TwvJ8D0KD4773rnHGVx+7lY9kFrd5vukhAuzOLiG2JLHWUNob383TipCFxZGYBToaxuNCibqAfEg+qNvsHvK4VClAr8r4KRdby93+tOi2IA2bkzw5mCxFMimTH0LH8Qw6J6JRWCZICbQiSmgKukTW8LRoEOaWUWIqqm7/80kf6ygLfKvuuSsexGAkn4AzwUnLMBQuz37W0XFfsKM9Fd6FwcW3fkBp2iu3L5Y5+qQR3L5SqyJHBS1vbnf3l2TOrU24PenYT8oW6zr3jo2oar9W271ianpJZ/ChnYjmZwIjIKN4pVFbA0biMANDPPXNZ5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCwhWkJ1DvxwlcSfpyhjJUjU5+kwI4ebFCbFWetN3A4=;
 b=imH7JkZeVzegpavZMFqzfn29YR8UPIz1drl27DUCBDvmzZHy18NltW6zStBRTUiC+dAwIiR7vGy+6cwyZ544BOAQHbPzajd1/pZHyY3PHJS7atJEMPKCjAfywDNCFwrNTKKqAc8xGspSfKktv90tuablp3/AwDMv8ExtfMUBvV9L6va0j+62lMQnGYI9lqZW8VmZXg7EHLGcOt8VvNfkfEPrYi7C4TbT1Oiv/FXCyvLxRWRPirrYnAIdbKxQyHD2zIrjfZIc/EiJmvoYoH5Byipi1x9N9J+4AHe5qgJOMvrdGDsBJ9BsnMblSdRPG/WXr+MefK2KE+QSjIlh0kFYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCwhWkJ1DvxwlcSfpyhjJUjU5+kwI4ebFCbFWetN3A4=;
 b=QdjxA5M0hDYA+Jwswo0WHMToW1rx4I16a5LwyZDpHMqkfxKfFSyc0MT5pE7qZuX1Ppz7oxycm3stMMqr0Z2UZTl4Nfj/85Lpxg20NSLp36bM+6qzloEn1Z+Q0nae+GuJGi1yKmPxi7qpyTfEHgmPrsLjTystA5i1U5xJ9xmQZq0=
Received: from DS1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::10) by
 SA1PR12MB999110.namprd12.prod.outlook.com (2603:10b6:806:4a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 18:12:45 +0000
Received: from DS8PEPF000000E1.namprd05.prod.outlook.com
 (2603:10b6:8:455:cafe::9a) by DS1P220CA0008.outlook.office365.com
 (2603:10b6:8:455::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 18:12:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E1.mail.protection.outlook.com (10.167.23.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:12:45 +0000
Received: from [192.168.86.113] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 12:12:44 -0600
Message-ID: <d7290320-2135-4afc-9699-4de002d03025@amd.com>
Date: Wed, 4 Nov 2026 12:12:43 -0600
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
Subject: Re: [PATCH] MAINTAINERS: Add CXL reviewer Ben Cheatham
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>
References: <20261104175003.297974-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261104175003.297974-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E1:EE_|SA1PR12MB999110:EE_
X-MS-Office365-Filtering-Correlation-Id: c33512c4-af49-46db-0aab-08df3a9f39b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+xTalhk3VR5nTD3Mm6YP8YIMqUyJ2PkXKdNepQIGcX5+6m2VT/BGUC0rOn9aIwgQtDJAz1I9R3YXphAoMHdhQsm6N3QxAtkTHRSTJMhHA9tYka6j8qRYLuDMOP6K8pnzGaxJ45b1OhQH1K2XHSR30Ah9+XM7VLvNelnwDzrKySl0kqu4zkqfWXD5a5usXMgFZET5G9V/1laBSN2MvSXzzGZDb4vGOS5PPoR+UlTBgQ9kI6ipjHhBAucsagni/T8iondfp/jJ//8S2g7UK314BrItJ32j1rIq9ihU5OZtTnZe+YKjZ+3wuMhZa/ZArMAqSagQUMit62aJ9iwk7w57Y5GCH5yCOAAFOatKayMYwbzGPiDUekqGP/wzYmcej9EjHYUUUtXjCii1DoxnpkqkG+3t+oyJifjy7YHXiWvOs0KC3rJseZ3Vw3XnyK8mZDleY0Hg+aaRMKbsXhcKR/ePAZCXvLeo5lyISObiaa2OAzoZhzUCcHxxaOmRNZ8VsmdpWkJOAEXYXzu/Q1qrroTWBJx8gN3j7ME6NljDbkFOZrIN2R4i3PL5xZ52GbkUy942c9qXa+Xdt0yZritkp0E7WGJT93aPrBmVJIEmh6pO6r9KYWDCqMFlWB1hPH889Z9FxrdtEjC/HPVqPo5TyGQu6lY0NfFMRQPzaWseKGiS5VAOWgx0vfnk9wnTAlKReXHt
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SpDc4F0DuQoQOmTIrxa66gYaV+/WVp/OA3AtBVqQvrmFX65ADEI1WMZdxBuY9O7g+Uh3A6QPSmtV3YwOimR0fMZwMAVpVyH29FunRFmgAHeYy/0LNb2pxqhVPrHu0VHyGydbzAd5fjfOKarwS6U/gPJXx9cmKyeEE0oy7ICnE361wX7JXb7UMIY+22tazI55+inSCXLwnc16MubUPR4j4mQNurp7cxKuj1Jl1vppNIOWxDXPq5/Tv9PBuN81uK0FysLzi7LKbdJ+GgxYOpGADhrmI0Db/ZZ1i12tVOKVgV3FAtjNYE3FQGjwq1GMbJV1/n54ucpPqjt4moCh35O027SOM2Vf4ukqWaoi8H2Kz1N9Lu1c+0GcF1besZf8d+7Y06umQy6SIkQ3ZhrMhKQrTCANZ18DzGj99++j6QqfPIvjpXcISWELdfv6KFplZd0L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:12:45.1160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c33512c4-af49-46db-0aab-08df3a9f39b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999110

On 11/4/2026 11:50 AM, Dave Jiang wrote:
> Adding Ben as a reviewer for the CXL subsystem.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

Acked-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks Dave!

- Ben
