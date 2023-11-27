Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSJhxF4x"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD66BF
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701106827; x=1732642827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J99a7JpS2deza6TUpl3XaTJjD78ne5raF5E+j1BS/mk=;
  b=HSJhxF4x5ThUn1JCoidXbHZ/mvZT9xkBwo07wYS5IRiPRaPNyWZ5cPub
   fkMQdjTknam22rIaUOzLSLfPmnadT6UYXhRNUmBr+KU/Z0JsmQF138d4c
   2uG7oSjA8lQV8VbyRGEcBA33dko+vNDvB4uwW3FqUrImHtNMmgnjlYauB
   bLhFQGyDkFvsKjvuz9EN0RsRGULzS6hG7K7cbfobgNWvcMLRmFvjQIhLl
   ck35UZO0pRUs27kq/L0UOafaA1nA7k2q+fcX2I9+3ssGaBRLUeqPggZBY
   E0NmKTDsPFE3QYpLvAk2UYlhHrLqRnFQeZzO6D6iz1cMalWrjmLzbys4g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372130377"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="372130377"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 09:40:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="744631412"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="744631412"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 09:40:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 09:40:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 09:40:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 09:40:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV8TcFISoou2lFbKyKEZ6/hnQT3Ps7BtqOL8tp0Uyl4lbnHQnES8hjvukS3HduSZrlPR7g1DnX5gwJPnXjD4GnOGSPniov0ePGMDfZg6R4DzzuVcxXzogEvRbQUjnzrFpqK68xMbvqQbV38By5EyrjFoSNuiBKtUkP7tEsOk+qwUNkqK5gQWX660NDfliVgrV7fOTV4nezl1S0Te5M76n2mia6M8w9jXpnpwoUS9wPunXOA459AGlrl1jzMt98Vl1xOYtcNvLzOyO+RTBU0kb5Syc60mMv0VR5wgCDOrfVw0tYdtPUYxzfF97yiD2j5jI4iBlIoxHJ/QraoaXtP5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3bA09OweoAAFugRXmk0XrHi3x0SJA5JJ1NShpFmxAA=;
 b=A874TC5yJvYvCLngGYktzLW0TJPnkUINhpVFStNsM/VdN3nfAehNPe5TOizUtVXtUPKzhLeRvegyiBSCtE6DefBZiBj/D1tIR7QCcpipsl8uCgkwx7lvKMxPCV+0RWyM/i6gQRmz9ecEFKtUX7+XAXsaePIdfelF2766A1e4d5Sapo/LbLkmqSd9yzDTWOkjK88aaptpyBvNoSap5qziC+RDuHbUUzNTSNpTkWymz0X9HaxyHBuy2C72vd5vRd5JLqNdvjA/mXLdzEM1mwMHblgXSiSxBOq3q1K4J+1BrQPuD0sC7up0OTW4diwb7POyvtG9IrbgPckRFLdlZfDbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 17:40:17 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:40:17 +0000
Message-ID: <93aa57b4-ee64-4a99-b30b-c784635b8f9b@intel.com>
Date: Mon, 27 Nov 2023 10:40:13 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/2] cxl/core: Always hold region_rwsem while reading
 poison lists
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
References: <cover.1701041440.git.alison.schofield@intel.com>
 <08e8e7ec9a3413b91d51de39e385653494b1eed0.1701041440.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <08e8e7ec9a3413b91d51de39e385653494b1eed0.1701041440.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ1PR11MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9d0fd7-0598-4b26-7b41-08dbef6feb0b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9+6rN5pCDW9/bb6Hrq3C83QpyfZwGYczX0hXoyS3ttOCcgUXmXX9IW2jI41X+5lAZ+FkjDO2EGR+GLWSLbHGZ1ND73ZnAA/CSu2psIdM0/sYV3YTWRQqVIxbbQsMeqzG0wKndzGJA4fB7uahyVffT4/azNpLgvW86UW9mQNCKvt3xam1dGOslMYMtcnPjiTrSAGDMEW2lTiVD8J31SljOO++oQ3IDOEAK606/dMnfb0FVD1305c0bgmCU7fNQI4eBK4ql+DQVzPhP3O/IbW46zRzzfUqvhv08pWCDhM7x5fZ4YyOnVg4PJJCGcWF/pZSb5/3E7LJWKEzOZ3JUPn0Q8ZH+wHojRKAEvT66g8+fF2dPA1ViH8M9F5/Ft2wtTeBUTwnjhgy1fzEtHkjtcd785Th6LHGW8ZnTNS7KEHdsqJ2XmyJ0mxfwp3zw5xExqlivsCN2EDPTmkAxvCm7OerRQXO0xQ+w6YKiPtxbaccIYNKE5r6y0+kDYtEyICcbINL+AWBacq9XY4tTqpNQU1sLN8oHF7DwQK2nFsDfolMQACedXgOjUN6UMJHzvBHm33dt0e9w3Ie1sKWjoQFel9X16q7ow+fqXuBRmkA1/BQLUDAsYgYYCFSBtWI2J8iYw8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(1800799012)(186009)(451199024)(38100700002)(36756003)(31686004)(86362001)(83380400001)(5660300002)(82960400001)(26005)(44832011)(2616005)(2906002)(31696002)(6512007)(53546011)(6506007)(6666004)(8676002)(4326008)(8936002)(6486002)(508600001)(66946007)(110136005)(66476007)(66556008)(6636002)(316002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUQ0QkNCZThFR0NVN2RTYXQrYTVZV20rQStELzV3MGw1eGo4UFlmWmpDczNU?=
 =?utf-8?B?RVoyVVdDS2d5NFlDOWRzaG45OGFXcFVjTm53dWVVMk9qYjdTTDEveDlCc2Q4?=
 =?utf-8?B?MHdiSkFKR0QxTzVJMmtXREtWVHdkbkQxb3Nxc1huaHlMS1BNNEtvL3hkK3Iv?=
 =?utf-8?B?MmhlTVNnWjEzWUR6MVdrRFR1WDhYcmFSSVBMdmxFV2NIa0dzcVpta3ZneDBa?=
 =?utf-8?B?YWdCK2xxckEzNFhiR0xYSHlVTGpZMHF2M2NhV2o2RnR4WmNyK2ZEd2t2U3Fs?=
 =?utf-8?B?OWhCOWc2Q0FXazhqRlRwOEhva2dhZTlUcjlXcDFyazYyVm5rZlB0NTJHcUZu?=
 =?utf-8?B?eUZwWVVmREtEWTlvTWFHenh2NXBiMVorbm9DU2dKaVM5YU92cUhpMEluNnVp?=
 =?utf-8?B?N3JyRFgxWEp5TGNkN1ZVaUhDNGFoNG5GRWdHMUlSMVdNM0ZwY2g3bjJOUG90?=
 =?utf-8?B?UDllNEh2UTFWS2hLRGp3Skw1QkozZlBub0RRcXBLRVFvZkpGa3F4SG9HMFk0?=
 =?utf-8?B?MFlzR2VKaUhYOXlPTzc4VTI0QnhPTDlEUGVWUDFYL1ZGdXU2L2NNYzhoSFRk?=
 =?utf-8?B?cEtqaXJrbEU1bFdNb0pRWG9RRkE2WW53bjNLa1hlQ1VNeGkzVXk2SzR1ZGlC?=
 =?utf-8?B?dDU5V3JLU0NoRThiZ3k2c0tKVmVMdmMweGxwaEE0TThOVDZCdzlaS092ckcx?=
 =?utf-8?B?V0tERFBHeWticVFPU2ZSZlBqNnErSy9PeldyM2VZemQ5cXRscTdlclJ2SGdi?=
 =?utf-8?B?MnppYTFqWVZBWExmNU5udTFFT2habnVjRmF2dTkwNVBkTlRIUkdEUHRNSCtl?=
 =?utf-8?B?RUhic0hxc3c3ZG0zMC9adFRsV2xyRDR4cDVPZkVhV1ZoaFpwMW55MGYrQlVR?=
 =?utf-8?B?dENmdEFkVERmWURZSDhxTzJLYUI5YWsycHZyUnlpWm4xekpPaDVVbGJxVWlv?=
 =?utf-8?B?b0RBOGh5c2hCK3NOaXZ2NExVUm9WbVN0Z3Y3ekhya3haMmllRWh4ZStpeGJq?=
 =?utf-8?B?cHIyTW5uZDF1bi9JdW1RenI4bDNJWEJyYUlEWHIvdHFwdkQzSmNjRU1LUWt0?=
 =?utf-8?B?b092TU83Z0V6NldGNGdTWjRTNzNlZUpNQ0NBSHNIWDhXb3RLdlpZMXQvdDdD?=
 =?utf-8?B?bHREeVZFeWZXTHNwRTFNTXBWVHM5bTF5M2NxS1lJR29aQlAvdUR6dmUxU05k?=
 =?utf-8?B?M2FzR3F6VWI1YWtJekNVcjJqWE9va05ZalVIa2NNQ1Z4bGR0dnk4cXhFSlMr?=
 =?utf-8?B?b3VRelQ3WFg5K0NhdFZRWmdBSUljT0NJa0xqVmVSVWh0eFRaMjlBcTYvNTVy?=
 =?utf-8?B?dXBuTkoxaVNFWTBDNlV0OWd0OGxpVlJ6TU9lMDh0cUNMSThHei9IRlBsdlhl?=
 =?utf-8?B?MTQwYVJRUllmdHJXdDltWjF0SjByT0t2SFR1bVBSdlZCRi9XNkpUNXVOS0g3?=
 =?utf-8?B?OEswaVlHNmVVaHU3SEs1Nm9PVmw3SHR6bWpkN3N5S0xONys5eXVBTTcyYVBr?=
 =?utf-8?B?eUF4TlNHTXliNTJwTTR6ZDJsSjNHa2VVSVRqR1Z2dy9Tc2RrKzZiTlEyeEFJ?=
 =?utf-8?B?QndVVHQrbkVzZDZkSHZYN1dZRjdlUDJVd0V2M0plYStuUnBIR0NJSm5TUkN4?=
 =?utf-8?B?SG5yTEI3T0ZMMHJyTlJQY1cxOXk0RE16UXd3TlNXdWZGbXUxVHJkMlBGOXla?=
 =?utf-8?B?RzM3cDdlY1Zpb0R2UzFKYnhKVnhWQkhBWHJBZXFKQ25yTk5wMFBlYWVYT1lw?=
 =?utf-8?B?YW1STnZrc0IxNG45OFlJQlJGUERhNzZUbXNCWUw4UWNXM0lHbll4cmNncWRV?=
 =?utf-8?B?aDNoaXc3RExicktZNTBObVR1Zk5lODVjUVZoYmNla2hWYldNQTBZWVVHOWdH?=
 =?utf-8?B?Zlk5SSthbGJ4TkZyaW1QM3hrMVdyODlUZDR4TUVDeG0yZ0ZXQjJCRGx3UGlx?=
 =?utf-8?B?RDRKbVdqWEg3dzRKcmRpclhWVC94OS9RV1JYaDFnalBWVzg2bytmTkFqYWp3?=
 =?utf-8?B?bkxGWDgvUFlHVUlRTXJ0RUVoL0JvWWZvTWZYQnJSa2tYZmpSQis0SzZVd2ti?=
 =?utf-8?B?d3Eyem03VENzYWVvdktkSm13ZEgyeTJIbUExZFhzYy82ekdoY3lzQytEbzJS?=
 =?utf-8?Q?RyOmELW9Ud+iBt8fcdxSSEiKP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9d0fd7-0598-4b26-7b41-08dbef6feb0b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:40:16.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdpCkw03Ye0v56GtaxGdyHEzdJgqmx9PWFM6xtlrMHTxjNUk0CI33ZCY4ZyA6HTVk1qUDqAocLlZob5YHAGtYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6108
X-OriginatorOrg: intel.com



On 11/26/23 17:09, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> A read of a device poison list is triggered via a sysfs attribute
> and the results are logged as kernel trace events of type cxl_poison.
> The work is managed by either: a) the region driver when one of more
> regions map the device, or by b) the memdev driver when no regions
> map the device.
> 
> In the case of a) the region driver holds the region_rwsem while
> reading the poison by committed endpoint decoder mappings and for
> any unmapped resources. This makes sure that the cxl_poison trace
> event trace reports valid region info. (Region name, HPA, and UUID).
> 
> In the case of b) the memdev driver holds the dpa_rwsem preventing
> new DPA resources from being attached to a region. However, it leaves
> a gap between region attach and decoder commit actions. If a DPA in
> the gap is in the poison list, the cxl_poison trace event will omit
> the region info.
> 
> Close the gap by holding the region_rwsem and the dpa_rwsem when
> reading poison per memdev. Since both methods now hold both locks,
> down_read both from the caller. Doing so also addresses the lockdep
> assert that found this issue:
> Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
> 
> Fixes: 7ff6ad107588 ("cxl/memdev: Add trigger_poison_list sysfs attribute")
> Fixes: f0832a586396 ("cxl/region: Provide region info to the cxl_poison trace event")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 9 ++++++++-
>  drivers/cxl/core/region.c | 5 -----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index fc5c2b414793..5ad1b13e780a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -227,10 +227,16 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  	if (!port || !is_cxl_endpoint(port))
>  		return -EINVAL;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  
> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	if (rc) {
> +		up_read(&cxl_region_rwsem);
> +		return rc;
> +	}
> +
>  	if (cxl_num_decoders_committed(port) == 0) {
>  		/* No regions mapped to this memdev */
>  		rc = cxl_get_poison_by_memdev(cxlmd);
> @@ -239,6 +245,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  		rc =  cxl_get_poison_by_endpoint(port);
>  	}
>  	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 56e575c79bb4..3e817a6f94c6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2467,10 +2467,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  	struct cxl_poison_context ctx;
>  	int rc = 0;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -
>  	ctx = (struct cxl_poison_context) {
>  		.port = port
>  	};
> @@ -2480,7 +2476,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
>  					     &ctx);
>  
> -	up_read(&cxl_region_rwsem);
>  	return rc;
>  }
>  
