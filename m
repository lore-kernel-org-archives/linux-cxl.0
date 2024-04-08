Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312B5228
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544735; cv=fail; b=ggamdDtQPwYNTEIZGCU9S1Or/4kykMdKGBuxb9O1NpZHPqR1AGIFXmUnDL2BaBBcHIExz+MzllgkTqPrsN97UpfbJyptQLQR/7LPh6+w+lqmjEzpVUOk49FUpmifYNIYYSBKVn0IhoZUxITZJorjyYNvAMZJaXjznHEntbqI+4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544735; c=relaxed/simple;
	bh=NqrcGqi1gw2NMmWzzW9o3AbZ4PinJXTJAo/bjvyIlwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oy9TaEDDuNesK0WYu2i4WDzN3uFhWQuZWFBnf1/TpZlMZzQ8baNvkjz3SgTDKBVaMPk2HaYFVB71FevNpXEdz0e0Qi6CwldgTGs+4QgxMv4kC68uKJ1/N8oc63GJWtJLcaPKS/wjgqsSRye7JWj8PaxYuEUwhlXCPm6YjqWzMJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=EWJZWFyI; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="EWJZWFyI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712544732; x=1744080732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NqrcGqi1gw2NMmWzzW9o3AbZ4PinJXTJAo/bjvyIlwk=;
  b=EWJZWFyIVWV6rs+8v1JV5sfVtUNVwEJwQfg0L4I+mbDbwweHTenBBYdg
   2jtH4vx8HEXAwxadx1x4mr+9syYsxX8hzMBF1vDvxZg2xS4ZnsBw92Wuf
   fBuaocnPwgbEibZd0lANt7pgOabOS90sEBjSDHo8WuNTedPKRlzTN3Hs5
   E/Do6vSJI4xAZ/M39EgMDym3EAH61xrLr5rXvo4xk81lxc5iTQiPQxxGh
   MiGFKbPeQvQx0KUmUrEaeDrWqyF/yY1SbWgswEwBFQ1zgsQ//YZ17hXOm
   +jERypGbv2/TGxAP39U6iStye0+mRdfE7LOkdBknsAQbORPJE5lB/+WDF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="27239902"
X-IronPort-AV: E=Sophos;i="6.07,186,1708354800"; 
   d="scan'208";a="27239902"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 11:50:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI80nWgl63RQr4nVmkHO6npqoDoxK3fY2/S8WTG9TWD8QdWm4jXrKntnZgj4WPr5+BzSdXGeeS0XEllxzi8JCfqQZkYP4YgQp1ntgcZevGzfcP3h3OwEvAQ+puYFJRIT1cfeiCT1y9vLsZGOxcdYRq8u/zdXGn5K7/3ohFkQa1bDz6FGheTTt+ycgTAIlXNvrQLufjrPUC7hiDRYkKXwqqZTgmm/PhOmfpW0klaS41k8oCsrGpMTMeb5fSnqDW5tv4bJfwqljwLusLH2obNlZ83vJZOS6szQqPekWTnQ4ZqTIPD/H3qwh5UM6S4JNZNbwnzp2YatZsrOzVoI2IHv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzRrIzMSsUVwL/2OKJrRCDOHR/qlpQEwbL0Nae7ue2E=;
 b=i9dVAhMrY0hIYomJT3hccaGwsE9ynJxbngPliR6XMGwP4NChJ906ZewZhpL7IKgilMk0L+KoCV8lyLI/1Nzd+xeKassRLdTJBm1IKghwPtnDhYa2YGUYwIp1LnqBxUD6xWK/YPJ0IiNEdWEMAaD1zMxIgx91EJTesdv77DhOY4KBA3x5IbcJBkeJXlXUTuFOZVPQMQ9IirELLlbgWFGsM/+IjG97bS+nrZi6gPZ9gsqKWtetgp01QHHxZNAd6hywpu4G1JKX88y13zZytrOki5D0RlgP8l6mLY9bPKuda9kfUPvAOknxiPBSSaNfYawdFxc+h4rnzfQXvesOouIYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB12020.jpnprd01.prod.outlook.com (2603:1096:400:37c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 02:50:55 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 02:50:54 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] cxl/core/region: check interleave capability
Thread-Topic: [PATCH v2 2/2] cxl/core/region: check interleave capability
Thread-Index: AQHahW1OPHyiHYIhl0WJFB/I11b1EbFWm1QAgAcWm9A=
Date: Mon, 8 Apr 2024 02:50:54 +0000
Message-ID:
 <OSZPR01MB645303D2E199F2AFBC38EACE8D002@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
	<20240403021747.17260-3-yaoxt.fnst@fujitsu.com>
 <20240403152744.00003b6b@Huawei.com>
In-Reply-To: <20240403152744.00003b6b@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=d13ef829-f848-4724-bb9c-3fd5b326257d;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-08T02:42:32Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB12020:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EjeGWiAGslA/ISoH3qn02THQBeV7IPhuE5QUTUMxqPbHDicnGcOB6z7RHznYiwqLbXcz9dfUm/CqC5RrtqLc+seymEnF1SfHVjMqKULa6oMaiVN44+sT7Zj7+Raz0NroZqNH2yrmnbN3CVxRos7tU3bUBoAuuIiHOAGNMv8bim7rkBmK+EuLkUOOQYOXwBx7uk1319o5BMOV3xouPmcNJp6yjsv2MYuAObBKtMyGTdyAwm+Coqe1X5UmOOXWPnqvUmdwGgn8nLwovYdc+gWjenRaXH1MjqcRyO91OGk4Xx1UtnCPrDXjXiV+qzPtIhLs60FVDT3tYXKmfqcdV30Bpp+9c9SAyVq+F53LeL2lJOTcJL2D3r3ghVqH/apYa2ZYKhZWgXkXhSRIY88K0rxbcepTsxq3eDOMgZq2q1iIi2HE5GgWRTm/+7fZlnfq0yUbXWJ0QtB3aRPaPOGsKBRg2cgGZdU/1+PryUIbWDsypmBDeiQPLyJuUDPOQ9jCB676iT1zdFqSbmToJxsj9+obTX8uHRUgi6pqDvWeaNaq8UdL6g7ySBVwYqE53vhi/HeCVuTxitzt132TYKhm8AQSWGSiVpDndOd3vB2DEG4rJ0c5xSTSzWAU88lI5USCGMDt8V719ql1+JMycz7bDT29Uu7E7tANaAqZHNbkwTM6krs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?emJZaUFuK2JPV2RCZXFYQTRsZW1YK29jTi9UaUlDWjFGcERRRG42cVg5?=
 =?iso-2022-jp?B?VXgyK1ovOWRxR3IzVHh6aE9aUll4N0VPdkFUMHRCUzl0Lzc5NE1QK3Rl?=
 =?iso-2022-jp?B?MzdORi90cWxzVVNVVU0wYitFS1dJK0h2ZGNNaDdzTDBVSnA0bUtqbGJ4?=
 =?iso-2022-jp?B?SHp1d2J6QUhKekYzNXBTM2NoSEk4eUowakkyMWpGdUNpcnlnMVA1Q3Y0?=
 =?iso-2022-jp?B?dUpMYnk1TUFpOC9BMk1KU2NxeWl4REwrZVI2NVdFWTNSSG91a2Nya3ZM?=
 =?iso-2022-jp?B?Wi9BbDJseEZOU290bkM4SExBOHlXSmlRWnRhVHk4WHJta0xkNGYzYjZL?=
 =?iso-2022-jp?B?SjBqQ1FCZlR0ZjRkbnRuU2g2NU5lb3AwNTJ4RXhKMVJqazcwMGNubVZr?=
 =?iso-2022-jp?B?QzF6dVJKWkVpRWxwVTlpeVp6NTRRU2xpTjZQSXcvL1RWeU1YTTJqaHEz?=
 =?iso-2022-jp?B?MTdtWEsxRW8wOFh0NFdWbVpBdjh6Wnl6VFB3NUVOZDJCQ3czcWZkS3pR?=
 =?iso-2022-jp?B?R0tlREd6UE9Idm9FNHNQWUIzRHhOWUJuOG9WQzd2R2JFeHBDR3lTQWFK?=
 =?iso-2022-jp?B?bVM2U0IyMnRGRy9QNmJ0WE5LRjgvRC9mY2FQdUI5V0ZUdjFVYTgyN1gw?=
 =?iso-2022-jp?B?UVU5NmE2UW9FQjVPYkZ3R1NYNGMxOW55UjFVdGR1eFFIMkJtck9FeTF0?=
 =?iso-2022-jp?B?RU1Ic1NGYlk4aFUxWFc3V3MwWTNLWE9ueGFzTnp4bmVoVFE0bElyZ2Fw?=
 =?iso-2022-jp?B?QnBoOVFOZHcxekVmVmVSbXU4eTZKak5heHFhM0ovbTl0YUxPQWh2TVhw?=
 =?iso-2022-jp?B?WXF2blIzZ1FSc0tNaktaRnBDOTBnVFA0WjBQVzVMUFgrd3JlenNtZVVX?=
 =?iso-2022-jp?B?R05lVXJGUThqSmRpRHJlVEZ6SWxjemZ4QXZmc1hCZXJSWXFZV1drVFJR?=
 =?iso-2022-jp?B?MGlZdFNnN3ErM2NXK2J5M2JUZmhlakZ5elNYbmFQSDF2Nm50NkFHU2pl?=
 =?iso-2022-jp?B?dXhxYno5Ykl5VjA5SFluSTdYRUxFNWV3dDNZQi81MDlnTW42ZWtLVnNh?=
 =?iso-2022-jp?B?MlVZV2lUdy9FQ2JuUG44ekMrSWM4T1NjSXBWNlJvSkw1NXpHR21ianB1?=
 =?iso-2022-jp?B?VEZsNUYxV1pMWWY3OUZPbVFYZU1nTjcvc0hPSUU4K1k3TERUTVhhc09t?=
 =?iso-2022-jp?B?YjFaYWQyTm8yYWo5b2cwWW9UMThJRUNWV1FvTzNhdzdPbTRYSnJwMmlI?=
 =?iso-2022-jp?B?NGtlZ3NqeFVETjhjZkxWSXAwbjFQdjVnczdmK1M3OThPc01KemFRdDFM?=
 =?iso-2022-jp?B?dmNyUjZ2RGlrMzNXU3h5N251MFl2aFJ0aXpNMXhVK1ZZbjRNK0s2bVZp?=
 =?iso-2022-jp?B?OVB0eHQxUytGbUpvUVdMd1ZCdW8rVnB1eDBpMlF5WUhvTWd1OXIxaGl2?=
 =?iso-2022-jp?B?VGJXTkJrK3N4VEw0dEFlaks2RUlCZlRTVHQ0R2FIMC9ETUZMZGxLWUM1?=
 =?iso-2022-jp?B?bmtyeUlvUUVmc1QrTXVWV3J5Y2VYY2RmZy9pNVlIWE5iWWVkNDdyYTZI?=
 =?iso-2022-jp?B?c25WWHRpWUFDTnRLUUcxMzZIUzcrOUpPWHYramg1ZWdTNUpRMEV6WDl1?=
 =?iso-2022-jp?B?RkZrYmFkVjU3M3ZockJyM2VJcFZKNG9DZ2lPZkNCM0M3QVl4b2VkRGdI?=
 =?iso-2022-jp?B?bkNMSHlGZFI2bU5jSGJweHRXZHI0NEpOT3c0dDZRWnZMak9jcTlEeWpE?=
 =?iso-2022-jp?B?aVlwcEdqTVNzUXE1dGNxRnhwd1BObmxJWlNBWEtYNWIrNGhaVmlkNnNW?=
 =?iso-2022-jp?B?QzJ1NnVrTmo0RldveDZRVDdRNXdzU21PeFlFTzdCbENib29COTNOWnNG?=
 =?iso-2022-jp?B?QzlOdEtwNG5HTW4xb3FTUGozOU8xbW1GLzJGZm05THNlcUNWck5tRG9q?=
 =?iso-2022-jp?B?eGkxNDFIaXk4ZmRudS9jaVV2dGlhLzZrU1J2cWRFVUZuQ3pseGJyTVpR?=
 =?iso-2022-jp?B?a0ZkUXpjQzdQUlRGZkwybHJqUEdBOUZoeXVpZUJHMU1VV2FsVDFwNVh6?=
 =?iso-2022-jp?B?azdPZ0x3emduYnhlcVArNnc3aFdtaXhPMGtsT2FZUGg0bGZhUDI0N3Yz?=
 =?iso-2022-jp?B?VjloaW9DZzNpb3d0Nks5RzlpS0FZU1dqVzhidzA2Zmllb2hERENqUXJj?=
 =?iso-2022-jp?B?Z3lUTDNQRkc0UmIzaU5BTlhjNXhXcFVnWkUyUzlrWDVFc1VWNzNMU1gz?=
 =?iso-2022-jp?B?QzZoWmZmUXM3ZE1UQ05ucFhQSlFHZWxuYkdvOCtUcEVGaFVCSjdvYzAz?=
 =?iso-2022-jp?B?dFB5MQ==?=
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
	9jC1DCCDlynL1VD+czie5x2VlDrsNMAHIe1HYCgy+2t/BGXFhgeco6ZUMNJyS1D3nxxoZF8znScE+BA4I+T6/5PrGYehfQo5jDOaXa+tV7n5VAAkrLYWRRI/GcLpiLbs14OFkoxZOJ9NzlXtXhCxH6uAoRURSBSTvmVJKdma9Nj9gLhcMYCTpKnB1PyomHHJLDq90VwUzoPpkhj6ubl85nlWDtRgbsjXbfQ47oL3m2f1CiwW7pXY+qhLypjSf7d6n8fKDGSXamgyCxB8+Cjk9nd69wvJ4uy0cJEAFHGxLc9WGJkc/4UEHf71ZflgIGiatS0hkwYhhSE1hQGUX/Cvpe7YrAHmOUQPK9hGtRYD3lZzWvyUfJT0gUhHFSqTOJRstcTDts3HWQO/NlnViUDUFaZl/s+PenTZVHJNO23G2A0X7A8J9752tdzQK+wb0yaIRzDGtJDPwxPCXB8LERZgLUFrSjVgYVRYJF0vcxvw8Ddb/CpwVVguuMbxADN3w9ea4WtRSY1k/hzCmSX8nhJwAtXxspf4rQbWSw/WW8fDBP1Z7DOccH/9F7fQ/UNSidKwZHRe2B0fuPgMS6mTrd5zua4VTMkWd+2kdesaGOmV7xVzy8irb4yZDrUN0yoIgFsM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9024774-0b29-4abb-5e37-08dc5776b5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 02:50:54.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mv6baDYXSIy7o92jIjplGh4Rg09fFwe9cFrkFBvNr8vi9Geuo0SJibgQfhatHAmXeeYrd7NcZm3D01f95YaHhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12020



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Wednesday, April 3, 2024 10:28 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; dave.jiang@intel.com; alison.schofield@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] cxl/core/region: check interleave capability
>=20
> On Tue,  2 Apr 2024 22:17:47 -0400
> Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:
>=20
> > Since interleave capability is not checked, a target can be attached to
> > region successfully even it does not support the interleave ways or
> > interleave granularity.
> >
> > When accessing the memory, unexpected behavior occurs due to converting
> > HPA to an error DPA:
> > $ numactl -m 2 ls
> > Segmentation fault (core dumped)
> >
> > Link:
> https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fuji=
tsu.c
> om
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
>=20
> I argued on the CXL opensource sync call last night that we'd get an
> hdm commit fail (on working hardware - unlike current qemu) if this check
> wasn't present.  Having thought more I think I was wrong and this is a
> necessary fix because a device that doesn't support one of these ways
> treats the HDM Decoder n Control Register / Interleave Ways (IW) values
> as 'reserved'. Is it guaranteed to not just do that by fixing the higher
> bits to zero?
>=20
> If that's a possible implementation and the decoder was set to 6-way (0x9=
)
> maybe the device would interpret that as 2-way (0x1) and give us the wron=
g
> decode.
>=20
> With that in mind I think this is a fix and needs a Fixes tag.
>=20
>=20
> > ---
> >  drivers/cxl/core/hdm.c    |  4 ++++
> >  drivers/cxl/core/region.c | 41
> +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h         |  2 ++
> >  drivers/cxl/cxlmem.h      |  1 +
> >  4 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 9bb6a256cc6f..1a99b138dbec 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -79,6 +79,10 @@ static void parse_hdm_decoder_caps(struct cxl_hdm
> *cxlhdm)
> >  		cxlhdm->ig_cap_mask |=3D GENMASK(11, 8);
> >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
> >  		cxlhdm->ig_cap_mask |=3D GENMASK(14, 12);
> > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY,
> hdm_cap))
> > +		cxlhdm->iw_cap_mask |=3D BIT(3) | BIT(6) | BIT(12);
> > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> > +		cxlhdm->iw_cap_mask |=3D BIT(16);
>=20
> Whilst it doesn't matter as such (because they are always valid) I think
> we should also st the bits for 1,2,4,8 so that all relevant bits are
> enabled.
good idea!

>=20
> >  }
> >
> >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *in=
fo)
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c186e0a39b9..25d178e14ed1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1786,6 +1786,36 @@ static int cxl_region_sort_targets(struct cxl_re=
gion
> *cxlr)
> >  	return rc;
> >  }
> >
> > +static int
> > +check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> > +{
> > +	struct cxl_port *port =3D to_cxl_port(cxld->dev.parent);
> > +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> > +	u8 eiw;
> > +	u16 eig;
> > +	int rc;
> > +
> > +	rc =3D ways_to_eiw(iw, &eiw);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (eiw > 3 && !(cxlhdm->iw_cap_mask & BIT(iw))) {
> If you have all the bits set then you can avoid using eiw > 3 just
> to check we aren't 1,2,4,8
>=20
> > +		dev_dbg(&cxld->dev, "iw: %d is not supported\n", iw);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	rc =3D granularity_to_eig(ig, &eig);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (!(BIT(eig + 8) & cxlhdm->ig_cap_mask)) {
>=20
> This seems too simple.  Need to look at the calculations in
> IMPLEMENTATON NOTE: CXL Host Bridge and Upstream Switch Port Decode
> Flow.
>=20
> For a decode of more than 2 ways you need more bits to be supported.
this is my misunderstanding of interleave bits, I will change this logical.

>=20
> > +		dev_dbg(&cxld->dev, "ig: %d is not supported\n", ig);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_region_attach(struct cxl_region *cxlr,
> >  			     struct cxl_endpoint_decoder *cxled, int pos)
> >  {
> > @@ -1796,6 +1826,17 @@ static int cxl_region_attach(struct cxl_region *=
cxlr,
> >  	struct cxl_dport *dport;
> >  	int rc =3D -ENXIO;
> >
> > +	rc =3D check_interleave_cap(&cxled->cxld, p->interleave_ways,
> > +				  p->interleave_granularity);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s with region iw: %d, ig: %d is not supported\n",
> > +			dev_name(&cxled->cxld.dev),
> > +			p->interleave_ways,
> > +			p->interleave_granularity);
> > +		return rc;
> > +	}
> > +
> >  	if (cxled->mode !=3D cxlr->mode) {
> >  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> >  			dev_name(&cxled->cxld.dev), cxlr->mode,
> cxled->mode);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 534e25e2f0a4..da8a487ededa 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -45,6 +45,8 @@
> >  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> >  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> >  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> > +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> > +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> >  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> >  #define   CXL_HDM_DECODER_ENABLE BIT(1)
> >  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index b53f7ae0fdd6..979c22955246 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -853,6 +853,7 @@ struct cxl_hdm {
> >  	unsigned int decoder_count;
> >  	unsigned int target_count;
> >  	unsigned int ig_cap_mask;
> > +	unsigned int iw_cap_mask;
> >  	struct cxl_port *port;
> >  };
> >

