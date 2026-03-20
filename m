Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2775730BB8C;
	Fri, 20 Mar 2026 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972364; cv=fail; b=g8fBbWrZHhhWWgictDKxanBe39JF3wJIKvok98+vxY6QACfMVot/oHuOo2Pc1ZMEAlYBmSnOUS7L1IHztXzXf2hyEOPYMGhieqAateMHT9+/NJbL0AHnZKYOZmaGSGGv+gPfk33pguI7R6w+tIo6ZhZUJVWe8rsixcv79fydFgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972364; c=relaxed/simple;
	bh=juaTMIvelZUFTJTO1zCqzvJfQauWXtNR0qIfuvjNdT0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GPcdxF4whZDvawRR0GcPd9qyj042M2EJgen3moTdJqy5yQwOwF4ovKwfUnNCi3gNSJm+pDZMK0FBAneBqhQvUofw780D8d2c1xaPQ27atINP94+gspVB7tdRDWm+Gy600dX8xwMt+hn1STACI6qHDDSkEXE9YJUZd8QpqI2xAoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzoV6xI3; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzoV6xI3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773972359; x=1805508359;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=juaTMIvelZUFTJTO1zCqzvJfQauWXtNR0qIfuvjNdT0=;
  b=KzoV6xI30MU7iFHiZzskCwh87oLKXEoCOINNlyYdKbHYHPjRHHq43V7f
   W/KwVhU/MjjrZczW34hSzWbAygFfet8nD6Oljaby/bpcz60CcolUBKfh2
   +vfkIf2Q3fq0FZgCm6N18uGoe2bzpa2MGLMjp2cNoJTsiFHAogVpHKgNp
   DfFFfA2Es+G9WVdlzpDSaXuDfLgHM3O5/bVQFEqkB/oMZE271wL0bEJLG
   1+eqmDLZxIbqrn5jcMXZfK0lS7UhzYONcMNfVw/g6pgmDQ7tZQrL7Lqqq
   /cPyyVh88vxzcA9oPkidWXNjvCEeGXq0V5jcrhtHCyk6jXuFSW9vnhcPz
   w==;
X-CSE-ConnectionGUID: gzU2YQx9SMKqhiPCNSrZ/g==
X-CSE-MsgGUID: QD5MYo1XTWuF6THGAENglg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75175733"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75175733"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 19:05:59 -0700
X-CSE-ConnectionGUID: cMPhYGkNSk6+Bpo06OJ6qQ==
X-CSE-MsgGUID: ZqWggeC8SGqH5Rwt1kM+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="220080199"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 19:04:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 19:04:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 19:04:02 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 19:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDxGtbWasWpjRVfN8FgaPedSIAfdCPBlqB12dsvJ8wmAWHLT+TlIae0thAbVyyXbZizWHO781qRzgNnPCmbSZveJhBQUP7WUB8fUwCiHy8DfIUB8ui/lZcRWUzegBAOBf0RnIlog32RlG3+9DQhmxHn5QLirEHu9Bg873rGU6s/YqMyeH37HoFh2QbDLD1x4hdv25+7UsVCrSVzY3k2cJQlWOEOG1c+kn1zXe4vnRgUFgoN2jUVjg0sY1M5fTWllp43DagI+jQgy9saGrHT+s3Dx7/MQv8bABOuacIni0QGZosAaYSb8gnORYfPvdlBlWFxjpvPUmWT1MoFLcOzgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPefhSAC01/8LdwII6UsTQEOcC02V3CUhB0N3ek2c3U=;
 b=UAqsZLoo3keWXLOEW9DlKfMLeuvg+Qj4W4qocurX4rrKWzUSSp7VBWK9biEboV5zYQ0UZtnP6kBT+22oVN4j4oA9Meepoqr76/LZyfpT3h8zkpEL4IDSTa+jKrTt0AQQkmjWq6oCOY/BQTmZ/IA6iQujTWu0KoepsFLrhtrw/BPNIjLQQUQUH2xzs5au1QLV5gEtZfMUjOLVK2uwh2K+FjClr/4f+JpNv5wr2qxlqBWD2CjFh44kmC8ROmoFNKalY6LnOzhDp79IqnFNERrI2ZvMANJPri268QP1+mx/Xb9i1iYF2UG0VKKF6j0Hn6dItgc1YZtNlZHML0TNFhrhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV2PR11MB9600.namprd11.prod.outlook.com (2603:10b6:408:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Fri, 20 Mar
 2026 02:04:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895%4]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 02:04:00 +0000
Date: Thu, 19 Mar 2026 19:03:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/hdm: Add support for 32 switch decoders
Message-ID: <abyrCJGqMTsyPnMN@aschofie-mobl2.lan>
References: <20260318-add_support_for_32_decoders-v1-1-bb7b41efde2a@zohomail.com>
 <69f68851-9e02-431a-9331-8f687bb2fa4a@intel.com>
 <291ac46e-67cb-4732-8626-e0c434ede12f@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <291ac46e-67cb-4732-8626-e0c434ede12f@zohomail.com>
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV2PR11MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: b37e7a16-41e8-476e-69a5-08de8624f3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: sD5CGjpkiM3X7kv8+hwBAK9i5B9a6xpwJO4vYxnMgPrvTNBenNYkKeTqHFaMLPI9Ggv/GfdD8CZ7owBOfJXAZRCm2rwIcJXLbEYlsnsupZ+njp2KzCkvtyG+vsenObnMh3DeRchSfmhRgdV+TqrjZz1CgAkGE5yqfUEJu4cuus3LEYtgxeE/4QpROLK8iTfo167ykiJEsDyhRTR3zIcPq0HG4ME11DV+E59vgfIqiba4hUH02HHnKFGl/hJUnz2sY911NcDvmsfGE7e62XKV1hGunoCTgjxWVUsKLgUlrFl4ZsOf5h2rLY7GAn+6UxNwvW4D8IQGljvy3ZtH2CUsJ3qDj9la86zByLGk3E2jVR48Gkm0HymDXm1OUI7Madoe3RnGu1Fa4f9E/s81QvsEgBjx4MjGqg0MgrX8RgrvGGmfJaQwko8SPQPXLjrYPRkVjZJT95o8o2P5zBLG0flJA+c1sA4ogfoBZYHv3Y/pfIULjuUSJSYEcpEQz8/bjbiM0ziErMiGDjMqU6lQGH5bvFQPUzUxQclZaZgLd5OfQ7XDkIkVJgA78sx6P/uLp9MUz1V1rsyYocmXtDi5K9JkgWnyJYdTDTSTrE3ZX5f6B6Hl3tteHAtwDOuE3BENX5bjHv0I2/1c5Dc3MtgUdbHUYju/f39eHIONfEYGYYLDOI0i1W3DnNWEc9V1fwX6DZ+mp4m/yVuqsnbXLl5ltvxLjgUNjdsCBwzlrA7wFUENQaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhtOTRCS2h0WTJPQUt1Ni9SUEFSay9hWW1jV2FlRG43bTVES3hidDNWQWVk?=
 =?utf-8?B?dkJYSnZGSG9GdjR2SjhaK3pkVU44L2VVU0V2K1BjRmJiS0lFZFpBYUR2VGVB?=
 =?utf-8?B?cGdOWmo4VjhNcCsyeWc1RGU4akFwK1N5TlcvcUp1WDBmOFcxSk84a3dNRmtJ?=
 =?utf-8?B?cEVoZXdndFJsNVpPbzdXd29DUlZ2UEMrZThPMHNwTFltdmRvckdHLzdtZzJi?=
 =?utf-8?B?RTJUSkhqSXRnY09JMUx4dlRJVU9LaVl5WDAvL0psUDkrZktFakFZVXF0b2ND?=
 =?utf-8?B?Q1RYL3poaHRQbitMOGJxa0VNOWZhNy8xTlVtYW11Vm1PN21kSGNOSHVCWHMv?=
 =?utf-8?B?NHJsb1FRRnFONHZQS2UwamhuU1llTytTZ1dTeXB1NlhwQktZMUpmd3JsbzRq?=
 =?utf-8?B?aXlNckY1Y0NILzVPTkVpMlp6bjJUSkNIWDcybndQcnEyY0pBNG5qZjZGMWt1?=
 =?utf-8?B?bFVPeHJMS2tuTGtwNGYrcnQ4bkdGVHg4MjVkQU1UTXlmcGFUV2J5QjVYa2Q0?=
 =?utf-8?B?THRDMjZYUlZhSmp4ZDZpQ2c3UlVVRUpZU01QNWMvWldveThTUGFrbzZJK0xv?=
 =?utf-8?B?Q3NqTEZLdnE5bEtYUzBhb1IrVzdzckU0ejdVWCt5bysycXBlbzNmVS8xMjNp?=
 =?utf-8?B?Zk80bUtkMUJiaTY1S3JybGxGNjVCYUVpVkR2K2xoTFFiVUY3VzhJYXQrN1NW?=
 =?utf-8?B?a0xEZTZ2QTl1U3JJZHltL2lBVXd6R1RqNk55RGxOelRJQjFYamZlUEJVNnll?=
 =?utf-8?B?V2VhanZHdlRaUWd3Qzk3L0dBOUwxRXJBOVgvbU5nblJFQUgxN0JZbnNoMzlO?=
 =?utf-8?B?ZlM0K2s0eTNOUjZ3S1dGY3hnK080V3VVV1JIODlUZUNlMmp0bmtZdnNITlhC?=
 =?utf-8?B?K1g1c0piSTNGbW9jdFdBbWlIbXlYWjB4U1dRaGQrQ3N2V1JkODhtVkI0eXhR?=
 =?utf-8?B?V090NW8wTWNJQ1FSV1dqdGdVTGVaSGJ2ejNJVGNvQndjOHB1aDgwZTB4b1RB?=
 =?utf-8?B?d1NtWmV2TWRpQ0Z6WlVNTnRjZjMxNURkWXhSNk1iMENMZUl2czRaWlhYQkRW?=
 =?utf-8?B?bW5qMkVQZzhReUdka2trWHQxNEpQYXltczlkN0ZkdGhyUnlZcGlNTVpJQ2Fa?=
 =?utf-8?B?b20xQ2FDclppcmFOSWorU2twSXg4M3YzR3hKaVdOelFuTGNZc2xZcGlVanl0?=
 =?utf-8?B?Z3NTQjhIUzVoR1N5QWZFSU1CZjE4dnFJMGdidWxTWXArSkk3Z21yTjdwWXhq?=
 =?utf-8?B?M3JkNURmeFJ3VjQ2TGdFVVhHWWU0WkdqcUlLcHpiQUNtWXdJcDkyT1BOaTdD?=
 =?utf-8?B?QUxJUXZCSDQvblNURmxpVVVxdFg2ZyttcWd2NDRYU0U1ejV5U1VLWWlOVFdR?=
 =?utf-8?B?d0M3blBVR2xxcVFhTSt4Z0hHSmdMSEN2ZzJYQS92eVBWaURBQlA3R3NqOVdq?=
 =?utf-8?B?dWo2L3NWYW9TTVJYeGJVSUhjcHh0cTRrZXJiQUd2NHRTcnFzZHowS29aaTNW?=
 =?utf-8?B?U25jRDZMMWhhcnlRbFNNSWN3RnBPa2tkdk1LVDhFYll5M3RCRlgrTnBKZjIy?=
 =?utf-8?B?VWY1c0lRbG5NQlNnaXMvS2RNU2gwT3lvd2Z3T2xZT1NhQ3V5Yyt4UDZXV0F5?=
 =?utf-8?B?d3g1TXVqa1dVeFNpTjQwL283bXVyaElvaVViNlZlKzl5Y1pJMjM3aU9IbUI2?=
 =?utf-8?B?U1EwcUM5RzRjMGRCOWx1eGJrYlgwdXNibmxjSGpJNGd5LzZmc0JqZ2E0azZR?=
 =?utf-8?B?WXhuNGVTT1Z4ekk3WW5wblFRUGc0a0xsWEs5eEdpWFByRHViYnFsekQ5K2c3?=
 =?utf-8?B?WXVXQ0o2VTBsNkw4VGUwc3E3Z2FGempMS1VOWER0QWNXOXl3OXIrY3ZKZTdo?=
 =?utf-8?B?UlFsRHlwQXYvVUx0Rm1sdFhuUjVHYUtuSGo2OG56T0E4bm1hYS9uZzQ3Sks1?=
 =?utf-8?B?YjFQaXovSmllNUxkY2IvV3ZtblJKb1VHUE0rcVlTdnowWVVoMHpBYmErQnRL?=
 =?utf-8?B?eSs4dHNzSWRtSkxWYUdta2UxZjRLdWhlZVlmQUVVSllRZ1pOYWd4N0Y5U1ZK?=
 =?utf-8?B?RjVWeTNSNkJONzd2aWUxSXNVaXlQWlJqcEZlakpIdjl4djNOaEpoZisvYWo2?=
 =?utf-8?B?eVZMZ1FNa0E1SmpZdGxSUWdpVDlRMURGcGIrUTRJbm0rZkJtOXBkSlJ5OTlO?=
 =?utf-8?B?cTM5QWE3NGNMSE1NaTUyMkF6NHhFZ0o3c2VOSXRseEl3cVZYY0NsbGNnTmZT?=
 =?utf-8?B?RFRjUzZZWXhmWDZYRWZJVkxBNVZBTzVwbGo3a1NZWXljaENXSGJRTCtlb0x1?=
 =?utf-8?B?RVg4T2FoOHF2QkYwekkxMURVdnA5eGcwbThsMzFYYnRla1ZIZTVPb0RIKzRl?=
 =?utf-8?Q?iVNh9wTvldm/4abc=3D?=
X-Exchange-RoutingPolicyChecked: kogouHp+7YCw1uQddujZLaJByH1aGNPrhONgC+Rb0JwNHAMywVLJTwerJPdeMhK43yr8sFuidHmnIbX78+m6Q+XnhSuYRjBKtRIQroA0k0TsEtTC/q14VWpNkepuG7Wh6mHwhZXTlIUxS/99TOVkahB3Veel/2sBp/j/ENTXMyRRA8T76qDeM/ER1iYLPKEgc5z7krYtfyyY50OfcwHIPhXiMjFZX3Uok2C6wGEOMlzXYePJPizP8aEO+f5aw9pOXZNxPm4PlY8uSUy3WF3Sryu5HJJtbyARzsyr0BwELZG3NDgBtHRl15K3BzHXfofHkgiTjRb4tTmkS92vkTlp+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b37e7a16-41e8-476e-69a5-08de8624f3b1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 02:04:00.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O61e7Nllb2htGSBN1sRMsdBYPH556ZcaIRQiOqQo0KStS/P1j+AgwjccBIrW4omhtOjaQYSsbZYV4p33TVuTNzslXsPqMG/hXaKRec0S53Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9600
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 07:11:34PM +0800, Li Ming wrote:
> 
> 在 2026/3/18 23:40, Dave Jiang 写道:
> > 
> > On 3/18/26 6:00 AM, Li Ming wrote:
> > > Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
> > > support 32 HDM decoders. Current implementation misses some decoders on
> > > CXL host bridge and switch in the case that the value of Decoder Count
> > > field in CXL HDM decoder Capability Register is greater than or equal to
> > > 9.
> > > 
> > > Update calculation implementation to ensure the decoder count calculation
> > > is correct for CXL host bridge/switch ports.
> > > 
> > > Signed-off-by: Li Ming <ming.li@zohomail.com>
> > > ---
> > >   drivers/cxl/cxl.h | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index 9b947286eb9b..466b8eeefed7 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -77,7 +77,12 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> > >   {
> > >   	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> > > -	return val ? val * 2 : 1;
> > > +	if (!val)
> > > +		return 1;
> > > +	else if (val <= 8)
> > > +		return val * 2;
> > > +	else
> > > +		return 4 * (val - 4);
> > That looks a bit messy. How about:
> > 
> > switch (val) {
> > case 0:
> > 	return 1;
> > case 1..8:
> > 	return val * 2;
> > case 9..12:
> > 	return val 4 * (val - 4);
> > default:
> > 	return -ENXIO;
> > }
> > 
> > DJ
> 
> Sure, will do that in v2.

Hi Ming,

You may have already spied this while implementing. Before this change
this function could only return 1 or val*2, so never negative. Adding
-ENXIO changes that and could wrap to huge value in the decoder for
loops. Change decoder_count field to int to clean that up.

Or, you could do something like this:
	WARN_ONCE(1, "reserved HDM decoder count field: %d\n", val);
        return 0;

I like the ENXIO and type cleanup or maybe you have something else?

--Alison

> 
> 
> Ming
> 
