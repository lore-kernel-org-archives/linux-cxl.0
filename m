Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACBF313E0D;
	Thu, 11 Jun 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188484; cv=fail; b=R/PifHinQfb/ZD6y8fwE7ElO+lbPYx1anMS5mWhJXGWmhT2MCnM4q+5LM1iwlAnhrH7y9KRiVgtUFWPnN6s2nff1IYWWvP6wWMcZ1yvaCGQjBitdh4aAjyeJFj+dP4W5NNNWaAk4UogSjS5vyvdxgkPdsyyEWtflOsrlblnVLxY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188484; c=relaxed/simple;
	bh=ht0b77bJejHH1e6rwV31v24ktBAtvG7cXt89KuNE37s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MT6BoosjAq1ztiJOpIpWskvPZrbpKTPxyU5XnPjy2Bt43Wvoe7GDSAu9aK5/1u/X0YYSsHr0fUTb+jqzKKqasvgrz9bXPnJS3UCABpdbJYyt2a1C5ZA8gHpFI3mjL7eyP/OVKyV033CsFJUM93BrITEq1T8/SVbKvmqkCOeAsQg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QXyh4Bx1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QXyh4Bx1; arc=fail smtp.client-ip=52.101.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QXyh4Bx1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QXyh4Bx1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vw19qmstjmFm6h7PHGi9/UH/9VlKMhi9yWds17+bNjAgolXmXgNiL/CU7h4ziZ/SFN0O1j+EFhiWlp/O6cEiSq+LLZnN+Eu0sJr9IrfMTnlX1d9puwgZrsWUVr7771KHOLIzTYsJPo3eTpcc2CTLB2PZ1bJLBQ2xLO1emmi5O1sFX4CgVErfR6WMCPO7egolc+L726hKy8Af715v7bXffj4crrY0Ur5Mhnvow+sCqWqohFdYNWaQXQgUoyZ4Fq2G6GR57XokImi9VGMzxpITW3BOY4fXV7SedVALLmxAElPv6J7AT1wptZqt44kZhMrXcoRwMA6veo8QOH2+h30i8g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpDHl4kWzHPjzFTkqmp9d3T/R3DdhzekhK1ju+ENzq0=;
 b=D0ztxqVG/faopZkYGIzyFXXALuPA810tuX1OWy2RcNvIgd2a71yl/AVwQsgJvI4JnAd2wUvRsXEU2rm4LlEr7fM64t2CNVNZqsKR1cJadLwU+f8xNTU2H02kspzH4WGAbWRRPD/CbQMlS+G70wRYYUo0/AOGY5F96X+EMSZpzHIg9vVe52lBUeoMMv6xMaiCTa4Bhy3WJD+oEOCdsHvjDvpfoLDZud31hUyJJC+D7DU33FiLrN5lCpUuKTUx/EaxJPOtPr0StPcZOG3rXuuG+Q88I/mDHxwCy7tu7yFFsNCTnn1OUdwebAu/llJoDD0SvjPQSf5HqBf4TdtXt0w2jw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpDHl4kWzHPjzFTkqmp9d3T/R3DdhzekhK1ju+ENzq0=;
 b=QXyh4Bx1mW1aDbeBN1vBm13U8mOiRZpbQ7/iWJeNdabKnOj0mMorja/HYfBKsAsmxCa7kyxWwtHpcUhjQRgc8lVnyc+l2QyTB9/plzggX/eTp/h/L9PWMe+ayO3OqGb/cuPT+tUiB6VvL4T8Rx80n9JOpH87x5H9Anp8gmAcNes=
Received: from DU2PR04CA0189.eurprd04.prod.outlook.com (2603:10a6:10:28d::14)
 by DBBPR08MB5930.eurprd08.prod.outlook.com (2603:10a6:10:200::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 14:34:32 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::b) by DU2PR04CA0189.outlook.office365.com
 (2603:10a6:10:28d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 14:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 14:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwv1rKvnB4+1We7K53b8nt4c2Q6beNaMFGN1/bIPszFfOISZtgA4Uha9W23UsBC/+++S1ZvvYX/VTLOair5235KcbDSoSw+Nn6Y4EhXz1bCofRmSMygDoQEtxBeJFxqd895/Dh3H4vJFAPYv1FryUGYg44CyhsvTGwESHQZ9lR8Javzex+iRo1AmECi3YScxfpCMq0bi1WgbIG0AQPyYj2uFRwzfqIKZeI/MaMmAhHrq78g19Z2VbA/CxrAKMgv+IKv7KYuR9Q9yEsyNcw5Nb+XE/5do1Vp/sL2zjosvdyKwYME57avFatVMBQkeKKcGmmZFlT/ic7FMAnvAq8XEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpDHl4kWzHPjzFTkqmp9d3T/R3DdhzekhK1ju+ENzq0=;
 b=Kwur24hXUOyA/tn/DURvfThNmWWCmosxysX4tkrXhZcmNrsxAt5y7kO/QImj9QK8lblXR3TL13AFSI8Qi8dqh00dHAWxJjnTS86QPI7vCkwelu0oLbBDQ4zBedSCI0l64imd2nMODvDkBXe++E5UOG58zJ6MPxUXd0H3yFcARowecGAvSm3sxU/qiYPalj7b0gF7IOSYRfWIAbETl74cTti/vR/gy06xPNP+HmMmaGdfUuDfmzs0dgnbXxdazuXVBzcaPbHQTyGWcFTI7B+oMOYIh6aFIgDXU68E2e5EDQh+p1AcC8mwrF1rHJ2JnjK6UcrofdSLW9XMuCR/5wvnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpDHl4kWzHPjzFTkqmp9d3T/R3DdhzekhK1ju+ENzq0=;
 b=QXyh4Bx1mW1aDbeBN1vBm13U8mOiRZpbQ7/iWJeNdabKnOj0mMorja/HYfBKsAsmxCa7kyxWwtHpcUhjQRgc8lVnyc+l2QyTB9/plzggX/eTp/h/L9PWMe+ayO3OqGb/cuPT+tUiB6VvL4T8Rx80n9JOpH87x5H9Anp8gmAcNes=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MRWPR08MB11806.eurprd08.prod.outlook.com (2603:10a6:501:9a::22)
 by GVXPR08MB11637.eurprd08.prod.outlook.com (2603:10a6:150:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 14:22:24 +0000
Received: from MRWPR08MB11806.eurprd08.prod.outlook.com
 ([fe80::20ea:c85e:c8c9:a8d4]) by MRWPR08MB11806.eurprd08.prod.outlook.com
 ([fe80::20ea:c85e:c8c9:a8d4%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 14:22:23 +0000
Message-ID: <ceb19cb6-7083-44ad-a262-a8198f489257@arm.com>
Date: Thu, 11 Jun 2026 15:22:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] dt-bindings: firmware: add arm,ras-cper
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
 <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-9-2e0500d42642@arm.com>
 <20260529174407.7081ad0b@jic23-huawei>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260529174407.7081ad0b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0057.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::12) To MRWPR08MB11806.eurprd08.prod.outlook.com
 (2603:10a6:501:9a::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	MRWPR08MB11806:EE_|GVXPR08MB11637:EE_|DB1PEPF000509F6:EE_|DBBPR08MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e63af9-7be5-4135-117b-08dec7c68d95
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 wnxnZ2hgF8s+X0OSjJrM5JMRLUaKsT03WF17kjOqXbIfX7bkzIUGsyybXMUUw/o+lV5Z3GnlCXsmAZC7VkixIOv1ujsNwvmsy/j/5vluJYBW+RWutfx6eHpitUeqgydtW/L2VNJIEF6e5naLTGHtwubGCV8gSulNOzHkG/h8i6W4TfflgcMOmj1UHAv5HOhYVM2RSul4J+VEtXs0HbcEj2cKspwTQOidg+rGRuR1ZswY4eEE7Owx8OIkMoOkBpi0/J3p/5OKu7zLwuCceZh0cWj045xYjI45RDi0n3rohso1y+FxRdrDr8AgYQnb/0XT1w8GNBHbgcFepH614j7iUuOrxyw/uCOZrM+JHo8fZjFyWe8q79+ExZapsSMoHIL4lueb0Ef3oEsyWqqZVRknKqAOaYQs+oAGGuOEBZ0d10NedvPQDKJnJEqpQtT5fz52iHpkRS/Q+NEa6Nve7GBWC25GDee9uqNDB6niQs1vk+8pVlwkblsd0HO6rgn6706VVTUTwT7Z3iN4Kr3y2VrG5xwetU5GsY6Pflrr9YTphT1Y1xIkMxIMP2TJrSMsD5RrBE/tg6I2a6Sf/Um2ZkV9nR9yzPRarYUhfmkGRNdHG6rCsWsxqWuoDugEJ3r6pQ9r/pB08S4ynwKM0oP1NGgO6w==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR08MB11806.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Z9aFDiYj5T/FYiN7mAD9MGAG4ZE8F2+G8drKAvBplD8aIMoWEM6CIizDc0OoaAtK7PZmHAHGwsmmQHQuKFpoMnGeXYuL2dfkmuMbsLB/AU6jKxeAdaJ8vOncUf4pt5xKlMfIxAKDQg0uKHWxu1grdZ+8PHWe5hfhfoNANVSr08dIw0ce1Ni0q/2wmyXLuu6usCwEUpc7fGBmdKWRQesbxgdRtRfeg+JbU7ZyKh+d1S7z+tPhrdPf+9Wci1MF0eDgeJNfPljKs2nNt0P/FV/7lFcK562jpvx5P4jMMnapEHbkc+dxaIz++FeaTiP9kd0xnhlla1Iyu8tUKDthQbdAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11637
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f974b14c-ee2c-4eec-1c6f-08dec7c4dad8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|23010399003|1800799024|376014|7416014|82310400026|14060799003|56012099006|11063799006|4143699003|3023799007|6133799003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mmn/9+EaBLr66MN4FTJEYcXVENnu561k2To2iNSW5ISwBVgsKPl1+YCPWJBa19YvpWRRbRKwi7iOGHKax++P8usmyWD2OHE6TNzB9w0XUlnB5pN+i8jZXivPKgldcoz3/nkl5w0Ocy46X3gvTkrdIOKD/Q+EHvNQUbrshMqg1Ozj4YmGErhMsFTq6PoYMfloCFjd0M+XwbpanvRhCu/p88xZEw+bXl1n9rKqMqJsnNBnCEdMCMMdaAxjSWedaAPzzcbpvo04QO6f9mmpsy3OcbcvqPXKKTsFXvrqDb4z4aQFUJjUi5yVS4eljF+JSCvj/MmDJTAlj0QMQxXbpoxcn/0blN1JbmUHGWkcHTU1KGpqu5c8gse83oI622iA/ewia1+SRiG36entZrcTz/9xibU4qe3NrsQo1paLiRqr9zX9qbkw/zHX5ABtsNRvSMt5xaguY+zlXwZKTqJDfVS6QsNPV42uEV4IXQPkvW9m2jX439aPnkJ9pD+FiDO3OwWRvHQm1ld/zryNdCf+MYVRwz3Du0lgUn4dIATbqr4zPU8l2qIKAemKgIzRccSndYyvxEYSZIDMMbP7xRVGH9vYJ+GeyHA7f4dsM+xHZRgrOFeAj4ZW2h3CLMCsNQuMGmP57+J+29HMnRMkDZexClZPQMxbSJwUbuRhpJXrhJAAIItlJgIeIAwUxU/JSC9ysYke
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(23010399003)(1800799024)(376014)(7416014)(82310400026)(14060799003)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tJwR+bvJuA1BliMdUCl9r0BhbgdGOuL6xevrS0IyHbNCohcBgvRyKjbN7aWR66l03oIqYvDcUJPvHxTpnM9viAYHl2ZrBkzjXBYH11qFtVU2r2gLs2HD3zfee58A7ap95YVlFzD7dMNRg6IDHqXigZu0yypYUzRqB2fGYq5WQGbjxGZwjATMSW8B3ANZmyjZDBsKPquUR6EjMNm+y+89mhRTsnN+dTVVWsB5tawoO3GjaTiN3T5cujam8+fBlN7TuwLtPrFZ11a8+iEMxiZ2hcgwAudtx2wL9+gsZOqUhdg0Cm3LgHsAOTbVQ7FksaSPO7zBCQUO/8H6nRF1ABuTg4zLbmEWhIo0KVZHSfcHhD3dhBKwWc9nyfrbbFWXaXVsjj4faEP/ynmJnVGVFgQQbhPtjdR3iJzqTfSwQG0ePwUISimNTt0Cb7xKScoXR+8+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:34:32.5001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e63af9-7be5-4135-117b-08dec7c68d95
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5930

On 29/05/2026 17:44, Jonathan Cameron wrote:
> On Fri, 29 May 2026 10:50:49 +0100
> Ahmed Tiba<ahmed.tiba@arm.com> wrote:
>>   .../devicetree/bindings/firmware/arm,ras-cper.yaml | 54 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  5 ++
>>   2 files changed, 59 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
>> new file mode 100644
>> index 000000000000..3d4de096093f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:http://devicetree.org/schemas/firmware/arm,ras-cper.yaml#
>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Arm RAS CPER provider
>> +
>> +maintainers:
>> +  - Ahmed Tiba<ahmed.tiba@arm.com>
>> +
>> +description:
>> +  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
>> +  a firmware-first CPER error source directly via DeviceTree. Firmware
>> +  provides the CPER Generic Error Status block and notifies the OS through
>> +  an interrupt.
> I'd like some spec references in here if possible.
I can add a reference to the UEFI CPER specification for the Generic
Error Status record format.

For the firmware-first DT description itself I do not have a more 
specific public reference to cite.

>> +
>> +properties:
>> +  compatible:
>> +    const: arm,ras-cper
>> +
>> +  memory-region:
>> +    minItems: 1
>> +    items:
>> +      - description:
>> +          CPER Generic Error Status block exposed by firmware.
>> +      - description:
>> +          Optional firmware-owned ack buffer used on platforms
>> +          where firmware needs an explicit "ack" handshake before overwriting
>> +          the CPER buffer. Firmware watches bit 0 and expects the OS to set it
>> +          once the current status block has been consumed.
> Does the arm spec really make this optional?  Can we constraint it to not be
> just to make our lives easier?  I've never been sure how you would actually
> make a working platform without the ack support.
I will update the binding to require both memory-region entries.

Best regards,
Ahmed



