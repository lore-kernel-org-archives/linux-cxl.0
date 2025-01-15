Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A72AE66
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903264; cv=fail; b=u7X0rjiayFNfaHNHsdaXdrUqViBgVb4TJotkDBtbOaFsut2hTke460FnGHaCnQcdeaSaeXFlPYbbI/wJNkjMrr4vEJcc/5p7A8T+4Au7QQSFQg5cMHmaEFxjq1y4XOoQlYDf/7UABh5wOl2vzmjY0Wd/L+foB/5Gyn8/vmmlypQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903264; c=relaxed/simple;
	bh=PEd6jwzH5fwEuP06cjjx917xD50Y7h5lNGAd+GnzilM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T0w0ZVUjCLqvac9E/hh6teGww2gW7WXmfOjLoyZjuxFSDIQMb3lXFrJp9qX2kjtEF61lTr/LHdHQqNOa1qHHER1f/XSOJh/DXQ72avuNvA+KDbqcNDLwr6s02//MJ9f4tZfBNl9Ye385yS+SzBeHk8NFJ2qdj9bxBd/CuHv9jVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=F5n+WpIv; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="F5n+WpIv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736903262; x=1768439262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PEd6jwzH5fwEuP06cjjx917xD50Y7h5lNGAd+GnzilM=;
  b=F5n+WpIvO7jvMxyw5zmW7r37m9OScDeK+lyczlzmJAusuu1jS2iTieNZ
   CtjiUG9qJjRax2AcNaIxEGmv8IpBnYuaECffq9ESltYw1AuDaAJi/FLGh
   q/kiUCGnWXcsttVbeOIqMGhGfc4vhWu48mvBESeHf5QACoSaYi0lOQqJ4
   dOjayEr1Z8Ckv2Ra3a49B4kn/Jsg0mPd9j3rEkVj6HHIuWsx3C1nfqWGs
   fw6secKPFWTM5Lnc2VZLmvPz4+FFGJk4u/BiFMxFaVlPmmuEb9g/S22m7
   5Rajs8FJkMrYCF78UZwbY21Zzj9XHfgT0WWB7ceQGq04l9lCPpbDjSxZe
   A==;
X-CSE-ConnectionGUID: 6ZraMGY1TEiTiy9wDnnyCg==
X-CSE-MsgGUID: EopMA7llQTa8I8ajSH+xcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="55845769"
X-IronPort-AV: E=Sophos;i="6.12,315,1728918000"; 
   d="scan'208";a="55845769"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 10:06:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAk7ntetjZDcgPb4os6iOhDQPY+ynNXCZh3LYFjB4ROUEVn6dDJ4PADtPv19oXXC1i7mC3plThMC53mIRAR6blVO66Q9JBmQc9H6PGh5xJi5LHWJx3TQdJtFBXXiySgOmYFVjI7Ypf2O6pOG6BEpSSMDJNJTvsshkLZ80sP8F41lHRnvB3hUgBW4VbzSW7+FF6tTi/WqtMBN0a5tiFmkp8QXS1KrAdCAtBDwaqpcbD/asA8trrZ3dXq2kCgKOKBaQLl5DdKucrr7FnTRujt0gWaawtPDc3HRtUXd2cX6TSRHCCUtmehiCNp+IgxhUVketj8b7NyctDdLF4yikFmlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEd6jwzH5fwEuP06cjjx917xD50Y7h5lNGAd+GnzilM=;
 b=ExxTwox+ikvQVRy2YIfzqozA1jNp/wLzWcDPl4FF6yGmqP5jsfqOvqCSUpAQ+FuD+v8zL2y7Czt3YKmO0oypiPy6IfHYexfZsFA34Acr966WQs5O+c+XGxN9BgxYFthWanzy3rQiBL4zD5rwhIU44V6yc0zpOqzDmHJXQWDgQG8luS9qvdvUgs0Xmc5vQJ1GZURWsB6k8RSEcOs9M/TP+nu/cYkgSgH92PLR6XkPSrXJ3PptJ3zWlqisDBxOWzEFieCuHRhN6hkSp4RXT0mfnyPepCRpQBTx+Pp9l9/AdYoXN9WQLzDA+aAY3Rr/oK4l8gJ40AWaHjnRcbDxADwrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com (2603:1096:403:11::17)
 by TY3PR01MB10125.jpnprd01.prod.outlook.com (2603:1096:400:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 01:06:24 +0000
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14]) by TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14%6]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 01:06:24 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Fan Ni <nifan.cxl@gmail.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>, "anisa.su887@gmail.com"
	<anisa.su887@gmail.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [ISSUE] memdev cannot be enabled after reboot due to failed dvsec
 range check [QEMU setup]
Thread-Topic: [ISSUE] memdev cannot be enabled after reboot due to failed
 dvsec range check [QEMU setup]
Thread-Index: AQHbZsM8hlLRxEnPFECTEBv8CKzOs7MXBdsA
Date: Wed, 15 Jan 2025 01:06:24 +0000
Message-ID: <80665bcd-7d6e-4f7a-9ab4-e292486f2681@fujitsu.com>
References: <Z4bJdCliETI_t2DL@fan>
In-Reply-To: <Z4bJdCliETI_t2DL@fan>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1566:EE_|TY3PR01MB10125:EE_
x-ms-office365-filtering-correlation-id: 811040b9-8811-4c31-8e8b-08dd3500d4cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?aW1TMGx0dFpPTUJEbDR2UnV2TklsV3ZJM0Njck0zbGoxanU3R0RqWWhnTThL?=
 =?utf-8?B?YU04YTloL2RsMkllOHVUaVpuME9laU5ZdWhBa0FMaTR1QkU3aFJtazhzZ2lz?=
 =?utf-8?B?bDVHYWd6WFExUGJOYjQrRjJKQjVQd1BzVHg3M3ZmMmo5WENndzVLenZrWGRT?=
 =?utf-8?B?cC9MRy9xUXkrWUFnM0NqQXVvZEVyUjZVOXNIcEpqeGZuRVduak5oQU5vL1hP?=
 =?utf-8?B?bFpwRnJCTmtpUDhNRWMvT2w1V0k5NzQyNGwzNDZKMk5ERWpOYVQ4TTE4dUor?=
 =?utf-8?B?WEtHbEFOVi84akI2a0MxdDBYNGZRYUpVQmdiajdPZzl5NXFsSi84bkRhcXl6?=
 =?utf-8?B?dHNSNlp6eWEwQWk2WTREdWJwaEFKalVvTEpLaWZDUEZRMGNtTHZNUCtOU3Fj?=
 =?utf-8?B?TjFmWlA1elViZnhmUzU5SWREdUxkM0tNTVZlYXhqZkVIYThUaUJZREE4Z3hk?=
 =?utf-8?B?Q3krV1Bqb0NaaUpPekVZWDBxTWZYSzdXMlNsRkFVeFlDekdYZnFpM3UwcWJn?=
 =?utf-8?B?NkdPZ1FVU1pTelJyT2FCd2M3eEJSMk8xV1ZiMVV6aXI1YzB2TCthcXBKbDlj?=
 =?utf-8?B?elFxaUxweHp1b2pYdWF6UGZ2OXhCaHZ5RVpMcEp0cjd3Z244Mm9lL2UySXVl?=
 =?utf-8?B?eTVEQkNDd1B3UkRzdU9UVmQ5VmNSTUdPT0ttNkV5UkNic2c0UGNRbzJBY0pp?=
 =?utf-8?B?ZXZQSmplT3VvcnZWQWNsb3dXWitBUFdPSUdjaTNHSWZERkpDMHRhQW9GaCt4?=
 =?utf-8?B?bjRVUFVWSFVMTTAzVmRFM25VcjBvMFNlV3NBbFBoRnZUNTlpallWVWtCMjNH?=
 =?utf-8?B?MDdxR3VteUlITlAvY0QzT0FCdU5RQldINk5ZWTVqQzd1cWQ2VS83UnpBZTg3?=
 =?utf-8?B?cFVOSHQxUDhzeTczcVpCYkxxTnBTUGoxQWlCL3o3a2dOUi95K0hUMDA4dVZT?=
 =?utf-8?B?eFlrNWQwZUl4RTk3OUJjbWFha21JTHdXMTlHVVdnSFpEeUVwSHgxL3ArU0N1?=
 =?utf-8?B?S3RRdWwwNG9tVjhHRGhZcDMwcHd4cTRwZ3QwdHdnam5SOXV0eFBXWGJzRFlh?=
 =?utf-8?B?bzVlWW9ZbDM3MHhlREtMU1lndU9aNHRCMUY3OEhvNHQ0Q0lJRjNFN0NQeFNo?=
 =?utf-8?B?VmlXV21pZVNxQVl2RnF0OGtRWXhQcEFsbkZqN2Jyb3hlcE5IQzNoREhTcjZa?=
 =?utf-8?B?YTZxRGF5RzhaR0V0MndmNWlQVWgvZk1OVW42T1k3ZmFWMVgzNHJXT0ZIRzRS?=
 =?utf-8?B?SUx1c1R5TS96R05UbXY3Q3dnNmZ0Ry9hbEdmakxOUnQ5VENBVEZ5U09BY1Nh?=
 =?utf-8?B?MXYxYkJDQlVORlc5Wk0yVFlDd3Y0Y2RMcTJwWHBmUWRCWVhOZGFXVTBaZDdS?=
 =?utf-8?B?amRRUUowRkRobXJSM2xUaWJrV0ZqSFVtSVNIdjl4bWpwSHJjUmVlYzh6Vzgv?=
 =?utf-8?B?K21PUzFhdVBjczBJT0dreHdGdGdoU0RKSmlleTNKN0VsbkNQSGlDM2k3Umth?=
 =?utf-8?B?T0F2TlNXK2hWS2ZhcjhnNHlDYWY2OHBoV3hOT2hrNVIvMzRnWmJyc2o2Q0R6?=
 =?utf-8?B?Z3lkVFQ0L2NJZDIreEd5SmZubHRFUXJ5eG0xUzgrbVgrdHZLMWFnWDdmYis5?=
 =?utf-8?B?K016Rk9KUEkwcVhURjZFL1pKbkVEZS9vbktEQ0gySENzWGlib0hhMEFFWUZu?=
 =?utf-8?B?bTlPelNyYkVydE11MXAvdUx6VUI2d1pvOCt6ZGhvVTIwSGt5N0FtYzFpbnN3?=
 =?utf-8?B?aVh0eHVkMXY0bkN5NFR6UHJWUlZTYzVmNzM4aHR4OEpxUkFwd1g1b21RN29t?=
 =?utf-8?B?cFp6NEkxQ3IzMnpEZkFlSGk1Y09Qa2t5RHJUOGtCVkNKTXZRU2dhVEMrVXJv?=
 =?utf-8?B?NmRaSjMreFBUblJwOFR6NzdaclBEbGY0emxnYmVZNjJ6czBwNmlyTUMrRnZt?=
 =?utf-8?B?UzZzUEN1ZTdBQjYrN1Vrc2NhWDVycGRkcE9aYlZiZVFEVW9XWGowYllidWs0?=
 =?utf-8?Q?Xq8pIwPhfJp7EjO9YxhLzBl/AYcYV0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1566.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1FXY0ZraUVEQjBhRlIwaC9BVlpSYzIwZGxvbm1QQVBWaVJwOHBNc29oVE9u?=
 =?utf-8?B?WU9wL0dwZW9RK1U2K3l1UldnaTVCc1hDWlo2RWRXRlJWMVJ1ME1OaHMvM1dM?=
 =?utf-8?B?Q2pPS3hveGk2N3U5ZnZXbkZXa0c4NTdEVHFNYWFjZE10UGZXdlJIZGllY1hy?=
 =?utf-8?B?UWl2YktkdmlSN3c2bGw5YkpUbk9FUGFnSXptZWk1WGp1OXFGNXhnWXJ1cU1Q?=
 =?utf-8?B?RVdLNXdlRmdnZUhaMlRHZzRmeVN6aEVleVRmcElvbTBGdWJDcTQ3ZDY3RGl2?=
 =?utf-8?B?Y2JxRnQ0L2x1ZU9iOGdqbE9FNHFwN3g2anpPMUxGaDNvQk5BaSt1Y0RYc3NQ?=
 =?utf-8?B?ejJ3bGZ6dUV0WTIxZDBNcFpCc1BnclYyYzFrL21OUkNtd3UzY3VJR2hsMVRZ?=
 =?utf-8?B?d1JOa0xJcDNLK0dBQ1VTTE01SGJMYXliVFJYRHNkWnZYcEpxVWdEUjZlSUgz?=
 =?utf-8?B?OWZZUlNpN28zeCtaZ1F0WVJUdEtkbnAxM2RFN1ppNHVzZjFZYkhvSk1IcU9K?=
 =?utf-8?B?U1pwdVZMODROaCtyYWZxZFE2SVppbDFidFBXOHd2ekZhWndmT21iNzdUNGho?=
 =?utf-8?B?ZnI3WDFxWjY2TXI0SitVWlNPdGRXSEQwa2FWdTJoTzI2SkdLRkxCNGRseGRJ?=
 =?utf-8?B?KzVsRHl6alM0UXg5VElqNGg4bzZab3JIK2wyUVlhV1RhbmZvei83Ty8zZFJJ?=
 =?utf-8?B?NVQ4SkwvT1Z3bzUxcUEzQ3JqdlVVZEg3cTdUN2QwK09JdlcrNEUwWW83VSs4?=
 =?utf-8?B?T2VlQVpGUFJnUWNyMDJSQTBTck1BcFU3S3Q0UUR0V0tmeXM5MURuNjhydEM1?=
 =?utf-8?B?ZjUrdklnckpXRm1hOTA1R2kyUHZqNzg5VXNxbThDTkEwT1Zkb1pmbVhrTHRN?=
 =?utf-8?B?akVadmhGVDB4ajYreENqZXN2Y3gzbzRPY1JSMDY1Wm1IZlpXVXZ3UVhRdXYy?=
 =?utf-8?B?cGZicGg3OVNXQnhvdU84akFOU3dlVVZBRmFzRlRLV3pkb0k3VDNCTk1uYnNx?=
 =?utf-8?B?UGQ3cTdFaFgyMFhlanZIQWRLQWRpSlJKTXErdVZrU3VTSzljbG52Tjd4YU83?=
 =?utf-8?B?MlFrNjJjeTVQaDRYWU1IeVhkRlRBK1JybUZEQnM2QW5lbllMVjlHSkF3TDJP?=
 =?utf-8?B?UHovTUlwMzk4aFVtTVVZdTkyUTFYaEQydHh1N29kZEFCZlcxcGJmNlBjOEJG?=
 =?utf-8?B?SFRSNS9wS0lNbWtJTDZjM0lvVWk1RFI2YkxrbzlyMGtWSkFXRmR4ckFYWFl0?=
 =?utf-8?B?amhXVlhpSmtWa281R0JEOUt4TlVyZUVVSVpGbmxJNzRlanBlSUQ4aWhaQ05z?=
 =?utf-8?B?czZpYnhub3RvcXRSdUliak1pcnR6a1RXZjdjdTJubC9QYUJQdnFwOWM4MStU?=
 =?utf-8?B?NHVxb2R3bzB2bno4ak01Ym9PS3N1MGthckpFbUUyN3JEY0JFOE1ZbDU3TWg2?=
 =?utf-8?B?eVBjYzFwdWhrUi9vVVBtMFhEbmI5R0ZseTAvVXBGSGdXQTdQQXpEcFNMMThL?=
 =?utf-8?B?ODY3QlBpaHFBcmlPWkIrdkVaMlY2bEh6dmJLNFRjREFiRUlzK211MzhuRSsy?=
 =?utf-8?B?dG5LQUN5VUk0UjFCcVIzUkwyQXlWbllENzZtaXg4MmJRYWZ4Q0NncUdiQ3VB?=
 =?utf-8?B?U0xHVnl2TENqSjNRUExaZFdHOGZ2bnkvMG1xdHNuc2tNTU51bERqNGdEN2NF?=
 =?utf-8?B?T3hRSlduRmV0dnFkNDkrNHl4ejlCRjNDcWZsRWtuNFRaTVc2UWVSSTNjbXJa?=
 =?utf-8?B?ZEpuSEpyWTl6K1l5RC9QK2dteTdjNi9JbnFqa1BBcGtUTlBqdk1PRnZBbmdZ?=
 =?utf-8?B?ZGpqRis1NElHaVBSN2JCVWM2VG15M2FOZXA3OE8yR05iVDNOTnAySnRSM044?=
 =?utf-8?B?QmQzaDNQTWdoTitGTW9pdld4T2ZTU24rK01ONUpyVnhEVFVkYXV1elZaSEIw?=
 =?utf-8?B?MnUwT29uaEo4RlBPdWlhWVRxUk0vNkE0YXA3ekZKSEN2MXd6WmwrM0RIYUl0?=
 =?utf-8?B?VnYrUFpneEMvTE9JdEhFdHlYQjNKYjRzams2SUNDZW9Cem1NdDByMUlIN1F1?=
 =?utf-8?B?VXh3WGRaZEUyNWZ6TG52SGl2V0ZIQ3kyUFFFaEdZSVVRM3VPWU8yRkZEQTE3?=
 =?utf-8?B?UG82SkF3anhhVGpycGJGYm9aanE1NFNVVi9IdzNiaDQ5NmlEZjR1SmxyR2tj?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9480857EFF24947951FBA53ECFB8858@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DxqJH4PmEPBtvNCAUHOt9QgTQTTej6oO3r2zYM5pjbrEbexUzQyz0WOO/+ycdv+Pk6YUBLJkTt+W3tMjhajoHQRlnUuu5HVbK2Pp9G0krYKtxQUNbT5IvDkwDYA07hhRMODEIVDHzICNcOGc+/yZYjrDl4DKjWkuWsF60Oh0dw/8ykHPhGxOVJ07clY8VKjdVbE2NnxscXbPW3uIFH7bidc+Fx54I/61Aa88w4WfDJbEQychl0q401K+M58PEppsowRdLkpUPl5GIuO2gARvpK9JZjq4zJ1Sr0FNHHkctxBAHbgO4Dce8//LpsO8m/zw4MZMAngBqj/ncAxlCOspgHlHH8vaF2BzOuKACLrg8NCa5zF2dMH6IjRhKECTk4gAzMW3QFMO3Wp7Pe98vAYcebXXnkvgcCJSA3416YKO8dSc/DMX38kzvNFkha5R2E5D8E1LOIUykAgGy/3Ey53BVzHMk6Kg94TTFgsLS+wCs9tNCEmNwHpJ5D2U0x55xpMFs8RPy7JlAgRrC3RuAjIvjZv8UrJE+BpnFQyz5I4Q2+2OeBZh34SttJHX1lHKMAV4ybVrGF/3/ISnszPRaKoloV4vPg6RgDW5N069E9k9+fL0gKABzuwMbIWWKcLwxzeO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1566.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811040b9-8811-4c31-8e8b-08dd3500d4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 01:06:24.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRVzU/p/jg6DFbFgQ43rQcNWEOioggyA8jy6ljYE1AmLTk5gjCtfSWdDZSlpc774v0cVu1hBg3RQ+6eWxYdZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10125

Q2NlZCBRRU1VLA0KDQpIaSBGYW4sDQoNCkkgcmVjYWxsZWQgd2UgaGFkIGEgcmVib290IGlzc3Vl
WzFdIG1vbnRocyBhZ28NCkkgZ3Vlc3MgeW91ciBpc3N1ZSB3YXMgY2F1c2VkIGJ5IHNvbWUgcmVn
aXN0ZXJzIG5vdCByZXNldCBkdXJpbmcgcmVib290Lg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtY3hsLzIwMjQwNDA5MDc1ODQ2Ljg1MzcwLTEtbGl6aGlqaWFuQGZ1aml0c3Uu
Y29tLw0KDQoNCk9uIDE1LzAxLzIwMjUgMDQ6MzAsIEZhbiBOaSB3cm90ZToNCj4gSGksDQo+IA0K
PiBSZWNlbnRseSwgd2hpbGUgdGVzdGluZyBjeGwgd2l0aCBxZW11IHNldHVwLCBJIGZvdW5kIHRo
ZSBtZW1kZXYgY2Fubm90DQo+IGJlIGVuYWJsZWQgc3VjY2Vzc2Z1bGx5IGFmdGVyIHJlYm9vdC4N
Cj4gDQo+IEhlcmUgaXMgdGhlIHNldHVwIGFuZCB0aGUgc3RlcHMgSSBoYXZlIHRyaWVkLg0KPiAN
Cj4gUUVNVToNCj4gaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11LmdpdA0KPiBi
cmFuY2g6IG1hc3Rlcg0KPiBjb21taXQ6IDgwMzJjNzhlNTU2Y2QwYmFlYzExMTc0MGE2YzYzNjg2
M2Y5YmQ3YzgNCj4gDQo+IEtlcm5lbDoNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvY3hsL2N4bC5naXQvDQo+IGJyYW5jaDogbmV4dA0KPiAyZjg0ZDA3
MmJkY2I3ZDZlYzY2Y2M0ZDBkZTlmMzdhM2RjMzk0Y2QyDQo+IA0KPiBTdGVwcyB0byByZXByb2R1
Y2UgdGhlIGlzc3VlLg0KPiAxLiAgc3RhcnQgdGhlIHZtIHdpdGggY3hsIHBtZW0gZGV2aWNlIGF0
dGFjaGVkIGRpcmVjdGx5IHRvIFJQLg0KPiAyLiBMb2FkIHRoZSBjeGwgZHJpdmVycyBjeGxfYWNw
aSBjeGxfY29yZSBjeGxfcGNpIGN4bF9wb3J0IGN4bF9tZW0sIGV0Yy4NCj4gRXZlcnl0aW5nIHdv
cmtzIGV4cGVjdGVkLCB0aGUgbWVtb3J5IGlzIGNvcnJlY3RlZCBlbmFibGVkIGFuZCBzaG93biB3
aXRoDQo+IGN4bCBsaXN0Lg0KPiAzLiBSZWJvb3QgdGhlIFZNIChydW4gcmVib290IGNvbW1hbmQg
aW5zaWRlIHZtLCBubyBzaHV0ZG93bik7DQo+IDQuIExvYWQgdGhlIGN4bCBkcml2ZXJzIGFzIGlu
IHN0ZXAgMi4gdGhlIGN4bCBwbWVtIGlzIG5vdCBjb3JyZWN0bHkgZW5hYmxlZC4NCj4gDQo+IGRt
ZXNnIHNob3dzIHNvbWUgZXJyb3IgYXMgYmVsb3c6DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gWyAgIDE3LjEzMTcyOV0gY3hsX2NvcmU6Y3hsX2hkbV9kZWNvZGVfaW5pdDo0
NDM6IGN4bF9wY2kgMDAwMDowZDowMC4wOiBEVlNFQyBSYW5nZTAgZGVuaWVkIGJ5IHBsYXRmb3Jt
DQo+IFsgICAxNy4xMzUyNjddIGN4bF9wY2kgMDAwMDowZDowMC4wOiBSYW5nZSByZWdpc3RlciBk
ZWNvZGVzIG91dHNpZGUgcGxhdGZvcm0gZGVmaW5lZCBDWEwgcmFuZ2VzLg0KPiBbICAgMTcuMTM4
NDI4XSBjeGxfY29yZTpjeGxfYnVzX3Byb2JlOjIwNzM6IGN4bF9wb3J0IGVuZHBvaW50MjogcHJv
YmU6IC02DQo+IFsgICAxNy4xNDExMDRdIGN4bF9jb3JlOmRldm1fY3hsX2FkZF9wb3J0OjkzNjog
Y3hsX21lbSBtZW0wOiBlbmRwb2ludDIgYWRkZWQgdG8gcG9ydDENCj4gWyAgIDE3LjE0MzcwM10g
Y3hsX21lbSBtZW0wOiBlbmRwb2ludDIgZmFpbGVkIHByb2JlDQo+IFsgICAxNy4xNDUzMjRdIGN4
bF9jb3JlOmN4bF9idXNfcHJvYmU6MjA3MzogY3hsX21lbSBtZW0wOiBwcm9iZTogLTYNCj4gWyAg
IDE3LjE3MTQxNl0gY3hsX2NvcmU6Y3hsX2RldGFjaF9lcDoxNDk5OiBjeGxfbWVtIG1lbTA6IGRp
c2Nvbm5lY3QgbWVtMCBmcm9tIHBvcnQxDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiBDb21wYXJlIHRoZSBzdGVwIDIgYW5kIDQgd2l0aCBkZWJ1ZyBpbmZvLiB3ZSBjYW4gc2Vl
LA0KPiBJbiBzdGVwIDIsIHdoZW4gZW50cnkgZnVuY3Rpb246IGN4bF9oZG1fZGVjb2RlX2luaXQo
KS4NCj4gDQo+IChnZGIpIHAgKmluZm8NCj4gJDIgPSB7bWVtX2VuYWJsZWQgPSBmYWxzZSwgcmFu
Z2VzID0gMCwgcG9ydCA9IDB4ZmZmZjg4ODEwOTdlYWMwMCwgZHZzZWNfcmFuZ2UgPSB7e3N0YXJ0
ID0gMCwgZW5kID0gMH0sIHtzdGFydCA9IDAsIGVuZCA9IDB9fX0NCj4gDQo+IFRoZSBpbmZvIHN0
cnVjdCBpcyBmcm9tIGN4bF9kdnNlY19ycl9kZWNvZGUoKSwgd2hlcmUgaWYgbWVtX2VuYWJsZWQg
aXMNCj4gbm90IGVuYWJsZWQsIGl0IHdpbGwgcmV0dXJuIGRpcmVjdGx5IHdpdGhvdXQgcmVhZGlu
ZyBkdnNlYyByYW5nZSwgc28NCj4gcmFuZ2VzID09IDAuDQo+IFRoaXMgaXMgd2hhdCBoYXBwZW5l
ZCBpbiBzdGVwIDI6IG5vIGR2c2VjIHJhbmdlcyBhcmUgcHJvdmlkZWQgdG8gdGhlIGZ1bmN0aW9u
IGZvciBjaGVja2luZy4NCj4gDQo+IFdoZW4gaW5pdCB0aGUgaGRtIGRlY29kZXIgaW4gY3hsX2hk
bV9kZWNvZGVfaW5pdCBmdW5jdGlvbiwgdGhlIG1lbW9yeSBlbmFibGUgYml0IHdpbGwgYmUgc2V0
Lg0KPiANCj4gSW4gc3RlcCA0LCBhZnRlciByZWJvb3QsIHRoZSBlbmFibGVkIG1lbW9yeSBlbmFi
bGUgYml0IHN1c3RhaW5lZCBhbmQgdGhlIGR2c2VjIHJhbmdlDQo+IHJlZ2lzdGVyIHdpbGwgYmUg
cmVhZCBmcm9tIHRoZSBkZXZpY2UgaW4gY3hsX2R2c2VjX3JyX2RlY29kZS4NCj4gU28gd2hlbiBl
bnRyeWluZyBjeGxfaGRtX2RlY29kZV9pbml0KCksDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAkMiA9IHttZW1fZW5hYmxlZCA9IHRydWUsIHJhbmdlcyA9IDEsIHBv
cnQgPSAweGZmZmY4ODgxMDNjNzc0MDAsIGR2c2VjX3JhbmdlID0ge3tzdGFydCA9IDAsIGVuZCA9
IDUzNjg3MDkxMX0sIHtzdGFydCA9IDAsIGVuZCA9IDB9fX0NCj4gQnJlYWtwb2ludCAyIGF0IDB4
ZmZmZmZmZmZjMDY1N2JiZTogZmlsZSBkcml2ZXJzL2N4bC9jb3JlL3BjaS5jLCBsaW5lIDQxNi4N
Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IEl0IHdpbGwgY2F1c2Ug
dGhlIGR2c2VjX3JhbmdlX2FsbG93ZWQoKSBmYWlsaW5nIGFzIHRoZSByYW5nZSBmcm9tIGR2c2Vj
IHJhbmdlDQo+IHJlZ2lzdGVycyBzdGFydHMgYXQgYWRkcmVzcyB6ZXJvIFswLCA1MTJdLCB3aGlj
aCBkb2VzIG5vdCBtYXRjaCB0aGUgaHBhIHJhbmdlDQo+IHN0b3JlZCBpbiBjeGxkLT5ocGFfcmFu
Z2UsIGNhdXNpbmcgdGhlIGlzc3VlLg0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+IFRocmVhZCAxIGhpdCBCcmVha3BvaW50IDQsIGR2c2VjX3JhbmdlX2FsbG93
ZWQgKGRldj0weGZmZmY4ODgxMDhhZjk4NDgsDQo+ICAgICAgYXJnPTB4ZmZmZmM5MDAwMDU5Zjli
MCkgYXQgZHJpdmVycy9jeGwvY29yZS9wY2kuYzoyNjUNCj4gMjY1CQlpZiAoIShjeGxkLT5mbGFn
cyAmIENYTF9ERUNPREVSX0ZfUkFNKSkNCj4gKGdkYikgYiAyNjgNCj4gQnJlYWtwb2ludCA1IGF0
IDB4ZmZmZmZmZmZjMDY1N2QzMTogZmlsZSBkcml2ZXJzL2N4bC9jb3JlL3BjaS5jLCBsaW5lIDI3
MS4NCj4gKGdkYikgcCAveCBjeGxkLT5ocGFfcmFuZ2UNCj4gJDUgPSB7c3RhcnQgPSAweGE5MDAw
MDAwMCwgZW5kID0gMHhiOGZmZmZmZmZ9DQo+IChnZGIpIHAgL3ggKmRldl9yYW5nZQ0KPiAkNyA9
IHtzdGFydCA9IDB4MCwgZW5kID0gMHgxZmZmZmZmZn0NCj4gKGdkYikNCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFRoZSBocGFfcmFuZ2UgaXMgc2V0IHdoZW4gcGFy
c2luZyB0aGUgY2Ztd3MgaW4gX19jeGxfcGFyc2VfY2Ztd3MuDQo+IA0KPiBBbnkgdGhyb3VnaHRz
Pw0KPiANCj4gT3BlbiBxdWVzdGlvbjogZG8gd2UgbmVlZCB0byB1cGRhdGUgdGhlIGR2c2VjIHJh
bmdlIHJlZ2lzdGVyIGFmdGVyIHdlIHBhcnNlIHRoZQ0KPiBjZm13cyB0byBtYWtlIHRoZSB0d28g
YWJvdmUgbWF0Y2gu
