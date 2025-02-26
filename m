Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E11E502
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554659; cv=fail; b=i/hpJUZgZgJEJZ9OSbyRps3ir70J45+W/qZr66Df7J1nKi1X6s1Qp6wpFfQ+uGoMrHAsXmCdjgSY9y0ly2+vbe3ZbdItK8nCKPy2X/5aRTjeoQzyKkoMj3LwgbBqrZ5JH2CJGJA/4EgUi8oycbOhBv7GoCkd+s6qNSEIFDMuWUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554659; c=relaxed/simple;
	bh=kwzNdxmblE/oVCuBJSdXo7ISWUlGbo7KXD3LkK++XGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nGrqZU2sgsomVs09foFHCsFDBIArvv8qVaDZC8BSGu39UWvivPz491/b4gUfuLiZVCEIcnt7BaBG+h+kj1E8CiW3LgR6bXg/I3eqa0gSMtnH9vAGbwlxjDfHjf4qFuviY3HMSIFNrNr4zEjX0rSmIZlFjplmCH93cROiKX5K+BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=s5qGWTGZ; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="s5qGWTGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740554656; x=1772090656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kwzNdxmblE/oVCuBJSdXo7ISWUlGbo7KXD3LkK++XGo=;
  b=s5qGWTGZ5E5xNEB/Feoy7VBqFQQmZo41X4I/50rGQJcR/hDYkwu4hACw
   EjTOS8dJkyrAt90TaIUuXD9zyvdRJ1gsTFYeZnxW5VFxhyeZWOiwEQBFb
   1UutWykbwL90O0AyxMNg22vPcnSgAwLkPbEMr6TwA6pm1tYkYzgKPUYWQ
   jAF1JdyzEFqGtv/xnxLD5QRFNdgaY3ZVtbDKRvTmVxtZTfRWcyKReaFrP
   KtzRASktEGakoTLSuRBFriK5ozXyllynHnUf9jTvjFIq0gChmBlYCFGN0
   0Lb+cdoshGaq0hX+3NiPqDnr8QWnwHhQqQEry6xENfDJtcOPc1jw1SKiM
   Q==;
X-CSE-ConnectionGUID: flXaOA1gTYSaJXxZZiuvMg==
X-CSE-MsgGUID: zHQc/y0lQGC7DRydJhe+gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="147146711"
X-IronPort-AV: E=Sophos;i="6.13,316,1732546800"; 
   d="scan'208";a="147146711"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 16:23:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZy01QxL0QJpfz6yPdHXSBOXOPX+fYYdF+X9Whif/JLcGmixzyJhP4zp66Tf6eLBYIV0jUiaJHEAakKDFfm6On5cTFszVka8MP7QKbOexxwzcq/OOzWYoOQaCONUgxLSh5Pcaw41dtPqRZPPa9ChDZlZN+N5+cW09RhwnjCjnZcM0r9nfi3vUxmPQvLiil0wDlHauvvL6g8izR68m6qDC5FGhc4M8YSEUiuTijOOG5c6Wc7vcRyBECu9fWyK3MoidN7rNcociAmSt/3IvPcrikmWmvkzgbvdozBVwESbTy8kOM263jwQsS2tb3NtWAupcz8yNfgSD9L1ssEIW2J8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwzNdxmblE/oVCuBJSdXo7ISWUlGbo7KXD3LkK++XGo=;
 b=wKT4sP7eSZrvy9uUewYuBHyQ3otkPoicaLAUcGmu1l3Nc23nQVi8kBSaOr1WHp76ja5s0qd3Ft6sYGWakdw/JQ2Ef+4GGR1i1MpkQd7Hx0WLcPeZKGCaP93OOysUFNcHiuTv0sJI8hBbaoctM5qx4QCfbVcTyltvyvyndEnxgbNbXlqSqr+lTBKBnK6flEfwxn8d1xwmM3fg4dc7QWcln3ssU+HuKH2Y3kbQncM7LNFZxgA6mVwTLiCACLgCP0lz4D75qT+Xj/vOUbIgOaqKZWXFC6Pe5glawDz32kLIiyP/xlMjg3lRLHFGe1zP12AHMcVur6SWp435Vq7ArtSIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB9400.jpnprd01.prod.outlook.com (2603:1096:400:194::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 07:22:59 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 07:22:59 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "alison.schofield@intel.com" <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/test: Define a CFMWS capable of a 3 way HB interleave
Thread-Topic: [PATCH] cxl/test: Define a CFMWS capable of a 3 way HB
 interleave
Thread-Index: AQHbhxbx7HiMmLCGQUirjPESV4XakLNZMFaA
Date: Wed, 26 Feb 2025 07:22:59 +0000
Message-ID: <fac0fbb7-ffe7-4688-927b-218e64249a9f@fujitsu.com>
References: <20250224235032.2259058-1-alison.schofield@intel.com>
In-Reply-To: <20250224235032.2259058-1-alison.schofield@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB9400:EE_
x-ms-office365-filtering-correlation-id: 7fbabb8d-9fe1-4a04-7172-08dd563665f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0hKWlNHRTV2cXIweWdDWVdUV2ZQMmQ0NTFwUGpMMExMb21meHBVTWpsL05s?=
 =?utf-8?B?c0dUTjNVZ3RHcng4U2IxcEdpMFhyd0NMNGRCVmRaV0JxcUY3bG5wb2FwVzJH?=
 =?utf-8?B?S09BMHE3TFZvSHFFSUs2T3E5MW1qczFaN3F1aGpQcEVIa1FxSHEwMDJocFRh?=
 =?utf-8?B?UTV1OW4ycXJmV1AwMEhPZzhHVEdqdlRkbzVQcUtjWi9pRmZGVG9ZZVFpdmtI?=
 =?utf-8?B?YVRRTlBiRktyMnRWS3gvTy9WOG1QVmw5SWNOTitSYnN6ZUNkNlpaczBHSHhl?=
 =?utf-8?B?V2c4c2dnUi9kQXBid1RLWDZ5MmI0amhNVEZMaTV6ZGVHeHlMTWFFVjF2Z2pk?=
 =?utf-8?B?WkJLWkpjVUVOQjFGS2Y3RHpZSWdlazkzY2hwTHpXbWhQb2lGdEorWHloaFE5?=
 =?utf-8?B?Y3RWVW51QnlGME5CaW04cU5YZWZPdGZQRWxRZnpORjAySzdhNnBQUnJpcmt4?=
 =?utf-8?B?VWZXcmFTQSsybUJIeVJlS2RyMWhKTDh6d1NwRElqdmJWVEZZR081bXg4YUVK?=
 =?utf-8?B?TjNNMWkxMW1KQ1RCNjJHZENDdTVqcE56ZEg2cUtLcFVCVTE3dEV1cHhpelpw?=
 =?utf-8?B?cC8rcHFHZVBhQ3k3enRJNzgyT1d1SzZucllJdEpNUDdkcmRabUpyT3RZOXRQ?=
 =?utf-8?B?OHR6K0E3dUtQWjNiSVZUSHdQTjhZY285ek9nZGoyVU54RWRuZ3JFU3VRUlFv?=
 =?utf-8?B?VUQyN0VEUXpQdW5XSmNubVE1aW5uQVU3TUgzczI4TEo1Si9mdEVLR0FuSjJ4?=
 =?utf-8?B?UWNMQlpmOFpOMkVlUVRrUHdnRTNSa3dtY1J0VENaUTNPMEF3cUlQYi9UNHNX?=
 =?utf-8?B?dFFLTDNXYm0wOXhnSThlL3VOZUVjV1hlVHhkZlJYa2RodWRkQjcxMUlnVUhx?=
 =?utf-8?B?Q3BOU0NTcEUwY1BVK0VTb1g3MlZLdHlBUkxZTnR2bWwxTTRZby9lWHRRQVM1?=
 =?utf-8?B?ZU9Ec1V6YVVqUFMzWm1VZEpMZ205dHlneUpCamVINWdhWHhOME02NnRDSEpo?=
 =?utf-8?B?WExuWTJmTFpoY095YVFoTEVLdG9HaE52bTM0VWRDT1hrR1Rldy9pTXp2SUc5?=
 =?utf-8?B?VmJqS2x6bnpCWFhPaWJmZnZ5YTF1ak9Za0FwQWxBb01VOC9EL1RaN09memdP?=
 =?utf-8?B?ZE1OL2ozaWE2Tlh2akJpK2VUVUk4WUYxcmN5U3k2SlgvWGcrRjBRcVUxeVVG?=
 =?utf-8?B?d0doM01kaWx3SmJkUUJnRFNLalk5M0Q3WE1VWWtHcG1weHBtelBObE9neTk0?=
 =?utf-8?B?S3ltcE85cEQ1Y0lrdlBydmovbmhxa1kwRXJjUmY2MjQxV2hEblBlS2k0REtq?=
 =?utf-8?B?TFB0UEFSYzN1ZjFPYzN2cUVkZGtTODlxNVdkN0h2dzc4Y2ZIc2VHRTR0MHVP?=
 =?utf-8?B?QnNDT00rTkNqeTdKWGZqNHp3UEl2cER2bExHQXA1WWduYlpZTGx4TmhjSjdn?=
 =?utf-8?B?czNoYllMd1o0MWk2SVpyd00yVlNkWUZOU1R4QkJEWGwxdHl3MFZuc2pxY0V3?=
 =?utf-8?B?eUNkQ243UitOREFBdE11emo5bGl5dEMwRHRiNGZRNjZhNThkUDRHWWlCSlha?=
 =?utf-8?B?Uktvc1E5MXRoVVFORi9NODlaSkVLWndYL1pVWFIzNmtMRk15WDd4bmhmWkpG?=
 =?utf-8?B?VEFtWkgwVVJFbUgvamVjalJUM1ZxdXp0ZFpIbWVBNkNFWXVNSTkxckg5L0Rt?=
 =?utf-8?B?dXdYQlNJWXBUQ24yTXFOaHBITmE4Mm5WV3dMTEo1V1pxN1R5Q2RLSjlqWC90?=
 =?utf-8?B?VjVSTDZJUmVJRGxpUTV5cW5PSmVPMlVub2pPZ1NmOS9sbkFKa29xVzB6Q3Vp?=
 =?utf-8?B?b2FjMWRIZ1k5S2NPZmZ6bllMQXcybjN2ZmJSQnBzY3ZrUlhMQlpVOXE4Q1NK?=
 =?utf-8?B?ZEJBekg1ZmUwVkpBcnZDc053eTBlYjJnSlVXTS9MMUlxWlNGYjFoWmlBRlkr?=
 =?utf-8?B?WUpEbU05YThCbzlaZVZjSHNUNmF3eDkzMDZubmZ0dlRSWGwvYWFrNVlIemFj?=
 =?utf-8?B?eURLanliQnl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amEvRUd0L3lLOEwyR1pWZTVweUJWZjBldFM0K2s5RTNLeVI4amdESFN6RTlE?=
 =?utf-8?B?d1NOV1RIalZZa3FHRi9uUGtndk9yTFdSL0dRS3BDUTFMRnlXNWV3WGF6a3E4?=
 =?utf-8?B?QllTai9EMEVvcnpFT3ZuSXB5SkZRTlVCaURnRGc4eVkzT3VGRUJCS2gxbnZu?=
 =?utf-8?B?RWVlTngxdzNub0s1RkRDUmdYRWJUdnV3OU9KOFhpNXR2bHpocWUyRnQrUk9J?=
 =?utf-8?B?cFNzMnB1VStRQ2R0NG5reHZXWUg2RXNLTmNXcFNBV2M1MWRhZkdtcTJhZWx5?=
 =?utf-8?B?dmdoOHViZ3VOOEttd0tqTWhpTXpuT09IMGtBQy8wT09TN2YzSjVqSzBqcGpS?=
 =?utf-8?B?dmVEanBnT2l3UnhCbW14REVwbDBZZzRXKzlsWnV5R3ZNODgzb3lIb05xelkv?=
 =?utf-8?B?SUlxUmV3SHdhUFVPeVFRWG9ER0x4N2xEL3djUGVSckk3M2ZjYXQxcHdXQUZy?=
 =?utf-8?B?aGpXV2RGbHZ4NGFkYm5hNytNYXFjSm5OS3JjT0Z4OW4rbFpTOGJQMEVhZnpo?=
 =?utf-8?B?dHMvWmNpemRWdkFwbmN5dGxzcnRDTExpbTI0SXNGdStBalpra3d1VDFiYnp3?=
 =?utf-8?B?NjJlOW1pM0pkMVZGV1RPSXhUaDdlb202OWF6anBPV0hTRFR2U0JhWExKNHNN?=
 =?utf-8?B?YWx0SjdzWmlFZDh5eDg4STRBRlkweHJXNExDRTdNNStvYnR2STJaNkppZy9j?=
 =?utf-8?B?a0FucEtyT1NZSmJHRjdscTk2TG9XeUN0ai8yNHowSUNaWEdKMmUzbWdMVEEr?=
 =?utf-8?B?aWpReUg0RGh5d1I4NFc5cGpZMEtHaThJZ2hyTFBob21tUHN5eWhuRzgyUFV2?=
 =?utf-8?B?SHdHR2dXRFZOREdJYks5VUh5OHZ0ZDR4RWl5ckwvTzlidXphTmE2MTdCVkFq?=
 =?utf-8?B?S3ZjVkdBQThkRWVyVUR1TEJXWDdNTEhmb1RMNTZnTmRVRTd4RWRjSjVuVmxr?=
 =?utf-8?B?WU5FZXNxeTlZUFJ2U2xqamwxWmRPVHdib2VZc3VmVVlrNUpaNzJvTHAyTE9U?=
 =?utf-8?B?TmhWUER5K3pVSU9sUkprUUcraHpzUHhkenFlSXVGSW9ONlQyU0pmS1d2YnZK?=
 =?utf-8?B?WlBleWNaZG5lTEhZTHVScVc4Q1RpK2JOeUNhTHJrRVhQaTVCeGliNHA3RXFR?=
 =?utf-8?B?N3k1WWl1VTgzSWhQK2ltbjd5MEtCRlZQQnlrbEd6eGFmT3p5WjNBcHJpQlRU?=
 =?utf-8?B?Zm13SncyQklwK2V6NGRTQXlVa3N0U2NpdHEwRG5aOWVtWnpOTHkzckdWb1BT?=
 =?utf-8?B?YUVtNk52Y3Q5Nm5XVW1Dd1lqdkdKMDF5Z0VuQ3pHN2xOeTJtdEtvQ1FGVTlW?=
 =?utf-8?B?NEtOR3NEa0FnN2plVGRhVWVRS1RwVUg2eUJQcmV4Wlo2QWhtUXg5dDFBQkl5?=
 =?utf-8?B?dUNPb3lwZXA1cGMzVGtTdUs5cWRFTXNTKzNueGhjREZaY3oxNUZWajlyZUVj?=
 =?utf-8?B?cENDQzkrMVA0b0M0WjhObWRDdXJrUTh1SE1HbXRMeHF3T1p2dStFRXkxUllS?=
 =?utf-8?B?RjFmVGFnNTB6ZjFqRFBXcldCVXhpTnQvcDdBdWwyV0JDcmdTbnU1N0MrSWps?=
 =?utf-8?B?eG9tUjBBbm1UWGNrVG5zMk1FK1A4cDRlTkRNTW5EOGZIWW4rTjlReThsU1Zn?=
 =?utf-8?B?di9hWnlCNVlBbHFYVTlvemlLcWpPVkczNWxkVlE3ODlkeUdkNUxlalBpUzBM?=
 =?utf-8?B?QkdYc0F5alIxNzhDV0x0YnJSMGNhQjZTZ2JjcXZBVXZvaUNrRHJFRE91Qmlm?=
 =?utf-8?B?RWxKeXY0Tk9zVFlEZGJtSlFaT0dxOUwreGFLUkxjS0hYbmRJU1duZ1M1QWEw?=
 =?utf-8?B?R2E3YndpOFVoZmRydEFXUVQ0ekFuNlB6d1BNMDdrbEc5S0svcFF2dU9nMFNa?=
 =?utf-8?B?VTJaTzQyYzd0Vy90T0pRL0tnUkF6dmd6WDVIYWJEUi9qa2NURDh2TDdYdk9u?=
 =?utf-8?B?U0xBRzYvVHJmaVZwZ0JkSng2SlJ1eVNBR3hGT3cvV2Q3Smt0Q2VPTnREMk1K?=
 =?utf-8?B?ZFYvNjNWTHplQzJOL0EwVllwU1FWWXBHWUdzaG9BYklxcGhRc25HYjh0STBk?=
 =?utf-8?B?MTN5UU5EYXBWb0xrUzFKcENCV3VFQ1plL0VXOWVlN2M4Mkx5RmFpRzNUdnkw?=
 =?utf-8?B?KzRtUEMzOWhITkdCSm1ENS9ZbE9PMTJKcmlOcFd5RGxKRjRTSm1FMFJEWjQ2?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A529D0A10246E248AF5392664A9AE56F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hdIMIHhSX3VCjdlZhQS8ooMfmUu7i8DLbktE0kz58UVQAP+b6PjJJ1Gz51uGmqfaZTqUW6FTZ65z0QbpoICSATOE4+XMj9ihO+UIdsROInSFaTAHNSGQ4cbHpm28WIZn4knN24BuK3MDKMdPZ/6B4n6JuhjpVhcH6d01z0g796kjzI/J93/NNMPNrChNee2SuL6dfgvBjDViNKmsMfRD7L7GZD3pndPgzofg1GI6SZxSv949ZM5Qc/VMColtTrky4kiwoywPqJH7L1QIBLviqpvV9mL51AxMYBVl+/zi0OXbdAtt/XRemsfQ2QUykSTOUT06cBFaG1msFF70TnZzNlvWnvptLQvCXW89ZZHDl0nTjGQ6AYXX2DS26foNxU+yXmRrnptLoJdFaiXDeiMBshOnhrtT+aPvJuPUF9oa/wXHNDgBUjr0nxwkMIPDnJUnz0fHPcibYUOuHIx6ZR6qz0NIRWJ2VVDNAEg9lFRnvX5x4V2cJHMxpA8zFYSgxpxzy1nNIKVfL0QGfY7Aln7Yw/retZVEdPtQvxEr4p4gN8t2W2yHluSzI8EXxOupf1VVtS5PKdY/7+CSV1MdsTsMNJdHiG01fg18TpF3rNBOqF5O00mHSgmNCFSfVWD4qE1g
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbabb8d-9fe1-4a04-7172-08dd563665f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 07:22:59.4914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXfftgBsAnJQ5kGE0c1XrLS4pNMjS0/i9NxBMDRueshd5IO/M+kbvdLuxGUdb4U3Q4QUCHpJOpX5V7phipM+Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9400

DQoNCk9uIDI1LzAyLzIwMjUgMDc6NTAsIGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29tIHdyb3Rl
Og0KPiBGcm9tOiBBbGlzb24gU2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4N
Cj4gDQo+IFRoZSBDWEwgdW5pdCB0ZXN0IGN4bC14b3ItcmVnaW9uLnNoIGlzIHNraXBwaW5nIGEg
MSsxKzEgcmVnaW9uDQo+IGludGVybGVhdmUgdGVzdCBjYXNlIGJlY2F1c2UgdGhlIHdpbmRvdyBp
cyBub3QgZGVmaW5lZC4NCj4gDQo+IEFkZGl0aW9uYWxseSwgdXBjb21pbmcgZXhwYW5zaW9uIG9m
IDMgd2F5IEhCIGludGVybGVhdmUgdGVzdCBjYXNlcw0KPiAobGlrZSAyKzIrMikgcmVxdWlyZSB0
aGUgc2FtZSB3aW5kb3cuDQo+IA0KPiBSZXBsYWNlIGFuIHVudXNlZCBDRk1XUyB3aXRoIGEgMy13
YXkgY2FwYWJsZSBDRk1XUyBpbiB0aGUgc2V0IG9mDQo+IENGTVdTJ3MgbG9hZGVkIHdoZW4gaW50
ZXJsZWF2ZV9hcml0aG1ldGljPTEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzb24gU2Nob2Zp
ZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4NCg0KVGVzdGVkLWJ5OiBMaSBaaGlqaWFu
IDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KPiAtLS0NCj4gICB0b29scy90ZXN0aW5nL2N4
bC90ZXN0L2N4bC5jIHwgOCArKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9j
eGwvdGVzdC9jeGwuYyBiL3Rvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvY3hsLmMNCj4gaW5kZXggMDgz
YTY2YTUyNzMxLi5lNWNkODc0NjE0ZDIgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3RpbmcvY3hs
L3Rlc3QvY3hsLmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9jeGwuYw0KPiBAQCAt
MzMxLDE0ICszMzEsMTQgQEAgc3RhdGljIHN0cnVjdCB7DQo+ICAgCQkJCS5sZW5ndGggPSBzaXpl
b2YobW9ja19jZWR0LmNmbXdzOCksDQo+ICAgCQkJfSwNCj4gICAJCQkuaW50ZXJsZWF2ZV9hcml0
aG1ldGljID0gQUNQSV9DRURUX0NGTVdTX0FSSVRITUVUSUNfWE9SLA0KPiAtCQkJLmludGVybGVh
dmVfd2F5cyA9IDIsDQo+IC0JCQkuZ3JhbnVsYXJpdHkgPSAwLA0KPiArCQkJLmludGVybGVhdmVf
d2F5cyA9IDgsDQo+ICsJCQkuZ3JhbnVsYXJpdHkgPSAxLA0KPiAgIAkJCS5yZXN0cmljdGlvbnMg
PSBBQ1BJX0NFRFRfQ0ZNV1NfUkVTVFJJQ1RfVFlQRTMgfA0KPiAgIAkJCQkJQUNQSV9DRURUX0NG
TVdTX1JFU1RSSUNUX1BNRU0sDQo+ICAgCQkJLnF0Z19pZCA9IEZBS0VfUVRHX0lELA0KPiAtCQkJ
LndpbmRvd19zaXplID0gU1pfMjU2TSAqIDE2VUwsDQo+ICsJCQkud2luZG93X3NpemUgPSBTWl81
MTJNICogNlVMLA0KPiAgIAkJfSwNCj4gLQkJLnRhcmdldCA9IHsgMCwgMSwgMCwgMSwgfSwNCj4g
KwkJLnRhcmdldCA9IHsgMCwgMSwgMiwgfSwNCj4gICAJfSwNCj4gICAJLmN4aW1zMCA9IHsNCj4g
ICAJCS5jeGltcyA9IHsNCj4gDQo+IGJhc2UtY29tbWl0OiAyYmI2NzAwNDkwM2NmZDM1NzEwNzUw
NjU0NjY5YTc3ZTcyMjNmY2Qx
