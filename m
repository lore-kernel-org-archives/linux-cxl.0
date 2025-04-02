Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36713C17;
	Wed,  2 Apr 2025 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576412; cv=fail; b=Qm7wiz2cGhYqzGW5NuaqQAtvM1Pto8GnuU7wglPQUEBd1S6ZEWhjQ5cH0k8vCDprmTLmSioqiuPvhKZARhbnNDZhJSuFkDV1fgnvrAplSa2z0Kq3lrCyV9T6MPEoNrOXvYwJyX3yxL0LTgMddabApdzrI8V38ApEKW1+F1+VP0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576412; c=relaxed/simple;
	bh=ARanHAyNdL/Hu/cFpYewxGgK3aK+u/enOwCxtkZHwFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ky2eNkqhNDykittIXHKJIoRWBWK7CXIVswXhCIzB8uyLnEVwLYKCSwwNylyWSSCvxmMRKTVQEysmdxfSYtcANHO6vxvMzCOm6Sk07PYW57XDl33uODl43IIu0vVDRV5UGBye+v60/ci8AcnHJCu7mQxufHSGrIA+c26we2g+hH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ou0Z3scY; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ou0Z3scY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743576411; x=1775112411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ARanHAyNdL/Hu/cFpYewxGgK3aK+u/enOwCxtkZHwFg=;
  b=ou0Z3scYXtmOVoDEJDbjZ3sectb9V03cAe39aZtaLsjjYwGR7UZX6nEc
   9o9b0JxcgYEaR8Ehp+WHW+UG00Y4bL3Hth62kKrIm3EKROGCQEOGEpSMz
   2FlVIT+k1FhRNruEwHkmLV1eRODmJ98Iyi/6InHEDOre5SgDwi4j4awzw
   I6Lh3kli3mQJFh1cOn2c4NQNinMy2g2u1x3ZvapNBFNz2hjlXZ6MjBa1W
   FOpUMYi38DnUWkdFs6yxByUQHcpxoUZDGhoVVn1PInrNPiqqo3cvzaYr5
   clKu2DoQcw5g5eObH4377Bg5X+vZ1tkRojfrb5dPwq1IEfImeDyjclp92
   g==;
X-CSE-ConnectionGUID: lYXBQmbGQ16ZJfBcCyeQMg==
X-CSE-MsgGUID: 5m9qxebKTYa99RldOji82w==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="151580735"
X-IronPort-AV: E=Sophos;i="6.14,295,1736780400"; 
   d="scan'208";a="151580735"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 15:45:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMaf6zyfXmkNgFxQeJX7l56YgD4dlqjSAGirNczbLb1Vj6r6fGfseHNCKgZ7QeXncSKxwwdDCZpMYhBs1OBGb+DSw+BbnNRKzYGYUQCPluju9SEQD+qXvkq9RQpgW8INlQjGHv6zbnv43aZrqZhNECzwHLff0Dv3QYaE7zJXmEvqVZSV2nKazaqlOsGIvqcwywCZpD8FrU6sifLk06hl7EQ2OTD5V+a+7P4dGmyuw7gL+lhxWJp6IHDQ76ryevQs5y6ho7KXnGclCtVSFo3dshfZMtQ1VBy+7kNgHx50QxO66GehtBCBCOM0SH3glE/D/R4jTSsrBJ3GqlCs7+aFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARanHAyNdL/Hu/cFpYewxGgK3aK+u/enOwCxtkZHwFg=;
 b=JuuQUjAmUVByHrA+Si1VHwC2VMaKNVhd5IWEncpgaInw7wpUkQHzzUDQia7bGB3NLnzK/uWcVKzjWWwXXONv4jsy/fwQaha8AiMk3wKL43qcTeWx8v9S62uh++jS1siMvWHFCOgLzEnSA/vzWiV8yMU9cTcT52q1IT5CQiGxterK5QkGFnSLuCZXF61WJBP2KSIS05qJik1EztQFIn6311OOzPVIqC4o2kfzEpYhfytehbFa6XdkY3SQR91m8WBzi/KvQjNbHo+994WgwjPlyr0xCs76zKAjVN4jS0wVnm+0lOEhC4hMEe9uVevTz36RwRVozJsKfNcuzZnj7mm8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYYPR01MB13164.jpnprd01.prod.outlook.com (2603:1096:405:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Wed, 2 Apr
 2025 06:45:33 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 06:45:33 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Gregory Price <gourry@gourry.net>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Thread-Topic: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Thread-Index: AQHbjvNia1PhMmp5z06r6vu5ANRYCrOQF8EA
Date: Wed, 2 Apr 2025 06:45:33 +0000
Message-ID: <cf7b97d8-4393-424c-89fc-aa810d907a67@fujitsu.com>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
 <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYYPR01MB13164:EE_
x-ms-office365-filtering-correlation-id: 49137694-4b46-47c6-6b96-08dd71b1f7b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlV0TDRqS2lqbXJDMDQxcVdkRkUwb3N5eVZ1RStwZkJ3ZVNkNVMwYjhLUW1H?=
 =?utf-8?B?RHBTdTVxeXAyVU9yNEVhWGdjYUoyc0VhL3hGcDRGdFJFK1BSL3Z4ZWYybFdj?=
 =?utf-8?B?VkN2WHBqZ0xYeVdNUkdQbjZhS3RsNDVydnZPQ2twT2N4eUtCOXNQcHliMDFw?=
 =?utf-8?B?VFp3ZGFrM09CbmEyZFdDMkJIcnllNVJjOWJhRDF1eVF2MHh2TWNNTU12QkFK?=
 =?utf-8?B?M05aYTB4a2RKR2toRXhBdkMzZmJTbFE3c0V5bjNtUm1seTQ2U05lYUovb3N3?=
 =?utf-8?B?aUxIVXhPaW9jZTRsM1ZoQ3NxNHFvMitFVWxsTk5SRVQvbFZFZzhLL2VmelRV?=
 =?utf-8?B?ZGlWTGJzbzRQM05KTzZWL2dxQTZHM3lyRjh6OTdVdUJEQVZLVFF6VTVTRVNC?=
 =?utf-8?B?YVEzWkxDOGw1NHJzRjZjZnQvcFR2eGFnQ0k3WkNzNmxqbTdnMDlITWlFWksr?=
 =?utf-8?B?UGhtbXM0eTU2ZlBtUzRUKzc3T2hsc0dPY25WUlFTaW1heWgyZlkyUHd5U3kz?=
 =?utf-8?B?dUVJMnQ4OUplV0FXUmJBWVVhMzJzdEtONGV3a3ZJdTBKcmJHZ3NOQ2dwQjJU?=
 =?utf-8?B?ZFVPRVlZNkVYM1F1TzNrUThEYUtVTUpxeWNCZmJFSHVKNXZaWmNkejZYaWgz?=
 =?utf-8?B?WmpRbmMrc3dJQnFja0wzbGIyenhpL2ZoMGMzL2Yxc2JrZEltVWZhQnpEWjlz?=
 =?utf-8?B?QnV1VnVPUkJUMEx1YWhGS25Ra3JqNDlPaDdqNzdjMjdacklGQVZ2by85NFcr?=
 =?utf-8?B?TTFwZzlCVHNIb0hzeTZodHNjRXZiUzRRMFkwaFpORWlWUlhudjU0NkFVRjdt?=
 =?utf-8?B?L0tQbklQMmNoTVJYR1Bjd0NKQkUrVzB5d2U0S1FTeW5tSmxyN1RpUDlxdGc1?=
 =?utf-8?B?ejRPK1hGS0NWdkRtUkZHSkhMK1lWcldUQ3FBSjVUS1ZXRUVMSlYyZU5MVXJi?=
 =?utf-8?B?eGY0UzljTzVibWMyNk42R2t6NFp4VDMydnJzbTBOWldROEJOVWdab3NZYWdq?=
 =?utf-8?B?MnRqcHBSWlQ5ZFJqUlVZK2VBUWp3MGltV01ieGVTdmFybkxMeFoxWVdTYTdn?=
 =?utf-8?B?WmtJVzArMXpoblAxSGlDYVRKS3BxZWphTEpFczRlMFVIUWh2bjI0bmY4RGli?=
 =?utf-8?B?dUNwR1lrM29sQ1dZVXFNQlhsbDhBZ2IzSHlSc0V5bzRtUzBlZHpMR3dtTzUv?=
 =?utf-8?B?aVl1UGN3N0RSc3hYZjEvTk9EcVlYeEFqNmNSVG9WTjd3SFlOQXpiQldOTDQy?=
 =?utf-8?B?VTZJRlpUdm9GdCt1OFpLVmhRaDBzWVkzM1pWMlB1VERYVjUzSUQwUWJyZlBr?=
 =?utf-8?B?MC9lWFJiaURrMGNnM0lRWjJGZzhIajdNSXpWS3B4eE9Cd0RkaGNSYy81aEZa?=
 =?utf-8?B?RVpWdDRqWnZRZFQ1YVBsNnVydEZmeWZjNXBlOWtzbkdSeUN0Z044Y2lLdnJD?=
 =?utf-8?B?cll1UkVSTzRJVEpDMUJiVmNPT0VJUzhpNm52THpXNEpPOUM3U1I5dTFPMTVj?=
 =?utf-8?B?UE9XajhCOCtHOEM3aExtNUoxU3A0VVM5c0w5b1dGaGV2c0JCVm02SWRJcW5J?=
 =?utf-8?B?c1lpa2FldmFrcEhCMlpHemFrazA1QS8yUFowQ0p5K1dYaWJmSmo0TGo2bDEy?=
 =?utf-8?B?akErUHZXTENuQnpEWGpDSXpsRHlOZ3VVU294ck9pb0pRODNJZjlVaG9ia2Zs?=
 =?utf-8?B?OVhtQnlaWFNZVVl6YXVjVk5ja0xqQ05JSzJEUmJLdWxvVEgrbTZFZXRYckFt?=
 =?utf-8?B?a0IzZHRNcFhKZmhaVUc2SCttcUNPNGtmeUdUUmxJYVl1T3Rhc29oSng1M210?=
 =?utf-8?B?RC9qQ01ac3NZMy8rQTExcnZ3L0h2WlFBc3B0dXlGN3RwSmE0ODRRWTByckF3?=
 =?utf-8?B?NThoYzZUaUVaazZtUXN6TkRPclJWRHpZWEwxUkwzT3FSVFV0YjJEODRVNnZC?=
 =?utf-8?B?R0pLMTdYN1M1QVM2TEt0cVVpWm1FbHU2TnlTZEVqTGlPdXhZYllESUZFWXNZ?=
 =?utf-8?B?NVIzaXI4OWRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2VhZGFpbDRvUkc2YmRsNjJDaUl3NHhJYXZBNGNPbjFRNmsxaDF6RVVtamdw?=
 =?utf-8?B?TjBva21Ld210SjljSlZ6em9OYzRPUjFUSzlyNEIxMHBuTXdvQ0tqUGpNelJP?=
 =?utf-8?B?QjdFZjU5YmVjRUgva1F5ZDhsWm1vcEozL2s0c0lIZStIcnNmNEoyRDBRTnYw?=
 =?utf-8?B?K3B0b1pkVnNtSXRvQ3JaQnVpZmk0K20zN0twR3dGbkZyTkFKM3UyZlNPT3R2?=
 =?utf-8?B?dEpUQ0NjZUN3aldYb21YbVpHdGRWYXhMYStxTEppNlZTMmR4VTB5NGxHSnJw?=
 =?utf-8?B?eURDTHNza1lIdlVmT2dBVTJVNUJwUFFCQzhVMVlIRk9BeWhQWklRSVRnbUo5?=
 =?utf-8?B?NHhuUUZ6aDlVQkI2SEZyVXBwWDhJT3BHUkhQZCtKK29HcDZVSnBSQ01VUk43?=
 =?utf-8?B?T1pPcDJNVUhkZE1RL2hGM0pPU2tYWnlvR1lnQ3Q3Vld1S2lOa0NxK0VwOVh2?=
 =?utf-8?B?emg0VU5NV2NHWkJ2Tk81UTNrYWZNVWw2a2lGbDFZNEVFeVJJUUhBNFFTdDdN?=
 =?utf-8?B?alNIOFVpSndJWm40QkdoQjdncjhxd3pDQWtHT3FyYllydXZUTjVXQmhGTmNN?=
 =?utf-8?B?Y0ZBSGFBQjA5bXlUVFhaOE4yQ2NLclcrTzhNWkZEbnBqSVFhZ2lSYW44bnYy?=
 =?utf-8?B?SzRTM2wzcWZSeWJjalJlNTB0OEZDRmxXeDhtN1d6ZGZ2UUh5SU0vbHhWb0pI?=
 =?utf-8?B?SUttbmdESlQvd3JReC9PSlhKaldOd1llQXlNQ0s4K0pYYUxOUEpIRnBlZkNK?=
 =?utf-8?B?cDdxbUJiMVNrRWhzZFh5UGxMMWJJeklyREJ1QllROVMzYVdvU0h0eVdXTSt3?=
 =?utf-8?B?R3FFNVJBajNESHY3L3JpeEFxQ3VwY1ZCMUVzdGlLaENSV2lSOEoyRGxCT3po?=
 =?utf-8?B?QTJFTTlrU0lnQzNOeHFhWCtwNE1YTlZGMnEwN3duUE11emVNOTBieVh0dlVM?=
 =?utf-8?B?eWNIL2U5M3VkUjRLbmp6eHQ1eEhCRHF6ZGNGYkN2bHFjSEZ4aXdEMTIxUFYz?=
 =?utf-8?B?WU1HYzJMZjFQc25pVHlkc0d6NWx1RkVnQTAyWmc0cGZDcXNQdjIyb3Zsa0ZJ?=
 =?utf-8?B?dVczeW96R1BpRmRONmUrY3Q3Sld3MU5SKy9ZSXZpVDVlYSt4dzVRM3lMZksx?=
 =?utf-8?B?a2tNTTI4T08weFN1R05jS3Z6a1FsaXNXUEFnNUM4VDVjMlo3UEljYUowNlVC?=
 =?utf-8?B?NHFwZE0yZHZFcEVpRlllZDVUTUpGYWtmWVJRZ21LUzZCSHgxSDh0bWNxbzNh?=
 =?utf-8?B?SG9kdEJjOWZESEp6WjNSQXdwRFRPMjB2eGVWWjhTWUNtQnhSQlZVZ1dPS25Q?=
 =?utf-8?B?YVNJbFZzc2ExTTU4NHpEdFZVb0hjRTByMmxSRHYrcjJkbUVyV090VXF4cWc2?=
 =?utf-8?B?SHdWOWdCTXJwd1NabGNHbkNRd3c2T3JuNHUrL2dOVGw5VlVQZkFrOUJCdGVu?=
 =?utf-8?B?QnE1cTdtVzB1bnZWa2J6MnFqSExwQ3VOVVpYTFM3VDgyT0hmWW5uVlQwQWF2?=
 =?utf-8?B?enVuOHdNN3FpQXhyUWdiNndxNXdRVWxnMG9BN0NGb3FqRlQ4L2NiR2lsSmVI?=
 =?utf-8?B?R2owK3YxRExvUFNQd002WCs3UTJiU0ZLMXpOcmxrYzhhMS9NdFM5S3Z3Y3Zx?=
 =?utf-8?B?NnBtMk9EQVhlcElEcDRUbkdFUGRrNkhtb1ZPMkIwNWhkT0dWTUpDbWMveDlU?=
 =?utf-8?B?blVHOUc5MlA1ODcvamsxVFA1a0hRWE1NTER4NDhyWEZRK0Nyb0xySHo4dTQr?=
 =?utf-8?B?bnJPcHdjZzhGWGkzTUVyNTdGRWk4bm9zczFkK1cxb2NLZDdOTG1NbHJiZzZS?=
 =?utf-8?B?TjdTMWhSOG1CKzh3UnZOMzZDSVQ0YlJwek9veDBoUjFjMFJzd3RCTXpCbEEy?=
 =?utf-8?B?WE1QUlA0cHJLTVJRZmYyclgwb2h1YSswVUFVM2duNjRSN3JOWHlmVEhWalVK?=
 =?utf-8?B?a28rUTZZdWQxTitickZGc0pmeXdtdk1LcTg2UnhIa2grUUJObWlaVVF2QVBQ?=
 =?utf-8?B?TjVUT0tONG0xemxWTzFJMDlzRjUrTnNKT1djektpYUVrRDBSZFB2VnFhTGdt?=
 =?utf-8?B?czY2OGwvVDJkdGtJYTg5d0RETDQxUmJSOHVGWDJaK05LQjY4a1Z2c3ZjS1VM?=
 =?utf-8?B?MFBVV2tSYVd2enJ4S0tJYnVzK0hUMkFLeTZmT29JejhHTnE3UTVQS2xGdUtE?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B25A352B7F3A134DACB496CC71E8648E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dDnso/yqndzKro6fAE5zlHyreqTpMZoEHJmeLR3+rLDx1yZc7T7TDC15SN8g3wQL6frzs1sQWAhl7uL7sJlikY/M0G77on1vTSv7M7aQ3TKRd+IEAYbJ2wog8C+a3dPFtXbts5Z+6GziKaCmZN4ZAejlWmPCyBAlXzY/XcqbMPtFCcFULqK2wO8degCiHCiStpMZ1lmv4+jsAx02nf4zCmFjaSn6p70mVQc8M7XCsB99njAWscbG20oxWhlyPZsws1wJxUoZ5W+Eznv35aKQsvWHPIGZOQOrlajtBECtFGGqRIrIYPPkigW/dH6LcBkwktc66cwWKGkVkzWXGFUgXzg8y1B9EkK+s9pIoDMJE37XHGjF3lwo5cNVFoJ6Ky0zjlmL/SwplNe/hBtT7yGf71aK/74cIjTJVnPqjf5gni1ybqX52Yn4nkgapFPsuAGLsagF7sr7/RYURiajvVBgQJTYxtXJ1N9WRbcFAov+cd0Y7PSg8ailfTlWjwelKQKjkmbjzNatW5K4gOEhJoVSh4FUjBiVVLR+EKqGUvv1ayyMQ+MuSwZqVsLuta5L/Ux0zM4w0piYwd4cPKvHg42/mL4HCxHTI2G1ln5dOIgE9xrpWnonoLNNInZ/5vwis53e
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49137694-4b46-47c6-6b96-08dd71b1f7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 06:45:33.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWxuDXgQUYnUkdbZ+GDaWaNDHG/+er1DMuDmqZ6+CugHL3aWJlwNeYsgrqCl0GBCv/BJOVAIn0n3/OP/xSS8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13164

SGkgR3JlZ29yeSwNCg0KDQpPbiAwNy8wMy8yMDI1IDA3OjU2LCBHcmVnb3J5IFByaWNlIHdyb3Rl
Og0KPiBXaGF0IGlmIGluc3RlYWQsIHdlIGhhZCB0d28gMjU2TUIgZW5kcG9pbnRzIG9uIHRoZSBz
YW1lIGhvc3QgYnJpZGdlPw0KPiANCj4gYGBgDQo+IENFRFQNCj4gICAgICAgICAgICAgU3VidGFi
bGUgVHlwZSA6IDAxIFtDWEwgRml4ZWQgTWVtb3J5IFdpbmRvdyBTdHJ1Y3R1cmVdDQo+ICAgICAg
ICAgICAgICAgICAgUmVzZXJ2ZWQgOiAwMA0KPiAgICAgICAgICAgICAgICAgICAgTGVuZ3RoIDog
MDAyQw0KPiAgICAgICAgICAgICAgICAgIFJlc2VydmVkIDogMDAwMDAwMDANCj4gICAgICAgV2lu
ZG93IGJhc2UgYWRkcmVzcyA6IDAwMDAwMDAxMDAwMDAwMDAgICA8LSBNZW1vcnkgUmVnaW9uDQo+
ICAgICAgICAgICAgICAgV2luZG93IHNpemUgOiAwMDAwMDAwMDIwMDAwMDAwICAgPC0gNTEyTUIN
Cj4gSW50ZXJsZWF2ZSBNZW1iZXJzICgyXm4pIDogMDAgICAgICAgICAgICAgICAgIDwtIE5vdCBp
bnRlcmxlYXZlZA0KPiANCj4gTWVtb3J5IE1hcDoNCj4gICAgW21lbSAweDAwMDAwMDAxMDAwMDAw
MDAtMHgwMDAwMDAwMTIwMDAwMDAwXSB1c2FibGUgIDwtIFNQQQ0KPiANCj4gRGVjb2RlcnMNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZWNvZGVyMC4wDQo+ICAgICAgICAgICAgICAg
ICAgICByYW5nZT1bMHgxMDAwMDAwMDAsIDB4MTIwMDAwMDAwXQ0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVjb2Rl
cjEuMA0KPiAgICAgICAgICAgICAgICAgICAgcmFuZ2U9WzB4MTAwMDAwMDAwLCAweDEyMDAwMDAw
MF0NCj4gICAgICAgICAgICAgICAgICAgIC8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ICAgICAgICAgICAgICBkZWNvZGVkMi4wICAgICAgICAgICAgICAgICAgICAgICAgZGVjb2Rl
cjMuMA0KPiAgICByYW5nZT1bMHgxMDAwMDAwMDAsIDB4MTEwMDAwMDAwXSAgIHJhbmdlPVsweDEx
MDAwMDAwMCwgMHgxMjAwMDAwMDBdDQo+IGBgYA0KDQpJdCByZW1pbmRzIG1lIHRoYXQgZHVyaW5n
IGNvbnN0cnVjdF9yZWdpb24oKSwgaXQgcmVxdWlyZXMgZGVjb2RlciByYW5nZSBpbiB0aGUNCnN3
aXRjaC9ob3N0LWJyaWRnZSBpcyBleGFjdCBzYW1lIHdpdGggdGhlIGVuZHBvaW50IGRlY29kZXIu
IHNlZQ0KbWF0Y2hfc3dpdGNoX2RlY29kZXJfYnlfcmFuZ2UoKQ0KDQpJZiBzbywgZG9lcyBmb2xs
b3dpbmcgZGVjb2RlcnMgbWFrZSBzZW5zZT8NCg0KDQogIERlY29kZXJzDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZGVjb2RlcjAuMA0KICAgICAgICAgICAgICAgICAgICAgcmFuZ2U9
WzB4MTAwMDAwMDAwLCAweDEyMDAwMDAwMF0NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfA0KICAgICAgICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0r
DQogICAgICAgICAgICAgICAgICAgICAvICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAg
ICAgICAgICAgICAgICAgIHwgICAgICBIb3N0LWJyaWRnZSBjb250YWlucyAgfA0KICAgICAgICAg
ICAgICBkZWNvZGVyMS4wICAgICAyIGRlY29kZXJzICAgICAgIGRlY29kZXIxLjENCiAgICAgIHJh
bmdlPVsweDEwMDAwMDAwMCwgMHgxMTAwMDAwMDBdICAgICByYW5nZT1bMHgxMTAwMDAwMDAsIDB4
MTIwMDAwMDAwXQ0KICAgICAgICAgICAgICAgICAgICAgLyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwNCiAgICAgICAgICAgICAgIGRlY29kZWQyLjAgICAgICAgICAgICAgICAgICAgICAg
ICBkZWNvZGVyMy4wDQogICAgIHJhbmdlPVsweDEwMDAwMDAwMCwgMHgxMTAwMDAwMDBdICAgcmFu
Z2U9WzB4MTEwMDAwMDAwLCAweDEyMDAwMDAwMF0NCg0KVGhhbmtzDQpaaGlqaWFu
