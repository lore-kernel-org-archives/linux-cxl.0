Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1109381AB
	for <linux-cxl@vger.kernel.org>; Fri, 15 Dec 2023 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnRafuVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702655224; x=1734191224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vao4QghPOBFZW26Zf1fmEq7wkomtt9y0GOf7/y/+2m4=;
  b=CnRafuVMDSXKmstTPfO4bWidFtO8yT3AJE71z6wnFAPiRSf09R0EhEC6
   VV8L0grMQClnc3SrKvsJxJt3n/rOkn++vJ8gCKmFv6I+aRGamaG4fryyJ
   wHFkmQ+o+eI2CWe57hvrajTCbha0+iUAZnwd4VPy6Zyd3FTI7CXjWwnI4
   eqfYmuiqgmeGl0vhqNW5J4cayLck98WrfXGUP0ZYxd5whIWtg8QB/OmVD
   BXkJ8p4x3ruBDjhNKdNK56JOwPrsV8sGHSYkkJiv8FrxPpklYjOAOCWSa
   NMm55KHMmHZt+ck85W7Iepqam97vKiHJthWgKdKwGQjxc3G4x8V503B42
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461752537"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="461752537"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="948005866"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="948005866"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 07:47:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 07:47:03 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 07:47:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 07:47:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 07:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6c8nZ6fc+JI9YIJTeLX/oxEkg/WRbaOTGlII+mcHDr6r7Xvq7iNug1no1X/4Bsod1NMJhkZfQOW1kYZW1C+icTZZo7oeFbCJxyXQQDeRyT/DQYNLHZ8jZ/OZSEKOBWNDaUozSZ1DjVGsKgoK+bsXcnRbs6JSlijgmLoQhZfq8XKAJe4kH+NcoyEFKozb0vI79wkULvOP8LWTRByRRchputrNJBEmUbKp8Yx9yvRxolzTnJ4xt/mq+nHwz8gFhpFbJcdO4P4gpuW4qaG31RJ2FNtMtIY9y5N6/t7+0lTP1dyRdaZx3ulgzc+g8ZbHLZkumGmAILm1l3BVGINbIiXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Wd+s96kAUeVyCsPS7p7YMWcyLKB27GZBxXbG1a9M9U=;
 b=F1gICNMmETxVlrpicTxYn+a1qVZ9F3WWqj9EIbRXm0lUg7ypIWzwp6x97x/CamlrJ/nw5jpSGtJw9PUHRN5WcnG9Vc7M6wQXpvuBCB23mBBzHk5bpN4IiS3oN/eUMMYdQt+s6HGg4oy0bcHDt4pPsyDtTvisKjpOKG3jIYyD7Yn2sePWj7yUR1dDvuEyUnjRqnqtAwSu7NJY/N0BZkS7LGk0lHn8wR9Dodf9ajKJAnUDqgi48hBmR7H3/OBkvkWzmOg8/nxcxTMZmRe4y5mfEB1jbticav+vSDX8RRou5YMjZyT+U9/dxuIe6hmJRl5c6u+sx0P1CGR/iGFVbS6MIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 15:47:01 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 15:47:00 +0000
Message-ID: <0997dcdd-44cd-4607-a3c4-31ee41d4d23c@intel.com>
Date: Fri, 15 Dec 2023 08:46:57 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/pci: Kill a goto in read_cdat_data()
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Robert Richter <rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>
References: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL1PR11MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: a11c5e86-8c60-4193-f247-08dbfd851398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4m6O+m1OP709j1dePfnKMJbbKsoaqD5Qe7g/cP3C+Hx/mlvan1YJiQ7UxnXV3axg8DgjuBgXQ+79ok4J8b1MhlcrEWmxzOiiHeAo5n/r+9UsiihyhkKzO2fvXnVIZpVPM2lgynaVxECrfZ24/e2tJXx5eN9d1HDVVDDEMKlXHiebQFFwKIdiyq0n06xfQVmj7hFpvG1ijzoMNa0gboiUbj6z8hE+T+9pcRQPpKzPWWXhU6yP4jvBIufpVHMDASTsW0gOhKa8Xvso7m9QK3+Vc9dfgDmUJPX0Ds5hiIare+RHbyvfjKl5iMmPfNFUumlvvXo5E2Tpr+VJJzrb5UZxCOxLcH18Pwe4PXiAnI2zPmNYKw8vcYp5lLSjXeveAdYsgzbcsjrQXX8K/J8eQfr9LUPz7T2pCUMLOS9HiDEJLFcUyUpK/EC/1tPNFyD0gHT2DJkPzYjJkqTnxpFd3yECPomgkg1IUo7vXHXgOehZcYW0cy31ikd7XygB+Es8XlStLWs9AKKRhJBNVZZuVsdz7mM3pP09NDNiocqIrDh1JYq5X9zlO6tgW9/PSXyvpoJ3uvk+XxaEtg8fkXZ2+84zIRdHEHnElIvmZ7G0/IOjmdyI3Y+kWEeJAzbwaPo+BZvd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82960400001)(2906002)(38100700002)(36756003)(41300700001)(31696002)(66556008)(86362001)(6666004)(4326008)(8936002)(8676002)(83380400001)(26005)(54906003)(66476007)(6486002)(66946007)(6512007)(31686004)(316002)(107886003)(2616005)(5660300002)(44832011)(478600001)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajFkWENLUFl3aFdNR1dpT1BJNTVGVTlsdjRHcFRjeVRhcDNmaHkyYlE4Njcy?=
 =?utf-8?B?WFJhSU1hOVVSR0p6QVNsejRFMXNKY2VJZDNrVUxxMSt4MWdzR0ZMekFCTmVk?=
 =?utf-8?B?UDRyTDVEV3l5VDVRdFhCamc0bXlWSTNody80RUU2UXdRMkdUU3F1QVVFUFZC?=
 =?utf-8?B?eGF6YjQ2TnpiL3N3c3A4UzRkaU9XTjhaSXNNUzFONzJGTkthU2JhMGxVRTJS?=
 =?utf-8?B?TXQxUlI2dmtRbkNndHdJSi9qbTU2VjFTb1pLWmQzcUFYV2VtY1V1alVOY3Zx?=
 =?utf-8?B?VHVHS1V4NEUvL3I0SGU5WGRGRzRNMzhQMlBzRVI2eHlpL21yN2FzSW9CR2Np?=
 =?utf-8?B?c1NJbTZkODVjODhCRXhMeFZzTU1vcVF4aVZRS3phcUxJVjJoUG05QVZjSmZW?=
 =?utf-8?B?amhiaitmUHZLNm5CUG0xL3dER2hNMitlVFdjUGlDWjBPMHZwd212V3RicUFH?=
 =?utf-8?B?b1VYOFBEWG0rbzFOZWZsZ0d6NVUvRHM5VjhiN1RZQXNGYkFhVW5RamRlS0xS?=
 =?utf-8?B?RVJCNFFpVHdXWlpVclNzaTZuSE5XckNmQmxiYlk5ZGhWVU1JSVZNcXJ6SVhH?=
 =?utf-8?B?YVBuRmxxU1FXcUpQTjEvRzE4UXQvYyt4YmFpUDM2QXU3RVdFYjU4SFRHcU05?=
 =?utf-8?B?ZTErWWkvcFpRRFhDUHlFaS9Wckx3SVY0YXFReGdmdEErYVQrdm5tNzZnYWdu?=
 =?utf-8?B?eDhSbFcyZWJadFY0c2ZNWnQxS3JiZDZad1FIKzZkbGZzS2JmOCt6QWg4WS81?=
 =?utf-8?B?bWJEMWllY25VKzI5Rmd5MkN5eVB1QlVWQ3JOeWJLZmxjNjdCZTVjRFh3SjBi?=
 =?utf-8?B?dzcvNWk3cTcwV2w5NzY1UXljcXNMLzNzMmRTK3NQQjRqL1pidTlmOStLcHhF?=
 =?utf-8?B?aWl3amtnWnA1MHNrTSt6bGpHNG9OMWo3MEIvcVZpcnZHYVNJa09VUVFqMS81?=
 =?utf-8?B?eFgwVVJqcUd6NXJqaS9pTHJZYTJoTk5JTkNGVWRBdHIzd1U0ZnovNzRadG1W?=
 =?utf-8?B?T2FtZWVIWkFPcTNMUHJSM1g0NVNxcVBybEFJSHFTQiszTHJGdmpGQTZGMzll?=
 =?utf-8?B?MGJJc3JWS2tQaUVDNnh0M3I2WlV3Q1JFTUZEeE4yTThRTGYybkdqNUdSam5C?=
 =?utf-8?B?aU83dFlId1oxVG5meVdwR2dTMFAzdFA5TlA0ZlZ0czVKUFJkb1ltdHBZRVBZ?=
 =?utf-8?B?SEIwaDVCcFZ1dDIvdHNaMjgwZFBZOUVDK2VicVRIZ2lTcVFRUkk3Q1Q1Rk40?=
 =?utf-8?B?cVBMbjVkL1ZJazhrai9PU1F5bFNVUzdqZi91SWFiMXB0NG45L3JXS2lvSlpI?=
 =?utf-8?B?RGF3QmdjbjhOVVlPNmNUSm5hazdlblNDckY1Wmttc3pSYkswTG83a3FBeEkz?=
 =?utf-8?B?K3N5SUx0ZmlTWGVlQnRvenNwUXJxL2dZUnVmM2RQTmNwWEtCZko0eXorZlJP?=
 =?utf-8?B?YXY0UzZHWXJaWVNnVGJ1RGdPc2ppWTlVNFNoeXZPem9LNTVNcmZIMGxGczFl?=
 =?utf-8?B?dmcycXBKZnVqRmVCcXB2OHlIVkRmZ0VmVHhFUXB1a2VxcTRDdGRzNVpiZUhG?=
 =?utf-8?B?emE3dkFEOWNtNkVxUjM3KzM4bjlkR2cwNVIwRHRzQ1FJdDA4M0NmKzlHb0Ir?=
 =?utf-8?B?K0IvbHR0dnNlWVd0cEVyRjA1RGIwQ092d1RrTHhQZmZTUklmSEtnbk9iYmtQ?=
 =?utf-8?B?WTFrdktPZVBlZVdySXQ0YnlxV2N2T1J2cVhxSEJlZldiaDFyaHhCM1FYSHpq?=
 =?utf-8?B?UkMwK2Z5bzhrdVo5Y04zclMvOXpuWmZkM3hoZnFpT0tsZUcxSVoyY3UrZHVm?=
 =?utf-8?B?S1JIR3ppZ2FMQzRNTlN3T3huMEJDSlBEN2hJd05rSzNMN2E2ZXF5SzlBL1dK?=
 =?utf-8?B?dDNjNzFJc3BmNVZYK1JKMWU2eUdQR1VHWUdlU0ZBem9MNVVCTnRLbDBnT3N6?=
 =?utf-8?B?dEdSLy96T25Kdi9rL09Ia3h4RjhzSlloejk1YVpodHVpUzFwbjE3UGozNFVB?=
 =?utf-8?B?d1cyTEM0TnB6Q2RoZmI2Q2VaSW5iN3NNRis5QXYwYmo1Mm5QcVoxZ3dhRDAv?=
 =?utf-8?B?czZUTXpRYWV5TE5TaThpdHFaM1hERDUvV3Z4LzVwc1JHOVdyYzk2QVQzWmZM?=
 =?utf-8?Q?++zLlsNLqw7UPQvYJpXYYZdEH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a11c5e86-8c60-4193-f247-08dbfd851398
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 15:47:00.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boRk13KE8MB8lI4JuqlwTd/ZnTfWgksvs6UzqydhOqgKbJ6V7PybLnbZMgEk6j+vfCPeH7zirvVznJxdmCVL8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-OriginatorOrg: intel.com



On 12/14/23 22:25, Dan Williams wrote:
> Given there was already one bug here around passing the wrong value in
> the cleanup path, remove the goto with the use of the __free() helper.
> Note that since the cleanup helper only passes a single pointer as an
> argument the auto @tbl variable needs to also include the @dev argument
> to devm_kfree().
> 
> The open coded math to shift the port->cdat.table to the relevant part
> of the response buffer is saved to a follow-on patch to cleanup.
> 
> The "devm_buf" scheme can maybe move to include/linux/device.h one day,
> but the expectation of using devm_kfree() in an error path for the same
> function that performed the allocation is a rare pattern. Many
> devm_kfree() usages are at object mid-life or end-of-life time, not init
> paths.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c |   29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 37e1652afbc7..dd938a60a2de 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -606,6 +606,12 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>  	return sum;
>  }
>  
> +struct devm_buf {
> +	struct device *dev;
> +	void *p;
> +};
> +DEFINE_FREE(devm, struct devm_buf, if (_T.p) devm_kfree(_T.dev, _T.p))
> +
>  /**
>   * read_cdat_data - Read the CDAT data on this port
>   * @port: Port to read data from
> @@ -614,13 +620,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> +	struct devm_buf rsp __free(devm) = { .dev = &port->dev };
>  	struct device *uport = port->uport_dev;
>  	struct device *dev = &port->dev;
>  	struct pci_doe_mb *cdat_doe;
>  	struct pci_dev *pdev = NULL;
>  	struct cxl_memdev *cxlmd;
>  	size_t cdat_length;
> -	void *cdat_table, *cdat_buf;
>  	int rc;
>  
>  	if (is_cxl_memdev(uport)) {
> @@ -651,26 +657,19 @@ void read_cdat_data(struct cxl_port *port)
>  		return;
>  	}
>  
> -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> -	if (!cdat_buf)
> +	rsp.p = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> +	if (!rsp.p)
>  		return;
>  
> -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, cdat_doe, rsp.p, &cdat_length);
>  	if (rc)
> -		goto err;
> +		return;
>  
> -	cdat_table = cdat_buf + sizeof(__le32);
> -	if (cdat_checksum(cdat_table, cdat_length))
> -		goto err;
> +	if (cdat_checksum(rsp.p + sizeof(__le32), cdat_length))
> +		return;
>  
> -	port->cdat.table = cdat_table;
> +	port->cdat.table = no_free_ptr(rsp.p) + sizeof(__le32);
>  	port->cdat.length = cdat_length;
> -	return;
> -
> -err:
> -	/* Don't leave table data allocated on error */
> -	devm_kfree(dev, cdat_buf);
> -	dev_err(dev, "Failed to read/validate CDAT.\n");
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  
> 
> 
