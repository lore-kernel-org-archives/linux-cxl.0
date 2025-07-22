Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD7281526
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201460; cv=fail; b=oy4iiKOSBxa969TWZ9dt8hji77hqU22iL1Gb2O8CDo2a4ebtil1TJ+93Wtd1YcTEOM8Tz5XOSeVPPBB+aemA4Sb68Ae+Id86G35TLlVuG1A4X/Ow2Hbjmc09VtP+4Pl2+f8rHL+mxU01OA3DmCW9NsWsTStJNnG52Otgkx1v8Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201460; c=relaxed/simple;
	bh=THF9ZXGz0Edd8r6VKeMVu2JzhLWrINIYzmx3q6edWSM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Q9JVsYjmPBPNHru/zrd35FF4JkWzAM0KsvgTRJHQ4vbIrYNGBKKsNedm/6rWmKKSWD2dQWq4BDUNH1e6jfB9y2wuSM19UiafgfAopuiUJA4NmXhl0Itq6Byp+smCfZh08G/tQlWwOrvkO9dyO+dDFXJpnPYQoPYE+tNScDbVoH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrHxdWak; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrHxdWak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753201459; x=1784737459;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=THF9ZXGz0Edd8r6VKeMVu2JzhLWrINIYzmx3q6edWSM=;
  b=MrHxdWakH8loN5nZNVGUBM7ikkn0zBnWWlqoiYM3jn2CfiCgjPncKqCj
   PEE1T/99PFuxVm/wfqUNWJNbhylqcQYi+nx4EIrnQyjjLdOZZWUkKKH0z
   qyrVR8Gjfp7BBVn7GIUyLQrYJQm9ZY9DA5TJUem+Xs3lUH/we4ZaM2S3Z
   CIhvoXhJ/z7TfPvqpQxQC+LOQxj9hywOND/IGv7aOJbRgT6CeeuAhvm7v
   12dx5IRBtCUVtEyFu/2EK2Q6Rcl8B3QjXKaqSfqv5XXgcPqjRjRreJTVJ
   QqQu0AYukVCIarRp8SfoeWweA2u2WIsRHwGH0Q5b6GA7Fz52R1e1NG8lu
   A==;
X-CSE-ConnectionGUID: gaTOgFArRBmXVqTrPpyOBg==
X-CSE-MsgGUID: CS+r21RwS/KY9NH0CkvWmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55554937"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55554937"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 09:24:14 -0700
X-CSE-ConnectionGUID: nLCIC9ouTUC53YNgWgcuBA==
X-CSE-MsgGUID: uPzzjqTuQxa/epakB8WJrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="158491415"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 09:24:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 09:24:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 09:24:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.40)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Jul 2025 09:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/ruQHtO1MzfygH2u9nBTqt4N2h1ZvlxMwREoCjfxRmPoatcV/HgfZu4KFackT0POXc3LprHhqvpqyHB/TlE7UbkEQnw7MJSjuH5p2Tss0joaLCT5+FMHO2eHxabSzPHks2xuHx7zX7M9BlcWhy5wRdCwf7RdaZj/29QynJR64OV608vWOJ23vEhzu7otXehcfog7Vx/UtxclB3ccAbu2nVaTIxEsH0b2kLsXfFF5QULa9HtDtiNFgrLmqfkkHYuir7lLaEQZh4Tsude2CrBUmxxrH82bcbwMNCMpDyDCsSBVBcKbFwxi+Zdl1b1M6OudO2Imc1UoyjFOeo7ZY9PnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THF9ZXGz0Edd8r6VKeMVu2JzhLWrINIYzmx3q6edWSM=;
 b=wlC4ivwQt+vofIPU40JHLpwhqdSa9ZGo768IX1kh9YA7dkkwuIHWu5LqyPuOQVlNvLTVfGadf5qBpSngUblAAUyuGgybymof6Q23lZ0F15J2fLjynqIBLXVwQE36xg3ydNOwCSldb1CZFoDln4rhZulQtoujddlTvj//qh4MmjJLMcb0EHbAWqpRMM2YcfvEpY1EAErnBwHeXTcfhjKcbwYZln6eFuNmH3b7XKXgMRwGz1pDHXqmRrSJ/3Uh4aV7M0cvm5rXGJoTeBbhYzf1x+8KUHVZ1AnzKuJiMtPioCss3F7FkJxE6yMl1PS5dDugVZnw71Ho81C9TNyDVkZm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 16:24:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 16:24:08 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 09:24:06 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <687fbb263b892_134cc71006a@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714223527.461147-6-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-6-dave.jiang@intel.com>
Subject: Re: [PATCH v7 05/10] cxl/test: Add cxl_test support for
 cxl_port_update_total_ports()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: d36259dd-4b43-4631-a462-08ddc93c2f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDFTSzVBWkxQaVlqeEFubEhLcm1vVUl5cTJpT2pYOEk1QU1CVjExUFpRRUtk?=
 =?utf-8?B?UFJYSnE0OEVmeDdNNmVIZURVQlNyVlNodG44dFFIeXhPcS83K1FpU2NMVGV0?=
 =?utf-8?B?cTV2YURQcU5xMlAyNHc3d1BGaVo1Um5ta1VLM3QycVBYSzQ5NVFqNm04dWt1?=
 =?utf-8?B?QzRVNjY0bVY4RnEzMFNTb3BlSDBWb3lvWW84cjR1bEszVXlNU2RsL3Y4Smo1?=
 =?utf-8?B?OW1WL2w4VEV5MWxxMVJLbHV4Qk9WNHRXU3NacmFKd3lFOE45UVlWUnlsbGdu?=
 =?utf-8?B?RmxIWFNLa1NnN2ZQeS83dWd5b0tPTnR2bGFLMkV6SjFPT003bitwN2l5Q3hs?=
 =?utf-8?B?UGExaC9palJqSFpOU2l3YU9JVUdaQVNtT0kxdmEwRlJUdUdHS01IanJOUVAz?=
 =?utf-8?B?SUNkbk5QN3JqNHBUd0FORGRDUUhHTFcwbTNBTGxydGxFM0VyTWxPbDJnUjd6?=
 =?utf-8?B?SEtDcURBUDRpQ2ZyMW5OWTFlWjJ4WDFVZE10U3lxRlgraXczOGR6dkFrN0FT?=
 =?utf-8?B?Vk8rUE5EUW80RWRrdlUydmhkUVZrclZ3WWVadWNLVkIvUG00b0hHMC9QOGt0?=
 =?utf-8?B?TENRMHlGdDVLcmhOMitqdmp0T3JsOTI4R1NRVkpmOTVYaE5kaElMbFZUMFJ0?=
 =?utf-8?B?eXE3Ym1TUTE4Q3AyNVFMa2NvZkh3SDFkblRNUWQ0aWY2STFBRGxJL2lnVUQ2?=
 =?utf-8?B?eU5Fd3RaU28rUUsvL2c0MlhLYnI1U3ZudTNBdXVVaEQzbGxLRW5nL0hPajJP?=
 =?utf-8?B?bTRRS0xaaDJadzVmbWp0dnBjbHVZUVd1SGcrTzlyYmd3c1BuS0NHTDByL3pZ?=
 =?utf-8?B?djh0VHNOeEVWQzVZVngzZnBkZUg4QitiNW5yZ21qVjROTDdwUDFVMUZMOE90?=
 =?utf-8?B?QXE5cCtHTUozQkdLN1FxcTNraUFDNytKTGpydVJuS0RRV1JpNDRCOVZrbjJQ?=
 =?utf-8?B?cnZ2QTF2TDF4cldWK2N4K0dMb1BOTmNQQ2lqZy9WQ2dYNHl5WHRNSW0zTGVE?=
 =?utf-8?B?L3pKL05TbmMrMWVUOFRpZkM4ZVN6VkxRekRubm1EWGk2eUJiTElCQ0RxSXpL?=
 =?utf-8?B?R3pGWTljUGxWMGpicm5Nck1UMlVOVW9GNUJheTVLN2hXVmRhQW5tU2k2YW1v?=
 =?utf-8?B?RVRUb2o1RFF2MFkxL2hpVXZ1TXlGOFBQOXFQdnFjaitXZ3JYNk5kVHpRcEtG?=
 =?utf-8?B?REJCRDlDY0hSRG9DNmRqS3JOeWlDZkFpeVRRUDZ4SDJPb3RMUFhZTVllK0t0?=
 =?utf-8?B?bEFPQnk0ZUZ4OHNSajY2OU9sVWxkSDZpSGhRUCtiWndpN3NjaXdXUWw4TjAx?=
 =?utf-8?B?M1NQdUdYWkdKNUlsM3V3R1JTbTZQYjkwOVhQaHIrWk45ZlUxMUJ6RlhQTWNx?=
 =?utf-8?B?OFAxbXBiQzA4c0JNd0Jmek1uT1duY2xQd0kwcW5Ienk2NGZTUHFjL2ZJRmp1?=
 =?utf-8?B?VmIvd3VxZEtxWmtuNUFvZVczRXBZemRrSWpZTGpDcktmTlYwdlAvb2ZjTzNC?=
 =?utf-8?B?RWt3VzJ5bDBFZTlHS3V5V2tXTmVGRTd4UHhkeXpYUHRQN1FUVDl6YUpkUlpP?=
 =?utf-8?B?clYrLzlZSGF0Y3pWMXhtTmlIMlJxendKb05reEpGY3h3Y0lKQi9mdXNXTFdk?=
 =?utf-8?B?ek0xTXprZFMzN2g3eVpxZDNRT3EzL2xqL3ZYM3d0YVp5eGZhR09NSjZtUDJa?=
 =?utf-8?B?ZVhVSE1aZHArUTNqdlpCak1CTC9hV1l0VHo1UUpnNVhRWnZXNkpqSWowcGtq?=
 =?utf-8?B?NWhWdmRXNmNPTnAySGhvMytIT1RoYTc2MlFqUWx6RHpDbitUZmNLRTlHQjJN?=
 =?utf-8?B?WkVjN0xxV1Z1QkZtN1JaYlh6ZDI5ZXlOcnhXdWxhdXVvcnVPTERuMXdlRk5U?=
 =?utf-8?B?WVdYcWNvUGhTZE1GK2xrWDYzZTBhUE1GclUvU29oN3Ewb2w3TGdUQ0Q1alRE?=
 =?utf-8?Q?zZiK+grSLcY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTkrL0dvbXJFck5ka1pmWGxIR3FlZUZ1SnFiNjhySU91R1kzZDBZdEZoYk1Z?=
 =?utf-8?B?ZWhPY2dWNmt4MUg2SHVhb0VITE5LaGpzbkZIM3A3a0Nsc2EzQ3N3Sk1pcnc3?=
 =?utf-8?B?VisvNy9SdjNKUUwvRkNPK1JuaHJjMi9GaWJXUFkxc1l4L2RVcU9CaUJnZ2R1?=
 =?utf-8?B?SC91d01PK2RTT0VvempEU2lqRDA4cGJ0SllIQ0ZCZlFEcE1mZnM2UWFjQnJN?=
 =?utf-8?B?Zmw4dUpxb2pOUDgydk9ZOGt0QjY3TUxiaDNxcW5iR25RMlh1ajlmOU5BeDM3?=
 =?utf-8?B?U24wOU93bFMwb2l4RCs1RnFKRHkveHJucnlOQmpMMEJqc2F6dzVJb2VveitP?=
 =?utf-8?B?dnpvZjI4bnlPL2xkcWp4Y1pzdlVsWXd2UnRqNUhTVjh4VXJ2OTJka2lMRTR0?=
 =?utf-8?B?MGhzWVlJd2RaV3JxcFBWYlJ3bWtGOFJBamc3ZzR1YThPNnhVSnJTY2pHQ3R6?=
 =?utf-8?B?dzg2VGpia0F1WmU2WWtmbytnYkZ4MG9QRERZU2syQU5nRHM3S1JHdXhaSDJt?=
 =?utf-8?B?cHdmaWY3UTlTT1pxQUFlQy9lb1hsbjVoYnV3SW5lNUVuZWVMeDNGZ1U1ZHk5?=
 =?utf-8?B?K05yRUxUWHk1RWNXQ2x1Uk9oYm5pbmZ2SmNWL3Q0YXpIUGRRamdDMjA5SnNw?=
 =?utf-8?B?RWhMQ3lZUW9BNFBqRVRuc0NYMUVIdW9LbnQwZmZycnJJNTRSS2VUVHlCYUo4?=
 =?utf-8?B?UUJPWE1iUWpUMm9UTTJEUjdVQkYvVEZGR1Q3RXNlTWJ0bWhib0IrZDdFcTZH?=
 =?utf-8?B?RG51NE5ITytwaHV6YURiaEgxUzMwM0lOVUE1QXVURFpRcUlZL2JISFJrRW9T?=
 =?utf-8?B?L21RUzNMNkNHeEM2ajQwQm1yd3dSdjVRVlVoeUY1cU1pbkswaFkyclY5cjNq?=
 =?utf-8?B?VmVTOEswNVhUb3FuR3RlRS9wMVVzRFU2S1M4eldNT1JDNDJmWURKWlRPMk95?=
 =?utf-8?B?a0d4bnp1SFNSczl0akY5ZmZob1VPOVNzbkVMMnJ0UUtsMXRYWEloT2hXcmNq?=
 =?utf-8?B?Zmp4VkRkQjNXK3RGNy9ZRzM2VUFuUG03MTZrdGdUTHJKZ1dvY3NHREpXa2h2?=
 =?utf-8?B?SU03dWNITGtGQlpnc3lwR0IxUmdtaHdLYTh5UWRMcXFnTjArSENsblBVdlZK?=
 =?utf-8?B?UU5UNk9KV2xKVXNUdFcxbE1id3NjZ1NVV2JrTmhjQVVmWTRTeDEyTmxEeFM3?=
 =?utf-8?B?NDBzbDhKMml3bzRMSGVseHgxU3hEdTFNRU5sUzU0WWZBak9XaGgvMmNxNEk3?=
 =?utf-8?B?cWVxRVFzYWJ5bWRuM0hMK1cvQW15WGU3ek80WWVZdCtNR2FyOFAxTXF2YjJK?=
 =?utf-8?B?R1o2Tlptc1R1ZjBaTUVhWHRrQVErQjE2QjBTTWlpSFJ0MHBHL3FrWkVNbzc0?=
 =?utf-8?B?OGFDOTYzOWFaWENDUzJXNHcvQlA0WXZCdXhGcEVkbEZZaVdZbldqbWxYL3hx?=
 =?utf-8?B?clJrUnRLVUhrVWhLUCtGUW9ScWdGQTErYnJtYVF1dEdSYVZzV3lIZ2t3U1dS?=
 =?utf-8?B?QkMzRlZjcmRDcEk2OEU5WW9qNHZVcVRNOGtXaVlOL0Y2ajVMZ1hDdjFuYmtF?=
 =?utf-8?B?Q3NGZkVSSmFkK0YzNUNLNGQxOTVEVjJxM0NXekpOeFVteTZpMHdqdlczWGtR?=
 =?utf-8?B?RUsrdXNPTjJjTzBwZU1LMWJNUTVaK2pwcW80dFJETnlHWlg3TUovSGp3TzhN?=
 =?utf-8?B?MG5yRWp5SnZRQ3ZYb0ZiV2hnbUhoMUxhRmNmUEZGRUUvTFBmdUhpc1N1NVF3?=
 =?utf-8?B?Z285L3BRTmRTL0tGTldhYXhsOHcxWU5SdmNhZVlMV1hvZitoenZ1SENxK0E2?=
 =?utf-8?B?UGpVSG9ublV3aWVyclNJVk56dmpmYUh5TUtLZndLbE5GUzFTMHN1QmRFTGlK?=
 =?utf-8?B?ZEN0K2RXbE1qR2Y5S0xNRC9KUm9MRUZjUVpBODVBN3g1YmVyR2ZuQkhXL0FC?=
 =?utf-8?B?aElxNlQvSG9RSGZQTndWc1RKWEdGNVVWc2VrSzVpTS9RYlE1aEZMbS9MbjRs?=
 =?utf-8?B?TzFlZHFhUVlQcnJzUUczY3V5L3F2YWFyY2VMaW9QSWpQWWtsOXdWaUUwUWxU?=
 =?utf-8?B?ekFzdnlkYndZK2MvK0RCdjE2RElNS2ZoVWtVTEZmSExiYWFsck1hUGt4YXZS?=
 =?utf-8?B?aDhBSkREeWNwWWlmNmNKQU5WTEJIYUdDVkxlb3V0ZmM5bkE3cDZURDFRaVZO?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d36259dd-4b43-4631-a462-08ddc93c2f35
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:24:08.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kctFvWIo2SjTvm52zlOhU+aMh1autZeP/MA03GMpxzbcqUgKfKo93oGjqCe6t/aeWenGiGrRFI/TuvQFJ6NL8yucIKyQ4PQt0WnRolofORM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8478
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> In the delayed dport allocation scheme, the total number of dports
> need to be discovered during port probe. Add the mock function
> that does it for cxl_test.

Looks ok, but this coming after the core code adds the call means that
there is a cxl_test bisect break? I guess there is no clean way to avoid
that.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
