Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E532FA30
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962695; cv=fail; b=V+74nZbeSowyrq2PfDwpCYPHNZmWTqItF3P1mBfqtz9xHmmvjZja/Km6BLHjq2ibAu+79WXnRPh6k1bTe/dhJZych+4iMi7KfZYQiNuIB6tB5MZIK/lYlqIFtv+GlMyy3p6E5R3wT9HI/J/05LugtI/Hq2C1JIPq4G1OR2YXqZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962695; c=relaxed/simple;
	bh=zsW0sBERR3xWxFOE1wMEbZ9vdKYyNKMT4kWSJs45K4E=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=dbV8ClXuV4DrTugrDudnz1WzltKVF1e6gq/tz0wq+odJ+bJW9UU/uu4+eTCL+sfoyMwjc5zlaPZBBQ4RIUw6kD6f2kDzKrsuMqb4fA4YJFE5GQnQ0Bb37hzjHllrS9f3C+6JeNpmbC9pQJE2BLnnoM6nXKdfIm9CBLE3q5xEzBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/faDUXB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/faDUXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771962694; x=1803498694;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=zsW0sBERR3xWxFOE1wMEbZ9vdKYyNKMT4kWSJs45K4E=;
  b=M/faDUXBWujsoa8V0uRdnbsrutz64vBy319+MidbyL0m40l2Jg0xvbNa
   mi9ESp/DpdvT2wh9cOSRRWRLM5Mno2Rdb1/fU+OQ3YMOOnWeUiFK+KVkk
   K8n+i6Zax7E1fUT6FxGXZCFgNvp7piSUOZ7cu0oCceDzkf25O9o5cZxlJ
   K/BN3ztgxzCGtkJhgDPlJ34W3EZgR/KgSJId8Vefm/PX5LBHGlKwlPXAM
   TUVMCcUEj6y/M9xzFA7tD4HeZftA7TikPN6sypwWKn/pOepFGu65B6eMJ
   JdwRzAJCctDVQmG1EAdz8qn02XmwKDdLXB9XJNfGnXbPEveNTqzj/b0nC
   w==;
X-CSE-ConnectionGUID: yMRJ1hySRYuNiPLmBLeAow==
X-CSE-MsgGUID: nHkVeqUHRJiwNVn0rODjMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="75599836"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="75599836"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 11:51:33 -0800
X-CSE-ConnectionGUID: XXOsLN/cQ0ayFnFpnur1iQ==
X-CSE-MsgGUID: DBgmAMTFRPa8+Pd2pXnwOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="214202603"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 11:51:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 11:51:31 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 11:51:31 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 11:51:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh9A6/Lyk5Sl5NvtxynSfdoVkVSy6kxLWTENd6ltHHjc+ww8OVJpNOltzQ/SDuhQO6whVOqfOxSiAkn9fJmtOEIvwiAz3GJK/dSBPBx2IN+KVkZ9rzhPU2n6oApdKXU/MXDD77veJm+RBLbsUT9khSSFL6uAzKEum4XTiMpdggZQBRVrMkHGbRm4OHIweNOzyHwIy8s5Oe3V3lG98U7uZtvhdqXoVEfwzSC3VZbM1uh+tlB38eL716ERp6LSqQEGV087HzKrL9+TOeXafSldz8m1KHryyXUoJEPDaCLy6F2Za7iKr7m8PNYqn3qyY26ZCmBQmbML/31u+BCWx/nzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfqJ/K5taG/M3KKYH7Iu1NEAe5DUU9omUCIFG9hcDaE=;
 b=BHNK+1gRPaW62GKN0qm3yC5bx0etFMgQn1rZ9C9Nos8+nKkGjgBIrd4Pa0CyOsZXrHDOBtQQtOfX55IiVmaVJVtUP7Vx7S3gVki76AQ9OWkOaSoI4pukqI+d+TVA9ZEBLpXxdy1A73nJZnAdQzRlVXLQ8/7ySq3SUvw/XcOvhI52r59qLV5pMq2SLwwpMpLGDGwE/RIfw+V3SEEfQ9xgkWcIRqoBWdeQaZ56fqhOnCIozegaQ3to1I25hqnXD1IA3dnfzRIHvib1ZFL8fss9QT0iyRSISrsl6CkXiwkOdoiIohe4szvn647HZMpyDlFof92tOvmnyJAXPKLqnxZs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SAWPR11MB9547.namprd11.prod.outlook.com (2603:10b6:806:4e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 19:51:24 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%2]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:51:24 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 24 Feb 2026 11:51:18 -0800
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Message-ID: <699e0136f09f0_1cc5100e3@dwillia2-mobl4.notmuch>
In-Reply-To: <20260224184120.1680624-1-alison.schofield@intel.com>
References: <20260224184120.1680624-1-alison.schofield@intel.com>
Subject: Re: [PATCH v2] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SAWPR11MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bff870-15cd-4a73-ba32-08de73de1747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2lVVjhZSzd6MkorblJvOXVqSHpMTzc1MUJIODQ0bEpXc01uTGpXaG14eGo5?=
 =?utf-8?B?NTMvUGNBcitvZDFYNlE4WVpXMWJPZ0MvMTRIVWVack5XdkRaUVgrTEVITHF6?=
 =?utf-8?B?SThqRTFuOXpuVEpOcWJGMVJ4WEJkR0FEY0VkMXJZaG5XRTRzcGxZNjlINEZ3?=
 =?utf-8?B?cEk0U2tnRVY5SEpjVnUybGF3NDBSbXAzK3FWY2ppT293MFNtWi9tRVJNOFhu?=
 =?utf-8?B?REdDcldQQjRueXd5S0JEaC9FUVp4RTBQV2J4NURGWUgyTEwzV1ZnTnVNMjVj?=
 =?utf-8?B?aUxFZE92cWZBWnR0a2ZwWVZQdXdreTdLYjNNVEhaOG9vUjFMem9LNzh0WW1x?=
 =?utf-8?B?ZzdxTEV3L3EzdFh3Y2hyRlBDN2lEdFdaYmdRNnNabkhvWDI2ZlJ0WGt5K1dJ?=
 =?utf-8?B?SUtQcEZBdXU0QTdKL1ZYN2IzRG9hek9wZ2pBSmQ5SkdMb1V6em5yNVlsSW1C?=
 =?utf-8?B?RXlGQVI2VEUzclFQUUFLY2xlUzhOTkphZThONVVUWlV3MUJIOGFhdWU4QVZp?=
 =?utf-8?B?NXZFSVFyNDRVcnBDVVJEd29zMHRRUnBiTUo5TTFnSXVuWC9YNE4vRG9VOUdv?=
 =?utf-8?B?MUY2aERkaDR5UmYwVzdQejI4ZUk3TnIwZFY5c2xSS0xuR2RqUXh5NEx1cE5P?=
 =?utf-8?B?RVVDd1I5aDhUVVJYR1Iwcm8xdXRvWW8zQVlzbENoODZ1UHU5WXdGT1hXN01Z?=
 =?utf-8?B?T05pcXNmczlidWo0R1NVcHV0cG1pVWFWbmpYSElES3FreURnem0vb1lNUzBN?=
 =?utf-8?B?RlJrMEtlb3lvVEtwQzRvUHRUMVNhbEQ1YnIvL1M4eHBEWEplRVRuaW53MVFF?=
 =?utf-8?B?WlJHYW1xc1JkeE91eXBPbjdiTlpqRzJESmZxT0psMC8rTVlaZHpMbjVJci9R?=
 =?utf-8?B?T1hYTlNFc1greGpQUnNLaVpDU1huZnk3cldNajNObVRNUDZJaGczN05iY3pM?=
 =?utf-8?B?aHI0YnFuaHV5WkdVOHJLd3BpejRWZU84ZFc4RDkwTVgyMlRuVGNzWHdtNFZh?=
 =?utf-8?B?bnoycFE1K2MvZE5LZkhiSEdPTzlvc1o1ZURTRVFJZmpCT2czT1RHZFlvYnVT?=
 =?utf-8?B?bm9IaVJKNkpFQnNHdDNKdzQxZEhCeUh0NkhjMmlQcEhCdnFzZTl2S3U5YUdy?=
 =?utf-8?B?eEhKaWVLQW40UGRzZi9KRXZNT0tYYlBvdlZWdkQwR0hVZXNIQVdqNitVM3ZE?=
 =?utf-8?B?dnRvVktqNnlVTWtjRDE1SStmQ2RRZUp1ZjNaUEozaE9EWVVHbC9RS094UzJU?=
 =?utf-8?B?T2JFY2pkNjNFQlNVbUh3VW9pZEdGNlJWeHRDUmRqRkNVMWtBWFFSbXpEM3Zu?=
 =?utf-8?B?OWRYWFB3WERGWW9zWVhlS3Uvcm1MaDE4R0JtSVFDaFVEdkl5aWpnT1F3Nmta?=
 =?utf-8?B?VkFXM1dkemtOdW9iSjUzSktHYzU0OTNQWDNlT29vS3k1cWxHeVoxcVIxZW5q?=
 =?utf-8?B?YmFXWlA4dVFpUkI3Njl3SityQmliWlJsQU1sMTl3L2UwZ01FREhjR1VwS2Y0?=
 =?utf-8?B?WGNGZld5SEpBK1JGUXZ0Q3pCQ2lQUDFMK21JcU1XaWRqUmtpZXpDVk9uZ3gz?=
 =?utf-8?B?Y1FMZjl0cDRIdEZ1WTBLS2Nzb3hGclRsT2xmQzBhajBWZktBUTBaTXFocHFH?=
 =?utf-8?B?Q1ZHcHc2bldRcGhySjZCQTJ0aXVzRUx0NEJjcDBiY2EzSDhzOG1CMStrd001?=
 =?utf-8?B?bFlKUm1BdHhTb1RXdm1Cc1F2RGhKVG82b3VvRFYrcTltY0hsbFlKVVJVeVh2?=
 =?utf-8?B?YWlIK04wQVYrbHcxU2Z5S0M2Yi9JOVp3aXlIOUIyS2JVMFgzNkRPbWJOWE8r?=
 =?utf-8?B?YlYzWmV0ZXdtQkFKcFlycXkyTGV6cVZrbXZLRHRwb2VvbFpKRS96SFVRZDQr?=
 =?utf-8?B?WXpVdzFSTDFITzFsRWtldmtYKzJRZXVubHBzVzAyeDB4ajNINXBPbDRVZVVW?=
 =?utf-8?B?eWVjSWxGdXdZT0puV01nWGRXVTV1cy8vb0pFUVNVcDNZeUtVcHZTejU3bEx4?=
 =?utf-8?B?T200Qm9pL2VoTFhoWVluelAwOXhkYkFEZUt1MitCaU16UmNZOCtLZHlvWm5E?=
 =?utf-8?B?ZUNpUTBZcU0zcExWUXJXaXhFMlk5Vm5MWFQ3THBNektneUtrMEhFVjdvSnRY?=
 =?utf-8?Q?d5Vw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWlPeTFNOERZb3dhend3RzNYdnhJTGEycS80WmdZazNhZ21rVUROajY1ODc5?=
 =?utf-8?B?RE5hRzZZK0UrY0hCN3ZMY2F2NmcvSi9nNVpBRFprTFkydjU4RmxUcDVvSVk2?=
 =?utf-8?B?bjhWcERJTm5OT0IwUzVDbzFnR0lFR1dxekgxZFJFZzNONm1jekpsQnFJK2dz?=
 =?utf-8?B?aFJrUUx2R3YvZzVscW53SzR6OHZxWGJMaGs5Y0Y4K0w5djdnaG55elBVU0pR?=
 =?utf-8?B?RnZkdG0xQXJCNVZMMGtKbmgxYXV6TnRKY3pyWXAzSVlSUjQ1YzJPZkZTVUVx?=
 =?utf-8?B?VFdiSXAyWkIvS01vRUVLZ3JreWZFeUN0bWtSRDVSSFRjRHZvYWMwQk9mRUNM?=
 =?utf-8?B?MjFoWFZac1lyWUNRZXJHTnBOeXplTE81TlpxUmJjeVlJNFg0LytrZ1pLelUr?=
 =?utf-8?B?dVEyNTVycUtJSFZ2bEQ3bkFBSXZ0cFlqWEV6OWJJOEgxV2NmYWUva01NRTAy?=
 =?utf-8?B?dElrcUE4VnNDbFNBamtIaWFpRGhhMEhmcGNTTnJJbjFoZGkxNEkwTmpabm43?=
 =?utf-8?B?cHVoRWFXbGo4bDhnb3crSlVvZ0p4ZUlDQ3BBN21wQ3BnRGEzdURPaDB4WnZa?=
 =?utf-8?B?bXcyU1ZaR0N6Uk5qcXJacmpLbFU1S2dJaW5hL282c0FEVVhra01CS1JEL1pL?=
 =?utf-8?B?K2RMa2RiVndPbDVpUWMxNFhMZ0V4ZmptZjIxZ1R5R1FHYUdldkxHQ3ZqTEk5?=
 =?utf-8?B?eDQ3ektlTE5sRkhwZXViSmJsK3J6TnFWS1Y2aVEwNW5DeHoySGpnODhWbG1X?=
 =?utf-8?B?MVluY2tEN3FuTXY2NjVGcTk3bG8yN2ZsSUtqT1pwRXdFb3lkSnFYaElTSjVN?=
 =?utf-8?B?QUVYOHRTTkJlQVI4TzZzSWFvMFZHQXRuOXJWNHp4MjdoU3lVVGkwc2xrYjMy?=
 =?utf-8?B?cUdaS0FtVEZ6Znd3SlZENzIvRDJ2ZE9TMG1YeTZvWUVZR1d5bkdTbG1CbTNF?=
 =?utf-8?B?VFhFN2E2QkxRV3lmV3dRcmxHa1gyTzFvZUsxaDJQUUhBUE5abEFTUUF1b0h2?=
 =?utf-8?B?MlpCRVFaOFZYSDN6d0RCZTdDR3k3ZktxaW5jN2F6Y2RCT2dHKzZhYnF6cVNW?=
 =?utf-8?B?Rzd6L3JoM3paaEI5SlhQTkZBbFdpdTExTDQrRDF0dmFpNjNGdW1JR09yVG5K?=
 =?utf-8?B?YUUxQThhNTU4NUl0RlQzME8zMmlhV1BHc2hFVXkyR3JFWEsxRFVaVTRuQkw0?=
 =?utf-8?B?THhlQjdVQzhIcGlDQXJ4NElWV1U3MnZhUTBGYktGakoxb3gwa2MvVFhpZzYw?=
 =?utf-8?B?eTZSRitsSXQxUmlvWk8zL3k1ckMwODRhQjh3OWU2RkNnT29PcXdRNUxzRHZX?=
 =?utf-8?B?V2lEVFZVY2FBeTlkYVplVVZpSUxTRXVDRXBPWUZEay83WkFlb2wybWRYWDg2?=
 =?utf-8?B?NVVGMWgrY0ZneUYzejNnaXJ0UGpmenZXbXpwaTlPdDRvNEVvTGd3aG9ZU1kw?=
 =?utf-8?B?NUVrVmM4bktPcFV0d1k0UDdvUExZRFBOTHE3Q0t6MXpYRkdWVHNQSTNkaUwx?=
 =?utf-8?B?dTI0bnJ2UVZ3QVVhN3dGTjgrdzNYaFNIR0RiZ2c5VkhuYldielNNUWRWbUxX?=
 =?utf-8?B?VnBjcktVYjdJWUVxSVdRRGFySmd1YzBydmk3dE1FZG55QlpjSmJPTng4dDRK?=
 =?utf-8?B?MmVWWHNiMHRlZVA5U2VkWDN3Q3F3WmtTNzB5SWNjVWZkVUFJUzExRkRhc2Rq?=
 =?utf-8?B?bk9VaWFpQ2xJaXVXUTJrUVZ3WXVPNldHVUVFaVNER3dNTkdJeWVyNFh6ZGhx?=
 =?utf-8?B?aTNaajI1MlMxSVRibVhHMFZaOUhKVGJGV2t5cWY4ZTRFMkZBVnBSeU1GYW55?=
 =?utf-8?B?SFlMNm5xclJwOXlkRlM0dVpzZENzOVU2UmVTWktoL0J0Q2ZmUWowV3NIYU9O?=
 =?utf-8?B?bkhhMjZTcDhJclFEdXRYTU84VVdOQmoxMW8zdjFwVG44N21wNWI2a1JSZHBh?=
 =?utf-8?B?cEdlOWtJOGM3dzhmQ21nWXJjQ0s5MzVDMEZMYlNxc0tDTWpodVE3MDNWS0tT?=
 =?utf-8?B?YVNlSytMU3Zmd0NQeG1waW11c3VaNmVjKzFyTXUxTktNeVB5QUZVMTZBMDZo?=
 =?utf-8?B?ZTl4UmRHcVRrMWh4dEd1cWVWWC8vRkMzYm1hMDJqbjlQS1FpQUFEL1Z0allz?=
 =?utf-8?B?MVhOVUgwdzNlUDlJaWVVajRNTzJTSVZ5QUZxYVBWSjhFS2FrYTlNRmtQczNC?=
 =?utf-8?B?a2pSbVJtVHRJVGlab0FUaFZGNEhTQVV4S1hHQ0lxKzl3MXd4Y0VIZnpvTVhO?=
 =?utf-8?B?WXArTXZZbGJtNzl0djJtUGcyWkZFWjdtNGNoMU5yOE5vakFrRnlCbkx6cy8v?=
 =?utf-8?B?WXVrNThPbTZucEZRamJqTkZBTXBORXpMek1UUEtDQ2ZFc2xjRmZtVmhMeTBO?=
 =?utf-8?Q?vEdyO7G7SzF2bCwc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bff870-15cd-4a73-ba32-08de73de1747
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 19:51:24.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pl5MeiRnNcVbn8Ut8vT9ek7ITL8q5I9S9rLadk8gt+nbTHGoJG2ElucEIc+zdu2aCMjQs8auPOxVPNJ0K+gqYcn3nj4yo9uqMVF/SbxCuP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9547
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> cxl_detach_ep() is called during bottom-up removal when all CXL memory
> devices beneath a switch port have been removed. For each port in the
> hierarchy it locks both the port and its parent, removes the endpoint,
> and if the port is now empty, marks it dead and unregisters the port
> by calling delete_switch_port(). There are two places during this work
> where the parent_port may be used after freeing:
> 
> First, a concurrent detach may have already processed a port by the
> time a second worker finds it via bus_find_device(). Without pinning
> parent_port, it may already be freed when we discover port->dead and
> attempt to unlock the parent_port. In a production kernel that's a
> silent memory corruption, with lock debug, it looks like this:
> 
> []DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
> []WARNING: kernel/locking/mutex.c:949 at __mutex_unlock_slowpath+0x1ee/0x310
> []Call Trace:
> []mutex_unlock+0xd/0x20
> []cxl_detach_ep+0x180/0x400 [cxl_core]
> []devm_action_release+0x10/0x20
> []devres_release_all+0xa8/0xe0
> []device_unbind_cleanup+0xd/0xa0
> []really_probe+0x1a6/0x3e0
> 
> Fix this first case by adding a check for port->dead after acquiring
> both locks. Unlock and release the parent reference before continuing.
> 
> Second, delete_switch_port() releases three devm actions registered
> against parent_port. The last of those is unregister_port() and it
> calls device_unregister() on the child port, which can cascade. If
> parent_port is now also empty the device core may unregister and free
> it too. So by the time delete_switch_port() returns, parent_port may
> be free, and the subsequent device_unlock(&parent_port->dev) operates
> on freed memory. The kernel log looks same as above, with a different
> offset in cxl_detach_ep().
> 
> Fix this second issue by taking an extra reference on parent_port
> before locking it, preventing the memory from being freed across
> delete_switch_port(). Release it after device_unlock().
> 
> These easily reproduce with a reload of cxl_acpi in QEMU environment
> with CXL devices present.

The analysis looks correct, but I worry this fix is too tightly scoped
to this one problematic path.  Just make the rule be that parent ports
have an elevated reference until child release rather than child
unregister.

This would be a similar semantic to what happens for regions where
cxl_region_alloc() takes a reference on the root decoder, and
cxl_region_release() drops it.
