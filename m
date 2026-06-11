Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8835AC33;
	Thu, 11 Jun 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181855; cv=fail; b=n1NTr11hO02r1spIlRpJVvJugjc9nbP4urrquXEdwyO1AHYttrhXhCzTHPqCqonxF8tY0gZokmLHGPfS4wMv8gTVQYjRGQLhlwHlz2eQvTwH+LLCTq9KElthATTTPvzI3bXnxrNxUo+rYkp7+BAvQBEjsCQUSaBJ+6eOWXAh8dc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181855; c=relaxed/simple;
	bh=EYZsP7iBxWFTl7K1KvX0pD7T7NLikWBzK/cTtT9UVKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vCCYCQkqjKnCIudCuyGGhDFw8Ui8zvGrEGsKf9eGdxcoOFVRVUlRqbY5iAoicoOY11TDCl4qTYT+3oTE9cIHV+7gkK1Mt4S34iFexWu00MULMbavpKnIP10NzX7W7n8XFw99BMh5Xy4XomeAOawdX0x4IZW1Xr0lZ8SqeeBBG3s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TDXtJhLy; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TDXtJhLy; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TDXtJhLy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TDXtJhLy"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JSuosJXWsqIi7e5bleHdB/EO6ywfhTg7ktNzENURwTgcJq6M5qvtNBqa1Ve4kx0YatRgdwylnpsABluvq8s4z1HuKuLJSj2KmoDbBx2rjpJHBcejDTVNW4d7I4zL1zKMJHjjSGcWZ/a/rLyoR1/c/KtW1pCV8TScSa1nQ5jppBmtV1spVpfLVM49cU3DbSqG7rsXfr1FlKUMGLX/DACEZ/eZVrqj45SHzQ69fDeyKlX7bYkjajvEg8aMHBNgyKPv8f8JxDb/dYgyAh5jZi93eQ66O5YxeLcPHBePq04u3glNTel6GyNltnBvPLldggX9e0fey6w/acu6L864Mw2yPQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywsnunz5O4sx7NPH+J2HUpV+L5yYIn3iyeiVua0NrOQ=;
 b=dGIbbe/oEhdhlWz6WGB5YA0s5Sf5ui+lmR6aiZoukXV/MbFd8Pzd6yid2ieG9lZNxeXAX+ie730+PHONHXmIkNkShZglx/s8TfKBgNj4S3MtQLs4JAHaNZ6ips1X542RzbIDGOUmVEeABbvXu0QtgAxu2tO6OK91GiRBqpIfgatgx1bjAPh+Cde+tFqyDg/q8aeamcqoDYBLs5nNLzHVLPqcSB6SIXrDKGChikkre6lrJMyTtOoF+dAxMlu5KZn9/y/Z3gojAHJ+RsSjBGPqI1aw2X9U0SIs+YCGVCPZLq3V3l2M8qD+bEK9giwuj0tRW4eSdkiwL/mXgklhR8jsQA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywsnunz5O4sx7NPH+J2HUpV+L5yYIn3iyeiVua0NrOQ=;
 b=TDXtJhLyVpF5izBjVtouGQUmlcrwmB8GIj03PjXhm+wg5cnL+o6On4My4uYBUFFz4kUApvRLXjJrI+ofgp6XJb+SzR2kng/9xjjZF+c0nMzbFNhhf803/e5c/Lu4dbyA7O/PjyjHX1Zi9EJZP4qt2Teq9p/7SMBlqBi7AveU0yI=
Received: from DUZP191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::16)
 by VI0PR08MB11668.eurprd08.prod.outlook.com (2603:10a6:800:30c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Thu, 11 Jun
 2026 12:44:04 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::7a) by DUZP191CA0006.outlook.office365.com
 (2603:10a6:10:4f9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 12:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 12:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzXoOB6N5XaQUkllNRYEINF1eYYg1NDF19GC3UYyItqgn+BBxsKrTxSIpVnCHsF3UMxHXGHfMj+wF5TyKmPuIgutbfMeQXrtK3VPthTDsHF7WYDluVerVcJXMNBnK9h9JbsG8WuDpj7Rh/WkYJjLwAkUX9QCRDj8dmqaJh3javWb/C3TEWGJQiG35VRrwLkyqHrowVaIB01pfnd2DfwDOrgUxwxJuhXd1kJ1OKRm3VzwY8jfhfjGVxNhTlE7jiLSNZosNSCM8tYKk6RSYMPtHwpUjR7OyI6EygfzvSpgK4BYRhvn5VxECLekRMeDz9Bz2HnWsOGcU9D+Sb+Fy4RUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywsnunz5O4sx7NPH+J2HUpV+L5yYIn3iyeiVua0NrOQ=;
 b=bToh8ihN3yWJFx4gh9MFcCN/LmbGLRXR8Mjfhs/9CW/D9Qy+XAfvwb5sZziQ2XgGg89HSoFYP8dz/VonGTgKo3xzUFqpoU5RByrFjo8pkxMFqyIlt9JqEH0QqN1sSQ0EvAot98ZfUDJFl+adzsI7+j8x9ndjm7OnpOIeaa9fEyRPBMB7RBh6zrbtcNeL63TmcUNgF4beLlMjhvXEnhop+QYjtMOVlrYrfa1AHJe7823sey3TReAwKg16i9XbdapFcZ/5kgJMLyL4iLA9RkJFvI31NYIgkrZMubjLf3WqryiV5/R1d5OvWsQpaO7M5TPwR2aqj4IrMRpQxPguCg4hLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywsnunz5O4sx7NPH+J2HUpV+L5yYIn3iyeiVua0NrOQ=;
 b=TDXtJhLyVpF5izBjVtouGQUmlcrwmB8GIj03PjXhm+wg5cnL+o6On4My4uYBUFFz4kUApvRLXjJrI+ofgp6XJb+SzR2kng/9xjjZF+c0nMzbFNhhf803/e5c/Lu4dbyA7O/PjyjHX1Zi9EJZP4qt2Teq9p/7SMBlqBi7AveU0yI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MRWPR08MB11806.eurprd08.prod.outlook.com (2603:10a6:501:9a::22)
 by AS4PR08MB8024.eurprd08.prod.outlook.com (2603:10a6:20b:587::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 12:42:56 +0000
Received: from MRWPR08MB11806.eurprd08.prod.outlook.com
 ([fe80::20ea:c85e:c8c9:a8d4]) by MRWPR08MB11806.eurprd08.prod.outlook.com
 ([fe80::20ea:c85e:c8c9:a8d4%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 12:42:56 +0000
Message-ID: <84b929cd-f726-4422-9b1a-1f0edf68e163@arm.com>
Date: Thu, 11 Jun 2026 13:42:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] ACPI: APEI: share GHES CPER helpers
Content-Language: en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, saket.dumbre@intel.com,
 mchehab@kernel.org, dave@stgolabs.net, djbw@kernel.org, bp@alien8.de,
 tony.luck@intel.com, guohanjun@huawei.com, lenb@kernel.org,
 skhan@linuxfoundation.org, vishal.l.verma@intel.com, rafael@kernel.org,
 corbet@lwn.net, ira.weiny@intel.com, dave.jiang@intel.com,
 krzk+dt@kernel.org, robh@kernel.org, catalin.marinas@arm.com,
 alison.schofield@intel.com, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Michael.Zhao2@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dmitry.Lamerov@arm.com,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
 <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-8-2e0500d42642@arm.com>
 <20260529173229.18843384@jic23-huawei>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260529173229.18843384@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::11) To MRWPR08MB11806.eurprd08.prod.outlook.com
 (2603:10a6:501:9a::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	MRWPR08MB11806:EE_|AS4PR08MB8024:EE_|DB1PEPF000509F6:EE_|VI0PR08MB11668:EE_
X-MS-Office365-Filtering-Correlation-Id: 61007ce0-fc7c-47ec-94e9-08dec7b71ea5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 YwTWCEDhAXizuvd4NNmTgkcCv+/TYRlFg54Xa1yk0vNtO+l7uivMsnhmQ+NFp7vJjHizVb+oBmkV7/z8mWsREPk+S9p8ibr8ect7HW7+7576tiuEThdKUiKVkpQZ9T5kZT8pYUy2LV0MHSm9IviNSH0k36oP/gJT0O9NrTxEA19DV059L0X7QuMb47UVCion1nLB6NRELrOdpC0whYfYVbRl7vFw6PdMAwy6qQNwkHnPe+GqlRHx4QGVW7J4Ho3e7Gqs6H8kuTwi067qtOmKQp8vv3wIBZpLLDhK10ofBPu9hcI6eutqGyky+Q2Cx+IbavqVtY7V4N5fasqIo0PpwBJ9o9mj56RcqYdozRkQx85414BEXgetMCj1OBiP91Er3N0A1cZzrUsgQCSnj+79FAPv+//Jcr8kWgvl8djxg6ge8JnGHNl4MdyF2K+V4kh7beYckqBB/PU8TU3LVPofPsgtTL9yvU5AiEaDlvOrElQsICn4TA3vvm3tU892DS3AXTrNJHyEehLz0LBK5rh1a0CrlfV4e3Y9q9qbZYEUOE+kMKvRSrm3bY4TZvHqMbqQ7FjQylQp5Vmbpr0aN2nuCNIuw+cXLhKTRMmIfQ7a60pqElBLiY9Vijj3+xZzbURRCGZ3wTjt4zCH0sGds3NCQyV+hf6QqFv8mji031rQNyk8CyVYJMwXzqwqlOh70wvn
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR08MB11806.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Jgh3s5cMsIMk12FJzs0jUj2ogbXRritogNb627O0rjxwIp1/3hUXFukYZSycs8Qs1u0tFmYwMuUT/4lXz2szCiLQGsdRn2h9pKI2CZf7Q1huEXpI4jj7DY7DHrQaS3jKqByLxH7YDbgSaHV81zl0rgvXBn4LmC/+nGHuRMWQPMPaO6DVgPcAPVLSm6Hdn1A8eT/ybLCB90G0KmmGRCiHCdoEoe3+oX/nhViMzD7Il81Ic8r1ZDd+WcWEPSzFhNUnwmwztVSW5Mn25pp+WEkVniQs/7GCmNhF1x6/KRWbuux1TfPfpzOvGcZ8Nt3gooZqY05CkagF2jh/AptfCfJRdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8024
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8807fba9-b2c3-405d-ff6c-08dec7b6f5f5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|36860700016|7416014|14060799003|82310400026|23010399003|1800799024|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w5EVhT1YexDFpFb1NcgPH/vbyqVb9YsfDfjIq6LXOYfBjv/K0oNbzWa32G5ndYqBIV0y8sb7KDGQ6yKO32CHWa5TK0d5990Ik96twMlQYhPVbRJjD9jQbmJO5LN2RFMKrYW8DENw2bSQjcadxTbV7eRdA3jkWpcJUphbbw2S6hM8teFp/nIVOnqjk3NfC1/Gzn6uZ7bAcApWefyg5kELN09SGlmcVbo/3ti+1cLJZMsn8CzWm6Vc/GIFPdwzjq5q7jtVvWeF+8ZLxymX5I4KHvhHyAklqC/3DbwDbNyzj7WFqVZg35vBV7Mg76OcjTM59VwnOSF826NDkwNFnj6x+MW9GjV5vn5cBkBETgp/h8Ddigu5VDFzST6b09qvyMkY2crkju2sz3f4DBW3QMkY8aEyXPl9mUSCTovdZM8+nr2txBET5lOYEXEfkW0y0vT2ERh4VYWZlDWAoAzTwQQn9HePQ63abQ5NKkfQhvCz9Fe85autWK6el9xqYgkDoxEwE/HTvjHfX+pSIxljXOHmdtSTGLUHunOqiwoGw57pera+2+kWfUBZPW1hFJVYd5xP03fA2mAdnFx6kWwyKEBS9kOCZHF9X6R+GPSzVjPfOHgK8tyhGf5qkJ51/kzuecuAI3Yt/rxxhMjvTyMcOSvJT7mrsg5sbER/29QQyW9oDPxUovR3lMQvdPA/vCQ+EO1SAmk4GMlVw9MtRtUAweFEYHBJ0EE+heITd1KO2/VxvxE=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(36860700016)(7416014)(14060799003)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WKbZOjkcCARuhbiICuw9OKPyURxsLU7PJcQ3tp2Zu4BzZ+Ia9CWlCrHwuGu9hnVnjNJz2YKGwcBOBRn2z23bA1sQ6CqE2mTVPK0o53kRDfl7l6Ad02p20EDQGr4EOcdSNhQdhKaBNhPlpRDmU0YtrJY8WmacfU8fvPhxs4ZKU47utJod6kB043NnKjfrH6pppafbCWR0i/qA9LWnGlQaBgw3POqQJdjPCzWJmLOgVwkcp9LUdy0GVFSd45KxIEW+BkYbf0xpcI+sMeLGtQ9YNjEHGcRjz0y7lowH7XUztYraWtDNbFjzlYVPv0gTmETyeX0N7pAm8qJS8oGXFIRSMH9yM1OFL3Nxg11dXxCanq1+1N033wYjpl7vDHPVxmJ3l3r+GDNcZQK3P7TwrfSGhovb6MQ8Lp1o34HTy4Xd8nyAHLg30aTHps2jF8F5Wn03
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:44:03.9088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61007ce0-fc7c-47ec-94e9-08dec7b71ea5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11668

On 29/05/2026 17:32, Jonathan Cameron wrote:
> On Fri, 29 May 2026 10:50:48 +0100
> Ahmed Tiba <ahmed.tiba@arm.com> wrote:
> 
>> Wire GHES up to the helper routines in ghes_cper.c and remove the local
>> copies from ghes.c. This keeps the control flow identical while letting
>> the helpers be shared with other firmware-first providers.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> Mostly looks fine.  The one bit that rather makes this exercise of breaking
> out generic code look dodgy is the ifdefs in the generic file.
> 

As below.

> 
>> ---
>>   drivers/acpi/apei/ghes.c      | 416 +--------------------------------------
>>   drivers/acpi/apei/ghes_cper.c | 438 +++++++++++++++++++++++++++++++++++++++++-
>>   include/acpi/ghes_cper.h      |  20 ++
>>   3 files changed, 459 insertions(+), 415 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 85be2ebf4d3e..f85b97c4db4c 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
> 
>>   
>>   static void __ghes_panic(struct ghes *ghes,
>> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
>> index d7a666a163c3..0ff9d06eb78f 100644
>> --- a/drivers/acpi/apei/ghes_cper.c
>> +++ b/drivers/acpi/apei/ghes_cper.c
>> @@ -13,22 +13,32 @@
> 
>>   
>>   #include "apei-internal.h"
>>   
>> +ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
>> +
>> +#ifndef CONFIG_ACPI_APEI
>> +void __weak arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err) { }
>> +#endif
> This is non obvious enough that the reasoning for a new weak function should be mentioned in
> the patch description.  Why not stub it in include/acpi/apei.h?
> 

Agreed. I should have explained that in the changelog.

The weak arch_apei_report_mem_error() fallback was only meant to keep
the shared helper buildable when GHES_CPER_HELPERS is enabled without
ACPI_APEI, while preserving the current GHES behaviour when ACPI_APEI
is enabled.

I kept it local because this fallback is only needed by this helper 
split and I did not want to widen the APEI header API for that.

>> +
>>   static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>>   static atomic_t ghes_estatus_cache_alloced;
> 
>> +void __ghes_print_estatus(const char *pfx,
>> +			  const struct acpi_hest_generic *generic,
>> +			  const struct acpi_hest_generic_status *estatus)
>> +{
>> +	static atomic_t seqno;
>> +	unsigned int curr_seqno;
>> +	char pfx_seq[64];
>> +
>> +	if (!pfx) {
>> +		if (ghes_severity(estatus->error_severity) <=
>> +		    GHES_SEV_CORRECTED)
>> +			pfx = KERN_WARNING;
>> +		else
>> +			pfx = KERN_ERR;
>> +	}
>> +	curr_seqno = atomic_inc_return(&seqno);
>> +	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
>> +	printk("%sHardware error from APEI Generic Hardware Error Source: %d\n",
>> +	       pfx_seq, generic->header.source_id);
>> +	cper_estatus_print(pfx_seq, estatus);
>> +}
>> +
>> +int ghes_print_estatus(const char *pfx,
>> +		       const struct acpi_hest_generic *generic,
>> +		       const struct acpi_hest_generic_status *estatus)
>> +{
>> +	/* Not more than 2 messages every 5 seconds */
>> +	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5 * HZ, 2);
>> +	static DEFINE_RATELIMIT_STATE(ratelimit_uncorrected, 5 * HZ, 2);
>> +	struct ratelimit_state *ratelimit;
>> +
>> +	if (ghes_severity(estatus->error_severity) <= GHES_SEV_CORRECTED)
>> +		ratelimit = &ratelimit_corrected;
>> +	else
>> +		ratelimit = &ratelimit_uncorrected;
>> +	if (__ratelimit(ratelimit)) {
>> +		__ghes_print_estatus(pfx, generic, estatus);
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_ACPI_APEI
> 
> So after the effort to break the the generic stuff we end up with non generic
> bits in the broken out file?  Is there no way to avoid this?
> 
The intent here was not to create a new generic estatus core
but to keep the existing GHES control flow and lift the CPER helper flow
for reuse by the DT provider.

Splitting the remaining ACPI GHES specific read/clear path back out into
ghes.c would break that flow across files again. The CONFIG_ACPI_APEI
guard keeps that ACPI specific piece local while the DT side reuses the
same CPER parsing and status-dispatch path.

Best regards,
Ahmed
