Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024A3EF0BC;
	Tue, 19 May 2026 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181419; cv=fail; b=jfnW7UU/Tt9n3nric9zfcqojjKu+mzKY7Q9ZlW3HqXIQ1ar78IFEXhxc8En/U9I6g5AN07NfUI/XGDT7P64w/UnKh2y/e32u/Cdtf3/PQAOgtU24x0mBafYgSacDqr37lVz95P1fjlyP08XLpcU9fjL/WDp9vP2Y1lgoAc+4Ucc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181419; c=relaxed/simple;
	bh=O4Ye7jEWkNHU9EnxlnRELLCfOchjh0x26+FFOgUlfl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=muadXWJ2LtwiJVG3ATtJXkxENFbQpXPYSMCGuz93skHSwvGyEKrC0F2MjqSGzCIykQJ+MCzyXuS5OHVQCe5Cgc3uzKgr5vDVxP1UvMi7nhtgfC1xch67x/ahmw0op3Ede2pEFW3yMbkOOKQRpQgnfSOko6fZoMF+hIPR+ppnL/E=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ltuXLKWx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ltuXLKWx; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ltuXLKWx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ltuXLKWx"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KbcwnRha+zqalpImX9vkCl2XGOgmxo00Tv04XXd21LYlXkJ/voHznZOs2SwdFFXOvuuVvyeD+QMUFrhKvfYpnFLWchxjcWuoy9qyzkoWs4UP/pxJr832FfNHGBxWdQzsVO5fHMUvutZXlVbOKVP0VmaRWgQ3XN98aSrcnVcUM5RFGg07tBa5C50B+Z3Tyow5i/jpdDgJ6/qOQDuxEQLWHf/HfSikX12fDRnrv1ew+ZIA74MoLQmKIsf1gMOjGpQSsOLDoaw62/9ZgCojKB60Zs0fR7VVNOrXjPMAqsrLMyCEOfz0dlSaxXkV8DWbhv3ckUhO7ABYOclBjpwL06C5CA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj5KxujXxqJExzeLk6Rjs4MHS+ALBzegkOb28PBEkjI=;
 b=eb/HykXv8x83cjpdwQiBzz0aDlbBw90opYQS+l0lISBeVtayCoS2jEXxtLY620uvcNknhXQlNs5g1rgHKEbnvNITw95g7gjr9fgxjL4eFgeVpPnqsvcvv6ipyuKIpYotgZwGKNdOmaOk4MVybTWWmqxj6LFoaltEvHIQLNgVogsY311olqXJxxBfEqUiIpBOvR9MlovlaFQ0973+FzOq46iK1gfffDSs4rKuhRLRoZtZEh0gbY3HOEDpVeBm8cuMsp5T8P2N7dkov8SLENdv1ZoMmyQ0ucqGUZYaApxNX4XnHNyfEykGUrg1I37b03gD9eOO50psI3VHiPWMkE2KRg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj5KxujXxqJExzeLk6Rjs4MHS+ALBzegkOb28PBEkjI=;
 b=ltuXLKWxIo5jVU9jsEo5CM1ALDOXLmGAUuf+zU4Q+xUaXSB7axtlJwJ+FFVneiLZedCApbQiTkwPEsFZpSF1mUaLAzMTjb6I0TgxpqNLlBOv//oo2wACucL/qV+FE6ZMB+Osz9l1J57Y6XQxNcZLFdaHke/QF7e0uW2hC9c0I5A=
Received: from CW1P123CA0010.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:293::12)
 by GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 09:03:28 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:400:293:cafe::82) by CW1P123CA0010.outlook.office365.com
 (2603:10a6:400:293::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 09:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Tue, 19 May 2026 09:03:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYhaz53CM3xUu+/jwlp+c6Bulx6n+DMK65tt9iWp8uNLuDMHkqVpa0ISi09mHpoDw4Y70246vg9CtKAu1QEzNzba2kl9k0P8H74v252cvq4NRKP9FKXcPyteh844CCDoDvGde+jeNhFeoGUzaStlutLjlqGuwmydEnQ52GfhXcekwN9E/8MJdlg/8m9ABluWWXd6wy1CQE3etxOo2hChFQ8V7g0iAyb8xre8JdH6ql/VR9j16540dkKmjxSORnqAUhhzQiMDZPgvXfdMEemSIC7G5M5oeM/xeq0NnG7PcXxAiJ4NlmxlhAuk+kxAqNveMvffCopZLloBj+iSYOo1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj5KxujXxqJExzeLk6Rjs4MHS+ALBzegkOb28PBEkjI=;
 b=G9vN3VGXYxe9UcUOC9yYPDohvJ6Q2ILkfw7E+eJuMOIYF253GZGccyZ6OkHRJFnVjInAYgSlnmGrDn52QotPeIS/R7/aXr+Py2lZvo+yVp9UendugtsSACebGNIwj50i2sEf/zrO1q/8ZZuOtiormA2mRMfr+bMgHQWbpoWr04v3M2Tti7BhEtBl1FqU2/bV+JeLmlK6oRZ3N0oWbJwaq2cxe4sAxOLcVeVw9J/S8Zgd6/r4p0O5Cn0HgxXnqI47EB7XAzLsfJw7hjCfk04OB36voAL/Sa+MsEs0VWwDQqr8MiJd5SmfjB6QzNbBx60VkIEskd8oOKC7flopzRLQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj5KxujXxqJExzeLk6Rjs4MHS+ALBzegkOb28PBEkjI=;
 b=ltuXLKWxIo5jVU9jsEo5CM1ALDOXLmGAUuf+zU4Q+xUaXSB7axtlJwJ+FFVneiLZedCApbQiTkwPEsFZpSF1mUaLAzMTjb6I0TgxpqNLlBOv//oo2wACucL/qV+FE6ZMB+Osz9l1J57Y6XQxNcZLFdaHke/QF7e0uW2hC9c0I5A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by DBBPR08MB6106.eurprd08.prod.outlook.com (2603:10a6:10:202::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:02:25 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 09:02:24 +0000
Message-ID: <8bc812fd-cda5-485f-98d2-4901ec17c66f@arm.com>
Date: Tue, 19 May 2026 10:02:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] dt-bindings: firmware: add arm,ras-cper
Content-Language: en-GB
To: Krzysztof Kozlowski <krzk@kernel.org>, rafael@kernel.org, bp@alien8.de,
 saket.dumbre@intel.com, will@kernel.org, xueshuai@linux.alibaba.com,
 mchehab@kernel.org, krzk+dt@kernel.org, dave@stgolabs.net,
 conor+dt@kernel.org, vishal.l.verma@intel.com, jic23@kernel.org,
 corbet@lwn.net, guohanjun@huawei.com, dave.jiang@intel.com,
 catalin.marinas@arm.com, lenb@kernel.org, tony.luck@intel.com,
 skhan@linuxfoundation.org, djbw@kernel.org, alison.schofield@intel.com,
 ira.weiny@intel.com, robh@kernel.org
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
 linux-cxl@vger.kernel.org, Michael.Zhao2@arm.com,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
References: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com>
 <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-9-42698675ba61@arm.com>
 <5fb43b8d-e772-42af-ba78-d75abd87bd0c@kernel.org>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <5fb43b8d-e772-42af-ba78-d75abd87bd0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::14) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|DBBPR08MB6106:EE_|AMS0EPF000001A9:EE_|GV1PR08MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 5649d244-01cc-461f-dd04-08deb5857df5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|11063799006|921020|3023799003|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 ydcQdu/Qoyu8+0kWxRU2FvTo7rpyNtdeD+WEVAC0E6WJtNgOzRGQWiqwYSe22hYul7R+2DO+fAJ1pCM5F2DW7mO/kahEJf8qeVT+G3U+PLiv7A8zTU9+FYDMErazCOOhqqjMCf1r76zGxC4lyNIIxkPGPcSO9sXbwERY0fDLv3HCAu7vu67WXdHv1NiyKVr5JsWo8AUp1yINsB2UoGfcEYuZkgbmvWLU2ODRuj866dK3kkL2aT30V5ElJD61aEnWukyCV28lISW8bfH/wmE4vfL3LSWnJYQe4OdaocDeu3qlbqMyNmI3Dd3F4L7tVi4CkqmVcqca25SfZhw8kiXDWhLh7Ojt5KH1wXtLJ63Q+VXvouDvMGuq8R9Gn651AUQsYHAqC/RzGYABdgcQxG+0m9Lq2PwzKjAh5V+ikHV/0ktU3/v7qb9538RrxdqK1TvQiid18lEcSzGs/Os2XysAE+szyGTxva60NcNFyujchXfyY1gUj0hviZ0aIkHmWS4I1CavHfYyjR46D0+wiqL6aJihXcnyJ+VnFhBwEMIRiyw8PFVL7ibWdp1N9ZcbCvq+RNU4AjVEQAJ59McJRrkI2vvZ64XXNhh5MLDQJNxQuaON97HwrOy1X0jYKQsxDoTn+aZM9D1cQ3TmYSyV6ZeunkTaTs5jRwEkXQVhWAphUA6ITbIPBwlU6fKX3uwKr49H
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(11063799006)(921020)(3023799003)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 cDNgjw8K+wNG21YZUB3uRiXcHMFRp393Ye+QcdYlSyo21iGkckvhnCJ8dlXibh2GJ0OHX6CuyFHI5rKzIq4VigGHg/U5uhHy2+XNvHX370+NryOZSNwfipYCSPnLD8OuBU2ow/UqiP3kJNIyOJgtHU8ThWTkVQ7j8T50/Xa6lZmi0l2Sfqsimn3WOXD5s2aZGCkkCnpl7zLZCPl2MYK+7YhKndOfCaYsFZzddspwwz0BuU5qeSfDQ9oZJPVq7k1Qh7NnoM6Flq5A8F6W272ooMcTEwvM3uoEBgDU6+oj9IVhidL+e4srOLfbaQgeLgyAbukUtKk51KrDlbekIR1RCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6106
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	89954c39-e097-4971-dbb6-08deb585577f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|35042699022|14060799003|7416014|376014|3023799003|4143699003|11063799006|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1ndbh0La1zvWNsLGrWGJ/95H1DL5kppjLmkSo4rwtCy7LO9rZqQXgiD997RB3jmA18xp4VxrDS/RwqxGxFBn/SwTi37+cFFdTP6B2x9iF3w7tNMS3XamVZXhnZQKkXUDb0+D30R0mDiVypyadhFumsreggBibXg/HKK+Ka9WcQ+muE66MSbz7j3kGuO0a1gaftVWNXGhi/5oRP3Ld7wjCHYO99unrDipGnavg7lOJOJ85JsERN8wAph264wFByPITIRgQ13kP7XSLPAwpzI9QClpEk6CZl2mxvv/FR3nh/8etYrVwU45n7q1v/mYYucZSfwxwWrVgA0U/GToXYY6THKuSQ6OwUwFhJ4Tm+BGbBtHRuEM3a3mlCyDONTLezUJiSQ3xjy+C5sm3m+vqV/9uoL5y+n8PUJfDJKEqeL1VVRakZUHGkLGKsTsHKzIqN7e+Nm6+VKnPlV3XpzeoQgIHpQz8gLQgISlCx8wIhfFRFv4DXcTS3accBJLUSapgvsPBgWZZqoGqB5Zw2cNnaNVyQ4cF/ZBu0J2qAsMMJ7ErqyIreWYhIl9/Bs6wz6io2YPeWuppCuoTcKAIKnjfU0UaswlLeyAGUZF5hrkIHAPjsKrMBTTZHxlDe5mamnm5CcT7XH6sPxt9mpaJ7A1UgG3e+61o7GHzg4Xf2NispkQ4dkK8ls7hIt42FxFzORr3EiIn5B8c3rSxyeg53XGCKi6GGxgzMN5d7AqtJkYztkirBI=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(35042699022)(14060799003)(7416014)(376014)(3023799003)(4143699003)(11063799006)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7OtWAaXJeb0wNyp15QLReeztbs67gHznDn+Y287vkZc47ID8VwRBvkVyHyxSMnHAQN02EffKFjfLil7qDWXHdRbHtHtBxa6CX/oBrzCvkMzQNjRXxzFN9cMBsToxAFjzK9q2tN4o+ErKexpsZ5ldOhy8G+65tEdcqROlAIEXiwLxZg04baRaUs36RP4pDemhe7Dv9/DdmtAK3yjGwdc+Dc4uTbvG5Tw+9bmcAx3niJ2D9gnCmTj9ePdzGk50uNYkS6ALhObZCIgKPS9bfl3A6zS7PN3ZgGUvGf5ZdZjVymbp611ApVi9H+LpyvtcPksPNXivaqpSJjyX9dujG+78iwefFQ+5ufQzt9lDlzU9Hen9Y6/SeEPrBRGO9p2IstZkIZVpj/qItXYTRv4PstpPq66lilNMl/TIwMfW8E0BJeGLhX5tZ5kHwOWYO8F7N8or
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:03:28.0842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5649d244-01cc-461f-dd04-08deb5857df5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8426

On 19/05/2026 08:04, Krzysztof Kozlowski wrote:
> On 18/05/2026 13:57, Ahmed Tiba wrote:
>> Describe the DeviceTree node that exposes the Arm firmware-first
>> CPER provider and hook the file into MAINTAINERS so the
>> binding has an owner.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> 
> Please implement previous comments.

Could you please clarify which previous DT comments you still see
as unaddressed?

My understanding was that I had addressed the earlier points on the YAML
description formatting, the `memory-region` description text, and the
example. If I missed a specific item beyond the one below, please point 
me to it.

> 
>> ---
>>   .../devicetree/bindings/firmware/arm,ras-cper.yaml | 71 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  5 ++
>>   2 files changed, 76 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
>> new file mode 100644
>> index 000000000000..81dc37390af5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
>> @@ -0,0 +1,71 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/firmware/arm,ras-cper.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Arm RAS CPER provider
>> +
>> +maintainers:
>> +  - Ahmed Tiba <ahmed.tiba@arm.com>
>> +
>> +description:
>> +  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
>> +  a firmware-first CPER error source directly via DeviceTree. Firmware
>> +  provides the CPER Generic Error Status block and notifies the OS through
>> +  an interrupt.
>> +
>> +properties:
>> +  compatible:
>> +    const: arm,ras-cper
>> +
>> +  memory-region:
>> +    oneOf:
>> +      - items:
>> +          - description:
>> +              CPER Generic Error Status block exposed by firmware
>> +      - items:
>> +          - description:
>> +              CPER Generic Error Status block exposed by firmware.
> 
> Also, this is just a list with minItems. No need for oneOf.
> 
Understood, I will drop the oneOf and use a plain list with minItems


Best regards,
Ahmed

