Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215E19CC05;
	Mon,  7 Apr 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013106; cv=fail; b=uZks5qFeen3yQ0NvQO2BfG3omCigB1WlwimgWv7+L7mwNywC25X4BsHNOW3m/dMoYroZg0uyTn25RzIZZ4QhWmwumTvSOGbiA09WNVh79dR/XE13EWxdP7Xm2ROmBXLGwdysK6j2FSrhuhM57kYG5jMnvrW4JcDRnbJBSaLddaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013106; c=relaxed/simple;
	bh=8eB3wGHivciqfDlQ+nj2kgerfuGV36laSFLmSjzduRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b5XtX1CcB1k5kO8QlWxY0zMpi2CMKqCgZDQVvTovNXjGRmja0ZAGdRhGZlD4qaYAaNpoSODpGIBWz+hTC9znU9f3TZRtoBjb+xgdHX7dMulry+c+eFWXe0JhCGSM68Wzl7v4/mdtabTd0TEOIyrCnzh4bAyWdYWLUTq8/SZuWHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mTglkyJz; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mTglkyJz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744013102; x=1775549102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8eB3wGHivciqfDlQ+nj2kgerfuGV36laSFLmSjzduRY=;
  b=mTglkyJzFhEsCvlsGJBLAlY+aXl73LHQjm3Ipbd16IeDT+svmPK5qsr7
   VGjBmJzTY9zPfH7MWo7IFkSArDucdyURDSFytohJF/OJJtjUAwHm2Vm8e
   9zZW8C79jSkAWsWcrgB0LdRXtbVHTc8433Xrdf+endECd39cLir4imPjb
   8hH6ZjFoYgUoshZ+ddCMJu4CEUcTgXOGfZZeFY0NvHvqwVTqq7XHLU2uj
   uv/67oNEUd5uKabWyhT+l+PsE5vmN3XCmLkk5lThf+4/5QZpsSkbDAmsV
   B8o4Mft37ta4WgBEZKpXgtdq7GnwzDE1SNpR+Fuai1x3c2QcamYizV/ss
   A==;
X-CSE-ConnectionGUID: +0DV2u9WTIiemtAsZnU2lA==
X-CSE-MsgGUID: +Go+s632QuSmv1FoMDObcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="152134127"
X-IronPort-AV: E=Sophos;i="6.15,193,1739804400"; 
   d="scan'208";a="152134127"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 17:04:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBjUkf42zrhJvT+Ug1mc/j64p0EXXIAGY0hs9IhcITsTuZi7eoGAolE0QSWNFk+C5pWTrIlOUbpw4meAbWKiKU9TZxcfB6jZdEQLDl93hlwh75k7MZxtcHZWhwH0k1fbNnws6T7ApycDHdyQBDX0Q0Da7If32//R7n6qdDHr+CT/ALwWB0XD1ZWEkd0g9bFVmBj17oiJda5YA6CyUgctSsMJlV8WCTzNuW000wfSbDueXdDn/JielgNTgLUF7ILThNwwawzosVaotRWX/AGVRgEKo9hXl8sWf21+udH8+4LhEKI2sGr8rZ+qie4/w588ApJies7Q0iInhBO1toeMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eB3wGHivciqfDlQ+nj2kgerfuGV36laSFLmSjzduRY=;
 b=HT8dmEjhTeH/tzJHv0Efhk3mqVFrLlFfIRFy09/ZZiyd6ebg9EICLARQJnEI/cxOlHeYDzRs71tK5Wo4TWOCxjJXZ/NvmII6iRzL51QKvaf6htaOj49V0qhL1aAn6KZ+75vHz7n8L+Nf88L4iI1yU32XHZY889hjtJXcdPGz6hq3mI4sR+tATmhSIBrPbjis8m/dhD4iaKOIHCUE6p6z/wIpQi5yEqouYh5GvHsfyReOlq8KHJc9JjdTXwZVXPMj1a6fKSrpD4tIYd+mWbLDHs3fkDayE/MeJxgV6ycwOOZQ0izfn28dWfnC9wmiRIqFCS2CzClWCKA4RE6b5XzPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYRPR01MB12364.jpnprd01.prod.outlook.com (2603:1096:405:103::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 08:04:44 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 08:04:44 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Gregory Price <gourry@gourry.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Thread-Topic: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Thread-Index: AQHbpCaxQHh+ea79DEe/ckQgeqDMvbOX3yOA
Date: Mon, 7 Apr 2025 08:04:43 +0000
Message-ID: <58522fbc-0fe8-4ecf-89f3-385f79346a10@fujitsu.com>
References: <20250402232552.999634-1-gourry@gourry.net>
In-Reply-To: <20250402232552.999634-1-gourry@gourry.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYRPR01MB12364:EE_
x-ms-office365-filtering-correlation-id: 79aedd2a-e4e9-4ae8-d5f3-08dd75aadb33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHl5eGk1UzFFaWRkTzR0RWI3OUhCSklWMWhTTDB4NDRIQWdrQlZSdFBjOGVR?=
 =?utf-8?B?QWpyci93VlVjVTArc1pKUnhUd21aNnhUVzkwRXJkS292WHVaMFNGRHpwRmZx?=
 =?utf-8?B?TWpUVjlTUGM3N2VTbUhlRS9nN1ZRUTBDR3hhYVUrMWJUQVJOWG9LWnd4UFli?=
 =?utf-8?B?N3M5TTR6RlFKd3VHZWI4WjhydUpVSWNEeTZ6N3h0M0hqREZGNjBYcVBHOXU0?=
 =?utf-8?B?RXBCRWY3SjFKVW1rM2pNMzNmUmVBV285Ujg0Z2F0UE94c1RaMGpkYUtHQzBj?=
 =?utf-8?B?TUxwekE4cFdFSDkySzYreFdIa2I2VWdPUHRtT3RIL0FxYzB0Tnk5QnlxcXFW?=
 =?utf-8?B?UkJ6UE51S2s3ZEhKMkF0T280STZtamh3ZjhqNkI1aURodStUQmxYbVBHRlR6?=
 =?utf-8?B?TUtleDdjMnhSUFJPa3dLZXI4eVYwY0grR09DaFZpbjRnZS9yZnQ3UExHWVpJ?=
 =?utf-8?B?SEFHZVI3UHJWV3BkdjVDVCt4TmVqMHdsVHd3S2ptdjNlSTlNNWNLSmRQeDRO?=
 =?utf-8?B?djRjTG9vd1JrNktJMWRZenpXQlc2b1kwcGRhRzFqdjh0Mk1vbFJLUzBaSlBP?=
 =?utf-8?B?YnRQTUxvY00vQWZrOHZvclk5SnlBSHN5Z3RTL2JjWCtYK1d4L0JIWkxUWm1O?=
 =?utf-8?B?Yjg0ZGY2NUo3alJoUkhVbDU3S0JRdzFxa3pVTzRvZkZXN0JVYVU0cmF4dEdF?=
 =?utf-8?B?TG01OXF6Y3JDM29SVXU4Y0QxT0RxbGRiTzlKcldNZUNxSTZCRlpxVEE0eERG?=
 =?utf-8?B?S2lYcHRPeXVJNWlwenh6QjRZdUN2ZlM4M3JValJmc3NONWZKV2JoZFhzZjJl?=
 =?utf-8?B?eXVVT1lnU0tOYnE3bmllemxzMTM1U0xmMEl1MUdJVHVscm5Od2JMR1JpUVZY?=
 =?utf-8?B?NzBqMU9FbVZsOHNZRjFIRnEzakFMZ2ErYjVIZW9URlI2V2NMSk9YK3AxbmZo?=
 =?utf-8?B?T0FoQ2VLMXlyajJTeUZLMmszWExVME1BeTN2dFEzWGErbkErOXZnYUp4a2lC?=
 =?utf-8?B?NTltRThRV2Iva0JOaE1CMDBPYk9KNkJRaGt6cmxCR2hHWXkyVnN2cXpibmFY?=
 =?utf-8?B?SmdnbDNkc2tZelRqTThQY1NDbU9aVkR1bzVpR2xiYzI5YWJvTzBkVmFZcXNz?=
 =?utf-8?B?c3F0cXZuMVFsbGd5Y1l3V21mNXBDUzdNYmJqNTJGbWltamVtSlZpelQ5dlo5?=
 =?utf-8?B?Nm9vLzQ5cFh1MFZtdEZ2SXdxWmIrMEtOcnpEU2NyL2dNdktGbjZKTEVvTXJ4?=
 =?utf-8?B?Y0RjeE1SZzhVaEdSVUNlVUx3TlRibkVudVNFcUZqalZ6VVgwWmxZVnMycThO?=
 =?utf-8?B?Q3NGNEdlMmVkUXJQWnBzdkgvWTA0VlZDNlVxVW42Rk45VHcyb0RYT0E5VEJH?=
 =?utf-8?B?QmlUS1FzL1JFRUdwYkUxWHVKUjBWQ2VNWE9IdEd0dDZzaEw4eU5CMWgrdms2?=
 =?utf-8?B?NmNZa1NqRW8yMnpBN0RMRXNvZTVNQTNTRHUvUmVHUDBaTDhzcE1UV0F4dEgx?=
 =?utf-8?B?bk9QSDlrSXNuR0J2b1ZGT3kyQ3Zia0xRb0d4V3ZCOWZpcHFGR2JCL3YxRWZU?=
 =?utf-8?B?N2lwa0dGWml3cmNlWnNyNVRGN3lLS2JrL0tpYnBITlBaVVVOaTZDOEx4UUF4?=
 =?utf-8?B?QXMwcm1DWjFpWk5JUVBUQ0hNWVFRSnhoSTdJNlJ1YURWU1BabGVnSUVTL2Ex?=
 =?utf-8?B?cnVVV1RQUmw2c0kvdG5ia2Y5YVdBVkkwVmE3RnJYUmVDR2NFalhrWnRudkhq?=
 =?utf-8?B?c1lESkNRb1BsVnFGVWY2YWVSTGptcEtRclYrbml3U2t4WDZTZmV2QXlhcDJT?=
 =?utf-8?B?ZkVvdHA0V0o0QTh3eEpuekFPMU11MWtpaldZOS9obXhHSWhzVWkwcE40aUxV?=
 =?utf-8?B?M1cxdXNEeHJVSWpXNFdjejJsN1VOZHFkYnpGRXZjN2dkMERnczZOYUozNWZL?=
 =?utf-8?B?bDUzWWhkYlpPNmNZVHFRbGJ3c0pXL2xlTy9ZeWpQQjZGY3BTcUFQblhaZndP?=
 =?utf-8?B?aGtERWtaaEJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUc2Sm9DVzRBb1dSK1RtNnlmM1haazVsejFJQzJIT1NjbzJSTDhaY0RuZ1dm?=
 =?utf-8?B?UHdndG5LR1ptOWQ3UHdIeURBZjZUNFdKS3NGRnpqNlVaYUg1ODU2MGJ4MzBm?=
 =?utf-8?B?T0FlbE9ZbGhkeGdXRnBkUmJrY3gzUDJlWmwzMUhsZnRXZ2VRL1Jncm5OcllG?=
 =?utf-8?B?djdOaGN4Q1pXcEdCMmI0OHZCZEpuZEZmWmFBRXFmb3VObFNJL1ZrRXlVTUhX?=
 =?utf-8?B?aHVKdWVnSm5oR2t5RW9SRVMwMlpzb1RiaGpjWjY0K3ROWWVNWDJGM2xHam5T?=
 =?utf-8?B?cFl3ZmNoVlp0YmRKNjRrdHE3WFYzSm53R1JoN2hSMndTd2tzZFQyQnNXVjFK?=
 =?utf-8?B?enNzaHRaTE5hMXdRQ3hmWnVQSDFVendzU2dnSkppTW9uQWhiZ1dKcGNycUh4?=
 =?utf-8?B?OVdIVjJhS2ZoTmthRkxEdEFrdEtWUTJoVU9jdEw2ckxNMWh5ejRtTnFFd0xL?=
 =?utf-8?B?TE5RQU45WkNJbWZIdCtIOXNHUldHWnJGMlB6VTA2eTFEemVLUGlkbGhTMW52?=
 =?utf-8?B?bHZ4L21GQytYbFZMWmNxY2lHM0dUN1VSNitVNHJFdXR2Rko3VVJxejRNZUcy?=
 =?utf-8?B?LzIyWXM1TnM0SndnQ1U4ZHBOR3h0cForb3U3OXpKSTVQMFhSeFBmVzV4L0tV?=
 =?utf-8?B?NEFteFBhNmpqbHdyVG5EU0lmZWdCUjJ5bTZqTmR1VFlKYnFxUm9NZHZuK2h3?=
 =?utf-8?B?ZThUOTVISVkzWDJSY1RRaGQ3dEFuWlJINWxjVWI3dE0zTHJTSGpmZHZjL2o4?=
 =?utf-8?B?cVVlczM2Q3R2Y2tPVSt3YjJJWFE1cG5YSUN1T3Fjbi9pZy9uVXBBTGRsMzFl?=
 =?utf-8?B?M2JvVExwZlgzVzZ5aTBXRm5lYWdKTHphYTdUTGRlVGwyWWl0TzlaSVhZNTdT?=
 =?utf-8?B?b2MwUDNWeEVlVTUrQWNhYldzNERJK3I3aURGYXJWdUVJWjlOaERYNDRWUFRE?=
 =?utf-8?B?OGFmUXEvNGNPN2ZUZUpNRjRwZUQ4bGJ6OU9DcjJKWTljYXhmZHdXSkU5YkFr?=
 =?utf-8?B?UHFpKzRtTWZoTFduQlpnUGVHaGJQOXY0WEQyaVBUeTRVZ3BWakcyQTNvOUZQ?=
 =?utf-8?B?bXlhOW1zNGwzY3pDclRvZEVMTzNmSlR1cFZGVEhQaGljdzgzQndHVjhkNU9K?=
 =?utf-8?B?S0NZbGxLRHJyL3loUnZJbkwzMm8xVFZTM1pvVktZYlBUN3RNbEx4Yisxb2M5?=
 =?utf-8?B?bUhRY3dyTFdSRzNpSTQ0NjNpSVlQVjZzSmk0Ny9xelhjdWNnUW4wS21ldzIw?=
 =?utf-8?B?VVBYRlUvdGlkdExtUUU4V1g3WER3aHNUN29RZ1RKb1lyU1A0Y1AzNHB1VXhG?=
 =?utf-8?B?OXp2OUpGSnp1Qkt0dUJTN21wcHUvVTY0QmhCakxUVkJ1bjhKUVh1VkoxUmky?=
 =?utf-8?B?dkRFQ3VKckFsNlJGNnlaYjZicVN6M0RvOExidGdpQW5MSytaYzh1aVA4cVlE?=
 =?utf-8?B?TXF1U0x5SzkwQmI1Y2NpVHBJVC9mK0JkVEhOODNTeHRDVmE3YmhPaW9PbGF0?=
 =?utf-8?B?Mk5hNW96emJwN1RjdkYvT3BQTCsxSFB6R001Q0VEWXF0bXB5V2EvZUJLd3pT?=
 =?utf-8?B?SWhVaS93emFCOGFabkN2cGVLL0J4TWNCZjFZV1BoN2Mxb29LczNNeGtCdzhG?=
 =?utf-8?B?dUJreVVmaitOUEFSRUpUUVVUT1ViaG1sSjd1Wmd4WE5rVjlOMmxzOXJ6djA0?=
 =?utf-8?B?UTVPUXI3aXZHREw3WUpTWWl1VHRXOHJrdDU5ZDVlQTY2R3pOVzJEcGo5d21J?=
 =?utf-8?B?Uk9TNnJxdTcvZ3R4SFlUaVY5YURVcTBMK0lES0wybkVlQ1NheDVSVWlya25I?=
 =?utf-8?B?TEtYeDRRcHJ2WWx1SS9DUlFkZVBtTW51eEloK3VNMUVEb1MwQ29JMy84dmRk?=
 =?utf-8?B?YndlYnV6RE9wZ0Z2alZhTThOWHh3OHFCUXhFSGc2U25HWnlJUVFYWXIvYXJt?=
 =?utf-8?B?YUs0cG5kQW9vN1ovY0ROL3o4YWpjeEJDbW5hVGNkVW13djZ1Snh5WU9ZaXdZ?=
 =?utf-8?B?OWY3QWJhbk0zeGszRTJTL3lYV1ZjWXB1M280TDZEWmJvUFpuZEZHdFMrcmph?=
 =?utf-8?B?ZFhvamxNamNHREJQUG9XQTV4b3E0REVVekcwRzJoUzlOTnhDaXV6R0N6aXZZ?=
 =?utf-8?B?VHhyVTBleXJMbVpBckZoWEtsRklQR3duWnB0T0FMTTJ0SDdGTEZaME02SFND?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32609E1EF4B6A4B86DD47175931E580@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zPrWiC35OgMszFELx9YCZUH0anA38ADddrwDOD0hvk19RBc7n6eiFx63uPJH7arGwX6E1OQMB+z8lOW/jF7B5P7IWNAirnZPQ2ZnhI1Ii/nvuXFv5X3jCCoMzZzfsaLshBhT+Nze9ZJc0fOo5ee479BakplgAsgIq1NdDYak+yzr5Y5cDXO4f+nTjsFQn9aERenWjFXeQlhbEnK7kSshwehr1QzL5cxIIYc8+uKFYlWG5teKXKvB14nPCLBysOX6Y6BiaAD3L6UzhnXoe9cFWZzJ4VfjePBCF020CZyosjQzTbxntTpci3sr68jWcv1cKG0hGhezATsQNHDGCgkE19NraLEkVLBGDS1Fx2okPsqhwx0CmJ8oWzKsMHaFqUT/CTpOTQqxVa3lOowsF0KmYIONWIG40hmRUQ88FwTHQ/jHR+QU5+hyc1pjwvMQy35VYKv+QfMxoxZhMwt6tyOnDbvrMrG0Uv0TGBIoJq/CSgW3sm1A7kUW2W+F/oqQaEClnjzLTMDuFil0Gvl7i3i3FbBV4JOBEUIEjGrnyFALuLjuuzrkgUh51goBrsqUc/Gtwk9ueWp99M5zIlynhHv7UJQ+4n6fkVDG/eJvIOe2RFfEgNK/sJZUMTtQ15QiAGiv
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79aedd2a-e4e9-4ae8-d5f3-08dd75aadb33
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 08:04:43.8665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycIvo972utjGBVeiP51yrGfpEpInI8Mw4pwG7nVrEFXPpCvuvrNhzt8xQs5ACrf7ol2/+G0LfxCOGAP9mWNnZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12364

DQoNCk9uIDAzLzA0LzIwMjUgMDc6MjUsIEdyZWdvcnkgUHJpY2Ugd3JvdGU6DQo+IFdoZW4gdmFs
aWRhdGluZyBkZWNvZGVyIElXL0lHIHdoZW4gc2V0dGluZyB1cCByZWdpb25zLCB0aGUgZ3JhbnVs
YXJpdHkNCj4gaXMgaXJyZWxldmFudCB3aGVuIGl3PTEgLSBhbGwgYWNjZXNzZXMgd2lsbCBhbHdh
eXMgcm91dGUgdG8gdGhlIG9ubHkNCj4gdGFyZ2V0IGFueXdheSAtIHNvIGFsbCBpZyB2YWx1ZXMg
YXJlICJjb3JyZWN0Ii4gTG9vc2VuIHRoZSByZXF1aXJlbWVudA0KPiB0aGF0IGBpZyA9IChwYXJl
bnRfaXcgKiBwYXJlbnRfaWcpYCB3aGVuIGl3PTEuDQo+IA0KPiBPbiBzb21lIFplbjUgcGxhdGZv
cm1zLCB0aGUgcGxhdGZvcm0gQklPUyBzcGVjaWZpZXMgYSAyNTYtYnl0ZQ0KPiBpbnRlcmxlYXZl
IGdyYW51bGFyaXR5IHdpbmRvdyBmb3IgaG9zdCBicmlkZ2VzIHdoZW4gdGhlcmUgaXMgb25seQ0K
PiBvbmUgdGFyZ2V0IGRvd25zdHJlYW0uICBUaGlzIGxlYWRzIHRvIExpbnV4IHJlamVjdGluZyB0
aGUgY29uZmlndXJhdGlvbg0KPiBvZiBhIHJlZ2lvbiB3aXRoIGEgeDIgcm9vdCB3aXRoIHR3byB4
MSBob3N0YnJpZGdlcy4NCj4gDQo+IERlY29kZXIgUHJvZ3JhbW1pbmc6DQo+ICAgICByb290IC0g
aXc6MiBpZzoyNTYNCj4gICAgIGhiMSAgLSBpdzoxIGlnOjI1NiAgKExpbnV4IGV4cGVjdHMgNTEy
KQ0KPiAgICAgaGIyICAtIGl3OjEgaWc6MjU2ICAoTGludXggZXhwZWN0cyA1MTIpDQo+ICAgICBl
cDEgIC0gaXc6MiBpZzoyNTYNCj4gICAgIGVwMiAgLSBpdzoyIGlnOjI1Ng0KPiANCj4gVGhpcyBj
aGFuZ2UgYWxsb3dzIGFsbCBkZWNvZGVycyBkb3duc3RyZWFtIG9mIGEgcGFzc3Rocm91Z2ggZGVj
b2RlciB0bw0KPiBhbHNvIGJlIGNvbmZpZ3VyZWQgYXMgcGFzc3Rocm91Z2ggKGl3OjEgaWc6WCks
IGJ1dCBzdGlsbCBkaXNhbGxvd3MNCj4gZG93bnN0cmVhbSBkZWNvZGVycyBmcm9tIGFwcGx5aW5n
IHN1YnNlcXVlbnQgaW50ZXJsZWF2ZXMuDQo+IA0KPiBlLmcuIGluIHRoZSBhYm92ZSBleGFtcGxl
IGlmIHRoZXJlIHdhcyBhbm90aGVyIGRlY29kZXIgc291dGggb2YgaGIxDQo+IGF0dGVtcHRpbmcg
dG8gaW50ZXJsZWF2ZSAyIGVuZHBvaW50cyAtIExpbnV4IHdvdWxkIGVuZm9yY2UgaGIxLmlnPTUx
Mg0KPiBiZWNhdXNlIHRoZSBzb3V0aGVybiBkZWNvZGVyIHdvdWxkIGhhdmUgaXc6MiBhbmQgcmVx
dWlyZSBpZz1waWcqcGl3Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3JlZ29yeSBQcmljZSA8Z291
cnJ5QGdvdXJyeS5uZXQ+DQo+IFJldmlld2VkLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGlu
dGVsLmNvbT4NCg0KDQpUZXN0ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4NCg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfCAyICstDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVn
aW9uLmMNCj4gaW5kZXggMDRiYzZjYWQwOTJjLi5kZWMyNjJlYWRmOWEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9yZWdp
b24uYw0KPiBAQCAtMTU1Myw3ICsxNTUzLDcgQEAgc3RhdGljIGludCBjeGxfcG9ydF9zZXR1cF90
YXJnZXRzKHN0cnVjdCBjeGxfcG9ydCAqcG9ydCwNCj4gICANCj4gICAJaWYgKHRlc3RfYml0KENY
TF9SRUdJT05fRl9BVVRPLCAmY3hsci0+ZmxhZ3MpKSB7DQo+ICAgCQlpZiAoY3hsZC0+aW50ZXJs
ZWF2ZV93YXlzICE9IGl3IHx8DQo+IC0JCSAgICBjeGxkLT5pbnRlcmxlYXZlX2dyYW51bGFyaXR5
ICE9IGlnIHx8DQo+ICsJCSAgICAoaXcgPiAxICYmIGN4bGQtPmludGVybGVhdmVfZ3JhbnVsYXJp
dHkgIT0gaWcpIHx8DQo+ICAgCQkgICAgY3hsZWQtPnNwYV9yYW5nZS5zdGFydCAhPSBwLT5yZXMt
PnN0YXJ0IHx8DQo+ICAgCQkgICAgY3hsZWQtPnNwYV9yYW5nZS5lbmQgIT0gcC0+cmVzLT5lbmQg
fHwNCj4gICAJCSAgICAoKGN4bGQtPmZsYWdzICYgQ1hMX0RFQ09ERVJfRl9FTkFCTEUpID09IDAp
KSB7
