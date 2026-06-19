Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFF3B2FF7;
	Fri, 19 Jun 2026 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883778; cv=fail; b=KLZpLwfwWZFFMdxexffyHX4t/qfyAxarjJgAF8OWLwDc7VtI/bOdVTiZ+k7orYC2MzISZkrB/+hjXE6ItJcMUewzQyBK3T05D45FvSmaznhKwVTg6v5UKg5z4flThdx4ZRPNbAayXXr/IkI3RGT/XpOqBUbWENGjodPzkBsowSI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883778; c=relaxed/simple;
	bh=qQLLvc8AOxNa6Kzv5qPeUQlaVpxR2rNvEwp7Sl06yeg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PTG3hbwjqhojll17iV6IQW5YSrHtOOkGx5F48Vp7vQv2ZDBY8OMzbEi5PbNfqT5diTgPX9mfkWQ0MIikI5PyX7SgkN8d+gDdR/mpUt3dzpbyMSqkigWk4T3OhxL7Y0z2bfk+ePBUNBaH02gaulJOdi3D9gbkCkRVAOPikgGwjP4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OFu9JTnj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OFu9JTnj; arc=fail smtp.client-ip=52.101.72.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OFu9JTnj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OFu9JTnj"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jNH7vICeOkhBv68y2EEcw21key8SBaL1zbbr5/mmdXk8mEy0hbMu5Z0CPFKgBC2ceZ8c3Qlj+6EnYswv21CXe/38mDo31M8HGtowKgMaFvA1MLpCoBgaPfUL/2ECosK70UmvWOkWT/ta4XHgDQLr1QQdyagj8kfBtqlE4d6wf37fNBPY2fWSFvVYrF8D7Lx2FncM3JNV0CqIrItsPCcGXl1NcdpYfdRUou8Fj3zc2g8YbyqOiUoFJvJU05deRfRhvox9HZxzqD2sxDuSgmeGHdq64CeH1fZmVbDQcH0N3NDaS1d6uhVCsADKXJuha+5gQOy4m2b0HXpiyShV+PvI9g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTqQ+F2jRTaGLZOwTWmvzfCkn6aaI6AvSQpP9OZYcn0=;
 b=gQ9UBoK2jTB2Xf8b+v8dNr75oXS0+tKjWo63SI6cIP5aoMyU157n1SLxGT3qtk1Tyz95kkgIyT6bVcPza4vugwbzGK3c5Z0HDeRt71nDUnux7Lo3TNGbIZS5AzspEbrvY3WlJGBszUWEX2sZGeMNfB8cKqdFp9BhEazGZx3ofDf+AEHNxdbURuUSloXYvHvUipzkhLZ9mq36+7fTaV0SqRMRERPfsgVpKvHkUc4vRPMloZukoksb5sLvTm5uCUPdxj6XxO1ty2vEOnCmtqLt4GhvjmqCliF9oYNtUYXM7lGPmKFRbEbuffkx+q/2X+NmxB7SzAVGJ/vv6Ie7TeT1Ow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=alien8.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTqQ+F2jRTaGLZOwTWmvzfCkn6aaI6AvSQpP9OZYcn0=;
 b=OFu9JTnjfCNCkglOh5JUon30OHpIpYPMM2y3h9z04eiMxEksSAHPd0LBQ6IyR5SDPI1ux+YTarDaiJOpYu7gMCAnPYl3MLmUiVp5baCnxYSy8aNA1ligt45YuM4MXcay5e1URXOmABuQHM2xfbPC54N2sdblN64mpAEN47Uku74=
Received: from PR3P189CA0077.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::22)
 by PAWPR08MB9590.eurprd08.prod.outlook.com (2603:10a6:102:2e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 15:42:46 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:b4:cafe::48) by PR3P189CA0077.outlook.office365.com
 (2603:10a6:102:b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 15:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.0
 via Frontend Transport; Fri, 19 Jun 2026 15:42:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKz/aJmZpO/sVv8yR1EeYfWer7L36S4J681fTF+Xk6GMO8Nqz/Si2mA0xXWpSGogc57372/5EdUdNR2ZzcOF7IOa4soFpfIS1qn/Y8YO3A74WrO/HvMui98wI0bZVOKxkJPJGnPdKiYByZgPK7Hl6dYU0K15i6iZjHEj9AwbwcrvZW1azfrGRVr+cZOXBKTMJSC7JNVAGEviqCrRKDpBJipx0IqLVqYsTElQh1+flBNOP7JshuyfyICitjlf2/y75NAWH7VPxDwv+h9Q4dJQlpgPl3dWpwdKDIKMvBsr7UC3YXRkXRFkCX/5cqDVrNDnS1NBUV2KL/RFSGf7zoikDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTqQ+F2jRTaGLZOwTWmvzfCkn6aaI6AvSQpP9OZYcn0=;
 b=CRYOM6xtkY6vxuKAkAsGQo3nUE0AdxiEfv1Gwj/WSxZgcm/C1FoZED9NwMJZoA+9bhSkEP0uVEoZStSIby63COeLbMPEiAjnmJ697lanftW5B3z7m17t/cV3+Cv/PDp4DyOu6VWMXStkOfrDK+eDa5mGFI+fRXUT6j/kuuqax6V4cPINziSfNvcnLXAhWOwyuTC3PEKrMh6u26fPouiuoaWjed5Mn2cwf72EQC921anzrFg22x3og5LyA2M6LXipcC2RAu2UKeSlu3/CAVqQ+/6tKnJI3idToLRB3gvPn3IV6arUI2lyQqCqJcRkjzMUd9xu9A4cD/MwsktfzyYUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTqQ+F2jRTaGLZOwTWmvzfCkn6aaI6AvSQpP9OZYcn0=;
 b=OFu9JTnjfCNCkglOh5JUon30OHpIpYPMM2y3h9z04eiMxEksSAHPd0LBQ6IyR5SDPI1ux+YTarDaiJOpYu7gMCAnPYl3MLmUiVp5baCnxYSy8aNA1ligt45YuM4MXcay5e1URXOmABuQHM2xfbPC54N2sdblN64mpAEN47Uku74=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by AS8PR08MB9767.eurprd08.prod.outlook.com (2603:10a6:20b:614::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 15:41:43 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 15:41:43 +0000
Message-ID: <eccbf574-a145-47af-889b-ca6dd80f98f2@arm.com>
Date: Fri, 19 Jun 2026 16:41:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-cxl@vger.kernel.org, devicetree@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260618164807.GAajQhR9J_00j4LxaC@fat_crate.local>
Content-Language: en-GB
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260618164807.GAajQhR9J_00j4LxaC@fat_crate.local>
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
	VI0PR08MB11823:EE_|AS8PR08MB9767:EE_|AM4PEPF00025F9C:EE_|PAWPR08MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9a4bb6-9162-426a-235b-08dece1968b1
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 6VHBjSZMVDBjgUUN/uP3dcPTU0h1mfq9LsdPKouySbHfcyzBDa89zs3wQWlscUJcZWOFWHWzUiGE84+ips4MofRbjornThgPOUIM8IMl7dCk5PJuEub/gMfYxEYG2oeg/DMX+xImjSj+hsdBMJKa/8LP7zZqVeEcKG59rlwECzT1c/AoiFBVKy0kMYMdwmL/GjcT+rvftz0XpAHVaSEgwcmFTPww9bq7smDh54K+9xBi5mA/2n9pC/+Hv8u8TAbckEAGA+nARWzZQNjaNj8gNB+TFTZtlFuacdDoudSceh4HZYQSfo8LjV3F6pE37vTM9Ca5NERLGN2OJu+pb/btqa2vbaMVyo5ePCMCjgS0RPU+XHYfMHJBXv/C20DEAI4SelDq2ArLIvrbAcRMkFHJEfojCxQiObbK3eenxav+3jYzC1zPb2tZfhSkQOnnmUlSSMXRGCOMJykOyiH/xMk3RzF34PySHoWGlswYW2xQ5i0rDPVcLE/vFEFYqEOaAxWs8erP86BErxNrO81yGyo9yWzHSGn9tU8TdfUMw4++fs1TJsEbUuYeLGzIZK6zHFf5l4x44ZD71b3+ZW6dtxHsibU4IuFgJYTYAbvTnd4DbLk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 GjuDU3OHyx8KwdGEAX77MmSJptesA2rA+iOwZ1nRdFPoV851AxIsDAiZCDxEPi2zw2QxHgwQRsVs3+iLJE05rCtOSMWsBYaeO5NsPUP0TKv2nNOjv25M7TelU0W4FUWvtU8sIteTapbni6E7aBZtRMbGArqG30ZH50prTuDxH+9lftZr19kbQzVRGUlJQfzNbenwFntnIT7RgFog7PQyskC1YYg42bMmx0gmQwFw2c3D2Y2BLExfK1XyFQ902Q0OiDYKA05pxtwcDxOmfzIZgFKPKyV+o36yqMzJmxiWfxNHKnMnTcrk2KUC5Y/LgiZJk/S2DQPKPuiFP3P/BNtiOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9767
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e18bec91-c0c2-45c3-d682-08dece19430a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|23010399003|36860700016|1800799024|7416014|376014|82310400026|14060799003|56012099006|11063799006|18002099003|22082099003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	xEa+qecBXv/t+mvlIj6z0pEM8tz+alO/GOtFtTFou/CpvotT+eQTq171J4NIOdFwHEoFRAc4fmmBuzRXFp9ZaG6CDo59fVtsJ7nf6pI+SqRHT2dcLTQ21j1qWaEW1exkVwR/6af8CBDjKjjqQUpcdBlWV5R4EJlVkGZYkREhFjf3FKJnVLS5yoa7yyiyPSwwEvm8jTx0Zf1ZtFtpCmLtTP5nK7NLRranjADQ94eA2qM1QX8/0cE+skFoV9LC8T2kzHfgarHBq4kkHJuXz/3hbvGzyhZX1mBs5i71GE1OHtq6ldpGGIE6ymMD4Gmury3VMAKFGafVZ8eJBWf3PZiXGA5gaErSVrgKc3jAA4HyBALUlJyQD3M2l1z+c0UyjFFSTR/X45tWNKHyUG1dSQnPuGWgXPkxAjA8UfeFHu9dQ6EWAsKcABVbfGUbhItp00qJzd/Ry4oNHZv9urRtTM/CxPiLjC95wQ4kqxrfVXARM00chzOrelyt/69rw/I1Wla9dlr92C1s3jxa/xVAvox5cfHzT6WR5BQk3QtdpJCd8W2z6lReqcW2Z8sRpfbPAUBz91HjgJaXbCgkhqEEYSyPfESBZ7h2RSeGAOPha4YjmpMhO41HaQN4eawOd4MsvOP16DcgbsTstBhmVrkrsgKpow==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(23010399003)(36860700016)(1800799024)(7416014)(376014)(82310400026)(14060799003)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e0cNEW06eddkxwR9LVueU+IrBl14t50nu29KEN3YFjXQyO2zCefveKju0nkMULm0voo5L/l1UscO0HL9HytHDMVYreDQwr5WIyG+lvowCGaGoWyuhjLBV6Mb6kQ6eWTm9DAgeB/misFmNIS92gqG1PLwEtqyWOSrxf5AqCrpVOnu8zqdolqeduIQK9voW5msGXSZ8h/H8AAacJAkuZTTlVxXlOVzwPlnF9thFwMsXfqSfQzJer8590oSTcSuJ3ym2RRuKIoJOwHGKmpgyyjlawd2j63dQnjaB/IY+6suHPoR9sdWzTxOD4lG93xKWYkfcXjpd9pFdFp9nfkkuL0oN4y9uIoKj3w9CNMSOKIVfaHe1kVjTnjT482vCLFtrMkIhcpyp8Oon3zCdlGFOszqDAnN3hrefJp+aPvA3Arp95W3VmjMEUx/uEvMcLSw8H/J
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 15:42:45.8184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9a4bb6-9162-426a-235b-08dece1968b1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9590

On 18/06/2026 17:48, Borislav Petkov wrote:
> On Wed, Jun 17, 2026 at 02:54:38PM +0100, Ahmed Tiba wrote:
>> This is v6 of the GHES refactor series. Compared to v5, it addresses
>> the latest review comments and tightens the DT CPER provider and
>> related helper wiring.
> 
> Sashiko has comments:
> 
> https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0%40arm.com
> 

I will address the issues introduced by this series. Pre-existing
behaviour is carried forward unchanged.

Best regards,
Ahmed
