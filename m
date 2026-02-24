Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59E2417C3
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902051; cv=fail; b=Qp3L2ANioerb+71cIv++HXT+4ls+YOMCjaKF5u9vrdfkbN2dmEPqH7hVfZH9QdFbzKPKzEKlD79dTOrThmKlgJrs5w/mBHSsLPge2WijA95WY5HFQIJk3Ix5A3v4xzMVvU2AI3x6ghu8LmKIBeTcLObs6I7SblhKg9zv0VWX814=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902051; c=relaxed/simple;
	bh=/l/0OpvJAgNYHKceTbCQqJI7oSyyXcokTByHkQwgPJ0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=QbZC8RwMi58xcmjmPUOCJKUsW6o8uHfCX2mJBiWG5Dwrcn0GDD1QBXBJa1x6fOFr445Dnei3qvaMzC9FS32M4pvU9lLJNXPW2Bgj4T1gBeLoiMC5By8bT4VEVb0wz4kPBieacHgz5QeuQjJhm7IalsZmMBrhJczAQc14JPdkV38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Imt8mm+Y; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Imt8mm+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771902049; x=1803438049;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/l/0OpvJAgNYHKceTbCQqJI7oSyyXcokTByHkQwgPJ0=;
  b=Imt8mm+Y1//Mvv2FdLLDvN5paFAlb40kkQ15o3syPzaTFYeo+ifubfTg
   Vk2oSaM8kfpspXnGT2Mxk6ndPlrcJ6Fi+rtOouTyCA5/79mTQhbfeMNkd
   Q4nLaOP3neGv8rIWzJp9l11RIQwS/f/VfSsbRU+o5yfzQxi34rfWW7o91
   4KsyVulv5PlJbWLiwLV2xjLNqbEftqOhMlqDRmb2UHjK4KPSyG46Z1Bqo
   hLfUZJpINoVrXDeT7o/txtE9TbzlTx7yTiBwmOYy5m7pf4BolOsfCUcG8
   wPMC2+ljhHG8+B7ZAS0SaKjmZ4IWHnvh89eezhC5n/O+qNwLZk7HYXlex
   A==;
X-CSE-ConnectionGUID: nYVnvrg+SZygLxIAfDYqow==
X-CSE-MsgGUID: 4WdKrPLuTn2NyYB5s/Y90A==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="60485736"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="60485736"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 19:00:49 -0800
X-CSE-ConnectionGUID: w0lMjyApSR6c7ProtG2VGA==
X-CSE-MsgGUID: juUvpfJGSVOIRq7gqrvdoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215616683"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 19:00:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 19:00:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 19:00:48 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 19:00:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnq4gObDjK8UBgMZhUXB2BagKxrg/BJ8K+JBi3XtWd+5OKgFcDPjoeRArr4HOjoF8K45zpgWQ7JePJ9ezF4AXtuVrhXJw1oUKUmlAte9ioeEZPAt6nl6R8ZeZ1t+6or+R2gNH9GtnUm/K2ZzsG120yFw5pLbO5XZD3nXcwSM6ao96tz2BFwTEX3sB5S+hv44yXmliLLVZuQMTu23Lho8AeA70bMJ6/SCtPWbPaQV2pqVuaglIGWJOGLW7E01AZs6s3qO/PDeCqGu5/dsRH2WhBfwiKP7R45Hl43hPP2hi/7KcaC5ZuDJ+xwW6ZxdbZVT6f/EWrjEd3ni2h0ROR7A+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IteQH8C08YPkzJPDLtkbwv9tRA+jsdBl1xbPqqu154=;
 b=iA17ceMuedAYJb5GXm8jVTuTdChAqXQdIbsm9TwSWoQfUzOiBt4J3eKUZW5IlI0cQCYA9fcjTyUJRY8K8mD9A9LwV4Nem9+U3d9ocIRjJ1aCF5Mjc55ILd2wAneDMU9nPq++Dxsn11fXpXxWmmirEmuAlrm3kKH2ufPwvp+4EInp3Om6o+egcNd+LqJfiui1M685y8n8LJo8+whqBkJp7gLzP1tzFFi2KcHng+F1lYFyYIVVEU3R4zxnnE8Qt8PDPsRNW7X4GB6vXeHBk2srj4M9/ftfvWzjYMnazj/PRp88/Fgs2+bPh9dSxq+MIb1hBifcO2Lxn6G7YzIVv+dsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7117.namprd11.prod.outlook.com (2603:10b6:510:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 03:00:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 03:00:45 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 23 Feb 2026 19:00:44 -0800
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>
CC: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Message-ID: <699d145c1da21_1cc5100e4@dwillia2-mobl4.notmuch>
In-Reply-To: <20260224023609.1059138-1-dave@stgolabs.net>
References: <20260224023609.1059138-1-dave@stgolabs.net>
Subject: Re: [PATCH] cxl: Handle ERR_PTR endpoint in sysfs-accessible paths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 81588af6-1bd5-4f03-8c4b-08de7350e793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWdteVVpakxVcXpUOUNydnRTNnQ0OWZXM0RDY2dXN2xkL21mWUZDQmxHSldQ?=
 =?utf-8?B?VE8vWG9jTWJQbGVjZlh3OG1XN2hVWXNwMzhyTVVHUncyYmlMem8yeGd4UkV3?=
 =?utf-8?B?eXFGeWtvdXdJeWs2NTlVOHVmRnJ3R2RMRHNuL3RUM0Nrb3BidHhVaEFmVEpw?=
 =?utf-8?B?dFMxUlJYcmw5bzNaUXFOV2xWY3ljTjE3aURoaVVOMkpHZlgrZDNEL3ZlUVkv?=
 =?utf-8?B?Tlh6UFNZc2pyY3pKR2o5cVUwZUlLNTI1Y0VDWlg4QTNTY2xJWE02bEhlMFMr?=
 =?utf-8?B?RXBJeFRQenp2TXY0WlpqVkZpd0VQMnNmVCtHYWVtdFBZLzNqMlFRZThOM3o4?=
 =?utf-8?B?VHpvTEFSZE0wTVl4TUZ3STArekRMVmVyaDFpWTZ5SkRndGgzK1JHOHBHMVZH?=
 =?utf-8?B?TS8yRnZuLzFhdzhvRWN1LzhJL3BkTG9aL2pSYmVtUVhnM2VuS3BWUnEvUUtV?=
 =?utf-8?B?d1k4NVFNTVhYUnZib3FZSGhVNmd0Qk9JZGFqVnEvcXpIVnA4Mk9BTmE0MktL?=
 =?utf-8?B?dE01VlRZQjNiVlpmMnE5MXlCQnRkdkhLM1RVUFdhYVg4SkRFM25FWlRyS3U2?=
 =?utf-8?B?VXNBRWVVUkE3WVVFZnRBL2tSRUp1WmoyWVVPQlF3a21yRWU2SWJWdzB3SEVj?=
 =?utf-8?B?K1ptTFlvdnpqZTZYRzJydXc5Rnl0aHpabGZNWmIzY25NMDRmNGROY1c2U1hQ?=
 =?utf-8?B?MnFzMnM1eFJDV00vSmxSeDdCU0Z0dC9aejdCVVhJM21uZmVMaDdWTEN1SW1G?=
 =?utf-8?B?ZGRrYmFUbkgzWVJXUUM4cXlvdWFZSnIzOHRRZlJMNzRGRGdzMnF4Q1VvT3Zj?=
 =?utf-8?B?ci94TkZHN3lrZG5uanpCVEwySm9zdHI0RklRR2dJRHZIR0VGME9aN281a2Jm?=
 =?utf-8?B?b2MzWlBCNXNKUTIwZUo2L25KTUNDWkJ2Q3N1ZmhjQjZIZDBmTmVWUUo3RDlD?=
 =?utf-8?B?VzdrSWtIZFdiL3ZtRHoyZEZWWllMeldJTjNrQ3NQamNwbC92NTdnQTczYWV2?=
 =?utf-8?B?OVkvcFVibktsZzBHQi9ZL0F2OER0ZXhWWmZSWFk5U1R5ZkhST3k0L0tJQzVU?=
 =?utf-8?B?OExXNDNsdndSTUxRbVpvNklraU9ZS0ZMQ1JpUWVNZUVHQWd4K2Y4RnlERmp4?=
 =?utf-8?B?ZzhpM2kxeWFwVFMybSt5OTE5eWlNaWVhRmV6L3hPM3ZjK0taRGNGc0Jhc3Bw?=
 =?utf-8?B?QlJiRXNGL3NuMEN4SXhEMS9GWFRPVDdyNkVmR1EvRWtidk5UYit0WFdxWEhx?=
 =?utf-8?B?RXZKbGI4TDVhQnF0UXNIWWJjYy9qTkZnTmgwVGdaQmlVZ2ptR1pCN2l4dTha?=
 =?utf-8?B?Y1pRVm8wdGJHQ3lhMWRCa2JuU0ZFL0tpZHNsaUVCSDRTU1NDZTRTMzNDaG90?=
 =?utf-8?B?U1c1c0FpTzhzaGtsWTFWeFkxUTFXTC9OUElyUWUvekxLTXVsOTg3ampuM2Iz?=
 =?utf-8?B?UjdFTVdpZFUxZUQ5WDZvRTZrQ3VmNHEwbVZ6QUgyVTd1YnJXWUdRYWZ5aE5r?=
 =?utf-8?B?ZWJCUGlvSGV2d001dGxuQnZFSk0zZ0IyNitNMG1PT0NMdmIreWR5bkVtcWVa?=
 =?utf-8?B?YjdFNkhQSjNNalkydXdZVlE2RzAyQStmenJXM2NjNTZoNEJveEg0eS9XYUtS?=
 =?utf-8?B?L3hrRGhRdkxKdkUrMTBRRzF6dWlVWFlwbjJoSlV1cTlLWm1LYytVb3FmZEpI?=
 =?utf-8?B?ZloxTDJBZjlUQzhQdzlPeThocXB5QS9pYUU3bUtOa0lhb1VLTGFObGYrcktN?=
 =?utf-8?B?b0hoa3lWS2NpTjkxR0NSVkhxU0Y1Z1VIMVJwZ3JGS1luSHdXUG8wWmNhZ0Fs?=
 =?utf-8?B?R3RoQmZvaDg5QzM4dWc2bllEdjVsUEhyRmlIV2srcEtPL0ZBaEJhbmpNOE0y?=
 =?utf-8?B?a3BLS24zbUxQSW53T0ZtcjdMcUtvK1h3ODY4bnlqMER4cG1rQmR0alEwNDFa?=
 =?utf-8?B?VHljOTBHMkk2V0NZb0VzZm5ZR2tzK3VaZEMzZCswZlN4N24xMmVtaWwrM1JP?=
 =?utf-8?B?dGR5RnVJUTMxN3JLT1RLcllBcTlnTUxwV3hqZEVXakVjVExRV0J6OGxYNkw5?=
 =?utf-8?B?dE05TGN2UDBsRktLNkJsZ25oMVVuN2ZtZGJyaVFwbS9hNkNSTGhtVUE2VXhu?=
 =?utf-8?Q?pM5gtxvukxkcn//JqKSK6aTWR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU84dWttVkFBRnd0ODRzcGE5K0FYY1k1NmoyV2t3ell3bVVlQ3lwdHl0aEtv?=
 =?utf-8?B?Y3VFbnRlYUtIQUZxc2ErQ0xoQWpPYllDN1c4SHZMd21uTFRNZEgrK3NXaWxq?=
 =?utf-8?B?Q0M1WDhoMjdZR1RmeElNaGg3bUk3dWFSTkN4QVRLUWF2ZmZ6Z29iN0wveFVD?=
 =?utf-8?B?Z0Nrbk44d1BYZkg0eEI4L1hQVXdpRGcvU2ZxNVRWN0JwcWlldEI2YkZqZ1BT?=
 =?utf-8?B?bmg0a0VjY0VwQ0cyVTh0VmI5dEtyR3IyQzBTZ1dDbWJLNm1IbjNpWGJnQXk3?=
 =?utf-8?B?M0xtOUhGNk9PSFZ6SkwrYmlYZmlKTVo1SnVsRG5tS25zUVdkVW43dkdDb0Mx?=
 =?utf-8?B?Yk0wV1ZuUWhZSVhSNGlPb0M0by95MFd6eFJRVVlUSk03OGFXdTFyRHJ5MmdX?=
 =?utf-8?B?RUhPbHlXcEFnMFpjTTlRYmc4ZEpVS05RZGxhalhLNnVmdkZwL0Y1bXgzWmxu?=
 =?utf-8?B?ZHlNdG5pT2hjMC8vQ2NxNmJ4blVGOU52aUV2K3Rja1FwdmJ1NDRITEE3QWpk?=
 =?utf-8?B?cWpneVRzOHYxK0svekZaZmlwV2RMRmZQMzhDekhBTktiVkRoVFpoS1lYN2ZG?=
 =?utf-8?B?MlpZeHQ5VG1MM3pQcENTZmFaR3JuajB4RTQwa05JTEs1eDlqaVR1VjJaL2Ur?=
 =?utf-8?B?WUlHZmFQbHhWN0Q0SW4zMHR5eEhNNXNiMURyYndqU2VIdG8rS2MvUWFPZkNh?=
 =?utf-8?B?LzVVMktPS25KZTdnUGRtZ1grRmw2cmRwclljdzltd1RRejZxdUhoSzdyaVZJ?=
 =?utf-8?B?YTFxTXhuZUFyckEra25oejQwcnpHL0lSYXRhdzZ4TGRxcTF3RXZXQ3pJVG9L?=
 =?utf-8?B?OVRJOHF4YitMc0JPYjVPTWlHRHJhT09Sb0dBSzVBeE9qQnRUWVJQbnVEUS9v?=
 =?utf-8?B?emhLT2lmdVJEa3FqRHZjZExsR2J0UXY5N0EwT0RWb1lDUDNZOUp3YTBoNVhT?=
 =?utf-8?B?aHRzalIwMFVhaWVOekhhdUk2S1Faekw3a01HcjcxenhIclQ2K2l6MmxuQVNG?=
 =?utf-8?B?VzQ5cUtDY1pKK3VBaHVIaUVlWmxkZGowVWplcXFscHVRaGhZZ2R3WnNoaEhi?=
 =?utf-8?B?a0VudlZyNmVDalJ0VU15dEZVamNOVGxkY3YrUmJCeG5Ib0FFb3F3bTB4MmNL?=
 =?utf-8?B?SjJCTUw0WXJRbk02NEx4ZUFWK05DKzJHSU5DbDBpUDQ1bnRQUER1bnNpTVVL?=
 =?utf-8?B?MlBQNVdsdmFYREFaOWVnVUJzYzBtazRFbEc2MmxmdDZ2WHQ4SFdubkFBaGJq?=
 =?utf-8?B?RVhSRk1jcTJ2OU85N3NCcHQrb3Y5Vk5Mcit4S2FoaGRiN2lyd21iTEtTSGZE?=
 =?utf-8?B?NnJDNVgyRitNVklla1JYMWtKQ0E5aWpHM2h1dXJraGRNYWRjV2JMYzRvWjEz?=
 =?utf-8?B?UXFYQWUxbzJrRk4yM250M2w3UklUbFYyeTJxd25hTUc0ZC92RjM2RXBzeVZx?=
 =?utf-8?B?emRhN2thdnpBMGpZQzV3Yzc1L1c2QUdSMlV2dXFBVDlWSEF1MUJFVkFoV1Ni?=
 =?utf-8?B?UDlXZmNoMzRNczhIUmpRSnpNbWJKOE9xOUtEeUV3bFNNMjczVDZRWUFObzNN?=
 =?utf-8?B?aGwxU214TVA2aTduTllodnVHZS9ISjNlS2sxd1dCOGM5RWxhelN3NGh3UXp6?=
 =?utf-8?B?YW1vUUhiUnYxWUd3OHRXLzg3RDV4MFNnUkdNcVJLaFZZLzlHcThGenlQRG8x?=
 =?utf-8?B?cnI0OTJqUUhqTU1nRzhBQW9WVkpTQlNDSjZueDRLbjU4YnpONzhBR0ZFamJm?=
 =?utf-8?B?MzhwK2tOWnNwSnJoOWlXSDExa2NtbDlwbFpJVkpVaGo1N0syV0tqUVYveTVJ?=
 =?utf-8?B?RkFtZk5jYUF3N3QzY3hWQk4wNnFLNk9qTDBBVDRqa0xWd0JrelMxWGVucEVj?=
 =?utf-8?B?U1MyVW1aaHBxTk1Yb0pEczNwV21nN2hTT2lkWllZME92V1RoSXJTQW9ySWJW?=
 =?utf-8?B?dnlMR2k1THBoVnRGRy9SMGNaV0pJd0dKK3N6TVpHalp0S3B0ZGxEOW9UYUxn?=
 =?utf-8?B?dmVhM2g2WHIvaGxDQVNzRDkvZThVVCtHbmlBNFQwbVR1OFFOVlBhbXNsQytS?=
 =?utf-8?B?WGl6NHEyNXdiRWFaU3V5cXpOODJ6ZDFlSkl1eDQyM2tlUktnekdiRllkallm?=
 =?utf-8?B?MGl5NVI3bXhLNWFhUEtObFpOQUROalh3WEtKemVzejNsOThYSnVFekdPclBz?=
 =?utf-8?B?L3R6TkxPY2VnWFIyK0pSSkN6em5XR3k0bFVGV3hZMVVJOUVhYVVvbUdONHVR?=
 =?utf-8?B?SlUveEpGakxSdkVQYjhCQ01QVmZoWm9ZbUcwVjAyRXhSU0NpdWVDL3dGMWZS?=
 =?utf-8?B?eGVUbVExVUN4L3pCYVU2Y1hoWEVQblRLMy84Q0g2c3BFRGlYQm8xNVZOb1BF?=
 =?utf-8?Q?tJ3+5Iq6zd3Njog8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81588af6-1bd5-4f03-8c4b-08de7350e793
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 03:00:45.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrBt7echjadCwTr0FScWbHD4+0k5/nlDNmOEN+aRaLQTe+lKs3aU2NI+mZaVC7qZ8S49GkgUL6T5LfzwDBMRdv0wDtlJyi/qbA8DdxZVzuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7117
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Fuzzying CXL triggered:
> 
> BUG: KASAN: null-ptr-deref in cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
> Read of size 4 at addr 0000000000000642 by task syz.0.97/2282
> 
> CPU: 2 UID: 0 PID: 2282 Comm: syz.0.97 Not tainted 7.0.0-rc1-gebd11be59f74-dirty #494 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>  cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
>  cxl_mem_sanitize+0x141/0x170 drivers/cxl/core/mbox.c:1304
>  security_sanitize_store+0xb0/0x120 drivers/cxl/core/memdev.c:173
>  dev_attr_store+0x46/0x70 drivers/base/core.c:2437
>  sysfs_kf_write+0x95/0xb0 fs/sysfs/file.c:142
>  kernfs_fop_write_iter+0x276/0x330 fs/kernfs/file.c:352
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x5df/0xaa0 fs/read_write.c:688
>  ksys_write+0x103/0x1f0 fs/read_write.c:740
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f60a584ba79
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f60a42a7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f60a5ab5fa0 RCX: 00007f60a584ba79
> RDX: 0000000000000002 RSI: 00002000000001c0 RDI: 0000000000000003
> RBP: 00007f60a58a49df R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f60a5ab6038 R14: 00007f60a5ab5fa0 R15: 00007ffe58fad8b8
>  </TASK>
> 
> cxl_memdev_alloc() initializes cxlmd->endpoint to ERR_PTR(-ENXIO) as a
> sentinel until the endpoint driver has probed. During that window the
> memdev sysfs attributes are already visible, as soon as device_add()
> completes.
> 
> Use IS_ERR_OR_NULL() instead of just NULL checks in all sysfs paths that
> use cxlmd->endpoint to avoid the user prematurely accessing it.

Ugh, no, like I said here [1] I think endpoint non-NULL @endpoint
confusion is an indicator of other issues in the code.

[1]: http://lore.kernel.org/69813ac070f79_55fa1005c@dwillia2-mobl4.notmuch

> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/edac.c   | 2 +-
>  drivers/cxl/core/mbox.c   | 2 +-
>  drivers/cxl/core/memdev.c | 2 +-
>  drivers/cxl/core/region.c | 3 ++-
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index b321971fef58..65b37460d1a8 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1149,7 +1149,7 @@ static bool cxl_is_memdev_memory_online(const struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_port *port = cxlmd->endpoint;
>  
> -	if (port && cxl_num_decoders_committed(port))
> +	if (!IS_ERR_OR_NULL(port) && cxl_num_decoders_committed(port))
>  		return true;

This NULL check was never valid. How can a edac code ever encounter the
port detached case?

>  	return false;
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e7a6452bf544..f2308db13c5d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1301,7 +1301,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	 * Require an endpoint to be safe otherwise the driver can not
>  	 * be sure that the device is unmapped.
>  	 */
> -	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
> +	if (!IS_ERR_OR_NULL(endpoint) && cxl_num_decoders_committed(endpoint) == 0)
>  		return __cxl_mem_sanitize(mds, cmd);

This looks to be abusing ->endpoint when it should be checking
cxlmd->dev.driver. The rule is @endpoint is always valid if
cxlmd->dev.driver is non-NULL.

>  	return -EBUSY;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 273c22118d3d..f0a97aaaaf35 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -236,7 +236,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  	int rc;
>  
>  	port = cxlmd->endpoint;
> -	if (!port || !is_cxl_endpoint(port))
> +	if (IS_ERR_OR_NULL(port) || !is_cxl_endpoint(port))
>  		return -EINVAL;

If you can trigger this, which I do not think you can after Li Ming's
recent fix, then the proper fix for this is in [1].
 
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 42874948b589..5ff5a086ca0d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2956,7 +2956,8 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>  		.dpa = dpa,
>  	};
>  	port = cxlmd->endpoint;
> -	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
> +	if (!IS_ERR_OR_NULL(port) && is_cxl_endpoint(port) &&
> +	    cxl_num_decoders_committed(port))
>  		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);

I believe this was the exact issue fixed by Li Ming's fix.
