Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D6223DC1
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468331; cv=fail; b=um6heRCQdOvYCt26r4LfghLfZAbHAmk9sTK2w0iWSb0gf1NG4gI9+qIu+7myQUSfCtm6j2nkCqOOl/5yy4au0FPX9G5Gmzs0ETOJfSDzKJ1LVbwwqoHT7NeqPMuEx5mfFbytCe5YbGP9XiexRzLWCdVeTT2/NqfQwRhetjHLxCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468331; c=relaxed/simple;
	bh=STTVujkoIkOvi6ZInapF47iNYM0fmtyFKujgdVzvCJs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=MTUZsCxvKdlSsPYihPB/sO6kkWp6Rh9kqN+SvVXWMiM71+bSINB6wnT30240q7krqVn6g96jFFJ7MYfDeLRDAxfVI+VCIUtlkMdzgP++cH4tdCP1lHfUvXXI4xmi7+I9lz732JR0Gpvupth+N0dXQbnQKkOj66kCx5xFE+u72jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lC+Tooc6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lC+Tooc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760468330; x=1792004330;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=STTVujkoIkOvi6ZInapF47iNYM0fmtyFKujgdVzvCJs=;
  b=lC+Tooc6SUd0QJdSeOn441qS+4fjwWw71bRw+FCh4g7tJwd0sb/5i1xO
   fnWx5dCZE/xHOzZyh9+q+91SjfjQEefuUC+Db7A55ArwT5bYRseAdH2WM
   zVCMdm2SrkOs9JcrZVCczWJqtEi87bLbjG6ONHujgXmnt0ml8qqQv1NBs
   5V8QqvzoQs0W/3HxdpytETAAPnqAAO9q+K0Mmb9w741u/wHQtHN8SDeSN
   JS6zzEJPq0WZkGTLVTg/BbyEbNfk4A8a0KXNO2za7qp+Q1tnvGaeR+mzf
   L4tWRwxHWOS3Begkh6HHwmHP64mJQD4xFaWmlQJ/9gsB7xoDEFiIGGwvi
   A==;
X-CSE-ConnectionGUID: F4MPzuJ/QJiOqBZYlSOj8g==
X-CSE-MsgGUID: q9W511a+SAqnGVktJUK+CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73977833"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="73977833"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 11:58:49 -0700
X-CSE-ConnectionGUID: lDO0wghwQMqWLtINcs93Fg==
X-CSE-MsgGUID: 9KMlqA1SSeOISXWJjl8tzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="181507833"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 11:58:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 11:58:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 11:58:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 11:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSiKl/A22lw1Yimnb9t5vWnypMI1g604SJnthaT+I8SsD/BgvtcIWpOVRQJyOzNBgHM5ZRSkrOI5LiXhKKcJzZZ6C5aFOTskBo12qPnCgC6KFqi3LT8Ez80RKi3cX4sLbcXf7hut1AosNq4eHFiME0D30Af3aw6MW4Yf8OIHMCuf13BE8CmLpfC86Gn6eaNNg+0RZrJ0VkiYt2i1r8CX8V+sQorqWk35sV2KleNTpjDwf/l53j5aUMUshId1we1pYHJDXGasceIslEY6b320NqQXX3bLJaLXbRtdQfCL2pXzQ3GJ3oB8VCkohCsztOilM11LXDDgT5An27zA8NKc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STTVujkoIkOvi6ZInapF47iNYM0fmtyFKujgdVzvCJs=;
 b=T+4ne5IfX+oXZBcHFAiuHJLEaJqPd8iXALQwVgdO06Tc1KaPJe/V1NZc3l6oE0IhTCunqNu1z2DuyPudJ0qIycPDTCGeG4AOyupm+XophFD6Ue2/fu/HTr/ZGXrkTnzXdvo60dI6HGaZPRjxv5DU2XSv+odsnBM71pqpCf7b/R1WBSpI6VzESnoC3uy2gBxLIOSqDajIVpEfhMv1CRxEqAG8gYalbmqQkA/w5Omh/SOg4mxJMubmRXkDtHySdvf2cOsQCV3iBMBLL3QCdS1B4w/9bq2hB/Ydhiypodw6Cq5R7TgvrC9N5EZN3yo8iZESIz7eFWOy8rf8B6fqx62NJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 18:58:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 18:58:45 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 14 Oct 2025 11:58:44 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <stable@kernel.org>
Message-ID: <68ee9d646324e_2f89910078@dwillia2-mobl4.notmuch>
In-Reply-To: <20251010205755.205280-2-dave.jiang@intel.com>
References: <20251010205755.205280-1-dave.jiang@intel.com>
 <20251010205755.205280-2-dave.jiang@intel.com>
Subject: Re: [PATCH 1/3] cxl/acpi: Fix setup of memory resource in
 cxl_acpi_set_cache_size()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: d3070d68-d04b-4db1-8779-08de0b53b374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHRkcXptQ1NIUVJ3dm9SMTJsYmJTMm1uOXRObWhQK01mUThkZUJ6cUx1eEZ5?=
 =?utf-8?B?TTQ3aVdJOTNTNTgxdllzeTV6Q3NMRHZJcFVJRHV2VHRLcXVVUCtPL2lpRzJp?=
 =?utf-8?B?b1lzVkhtQTU4MWlhbTNlQTV5bDhNTFZ2OWs1dWNxVEpOc1REU3BlYm9Ecm1u?=
 =?utf-8?B?Z1Z1Zk5XV0MyNXI2NVVoUW5XMk9ibFZWeGQ2bURkV01KRUxMN2NBS3Q5aldx?=
 =?utf-8?B?WXJIL0l0eVExVndFZFo4bUxJWjBDaDZvZHNvbWJrY1Y4bEZqRVFsRnh3eDQ1?=
 =?utf-8?B?VXNGOUJObWFRNnhUUnp0Ni8zTUdFSTVTand6YWRIQWJhZjByTk04a05GK0Zr?=
 =?utf-8?B?RUc5RDdxS1RVQURiR01LU1AwZmdNYTZMVk14WEF6bFlwOVZXMldMcFRzYWdX?=
 =?utf-8?B?MVU4M1lCNjVxSUJaWHRhODV5RWVqc0hmME10ZlBlR0ZXQmR6dXpZb3JsS29B?=
 =?utf-8?B?amJlcERBWTNBZzc1UFIxSmFGN3ZLMTJ1T1JxOWFva243am5maEtNeHY1UXYr?=
 =?utf-8?B?MWN1aUpFRHN1cEhYUHNXclFuaHY3aGdoOW9GS2p0eXlYcDVUckFZUkR4Y2pS?=
 =?utf-8?B?OGNhRkRHWGh5aU81Ly9zbzNlWTNCVXR4cHBQTFR6YTVoRFFiMytCVmFNbHdr?=
 =?utf-8?B?MmRBdW1vMTBrcGlBWFhxK3hEdUZ2UG0vQnEzdmtkeU1MMXBKRnkvVDhaa0Fi?=
 =?utf-8?B?YTRvWmdTRjhtWEx4V3czQVZOM1ZSeVhGL01Jb3lwdVpWTGx4RTY4SnhidCth?=
 =?utf-8?B?d01qZjJLYWY5SXE5WmROcFNuYkFTYXkyTWNBclpPbnJDb21HZGVSMmZTSDhu?=
 =?utf-8?B?MHhEY1NTd0JMb0JDSUYyY1Mza0Z6cmloYkoreFBvUGVCZ3ArYVZ0eXV6ZEJ1?=
 =?utf-8?B?Y0U2L1hhNStRMjZUdmhNS1pGL3dsY0hQa3RGVUFrZmJXM214T3V6bXMyQklL?=
 =?utf-8?B?TGQ1SVpBcGFIZFQ2MTBKdHRzb2RCUHUzdU5UeU1BcWE4RkxMQmg1N0Z3L3pQ?=
 =?utf-8?B?aDZJZWE4L0VCVHJvaFZSdFhxTU9CQm1HSUhtUExuOE9kc0I1eUs1RVhjVERF?=
 =?utf-8?B?VldaT043TktWNVNXcGU3NHQvRiszb09yVkt0OVdvZEJoZE9ZeGJBNGViTDhU?=
 =?utf-8?B?bFJVbUNQcFV6djB0eXpibXpJS2pjcldiOFpubG1QS0RJcUxsTzl3T3ptOWFa?=
 =?utf-8?B?VUNzQ25sbEY2Y2dLZWFhdGpnRC9CbE1MRUZhcWNxWlBKaG9rUWd1Wk1oZ2Nn?=
 =?utf-8?B?VDArY1JmQTI2dGtubnBRWE9aVWtsbVd5azgyNFcvTjcrWHNzSkF0UDRRcEkw?=
 =?utf-8?B?NHRsY1NwVHpSMnBEeExzbXNab01FOUsvS3lZbXVBRVFJTm00akJ3dGlwbWRk?=
 =?utf-8?B?WkcwaEpVYzRJRTdLSkxJRDNJNUlFNjhnbEVKNGtHSzgzZEt6VnJ5S3Qwd1Z1?=
 =?utf-8?B?NU0rTE1nWGdDT2g5aXJkOSt5aXJwT0VQcWxBenlmYUlUS2hWSzcxY0RXdjNE?=
 =?utf-8?B?T1VpWDV6UFZUVFZCZTgvQXFuREhKTnptS3htR0NKSm94N3dNM2svbGF1bzNr?=
 =?utf-8?B?NXhNbnFicG1kYzg2aGZmK1lqaWR6UG1tdnlGeVdxU0MxclRQYXdYNFJ0RWNG?=
 =?utf-8?B?RXIyc2lCNm1NN1NuL0xUKzZZRlRnN1o4dkVlUVI3UDNFRDF1NzlhWVd1bld1?=
 =?utf-8?B?Sk53bGt6YXlXb3RZRUdid2dKWFlWelhWNVUzU21Bc0ZvMHE3RUwzMW1lZUtK?=
 =?utf-8?B?U3paZ080M0RDZHZ5Q1NhOWJmdnZ2cDIxMjJhUndQRnVBakNTREhmSnU1VFNy?=
 =?utf-8?B?NlVacU1RRVdZMWRwTjArWkZPVWZhWGthK3BHR2k0NStoQ0pwV2MwOHh4aldW?=
 =?utf-8?B?c3B1T0ZXUGpQT2pZd1R3ZytJc0NNS2ZRODVtYThYUnRNbHZNekt0b2l5NEFq?=
 =?utf-8?Q?/QYQbSP5AoK+vTTOJgdJbGNEnVTEsTe3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1RLY1Bvd3hoaXVvMGszVy9Cbm9HYW1zUHVqV3F0WFhja1FRSTVHWERwUlFG?=
 =?utf-8?B?RGw5V25CNmFrWDhDQ0p5d25paHBvek5kVzloNHVIQis0TkRLd3B4M2kwWXcv?=
 =?utf-8?B?OUlTN1J2ZTVRdThzVGNVSVcrVFUvTUhqMGtob3d6TTZXNUVrR1NNSnRPNnRC?=
 =?utf-8?B?Qjdta3J0T2JUMDFoRDQ3MnBLaUpOa2JDODFwV25HQ2pKSk9nQjh1bUxrSkxU?=
 =?utf-8?B?Q2pHaFR4dEhqYWxsV2ZqUHhsQXovMlVIM0RPRGV4TmNqSUVKYUxTVWRtR3pk?=
 =?utf-8?B?TWZ4RW9aZFM2Q084VGdOdW4wT2VpajQ2TldvODBIa3JxYUtLWmpBZHZvNExO?=
 =?utf-8?B?SjFuUlpMWkRUVkhEUUpLcitKZ2k2NDVDcmp3Nis5Z1ZhVHVpdFJjQzY3UVJH?=
 =?utf-8?B?dDRLOW5YVEk1em0wMmltVkN0Tis0eHlKSERLWXJsdGs3QnRiTkZUUDF1cHo3?=
 =?utf-8?B?WkJrMWpISVZoQ1hUa3lDY282M0g1SmltTk9tWFNGNU9DN1FjUURZenFxbmw4?=
 =?utf-8?B?TEJNbnpKWE5NcWJJU29IaTNKMldaNHdRWHlBV2J6OFYvQjd2R29QbjdrYVhR?=
 =?utf-8?B?UmkwMWhsOGFCZXRyTVVuUmpKcko0THhCb2g5UVYrd1VQNitVckZ5TThJNkg1?=
 =?utf-8?B?UFUxc0FFWGZXOFVVaTErMWJ4Z2U3QW44cENjNjlodFcwbE9hbzFiT001TnI2?=
 =?utf-8?B?My8vS3AwUFlzOHFkWHcvTXMxMUxkZG9XRHlzY002MzJwTDIvemtjelB3SnF4?=
 =?utf-8?B?YmNBSmRWY04zc0I2QW9sbG9pWDJubHh1RG5WWHFPUjBvRDhaQmZCK28wdGVD?=
 =?utf-8?B?Zk84enhCMTU3Q1RNYjJHbFhyN21EWUsyWkE0N3FWdHVmeG1FRTZFd3krdUpQ?=
 =?utf-8?B?M2doWHhyMEtzd2twQlhVM3hjdnNHcWhnbkRxQjJudGhRaFFxYzFQTmpZYjBR?=
 =?utf-8?B?SGYrSUNKdTh3dXNQbERPenZDdlc1TitBMlRwVmx0QWRzYUhsVk9rcUNzZVA4?=
 =?utf-8?B?QkpOYkRVTDBPOVgwV3pvOEtBTDAvdUFVM1V5aGM2L3NES3ZXQmdEbm5RQ2Er?=
 =?utf-8?B?WGdOZnBiYmpTZU9jbW9pMG9KT1FUNDF0R3duMHI2QWxRQXFpS1RmM043d3Zr?=
 =?utf-8?B?Z0R4RXdLYnZxc1R4eW0wWml1dWdDaysrOXc3YisvRnJ3VjJPeFhicWYxTDRQ?=
 =?utf-8?B?Q2N0WWh0VGFzaXVEWVA3UjN6ZVo1WUNpUDVHMUtKTTBrWUdESVFtaklxdWFh?=
 =?utf-8?B?QlpjcExlenRaWk05bEVud3NncHFDaFNoQjNZOWVVQkV4QW1wOUpKZ3oxK0xi?=
 =?utf-8?B?YURzZ2o2MHArQmMzT1Zod2dDc0owSDNKV0RIakxONXF1bGx0a2YrbWlEN3pO?=
 =?utf-8?B?M09tSzZ2MlM3S0ZOdWhiOHpnclhyczdGQlppdERDQWFEYkFOR2puaThnUUln?=
 =?utf-8?B?Z2syMlZQMTA2NU5jSTFaVFhYQndaWjBTZE01ZEhJNExvck9MRzQ0MVNoejI1?=
 =?utf-8?B?ZmE1aUNFK3ZvbEYwMVRsRmpqUjlJSGdIalA1OEVDNU56djRTQnFtY0wyRjAz?=
 =?utf-8?B?dXkxaDdQd3RBZE9PNWhkOE5uVWtVTEdBZ09CQUQ2Ym1EM0U2R2RYVU1aUHNG?=
 =?utf-8?B?OWJLTEN0UGZoaSs5aFF2VTV1eWdqTm4xdytkR0lpTCtGZDFXM0Z3YWl6NDJl?=
 =?utf-8?B?dHpGNVdXZXBzNE1WOVJYeDJCbWhCYTlZK2doRUpOYmx0Wk5Lcm5yOUxlbVpB?=
 =?utf-8?B?UkRlR2p1RUlBdFBpQUxtVHVHdGlTNEpjWXdTQ0VSTE9iSHlFekpSR0Q4MGpj?=
 =?utf-8?B?YytrUFRkV3gxUnc3c04vTmw3Sk1zTjJkdEVBZFcwTWoydXRZUEQybDRmblY5?=
 =?utf-8?B?S05iKzJrV3F5UVpmakp0MUZ4anpLV2FlODhpSEpuWHRnbFBFdGlEMFk5c0pQ?=
 =?utf-8?B?NlJOOWxwM2pTcWZENFVsVSsrYVYzdEpvYU5JM3BoUHMyLy9lVTA4aU1Cdm9U?=
 =?utf-8?B?NE1zbHpuT0NWemFORFhWMTFUTDFrN2RyODdhRTF0U2VOSm1seUZsMTdDamtB?=
 =?utf-8?B?akR2SENrd0xtRVpJeTNRTU5QN1ZLeG9nMkp1enlJbHlqU2FvcjhIOHVPZ3or?=
 =?utf-8?B?MnkzQ0t6alVmT1pWNzVWNEVkQitMTWt6MUhybEx4aFRlclYyRGFqK0JPMU1v?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3070d68-d04b-4db1-8779-08de0b53b374
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:58:45.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJqAl4rNQVM6SP1LdJqsJ99USmdk9d0MCppe3KcmiSgUzGLazJBMUpC/mNwq0hy7dbY9v0k+6E/9NoB9Lh7uUS0ZYgdv484DP4eeEkVRlRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> In order to compare the resource against the HMAT memory target,
> the resource needs to be memory type. Change the DEFINE_RES()
> macro to DEFINE_RES_MEM() in order to set the correct resource type.
> This causes a regression for platforms with the extended linear cache
> enabled as the comparison always fails and the cache size is not set.
> User visible impact is that when 'cxl list' is issued, a CXL region
> with extended linear cache support will only report half the size
> of the actual size. And this also breaks MCE reporting of the memory
> region due to incorrect offset calculation for the memory.

Might be useful to mention that hmat_get_extended_linear_cache_size()
uses resource_contains() internally, took me a moment to look that up.

> Fixes: 12b3d697c812 ("cxl: Remove core/acpi.c and cxl core dependency on ACPI")
> Cc: stable@kernel.org

The stable alias is stable@vger.kernel.org

Otherwise:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
