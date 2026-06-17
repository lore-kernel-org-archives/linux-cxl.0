Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0F380FDE;
	Wed, 17 Jun 2026 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703787; cv=fail; b=RmuX/8JKwOsCSZpEhyK4fGNUka3BzCPTqWctq6Himov25zdlSBQQ+Fu6Emdw3YhL8372XaSHXVShhG+LCJvdk2pl1Nf9SKKM68bGwUWvxu3Zwm1ZN2YpWkTNE3yF0qptW0AROD8JJRA2xu1zSnGMl4NjqZM82qFqVA3I5CUfens=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703787; c=relaxed/simple;
	bh=bKJqmB8T9NUFI2ZCmFoZtk4bGEdKE0pWELaOk76jYIQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CIZb4JDuymCi7EIKzBCxLf3r2f014Z/W/B4Ph5F4UR9tI3Zp7kDlgfC3KMXB7zQTiKPuuHCIqolvwsm6Y5E30OwAv49jQqZSzUQ4GnYn/g1yFmB4Pmo3X/ug98Rc0exA4nsjreCXxHiVZefh+8/Z9jt/+YVEZGBDeuqTM07DLtk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K56XyMku; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K56XyMku; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K56XyMku";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K56XyMku"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SVzzBXkvvSYb4VCmNI6gGYlLAiyH09KMpYe2C/o58lhLy2DrjpkT+CDySa3BMy/JjSuizcTXJwqCsOP3/40AOkum9jvSrGO1Ysd79Ng0uRAiIsMa7Hh8DdM3ENUUfHagzXtBMLfQfHQjoT0SV60iVsB7u+uSAaimbnOUmoix2vnY2lunAiY39c5sjIAn6cXuJ5A8PH9Mcs2ZX415mS7exT6tq6tYGp03k1KAbFdaa+Vt1xS+Yx4Z2aAGvS9V3yR/BsPKz0NPRCSxUUX86NU51E7XHM/qZW7D98HgN00LDN/crrdTppmygGCOCLeRk10Evh8EPNi0Xy5/TZVWmhBmxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAPVz2C6xbautcVWwtApKAUZmIdNdR2PVzeZ91Oyg2c=;
 b=d/5WjW1eLNYWsqQ+1qU+BAQHY/DXcHuH9VvJ/nBeZ+GoXXM2iUNuJq9uOAWH3Mgs/3cleK2TMAiMaCBvY2NQcDoAP/biC/ZekjOmkXGVz0Qo6oz1y4dix5LmrcV1r41ceMYxyEcPdLuGhvMWaSoyy0Ar3RLwgqxRRifyklSsZmV3K3QjwJNSi5PDOWdsd+ej5TMCtv7UQVVjp5k1KPF5PEznTxhz2JW6j2aJ74sLTwF1l7YIrVtudNxOwFiPc2oxpwRM7lDkQzqfD7jH32dRtOYNJ/3592noCjzLqZHfZQt4AyRKv6r+kQtX5xTeldPVd9mTsaDX7ReC6w+UxVrfxQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAPVz2C6xbautcVWwtApKAUZmIdNdR2PVzeZ91Oyg2c=;
 b=K56XyMkud3p2BoVa9b7USj7PtIVM3IfxhkI7K7RqB1eLZktZq+2iFguhJX0ulRWgHuA7m6VAFrIRJcqTEruoaPnxH76bcJWfPxSCaYTm5ggteyc4J3ZeLj5Wlscl5eLFbstWBPhscbaPvVXl6CkgmF1/G7R+duHc9wIa3zyJJPE=
Received: from AS4P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::10)
 by AS2PR08MB9869.eurprd08.prod.outlook.com (2603:10a6:20b:596::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 13:42:59 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::57) by AS4P192CA0015.outlook.office365.com
 (2603:10a6:20b:5da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 13:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Wed, 17 Jun 2026 13:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd1VzqKtXlXh2wqE6LTQTGYP8jaU0mJlo3OFxmxt3ugMXvDbdfC4pXoJuvNc0QxxrqF9w/rwCaTl1vQeqpcDBsQK4TIGFOIY2rivvFuIxoj6LXmkriRLyvS0KTlLsuBsvTuf78C+RkqShyqPTOxNJP5i3x73Md0+phnrUEYg26ylDaX/7WYhEbYnf74dbfnBdzxLJfNg16hGd91JUOMvHcKwln020PRhsAs9l2QzXrqPZ7B6L5B3KDa+X5yKGff6xtI4RFaPsdX87J2agtPUWoKH+3i0RVvo5NEJgyxDTn8e6BQLEUZbf1TBWRUOIt2LUcsxMvMHetbmGy0uZEJ3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAPVz2C6xbautcVWwtApKAUZmIdNdR2PVzeZ91Oyg2c=;
 b=VDjHjNiiz9Rl81ZduCmoBsENpBEEn/+VKGdLtVxx467xNc5jE27hbBC7hs7mGm4157Oja4gYkkA2kPQhEEDgOIyCm9IGJcoJgKWjj/Mt1qY5A1IKJHhvHBTJR0zqsumxiJzHiUSn9TbkvW1z8qAZj4rk4xeQb+/K40wCqSTviZhEhs9+xa7/ssum3xtp0wKg2bzc2N1vW2KpHmCFQXRTfdun+IpDkzmoomgXlFokEkVmoPXxjSZlO5y1xIuz9TKmYTllatbHl7J4URCsFXy2Z5PPFWHRc6HuxUmGC6ownf95TOmYQu1HfnPpOJh+Fi6mJD1JHI0er2tzFXflOcG/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAPVz2C6xbautcVWwtApKAUZmIdNdR2PVzeZ91Oyg2c=;
 b=K56XyMkud3p2BoVa9b7USj7PtIVM3IfxhkI7K7RqB1eLZktZq+2iFguhJX0ulRWgHuA7m6VAFrIRJcqTEruoaPnxH76bcJWfPxSCaYTm5ggteyc4J3ZeLj5Wlscl5eLFbstWBPhscbaPvVXl6CkgmF1/G7R+duHc9wIa3zyJJPE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by DBBPR08MB10461.eurprd08.prod.outlook.com (2603:10a6:10:535::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 13:41:54 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 13:41:54 +0000
Message-ID: <d480a8f7-fc0d-4c23-be7d-4ea253d3c264@arm.com>
Date: Wed, 17 Jun 2026 14:41:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] dt-bindings: firmware: add arm,ras-cper
Content-Language: en-GB
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, will@kernel.org,
 xueshuai@linux.alibaba.com, saket.dumbre@intel.com, mchehab@kernel.org,
 dave@stgolabs.net, djbw@kernel.org, bp@alien8.de, tony.luck@intel.com,
 guohanjun@huawei.com, lenb@kernel.org, skhan@linuxfoundation.org,
 vishal.l.verma@intel.com, rafael@kernel.org, corbet@lwn.net,
 ira.weiny@intel.com, dave.jiang@intel.com, krzk+dt@kernel.org,
 catalin.marinas@arm.com, alison.schofield@intel.com, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Michael.Zhao2@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dmitry.Lamerov@arm.com,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
 <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-9-2e0500d42642@arm.com>
 <20260529174407.7081ad0b@jic23-huawei>
 <ceb19cb6-7083-44ad-a262-a8198f489257@arm.com>
 <20260612144910.GA989816-robh@kernel.org>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260612144910.GA989816-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::14) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|DBBPR08MB10461:EE_|AM4PEPF00027A5E:EE_|AS2PR08MB9869:EE_
X-MS-Office365-Filtering-Correlation-Id: 354bee06-ed7b-432c-ec76-08decc765829
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|11063799006|4143699003|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 8BmtT9CM/INxoqfZut3HPsJ1y3cEbDxQQHpSJHLcKQbmKWdfWUZYJWO4WxPoaVPcbH+UUBsKv/pYrYwrTvK5s1ZDdkUrN7Vmo1Obc0WTcF0VDxbrSyXfJ/Y3fYoO3vNXAl9p5gv1WNN/eCn3KloUazzth+QFsTgQXU9FPP3rWSOwPex8tIvepj+CyKChqq5fUGyc88rRVa3ILJXHBiygNiRae+Pj8skwNXjfn/fCfJn7oJkOUnNDd/DSbKouQO76Hg18cWL2pVk6kbwNN5M+KgZgwqvSfcib0oRdM1bjbDE8dRCimF1HdNi5X+wSCYUr21WYFdBMyRFLQY3dM2nJZAZOfgJKPgH/4jf8dEm+CL4Qpol7J3DrRGOAvNxgtabgapOMPb16NfPPMKkq/1rTSYZt6jnt+SUGp3tkHi+/fQsqkqZBotS/K0994TswFpwl2sRX4fUm/tF+Xy8sg6v4H+EPb3E7vTAUx0T8dwKHkVhAHv0QsfRvY3OMBQmBnrGz5O+bMu663v+8lBOYnuC1REZkeXi/WrxyDEzEfAfI9acxQSNujChOH7igm1HcOwZvoWKnucHBKPCVWd/bOZ3MdhCAvMfohr3sJ8uov5m8IIhXezJozmp5nkHwwIHWtojs7Wso4Y/43Mq9ytK+ICDaAQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(11063799006)(4143699003)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 YDs/QWyeRobGoiG4QE6tTT/j7XJr2HoCwacYaXauglRf6kIC38R0tT22VFcHfxiD0GCHdnOf6M1aTVbxq+9y/eJ/gGzis2C13kmsY4c0HijzQ++426fTFZCfOk7/rJtoVASdvkolpPL/7/RYcbOkEgkGY2Dn+YZPaaLvRKGdByrilS7W+OiM5KzMhlTMILpwTFn5VS9pw1auKbFq6r3DQGWldiq7yny9ECqYDyxJlCsZFdQvr9WRoLfw21rGqATYEjTvMmUEAzNYrMmFYOBoeHKFDCvXEluvzqvCdCa3pwpRk5b5k4mjwwdLC+x10FcJUfxAjYuhZuRRFH0LsWs3kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10461
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e980248d-db3b-4d38-c911-08decc763164
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|14060799003|23010399003|82310400026|35042699022|1800799024|18002099003|13003099007|22082099003|11063799006|4143699003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	7JhvKMFcW6BAlcbhcEZ2hjJTCH4LKzjLY2qoE76zp7vRkOXmrqYkR4QnHRUlJzvL/Acb3OElhOaERm2iPIEZdG+3GiAWJOnbjw5x1Pll0HslKEODtfhxx+UMOPbDMvicLY5o2a9L9q+Jz3Ys1YxREmg/WSaFkgKcySvkV/UEeZaBOQYoO8Zl2kgiAz1STfgIu3Rbymhq6uctcYjvSqj4994b9ss24NiJhSxIWrlPAhY5LaTc3BZwibSfYPsBw3CInJgZhSCdPSQAsyZfCiGHpt0EZ/XikoUUdQxd0Dp4fpTTpisuxPmVqyKbVJw4V4KfAps3jMP5dAYvEU+0Ah6hnPbOKDFExifO8D3aAiqEgFF8Xc9Df3dSKad1O6UVrkHSuycz++3/xiqV8d7VYYsqyx30Ot8mPkRMAmQLuI5XkhGmoU7jmRLqkF/ieQNfIfrVjgcUG//QbGwCM+H4paK3zMj35IA4OSvuZscrGpZYWh9x+ys59YWW8PzSNw5ewF3M4VPrd4rdehCMMSAluj+Iz2vPR7UOD3z4XBJebFQaDtiP7FSUPwC1GcQ6AR2MtnaZepgdaAzuzNy+wG6hlUZTTF3oVUPUUjj8fR21DO0kt9LunBmwnpkZesf0GqIYX2kZXJxz1iPBjvan4lppiHkVLxUopoWunENjtftry3IEPBHOoSxhW5AXTi9KrFIhrnEW
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(14060799003)(23010399003)(82310400026)(35042699022)(1800799024)(18002099003)(13003099007)(22082099003)(11063799006)(4143699003)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qdq5L9BMc15S8QUc5mLdwhtfA1Mpthke7JFjHkPlTDwasFAoMxv5k6nf5KUuVnnE7FKA7Wrd6iFndHmcFYsR63S/uwdE48voDfc4EOx4dpDqgQOqxwzIll/Wv5tH6E0a3YkL6LXP0HX2S1xccwnnzG5rGWyK5V/DuVbFzm8T6MS/WBswG0Qb5A6AoGUqbS5UWmYbb0Nx33w+W7LsOZJfYHFqIR1eTiNB1Ioo2/9ACq659Wr7lm+COLMykcfoVVS+JuR3TEgGKRw5CS9MNlS0nSna/XMlbATzJOr8jJ4jkvOijww+WTEU7qYEICCv7lKZ3oMPcpRkAMh5Ft1+F7Srb8jKzRdJzpsWzg+esQCRF2Sg5x9nWLEnv441ycwyDPqs26+83Sc/h/+yz9Xl3LXdl9HE+hVgsm5yV6PM9Y1vzdAX1YWoP2pY49o6fcV91p48
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:42:58.9596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354bee06-ed7b-432c-ec76-08decc765829
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9869

On 12/06/2026 15:49, Rob Herring wrote:
> On Thu, Jun 11, 2026 at 03:22:21PM +0100, Ahmed Tiba wrote:
>> On 29/05/2026 17:44, Jonathan Cameron wrote:
>>> On Fri, 29 May 2026 10:50:49 +0100
>>> Ahmed Tiba<ahmed.tiba@arm.com> wrote:
>>>>    .../devicetree/bindings/firmware/arm,ras-cper.yaml | 54 ++++++++++++++++++++++
>>>>    MAINTAINERS                                        |  5 ++
>>>>    2 files changed, 59 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
>>>> new file mode 100644
>>>> index 000000000000..3d4de096093f
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
>>>> @@ -0,0 +1,54 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id:http://devicetree.org/schemas/firmware/arm,ras-cper.yaml#
>>>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Arm RAS CPER provider
>>>> +
>>>> +maintainers:
>>>> +  - Ahmed Tiba<ahmed.tiba@arm.com>
>>>> +
>>>> +description:
>>>> +  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
>>>> +  a firmware-first CPER error source directly via DeviceTree. Firmware
>>>> +  provides the CPER Generic Error Status block and notifies the OS through
>>>> +  an interrupt.
>>> I'd like some spec references in here if possible.
>> I can add a reference to the UEFI CPER specification for the Generic
>> Error Status record format.
>>
>> For the firmware-first DT description itself I do not have a more specific
>> public reference to cite.
> 
> Is there a platform actually using this with DT (FVP doesn't really
> count)?
> 
> Rob

Yes. The initial intended user is the upstream zena-css platform,
with validation so far on FVP.

I will note that in the next revision commit message and cover letter.

Best regards,
Ahmed
