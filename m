Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C92901
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830653; cv=fail; b=Z9xEZB8BgedmcqCZhMcF33DyapsyzOK/B/nepD5veI7JCHMLdz7zBQdJZz68JkL93Ng1Jmx77xDHBNCz+OCxsrmdJGS9Cr2YfIOFfTLMlMI9ODrnsHw0TxkBQYBp6/NCeGmQIUcGn0vPLHmJDNVcGq73zQKU0AwPS+xVss8VENE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830653; c=relaxed/simple;
	bh=h5GOBAksXU8DufCYr2wGV5Ndr6DjyRg/8v6azdIo85c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kIwJ9+nV05NMnXqEPw6NAlT7Ia7UXsWMzmkb5WVqsMHpXsq5KwlE5zVX6jpWdZGH/zyPOhsSoNqqKOUS7dXUR8ivOhEiV+LufUopDBfTo6A4hffgBQA4g/GD9cStSbTDnRG5+mHJTEcdIuL15LZv5BFn9ztLm0N2WCI/dKNTfEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CBimrnZ9; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CBimrnZ9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1713830650; x=1745366650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h5GOBAksXU8DufCYr2wGV5Ndr6DjyRg/8v6azdIo85c=;
  b=CBimrnZ9fWiwQoGInA5ajsu9/U9K6ycOz/sU9xULfZDWK1WiiQxKTKXq
   LTWnEvg71FYYsVOQVVpVJjIrIzAC76HrrnS2G0/SPeFbCvi/oN+Q8C8sa
   YIagAxZS1a5uxI1RF9N+E1wQCaXhWsV5GDzFITOku4XLRBoUCKIYTUqGO
   n/Xjd11lrtNkwDfqd8gI7qwqbaA2ICvVuZ+cQQXzpC4w3n+VWxUjN7KhR
   xqUym1gkRssIiJd3ZqtisyrDoI9qWwrgLl/vxhG85LILyVmAWF6oJfcyi
   dFpuqcN5w0XKKrT9WHnbo++R+GnA1IKCNk7vmADU2ArZlf2gf7DivEvTh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="117686768"
X-IronPort-AV: E=Sophos;i="6.07,222,1708354800"; 
   d="scan'208";a="117686768"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:02:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Emu9sncVTA+Sazd4l9YjA48WEbBxMe/MT557VcnqB3M14aIUwuD4LyVeBEOF0/MxrftKYT8gq5+Xwr5WTsaWC0bIteFwmmg+itrC41jjeDpC6AUoEmn3AiGddBiub5LaKKEKVCoZm1ijeit4UmkJDULBnaSlwEe8bDtnNtqXi1pgX0H5V7R5/s2MLsonksbYi6Uy2G9fHVdXMJeRZlO/G8HepsGPdRlDUw1GMSz3x7wJY7kCdtjJ39QfLKo4Xsfg2flMtl11SJbcZLcU+DfAB3q8xiTT5TQt9sjPAMT1gaqZuW8SucIyJhy/yevBUCW1riITDbqyMieHtsnspQHRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6ewUkZAmmo7RvaySZYgQacY3Ib+OSBaDWmDCOnK8fI=;
 b=h0eSGNosyYeU2Gj4HgPfKkNisBht9bnpbJQOakF1EFZfDAPPWs9KYqpfkHHqelGATE4PDxdqpTKl4XBagZeo/9elKkiGX8QOUuVp8CiVz7ka2//tig7Dw4TrVe4OCOdFTD23o+oWSUxjl2z48CCp7rMa0am5qUt98IqqtkoTau8uWfTzDrd9+pGSvioWPjIuSuDKVif8dlFAdAAiEv7o7RkgNoJYsnjNGS4vTKrTsvYIaawyuPBGQUi2r3/m9fSOOHlx6ITcoYkvL9x2oVwPxg1h7va8mGmded+EulFKw5CltoMXLSaFOub7WUMs667kUif20tsLWgYHrqQqzpnJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB10913.jpnprd01.prod.outlook.com (2603:1096:400:3aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 00:02:33 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 00:02:33 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Topic: [PATCH v4 2/2] cxl/region: check interleave capability
Thread-Index: AQHalJWFMLLcyIwdlk22sjCGWvAyarF0JBmAgADUKLA=
Date: Tue, 23 Apr 2024 00:02:33 +0000
Message-ID:
 <OSZPR01MB6453093EAC6929760F8461E98D112@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
	<20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
 <20240422121717.000025ab@Huawei.com>
In-Reply-To: <20240422121717.000025ab@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=cdbdde81-bc98-473b-912f-761c8605d564;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-22T23:56:43Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB10913:EE_
x-ms-office365-filtering-correlation-id: ad16797b-da87-4d25-3828-08dc6328acf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZHA4Q0hHdC85SjlGSUZwR0hFUzREaWNYUjkwN3lhQ1I5UllMV1FLWHI4?=
 =?iso-2022-jp?B?QVA3UFN5dUVTamh1MzhRaEZ1QjZiak5kTDZrTzQ5ZVdaRTdVME5nY1Y0?=
 =?iso-2022-jp?B?SWpBSjhKMTF5MWIySU1PZDdzb21xbEJ3MDFBSEZFTHNRTkxzTHNpNWtX?=
 =?iso-2022-jp?B?dnhrMkdWcFFkVjF2UkdDOUJsbFVKcmkzT2xFcHVlNDBWSjN3ZE5TdXl4?=
 =?iso-2022-jp?B?QTF0L2R0dDBUUWtXMFphRy9tSExyRHEyZUZqckxFbGNscm1sZDg2Q1ln?=
 =?iso-2022-jp?B?cEEyQVFIM0FzQUtrSC9FZDZxTXY3NU0rUmVYblhCWURVc0lwTDJNdTBT?=
 =?iso-2022-jp?B?MHZuWXhTcE02ejBNSkd1OFJDKytJeUhhMUtlSWpHZWQ0QnpYVW1zdVg1?=
 =?iso-2022-jp?B?Uk8wc09OWHpTNjQ0YU1XT3A0TjlVZ3ZqN0drUmRnRTZCeWI4bHhUT2NH?=
 =?iso-2022-jp?B?VGJWeFpoa3VJYUZzQW85Yks1T3RYWE9KV1dOOFdZMENiWkJkTm5qY0VT?=
 =?iso-2022-jp?B?eDFoOUVrU0hDUHd4dGpYaWxocFZFUjlWSGNlRDNTek1jRUd0NWdTb3Zv?=
 =?iso-2022-jp?B?TVNDSFhLMGltWEdKWi9lWkxvNmhsRHU0djU4TXFSVnI0T1V6SDdFOFhh?=
 =?iso-2022-jp?B?LytwVExPSExrMUgrUkl4SUxWVXlBOTlGTFVKTUl3T2tFNHFONlBBSlli?=
 =?iso-2022-jp?B?ZElKcUtYdDNDYytWNnFNT2UydzQrOWtXNjIxdWhGTWNxMWxaOUpWalRB?=
 =?iso-2022-jp?B?QzVsNGk3ZnhaazR6dUowQVFOMEJ6bkZYNC84MEJhR2VqWk9mWXIzWTZI?=
 =?iso-2022-jp?B?NG9zSldYbVZQWHMybmRwK3kwY1hGNEhDWEsyZHd6LzQ0dVZ2SE1SRXZq?=
 =?iso-2022-jp?B?Y0Z6REZMSTRCMVk4bXVNcFQ0VlF4U3FVdER5VEtkWkUxOVFnRlZLT0JX?=
 =?iso-2022-jp?B?blQyZ0J6Wkxmd1NIQW5KRHYxWmZzOXFaUmZBTXhxNWpkeldyTGZBc2xs?=
 =?iso-2022-jp?B?dnM2elhFSFd5UjFEbVUyd0hBN3VkL1lLNXlHaU9WU0lMWm1hU2UzL0pi?=
 =?iso-2022-jp?B?WExoS0dZWWlSY1NxdVZsMmFyRFg0OG5pK3ZBR1U0WmlRVU5VeXU1Q0Vm?=
 =?iso-2022-jp?B?c2wrY0xYWGZ1ZnI5TFZxVUxML1puQnhzWW1mUWNLRURDeEt1Sml2NWdN?=
 =?iso-2022-jp?B?QXRZanJjYjQ4a1RCRGZ5L0ZHVzkvVkxvL00vLzZkMklCYzhXVHVZai9n?=
 =?iso-2022-jp?B?NExETjNNUVNwRE9MZ0t1dWZ0OWNNNXdNNnJXL1k5TjZBL3dIUVFNQjIz?=
 =?iso-2022-jp?B?d0tGTno4dHhWbjIxa1JwRzh5QTAway9WRjRuM2prVzQ5cEVnZVVLblNx?=
 =?iso-2022-jp?B?b25vN1RyTmNNa2svSzk4ZlBLMEdVcjF0VCswWjZoNDdDUWFZbGtOcGRO?=
 =?iso-2022-jp?B?Q0N4bVZIWVhZVG1Bb3NiNkpTNjYxVXZjUjB2R1dnUFZGK1JNeDRESHRZ?=
 =?iso-2022-jp?B?dStNR1NDeWJORjJ6QzQxZXVCb3V5ZEt1aEZOQ2dHbkhFNTc0UXpOYWFl?=
 =?iso-2022-jp?B?MHl1ZDdOTEM2cXpLZEc3RDdCZEgxMVlpbjR2WmcycWwzOTFmMXU2Rmdm?=
 =?iso-2022-jp?B?amtTenAzQXIrR1Mxai9aaHgzeG1UMjhENGxkNHZQZUlWU0E0MldQUVpE?=
 =?iso-2022-jp?B?bWRIOEozNFpGdXFuVUVrK0dyVzE3bjFGSkM5eFpjWVhtdEJQM21XUjN3?=
 =?iso-2022-jp?B?SW1SYlVnUlpiQjFpTkttR2hOQW9oV1Vkak1VNjJkLzBwblJXdndjS0ZV?=
 =?iso-2022-jp?B?QVJHWlM1QUY4M0hCdDR5dzJZNEtzTDdQQnByTWx2V3dFUnRtblpYT1My?=
 =?iso-2022-jp?B?OXdTdkcwZUFITi82QXpRMWJzbkd6eVZ0V3VKakh0bC85Y0RzbG00WHVU?=
 =?iso-2022-jp?B?cDVhYzBFQ1l1Tis2OVZXMmR4MU9WSndsV2hRTi9wMVRmUGlmakxJRUFI?=
 =?iso-2022-jp?B?RT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?OWI4UEh5S25KcjRybzh6ZXptVHVTby9VZDZRUWo1U0ZZbzZJZFI1SjBS?=
 =?iso-2022-jp?B?TlJCWGgxNTVIR25NREc5dHc3QWdyOXpzS1hBbXhuT1hzU3p5aUp3QTg2?=
 =?iso-2022-jp?B?OHh5OHMxaWZydWFUdE9lQS90TERaVER2b2NxNFUva1l5Zkswb3gvaktn?=
 =?iso-2022-jp?B?ckhYaitnb1E1K01lS0tNL2NFUnhWUVNJdmtSalJQSDlkWGd0bnMzR3ZH?=
 =?iso-2022-jp?B?ZCtEVkJMY0NpL0pma0twS2o1NUNOMUU2L05OWWRIWk8vMFpKZys4bkd3?=
 =?iso-2022-jp?B?dDRCT1Bsa1Z1cTFmbWtPN05uaE93WDBxeWJlZk95bTROdlFVaUVZOStq?=
 =?iso-2022-jp?B?RWY3ZGdyVGJkZWxPMTF4M0F6NkIxM2NFd2NIeCtodEM2VGZ5STEzdXZO?=
 =?iso-2022-jp?B?ODl1SzNYYkZKdEpONzUrV0U0S3RqYzlmalR1RXNBOFJ0cXI3SlUwRWZL?=
 =?iso-2022-jp?B?MWE5Mmx1c0w0Umk3ZERSM1l3SnpxMXZTbFhDaStlMXhMUzB3NUt5M1l0?=
 =?iso-2022-jp?B?b2hXWUZxeFpRdUtTY3U5Nm44Tzd5R3RFWGxWQWFPS3VnczB0Q2tGVC81?=
 =?iso-2022-jp?B?WUFMeFF1cks3SFJEcWVlTVFJc1lDcVJ2SFlvRE9ENXEvVTNFMzRBcUYx?=
 =?iso-2022-jp?B?ZGVZOFRFVjV1b2JOcWdVRFAvdXlIYzNHTWgvazVVTGRjZHloSitBU1hD?=
 =?iso-2022-jp?B?WGZCMFdJemw5SzFFKzBIRnJjM3dDOUtWbTd2K2JFOGFBMEFmQ1RFSlFQ?=
 =?iso-2022-jp?B?aWhFd3ZnYTdzNVVSU3lQNDA2VFFxZHVpaXRaNTdNNS9iLzd3eVRhTkN2?=
 =?iso-2022-jp?B?MW5qZnFucXpVTTQyT3EvblNHdG40TVM1c2FaakxUVHh5RlFOWE12T08r?=
 =?iso-2022-jp?B?aldmOHhKUVFBVnZXWGJKdUs2NEhIc2l4Z0Z1ZjlidEs1cms0OG1pNnJT?=
 =?iso-2022-jp?B?LzFtT2srRERxM0xWbXVPZ1FCN1o5ZUd2L1dTdU5CaXFkQjkwL21qK1ZJ?=
 =?iso-2022-jp?B?c3g1Q0FTV1JIYktCTk95RUk3M1IyY1ltcjQ0UlkwUUk2K2llbEUvZDV2?=
 =?iso-2022-jp?B?cGh3OFlKV3BPR0FCLzA5RWtiUHJnRnVxamNNQ3EwL0JBbnQveGJWRW5K?=
 =?iso-2022-jp?B?VGlvSzZ0S01MR3BhVFV6UUtldzhzQXJvMGtieHVQMXVhUitVUVRpSnVy?=
 =?iso-2022-jp?B?MnNjRk1rWFh2UkJHOSt6TmhGejZBZmc2YkRFcXpwMU1qcHBiQjQwR29v?=
 =?iso-2022-jp?B?bzB3MWtKakNuSi9ZMDhKK2xNNzVWOVVzOEZMTTZnaHNQazc1R1dJWHRL?=
 =?iso-2022-jp?B?NTM5cE92YVl0NVZjQ0FKQ3FnUXRyUTVBbXpMWlNYTjc2RVJ5dDFuMWQ1?=
 =?iso-2022-jp?B?Y2JmdlRGaXY0TkdxbHZhRGNIUDNnd3hXM0tzclhnaTZBMTE4Z0VMZ0RJ?=
 =?iso-2022-jp?B?Ty9BNkNBeUNHdnR3cHJ5OW1zSUJFNktEZWE0SUI0SU54UDlRSXlVaVhJ?=
 =?iso-2022-jp?B?bldHOVNxdDl5NXlrc2JpZ04zMHRYU20zbVd1ZDlqOE1TaEZLVTUyVVRw?=
 =?iso-2022-jp?B?Z2J6aThBQUpRNjQ3UDAzK1RhaUg2S0kzRnFRZ3BCL2RpcFdqdnlTbU1I?=
 =?iso-2022-jp?B?VllkOVNiQmpKMTBMRkhUM0YyU3F2eFltdTZzV0xSa3JxbzBsR3BkTko0?=
 =?iso-2022-jp?B?NCtHcmJvdnZyc29KWmVucHdLMWc4bEFad0pBK1VoSmxWbHFoWElmUzV4?=
 =?iso-2022-jp?B?b0xyaTVVYlJPSE5ldTVEcFMzMjcrUmRHU3BJR2RRWkZFZHJnNTZzVjZO?=
 =?iso-2022-jp?B?TERGaHZiNlVEYnFqY0VTRW9jS0VIVlpHNTVObERLakFTbWFxcFk0KytF?=
 =?iso-2022-jp?B?azQvb25DZ1ltbnBPNS96T2k0SUpKVmtScHBXR2x0dVgzQUVGREM2OTRV?=
 =?iso-2022-jp?B?VVB2MDdXdkJaMEE1MjF5RjRicWl6a2lpcmt4b0Q0My9HOVBpWnRhN0lQ?=
 =?iso-2022-jp?B?Z2VLNXFCVlpsRG9sR1JadHB6cDdaNE1vRUhldlJGaXRDOHJQQllqSWZH?=
 =?iso-2022-jp?B?dHpQb0tXWVBXM1lFNGZpZy9FZlBmVVVTdE9NSmEvKzBhbTJqc3pYK2xW?=
 =?iso-2022-jp?B?cTlha3N2OHlYWHJGdHJyNnduSEovamxWL1NCOTFKSmU3VFprNS9zc3Fm?=
 =?iso-2022-jp?B?KzJyZ1RCWE8vL05WenRIaFVzNWwzR3lHSnMwcXBtN2tsMkFMSWRzekJW?=
 =?iso-2022-jp?B?SmxIYjFCOXBBTmNCL005Q2VxL0RIT2lRV3VoaU14YTgxOWxNdHd6MkRB?=
 =?iso-2022-jp?B?Y3Azbg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UFrG/yavD/ChqGfU6buIOEw3ccOBArMtmS7HMxL0CrhiHV8usiM4uGuDWhESKPpI0Bl8qPns5/5jEpXsAAOgMZ8lnga+nFcceCQdwp4aEwxza/ZejIuU1K+4rIs6/x/ZC1319/9Dbk+DzdeMCjk6NG6J+Y1aU1qwChfqi2l8r4PQPgFrsIlekusT5SbQiRkmh7tUYeXo279OTQAHQEUiCVhIcVmfmW0HqLeKPuJas1JSv2WdUk+IU1oy8TLrdB8eCYe8ySCFMtplri9aLLj6bfuPkx0brVP5klQpm4J+EAncZBnpW6DVfBpLKMqjHpXoG8WSQoq9dYQfjUBVLGTwpSfqDlESh8pfYGY4KsruBD5frCe9AWcpdZgOTjzqVlrtI9XlfnEdwojh2dRZzOq3IQbAtA5o6vP8SY+fVwed6aBwd+FPk8bPbbV+KWBtvCd0fIyAuCZYFvuNiyhUPN51r55jykAzMJ4hYi1HGpHIozFBRHmEAgYc5Wart8h6Bn7HIlBMgTE7KpszOW2CONZsySqazSFxqALnDH0wXZ/iiYv4Y9Y/QabShx7Fr4IQlS+ttbfHukdLzuniSQyVt4rRE2o8U4G0eLeviynd+n1MsCDFlOST6lyMVJpEtpmT4New
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad16797b-da87-4d25-3828-08dc6328acf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 00:02:33.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUT1mpsmyzBfUE+j+fv1nxTq+mT6jp6zMeHQFt9369bU4Psvb0q2ta0Qq5+BM7huC8nw1jtpb6jpvcghcbnNag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10913



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, April 22, 2024 7:17 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; dave.jiang@intel.com; alison.schofield@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v4 2/2] cxl/region: check interleave capability
>=20
> On Mon, 22 Apr 2024 05:13:50 -0400
> Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:
>=20
> > Since interleave capability is not verified, a target can successfully
> > attach to a region even if it lacks support for the specified interleav=
e
> > ways or granularity.
> >
> > When attempting to access memory, unexpected behavior occurs due to the
> > incorrect conversion of HPA to a faulty DPA, leading to a segmentation
> > fault, as observed when executing the command:
> > $ numactl -m 2 ls
>=20
> Don't mention a segfault as in theory it should have been impossible to
> set this decoder up (commit decoder should have failed at the device end)=
.
> So just say that it fails and leave the details unmentioned.
OK, got it.

>=20
> >
> > According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
> > Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
> > Capability Register' indicate the capability to establish interleaving
> > in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
> > be attached to a region utilizing such interleave ways.
> >
> > Additionally, bits 8 and 9 in the same register represent the capabilit=
y
> > of the bits used for interleaving in the address, commonly referred to =
as
> > the interleave mask.
> >
> > Regarding 'Decoder Protection':
> > If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
> > interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1=
.
> >
> > If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 1=
2),
> > the interleave bits start at bit position IG + 8 and end at IG + IW - 1=
.
> >
> > If the interleave mask is insufficient to cover the required interleave
> > bits, the target cannot be attached to the region.
> >
> > The above check does not apply to the host-bridges with single port and
> > switches with single dport, because there does not have a instance of
> > CXL HDM Decoder Capability Structure for them.
>=20
> There needs to be clear separation between such cases that do not
> have HDM decoders and the permissible case where there is one but
> it can effectively be set to anything because no interleaving is
> going on.
OK.

>=20
> >
> > Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>=20
> >
> >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *in=
fo)
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c186e0a39b9..5c09652136c9 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1210,6 +1210,60 @@ static int check_last_peer(struct
> cxl_endpoint_decoder *cxled,
> >  	return 0;
> >  }
> >
> > +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int =
ig)
> > +{
> > +	struct cxl_port *port =3D to_cxl_port(cxld->dev.parent);
> > +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> > +	struct cxl_switch_decoder *cxlsd;
> > +	unsigned int interleave_mask;
> > +	u8 eiw;
> > +	u16 eig;
> > +	int rc, high_pos, low_pos;
> > +
> > +	if (is_switch_decoder(&cxld->dev)) {
> > +		cxlsd =3D to_cxl_switch_decoder(&cxld->dev);
> > +		if (cxlsd->passthrough)
> > +			return 0;
> > +	}
> > +
> > +	rc =3D ways_to_eiw(iw, &eiw);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (!(cxlhdm->iw_cap_mask & BIT(iw)))
> > +		return -EOPNOTSUPP;
> > +
> > +	rc =3D granularity_to_eig(ig, &eig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/*
> > +	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)
> > +	 * if IW < 8, the interleave bits start at bit position IG + 8, and
> > +	 * end at IG + IW + 8 - 1.
> > +	 * if IW >=3D 8, the interleave bits start at bit position IG + 8, an=
d
> > +	 * end at IG + IW - 1.
> > +	 */
> > +	if (eiw >=3D 8)
> > +		high_pos =3D eiw + eig - 1;
> > +	else
> > +		high_pos =3D eiw + eig + 7;
> > +	low_pos =3D eig + 8;
> > +	/*
> > +	 * when the IW is 0 or 8 (interlave way is 1 or 3), the low_pos is
> > +	 * larger than high_pos, since the target is in the target list of a
> > +	 * passthrough decoder, the following check is ignored.
>=20
> There may be a decoder even on 1 to 1 routing cases so is this correct?
yes, the decoder exists.
for this case, the num of interleave bits is zero, means that no interleavi=
ng here,=20
so we can ignore this check.
>=20
> > +	 */
> > +	if (low_pos > high_pos)
> > +		return 0;
>=20
>=20

