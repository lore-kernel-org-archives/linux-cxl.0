Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D04A21;
	Fri, 28 Mar 2025 04:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743135407; cv=fail; b=m33s1SOM/AKMMNaGRMVVCznmdmXVwZIdZyBVGWzI6qn9xV7NE7o5UJwk+hcaIqi0a5AJmU9LAD5j/3GB9M+wlivTq/u4bQnua/jBk1T2nu9BfgBkO2PJxguy1feEUw0NAirgt93t3j3sPNyGw5D9FQHvox7Q/7T0cLi2Yw/LKZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743135407; c=relaxed/simple;
	bh=ANDaBItlzUjb6rwfchqS5o1oGFn+H9Na6bGV+MwETOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTsTVG/tlr+YkvIrGnZxNEt6r7incFparhxLYP3LQaA/WL8dG8fn2F/9P1x/AFYW6zoG9pGlZaYX26G0piugXsRwTF5wpyjXPSgEI9wu/j8J922yxrxLoKuJyjGmuqLhtDxN6d7Wzrg+4u6/TgLCYXJDSYzaiwlMjkqzg7S046c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=yY2Rxedv; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="yY2Rxedv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743135405; x=1774671405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ANDaBItlzUjb6rwfchqS5o1oGFn+H9Na6bGV+MwETOo=;
  b=yY2RxedvksqErESovYRLzVhorm1JlrL6TlTiCWi6EfFsEW9UOc7RqL6v
   eLDl2oi6harBIszZzCAn4hO789PGTnnoPyX//5taIcE/SWdKZrx+PomnP
   CCR8/TkUecGMzvWEAhwUKFw5yYVYM+VbnyFttYkGlETn1s2B4ROYN4K6+
   lndxNbABrsueF+d7DLeMQhaMiQjnTbCVWjKaQcDjolOK13xpAq4Hw+aI3
   dTTghgHeOGxZ+K8mgNe8pErEB9ntfu1gG2tTJ0OxWcNB4lAAHKbKr9Wns
   AVoFscuzEAh3nxpzC+ypQziRQV8ANSLA/MXKOrWyJR4XIoyIheTW+k0q/
   Q==;
X-CSE-ConnectionGUID: V5zFYDJWTXCVuqpFt9B18A==
X-CSE-MsgGUID: egMu2Ys+R2iLvQDqya+8Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="62275293"
X-IronPort-AV: E=Sophos;i="6.14,282,1736780400"; 
   d="scan'208";a="62275293"
Received: from mail-japanwestazlp17011029.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 13:15:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYcN3zAkIjQUmDa9iPMjJmAjjWTRwMBTnFz0zOrEj7RsJuPG6BGE2Tf963dhNkwIqaQ2qzaqLAVDikioqMRRTtzCbddKGhm27tfr7wfJgljO43Km2qnyvtOWEzl5MKEKPVPUCLZEsr4tKyr7233a1gLkl7Vmk59bQL7DXx5Uj+YRQ8M9BFPrhcj66S8BslIj6Kpr4H+9xXYmwXbguaOH+bR8cpCMpYqYoanI3klJWKXWVCuXiZUmBtXg04ICYqx46r16VCUmXfvKIypsMBpzOFlcyFL3TZ4SEugcZt7nspQgDlpFuLtXAOU59CxCZluiiCVbLNRFDh8I0SFJVxtFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANDaBItlzUjb6rwfchqS5o1oGFn+H9Na6bGV+MwETOo=;
 b=PyDBQDtuK0sV7K4gowASqJThA12c3TjX9qgYEH0wrxNfCrvZ3UQE1zzkf8q/uuVvyeZ5YqVUCzsHPTGhwU++MiaUCnjQzdZpCdDdfYNQlomdALKR5jb6h2uiQNi0NO2bGiVV93pdcOMv9GkBbR1Bxwa+xTrMv5rfEbRuqC1mccRlOVZqexAgqp95PQf7/Re6jHYei6NuONAjP5arb5Z2vhDreiYLSG8qQxrc++85ZNZV7XcYPjpQcxdR8adbKABseinQvK7+m2zMzkkvnJgC6iTmHd4ZwspckdNU0JqBEO+vPhpvCY/cAsahYGZiVuFXQpn/WkPqDzZvbthIfmXSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB7092.jpnprd01.prod.outlook.com (2603:1096:400:c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 04:15:15 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 04:15:13 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Topic: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Index: AQHbniL/JoX3x8SxXU+HvSvJEGqce7OGWN8AgABC9gCAAGJBAIAA9aMA
Date: Fri, 28 Mar 2025 04:15:13 +0000
Message-ID: <7bbf602d-6900-4179-9737-efeb40e1566f@fujitsu.com>
References: <20250326074450.937819-1-lizhijian@fujitsu.com>
 <67e4c9aaedd08_138d3294ca@iweiny-mobl.notmuch>
 <1ed912df-42c7-4319-8765-3167963df7b3@fujitsu.com>
 <67e5544237027_13cb29432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <67e5544237027_13cb29432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB7092:EE_
x-ms-office365-filtering-correlation-id: ce7bae2b-9e86-400a-0e08-08dd6daf2323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?bk04NndXL3lpZ2lOVCs1M21tNllhdGJQcnhzNUZ3dlFpV3kyeXViOGU0b0xT?=
 =?utf-8?B?L1BDMWxYenNuZHJvazJlRFQvdDAzem1YQmFrcDZiS3BvaEhtelY4ZmxzZGsz?=
 =?utf-8?B?WDdZNWJhZUZNTmozQlk4Ni83TUNjSyszdWswZVFTclVlSFBJdnZVSUtCRjhi?=
 =?utf-8?B?UnNmTThIRlRkM0lyZjQ0TnZhVTY3UnRDUG40SmE0K1EyaUg3bXE1Qi9abGFM?=
 =?utf-8?B?b2ZEdkdDa1ZNNnplVG5TVXZSbk9XWG5ESHg3VkNySFN4dlFYUVIzN1VaTEgw?=
 =?utf-8?B?OGRYMzlsQ0pmMlVubm5vZjhUa2JxOE1sUWdEem9EZG0vV01HUnVBTjFqelJp?=
 =?utf-8?B?dm1BSDdHa1JFQ1ErU1Y4TVpDTmpOSGZTSC9wakxXY2lrblJoTVFGVHdka0hh?=
 =?utf-8?B?aHd1bFY3cm9HV0w5eXFYNEdWNGhFd0x5ODZZWFNZbk8zNzA3OHhXOWthQ0lC?=
 =?utf-8?B?dU41YkdhUWRMM0luWFpXeDhsV05iVk4wdzJQWUsxRzdZSXRsM24rU1UxdXcy?=
 =?utf-8?B?OENXVXNGeGNGVlE1RWFjUEpQNjBZU2RJK2M1L2trVyt1aTVsQWNPSlZtcndR?=
 =?utf-8?B?VjlQb2VBOWR1Z242Y2JSQWZEeEhSUHhCU0grZThtNitsVUt6dHF4TGd6dkZ6?=
 =?utf-8?B?RTUrNitSNjVRUTl1VjNkREh3SUF1TUVNWWpaYmJEcWRUK0dtVlhxdXRrTGZB?=
 =?utf-8?B?YmpXNWJwSW02VE9hWk5hQ3d0Ym1xa2sydVJYS0FzYXFFSWJuUHE1cWE4ODQ0?=
 =?utf-8?B?QzR0eEpJV3dhMlZDcWpqMVFaUDdpREZ0bWhPZGx4RFVnbU5wZ3NHOFZsVC8w?=
 =?utf-8?B?eE16UVRpUGdDL1czbmc2Q3dYbGtpNkVPcE5kWERyVUJZcURJMHB6cUxIOVBY?=
 =?utf-8?B?UlN4VzhRMklwWTg1VkdNUHVwcUJycm5za3lPdC82NndzOUt2eFVRckd4eFR2?=
 =?utf-8?B?SnNiYmhFL3M5UmRySEdsdGI5MkZ5WHNQSCtFZHpCVDlsaUd6Mldybk5PYysz?=
 =?utf-8?B?QW82WE5BbFBFVWxVUzFuOTV5ZGw0OFc1a3JWbCtTUGZETkF2alFCNExheHR2?=
 =?utf-8?B?amhpV0ZrbGc2Q0YzNEdEbnJqQkczL0ZKMzBsbENCUGxwNHNWNTFWQm9FSDVV?=
 =?utf-8?B?N0xxTHBvY0dBOEdSdUIrdTR1M2xxcStrczhLdFRWNFBIQVBMM08wbVYwR2Nn?=
 =?utf-8?B?aUtnL29UNlRpYldnVHRuRlFGRnJLcTk1MFBUYlU0a2RwZ3hoYW9nQVpTUHEx?=
 =?utf-8?B?R1NycEpZYUtsa1VCYUhNcnJtbGlySDM0S3QvNjRTMVRobDc3SjViRUFabDNR?=
 =?utf-8?B?Q0NOSXBWcXNpNkdUTzZ6R0RyRlZUQ041UVN0UWo1THNoZmtrUUtieHp3SEdz?=
 =?utf-8?B?SWd1TDhuZjh4UEIzeDYwKy9VT21LbG1SZVMrSW5TdlpINU9wS3dJMTQ4Ui9n?=
 =?utf-8?B?WXQxY2xQSkc0QkQ0Z04ycUdLL3l6R3N3eDcvNnBxRWpYOEJGNTFBcW9NSFFy?=
 =?utf-8?B?Zm5JQmk0aGlNYzNnaS9iY0x0NG9yemcyeno1aEJYeFl5RVhWUWZLZDlMVFJm?=
 =?utf-8?B?TFZSNUhLb3dFNi9wVi9HWlVvY0Ezb1M2dUpsZVVHT3hnTXcrZGRjbFNLeTZt?=
 =?utf-8?B?d3NyUy8yYzNTYmZXT1o3Z3VIWFcwc0RlRHNKMUhyTDM4SmlFZENqOGQ1VHdT?=
 =?utf-8?B?aDExaDA4bjZWSlpVWTNVc3U4Q1QwZlo1MGFxanJjSlFoNHJvZjZOM0Q0Myt1?=
 =?utf-8?B?RysvRUhBNmkzUG1oaWxsZVhVT0sxOEVReHFLN0ZvNUUzVVRiNE5mR3NZTGlj?=
 =?utf-8?B?QzlJQm5hdmZ1VTNqNE5WczNUSC93NGM0RG92Yyt2M2lrSEZBc1VFVXJvQWxx?=
 =?utf-8?B?OHYrRXoySGxmUUpwYjVITHpsQlJSeUVZMHphNll4K3MxZnNoVisyMjhFYmd0?=
 =?utf-8?B?NHM3ZWRXdmcwcm03TzE4RzY2Ky9BZHY3SnE0RUJrOVJaN3NkWjFGTXowNW5P?=
 =?utf-8?B?VmI5aXlvcW53PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXVqeGJ2SUlsZGQzcEV1d3M4YjcxNGVYd0YyTlVMWXliV0tMRmYxV2dQbEJP?=
 =?utf-8?B?c1FKeUZsZWpKeDVhckd2bGl4UEVDcG1LNndjMWxKcnI3b2EyL0JVc2RiQkRl?=
 =?utf-8?B?ZFZ2U1pHZHhzQS9zMU1oekw2YU5yWUt5NTVOaGdUZDk0UllJQnV2dFVva0Rz?=
 =?utf-8?B?OVJrZVNwTGY5NXdSY3ZDcjJyTVlQM0JWNVFUVDdCY2wrV0R6bUZudUIvTkd6?=
 =?utf-8?B?Wlg5VklWZVFIUWhjbnFMOElvdlRCakhsOVoxVXNlekdpMGdNN0VjNklTUGpu?=
 =?utf-8?B?eExQdlkxMHpDL29mT2VmejhpdTFzQWpzTVh2QUNVQUpmc2pndktYa0FIek04?=
 =?utf-8?B?ZWpTVTlWMU1KRFpaVENhaFc5NXlpUFVuUFpsbEdNa1JYMGk2L296ZTdUOElx?=
 =?utf-8?B?UG9MRmVYREJWdU5UQ2EySnRjZkhVa3lBS2hneHkzenVLdExsdHdQNk5KbE5x?=
 =?utf-8?B?QklNVU9zTXloWUdOakZtVCtTa1g5S3p6Tkl2RVIyeDdLbUtSVFFrYSsxamVT?=
 =?utf-8?B?WkhPTE90RmxqRVR5NUlqSU9ITUlqVkZHY01LNHNHZlR2cGJucGNvQjJETGxm?=
 =?utf-8?B?QkxSaEVCT0thR3YxZzJwLzdXeEU1QXp2RDZaSXZiWDQxeFpTRlQ5N1haZk5O?=
 =?utf-8?B?Y3RHWmswRGJzY0FyUm9yMTRYVnpVejZveXlkcUtSZi96cnp2VWRRMlJFaVVN?=
 =?utf-8?B?azUvWnpQamJ1aVhrMUZoWHFUckp4a1RyNWRjeVRkR0JSNldWZ2xFWGFRR3c1?=
 =?utf-8?B?VDZDTXNHakpHcEMwd0ZmTFZ2OUM3bUx3QUduUG5HNWtuZFEzNkNMMXY1OVJW?=
 =?utf-8?B?Zjl5bTdGUFlWR2U5WlhjeEdvRFlVYitrYnNkdW83UXRVV2t4T01CdGFaUFYy?=
 =?utf-8?B?azl6Q2RCTjRWQnpkWk9WdFlLUGhoUmk2b2EvVlVjb2Z4WlNQV3hQMDlsNUxF?=
 =?utf-8?B?akxCNWVMTDA3M2dSUUlseCt2SENTSE0vbTNmOWV5TDcwak9NQXdxM3Mrd0Jk?=
 =?utf-8?B?RENMSXJPMitBOGJWV2hVUGZnMmE0RXd6WEFJbmJXUDZJa0JXL2lxd0dVN3li?=
 =?utf-8?B?cjlLWXJ3VDh5eUNwNzJHaWlseDJXaXdaRkZwTzBGZWRMMndiLzAwd0tIMWpq?=
 =?utf-8?B?R0FtK0w1WFNQTWcyQ0k5dDk3MmhrMnFmTmlHT2g4d0tuRC8xTjJtcTlEQ0VS?=
 =?utf-8?B?UGNtOHZDbGV0VVdMTVpBZmdSNitZQzlKT2hkeFowS3JjdUxSUDVnTEc3bC82?=
 =?utf-8?B?WWtKTEhYS1VBUm1PenVwM3NKSUpoYUMrQVJVSkRPbDZHandnZndmcCtXTXA5?=
 =?utf-8?B?MzRIaER4RXpEV1VLMFpiV3c5bVBlcmRQN2J2a3F1S2NVV1FQTlVwK3JRWnFr?=
 =?utf-8?B?b1ZjRmx5d2t4Ylh2NXlmWUk1U05ZTGRTeXRyK09zbXB2aWd2VzhNQU5peXY2?=
 =?utf-8?B?QUVwQkhmaUJmcWp6UStoVmpnOVduOU5SRHA2VmoxU0d5SjdUZTBSVkM3a2FI?=
 =?utf-8?B?aDExZ0VJdnZndVFpOWNlOW9tZ09NMnJkNmNRbmJTdGFCVHBvVmJUQVR2TW9l?=
 =?utf-8?B?MzRWbHJKMEN3OHVOVWlrVlUwVTRwTnpwNVNBZS9RYXNpMEwvYnlnNVRYSTVz?=
 =?utf-8?B?UnEwKzZGQWgwY2MrSWw3VjJsSlFhK3V6dWRJU1MxMjZjM05lVDc3WFQ1Wk1a?=
 =?utf-8?B?Y2hnb0wyYzVJUGE4UlRGRHVWZ09BbElnejdpbElHMkZ0TVd6SFd5MXJtdGgr?=
 =?utf-8?B?dzErMzZlMVFBKzlPdUtOY29KQzN1OGJEbHo3bFRsUVRuSGNSOFBIb1ZFc0lC?=
 =?utf-8?B?MVd1M3JIbk1ER0NoRzA3ME1EU05XcTN6eGNjMUQzK0VHTVlhbVV3UFRHZzM5?=
 =?utf-8?B?RlNpYnRoMlpmY3VvaEVIbG9VSytTSVdiMTJvalhRKzByR3VmR1NoUDBjWmJ1?=
 =?utf-8?B?elRnNGdzaXBZbWZuT3ZhSHd0S2FTems1TjFlZFpKZVZWckZtRHFkSngvQjZG?=
 =?utf-8?B?NDE4OEQzVks1RTNXbFZrMlhJMzRMU2dlUzRpUFd6dUdJY25FN3lBaXBYME16?=
 =?utf-8?B?NE1xQWRRTE9KNEhQUE45MklKK1RJNkltNkhJK1pLWE9naUJuS045MWxWalpG?=
 =?utf-8?B?MEMvWVBpekd3Z2Zwbzd6Mnc2dGNjVDF3NXNUVzdkb0RyYWJTZ2VEWXpMZXg3?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1A535715DDD714D8255BF3736FAB5A6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tnzvtJaeQj3XYDKY3fXFAnSNFshICjNxpcyISFTypKpARXNfiIwr1TfNsxii8SFu0kCjOU8DmYKThWtS3bE2HBBMoKeps3ZJpgBI4dfpJO/JIb3o9fFWT2/YCYI8OyBe33/YdI7XvdUAJv7VuS2JBT0l8bJ71oD7RCBM4/TChYN6m3MDfOJl7em35kFP6g3oGXj2oC6BhrrHtdn3HpBB56JyZTSXygCKFgQOjmAdUR2Ga2dUWZa6hg39nFRKQgYNliwHajucarbAw4PlqBLZEoo5AA/ODMzq5y1mnGvhGZTLbtEMAjy9PU6pZ2nMl2NrSsDtQosP4lzFBIedWHZG1TYOCV78Wl7fPzP5cboU0T3cXdh27qbaoustrGgtWm8fpejLb1ex/allDMPHIjp4mzOZGy9DNvgYMOXON0c+ZC5hO6dnhn1TTbSdGaW0GAnQ7yiMfgzCNJ2HD5yM+BjC0o83CmMaRffcJLkE2adnf3MEMDlmt+/7KN5QHSrPWMeLlZgw9aHtccv9/NQFczTFrDmg+DVymSPTmP1Yc2AhBUirYzZTWREhEWGinfHQcQLa6NkQGuXWAKOBnE+T51sAqh91hXuPtJooW+11R2pk9zl5ruDbUz3hg6q+Q5VRavxO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7bae2b-9e86-400a-0e08-08dd6daf2323
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 04:15:13.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZOLXwx/obJ1pPtlMBZSWR8k1JOv0/vBqF3nHjwSJz/6ureXMZJzJgtDQeJiC2AgEubZqacmIFNr28qi1IIYfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7092

DQoNCk9uIDI3LzAzLzIwMjUgMjE6MzYsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gWmhpamlhbiBM
aSAoRnVqaXRzdSkgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDI3LzAzLzIwMjUgMTE6NDQsIElyYSBX
ZWlueSB3cm90ZToNCj4+PiBMaSBaaGlqaWFuIHdyb3RlOg0KPj4+PiBQZXIgQ1hMIFNwZWMgcjMu
MSBUYWJsZSA5LTIxLCBib3RoIENYTDEuMSBhbmQgQ1hMMi4wIGhhdmUgZGVmaW5lZCB0aGVpcg0K
Pj4+PiBvd24gbGVuZ3RoLCB2ZXJpZnkgaXQgdG8gYXZvaWQgYW4gaW52YWxpZCBDSEJTDQo+Pj4N
Cj4+Pg0KPj4+IEkgdGhpbmsgdGhpcyBsb29rcyBmaW5lLiAgQnV0IGRpZCBhIHBsYXRmb3JtIGhh
dmUgaXNzdWVzIHdpdGggdGhpcz8NCj4+DQo+PiBOb3QgcmVhbGx5LCBhY3R1YWxseSwgSSBkaXNj
b3ZlcmVkIGl0IHdoaWxlIHJldmlld2luZyB0aGUgY29kZSBhbmQNCj4+IENYTCBzcGVjaWZpY2F0
aW9uLg0KPj4NCj4+IEN1cnJlbnRseSwgdGhpcyBpc3N1ZSBhcmlzZXMgb25seSB3aGVuIEkgaW5q
ZWN0IGFuIGluY29ycmVjdCBsZW5ndGgNCj4+IHZpYSBRRU1VIGVudmlyb25tZW50LiBPdXIgaGFy
ZHdhcmUgZG9lcyBub3QgZXhwZXJpZW5jZSB0aGlzIHByb2JsZW0uDQo+Pg0KPj4NCj4+PiBEb2Vz
IHRoaXMgbmVlZCB0byBiZSBiYWNrcG9ydGVkPw0KPj4gSSByZW1haW4gbmV1dHJhbCA6KQ0KPiAN
Cj4gV2hhdCBkb2VzIHRoZSBrZXJuZWwgZG8gd2l0aCB0aGlzIGludmFsaWQgQ0hCUyBmcm9tIFFF
TVU/IEkgd291bGQgYmUNCj4gaGFwcHkgdG8gbGV0IHdoYXRldmVyIGJhZCBlZmZlY3QgZnJvbSBp
bmplY3RpbmcgYSBjb3JydXB0ZWQgQ0hCUyBqdXN0DQo+IGhhcHBlbiBiZWNhdXNlIHRoZXJlIGFy
ZSBwbGVudHkgb2Ygd2F5cyBmb3IgUUVNVSB0byBjb25mdXNlIHRoZSBrZXJuZWwNCj4gZXZlbiBp
ZiB0aGUgdGFibGUgbGVuZ3RocyBhcmUgY29ycmVjdC4NCj4gDQo+IFVubGVzcyBpdCBoYXMgcmVh
bCBpbXBhY3QgSSB3b3VsZCByYXRoZXIgbm90IHRvdWNoIHRoZSBrZXJuZWwgZm9yIGV2ZXJ5DQo+
IHBvc3NpYmxlIHdheSB0aGF0IFFFTVUgY2FuIG1ha2UgYSBtaXN0YWtlLg0KDQoNCg0KVGhhbmsg
eW91IGZvciB0aGUgZmVlZGJhY2suDQoNCklmIHlvdXIgZWFybGllciBjb21tZW50cyB3ZXJlIHNw
ZWNpZmljYWxseSBhYm91dCAqKipiYWNrcG9ydGluZyoqKiB0aGlzIHBhdGNoLA0KSSBhZ3JlZSB0
aGVyZSBtaWdodCBub3QgYmUgYW4gdXJnZW50IG5lZWQgZm9yIHRoYXQuDQoNCkhvd2V2ZXIsIHJl
Z2FyZGluZyB0aGUgZGlzY3Vzc2lvbiBvbiB3aGV0aGVyIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIGFj
Y2VwdGVkDQp1cHN0cmVhbSwgVEJILCBJIGJlbGlldmUgaXQgaXMgbmVjZXNzYXJ5Lg0KDQoxLiBU
aGUgKipDWEwgU3BlY2lmaWNhdGlvbiAocjMuMSwgVGFibGUgOS0yMSkqKiBleHBsaWNpdGx5IGRl
ZmluZXMgYGxlbmd0aGANCnJlcXVpcmVtZW50cyBmb3IgQ0hCUyBpbiBib3RoIENYTCAxLjEgYW5k
IENYTCAyLjAgY2FzZXMuIEZhaWxpbmcgdG8NCnZhbGlkYXRlIHRoaXMgZmllbGQgYWdhaW5zdCB0
aGUgc3BlYyByaXNrcyBtaXNpbnRlcnByZXRhdGlvbiBvZiBpbnZhbGlkDQpjb25maWd1cmF0aW9u
cy4NCg0KMi4gQXMgbWVudGlvbmVkIGluIHNlY3Rpb24gKioyLjEzLjgqKiBvZiB0aGUgKkNYTCBN
ZW1vcnkgRGV2aWNlIFNvZnR3YXJlIEd1aWRlIChSZXYgMS4wKSosDQpJdCdzIHJlY29tbWVuZGVk
IHRvIHZlcmlmeSB0aGUgQ0hCUyBsZW5ndGguDQoNCldoaWxlIHRoZSBpbW1lZGlhdGUgaW1wYWN0
IG1pZ2h0IGJlIGxpbWl0ZWQgdG8gZWRnZSBjYXNlcyAoZS5nLiwgaW5jb3JyZWN0IFFFTVUgY29u
ZmlndXJhdGlvbnMpLA0KdXBzdHJlYW1pbmcgdGhpcyBhbGlnbnMgdGhlIGtlcm5lbCB3aXRoIHNw
ZWMtbWFuZGF0ZWQgY2hlY2tzIGFuZCBpbXByb3Zlcw0Kcm9idXN0bmVzcyBmb3IgZnV0dXJlIHVz
ZSBjYXNlcy4NCg0KWzFdIGh0dHBzOi8vY2RyZHYyLXB1YmxpYy5pbnRlbC5jb20vNjQzODA1LzY0
MzgwNV9DWExfTWVtb3J5X0RldmljZV9TV19HdWlkZV9SZXYxXzEucGRmDQoNCg0KPiANCj4gSS5l
LiBpZiBpdCB3YXMgYSB3aWRlc3ByZWFkIHByb2JsZW0gdGhhdCBhZmZlY3RlZCBtdWx0aXBsZSBR
RU1VIHVzZXJzIGJ5DQo+IGRlZmF1bHQgdGhlbiBtYXliZS4gSnVzdCB5b3VyIGxvY2FsIHRlc3Qg
Z29uZSBhd3J5PyBNYXliZSBub3Qu
