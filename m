Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331283BB57
	for <linux-cxl@vger.kernel.org>; Tue,  3 Feb 2026 03:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088084; cv=fail; b=FMTBZOZi6Sh6OUMr9M7WVt2eNMw3ixukG8qUSkkOUS/zsWRLPNM33H9N/xhwKfSA6xPfoK/In5+e0k0DVPq+v3QHi/+JQu0gY7PMjUhAFaMjD8j9JbQtsYDZVpzZzbViIPgJNlXUIf4nfspBqFWOIwICgh0nsZ1MHubuaS9q9NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088084; c=relaxed/simple;
	bh=c75DuNB2XLG5s6RyeGe6EIluPXNZrvQssRMfGct/w9g=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=D/D1XKmZtvBwN7HpjcVm33AnHPtf2wp7jyKEkHDEZvvUeW73yMXBViAga/3bSboznik4UOM9S0J4dxw+4iBx/u+6G1PKX4h4IWtOsnvf6WiE2Npq3WKujIIP+yUVT8FWiO7e21bybu4zK8mPE6jLSur/n/kbfaWYqH5c195vGFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkNV+vXw; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkNV+vXw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770088082; x=1801624082;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=c75DuNB2XLG5s6RyeGe6EIluPXNZrvQssRMfGct/w9g=;
  b=hkNV+vXwKdQ4SL5HjEcgHmaTgaIaDoomJv8WtzLUxMxLCvLMWaD0qWZc
   Xv8XjiDVcMhmDog3u/5TDkb6DBv+91uAPrGxhLGac0TQvJ8Jqu97XjEA7
   DH4KrovLMQZYOaA0AlQ8SGMq5XDp1U+v4od2NdoNFTYIUApuA3MtmeHQM
   +LjAEQw+etG+1LjZiHwP4zK005QhSMJu/Fdir06DfSRoPg2QgpjYh80sW
   2e4SKXDtoSIU4gIiR4yhAyUb7iBw0TniftZLv660Vwixxrfwws5r7EHKz
   5Dl8y5fP45LUwfbR2IaWWe21Bq/2O7sveyOfN0E19ahKXZEqlfkA2vzQB
   w==;
X-CSE-ConnectionGUID: wPlwWTN8T5aYYlTAYie2kg==
X-CSE-MsgGUID: jsV8yE2TSZiROzSImDE2RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="81881959"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="81881959"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 19:08:02 -0800
X-CSE-ConnectionGUID: Tg6PfgjuQ9CJYj7ctCOYQw==
X-CSE-MsgGUID: BrWRziwjTSmcxFHgor7rkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214479838"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 19:08:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 19:08:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 19:08:00 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 19:08:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOrIRlI4x8Fie2zY7zRt5OcPkR2kpK1lp1zMTS0957HStG87+5F9WdHSSTY387m1pxLkxl2399bEJJGavyNgOAtMgIqEmkwLcBG0PTxKveFAHu0dL6T8EB+tp/kScgjM6C2v9+Cf4b1+cM3BYFYfEoAW345VG+WFx8roziOp9SM30Prl1ppMZonWZIACk+CGQ/lzlnEfVMJnqvIa8kM1/Qrvmsu2n50SIm+xCxXLj88sCsgto7Ie5DHwlVAQv3BL5kre5eDGyTV1LHFHAUbPhpQ7D7NmcCJ7JGmgSI4whjb8WltJslzkMLpGRG6hogNyURrBkZoYeO/p8LaxzORUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAlir+ig7AQwUkP7Ad2hkOOZv3FS6XE233SVIDuT4M4=;
 b=pyvDxxh6vtpdQ3MCsQXTEbs2+EkGJqFhPXftIXjVm/kJhuTSacqh+sn0sXW4bX8nhmOgHnBC37ROWtbWA4m7iBK5AZ8a/bjLWO963ZEydJg5N5/+6MoXvNHft8RyULU8AUFHbZBPhiAG04EDwCLmj747UGfwan7+SMdNnNJp8WOXW4DBzOXL8WYr5Qics311onokCL2eFfaFslNHlsuladYQyFFBp+LBlnRJMDwSscciAmUgqexNXhbVz5GlS1uf7TWVgAUQ9N2KotScsSp6ryyEuhH0Kw0n9MfgIdI0msj5ovR9RTiVr4fTN/wOsD5DXntuGQlaX820jkIWPwfJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9397.namprd11.prod.outlook.com (2603:10b6:208:573::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 3 Feb
 2026 03:07:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 03:07:58 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 2 Feb 2026 19:07:57 -0800
To: Alison Schofield <alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<gourry@gourry.net>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Message-ID: <6981668d2182_55fa10024@dwillia2-mobl4.notmuch>
In-Reply-To: <aX1VMDh9IY4eg1h_@aschofie-mobl2.lan>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
 <697cee39ed313_1d6f100bd@dwillia2-mobl4.notmuch>
 <aX1VMDh9IY4eg1h_@aschofie-mobl2.lan>
Subject: Re: [PATCH 2/2] cxl/region: Unregister auto-created region when
 assembly fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: b1194e1f-3d9d-4b61-f9af-08de62d16f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWlBSXVyczRWV3hEWTFiMmdRMEt4SWNHMU1WL29uQld6UXc3NWtmWGtIZjJa?=
 =?utf-8?B?Titkem96QnhzR0dKRUZBU1liNm9xcTJnZm1nU3YzSzNvWTBUajEzTXVBc0Nm?=
 =?utf-8?B?MHVyNlNKOE03Myt6Zmw1dVFBUm52TUR3RERtaERVWC9lYjYvRW15TUpTektP?=
 =?utf-8?B?eENDNE0vWkFoMENEL0dQR1k5STVBbGJ4eExhbVdqLzlSTEE5dmVDamlueFNG?=
 =?utf-8?B?bnl1NkR6WGJTQkl2WVFTc2NaR0d4eWVNVEVZd3B2cjlmSFg0L2phbEsySUhN?=
 =?utf-8?B?Zm05ZjRGVjVleXA4Tm4yWmhhT21CSXRKdmY2Z3Jlc0dvUWpRK0V4UHJZcVgy?=
 =?utf-8?B?eFJmRzFIVW9rZXJqWUZZNEhmVUJKRCswQ1Vnbm92YURtYU1uaGZEc3hjT1NZ?=
 =?utf-8?B?TFFKZjZ4WG9NRTlGamN6Ky9TdndicVdwZ09Yb0o1dEZUekNFZVhwU0N6em5Y?=
 =?utf-8?B?L0tVUjBlRTk2L0l1UFlXTEZiKzkvWmlGV3ZNNSttNTBuTVBvV3R0Zk9ma0FK?=
 =?utf-8?B?SHNpeTVNaW85WWlGUjlCc254WU1MUE04d1dFMHB1REpDV2ZiR3c3cjZvMWxo?=
 =?utf-8?B?QTBQK083SmtVV3VVOHBJbGtKZXcrdStBUUFwRkt0UW5sRnVCanJEOERIaWNP?=
 =?utf-8?B?c0xpQ0U1c0pQUStRNjBFWnE0ekpXalY2TjdwbWNXclp3Y1ViK3Bsdm5oTTBD?=
 =?utf-8?B?ZFRiK0RucHJjT0ZYSjVydDdvTWVTNlRZaUl4eFY5V0U3T25zSi94RnYvc21O?=
 =?utf-8?B?NG1QRExtRGN5MlgvUXZ2bFpXM2MwV0w1RWNBYVZ4NkJJcE1VYjdSbkhFQmR6?=
 =?utf-8?B?YWVoWGhKQXZENlJVUEtqVzZtY1FiZWp2VzZBejEyS0VzU1N5VFRqSDJJTFlW?=
 =?utf-8?B?WmxCMzAzeWY0Z2IzWW5COHVSRFZRY0FybnluL21Kd2YvK3gzdmRxTWxURWkx?=
 =?utf-8?B?K01JYnVqUi9yUm5RQ203Z0drV3pFR0cwNUs1bzNvazM1UmhqSlVieGVrR1JZ?=
 =?utf-8?B?ME9iMkNkMmF6N3RUR1lUdWIwRW9nOVhqdmtoNi92c25PRk10V3FLaVFoZlpl?=
 =?utf-8?B?TG52SXBPcEhFcWxCOHNKb2dhaCs2K1VuNHdHVzladTcxbGF5c3pBSytMUHZ2?=
 =?utf-8?B?VUNFZUNSLzExeGFUZnV6MHRsc3JjUDA1bXQva1ZzWXR5UVBlei8zQnJqeTVV?=
 =?utf-8?B?eFNMSFdod0tKSXlxRzM3MC9yd1NaMFZnQXBFUTg3UzRieTVrYUFUU0dTaTFu?=
 =?utf-8?B?RExWaUh5S1N3cU44dzBGbHlINEtzOW1iR3VSQmNCc2htbzRya0RKdEcwK05X?=
 =?utf-8?B?a3BtbEdMZUdmaEdRR0NkZXI4Yk01QXNJMDFsY2tvZFUzUEsxUUFQL2dCTGoy?=
 =?utf-8?B?ZVR4OXNYVzFrYm9wS2QzOHphNUZKeFJkWDh2K1lnSXpObjg1OWtrbkQ0VE1l?=
 =?utf-8?B?dE5WNkhOTmYxYlpxTU9XUFYrV2pON1hYb0pwNFFnbWZZdG5LSEJsVkdDUGNk?=
 =?utf-8?B?MU1EWDNmWFhlSE9EYXVtLytGd2s2UEhrKzk5bXV6S2w3czY2UHFJbFU4dnNV?=
 =?utf-8?B?dHdhY25HSm9tYW1yK2x1bk9VdjRRSmtFRTE1QnBuNHpxejVsR242NXhFZVZC?=
 =?utf-8?B?Q1V0STd5Zzhpb3JmNkk2M3JQVnFFcmJDRG45djM0SWg2YzZIRVBzL1oxSFo5?=
 =?utf-8?B?OThQYTdXTmwxK1dVNjlZQUd3cm5IbjA3bmUvbDFzQTU3bjBwbFpKQnNTaW56?=
 =?utf-8?B?d285UXNzbEtxZHBReElvU3FVSlYxdjhXRkVvR0lVT3d4bFRDc2lBS3RYK052?=
 =?utf-8?B?V01kTkJNbkNFNllYTUlXWW9odi92L0lhTTRkSlhyTHlVTjZCcXJWYVhoU29l?=
 =?utf-8?B?WmR2ZzFsU2ZjUm5aS0VvUXlONHBKbXFXMkNlRllzcnc3Vldpa2tKbzdDSHhQ?=
 =?utf-8?B?amlCOTMxQW1UdWpBYURqQ0JXdXRLSDEzUHVVby9XTGhvcURWSlN3MUxvNEY4?=
 =?utf-8?B?L01yekxBR2hrUVBFYlFST2Q1S3FvSWhGSkhGWFJmRWQ5OG52WklENmZ3UGFQ?=
 =?utf-8?B?dWE1M3dhL1pKUFVDMGhkVzNCUmhpZHpmQXRBbUtPbEVwMC9wR1RQbktMeGFB?=
 =?utf-8?Q?b9ww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3prdnZGaXU5WVBPRm9LNTRpYmIySzR1TVJSV3Erc2JEN3FSSTFDOFA2ZTVZ?=
 =?utf-8?B?K0NQM3V3cHNBczZrMEplbW5rczNaeUk3eU5KS0pSd3NKSElEMkd2MkZkSmd0?=
 =?utf-8?B?VDJlejRCMFRkWmhVeW9ZbjdFcCtlV2t5R1drVVJWUncxN2NpV2RGMHFkZlM0?=
 =?utf-8?B?YmpHSld6OEpqVHZZd00wb0VUM3JjaEhGTnJXUEtQd3hCMTA5eHV0ZzcvL01V?=
 =?utf-8?B?WTR0TWt0R2NMTjRROVRHcCtuaXV3THJXQTlYUW9uQkRjTFljTGE0bmZWSzNw?=
 =?utf-8?B?UkxhQU1meWhmUW5ObEFQUHhXYzNZM3Z6T0dKRHFIbDlCZ3VQQk1qcUh1U0dK?=
 =?utf-8?B?ZWpBSFV2a0VYODc3OWJndFJnbmNCN0plT09jazYvU1M3ZDB2SVpmYSsxSmFL?=
 =?utf-8?B?Z1B0TFgzcWpTSERMWXdVcWloaGQvSkxWQ3VPeDZiZXZ3L0VzWU54RWtlZVlj?=
 =?utf-8?B?Sk9lZVJwUHhwOTR4anh1MkYvSmRZNlJHL2VOZ2JQUEsxSDBCZHY3dFMvV1BQ?=
 =?utf-8?B?M0FJTy9FSFVYUWNrWlFTNHNCVWI3bjJxdE5lbWVFYkZWOUdYc3hyS2ZmQ0ZI?=
 =?utf-8?B?M1pkTVFaY21jdTdnUnNQOWpvSlFqalFFR08yTkVGeEFRekZVaUo2QzlXaDIw?=
 =?utf-8?B?Qm9IZEFFRnlIKzRkd05pT2E4QlkxM1hES1hPQmFYaXg0VFFYSllrZkNsMFo0?=
 =?utf-8?B?Y2dmaUoybW9hMDBBOXJ0djdwTjdVOEl6aHJiTDFmYTJ5TXhBRTU5dXVKY0Nz?=
 =?utf-8?B?TzQ4cTl4OVhlVTU1YkxHT2Jidlo3SlYxRGtJeVJQbE9rb0pHWldqREIxYzJN?=
 =?utf-8?B?bHp2RlpXdzZ4M2R2bU5ESDhSd1Qzdmd3TGwwQUZ0Q1VnN3lwRTZuRE53dncz?=
 =?utf-8?B?R0FBeVAzOE4yMTRnZy9EOFp6Z09hY3dlRXFhM3prTmhKTmtUQm01bTVTVGpE?=
 =?utf-8?B?WC9xUGk3NW5DT3lGVUwxN0lVUnUxWmJRelZJTVlHMkRrY3NyRzFkZkQxS2Zh?=
 =?utf-8?B?b2toc3BtdksvblFDQ3psL2dxVDhKc0p1L3pEVGZNWnNSMzlFUTZibXErMVdJ?=
 =?utf-8?B?L2tWaldDSUwyL1Qra2VrcWVkSmFqTEsrNzRlempEdG5tQUtjV0V1L2NNMmR0?=
 =?utf-8?B?dll1UmhuWkNjbzlySjlJcVl0SEM1eHVOZlNYdEpld0EySDlVdEtWdW5oNFZ5?=
 =?utf-8?B?U1NuWGJkZHhQUzg5VTQ2U3VSR2tPUUdrNjRMaUNNd3pkbmJQUGFNYm5tYW1l?=
 =?utf-8?B?STlKdUoyUWMzZ3ZSZ2h0ZVBiMUtHelhaMHAzbEE5RUM1bGJMOUovS2thZ0hz?=
 =?utf-8?B?ZXBDT2oyR3RyTklMT3hXTWI3TXVCTEhHSUVVZThaTVRsMTlZR1RHYktDMDZh?=
 =?utf-8?B?RzJ1NGVRV0k1dTdkOUFvUlJia3VSQzhHWDYvbW9ZdUhyemxjUFg1NWNwc2RU?=
 =?utf-8?B?dlFWT2NlbFdMSlM3WE91UlRLenE0a1ptQUFid0laVk1XVnZGTXJVbzJHYkp4?=
 =?utf-8?B?eGlLQlhncUR2cjIwbjJnM1I3Vlh6U1kyNXU1TkIvUE1UZEVqZFRnWGtzSXpT?=
 =?utf-8?B?V3l4Q2dZNUZwN0xOM3RDSm00QUtORURsbXpjQXcxdm5Udmg1dTZWbCtlQmk4?=
 =?utf-8?B?cTAvdUNHbjM4RnJhaHJobHZib2xWeFlWdE9Rb1owQldQci9HUUN5MVBmMzk5?=
 =?utf-8?B?dXBOazhndlV4SUxpdG5iK1ZTSXQvWkgrU1pycGtYQVBsbEJmUzhFaWFMejUz?=
 =?utf-8?B?QkNsKzZLblBZZDloZzJZY2oraDNYMTEzRHJPRzltVldJaktpT2ZLcnJnZ2wz?=
 =?utf-8?B?czJLRkIxbDIycWZzd1hHYVA5eXVyNEN5dTYwZEtzOWljemIvSzRnYStNMHpK?=
 =?utf-8?B?ZmNHM1lWNkFrbjU5ZUZpRW5vTW9JdU9yYkJQVHdZeWpuZkJVWGc4VHp1WlZn?=
 =?utf-8?B?MnVLaUQ4OHAzU1RTMnBNaGN3bFd2ZGVoNUNDbDB6QzBBMHlhRlBjd0o0T2F5?=
 =?utf-8?B?bERDRklvSHkveW91RWFNcUREQmUzQUVoMEoyaTFXUmlPQUQvSFRHa1p5RW1t?=
 =?utf-8?B?WlhvV1M3OWdGUC9IVDJFWlo5aEw5eFNGdlNiRHVtZk1XL3R5L3BLZ1A0WXVP?=
 =?utf-8?B?ek4rZFlNQUJpYlNLTWJET05sVWhad3MyMXhlZk1KV1RGMTg3L1VpR2hVNk5Q?=
 =?utf-8?B?YnNrOWFGVDlWeElWY1U3aS9EaGRxL1RGd1F5Zzl2aVpiaklWU0pjbm1sbmli?=
 =?utf-8?B?ajk4VXB1SlBpWmtMaUs4dnc0dFM3a3BkS0JqUVFJZ0Fjd080eTE0Z2owS3Bo?=
 =?utf-8?B?ZkxaQlFZWEl4MnVNc3lXdXh6cjVoQ0hwck9KWWJFUXJQVmZ1MVJBWVBVSWE4?=
 =?utf-8?Q?1AweWhIvsuHqlf+w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1194e1f-3d9d-4b61-f9af-08de62d16f1b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 03:07:58.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K6Fpm9hZSRoGN6y9LCQUk9at8XYNYA8lZxO8U6W8yFobSCyn3kAqr2WnVTzvAKBg9cjQ3kz1MTkmY2Ip2RD+TkK8FJAafclcVcI1R83y3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9397
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Fri, Jan 30, 2026 at 09:45:29AM -0800, Dan Williams wrote:
> > Alison Schofield wrote:
> > > When auto-created region assembly fails the region remains registered
> > > but disabled.
> >=20
> > Right, that is good forensics, administrator action is needed to figure
> > out what to do next.
> >=20
> > > The region continues to reserve its memory resource, preventing DAX
> > > from registering the memory.
> >=20
> > I would rather have the partially assemebled region to continue to
> > exist. It can help debug the expected catastrophic error reports from
> > DAX enabling access to a memory range that the CXL side can see has
> > completely failed (lost an interleave member). If the failure is more
> > benign and DAX side access is viable, then the forensics matter and
> > userspace can cleanup.
>=20
> Thanks for all the feedback, Dan & Greg -
>=20
> I'm responding here because this is the overriding topic of do we want to
> behave better upon region assembly failures. If there is a path here to
> becoming a better region driver then I'll take a look at the implementati=
on
> comments, like if or how to timeout.
>=20
> One point I should have led with: while we are focused on failover to DAX=
,
> the issue here is more general. It is about the region driver leaving beh=
ind
> an unrecoverable partial configuration on assembly failure, independent o=
f
> consumers.

This gets to the heart of the question of what practical problem is
being solved with this and is the solution suitable? Outside of the
"platform is doing something strange" case like "Normalized Addressing"
or "Non-CXL Interleave Target" I am struggling to imagine an end user
benefiting from this automatic cleanup. A system which is so flaky that
it can not arrange for BIOS configured interleave to stay alive through
Linux boot. At that point I expect the end user to decommission that
system, and flag it for remediation, not recover it and keep running.

> Neither of these failures are recoverable from userspace today. If they
> should be recoverable from userspace, prove me wrong, but I'm doubtful
> that we are just one smart admin or one good cxl-cli update away from han=
dling
> this in userspace.

That is my bad. I mixed some unverified wishes in with my replies, but
the end goal for me remains the same. Userspace should be able to undo
every step that auto-region assembly performs.

> That's why these patches make the region driver fail gracefully. And I
> do think it is the region driver=E2=80=99s job to fail gracefully.

This where you lose me. It fails gracefully today. It stops in a safe
configuration same as if userspace stopped short of fully configuring a
region. I keep coming back to the RAID example because CXL region
assembly is roughly patterned after RAID assembly. In that example a
RAID0 array does not disappear after 30 seconds if auto-assembly fails,
it waits for administrator action.

The potential conflict with a DAX takeover is a separate problem that
also might not need full teardown if we can make it work with
incremental fixes.

> When auto-created region assembly fails, the region remains registered
> with decoders still enabled. In that state, userspace does not have a
> supported way to unwind the configuration. cxl destroy-region fails becau=
se
> the decoders are still enabled (--force fails). So while =E2=80=9Cadminis=
trator action
> is needed=E2=80=9D is true in principle, the admin has no effective actio=
n available.
> Leaving the region behind does not provide a viable recovery path because
> it leaves all the things related to this region stuck. All the things bei=
ng
> the HPA resource, the DPA resources, and the decoders.

Right, I think that is a gap worth fixing to have all the same tools
available for partial creation recovery available to partial assembly
recovery. A "gap" and not a "bug" because only a unit test might care
about this presently.

> On the forensics point, the most actionable diagnostic information is not=
 in
> cxl-list output. cxl-list can show the existence of a disabled region, bu=
t
> it does not show why assembly failed, which endpoint is missing, or what
> happened at the time of failure.

cxl list -RDi -r $region

...shows the region, the number of expected targets, and the ones that
have arrived.

> The forensic info is in the kernel log, because that=E2=80=99s where the
> assembly failure is detected and where the relevant context exists.
> With the changes here, the kernel messaging is improved so that the
> failure is explicit rather than requiring the admin to infer the
> situation from a disabled region in cxl-list.

The kernel log does not know the device that was meant to arrive.  . The
kernel log likely has debug disabled by default. This situation should
be debuggable without the kernel log.

Likely the first notification of something wrong is operations tooling
noticing that serverX came up with less memory than expected, not a
kernel log message.=
