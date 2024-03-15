Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35703E474
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515028; cv=fail; b=rVaspk59rRGvT5DEz11h2m1hqajwWS4ZZgTIPrLeEd6VW4NaOb1OKNb+mff0ynU4w3aaYjJLe4lWLFLOz0Cr/yBFbbfcchnYuYXBpC5Yp1Bt69vMu2Fw9swQxE3dDx+bgnjNNpsVFBG1awPY7Yt75rsS6VK0fIzlg4xXS6BeH3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515028; c=relaxed/simple;
	bh=RcuqXgS/zHjfRn2/3/WEz+Ay+bQSfnPr1YptVMgeFJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NOf0zwmv7XI9rpsc46GFnP8ys3s2KY2iB7mtIEASeJivJ2iyWXDkShGmbwh3zjehCHD63pse5ufSfgjCA2jQ9eFTLR7TdNk/g7oCs0hcVdgyMF+p7XByW/xS+IJVWRnCG7C4Gmka5YuAyvRqFr1EuCNOnyLGdwzIFUNluNSgaCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LUe0KLYb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UKH7lLum; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LUe0KLYb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UKH7lLum"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710515025; x=1742051025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RcuqXgS/zHjfRn2/3/WEz+Ay+bQSfnPr1YptVMgeFJ8=;
  b=LUe0KLYbRWbCElqK+Q01fU1qgHHTDK2R6XQiv2mnJLxLfziNXvZfsvjy
   INCtCEbAUmhC7tf3BcDBgMimYrtBHft6wA70C8k/HXN0dyITfPa6koGL5
   loiMaUFgkcr1nOubdLzvM7mij9scoBAHdyPN+kuPIFEFTCPc4MBbcqXNE
   5ciTUVxZXHC7WI2e6jhTkkSL8sRQORWqgVclTgmNI3TzbhyUsXIrXpbHp
   7lgokUv2utExAFS7Vkt030kY9Lu0nYv0sXkqMtmVHo4kdhlBsRtACRKZn
   PjMYbWG9Vqp97ROO2n/YZOMP3VqdFGNKmXvOuy/02iq2FMFUF1WF6l9g0
   g==;
X-CSE-ConnectionGUID: xr1cVh2SRaCFCN4y0qfPkA==
X-CSE-MsgGUID: Iej72GXZQtCHZeZd7ruHKw==
X-IronPort-AV: E=Sophos;i="6.07,128,1708358400"; 
   d="scan'208";a="12319579"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2024 23:03:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b76qcaR6czoBcbzz+1mQBwW2cOkvQCLZdiAEgX2smr90/CYEJi0/PJ/egXjBjA55hpIaDyLh6m2Ya9+6ULmv8VNUc1sB6gqQ78oUV+19NTflKRtEViWYcBG9cLj2xet3xpugr+2suqWpmM4vDiJfQKIAXlYksjjJTfVpjj3l0DrSI8bAO4piVDAqA5NxrrUBfTYj3oHcH904QM/gHqO8ob8bTVlCKpD8CLR9/EPsB4JnhcUd4e5TKUc3tzopzix2a4uhaDnAacyusoBAj5walcKk5oZfj0rJb3rGjpiV5yrJwxHUMZdAnSVe7hbns1ke63sfyCPWn81Dg8/K4nwxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcuqXgS/zHjfRn2/3/WEz+Ay+bQSfnPr1YptVMgeFJ8=;
 b=HXjJ7ags4fsqDlp+0wg8cU64MjDg8lWd0BN+esKWdmEtlDG+Jp4BnBvWt3EXTs5Jf6tkTeYtHIhwrSNsJf/aakxPHzZhvGdgBZzBF7JdVgQQhXCRi8T+/tE+IFTZ695YfdvEBngiXdqtkSXyMElNKzpaqAekJCXi+32IwgUz/jlzV7dn7XlqcMKlx3KKMY80y0/zi52yBexvgtyIwB8b7PbSAoYJL9R0iUFhVTpH5QWjI9OO5c/KmoKYqJemdjDIrm0wIG8xohcwlmuapt9f5nuInHTzBCJKesUbgycgkrmO8YUtcRyvORn4sYYFJG/i5wBq2MjeccDdHp1hEdGnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcuqXgS/zHjfRn2/3/WEz+Ay+bQSfnPr1YptVMgeFJ8=;
 b=UKH7lLumrZIJ3DrKnYjliEyp0upXvvN1qVx2fuquNPIjHXKc+xS1yZUaMsygLsidLuafCzgqRe41VUFFYx6c/F9kc6tqK7y7v1/APYuwsxsnf5V8ico822CJN4MMQiTPDnSWF05yiKoLpTq+pzvnms0CX3oJMuAOZqrFan3PmVQ=
Received: from BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 by BL0PR04MB6562.namprd04.prod.outlook.com (2603:10b6:208:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 15:03:36 +0000
Received: from BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9]) by BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 15:03:36 +0000
From: =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: Another CXL/MMIO tcg tlb corner case
Thread-Topic: Another CXL/MMIO tcg tlb corner case
Thread-Index: AQHadrw6GB5foSHncUuVcVfx9BmDGbE4umcmgAAr/IA=
Date: Fri, 15 Mar 2024 15:03:36 +0000
Message-ID: <9A1AC14C-1555-41EF-91A6-8F6D2C406DE6@wdc.com>
References: <33748BB7-E617-4661-BDE3-5D29780FC9FF@wdc.com>
 <87v85n3cmq.fsf@draig.linaro.org>
In-Reply-To: <87v85n3cmq.fsf@draig.linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB5431:EE_|BL0PR04MB6562:EE_
x-ms-office365-filtering-correlation-id: f2ebad9b-3385-4567-7b29-08dc450116ef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Zn6oQGf2z8Z2hBJbr+U//9RpUdlDtcIka2ubRv4FkgBbWicTLUTmrkWc03QXopet3tRjrj7X5a5QfigeECjP8N8Xa86rrsMjYVAwnapOHJP3dABkdogNYkVYcnzy4wUbdbHW8XFCxIfonk5ko5YPu1t9/JODF8qNUuq32f3VbzNs6oQRkg7ghSEBonlffBT/X4ONqjs/Sb4p6TFffDGxoF0199RGMIAQ4F5uxSAkYnSZR53cotslRgq8bJ93NX69q9td+mTMErHYy52naJubXLKv/ya/XxUL5jtd/uq9oVr4fJuUd5RQPuyVF52tNaKZuIyQ76nBTaGO+Clz4upxmo2EH5sPmCaM32WKj94qE3pvk/8I49u0GeE2fGzUHHeFIPWfEW8WvkBjU24WbFscJs6anbL74YBVH3Xwy20rSAYNtKhsxxHsrbVCJ4+i2q4yhpolb9SqfdMyWscon1oR+FbsTq6+DSMZJL4eHOtJMc9REGhMWv2ypb0Xn+J0wBGcS5FMdZz9hmHK8Km+o3V0iLzuUGfjiMwdgY5b75QBGCNPQuhhZS50cXYv0tv78Tgk+cNdOzw8SKZGXmYD2gzomP7TxCtDJP6IjXk+hwkC1QQaqQUiopx+1VuwEY+wBtTjGLGcnBCFlshaEwj17wdlzdmCV7IUOjzel4Lqn+aJDbc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5431.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnRNQXJKZFcvM0xtQ3ZVRFh1SlRyc29teHcvUjYzMHUxM2ZWWTROZUZkL3ND?=
 =?utf-8?B?Y1JNZ1JacGxMN1poY1lFWGFYSUlBMFV6QjhqZHZQVk5TMVcxczVOSHhxL3RE?=
 =?utf-8?B?VFdNUXU0V0szTVZkTUllVWRoanRSYlJOMlcvVXZVTmJUL2NwRjNqb1ArSWdG?=
 =?utf-8?B?Qm5qMGlSTFRYZjVhdVA3VTlSelFma213Z3Rxd2FaYzBZR0JwSWNDUm84R2ZM?=
 =?utf-8?B?cHNNeUVkTXNHQ3crWmJyYnJvQXFPZkVMcWJxTldYOWhTSDV2blE1aFNoV2dy?=
 =?utf-8?B?MUk2d3NqVjlweDlpSXUxWjBGR2dLQzBtclY2UGxNaE83M1RsUGNvZFMwOGli?=
 =?utf-8?B?L0E1L0hIMEVSUWxydFc0NTFzeXpReGNQc1NScmlScTFMNWp5Vll6UkRoWmFh?=
 =?utf-8?B?MTA3UkZ5QWYyMWpnWkF0VE03eHFsMUhQQzg2Q2lmQnVzQ2pwWEk4blpxelV1?=
 =?utf-8?B?cWJ0Q0FVU0xNZFUzNWx0d0piS1NUdEJnZURaVVNncmlha0EveFBDd1BuWjEv?=
 =?utf-8?B?eVFnUWVVRzlKZDlJdzA2UTdWUnhiTi80elRIQ0xIRXplTXVzakkwYUIzc2hC?=
 =?utf-8?B?UHVROTV4Kys0RUQyL1lRL2hmU0ZoN2c5b3laeVpqOGxIdGo5ckUwdkY4ZWZI?=
 =?utf-8?B?YVpCVWR3WTdhUHdsWlE0S09ROXRCaHZxK1pFcEgyOFhzcXJuUHdRMHZvNnpj?=
 =?utf-8?B?MUplKzh1cEJsUzlBQ0JvRFNqdjdYWGEycnpoWVhTTENleUxVZDJCRGlSc2w1?=
 =?utf-8?B?YXZtWlI2V0tKRzhKOG9GT0VBaGlFQWl1eGVoOEh3SHU3RVFpRGZNdDkzQk00?=
 =?utf-8?B?bzlJNkNDY3VxL24zT09zeVdibzlTd3dWUmlNMExCcnkyOWxsY1o2d1hQdGJo?=
 =?utf-8?B?QTJPV3dqWC94ZjQ0T2NvR1JhVEY0VE84OTNtVkVDays0QXk4bkNMZW1zOXVF?=
 =?utf-8?B?aWsweE42bGc4K09Nc1dJOUw5YUM5REJqWkxzdHdpdS9HMEVWckRJM0NpYUpK?=
 =?utf-8?B?Q2MvNGx4Y1Y1SjRjZkIyRzZmWEdKY3hWSHJGTnIxZEVEcFRnMDdwS1MxRmta?=
 =?utf-8?B?SW5YSXZSQnhtVVVJeEcxc0puYmg2SHI2SjBOc0RpbFZ3emxiWW1DMWliOWpo?=
 =?utf-8?B?SGJNa01hQjgyTTdmZ0NQQlhjTEhRM1lZeU83QnoyZ0dlQXFtaXJNSUZOaWlP?=
 =?utf-8?B?WGVFOGdjRWVMM1UrRHNOUXNtYzBibkpiRUIzbytNajJ1VWhET3lNQ0NSUTIz?=
 =?utf-8?B?NURRRjFFNWhWU1JqN3oxTEtFN3ZqcExPVzZjK3dpZ0NNUXI3NTZ3dDBQOHhG?=
 =?utf-8?B?bURPNFhCd0NGWmQ4TlVqNmJYenpJUENpSDhrUDUwcEU0SCtLT1UwQlVQdHNG?=
 =?utf-8?B?UkxqUTQ1UEJwbDNGb1BieVJTaStYVWV6MWwyVnFiblh1d1RCSUhVTDBoczlJ?=
 =?utf-8?B?N0h4TzlMVEpWeDVCdmNQT1NhcXVGVlFjUko1TUZ1TGJHY3BHNFV6Vy9uZHRv?=
 =?utf-8?B?WG00L1ZrRUVhZ0hRSXZnZENmMVo2dnJxNjU2eWEydjVVZTVqeDF6bzlDcXBC?=
 =?utf-8?B?c2N0dlBkVS9mcjJuVkx2cW9McWdCS2JFUG5uSy9vbENmWU45ekpvRVBObFg1?=
 =?utf-8?B?cCtBWEUrMi9ZYWdMcVFhdEs5MGNTdUdETERzT210VVNaUVVvRzdmTjI3VFFk?=
 =?utf-8?B?UVE3bGE3bW0wWkNOZEp1Vk0vOTdOeWRiRVZOOHUycUxmTzRHbUp2K3JTdll6?=
 =?utf-8?B?akN5UjZQeCtVNEp0TGxDeUFWUmlxOGJjb2o0REYwWlRMTXlqVjVmZFg3VlBX?=
 =?utf-8?B?U3NJMFhpQjNrTzRwWjZNdG1zOXFIQVFXRlF5em5TWVEwVWpQTUN0UjF5N0Rn?=
 =?utf-8?B?dmhnVHZ4SE1sSTAvSzBkU0djSWZYdkN5VitqaXZ5cGltb0cxcWpyN2YzWFdG?=
 =?utf-8?B?M1lzSjF2NXJwMHZTeThGYU12Y3RUMDJOTWFneEs1dE8rS2s4WGZnUmpzZWYz?=
 =?utf-8?B?ZUVXTEd1d2xjaHRkN3BXK0tjdjVLd0dBbmZXbEtGT2FsY1ZvWnFLM1ZyYUlZ?=
 =?utf-8?B?YXFRSzRhbFBzd1IwSjVPMWNxaW9zY1lTUVJGaXZNSCtLb24raDcwaTBoR0RU?=
 =?utf-8?B?dC90d3E1a0hWeFh4ME15SmhQMm9jOHlJTThZVzRNeWxJeHpaMWZkSjhRdk14?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA9BCFB090BF746B87F99153BB7B163@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0vty3yHWq4orkLYdLIbfES65YWbc8Jml3BmLKTUnOZeSffeJ0lEFZ22wYAd/214hwj5hhmefs33gQQkS8q7RShVIKRt1LQcUUKQ/hqdoeiFbnrDxnQjNypxwrnbUBnJyMaCMZDLrE4+eXe2cpnFRc5HypJUrlRXB/xbPBUPC2LmGISBfj/0daAo0ViakfbJO4lwO452RDM1wRjpEwC2924O2fPYVNK4zaAMI0ajsYoS2P/JN9fj4KG/cTJUCExCk4eAMu7Mv7YBVXFxhWJmCaIzCO8Ba7fgkK3zpnmTzEQKOj/Pj49j040nOs8glY9v+CRhDVmcOvQeqW7L/KSPiaxvCc5EjxiIXebrhIkpNteR3ei/vI6pmY1LnpURuw/FLXxvlYOcAMXOUgxQb6aS/KzvqQkR6GULfP7Z54iBf6CaNLEewEEtYh4ZRsNsV0ZXMvwK8E+PSt4elvan6w336I3Hn5eEZI2zAAo3is/8RD+2L3+ITY+UgLexY9Ymj+ZvBu5h5rjg4iDfoPN5wVuBB+ik9I1ZCy4mpX0/wnXLQjK9TGxqFW302hJnT7BRZSwik5VK2AzmxnCAy+rYvrltiw2fWn+hD70YjeN+H/vQV4OOshrO8djk46eFuOzACAD8p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5431.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ebad9b-3385-4567-7b29-08dc450116ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 15:03:36.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NKT2RLf3gw1XLwRQy1Q+jvpMEfv4FXfAezAABSSiodFFRtWc3WXhfa6cCaqerrbooFRuXFEQ34raYaqLFNHxbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6562

DQo+IE9uIDE1IE1hciAyMDI0LCBhdCAxMy4yNSwgQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBs
aW5hcm8ub3JnPiB3cm90ZToNCj4gDQo+IErDuHJnZW4gSGFuc2VuIDxKb3JnZW4uSGFuc2VuQHdk
Yy5jb20+IHdyaXRlczoNCj4gDQo+PiBIaSwNCj4+IA0KPj4gV2hpbGUgZG9pbmcgc29tZSB0ZXN0
aW5nIHVzaW5nIG51bWFjdGwtYmFzZWQgaW50ZXJsZWF2aW5nIG9mIGFwcGxpY2F0aW9uIG1lbW9y
eQ0KPj4gYWNyb3NzIHJlZ3VsYXIgbWVtb3J5IGFuZCBDWEwtYmFzZWQgbWVtb3J5IHVzaW5nIFFF
TVUgd2l0aCB0Y2csIEkgcmFuIGludG8gYW4NCj4+IGlzc3VlIHNpbWlsYXIgdG8gd2hhdCB3ZSBz
YXcgYSB3aGlsZSBiYWNrIC0gbGluayB0byBvbGQgaXNzdWU6DQo+PiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9xZW11LWRldmVsL0NBRkVBY0FfYV9BeVE9RXB6M18rQ2hlQVQ4Q3JzazltT3U4OTR3
Yk5XX0Z5d2Fta1ppd0BtYWlsLmdtYWlsLmNvbS8jdC4NCj4+IA0KPj4gV2hlbiBydW5uaW5nOg0K
Pj4gDQo+PiBudW1hY3RsIC0taW50ZXJsZWF2ZSAwLDEgLi9jYWNoZWJlbmNoIOKApg0KPj4gDQo+
PiBJIGhpdCB0aGUgZm9sbG93aW5nOg0KPj4gDQo+PiBudW1hY3RsIC0taW50ZXJsZWF2ZSAwLDEg
Li9jYWNoZWJlbmNoIC0tanNvbl90ZXN0X2NvbmZpZyAuLi90ZXN0X2NvbmZpZ3MvaGl0X3JhdGlv
L2dyYXBoX2NhY2hlX2ZvbGxvd2VyX2Fzc29jcy9jb25maWcuanNvbg0KPj4gcWVtdTogZmF0YWw6
IGNwdV9pb19yZWNvbXBpbGU6IGNvdWxkIG5vdCBmaW5kIFRCIGZvciBwYz0weDdmZmZjMzkyNmRk
NA0KPiANCj4gT2sgc28gdGhpcyB3aWxsIGJlIGJlY2F1c2Ugd2UgKGJ5IGRlc2lnbikgZG9uJ3Qg
Y2FjaGUgVEIncyBmb3IgTU1JTw0KPiByZWdpb25zLiBCdXQgYXMgeW91IHNheToNCj4+IA0KPj4g
TG9va2luZyBhdCB0aGUgdGIgYmVpbmcgZXhlY3V0ZWQsIGl0IGxvb2tzIGxpa2UgaXQgaXMgYSBz
aW5nbGUgaW5zdHJ1Y3Rpb24gdGIsDQo+PiBzbyB3aXRoIG15IF92ZXJ5XyBsaW1pdGVkIHVuZGVy
c3RhbmRpbmcgb2YgdGNnLCBpdCBzaG91bGRu4oCZdCBiZSBuZWNlc3NhcnkgdG8NCj4+IGRvIHRo
ZSBJTyByZWNvbXBpbGU6DQo+PiANCj4+IChnZGIpIHVwIDEzDQo+PiANCj4+ICMxMyAweDAwMDA1
NTU1NTVjYTEzYWMgaW4gY3B1X2xvb3BfZXhlY190YiAodGJfZXhpdD0weDdmZmZmNDlmZjZkOCwg
bGFzdF90Yj08c3ludGhldGljIHBvaW50ZXI+LCBwYz08b3B0aW1pemVkIG91dD4sIHRiPTB4N2Zm
ZmMzOTI2Y2MwIDxjb2RlX2dlbl9idWZmZXIrNDY0Njc4MDM1PiwgY3B1PTB4NTU1NTU3OGMxOWMw
KSBhdCAuLi9hY2NlbC90Y2cvY3B1LWV4ZWMuYzo5MDQNCj4+IDkwNCAgICAgICAgIHRiID0gY3B1
X3RiX2V4ZWMoY3B1LCB0YiwgdGJfZXhpdCk7DQo+PiAoZ2RiKSBwcmludCAqdGINCj4+ICQxID0g
e3BjID0gMCwgY3NfYmFzZSA9IDAsIGZsYWdzID0gNDE1Mjg1OTM5LCBjZmxhZ3MgPSA0Mjc4MzIx
MTUyLCBzaXplID0gNywgaWNvdW50ID0gMSwgdGMgPSB7cHRyID0gMHg3ZmZmYzM5MjZkODAgPGNv
ZGVfZ2VuX2J1ZmZlcis0NjQ2NzgyMjc+LCBzaXplID0gMTc2fSwgcGFnZV9uZXh0ID0gezAsIDB9
LCBwYWdlX2FkZHIgPSB7MTg0NDY3NDQwNzM3MDk1NTE2MTUsDQo+PiAgICAxODQ0Njc0NDA3Mzcw
OTU1MTYxNX0sIGptcF9sb2NrID0ge3ZhbHVlID0gMH0sIGptcF9yZXNldF9vZmZzZXQgPQ0KPj4g
ezY1NTM1LCA2NTUzNX0sIGptcF9pbnNuX29mZnNldCA9IHs2NTUzNSwgNjU1MzV9LCBqbXBfdGFy
Z2V0X2FkZHIgPQ0KPj4gezAsIDB9LCBqbXBfbGlzdF9oZWFkID0gMTQwNzM2NDc0NTQwOTI4LCBq
bXBfbGlzdF9uZXh0ID0gezAsIDB9LA0KPj4gam1wX2Rlc3QgPSB7MCwgMH19DQo+IA0KPiB3aXRo
IGFuIGljb3VudCBvZiAxIHdlIGJ5IGRlZmluaXRpb24gY2FuIGRvIGlvLiBUaGlzIGlzIGRvbmUg
aW4gdGhlDQo+IHRyYW5zbGF0b3JfbG9vcDoNCj4gDQo+ICAgICAgICAvKg0KPiAgICAgICAgICog
RGlzYXNzZW1ibGUgb25lIGluc3RydWN0aW9uLiAgVGhlIHRyYW5zbGF0ZV9pbnNuIGhvb2sgc2hv
dWxkDQo+ICAgICAgICAgKiB1cGRhdGUgZGItPnBjX25leHQgYW5kIGRiLT5pc19qbXAgdG8gaW5k
aWNhdGUgd2hhdCBzaG91bGQgYmUNCj4gICAgICAgICAqIGRvbmUgbmV4dCAtLSBlaXRoZXIgZXhp
dGluZyB0aGlzIGxvb3Agb3IgbG9jYXRlIHRoZSBzdGFydCBvZg0KPiAgICAgICAgICogdGhlIG5l
eHQgaW5zdHJ1Y3Rpb24uDQo+ICAgICAgICAgKi8NCj4gICAgICAgIGlmIChkYi0+bnVtX2luc25z
ID09IGRiLT5tYXhfaW5zbnMpIHsNCj4gICAgICAgICAgICAvKiBBY2NlcHQgSS9PIG9uIHRoZSBs
YXN0IGluc3RydWN0aW9uLiAgKi8NCj4gICAgICAgICAgICBzZXRfY2FuX2RvX2lvKGRiLCB0cnVl
KTsNCj4gICAgICAgIH0NCj4gDQo+IGFuZCB3ZSBzZWUgbGF0ZXIgb246DQo+IA0KPiAgICB0Yi0+
aWNvdW50ID0gZGItPm51bV9pbnNuczsNCj4gDQo+IFNvIEkgZ3Vlc3Mgd2UgbXVzdCBoYXZlIGdv
bmUgaW50byB0aGUgdHJhbnNsYXRvciBsb29wIGV4cGVjdGluZyB0bw0KPiB0cmFuc2xhdGUgbW9y
ZT8gKHNpZGUgbm90ZSBoYXZpbmcgaW50OF90IHR5cGUgZm9yIHRoZSBzYXZlZCBib29sIHZhbHVl
DQo+IHNlZW1zIHdlaXJkKS4NCj4gDQo+IENvdWxkIHlvdSBjb25maXJtIGJ5IGRvaW5nIHNvbWV0
aGluZyBsaWtlOg0KPiANCj4gIGlmICh0Yi0+aWNvdW50ID09IDEgJiYgIGRiLT5tYXhfaW5zbnMg
PiAxKSB7DQo+ICAgICBmcHJpbnRmKHN0ZGVyciwgImVuZGVkIHVwIGRvaW5nIG9uZSBpbnNuICgl
ZCwgJWQpIiwgZGItPm1heF9pbnNucywgZGItPnNhdmVkX2Nhbl9kb19pbyk7DQo+ICB9DQo+IA0K
PiBhZnRlciB3ZSBzZXQgdGItPmljb3VudD8NCj4gDQoNClRoYW5rcyBmb3IgbG9va2luZyBpbnRv
IHRoaXMgLSBJIHRyaWVkIHdoYXQgeW91IHN1Z2dlc3QgYWJvdmUgYW5kIGl0IGxvb2tzDQpsaWtl
IHRoYXQgaXMgYSBjYXNlIHRoYXQgaGFwcGVucyBxdWl0ZSBvZnRlbiAoSSBzZWUgMTAwcyBvZiB0
aGVzZSBqdXN0IHdoZW4NCmJvb3RpbmcgdGhlIFZNKSwgc28gaXQgaXMgaGFyZCB0byB0ZWxsIHdo
ZXRoZXIgaXQgaXMgcmVsYXRlZCBkaXJlY3RseSB0byB0aGUNCmlzc3VlLCBlLmcuLDoNCg0KZW5k
ZWQgdXAgZG9pbmcgb25lIGluc24gKDUxMiwgMCllbmRlZCB1cCBkb2luZyBvbmUgaW5zbiAoNTEy
LCAwKWVuZGVkIHVwIGRvaW5nIG9uZSBpbnNuICg1MTIsIDApZW5kZWQgdXAgZG9pbmcgb25lIGlu
c24gKDUxMiwgMCllbmRlZCB1cCBkb2luZyBvbmUgaW5zbiAoNTEyLCAwKWVuZGVkIHVwIGRvaW5n
IG9uZSBpbnNuICg1MTIsIDApZW5kZWQgdXAgZG9pbmcgb25lIGluc24gKDUxMiwgMClxZW11OiBm
YXRhbDogY3B1X2lvX3JlY29tcGlsZTogY291bGQgbm90IGZpbmQgVEIgZm9yIHBjPTB4N2Y0MjY0
ZGEzZDQ4DQpSQVg9MDAwMDAwMDAwMDAwMDAwMCBSQlg9MDAwMDdmNjc5OGU2OTA0MCBSQ1g9MDAw
MDAwMDAwMjA1Zjk1OCBSRFg9MDAwMDAwMDAwMjA1ZjhmMA0KUlNJPTAwMDAwMDAwMDAwMDAwMDAg
UkRJPTAwMDA3ZmZkNTY2M2M3MjAgUkJQPTAwMDA3ZmZkNTY2M2M3MjAgUlNQPTAwMDA3ZmZkNTY2
M2M2YzANClI4ID0wMDAwMDAwMDAwMDAwMDFlIFI5ID0wMDAwMDAwMDAyMDVmOTIwIFIxMD0wMDAw
MDAwMDAwMDAwMDA0IFIxMT0wMDAwN2Y2Nzk4NGI1NmIwDQpSMTI9MDAwMDdmZmQ1NjYzYzdlMCBS
MTM9MDAwMDdmNjc5OGU1ZDBiOCBSMTQ9MDAwMDdmNjc5OGU1ZDU4OCBSMTU9MDAwMDdmZmQ1NjYz
YzcwMA0KUklQPTAwMDA3ZjY3OThlMzlmZmQgUkZMPTAwMDAwMjQ2IFstLS1aLVAtXSBDUEw9MyBJ
ST0wIEEyMD0xIFNNTT0wIEhMVD0wDQoNCg0KPj4gSWYgdGhlIGFwcGxpY2F0aW9uIGlzIHJ1biBl
bnRpcmVseSBvdXQgb2YgTU1JTyBtZW1vcnksIHRoaW5ncyB3b3JrIGZpbmUgKHRoZQ0KPj4gcHJl
dmlvdXMgcGF0Y2hlcyByZWxhdGVkIHRvIHRoaXMgaXMgaW4gSm9uYXRoYW5zIGJyYW5jaCksIHNv
IG9uZSB0aG91Z2h0IGlzIHRoYXQNCj4+IGl0IGlzIHJlbGF0ZWQgdG8gaGF2aW5nIHRoZSBjb2Rl
IG9uIGEgbWl4IG9mIHJlZ3VsYXIgYW5kIENYTCBtZW1vcnkuIFNpbmNlIHdlDQo+PiBwcmV2aW91
c2x5IGhhZCBpc3N1ZXMgd2l0aCBjb2RlIGNyb3NzaW5nIHBhZ2UgYm91bmRhcmllcyB3aGVyZSBv
bmx5IHRoZSBzZWNvbmQNCj4+IHBhZ2UgaXMgTU1JTywgSSB0cmllZCBvdXQgdGhlIGZvbGxvd2lu
ZyBjaGFuZ2UgdG8gdGhlIGZpeCBpbnRyb2R1Y2VkIGZvciB0aGF0DQo+PiBpc3N1ZSB0aGlua2lu
ZyB0aGF0IHJldmVydGluZyB0byB0aGUgc2xvdyBwYXRoIGluIHRoZSBtaWRkbGUgb2YgdGhlIHRy
YW5zbGF0aW9uDQo+PiBtaWdodCBub3QgY29ycmVjdGx5IHVwZGF0ZSBjYW5fZG9faW86DQo+PiAN
Cj4+IGRpZmYgLS1naXQgYS9hY2NlbC90Y2cvdHJhbnNsYXRvci5jIGIvYWNjZWwvdGNnL3RyYW5z
bGF0b3IuYw0KPj4gaW5kZXggMzhjMzQwMDlhNS4uZGI2ZWEzNjBlMCAxMDA2NDQNCj4+IC0tLSBh
L2FjY2VsL3RjZy90cmFuc2xhdG9yLmMNCj4+ICsrKyBiL2FjY2VsL3RjZy90cmFuc2xhdG9yLmMN
Cj4+IEBAIC0yNTgsNiArMjU4LDcgQEAgc3RhdGljIHZvaWQgKnRyYW5zbGF0b3JfYWNjZXNzKENQ
VUFyY2hTdGF0ZSAqZW52LCBEaXNhc0NvbnRleHRCYXNlICpkYiwNCj4+ICAgICAgICAgICAgIGlm
ICh1bmxpa2VseShuZXdfcGFnZTEgPT0gLTEpKSB7DQo+PiAgICAgICAgICAgICAgICAgdGJfdW5s
b2NrX3BhZ2VzKHRiKTsNCj4+ICAgICAgICAgICAgICAgICB0Yl9zZXRfcGFnZV9hZGRyMCh0Yiwg
LTEpOw0KPj4gKyAgICAgICAgICAgICAgICBzZXRfY2FuX2RvX2lvKGRiLCB0cnVlKTsNCj4+ICAg
ICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4+ICAgICAgICAgICAgIH0NCj4+IA0KPj4gV2l0
aCB0aGF0IGNoYW5nZSwgdGhpbmdzIHdvcmsgZmluZS4gTm90IHNheWluZyB0aGF0IHRoaXMgaXMg
YSB2YWxpZCBmaXggZm9yIHRoZQ0KPj4gaXNzdWUsIGJ1dCBqdXN0IHRyeWluZyB0byBwcm92aWRl
IGFzIG11Y2ggaW5mb3JtYXRpb24gYXMgcG9zc2libGUgOikNCj4gDQo+IEkgY2FuIHNlZSB3aHkg
dGhpcyB3b3JrcywgbXkgd29ycnkgaXMgaWYgd2UgYWRkcmVzcyBhbGwgdGhlIGVhcmx5IGV4aXQN
Cj4gY2FzZXMgaGVyZS4NCj4gDQo+PiANCj4+IFRoYW5rcywNCj4+IEpvcmdlbg0KPiANCj4gLS0N
Cj4gQWxleCBCZW5uw6llDQo+IFZpcnR1YWxpc2F0aW9uIFRlY2ggTGVhZCBAIExpbmFybw0KDQpU
aGFua3MsDQpKb3JnZW4=
