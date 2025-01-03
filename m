Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF88EDDC1
	for <linux-cxl@vger.kernel.org>; Fri,  3 Jan 2025 06:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735886192; cv=fail; b=p4HTHtye/38CC5f/gYQV/YtOnl/YYD3ABN1XgP489g4BrwqFX0607stAUudU9znPkNGjadyXVp0gk9XX+FE9rgLxBtxXXahOCe9dmSFLeqGBDUaIXtXWR9iRAI/XXadeXoy9mkjWvsSnD/G85iKRQC3x0yruNcEpJKosIdjinVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735886192; c=relaxed/simple;
	bh=zVwtiVC2QJ2ys++pQqW4Q2tavq8+NYwHQzssvb6pFFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uAG64juB50iDiem5kUZ6h/0F+sxsu8zeLOuz2hnIW438vHiqZf0YY/m2c9Ew5g2shCE6AoefCGUM8Ph2QExd387WgEVt3G4Y7C3tlK6RDkvnIpXIjRt92jhXeu6JKww3YFhbBSle6pXUQC51euMv3F8AwAwJQ6AE24mokOtvdDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=r3HkUynD; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="r3HkUynD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1735886190; x=1767422190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zVwtiVC2QJ2ys++pQqW4Q2tavq8+NYwHQzssvb6pFFE=;
  b=r3HkUynDREwEU5aesy10vNQ8mP1EvfefpVIf8X7f4avdTUv3KctRp/EN
   9+S33ohecy7WzhoDXog6M5b24plJ1IhNN7R4y9rsecX+5+al2YpSNzvsv
   upHfP/E6BnkGwsLt25mT05LWkkTtx4bH54ds35wPZBi4Hpm6UI4XLywW+
   Uqabxe0H4omZlFWThttSc7RrexFBIjzCW38DF7t8kTaKv28e87N5lVC1+
   bJ2IhOYUlihjDBZfB0SIlszC+8mKdggH+NfnXOw2/VYkSihJtJ7ldjlsO
   EPUo9jKh5z9I12hYrXUIJ3umUTkXeEyaLWgAJNpgjwJVe7/Z1rdZnO/25
   A==;
X-CSE-ConnectionGUID: hgR8VCsLS7m5dUUnSgu8qw==
X-CSE-MsgGUID: GOjBdNWPSOedSn9zifoHSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="141398012"
X-IronPort-AV: E=Sophos;i="6.12,286,1728918000"; 
   d="scan'208";a="141398012"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 15:36:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEoznSly9n1Ne0WitOGyu1wxleniUmYLL/QfFHxVcN16sHQ8taOCW7mTUqETaQLbaTtLF7hwxWEvPsd99W5sAeSNueokp0h1MDBILDfIk99ZB3pOqWEgHam5d+uEHxCE1zV0ur7M0EQgCIlIhz0V2k2Z0szCszmAXfZXBgaIwA6uwZDHSF52X0fO1iZF8vFWDGMHVtyfRCpF64ipdVH3YwrmVQ3KND/y++s7Z1VUiwI2djnzza2/u2ZwUshE7/iBHUXZ1Pe9Ji+v6fJKk9+uH3lR++gyg8JSkzKXRQ8n4Gw/pbbcuI+1MJum3ZQMmdcQll79fm1OvhAt7O5UQ1E8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVwtiVC2QJ2ys++pQqW4Q2tavq8+NYwHQzssvb6pFFE=;
 b=hCI5xHhUz7Es4V3W5pC33v4J2wAfj6m784wxHGnv/gsWxSzmWRfBCTvowJUdVlLXUYBOpR8Psy+eJKN+hO7vsN1ILU+9/tv0Ks/ONwsmXaqkhmrWsuG8XcZ0pmT9WximDzeo+bL7EwkMJRD2RsslV+f0NU9FOf5tVCIAxSDZ+uJFFPuHj85SSaWAzroLnaiDqS9SDAsgQmMGwP5gADq+bsjvH6zlmsmR1PHV7m4MmTkEV90ZuJf9O0Q8IJSEUEJZ0rCcUbXdc+G450mkr32lpRl/R1Knin0sSos2IlF53lvYjIPI9+n3R6KOZAT38acw7CGeuQK8uYq0rSN4gy5p4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB5999.jpnprd01.prod.outlook.com (2603:1096:400:4a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:36:17 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 06:36:17 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni
	<fan.ni@samsung.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Thread-Topic: [PATCH v2] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Thread-Index: AQHbTUJy2+Bu04d+mESXzsaCQaFJ0bMEuQuA
Date: Fri, 3 Jan 2025 06:36:15 +0000
Message-ID: <af1c7e91-0f02-4b34-8048-ddf93b115523@fujitsu.com>
References: <20241213093602.3248246-1-lizhijian@fujitsu.com>
In-Reply-To: <20241213093602.3248246-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB5999:EE_
x-ms-office365-filtering-correlation-id: f08a1f0f-5a7e-489f-9b5e-08dd2bc0ec64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDJnOVFOZCtKSi9SWldFZkxzQ2E4SjR6bXhkYkxlMXZrbG9zTm1UcFpYVWFB?=
 =?utf-8?B?bjVQM0hVUEFXODVHbGdNdGphSDFxaWFlTy9uV1BzRE1LdkdFZjJrSmVnNUJD?=
 =?utf-8?B?OHBaTFFsSXdqbDJLcTJ2amYvMHBBTUZOSjdqYmNCQzhkSHV2T2J5N2cvM1FC?=
 =?utf-8?B?elNnUXplVzcvVUtoaUlTT0FrK3lETDFld0N0UVFBdDJJYkNHTkNqN0FJQlha?=
 =?utf-8?B?ZHNCdTYrZmFYZ1l4VnhPaC9QVnU5bHhwR2JvS1o4MVNMbmhJMG5qZFpxb2Rl?=
 =?utf-8?B?WjJ5OXlLdFhFOERjUlpsV1lja253Z3NVaGpPbEZab0x6UnEzVEg5STZYRG5y?=
 =?utf-8?B?dGY0SWE3SWFUejRXNXFscUVVVVlKTVJzQklNbGNDV2RJU0szcllDYklFaml1?=
 =?utf-8?B?MUJkZmlYSnlBV2Y2SC9rSitPYXVJYVhnTEx5OWJPTVZ2N0pjcHZvdzVnd01J?=
 =?utf-8?B?SkxtYkJQQXZoWFFXSW1lOW5tbTkvbVJEdGRia2k1RDhJdVl2RWZhRzd1NUd5?=
 =?utf-8?B?OVlsQ2RMQ0xlZWpYcUd5NnNOYURFaG5rWHV5dFpqb2hvRFhxWmppVFl5ZFpv?=
 =?utf-8?B?OW84TnF3WlI0TzZUMTBOcXRWWjFUOXJhL0YwRWZnbEMwS2lwNndMMWN3NW1u?=
 =?utf-8?B?YnBrZVhPUzBLemg4cHk4NWJ2SVNMRjJPMHUvTGYwSWpuSXcwQ2hiYWtGT1Ry?=
 =?utf-8?B?RlJTN3hhUXFIZUNkQ1pBRy81V2RZMTNUTmdBc1pBZldXNEJVQ3R4ZStRYTZ4?=
 =?utf-8?B?bHlQcHd4M0J3NnpqbEdNV1p3QkhCRnNFbTN3T2xkWSs0Z3RnSUltN0hTZDBT?=
 =?utf-8?B?NEVNYkJzYUE5cEkvWUk1R3YxM2JZM1FVMHhMWDMya25PbG5zZUwrZnR6c3NI?=
 =?utf-8?B?YnZDLzZpZFZiU2tYbGpncXp0ODE0bDhmOS8zRHo1ZlBjTERlZVJXdUJURVgv?=
 =?utf-8?B?ak9wZEhSU2JVUG1JdEJKSHkvTVdWRkpsYmpSRTVQSWVuSXdDeEVrODhKQkI2?=
 =?utf-8?B?Mm1IMEZkb2J0eWNac005UnRKb1Z2QzNnVUtEWGd4TzBmbWZabS93UDJ4OEpX?=
 =?utf-8?B?MmpCcVR0V2wxU25mTlB2b05WdXB0TGxvb1hybURRcEJubCszM1JyNlZydzFC?=
 =?utf-8?B?K01jckpkS21qYVpvNTdoeTVpa0xmeGRYdEd4VU5KT1Z1SnJnZEV3T1FkRjU4?=
 =?utf-8?B?enM5WGJVbEZqV2FoczZhSmd0Vm1jWk5LcnNiTlpjRTh3MUFTUHR2cUNwK1pj?=
 =?utf-8?B?SXdWWktSQ1JUQURQUTNrTUhUTnVkVC8zTTNBL1VtOHV6YWZxQmsrd2R3R29a?=
 =?utf-8?B?VXRCakNZRVNWdllmQUxnZEkzcDBkbkdYVmh5NVhCT3RIK3VTaWpHUlUvem5s?=
 =?utf-8?B?d1pQUmZ3MEpZQjRRMnBrcFRvTzlUY0dYK0lsM0ZSeXhhVzhjNGg2eFlrTVFv?=
 =?utf-8?B?U09DS3ZSM2oxRS82K1IzWXdEZGk4aGhFeUhQQmpQUVdyK3dRbDFVZlZMeFFM?=
 =?utf-8?B?RjlDZEVjM2l6aVJFbDZBS0RKVENydjEzNXdQWFlhdjM4R2g5ZFVnSjk4YTVW?=
 =?utf-8?B?M1AyejY1cFhROFI4ZXgzVmo4d0d4RHk0M0dQVHluckZjNy9qTXpXcUVGTmlk?=
 =?utf-8?B?L2ZqcVFHVmVhMkxGdjdPeitxakxtMElaNjhoS3pCaTRjQXl5OTg4UDB1UVVI?=
 =?utf-8?B?ZVR2SWRQckFhSU1CNXBnTE5mV1F5RVVqditZSnQyZXhnZ3BZZHgrdkJWSzBT?=
 =?utf-8?B?RXo4UGdNRlRjcjlMRzg3MVlvN2M5OHo4VWZTL0pTbUhjOXBYTDlzbTV4QU81?=
 =?utf-8?B?clVTQmxMRUtBbG56MXFRRDgyc3ZGZFcrSmdYWTVGY215RGp5M24rRDMzY0Y0?=
 =?utf-8?B?WmRNVVdHRG5IcWQ0cWpWakNPNTJja0NPNmQzRGNKUmhwMzZQekVEakc4K2FU?=
 =?utf-8?B?cFM1dENGZGl3dDVmK2gzT2Z4bGJYeFVXR1l3ZWJiQWtjOGRRMkVkZ2pZTHVC?=
 =?utf-8?B?ZHJYY0VheGd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDJkdFV6TFNrbDI1Vyt1T2lxMmNRejh5ckFaL21YL1Y1T3Rrd1hmaUZlQU1C?=
 =?utf-8?B?MWZDanlucE5YQVFCZ2IxYjJIaERTVzBmdWJtb0d6VXZpV1VmdTllNm15Tloz?=
 =?utf-8?B?WGF0elIyTXRxelhWTExELzd0QVdEZExTUlVIdElpNzYxbGRGM2s5U1dKdUNr?=
 =?utf-8?B?U0lTL2FhendkbU83WW0yaVpVVzFMamJvVE04OEF1VE9pZDQ0Sk1hdUVHMzFS?=
 =?utf-8?B?ZUdRL1Fwdmdjbnl3cVpSa2Z5RHlCR2RUS21YSCs3Vi9iRmNzVTNBOWtCMXNh?=
 =?utf-8?B?NXJhcGIvM0pUQUIxNmIydEJzdkc5aWxpQkpDYlVNNWdxZExiWHBCd3NkSGkw?=
 =?utf-8?B?TUljemlPaFl2ZU9LWCtaKzBrc2J4cmxFdTljQ204Z25JMEFFUWpyaG9jQVRo?=
 =?utf-8?B?SWFrYzJhdjFJRTY4UTkwMHJFcWFIa09jSnYyWFBUQ2ZZbkYxcWs3STJVL3FT?=
 =?utf-8?B?V2czQ3lDK0FncUtISFh3TXRPYU04Skk2S3A0OU5kS09QQTNiTTl4OTZpdE15?=
 =?utf-8?B?VFo0RUN3SGFFcDBqdUd6YnA2NkFreXphSDNVOG5sa1ZGSTZsR0Y2WmFZT21n?=
 =?utf-8?B?YXBEa1RMY0w1KzZpNExBYVFaenZHMDdqWkQ2Zk93bG1GeS94QTNWdDVpNHJQ?=
 =?utf-8?B?dm1HMnpUQnlTWEVvU01uZHNZaGV5bjRSVDVSdXFZU25LL0xNSlJNQ2lIQ1cr?=
 =?utf-8?B?TzYvK1lFRzRkOXRmQzkzYjZTTnBpWkswaHN3eVVXU1RsVmwrQndIaktiM0t1?=
 =?utf-8?B?NmhYTTZ2bEYwTEJldTB0Q1ozUFpGTWp1N2lUcWRMR3JyN0Qwd0VFTGhKcmpx?=
 =?utf-8?B?aXg1U2RuN21JemxibDZXdlFZaFdLbFJBSzk0eVdPc0xDcjhYTXdERWZuWkxU?=
 =?utf-8?B?aW5ZSXhBM0JYRWJqZm1tYWRXYTAwdUFVYk5KbXk0bzI5aVdaaU5uUm9BV2J6?=
 =?utf-8?B?cEN5Tm5TVVNUVnc3WXZ5SVJtb3RzR2VBbjZockhKQnBwZ1F4QjhwUkRvRkFF?=
 =?utf-8?B?bWJSZkJYU1BLbUx2S3JFVG9nWG5wL2c2bzAyM3BWdmR6OG9IbEFPM1hpNWJa?=
 =?utf-8?B?Tk9Oc2xNWnQ3Y05wNUlyU3hPd0hYMkJGcVRndWVpbGhGdjNWczFDQWJMaktF?=
 =?utf-8?B?M2ZRT2RJd3NrbExvMFM4TFdEQ01SYnRkT1BWeXZQMDJOTnliU29lMjNOdytn?=
 =?utf-8?B?V3ZrVllMaDhCN1JXcVl3Q1QyakRtbk5RTERjNVg0cGtaTWFMdjJOT2RHYnl4?=
 =?utf-8?B?NEZ4RXB5bW5IVi9mS3YxWTBIUkVzRmswRXZiZ0JIcm41MHJ3ZXU0OUltTklE?=
 =?utf-8?B?WlAxd2g3czhDSmFSbjQzSHpZTjhtc0MzbFpkWDBLckVtS3V4UGJmQ0xSdGZM?=
 =?utf-8?B?d3JZakpIZEx6WTQxbW00M3F5Z0FHTHAycUtKemVJa040Q2hzTEIrV2g2RmZi?=
 =?utf-8?B?TEJsdGlHcDAwcUt6UUYxYTkzMDdMT2xGaWtjbTB5bnZSUGdEeWpYYXRKZ3BS?=
 =?utf-8?B?ZitJV3M2TFNCTU1Zc0tyL0VSZGswN0dJTWl3TlY2SGRZVER5MHNlQWRDTXFj?=
 =?utf-8?B?WWtQaUJ0N1pjaXNHbW96T2dtNGl3R01GbDBZVDJYVTVsZUtyOXRNMnoyU3B4?=
 =?utf-8?B?NkhSNGFjVEhqWURuYmlMYzdFYW9JckZDU2pNL1lCdnVKU1ZDRFFndC9QZ1Jn?=
 =?utf-8?B?MEdualBxbi9wdCtMS3hndEdra1BrVTZiMTg1UU95Z3FwWW96U1BRYy9kUmJ0?=
 =?utf-8?B?L1RLSmRKYWJkQU9tdnRNWVFJaGJxWWpEajZaZnhycEU3UVNPN3pSSDVqcVhE?=
 =?utf-8?B?RCthaDk2dWppMk9CTTF1R2paM09hQlBGU3VmSDRXR1hDcG40dEpUR1FvYmNt?=
 =?utf-8?B?eHJacjFYRFpTZmxnMmdocHV0ZldwS3ZyUjVtWnQrblIyNUMxeWlORFRVanRW?=
 =?utf-8?B?eXNhbUJ0MHI0YWtpdGc4NHhhb1FZZjg2WXNvOUtHQk9DcndCZEVpQ3FLT0Vi?=
 =?utf-8?B?STFicXJjMEY1dVRsREJCV0VkSFZYbnZZbkF1SVVaT2tOVElGRUJuTmtPeHEz?=
 =?utf-8?B?ZUNjbEdHZzVQdHd0ZW9tYU91OGVib2thNU4zNlMwY3IzSEVQZEFuZlFCWDds?=
 =?utf-8?B?ZnAwd1RrTFdIUHVZWUtydmVYb3hJQUR3Y1VmRmhYdysvZGVsUlU4UllXL2Rl?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1BB2B31BAE4E64DB03CE419F94E03B2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	13lKtR8Uxxxr2KVPlwRP9X9VgvNy20clc9ou7GaO4QJGStbDBxwkFgaTJn/GyuHh+wDVixkIeSjsVVp1f2F8yKOdCPBZ+NCq4lzdSZbU982bQyGv9xP+6BWx+9ggwRU3vzidIDl8lf29BeJQX40nvMkJXz/ryjjXr0TZ/v7uQrVGZAGUbk+mjHrBYwkq5HA745wbeE7WzT9zyCti8ckMOz2vftrMrqxr2ciIJsKPZIlDjL9xzWKGHmyOY+4f0XAGTWbwCZjirqNZqzbRfTqJp5yL7ivleitgB8cyVQaWxDwgBRaf8DcNdWiHs9UzUwgLzxXgbCLgcOLSwatgn4TqgZNhtqwdUeRYOSRUek5ug/1LgSPz9w8tDBVTj0nhnOP+Q7IzvDNvUvMcAfhqzy8PH2sezE27eQXwmkc/t14emQA6kiKRklVrwFMYfdH0dtKuFNgBbLaCqqs9OhqSTCCxSH8XMrg84tSiSNzucdotXhZSTL0vtHd4Fdq8wUjQDzqnjlIWKT2UfpjLXRIidrtvgg30Sd9pzyMS9WVO17QsSmbB1LlThC6KteaFHprdhxWizXUdEXaM5DDjg3d8+uM3NsX5rPU2ZIu5kXH4oJq8MELc27gkDOnxbtUKsZn3ktpD
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08a1f0f-5a7e-489f-9b5e-08dd2bc0ec64
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 06:36:15.5938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7DoiPN5CeMynYtviZDa/IaWQxYH7uUWWAd4F8lrZwZnkmhQbYPsiie3xdjhU5pEDn5p66Agvxw0xbnaHDioXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5999

DQpNZXJyeSBDaHJpc3RtYXMgYW5kIGEgSGFwcHkgTmV3IFllYXIhDQoNCkFuZCBraW5kbHkgcGlu
Zy4uLg0KDQoNCk9uIDEzLzEyLzIwMjQgMTc6MzYsIExpIFpoaWppYW4gd3JvdGU6DQo+IFRoaXMg
YXNzZXJ0aW9uIGFsd2F5cyBoYXBwZW5zIHdoZW4gd2Ugc2FuaXRpemUgdGhlIENYTCBtZW1vcnkg
ZGV2aWNlLg0KPiAkIGVjaG8gMSA+IC9zeXMvYnVzL2N4bC9kZXZpY2VzL21lbTAvc2VjdXJpdHkv
c2FuaXRpemUNCj4gDQo+IEl0IGlzIGluY29ycmVjdCB0byByZWdpc3RlciBhbiBNU0lYIG51bWJl
ciBiZXlvbmQgdGhlIGRldmljZSdzIGNhcGFiaWxpdHkuDQo+IA0KPiBFeHBhbmQgdGhlIGRldmlj
ZSdzIE1TSVggbnVtYmVyIGFuZCB1c2UgdGhlIGVudW0gdG8gbWFpbnRhaW4gdGhlICpVU0VEKg0K
PiBhbmQgTUFYIE1TSVggbnVtYmVyDQo+IA0KPiBGaXhlczogNDNlZmIwYmZhZDJiICgiaHcvY3hs
L21ib3g6IFdpcmUgdXAgaW50ZXJydXB0cyBmb3IgYmFja2dyb3VuZCBjb21wbGV0aW9uIikNCj4g
U2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiAtLS0N
Cj4gVjI6IGp1c3QgaW5jcmVhc2UgbXNpeCBudW1iZXIgYW5kIGFkZCBlbnVtIHRvIG1haW50YWlu
ZXIgdGhlaXIgdmFsdWVzICMNCj4gSm9uYXRoYW4NCj4gLS0tDQo+ICAgaHcvY3hsL2N4bC1kZXZp
Y2UtdXRpbHMuYyAgIHwgIDYgKystLS0tDQo+ICAgaHcvbWVtL2N4bF90eXBlMy5jICAgICAgICAg
IHwgMTAgKysrKystLS0tLQ0KPiAgIGluY2x1ZGUvaHcvY3hsL2N4bF9kZXZpY2UuaCB8ICA3ICsr
KysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvY3hsL2N4bC1kZXZpY2UtdXRpbHMuYyBiL2h3L2N4
bC9jeGwtZGV2aWNlLXV0aWxzLmMNCj4gaW5kZXggMDM1ZDAzNGY2ZC4uYmMyMTcxZTNkNCAxMDA2
NDQNCj4gLS0tIGEvaHcvY3hsL2N4bC1kZXZpY2UtdXRpbHMuYw0KPiArKysgYi9ody9jeGwvY3hs
LWRldmljZS11dGlscy5jDQo+IEBAIC0zNTQsOCArMzU0LDYgQEAgc3RhdGljIHZvaWQgZGV2aWNl
X3JlZ19pbml0X2NvbW1vbihDWExEZXZpY2VTdGF0ZSAqY3hsX2RzdGF0ZSkNCj4gICANCj4gICBz
dGF0aWMgdm9pZCBtYWlsYm94X3JlZ19pbml0X2NvbW1vbihDWExEZXZpY2VTdGF0ZSAqY3hsX2Rz
dGF0ZSkNCj4gICB7DQo+IC0gICAgY29uc3QgdWludDhfdCBtc2lfbiA9IDk7DQo+IC0NCj4gICAg
ICAgLyogMjA0OCBwYXlsb2FkIHNpemUgKi8NCj4gICAgICAgQVJSQVlfRklFTERfRFAzMihjeGxf
ZHN0YXRlLT5tYm94X3JlZ19zdGF0ZTMyLCBDWExfREVWX01BSUxCT1hfQ0FQLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgIFBBWUxPQURfU0laRSwgQ1hMX01BSUxCT1hfUEFZTE9BRF9TSElGVCk7
DQo+IEBAIC0zNjQsOCArMzYyLDggQEAgc3RhdGljIHZvaWQgbWFpbGJveF9yZWdfaW5pdF9jb21t
b24oQ1hMRGV2aWNlU3RhdGUgKmN4bF9kc3RhdGUpDQo+ICAgICAgIEFSUkFZX0ZJRUxEX0RQMzIo
Y3hsX2RzdGF0ZS0+bWJveF9yZWdfc3RhdGUzMiwgQ1hMX0RFVl9NQUlMQk9YX0NBUCwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICBCR19JTlRfQ0FQLCAxKTsNCj4gICAgICAgQVJSQVlfRklFTERf
RFAzMihjeGxfZHN0YXRlLT5tYm94X3JlZ19zdGF0ZTMyLCBDWExfREVWX01BSUxCT1hfQ0FQLA0K
PiAtICAgICAgICAgICAgICAgICAgICAgTVNJX04sIG1zaV9uKTsNCj4gLSAgICBjeGxfZHN0YXRl
LT5tYm94X21zaV9uID0gbXNpX247DQo+ICsgICAgICAgICAgICAgICAgICAgICBNU0lfTiwgQ1hM
X01TSVhfTUJPWCk7DQo+ICsgICAgY3hsX2RzdGF0ZS0+bWJveF9tc2lfbiA9IENYTF9NU0lYX01C
T1g7DQo+ICAgICAgIEFSUkFZX0ZJRUxEX0RQMzIoY3hsX2RzdGF0ZS0+bWJveF9yZWdfc3RhdGUz
MiwgQ1hMX0RFVl9NQUlMQk9YX0NBUCwNCj4gICAgICAgICAgICAgICAgICAgICAgICBNQk9YX1JF
QURZX1RJTUUsIDApOyAvKiBOb3QgcmVwb3J0ZWQgKi8NCj4gICAgICAgQVJSQVlfRklFTERfRFAz
MihjeGxfZHN0YXRlLT5tYm94X3JlZ19zdGF0ZTMyLCBDWExfREVWX01BSUxCT1hfQ0FQLA0KPiBk
aWZmIC0tZ2l0IGEvaHcvbWVtL2N4bF90eXBlMy5jIGIvaHcvbWVtL2N4bF90eXBlMy5jDQo+IGlu
ZGV4IDVjZjc1NGIzOGYuLmYyZjA2MGVkOWUgMTAwNjQ0DQo+IC0tLSBhL2h3L21lbS9jeGxfdHlw
ZTMuYw0KPiArKysgYi9ody9tZW0vY3hsX3R5cGUzLmMNCj4gQEAgLTg0Myw3ICs4NDMsNiBAQCBz
dGF0aWMgdm9pZCBjdDNfcmVhbGl6ZShQQ0lEZXZpY2UgKnBjaV9kZXYsIEVycm9yICoqZXJycCkN
Cj4gICAgICAgQ29tcG9uZW50UmVnaXN0ZXJzICpyZWdzID0gJmN4bF9jc3RhdGUtPmNyYjsNCj4g
ICAgICAgTWVtb3J5UmVnaW9uICptciA9ICZyZWdzLT5jb21wb25lbnRfcmVnaXN0ZXJzOw0KPiAg
ICAgICB1aW50OF90ICpwY2lfY29uZiA9IHBjaV9kZXYtPmNvbmZpZzsNCj4gLSAgICB1bnNpZ25l
ZCBzaG9ydCBtc2l4X251bSA9IDY7DQo+ICAgICAgIGludCBpLCByYzsNCj4gICAgICAgdWludDE2
X3QgY291bnQ7DQo+ICAgDQo+IEBAIC04ODQsMTYgKzg4MywxNyBAQCBzdGF0aWMgdm9pZCBjdDNf
cmVhbGl6ZShQQ0lEZXZpY2UgKnBjaV9kZXYsIEVycm9yICoqZXJycCkNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAmY3QzZC0+Y3hsX2RzdGF0ZS5kZXZpY2VfcmVnaXN0ZXJzKTsNCj4gICANCj4g
ICAgICAgLyogTVNJKC1YKSBJbml0aWFsaXphdGlvbiAqLw0KPiAtICAgIHJjID0gbXNpeF9pbml0
X2V4Y2x1c2l2ZV9iYXIocGNpX2RldiwgbXNpeF9udW0sIDQsIE5VTEwpOw0KPiArICAgIHJjID0g
bXNpeF9pbml0X2V4Y2x1c2l2ZV9iYXIocGNpX2RldiwgQ1hMX01TSVhfTUFYLCA0LCBOVUxMKTsN
Cj4gICAgICAgaWYgKHJjKSB7DQo+ICAgICAgICAgICBnb3RvIGVycl9hZGRyZXNzX3NwYWNlX2Zy
ZWU7DQo+ICAgICAgIH0NCj4gLSAgICBmb3IgKGkgPSAwOyBpIDwgbXNpeF9udW07IGkrKykgew0K
PiArICAgIGZvciAoaSA9IDA7IGkgPCBDWExfTVNJWF9NQVg7IGkrKykgew0KPiAgICAgICAgICAg
bXNpeF92ZWN0b3JfdXNlKHBjaV9kZXYsIGkpOw0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIC8q
IERPRSBJbml0aWFsaXphdGlvbiAqLw0KPiAtICAgIHBjaWVfZG9lX2luaXQocGNpX2RldiwgJmN0
M2QtPmRvZV9jZGF0LCAweDE5MCwgZG9lX2NkYXRfcHJvdCwgdHJ1ZSwgMCk7DQo+ICsgICAgcGNp
ZV9kb2VfaW5pdChwY2lfZGV2LCAmY3QzZC0+ZG9lX2NkYXQsIDB4MTkwLCBkb2VfY2RhdF9wcm90
LCB0cnVlLA0KPiArICAgICAgICAgICAgICAgICAgQ1hMX01TSVhfUENJRV9ET0UpOw0KPiAgIA0K
PiAgICAgICBjeGxfY3N0YXRlLT5jZGF0LmJ1aWxkX2NkYXRfdGFibGUgPSBjdDNfYnVpbGRfY2Rh
dF90YWJsZTsNCj4gICAgICAgY3hsX2NzdGF0ZS0+Y2RhdC5mcmVlX2NkYXRfdGFibGUgPSBjdDNf
ZnJlZV9jZGF0X3RhYmxlOw0KPiBAQCAtOTA4LDcgKzkwOCw3IEBAIHN0YXRpYyB2b2lkIGN0M19y
ZWFsaXplKFBDSURldmljZSAqcGNpX2RldiwgRXJyb3IgKiplcnJwKQ0KPiAgICAgICBpZiAocmMp
IHsNCj4gICAgICAgICAgIGdvdG8gZXJyX3JlbGVhc2VfY2RhdDsNCj4gICAgICAgfQ0KPiAtICAg
IGN4bF9ldmVudF9pbml0KCZjdDNkLT5jeGxfZHN0YXRlLCAyKTsNCj4gKyAgICBjeGxfZXZlbnRf
aW5pdCgmY3QzZC0+Y3hsX2RzdGF0ZSwgQ1hMX01TSVhfRVZFTlRfU1RBUlQpOw0KPiAgIA0KPiAg
ICAgICAvKiBTZXQgZGVmYXVsdCB2YWx1ZSBmb3IgcGF0cm9sIHNjcnViIGF0dHJpYnV0ZXMgKi8N
Cj4gICAgICAgY3QzZC0+cGF0cm9sX3NjcnViX2F0dHJzLnNjcnViX2N5Y2xlX2NhcCA9DQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2h3L2N4bC9jeGxfZGV2aWNlLmggYi9pbmNsdWRlL2h3L2N4bC9j
eGxfZGV2aWNlLmgNCj4gaW5kZXggNTYxYjM3NWRjOC4uM2Y4OWIwNDFjZSAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9ody9jeGwvY3hsX2RldmljZS5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvY3hsL2N4
bF9kZXZpY2UuaA0KPiBAQCAtMTMzLDYgKzEzMywxMyBAQCB0eXBlZGVmIGVudW0gew0KPiAgICAg
ICBDWExfTUJPWF9NQVggPSAweDIwDQo+ICAgfSBDWExSZXRDb2RlOw0KPiAgIA0KPiArZW51bSB7
DQo+ICsgICAgQ1hMX01TSVhfUENJRV9ET0UgPSAwLA0KPiArICAgIENYTF9NU0lYX0VWRU5UX1NU
QVJUID0gMiwNCj4gKyAgICBDWExfTVNJWF9NQk9YID0gQ1hMX01TSVhfRVZFTlRfU1RBUlQgKyBD
WExfRVZFTlRfVFlQRV9NQVgsDQo+ICsgICAgQ1hMX01TSVhfTUFYDQo+ICt9Ow0KPiArDQo+ICAg
dHlwZWRlZiBzdHJ1Y3QgQ1hMQ0NJIENYTENDSTsNCj4gICB0eXBlZGVmIHN0cnVjdCBjeGxfZGV2
aWNlX3N0YXRlIENYTERldmljZVN0YXRlOw0KPiAgIHN0cnVjdCBjeGxfY21kOw==
