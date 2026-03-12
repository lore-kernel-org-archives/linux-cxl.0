Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D93890F5;
	Thu, 12 Mar 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773288336; cv=fail; b=oavKtxANO4xPoAMrPopBVerd4O4+C6qpO5D8tFaubzwpXoZxeyNmHdRSyqmMzNr2oeb5KRFFh8zEwZ73FAQAcHRR74gO9I5IO0VlngCrPBm/TpRmAUNMik5eCeZbA1Tcs69vk6lLdAV52gzVoEE97qrvIqm4LlE7m5HX65B/ryY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773288336; c=relaxed/simple;
	bh=nk5cbz9no5S2NsfmmkQc6c/cq/LTv/t3VmTjQ/Bw2CY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tgt/NWuA36aUTyQkvRIGZZcuLYsk0t05Xzxh9zjMNUJPVt7TLB8BCuj8MJd4dctf5QKcb+8wWTBJjB8MlSV7dxNEnYGTk+8CCqoQOE3KbPcHYOgWmbrJ79rNaYhwqF03obAKdOjsw9pAvISGvYo3El1D9J8YJtFzzJkiupRYpio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSsRqJev; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSsRqJev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773288334; x=1804824334;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nk5cbz9no5S2NsfmmkQc6c/cq/LTv/t3VmTjQ/Bw2CY=;
  b=aSsRqJev5AVoXQQEed4T/XF+eaZqY0Gq/avhZRmCtyM3+U0IiFh5G3SZ
   wzrJWpyX7js8hbOlBy+yVYc/HF3WCUDTBes8bU5F6RDXYXn6AaIBSaDby
   VjeP/p2gZ1HmPmgJWVyhUD5f7GAXFCve9EiCGoZA2GwYZmTzTCERjoVcn
   Q/8ZD5zA9L02BQWypVfUVVNOcx6Doq8sgf2DUEzm91iPJN4/5+VVs7766
   OLxiKwHcbYetWbMkzvAeLrHMOnM/Mu8tiXayNx6bG//wLNAYooUsBtRv3
   KS7PC0mQ2wBmFC9Llk+s3kAow4RzF8lk9os4LMQG+cPbW5ZEJSfs1687m
   w==;
X-CSE-ConnectionGUID: TWHbDehyQ5SNZHVEB5XyWQ==
X-CSE-MsgGUID: ZFSkPeIHRcy/aCiaDJeU8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="61948372"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="61948372"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 21:05:33 -0700
X-CSE-ConnectionGUID: g0dVWtpgRp252LixlHwd1g==
X-CSE-MsgGUID: lcuh0y+YTuC4J75jPcy6GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="225657353"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 21:05:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 21:05:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 21:05:30 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 21:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKUYLELqHOJK7UA13J6w6vQKFfCcHZ+v0h1jRZUDEufMQdyJJoDcEnCGibUHDA5ODQKVZG/PWx6wa3tZ8NlZabrjeyHSUoZGma5klVLHRJapyDdR73pcx4XIyUfkub5dejgJzXNyVkQpII7vfkErpFqf2uC4AeVs08/zR3BaRA/vTtyL8lFrCVID3Kg1+y/KuaPUScgMdK67rM+I4GsDm4JDA1aEW7KfgG2JnVfoXXHREPq/s5K8od6wblLmBYQXZCDyQKz1Ywj7RBmdRpcR/882mqufvZhKviBT8I9vGxG/DkaviEeOXI5BOVNrZ8n6gWofsxtGJxKAQpCDo8czOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dWpU3REMPRiuMCTmg47+rHVfZNLXrHOsHHmh7rBOME=;
 b=HHCYIkaZQS2NXtpBVCBBUoKMVzFaoM8m04ltbTTm8FRPPkWckOXPLmLT9PlHJgJgQXyF2adPcEmVIKJXHhoTpVBqWra3/KN8tYKJ+LJuxZFL6klT/xryFgBxjS1oX6p4ZSXF3xXhqbJQvfz4X2C4C2+KBpwKM5AITBe1/OJ3ZIX/XXz/JK1Zpd8nKxEFN3MsCETCPKlr4ZcX+WdzeeEsI95IK1Q1uFMSl9rGDIRt5uOc+pWLuFRshRpmvCZncrF8OZEUv4bLVgRjCpeYWCJxUZB2jABZy4K/XWjw9uwIuft27srdrJtGqdeC9vqinLc+i9QoE4F7ozmzx03fCoWGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 04:05:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 04:05:28 +0000
Date: Wed, 11 Mar 2026 21:05:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/7] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
Message-ID: <abI7g5xdfQTERoKX@aschofie-mobl2.lan>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-2-94fe919a0b87@zohomail.com>
 <abCOZf9vkau0AyWL@aschofie-mobl2.lan>
 <530f0541-851a-4201-98f3-93439825c6c7@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <530f0541-851a-4201-98f3-93439825c6c7@zohomail.com>
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CO1PR11MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 063589df-a062-4bdb-f165-08de7fec98d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vJWHCCWvbNuworDnJkaaXFWsjoXJKZY6mUDzg7l4IWxAqidUwFnUVPqA1FZyuPFoPZT0ZFSWiFEh+jlZotVjJTIXVmdSi1SH05zM25PIYgiqgQM8OlAuY+HyN4zdk9RxddncXVjt69tAGBxo2ZIX20BL6khtrR+6pypGAyAeqcAhMO8ta7J/OGlQDuawQev84g+JeJZzoIWWvpbVt1Wc4pEHNzm17yyAIcI7kNg76jytVD/UfoSHhswlcZk0JMqiP1O1VyezdRRvT1XxT+ycnTgJiOPfaUqvPhUHokS2pZrD7n6tFVfUMinCdryRzeFpsZXgemxmpcNEfWV1ULOEb+/zoFodffoNehLmZpRk8yoo/HVnviu4CMGIPgjR9xdfaR7qRDmbDjVOJpRj6Bn9eK+2FQViOTEowHCws5mRBUhNXcCQVRxuGJucFHrMhdb2D9sRMfgbsh6hM0C6fEKrebXI7H7Y0W/QPio5THL1iGPbgTqILUd8usPVZ0Hl7oAKt2XdLWTTblcBvchuJv3ApkiSMGi9g/cp4CzRtWAhLZcgsEAUDXXmMgFkxNQYE5V2NYyxXyNRfExI04Ewu9GfQXaEL+fijLK/i8eUCWADMhZRDN6KIScA4t7tTybi3wJdZ5jVqXibu6m4NndgP4hdJbguIRPyTjJT6k2VILvZDVV8baFGad3riKU819YmW0c+9aV3APVPJfUZmeNU9bLrq1L2qc88m2S208VcHU8gFBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHEzQ3pMVE51UGFjMzdncE1lL3NvSzY5dHV2RmZGbFI2ZlArWVdqc1l5eDRI?=
 =?utf-8?B?N2Z1VlhhVFZaVFFPd3ZkOTliUEJlNlFvOENRcld0NkdtRUR5c1d6N0NsbXpH?=
 =?utf-8?B?VitDUXFwK05MZE4vcXZwYzREdjIvR1hOQm1zUnp0Y0FkWDJmVUZYZGVVdWh1?=
 =?utf-8?B?S0Y5WFI2QUo1dGxPL0NNTDNKYStKdDdkU1hBdTV2dEh2WWZyREpDSkMzczJo?=
 =?utf-8?B?UUt5Q2dOZWQvdkgxZWVrRXVlWGlTMTBDRWZRMlZBU2FadzlLWVkydjlIU202?=
 =?utf-8?B?NVR5M0kwajVyYzBsY2hGVis5YXpMTXFncUEyUEN4L3B3dXVHSFYyNmJoUXNX?=
 =?utf-8?B?V0JQdjNJYlVGSWNxNTFOSi9tcXV5RitJVUZCZEcxdXJDZUxGdVpPcllXUGxa?=
 =?utf-8?B?NElPOVRWN1F5T0d2TE16czUwYjFLNDZQdUM3VmpxQ0RGQTdyWUdTUjJIam1y?=
 =?utf-8?B?aUFwQ2dYWmJZTFBQcEhPSWJRM0RyS3Q5QllhYWVCeHZxcjA1SmRTbWVpVEFI?=
 =?utf-8?B?SmM0RWl0ajZNRGtDY3pqSVZqNFQrNlJkOGR4MFZ2Ym5XclFwU3c1NnpJYTJT?=
 =?utf-8?B?bzcxbWhEUExEU2kvdFp6TFI0MDVhWGZObldENHZ6V2k4a2dIaGk2NXFKYlRO?=
 =?utf-8?B?RjFENkY0TUdCUnk3TGg3bDg3dU9wRmlhM1JYNVVwWTF3QzZxdit5bEtTbktr?=
 =?utf-8?B?dU42cFdmeDVmN2VPS3RzeHZBb2I3K21sS3JXbHRpcDJ4azNXVlhUSmdzL09O?=
 =?utf-8?B?WG5ER3U2SGd2RC81Mkx0bHN2KzVKcVZLOTlydk52Sm5XQlloekorWWJJTDNU?=
 =?utf-8?B?S2NZVldqSVhwMDBvWlY3QjhyM0tLTCt2RTIydHBwNU1BYjFFcjRzOEZkcndl?=
 =?utf-8?B?S3FXayt0Zml6NS9OTU8xT29yU2I1UEVSTFVKWVFYb21vZDdnUDFNU1hGc0Jt?=
 =?utf-8?B?dWxLL3M3OGhJUitKaXdnTXliT1krVlcrZzhmUGo4N2pHUnJzdHpza2NZciti?=
 =?utf-8?B?MXl5WHVyTVZjK1IzRU9RMmlpaTBOcFhJY2hPV0dQRUN5WGVXL3NEZis1OFVp?=
 =?utf-8?B?UEFRS01zdWVxa2ZqalJraUxNaGkxSmZDRmhvdlBmL0hXZUdmWjBsUUZhbkxS?=
 =?utf-8?B?c1UyQkZ2Um9HZ0kxRU4rUzhZdUpwNDhrTUlTTWtyaGZiTmNHV0IxeFI2NTVi?=
 =?utf-8?B?VzBLdDhuR29ieWFhdHJHZlRQUCtCZ203Qm9YUE1qY3Z2RmVXd0NlZVJFdDND?=
 =?utf-8?B?SEhRaFd2cHJoNFJvRHFGMVZPYmpWemxsTGVUSzZ5ZDRaNklQS1RaOHN1ZzJT?=
 =?utf-8?B?OHZHZlN1Y1V6RGdVYkExWWZyczQvbmRLMm9EMEJuUGhCakNueFlsdklWNWJz?=
 =?utf-8?B?Tkk4OWd3N01zcDhqbmhJOHM1N0dJSWVSK1ZDOWhBdDdsYlJEMktub1Z2MFB1?=
 =?utf-8?B?SGU2UklObTAvL1NabFFOYUNoSTFoOStvZTdGWHcxVEFNb2R1TjJSWFVPbE51?=
 =?utf-8?B?cnlMUHE2czJNMHlrek9zcnlsQlRLWjNUOGtCcUMreTlWMGROVjJHU3lVeHRy?=
 =?utf-8?B?MkR0RjRCQjVtZGtQTW4xbXY1NC84Nzk2aFVWeVRuemp4UUZlUUJyQWVCQ2Rw?=
 =?utf-8?B?MXBVYnE2UHpzSkovTTdKR0lXUXlPMzNwcXBqZGdXUXlwMUV5cHQzc3BKS0lP?=
 =?utf-8?B?MkRuTG1idVJYWmpmWUF2T1ZRcEFHR3dRNGlXWWhUc1k1S3I1eWxDMHgvK2x2?=
 =?utf-8?B?OG44eEZyZVVWMkRBRkNJNlBnZTNNK0puUUdPeDdCWW93b1JuUXhJQjJyWUtp?=
 =?utf-8?B?SURIUnlVbWFwTENDdlM2dFdFL05BVzBuQWU0cklMSlZHK0VwcWVaQWRpWXd3?=
 =?utf-8?B?MU15L25xclNBNXBOSE1WNjVkUGcxZ1RSenRQblFYOEkxY1gvNHZmZkRSUTNX?=
 =?utf-8?B?Rkxuc3luR1FlbnZ0YTdrWHZJaWFFL29OS3RDMElqOFpTdk13TWpDTFc3eU0v?=
 =?utf-8?B?cDB4a3FSZHNZTFRRSzJhMzRSVzJJU2cwN1VOM0JNR1lqcGVqTm1TNXRsVU1t?=
 =?utf-8?B?SS9zNlNkdERTQVlEQXBRbzQzei92NTQ4YzF6QStZVFoxNDRSUTVQOC9Bby9n?=
 =?utf-8?B?TGdkVG9PbURRZjJxMlNqR3hQS3FwU0swMVp1ZWNkcERjUCsxWUUySUNuRmIz?=
 =?utf-8?B?YjNNTU85MnZ0YUQyc3lKNmsyWXhzb1JIUVV4WEdkTFZlcTNKdXZHbWZSbHo3?=
 =?utf-8?B?Z1pDbDd2SzVKOUNBMTdzdXpBb2J1RC9JL0xaNERwWXk4OHVtclVKUDhPQkg5?=
 =?utf-8?B?d0RJajQ1YUlrOCtFQndSQTBxNTJmRWNsTUdmbWVuWTAwM2M0RGNwWnQ5dUk3?=
 =?utf-8?Q?OB0TTP7PQom5GgMc=3D?=
X-Exchange-RoutingPolicyChecked: f3FHBdP6C0y1DAMHPj/aQ7400JUmm7NBe7JK4z/v802VVV908YY+b/hq4i4X8mquPhWfSPUAHrlq+Kyrcdy6l2rmkOKRnTZtu+uXePmqbCL4nv2qMkew01N+g+ko3PsdZreD3O8abkzUl1Awvnf+LWNuAGDx+I0sJU4HCGE0GNXuVkTtYv+2L8LCbjqxGvxV1lYgseyy2S0jXx1JRqyTbobpO1QQMAZ1YkhT1z/9VTFdYDODXx8HtsYYAvRpItoExyXPVejfa48//LSvQpL9zwXt1DdV4WYOY7NTKIuWb5t6KIeAOnR7PBpnTJiT/4R96Nq60/AOx4W/PL/MSJqpgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 063589df-a062-4bdb-f165-08de7fec98d6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 04:05:28.8790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/S2/12BISfEDJFqF+nXMu+gzxTTRo5iVU1TAyacYvB+aCpPthYD2RubPAJ8geUq5k08Hk2FPVjxO1oBatGOcroObDN1Ra9hzWUy1QIkcN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com

On Wed, Mar 11, 2026 at 06:53:26PM +0800, Li Ming wrote:
> 
> 在 2026/3/11 05:34, Alison Schofield 写道:
> > On Tue, Mar 10, 2026 at 11:57:54PM +0800, Li Ming wrote:
> > > CXL memdev poison injection/clearing debugfs interfaces are visible
> > > before the CXL memdev endpoint initialization, If user accesses the
> > > interfaces before cxlmd->endpoint updated, it is possible to access an
> > > invalid endpoint in cxl_dpa_to_region().
> > > 
> > > Hold CXL memdev lock at the beginning of the interfaces, this blocks the
> > > interfaces until CXL memdev probing completed.
> > > 
> > > The following patch will check the given endpoint validity in
> > > cxl_dpa_to_region().
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Li Ming <ming.li@zohomail.com>
> > > ---
> > >   drivers/cxl/core/memdev.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index 273c22118d3d..8ebaf9e96035 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -295,6 +295,7 @@ int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
> > >   	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> > >   		return 0;
> > > +	device_lock_assert(&cxlmd->dev);
> > >   	lockdep_assert_held(&cxl_rwsem.dpa);
> > >   	lockdep_assert_held(&cxl_rwsem.region);
> > I'm having second thoughts about this since this call site is not
> > the 'beginning of the interfaces' as the commit msg suggests.
> > 
> > What about taking the device lock in the debugfs func, ie -
> > mem.c : cxl_inject_poison. If the goal is to avoid using the debugfs
> > interface before probe completes, that does it.
> > 
> > At this callsite, we make sure nothing changes out from under us,
> > no endpoints attach or detach during the work.
> > 
> Thanks for taking time to dive into this issue.
> 
> But I don't quite understand your comment, do you mean that we don't need
> above device_lock_assert() in cxl_inject/clear_poison_locked()?
> 
> You mentioned that taking the device lock in cxl_inject_poison() to ensure
> endpoint won't be changed during the debugfs interfaces calling,
> 
> That is right and that is what this patch does. So I am a little bit
> confused.

I was only thinking of moving the ACQUIRE one level up, to here:
drivers/cxl/mem.c: cxl_debugfs_poison_inject|clear ()

That would mean dropping the assert in clear_poison_locked().

> 
> 
> Ming
> 
> > > @@ -331,6 +332,10 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> > >   {
> > >   	int rc;
> > > +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> > > +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> > > +		return rc;
> > > +
> > >   	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> > >   	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> > >   		return rc;
> > > @@ -355,6 +360,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
> > >   	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> > >   		return 0;
> > > +	device_lock_assert(&cxlmd->dev);
> > >   	lockdep_assert_held(&cxl_rwsem.dpa);
> > >   	lockdep_assert_held(&cxl_rwsem.region);
> > > @@ -400,6 +406,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
> > >   {
> > >   	int rc;
> > > +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> > > +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> > > +		return rc;
> > > +
> > >   	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> > >   	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> > >   		return rc;
> > > 
> > > -- 
> > > 2.43.0
> > > 
