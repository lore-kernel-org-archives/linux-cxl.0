Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941038E
	for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+v0rJbt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703292596; x=1734828596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Aoo+ddPJow7Cke/EHENF3L07uCFIgpMFd7LSForPv0=;
  b=g+v0rJbtU49vYj8Ce16ubxDO43xI1TY/Y9KNZE066AiierzMt6KikmYl
   YKBd5RqFBjuZWy/rrSMkjy7hIQkuiVQq2rMljszDGA3Y7Z8SmfxM7UrqQ
   ElPTy7SxEc6Wg0R4/nWCcX8G7avmTmGvBEMbKhRJVNKUks2Tvq38vAmsP
   scINPZIAN52QheYlAvsIeec/woRfLo02D+uY0rhvANiWQ9EeyV0pjePSz
   WoPAWRcWr3ec/b2DZGekPwS++ZXcMmC5ouo36RuVL1ZD+A+H9SSzcT+dT
   oHXP0KnvGPV1o0NF7HSghsDPVmwd3SU+0v5McW5+cS6x8auj3ZN0izOlt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="482352392"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="482352392"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:49:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="950490906"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="950490906"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 16:49:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 16:49:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 16:49:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 16:49:54 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 16:49:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfcRCHmtWO/RA3CDdUBCQd8XSmNc3bwaI8HyaMDyBDMesZFsaZY4Vt3YFDYbpC6zMWiip+6HtPFzLrBKTYs6tP3f8G9hTZkDTHKjyEc/F0RPEPa+9JBC/V3GlKtk/Vg3KOo529xxiQp8zoMhhWBlD2UO6OuDIQ1MiAzhJsFWNEmsVANdvwt8hxIyFuUZ8WuNVJY/LchVhtJcfMOiOAQ2qWN1sLK5dWqF+BBjyPemzgKvvsDVsR/C7HmKYrL+v/CPclM34VdOKH9mgWhaddDU4T8VUr4VtMS6Jzba+aEMDEz5w8WZ7OJlhL6kIm1Zj2djKJcURVUvhSEj+tJoNqpGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS/OH9FTHMZ7VTHZ+D5eGNSc/b36Xul7UHDW0tk+AgY=;
 b=HrjFkHoMaZ866MrhBFaJRPhGJwnPs+pTmSdlsxOmocUwUqm3seaVV8gNTYNZHkloVSgkZ02SXrOos/YKd/fHt+23mhV1X4DsTC6yjMciQxgDOvly1pQrZ6HeGTcZGdDnBGCP2M0hzPB8yZRqc2PJ647E7rNJ7soY4+XjRlXdF7VG+vPmqEgjmWcjtLirg1BYB7zElZO7WyAnuIObbbjaTzekQPrj0Ym9dL0JiHvjjxM0KB8AwZtgGikE8PAXbJfAPnzGl4mImc+ECQ2DfVaBI4e89vlfKbyRQ6ESeGywBNWhehBnT6oRFmZiEiQxkRv5vfBc0W3OstlDn3kwQ0zVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Sat, 23 Dec
 2023 00:49:47 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7113.022; Sat, 23 Dec 2023
 00:49:47 +0000
Message-ID: <eb57bda2-c3ea-40f3-af63-134e113cb20c@intel.com>
Date: Fri, 22 Dec 2023 17:49:42 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] ACPI: NUMA: Fix overlap when extending memblks to fill
 CFMWS
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
References: <20231223000025.1401076-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231223000025.1401076-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ1PR11MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: a5522f62-e464-4f63-767c-08dc03510fb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2gjahMP4IL+8Ww3S9wAQeupRG3QlaWUzeYT68O4cYFvLMzQcCZqqMqBZa50Tc48XX8neSqCCLObnp3/7Ud25s5SvobR76VHQdcgIQt2FfQNtSxpM7DPlpKCkcWv+iVuc0jvG4KWSAdamF3F1G9Ev/1HA5pvJwHKdO0n8xa8VVW6hQva0DwJWxEBgj2dvpdfOnGoXvKhC0icg6kCCFejfaGg3ghGFP2gpYxk1FwT8OiAFKiLjRGBmNw2Iq6m7ha1v4FSgeB6gAhvZaeUt9UxakXdg48vlcmPewf4eRxFMENMn4LWs6+N0pHrnN0NMrMr4kJiqtdDsRYBcPoolk85qhOwLadMJu6shiuhM9XN8iSBtCPRYr5PS2yaPVR2ehJOP1Y2N262yB8XH9AXKmXPDVVYKsxz85g9IRuSVupaQ01K6abPgY3rHvFaXpJfL7br54k2DqZGprvzpx9XlMc8f2k8Zg/AgSaactTW16m7Dr2WJ0aJbXdjUg6sUOzxeu9qMYMAh5UauVNxdAP8Dgsxxia1XsfoK+nigghP+2UCAhn3wUpdmWqmi40n+RCtI+dnvXWom3A+Odk4UFRMNhzS+Jwll5HDPMCaDch3eZEHrSBnqHJgL9k8dJ3+przQ0UIs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66946007)(66556008)(8936002)(44832011)(66476007)(110136005)(6636002)(8676002)(316002)(83380400001)(2616005)(107886003)(5660300002)(26005)(38100700002)(4326008)(478600001)(6486002)(82960400001)(86362001)(2906002)(41300700001)(53546011)(6512007)(6506007)(31686004)(6666004)(36756003)(31696002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDdaNWY0RGgvSXRHWXp6VW5qbFFWY2YrWVBaSlZkVTluUHZNUXFsWEF1bEIx?=
 =?utf-8?B?enVpRHpQdHVpS3RMaEUzWDR5ZTcyUlcvdGVkV2hIVjV3YytsQXpaREtTZzM4?=
 =?utf-8?B?aHppTHhteVZVcGo5TmdRUUo5V0NTdWN4UXk5cFZOeXY0Rm5namwzaHFSU2lJ?=
 =?utf-8?B?S3Vob2RwQ3NSQmdjQkVRZGJvamFDMTRCV0ZWS1Z5V2szQWFvQUJ6RTdrZUpD?=
 =?utf-8?B?ZlRxc0VvcFJ2RU9pNHg3OHlQaVNpSTkvdWMrVVJndGp4RnZvQkU2YUs2Z25C?=
 =?utf-8?B?ZXhnakdQUWFrMXdzSE1JWmkxNWw3UWJibUU4U0psKzhSQW96ODRrL2RvTkJJ?=
 =?utf-8?B?VlZFOExJZXlsNHhWb2F6bDM0SHBwL2ozWjFkWGFDOXNGM0RCbG8rTmpldFdM?=
 =?utf-8?B?NkJVTFZKTUxvQzI2VllkT2EzTFVsbStCcHNjbmNEVzFzaXNLakIvT0JsOXdF?=
 =?utf-8?B?bXM3WXBVYm9tUFR4elVGRkJMSm9uYVNwZFJ6Q1BEd05ZazdBaVBqdm5lZkps?=
 =?utf-8?B?eHNyVHJyMFRQRnF5M0VNa2pnakJzdS9EVE5DeHZQdDI0R1ZsWlF6V1FtQXJx?=
 =?utf-8?B?bFM2OTNpZnVIdmtRanpjTDZWZFYvY0dWNDRQOFA0U2dpSTdmd0ZyQWE0SnZW?=
 =?utf-8?B?bE1BUW93SlVEdDlzSkgyMUo0V1NGdVZjQnRJM1J0RFl5ZGtMbzVnRUI4WDdm?=
 =?utf-8?B?TlVaVmhCTE1RMDJuWVJZVWczZ1pwVDNyT2x3Z0thdlRyZWZ4UXVjbVpqRjlH?=
 =?utf-8?B?UCtzMzhDVlM2OVJYcXpsV2krdjNZVUxBb3JLdVFodlBiOXhhdEtGa0FHRWdq?=
 =?utf-8?B?TkpFdlZTWGs5OUVnM1MyUHd6Yk1oU0V4MVF4ZHRabXJrL0FCSUJGRFF6dDU4?=
 =?utf-8?B?RWxVT0ZLczN4clo3VlgzTFVOUkhQUFJaZnU2SDM3anpXaUlscmJ6OERvdFB6?=
 =?utf-8?B?WEtHbEJBN0p6YzlSbzRad0lXbk5aUkZpbXN4a1RyZDRDSW1GK2R3a2JZdzJ1?=
 =?utf-8?B?RUM1Q0tTQkYxc3FKQ1A4cEJLeXpNeTl4bm0yNG16T0RBNWxET1VGTHRmcDFj?=
 =?utf-8?B?RlUvRDd4czI0d2JPSENTNFpMdWQ3aWZBaFc4cmhzMmMzQVVIcUt2QVI1QllE?=
 =?utf-8?B?YUlqUS9VajRORkFDNk12TEVXOXFkUnMrR2NGM1RtcFR3R3dTYXIyNkNvdW5J?=
 =?utf-8?B?RHEwblFYNi9BMFFKd0FvYUEwTDNUcFpEZnhNWXNoSkZlMFhsM3JBOHhNSk1C?=
 =?utf-8?B?aWJmOFN5VncybVZCM1ZkYXpCV1ZwZWtGd0ovd1BSc3ZHSE9xYTlQb0d6KzJy?=
 =?utf-8?B?SEFicDZmMWNPaU9UN245S0llbU45OGx1QlJXMU42SUdqRXBqbWZ6SXpHRkV1?=
 =?utf-8?B?NmxlcDRVTHZkOHdmSkcyRzVTeHorT0dwMVNRUUorN1k5elVmYVhaWGMzREZM?=
 =?utf-8?B?d1hWYm1yR2hZQWpIdXBvckhXUW43UnhmUGlDTXpnZXBpUXpDaWhmR2g0SlFI?=
 =?utf-8?B?am1tOU1aQUpwanRPelZWU0loSG5rbUVGMmhYbWdUa2hta1F6Tzl2S2NZcEpZ?=
 =?utf-8?B?VEtsYzVicWtnb1BSVUsydUdURlVYcUpnK2QxWEFNaEd4VkhPcVdNMGZuRGFi?=
 =?utf-8?B?R3NMYmFubmtNMHBXblJEU21mVnFUSmsrTkJqaWNlYitIZzhUcnZBa2l2ZU1I?=
 =?utf-8?B?TmdqZE10WFZwZ1pVOTZhZXVoL2oveitzbHFncHdUZ2ZTb1JnckV3UVhyOFpC?=
 =?utf-8?B?U1pBVEhNd2lRTFMwTExrenJjRlVaV2ROdExJZEhFRDFXbEhlM1Y3cGoxZUZv?=
 =?utf-8?B?YWpDZlZsaENtRDE5RkxPWS83aWQ3UnVZWTRvRC9IU2lYclVvVGhhazRCSU94?=
 =?utf-8?B?OS9za0xlWEhzSURRRE8ySE02a21QdGNMVTFPR0NTeXltaG9lU3ppQ1MwUExJ?=
 =?utf-8?B?NFZ5MmFabWtZSnl6TTBmeGVFaGdLclFoZG5aVjduMVFzdDdFV2JPQmljR2M2?=
 =?utf-8?B?cUNyZVBEYWpxd0hHU3gwbUgwb1lUdTZreExrem1mbFFDSndFUHdQdzZpS0tL?=
 =?utf-8?B?R1pIYm1CUkViWkFydVFYd1pYZHRXaXF2b2F5d1phczNmSi9MM2RnSWdheWU4?=
 =?utf-8?Q?CwLTlAFFuC1K7ohWB+O/VAiUc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5522f62-e464-4f63-767c-08dc03510fb2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 00:49:47.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWBeKV2eCOiCNq+Sqx3PnV74jGYvMZur+68Rr3YVE/oPsy1JMzGcEgJrzMYZ9FfzHi7sKkVrf727qMbZwE7VKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
X-OriginatorOrg: intel.com



On 12/22/23 17:00, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the BIOS only partially describes a CFMWS Window in the SRAT
> the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
> to fill the entire CFMWS Window, thereby applying the proximity domain
> to the entire CFMWS.
> 
> The calculation of the memblks to fill has an off-by-one error, that
> causes numa_init to fail when it sees the overlap:
> 
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]
> 
> Fix by making the 'end' parameter to numa_fill_memblks() exclusive.
> 
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 12f330b0eac0..b99062f7c412 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
>  	start = cfmws->base_hpa;
> -	end = cfmws->base_hpa + cfmws->window_size;
> +	end = cfmws->base_hpa + cfmws->window_size - 1;
>  
>  	/*
>  	 * The SRAT may have already described NUMA details for all,
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
