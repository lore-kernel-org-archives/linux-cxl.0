Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010055.outbound.protection.outlook.com [52.101.228.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F272AF1B;
	Wed, 28 Jan 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769563130; cv=fail; b=Jxf2OSySvpJBbQqxNvzJ/nmWl3Q/EoDOcQyGLqg7iDUXMichidxPEFt7Qbcgg4n+6MmsVEBOqQJdQszrpoq8BU7b7ZSmgnErlCJZQBHLyoVy21WKprpTJk8LUJcXiD9VxO7zViW3Qjh0T5/eg2xAMmpa0g0mTO49N2Hc/NyGFCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769563130; c=relaxed/simple;
	bh=4uvsL1BUaolw0eJPr7zYppVyLXtynlIzGXcl64k49ww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E12hz5tFJYMbsMjR4ZRPIi5PUMYlkJqPcnfNLkWeP4I8Xe1jg/jzDHlrRIdME/fOhW2KGnH2alLHGasTs9gW07lG+nOhimHJZvfetmMT71nxqtUSTSj7IJz3rnPFVJtdZzL+o5WravYO2hJ7gxc+6ZuvDJWv+eEtttspXxfjbRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dO2AB4ol; arc=fail smtp.client-ip=52.101.228.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dO2AB4ol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri2pVu3UKsiIxFVgW3LlEci0pRAm5uM3iHxhVx5oJFqj7uKqzjWFO3nlQ85KlcpZiD7F7cxxil+2LOkVXYSLdOAmihYCLXyKNAEeW7FgABaHT0zSp0MFpsvY5bKBqPNqzALwjrnhWicDKkS6wdteUuro6OJfNQSkn1LUJR/pQAXGUO61DanoWVx/l8BZSu4+kr9RAUAMHucQGmRtOxCbO5NEbHi5DTuy+mI2MhG0AOHzKZzKcZVeqzketIKyIhshwIvse3rKro+ivWXPDFR+qQweQT7/ZXdxuiGRRtxhQzODyk2naTewmfWzblbwsov8L35akP3QxR6+vrzhhCu+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uvsL1BUaolw0eJPr7zYppVyLXtynlIzGXcl64k49ww=;
 b=EuuY6I4B7A/DdM2QvkWbPRHfx53jGgpBdCJkVdVH8mEZjVL4oGbsvShoeTcgMwtrMbjKid3Pu0hnt0h3eEuVccboiM2g8eXr/dXbRn0mPZaycWMixf5t+WWL9KK3LrJuMozScfBeibcj2Y5Nd+75GXsqywLhTnHQeLzGl3stEJ0lojerRCOBegklEV1LGWmwsMX21+PETFYGDsHJxuQFvOJDP9lqHNiXqkNCQIxUvE/dTiTylw0cVwFJw+rnJCDpl45JkGIxiGsg2bNCSmFJfeIguIKSCwZVPLi0pYKig6hck4bv8UaVqKA6neU1LmvYsOSnzmyjNes2tBq4JHKOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uvsL1BUaolw0eJPr7zYppVyLXtynlIzGXcl64k49ww=;
 b=dO2AB4ol3SOcaXMSEne8ayMvJpwEOfH5JSN0dgmxHGEPZ6T3etipiZpgszYPVQRWRwoEZ3/O3ofZ3V8zQvbBS2KsEBdMBwg/a6kXWQEA5goz/iqQyY0LNt2ygBLMllfJKkSs0B0jMZXnRoTunBdeqk6r6zXDC8t5gD5+UR2chM4DSLHn2NnG7t+ngF8En56qcVs0W1NcdHbBmfPV1uVTo+AY1hCjN8HtEJRleBJXXfASclCAEPYM14cIhBtQW0QcSMV8/DV1AmKx7d0D/snyuGGTmMpa5gcr6Zruh8xVQwfKk4XvqiNKfa4FORuM0J6knH/mMdKrTcod5BYvjaiBrg==
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 (2603:1096:405:32e::20) by OS9PR01MB15510.jpnprd01.prod.outlook.com
 (2603:1096:604:3bf::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 01:18:45 +0000
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f]) by TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f%4]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 01:18:45 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Pawel Mielimonka (Fujitsu)" <pawel.mielimonka@fujitsu.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>
CC: "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 1/1] cxl/cli: enforce HPA-descending teardown order for
 destroy-region
Thread-Topic: [PATCH v3 1/1] cxl/cli: enforce HPA-descending teardown order
 for destroy-region
Thread-Index: AQHcjs3cQbJf4qzTfUyhUsFD4oHol7VmynmA
Date: Wed, 28 Jan 2026 01:18:45 +0000
Message-ID: <701cbcb6-136c-457d-9b1d-8ae9581a3182@fujitsu.com>
References: <20260126141459.3935967-1-pawel.mielimonka@fujitsu.com>
 <20260126141459.3935967-2-pawel.mielimonka@fujitsu.com>
In-Reply-To: <20260126141459.3935967-2-pawel.mielimonka@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB16837:EE_|OS9PR01MB15510:EE_
x-ms-office365-filtering-correlation-id: 3a9229f0-0d84-4296-95c0-08de5e0b2ee8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFAyWi9vU09WTHBza0h6UXRKbDFhMzZDZ1BBOXJlNXBuWTNET0tNaG5qWTR3?=
 =?utf-8?B?Q0dBWEI5Zmx2WlVtMVpQUENYWmtJdkZNZVV4TnFvNmZQVWx6Qm1FNml0N3dW?=
 =?utf-8?B?VUUyNWpxWXlBSGFhVTA5cTRIUFBnTVJtQTlRV1J4c1o2dU9sd3lpNWx1TmNV?=
 =?utf-8?B?dTR0S3Q0Z081MlRtR285TEhiWEJoeEFjWFZOZlZMdnNLSjB5N0Q0WFhhelJv?=
 =?utf-8?B?cmpXOUR5a0poUjVXOGQ5S1N6TU9PcGNoNjlnVTBIMWNCejdjMjk4NkloRU1m?=
 =?utf-8?B?ekJVdHdTN3o0L1R4Mnk3VkExUnVlcURsYVhPd3N6azhkeW9hMFZaOEpYSkdn?=
 =?utf-8?B?cDIwRDBoSlBaYXpCZi92UU1GMVJMRlplTGlzWEVFd21QcFZMc2ZwaVhFeWVy?=
 =?utf-8?B?MFNSaFRtWk5GeXJkSFF2TDFMVUh4aXJDSm9XWldpbnh0VGJOR1VnQ2FMWkho?=
 =?utf-8?B?RlFnMFhoSDlCd25xbXVwK2xPWkhmbmthWlJGczB6bmdnRzNuN1hKMVlGRExq?=
 =?utf-8?B?NldsVXdoSzFhNDdKcGJWSitSU3Y3bjNqaXN5OU9iSkRUUWVmRXV2ckV0SmFN?=
 =?utf-8?B?Y3JYY3V1dk51QzFnTjFaRkI5NUJRR20zaFZRMnRtcDJZS3B6UkxBUUZlTGli?=
 =?utf-8?B?d0h6WHVzTlVYaEU0eVlDMENvTVF4SHExNHpWd0VHUTgzb0JSUmloZlRBelBx?=
 =?utf-8?B?eEdZeGxkSXgrMjczazV2czRPNXovWndPWS8xOGtsVGxrdXBsTzliWmUvYkFz?=
 =?utf-8?B?U2xRNTdCbi9mQS9aRi9MM1J5eVhDSjJZRHZZcWJ3STd6ZllSVTFEMVdlbWxP?=
 =?utf-8?B?ZS9rK0Q4VnhDczBYc0RYbE1PbythVmpIZGNXMTJOU2lxemVNMGo3RWdxVjlt?=
 =?utf-8?B?VWNQNEpobDFxRW5HMzRqaTArdkdjU2ljcm1vQjlrbmdLRG5paUJhS0d6WGpy?=
 =?utf-8?B?cU1rbDl2TEZxMGJmdUt3dXVnSG5jclg5bmhaVHNML3ZJcnVYMXlzNmluZlc0?=
 =?utf-8?B?UjNJTE9SVkEyby9YcW5NdmNNWWRVZkFEa0M4VWZYdWhjM1VwTDZEL3psZUJO?=
 =?utf-8?B?amRSMWlCS0VKeEhlT0hpZ3R4OGY1bkFvWDlEaGtIbVZsb2ZaWGF0SGxzaU9X?=
 =?utf-8?B?K1N5QTlVbmtVMjlEZ1BUTDNCTjR1cWdJVnpHdkh1UTFzTzM2ZU5SNUxoTEJG?=
 =?utf-8?B?MDRFeXJpaVEyVDZQWmVoWG1xa2FYRnk4dnJFWkxJbFkvNjFMSmhNYUowMXFW?=
 =?utf-8?B?QUlxelE1TWFqcGF3aUNpNmRHVHBmL1lQUnhrVDZ1dTFtalBBM0hJVDJveEZP?=
 =?utf-8?B?WTdTaTNsbHF0VjZPWTd0OXVzeVdISTQrcHdoNEtUY3V2dWZBZ2syLzVzRGN5?=
 =?utf-8?B?RFh3ejdmd2F1N05FbEhSeEFaU2phdnVMaUdVUTZwbjNxdXhET3R0UGM0MXVr?=
 =?utf-8?B?cndsUDh1VUZjQzJ6b1hSc0k2NUdyUUFPeVVqYmI2THAyL1RmR0hOWWc2cUhW?=
 =?utf-8?B?WmV1dGZ4bmpNdko3dUVWVEJpOVNoV094TFZ1S05PaUFPczNiNm9pN0Z6U000?=
 =?utf-8?B?RVZGdU9ZM2wvVHZPZjJoRnM0UEpERm1TNVJETk9TdnZJZ2pHSDBVSHdPa0JB?=
 =?utf-8?B?TzMvQktVRGNwTVREUThkTWZjNXBnTkpSZFJScEoxUHI3L28zejJ1TzJkbTRr?=
 =?utf-8?B?WjNoOWNFdXQ3aVd2dHFvZ24weUFFaHVoSlNhMHR3V2lXN1luWUowanF5YzUx?=
 =?utf-8?B?S0hhT1NWcEVoOHR2QUd2bW5DcGFFeUwvUytkTEpLVEJMRytoT3pTWUNjVGwr?=
 =?utf-8?B?Q0pDM2tKWHFreDFReDBDbGtXdnpUc3dNb3JTeWxyRm14QWlrMHYvLzBoUlJH?=
 =?utf-8?B?OU9rakN5RVRuV1FQdHQzN25SOWNtKzFUeWo3K1dOQjJEalh2V2FmOU4yWTBT?=
 =?utf-8?B?MVBpMmhLTjIzVnNqNHBKSkorVVROeURLV0pnL0ZaME5pakliaDRwdjRDTTZZ?=
 =?utf-8?B?RnJ1aWdRZGhqNjVOdHdaSW5WRVc0N2krL1c5eUVaR3ZpTHY3cGFNSmxNM2py?=
 =?utf-8?B?MkluaThIMTFPbE1SK0pTbFovNGRlbGU1bjBVL1dyOUs4VVNrWEpXY3lsVG5R?=
 =?utf-8?B?eUtrTnZHUllkU2htM0lTeStRQUtsWHc5bWdlQjNFcUlsVXdISnUrVnJBMVd6?=
 =?utf-8?B?c3lMQlJLUVp4UVJsL2cyOU1WY1h4eTV2RjZ1RmpTTjN2cDFwdWlsL2tNU1Nq?=
 =?utf-8?B?UVpEUEoxYnAyL3JubmNYVzRKWTh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB16837.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGd5aHZzcGtXeGZmSjJ5Z1FNTHN3ODE3M0Z0OTFWYjdSRzNMdEIrL3dnSWNH?=
 =?utf-8?B?VnBIUHJwMGlMQ1VmOVhFamwyRER3c0tkd1IwOXphZGhCR3NWU2IzNzg5NFhP?=
 =?utf-8?B?VjNxNGt5M3lXTnJwUzBvbStXTi8xYkhwTkRxRkpFZ3NudTJyWFdoN1hqNXdO?=
 =?utf-8?B?QjFnRzVjM0ZBZWxDYk03QXlMOHhsaFFqa1pheC9TbThURkk4ZlZMaGZ2TldZ?=
 =?utf-8?B?bHZpTjNJZU1XK2VaNGxpU3VacG42MXNoV2pPeFlrRkpZQXk3TVhqMzgzSkgw?=
 =?utf-8?B?SUdjRGlVTmlNTVVDRlV3NnJGMkpraG82d1NzeXIyWTcvMXJ6WDJLd3oyQW9j?=
 =?utf-8?B?bW9iVDZnV1pCVHhLNEF2RHltUUVmTWFrTjk1UmYvNk5UbldtelZaVEhpQ3JF?=
 =?utf-8?B?Tkx2VVkvZngzZEFxS0Nmb0NUazRweG9zS0ZVa2hnNlBFLzM2dStKSlhPaWYx?=
 =?utf-8?B?WjN0d1BhamkzdTBRTEVkZktXTGwveWl4NTNRR2pNM3JkRTdScFZFQWdIVUY1?=
 =?utf-8?B?cGdBM2czVFN6NDIyTms0aERmVjE3Tm9STjdMWTZYcis0a3BHaWY5SXBPV213?=
 =?utf-8?B?clN6Ukh6YkIvZzI3YnVZSko2WjRLTFZnZDJIMHNobi9HanlVWW9MQWZFNmM5?=
 =?utf-8?B?d1pGcXJ3VVQ4WDh5K2tvcDgreStncE5lZ0E0aU0wSEQweGhXdkNEdHMzaTZw?=
 =?utf-8?B?aHhCWm12ZVp3NlI1aHcrRm1nVzltOXY3V2dNVTFlUCtqbjc4aHNISVZKUTNP?=
 =?utf-8?B?NlRpbi93OWtzTE00MEVxcTM5ZXJtemdhWlRaVXFKNjI5MVR5T2Z3UENlZnBR?=
 =?utf-8?B?UjJ6YWxCay9Qd3RFbmp6cnpiTnJxUm9JVDN3Wk9OTHpzQW5WdVJ4bkFkQmpl?=
 =?utf-8?B?bkFoMTQ0cU9QM0ZZM2lmSDE0MkZ3S1dLOGU5TkdVb3p0YVQza3RlVFA0MUpD?=
 =?utf-8?B?RFFjYWVOTytUN01Ocnphcm1EY0tYYmQ4MDgxaTRGYU5vSDV6bE5JbVJYcHRa?=
 =?utf-8?B?aUdFZTdSQ1QvNGRrYTJCdlYzZlMzYSt0VmpTbjMxUDBuWVRWb2tLTzZUaDkv?=
 =?utf-8?B?Zld0ajVpU2N4S0lPaE84S0tWUitjNUd1RnhvOEl2V21qRmNEU0ZDcnlEcHBk?=
 =?utf-8?B?aXIycDhybGx4RS9UWUJKb1BxdzBQaWcyK1lOUXpVY3RXMnEwZUFtSkV3Ujl3?=
 =?utf-8?B?S2ZZVGV6MjF5cGkxTU81TEJVMGhqbVUzMG5walhaL0czOG5oTUtuUkFuTmlr?=
 =?utf-8?B?K3JScGxUYW1pbEVoRVZCNUw4RlQxUmdIbVl4RDRJSERqRGtwTDRVc2dpUzZH?=
 =?utf-8?B?TklLbWhuRjd5VVhIVUcwYUl4ZFlwc3UwcmVtN09pRFB2MjFQMHNma0c2c20x?=
 =?utf-8?B?Skc4YTE5ZlRpeXdGZ1NCV1ZMY0lFY3YzajBMRlFUU09jVXJnYTV0b2N0YWFS?=
 =?utf-8?B?RVdLUFo2ZmxNbS8xVmZ6VC9ia3g0TFU0UEh2c21WSWRzYXd3enRqNkp5SXpM?=
 =?utf-8?B?ZU5CWkQ1c2xtNm9kM1dwaWI5a013WTg5bGtJcytQdUFxV3ZDcVpTQ2p6RlBw?=
 =?utf-8?B?RzBBTWs2YXNLTGErek95UlRPeFREaWFGY3doZ0RwZnRyMG5UeFZZTkhLZE9C?=
 =?utf-8?B?eitHZW9rRHhsOFphYXZacGg5YlFFc1NJUm9DVVBXOEJhM2ZPcEF5d1ZTSWF5?=
 =?utf-8?B?bUJlOU1SeURMWlAyK3RPdnNRWTBjbDJiNU5EUGdlRHkzSUpId0tsNHNVOE0x?=
 =?utf-8?B?K3lhd0xwVXo1cVJGM1FjckZXZDhVRlB6NU9WZjhqQ0x2c3BSRC92RUNhU2M1?=
 =?utf-8?B?R0RlVVZQcDVjc3VZVXdWd3ArOUs3anBhZEtOeEJmU2RtK1BRL296VElZL2VX?=
 =?utf-8?B?Tlg4dG9FOFVna0xDNFp2WW1ycHEvT1E2c0doVUhjSDZjbVBxSzNrT044RHdV?=
 =?utf-8?B?TzdHZkZvNkNCMEt2RkYwOFVvTFNGajhVZWU5YmNxaHhwT2tDelVPMFJrUG5B?=
 =?utf-8?B?cmpsZG5YQTVHaTNIMncyeHFQdmNQWkl1a2dXcU1aQjRGb0hWZzZKeDFGNjU2?=
 =?utf-8?B?QVJRL3htRTZqVnN1TTUxeDhQancyK3lIZ1FCNC9kSmkyd1hWTFVQd1o0amdP?=
 =?utf-8?B?eGNubTgzTnhySUxqNXdsU0VrcllQOXdaQm5oSjFJa3dnZ1NoUWtOdFp6MWta?=
 =?utf-8?B?eUl5MXBubHFRaTRhcEtLTzkvSURpcWg4dnIwNXFZVjNPeHBobm9RdnpZK1px?=
 =?utf-8?B?TkJXeUpKNzFGUFpnbUU4WTc4YmFXV0NmaHFWSDRvcndycmJ4Q0tuTXFnVjFW?=
 =?utf-8?B?UWtnRFc3ZHJKcDJXSkxhcHRoYnd4eWZLUGNSL0M4UG9Sak5Ua2gyeFl3dXZY?=
 =?utf-8?Q?gN+mRsg3qqFdgZMs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97A51CC135EA11498CC70BE8580ED646@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB16837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9229f0-0d84-4296-95c0-08de5e0b2ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 01:18:45.7466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDYjHLrkN/y27qoZ741tE1kDKn1ILbtJ60uQf0qD9qYyyuX+5CDl4i2GF6IO8JJlWCAZPIDjV7iPc/bwhD8+PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15510

SGkgUGF3ZWwsDQoNCg0KT24gMjYvMDEvMjAyNiAyMjoxNCwgUGF3ZWwgTWllbGltb25rYSB3cm90
ZToNCj4gTm90ZTogVGhpcyByZXZpc2lvbiBjb2xsYXBzZXMgdGhlIHByZXZpb3VzIDItcGF0Y2gg
c2VyaWVzIGludG8gYSBzaW5nbGUNCj4gcGF0Y2guDQo+IA0KDQpUaGUgY29tbWl0IGxvZyBmb3Ig
dGhlIHBhdGNoIGl0c2VsZiBpcyBtaXNzaW5nIHRoZSBkZXRhaWxlZCBkZXNjcmlwdGlvbi4gUGxl
YXNlIG5vdGUNCnRoYXQgZ2VuZXJhbGx5IHRoZSBjb3ZlciBsZXR0ZXIgKHBhdGNoIDAvMSkgd2ls
bCBub3QgYXBwZWFyIGluIHRoZSBmaW5hbCBnaXQgbG9nLA0Kc28gdGhlIHByb2JsZW0gZGVzY3Jp
cHRpb24sIHlvdXIgcHJvcG9zZWQgc29sdXRpb24sIGFuZCBvdGhlciBkZXRhaWxzDQpzaG91bGQg
YmUgaW5jbHVkZWQgaGVyZS4NCg0KDQpBZGRpdGlvbmFsbHksIGZvciBmdXR1cmUgc3VibWlzc2lv
bnMsIHBsZWFzZSB1c2UgdGhlICJuZGN0bCBQQVRDSCIgcHJlZml4IGluDQp0aGUgc3ViamVjdCBs
aW5lLCBhcyBwZXIgb3VyIGNvbnRyaWJ1dGlvbiBndWlkZWxpbmVzLiBZb3UgY2FuIGZpbmQgbW9y
ZSBkZXRhaWxzIGhlcmU6DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9wbWVtL25kY3RsL2Jsb2IvbWFp
bi9DT05UUklCVVRJTkcubWQNCg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQo+IFNpZ25lZC1vZmYt
Ynk6IFBhd2VsIE1pZWxpbW9ua2EgPHBhd2VsLm1pZWxpbW9ua2FAZnVqaXRzdS5jb20+DQo+IC0t
LQ0KPiAgIGN4bC9yZWdpb24uYyB8IDExNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY3hsL3JlZ2lvbi5jIGIvY3hs
L3JlZ2lvbi5jDQo+IGluZGV4IDIwN2NmMmQuLjVhYjlmNGUgMTAwNjQ0DQo+IC0tLSBhL2N4bC9y
ZWdpb24uYw0KPiArKysgYi9jeGwvcmVnaW9uLmMNCj4gQEAgLTgzMSw2ICs4MzEsNjAgQEAgb3V0
Og0KPiAgIAlyZXR1cm4gY3hsX3JlZ2lvbl9kaXNhYmxlKHJlZ2lvbik7DQo+ICAgfQ0KPiAgIA0K
PiArc3RhdGljIGludCBjbXBfcmVnaW9uX2hwYShjb25zdCB2b2lkICpsLCBjb25zdCB2b2lkICpy
KQ0KPiArew0KPiArCWNvbnN0IHN0cnVjdCBjeGxfcmVnaW9uICpjb25zdCAqbGVmdCA9IGw7DQo+
ICsJY29uc3Qgc3RydWN0IGN4bF9yZWdpb24gKmNvbnN0ICpyaWdodCA9IHI7DQo+ICsJdTY0IGhw
YTEgPSBjeGxfcmVnaW9uX2dldF9yZXNvdXJjZSgoc3RydWN0IGN4bF9yZWdpb24gKikgKmxlZnQp
Ow0KPiArCXU2NCBocGEyID0gY3hsX3JlZ2lvbl9nZXRfcmVzb3VyY2UoKHN0cnVjdCBjeGxfcmVn
aW9uICopICpyaWdodCk7DQo+ICsNCj4gKwlyZXR1cm4gKGhwYTEgPiBocGEyKSAtIChocGExIDwg
aHBhMik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgY29sbGVjdF9yZWdpb25zX3NvcnRlZChz
dHJ1Y3QgY3hsX2RlY29kZXIgKnJvb3QsDQo+ICsJc3RydWN0IGN4bF9yZWdpb24gKioqb3V0LA0K
PiArCWludCAqb3V0X25yKQ0KPiArew0KPiArCXN0cnVjdCBjeGxfcmVnaW9uICpyZWdpb247DQo+
ICsJc3RydWN0IGN4bF9yZWdpb24gKipsaXN0ID0gTlVMTDsNCj4gKwlpbnQgbnIgPSAwLCBhbGxv
YyA9IDA7DQo+ICsNCj4gKwkJc3RydWN0IGN4bF9wb3J0ICpwb3J0ID0gY3hsX2RlY29kZXJfZ2V0
X3BvcnQocm9vdCk7DQo+ICsJCXN0cnVjdCBjeGxfZGVjb2RlciAqZGVjb2RlcjsNCj4gKw0KPiAr
CQljeGxfZGVjb2Rlcl9mb3JlYWNoKHBvcnQsIGRlY29kZXIpIHsNCj4gKwkJCWlmICghY3hsX3Bv
cnRfaXNfcm9vdChwb3J0KSkNCj4gKwkJCQljb250aW51ZTsNCj4gKwkJCWN4bF9yZWdpb25fZm9y
ZWFjaChkZWNvZGVyLCByZWdpb24pIHsNCj4gKwkJCQlpZiAobnIgPT0gYWxsb2MpIHsNCj4gKwkJ
CQkJaW50IG5ld19hbGxvYyA9IGFsbG9jID8gYWxsb2MgKiAyIDogODsNCj4gKwkJCQkJc2l6ZV90
IG5ld19zaXplID0gKHNpemVfdCluZXdfYWxsb2MgKiBzaXplb2YoKmxpc3QpOw0KPiArCQkJCQlz
dHJ1Y3QgY3hsX3JlZ2lvbiAqKnRtcDsNCj4gKw0KPiArCQkJCQl0bXAgPSByZWFsbG9jKGxpc3Qs
IG5ld19zaXplKTsNCj4gKwkJCQkJaWYgKCF0bXApIHsNCj4gKwkJCQkJCWZyZWUobGlzdCk7DQo+
ICsJCQkJCQlyZXR1cm4gLUVOT01FTTsNCj4gKwkJCQkJfQ0KPiArCQkJCQlsaXN0ID0gdG1wOw0K
PiArCQkJCQlhbGxvYyA9IG5ld19hbGxvYzsNCj4gKwkJCQl9DQo+ICsJCQkJbGlzdFtucisrXSA9
IHJlZ2lvbjsNCj4gKwkJCX0NCj4gKw0KPiArCQkJaWYgKCFucikgew0KPiArCQkJCWZyZWUobGlz
dCk7DQo+ICsJCQkJKm91dCA9IE5VTEw7DQo+ICsJCQkJKm91dF9uciA9IDA7DQo+ICsJCQkJcmV0
dXJuIDA7DQo+ICsJCX0NCj4gKwl9DQo+ICsJcXNvcnQobGlzdCwgbnIsIHNpemVvZigqbGlzdCks
IGNtcF9yZWdpb25faHBhKTsNCj4gKwkqb3V0ID0gbGlzdDsNCj4gKwkqb3V0X25yID0gbnI7DQo+
ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgaW50IGRlc3Ryb3lfcmVnaW9uKHN0
cnVjdCBjeGxfcmVnaW9uICpyZWdpb24pDQo+ICAgew0KPiAgIAljb25zdCBjaGFyICpkZXZuYW1l
ID0gY3hsX3JlZ2lvbl9nZXRfZGV2bmFtZShyZWdpb24pOw0KPiBAQCAtODk1LDYgKzk0OSw1OSBA
QCBzdGF0aWMgaW50IGRlc3Ryb3lfcmVnaW9uKHN0cnVjdCBjeGxfcmVnaW9uICpyZWdpb24pDQo+
ICAgCXJldHVybiBjeGxfcmVnaW9uX2RlbGV0ZShyZWdpb24pOw0KPiAgIH0NCj4gICANCj4gK3N0
YXRpYyBpbnQgZGVzdHJveV9tdWx0aXBsZV9yZWdpb25zKA0KPiArCXN0cnVjdCBwYXJzZWRfcGFy
YW1zICpwLA0KPiArCXN0cnVjdCBjeGxfZGVjb2RlciAqZGVjb2RlciwNCj4gKwlpbnQgKmNvdW50
KQ0KPiArew0KPiArCXN0cnVjdCBjeGxfcmVnaW9uICoqbGlzdDsNCj4gKwlpbnQgbnIsIHJjLCBp
Ow0KPiArCWJvb2wgc2tpcHBlZCA9IGZhbHNlOw0KPiArDQo+ICsJcmMgPSBjb2xsZWN0X3JlZ2lv
bnNfc29ydGVkKGRlY29kZXIsICZsaXN0LCAmbnIpOw0KPiArCWlmIChyYykgew0KPiArCQlsb2df
ZXJyKCZybCwgImZhaWxlZCB0byBhbGxvY2F0ZSByZWdpb24gbGlzdDogJXNcbiIsIHN0cmVycm9y
KC1yYykpOw0KPiArCQlyZXR1cm4gcmM7DQo+ICsJfQ0KPiArDQo+ICsJZm9yIChpID0gbnIgLSAx
OyBpID49IDA7IC0taSkgew0KPiArCQlzdHJ1Y3QgY3hsX3JlZ2lvbiAqcmVnaW9uID0gTlVMTDsN
Cj4gKw0KPiArCQlmb3IgKGludCBqID0gMDsgaiA8IHAtPmFyZ2M7IGorKykgew0KPiArCQkJcmVn
aW9uID0gdXRpbF9jeGxfcmVnaW9uX2ZpbHRlcihsaXN0W2ldLCBwLT5hcmd2W2pdKTsNCj4gKwkJ
CWlmIChyZWdpb24pDQo+ICsJCQkJYnJlYWs7DQo+ICsJCX0NCj4gKw0KPiArCQlpZiAoIXJlZ2lv
bikgew0KPiArCQkJc2tpcHBlZCA9IHRydWU7DQo+ICsJCQljb250aW51ZTsNCj4gKwkJfQ0KPiAr
DQo+ICsJCS8qDQo+ICsJCSAqIElmIGN1cnJlbnQgcmVnaW9uIG1hdGNoZXMgZmlsdGVyLCBidXQg
cHJldmlvdXMgZGlkbid0LCBkZXN0cm95aW5nIHdvdWxkDQo+ICsJCSAqIHJlc3VsdCBpbiBicmVh
a2luZyBIUEEgY29udGludWl0eQ0KPiArCQkgKi8NCj4gKwkJaWYgKHNraXBwZWQpIHsNCj4gKwkJ
CWxvZ19lcnIoJnJsLCAiZmFpbGVkIHRvIGRlc3Ryb3kgJXM6IG91dCBvZiBvcmRlciAlcyByZXNl
dFxuIiwNCj4gKwkJCQljeGxfcmVnaW9uX2dldF9kZXZuYW1lKHJlZ2lvbiksDQo+ICsJCQkJY3hs
X2RlY29kZXJfZ2V0X2Rldm5hbWUoZGVjb2RlcikpOw0KPiArCQkJcmMgPSAtRUlOVkFMOw0KPiAr
CQkJYnJlYWs7DQo+ICsJCX0NCj4gKw0KPiArCQlyYyA9IGRlc3Ryb3lfcmVnaW9uKHJlZ2lvbik7
DQo+ICsJCWlmIChyYykgew0KPiArCQkJbG9nX2VycigmcmwsICIlczogZmFpbGVkOiAlc1xuIiwN
Cj4gKwkJCQljeGxfcmVnaW9uX2dldF9kZXZuYW1lKHJlZ2lvbiksIHN0cmVycm9yKC1yYykpOw0K
PiArCQkJYnJlYWs7DQo+ICsJCX0NCj4gKwkJKysoKmNvdW50KTsNCj4gKwl9DQo+ICsJZnJlZShs
aXN0KTsNCj4gKwlyZXR1cm4gcmM7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgaW50IGRvX3JlZ2lv
bl94YWJsZShzdHJ1Y3QgY3hsX3JlZ2lvbiAqcmVnaW9uLCBlbnVtIHJlZ2lvbl9hY3Rpb25zIGFj
dGlvbikNCj4gICB7DQo+ICAgCXN3aXRjaCAoYWN0aW9uKSB7DQo+IEBAIC05MDIsOCArMTAwOSw2
IEBAIHN0YXRpYyBpbnQgZG9fcmVnaW9uX3hhYmxlKHN0cnVjdCBjeGxfcmVnaW9uICpyZWdpb24s
IGVudW0gcmVnaW9uX2FjdGlvbnMgYWN0aW9uDQo+ICAgCQlyZXR1cm4gY3hsX3JlZ2lvbl9lbmFi
bGUocmVnaW9uKTsNCj4gICAJY2FzZSBBQ1RJT05fRElTQUJMRToNCj4gICAJCXJldHVybiBkaXNh
YmxlX3JlZ2lvbihyZWdpb24pOw0KPiAtCWNhc2UgQUNUSU9OX0RFU1RST1k6DQo+IC0JCXJldHVy
biBkZXN0cm95X3JlZ2lvbihyZWdpb24pOw0KPiAgIAlkZWZhdWx0Og0KPiAgIAkJcmV0dXJuIC1F
SU5WQUw7DQo+ICAgCX0NCj4gQEAgLTk3MSw3ICsxMDc2LDEyIEBAIHN0YXRpYyBpbnQgcmVnaW9u
X2FjdGlvbihpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIHN0cnVjdCBjeGxfY3R4ICpjdHgs
DQo+ICAgCQkJaWYgKCF1dGlsX2N4bF9kZWNvZGVyX2ZpbHRlcihkZWNvZGVyLA0KPiAgIAkJCQkJ
CSAgICAgcGFyYW0ucm9vdF9kZWNvZGVyKSkNCj4gICAJCQkJY29udGludWU7DQo+IC0JCQlyYyA9
IGRlY29kZXJfcmVnaW9uX2FjdGlvbihwLCBkZWNvZGVyLCBhY3Rpb24sIGNvdW50KTsNCj4gKw0K
PiArCQkJaWYgKGFjdGlvbiA9PSBBQ1RJT05fREVTVFJPWSkNCj4gKwkJCQlyYyA9IGRlc3Ryb3lf
bXVsdGlwbGVfcmVnaW9ucyhwLCBkZWNvZGVyLCBjb3VudCk7DQo+ICsJCQllbHNlDQo+ICsJCQkJ
cmMgPSBkZWNvZGVyX3JlZ2lvbl9hY3Rpb24ocCwgZGVjb2RlciwgYWN0aW9uLCBjb3VudCk7DQo+
ICsNCj4gICAJCQlpZiAocmMpDQo+ICAgCQkJCWVycl9yYyA9IHJjOw0KPiAgIAkJfQ0K
