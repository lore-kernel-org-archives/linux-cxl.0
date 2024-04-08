Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071E8120D
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582051; cv=fail; b=VcdISH8/BaVeZ6VgQsZYKbgZiKx5xow0s/pwBoXwN3SwNlsH59OHRiEm3hGsMo/Xre2QQ+rZcYj7lRWzJeH6S9vRiMmSmmvuumhcZiRJhVculSRb4dibH+fwIDiskR0rBN4NJgld2InuTZunzN7mD9ayfmVwFw7FuA+DBFFagTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582051; c=relaxed/simple;
	bh=ZiALudeDWElYQd6Rtg3QwBJdHafZPVpAds3ayuzIhHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lNUyqIeyvAC6twUjinjO/MHFhk3qrPBKi/Guck69mlZbckEh1HTLsjJu1+ri0W/I6wdJQ4EaruHGTF1+oSuYFrE1M/neaphAjQPkoobs0pirku+RX+OGnDlaQjLD5GjA01Wvvy7jABulKDKusbGGV48NC2AvmugKwXBxTs8Mnw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZcOm5YtR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NbX466DZ; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZcOm5YtR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NbX466DZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712582049; x=1744118049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZiALudeDWElYQd6Rtg3QwBJdHafZPVpAds3ayuzIhHo=;
  b=ZcOm5YtRbQ+Eg0RLVEZrgHK6PSAzb8Xy+FGdIJ4gnA2h+EG4IP/3CaHc
   roIv1dARVpNV6hj3pJ6TQe/S471SdokElcvQ0TS4tbuunLI5x3Nwub2jK
   99lwpz2gfzq7Mti/wxcUhntMwC8f5SyfgGDEj0naRxgyiTb56t7hXCL0K
   1b3xxXfA2WPR2HhUId8+eXeDP512paUOT1I510NItBRWiYAJdPgyMFpx7
   MEHjbL+wEQTcg+q7Pd9evbR/MYv7orLIXmwavM9fUbgEG4P5V+P4a4bZj
   lbuEiwGNFuC8EHzpxkdDz9rhIxDoh7KRCdMjP3jrZr09rFYDFSDrwY7eG
   A==;
X-CSE-ConnectionGUID: uENJsW6LTVWnevl8AHzW9g==
X-CSE-MsgGUID: cEjrK0U7ROO7zFfCXI2GDA==
X-IronPort-AV: E=Sophos;i="6.07,186,1708358400"; 
   d="scan'208";a="12986056"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2024 21:14:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg1n3UpMFJsrzs8kboGD6StuLpfypkPmoS2tft8hOrLM6Aw1Z7ukExWnaaPuM7nfX0LAod3uZrt7lRIxPGtyl/w436mN9uxb4vF/mI4N3gXpdUy/1tb4WG3yD3r3FknssyxPkFEU8VII22P5DK0drtyDOKjeGQ34dVFsIxWwbeaHZng7H0cjSaCkGm+fdZgDo6/AVgc9kWVPHq1EKj7S0NYGBBArNgk2nmPBTvBcb4fAkPhr6vTTdYImNhX9sZ1nnDFH+Y6D8d9NO7Yk/hXRyRZWannO8+qu5NqMRRIyRyblMczDAgpngOZ7L7DrriJJe7klCWS8WeLH4+oQdSuVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiALudeDWElYQd6Rtg3QwBJdHafZPVpAds3ayuzIhHo=;
 b=SYjNXT7az4zZqhnft1OOOJRzSiAtsYhsO1MT4pm9i75pUxj6z51cwLcGXAnt6RWOFdPkTo1ko+es30QHzTtqg0DrutyzYoQSY9atk+K7UE9rQRsrqQYJB1o03G9uwXiU1OMv6C18Ct2RW3XNTDfs0T5qXLSLd4+zukSaIT3BO9d+4NIl2zeNF4wzcBiRZGOWaUWdg+Zw5odlWWpEj21KoIl903B1EwWXYd9+ZUMGQ5F9qJbuT+NICDIk4qYvJMwPNbSSYG8SpM4srItf0DianXM3U/Ju5ETnhDmuDdh3GaPimAI16F7AbZi4zWLWu2voSOnZ3r+X9qfjhLboM9+HTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiALudeDWElYQd6Rtg3QwBJdHafZPVpAds3ayuzIhHo=;
 b=NbX466DZT7T1dGAp7F+nBIXJZj5P1J+LvXjQbfRCRnP9XQYxd/WzZYkPwlbgGW4ZZrRexmOBd9OP9BeXhoaXut+pFqQKIISIwO3iVjbdMB4slopi1SPg9vhIDdalWhrrB3P1FH7bxvCi1Y5hkZ2d1wNqXGhOyj78hToj6EboCnU=
Received: from BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 by SA0PR04MB7371.namprd04.prod.outlook.com (2603:10b6:806:e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 13:14:00 +0000
Received: from BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9]) by BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 13:14:00 +0000
From: =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 9/9] accel/tcg: Improve can_do_io management
Thread-Topic: [PATCH 9/9] accel/tcg: Improve can_do_io management
Thread-Index: AQHaiHJn0Y4ATFwuUU6KQUTkuyOZ5bFeXFCA
Date: Mon, 8 Apr 2024 13:13:59 +0000
Message-ID: <7147dfde-5837-4c07-9f12-35c0657c3c4a@wdc.com>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-10-richard.henderson@linaro.org>
In-Reply-To: <20240406223248.502699-10-richard.henderson@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB5431:EE_|SA0PR04MB7371:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Y1weisJanRfiFPi+bPIcvIVQRTKdH4Dr9E/2fvznLskKJGbCBK50QJq7WyBKk0DRNx/QFmHWBl4SJAolGXEShJyEYkdiAdWtRukATDNkT18UtaD+M2GSU2I2RiM4JxGD0/QZby4CjIte3pRcE595Lndxv/TAfRlwD1FRkNYQRkVeqg2dlS2CDSec+AM10gaMFD8tXp12RMg2U8IHPdrc4LOWCYEmBOIWAppVgQZyx1Sf5YJh3gLgQKFQruHCZ5jNz9R0AeqZmFCjtvdyp6auCygKBKEgXKs9+SOQphCgCvBAxQL+xpnsQX21MBZrKsW20ThH85kNlY9grrOFvW2zPvSQ601Ska0t897Rjw95bak+yluM4OrPPI4HRLCNHR0/F4y/N8frgdFQ8FMUkeB2SAnznyXtGu1OfJWq/c/lRLtMq9V4pQrGRCj7DN6ltc/DjPEShw/xPQHZ42nkorWvCitdxi2J9no76zTkMxx9aOzwZROj59KKfiUxtcYccsHR15jF/oG2FRpTfDGMiOkBYbcJeTKpIg/CCOWlXxMV/BlXnPXT52pMzLJHkrcm5tUxneCfjmSkyOQV8OjUC4//C6n+jqAzh8eJVYC08sZIJIkvi415AHrkP2FX0yeSwceA7AY6a3Uc5l2CaoCKD1fYJZRtEjGPGLpRIlVE0zJPU4k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5431.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGhWZ0hNeDlJNzVtUmhCSDdwQW5JWnRyZVYzeGZIV096WHRUM2ZramFHNTJH?=
 =?utf-8?B?TUdVTSs1WUllNml1ZklwbUZYemhJczNIUTc3dnd5RGVsYzd1eVFWVXYxMTM5?=
 =?utf-8?B?UDh4cXJOOFdKYVpYenk2YjBzMzJac2FkTlNzMzg2Y1djcy96cnVZK1djbHor?=
 =?utf-8?B?TkxOZVBSKzFFckNqUWQ4cmlON2xvSWRBSTljT2pEVFJqQmZUeWdGZUhuVjFT?=
 =?utf-8?B?NGhEUEptRzlMUGdLOWxSclNpYmEwRlZ0NFBoeTM3ejltU2hJV2I5OUFJUndz?=
 =?utf-8?B?YWhETlRPK0VCTDJYMHZPc29qVmdXUWUyNG5hallDaWw4VURjVytmbXFFbkFu?=
 =?utf-8?B?WUJJOVc1OUVDaGlnWDdBT0ZlTDJxQW9CMlc1VFBXZmoxRDlxNDlRQW9sM2pl?=
 =?utf-8?B?REUrNmpmK1orR2hibmUwV3Q2eW5TZEtRYlFTR0EwekNiVHgxRmV5VzcweUEw?=
 =?utf-8?B?dmdnRGJaaHJmS0lBU2dhYXNOZEpQa05vS2F0cXJiY0JPbnloWTJLODVoUnVE?=
 =?utf-8?B?dXNpSytTZTlpb3I5UTZmaGpsZVovNEk4c081d0p3NjVlTVVlNitsZEs2bEFF?=
 =?utf-8?B?RTFNaStUemQ1SFl4RDRHOTJKcU5uS3BZMkZxb3hnbk1mQlIyZ1NIYW5OdXNO?=
 =?utf-8?B?V25ER0hiM0RMelBPdEVXWVNnMDljYmp3RFA0NnpWZEl4NjB2R1c4dFBWSzFK?=
 =?utf-8?B?Q2U3WERleUdoVW1GeG1MNGtwSnpzR2pDbFhISzBOTnNaMGRTdkp6L2piajJM?=
 =?utf-8?B?RjNiUjQzNVA2WWR0dG4vZVVCd2dKUUZicGZjTGY5SHRLQllLaTVrTUpFNFRX?=
 =?utf-8?B?ZitzdklBVkI1Y0N0bUw0Z2RPajIzNFIvVE1wWCsvNU9PeDdjNURTVGh3aG9C?=
 =?utf-8?B?TStGcGY2UW1yNlJYZ2RWeFlUdkZBOElkeGxsVGVwbkxMdHJQRDJvczE1ZVY1?=
 =?utf-8?B?VU9WbUtIaTNhMTZrSHltSzFia25nWE8vbHVuU0Z0dmFNQnVtdGhxMWZWRkxH?=
 =?utf-8?B?SHU3UFVIN21mK2RJRWV6QjRpRW5qZGVwNDFCWFZkam1HKzU5RmRWYmZFQ0c3?=
 =?utf-8?B?TE0rL0pNL1hMT1Q3ZWJHOWxRRTFTd0U3NnZNK25JSWUrcUZRa3pwUk1PeXpX?=
 =?utf-8?B?WXVBRjBSeTZqQ2d1VUpvYUY4OGpoMDEwMENVTlRzTWhsWk5TTnpBK1ZPQVp3?=
 =?utf-8?B?N1RtcG1NdUlwYkZIMndxZnVEQmxvTWlLMHdOTVNJcStGMGxwOC91UEc4ZVVI?=
 =?utf-8?B?VXlReWVncVN2L09PaEtmVkZzRDhkbUloSU03SGxNNnUrdXM1UjZneWV4NnRj?=
 =?utf-8?B?ejhzQm55QlZFd0hQYThiMGRtUURPSjhoMDVKU2c0RUZJWWtCOFVDVG1LakFX?=
 =?utf-8?B?bGVBQkc0SmpnYXVXbWpBSkxCL3Z6WE5jS3l5M3J0VW9ndFBjeDZpc3dUK1Vw?=
 =?utf-8?B?L1FxYXpEcmk0OEZScXowYlk0T0VvN3NmbXB5V2FLbHRTYW9mM0ZqeW5Gem1u?=
 =?utf-8?B?UmQ2cXFQckFSLzFLbDlNWWIvdGhUMHFaelQ0NzhQOFl0eERyZWxYN0NDNW5L?=
 =?utf-8?B?VWVOMVVkR2NnWmNQcDNCYnd0RHpsZlhvS1E0ckVsU3FGY3BDQVcrM2hTNzVh?=
 =?utf-8?B?bmthYW82TnliNlZ4dE5lMDI3UXNBeVNQSUFuWjBVK05TQXNZbVFxaEdCaHFH?=
 =?utf-8?B?c2NJZ25IZU9lK0Y5V0Z2U2JWK210amZscVhhU21wRDYyNkZPOFN0ZklDcllE?=
 =?utf-8?B?TmRCTk84anplTTF3VVpnM0JWc2dZVDg0NUovd3Q3YWFjQnRlcUhWTEU5clBW?=
 =?utf-8?B?STNpbm1hejM0Y3RORVVTL1ZZRERvUFdqcFpmSnFRUDd5VmVFNjlzMHdQaTV6?=
 =?utf-8?B?NEtBdDJ3MGZqRHBkaTV4R3V0ZDZlcGtHSWNiZjdObkVLeWZNcDZkbUNxRWE0?=
 =?utf-8?B?N3I2dlRJY25sWnM5SG03VjBpTVg2WlVXdjNzUFIyblhrWER1QUFoWmtIdU1p?=
 =?utf-8?B?OW1RTzBhZElaNmdiSERZQ0l4Mk9xZW5YNmFWMHpSY2FBdytad2FMSUlxbEVR?=
 =?utf-8?B?RWhrTC94bU5BcHpoSFVlMmd3Q0NtTUxLNHlBZGU1YVY5Wi95eUUvTXQvSkRJ?=
 =?utf-8?Q?u4KgHGMcLS7F2qpnvvY3wfFZf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AA7AC14C49DAB42816EA2426D67AA14@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ok5UiE2q5gtTqNdrX1qgpo77lb/atjASPbl1PLXHdSnN5zOgDzD+xHvJ2AyffPvokuZE8yWLmR0WVsr4F9uBhsLYDPHGoTT/dJkePDy2ndhn0uJIJSmMq5/OqwsafU3RPxnwO7LBSgdJGEuYFL8oT+eK3LJF+2zQVR/u8WAvwZxgwSIWNEKSQHJvDpvks9VO+Q2vLT49CNTzSlqTgt6OCc4n8+aVnHulF7ZXV6YI5qGU7SpznnuRGBMo8L5opVOM/BdH0LCryLfQ90hlSTogjIFJSuj0jf4GWlkD1jrstlfhNPaObIWnP3fg7+TFKdQKYoINDqfMXhg57JpxIVvlFV45JemUSjwhN8A7vPR6XXWMbuiz087lXXO+jKTvFVVWph6Ex1i1Tt/yvqVnuHAOoJ5ip5C9m1dwzKijVvlTQ9+9STxqAfExaBvjqxyxn5TW+pdsDBdFmuQzfhdFkKnBKk00AATdaV/Chi0DcTSQ3Pu1yjTZXmpL6yvkitRp0vPAdOiMi7+sO6cjfHDv9XlhwG6pMQuDxI9a2wK2iCU+MoIRPSfG8H1oM+Ns1biED73P6f8XWTkg4cSUsAwmenfOeECPMfenrYZnkdcyJo1CnTC6TfaCA3NxJlYvnZQ1ACdk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5431.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb021ce-7045-49ba-7970-08dc57cdc127
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 13:13:59.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfUxVAeuiuSzN9sHXfu1eDw1CbtUcbSnkA9Cpf0kPSs3MCLoZRyC1z81xoxkN+85TRVvF6icaZraMOFv2QgcsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7371

T24gNC83LzI0IDAwOjMyLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4gV2UgYWxyZWFkeSBh
dHRlbXB0ZWQgdG8gc2V0IGFuZCBjbGVhciBjYW5fZG9faW8gYmVmb3JlIHRoZSBmaXJzdA0KPiBh
bmQgbGFzdCBpbnNucywgYnV0IG9ubHkgdXNlZCB0aGUgaW5pdGlhbCB2YWx1ZSBvZiBtYXhfaW5z
bnMgYW5kDQo+IHRoZSBjYWxsIHRvIHRyYW5zbGF0b3JfaW9fc3RhcnQgdG8gZmluZCB0aG9zZSBp
bnNucy4NCj4gDQo+IE5vdyB0aGF0IHdlIHRyYWNrIGluc25fc3RhcnQgaW4gRGlzYXNDb250ZXh0
QmFzZSwgYW5kIG5vdyB0aGF0DQo+IHdlIGhhdmUgZW1pdF9iZWZvcmVfb3AsIHdlIGNhbiB3YWl0
IHVudGlsIHdlIGhhdmUgZmluaXNoZWQNCj4gdHJhbnNsYXRpb24gdG8gaWRlbnRpZnkgdGhlIHRy
dWUgZmlyc3QgYW5kIGxhc3QgaW5zbnMgYW5kIGVtaXQNCj4gdGhlIHNldHMgb2YgY2FuX2RvX2lv
IGF0IHRoYXQgdGltZS4NCj4gDQo+IFRoaXMgZml4ZXMgY2FzZSBvZiBhIHRyYW5zbGF0aW9uIGJs
b2NrIHdoaWNoIGNyb3NzZWQgYSBwYWdlIGJvdW5kYXJ5LA0KPiBhbmQgZm9yIHdoaWNoIHRoZSBz
ZWNvbmQgcGFnZSB0dXJuZWQgb3V0IHRvIGJlIG1taW8uICBJbiB0aGlzIGNhc2Ugd2UNCj4gdHJ1
bmNhdGUgdGhlIGJsb2NrLCBhbmQgdGhlIHByZXZpb3VzIGxvZ2ljIGZvciBjYW5fZG9faW8gY291
bGQgbGVhdmUNCj4gYSBibG9jayB3aXRoIGEgc2luZ2xlIGluc24gd2l0aCBjYW5fZG9faW8gc2V0
IHRvIGZhbHNlLCB3aGljaCB3b3VsZA0KPiBmYWlsIGFuIGFzc2VydGlvbiBpbiBjcHVfaW9fcmVj
b21waWxlLg0KPiANCj4gUmVwb3J0ZWQtYnk6IErDuHJnZW4gSGFuc2VuIDxKb3JnZW4uSGFuc2Vu
QHdkYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBpbmNsdWRlL2V4ZWMvdHJhbnNsYXRvci5o
IHwgIDEgLQ0KPiAgIGFjY2VsL3RjZy90cmFuc2xhdG9yLmMgICAgfCA0NSArKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2Vy
dGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KDQpUaGFua3MgZm9yIHRoZSBxdWljayBmaXghIEkg
dmVyaWZpZWQgdGhlIHBhdGNoIHNlcmllcyBmaXhlcyB0aGUgaXNzdWUgb24gDQpteSBzZXR1cCwg
YW5kIGFsc28gdmVyaWZpZWQgdGhhdCBubyBpc3N1ZXMgd2VyZSBzZWVuIHdpdGggZnVsbCBNTUlP
IA0KYmFja2luZyBmb3IgdGhlIG90aGVyd2lzZSBzYW1lIHRlc3QgY2FzZS4NCg0KVGVzdGVkLWJ5
OiBKw7hyZ2VuIEhhbnNlbiA8Sm9yZ2VuLkhhbnNlbkB3ZGMuY29tPg==
