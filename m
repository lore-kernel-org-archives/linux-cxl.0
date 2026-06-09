Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAF416CF6;
	Tue,  9 Jun 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017196; cv=fail; b=uTr3+VgpYYoYfoSlKhdDFtONi313uRb7GrePOU+Llavjbwtn/EScqDlB7LiviE9dhod0VOLHiJULbWZ2FgOMPHvftk3ELc43dL7IiMoi48zIt6U3XomzAyktfCoOoiuQy3zlbd2Lud6BQjEhHDnhdXGs9N2xFi8Cj1JQPkwuTNs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017196; c=relaxed/simple;
	bh=ZYt1DikWz+SjDpm1pSxIbjXI0PeMu2E0SRyovxuDeXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qeenah2C/XDysV2uv+12gp51+15rZzRCiBceSt4QvlI4flg6DK7AE1A3P/3wpBeJ8oURZzEYhwH4724RjofsbC8mJPYIpGGraC5I2nIFOeIGZUOWCLTXWNr2PFLRRaDhFN7hZuVAd5TZqEV5Blm5qYh+5L0NzA+ahyG7sXyyAyM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KnRlby6o; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KnRlby6o; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KnRlby6o";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KnRlby6o"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZPE8U/PMSPRpDchfpVVMYVeIzI4AM/MDy28sriGwtmq4UXf2BF7Zr2CCfaYBYlmy64e7AhBG/Z0/8MzY3uJD07TKJuS6YV8tFtXEiq7B/wecNRBiDtL1jScIcm9uxdFX4z3/k/+g7+oBctdhI0Oh5MmTNEPHrq2TqR8ltoUcfwyG5WhKxWs9HuCJn8s/TQu70tck6UWxSmum97L+74iFGfbHtGibCnBrmfYS7vVBw1j8/B3jjLxDUzQWyFczo4+3/d8+6R+W0i7WZmfIUZwmPtJ2H8g9T0S5psKP7PIRRrXFOcdK3bVrNYS4nc47j8d+6mW9t2lCZ7KmqJy+szoAkw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW9OWfMtrNL5L9Zx1uOIbXbLALvL+VT54pSx0Yt2itM=;
 b=xHZ1UtG3W3lJp/8BEVMAOAxn0yCV9zYcYCOWyFpNeUgQIErh201Lg0p+7+Zol5H6hpY2a2CTUPKlAIGvJlXx2GMMambQ8Knzqft3am8pGwRthO08rTWAwYgpVX+TDfVl0iT1ZklWhLNKz2W7yESTWIQDqUZtDOlc/0D3qnsTefdtHJVu2RcFSkp/40mxJ5Ek8HvK1ML1ZsS6x8rUnZLi+VGWgMvJj2c3yAWjMcblJ5AgmXZTjO7LXoI4BfUxvSxHTWcOPZi/r1gDt8ZY+SWmhxCzVt08LWSKkG4cEfrCREvJNZPgKBz1M4esAIHUPzhWFv791onSvn2xYCfOCqYeng==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW9OWfMtrNL5L9Zx1uOIbXbLALvL+VT54pSx0Yt2itM=;
 b=KnRlby6oYoU+ExFtgT+1c8pttw0wt8GNoWVRwklIF4CuMquyjkK4n2Pq1UjuB7ZiTr89OEi/oFpuyv2f6vW3R7IHvoXk2AyCShOQjWrSSU4tv5r3vtL1xapotSZfN7hf4mNya1ZtWSdcT1x0ky2dO4QXFJaQgXfTtRmV+GhGkCA=
Received: from AM0PR10CA0046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::26)
 by DB9PR08MB8387.eurprd08.prod.outlook.com (2603:10a6:10:3d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 14:59:44 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::39) by AM0PR10CA0046.outlook.office365.com
 (2603:10a6:20b:150::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 14:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Tue, 9 Jun 2026 14:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJ0fVt4f74ROOJgWpWsh5h3NT4VXKaRxiFmKadazjk6CPnaG59Izhw/LYKXA5gPjwbH3tIePqCZJcom6TKyHMR2aV8ekFNPln5nZCNBY6nG61r20CGiys9MZ1jIxN3HM5sLNjI0nV+0lUAgDReYMRPNfdv8Nj5Tc5KRpUYZtGl7kPy/218wdwwFSsVIcsxs8PgZ0riksNiLKAG5aidkPpPsKVDjZ58lkySHdO5irg4C53zZ6MEX16PrCjvrmNdh6rDYUUEZae6txPmZhrWBtrqyqqJV3SCXPQlz2rBMUq0mrtfs6nBrdQ8NpLTfIWiHrLskyXJTG3D43URB2FmYyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW9OWfMtrNL5L9Zx1uOIbXbLALvL+VT54pSx0Yt2itM=;
 b=XEoo8B84zFETlRWHan4Tc9Ftnx/OqlAacfmPjjmHBk3UjvsNAgEQEqijBXOqVvhcpmhNvKlVnc7C9Br5Ws/eG3dm1WbPt84Omf7butV3CDRe6qzniy0LezvQYFsc/FGrKFvsmFLaTBbdZFCZAeZwviGmjKiNo87En+ylLvKIT+y5XWQLNYygsYJO/RH4NrJucEto+3N0FUjaDdL5TKMogPgn7j0j3fWLxQ/M22HNMnZPbvh0WauGDy1tZJjGNt9a58Wwhr8cB2M89KzXMZd4kcV96MRA4w+1oXv5VJOCMVeT3v213dd9NboolPp71AAo53C2LDoCsfB3ZSScmC8jPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW9OWfMtrNL5L9Zx1uOIbXbLALvL+VT54pSx0Yt2itM=;
 b=KnRlby6oYoU+ExFtgT+1c8pttw0wt8GNoWVRwklIF4CuMquyjkK4n2Pq1UjuB7ZiTr89OEi/oFpuyv2f6vW3R7IHvoXk2AyCShOQjWrSSU4tv5r3vtL1xapotSZfN7hf4mNya1ZtWSdcT1x0ky2dO4QXFJaQgXfTtRmV+GhGkCA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by DU5PR08MB10399.eurprd08.prod.outlook.com (2603:10a6:10:520::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:58:34 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:58:34 +0000
Message-ID: <a3f56756-2865-4c70-9356-38fc09be5132@arm.com>
Date: Tue, 9 Jun 2026 15:58:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] ACPI: APEI: introduce GHES helper
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
 <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-7-2e0500d42642@arm.com>
 <20260529172113.74c4ca05@jic23-huawei>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260529172113.74c4ca05@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::19) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|DU5PR08MB10399:EE_|AMS1EPF0000004C:EE_|DB9PR08MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd11507-269a-4e2a-0732-08dec637bd5d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 LQIvQkZ+Fa1NLJLgnIPwVFrARu0swBR8fsF5t1PsmMpalqG4iRmqWLV1HvAT4wFWq7Ej9kc+iQsQceA47f2BZq8u7o3bq1ikewfw5Zf1wRENgAaiEDXiWWWi4F+OE4bI2fU0kdEXAX0I1ApqhieM7N6wYetvPlsUSkIiJHfqQRzc9uzx4/PrpEd3FncKXXofnKMUQ0ZOEDiQQkfPgrOzwCjmHmeNO2ShIBxYG5UDPTLcJcspKq7BmbnTXi9oS6HJKFjlN/XX3LQJC7G3AXlzhQGkVc6BPqASHBhRqDiBmctQRp74zGTYQYfX97aqZIuqJFaAFbY59fohrzDeX+TDsl7qPUsNj0yQZvNE2AAXdPp6z5j4xjQpCR/dasXSQWvGN0G21706/9JiquvxttzTAQcU1Utel0DmGi9+sXVFw8TuThTN9x0GS1wG9dO6nhOLfb1l3WViAU9hhxGYOhR2ljqNS5udJViZEiYbHi22BkeyB3dmgrWmhAvhlRJd7isZRcMnnpn+omxCiWOzDdZ+gZGRi6+EfjoSoK1MJ/0U744QRl6MIIjOgY4djQBLd3c9lwl9Xf9TmQhbUaP/j+QZTrpUlts7PmuBX66a6ILjg7vMO0OcrYjKP+F+EzDmxGKkpRbrti2/aAMF/LnGB3Yi6njPYY/JgzEyKij/1NbgRG8kDJSqV/KkczEd39oiB18o
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 j8ZFqylHIe8X1ihbW7A/5y5jK/q42M1YA7WnAvbC1tbOzWdsIXyQoWU4QqaNjFDipUbigCDMCWl7DccO1jSVCfViuRzUFTWysYeXfyNgEQThP/Apj3+A5TzBN2irXunoJipJRJfymdK3w/fX8gd+vXJM4x8oukexbKvFdZLoZmKD+3PmSkrdON0061SCprazaj//wPbat4u1cHH47L5LChyJAYPxQFRKNrQJzT1RZp4TnmqHjOel9ua4dtgwavm18nnVRpig9JR5tUI+7016kJlTCmggLjR7G8VqQqsf2TWJ0zCfvs3sGi1ArwZJYxOdahz/7jz26nJ9UKJJK1N8Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10399
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1cafedc7-5bbf-4e19-438b-08dec63793e9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|14060799003|82310400026|35042699022|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	eBLbv0cvlGl2dFfWqvQhW3xy7jcI5Vv8eTkck/MujVgz7FNUARx6pAE8V0HyOjaj62VzuGjNZDc//iey+6tj4lIgcBIQFme4ONSDqrjN7w8yVm69YXZ2x7EFQ2cw65xplbgXeU1mqlHZZMPv8hyti778T31HENvFgWHpeo98V0PIKY3+4N+qOagIr3OFYRpBiLczUannyVyoWJ6w/WYUTWyv3/KPfiep9mUy4EZtq3gW1NCONNy/xEk4PQeZTGfPKQpy9mMrexAV5qCZg4jhxdWIGtPCVpPr7aL7H9qS2/U5Ojr4JxNp45sLX9gIplyZoZh2k6gcu00nAWqTqyhRF3EKbi5dnEsYK2QWXyk9O1rbvMrgR9e4ow5YGrM3NZbRl912FSKosmS1LyczgZei/HJYujj2JsiJje/aZBKx1VIUbQS/5PjPs72l4KbEMiJKN1XLn2srB+yWWssfGo1Bzpr00eRXXtmOLJKzKtVEf7jlr3G2VKNw44lovGGsYqOAmaqTeQ9oCEhKbf/XL3JjMEK094+doog73f+smIbygBB12CNUefZyiJf/y5mYGrKI1CsHaRzeqvqMTgSYdfFyGgI1dXqw6l7bzL3FsHcSQ1iXfcYg4hD3pzRjeCO4MfwtbZl+plsQxpYKpjcG3HmyYvAhdO4qMn3yH4Armw/CsGJar+Hwv5c9S2yXhJ5kzvk1YrFedVJlphZ12IUWdc9qdKNlbNzk8U+qXPRoZ1VL42s=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(14060799003)(82310400026)(35042699022)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4jf/K8IJgaq8cKXnfGJNMkTSBTGOhk9YaQImWzChKvbW8zeFTPlgRukDJL7A0k94+DbSHnWPTxiJMuWpem08xo+2GGPSeR3qoEme28HKZyP4zlPm1pTcu3QnmvE8AWkyTQ4qG3lvyS2FQhhSYiKcsRednX9bkfMZ3MtOo6Ld3pVs0C6g7JFbZlRydlamJ5T4ynEF5WGQpNtL+j6HdQE0++PbOltYjQF8CARjZeWn3QQSIh0r5AE5mHqRVysqXCVUs7dqhuctJtdQztGceUgoeen0MhmSaEBVM7JvMNdjHznFecMh6wDQXcEn9rGe4ZYRGw5Dv8EtD4/S36bYoZaF6tUB31q5Re+0z5jcuUNsyeTdSBdi/pHbiY24OXf5CJ9HE0kayQRS2B7JMuEI2/Q2TYz5Al4APh50KBH+K5bXFIB+8YnhVJcwOUGolcWdyYnL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:59:43.4686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd11507-269a-4e2a-0732-08dec637bd5d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8387

On 29/05/2026 17:21, Jonathan Cameron wrote:
> On Fri, 29 May 2026 10:50:47 +0100
> Ahmed Tiba <ahmed.tiba@arm.com> wrote:
> 
>> Add a dedicated GHES_CPER_HELPERS Kconfig entry so the shared helper code
>> can be built even when ACPI_APEI_GHES is disabled. Update the build glue
>> and headers to depend on the new symbol.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> I guess it doesn't matter too much as in practice all exiting CXL systems
> are ACPI based, but is this new symbol sufficient for the
> CONFIG_CXL_RAS dependency?
> 
> Rest of this looks fine to me.


CONFIG_CXL_RAS still depends on ACPI_APEI_GHES which in turn selects
GHES_CPER_HELPERS so the existing dependency for CXL RAS is unchanged.
The new symbol is intended as internal build glue under ACPI_APEI_GHES, 
rather than a change to the CXL RAS dependency model.

Ahmed

