Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623E18C933;
	Fri, 11 Jul 2025 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207192; cv=fail; b=Rb1g6V7xFDZM/I5ruhsOSCPffGcGQfAd/EjNaa9PvVGp1sjJxnM65HnRoJvWZlEoS3MstVuweTm5W6dswUHzAY2AGl+LlYobNUHLBvKNTvWO0No9iIw7W6GmXVWiEOjQQYAMjykW7AC2hrXplf6a/sxEb0RQKV+dw/lQn6OsnLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207192; c=relaxed/simple;
	bh=xmCIR0R/tFVIeG7eMMy2CQJZ5rLoHyjR8cTO7Mh36sw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=o1zDFEcPvDswJWxB2lE67/uHM0wNGwTX27Q0pBEfy2voxziHS4PaE9xebyODf+FATfgXDyu8A/otj3pnv/MT0rIM7rv5gIQPKNktBRXqkbNV0T6TGv4oaD5JrLvjsbVtmmB4KD+N5LW51Pxd4iSSCLIwGAfUL2kiVK0s7hGXW5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHQth8+o; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHQth8+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752207190; x=1783743190;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=xmCIR0R/tFVIeG7eMMy2CQJZ5rLoHyjR8cTO7Mh36sw=;
  b=LHQth8+oClTh2C9ms7kE0pQG1t8vghOVlkQtS87YmpaXFjHj2n69gDro
   y9+c4bWh3bJRVEgRNuT/oGX02QO3frxAohtbxthvHqFlJNV3ClI9Ny6sZ
   s5UEXH20g91G6/2Il9wgNK10adG3/El2uHJY8Ru26L5Uwq1yQ+i+39JSW
   EtFM1WlaDvs0Nqe9kqiQFaEoARmiOoVIuic+gwCBG8pKdg5XpD6Uv9jlo
   aikfI5/TLUdarlUCQplf/jGLRcUDfXU/fwd949Hscp8DGl+573sXiXu3c
   HlVz+WAvmcLZi9DgsCE+QhEMOOpTToKIlLcAI1hXHvnUp9rKnlU6t/jmm
   Q==;
X-CSE-ConnectionGUID: fkJCulzGRF26ro59NqhE7Q==
X-CSE-MsgGUID: MVvga3jISwCl7dUd1ini2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65203106"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65203106"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 21:13:03 -0700
X-CSE-ConnectionGUID: Hgye2PGsRX+jigH1dJ5pnQ==
X-CSE-MsgGUID: OtnNC+MaQ8aVyNhPV0njSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="155894696"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 21:13:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 21:12:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 21:12:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 21:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xf+/ZnLQKLEMWnFVrN4MiDe45qW7f0VsUJE6EguTG+HZmm5nmXotQf0w6ZHy+6+fUYjjc4aOg11cnkO7rlind9EJiUrfH9e5yDGqtNFgi6YeVMQAQHCnTyrCrFSZiFx67FsfPVEGTivnTVhBiVvyHCUq/88xV4CP6Z9jzJLTko9fmR5qg3oCsuivZzr9UEAN2GF5eC6gu0TYpR1dgBMPHCR9QbLpQPcOab/CcwTUxlAhMmRIS1osJQmAgvZhXIz6yaEE4iaaId4kSlv5o1z6KY0FFFfJSbbpy85R3QjjT+e5svTKxHy/dYe1R7xMbC1qyC0be/F1Jae7cjHLy3n1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbNGSNQtBxNuMGDcDMzFYH2ZFnf/Ahd00S79hNqxNsI=;
 b=Sq/jxkYF34dIq5cPfqbvGzHrDAaJYbR49AFuVPJDp4wgwRB9JEt9lNzhfnP7w6oRzctWJ+XzGgK8mda5aGYdhkYP2e/+oE31yVsoOJFsbQNyF66+Nhf2vpERfiFvCMA5b3MjdiSnR0LUVUoUM6Aom4x+79pD1/1T6M82G23BoKrNAE/J8h/I654YQAFxq5AG4O5JXog6JGAP0lMw4ZaowOs90g7oOZsVPmJp54rMOAV7sLnL7ON3lC3+KY7ds4mHTUtiKV0NkJ9IkgrFv76fzWHu+RUq0Oduju3HLKUK/tTwbRLl+3eRR4s1JAT2H+54ERXPE8WjKi+FfJ9mXzh+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF8F79256C7.namprd11.prod.outlook.com (2603:10b6:f:fc00::f37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 11 Jul
 2025 04:12:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 04:12:42 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 10 Jul 2025 21:12:39 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Message-ID: <68708f37d30d6_1d3d10061@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250623114933.00001ba4@huawei.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-8-dan.j.williams@intel.com>
 <20250623114933.00001ba4@huawei.com>
Subject: Re: [PATCH v2 7/8] cxl/region: Introduce CLASS(cxl_decoder_detach...)
 consolidate multiple paths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF8F79256C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 381fc547-a136-4dc0-b62d-08ddc0312e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1RPb3VDdHgyU0NnYlhseTcwZHZ6dzBtQVU2bHZFbmFucC85MFArQ2w0VVhr?=
 =?utf-8?B?N0tEVDlqd0VoRVIxM0svRUxWY2FNTnFYWVg3QS80ckpRSG0rZXVqRW9xaWVX?=
 =?utf-8?B?MHN0ekRXTUlTNFBHeVp6Y2dHVDBpeFp4N2gvcW5udWNsbkVJNkEyQ2xaZjVQ?=
 =?utf-8?B?NWtDWTNEdnR2dVVBUENYaTBmbE1GUDViOXM2ZVFnMm9pYkljTkQ0cXlsUWpQ?=
 =?utf-8?B?Sm1yeGd3dnNyTGxCNHRkMDNTOGNVR2FCWTc3KytsUUpmRUl5RC9HQWw2bEd3?=
 =?utf-8?B?eXptZ3QvUVVTdEo5TndYSk93REIzeTBXc1BpTVYxK2txOEFPaUtOQzFBTk1D?=
 =?utf-8?B?ZGEvemE0UVN4UjVwUkdSQktzNnpodUlna04rTXVVUzBnL0FOTzJ6NXdHeElM?=
 =?utf-8?B?UjlnQ3BPZWFqZFBiczhZN1RWSlRxd21qSWhqL1puWFlyZldoMk5iY3JpMHpL?=
 =?utf-8?B?VjVMR0M0TVhHQVcwZkk2MkErWWRKYXdhRkxSZEJwWmJTWjFBTGgvSWRBYmFB?=
 =?utf-8?B?MlBFS3lNeENEUjNhTDlPTlV1Slg2QkdrMFlqTUhIYVhEdi9YUUFGVmJoY1du?=
 =?utf-8?B?cHFPUDRnaDlJbEZlZ2lIUFNHeUkyb0JLOUZLejUzZDYyT0JDN3BQd0lYNEtH?=
 =?utf-8?B?ckFSUmZOVEZIVXdQYVpTK0k5d2RFWUpTdHBycSs5YnpKd21NK3hBSGZ3Q3pZ?=
 =?utf-8?B?TFBvYlJxeEc5RnRDMjFxS3JwbUlraVR6ei9vRzlrNWVBV204WEh1bGV2M2or?=
 =?utf-8?B?MmhOM1d3ckJuWWExaXdDbTJxRW1SaFc3SWVNMHN1SDQvRm5MTHh2eHlaUDgw?=
 =?utf-8?B?UmhsRHNsNHhrS1ZSbTNhclNUaWtCNmlMenJkY1pITS9OS1F3UEkwblpTMXUx?=
 =?utf-8?B?SjlISHhlaERMZk5HTkFpRnp0eG1GeENyTml6RFE3RzcyTVRZdXpWYnpZVTRk?=
 =?utf-8?B?L0ZvWkJFdjZ2cDhPM1R5Q1RIdDdYU1MveUxNcDMxV3lIcDRDbWpuM1J0eWRF?=
 =?utf-8?B?dDd3NnBXaEJrKytmMmVlTWt2Q2lGZGk4SFZ2ZUx6VjIyWVZrcFFJOCtYZzJ6?=
 =?utf-8?B?d0VlRysxWHBhdmQrT0VaTVBMaDI5QTdweWlSRS9KYjUwQzhkbXFpcEp5bDM2?=
 =?utf-8?B?N1NOQkcvRTNWNmZUWXd3TXBLWGhGd09VdWkrR05ZeGdiMVpNYW9GSGpWaDQx?=
 =?utf-8?B?ZVpEL2wrSk1pOGVmV014TzRJYU5WVU92UnlQbkd1UTQ0ZCticVNQL05EbVk4?=
 =?utf-8?B?NEg4YUFMb3A0N2dZMDY3YU1PNnpFRjJoczBBZVlkMVB3TC9reGhhZWp1WUlZ?=
 =?utf-8?B?dHpLQmZPR1BQSGFSdUZjd1FPNDhIamkyTDlwd0p2cnhsT2ExTklJeTJ5a3U5?=
 =?utf-8?B?Z3E0MkdWUmZrRUMvL3M5elpYWStBNmZNZUUzOVlKMW5EMG5BYVd1S0hQUFVJ?=
 =?utf-8?B?T0JrVzJjUnZxVkk5Z0Z3bVF5RnJSMXRad1RjUEo1Z3Fva2FHZDNraldQUDFD?=
 =?utf-8?B?SGh4VkQyZHJveTlKTWlBMWZycmRIemUyYldsTmp4Uk1YVFpMTWVyQkthT0tB?=
 =?utf-8?B?aXgrNUk5UmhMQzIzV2xOTWlxbjFoZUUybzdwZ2VhOEpQaTVrNjdZY1NnNldY?=
 =?utf-8?B?b293UndxbDJ1aW1RT2s1eDlMUFR6Q3Q0MEUrZWxaNVphUDlWOXV6TGRvNldE?=
 =?utf-8?B?K1ZwYUkySUZESE1NSWpZallZWmFhWlZuemZIYTBtT1ByRks5TWF6S0dBdUNR?=
 =?utf-8?B?U2ZKcjVLK3hqNDVHeUpsdEh2VTR3ZkFXc0lQbTRYU3diNmlZZk5RdkNEc3Y3?=
 =?utf-8?B?Y2RrNm9wdmVkZXhqa0NWZEUvYW1PdGtERTBwb05wQ2pIcFZ2cTcrd1JnaXZJ?=
 =?utf-8?B?bXg2M1VZUDVqZUIyNDJGZGw5emVBRVZCOGdXejE2VjNMOXQxZG1BcmNRNzcw?=
 =?utf-8?Q?r9tShPFi5Cg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDhXNzhwUUxjYVJjTHI3WjMxU2I3T0JHSUk3RDF3VXJQUDVZVDZ0UzVDZ0Zu?=
 =?utf-8?B?OEdJSmxwVDR2aG5WZVc3VFZKbnFhZlo4RkRiZWtpV3JxbU1hN2prc3ZZSnZu?=
 =?utf-8?B?SlVvMlVhQ0xwalNPTklxdW9iYzhGa25rN3hQMEZvQVJsUDhiSVRhZjAvVXJV?=
 =?utf-8?B?OENpTGxnOGJXMi9ld3hRWGxjaDd5SGp3dGtxRW1ZN0xTbzk4cFg4SzNMYitN?=
 =?utf-8?B?a1g4UnNOZWtWL1ZsYS9rSVJURFZoV05ZVG0rYTN1bC9GSU1EOXYxbGkra2lM?=
 =?utf-8?B?alZzM1lQRk12WWEyeDYrWUtxWmRxQlR3SGs3V0kyc1A1VThuQnliazVJK3hG?=
 =?utf-8?B?a3MxUVBGLzNnRmRoVWNsSStLUWdRbUozNC9EUzlUb3lmaXl4SGN3UDN0L3Rl?=
 =?utf-8?B?SzJBV0U5SU5sWkVVa0lZR1h2SmdpV0lFSUY1bGFFQXVOa2hwMzN1TkVMbG5D?=
 =?utf-8?B?U1pVOUVsblJGTWk5TkJnd3FBdm5xaHpOT1FLcXYvaDJpcGl1V05XQkljSWNE?=
 =?utf-8?B?d0F4dVRFTHBqTmtEUjFlREZLL2JRMDlaQ244OWthbzkwK2xFakV0VGg3bktz?=
 =?utf-8?B?VFB4RUpEMmZIV0dHaFVLZ3Z2QXZBdEZXZC9CbklMWjZJeCt5TFdTa2RETDR5?=
 =?utf-8?B?U1VqYWJhemVHS29neWlLSkdvNkNQMmNGOEM4c015U3YvU0JYWUx1TGMwU0xG?=
 =?utf-8?B?aEMyMkU2d2dORURjcERnRXdlbXVhYkZBQzFPWm05clFFbGVPb3NETENLZTVx?=
 =?utf-8?B?ZUZ1Ym5JZU5KZkcvaDdIUVZLWDVhL0d4TWJCbW56V3NyblJYdFg5RnVtVTlG?=
 =?utf-8?B?WGRweVk1RTBHM21ybnE3NHp3S1o0aGs2SHNXNUhhdWdwZ2FrOUVUSGRneitZ?=
 =?utf-8?B?dkZjK21oYjFwUGlZemgrcWcycHNDeXJVVjQydGNUMkFMaXJGN3d2MmtHaXB2?=
 =?utf-8?B?d29XclBSTGh1T0duT2R0dTU1Yjd1bFRmazErelg5SmlNaDBGOGJqSlBuWWRs?=
 =?utf-8?B?VWlFdmkrWlU3V2o1Y0FTeVdJSGZyaEdCdW5EbEFmQURmZjBSYXZvUWZiSi9R?=
 =?utf-8?B?REtWNE1tbVpUZ2VrMEZHUGNYdFhMUjREMUFQc1crN0ZkRVZmVDRSQWQvckxF?=
 =?utf-8?B?VC80c1kzZHRRQU9qTW1jUFZQUkg4ZDlDQjNWdWlBYkJ2TUgybnhaOFBvNkJt?=
 =?utf-8?B?bFFwSS9mamtINXRGUy9VcmhkZ1NqcDk4WW5Wb2RzZVZja1pHdlRuQUhSTHFh?=
 =?utf-8?B?aGdCWFdiMG9lY1BXRUE2MWhzdS9aaDNFemNWRG8zblpZdGRxUEcvMmVlanNJ?=
 =?utf-8?B?WWhJZ2dRekJtZW1CcFVuM1A5V2tJMnE1Wk1nUXZGUDNRTFdQVzRmYXZ4azhX?=
 =?utf-8?B?aE1Tcmx5Q3dCQy83RVlpYkhkenkxNGVJZUw5MDJXcGNzdkx3KzNna08xbm5F?=
 =?utf-8?B?TjJOMUJZQm9HbXNkaThFS3lyeU9mcnd1MXlGME5EVG1HOS80ZnF2REUvUFpt?=
 =?utf-8?B?eEsxZnJldjZDa1F5OXUwMW1JTUhqZzJVaC9tWlRYNytHQmlYbnd4ZWpETXJp?=
 =?utf-8?B?U0l4UHY5WDJ0YkRMckM3WkRBRlhrMDFuaGxWYXNwUGFFNlhvemZGYWZsNmp4?=
 =?utf-8?B?bFZLRDdQRGNGMHpnK2F3VEJZeDA2ajlmRW93UlBFWEFJK0lPUUpoemJqQlBI?=
 =?utf-8?B?REN6cnkzMmRIN214UlR1ZzVYZW92anJ6THdtUWZyMG16ZlhyVVl2YXA2U2hk?=
 =?utf-8?B?Y1dEN0J4bGlXaVlmcCswSFEzTWR3NGl6czU4d0lkcmtHM2NJUTR6TUJZaEJ4?=
 =?utf-8?B?cmt5aFY3KzlGVmxEOHpRY3VZYUJRb21GZC9hcEJpVXdxVjlpRUE5RW93YlJm?=
 =?utf-8?B?d1dKNWRaMWZZQWNjelN4akF2Q0NxTFYrWWNsZkt1S0djbVd6dEtWOG1PaUw4?=
 =?utf-8?B?eE1pOHBCOUpHNWZpQlpNQy9YSWtmTUF6MVdtL1A0Um5hTVQ1Tkg0NTF0WlBy?=
 =?utf-8?B?OEN4YlVhVVUvdUE4TE9WelpKRTF0c0REU29LaHJHWjhUa0hoS3FFaWpBaFkv?=
 =?utf-8?B?bmxOZEx4T0Frb1FiRWVreUZDb1pwbnBScWNsNU81VnkxbFU2RW9tUk1sMDZn?=
 =?utf-8?B?c0VMWHh6UVArcjNBVUZ6UFR2OW43MTJOTmhwWFVpZ3hxcG5DVjJTNEhxdEt6?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 381fc547-a136-4dc0-b62d-08ddc0312e65
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 04:12:42.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQsZZwH7GV2OM6WsSfo448xaGSHhQeVsaNLpdFqJ4TMIomRQkOYGfmEDpoaO93g1WIyRuMexw4YFg3i0wQJ6UtZeDEAuppn4nMrURrDEgHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF8F79256C7
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 18 Jun 2025 22:04:15 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Both detach_target() and cxld_unregister() want to tear down a cxl_region
> > when an endpoint decoder is either detached or destroyed.
> > 
> > When a region is to be destroyed cxl_decoder_detach() releases
> > cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.
> > 
> > This "reverse" locking pattern is difficult to reason about, not amenable
> > to scope-based cleanup, and the minor differences in the calling convention
> > of cxl_decoder_detach() currently results in the cxl_decoder_kill_region()
> > wrapper.
> > 
> > Introduce CLASS(cxl_decoder_detach...) which creates an object that moves
> > the post-detach cleanup work to a destructor, and consolidates minor
> > preamble differences in the constructor.
> 
> I'm struggling somewhat with grasping how the destructor pattern is useful
> here. In the two cases the scope is tightly defined around the
> declaration of the class instance. Doesn't that just boil down to
> automatically calling the destuctor function immediately?  If so what
> is the use of wrapping it up in a destructor?

tl;dr: yes, the CLASS() is not needed.

I came at this from the perspective of removing the mid-function unlock
pattern, and it was useful for me to decompose that into a
constructor/destructor pattern. However, you're right, with the
refactoring in place this further simplifies into a straightforward
helper function scheme.

I have __cxl_decoder_detach() which does the conditional cxl_region
lookup, and cxl_decoder_detach() which handles the conditional locking
and device_release_driver() follow-up.
