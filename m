Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCDB286A4
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853628; cv=fail; b=WD/02AhJivWP8LHylkVbrcmfGs+eZJ9Xg2ChKPJFlUOD8k0sSMPmbb8100OuFhrpiTfbQxH3A2RROLkdysMOk9IwunuqWQHx0eoRb57WNcR2V1VkrvZX+FlEBUpT+ps42haPnX7Koscz7ffHaMuh78OHeEsORzIIlwcG3dr5enM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853628; c=relaxed/simple;
	bh=zwRjD3GcZzVSRr8AKnbd8/3z51KRA1rFuAVO2MfGUlM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=lqCRdEjgwlpmhi5xa2uH2QFCPgMnceQ3wAReIpffwDBTZWm5LyKV6BLx9o4TMhVYKvqJj1ITydDtZmODUJMlRP1HGoaW3k35YKdYTGsK8PLezTTGDmuHVsDEWfi22tDGJkG/JnDbqygPnmZ+aQSk+/PoieVzLhcKjiVbZ3Vp/0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CebV6vA4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CebV6vA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770853628; x=1802389628;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=zwRjD3GcZzVSRr8AKnbd8/3z51KRA1rFuAVO2MfGUlM=;
  b=CebV6vA4mcR6JM3BxWDF3v7v2v5c8zmTfMB9MofnA/sdgQn/ruetSSwA
   Y1SmmvENwQY9i5VGMg3/D8giKcu75ZrbYUuk7crJzExidulYZC2AOwtgb
   9LHZlTIxDRC5q/kchuNH93E9D9HcqxjeJ98hPLWN4cV9//7jvSidvXWwO
   M7SWCJqaSKbiKJ5Ctezv5jDqCu/vlKRNae8/GBo7PjCUgqvn7dOYguy8y
   gKPHuJMgGDlT9UGb4zaWBkZ3vpLEsRchW0EWJOyY3oIifwVZvZ6Ty7OvB
   Az2z2i30WmvIfOhUEwfkQ1VXvkpIEHrG4P0kW1rlJYRojfYGJJz/vavgr
   A==;
X-CSE-ConnectionGUID: 6BwfANztRZKTkAPpELSSkg==
X-CSE-MsgGUID: qfcGm67iQfeeFXUde8SR6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72200036"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="72200036"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 15:46:52 -0800
X-CSE-ConnectionGUID: T5XXXqewRP22HDDt2n8gzg==
X-CSE-MsgGUID: qP3fMPI9SnaVlhxyq2uYkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="212498373"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 15:46:47 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 15:46:46 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 15:46:46 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 15:46:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP2T9ZCJetEzGRcPHH2noB+oVCHU1RExoNEkv64CTiiAPEO8z1MrCCWHOliNX4gnpAeaaHslreSzE7U6B+cxSjUrxe02fJqUmFxos3CQQ/NTxbPMot4IdmpHRhqoFcUS99HAxp0CFFKskeralTklYmem9/IrJ81zMwNsoZ/RkWvIyNkQUN6Dh/Y6twpXUcCFP1PTOqN0F5Aed6esuGssJMXlSjSNA5e9qrkeJ8njHNUJlucLuJAKZfZjb4CIAxHQolxSzRx8NAqX27EEb3lqBZUE2Sx0NdKbVtrHfvU2xu56+Au0JH8nN/r5a9eMVscmbWGkatWL7H8J1gnTPKS3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy5HBSk6v1sXknsgRH6Ape156JqXonGB0Tg7xA1RVHo=;
 b=VDYwJqnn0YA09z8fxhSwrjEXrtK79uYeHEaduToYk8h4jedhbvQxpiG64hVxTBaslKaXNHCe4u1OrAYiNO/nj9DS3HE53FgmfAUY3/NW0VHUc1k3eRgPTBog2pU+bLg09cn/uZH/XiBe5X9Au6Wx1XV9MIRU6Fu8QwctT45F+hba+wHkS3216cwwBkzTkcaBl0SiePhPwKjwqFeKgacLEjxddIeIgfGsyrY5zYT3fljCFEN55kbHYF3K2MeKoKmJXaztqbqidieqXX+bsBywhpAfoNq4PL75tpQ890RRaqcgS0i8ztxVvYvpZ3c5JuXSAvMeBIrucNVzjz+l+iWeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by LV1PR11MB8842.namprd11.prod.outlook.com (2603:10b6:408:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 23:46:44 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%2]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 23:46:44 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 11 Feb 2026 15:46:42 -0800
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <698d14e26e776_8c3210025@dwillia2-mobl4.notmuch>
In-Reply-To: <20260211232630.480509-2-dave.jiang@intel.com>
References: <20260211232630.480509-1-dave.jiang@intel.com>
 <20260211232630.480509-2-dave.jiang@intel.com>
Subject: Re: [PATCH v2 1/3] cxl: Move devm_cxl_add_nvdimm_bridge() to
 cxl_pmem.ko
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|LV1PR11MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d051b3f-c880-48b4-dd45-08de69c7cfcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1B2VHZVV1ZKcWhoRmowaEJud0hSK2FpelBOSGJnSGgvbjR4bWxmY3lhR1U2?=
 =?utf-8?B?UlZ2M0RiZmVIdW4zdC9NT3VkUnFqaUs4aWFIR3JTOUMrUWlBd2JlYXQ0YnAz?=
 =?utf-8?B?eXZpN3dXb3Vuc3V5Vm82RjRxMGc0NEdDT040VHQ1OTBaaE1kaHVvM1ZBSytr?=
 =?utf-8?B?RGJQenplTml0NHBTUkVhRkZ2bEZtQ0wxU20vQ1lFMGJHTklwUDlOSStzN0NE?=
 =?utf-8?B?eUx1RXJYbzMvaTlnZ0FwTHpTbE14L0s2c0lJYTBaTk5TcnVvenY1OElwb2FU?=
 =?utf-8?B?Um84L1VUbUVWeXk2ZWxTVWhrSkhCSTNXZVlhWWNLMDlDdGJzN0M4cStXcTlv?=
 =?utf-8?B?SHUvY25WVlJ6UlVneTJVWFZQNUNFQVhpbzNyOHVxRWI4TlFsNm1WcmkvbEw4?=
 =?utf-8?B?aE16ZkpjN0pCZWpucVdndGVRaG9waS9vOG5OcU9KL0RuY2ZaUk85dTU1WXZx?=
 =?utf-8?B?MnkvM0JaNG9zU0Mwek0zK24waVcvZDlEc1U1L1BkS1lKZEFPcWNUakhXZXpX?=
 =?utf-8?B?MTR4eC85eWhkRE1VMytwdEJ4Z1lFbWs2K1VyWlRINU0vYkltN3dpVkNvcFZB?=
 =?utf-8?B?S2hSTGxhbEhobVlvSUZpZ0c1U3VKQlBmMGRtSUdDeTNwRlZQR0lnTUtQR1Y2?=
 =?utf-8?B?Y3NZQnNudmFpU1A1Q2tCdWtTTWRITjJEc1R5N0VIdlExU3BVQkswQ0hZMmR5?=
 =?utf-8?B?emE3OTBuZkY2Q3pPd3Z5NzY3LzdwbVJGTHBOYVZKa1lRdWJCTjN1UXNTKzBN?=
 =?utf-8?B?WUhTME8wUThFeTBsNWdzaGg3MDUwdG5EUEloazhBUHptaHIwdVZkbk5va2VG?=
 =?utf-8?B?Z3ZpemxNekVhTDNaWHBSTHN2OUI3VDdJMUx5d2FoRis0M2hPMEVQZ0c4Qkg5?=
 =?utf-8?B?YS91T1BaZkZUVEdqYUpxSGEycS9EbndiS1N2eFpuRk0xTUtCMWpnZ1NSdkZU?=
 =?utf-8?B?OFFJSEJmOHRRUTcxUFRyZStsTnN2N2RMalFPcEFmRjFCbFYyOFdWT2diNTdK?=
 =?utf-8?B?ay94UlFzeTl5STBUdUs3alRSdm0rTkdRQzk3b1J2RFZnQ2pBZUc2ZVJTdzdU?=
 =?utf-8?B?K2tEQVhOTE5ocUpqSkVmaHBRQTRBNnJCK3dCNXR5SFhQVmg1UzJzVUY4YVlB?=
 =?utf-8?B?RUQwMW1iRDM0K0RJMDQ5VEo4L1ZzWUxIazc3OE45Q3doY3pTaG92VFFreWNl?=
 =?utf-8?B?MW5vaFZKanp3b3VPNDJRSVMxRFJPakswOXQ5MDVKOWMrOFRYbXBIdDhvaXdQ?=
 =?utf-8?B?K3JjZXJZS1J3UDZuUjlmOExqYTBCakdTNUU1TjJKbExWRmtPdGNCZ0l5TSs3?=
 =?utf-8?B?ZHc4NWpRZDVJeVRaTU1RVll2OWR0eXZ1N0duTitGVGtQQ0thSVVub1RXMVBW?=
 =?utf-8?B?dkJ0dXZ3WmFhalJ6emJMcVN4ZDFoYnh3N3JNa1NKZTJ1UkJFVmF1S0pjbk1C?=
 =?utf-8?B?RHI5c3E0YUxScEpXR29YSzM2OXVFQjA3Zmx5MWtrSzZEeUZ0VnowdCtCSHFm?=
 =?utf-8?B?Z1NGa3ZQYzMvRCtQRmdoamUwMkZtVlVieC9tQXFqclZWbnlpNFZIcDRPa2N6?=
 =?utf-8?B?RC93dVYxNjlMZXRCU2NRUzlXQ3BXYWFQeVF5WlhmUkFmTDJiZDhSOVpmQmVU?=
 =?utf-8?B?aFQ2Y2U3MTdCS3hmM25zSlNsVG1DamF4MXBwVkNSeUp5K3JqRU9GYUJ3bWFG?=
 =?utf-8?B?MGZ1bmNDK0dGbG1ySHZXWlJYQnYwOUVUQ0V0NFBaZFozVS9oSGk5VFlNZ2xV?=
 =?utf-8?B?cEM2VFVkdmNYckpHYjlMVStwWEZBKzM5VVR4b3hXS2NzSWltZi9nbmZqdEZl?=
 =?utf-8?B?SVJHL0Rnek9oNG9FUC9vVHVwM2pKdk41QXI3eGVJQkdzdGc4T0dscEJFRFln?=
 =?utf-8?B?dmxTL2c3OG9JNS9JcTdoUk8yY3ZZWlV5WVhJZURqd0hndkNydzZJR1RGMU1Q?=
 =?utf-8?B?WktISEVaUU91cDZxT01aekkxZWpDVmVVTTlseGxTYTdYMzlVWTlTMGJmTDMy?=
 =?utf-8?B?TmtoTFYzQ09jMFJTQ24rOHB5RUFDbW1EUFg5SFFBc1JTNjQ5SGF5Nm13d2ox?=
 =?utf-8?B?UEpWQ24vei8yb1JHRU9FTENXMW1oQzJURDZmU3ZuOWRucE01YWE5aENWUDRo?=
 =?utf-8?Q?tNeg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJVMjRvVHI0T1hzWTVTWWRFUDVKWW1uRHJtbUo2Y3Q0dnRBNDM3WDVYWXdh?=
 =?utf-8?B?bXQ2NUkxbDlJbUkrV0tkRkJWTkpKVWNNLzI2MWpjM3FnR3FpRmg5cmZIQW9j?=
 =?utf-8?B?QkJ3L21QQlZGS0k1dzd6VlE1ZHNETVQ1T1BuaUNBRFF5SjFHSm1YUTJlbmRQ?=
 =?utf-8?B?MUFnUzg4RHd6aU1pNDlLclZNWGd2eHA5ZWdJWlRuMjJOVU9yYVVteGRZZDNo?=
 =?utf-8?B?K1IzRnJjV2FwdUEraVJHVnRaSXlMMnAyTnhjc3FuTGFUL0VVNklkTXNoYXdR?=
 =?utf-8?B?WThqdzJuRFByU0ZUT3ZBLzkzUGZDZDNibU90QWJxc250TTV5aC9VTDlDRjJE?=
 =?utf-8?B?b2R3cVIxSFV5bzV0eVZxeVB4cHlLUFdsenJLK1gwMExlbjRENWVmaW5oRkRl?=
 =?utf-8?B?cXArVjlDVDNRaUdzMmU0WHR6NDg3Ukd2dGNqQTVsMld1R3dCQ3ZmeDZHY2RH?=
 =?utf-8?B?TEYweVc3cXcyd1VtS2gxTHpsa0w0MmRrb2JjVnR6aEpaZTZ5eGY2aDljQ0J6?=
 =?utf-8?B?eHNxUmFCR1RXakRtODk2REhKN0c2Vm4vVkwrdkVPcUpOem1LOHo4N2NnSmJr?=
 =?utf-8?B?RXovbURsYTcwbXA2QUJrRWJJSzY3ZlNOdHlvNGp0Ukh5Zk45L1pVSzRVVUho?=
 =?utf-8?B?Nm5nYWpKUDNLSVNEUlpqYXBtVFg5RDVrWnRGR0xmMXlDYUI4Zk0veXFlKzVI?=
 =?utf-8?B?ZG5ZOE1OK2NSMU5xTVlpZ0RWZDdDQldTVVpkN2xiUlRnN000anM3M0N5Rldp?=
 =?utf-8?B?SkVBOEl1V1kvdkh0UmZWVzRtWjJISlRPUGxucGI2N2w2VUNTVWJoVUdFdkpD?=
 =?utf-8?B?SVFvQnJqTFQyMmpnWjBGNVVaYUNyY2FYZ0dYODRoU2p4cHNEZFBaMXZlVE1w?=
 =?utf-8?B?SEdtS3NoRnJ6WmNQRTNMTjViMExqSUpBc3RvNXRUdU83RitTVFRBczMrY2RG?=
 =?utf-8?B?NC90UnFJYWVNd3Q3ZGlrWlBUODRxdndDbERkSDdjY3BOMHhXWm5LZkd6QkVs?=
 =?utf-8?B?UlNpRUpGOFN0c3hiMG1iTzE3dHNoOEVMU3BaeDJEOVcrdlIxYmdWRU1UOE9h?=
 =?utf-8?B?eHB1UGVaTG5rVVVGbHZPNFhpTWxwMXN1dXY5aDJmd29uMXptaXhKbzNwNEto?=
 =?utf-8?B?U0RESXIzditMM20xZTlKVlkxSUpVeWNNZjRiWXN3VksrbW5EZ3pBdENRT0pt?=
 =?utf-8?B?Ni94MFdnZVVTSXUzVVk3NmtqYm5iZkNHOVBRZ2NFZDBKbTBRY2IrK2FpQVlZ?=
 =?utf-8?B?a29Lb3JBZlV1czRmMTl1T3dEUkVqbVJiZlE0OVJibVJ3dnl6bnRtYTlHajVC?=
 =?utf-8?B?SWdqNllrSGh5VTk5RWRlQ1lRNGJxdVprbFlwaXBjc3JtbHNYdVFGUHBiaWFN?=
 =?utf-8?B?ZlNvODNJNjV2UXY3UjZ4N2RaYnNjaE1IbC9aL2kvVCtDUk0wdkNVMzRnN0lO?=
 =?utf-8?B?WWFPYzAydVBIYlA2WHdVR3FmZ1o1SFllc3VwUE5VWk9ucVBrckJCVUpXMWpv?=
 =?utf-8?B?RytVWHlsNGRGUU92WXp2MzJmNVphQ3FoNXpzejFCVkx6UWNZTTdRWm1sY3FZ?=
 =?utf-8?B?QjVsN202WnpNdEw4UE9PZXBPRkI2SmNXRmg1TGFCUWdSZVVxdElHOVBBM3A4?=
 =?utf-8?B?R294ZGVQZWFhQWRrYldjVUNkcm1yMk9pY2lmRE13QjA4Y2paWHE1NHVMcTg3?=
 =?utf-8?B?eEZVVTdtN1hDSXlyL0NyU3hBUTRHS3l5c2xhYlNMZGtZb0xuVkowc2Ixa0xk?=
 =?utf-8?B?cWczSklvVU9GRmo2dXVQeGVsMk40U2VKNzNzYndaTDROYStZNXR5NjZXcGtj?=
 =?utf-8?B?bEtHTnNlZEFkdzdDVlg3emlBMkJ1bllTRzl1K3AxNFVsZ2MwdTFQcmZtNllN?=
 =?utf-8?B?eWxsdFczZ1BjMlowSlV4b0t6Rjlxdmtvc3pvSjFmZjhaR0dNNzYvTFlJTmFn?=
 =?utf-8?B?dXhHUTZhMk5vTDdJc0c5QzVuQ2VtQmlBS3d3SXpWY1cwSmZRK05Zc3hNaGtq?=
 =?utf-8?B?UVdnc1pvTnFTVzhJTlBXemdUVW9DQlRhMWNIOGh0M2tHbzF3UUxzRmY1YmR4?=
 =?utf-8?B?NmdIVnF1N3NJS0FMYzhGOTlGemZhcEVQTmlqeWYxbnJ2RTBpa0dMSVN4YjBE?=
 =?utf-8?B?WW9TS1pvZXlBQmNhZ2RIOGhTdGMxVDRoZk11aVFxYmI3b3E2RFZUQWJxYkcy?=
 =?utf-8?B?a2Z6MlVoWGJUZWJsWG1EZ0RMRVNHVFJEQWFKZURqSFprQXVZUjFpeWNzRTRr?=
 =?utf-8?B?N0x6RWtHd1FKdlZCaXlKcnZwcHlKUWdJMHlSL0dHUjM1RnIrWG5NNzFTTmJU?=
 =?utf-8?B?aWx6SnorTElLeFdmMVFmeGhIVzc1Q25lQ2JnQmRmQ0NFSmRVckw4ZTluQkRD?=
 =?utf-8?Q?veEX7T5UNqmTRqlI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d051b3f-c880-48b4-dd45-08de69c7cfcc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 23:46:44.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jx4CyOtDC4Jb6XviWPYLDZH4MCTVz6d2Zg/HboG+xYhJPAcwvUNFYYSzESb4Vlw3GjfpwQ7mklwdJGWpddb0+W6Y1xvo6go0iqTfuRGasU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8842
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Moving devm_cxl_add_nvdimm_bridge() and related functions to
> drivers/cxl/cxl_pmem.c, so that cxl_pmem can export a symbol that gives
> cxl_acpi a depedency on cxl_pmem kernel module. This is a prepatory patch
> to resolve the issue of a race for nvdimm_bus object that is created
> during cxl_acpi_probe().
> 
> No functional changes besides moving code.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h |  1 -
>  drivers/cxl/core/pmem.c | 86 ++---------------------------------------
>  drivers/cxl/cxl.h       |  1 +
>  drivers/cxl/pmem.c      | 84 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 007b8aff0238..8ee0c3bb2065 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -7,7 +7,6 @@
>  #include <cxl/mailbox.h>
>  #include <linux/rwsem.h>
>  
> -extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
>  extern const struct device_type cxl_pmu_type;
>  
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index e7b1e6fa0ea0..50557d71a45f 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -21,7 +21,8 @@
>   * operations, for example, namespace label access commands.
>   */
>  
> -static DEFINE_IDA(cxl_nvdimm_bridge_ida);
> +DEFINE_IDA(cxl_nvdimm_bridge_ida);
> +EXPORT_SYMBOL_NS_GPL(cxl_nvdimm_bridge_ida, "CXL");
>  
>  static void cxl_nvdimm_bridge_release(struct device *dev)
>  {
> @@ -41,6 +42,7 @@ const struct device_type cxl_nvdimm_bridge_type = {
>  	.release = cxl_nvdimm_bridge_release,
>  	.groups = cxl_nvdimm_bridge_attribute_groups,
>  };
> +EXPORT_SYMBOL_NS_GPL(cxl_nvdimm_bridge_type, "CXL");

-ETOOMANYEXPORTS

What about just copying the approach of:

1f1cb7f0c255 cxl/mem: Arrange for always-synchronous memdev attach

...that did:

struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
                                       const struct cxl_memdev_attach *attach)
{
        return __devm_cxl_add_memdev(cxlds, attach);
}
EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");

In other words keep all the core infra in the core and only have a
private export from the core to the driver module.
