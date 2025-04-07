Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6DF156CA
	for <linux-cxl@vger.kernel.org>; Mon,  7 Apr 2025 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743994839; cv=fail; b=qbUL2KWxK/wLKAkF4tMennopajsWC9HE1W9anJUiIh9VSBIVBGUU/xaq9DfxpqxpFm5m3vE1JmYrVpvKJ+y9C1AEueLBFvGvkhF3/ivXDcfqBCHt8zSJlT54LmzEXCkUStow8tkxcK6e7vMve+96Fqc/PYPry2aMEU81Fo9JhdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743994839; c=relaxed/simple;
	bh=N+HUXMeDL7CA+ktjmorF9MK2o7pyexYzhsutluREUm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JAHEj3vrH+KKj+zDQH19hLET8zfaQlF8ZnRcNMquQz7Tzdp8SKV3fEuzLWE0HTeEjWD/WZtVh9KreIOIzndOnIxaU6f6RqJvKXVOX6TQx9uhBLls+Y7RtqL/Mpyd/zUwIcjIOSbsuTieQ8/ooQUDfJ0NaS7EL3Zty7aG6AsVEUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kqeQmThb; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kqeQmThb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743994836; x=1775530836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N+HUXMeDL7CA+ktjmorF9MK2o7pyexYzhsutluREUm8=;
  b=kqeQmThbUXINTRAnXKL2lK8/LN+Ook5ObjxPC1yfVnU2z+7+3rqLOpef
   YNVL2DET/lISx3dW6Y8uCibOl2l7giLaG3B2ogcW555Qd14Dz4nC5b3mg
   cens4h5ywtYFC8wz+v5Mt+AaTe9B8kWTtLi5hpgv5D2ZAuf+2FTp1z9xS
   GpNhLql/0xnpii4QhvPsZ+B4y++tqy8YTHlrINKJgUVFAnH7VwuSMkP1l
   CTnajjeSD9Xm2nOMPeIgo70nn+1Arz5LDGnPfAWsGp9LKGOheAxERMUN4
   mkjPUrBLemoVm9v36jk+p/Gefx2ThmmM7oXzDohf79m7yTrLh3qK/cllU
   w==;
X-CSE-ConnectionGUID: MKA8Ixk3R+C749uugXkdow==
X-CSE-MsgGUID: z/wVtgsQQc+4eQypsnThTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="152401761"
X-IronPort-AV: E=Sophos;i="6.15,193,1739804400"; 
   d="scan'208";a="152401761"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:59:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4wHjXxnxP6p1vHfZn8o9X8jS5Qq2kdvZbumE099gdYv/+UE69e9urip/u57hE5/mysZ3v+CA7sZmcKoKzl8HMiZ+FjAi2EV9krrE9WZFLE6knDL2PcHjgQYxFLzugv8N44pJxzTD1C76mcJ2fAtoLJLH30uan2j1nEJwcyNudCtDm4SgZg3UoVwUMkzRJ217oYBqv205ysrjaKo5SHR348vozwQyBI9d1pvKIeNbpNDPsl03uh7wZPVua35SP4Q+d1gayueeC+Za3JaGOBOzvrCQbGo3tTzZhMtaQyeBwGK3nOxCp8aQI30OfWhVQNEJek9hl55Z23ORgzeC/pu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+HUXMeDL7CA+ktjmorF9MK2o7pyexYzhsutluREUm8=;
 b=mxQlnBt+SwnMKU7huRNEnpFSABevzCVH+2Wti/ha6aQHHLBL8fejtEZdMe8aA093Lt8Hdbdudxbf8cB5efc7D26KGQgi7cL6G9cLXjVJtM1Wo8d11OqY3S42Twfpy0Yyb9PtT1L2AsxklDDghbm589vx02amlqqJGklYdQeCChVWyqm72bHl5F37vp9nPpw15Yn9gNc8JlVsyS4WsRf2G7f7JCLfzcxhWykUgRXs7G75vBa45gtQCYDI3VuNDO873PNUR/B/b44rn/CiIa9EWx/OsdeVC4S1c9mt042LcIz3FFo73FFNXg/G8ONOPwMaZ3nFaLmGsUySmAu0cAFJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY7PR01MB14992.jpnprd01.prod.outlook.com (2603:1096:405:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 7 Apr
 2025 02:59:21 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 02:59:21 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
CC: Fan Ni <fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/pci-bridge/pci_expander_bridge: Fix HDM passthrough
 condition
Thread-Topic: [PATCH] hw/pci-bridge/pci_expander_bridge: Fix HDM passthrough
 condition
Thread-Index: AQHbm8o0B9htuAj4zE2+ObG4bZ08ZbOXmoiA
Date: Mon, 7 Apr 2025 02:59:20 +0000
Message-ID: <e2933a3b-7600-4f84-bfa9-d7b59dafb939@fujitsu.com>
References: <20250323080420.935930-1-lizhijian@fujitsu.com>
In-Reply-To: <20250323080420.935930-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY7PR01MB14992:EE_
x-ms-office365-filtering-correlation-id: bf4b67d2-afb3-4b7f-2047-08dd758031ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?di8wV0F2SUpNemJaUHY5azVmSVMzeXBHWldQbXVhbkxsSDVtaldOL3piWWVz?=
 =?utf-8?B?cWJXUldLR2dDSXV1Wk9uV1JaVXJQU3lxSWFpZjJON1crUWZPNFNteW8rZ0xQ?=
 =?utf-8?B?UlpUckZlOGlGajdGbDVGUFgzS0JrR2ZHYURjdm92U2FFcXdzR3ZaNUF6SmN4?=
 =?utf-8?B?TU0xcTNsYUY3clpCUHdBcjBxbktidGRhY2RNdWEwc2NEblhFMjE0WWRwcEly?=
 =?utf-8?B?cjJBS1pwSWROeTVVelc5a3hrYjg2NHF6SkxQM0pVL2t6R2N5V0ptVFhMUitE?=
 =?utf-8?B?TnFIUkRkbUsvOXFMdC8xZmVLNkNJNnBESDVkWTBOb1Jkc2J0KzZyRXFnTFV5?=
 =?utf-8?B?Q0pZQ1dnMkNzUFo1K2crMERrREtmUVF6a0U3M1NFbUpFcHJ4dVFBaEFlRHJa?=
 =?utf-8?B?WHpyNXc5MnlxWHV0N3VwbmtPd0I3Y214WGtWeEdibzFlRDdhRStrbVNOTFRO?=
 =?utf-8?B?Y1lXKzlPTkhKWXRlNGszaEFkWjBYYXM4bXNBeGVCejRrZnk3dXFrVHhPSk5i?=
 =?utf-8?B?NlU5dElNZTFHREErY2RMSEFnUU8xOHVNbFRzZjRjQ0kyd2F3aVMzcUxPdWVv?=
 =?utf-8?B?OUV5OU1WVVdXRFplSHUzZnVHc2JKZXErVFFPaUtoRGg1Smh4K25OTVlRallW?=
 =?utf-8?B?dHMyNVpwRW9URTBCWC9Jb2RCYjNtek0vTVFBb3RMUWpaZWVjMk1aZHdNbDBl?=
 =?utf-8?B?UEJsY0dmZlAwV3pXVG4rWGRUbWhsZE91Y1FLbzhjNGNsM0xwd3RRRmg4dGZI?=
 =?utf-8?B?TDBaY1VXTk91UGRpbC9xRzhCQzdyZTJ3d2dMYXEzUEZ2N2RnQkMyeE1ickNZ?=
 =?utf-8?B?VHJKQ01mL1RhcnlZVkx2SFBLdDBEL0JxeThac2dyOFp3UjV4emRNcjdPYXEz?=
 =?utf-8?B?OEJZNE5GV2RTWm9ydFhwelpMMEFOTTZBZjU1TnF6OHh3Ykx4UHZET2tVeUZv?=
 =?utf-8?B?dHovOC9QOHZ1VEY2Z1Z5VmpRVmpRK0FSTWRxR2s3Smt4SnFHbTFGeUR2SjQv?=
 =?utf-8?B?ZU4ramljWWFzcEl4TTgxOFAydG91RmZTb0RacnN2QnpqejJvdkxua29HVExM?=
 =?utf-8?B?K21GcEtsdU9ST25nYzc4N3plckxLazZZMWdxVkJOaFF4bElZbGEyWE44SVR3?=
 =?utf-8?B?VzVjTUl5QWdxZStxczNOMHFRaUtlY0xGand4bmhpS1NNSE56bVR3UTNkQldJ?=
 =?utf-8?B?U3hrVlcyMDhYaEZKT1FHdlhHQ3I5U25KMXZPQTIxQWRpbzBNN3ZsdEltSDNv?=
 =?utf-8?B?TlExZjZMOW4rYVFWdUprR0RrWjhBRE4rOXpwdG0wQnZGeFg3UG8xdlk5WjdU?=
 =?utf-8?B?bjlZbkUxOFNibEkrZ1F1QmV0WWJtbW9qR2pEcnR2cUJJVkRDU0huN2lpMkVD?=
 =?utf-8?B?RUl3anFPU1FTNWhodXdoaFRENjVEazlQVndvMkptakRVZ1R1YkgrUjNMN1dh?=
 =?utf-8?B?MW1kak15SmhsbjBSN3lBYlg5MFRKcEFFRyt6eFBncS9XM0FJTStqSXFjKzJv?=
 =?utf-8?B?bHhIUFhKc0Z4OWt3Ny96LzJSeE1vRkd5c1JYbDN2Uk1CbHgybGpWMVYzakxP?=
 =?utf-8?B?YUZWVVBmNzRBamN6dCtqSFc4SEFDOHN1bkR0Vk5UWVcyN3drR3BnY3RtWVdJ?=
 =?utf-8?B?czR1WlRtV1lQcmdUK3k0WlN2UFQyMUJmbEE3aGpETnNHUjZRS1dKSGZ6ZTYw?=
 =?utf-8?B?R1lJUzVzN0tNZEhiQzYwemNRNjZYN05pL09QUmNzRENpS2VkbXpyVGRLK1lt?=
 =?utf-8?B?bDU2Rjl6QjJGZ0ppcStHc04zY0JNRGhwYXE4Q0lnSm8yV1V6YXVzeUhsREhj?=
 =?utf-8?B?R2N0WkQ5dTJpVUFGNTBPMTd5SG5zTkNDYXcvenNEU0F5ZXZkMm9sWnJJZmFH?=
 =?utf-8?B?a3NORjRxMCtaWDhRem9ORnJ0b0NUMk4yQ3BaU3NRbEZrQ3haOFRFcnU5MUt6?=
 =?utf-8?B?UEh1NmlKR29QVk5IdmhIYmhVL3p3MGdsbjBKZ1prTVpOM2FLR1lTWXNUdWgv?=
 =?utf-8?B?Tld4QVREVGZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUthVEpHdExWbjg4aTVLTkdMbndpZ2NUbUFPbjk3aUdqZkQrbjE4L0dZVFJO?=
 =?utf-8?B?eTQ1bm96WkJzQTl2dUJST3U4M2cwK0FicEFrTHBVd01yWHhhUkdOY3IxZStV?=
 =?utf-8?B?V3oyZlAzZGNGU01mYzh6aGJTZ3NqZmQrd1lvMjlvaS9KRDhxSXNQT2VScnc2?=
 =?utf-8?B?SDFQS2ZmY3p1WmZBdDh6YXpUeVFUSHBJNXQ0OEZJaU1VOW1tUjBmVFZPY2JL?=
 =?utf-8?B?REZhcnZiTXBFY0pXZ25jczUrN0d0dVU0STJzQks2clpEK1NZYlNaRW15TGVu?=
 =?utf-8?B?anAyWnNWWmxnUHNQU0NRcFJHOUdQU1B1d1NIb2l1cFpXQzg3MVVDUzZQOUdv?=
 =?utf-8?B?Y0N3bWlySTJzaGZURzRKN2k1YWk4RGR2dm9QaGRLOWsyd1ZXQ0V4SkNrOVFC?=
 =?utf-8?B?c3dNRVlxU3IwTVlERWEyd1pTbEFIUENXVE5McnRkeEhmbVp4TVFKRjgwOCtW?=
 =?utf-8?B?SlZRU1pkS0dYZC9VZmlnWS9HVXlGNm10eGpyc2V2U2dBbElPNFpnTllpbjJY?=
 =?utf-8?B?RXZGanNhQmpvZHhZY0NSK1ptNXNzM2p5d2NsTnVZY2daK0M4NDZIdWd4SHM4?=
 =?utf-8?B?WUx4TzZ4eGptbkRKT050VGVGdDlhOFdad0RkR0ZoeDhLRmxhdUlxYzZvTjc4?=
 =?utf-8?B?eXA0QXM5TmQ0VWU3Uzg1c1kxTTh1ZjhBeXBaRWpFL0VlazYra2N0ZWdGSjdB?=
 =?utf-8?B?N1dSS3ZFNFJhd3B0cTY2RDUrRStsM1lJVVBTbzB5bjA4NG9IZDVvUERnU3dt?=
 =?utf-8?B?eUFmNkEwSDFSczNETVRxWHZTZnJYQmtuMGRCZStobVVGMVM4a2NwMG9RSGN6?=
 =?utf-8?B?M1dna01XOVF0VlJwVzV4ckloL3I1a0NKK3M3d1oxNmZMSWVtV3JRQVlGRzl5?=
 =?utf-8?B?NVpiWFNtZmhzTi9uMVJQcXlETy81VkUrSWlOeWIzalJBVXJWUW1HakpUY0Jr?=
 =?utf-8?B?Y0dIcCtWaGd0emJXSnVocjEyYlFlbC90bzlQNDRvWXhjSnR3cU1jVmloZmVE?=
 =?utf-8?B?eUkxdnd6anc0NFBDaVp2N3BXa2lQRlZBbXp4VVRxbXVHUWJ2S0VFWThUMzd2?=
 =?utf-8?B?dUxFZGQxa0dUeFNJQkxiQWdGMG1yUVdVRHczMjlJUmNYZyt1K1Yrb1FhTWlt?=
 =?utf-8?B?eml0UzViRDdZR1c2T0RvS1h4L3N2dnUxSWFPYjBkSTlSN284VnZvWE44eEVO?=
 =?utf-8?B?UW9kTW80UzVwbUVXeGwyL1ZwSndHeWNGbmlkTkdPWlVaazQzMG53TC9IUVVm?=
 =?utf-8?B?NDBTZU82QUxZUEJubmhjanFUY2c1a0cyT3dFdEovN3B1cWMzT1VaRlBrcEp3?=
 =?utf-8?B?b2ExQm91eGJuQisvS2JuMXJBKzlIRW5GUE5JdVR6ZFlNbUJMdS9qd1ZWWmNP?=
 =?utf-8?B?b0VLT01NTWpzL0kvNVhVT2tMck12aHY1RENLdGlJOGlOa2VCZVRHWkZ6Undj?=
 =?utf-8?B?TEUvaUcySUlNSzRORXlFZE9pTkI3ZFhobmU4Q095Y2F6SnY5Yys2SGIySFlX?=
 =?utf-8?B?UUNMdkdPclpsdVl0TmhGb1dNVFNpV2ZIdTA3c3ozWVpkWTNDTWtjRytoK05q?=
 =?utf-8?B?OWsyU2grdTAwTU8xTU1GRkFPS05qS1FFdTliUDRvQ0NMQmRKL2xTL3l6NGtt?=
 =?utf-8?B?RmFzbWowQUtPU0JTNC82NmVnU2d6a3Y1aUZxMGNWT3UvcXkxdVNGNng0aTg4?=
 =?utf-8?B?NHdmZXVHNE9Rbll4Y3BjK0VsYTBXWW9kOWZqby9wRFlzTko2TW16V2ZMN25q?=
 =?utf-8?B?Vi9JWnJVbC95a2ttQ1FSbXAreElZYnR4bEJjQUJFYVJreHVjVzA2QTR2ZE9m?=
 =?utf-8?B?UzdzbVQreXhueEdydkhVcEdPWXpXOTFkMk9GTVpoa0NQWU84RjBhdDB5Y1FM?=
 =?utf-8?B?dUhSK1VpRlVCVFhoUkJ1YmsyVndNRkRhUThIRnh2dDF6K0FMaXo5QjR0NGNa?=
 =?utf-8?B?Mk9GendkVitmZVYybFYrbkdJNnkzNngrS3daQVNlYi8vM3I2aUVadFpPTGZU?=
 =?utf-8?B?NUVIUjV1aHU3WjJ5VytYeVdSUHBnaUxlS3Z3N1pCMUYzWmVWWHl6T3pjVGdK?=
 =?utf-8?B?NWlHSHFXNStMVk92TzBoZWNEVnNkbFdXZkNFcnVGMzNGSmwyK2FxRW1sczhS?=
 =?utf-8?B?bHZDenJFZ2EvTkVvZDhYVG5GZkp2RlF4VnE2UUF2OWZxcTlZcWE4MXpFWlpT?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D8D32B36ECFF349A7695BD7F860695A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TsbyvR8REGwnTOECuhl0ZvfESGxlDF4N9D7XRVFMSjfZohCxxGPAK3COZTQlxv9sKZ/ilkhLe/Gda3R4LQdREboCvb21Eyc4jpd/ulvLxetETwbxd5B1gGRG2n+fk6myWlpvrCyote3ZSjJ27Pd0bGUsiFY7PNKVZyubSCro/h1EJkPJBFkEgtr5ljFwwW/q6dJ00SW8ctahZjziZSkf13MSd61QZoxUDAVTlY7H9DCoGlXspNCadhVUfJasL6TFpFBrKczj9u1jsJyJBL6x659rNOq0nuJFkXeVaTG01jbYOGYJXDvBsRZ+oODq8kylt+wHEEJ9gjFmW9nWLMNRolxsjQGRrm+fbfwdTG7WeGEEE+BCJ3gMNNMgddUlmIdQ2HtULuN6ei4VqaqI9TaK9w+G6zXuGuAmnAWrzMraVsqz4x6XEXkcF8pZ5FGneFXu6i1ZWEJgriEWgDk1dPlSKQNWLwytgqlcaPkKZjeFoW7NPGQ4dRqx+oO25eXdR7ZZTHLm039z03k8gy+50CY6osYyJtfMLdjqVIy1dyVCm8trY9S1jInuaHWgEa6cPNibN0mkHpJwXiu+uS/MaBj/wc1r+6Twbg+gkyOcTmWdEPwHE1C2aXhOM3vr30zUtHo5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4b67d2-afb3-4b7f-2047-08dd758031ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 02:59:21.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0dAn1w0UjPKFFWijCEeus7PR1bCWAhpnQY3FzYYm/E/nIpj8ZP9bmF/2r9Vby9xSK13hrgE0Fx6txIwhZ+sgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14992

UGluZw0KDQpPbmx5IGlmIChkc3BfY291bnQ9PTEgJiYgaGRtX2Zvcl9wYXNzdGhyb3VnaD09dHJ1
ZSksIHRoZSBRRU1VIHNob3VsZG4ndCBpbXBsZW1lbnQNCnRoZSBIRE0gZGVjb2RkZXIgZm9yIHRo
ZSBIb3N0LWJyaWRnZS4NCg0KQnV0IHByZXZpb3VzIGNvZGUgZGlkbid0IGZvbGxvdyB0aGlzLg0K
DQpUaGFua3MNClpoaWppYW4NCg0KT24gMjMvMDMvMjAyNSAxNjowNCwgTGkgWmhpamlhbiB3cm90
ZToNCj4gUmV2ZXJzZSB0aGUgbG9naWNhbCBjb25kaXRpb24gZm9yIEhETSBwYXNzdGhyb3VnaCBz
dXBwb3J0IGluDQo+IHBjaV9leHBhbmRlcl9icmlkZ2UuIFRoaXMgcGF0Y2ggZW5zdXJlcyB0aGUg
SERNIHBhc3N0aHJvdWdoIGNvbmRpdGlvbg0KPiBpcyBldmFsdWF0ZWQgb25seSB3aGVuIGhkbV9m
b3JfcGFzc3Rocm91Z2ggaXMgc2V0IHRvIHRydWUsIGFsaWduaW5nDQo+IGJlaGF2aW9yIHdpdGgg
aW50ZW5kZWQgc2VtYW50aWNzIGFuZCBjb21tZW50cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExp
IFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gLS0tDQo+IA0KPiBUaGlzIGNoYW5n
ZSBjb3JyZWN0cyB3aGF0IGFwcGVhcnMgdG8gYmUgYSBwcmV2aW91cyBtaXN0YWtlIGluIGxvZ2lj
DQo+IHJlZ2FyZGluZyBIRE0gcGFzc3Rocm91Z2ggY29uZGl0aW9ucy4NCj4gLS0tDQo+ICAgaHcv
cGNpLWJyaWRnZS9wY2lfZXhwYW5kZXJfYnJpZGdlLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcv
cGNpLWJyaWRnZS9wY2lfZXhwYW5kZXJfYnJpZGdlLmMgYi9ody9wY2ktYnJpZGdlL3BjaV9leHBh
bmRlcl9icmlkZ2UuYw0KPiBpbmRleCAzMzk2YWI0YmRkLi4yNWY4OTIyZDc2IDEwMDY0NA0KPiAt
LS0gYS9ody9wY2ktYnJpZGdlL3BjaV9leHBhbmRlcl9icmlkZ2UuYw0KPiArKysgYi9ody9wY2kt
YnJpZGdlL3BjaV9leHBhbmRlcl9icmlkZ2UuYw0KPiBAQCAtMzA3LDcgKzMwNyw3IEBAIHN0YXRp
YyB2b2lkIHB4Yl9jeGxfZGV2X3Jlc2V0KERldmljZVN0YXRlICpkZXYpDQo+ICAgICAgICAqIFRo
ZSBDWEwgc3BlY2lmaWNhdGlvbiBhbGxvd3MgZm9yIGhvc3QgYnJpZGdlcyB3aXRoIG5vIEhETSBk
ZWNvZGVycw0KPiAgICAgICAgKiBpZiB0aGV5IG9ubHkgaGF2ZSBhIHNpbmdsZSByb290IHBvcnQu
DQo+ICAgICAgICAqLw0KPiAtICAgIGlmICghUFhCX0NYTF9ERVYoZGV2KS0+aGRtX2Zvcl9wYXNz
dGhyb3VnaCkgew0KPiArICAgIGlmIChQWEJfQ1hMX0RFVihkZXYpLT5oZG1fZm9yX3Bhc3N0aHJv
dWdoKSB7DQo+ICAgICAgICAgICBkc3BfY291bnQgPSBwY2llX2NvdW50X2RzX3BvcnRzKGhiLT5i
dXMpOw0KPiAgICAgICB9DQo+ICAgICAgIC8qIEluaXRpYWwgcmVzZXQgd2lsbCBoYXZlIDAgZHNw
IHNvIHdhaXQgdW50aWwgPiAwICov
