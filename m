Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5128BEC
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238974; cv=fail; b=LbH8IRfgKzTaIzp+2pPhZ56t35Fgwn7cwHCSYHWSOKrU8X52i37k8UKgkDyfzG61/jrnu9CUcLopfk87qijK2g864aGVM/NbCWZZpsK8V7FXzbez0nzjWQoJBmylrM083i859/kR/Ab/IVByXhKVObqOZpi3791iLeI9mMmq6iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238974; c=relaxed/simple;
	bh=ER0dK7O2Gzdjf35xZz+f7XzjATt0jDVhAOlLYEGgw0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DvIAijIicFOmTDAZTE15W3gWufQ0gS7vE6SGPXQCmdRqzvt4oLGrBHU90cKVqy0UgYjfqNG4CIjntcA2ivHSM6WiW35OZdX7mBZ+9CbM6H2DtBKJXl7So9nvXbfDf2urIFgFV3cruDhObPyjMxLj0eVEGAFkC5xGKjvNqSzxkkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ZgBwa+HK; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ZgBwa+HK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1718238972; x=1749774972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ER0dK7O2Gzdjf35xZz+f7XzjATt0jDVhAOlLYEGgw0g=;
  b=ZgBwa+HKBwRtfZ00fu3I7bVlNjDQTavSve5qLSauy0ZpSF3TpOvHn6e9
   FbvIHRRxt9kccQvkG+pca7JpHlbbMSWZGbaXaDeWfb8AombGm6eATWoLX
   z0jjkG5Ezp/Hu7slOOr1k6wFM1/HPWNgBGnqQuhsoNKlsVAx43+E5rb7I
   CQVdvm4JqzvI8chLwAdcQjDLbX8o6EXfrTGI+MQDyJ9HhuAqm4UGhv0ko
   qOywhcMpqvrcB7EbY5nL1d88LnJbisIkDX97/uBqtJGBflq/VrEWjYl1I
   yS4I7QItTFf9Z4FRBwXBSIaY3Q8PyANnSxVw4ceqbenbEFDsq/OFqJjS6
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="126935040"
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="126935040"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 09:34:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyLDskOcoLzq4LGxigHHKW5TwHFw8OHgm/cIIt+w+uZMl+IYdojz9H30TsNGWpg7qQXe5pnzxAqnq3mW4ixHYMsUgbXq8n7KILOcwN7cno1kj6ZhE+qXpgRnLUA+OLW2l7ou6WZQA6D/JgrhrjdHLeDSnKTijjsS2wzqVndgoG7MtAXDc4iw9oi8X/ABqI/KqQN/VC4qlwaOVTCaceM0LBuf/VQjOFlaTIHDKNEgroPp+gqv2mTBx/a4tRmtPCwUo6YTmEmQ646TTe/gfH+fpLYnBTXxVA0oZ5l6iL+vbkcnoKgi3jvb2PI4lL9U6Wyq7ajK6P/rx7spCjASjZtLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LP8CnbMgbRUUCqleXItytMgrvuKluBBsGQ05Vb0Wbc=;
 b=lbIq2Zrkwc5ywpQEZumxzfcUHVvGS/T1TqcefsoDIIWKeJJ9SPuyzM+8f89KlqetOnPrb41gKuOq8/uFAKNRNhCOfOJI7rKHHs63KZaICxLVmhZfknXMo1EWUoByFc0tJMiOOo/9w2pBWFdEK4Q/trXMx4mQx7WPcRN5TcMGkqBZHrWovCx62aMCcFTPRHSqv6awaQ+FYgX4wvOHARxqh7+JviiRPDOe11p7HUteBLfnQKZ+F3bp31cK/o4EMfBfu2AuE5oAM6Ur4IZ4TYz+euHupQFEDqSnY8RQtSC3Qzdcb03ywaTcUdzt0FbY3iErON/cj+Zpq4EnOa1Q7df8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OSOPR01MB12313.jpnprd01.prod.outlook.com (2603:1096:604:2df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22; Thu, 13 Jun
 2024 00:34:53 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 00:34:53 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v7] cxl/region: check interleave capability
Thread-Topic: [PATCH v7] cxl/region: check interleave capability
Thread-Index: AQHavHg+kayOu0TIlUazgRKg5v7PCLHDgwyAgAEqsoCAACvLwA==
Date: Thu, 13 Jun 2024 00:34:53 +0000
Message-ID:
 <OSZPR01MB6453604FBB697F13FBA270DD8DC12@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240612032544.39149-1-yaoxt.fnst@fujitsu.com>
 <66691eedbe8_31012947f@dwillia2-xfh.jf.intel.com.notmuch>
 <ZmoZfZPcGNYCqQGL@aschofie-mobl2>
In-Reply-To: <ZmoZfZPcGNYCqQGL@aschofie-mobl2>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=3f5ea8fe-23b6-4edc-8301-373e7870294d;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-13T00:33:04Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OSOPR01MB12313:EE_
x-ms-office365-filtering-correlation-id: ba644f5e-6d44-4f66-93f0-08dc8b40a458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230034|376008|1800799018|366010|38070700012|1580799021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ckxnc29LV2pmb3duemltbVVnbW9KVEdXazM2M2pBU1FRcC9FaXd1RUd5?=
 =?iso-2022-jp?B?U1h2QmY3T1Jxbk5oUkVnaG9jSUI3TWhBYXlWN2JraGNtSHREWHVhZ2RW?=
 =?iso-2022-jp?B?Z29JWDh6eGFwaU51MmpRY0l2YUZOdE5OU0dJM3FOQ25xMWNXcVNXUkdO?=
 =?iso-2022-jp?B?ZWtQdUhiUUtidVRrUlVJUVFZVTJ3YVRCdi9nZGhiV0ROcVBpVDJxYnI2?=
 =?iso-2022-jp?B?TWJNVEd0cXlwbU4vNUY5bitTVkRjUXo4dTl2NkJYQ3FFaERla1FkL3cw?=
 =?iso-2022-jp?B?L25HbHlPU1dxYjQwdzFXQ1NFY1pWSXNMeHZsWFo2aUpXTDBmTUdlQ3Bu?=
 =?iso-2022-jp?B?RTZCSS9GWXNuNTlLUjNDckRtOC9nOTRMWnFlNWQzSlpRZ0RWRXp4SHoy?=
 =?iso-2022-jp?B?NGd0OUhwQzlmaWEzeHc3QTVDZk02WmNZUGk2NXpaVlNxSkJXOVptZ2NM?=
 =?iso-2022-jp?B?Tm5pbkY2WkczS3llLzFiNjh5SGRSQ09wSHVvQTJLNFYzRjhmQnZhLzBn?=
 =?iso-2022-jp?B?OHpPOEFIbVo2b3NGZGVsZ3k1aTFGaUdQL1ZnU1VnQklzVVJzQU1xYStZ?=
 =?iso-2022-jp?B?aUZzdVZUb2pXaHVNbnJTbi8wZktHaWpWenBocmFZRkhSQXU3aVVXL2c0?=
 =?iso-2022-jp?B?bGx0VHRJa0J0UzNuaVk4VXZaSkZ1UGpxRkpHbm0xU1RvdHhFYytaS0Rq?=
 =?iso-2022-jp?B?U3dOdEpvamJIaEZ6UXB5K0FXcXlrS3RZMkNOcVp4ZElBclVuWkQwelMw?=
 =?iso-2022-jp?B?VzJJVjdsZGtwVm4xNG5rR1pSV3J2a1pZYkg1ZUh4TzZoUC82UE1NbTVl?=
 =?iso-2022-jp?B?R2V4MzNhb1cxOU44ZkhKTklnYVhXM3FGcnRuMnZNZ09TUXlWTmt6M1Nt?=
 =?iso-2022-jp?B?OWVTSEUxS0VwZUJ0NjRQYUl6NGJNVVZVdkJNSTl4SnBkdDhMcUgrOEpz?=
 =?iso-2022-jp?B?cFV2N1plZU9Eck4yWHJUdDJsZXdsZmVaZUZaRXYxNXRZSUQvRUg0VHR1?=
 =?iso-2022-jp?B?aWE3MjRnb0k5YlExZ0dFL3poaTJ0alRsS0t5NHlhWWs2K0haUVBKbnRL?=
 =?iso-2022-jp?B?NURzKzdISFBRd1VCcUdiVWlPTjRza2pNSTNBRjd4TFNVUjJtL1R6cXMw?=
 =?iso-2022-jp?B?YlpPY25zTVRJZ0R5V1RxL1ltN0E4YlZYeXp2U0poTTRLT0QvdTNuTXBD?=
 =?iso-2022-jp?B?aUVPbFROWjlURWdBblBhYW9BWWNrejFZeU4vUlluMWw4cUZCcTNXOS9r?=
 =?iso-2022-jp?B?SnNoMEs3elJOVDVkWHJMK1l0WUFkQ2o2K0REOUNBcWo3K3lvSDgzRTBz?=
 =?iso-2022-jp?B?RTBSK3lCSDNQMmppYTljY3RzWFZRd2JMWGpKTDFhUWxPL3JUTlc3QitP?=
 =?iso-2022-jp?B?VTVWdTdjU24zcERSbUsyTUNRanFqVDcycnNnbGttMm52eit0NnVOZFdj?=
 =?iso-2022-jp?B?NFJUbGxMditFYy81SGlOTHNjSHlLcTlWRHRkcG54UGFrL09DeHJPM2NJ?=
 =?iso-2022-jp?B?RkdYYjhKVms3QUxaaE1vdXJxWks3MFpTejF6b0x2N3Q1SHhnYStXMWZH?=
 =?iso-2022-jp?B?cVlocFFmS09zUm1ueEVGdWlBSmVQY2EyRW1zQTZPY2Vzd00vUytkT1Nr?=
 =?iso-2022-jp?B?UnpYTjY2MlNzV2V2QTFxSEtCTHl3Y2ZBYjNyT3RxZmxHMFBTWjdOMkJj?=
 =?iso-2022-jp?B?WXVZTW5LRDRaWXVZN2RNajZvU1NiYWs3TkYzMWcycXpETDd0YlhZeDZN?=
 =?iso-2022-jp?B?NE43R3lSWS92Z0s3V2Fva0hDNGs1QkdaWkxoMVJwdGExZDZTK1RjbkRR?=
 =?iso-2022-jp?B?a1pxL1ZuNTh3Ti9HWWR1SGttN3A4VmFuOVdsQmh0c2RsbjhMN2NEUDlN?=
 =?iso-2022-jp?B?dVpFYjhqNDFFM2t3TDNNYm5wUEJNMVNmWThjblROd1pzVW0zVUdRVVEz?=
 =?iso-2022-jp?B?SWtqWDJaWjUxVXFLOVBjWTdKVkM1MHBOK3FhcXlPR2JnVEhsVlVsR3lH?=
 =?iso-2022-jp?B?WlJ4b3NmWHg4bWNzSEFhcnBJYlF4T21kcDFTMGlwc2kwelZaWHVQVVE3?=
 =?iso-2022-jp?B?Vnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012)(1580799021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Q0RJdmw4aUxsMlp5ajg4a2JmejNibDBpQm5CNEtGejBTaVd0NW5zajlE?=
 =?iso-2022-jp?B?aXBraWxUdlFDaG9ndFNBMEJrM0Z3dEN2a2VNSFptWVFiUFRGZ3EybUh4?=
 =?iso-2022-jp?B?TCtGRFU0U2FMbWRWR2ZNWGtZMFMxN21rdXROWkc1VkVKMlVqd0M1MmZG?=
 =?iso-2022-jp?B?V1dLdnBpZHAvclI2ckIrd2xLYzUvTEV1VmZRZjRmTFVCNmxjVXBNMndr?=
 =?iso-2022-jp?B?RnY5RjdvNVZnUjR1YmR6RWcxLzBXWGs4VTRmZ2Z5ODUxYnRvejVIOEk1?=
 =?iso-2022-jp?B?Uk5ueHBGR0RRcXQ0RlNBUHp2N09LYVpiRjdUc2ZPaVA5OFYwUFFGTlRl?=
 =?iso-2022-jp?B?bHI1M0JNNmtVa1ZZUUJJUHFMZjF1aENuNG1qSTFkNGNwQmREMDVRakpu?=
 =?iso-2022-jp?B?NVFHMlpBdGNjclVqRzVTRTJMbGRRcWQ4cE9ldlo5Ynl1eEJTLzFZWGJr?=
 =?iso-2022-jp?B?RzZVQzdQK3JjZ2hvc0I5ZjhaSWJ4OWxrbllOUStscHZoNjVvY1BzNHhV?=
 =?iso-2022-jp?B?alVTeGd6ZlpUdjQraVdxMXVLYlFBZlllUnhwQVl5aDVyMmpsOXkzenpG?=
 =?iso-2022-jp?B?S056UHRLK1dmZ1QwclphS2xhdU9Kb1BnbUloRUd0T3RJSndtZ0lTTzdy?=
 =?iso-2022-jp?B?d0pYNkdKRDN6S2dXVXlZUlFZZWlITnMyUWJSUzM5cGcxeElneGdTNkZX?=
 =?iso-2022-jp?B?VjMwQmFHekVPT2JNNXVQQXJSN3Z0Qnc2d0ZyKzNxTFNNcnJsNlVNS25j?=
 =?iso-2022-jp?B?SG9tS3RxSkRTUk5wVXo2OGJoRGFKTlZOUW1WYlpXZnBkN1VuUnBieGpR?=
 =?iso-2022-jp?B?ZEZPT00rRFU2S01XQVFMaTdvMVVIcy9FdlFpa2ZnS2hFeEd1aVdlcHdM?=
 =?iso-2022-jp?B?NDd1NStXeHpiU2l3U29KY0I1ZDFrWkVnRGUrTStjRW0zeVpkcFVWNEpI?=
 =?iso-2022-jp?B?Q0w2b2xWd2F3eVNZTkxPYitiK2tTYUl3WHdKMnlkWGJtZW1UZk5JZTM0?=
 =?iso-2022-jp?B?YTNLeHU3Z25Jb2MvWXlhS1BBTjBjeGR2YU1PaXlxSTV6cjQvdG5WWmJw?=
 =?iso-2022-jp?B?U1Q5d285eVZJWE9wR2lvT0F0cVZwNS9pM0JYZzcrYWFTN0UzSnMxaVp5?=
 =?iso-2022-jp?B?UU9tekRTeXQzcFlHNFJ0U0VnS3M3NXI0WDdtM2cxQmRvN2lpREpsR2hi?=
 =?iso-2022-jp?B?TjJiTmVwR3hEVGVsdS9rV1VCbnVmNndUNGlFNHdGZ201Y1Q0aWxpWm1o?=
 =?iso-2022-jp?B?VGdya0ltWk5UT1g2aWtRQ1V5RVdvVXd3emR6S3Q4U0xXMFJUdXBKOVhX?=
 =?iso-2022-jp?B?YUJza242MGprazJiQTNUQmRtU0RxQkQxWjBwSG5STnZ4Ry9vdUF4aHl4?=
 =?iso-2022-jp?B?OHVxUU1qZytRbXoydVNtYStHZXpIZ1hEREZVNWlVWElmc3IvRVhEMTdN?=
 =?iso-2022-jp?B?TUZCNHphWU8zdGtTWWpySzlIaHQ4TkRkbWsrMzQ4MUJxTzFqcTJSdTcv?=
 =?iso-2022-jp?B?eklYS3ZCYUJKTUFHNnZkdlNzaHhBRFNYTjNNM0dkL2Uxa1BwV2hVODRE?=
 =?iso-2022-jp?B?R3RrOTlzelBxMFlISy9PSlFueWNSblNYSUJPQXdiWHlRNjZobGJweDNa?=
 =?iso-2022-jp?B?WDBCcXM3eDNtZ1hINXEyQlk2SGhEei9jTzJNY2FUdkVGNk9hQXkrQ0hx?=
 =?iso-2022-jp?B?Nkl0OVhUWGM2WEdudXJoaVJRblBFK1ZuSk9ZN1hhNXFhRzBtbXZqQVB2?=
 =?iso-2022-jp?B?T1phaHIwVys4bWFIVTVwcU52Y0pXaE56OFFxVkxSeFgxRTN3dUMwckFL?=
 =?iso-2022-jp?B?a1hmdnhRSitZZTdyMUtOQXFEQ1FaeThybnN3K2REaGZ3WDRMOEhVMzlr?=
 =?iso-2022-jp?B?K0tnYjZvNExzZ3NYdGZ3My9VTk92SXFvU2JLL3owc1RWNW1GeWpKNDZj?=
 =?iso-2022-jp?B?QXdIMjBzRmpWU0FmR2IveWZWa2RURDFoVnN3bGNwSzNjdmJPYmg0Mml0?=
 =?iso-2022-jp?B?RFFMQi9XYVA5RHVDSmhxK2JnTXB6Tzd2ai9LNkRwSHhvbWM5eWcyMTB5?=
 =?iso-2022-jp?B?akVkQjFkejVHcmw4UEZpcVVoL01yREhkUGsxK2xQMWtyMzBQTGk1K08r?=
 =?iso-2022-jp?B?SmYzbmV4YzdPUWsrazFVSlJtdjhndzhJLzJoTnY1ZWRmTElleFZGRjJS?=
 =?iso-2022-jp?B?VVQrRkpSN1R6eWdHQ0FrNXhXdnFHbHdaVmxWeXY1VkdDSUtkRVY0VzJL?=
 =?iso-2022-jp?B?L09FTmRqN0NQalBXK1A3TXNRRXdtQ1RWajA5SUhGT0Z5U3I2Sk9vSUlE?=
 =?iso-2022-jp?B?MjBEUw==?=
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
	MNZbadDDQiiRZ9ib0qzPhGt09PkcYEnIhiRloQzTjifJYQAZOkW8A27E/mSxMmZvHy2sW9eVkAN9L0YgYFqnfmMCy3GrXwinfEhg6tLr3+GPXuXhopLFP4yNWjiI6i6AWgzMvEw0iShVa8Vh/apn8mPdy4dtc6lyrBLTfJfAfU+C9MuKJEM9gEl/l1Op4Dxj4ivjY9eFnn+/iX/cb6xc4uhN2GRaAvI8n3/9lfOirXXEvwTLAwJDFUoCJ8CZIwXtQjDAI9R3GJOijlZRWiHWI9KL+w2tLcEbymMd2ESyScgRpEGGhfcUpmC5FxjosNH1l8NJE/T5TgUDFnYFtCS3wiBfh2g4i5patzKWcvy3jBYxVAHkELPN6kiNt09LeiMelrYYuchDD+HzZNP8jmkvb+eJVi7/7+ZTetFnewuYK7poVS6lccVTLlg9S6NAm9Sf9Ui4KuTCEM1g7e7kb2ksReIozOCTDSMZGBiMECvoReHe1o+Hw44FfLEe9QZVwU4dzXL/xmigRchFeoGL2nQksEkowfbDiL0pehsNVRPAO4oegKvnGQFLjvhOL467/FfeROf/Mj8a4BewTe8GoX86o+/mxO/BsmC1PRLKvxW9aZ2Z9n4hwFJpW3Gp524qY0k4
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba644f5e-6d44-4f66-93f0-08dc8b40a458
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 00:34:53.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tANARlKt94+8zF3a9cBABqj/etz3f5nJvBj8C6++Skx6ALBvkv+yhuWiF/96u5q+vNZ0Ah89y+k2DVvTo8zsmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12313



> -----Original Message-----
> From: Alison Schofield <alison.schofield@intel.com>
> Sent: Thursday, June 13, 2024 5:56 AM
> To: Dan Williams <dan.j.williams@intel.com>
> Cc: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>; da=
ve@stgolabs.net;
> jonathan.cameron@huawei.com; dave.jiang@intel.com; vishal.l.verma@intel.c=
om;
> ira.weiny@intel.com; jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v7] cxl/region: check interleave capability
>=20
> On Tue, Jun 11, 2024 at 09:07:09PM -0700, Dan Williams wrote:
> > Yao Xingtao wrote:
> > > Since interleave capability is not verified, if the interleave
> > > capability of a target does not match the region need, committing dec=
oder
> > > should have failed at the device end.
> > >
> > > In order to checkout this error as quickly as possible, driver needs
> > > to check the interleave capability of target during attaching it to
> > > region.
> > >
> > > Per CXL specification r3.1(8.2.4.20.1 CXL HDM Decoder Capability Regi=
ster),
> > > bits 11 and 12 indicate the capability to establish interleaving in 3=
, 6,
> > > 12 and 16 ways. If these bits are not set, the target cannot be attac=
hed to
> > > a region utilizing such interleave ways.
> > >
> > > Additionally, bits 8 and 9 represent the capability of the bits used =
for
> > > interleaving in the address, Linux tracks this in the cxl_port
> > > interleave_mask.
> > >
> > > Per CXL specification r3.1(8.2.4.20.13 Decoder Protection):
> > >   eIW means encoded Interleave Ways.
> > >   eIG means encoded Interleave Granularity.
> > >
> > >   in HPA:
> > >   if eIW is 0 or 8 (interleave ways: 1, 3), all the bits of HPA are u=
sed,
> > >   the interleave bits are none, the following check is ignored.
> > >
> > >   if eIW is less than 8 (interleave ways: 2, 4, 8, 16), the interleav=
e bits
> > >   start at bit position eIG + 8 and end at eIG + eIW + 8 - 1.
> > >
> > >   if eIW is greater than 8 (interleave ways: 6, 12), the interleave b=
its
> > >   start at bit position eIG + 8 and end at eIG + eIW - 1.
> > >
> > >   if the interleave mask is insufficient to cover the required interl=
eave
> > >   bits, the target cannot be attached to the region.
> > >
> > > Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> > > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > [..]
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 36cee9c30ceb..7fe617122d33 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -848,11 +848,21 @@ static inline void cxl_mem_active_dec(void)
> > >
> > >  int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
> > >
> > > +/*
> >
> > Minor detail that can come in a follow-on patch is that this needs to
> > be:
> >
> > /**
> >
> > ...in order for the kernel-doc system to autoformat it like it does
> > other 'struct' documentation:
> >
> > https://docs.kernel.org/driver-api/cxl/memory-devices.html
> >
> > However, the reason it needs to be a follow-on patch is that this file
> > is not currently included for parsing and needs something like this:
>=20
> We'll need another revision of this patch to address the cxl-test module
> dependencies so how about adding the "/**" in the next revision.
>=20
> I'm suggesting this because cxl_mem.h contains other kernel doc
> comments that are not being picked up because cxl_mem.h is missing
> in Documentation/driver-api/cxl/memory-devices.rst. There also seem
> to be other ommissions when compared with the kernel doc notations
> in drivers/cxl/ :  core/cdat.c, core/hdm.c. I say 'seems' because
> I guess it could be intentional.
>=20
> Can Yao add the kernel doc notation in the next rev of this patch
> and then come back soon and sync memory-devices.rst for all of
> drivers/cxl/ ?
ok, my pleasure.
>=20
> -- Alison
>=20
> >
> > diff --git a/Documentation/driver-api/cxl/memory-devices.rst
> b/Documentation/driver-api/cxl/memory-devices.rst
> > index 5149ecdc53c7..e33ee67ac1a2 100644
> > --- a/Documentation/driver-api/cxl/memory-devices.rst
> > +++ b/Documentation/driver-api/cxl/memory-devices.rst
> > @@ -325,6 +325,9 @@ CXL Memory Device
> >  .. kernel-doc:: drivers/cxl/pci.c
> >     :internal:
> >
> > +.. kernel-doc:: drivers/cxl/cxlmem.h
> > +   :internal:
> > +
> >  .. kernel-doc:: drivers/cxl/mem.c
> >     :doc: cxl mem
> >
