Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B7292B4B;
	Thu, 25 Jun 2026 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393252; cv=fail; b=k0Jl8W5d8nvFpg1v8cPH3Cj4FG9cLzOVdN+Ej8AmByZ7OD09Fn2KJJ2Xegs+RltPzsuoqXzF7P2g6jZ3V5x6Q8ERypjiwmP5cEu7xauJ0D3wjRiN/minW5XU+DArZ1H11X19kvCy/6gxyGIawznWiEX5XnfB8BYbGMD9OC0uugg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393252; c=relaxed/simple;
	bh=Qwd64o9zizXLsl4SavaaUzMFsOJwI28g8R581DFp91Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bcq37IX2/2sikxOVac2WOBcjYDIUBxBRNFhQ0wyCcPs4aA7diVDCOeoIZMIMI50Dea2z+d7a59T0j6atOvnnUE148YwWAQNxzb45zQHjxMQ4dzdpG2cIAV+FIYYxBfAoktujIf3qwinbpxrdLxTAP/06J9Uo5nNLeqmVwNjEOAY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sPH9gKAQ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sPH9gKAQ; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sPH9gKAQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sPH9gKAQ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Crmo5V0l5p9Hv9o9gt2O/thfi/oJWTRXxkwKarmFgoYcJfIiuyS0MwdpWJSJ9ib2zRNz1LG04Fwd/SyWgkyVV+qcd/+ffl8jA9HJx0GEinwiDRGsg8SfPpRnpXQ3rCHQsBLxSmvmXSOTg01Wp6VnkS5cc8uGmoylRGaY1tIPyXUAJ8H9dDwu38t9T8RE97oDrKbFZad0TZFgzS74b8taQ5XJj7d9XO3U3k/At91Mhd8aKx+5cqBPMyVOHZRf737YKFTCHlmbpEwE1m+yb0gECbxkGZRNr9+mE8u++RMGkSJ/kL54DHuab5kMgpOCpa0CeHrMsC6su2x3HfwTLxxHDA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=envSEUffQ2QOpftGK1JNm5jPQy2+D+BWs8Scvl4vT0k=;
 b=CFwZGnT6meLKeu1CgoAk0NbxwXeMY4y8fhorhZTCbu+AwXpMsKu1zGcTllxNIo2Gtt1+Zyddl1TskeI1Cqn0ajONjVJQX0Lew6zGFQaYFfZ8ukgGMimNnOnUU0O/4SUm8158Fn1l44g32tNGgJC7T12s2fSFBP+j2Fy7ZaM8J/MYkXyOUSyhYPZXR40Aipa3gRtwsR+ttR4bTKypkdzUEZeBomfKLAWFD24OzH4566rxQxRARhw7qpEEUhPdVNdxZhTRvfXs0Hzm/9jtDRArICe7iUwSvKZZdRLfIiuAfakU41cq0PjktTBnFjGrmGjI900xOMeJ8EIG9YXTIerqZg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=envSEUffQ2QOpftGK1JNm5jPQy2+D+BWs8Scvl4vT0k=;
 b=sPH9gKAQJ2NusglxXWgjnRexqV34BuBTRC5j8z5U4buMui2QP//wrFpW0BYZZGnONX3vUwjLaidN2AOeCBTdruh3w5oPstRFrjoXnOY4l/jiINkebS/SjornHedPKt7E5C4vW4D8KZdCHRlENpxsob0e2GnQYYfHdpF3JK1UyCU=
Received: from AS4PR09CA0006.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::16)
 by GVXPR08MB7749.eurprd08.prod.outlook.com (2603:10a6:150:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Thu, 25 Jun
 2026 13:14:02 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::4f) by AS4PR09CA0006.outlook.office365.com
 (2603:10a6:20b:5e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 13:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 13:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDuxKEmnAPsEBYE6RGMAsvhZjPI7a32jOCVToXOSY3SGLc04PaE/UU4+dNxavSEoPhHAxVzhvv/2qRpvcyytmPgwoQ+IpN3xeymyPlA+PVFNiwdnCuyD+3684MgcrQgMw+Tf5+zpGJCKNW2bj2W3iQKB04fn4B4tC0/2J4pBPgVqqv19wS7CD3+Hu8HSXnmdfYnjgvKfcei5BW0BbRfxOcrwHPQUrWLCf9nKnK0hkcgnaciro/OY/xJiMP5wLlzWGk9qrTAV0YKIBqzpr2iLu+MC7eCxMGi0dTP950FgdBjaT99TiS0wCgwGmPi/Tc+epC0aKD7QZdv6O7smL+7QeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=envSEUffQ2QOpftGK1JNm5jPQy2+D+BWs8Scvl4vT0k=;
 b=vq30EqLTn0YbwJSbeRh9CW6vsNhTLc7rM79lm7jMLiIgasa+QWS0I5qG2Oz5SCV0zGRXZ0IDrxNIbfUtkTAR48cfFptJ8GrApKSehuyInvzPJ9jH84pzKc1OPh12q0KlgKyJW+OLPgW5g0ILkwvsaQFFLhue4WDVxyOPNm9aik+Y9rxIjzgRfLy9XT2npM2m/corQVflOd9ao/BxxdZPYMcuzOy/kWOsh8NmikQqUSq5IOHT+ZkmOsoeTTnx9vmJk1oO+mlgJLfkic1/zoCZ4eaZgcGvF97atriCeAZd5iZxnSDvJaTZLuM5UG0DzqTY852PBoUeH7fhTVtx2hMLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=envSEUffQ2QOpftGK1JNm5jPQy2+D+BWs8Scvl4vT0k=;
 b=sPH9gKAQJ2NusglxXWgjnRexqV34BuBTRC5j8z5U4buMui2QP//wrFpW0BYZZGnONX3vUwjLaidN2AOeCBTdruh3w5oPstRFrjoXnOY4l/jiINkebS/SjornHedPKt7E5C4vW4D8KZdCHRlENpxsob0e2GnQYYfHdpF3JK1UyCU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by DU0PR08MB7883.eurprd08.prod.outlook.com (2603:10a6:10:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 13:12:58 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.21.0159.014; Thu, 25 Jun 2026
 13:12:58 +0000
Message-ID: <ed31c2bf-a835-4d1f-a701-33851f1ac45e@arm.com>
Date: Thu, 25 Jun 2026 14:12:56 +0100
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
 <81dd6d0d-427f-49ae-9573-fbe84dc2185a@arm.com>
 <84dabe49-8405-4213-8b73-433cf736ded9@gmail.com>
Content-Language: en-GB
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <84dabe49-8405-4213-8b73-433cf736ded9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0315.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::14) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|DU0PR08MB7883:EE_|AMS0EPF000001B1:EE_|GVXPR08MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c74074-b5fa-4895-ebfd-08ded2bba01f
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 mIk4ZuDnB4xqxqOks4ygtso2p+TlvJxE3SAPtBW7XNwnWbPl7+Mhw8TaMLdOPoFbXPtrcJKAxBYpd0DxpW3qs7KEzzXHm/QEXg0SBeXw/vB/BcKlUg7i1J+H7Yce7T0uNKW62WGeP1CYCthyLJgj48sAdPbBB7lkK3OiYx6WBB9ugRGWOtV4sMG0JzpqsVC8j4M0LipZYhKb5uewZkCp/cgj/gVOXqWwCPj4NJXqsqkor4Ob0+AoT31FjZD/DMJgajZDMuodhdt2SjLpSYoPOo0CxAhHVUI/7gka0b7sOBSWkpxKfOfF83HGPmjEUlZGT4ZqDRgpWW0iDMQLE5PLGpKPGy/F1LiTKKppWENMZin1rBeNpP7GwIiVud4eQNgFQBaSiUkZRhXoQUv7c+FSkfGmBvFV6mUfOmBpiVIBJsceVf65DsHYFj3J3F2e7+vc0l/wy4nrCV2YVvFln6f7xGeplBhE4PNiHkS3Kcv3FFtMBqfNpBFbnXdnDadJSIDFXhvhSWHJTPFaOelF+JXeFRv78sE3st/XCebUkK4vR7Jr/2dUz6hTk0OsyYKDjBRhZ61W4G6TkOzk+7CvSoGoNRjQXwt0YXSgYkZDHknJicWJn1joMhRjdOQjH99AXIQ/pvS5Zg27mtP877fd6yCP7ewBEZKqgid4YbQFPr8nSto4j3D0FrgOUQkQgwBUVQnTAqRuZgZasLFs3pjA8wta1g==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Bn8k7cddErPVHTpdoec4qT1Zh6wJ22Um/C1s9BtRiLLhgOhZyu1Jn/0GaWy2FW6sIJ5sxB5Suc0UYU5R2EVTZx4NfR5IF3PO3F2F5ssOCYIAkNp0ReJk4rbX0agRHls6GZL4W83a2i+mvm+1ZqSTQ0bLPXgjI9onWR76Xslje9Q2wFR9XURUA/Ex13BjJOBNZrgzgWuRxP4jEBunVEkZ+Pla+RAe7Dv/mp6wGdy56wLzLZ/X3UkVQBAH/Tzd71YE9cBroapIy5bLL1zgz8DLUN9quIkKrsNIicxBaOWRxhAiNT6KXtal4pN4B/0knOgMAVcJORsHb2oln8hc8/QZcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7883
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	80c206f5-a6c2-44f1-b765-08ded2bb7a1a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|35042699022|7416014|376014|23010399003|14060799003|36860700016|56012099006|18002099003|22082099003|11063799006|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	h4Fz/XSs073lJRltn8kdslRpCcqxlCSlyvaDDJYhpvzwoQLBnZn+AEptsxPP9SV7oCQqJqHsZ4zkdnt1+oswI+44m83JMJCe4m7CDS+z38NXlNXs2xGr80hQaAWyMN0Szwz1OIoa0xeEUr00lRWkG+V0yPLtzlaG8htwgC1TMVP9jGuc/sXh2uWUyHZs4YKbZg3eu9IGRvdNaGwJjuNERMlvcc/lELidUVnA1cMAyn+8DfNZfkI/dfqtBNQpVTsaDiN6oSafkOLrOpSPtqH6YsNEwvcs5yAa5REZkmosWAgDN3Z3HTSMiZgFmgW8HheHYX0KnEzMRurJf8y8JPhkoxYbANd3HV32oy2sEkcfSIibOj+Vn1DCVWp1KVIyTkZz0Xtzt0uOybVsPLbgu+fPYMzfV27l7Vc66AMPdZyWaR24vx1SXP1jtsIx22H4rZN+OAuSLVDw6WE+CKDLfT/D6KEM0Qj+TWdpgm+5bY9AOrltSOVNGVJeuB11HPgDqEieZd2UKSBxj2yS+Y35UTjANh1govb7hH6jXoD8Q7aeF1r4yFAx1bbNrhMkWcGrmMIUL8mMgywu6S7Gfyx0Q3wkjKNc6p3abKdjUDtlfZ72E49ZOAxIps+Q8Sa3Huu4JfzIv5HjQmkDW4LuU1AT/tztJaw6S+qZ2H6hVe6P+cSsP7F87Cby2LCZ6xif/MSVN9W8vczkWQSReLPd3B0oPf15uJXxxrQCFrAQH29gO1onaQDrQTcKk0m9TB6knOCzM8hu
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(35042699022)(7416014)(376014)(23010399003)(14060799003)(36860700016)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3K8LYtF5+d7sO+0GpQif0Rbr0804upxLB7k/jvXLzPacMx77qvm+rga3DCUmotZPMJ17YywEHpshwunY0hHVc+aXt6vEwNHD/w3JePlFKQwFqN2YqRgtCyvpv3Aq50yc2mHYBVy/VzA8K/GDHmshH9uVkSNsaplsTHnUK+EbkvJPo//441ZcQdcTp3TFCwyfHe3q3zx3lThkYTDM3FRdMjUx7m3W7COP0u1c7SgKuoRFFz9fRlkeyF4aay4KpYoU4X78jw/wR8b6wDdjMPWv9m30yHOl0SCock5hN0HVIvbAZwIyxblL4cCT0hT9O+CS9ZPOYpf05QEAbuiG1EM1lVDKmOw/xMjwDaNQNWBU42RnH0v8w4rTzPA+ilWTQ8yrtcyjCLoiGHv1i2l2sQwtNCSSiQhjSSnXc+oaNQSogpbG1n24HxJmCBIufJB4LzVj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:14:01.9375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c74074-b5fa-4895-ebfd-08ded2bba01f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7749

On 19/06/2026 18:46, Julian Braha wrote:
> On 6/19/26 16:45, Ahmed Tiba wrote:
>> GHES_CPER_HELPERS is intended for both the ACPI GHES path and the DT
>> firmware-first provider, so I do not want to tie it to ACPI.
> 
> So what's the plan to fix the build error when ACPI is disabled:
> https://lore.kernel.org/all/0f131ee4-d335-45d2-b6ae-49c18df1353b@gmail.com/
> 
> - Julian Braha

I can fix this by adding a !CONFIG_ACPI fallback for
arch_apei_report_x86_error() in drivers/firmware/efi/cper-x86.c.

Thanks,
Ahmed
