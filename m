Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2709223328;
	Tue, 10 Mar 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171017; cv=fail; b=U74GNWj/UshT0fy1yM5S+E4L8SG/2CFJItJTDUcnZpTCcdbAt5IB9UGITVDT/i+x9UXeg+5Y+Jl+lKWWLmWm7pyBBBnhCOMh6Ih6AScW5+wYGZ2kO4iQafVNU42zj9FllBsZY2VUU+TeX8L5w6CDBaRXsW4evEnfstS1psPo2Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171017; c=relaxed/simple;
	bh=lqLBsrgZa8PJt8XtUi9Ss6DMsPiA7mpI/ew7R35rsDw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=lPdtnGlt8WbqIF/NZFgUP7RpNwhIorHs9O3YeGjuBQdMi/3V1kD8l8dmSjt9+V8yhRlmBirM385qmMNZ+Td8VvOpvxOdeihKgaFIW+L7qh2WqE0GKgQj6mL+vO28QnPHV5UvicBBD95s6AFySV+cpVDtcExvOMccpUUFHuiaaKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8jebX65; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8jebX65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773171015; x=1804707015;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=lqLBsrgZa8PJt8XtUi9Ss6DMsPiA7mpI/ew7R35rsDw=;
  b=n8jebX65WOQzBWnfnmv9BfYEx6ROcyMXO2s2H4pUICQk3O+q6YysetNs
   A5XhXMXwMYo39Moq23YarZoUbb1ACkJ95t9udOa63b0IdLlw7IBdkjwxj
   M51Lx9i98fwJfbP2Cy5Fp2sdO9hsFrI7Xw1r8e+Ib8j1W1Sy7HVmxLXD/
   Hndf6NGkM2DuecCC/6x00fcOHm8ACCclkkc+tIuj+LyTQzl4lUTjuTE+Y
   Wajn68yzu6EGMf6gzJtz4by+0V9HFqj+FH3vAamg9TYn3ISb7gIYLa1nI
   2gLfSZIkOPntOqxx3LhIHW40by+CHYkoJesqmcdF+ggwAUcriRMDHTkSM
   g==;
X-CSE-ConnectionGUID: eXjp9aZSROy6YLzb76u7gQ==
X-CSE-MsgGUID: BKfAx+GuQt+tor8ZtZktRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74202868"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74202868"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:30:03 -0700
X-CSE-ConnectionGUID: uOvc0Te2Teqb4re1MWx0Zg==
X-CSE-MsgGUID: cC1A5IwlSaiTfW1t276byw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="222793755"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:30:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:30:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 12:30:02 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:30:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2OqWyQOTMLUdjih/d11POXgqlsf/l1BuRl1XwMThdJ2c0KaEQxgwE/SEyRizJciOyISSelhcCjw7JBhm+3Q2LdYoLPjkmqj8JbqDhbqQqDoTqsGrW+Mb4gVnRZ4Ipl0M6x59hpri6bqd6xUvO5JfGbCpW2L91PjBQ7NUKhgJ8BdiI95dEKDrVdbM14NK5Qx/ExEWMEYQIcQZiR69nmHusGrwprh6/FHGXbUxu3qn76833y9XT7yuXX0iTJ6Opukvqch3F4J/sda+IV+HzwewOpx+yaqtUkJfCKmV/pQqnGJT9EeEQu+s627YppjuhF5x9psGj1uJFLKUYFoi1ahJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJllakHaSB3NExB9HRIjcUYPVOKeBLvVNHNGrKYCSI8=;
 b=dVXkT5dQX2xvXRBIcF3eBw3oipxBsBzOvrTVWcN16Dk/PVrIWjlNmE0Qw13OiUG5i/oDM++0m+thHgpMq12AmPVsPindZS9ZRka/QAR084zyitiiwXy1EY2OvqKTR4u9xJDOA9R8rTCVRq5FIA8/uNvHBVACTIPQHzk1U7+K/XVBCw1SY+zxNsK/muGYkel+u90x7J9jupZML1E6mERK51l4GP1E6phSnJ49YhDRR2Z5vVBeOxFF23ghlP0ImW68/duEFsGcHSRTYS8HNw8cGu41L75TPoEbPlAJnP6+o0fbMk0th/WWDcss02KLdbQXvD7JeOE/xc04aGt4ipb4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 19:30:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 19:30:00 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 12:29:59 -0700
To: Li Ming <ming.li@zohomail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Message-ID: <69b071373ffca_490a100d@dwillia2-mobl4.notmuch>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-7-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-7-94fe919a0b87@zohomail.com>
Subject: Re: [PATCH 7/7] cxl/port: Reset cxlmd->endpoint to -ENXIO by default
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 44da339a-12af-4c7e-0dbd-08de7edb6ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|18002099003|22082099003|7053199007|921020;
X-Microsoft-Antispam-Message-Info: LsIlZ+rYNKlJNUuUuZKpuqWfLLhxEH7PcWGJVRvoxhrZo7Pv0RSvanD6WRRZ551P7HdnuQboR6vgJBiubb9BuWoONzo5jWEifuCPjskWkFDeHWqv1PZ4YhYnY05PTLZix10Fgs11sH0S104ovi8SnCbOTwgMpjM4y/o5OlsVrkLgiIyWU6W8zMxStGLcjlhpqfO/6/oxHDcp12/vUlQb4v6x+RQzVh0PoQMdk35Vhjq0i8oR0PTA2zAvd5EiMkQaobpLsktF9xitd3VSDVFPfZ4JxpynW21ruJIhjjccIfbfU3UNdK5ANvkPDScfu+YfZR4dG9x+OaJ/twrugYDl7aIfmryXOHZlgb+w57KVT49kwXrtATSs+wwfWB67ryEabf6sXQ1EGxnc3MyGtBQREtDkubkcvZX4Zi+aHurE9LwYhlZXlnt9KK/iC/GsqeUhrRjxpB2aDCegizUdq+KQCHSO6yPpSN2ioNjiy/Ctv91L03jJ/vYYspblDAJhcZS+Yyiqevy10ITf5FMhskuHV4Kj/6GcJ5dvsGc4eAVuz6co34jMbcbgYZBA566ODEP/0lweJmxuVwab9Q3PUiAiwlv9sjI277IGcP6e7M/4/ErONmTFVwejuzmb913EpkeiS41IGegEp7v42SDmVw77q9FqHzMNO4tDwvZgw4BRCefdd9xZF7NUxdQYFJ4yF0+kBEKpAmBFkuj6mCCY/mdrhGg1XHowy+gtFgcGtZXypb06oSKMfXAvuqqoQhh5ClGPMxWaJDr/vjhfKYF1y9AY6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(18002099003)(22082099003)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5hUVNzV29kbk16T1VmaStaSWlIMHZOZkhnM1pFVVJyNThvWnl4clF4MXFB?=
 =?utf-8?B?MEVwWXo1eXRNYWUzWFVXRjZTZFNDNTdIeDRCdEtVRGtlT1MzamEycUcxd3RN?=
 =?utf-8?B?OGRrdnNJWDI0S1FtWTVURGdKdVdzREQwc01iVFBwVVdlQUhXem5QVTBydGJT?=
 =?utf-8?B?bnEzYmZEVzBPZVlQM0V4cHM1TitQcW1vMDdKNUE3eW1TeXFDaVRPS3k4eFAx?=
 =?utf-8?B?b1RpYzgzeTM2ZnpvazVBOGp3M0ZNdStkUUZFQTBtamVlcnJiSEhKdUVLRU13?=
 =?utf-8?B?VWo5a0lhSWhIOSt4S3JWMVgyWDltZGRTdzNFRXNqbERYeE5wZWc5eUtWcG9P?=
 =?utf-8?B?eHVTRDkyVEtYdUtyL2NSNFU5cnpqNmxBVThxa1h2blRpeWk5WlNhWC80ekZw?=
 =?utf-8?B?ZTJNTTRFa09OemxiYzMydWRaUW9XTGtZTWFsRHRIb1VoOWpOV3pMQUt2RUpq?=
 =?utf-8?B?R1NmMkJYZHpVeW5FSlNqRWhwcG1MOUNZZmpKaHVhNm04dy9hcmdmd01PSGNq?=
 =?utf-8?B?M0xneFF5WjUyVXlSZ1puM1dBTzd3ZThJaS9KeFJCY0UybHo2YnMrVXVJTy9Z?=
 =?utf-8?B?MDUrdi9WbkdmNFcxZ0pqRmI1K1hTeStGcG1Rdk00SUZtSnpkYm4rTEEvL3Jx?=
 =?utf-8?B?KzFob0t5V3JhRUFOWmg4MHo2YnNxQUdhWVNTK1J2Y295NTNNS1pkTmNSc2Vh?=
 =?utf-8?B?dFZZcDhnbEloR05DeDZSK2Vwd1BjZHJ1RlFRZndHYjNzSG5qVCtXdTlaMUpU?=
 =?utf-8?B?cnRVMUdZbWF6cmdLRWROeFNkYjk0b3dlK1NyUG43ekg5RTRnUDlvc1BJN3hN?=
 =?utf-8?B?Y2RFb2lXTW9sT3VTMEpXWVArWWM2VkJXeE5lTWtQYWR3RVNLUWtWUlp1NjdK?=
 =?utf-8?B?aFZNV2VLZEYrcWd1T1diYVdwNXJzL3RFQjlkb0U3bFh1RVllYTRzLzYzbWxF?=
 =?utf-8?B?bWFpRE5TV0lnQWVLZU9uOFNwcDNqMzUzZFJUSmQvZjBaS0UzdmIzSjNURTA2?=
 =?utf-8?B?Tk1HTlFwNjlqVEN4NHowVkpEZTZZcTJmMGloaEs1cUFPeWpKZEl0RHRORnpY?=
 =?utf-8?B?REJGaGhOczBEWXJkTXF2SmFIOXkyMkNPcDlodzZZc215UVBUWEw3QnpYbjVK?=
 =?utf-8?B?NWVmUUs4azA5eGRNSXdabXNXZWsxKzZJejVvd2V4MjNXMSsyUmZEd3RNTjNH?=
 =?utf-8?B?VXdxUHJacVdUYk1Jc1VWdDNPVVJiSzBzWllPdnl2SElOUTgwVFpoWDR5ZzQ0?=
 =?utf-8?B?ejduMS9nWCt2R0dQeSs1QnprT3V0TTRBZ3Y4WE0xZW9pZXM5NzB6RDMvbmJ4?=
 =?utf-8?B?ZUw2T0hPZnJLMVlnVnBjQnd2V0dSZzBEYWlVcCtEWDEvN000c0M4SkI3YlF0?=
 =?utf-8?B?ZjdaNHQrSDJGenlxQzlDd3cyMmRxbDA1R2JkSmJZVXE3bStJMzcySmUxcE9a?=
 =?utf-8?B?aW1JTWVqdENZU0JzbFdVWFl0WlRhVWpJWUtlSjhmM2p3aHozZzFQUTJsYzdz?=
 =?utf-8?B?TUZzQ0RNa2UxL3VWV3hSTXZ1OTBmcnhsOTZSY0NCbnh0eFlwTmRkUjNpYWsv?=
 =?utf-8?B?VmZJL3NJZk9Ia1YvMDY2ZXVhUi9MNThvbmQycGkzenF5KzVBamVXQVlxSkJs?=
 =?utf-8?B?TkpGR0ZBUkxhVE45S0JXamVaRDZtNVRES0phc3R4VFZUMWs1bHVvdzRkWk5R?=
 =?utf-8?B?UUVKd0lHWGh5Z0kwenpjMzI5ZjBmSTkxeVI0NkU3S0hZQ2grcDBISC95QkZa?=
 =?utf-8?B?cGQyamVDT3lhWmY4YTVjYVU1OHI3T08reWVmT1BubnVudWVRZTdGb1RYcFdR?=
 =?utf-8?B?MC9jQ20ySzFORWpwMUxhM1FJSGxUY2hBNlF1V3psY2tpZ3plMXlKdkwzSGpt?=
 =?utf-8?B?NG56WHQ0dXVjRzBCZmRqZGNXK2I4bWtpZHRVdXFCWmthTUJ2UjNZbHlncEJm?=
 =?utf-8?B?SFNZb1Riekl4Z1BNQUVKQ3pUSDdrL3lQL0MxUlZZSUtiQ2UrTFRmcUlBNEJz?=
 =?utf-8?B?STNOdGtacWlJYStDQTNPVC9PVTRBTUxEMHk3YlI1ek9vOXduTWo4ZEV5QUFo?=
 =?utf-8?B?a01XbFlSRDZpdFd1eFZUN1JvVFhSeGY5RmZveVRqRnduNmtHU1g5czdxTXU5?=
 =?utf-8?B?ZC91YXN4RlJJdGdvL09QYWgwYTI3ZDRQK0dzNEw0QjFPaFVWMjdtM0ZRRnNC?=
 =?utf-8?B?TndJYktHdVQ3enRweFF0a1pFTG1uejdOVGJ5L3dJVGpxTGluVXU5QmVCV0RX?=
 =?utf-8?B?Mlh1eElhUlJ0VG91QlU5bWVXRk5sQXZpYkNNVnBFZ2VpNEVERFVCR0hhUzdW?=
 =?utf-8?B?U1QrZjM1di9nY3p3Z2hJd1k2b0ZjQno3L1Z6RkhWWHQrNWYyM3dsL1lFUEw3?=
 =?utf-8?Q?fo5z1NTpJZds7nPU=3D?=
X-Exchange-RoutingPolicyChecked: fg3b+z+5Taf1EBXiTOk8LjqVpOyF4meqFtlf3J7B7+REfxhoEOq+Hnof7ev1ZTJxJ7UivMQCL7r+b+pWv9viedXjz00r38ieOvtsYv0m6Gq2wrDQRfqardOGEcQqnapEXp+poYRNrv0FaxdSy5wOAwYP30AGknlVgnAbU3ohY4EBqxa9d3p3a5IoTMwfKp1HCB2xQtsJbAKmu83+MRhHpbTAsZWUk4O5ntTv5X2pFSnb+jvPXISLZcvLE+6aDu1RlS7ldaU/3iBIgHb8wrFPRuK6HUXryuqQgQb0c2v9vzn1T0/YNj5xfh9k/4Qv04F6KMcK6o1upK3/H29PlHljfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 44da339a-12af-4c7e-0dbd-08de7edb6ba7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 19:30:00.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9fmrHjjR6s85S7gSZBcSfqVs/Ft4jVMTtWzLmi7tTfPTJIkNfKqJBBhGVmSqIKjBZ5vInRFntj2VnlEuJRLZj/cGcXQMNfrw9/+0GbXUZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com

Li Ming wrote:
> cxlmd->endpoint is set to -ENXIO by default, This intentional invalid
> value ensures that any unintended access to the endpoint will be
> detectable. But CXL driver didn't reset it to the default value when the
> endpoint is released in delete_endpoint().
> 
> Besides, cxlmd->endpoint is updated to point to an valid endpoint in
> cxl_port_add(), but if the device_add() in cxl_port_add() fails, the
> endpoint will be released, but cxlmd->endpoint remains pointing to the
> released endpoint, it may introduce a potential use-after-free issue.
> 
> Fixes: 3d8be8b398e3 ("cxl: Set cxlmd->endpoint before adding port device")
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")

So I disagree that this is a fix. It may be a consistency change to make
sure that all invalid ->endpoint accesses have the same result, but it
is not a fix for any discernable end user problem.

> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/port.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0c5957d1d329..ec3cb62b44b7 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -834,11 +834,14 @@ static int cxl_port_add(struct cxl_port *port,
>  			struct cxl_dport *parent_dport)
>  {
>  	struct device *dev __free(put_device) = &port->dev;
> +	struct cxl_memdev *cxlmd = NULL;
>  	int rc;
>  
>  	if (is_cxl_memdev(port->uport_dev)) {
> -		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> -		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +		struct cxl_dev_state *cxlds;
> +
> +		cxlmd = to_cxl_memdev(port->uport_dev);
> +		cxlds = cxlmd->cxlds;
>  
>  		rc = dev_set_name(dev, "endpoint%d", port->id);
>  		if (rc)
> @@ -865,8 +868,11 @@ static int cxl_port_add(struct cxl_port *port,
>  	}
>  
>  	rc = device_add(dev);
> -	if (rc)
> +	if (rc) {
> +		if (cxlmd)
> +			cxlmd->endpoint = ERR_PTR(-ENXIO);

I see no need for this. All of the upper levels paths ensure that all
the results of setup are torn down on failure. Consider that if
device_add() succeeds and any of the follow on functions in
__devm_cxl_add_port() then this cleanup will also not happen.

So you must rely on upper level cleanup. This is similar to the
semantics of dev_set_drvdata(). That is only reset up after _probe()
finishes failing.



Now, if you want to do some separate cleanups in this space I would redo
the anti-patterns of scope-based cleanup in cxl_port_alloc() and
cxl_port_add(). cxl_port_alloc() does the "__free = NULL" anti-pattern.
It appears to be doing that to avoid adding a DEFINE_FREE() for ida
cleanup if the port allocation fails.

Also, if the cxl_port_alloc() call became something like:

struct cxl_port *port __free(put_cxl_port) = cxl_port_alloc(...)

...then I do not think cxl_port_add() would need to do the odd
__free(put_device()) initialization without a corresponding
get_device(). Nor the odd "dev = NULL" at the end.

>  		return rc;
> +	}
>  
>  	/* Inhibit the cleanup function invoked */
>  	dev = NULL;
> @@ -1425,7 +1431,7 @@ static void delete_endpoint(void *data)
>  			devm_release_action(host, cxl_unlink_uport, endpoint);
>  			devm_release_action(host, unregister_port, endpoint);
>  		}
> -		cxlmd->endpoint = NULL;
> +		cxlmd->endpoint = ERR_PTR(-ENXIO);

I also see no need for this. Either dereferencing NULL or ERR_PTR() will
result in what is needed, a kernel crash. How the use after-free crash
is signalled does not really matter. The only expectation that other
code has is that "->endpoint != NULL" does not mean ->endpoint is valid.
Nothing should care about that though because cxlmd->dev.driver is the
authoritative gate for ->endpoint validity.
