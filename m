Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796939571E
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112186; cv=fail; b=Do/XErAkC6mgWiQ3r14csX0RWmWSKBSqwSQKuch29iMP1nKGdXqfO3Z3jPj/eguDhK0f4TVjrOwCky90FBt6SyGPQbwjmeRn6tO6wgGcpY7O2FlKaRDfeCwMU76oas5RUp9oFSm0o7HYoFUmwAOLzWBAs3Sp1cA/1Muv5zX+9Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112186; c=relaxed/simple;
	bh=QttVJeUsy/NZ+Um+HtdwxB/BLXjBjCUIJGtgIGsKyZk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=RoHASOXo2AT580POa0hINmFmqI7SIqrRwK9ZpcL5rbqnJWBMpL19KMGoPCBz/9LdnWlQkT7yFrc8fReSPlTSnqGvQybsQYJLTis937QR/iEg0LpcCnskt8TiCC9POK5m7/GNe2SCFJcR+dK+9SpGhmGiJxqOzlLgZDDP7lQmF3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmL4u4lX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmL4u4lX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769112183; x=1800648183;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=QttVJeUsy/NZ+Um+HtdwxB/BLXjBjCUIJGtgIGsKyZk=;
  b=QmL4u4lXPi+ozRaoZe2i1kLBMP9D9q13HWfWWECglapcBelPlBFnBLzf
   bUC9Qnqltcb8AeyHT1XvJf1iVMPox5f839H5a+srrMVgSirwJ1KoCGnxc
   XzLOFP2iS7egZigEyrTmpa1nNCb8FfTs3/IQORnm69tad+gS6e8qMplpc
   YAmrWGqj/AEeoiyQTevERXLsXjsyeOC3/rmLe8bTHGcSBj8XwkKwlAM8N
   tmD6ajgjisQwWec9MYQWkM9ESty2ajK3wSPlXsecLWT5NbTW6c06I9wkA
   l64bfLvVDoN7X5prvcuo7Mp22Lz19A8tgRHZetEaWFgHQ3NE6psGSvg2w
   g==;
X-CSE-ConnectionGUID: /j6wZ2XCRzejl9oKOrE9+w==
X-CSE-MsgGUID: At224ds9Q2mpM5WF+dmThg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70455976"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70455976"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 12:02:56 -0800
X-CSE-ConnectionGUID: LqHvpWfeSWapPRY6lYrIMQ==
X-CSE-MsgGUID: QlF5k9qHRVKsmXxowMf9lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206418338"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 12:02:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 12:02:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 12:02:54 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 12:02:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnHbCGJcHd4Q4pBj1YM2XqS3OpQLAHZeU8MiKg3dVV2WRqJV/bmmVc5df9OWlFk+ecKidlavbB5RyMTwewvKggvjcjRip3785QhoT9keueECaZZNQK+46Fptjuune8VhBknqKwq08WesCGJq/0g/t6VmxaQCBmwF02VAGy6SLTAv6rJ8CqgNtZfTTYa9qhje9LtJRPtsyyVuzZsKCjfzgenLRUUFUlmVnht26S0L+dMz1fy7PxDj7LHEVIUltWYhYlBU0p/Jf42oNDrBq0uV+IRh5yBMj97gJUyieMAHvNwxRrMtpaFp7ZbJRz9EEpN6k8YWAyJj9ckTe5BPO3C0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDZC5MLrUqMpXf1x6dxsci5bP8flI/npnoV3NruUrIc=;
 b=TFk+KRuLEu4EdJ6DOXsJxSvTZOHGc/VKGxr3AewrbN4+Yp8R9Y6//M3VabwfObFzTlRV+RFbMMc8lxAc+hqb9dWhZcyFXtGBYjTA5guUj+yTZrM0L1CookIyOvRqssHsMzzfTEg9HWnNdw70yElN+kpaExqAo0liC6fvCRKt18ArgI0pabRPuoQaMHNpNQ3EQ9adYVMC0bJoD1660ZgzFgH67C9Q57iwNVeWhQr5n+3VkhOFFYRBIYrnR901ewTQxUPTZrb20AYzuHuu5mD7sN7+GOe4aL6myOM/8HGb6sZ2Isy07WbmC5Z4qio227pmisaUsRQZsAhfZ+rGhbYVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPFFA27DACA6.namprd11.prod.outlook.com (2603:10b6:518:1::d63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 20:02:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 20:02:52 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 12:02:51 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Message-ID: <6972826b162bf_3095100d0@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122113906.000028d2@huawei.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-3-dan.j.williams@intel.com>
 <20260122113906.000028d2@huawei.com>
Subject: Re: [PATCH 2/9] cxl/port: Reduce number of @dport variables in
 cxl_port_add_dport()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPFFA27DACA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a310d2c-e8ef-4569-b038-08de59f139e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTM0eTNTdENhZjI1bHpGYTFSZnFoTitFMUV0UzVkVlp3VHRJUlRRMHp1eWhl?=
 =?utf-8?B?cm1XMDVjTHVDeHQyV0hid1h2UFhEdnZ0RVBsclBUTEtmVGtFeTl5OXdyY21F?=
 =?utf-8?B?aDNIN1lvMG91NXdvVFJMZjJoTW5raXN1UTB4UVhBeFkxSWpQTjlIK2FFNDhw?=
 =?utf-8?B?dzZFczhWMktKWHAwUURNbHdtcUJFMS9XQklkSlNCSmI1Ri9sM3ZuQUV5Z2hV?=
 =?utf-8?B?Q1ZtMW1Fam1WMlQ1bVNsV3lNWVhLN0dJa1ZaQVA4d2M5T3NpV0ZXZi9zaVlS?=
 =?utf-8?B?ajFON1pJd3ZGWWUrNVBGTmlNdG5wWENyaGprS2ZRR1ZaUDRVYW83Qyt1a1lC?=
 =?utf-8?B?RjNRUm5jNU4rYVQ4N29TbjhCNDdqN1dGeG0ramJmZ0M3c2RwR29pZzJ1Z205?=
 =?utf-8?B?bXRNUVFHNEJHbEhXL3JZZCtENGs5NTdPeFYvNWNCT3ZhWHI4UXpaY28vSytn?=
 =?utf-8?B?TEFUbHNoT3RBWkpWRFErM3dob2x5clVmVlRHOWVSOVRCTkNHbmNObzBLVUZa?=
 =?utf-8?B?S1N4c0VYRlZseDcyQndWaDMwS2xnQ0lNTDRmVTJyOVdOdEhCbGxkQTRNL1hr?=
 =?utf-8?B?dytQUXdSTzczQ1lNMnhQUkdXMGpYcC9od0JEWHpiamJPWU5LQy83d0FocGIx?=
 =?utf-8?B?WmZEOHpDRkVUN3dMUWVPVHYrZlZqTFpyVXRHUWtCREtWRTM1TmFnUmN4bXRK?=
 =?utf-8?B?YThDQkd5ak9XQXZFYUpZMld6Z2YvN2NEREFEam01UllEVHhFajFGNFVmOFly?=
 =?utf-8?B?OWJ5VmE2TlBXcitRZTdIVTFKN0JtTlNTU0hVZFVJZiszeXRMallaR3JJZzRi?=
 =?utf-8?B?Mm83em5yOFVSLzBaT0hMLzlYWjVLajh0NmRscnJialdIQ3VpUm1FcG4xMEpW?=
 =?utf-8?B?aFhPZ0dtUytSL0NhUWlvemFvNEdWSUYrWGZTL1l2MWFOeFIrcDFybEZTd2VL?=
 =?utf-8?B?YmlZci8yaHkra3U2c3I4V29mb256TG94aEJQQnk0S2NCZk1RcnU5bWNCTWUz?=
 =?utf-8?B?R0lSWC9LUHJ6bndtQTRWYi80Z1EvcE5WaVk3YzB0QkVKazlwcGNqY1RIQmhR?=
 =?utf-8?B?SVBFL0EyY2V3RnYzaFRpdVg5STJqSitMRk5Pc0Rwd29ZSVZ1Ui93djhlS1d5?=
 =?utf-8?B?ZWJBMnJidENFWDVVVDdCalhBWmNmSVpkRWZEUUFnMXJMbFZ1VVJhMVNSN1VL?=
 =?utf-8?B?c09adHhJWHloL1d4eFRYOTQ2eERaOVI1dkgwV0RsVVZpeDBFZDJVRTVNRzZs?=
 =?utf-8?B?QW5Xa3F1Unc3V3BXL0Y1anZheXhpa2I4eUd0dEh2NDhxYWdhN2JrWFdXd3VD?=
 =?utf-8?B?SDRwaWVmajRUL3I5cDB4UG10TjQwbXBzV0pLc0FXSTlCU0RRVTA5Nk1qNmRo?=
 =?utf-8?B?MVBweTQxRVNUTi9xR0NEa0VMWHZqU1JwWGFLWkQ0ZTVGTnpJeVE1YVlBYVMx?=
 =?utf-8?B?eUxoR3hncmhmbml2b29CcERDdjRrZnQzS1FZK2NaeWFNMUo0UjBkRi9ZdmNr?=
 =?utf-8?B?RXplU2pWMDlsTFI2VlFadC96Y25QV0JIVVFCdEFIbVpaUXBWRFpxVStGYkZk?=
 =?utf-8?B?YitaRmlSKzRuSDRZbkRoYWxPMEZwekYwcXpDdW92a21RMUZkL0VhNlJXd2to?=
 =?utf-8?B?TWZOOXg1V21UNUxhbzBoWGlHbTVpMktzZ2wxcDVtL2NvcDNZTWJUTVY0bkp6?=
 =?utf-8?B?M21ZbDJPQXNxS1h2ZHMvNE1sUk90aXFRZm9KakF0ZDltZW1weFhNekhtSDk2?=
 =?utf-8?B?b3NmSHZlUmRnUkREVUtqN2V2QTBLU0JMa0tCbm9EQU5OcnRvY3FSSlI2emU3?=
 =?utf-8?B?aUhUZ0ZnZTNGVzZ0TXB3WW1ZaDN6NlVTT2dqZ0FHUy9BcHlGY2FNdHJWNVhK?=
 =?utf-8?B?QWk1NEphOTlFZmVrVVFrRldGaXJKd1BwRG5pbm9vV1NqNUxRMGdseFhHTk40?=
 =?utf-8?B?a3p2R3FlRE1BVTlOempRcmpSc05sL3ZpRGhaMlYxQWc5TkpGck4veWFTWkpO?=
 =?utf-8?B?Z2FXS1N6S1gyOTZKU1JBZlJ1U3lrK0VMcGwyQ3JGUm0xV1YvRm9jdzVLODg2?=
 =?utf-8?B?SzJYaEZ3WW11RXZoZENRSU9pQUI3SWVLd0lTVnhpejVqWU1EdG1EQ2R6M0F5?=
 =?utf-8?Q?DIeQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azl4ejlqUmhCRllaNGZDOGlEUkZpRXhDalp3M3FuRzJnYUhneDBTM1JSQzZX?=
 =?utf-8?B?eHZ5TVhudFdBbGE0ODBtTzFkb1ExMFRtaXgxVUNRVDUwUTRHeHZocm5yQk1h?=
 =?utf-8?B?MHVsbVBhd29IVGR0QW8vYlJyVTJMdVNmd2NsRVlCZjV1WTlPNy91VUtXNVZO?=
 =?utf-8?B?VSt6KzJjc0VyZ0YzQm41MjFGaGtZYjZvVW1UTHhad3RkSVBYYXBuaDZEYUJP?=
 =?utf-8?B?bkxrUGhnM2M2cmxGb1dRVVdkbVV0Q05tQ1NKSHZxb01TbTF1ZnBoL1drSlVm?=
 =?utf-8?B?WUtybE1KMUVRUDBzTUlkclgyV0dYZStveHI2QWlOK1hjU05Ra2ZueEJHYzl1?=
 =?utf-8?B?bjM0ZlVpYzFESTV1dTNyMHZzQisycGxnZHZ2eHFySEhady9jaVBkVy91T1Fh?=
 =?utf-8?B?M1d3TnhhTlZqc2kxanJEZ2hETzFzekVGdzZJaW0ybXJqbm1KSTBzd2Zid29M?=
 =?utf-8?B?NTgweDhuMTM5MkJ6VmN1WHJ3ZUVPOEt2NXpKK25uZVNXMGNTczg3aGxGWjVR?=
 =?utf-8?B?Z0d0SzluZWZyRDdGUndoWGZ2Q21UMzhYN094UHk2dUkxWUMwbTFQQWs2aDVQ?=
 =?utf-8?B?ekhWczRjcEJOY004RnY1RkljQTNWQTZ3VDVlcmtYSllpNHlkTlRuMnU0Ymxh?=
 =?utf-8?B?aVhjd29CZ2ZpdEUrMDVVaFJSdHcxNEQwN24zMmdJUDVDSDZoWllDZlR2VGpo?=
 =?utf-8?B?SXRVc0lKMjJ5MnIzMzh1R01KOG96RlVRbWE5a2JlV3c2aDAwV3BWeWhKS3V2?=
 =?utf-8?B?UlBDdmU4dmlPd0pMVW5ueEpJaG9tekoxK04wTzAzNUVHT05JdUtJU3I2ZEgx?=
 =?utf-8?B?ZVlBYkRBS0EzUzBrSmsrdmgzZlhTbC95RHQ2bVE0WVJYam0vVFBLc091K052?=
 =?utf-8?B?a2lqU2RpbzlqK0hYUjhDSkY3NldkMXZZZVpNRzBJYjVpVzNLRmYveHpGbVA4?=
 =?utf-8?B?Vy9ZTEZaUWVNb3BKNklpNkRHZlFEKzNXMlVJZyt0V2JHZzBVTExQVHNiY05t?=
 =?utf-8?B?UkNsQTMrbWNJTVo0UUt1YVUvRjlYODFtLzQ2OGdxOWFnSW9TYko1b1lDcWNm?=
 =?utf-8?B?UTAwTURRcGlHdy9sVk5xUTJtT2dJMlJzcTJyVzV6Qm1YeUI0bE9qSWZVcWxQ?=
 =?utf-8?B?alZkSnUrYXBJSi9DYzVEcWc4eHpYdlFKSHdYak9FZDl1RmRGc0Z2RkxXZ3lp?=
 =?utf-8?B?M0FkR05XRFg3OUNBS0FtMXMzWStPNytoSktESm1rbHRaZGtvbVBza0tad1ln?=
 =?utf-8?B?ZHR2OUNZUGtvbHFvYzJRS05LZDNDK0YxdnhyTldvNDNFMGZJbmVxaE9MVG1W?=
 =?utf-8?B?M3BDU3dTNFNpRDFGMDhZWVU5TmlPZGVPT3BHb1VZeDNzRitPb1lNMm00dk5q?=
 =?utf-8?B?N0pRemxXbytvYzAraEtZL0dvTWVoaDRVOWhnejY4c0FkbG1EUmZubXhiS2pG?=
 =?utf-8?B?U2pzQ1Y1dUZXNkR3ZXEyTGJVZDBsdnAxaVIwdkVscXVoT0I2MTB2ZERHQWow?=
 =?utf-8?B?Q3NteWwrWXdpa2xUL2xLWkttWGNNNXVWQ0NTYmNsWmRzbGNwUGhqRVZoOEwx?=
 =?utf-8?B?TGhCT2QzQW5YS1BtaS9hbE1zN24xbFVhcFhnYzRZd2JWTkRSRHNHbzdKamVJ?=
 =?utf-8?B?dFNObnJQeUh6R3A4end2bkhVQlduYjBBRDJhZlczYklnWEFYUDNMTTlMQXpw?=
 =?utf-8?B?L1RjMHJGSG9JVTZrT25lalljbUVHemlBVVJRdnQvUkFTZjgzOXlzc1pnUjdw?=
 =?utf-8?B?MlpwQm41WUlmcTlmbUUrMzZwWDhqemdWVUFRR1JrbDlrYlVLNHJCdVpwbnZz?=
 =?utf-8?B?dElKWU5rSmFRSGFvWE00dWdiaUFFcVJtZTV0di9xVm5wN0JIcCtBbEtmR0Na?=
 =?utf-8?B?TGpRL2w0c2J2RExONUtXdW95NGh6Zmdmc1Q4TFBaaWdMWVRLOFRKaW5nRXMr?=
 =?utf-8?B?aG9GQzlJb1RjS2V6aS92U28ybEFwZTNiT1Z6OERhUDFiUkpGNTVrMlVJOGJq?=
 =?utf-8?B?c0VaUnFkYStNN3dIamxmUWlocW9jQ1BrQzdOQUNwVnh6QnN3bUtOaWxiaWRL?=
 =?utf-8?B?N0FhYzUydVRGSzN1VGtyNC9FZnp5VVlQb0plRGlITndPT1FXeXJpTFphbkZV?=
 =?utf-8?B?WFBhaGZFY3hoeG5HVUdoRDM2UXB2dzF1WjFSL3N1aW5tZVVValVlQW9MakRW?=
 =?utf-8?B?U1djMkJVVG5mRUVpYlB0TFIxckxqV0h0NVdWTE5aVXJwcXVFa1NMa2Y3Y0dR?=
 =?utf-8?B?dWx5WWpZZXJYeEV2ODQxZS9DQjQyMzJIU3FLOGNUSWVxUEZFSUR2NEp2ejlp?=
 =?utf-8?B?aDl4aUdNZ2RldkVzOGh1RXAxMHBqRWZMaGYyK1BoR3pjMzVZT3hub04vQUk3?=
 =?utf-8?Q?NfgavtJAjSOoKtDg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a310d2c-e8ef-4569-b038-08de59f139e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:02:52.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7n/p0VSsQp4VgMVX3cs5VbPkT0jmE1FdOZiWjNTlbriOEEhkOwKOFRi4EQLyF/lNxrMx0yerOPYWtIX1Nls0pzgNoN+tnOMPotvWspCT9LQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFFA27DACA6
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 19:33:23 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for refactoring cxl_port_add_dport() to add RAS register
> > setup, cleanup the number of dport variables with a dport_exists() helper.
> Maybe mention why the driver check is now after the duplicate check.
> If there isn't a reason for that, I'd put them back to reduce churn a tiny
> bit.
> 
> > 
> > Kill the @dport needed to check for duplicates, rename @new_dport to
> > @dport.
> In ideal world I think the helper introduction and the rename
> would be two patches. Still real world, this is fine.
> 
> Assuming you'll address the reorder of checks by comment or
> putting them back,
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
[..]
> >  static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
> >  					    struct device *dport_dev)
> >  {
> > -	struct cxl_dport *dport;
> >  	int rc;
> >  
> >  	device_lock_assert(&port->dev);
> > -	if (!port->dev.driver)
> > -		return ERR_PTR(-ENXIO);
> 
> Diff is a bit of a mess due to the checks (originally driver bind
> then duplicate test) being swapped.
> Is there a reason to do that?

Nope, no reason. Flipped it back.
