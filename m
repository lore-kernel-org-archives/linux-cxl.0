Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62226ED25;
	Fri, 19 Jun 2026 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884003; cv=fail; b=ikNRjPCxdot3LwrECkZDIwRS18nDksbY7ooG7ZrIKH0Pja5Yn/Wn4TK2OhrRwHtSjFjZxrre52+YDRvu7o+47pG81V9G2QtKSkM+3ZvUE6nZoQLgznRnMacZw1QSlgbX4gogYijloO+fu0mNM1eb1LlPmdBOBkA3WVQ0ubu9CzQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884003; c=relaxed/simple;
	bh=EOGvHK1namSRHCdADdFFMTsHCdNSyqi7Dw0vjLCIhOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eZN7Ts1ut/7Ljyzo4oVZ/NbVrqsAgoY7yQLMzo0yJxQTtlrvxUUqvKTKabyhKOIwDipckprN/vyEahyIllD2cEfqubhIu6IG9dsdNg7CtycnsYP29QfQq94PV8BsEglD1SVeLSGw0NYo1v165Fsa6ymqBj+7I93gjYRe370V5QU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WDSzJFjl; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WDSzJFjl; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WDSzJFjl";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WDSzJFjl"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ONBWp0SniDzlvkn2fBqxNMdKaqNS1w70L7nabtn/97VXspcsDvd9vAe1ClNsm5t8z7DHgCdzgYm7Iq2PSs0xHiGNOEYMzw9U7orTKhPFp9hjYOZ10q5p080cnOkgSAhjBQFNc+LdEs65iEC+YUtKeMhQaXGZlvdci8IYanfhl07bP+QWpFjwY2zEgf3ifPx0vmLfmfblZT2jvf8GYDRGahhqbx0dkteQOIPB2bPSm11Y47vEw0sRCzPus7clSGfQl7rpAd3TFFIuUY++NFpo50kfBGLVYNS6LuI4AppDXZSJ8MXuvun8RTIL5kAKg4xMaBqmFkwgwqhxGOmYmJbqkw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=841ZMsl5VaQKfMKNKGVpc0xGoBXXJZAkN1xQa5sO8Os=;
 b=ydKsy+zVQPs+6pnu6WEAb2lYKGoZZHo+XjWtklNUSynTwdB6NabBAPJggWdyG58sM9pBf8veHnfy+u0S7YYPcBby1o/4RZeozyFgPULz59ct1ktGURwfGHlQ3jFQyYoHF7hVhBZvpun5cRRXgKpNKPZEyRadAOZzz/HDTYOJBOik4uYFOKEiq5Pi9nD2RFi7iQaAC+mdcQvM52APbTtjqUkMJrIeq8KGewXGjjIXdtZd8tcKT2CytwImx/XUFFeJgLDVcx7A4YHJWONMs3E1VxmfO5J4hm8NRhIyjbcXpFPLT5J4nhPEi6giy6doDjSR8mxlN5rOEJNrU9dvDQnQBw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=841ZMsl5VaQKfMKNKGVpc0xGoBXXJZAkN1xQa5sO8Os=;
 b=WDSzJFjlik1pki0GHVszFm8awUys2QFSp6MqiLE4sfJ9gm0BtWLQmHzqitVYjWmR1sb9MDDvn66RNCrFYNM+AltLP/9Xyc29rae1vhCElaCC3+PxiqFD50r9gEh7gticNfunphirR3I/aSykogykG2GK12uWnGUsspetn/7X7uI=
Received: from DUZPR01CA0263.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::11) by AS2PR08MB9200.eurprd08.prod.outlook.com
 (2603:10a6:20b:59f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 15:46:32 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::a3) by DUZPR01CA0263.outlook.office365.com
 (2603:10a6:10:4b9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 15:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Fri, 19 Jun 2026 15:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+S/Ry0WX5XhzuRTIPnh8LkYC1CLauUUrNyCNU9rRJ3tyTqrSA0iwiTeslgx17Ov2nFhDRm83zM2YAxdEDfadQiN+Izpdi8EemfnxZj7epkn17P1XN5FzrbbCIoYjyURDqi3fP0smqG5u+bx/EmPOJwdv+RNVlA/hoPZYmOcn5CTIJUOMqVNoqrULTuKd1HwPBtJZHOMuY+YU12siy5gAwqQ274MwRwmWrWsw3ZDX+MxJFrCqRPF/5boU4N4Kf8HbECUKkA26qEihEOnb6BEE3WNqHfYA1NJqbuQMO5mVSVEBYJQ8KeBZlWCw2FFMDff7R38SSVa3UUstPOgkslucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=841ZMsl5VaQKfMKNKGVpc0xGoBXXJZAkN1xQa5sO8Os=;
 b=jEDCw5DmSKNS8chiFPDFNGcByKwBedmoZa28vDSTUOFQEiDJEMHo6eoSonlUs7gEe/kaXQiBV7igkFp15/v9JPyMrX0ZMBTyAvQb9vNCi+aEeTD5nwhHszrO3oZeKqGJR9ewr7kQJ+RaV8R3LT61aZ19N8I9lilB3ak/CvOGTVJgjTsp24tK6cFHCJmY8q/RnqnwyRTIhcdQ21G1YDYs21iIE0miC+0sb3l/sgCQX0hKPEsqAcayE/1Kwlo5uRzCTVuGvKR2xlEaIRoyclW4Hr55u7KH/FXeWErILteaz6EeXPILZGw9KUi0Np62olMNLfD0ZjN6nexoQktkBDQQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=841ZMsl5VaQKfMKNKGVpc0xGoBXXJZAkN1xQa5sO8Os=;
 b=WDSzJFjlik1pki0GHVszFm8awUys2QFSp6MqiLE4sfJ9gm0BtWLQmHzqitVYjWmR1sb9MDDvn66RNCrFYNM+AltLP/9Xyc29rae1vhCElaCC3+PxiqFD50r9gEh7gticNfunphirR3I/aSykogykG2GK12uWnGUsspetn/7X7uI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by PAXPR08MB6494.eurprd08.prod.outlook.com (2603:10a6:102:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 15:45:29 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 15:45:28 +0000
Message-ID: <81dd6d0d-427f-49ae-9573-fbe84dc2185a@arm.com>
Date: Fri, 19 Jun 2026 16:45:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ACPI: APEI: introduce GHES helper
To: Julian Braha <julianbraha@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-7-91f725174aa0@arm.com>
 <58f7163f-2fce-41e9-bc35-d1d8e6f4a298@gmail.com>
Content-Language: en-GB
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <58f7163f-2fce-41e9-bc35-d1d8e6f4a298@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|PAXPR08MB6494:EE_|DU2PEPF00028D05:EE_|AS2PR08MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: b1026cc8-4cdf-4592-05e3-08dece19ef9d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|22082099003|18002099003|11063799006|56012099006|4143699003|921020;
X-Microsoft-Antispam-Message-Info-Original:
 kORTf5cU4FfN0NG5uoK1/rzigTPFBi6VpsQuwXFixJUIN6C0PxTLt1xLVep1S0ltgIp81rJcHHEQsap1ovgofCuWKpzYkp6zzw8t6sfeY8swZvHJqi9ul/sUcO/VYpsfsuHfihbEQTaW5cUQp8s/FVeQQZKfFRibIg7AxYaJ/VEXcb80njttllDg21WVm4B519rkTBBkj0diVFP2PX97ShFjnW/KXXc6Hy3WreDgZtBF3DvrK1Jkr5tr3GB4O9wtPtyO28rktqgmev0XyUcoB0hGv8SCMZM+pEEdmutPJMkV8DOYG2ZoowDDUjXCJLDS1xv1MKUBmxv5MSPYc+URwQlCd3I4YlwSk6YKpYSgu551luLEyzDt1ttsH9OxO1hgnPk06HH7eZObmqiE2Py4FGwr1kYzbr+iA8dtNJV/0Qzvx2wayZ1xqqvRQCOuqoubXjnpz6dh/jB/qVffHAcJsFVmufWKB4k0OX6O/tWzSot1MaSEsMHZCwpacrf+RyzuSqvYdQ9iObxTVVyPbcQ4ZlfwqpLddyqnE6mAhfpipSkgt2MaSt4ayfiQRo2U+PiHtl6+tq2sj59DznXURkVxq81QykpH2lBjlkZdKk75YeNU0d0pFcZceW3RmaTEt4qKsU/uSWYtxQhqnAIjZwtDCWbYLk4tjdp7WaFNvvUG7cBwbzFaRAhKuzqsm6E0RuguxnvSj5OcWiS1+vWlBFqe6A==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(921020);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 fTP0/fhmWyIp/A2ipPypBLONiSMgNovgtuz9+THXRMxLwo0sA9LYId7t6EUJIOVMaHhHgGaS52/6Iq9vNlcb732WSQX3MivVQP6D/wkZ0qxTig6iOrtpyrT6Bp83A0XJC9kf00Jpl+Ifms6J8WNEJCd0Vhjq8ZK0m6I1uwF1xT1yDJXg4Stx5d7ksRtiRH+1oZ8KqZu3ZJ6DryXwf7Sg41tsdJ59U7t7tyYSx2j3BHQiT/pEkHs757J/uYOgqPvXzZp1FreTZ2f3FhWVQxt88Jwxmj/PoqwOBwhJuEXFe9IDxtaAz4FFGeKeTUHgfvxULHWPR+HIf+rLP2VPFnaxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6494
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1aceb2c5-ba24-47d5-16d5-08dece19c9c8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|14060799003|35042699022|7416014|1800799024|36860700016|4143699003|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xizBAB/VvI8M/LESMm3Jrw1hvWgJ8POYlEnRvxjJ5ucwUQbv+VliM74LdoFX6jSdzdOnT5CS/eBh1XWOvTyl7xZbxPPesLVSGsYCJ+RjXksszqKI8aY1o3HJgNLhkkrb3TO4t5mxt9YharyQ4bZBO591KNKgqOIWPRlwpvM9t0s9B740ikZbNNjFa602wwDYQr1YULEOfhg5tim8WOsCknYxs+LB6UOtEToTeyEmgQax8/1w8gy5M0BE1c6JUoI+sU/vU9d8CZhRbo5rrOboLAoSXFtl3ankmm+rHusBgwlOf9+lHInzcGvup9UjUNXYx2XL+xiLAnxaqgmbtQk7bIc+yi1YONjiax1If9zDEh94VpmxklYRM+9QVjUk9PQ93z1Ztwhb6Am/ZSFxXX/x74qJMxs5DLxV3bDSb4/dKw0xRDp/RyM9UBrS1mOFJECOcTQ6gMdf2yPB6r1lnky548VjzjLCPddEN8NL9eVNt3Q8VIIVB1QBRkHV5x2lKewh7hOjweHcHu6ZKG0+xnPJDgSXX/Yr3iZX0Be28NIE4fAfvZD6upIr+s2HHUPJ4gsyEfqCKs5JCgwrdxWtITCH7Wr+mrYNDEx3f3cg7QSTciui7Ue92h4jee6OhUjG4GvGtJpM0g0Gw8+bymnkVkczTHScmAJkUcW9SM8POGcrthzBlxDgmoKnc/JpJNHPZw1mcK51HdzNANxxOLSFoEYeyyE39zrX9rUoA8RrdOakHkbO/gRFyVcH7g+82jP6wqvi
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(14060799003)(35042699022)(7416014)(1800799024)(36860700016)(4143699003)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hus+jV7kfdQKDx3GH9w/+VgiFcHtExVYiWUE/+DA6FjYFWU37JqyKQc+Jpm5Rn3iYKA2mVgBuV1ilj1SEJbEbAy06TLjanEq6/4oXkBR0Z0jAbb5Illr8SwoRpGYQ1Klf3DrwedrT1A9HkH3VUZQsPEurKWd+uGnPTKUljJ/HT0pILPlZIIhGnmzuI2BNALZ+C2JzKSYREIVSRX6UWm66iZGc3u6kCfkaP3UEcV3hzFwzxl7duJloREpygx59l7bdsu8pcmwKsZAJf7SO9lQAx8tjFwICww+424Qj9jJZ0uPj3wuNOsdsUjFHFLL6pGAE048JZp/9gFHjdoemP6uY4IqFPjIap7u5ciSkXVonc8XCjacT5XO+Fqa+dJRM0dCx9x3kp/iFKMQeqsIT6JaZ6WW02z8ayyvwFQCOrMMTEkFd9GvrnNCf0CS+fxGueTg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 15:46:32.1755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1026cc8-4cdf-4592-05e3-08dece19ef9d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9200

On 17/06/2026 18:17, Julian Braha wrote:
> Hi Ahmed,
> 
> On 6/17/26 14:54, Ahmed Tiba wrote:
> 
>> +config GHES_CPER_HELPERS
>> +	bool
>> +	select UEFI_CPER
> 
> This config option should probably also depend on ACPI (could just move
> it into the if ACPI..endif block), or at least have a comment that
> selector options ensure ACPI is enabled.
> 
> - Julian Braha

GHES_CPER_HELPERS is intended for both the ACPI GHES path and the DT
firmware-first provider, so I do not want to tie it to ACPI.

Best regards,
Ahmed
