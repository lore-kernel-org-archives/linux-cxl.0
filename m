Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23A36096
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHhnD7S0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704496094; x=1736032094;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=edhSa5mjkjM8jiJWSSlsKEtSkD+F5A0FS76bBq60V18=;
  b=aHhnD7S0S1sp54r4L+STl6BAAClV0APW9pq9jhaDFiIEQ5+md0DneJWt
   dwlJ/a32m3nzg/RTsq+giz+L7LRruKUqa/B5lMmSZliWff1hZFErvZcr8
   UJl8kuqe5KJSZeVaWpTfzXc8j/uhvt4bf7JF11Og9QEQ00OlSn3WE2m9y
   drYbIZjmI/BAFnlDw3XjlTKFkfbuCxkRnNGM1i+ZtnrQb5WWO1gX2lpRR
   vGdh5mSvANi9iP9DbJ21Z+htQui29QUXCSP0Y+w5vGo/2Hr/xENaRxECZ
   oIchHuAGcbIBxf8X3p00WLFv1jbk0fnQY4925PiYbB5N7dKZL3CiVDtpl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="16219116"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="16219116"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 15:08:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="22625999"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 15:08:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 15:08:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 15:08:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 15:08:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TADOd5kce82/wBg9YwAZo149Ph6MJ8zHjaC+OpvfJPblM6wFh4K3k720oII3Wv2iL1ZsMbPPl7cEnovZhEP+uN1V5z07VZiBbE2xHde0Gh18dEMwpFyypqkae4jTEXBGsL9ifFleZQD6mFZ/AadVwpkUTAR68eVI4kfQtRk2bczIylCSXErV9glXsKOb6rS4cwCzxYxGOXujD8MwfdMfwkt7llIGP65bLHKnKym25q5b9QetXwYlbCjGW1jcW9zzJyA17aHBlzpsmOxRe1G+n0bFg6MSOtRSou0jm1fm14z6IlWJVR423RzDshUaOMfhOUQPlkpxk7bX3/hoYxmCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAAIerXgeRlAqyyyiErXbxzaSleBIRI+aw2a1l3jV7U=;
 b=nmj+IQE4UDkikEi8ueEaToKPnePHCwa03MmqvE8IQwFAQAhCWUKNqhfI3v7vN/mzs7PbPAZJzoW4ukrfpR6mNRKtl8eE3r76yQOyr8Qksk43HE83yf8LmsJNS2iiJInuFHkT45BN7SKLWntbJUGRCxua1zn61clrM6looxhe/JzUkHvRydSgeyvmgTdFAAU8lcpZzufOGXREJss0OvbexyyFXcwCResOt2y1iASQj8vmBmcfO1dr01N5XFNacGxaxFidgC/Ujk8KUeRcmLfY+9U3HCvAbKU3AEFQmnNcMjOLLd8VBl301WDAXLAoES3pxfB9b3FybOggAPv8ny7BXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 23:08:10 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 23:08:10 +0000
Message-ID: <9eb1ff07-b867-43c8-9374-b7c8f9d0e3e3@intel.com>
Date: Fri, 5 Jan 2024 16:08:07 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v6 2/5] cxl: Convert find_cxl_root() to return a 'struct
 cxl_root *'
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449246044.3779673.13035770941393418591.stgit@djiang5-mobl3>
 <ZZiH7QGDLD8DlRNu@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZZiH7QGDLD8DlRNu@rric.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL1PR11MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f44784-e18e-4d8e-fade-08dc0e432f55
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cwCcnUiINlCf05JdRvLU1ffZ3r70fY5tIOCm4/jeVu4K+u8xnzjxmLYKcruwbmSP6UHpwcm/xV9vWp1bNmZ6yfd9vMQvHjRnLJdO4HnjEjN8hIkYbIdFtV8U7knU5VmidvFNUH3Y7anTIQbiDqfYm5azXikqysbR/Z0R3Hm0GSuCjRcJM5gNDNrkRWgnICBfrEJ9QlRopP6UsYiVXp2h0WfJVp/ve9Mno6MOiG4Dx+HpM8FvtNLWj+dB8q8qNhLZuZvzRcKaOBWPJxAdJGpipbYLzjaTAsxzHpVKmFzWNENbzNXoDbINTIwDwJUXOwr8f7fpUiSize2ah0OWAN+yvTesL/7guuxKtvMu1DBNceBTIxzQrsF0i8/vvjeAp1clCNOQbF8w1D/F/6Jn2MBgxlkvJpOhTagfxmAZ5ZWMlpiWreybRgamL+KszbEuAn2ZN+XiX+heGEuuO4Wi56rdYNj6Mvo8S3pQDr4Pee52ftnAcjTpWbBZldIVdPryoLkl92JDG04s3T2Skbcx1b4oe/RCkMcRYStEVW3qYHnDnZUY1P56iRhUKR6hyx43u32pjBlbm76cr9iBf6p8qXgefDklFm3zNr5pygcPUujaog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(2616005)(53546011)(966005)(6666004)(478600001)(6506007)(6486002)(26005)(38100700002)(6512007)(86362001)(82960400001)(31696002)(36756003)(2906002)(41300700001)(83380400001)(54906003)(66476007)(5660300002)(4326008)(66556008)(66946007)(6916009)(44832011)(316002)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDgvdjhuN2VJN3l6ZHk3YXlndkNpR2x6U0lTWE5XZ2RvMDNMS2tSU3RXaWp2?=
 =?utf-8?B?SzVEQVlUNnRadWhFcUZkSlFFVHVNYjFEeE81dEhGVUcrRFFRRllBZndmUm0r?=
 =?utf-8?B?eHNxMnhiR3pCbmxCK05jaHpBRXFnWVNWcUszcG5pVVpPTGZvT2hybHVkQlF3?=
 =?utf-8?B?UFl6VW4rblFLeUJTQVdmRWp0akoxZXVhNExqTlpMalI4QlpCeFgyQlkxVXdw?=
 =?utf-8?B?MUpxVkZqaHRzTTY3TWt5ZjBidmVFeko0R1l5VkZSUXhsc2JDS055Z0NaYVFE?=
 =?utf-8?B?YVlqTFBvZ2I4VTJhMWtIS2JlRlIrczRLNW1VNXBLQnU3d3Z0RXd6WXFXTy9F?=
 =?utf-8?B?cEZlZzRvMTc3aUVaWkM3dkIvTXhRdkNKaWl4ck85aGNKYVVEUVFVa3UydzBz?=
 =?utf-8?B?eFFtclJ2RmZMR2RFRGpNZlhIMjAraGZMeWdUb0VEV2dRYWRCaWx1VDdnYU85?=
 =?utf-8?B?TkFiZWdZRFhFKzhyR2lZK0MvT3JVTVRXSzlyL3hCdVFBenUzaThiaUJYU2k4?=
 =?utf-8?B?M0FuS2Q0RVN5ZnBXcWJqbzdFb1d3ZXIwbmQ0NzA2QTVxNVVRY1FBTmxYbXhP?=
 =?utf-8?B?S3d2VkxHY1FWdEZFVTM5ZGJyQzI3MjRoYVI4ajBTdEdQVlBINDB6KzZ1ZVE1?=
 =?utf-8?B?cjRHUFhjL2RkR1JYTFNaZVdpbDVjeE9SWDNkY3RnSnltZGJvUmN4RVJNRzh2?=
 =?utf-8?B?UmJ1Nm5wNU1LYmZsWXJPTVNvYjlRZjByUVdtVHZKY0V5NGV5YWRpd0d6U2xL?=
 =?utf-8?B?VlArSzRnbHpSK1MxWGYzQjRPYzV6ZDVtNndDTUE0MzRnRE9pTlBaWVRtR1ZW?=
 =?utf-8?B?dm80TVFUQkxPUmFxMWZlczFoNUx2RStEcTVpRkdpV0NkNmR0V3RFNUg1cS9z?=
 =?utf-8?B?K0JVMEUvSVR6MGtFWW1Bd0RZb3N3SzVvckVEbXdWUVc4YVZXaWIrZ21jQWNY?=
 =?utf-8?B?b1IyUzdqcURiNm1zOHczWFdYM2pabTRMNHROYWFmZFYwVno5RmNQMFAyVWpv?=
 =?utf-8?B?cytiYnBQZDRTWHQwUXpKTXY3WXZxWWdJME1hTjNMY3FPL3NxaVdjOXNrYVI4?=
 =?utf-8?B?M1V3OHd2YUJ5ZHdITnk1SFA5WVFJRVFvOVJHZE4vT3RkRVRGU2RLQzNWd1dP?=
 =?utf-8?B?OEVhU2dia2dxb01LbGthN3JPUVA0U0lFTFpSMTcvYjUvMXVaZUFiZHpqemNl?=
 =?utf-8?B?dUFadFpsd0lXVkt2M0ttUWlrcHdqZnJJK1VWa2FOTUJoeHo4TnhNWGN4cmpw?=
 =?utf-8?B?WGxpZG5vQVVjNXNCK1VQNzdTMkMvTDViRGV6dG5vQStXR01kbnhkVlRoN1RX?=
 =?utf-8?B?Y0YwQlUyY0RvcTRBWGU3L1NZbk5GRHlYT3RuV3Q1bDdmZDhpOXgrenZuVEc5?=
 =?utf-8?B?OTdnZ2pHZWFWZTIrZng2NVplVjBocGZub3NIN09CdWd6RVJFWFBraDlzWStB?=
 =?utf-8?B?Y1Vzeml2Y2tHTmdlY1BmTHNUVmtQS1F5ZXBwWk9BVERaajJTYUlGa1k1UWh5?=
 =?utf-8?B?dDh1aWpiVnp5YTVMRDlpcHNCT2NyaTI2Zm8wNThtTEUyUjYvUDZiWnZ0TEdy?=
 =?utf-8?B?OXNPNWdEM3I1TW9sd3ZTYkZBTnJSWm50WGwxcEM2bWFJa0FXWUlvTjEraTlP?=
 =?utf-8?B?MUlMV3kzTEhzOHorVGNDNDk4QS8yT2NQZkUwaE8rRkZYT3FqLzh1anhmcWRn?=
 =?utf-8?B?bzUvWHJ3RkZIdjJmR1BXakhSd3U3NUQ4eHlzaVI1V2RZOGVuRUtMNThSQnhy?=
 =?utf-8?B?ejhvTkxtTFJLekt2U1JKLzFidUhzeUFTL1hPekdwNG5uRkMzRW5ma1I4MmtX?=
 =?utf-8?B?OVpiV0hCV0JYeTNMVGszdytkQ1N3ekRyRmFvc0t0SEdrU1Q4d0hiYktiTHRL?=
 =?utf-8?B?VXdzcnNTUnFBMG1lT0JvOUxOMFNXcDE4S2JOK3dZdExyVHBGMnZkc3R2TkhC?=
 =?utf-8?B?MVZXL1FxanZkbndiK0RZTCtsbUF5YSsvQ1RZSDVseDQrRzVsK0pYMkQwQVJW?=
 =?utf-8?B?bk5CV3dSaVQvZDFtVnU3SmZRSVl3dXAySnlvbDV4czFpcHNIdDNzTjRNN2ZF?=
 =?utf-8?B?di9DK05GbHlXNDJnbUx3Zml6Y3NWd3J6SXVVYWIxMzVOd29BeS9qSVRzWVNR?=
 =?utf-8?Q?7N8qcnP36anF7TFy7mrjaiFhG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f44784-e18e-4d8e-fade-08dc0e432f55
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 23:08:10.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGJezHrYHMxCl5fNSldVJsnpzaftOSVP3UbTCLHFksENvndHE4YdQAilJcNJrco9jF1gIGSyewV+P2FA1E3Aig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5954
X-OriginatorOrg: intel.com



On 1/5/24 15:51, Robert Richter wrote:
> See comments below.
> 
> On 05.01.24 15:07:40, Dave Jiang wrote:
>> Commit 790815902ec6 ("cxl: Add support for _DSM Function for retrieving QTG ID")
>> introduced 'struct cxl_root', however all usages have been worked
>> indirectly through cxl_port. Refactor code such as find_cxl_root()
>> function to use 'struct cxl_root' directly.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v6:
>> - Revert code that broke device_for_each_child() (Dan)
>> - Leave put_device() calls in this patch. (Dan)
>> v5:
>> - Squash in v4 3/6 to update the qos_class to cxl_root. (Dan)
>> - Moved the introduction of __free() for cxl_root_put from v4 1/6 to
>>   here. (Dan)
>> v4:
>> - Adjust ordering of patches to move this to 2nd place. (Dan)
>> ---
>>  drivers/cxl/acpi.c      |    6 ++----
>>  drivers/cxl/core/cdat.c |   17 ++++++++++-------
>>  drivers/cxl/core/pmem.c |    6 ++++--
>>  drivers/cxl/core/port.c |    4 ++--
>>  drivers/cxl/cxl.h       |   14 +++++++-------
>>  drivers/cxl/port.c      |    4 +++-
>>  6 files changed, 28 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index afc712264d1c..dcf2b39e1048 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -295,14 +295,12 @@ cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
>>  	return rc;
>>  }
>>  
>> -static int cxl_acpi_qos_class(struct cxl_port *root_port,
>> +static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
>>  			      struct access_coordinate *coord, int entries,
>>  			      int *qos_class)
>>  {
>> +	struct device *dev = cxl_root->port.uport_dev;
>>  	acpi_handle handle;
>> -	struct device *dev;
>> -
>> -	dev = root_port->uport_dev;
>>  
>>  	if (!dev_is_platform(dev))
>>  		return -ENODEV;
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index cd84d87f597a..0df5379cf02f 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  					struct xarray *dsmas_xa)
>>  {
>>  	struct access_coordinate c;
>> -	struct cxl_port *root_port;
>>  	struct cxl_root *cxl_root;
>>  	struct dsmas_entry *dent;
>>  	int valid_entries = 0;
>> @@ -175,8 +174,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  		return rc;
>>  	}
>>  
>> -	root_port = find_cxl_root(port);
>> -	cxl_root = to_cxl_root(root_port);
>> +	cxl_root = find_cxl_root(port);
>>  	if (!cxl_root->ops || !cxl_root->ops->qos_class)
>>  		return -EOPNOTSUPP;
>>  
>> @@ -193,7 +191,8 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  						    dent->coord.write_bandwidth);
>>  
>>  		dent->entries = 1;
>> -		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
>> +		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
>> +					      &qos_class);
>>  		if (rc != 1)
>>  			continue;
>>  
>> @@ -349,15 +348,19 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>>  {
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> -	struct cxl_port *root_port __free(put_device) = NULL;
>>  	LIST_HEAD(__discard);
>>  	struct list_head *discard __free(dpa_perf) = &__discard;
>> +	struct cxl_port *root_port;
>>  	int rc;
>>  
>> -	root_port = find_cxl_root(cxlmd->endpoint);
>> -	if (!root_port)
>> +	struct cxl_root *cxl_root __free(put_cxl_root) =
>> +		find_cxl_root(cxlmd->endpoint);
> 
> That's the drawback that lines get very long. Not sure if that was
> discussed before, maybe just assign NULL in the definition and then
> have the first assignment right after?
> 
> Should be moved to the definitions above without a newline.

Here Dan says to avoid the NULL assign pattern:
https://lore.kernel.org/linux-cxl/65970c97b2b6c_8dc68294ca@dwillia2-xfh.jf.intel.com.notmuch/T/#m6462902836f98c35f0b0faa70467314998b22185

> 
>> +
>> +	if (!cxl_root)
>>  		return -ENODEV;
>>  
>> +	root_port = &cxl_root->port;
>> +
>>  	/* Check that the QTG IDs are all sane between end device and root decoders */
>>  	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
>>  	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
> 
> It looks like cxl_qos_match() consumes a root port, so we could pass
> cxl_root here directly and get rid of root_port.

ok I can fix that.

> 
>> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
>> index fc94f5240327..da92a901b9e8 100644
>> --- a/drivers/cxl/core/pmem.c
>> +++ b/drivers/cxl/core/pmem.c
>> @@ -64,12 +64,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
>>  
>>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>>  {
>> -	struct cxl_port *port = find_cxl_root(cxlmd->endpoint);
>> +	struct cxl_root *cxl_root = find_cxl_root(cxlmd->endpoint);
>> +	struct cxl_port *port;
>>  	struct device *dev;
>>  
>> -	if (!port)
>> +	if (!cxl_root)
>>  		return NULL;
>>  
>> +	port = &cxl_root->port;
>>  	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
> 
> No need for port variable here.

Ok

> 
>>  	put_device(&port->dev);
>>  
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 64f30d5fe1f6..63a4e3c2baed 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -972,7 +972,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
>>  	return false;
>>  }
>>  
>> -struct cxl_port *find_cxl_root(struct cxl_port *port)
>> +struct cxl_root *find_cxl_root(struct cxl_port *port)
>>  {
>>  	struct cxl_port *iter = port;
>>  
>> @@ -982,7 +982,7 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
>>  	if (!iter)
>>  		return NULL;
>>  	get_device(&iter->dev);
>> -	return iter;
>> +	return to_cxl_root(iter);
> 
> I guess this is the last user of to_cxl_root() now so we can remove
> the macro entirely. Unlikely we will ever need it again and a
> container_of() call is also fairly easy.

ok

> 
>>  }
>>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index df3db3e43913..3a5004aab97a 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -617,12 +617,6 @@ struct cxl_port {
>>  	long pci_latency;
>>  };
>>  
>> -struct cxl_root_ops {
>> -	int (*qos_class)(struct cxl_port *root_port,
>> -			 struct access_coordinate *coord, int entries,
>> -			 int *qos_class);
>> -};
>> -
>>  /**
>>   * struct cxl_root - logical collection of root cxl_port items
>>   *
>> @@ -640,6 +634,12 @@ to_cxl_root(const struct cxl_port *port)
>>  	return container_of(port, struct cxl_root, port);
>>  }
>>  
>> +struct cxl_root_ops {
>> +	int (*qos_class)(struct cxl_root *cxl_root,
>> +			 struct access_coordinate *coord, int entries,
>> +			 int *qos_class);
>> +};
>> +
> 
> Any intention to move code here in addition?

Yes. Needed to move that under the 'struct cxl_root' declaration. Either that or we add a 'struct cxl_root;' above it. But since 'struct cxl_root' is declared a few lines down, I figure I just move it. 
> 
>>  static inline struct cxl_dport *
>>  cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>>  {
>> @@ -734,7 +734,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>>  				   struct cxl_dport *parent_dport);
>>  struct cxl_root *devm_cxl_add_root(struct device *host,
>>  				   const struct cxl_root_ops *ops);
>> -struct cxl_port *find_cxl_root(struct cxl_port *port);
>> +struct cxl_root *find_cxl_root(struct cxl_port *port);
>>  void put_cxl_root(struct cxl_root *cxl_root);
>>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
>>  
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index da3c3a08bd62..4f3a08fdc9e9 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -94,6 +94,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  	struct cxl_endpoint_dvsec_info info = { .port = port };
>>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_root *cxl_root;
>>  	struct cxl_hdm *cxlhdm;
>>  	struct cxl_port *root;
>>  	int rc;
>> @@ -130,7 +131,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  	 * This can't fail in practice as CXL root exit unregisters all
>>  	 * descendant ports and that in turn synchronizes with cxl_port_probe()
>>  	 */
>> -	root = find_cxl_root(port);
>> +	cxl_root = find_cxl_root(port);
>> +	root = &cxl_root->port;
> 
> Same here, no need for the root var.

ok

> 
> -Robert
> 
> 
>>  
>>  	/*
>>  	 * Now that all endpoint decoders are successfully enumerated, try to
>>
>>
