Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689142064
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343180; cv=fail; b=phDyFf15z/hB+ggJgbodqRRV8N+OD/jp3mT+U5E0cn8MGGso1u5gXYD3SiZIf8beaS8UmFIOeLJfQcXPNxsWaAatv98QhgVWs+KcKg2i1cdriW9JLMMRNHcal6tNjDEoalEbuzMI6+IgtwzkpFaibQx6iCjn9nmyJXU4thpDwJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343180; c=relaxed/simple;
	bh=6HIv4IHfNssqu2h7/7o3osjaNkWzxEjTH5GmCY99dQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUFJI8Cd8QmKMriiwf1ln8PhLWg9vv/vRLViCDRjQs7S8Zq0j4HTIyut8GE9uirqb2rt4br40CuNFTQ1boJDQUx5wEAk2QzIWmM3YaZFKspM4BXnVpwfQpw9d/oMSeMhLn2IAM3Ke/dR8fN9nb/eWE9lqEEy4qr1Mo6Dzk7Rf8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=q0DnYk11; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="q0DnYk11"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1718343177; x=1749879177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6HIv4IHfNssqu2h7/7o3osjaNkWzxEjTH5GmCY99dQo=;
  b=q0DnYk11len7kMW2Zn8hd07mMOM7/pg/K7TZGxcX49re1ZgnVhn66SGe
   Y4K+m0OhHpu+fATkLX98cFEmBZWB1/NtU9bEzVp+kuWZuJWyalRxIFBy2
   S/n9kgnUAlqONYQQ+UB2Y+nyIB2QT/L8hbv8Gfm+QYmAEV5ms2ASNwacO
   M0rQ5Dewq3hAL8pOiMe9Atm4u2Cn7d5TPaL/jb8H8NuAoQnGna5Kxs5Hh
   YvL/7l/zaruDFekc35tXxiMrNNIVUTxdxz3UDy+TtfwK7tcD2QqvnHOX8
   L6QhIN9sLURTPwl+RZHjNlBDrBMHz/WDKDZU0tGoQmGLsp1rsOjlKr0RN
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="121897499"
X-IronPort-AV: E=Sophos;i="6.08,236,1712588400"; 
   d="scan'208";a="121897499"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 14:32:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm8mnkOqoXovauMp/ys1Wb3AbiNb2EBVOxb5vplL4l3b31zGxHtk2FTUlB+2UQB0V97mnjYCvefRELH+oxMdxqgLwVIqCf0xf1XhDQMA172CBiMiXOq35dAz4dGb09d5pBtEpNYowt553izfX3qc0ivdRwpZlrfhtjv+bl4Goh+HR94hS5kKn5ZsrlhMJxVzLZMsYgbUAD5MOyTsIv24qk4kK93R3UM8rqD3psLWA8pvX1Eh2wBsQoe+jH4D+HKZMzRmOOcXjsBRKRR6x19UBW95W77fAWjV6UOkWRhZHbq2IogkHV8EdGubW2oZqloVMOQsW5atIa8NiiIZejkkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeNel+MYlMJjhtt67ldawpkQKzI1W3pFV2P8yBXALio=;
 b=SShFigCIzfbUzpT0TqDy3vMSj9kKm3sHY5h88TFYLjnzmysXDx+/+kVzik/inkABzZIXbqZfwrjwVjQLF5MlfBanYj7UGPh3b8ZlkAdP057DW/s+Sgp+MsBr752bf/UCTqMmoKPdIlHVFbyEQ5XAbM4IgMhYlrjwiRU4l/lOQIfLg88ESxWxjv8sr8GzCm6fkxFWOY7q8CyTaKi3WvYSw5V5huogbwneLjY0xodBt5QSAaEYZ8qxS0GRjPedZLZeLrY8QtdS/mPdUpT08n1QmaPjYWysimlBC20oNkY2Fh3Q6qZnhCbqNShKLqJmtMgZ2bo7nlaqhz57L4ETcRfS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OSZPR01MB6325.jpnprd01.prod.outlook.com (2603:1096:604:ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 05:32:41 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:32:41 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v8 2/3] cxl: documentation: add cxlmem.h to cxl driver-api
Thread-Topic: [PATCH v8 2/3] cxl: documentation: add cxlmem.h to cxl
 driver-api
Thread-Index: AQHavgn6LyT9Zf9zmEqCfzoNmeNQwLHGr86AgAALW7A=
Date: Fri, 14 Jun 2024 05:32:40 +0000
Message-ID:
 <OSZPR01MB6453FDD43A911DD657BBA6748DC22@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240614032133.45365-1-yaoxt.fnst@fujitsu.com>
 <20240614032133.45365-3-yaoxt.fnst@fujitsu.com>
 <ZmvLWWR6WnClsQH2@aschofie-mobl2>
In-Reply-To: <ZmvLWWR6WnClsQH2@aschofie-mobl2>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=8b77d203-9cf1-42df-ba6f-5d98d71457f9;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-14T05:32:30Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OSZPR01MB6325:EE_
x-ms-office365-filtering-correlation-id: 50289f0f-f38c-49cd-0eab-08dc8c3368cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230035|1800799019|366011|376009|38070700013|1580799022;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?K0VnNzhyTXZxY3Iwby9NdG1OMFlDZm55RE9hK1M5Z0Zpby96SjB6OTUx?=
 =?iso-2022-jp?B?OWtRQlBldjRsVWpFZ0diSEwzS3FMdGw4Tk42Ym5yU1lTSVhURGFCU2RQ?=
 =?iso-2022-jp?B?RGhYV2xwaUJCRkRnamUyNDRuN2tkZFpHS1Q1cEUwWi9UUjJBK0hUNnJC?=
 =?iso-2022-jp?B?VmlqeDNVN29WdWVlNGp6WVIvcFNZVGNVbHBMWldEd3BEaHE1TWQ1RHFX?=
 =?iso-2022-jp?B?Zjg2K2M3OHUzNytkZEhWSW1KbEJwNWcxSlU0U3ZmNGhqMEdibmJJcGps?=
 =?iso-2022-jp?B?STlzYlpQQW9WeTVKNXY4VlI2TmtNYTNWdXVpQlg5ZVl0VW52TnV5THFh?=
 =?iso-2022-jp?B?cjB5TDdHeUF5VFhPVnZMMG1YSzNROTBaR1kramRZejlQZDhJWE5iV3BK?=
 =?iso-2022-jp?B?cEZiVm5SRnY3WVQrN2lvUVBUcXRtYzNzOS9zT2R4Vi9sUUhFeXZ4VllC?=
 =?iso-2022-jp?B?NStLN0hxSFhpTzBsL25vUHpiaHNBWS8rNWhYbkptU04zQWFJWXVpSFdE?=
 =?iso-2022-jp?B?cVB5T0xYZTRaMWtVUzV3OEw5dmp6dEp1K0JrNm1MZzBoaXFUbTVyZldw?=
 =?iso-2022-jp?B?K1R6bVN0cUtiYzcrRGFpS3BTYTRkaUt2TkJLbENXYkJxWWJQa0F3bjBq?=
 =?iso-2022-jp?B?YkEvcld3ZEpESGtMc2trTXdVREJIcVRiY0p0L1htZmJIRERkQlVSRTE2?=
 =?iso-2022-jp?B?Rk1TOHVjVm0xV24yNXIzOU05bnpCV3VaenljSGdJa05sTWg5b2tLMTNN?=
 =?iso-2022-jp?B?UUVqdHVmQy9scXJMbHFvOTFja0psMjRqVTkyQTRob2tqWk8xMjR3QkRT?=
 =?iso-2022-jp?B?OFlacGl1bFNMM2E4UmJPUHN2WTZHNFkvdU82R0V2VkdHa0hnNDAwN2I3?=
 =?iso-2022-jp?B?VTF6V3FKNUk3amdCOWUybTV6SG1SVXlSOWhRWWJaL2REaUU1bkU1bHJI?=
 =?iso-2022-jp?B?c1hmdm1DOFgzMjI4VldZZUVIdHdnNVJIZlo0OXRNNVJ1a25HTk0yYjIx?=
 =?iso-2022-jp?B?ZFZlWHF3K3RuM29MMHpucXM2WXlRU2ZNMWQyOG9ldFlRYkdXbUJyNWdZ?=
 =?iso-2022-jp?B?Z3FHOENsZDkrdEVRTzYwV1RxTm5IZk9BZ0xabUd3ZHhnRlNOZTNGaFA2?=
 =?iso-2022-jp?B?OW41aG9mbnV0WjNsOXBzQ01PMGR3bnU0NWJhUXpHV2IrQ1VjR0ZqY0hl?=
 =?iso-2022-jp?B?ZC9aOWFidGowRDNCQ2loUWtlSWo4MG1tVE5WeVV2bkUwRUZqTUNiMzl0?=
 =?iso-2022-jp?B?MWp2dnJ5S0hvQ2l1TDdkSXRyU3RQWWdqYWZZSC9mVXRYOXFITGt1VnU0?=
 =?iso-2022-jp?B?RXBPbUk2ajZWMUJNcUEyZGlYRy9HekZzUDBEK3I2NHNQZE90cVFVRTBu?=
 =?iso-2022-jp?B?WWIxeTlxM29heTZVYmZDUEtrQTRzNzREejFybkkwcGk3UzhoV3FDQ3Nv?=
 =?iso-2022-jp?B?dUFZV1BYdGVkVnBGQy9RdUJxZkpjYzJKcS8wQXovK002WlV0VmlvZTNk?=
 =?iso-2022-jp?B?N01PQVUvcTJWTnlOMTlMWjBJbC9qUjBKQ2x1Z3FRL2JzeUZkaXdGcEVl?=
 =?iso-2022-jp?B?OXdmeWJBc0dvbmNMRkpuYXMzTmk4UkszeUhtR0kybXlPSys0UHlGb3hx?=
 =?iso-2022-jp?B?ME1DMlJ2cUVvMXpEdnFwZUh5ZmI0bC9VNjlydmRDY0ZPL3pSbzRYUkhp?=
 =?iso-2022-jp?B?dnVGejRsclFVeTBMMXpTdzVlMWFmM0lUUit5dHJFVXdORWJXd1lyeWVz?=
 =?iso-2022-jp?B?YVJaelRzVnpIa29HVmFZRW5RK2VWWkZPNFUvUnpiaXBGSStMYTFuSnAz?=
 =?iso-2022-jp?B?V2NQakhhWFZmaXl3dEhidnVoL3F6UVc3ZXd6dnNlMXNuN3JvWm1ZWXYx?=
 =?iso-2022-jp?B?WkxMQ1lENHI1QTh6cmVyR3BkYjhzSC9QQmRlK2wrSXp1cTVhM2tQaE5I?=
 =?iso-2022-jp?B?dU1ZVDlvMEE3WDRWQytDQi96QUprd2JtbnM4MTY3RUMza1J0QjdqQk1l?=
 =?iso-2022-jp?B?eGJzQm1sZUhESkV2blJqdXNPNGdleXVGRm9rWGVIdUNRdytpYUsxVm4x?=
 =?iso-2022-jp?B?QXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013)(1580799022);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?US81MVBDcnVqUUZQRkdaYi9BV1VMak1XRm5aVGdxeXI2azdVdko3dmJG?=
 =?iso-2022-jp?B?aHlQUlNGYzRYdWhRYVVqZHJ6R0M5RzBjUW9Ibzl5bDdLUy9WUU53ZmdE?=
 =?iso-2022-jp?B?aWlpakUyNndiUDY0TUh3NHlWYnZJZUxHaHpSbk5xWGNJWmw0MDdmQ3hL?=
 =?iso-2022-jp?B?N21wZFI0SUk5NEVNTFpWdkJpcVlSVVg0SXlUTEJhandNOWwxb2dHMm5R?=
 =?iso-2022-jp?B?MzN1SnNGU1I1VSsxR3lXZGErc0RHdzBnYkZtU3RUdUVtQ1JUM1VzbkRY?=
 =?iso-2022-jp?B?aEpYQ0ErWXdSK1RRbnVGRkQvRzFNdHk3MGpaQUtRL2FMcDBtTTRYVEZI?=
 =?iso-2022-jp?B?UGUvL1VBcXJuQlhZYnlBMTYzY2Q3amh3YlczNGpMdFVNcjdGeUFZUU12?=
 =?iso-2022-jp?B?NkRQRm53NHR4bzVPYThPTVpHQUdFazlhbjY0SHE5djlweXpvZ1NpSk1r?=
 =?iso-2022-jp?B?VGViMXc4cVZWNmwrTFJZS1k5elV5em0vQkl4NW1nSzZ1MjYzaHFHblBw?=
 =?iso-2022-jp?B?US9oZEFHaCtHbGZ3Z2pFOTBnU0dQZlNGZkx4YU1Iei83NVdHekUwemll?=
 =?iso-2022-jp?B?MFRPajVzTVRCak5WeTh4dVRFY0wvSlZYMCtJcXY1SmFja1FteUtyek8v?=
 =?iso-2022-jp?B?djIvUlovOWJoWExpemQ0b0hNUlFjamhsd2xSczlESC8vSDRzOSs4dUI1?=
 =?iso-2022-jp?B?ZlBRTnBaVG15M2lhL1R3UFNzcnZzcS90M1Fod25LWlFqcjJTQVc1dzl6?=
 =?iso-2022-jp?B?Mys3YXFBODI4a0hKcHRhM0NteXIzM3U0NFJXWVZsUUkyRk5qbjhtcU1S?=
 =?iso-2022-jp?B?dUR3M2dFeG5rMU5ybnNBeWluM242WG5NbXdvd1FVbUs1WnRYL2hlWUlP?=
 =?iso-2022-jp?B?R2xPdkwxYTJWQkJDLzhhQWxKUEdqWmVuWTd2aktheXhwd0l5YmtHUlFr?=
 =?iso-2022-jp?B?VVpaRzhzSHFIN1d1YVhpZW9HZThRdUFXSlVRZEtTWUU1QjVOSTMzNjVx?=
 =?iso-2022-jp?B?M2R6Wk9wbUMvQVVLd0FkNTQ2YVVMZG1QL0p0eVlLSS9mLzhEdFRkS2Z0?=
 =?iso-2022-jp?B?QkVHZEFGS2FkVldRem5Cd2dKWnZlbk9EUzd3MDNGNVlyaGJybzlJeUVz?=
 =?iso-2022-jp?B?WU9Tc2ZTd3YrWU5NcWl0NXkyYm9FS25uc2EydEhDcU9kS0g3d0F5Nzg1?=
 =?iso-2022-jp?B?NGJqb1JhbEdlMnE3WmRyOWhVTWxqMTIyUHdnT1g4SStKa2cvWWFXb1BI?=
 =?iso-2022-jp?B?Z1B6cmR2YllaUjNFWi9vZ1o4akNxN0xZbllNdlkxVkdlRCtCcG1HUERU?=
 =?iso-2022-jp?B?UDg5SU5TUzhwVTFGSU85dFVIdjdDQ2ZocFh5UFZ6a2ViZEdHVUIrdWhq?=
 =?iso-2022-jp?B?bm5FdWc3MU5hclA0QmltODZWdVE2bm1YMXRwR0lrcVNlRlVRQktaYlJa?=
 =?iso-2022-jp?B?aWZueC9GTlNkVXEzM05MSWQ3WE5GK3pGaktnSTVXQzdxdzRiU3F3MnlB?=
 =?iso-2022-jp?B?VEpDMGhsR1ovbmswcTBpMG1uWGMzNENROUx1Qlg0WWRVYnZaRjFWM1dX?=
 =?iso-2022-jp?B?aDZmWFo4VHZJcGIyd2g0U3QzMmlMNmhtK1g2TndkdUF0YUlUZVE5Y1ZD?=
 =?iso-2022-jp?B?ZjRjb0I4VForQm1EMjE5blVhQkRwZitiaTQyd0JWVzAzcWhKb3E4dnE4?=
 =?iso-2022-jp?B?SktocVhRRFJIWFFOZElLdGtRLzQ4UGx1OG5FTjh0L0t2VTVUWVJqNU0r?=
 =?iso-2022-jp?B?NmZBTStFem5mTTFpZ1hFd1VZNjR4YlpKRkdxMjBya2I0c3ZDbTlDQ2lF?=
 =?iso-2022-jp?B?a1RWNjAyNVZsQ05KQlc4K0VuTGlnZEJLSlY1MHVpRDRuZzBPZEswelFp?=
 =?iso-2022-jp?B?UXdlbWNHTktoRzdGVE9kT1pQSE5HMmRDMFFNMWQ4TUxkUndMNXgyUlFn?=
 =?iso-2022-jp?B?d0o0UTZmT2wrOEEwTmkvVTdFNFdtaDR1VDFpWUR4MDJPN3VGOFc4OWJI?=
 =?iso-2022-jp?B?K1N0ODZLVTEwaEhNeXVGOTM4T01OYlZFYlJtMGVQWm9nTmozUnNYeTNl?=
 =?iso-2022-jp?B?TjNVNHdXc3pNV2VwMTY5TjVxN2pKaHdtamRsUDY2akxkMlBBWTA3TW0z?=
 =?iso-2022-jp?B?WkwyY20vQmJZL0lrQlhmMDI2T0xjWUNURDdwcE1YSFlmYlFUeWh4SjA1?=
 =?iso-2022-jp?B?S1VjTzJkMmNnRFB4TXpERlAxWTd5akMvQzR0V0dVdWtva1liWTlGY2hj?=
 =?iso-2022-jp?B?U09tT2F3RjdWN2xIV1FQUWkxTFpIMXU1NFNvcFlBamZVbkptQk54RjhT?=
 =?iso-2022-jp?B?OVlyaQ==?=
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
	2pWXYbOpbjN602Bvpxk75VwKXkclDzGpUT34K3WxKRu4QelNWuBggTy3EL/KHpI1D5LLt09Wk9FhST41qgH0QLMCtj2uIcxV00mMjOsaP0jWxuOyNSnq8guyK+H+plHCp2rPlM+ZvGnotYWxOFXaI9LshlfTb08zu4XRN1vd41tcuC9c/V2zVBdzcF9QXeUXLzHnhnli39vJa0OKkgZ6k5x+cSSjqY0ORM9fmnWO2pTKjfr9IAl9pIBR/S+NxWlzdUbLb34KVDCmpt7X3nJVsvmxx0bYcm0O3HsWqIfwQR3ogvm50K8+iDiSQdzAD8GkPIcxW0scZJvJs142L0Pl33g36hxUrM7aNmmkYq8d4EoDzedF0aHJcuYiba+gFaVtz4QOhVNjzkhJ9iFWqedXk89xS8aAKoDKpkYyz2VP9q2rv6PLIVjO4i8Ck21rNzS1NGqkR006PlUjD0YeUAvflv8BynX/sGWRqqBaHZD1eQB85GomtJ1N62cLoK6VXMi6FeERoVMODarFQ4/qbt7pYTQufXBEVRZuXe340Ip4ZVmFqInYmHNjSxiRmfLS5V+ub1D3UJEksv9v8f+B0pZ78GmUYH4HJG+V8AEVbxR1mgr6AJYnNt6Qe49OZhftitEQ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50289f0f-f38c-49cd-0eab-08dc8c3368cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:32:40.8979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTvSncyw0r58yW9h7AB2ebTOWwsFxSsXj0ZJCIToJxHvANjJgecBihf9jGildOWMfE9sIPK+1gjN+TP5/NnwyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6325



> -----Original Message-----
> From: Alison Schofield <alison.schofield@intel.com>
> Sent: Friday, June 14, 2024 12:47 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; jonathan.cameron@huawei.com; dave.jiang@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v8 2/3] cxl: documentation: add cxlmem.h to cxl drive=
r-api
>=20
> On Thu, Jun 13, 2024 at 11:21:32PM -0400, Yao Xingtao wrote:
> > Since the interleave capability check is supported, and this feature
> > depends on cxl_hdm, add cxl_hdm structure to the cxl driver API
> > documentation.
> >
>=20
> Hi Yao,
>=20
> I was hoping you were going to add the other missing files here,
> core/cdat.c and core/hdm.c
>=20
> If you don't we can pick them up another time.
sorry, I misunderstood what your request.
I thought that these file will be added in another patch other than in this=
 patch set.

will add in next revision.

>=20
> However, the new struct in Patch 1 doesn't have the kernel doc
> notation so this isn't picking up the cxl_hdm structure for the
> docs.
yes, that's a problem.

>=20
> -- Alison
>=20
>=20
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >  Documentation/driver-api/cxl/memory-devices.rst | 3 +++
> >  1 file changed, 3 insertions(+)
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
> > --
> > 2.37.3
> >

