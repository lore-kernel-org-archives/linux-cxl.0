Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2F360A3
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGaM/2/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704497649; x=1736033649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xg+JLhCsKJammxAoC/W9ztw+illudfUI0Lb9sKY/bWI=;
  b=TGaM/2/XLLMIqYyG+Z/jBaK1jPNgGIA6eX7n07bmMxHZPZ/bMxtYaC7j
   rMfgZVRuPFuf7MJPhJHn9NnutyGUV4Waii4OfsrLZNjVFFmJFul1m9JR/
   /eVMvQqjCPt9FlECKRHGzunK13yUk0eR+J0W9hnYXydsM6iLhuZARu+bW
   Vbkd7QA/3+woMd4et60/FwirmZXifhk7XFz2Xhp8Uev2PtjzB5CO9EVE1
   RLiPkUzFL+XTBb6rv7dXOReUzeWA1BI1ahFFbicoRIKTBIyIg7dKIdJbc
   1npP/+vIDEpTKWubU9xBD0mkDZ+LQUWdOmX50It/I8CkhQJzpj8xI61/e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="19122859"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="19122859"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 15:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="22630121"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 15:34:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 15:34:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 15:34:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 15:34:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/ibPlVRpEPgPJ1bliRttmXHe/lUbNEbL9cj2ba2jB7ArDedPsQPe/EjJErY/zhn9bURMxo158cg7UB0SCqvWrTBOSK3AapG3IogamASjQWjfjTg92wGdhpEp7vsftZOJu7xqz641+AsHMWQSg/7tqAcb0amJ/Pbb3QIBgYaYHshk5bvn+DPMTNzHT7/gd9vG9cz1CcyDPzDXg/hx9aoWHXDepUDHCZbATea4wISaCm1t92u8Q0N2MZF/1rl48HhTckIe3W01MGn+nCdUH/Ivxv65KFzYE3Ygx6+RGuWCAnIgYF6Ovq+tcdM/1wQwx78tDfLrpWpnfMyD6H1N5bC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhVWRIB4Qyl4QgDaUkurGE0AdtMZXAVu4W1eL6OPt08=;
 b=LLAH9I9+x+XNvttLAl9Fpb+QORnvSsLWkyJUamfAxKYfzOsZGbeMVVSK4Cvz7+4uXENvKfUaBTAGcOM9igmOS4KX30Y7jZdn7N5pr7iEuds9tpNAQVI08tKn9Lq09C1a+U9wRTyX7fm3Dd8YQqKsmUR+VHfYPx5EU7p/PV/vaHUp2L8kIhRbVwqNOXOq6JLEBTEt+1P38oLgsRlcOsNuzaV3aXfar1eOfC4YE6e/KC9cu3wTolLAjvvlXNrKqcmiR3pgjdI/NoymrN94b0vHDQ0wnfyjuBI0729rbPtsFNlIujeotJgRO1vKeck0qTJ55VjzSlyK49litd5lIbabtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH0PR11MB5428.namprd11.prod.outlook.com (2603:10b6:610:d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 23:34:04 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 23:34:04 +0000
Message-ID: <7148064c-c284-4623-93c8-faa998f1266d@intel.com>
Date: Fri, 5 Jan 2024 16:34:01 -0700
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
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH0PR11MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 36844c32-3641-4958-1e25-08dc0e46cdf4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMYj46JvWmJAPA7RChrAU3TdBTveRm2e6bHXuM7dufkYWbvQmRZTHyemGcTZiuEOuD8nk3NThWTf0Z7sztNhhckCykj6mcBWrAKLRynJimRmBY1Q9Ka/dvprvFXDf9bagzfI2qPJM4mrU+/idaLEMDNCJxj9x9OXXL9reXReeVTx0xIyfBOId+DlCfbiIsjtbegTpgAzUyVTFpTrxegYffCf1lU62ZrhPTTpLZKBlFDK7aiN3qMHK2ueRVx+ZIUsIMQK96c8vpcSv5qaqg6cETSi8GU/VGPsh4MSgnbabNuMlbrqUKYPa8+SWbl3j1Kg9XIHPNcwTE1KUaEKvz4GbtOh27On7ApPe8Oz/rx2I7JzypFI9QSMgEP/8J7ZX8VgsRYBsHr34He6V5PHfEjgQm0o1+01lqZaTShTmDUFi67qAa0V87fJMu+TcT83cs3XgNSJYhKl9M4+zBqtVKGcS0cljRbUdHK1mB9dTUqHFVg8Yul1kzMrtTdQzXjMAKGERSvWAl3amhZQILTwFiZbTLzB23ldm8+7b4reeDdbiVlBEsG4VhOVnE7qmTkxNtJYmvXEcNBS3YJLXsofPgozOtkD/R+vY/y5yGIG97RnR46nrgetelGhx1LGYqHacVAk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66476007)(66556008)(6916009)(66946007)(38100700002)(31686004)(31696002)(82960400001)(6506007)(6512007)(53546011)(86362001)(2616005)(26005)(6666004)(6486002)(44832011)(5660300002)(2906002)(36756003)(478600001)(83380400001)(316002)(54906003)(8936002)(8676002)(4326008)(41300700001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1RUVEc3RmpucmF3Zm1JTHQ1ZHRPamV0MkxubGhCM0JCdlVmMDUvbURlNy9O?=
 =?utf-8?B?ZXFGcS9zeW16T0NCdWtRejV1MWNHL0tvU3dpdytDWnBVZVhZOE9xajFlYlRB?=
 =?utf-8?B?RXlnampPMTV5MnhWVWZuQnpQa0NjbnIvZ2F5Y0E1QStIVVNoREdDS05mMnF5?=
 =?utf-8?B?WjZNdE1LS0VaU1ZvSk9tUnVENldDeS9jalZXWG5KeUhzdm4yWjBZSDd2dUZt?=
 =?utf-8?B?SUhYNno4OGNNTDNTNk9yaWZxZFhPdjAwbXlYdXlUNFZBUGhMUWJFQ0l5U29L?=
 =?utf-8?B?RW54Sm5HT0xqcWw1cWppVis4dGtTMFFIbTdMMnlJVE9udXE0SnZNMHB0Z01k?=
 =?utf-8?B?MFBrMDhzNFRhVnJhZ0cxOUwwWUMzQTJjUUk2UGpybFYvNm9ZYmU4ME9tajhP?=
 =?utf-8?B?MFYzS04vR1ljK0hJYTN6TDdnU0RDWnc4N2ZkWXpqS2UxdEJzdXNyajBPUjhZ?=
 =?utf-8?B?emtMaU5lNXNSWFIvbVhVRUtlanc5Y1FlVWNhMFRqQURYOFJub0JHTTVhTUlo?=
 =?utf-8?B?enp6ZEZuUGRoMTlRQWFxNjdxTSszaHZWdklNb0NzdVl0dmxveDlhVGlXeHZB?=
 =?utf-8?B?OFd3MmFHdk0rRUxVNk1pZ3ZZbm1WOGJBNzhNRGt3aml0dG5yak9aaHoySU50?=
 =?utf-8?B?V284MVZiQURhZ2xXVWJsYm9za3U3NW1ZME55Vk1QeUQ4WGZINDVJSEJCaUZJ?=
 =?utf-8?B?aEVEdk5ZTHZzcUZ2bTJGWGlrODRVNGhvM2JncnMwdUNiY3BMc1RyNHJiNFdM?=
 =?utf-8?B?SDdpUFZockN1RzJkcHNncFRielNvd0tKTlBHdEpHaS9UdXU3c0VYMGJIbVND?=
 =?utf-8?B?RzRDd3JDRS9KVHBzNVhjRENYa0hvOUlmODMrLzRVTnFuQ3c1MHE3YXJqSEsw?=
 =?utf-8?B?WHc5ODhaWjY3akRwWWk2NGV6Q0lhUHlHWkcxWlNEWjFpT3d1WGVsUVpaQWll?=
 =?utf-8?B?QnhZWHBHS21qZTlmZExyelhMQUJhTVJMT3lmTlFId2VFK2ZpWmtYaXg3YldY?=
 =?utf-8?B?REtQR3orK2p3MkNlQnRmQ3VPeEVzeUI3OFVlT1pVRkFNWWY3UWxMeEthMm5w?=
 =?utf-8?B?b05IK0MzblI5NFRQT05kN1h1SVpiVytCMnZPZ3JRR1BtbWdxYWQzQVRHenl5?=
 =?utf-8?B?c1FJSW9pZWhtaHdrRmVHZ1hKOVlkMDBvd2JrUFIrOW5zV2x4QklUTGo5MFBZ?=
 =?utf-8?B?dWdlMlJrd1N6VEcwVnM0c0pDaFgyc1loSU8zM29tM3JGMUZ5WW5kMFEyVi91?=
 =?utf-8?B?V2hYSks4Q1ZqbkxSaUlLL0pKNkVKSnBKaU43bVV1WW9xMWdDbjJGWlRoY1Rr?=
 =?utf-8?B?bDlvWGJwYnljNXh5RHYrei8xbm1RUWVlQzNoNDJTTGhRTytiRS9qTGswYWFS?=
 =?utf-8?B?OFRHWDVoalg5OTFEZkQrK2l5M21kY0JkY1ZHY2lwUklaOUEzMWF0R0lJZzUz?=
 =?utf-8?B?ZTQ3MDh6bVpORmhEdlBJNi9MK2orZFBCTmUxVmtZNUdiZ0NWL2pmZ1JkUVk5?=
 =?utf-8?B?RElqUlorMlZwcVRDeUtaY2pRRW1tNENQQU0raWdLMlZIWkFpYlpVVjczSVB0?=
 =?utf-8?B?cWUrd2xQTFZBNHFoU3FTVm4yQmljb3FtZDgvckRROXJpNEtZSjFmVXl2YkRi?=
 =?utf-8?B?OEVkbTliQlo5ZUN1dllaYUw0MDVna2VwMDYzZjNWdmZ6RUhxNjZWNkJiQXBC?=
 =?utf-8?B?QWxJMlZpQ3RoOUNiVW9JemZxR0VFNG5WemJ2RkJjbFUrY0ZFYSt5NDBnanlO?=
 =?utf-8?B?bk05L2FXcStQTXBUVU9ZZXhrUVZnaFJMeDVRNGtpRk41amxod2RCdmNST1pC?=
 =?utf-8?B?eStONVBYOHNoV0hBQWxybkwxTGM5WlNocE0wU1JyUlM5TUNWeFE2eFNEUGhq?=
 =?utf-8?B?U2lYcFE2MzVCTTJNenNQU21Rejh2RmpGeWNKcURCSVNqZTVTQmRkWXNrQmw5?=
 =?utf-8?B?V1FOanN4bGwzQ0M0UWd0UGRMdGMyOTRmOXJXSFkyQ3hLOVJGMGI0K3JLZVI0?=
 =?utf-8?B?VG4xRjE3Tksrc3AvMXhBNFJOT21DZmNXbmpvOWtXL2F0TXBlNDdlRUZtSk1n?=
 =?utf-8?B?alpoTmxMQ1NabzUwZHU3OWlSMDJsbzM0NmdsU1NQOUNlVXRtSDRqVHZuR21a?=
 =?utf-8?Q?fMZCuUii199oxCZb+XAJYSieA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36844c32-3641-4958-1e25-08dc0e46cdf4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 23:34:04.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNpy62LaAwyyAMNI6/KWJZCUeXGhKKQNSlUrKUCO116sjhhf5j5xRMmJTjOabLzTyKmXAmR9VaCPJV64Wp52RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5428
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

Looks like there are two other locations using it still:

$ git grep -n "to_cxl_root("
core/port.c:546:                kfree(to_cxl_root(port));
core/port.c:914:        cxl_root = to_cxl_root(port);
core/port.c:985:        return to_cxl_root(iter);
cxl.h:632:to_cxl_root(const struct cxl_port *port)

So we can keep this macro for now.

DJ

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
> 
> -Robert
> 
> 
>>  
>>  	/*
>>  	 * Now that all endpoint decoders are successfully enumerated, try to
>>
>>
