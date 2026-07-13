Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AE43D4FB;
	Mon, 13 Jul 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961066; cv=fail; b=XJFwx63FdacUrZlbt3tNWWCvpj4sKFG/qWVDQIlfEaY5VNJgfk8obaEE6fHDNpdiqaC3hAkL5fZ6YwbsE5Of2z/Tq3txMUyqumBT+VlAtNifFceUX4CdwMD/JoOsd2sWt3vt72rpW52R+ucfbbJjsl+VbH+EkfemKxf2DMlaL70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961066; c=relaxed/simple;
	bh=0FB6vlTwuHUBMl+eY/Ta4/i9YTUTJuWgRc2YZUqz3No=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+F+PORTRtKRy7JFCuSdSRqyOqL/BCgfeWvA/Kb47+sDum/nZZPTRf4ydBy4Y84bs8uPNf5paZPP/Ei/uGDWXmpz1lDAjkAqwoeIKf+yDo/11sPeeFYy7knJW7iRuqZSTfOCZs2oCc858emuFI7Tj3O48kltiwLaxZreTWVvN1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mo7FXJs2; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mo7FXJs2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twSjkjA2yZUNfRkF93h7jLUx5KN6uKK3orY4marDoIK9a7BscU7yYbDq3KEx3Z1zAuaALu9u3uBxUfjiubbJoQgbNZC8OOiPIKAtFFbRrOXvTe0EleK0p/Wof8UW+nYVPN/uDubyjubd8xV27lG/vQyYAY1Z+Y8ZEzNvuaYZjkivJYTE6C39RVCg3qy7uEMrLmXMjYiK1D4ftu1Hjmf59KxmXcopanyBpC8B2vxyUmBdrnLA68GgA2MRTbssxvwjxqLlwPeNLgKmP3dWzHDpXNpmeXHIQD2nCMTJ+F49YIGbD92Ea3Ap21718Kz7InmYQEmznYbc7YH/rWh6nhZLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FB6vlTwuHUBMl+eY/Ta4/i9YTUTJuWgRc2YZUqz3No=;
 b=nwl/kdJgP6liUeI6YtPdghL1/WNDy1pAQHfco7HrnFLWSEKrXE9ZicnitMTKhiV/BYAzYXfH1hBnNLexbdHv6uPpLY7jf4tCCCS4Z9ax1HttBxL64yJI+uoRjs1MpW+maUaanKgtg4KthJceGYEuio3RJFQF6UaVRv+qKlnmnGNNL2zGfKelTGRWYmmBg/n/30h7oMkb3hHpgW5XEdjr9wpLKxPmZSlZ8gLFGWeE50v+vpCXxbzOJyxiCaNzdCo7k/WJqfeIJPKucNH8jIHU16LA/7rSJ5TtMl9whYTCuL3LukX2VgDht+8Fz8ICE4eAcds0GPZrLSGO47cqtManYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FB6vlTwuHUBMl+eY/Ta4/i9YTUTJuWgRc2YZUqz3No=;
 b=Mo7FXJs2QnvUTCd4KjqtVy4WVv1FZbnly2bwjvOsiIVQSQk/R1WRp6gAs+kJ3fL8uiB/WcfZ0X1uyS3w2nFuQfqDXMuIlC2QeEfCSsU+ogSn8HyhC7l9mmwWFMZzgCIww1X8CvMunGzqyBqCKfW0nCzAW9BIuzlD6gTdUGFe50Bk8TvpG8h+sJMyH5H7wAVGtLyO9yaeNtoRbRg9SKg5AtsP3G9APQOOw00HXc3gxNr+pB+fmmEaGDU637yEYo7oLZp57hiaCBgJRXscXzViC7sMTVNXYnoAArpgBN+q2Ar8hf7g8EZkuYQUUKW4Ip72YfaYYW/lOL7P2iq58+oH8w==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:44:19 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:44:19 +0000
From: Manish Honap <mhonap@nvidia.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>, "alex@shazbot.org"
	<alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jic23@kernel.org"
	<jic23@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>, Ankit
 Agrawal <ankita@nvidia.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dmatlack@google.com" <dmatlack@google.com>, "gourry@gourry.net"
	<gourry@gourry.net>, "ira.weiny@intel.com" <ira.weiny@intel.com>
CC: Neo Jia <cjia@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v3 01/11] cxl: Add cxl_get_hdm_info() helper for HDM
 decoder metadata
Thread-Topic: [PATCH v3 01/11] cxl: Add cxl_get_hdm_info() helper for HDM
 decoder metadata
Thread-Index: AQHdBMNp69uzaAomg02akGPO2cFsgbZmBZWAgAWoSyA=
Date: Mon, 13 Jul 2026 16:44:19 +0000
Message-ID:
 <IA1PR12MB9030EB34BCCB0AA20212B010BDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
 <20260625165407.1769572-2-mhonap@nvidia.com>
 <6a50444528cae_3c589810050@djbw-dev.notmuch>
In-Reply-To: <6a50444528cae_3c589810050@djbw-dev.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|SJ5PPF183341E5B:EE_
x-ms-office365-filtering-correlation-id: 5940ccaf-be92-49bd-068d-08dee0fdfc3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|4143699003|3023799007|38070700021|11063799006|56012099006|921020|6133799003;
x-microsoft-antispam-message-info:
 Kp9RQPymQimymrKYndPCVkBs2LF+5o+CQEFaVAnbfvQfQq4SnwjGd4XKF7Gc/e7kt1D//LuLJwWJD5SXzNWJmpOp22h+ugHhwbyO1TWtIGSUU5jnjq94YgHHd6R+MS3y5uG0w5DLM03qG98x4ppES/iAreU36Vi8KcPAt2496/7Rf0vzyzFh7wS+93eD8tIt/KJ4M42wKfklUZx/Fha0RqNjyWzdx4zncy7/d4A66BTqRtlQnKGrkgHmOSDpzwyJG0343eJCpfx/YjSeL69bQFXHR1+hx8OW0U900YQuoNlZ5SCvksgnShhU+ywp3o9ECCl+rCGgOrFfytxRKrwv1wWVe9d8hDBcv8RPuPJKcpMyn1RZjuPM7R6t21E3HQ5LY0PRY5TsgtTP5pY+GY3PU80vcfZPQdqihHRaBxokMmdHQPT83eBOCsl3tgT4XdkdA+PZKO5dspmAVXlD36U0q9p2dwjb8TMmiX4J1fuqv2Tn1QqUZUJgEc5+2l8fXAY8Z1uftwX+Qb3766GJOcbYnqMjlPQ+Mrm7QBx7dzt8CdxjruZC+Q4kp9Wx3qxlDBMk1S/cCh/VLCPkeV4XJcKU9xbfvld8y1wYm5OJKxFHxwAcof+436l+cn6tbHALRUtxLKyGiQh19yn0HOBbjd2sYVNXnaCBe7/PgT+af7YGIIf18qM+AYti8Bv7c/Wzw+PerJUneROP/gBMA1sUAdy1fS3iCjNyoItHS52AeRsy2LM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(3023799007)(38070700021)(11063799006)(56012099006)(921020)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVRnRWN1cjN1Mm1CRlU5N08vL2dVVDErcVYzTWdnalRDbDlWeTBQU25MSUlv?=
 =?utf-8?B?U0lGUWhXSnBHWHUxZ2NqK3dQMjJOYk01emEzNm50dGpEZ1hQS0x2azZ4bnBW?=
 =?utf-8?B?VWs2ZkhwOGk3dFR2YldsbFZkMkFiVGRwS2FhWTRxSnpnN2ZuY2RvNHFpR1lT?=
 =?utf-8?B?aUdTTjB5K3VLMHRPaHZMT0JFQnRJMTliY1BzUFkvdXNRalowTWlzMEl6ZUc5?=
 =?utf-8?B?UTgrOHkwMUUxVzZycXJSaFh4cU1Ic3F4eHBCREdCeEowTXU0NG5yazZ6Ty9i?=
 =?utf-8?B?eWJhaXlQMG9HN253ZHlSMjFKcFNCN3BEa3VRRXJVREVFZWNsYnNHYmVvYXc1?=
 =?utf-8?B?eEVoaFllVzBqYXlzUjAxZTRkbjFqc1pMWmp6U0NiSmptRXF4bmdCb1pndmxY?=
 =?utf-8?B?QUZGZnVoWWFjdGZ6VVI4VHJ3SThyeHVtRVJEaUdoMlhzQllMdlovMVI1VVZm?=
 =?utf-8?B?MTRZTzIvWk5iLy9tYnNPdUUxZjFmdU82K1N0Yll4VE15VjJCQnpXZHh3bWFQ?=
 =?utf-8?B?RTNaVGZUcTNSc1BkaTJmSmh3SlBQZEpYNzgzb3ZmY0RCaXNDSkJqTTV6RUZX?=
 =?utf-8?B?VUlnZVFza0JOMld6V283dGN2SWN4ZVpCQTBRbVBVRWlIc0FyTERxR2wydTJR?=
 =?utf-8?B?Z0p1ZG1PeC9oZDJPa2ljTVRNcGIrNkY1WVdnYkxnMjBEMlZtZ0FVSG10NjB4?=
 =?utf-8?B?TEVNMXI3ZytHUU91ZVBqSjJTV3U0N3hKNEJlSlc2QUswRGUzTDJRa1ZicDFN?=
 =?utf-8?B?L2RuMEEvUGhZU25FdEZuN2grNGI2NkpCdkpoWFRQMVVlR0Y5U0FFdi92eHdy?=
 =?utf-8?B?Q25laG1ZQ2tRZk1zR3A2VXVwWk91eXRINXF6bS9Xc0dFU3FBR1poczdoQXNo?=
 =?utf-8?B?VHExWjRISXJaYmdYMURBdkZSWnA5dHpobHl2WVNDUzhtdUt1T0ErUFMxQ1dr?=
 =?utf-8?B?aFhnU1ZIdXVUN1dIcE91RG9GVHlGVVd0RnZRSkJwVnpiMkNqVnRjVjFUMVFB?=
 =?utf-8?B?NXR2VkRJb2VqcmpTQm9jb2sySzBzQVNITEZ2TncwMGppQlZtdWVYaUlNUUYv?=
 =?utf-8?B?YUx2aTY2K2cyRkdDYVpCNUZUbVlaa0FlRzdjbkpBdEc3YW00WkIvYjN3b3JW?=
 =?utf-8?B?L3U3U0dRMHlNMFZPQUVKUW5tWmk5Z0ZvOE1qWTUwRnFVd1VOVmUvM0d4Qjcr?=
 =?utf-8?B?dmZGTlhkMDhtNmlsbjRsbmtlYTNtUmF6OFRGV0VmK0p6dDhyejMwOUwxTk5w?=
 =?utf-8?B?dnVOWHZRRVpxR2tVQkhFeHJOSEExUnhZQkpyNDBnOHRoMnp5K2ROQUVOemVn?=
 =?utf-8?B?YlJNNXBvajB2WTZsc2V4QlJRZm1aT04zZThlOS9GdXJpWU9GT25WV3h4akta?=
 =?utf-8?B?dzY4NlE0ZzZrUWdma3UvN3FQWjR0QWQyV2hRYmhLN1I0NVBNWGk5V1BaOEI0?=
 =?utf-8?B?ZHJhUHhTeVpXbTZOMVVjSWx6cWQrVEZoM0Y1aFRpMmpBdXRSaTZHbnNyNUhr?=
 =?utf-8?B?RzdRY3hvallPSEFzdlVPdis1TVYxYkN4YnUyL2NUZ09Yc1lWckp3U2k2OGwr?=
 =?utf-8?B?Wm9sSWJSMGRmbUVnZGcvMlRMbVlHaldIWTB4UGxtOEF0Y3dhWE4rcU5CRFQz?=
 =?utf-8?B?R3ZaVnZmalB1a1hGZFlhakhCTXFyeUh0SEszckJwRXhRT2V3TXpNNm0wcEN4?=
 =?utf-8?B?SGtqVVFaOFhVcitiejBaSHJqUGhKWnlFWGxIbWY5elNzRzJuVEFFaUE3Mnpm?=
 =?utf-8?B?TWJVS1pLbytTTVhZc3BzQnUwNUcwTVpseEtzcDZWR3pJQVZlRmFoSzEvY3dy?=
 =?utf-8?B?NnRWKzlNcHRyNmFJeDhKYjJ2emV6Sk9aSHFLOGw0WUI4ZXJaNSt2T0JsVGJU?=
 =?utf-8?B?RnJXWjI4VHFQUC8wV1VLMk0vRlpiZUFreGdNcGxxODk3ZFlhekNJalhEcUV4?=
 =?utf-8?B?Z0x1THh4WkYwR2VCaUhVb2lGa3d6WHR1TXJwZjZKblQxTGlwQzVtZVJETjlW?=
 =?utf-8?B?eXplYUxROUJFR3daY2Y3Skc3UWpFNjhkU3JUcEFPajgxMWVJNFljSmpvSHNE?=
 =?utf-8?B?N3dSTnR2aU1WNUhRUTUvSnptR0p2UjRBWkRWd0txOUl2U2JuL0VSVFF3TjZw?=
 =?utf-8?B?UEFiWmMydXZXMm1BdS9YY2p2QVI3L3l0OHg4Q01NcS9CeDZ2RmZ1YlZHUDRD?=
 =?utf-8?B?a2NORlR4bFRacFJVRkU1RGdKWC9JZUhOMVlCY3I5akpLTVBMRUpNNUZmbTAv?=
 =?utf-8?B?bHM1Y1FnMkxHK3JBZnZ5QnRaVyt1cHVKRUo2OFZBam5WRHVKNHVxT3UrMzZU?=
 =?utf-8?Q?EuH9iwZhmiBWZvPpwI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5940ccaf-be92-49bd-068d-08dee0fdfc3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 16:44:19.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpJ/GWANOIr8QHLvaDT8Z6m4RFZ2CajajaUgkJjkeqPCW3EEn06Wmr9T4rqEWn6XeDfLPxqtTbBnPianKJU0zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIChu
dmlkaWEpIDxkamJ3QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDEwIEp1bHkgMjAyNiAwNjozMQ0KPiBU
bzogTWFuaXNoIEhvbmFwIDxtaG9uYXBAbnZpZGlhLmNvbT47IGRqYndAa2VybmVsLm9yZzsgYWxl
eEBzaGF6Ym90Lm9yZzsNCj4gamdnQHppZXBlLmNhOyBqaWMyM0BrZXJuZWwub3JnOyBkYXZlLmpp
YW5nQGludGVsLmNvbTsgQW5raXQgQWdyYXdhbA0KPiA8YW5raXRhQG52aWRpYS5jb20+OyBhbGVq
YW5kcm8ubHVjZXJvLXBhbGF1QGFtZC5jb207DQo+IGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29t
OyBkYXZlQHN0Z29sYWJzLm5ldDsgZG1hdGxhY2tAZ29vZ2xlLmNvbTsNCj4gZ291cnJ5QGdvdXJy
eS5uZXQ7IGlyYS53ZWlueUBpbnRlbC5jb20NCj4gQ2M6IE5lbyBKaWEgPGNqaWFAbnZpZGlhLmNv
bT47IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+Ow0KPiBWaWtyYW0gU2V0aGkg
PHZzZXRoaUBudmlkaWEuY29tPjsgWmhpIFdhbmcgPHpoaXdAbnZpZGlhLmNvbT47IE1hbmlzaA0K
PiBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+OyBrdm1Admdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4gY3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwMS8xMV0gY3hsOiBBZGQgY3hsX2dldF9oZG1f
aW5mbygpIGhlbHBlciBmb3IgSERNDQo+IGRlY29kZXIgbWV0YWRhdGENCj4gDQo+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiAN
Cj4gbWhvbmFwQCB3cm90ZToNCj4gPiBGcm9tOiBNYW5pc2ggSG9uYXAgPG1ob25hcEBudmlkaWEu
Y29tPg0KPiA+DQo+ID4gY3hsX3Byb2JlX2NvbXBvbmVudF9yZWdzKCkgZmluZHMgdGhlIEhETSBk
ZWNvZGVyIGJsb2NrIGR1cmluZyBkZXZpY2UNCj4gPiBwcm9iZSBhbmQgY2FjaGVzIGl0cyBsb2Nh
dGlvbiwgYnV0IGRvZXMgbm90IHJlY29yZCB0aGUgZGVjb2RlciBjb3VudA0KPiA+IGFuZCBkb2Vz
IG5vdCBleHBvc2UgdGhlIHJlc3VsdCBvdXRzaWRlIGRyaXZlcnMvY3hsLy4NCj4gPg0KPiA+IElu
LWtlcm5lbCBjeGwgZHJpdmVycyAoVHlwZS0yIGFjY2VsZXJhdG9yIGRyaXZlcnMsIHZmaW8tY3hs
KSBuZWVkIHRoZQ0KPiA+IGRlY29kZXIgY291bnQgYW5kIHRoZSBieXRlIG9mZnNldCBhbmQgc2l6
ZSBvZiB0aGUgSERNIGJsb2NrIHdpdGhvdXQNCj4gPiByZS1ydW5uaW5nIHRoZSBwcm9iZSBzZXF1
ZW5jZS4NCj4gPg0KPiA+IFJlY29yZCBkZWNvZGVyX2NudCBpbiBybWFwLT5jb3VudCB3aGVuIHBh
cnNpbmcgdGhlIEhETSBjYXBhYmlsaXR5IGluDQo+ID4gY3hsX3Byb2JlX2NvbXBvbmVudF9yZWdz
KCksIGV4dGVuZCBzdHJ1Y3QgY3hsX3JlZ19tYXAgd2l0aCBhIGNvdW50DQo+ID4gbWVtYmVyLCBh
bmQgYWRkIGN4bF9nZXRfaGRtX2luZm8oKSB0byByZXR1cm4gb2Zmc2V0LCBzaXplLCBhbmQgY291
bnQNCj4gPiBmcm9tIHRoZSBjYWNoZWQgbWFwLiAgRXhwb3J0IHVuZGVyIHRoZSBDWEwgbmFtZXNw
YWNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFuaXNoIEhvbmFwIDxtaG9uYXBAbnZpZGlh
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jeGwvY29yZS9wY2kuYyAgfCAzMyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiBkcml2ZXJzL2N4bC9jb3JlL3JlZ3MuYyB8
ICAxICsNCj4gPiAgaW5jbHVkZS9jeGwvY3hsLmggICAgICAgfCAgNCArKysrDQo+ID4gIDMgZmls
ZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY3hsL2NvcmUvcGNpLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jIGluZGV4DQo+ID4gMmJj
ZDY4M2FhMjg2Li5jOTE3NjA4YzE2ZjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jeGwvY29y
ZS9wY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcGNpLmMNCj4gPiBAQCAtNDQ5LDYg
KzQ0OSwzOSBAQCBpbnQgY3hsX2hkbV9kZWNvZGVfaW5pdChzdHJ1Y3QgY3hsX2Rldl9zdGF0ZQ0K
PiA+ICpjeGxkcywgc3RydWN0IGN4bF9oZG0gKmN4bGhkbSwgIH0NCj4gPiBFWFBPUlRfU1lNQk9M
X05TX0dQTChjeGxfaGRtX2RlY29kZV9pbml0LCAiQ1hMIik7DQo+ID4NCj4gPiArLyoqDQo+ID4g
KyAqIGN4bF9nZXRfaGRtX2luZm8gLSBHZXQgSERNIGRlY29kZXIgcmVnaXN0ZXIgYmxvY2sgbG9j
YXRpb24gYW5kDQo+ID4gK2NvdW50DQo+ID4gKyAqIEBjeGxkczogQ1hMIGRldmljZSBzdGF0ZSAo
bXVzdCBoYXZlIGNvbXBvbmVudCByZWdzIGVudW1lcmF0ZWQgdmlhDQo+ID4gKyAqICAgICAgY3hs
X3Byb2JlX2NvbXBvbmVudF9yZWdzKCkpDQo+ID4gKyAqIEBjb3VudDogIG51bWJlciBvZiBIRE0g
ZGVjb2RlcnMgKGZyb20gSERNIENhcGFiaWxpdHkgYml0cyBbMzowXSkNCj4gPiArICogQG9mZnNl
dDogYnl0ZSBvZmZzZXQgb2YgSERNIGRlY29kZXIgYmxvY2sgd2l0aGluIHRoZSBjb21wb25lbnQN
Cj4gcmVnaXN0ZXIgQkFSDQo+ID4gKyAqIEBzaXplOiAgIHNpemUgaW4gYnl0ZXMgb2YgdGhlIEhE
TSBkZWNvZGVyIGJsb2NrDQo+ID4gKyAqDQo+ID4gKyAqIEV4cG9ydGVkIGZvciBjeGwgZHJpdmVy
cyAoaW4ta2VybmVsIGFjY2VsZXJhdG9yIGRyaXZlcnMsIHZmaW8tY3hsKQ0KPiA+ICt0aGF0DQo+
ID4gKyAqIG5lZWQgSERNIGRlY29kZXIgbWV0YWRhdGEgZnJvbSB0aGUgY2FjaGVkIGNvbXBvbmVu
dC1yZWdpc3RlciBtYXANCj4gPiArd2l0aG91dA0KPiA+ICsgKiByZS1ydW5uaW5nIHRoZSBwcm9i
ZSBzZXF1ZW5jZS4NCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MuIC1FTk9E
RVYgaWYgdGhlIEhETSBkZWNvZGVyIGJsb2NrIGlzIG5vdA0KPiBwcmVzZW50Lg0KPiA+ICsgKi8N
Cj4gPiAraW50IGN4bF9nZXRfaGRtX2luZm8oc3RydWN0IGN4bF9kZXZfc3RhdGUgKmN4bGRzLCB1
OCAqY291bnQsDQo+ID4gKyAgICAgICAgICAgICAgICAgIHJlc291cmNlX3NpemVfdCAqb2Zmc2V0
LCByZXNvdXJjZV9zaXplX3QgKnNpemUpIHsNCj4gPiArICAgICBzdHJ1Y3QgY3hsX3JlZ19tYXAg
KmhkbSA9DQo+ID4gKyZjeGxkcy0+cmVnX21hcC5jb21wb25lbnRfbWFwLmhkbV9kZWNvZGVyOw0K
PiA+ICsNCj4gPiArICAgICBpZiAoV0FSTl9PTighY291bnQgfHwgIW9mZnNldCB8fCAhc2l6ZSkp
DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAgaWYg
KCFoZG0tPnZhbGlkKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gKw0K
PiA+ICsgICAgICpjb3VudCAgPSBoZG0tPmNvdW50Ow0KPiA+ICsgICAgICpvZmZzZXQgPSBoZG0t
Pm9mZnNldDsNCj4gPiArICAgICAqc2l6ZSAgID0gaGRtLT5zaXplOw0KPiA+ICsNCj4gPiArICAg
ICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX05TX0dQTChjeGxfZ2V0X2hk
bV9pbmZvLCAiQ1hMIik7DQo+IA0KPiBUaGlzIGlzIHRoZSBzYW1lIGluZm9ybWF0aW9uIHRoYXQg
dGhlIENYTCByZXNldCBwYXRjaGVzIG5lZWQgdG8gY2FjaGUgb24NCj4gdGhlIFBDSSBkZXZpY2Uu
IEVmZmVjdGl2ZWx5IHRoaXMgbGV2ZWwgb2YgQ1hMIGluZm9ybWF0aW9uIGRlc2VydmVzIHRvIGJl
DQo+IGFzIGFjY2Vzc2libGUgYXMgUENJIEJBUiBpbmZvcm1hdGlvbiwgYW5kIHNob3VsZCBub3Qg
bmVlZCBjeGxfZGV2X3N0YXRlDQo+IGNvbnRleHQgdG8gZmV0Y2ggaXQuDQo+IA0KPiBTbyBpdCB3
b3VsZCBiZSBnb29kIHRvIGRlcGVuZCBvbiB0aGF0IHJhdGhlciB0aGFuIGludmVudCBhIG5ldyBl
eHBvcnQNCj4gbWVjaGFuaXNtLg0KDQpBZ3JlZWQuIEkgd2lsbCBtYWtlIHN1cmUgdG8gYmFzZSB0
aGUgcGF0Y2gtdjA0IG9uIFNyaXJhbmdhbiBNYWRoYXZhbidzIENYTA0KcmVzZXQgdjA5IChiYXNl
OiA4Y2RlYWE1MGVhZTgpLg0KKEhETSBpbmZvIGlzIHJlYWQgZGlyZWN0bHkgZnJvbSBwZGV2LT5o
ZG0gYXQgb3Blbl9kZXZpY2UoKS4gTm8gbmV3DQpjeGxfZ2V0X2hkbV9pbmZvKCkgZXhwb3J0IGlz
IGludHJvZHVjZWQuKQ0K
