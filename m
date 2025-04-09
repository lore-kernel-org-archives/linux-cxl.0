Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BF442C
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170686; cv=fail; b=dZ3Xisls0qjbeJnICoLnweSiiuyJllcpGtfXqe21EAKFqwTaUvH1MULBohO5g+IovG5Tudtausgk3HF7bUeDiipwvzZSLPEUuaeSQGV1VGz6o+8O66nHQE71pvZhhpNumpvJU1XwLVxokQOokkN5JaPEJdMOQGBADAz5r61tfvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170686; c=relaxed/simple;
	bh=RLQ+fFHd2VvAAE6aJ3U54fpxv1KMRebbKGmOhUKDJec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SftQ+1jClaN8BG4dj3w6jGeXN5yRTnCXCj73sUQZWz6XmvRJSnteFDnWy/R5nbN6UxDPcwLr+RMeZ2xFK81a5QH0wUR872x15HaObZXoi7UBEzyYkH+GybJeTAPP3Ff4NCBuAx05KtsmFoTdzuPvXWXFwHVBoqLHpGIoNBfcaA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3nmu1gO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3nmu1gO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744170685; x=1775706685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RLQ+fFHd2VvAAE6aJ3U54fpxv1KMRebbKGmOhUKDJec=;
  b=j3nmu1gO58+KZKWkrGXfpPKkvYpm2AsaqRY/hntMDFh6SgfP5bQuYf2i
   Cf2ggk7uH63gdtJjQpOl3Vzaa4mcvr5EdW7Rz6ED3vZFPBuNXvkLVsAHB
   H+sfyMzn4uMXaRzOpcbgqXOoCY7WE2cIpMGNsHNNBbg5uO7LoN2n+6LW8
   VqyQZ11Z+s4My8rjD36QRubIA6odnAMQdH4SUWRMdy5eVsUUVKQV6u+LL
   A3y5wWAIydulMP7rDL9f+EpS29XQGsWfi8D9ZfyM2ser9BWf637ht3n9A
   e3hPPJuEXtXDg6/4zeMopvuvcxN4j3a/EKv0Y7Co4uOJegG9DTgiXMUva
   A==;
X-CSE-ConnectionGUID: MbNi/rOXTuWGGvtcrqjP/Q==
X-CSE-MsgGUID: nqvm1I2+R2aSDTdf04acag==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45718673"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="45718673"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 20:51:24 -0700
X-CSE-ConnectionGUID: zvWuOJ2aQ9S7/tL102XZFA==
X-CSE-MsgGUID: 39t3On5wSh6DzsmQKrovIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="133583995"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 20:51:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 20:51:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 20:51:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 20:51:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeGIqW7qewfQk4bhBonZQG/5ituK4GPQVj4ptTU5E8LUhI2EdGFL8ltg0VFvhReCe+PjApNaiePfyntBGb2xM5xye6aFFimDGlLuk8JyiQctZ6BVa1qCW/zfgew6Y5Sd5hxm1o2rIbSPuLvfao2NZa3HCwAYhWW5zABQSo7NQSKu6qFTehHz8Fm8pTpVyQKMheHaoSIgOvUbKvhlVITQBqfdGnQXm3GpzYObsSbMroYHaw0UOmadErXbef+l1g2Y/F2p0pvG7ezCDv1wuZI2mozGtzsF/488Fi4Yj40X7jUCDiQZpmQOMgc18lt7PFs9ct9lEnjq2HWkruzMusmmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLQ+fFHd2VvAAE6aJ3U54fpxv1KMRebbKGmOhUKDJec=;
 b=d7pdfAwhvR40GLTpk0ZHepS/OCUjAY4fzKFOPCBeyOk0Vd8mUHqjSJVerX/yWml40VGw4mIbP4PlunPGXU3rACXra1c6uO82ShjgyiOfQs7AMrK3mlgiUl34az9K6sVkbyd2G/XV9IvZiW50H9YIYjEXvLzziDLzCT3VxZCe9JvVm6S58kUpgsev6zmYGQ4tT3OVYcZpTeWmEa8pct2BpLWCrPQazJvLMVeVtQYXVP5WROF490SIe3FXk4RH2+/94oV+eKta9kheJaX3K6yhOioy55nXJJYy9BG8Bje2bUtuivhyA/tF/UHSRGgGlUQvwxUJoThxVfC2DK9P9O1fJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by CYXPR11MB8690.namprd11.prod.outlook.com (2603:10b6:930:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 03:51:05 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 03:51:05 +0000
From: "Ye, Huaisheng" <huaisheng.ye@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "Jia, Pei P" <pei.p.jia@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Thread-Topic: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Thread-Index: AQHbpubq+9CWdaenhU6/yZQpccJG97OX4QqAgALVytA=
Date: Wed, 9 Apr 2025 03:51:05 +0000
Message-ID: <DS0PR11MB7458082D603DBB5E741CA7669FB42@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
 <02fbb2a7-3973-4c7f-8b7d-cfabbb379467@fujitsu.com>
In-Reply-To: <02fbb2a7-3973-4c7f-8b7d-cfabbb379467@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|CYXPR11MB8690:EE_
x-ms-office365-filtering-correlation-id: 6ae2f903-9018-47c0-529b-08dd7719c140
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?clFQeGY0YXJNc3luTWVUQnRTdWlidG1oZkdVMTNCSXQ3TkJSa0VxTUtRMnQr?=
 =?utf-8?B?cFBuTkQzb3YrdnZrL2tST0lreDVpZ0h4TnU0RkpMd3JJT1lMUW9sV005TXNr?=
 =?utf-8?B?cnhUMWRZVE5lWWJBNCthdkJRZkpoK3UxNXRnam5tdlNBNXZ2c2xWbWFETHVV?=
 =?utf-8?B?YTUvcXJnN1R2eElaNTh0MElkZWMySEppOE04eGZVS2xReUw3R0hiOWRhR0JC?=
 =?utf-8?B?V1Z2bkc0MklIRG4veDBYRHNSOEhGRk9IUWRqTU1EK21JVy93SFhVaFluT2Ir?=
 =?utf-8?B?dEc5d1grR1ZtNEZEYzNTb2xwREhtVTFldjVRTVhzUDRlMEVRUE4rTk85bGg4?=
 =?utf-8?B?MDBxWkI0bDk1VmZNV25XRnJRMENZeE1nTEtjSWswbTVnTW9NZW5PZWRkY1lp?=
 =?utf-8?B?Wjl1cGo5MGlRbGlpK1B4OUlQZFEvU1o2bG4xN25mbzR1Q0FBSkc4bE5adnZG?=
 =?utf-8?B?Kyt5QUVNZUFBL3dLTEFhRzZhWG9jb2MvTXZRODJSc2diUlRJSlZjSXQraEp5?=
 =?utf-8?B?NVJIT1VXUGZYdTQ2TlpZNmh6VHJvc3g2K1MvMThVNS9UbTJ2djNiMUJoVStP?=
 =?utf-8?B?aXhraCt6S0dHaHFJdWg5SlNyUXVUNWQrclV6V1U1YjBUb2xXZE5DOSsvQVcv?=
 =?utf-8?B?NnczSnJSSkRxQkxsV1Y5M256bTFxVjExMS9VSnlJZVdNeGV1OUtLcmZlRWpp?=
 =?utf-8?B?UEY1djlhV0JPVUdUNURZUks2SDcxb2ZFd3Y3aVlsVHpKNFo3Um9DUCt1Ukwz?=
 =?utf-8?B?dWl3enJDMElmSjNqaXJTUWJwWk1OZk5DSHJiZWp3cHJoZWI2QXNxWVUxK3dR?=
 =?utf-8?B?NzFpWUE1Tjd6QVJ0L1pHZ0lIQXgvTEt4Q2JyVWs4YWhvakpqWWs4WVhsN2ow?=
 =?utf-8?B?a2NOS2FHRC8vU1M1WXpMYlhoWE50VmlmSXhnN3pPOHZybzJ3emhBeWNRNXQr?=
 =?utf-8?B?SVBReFhXVlpVYmZreUFJT1lkT2pDdUNOeVA3S0dEdDQraEd4eWF5a0NXYVl3?=
 =?utf-8?B?RDNLSW1DTllPMkhMM2ZOQTB6M0lIdkR0OVVtYXh2NEk0dHhmRGhWUFFhTzAx?=
 =?utf-8?B?KzhlSDZkTEFQci9kSFpacytJa1N6bXlDZHJKTEtxeUpCcTlXNFhxYi9UR3dq?=
 =?utf-8?B?SDREVDNJcnBHY0UwSExTSGFZU2hJVFJBUVdVS1pZZENQOHNxcFdkSmpSWmV6?=
 =?utf-8?B?bVRlOWFQdjErN0ZzRnBOcXJyVkMwZlFJMEE0dEY4OEpmcUpYMk9kc3FXWTVU?=
 =?utf-8?B?dVk2UzZuZG05SDh5ZWttWVVsNWlVQWM1aXdrNDRPcHlWcHFXRy9JanJkNnUz?=
 =?utf-8?B?cUVxS0lyYXp6RE5HUi9NZ2ppL1E5QWN0THJTSitydllkdXM1N3NicFhUcUE2?=
 =?utf-8?B?UmozcFBWcWRnYTBsUk5UTWxqYmQ1WEEzVVpCRDZWc3Nkb0JhaTBSNStpaWo2?=
 =?utf-8?B?UmdUQVphR2t6ZHhBc3p0bU1FR0Q2NWVvZkNKcjh4dnJidkU5RW4xTTlWS0c2?=
 =?utf-8?B?eWplZGVQTEJGcCtubTgrVC9tanhxR29PRkhFVS9jdWZFTUFDZHh4VmtpNjZ5?=
 =?utf-8?B?eFFhczR6RUE5Znl1RWZRUWZMazhjY0orNFh1NVJndm4yd0EvaXVrOFpPdXFG?=
 =?utf-8?B?RzNhdzBIVDM2T3FpS0FoM2RZUHMvZWVxbExlQW91TlpUbGFWRWJDZXFDQ0hV?=
 =?utf-8?B?djZwL3c5RjU0MWdUa2pwaFQrWm1icXpqMU1uanlrc2tGSmdpdWliY1p4dURR?=
 =?utf-8?B?UDFTWjc0VmFxZkpFallOd0VMNFRHeUFSbDhPRlk5M1ZJR21nVlhyUlZtV1pC?=
 =?utf-8?B?TWJ0VWdMZ1p5OVlvKzE2VktuWnQ0QXBWZzQvU1czWGd3REQrWEo2cU1teG9K?=
 =?utf-8?B?dmVCY2RwZ0puS2lnQVhVWUc2bWVZK1poZW9nTFBaZi9odnBFdzhWZUdBbCtN?=
 =?utf-8?B?SkhxQjdlRHFxVVRLdjhXRy9sVll5aDg1cElteVMzSG92WHdoeFlFR2pEenU1?=
 =?utf-8?B?K0J2ZEpHSk9RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7458.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGZneWV0bzZXYkRvQ0pBeUlYajhBUWdHUFE3WmozRjVEN2FNbEJzcTVyczlX?=
 =?utf-8?B?WU1UMU9NdktQZTVFWFB1Y2VtM2lHVGRESUN0Z0E4LzVHbks5ZDA0SWhuWnNq?=
 =?utf-8?B?anNDNDBwVzVPQlRzTTM2TTlNbGJjbjFFZ1JNcElhZTg0d1RVU2xwU2kvcklj?=
 =?utf-8?B?RVJxbDhLK2tIQlZrSTZoS0tEdkJOYjhFZUJEcjdYeUJNeE0rZjc4dm5XS3VM?=
 =?utf-8?B?ZUhqZDNaREZrdWJmaHBWK3JqbDNuMFRxcHJHVXRCQVJrRTJiaWpqYm45NW5S?=
 =?utf-8?B?NC9sdENoZGJTbzQ3TW1mNWFVK1FTZ2xOUG1ETDZ3QmtpVmhsQ0NhWVVnSFlL?=
 =?utf-8?B?MWQvMU9DbDFOUzlHdWgza3JOUlRobWlxZldvOTU5R1NoS09USzJyNWNnaTdP?=
 =?utf-8?B?YzRmL1dnVEFmTXk1VHJ5SG9tempNTmw1Yjc1UzBOTFBSd1V6MkcyejBmNzJp?=
 =?utf-8?B?eEVwVFBjMFpyRzJ4Z0gySGI0bmNtTnYwZlhuaENWVE4xTlYvSitmQklZMVlv?=
 =?utf-8?B?SzVLQ3laMmdqaVZmZFJBUjQ1b3JlNytWRENMTjdsbEVWYThOK2t4UFhsdXBL?=
 =?utf-8?B?Y2ZDOEEycGtld0FBcFpwdmJqZEFZNENxK29QSHBWMTBhbW5KRGx3WTNuWXdC?=
 =?utf-8?B?Z3RSOXFaVSsyK1NWV3ZJMEp5OGovSlhvUWlpQmdqWHRQZHJTRTZSMGVSNmZ0?=
 =?utf-8?B?NExQMVpaNXpYRVdiM2JVSGUxS1BFbnl1NGozc1gzbHFDUFdxZkgyYngxaGg2?=
 =?utf-8?B?YVpXVENYdnZmYThJZWwvMDVSdEdhLzUwUFBGSWVsSGJvUG1RMXlFdWhFUmd6?=
 =?utf-8?B?dks0a1RrbnBNVXJYYUhjdTl3c2hnSFhVd0pOWitZYUdXZjA4MTVZbU40WDlT?=
 =?utf-8?B?NzlEM3lyUGRGM3h2andLR1BFNFhZK3Q2N0hwRDFjNWxvQVBOK3BiNHBNbmFC?=
 =?utf-8?B?Rkg2R3FCTXpSVThyTy9MbVREazBxTXBHeHIrbTdEdFJKUy9qbTRzVFVPN0o2?=
 =?utf-8?B?bEJ4empOZWJzZ25aa3RRODlreVVvNmxVMkl2UWpabkhFa1dvakUxMm1RZlpi?=
 =?utf-8?B?UElaWXZXSy96V3hUV21lWG5rakk0b1FoQktOYldCSHZUZ0Q0Y3VtYkpHTG0w?=
 =?utf-8?B?RWNOaGM2UTF5UFErUG85c1Z5TXdjMkE0YlE5K1pHbTYyVmM4aXhXUFRScWNw?=
 =?utf-8?B?WitMRjlHU0ZJZUIvY0xRNS9nRW1xNlBpMUV4WG1jRklpckM5NXpJRGlQOS9z?=
 =?utf-8?B?RUFaMFJHVms0K2JZZlczMU4xQm1jQ0FuMisvZmJZb0RMM3NIMHhVUUJmaVJI?=
 =?utf-8?B?TjBxaGtwTVlSYVp4b3ZhdHMrWnBneFc5V0dzbm5pdFZZaG56Q205T0kxZ05P?=
 =?utf-8?B?bGQyRkd5Z1pjRnhzcCsvcGxiOG9Sbm8zN0tleS9jSlFMTVlwdkV3NUhoUTFp?=
 =?utf-8?B?dDJQWHhzRDNlQXVKa2k1RUdlWWdJTm9VSGFEQlNwclZUU1g3dTVocmhTanh0?=
 =?utf-8?B?anZIMnVCQmpyVzMvUmtQQlNCbTNFbE4xUmNvdWM3NWhxaXNMSXVuTUVneTND?=
 =?utf-8?B?dTdQSERmZHVwakE4aktBOVExajRtWitjcVJoN3lDUEtEaVYyWXpoKzV4MCta?=
 =?utf-8?B?QWVHYkt5dnhTTjZkMDFFTWIxSzBIUTFlYWJwZWxpbTdvbjJOeTRIeGpYSXlK?=
 =?utf-8?B?WGRDQ0ptcTJMYjB1RkZVbTlGUjJWME5MNmczV0hGanVHeWYzemdrdFh5UEsv?=
 =?utf-8?B?U1JSbHJUWDhvNEhKZW1Ec2hEL0hJQ3RjVGNKZVo5aGVpK3MvRkhMT3V6b29p?=
 =?utf-8?B?azJhTlZUN2hybmd5VXE4cHlTdmxzMFlHSUFtdHNPNmNXTXB0OXpLNm1qQkQ0?=
 =?utf-8?B?QjdaUEo5L0wzUjBPa01XODZYV3Fnd3FVRmhvdDVCRktsaC8vWjV0ZlNxZUYx?=
 =?utf-8?B?VUU4VTVPKzM1RkpmaU9GU2k1d0RpQ2xRbGp6NmhCVVh6ZUhuTy93U2NQTXBh?=
 =?utf-8?B?bW5SejEzdHVTRWcxMndoUVZXbXFrdEU0ZGk1MVlKL3BxR1B5N3J4K0JtbUEr?=
 =?utf-8?B?QUFPam1LVnpid0I2dkIwZXhFeTNsWHN5VXdYRVh3cFk5TEdlZHJkSFhFWUFN?=
 =?utf-8?Q?K+le5D2VPXJrO6PLXitV3U3a/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae2f903-9018-47c0-529b-08dd7719c140
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 03:51:05.6423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Anwib25GsM97pYTugo1Z+ESvsIKx+NCfsfdhAgdOP+rItR6cCBVDGoI0J8zmywvprJMy09bU9zQx8fgaiR4sOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8690
X-OriginatorOrg: intel.com

RnJvbTogWmhpamlhbiBMaSAoRnVqaXRzdSkgPGxpemhpamlhbkBmdWppdHN1LmNvbT4NClNlbnQ6
IE1vbmRheSwgQXByaWwgNywgMjAyNSA0OjMxIFBNDQo+IA0KPiANCj4gT24gMDYvMDQvMjAyNSAx
OToyNywgSHVhaXNoZW5nIFllIHdyb3RlOg0KPiA+IEluIHNvbWUgc2NlbmFyaW9zLCB0aGUgcHJv
YmUgb2YgZW5kcG9pbnQgcG9ydHMgd291bGQgZmFpbCBiZWNhdXNlIG9mIHJhbmdlDQo+ID4gcmVn
aXN0ZXIgKFJSKSBkZWNvZGVzIG91dHNpZGUgcGxhdGZvcm0gZGVmaW5lZCBDWEwgcmFuZ2VzLg0K
PiA+DQo+ID4gICAgW2tlcm5lbCBkZWJ1ZyBtZXNzYWdlXQ0KPiA+ICAgIGN4bF9oZG1fZGVjb2Rl
X2luaXQ6NDQ3OiBjeGxfcGNpIDAwMDA6MTA6MDAuMDogRFZTRUMgUmFuZ2UwIGRlbmllZCBieQ0K
PiA+ICAgIHBsYXRmb3JtDQo+ID4gICAgY3hsX3BjaSAwMDAwOjEwOjAwLjA6IFJhbmdlIHJlZ2lz
dGVyIGRlY29kZXMgb3V0c2lkZSBwbGF0Zm9ybSBkZWZpbmVkIENYTA0KPiA+ICAgIHJhbmdlcy4N
Cj4gPiAgICBjeGxfYnVzX3Byb2JlOjIwNzM6IGN4bF9wb3J0IGVuZHBvaW50MzogcHJvYmU6IC02
DQo+ID4gICAgY2FsbF9kcml2ZXJfcHJvYmU6NTkwOiBjeGxfcG9ydCBlbmRwb2ludDM6IHByb2Jl
IHdpdGggZHJpdmVyIGN4bF9wb3J0DQo+ID4gICAgcmVqZWN0cyBtYXRjaCAtNg0KPiA+DQo+ID4g
VGhpcyBkZWZlY3QgY291bGQgYmUgZm91bmQgd2l0aCBRZW11IENYTCBicmFuY2ggZm9yIGEgbG9u
ZyB3aGlsZSB3aXRoIGENCj4gPiBzcGVjaWZpZWQgcHJvYmFiaWxpdHksIGV2ZW4gd2l0aCB0aGUg
bGF0ZXN0IGJyYW5jaCBjeGwtMjAyNS0wMy0yMC4NCj4gDQo+IFllYWgsIElJUkMsIHRoZSBtZW1k
ZXYgY2Fubm90IGJlIGVuYWJsZWQgYWdhaW4gYWZ0ZXIgdGhlIGd1ZXN0IHJlYm9vdC4NCj4gUHJl
dmlvdXNseSwgSSBoYXZlIHRvIGFwcGx5IHRoaXMgcGF0Y2hbMV0gdG8gbXkgbG9jYWwgUUVNVSB0
byB3b3JrYXJvdW5kIGl0Lg0KPiANCj4gDQo+IA0KPiA+DQo+ID4gVGhlIHJvb3QgY2F1c2Ugb2Yg
dGhpcyBkZWZlY3QgY29tZXMgZnJvbSB0aGF0LCBiaXQgQ1hMX0RWU0VDX01FTV9FTkFCTEUgb2YN
Cj4gPiBEVlNFQyBjb250cm9sIGhhcyBiZWVuIHNldCBidXQgaW4gY3hsX2hkbV9kZWNvZGVfaW5p
dA0KPiA+IENYTF9IRE1fREVDT0RFUl9FTkFCTEUgaGFzIE5PVCBiZWVuIHNldCBhbmQgYWxzbyBl
bmRwb2ludCdzIGR2c2VjX3JhbmdlIGlzDQo+ID4gbm90IGNvdmVyZWQgYnkgcm9vdCBkZWNvZGVy
J3MgaHBhX3JhbmdlLg0KPiA+DQo+ID4gV2hlbiBlbmNvdW50ZXJpbmcgc2ltaWxhciBwcm9ibGVt
cyBvZiB0aGUgZmlybXdhcmUsIHRoZSBwYXRjaCBjb3VsZCBiZQ0KPiA+IGVmZmVjdGl2ZSBmb3Ig
c29sdmluZy4NCj4gPiBJbnN0ZWFkIG9mIFJldHVybiBlcnJvciB3aGVuIFJSIGRlY29kZXMgb3V0
c2lkZSBwbGF0Zm9ybSBjeGwgcmFuZ2VzLA0KPiA+IGRyaXZlciBkaXNhYmxlIE1lbV9FbmFibGUg
Yml0IG9mIERWU0VDIGNvbnRyb2wgdGhlbiB0YWtlIGl0IGFzIHRoZSB3YXkgb2YNCj4gPiBubyBz
ZXR0aW5nIGluZm8tPm1lbV9lbmFibGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHVhaXNo
ZW5nIFllIDxodWFpc2hlbmcueWVAaW50ZWwuY29tPg0KPiANCj4gVGhhbmtzIGZvciB0aGUgZml4
LiBJdCB3b3JrcyBmb3IgbWUoYWZ0ZXIgcmV2ZXJ0IFsxXSkNCj4gDQo+IFRlc3RlZC1ieTogTGkg
WmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiANCg0KVGhhbmtzIGZvciB0aGUgdGVz
dC4NCg0KQmVzdCBSZWdhcmRzLA0KSHVhaXNoZW5nIFllDQoNCg==
