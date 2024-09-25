Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28EA1849
	for <linux-cxl@vger.kernel.org>; Wed, 25 Sep 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223635; cv=fail; b=eCRf7E9ByydYBGMdsQ/PUj05Z6JZjj0r4yvlqmjHWc/eduY3cHZmdtnliI+Rh9lmxjr5BN9lWTdmrpBYo+OSd4YInRnNNpvx5bRckbHuPG9QWiU/6J7TDlJ401HCUr7B/YGegHVdsct3xv1UlnNDGjaboHeIZ/HyqnwujvVHLes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223635; c=relaxed/simple;
	bh=EOECh8enY+O41T4Jy5Mrefv7ppBICoJRKRWVNpCYefg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fel5LE3zzE2sGm4DzMOf8bqEVp1bxFDb4ZqoS97KSD8k+mE1D1PCYGXELppALMGEP0zLMjPXXN8cX89VeJIz4e3GRrK6zQ12Klk1nEnQ7c0JBs21HXJ8JOUygUjn1iqfeOS+cvaW+BaavkMBDFtJmf/mpCDVuffpbDh3kyB5dII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IsU3n1oc; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IsU3n1oc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727223632; x=1758759632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EOECh8enY+O41T4Jy5Mrefv7ppBICoJRKRWVNpCYefg=;
  b=IsU3n1ockNi3VyKqmyjvR+rGHA02B4Kf94v7uHbFlrz7Xx0HkKaVDKiT
   OMFCm80Kn7pxmy1uiMQauxls9kGuej0UJJK4xPzAgvRBWSYCnmTG5UIdr
   0HcPpIhsJ36jE2j/XIXaL0pxRVq6Zjy8RVxmrLOde5M7kDX6WbhQYRIAR
   vP1glm0z4x1WM8cVUE18IKtSwO4Zf2c+nQgB5N7qMP+AozYEOC7wiOFLa
   kSbQF/sJEfVZZhEfEypHqZxgXXYlrSjgRx7W5KigQrlKHR6fJNes9Mmmp
   kqeNLH5kxe0V9RxjhcHwQkxxZm6a54ES7BY42jBmyjrBOsUFR/SKr/x/T
   w==;
X-CSE-ConnectionGUID: 9yApQO30T5mED46PL8ZN8A==
X-CSE-MsgGUID: mDHMve9aSpOgXuEGERI0RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="132131516"
X-IronPort-AV: E=Sophos;i="6.10,256,1719846000"; 
   d="scan'208";a="132131516"
Received: from mail-japanwestazlp17011031.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.31])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 09:20:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYGvhfzINtOK3RNIwHpSoRTDn+I7i3l0VaI1RdEGvaHi3nfgQdGhVn6q+yzrzQQSgg/v7KwWALfb2G4smHALlnSoQ4fckQQUbQD1MdkS5w+ZVuoZjSf+HsxB75/o8nJHg9WNmpBhnHk8z/Xj9LXPz5rN9J3hZcv/ApdYuakFA/jupOTdwngF9+P91RMSxIa8Jb2OLYLoyW5MnvVW2XFFU24JgO/gw8qYeZ+otkA0WTdRn//hGLPAKabnaT8OKOU3w0BSpGzxB0JKcsaR8VEv40sHm9ADWBOLPJglAVKUDPjAmnOZ48QZNQLkWbA+eeKKTssFo4qTH7UqJUoJSTJIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOECh8enY+O41T4Jy5Mrefv7ppBICoJRKRWVNpCYefg=;
 b=Ov4p4N6CMU9m4gvQSb1NHV7mKbjAPxVnDbYEE1X5T0ftA+1ZxeMVOCqY9w5kaYodzsSMOiNkHCi0Qbzh1xGd7DkPPQL9nUr0XmlEgz8AjDB4bj5u3U8EFcpSlt6bq5PDO1+z1ZIvEbAgWHaUsZfNhGPKOzGZCv2q5spLgRB8jRlCZX/rta9vQmDttjlgptK9AK8Yr6TEdCpImJWW86mN5DNT5V9UjWN55i8GknJuEE4USwDiv9yGkvuojPKS8/0Wo50KK3hy6dxt35jFQwqhn9KGdeWl1iaTYvNPrMrNAqIwGofMkAvlN3h/WZuZ47v/9Z+ifQkKaJp5YWbgMHe6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TY3PR01MB10596.jpnprd01.prod.outlook.com (2603:1096:400:318::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 00:20:23 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%3]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 00:20:23 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dave Jiang' <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
CC: "mj@ucw.cz" <mj@ucw.cz>
Subject: RE: [PATCH v17 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Topic: [PATCH v17 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Index: AQHa/azqdXMWHjCNtEO8fXwO2aK/wLJmqpZggAB2BQCAAKRK0A==
Date: Wed, 25 Sep 2024 00:20:23 +0000
Message-ID:
 <OSAPR01MB71829C78947C2FC023CD0DDABA692@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240903025915.270521-1-kobayashi.da-06@fujitsu.com>
 <OSAPR01MB71827E711822FF4DD30C8A58BA682@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <e4b76403-2e1e-4c5b-ae02-e09d97384c0a@intel.com>
In-Reply-To: <e4b76403-2e1e-4c5b-ae02-e09d97384c0a@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZmE3MTQ2ZjYtZmFhNy00OGY5LTg3MTYtNDljZWMxNzY1?=
 =?utf-8?B?MzU5O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA5LTI1VDAwOjE3OjM3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TY3PR01MB10596:EE_
x-ms-office365-filtering-correlation-id: 093b5075-6df8-4ad3-ce93-08dcdcf7d8ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWZDRkkyc2FaWHV3WFplQkJ0MklpRm1SMTN5dUI3MzVNcjN1enVCU1ZoV1Jp?=
 =?utf-8?B?OVBmWTQ3bkNkUEZYY3JFWjdHdlhkL0YzM3JRVFV4MnZmVk8wbi9SemE4WjN2?=
 =?utf-8?B?NTJaeUF4V28xM3JhTW5wTzlQeGZtaktzeXkwSytKdSs0cW1acTFNNXZKWUh3?=
 =?utf-8?B?TUsrZCtOUTExWFp4dmxrY1BCMldscTFyeXpCMXhodEpIVDJTYUJSZ2tpelRL?=
 =?utf-8?B?Vk1DWGhmODhYLy9iU29FZ3hEZGlBNEg3clpOSlBhRFRJOVJIQkJOVGdEZGpH?=
 =?utf-8?B?TDVyR3lPekFUWHF2WGZvNDFtSVpwdUt5a2w0YmU0bHBuV0oxWUh5RUdqRTkr?=
 =?utf-8?B?Vkp1ZER5YVoxQ1BNQWtYbjU5eXRwQ3JldUd4SXExbVIzdHZyMnNZS2JUajJX?=
 =?utf-8?B?cVdaY0IyQThpQVBvZmdOeUlmVWMzMnVIa2JkMVVtZnM3TU5JeWxpVlAxSWE3?=
 =?utf-8?B?dHdKYk0wcmhVcTFMOHhjM2p0V293SVRoZTdHdU1odDFhcC9VV1NoMGVCYXdm?=
 =?utf-8?B?WlN3QzNvMkgyc3FtUU1YdDIweks0aG0xTDlkZDA4THdINTV1UC84TTdOQ053?=
 =?utf-8?B?UXQ5dWNIYVA1L3dEQ3BSMmdOcW5sbDZDRFNrbUVjaWpUOHo2NUNPWnI0YU1h?=
 =?utf-8?B?aHAxcWwrNE1PMWk1Sm1IbkI1NUlCU3lkeUg0cnY1blI2VkozL2hOdHBvb3VL?=
 =?utf-8?B?NS9wRlJYcDhZODVISUNjSHMzcVZxR0c4UWdvSm4yV1R3UTZZVkV0ditMYzhC?=
 =?utf-8?B?SU94UWJNUm1WdnZ6OTRMdjhuU1gyTzk2UXJaVnlhNjJVZHZDNmdBTWVtRklT?=
 =?utf-8?B?V3dMNzRDOGd4M3lWOTJZYUJJbllrR3lvaitJenRDSS8rVGNMcmd2T2c0QXpw?=
 =?utf-8?B?bmhTMU5hd0ZNbzBYbGRGNlFtOEx3YWFBTnVCeUdXUExOWTlkb29QalN3ZDZs?=
 =?utf-8?B?QldUa2tJakFsOGFIQXNjdjYrbldscmxPT2R4Q3Axc214aUJsZGJyc3IvSVVp?=
 =?utf-8?B?ekkrYmhGeXMyUGMwWFVUaDltTVQrMGorckxBYnp5dzk0bjFhTGlRSzhnd01S?=
 =?utf-8?B?aE85U00zN3ZkRW1NeHBUamlHQy9vcmJsNmZpNUQreVBEQlZMQ1E5aFI4OHI0?=
 =?utf-8?B?OTNjZUZqMFE4c2pqYzB1YnkyTG5IUmwybGdSSUtMb1RLU2YxcS9oUHpUNSs1?=
 =?utf-8?B?cVRvTFVPOWRKVmZHdFdOTnVoYlpRZkIwNzRkbFJldkQ2cjg0bW5aL2lNSHZJ?=
 =?utf-8?B?ZE5VbjlVc2tRMjhndExQaWJ0NGRRZjRoNVR4UlU5RENUSTZpQXBTU2IxamxI?=
 =?utf-8?B?ZVl4TWtKdmZrOEpZdE1wR2xoaUc1Mm9Dd1NjZTd1Q1ZnQm5IaVRoN0JwWXEz?=
 =?utf-8?B?THI2eGdmUFJnSWVmdFRmL2FxOTFjT3dIT1NrM2hpb0lWQ0poWDZwUGRHbDlu?=
 =?utf-8?B?cS8xa09wTDR2OGJGMDM0VEtHQkdjR3hlYjkyNUVyc0NvYnNLS1B6ZFR2ejJa?=
 =?utf-8?B?czhFS29pQzB0dHpCNVR2R0VIMGpqZDhTeFFLbUxyNVIzWDNkRElncVNJbTZH?=
 =?utf-8?B?S0pXSXQxWXFpdXp3WlhrSEtJbUZpS1ovWUtYRTVzcnFHMG9IU082MjNqM1Br?=
 =?utf-8?B?L01DVUNJcCtyODZKNU1JNTFQcDI2MFc4Y2o2akVHYUxlcFhOWldTc0dXODdR?=
 =?utf-8?B?SmUyNWFqRHI5WUdRREdPOHltaENEUk5mRDgrUUdQV1JidEZna1lwV1diNWhz?=
 =?utf-8?B?bWQ2Q2JEZW1ESEw1Uy9EOHVVQ1MyMFV1a3pyYW5NRXBmb2pjVUJCL3NNdXlZ?=
 =?utf-8?B?RmlZV3c5Rjl6QWhOdEVSVVI5ZEJyR01yaFJPZDd1aUROYTk0TmJ0VHA4Y00v?=
 =?utf-8?B?UDJBSW5SU09QbHo0bXdQSHQrRkR6MHBPa0lTUHZlRXIwWi9Xd3FpaHJiRWJV?=
 =?utf-8?Q?tQ1grn6dyIUUmNp+ZV0CQkF5QDQNNsyV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1kxV0doN25nby9ueGNFTHEyUS9sdnErTnl5RFl5UHI2QzhlVzUyaWM1Qkh3?=
 =?utf-8?B?Z0Q5TFBqbUJ2L00xVkNPdVdEUjdwQ0dVT2dNUE9na1lmNDU4Z0YzclZHcVZF?=
 =?utf-8?B?TnQwUHFXQ2h6MHpkREN4TE1JRVN0UmFweGx5S1pXc2Y2SEZDMTA1VG5obER3?=
 =?utf-8?B?aGNjblZEbEpUdDU3ZjFvaXFlZnVYc3paWkgzUTd1Vzc0djdGb1F3aVlsdUlO?=
 =?utf-8?B?RjBSQzlEQU5FOUs3SFJmQ1FUbkxRSDhqWXg4dHBDYVVSUUdtRUZoTlhLTXlF?=
 =?utf-8?B?TWV2NXN1bXB3Unc5SUM5WTJjRGU1R2hKdnNneG5VQTlpeExPVTdPeW1EYVR1?=
 =?utf-8?B?R1B3NWxSUHBoMWhBRlJab3RSdUx0blJTRlY2TEJISit0Zm1pWXExd2lPNDRV?=
 =?utf-8?B?Q0J0QzhRYmhtVFpTV1hwSms3aXcxQXVrYzMvWDhSank5RGg3OXZSbUltSmJZ?=
 =?utf-8?B?UXJqb1FFdUJiZEZBTGFVUVo0TTg1eHVqS3FQYUJKeXJmaE5uUmJXa3AzSldD?=
 =?utf-8?B?WFpSdVpMdjV5VmVxejlxNXcxaFpsQkc2NXl2dGFJN1FOZW50ZWthanBuOHZt?=
 =?utf-8?B?Wno1cG9GVzVnUXM5TFcrWXFBdjJtN3BqRCtxdnJkcmFWMGVlWHQwc2RpbFpw?=
 =?utf-8?B?QVp2dTdZTW1rTmtkWDRuUGdMWHdUQktXalN5ZVErLytNN1lXS3lSMjUzcUtn?=
 =?utf-8?B?SW1sbVZKMVJaUzJzcVc3Zkl6VUxhdXVhTjBPNy9KbVlXeEljWFR4ZnhHamwz?=
 =?utf-8?B?YUczNWVxREwwdWt3TGpaeXhzcTVuNm82Q05PVnhHYmV2TWhwOHJwQWJkclc3?=
 =?utf-8?B?NHV4eWl3NXdIczJmdGJxK0V3WU1HU1lSNXlUcUZMcnlhdXd1NHJRRGJZemh0?=
 =?utf-8?B?cnNqN0x4anZ2ckdsdWtObzcxWW9mNkxpRXNOVHlBTVFXZDNCWHVGeXlweVlH?=
 =?utf-8?B?RkhHMUhvQnJKeDk5TmJQS2NnZUg3NVZlcUgxYkxQc1phMGJoUjJJcU9xaThh?=
 =?utf-8?B?OXBicHpaSmllVWlWY2RTaW84dWtlV0R5RXVDVWhNTjVIN1dzSmhVeVFWb3V4?=
 =?utf-8?B?OXFNZUxjYUlqY2pqM2gwcXNWOW9iSmZKWTVJRW9UYUVhUDcwV0w4b0FYcXRp?=
 =?utf-8?B?Si9SQ2xnKytaREM3dUtPWnBBVk1aSFZ2WG1lQ0Zpamk5elVKOU1mTjVJQnl6?=
 =?utf-8?B?UEtRV092aHVJUTAxK3VvNmlQdkNJSmhwTXhxR1ErQlkyUUhOL3Z6OW4wOTA1?=
 =?utf-8?B?djRXK3liYklXMFFhcW84TUhrVDhwVGNjc2ZWdUc5NjMyc0lOYStydVlyYzN6?=
 =?utf-8?B?YUR2bUdvWlQ2dHFCMzkzczNwczNOY2VNVFFWd2xJcTdENHk2M3JqS01VVVZj?=
 =?utf-8?B?T0dCdHd5ZDNPOWl0ZG10UXplRFFFMDJtKzJwNHpqUXMzUEhYOXU1NVhLQXJo?=
 =?utf-8?B?amk0Zy80N2VmcEd0WUpkcW0vYWYvWXY3WGVWdzZVV2p6a2pTSGIxMHJueHE5?=
 =?utf-8?B?K2RMUnhTNkxwWnJtajlIUHZiSmU0b3dYZjBYRGZFalIrSmRhM21CNFhWekRu?=
 =?utf-8?B?RFQzeDY2cTJPQm1JcmlEQWZqek9sSHNQTVlFSFZQL2pxYkl4WjNIT1dGazlM?=
 =?utf-8?B?b0ZzVGtXUHhwR05PMkk3SGdMV1JNVStqeElDRlBQaU4vUG9hRVNVaE9WeHJS?=
 =?utf-8?B?Wi9oZEt6UXB0KzlGWmJ0L0ZRMDhFVmFtamtuTTMzN0paMExRQ0pXQjJScDlM?=
 =?utf-8?B?MXFwR0tZcnlzZ1dLVHFVcXFiVGFSeWpnNU93Z01WTkJSZ2RrSExpRkpUR1lQ?=
 =?utf-8?B?SnQydVNrTlFKWHZaSHU0VTBFbDJqQTdZZDRYalY3SG9HUWpidER3cC9GVHFr?=
 =?utf-8?B?QlZXMjJ3YVExYVZjejhiVWI3Y1gxamMrV1hCUnR2dW0wZkwyeS9mcUV1K0Rz?=
 =?utf-8?B?aDM5eURpTVpOVDBtUklid3htbWFRRDFHZDVrTEJVc1BrZkNjWEg3L080Wklr?=
 =?utf-8?B?ZGZXcEVLOHUxdjM0cm5sZ2VNRU8wa0pPOFhiQlpZczRpV29DN1pCZXlnS2w1?=
 =?utf-8?B?Z2FQckpENVN2OW9Cbzc3clV4QXV5RGV3enFMZ1R5NlMxMHlKTzRVNDd1RkI2?=
 =?utf-8?B?NTFHV3lGU29aR1JTazFJNGo5QVZZS3NEdnFJZEFpcVVQOFBQV28zazlWUDhn?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZiK9Cae/jr+lTFUdYULxvyCwajGLerDCBAtWaCy27KGyt1jbWYS8rV9NLhaDLPobuaNEyBlfaNmmA/9zYhOw59s6D5jKuoJkOp7F2vh3mOTCQIfUzy+sQ48jQhyaMCO4RJ0JkPy40swROvXD9T/ZPrs3orBR6cLyOqNTKaIONilIAUfwWFgaKaK0RMTHVvrOmQXDyhpWFLgw17gLnh97yt8kQ2iTi10kbW0GJ74PltniynOrihCYk7wwlqBq/XFFYL0pIXdD9Fj/1+RrCFr7bUZkO7S7KoL6cp9LGZDTnlqMWeb2AO6cBQffzyDBIRcIev+zkqzdCWx/Puk2orLVoRKOs2cJl75jAallrxPi1PVC8pcTgaFp9B7EzPnW7QVfaDZWcgeRIzdaOErwvOqs5Dn+Milu6tD8bkVRsnyLNAGskkw91g1klJT3cHX+6phBxgkX3QPyKLMsEM5oBnHQrjl8h9e2pUfhM4ettqzNYVtg4WmCBnTkYAolOO7RgwLp8SDrCGRvQfanuBYS4p5fQJbLsIRuXgPtgUZFy0oTF8XjZ8EtiwJCDp/77FiZTok2FLIFw1R7C4WdCCKrlBj/+EpF8cvsWqDAaKuXPhKjnZiNCPUsH6a8xeXba3Hcw7Ux
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093b5075-6df8-4ad3-ce93-08dcdcf7d8ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 00:20:23.0567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNSHKtxDOY2N9HYNBulfDPoE0A6rRnvjc9kacfCNYxhyo++1rhZR24Pfg3y1Nihl8v3TfQrjUAGhYPqOhD1kqOX1bcCQqV4xEvEkWt2gGL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10596

RGF2ZSBKaWFuZyB3cm90ZToNCj4gT24gOS8yNC8yNCAxMjozNiBBTSwgRGFpc3VrZSBLb2JheWFz
aGkgKEZ1aml0c3UpIHdyb3RlOg0KPiA+IEhpLCBEYW4uIENvdWxkIHlvdSBwbGVhc2UgcmV2aWV3
IHRoaXMgcGF0Y2g/DQo+ID4gSSB0aGluayBJJ3ZlIGZpeGVkIHRoZSBpc3N1ZXMgeW91IG1lbnRp
b25lZC4NCj4gDQo+IEhpIERhaXN1a2UsDQo+IEluIHRoZSBtZWFuIHRpbWUgY2FuIHlvdSBwbGVh
c2UgcmVzcGluIGFuZCBmaXggdGhlc2UgdHdvIGtib3QgaXNzdWVzPw0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1jeGwvMjAyNDA5MDQwMDExLmthYWpOdUNiLWxrcEBpbnRlbC5jb20v
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDI0MDkwNDAwMTAuYWZ5R2NX
VWUtbGtwQGludGVsLmNvbS8NCj4gDQo+ID4NCj4gPiBUaGFuayB5b3UuDQo+ID4NClRoYW5rIHlv
dSBmb3IgeW91ciBjb21tZW50Lg0KDQpUaGlzIHBhdGNoIHdhcyB1c2luZyBhIGZ1bmN0aW9uIHRo
YXQgaGFzbid0IGJlZW4gbWVyZ2VkIHlldCwgYXMgcGVyIERhbidzIGluc3RydWN0aW9ucy4gDQpJ
dCBzZWVtcyB0aGF0IHRoZSBwYXRjaCBjb250YWluaW5nIHRoYXQgZnVuY3Rpb24gaGFzIG5vdyBi
ZWVuIG1lcmdlZCBpbnRvIHRoZSBjeGwtbmV4dCBicmFuY2guDQpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jeGwvY3hsLmdpdC9jb21taXQvP2g9bmV4dCZp
ZD1kZDI2MTdlYmQyYTY5YzAxMjAwMWEyOTI3NDU1NzE5OTQwOWVmZjM5DQoNCkkgYXBvbG9naXpl
IGZvciB0aGUgbGFjayBvZiBleHBsYW5hdGlvbiBhbmQgYW55IGNvbmZ1c2lvbiB0aGlzIG1heSBo
YXZlIGNhdXNlZC4NCg0KV2hpbGUgdGhlIHNpdHVhdGlvbiBtYXkgYmUgZGlmZmVyZW50IGZyb20g
d2hlbiBrYm90IHJlcG9ydGVkIHRoZSBlcnJvciwgDQpjb3VsZCB5b3UgcGxlYXNlIGFkdmlzZSB3
aGF0IG1vZGlmaWNhdGlvbnMgYXJlIG5lZWRlZCBoZXJlPw0KDQo+ID4gS29iYXlhc2hpIERhaXN1
a2Ugd3JvdGU6DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCB2MTcgMC8yXSBFeHBvcnQgY3hsMS4xIGRl
dmljZSBsaW5rIHN0YXR1cyByZWdpc3Rlcg0KPiA+PiB2YWx1ZSB0byBwY2kgZGV2aWNlIHN5c2Zz
Lg0KPiA+Pg0KPiA+PiBDWEwgZGV2aWNlcyBhcmUgZXh0ZW5zaW9ucyBvZiBQQ0llLiBUaGVyZWZv
cmUsIGZyb20gQ1hMMi4wIG9ud2FyZHMsDQo+ID4+IHRoZSBsaW5rIHN0YXR1cyBjYW4gYmUgb3V0
cHV0IGluIHRoZSBzYW1lIHdheSBhcyB0cmFkaXRpb25hbCBQQ0llLg0KPiA+PiBIb3dldmVyLCB1
bmxpa2UgZGV2aWNlcyBmcm9tIENYTDIuMCBvbndhcmRzLCBDWEwxLjEgcmVxdWlyZXMgYQ0KPiA+
PiBkaWZmZXJlbnQgbWV0aG9kIHRvIG9idGFpbiB0aGUgbGluayBzdGF0dXMgZnJvbSB0cmFkaXRp
b25hbCBQQ0llLg0KPiA+PiBUaGlzIGlzIGJlY2F1c2UgdGhlIGxpbmsgc3RhdHVzIG9mIHRoZSBD
WEwxLjEgZGV2aWNlIGlzIG5vdCBtYXBwZWQgaW4NCj4gPj4gdGhlIGNvbmZpZ3VyYXRpb24gc3Bh
Y2UgKGFzIHBlciBjeGwzLjAgc3BlY2lmaWNhdGlvbiA4LjEpLg0KPiA+PiBJbnN0ZWFkLCB0aGUg
Y29uZmlndXJhdGlvbiBzcGFjZSBjb250YWluaW5nIHRoZSBsaW5rIHN0YXR1cyBpcyBtYXBwZWQN
Cj4gPj4gdG8gdGhlIG1lbW9yeSBtYXBwZWQgcmVnaXN0ZXIgcmVnaW9uIChhcyBwZXIgY3hsMy4w
IHNwZWNpZmljYXRpb24gOC4yLCBUYWJsZQ0KPiA4LTE4KS4NCj4gPj4gVGhlcmVmb3JlLCB0aGUg
Y3VycmVudCBsc3BjaSBoYXMgYSBwcm9ibGVtIHdoZXJlIGl0IGRvZXMgbm90IGRpc3BsYXkNCj4g
Pj4gdGhlIGxpbmsgc3RhdHVzIG9mIHRoZSBDWEwxLjEgZGV2aWNlLg0KPiA+PiBTb2x2ZSB0aGVz
ZSBpc3N1ZXMgd2l0aCBzeXNmcyBhdHRyaWJ1dGVzIHRvIGV4cG9ydCB0aGUgc3RhdHVzDQo+ID4+
IHJlZ2lzdGVycyBoaWRkZW4gaW4gdGhlIFJDUkIuDQo+ID4+DQo+ID4+IFRoZSBwcm9jZWR1cmUg
aXMgYXMgZm9sbG93czoNCj4gPj4gRmlyc3QsIG9idGFpbiB0aGUgUkNSQiBhZGRyZXNzIHdpdGhp
biB0aGUgY3hsIGRyaXZlciwgdGhlbiBhY2Nlc3MgdGhlDQo+ID4+IGNvbmZpZ3VyYXRpb24gc3Bh
Y2UuIE5leHQsIG91dHB1dCB0aGUgbGluayBzdGF0dXMgaW5mb3JtYXRpb24gZnJvbQ0KPiA+PiB0
aGUgY29uZmlndXJhdGlvbiBzcGFjZSB0byBzeXNmcy4gVWx0aW1hdGVseSwgdGhlIGV4cGVjdGF0
aW9uIGlzIHRoYXQNCj4gPj4gdGhpcyBzeXNmcyBmaWxlIHdpbGwgYmUgY29uc3VtZWQgYnkgUENJ
IHVzZXIgdG9vbHMgdG8gdXRpbGl6ZSBsaW5rIHN0YXR1cw0KPiBpbmZvcm1hdGlvbi4NCj4gPj4N
Cj4gPj4gVGhpcyBwYXRjaCBzZXJpZXMgcmVsaWVzIG9uIHRoZSBmdW5jdGlvbnMgZGVmaW5lZCBp
biB0aGUgZm9sbG93aW5nIHBhdGNoZXMuDQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWN4bC8yMDI0MDgzMDAxMzEzOC4yMjU2MjQ0LTEtbWluZzQubGlAaQ0KPiA+PiBudGVsLmMN
Cj4gPj4gb20vDQo+ID4+DQo+ID4+IENoYW5nZXMNCj4gPj4gdjFbMV0gLT4gdjI6DQo+ID4+IC0g
TW9kaWZpZWQgdG8gcGVyZm9ybSByY3JiIGFjY2VzcyB3aXRoaW4gdGhlIENYTCBkcml2ZXIuDQo+
ID4+IC0gQWRkZWQgbmV3IGF0dHJpYnV0ZXMgdG8gdGhlIHN5c2ZzIG9mIHRoZSBQQ0kgZGV2aWNl
Lg0KPiA+PiAtIE91dHB1dCB0aGUgbGluayBzdGF0dXMgaW5mb3JtYXRpb24gdG8gdGhlIHN5c2Zz
IG9mIHRoZSBQQ0kgZGV2aWNlLg0KPiA+PiAtIFJldHJpZXZlIGluZm9ybWF0aW9uIGZyb20gc3lz
ZnMgYXMgdGhlIHNvdXJjZSB3aGVuIGRpc3BsYXlpbmcNCj4gPj4gaW5mb3JtYXRpb24gaW4gbHNw
Y2kuDQo+ID4+DQo+ID4+IHYyWzJdIC0+IHYzOg0KPiA+PiAtIEZpeCB1bm5lY2Vzc2FyeSBpbml0
aWFsaXphdGlvbiBhbmQgd3JvbmcgdHlwZXMgKEJqb2huKS4NCj4gPj4gLSBDcmVhdGUgYSBoZWxw
ZXIgZnVuY3Rpb24gZm9yIGdldHRpbmcgYSBQQ0llIGNhcGFiaWxpdHkgb2Zmc2V0IChCam9obiku
DQo+ID4+IC0gTW92ZSBwbGF0Zm9ybS1zcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiB0byB0aGUgbGli
IGRpcmVjdG9yeSBpbg0KPiA+PiBwY2l1dGlscyAoTWFydGluKS4NCj4gPj4NCj4gPj4gdjNbM10g
LT4gdjQ6DQo+ID4+IC0gUkNSQiByZWdpc3RlciB2YWx1ZXMgYXJlIHJlYWQgb25jZSBhbmQgY2Fj
aGVkLg0KPiA+PiAtIEFkZGVkIGEgbmV3IGF0dHJpYnV0ZSB0byB0aGUgc3lzZnMgb2YgdGhlIFBD
SSBkZXZpY2UuDQo+ID4+IC0gU2VwYXJhdGUgbHNwY2kgaW1wbGVtZW50YXRpb24gZnJvbSB0aGlz
IHBhdGNoLg0KPiA+Pg0KPiA+PiB2NFs0XSAtPiB2NToNCj4gPj4gLSBVc2UgbWFjcm9zIGZvciBi
aXR3aXNlIG9wZXJhdGlvbnMNCj4gPj4gLSBGaXggUkNSQiBhY2Nlc3MgdG8gdXNlIGN4bF9tZW1k
ZXYNCj4gPj4NCj4gPj4gdjVbNV0gLT4gdjY6DQo+ID4+IC0gQWRkIGFuZCB1c2UgbWFza3MgZm9y
IFJDUkIgcmVnaXN0ZXIgdmFsdWVzDQo+ID4+DQo+ID4+IHY2WzZdIC0+IHY3Og0KPiA+PiAtIEZp
eCBjb21tZW50cyBvbiB3aGl0ZSBzcGFjZSBpbmxpbmUNCj4gPj4NCj4gPj4gdjdbN10gLT4gdjg6
DQo+ID4+IC0gQ2hhbmdlIHRoZSBjYWNoZSB2YWx1ZSB0byBvZmZzZXQNCj4gPj4gLSBBY2Nlc3Mg
bWVtb3J5IG1hcCBhcmVhIGluIHJjZF8qX3Nob3coKSBmdW5jdGlvbnMNCj4gPj4NCj4gPj4gdjhb
OF0gLT4gdjk6DQo+ID4+IC0gTWFwIHRoZSBwY2llIGNhcCBpbiBmb3IgYWxsIHRoZSB0aW1lIHRo
ZSBkcml2ZXIgaXMgYm91bmQgdG8gdGhlIGRldmljZS4NCj4gPj4gLSBBZGQgbWFwcGluZyB0aGUg
cGNpZSBjYXAgaW4gY3hsX3JjZF9jb21wb25lbnRfcmVnX3BoeXMoKS4NCj4gPj4NCj4gPj4gdjlb
OV0gLT4gdjEwOg0KPiA+PiAtIENoYW5nZSBhIHV0aWxpdHkgZnVuY3Rpb24gZm9yIGdldHRpbmcg
UENJZSBjYXBhYmlsaXR5Lg0KPiA+PiAtIEZpeCB0YWIgYWxpZ25tZW50IGlzc3VlLCBlcnJvciBo
YW5kbGluZywgYW5kIGFwcGx5IHN1Z2dlc3Rpb25zIGZyb20NCj4gSm9uYXRoYW4uDQo+ID4+DQo+
ID4+IHYxMFsxMF0gLT4gdjExOg0KPiA+PiAtIEFkZCBmdW5jdGlvbnMgdG8gaGF2ZSBvbmUgZnVu
Y3Rpb24gZG8gb25seSBvbmUgdGhpbmcuDQo+ID4+IC0gQWRkIGEgc2l6ZSBwYXJhbWV0ZXIgdG8g
dXRpbGl0eSBmdW5jdGlvbiBhcmd1bWVudHMgYW5kIGNvbnNvbGlkYXRlZA0KPiA+PiB0aGVtIGlu
dG8gb25lLg0KPiA+Pg0KPiA+PiB2MTFbMTFdIC0+IHYxMjoNCj4gPj4gLSBGaXggdGhlIGVycm9y
IGhhbmRsaW5nIGluIGN4bF9wY2lfc2V0dXBfcmVncygpLg0KPiA+PiAtIEZpeCBhbmQgY2xlYW4g
dXAgc29tZSBkZXRhaWxzLg0KPiA+Pg0KPiA+PiB2MTJbMTJdIC0+IHYxMzoNCj4gPj4gLSBGaXgg
YW5kIGNsZWFuIHVwIHNvbWUgZGV0YWlscy4NCj4gPj4NCj4gPj4gdjEzWzEzXSAtPiB2MTQ6DQo+
ID4+IC0gRml4IGFuZCBjbGVhbiB1cCBzb21lIGRldGFpbHMuDQo+ID4+DQo+ID4+IHYxNFsxNF0g
LT4gdjE1Og0KPiA+PiAtIENoYW5nZSBkcG9ydCBsb29rdXAgdG8gYmUgZG9uZSBvbmx5IG9uY2Uu
DQo+ID4+IC0gRml4IHRoZSB2aXNpYmlsaXR5IG9mIGN4bF9yY3JiX3RvX2xpbmtjYXAoKS4NCj4g
Pj4NCj4gPj4gdjE1WzE1XSAtPiB2MTY6DQo+ID4+IC0gRml4IHRoZSBwb3J0IGxlYWsgYnVnIGJ5
IGludHJvZHVjZSBhIG5ldyBzY29wZS1iYXNlZC1mcmVlIGhhbmRsZXINCj4gPj4gLSBJbXByb3Zl
IHRoZSB2YXJpYWJsZSBuYW1lcy4NCj4gPj4NCj4gPj4gdjE2WzE2XSAtPiB2MTc6DQo+ID4+IC0g
Q2hhbmdlIHVzZWQgZnVuY3Rpb24gZm9yIG1ha2luZyBzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQNCj4g
Pj4NCj4gPj4gWzFdDQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDIz
MTIyMDA1MDczOC4xNzg0ODEtMS1rb2JheWFzaGkuZA0KPiA+PiBhLTA2DQo+ID4+IEBmdWppdHN1
LmNvbS8NCj4gPj4gWzJdDQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8y
MDI0MDIyNzA4MzMxMy44NzY5OS0xLWtvYmF5YXNoaS5kYQ0KPiA+PiAtMDZADQo+ID4+IGZ1aml0
c3UuY29tLw0KPiA+PiBbM10NCj4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtY3hs
LzIwMjQwMzEyMDgwNTU5LjE0OTA0LTEta29iYXlhc2hpLmRhDQo+ID4+IC0wNkANCj4gPj4gZnVq
aXRzdS5jb20vDQo+ID4+IFs0XQ0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1j
eGwvMjAyNDA0MDkwNzM1MjguMTMyMTQtMS1rb2JheWFzaGkuZGENCj4gPj4gLTA2QA0KPiA+PiBm
dWppdHN1LmNvbS8NCj4gPj4gWzVdDQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWN4bC8yMDI0MDQxMjA3MDcxNS4xNjE2MC0xLWtvYmF5YXNoaS5kYQ0KPiA+PiAtMDZADQo+ID4+
IGZ1aml0c3UuY29tLw0KPiA+PiBbNl0NCj4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtY3hsLzIwMjQwNDI0MDUwMTAyLjI2Nzg4LTEta29iYXlhc2hpLmRhDQo+ID4+IC0wNkANCj4g
Pj4gZnVqaXRzdS5jb20vDQo+ID4+IFs3XQ0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1jeGwvMjAyNDA1MTAwNzM3MTAuOTg5NTMtMS1rb2JheWFzaGkuZGENCj4gPj4gLTA2QA0K
PiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzhdDQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWN4bC8yMDI0MDYwNjA3NDgxNC41NjMzLTEta29iYXlhc2hpLmRhLQ0KPiA+PiAwNkBm
DQo+ID4+IHVqaXRzdS5jb20vDQo+ID4+IFs5XQ0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1jeGwvMjAyNDA2MTAwODIyMjIuMjI3NzItMS1rb2JheWFzaGkuZGENCj4gPj4gLTA2
QA0KPiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzEwXQ0KPiA+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1jeGwvMjAyNDA2MTEwNTUyNTQuNjEyMDMtMS1rb2JheWFzaGkuZGENCj4gPj4g
LTA2QA0KPiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzExXQ0KPiA+PiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1jeGwvMjAyNDA2MTIwNzU5NDAuOTI1MDAtMS1rb2JheWFzaGkuZGENCj4g
Pj4gLTA2QA0KPiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzEyXQ0KPiA+PiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1jeGwvMjAyNDA2MTQwNDU2MTEuNTg2NTgtMS1rb2JheWFzaGkuZGEN
Cj4gPj4gLTA2QA0KPiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzEzXQ0KPiA+PiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1jeGwvMjAyNDA2MTcwNDM3MDIuNjIwMjgtMS1rb2JheWFzaGku
ZGENCj4gPj4gLTA2QA0KPiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzE0XQ0KPiA+PiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMjAyNDA2MTgwNDI5NDEuOTY4OTMtMS1rb2JheWFz
aGkuZGENCj4gPj4gLTA2QA0KPiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzE1XQ0KPiA+PiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMjAyNDA3MTYwNDI1NDAuODk2MzktMS1rb2Jh
eWFzaGkuZGENCj4gPj4gLTA2QA0KPiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzE2XQ0KPiA+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMjAyNDA4MTUwMDU1MTAuMjIwODM1LTEt
a29iYXlhc2hpLmQNCj4gPj4gYS0wNg0KPiA+PiBAZnVqaXRzdS5jb20vDQo+ID4+DQo+ID4+IEtv
YmF5YXNoaSxEYWlzdWtlICgyKToNCj4gPj4gICBjeGwvY29yZS9yZWdzOiBBZGQgcmNkX3BjaWVf
Y2FwIGluaXRpYWxpemF0aW9uDQo+ID4+ICAgY3hsL3BjaTogQWRkIHN5c2ZzIGF0dHJpYnV0ZSBm
b3IgQ1hMIDEuMSBkZXZpY2UgbGluayBzdGF0dXMNCj4gPj4NCj4gPj4gIGRyaXZlcnMvY3hsL2Nv
cmUvY29yZS5oIHwgICA1ICsrDQo+ID4+ICBkcml2ZXJzL2N4bC9jb3JlL3JlZ3MuYyB8ICA1NiAr
KysrKysrKysrKysrKysrKysrKw0KPiA+PiAgZHJpdmVycy9jeGwvY3hsLmggICAgICAgfCAgIDkg
KysrKw0KPiA+PiAgZHJpdmVycy9jeGwvcGNpLmMgICAgICAgfCAxMTANCj4gPj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+PiAgNCBmaWxlcyBjaGFuZ2VkLCAx
NjcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IC0tDQo+ID4+IDIu
NDUuMA0KPiA+DQo+ID4NCg0K
