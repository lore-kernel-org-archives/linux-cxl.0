Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023821;
	b=zMcmCdUnFyHczBJr7rQ2NpRYWCkIKHPl2NvsHPCa0ULawg9AhlXEqNVTKFq+fdToAw0F
	 JIOzH1cyPUovROEBp9kxjUbhplAeEkfMD03JheN/aDyMuBLDOlj2YOUGVyQ0jK1r2Mf8k
	 sgGWSD72E2NS7q7f4sLsIG+KIn+EZRG0kl6Qi317/XO+kkDm6ALjDpH/PnFwzNrG17hDl
	 stYjIoxThXGXENDLlTHrKx0dHA4fdc3UsDW5UE+extKwhF3GueraBSjrNxWu8bPF0ZTeA
	 QMDcGlNeeRqSpZ/yReG6irHQSwiTEbg7+heA64Z8qd0/fvkWInZxWUszrUKDijN2aQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023821;
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
	bh=36pd4C+0m3k9g68py+oeAY1fcgP9uCjnk7b1gMJuiYs=;
	b=VGEEeT5+7zlpt2M00VfIDwqk2oCrMUe/S4ASCqP9hw0eDV++ASTCm+3x2lD2sVwI2vud
	 +gS2t4t0IeHGHr5rNhIhQKs3s4pTXmnA6eTsgrJ7zpuxOhbC5R1zHL1jjVPAPOHwwWLMV
	 XUt0sgVh6madaVrsSlaCCL6pigOI9u0JYOGFglVDBN1TgG69tRHOHZfpmuX2xU5krkWS5
	 UVslxMWXNLsmKOih86nHqiRLI1oUSb/UyxBnbl8DxV04sbVnlfcDQNfUdJbX2VK8fdmov
	 KXgJVRcAmYwUn8ZAYQAIYvIVuTPFP5kh3DeF+WSvJ112cW40ADLnpl4U27fZ+c10xoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yMeggIng;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.44
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726CA606A32A;
	Wed, 18 Nov 2026 17:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 726CA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yMeggIng
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ER/c08Wcs+MKc7461dZS9Dd7K3+oem2yZZO6NUbYuNIBelw+5OzdxrCMOMfNDc1QW0Is92Np26+OZ9G4Oyp4oMEb1x7prl5kbI2eqQcdtRPEwvDvtL7tKmlpyjm+om4EOtOHUEUtyKnMX9qvNthbv5cF/byXo5L9SpX7nTsqya2BGcO5o/tjvDp9jKukcMafAwTzcsN1kbIX8R/TRgJv4ZGU8axyH3CnD1fP4iL2jPpkaMzlyV6e5G6OwGONzM+QwcmljxmG3MBkH3gWfHfqi96N5BpO1MJAHFZBJwN40W/13snyt4Ou03PdWGydVVQ21ZLEkYxGsWVcZ7qS/iKpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36pd4C+0m3k9g68py+oeAY1fcgP9uCjnk7b1gMJuiYs=;
 b=eineu5ltEXiuq6He9fo3pC83a8bEQGrOGkjtQNJ9tdq5Sc6j2XeUIwBdIsSK/6yAoiz/YUdfBdXOoIHHYAxChuJwmQEM5PBLUpBXEKR4ZZ8I8TlfK08lDg0jFBrIAPlcH8I045PbVHP1LjgrZNDQfAAWoF3MSREkc5gXqkKgsbgk2yZBOjCvYU4qFVIQ28CUmXObKse6/brHLw6GvCh0kG9Y/W99Su393G2Oa7Quhq2O6d0fFIj7wno30yoct0xb45WG2STVHNl5rC+mtcizypPKsJCpeIGOc3HBx9xzaHU5d7/zq7mlwlmeEkvD6dKizHsmh6qS8NykKdjWU+vMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xcena.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36pd4C+0m3k9g68py+oeAY1fcgP9uCjnk7b1gMJuiYs=;
 b=yMeggIngI4Ds3tCnAW+GwaM+LmbwlX+tY+XwhGSjQz8zbfbyTVFiYUgjSLhqXd9yOXoNn4JA8au++sPqx6zynC6HfL9ldi/vX6TnCcMrx3Lw5fLKsakfISTksOX9d6n9uHmfK/yy2vLM2OYqzGDHmJjvMRAqXHbxQMwpmf7XDi8=
Received: from MN2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:208:23c::32)
 by PHXPR12MB999231.namprd12.prod.outlook.com (2603:10b6:510:3ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:43:36 +0000
Received: from BL6PEPF0006C3DC.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::6c) by MN2PR18CA0027.outlook.office365.com
 (2603:10b6:208:23c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 17:43:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DC.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 17:43:36 +0000
Received: from [10.236.182.143] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 11:43:35 -0600
Message-ID: <4c1a43e7-9f73-4a1b-a954-534072baa7ec@amd.com>
Date: Wed, 18 Nov 2026 11:43:34 -0600
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
Subject: Re: [PATCH] cxl/region: Fix self-deadlock when
 cxl_memdev_attach_region() fails
To: =?UTF-8?B?7LCo7KSA7Zi4?= <junho.cha@xcena.com>, Dave Jiang
	<dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Alejandro Lucero <alucerop@amd.com>, Richard Cheng
	<icheng@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20261117-junhomax-fix-cxl-attach-region-deadlock-v1-1-f373a135edd2@xcena.com>
 <23185fba-5905-4671-8d94-8ae10c78077e@amd.com>
 <SE1P216MB2499A0F74C7505ED91303105F67A2@SE1P216MB2499.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <SE1P216MB2499A0F74C7505ED91303105F67A2@SE1P216MB2499.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DC:EE_|PHXPR12MB999231:EE_
X-MS-Office365-Filtering-Correlation-Id: 53906d6f-ed95-48ea-18ac-08df459b7948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|261021123027099003|10067099003|56012099006|11063799006|4143699003|261022115727099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	TZAlYNcj2Vf7KmdG/4xD4fu8j/Ws5TlvCz11UGqzqloPaAWOCJE4lTQmULWXWEK7r/15S7lJ9Lg7/+G+xFqD2JEUOY8sAeAptwY9cpmfPcaobqqrTwV80pO6p6b6cWEa87OgCvVp9ARfickqHfaXs0tzPRPfFcwsZxV9qqN5SoiY47UQFFoyoozq3BJhc4Tp4v0HUm2QqTodggaH5E7mt5Gtq91kKeCRRJuVuWND8J8sd6gTrMnfrOhwUD/pLx8o8x3MKs+60253QvPjAI6O7RQX6wvvdvhul5bQ3rFVyo19R2WDAtLbtr92PGYdt0+AfeeQzgBEJkNzMizKAFjcrBRebFyx4poM7l9cD3HEjvT5O/Gvlpba3sJdc49szGwnOMV2m4htec/ZEo0Rl30ppZJznoiXtC9DEFtshawZExzuRnD0HSKAiWM4PDhEXI931phoKjRBWhSxv+FLWehTyAnPhZx9kj6HQ8iNvA9/jMHkgZgyq0ajg6ShBX4F5eoEHPqrAX3zte8ZiZLRLfnKOP0uo8azDFbcfxj1uSxPTJDRTclg6LJj1GbmiMrcjDGPoK/qeJ/NnhU01qEM7Qp1Q3KKOjFoayIc71a3ltWahxoRoKIlA0dpMIc/LIUse4Qj9JJtLUUer1ZUwUQrLbjhjrGf00+YB3BtfWsmER5ESWWrYpORBrwhDMn5vUrvPmhIyDWpbvzLio/DFUXFRdIWEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(261021123027099003)(10067099003)(56012099006)(11063799006)(4143699003)(261022115727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9ZqmVDXUwTJi7r3EM1oZ5kgPhv0TItl0cX84g6XuqzzUHbTXZiwERF+H5C5sZ6kgiIzYEK/Je28a1JDd7VHxDzHJVZ77gyIVSf+GZUEmKDn3IddAPoMxz0FDhCkFYFfdnile5/EN2jY/2ZuAii8aJpzatr3MEWO1/YaIrodxiN8JTQaOGilgIYN+TAYKQnKmP6y5kM/xbSQ2WshPRSxcID43kmHfGfrgJhMAV6fg/1ogld3rzP6x3E21H9LjBnZJkR3Bkh2zzbRSMPJRu3IUoelQJfOK0s0KNdA2YtLhpxKvdaB1WSNyYvRc43jdAPEq7zqVfAvhMcjn4eGefsQaKooN3SH5ZlioyWKwSP9S/javb/MR+RrCVJpkNzfHX1N+koCi9FfU+/6LNYJHOYpZhr68qMGPxBMNXGZ6gZ7fjnMTS0bdQlo3ojDdw+r3K6b5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:43:36.6269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53906d6f-ed95-48ea-18ac-08df459b7948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999231

On 11/17/2026 8:36 PM, 차준호 wrote:
> [You don't often get email from junho.cha@xcena.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, Nov 17, 2026 at 03:49:39PM -0600, Cheatham, Benjamin wrote:
>> On 11/16/2026 8:59 PM, Junho Cha via B4 Relay wrote:
>>> The task then waits for a write lock while holding the same rwsem for
>>> read, and never makes progress.  Before it hangs, lockdep also reports
>>> a circular dependency: endpoint_unregister_region() takes
>>> cxlrd->regions_lock under cxl_rwsem.dpa, while cxl_add_to_region()
>>> takes cxlrd->regions_lock before both rwsems.
>>
>> I don't think the lockdep dependency is related to this, it's in a completely
>> different code path. That said, it may be fixable by converting the guard() on
>> the cxlrd->regions_lock in cxl_add_to_region() to a scoped_guard().
> 
> Hi Ben,
> 
> Thanks for the review.
> 
> The report does come from this failure path.  The new dependency is
> endpoint_unregister_region() taking regions_lock while
> cxl_memdev_attach_region() still holds both rwsems:
> 
>   -> #0 (&cxlrd->regions_lock){+.+.}-{4:4}:
>          endpoint_unregister_region+0x2a/0x60 [cxl_core]
>          cxl_memdev_attach_region+0x1ca/0x200 [cxl_core]
> 
> It goes away with the fix, and changing cxl_add_to_region() would not
> fix the hang itself.  I'll make that clearer in the changelog.
> 

Sorry I should've been clearer, I meant the circular dependency isn't related
to the hang.

I think I just missed the part at the end of the commit message where you mention the
lockdep warning goes away. That was reader error and looking at it again it's pretty clear.
If you feel the need to do something go ahead, but it's probably fine as-is.

>> I think this could cause an issue if you have multiple type 2 cards in the same region. Imagine this scenario:
> [...]
>> 3. The second card then successfully adds the action and passes back an HPA range attached to a dead region
> 
> Two cards can't share the region here, since nr_targets > 1 is
> rejected.  But the window is real with one card: with a delay added
> before the registration, writing to region0/target0 detached the
> target before the action was registered, and the attach still
> returned the region's range.
> 

I forgot about that restriction, good to see you can still hit that though!

>> Maybe you can get past this by keeping just the cxl_rwsem.dpa lock through the end of the function? I don't
>> know if that's too hacky, but I don't recall seeing the dpa lock taken by anything after endpoint_unregister_region()
>> gets called so it may work.
> 
> Detaching a target doesn't take cxl_rwsem.dpa, so that wouldn't close
> the window, and the unwind would again take regions_lock under it.
> 

Good point, I was thinking about preventing two concurrent type 2 devices racing but that's
not applicable here. Makes sense that it wouldn't work in the case you have above.

Thanks,
Ben

> In v2 I'll register the action under both rwsems as before, with
> devm_add_action(), and run the unwind only after dropping them.
>
