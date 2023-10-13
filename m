Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25068219F7
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qyi18v00"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5BA9
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697215725; x=1728751725;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mR0sfSfv4cv4jIWzgz3uRy1YlEJn0jIkwL33VAjleCY=;
  b=Qyi18v00Xm7jDDLIygqI0gb5LdWFnmgYv974sA8jxEh3p9aEquPTf6PT
   EYyc9Vc3evH6KE39gXFwUnAbArkTHCV+nsffP6Vra8ESGQ6XIA2Gw9F4k
   QPFoAI66aZzW8JhqnzA1rFD4nLs29aioNlDxQfgVh9AoO7aELZqhwL4Vh
   uxMUPqO6aUmcNg0XF14ycgEzl1XKpZYkSkAbnyP690QzSwz5ulpF1ez27
   /rdy7km88ki6K+DRXDxF8E2ucrzwIFTXAhfB8eQzpVZBV3XOO7UA6NI20
   GICZppdjTSlJcr6Gs0OPL7v8vNr9R0Qh1MoQOCNhC9JaqALkUAQXYDNDE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="449411358"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="449411358"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="928484833"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="928484833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 09:48:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:48:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:48:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 09:48:42 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 09:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io2+U9MBJ7IRCkSKMIQ08yjbbIY3+/0abKfh8jcdFP1iwacnChXn7R6us1sMGZ3foQjIDyjO0C6cDlalgvaodxOWD9j0Jlzi5d0VceYr7idrqoc6eSFoBzUMH0xlQxn7j/sCMI1YJaiuK91sVL5L4FzS830JqMo7hlKFb0UUVQAP3vDJxuNNc9C69Yp5VZPy3nUPzKctNHL0Hf0pV9q3bsbS1pJgLmPPHHBm5HfV7lkf4dzumQdxtILoDmrKETT7FWqNYk5RA3gtIu3whGqePUaCFHA6eINxaAHMN2kakP4wSnY5loYk6sRe1c0OzXcT2JWV7TEaLIk7rK5xBL/PiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKBZcX/N/N84jx/2iPFzMXi07dLTQ0KO1vJLvabS2+Q=;
 b=dPm1qwg2xGBVuTAVM8XPopvzKP0MlXrXz+epHxTY/Jgnt7CHbwnssRRR6aTEvsQLJxnU8Gl1t9FX3AjMNhICNZggovGDheE0XVL4mNYuhgh3m85QkgHd5GUJx/ScaqwWz5ispv5+fjWArFi9cIpkAh6fx8OdIYinN7i5GjU03SIGBPlXMyix6mW70t/6xOBP7gJvealjE3i5NKDACN5+oVlkg5TOywYNnU+PWHMnFrDWf7z+LIoIQsQ7w41R0dAry51eE/CGep9kwLnjtZTIH0jkYzahV8Ov/v+Ttun5LQp1V6zxRPizt9wmETeqimGjDnK0CXDQNi6jvmkNpV1wMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 16:48:36 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Fri, 13 Oct 2023
 16:48:36 +0000
Message-ID: <aacbc76d-0111-4d21-9dec-4aa025365f06@intel.com>
Date: Fri, 13 Oct 2023 09:48:33 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 3/3] cxl/region: Use calc_interleave_pos() with
 autodiscovered regions
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>
References: <cover.1696550786.git.alison.schofield@intel.com>
 <aa43b687f652cdb648dfba967dae9c1fecef3155.1696550786.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aa43b687f652cdb648dfba967dae9c1fecef3155.1696550786.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:a03:114::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1fd260-d508-4e3a-7abc-08dbcc0c3e9a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQKjEaeH9YdQ5utkuxI9npguQv+UpPqX+dd9vzMXoBgvKR+5lB9y0JLNQJpSE1rwNPfHzrm0RzccYFtXOWuNKW5uyoxkCYK3XY36JzhemWt4Kb7YljogcAAXZjkDvRfCRqb97iDbjQvxWn8cnHJmDs0T6MccAB/misrFV4+2cMRYIaFvtzdAy0pWNPYK2PDzEfpc0Yqbzl4pqVhMD0U4ioOGxpc5Erm7j/3Aaxy5cGJut5VISyQjSYIxtYlEHJzBhOGkq5+dQvo5/MLZNp8fPROV+rTcTBnVVmCNiHhWFS/7gJdJKS6OPa4pznqVzb6DH0ZlAgRMGANgfTWp7ptYlhHucXbzCoIeviFCeYGFrQlgejx/7OMXMKAqE42ADfZhDT02qmq1OHkdBTMMsCu2Ksk76gm5T1b3CGyfdjhvAUMEQ1YkZ5Z4JcAsr930u0OqR62TIgzcGWCqgLT/LbMuJ1SVvAOWxIAAaYxRgduW0gBZmu6RmB6FhTupXtiU8T0iC/8J05nvKPTERHDR+KVun6sQEMz8LPcP7nILuNH1DjBmf1465t66Se7ugcfB/hKSo7I8J0YRmuLFcCOkqi6+MrFSLQSZRfkZA6Eqh6NFQX2hxxVIcws3YhcVafjd+/Xs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(31686004)(6486002)(6666004)(38100700002)(107886003)(316002)(110136005)(66946007)(6636002)(2616005)(66556008)(66476007)(41300700001)(4326008)(8676002)(8936002)(6506007)(53546011)(478600001)(6512007)(5660300002)(83380400001)(44832011)(2906002)(31696002)(82960400001)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkFWaE56SVI0dDB3c0Z3R25ncm5PUXYrRWl0M2dtNXpsYVJ2cytFOVQwZGh5?=
 =?utf-8?B?c3liWkc4QXpWVkRRQlNyUjRWcWpJS3FKSHkxL0FmbGFVSTQrem5yZlVXWWNE?=
 =?utf-8?B?Q3oyY080STNpWFJnK2RXaE5xSEdMaW5wQ1p2c3JHeXI0ZXlrVUovTm5KdU5j?=
 =?utf-8?B?a0VMbFd5b3hPcDFodlJsd29yemJPYmFyME9hbFF6Wk9LL0FXMTRGSUR4RElm?=
 =?utf-8?B?M2s4Vm5BbzExTGkvZUpPb1FJMmpzZFd3c0dmWndEN3cwTUVHTDdPRU1PRzAx?=
 =?utf-8?B?TlNLS21ycnNlL3RTRnRFU3hCOXA4SjM3ak90by81TE9BWit2Z0svYWw3L2RS?=
 =?utf-8?B?QUdKczNXZ2hWcWo5UlpxeHJ2SFFwM3FKRDh0MUI1SGJTaHFHLytVUjhEeFU5?=
 =?utf-8?B?by9rWDNVcmZTdmFta0JWc0hHWmJxaDFmQlU2cFhadHFGdlFvUDZCSUVqTE51?=
 =?utf-8?B?enY4TDFjQ1BSSS9LTEljTitCdnZGcDEwSmJwRDhZWGcxdnFoWGhOUnNqZW8v?=
 =?utf-8?B?cVA1NXBZNWI1U0xHN1l0Zlp2d0dVS0dWd1hhcURDdTZqeUtVekpKMThKczd6?=
 =?utf-8?B?WFY5Q2NZNk5obzI3ckhQSWwzZmRSN1ZFanNKYkc2d3pCekJ4TTM1bW1GMGNu?=
 =?utf-8?B?ZkY5TlF5c0M5TElzZFVTTzdXQ3ZGL2dJMEJPa1pTQVJEeElXbWFvZFRzUnlB?=
 =?utf-8?B?YjVJbU0wSjhaTi8zNFFIV1poVmRGclhDQmdsRmdIWXpHcUFRbmp6S0U4ejBG?=
 =?utf-8?B?aWlIdXByWmFleWl5cjM1dlRrUW9FOHhSY1ZBeUVjeWtvMk5TdWtMTHZTVEp5?=
 =?utf-8?B?REV0WjNobUdqK1VPaWVPRGFJK3NNWGJ4VmhpOFVVSFJFOFVrMjQ1M0lVS0Ni?=
 =?utf-8?B?VStCV1RTS3dQQUk1VGxwbVU5NWxwdUNqVi9DNFQ3YThCanVoNHRaajVNWklW?=
 =?utf-8?B?MFV0SlpRRXBua2N5dEk1LzNHQ0p2N2xaT2p1SXVxaXFrMmMvZWljUXZLVkg5?=
 =?utf-8?B?akltaGtIbVVZUnhrSzZlLzB0OW9wTzRhVFFWQjlqNmdiVzBlVThNeFZYanVU?=
 =?utf-8?B?d0xwaTRiS2EvdXdUMW1CV1JxQlVCK0g4SWp0WkxYcjlndmdvVEJtWlRRNXdt?=
 =?utf-8?B?UzBCMXBnZk95ZUFUaXU0NkdVMWN5anhCRUpMdWNjN1Bka1ZLZlNlOWFXdzlw?=
 =?utf-8?B?M0I2eWRVTy9ET04zVFcxdWJkMnV4cDkwemVHVXJoaWhMbXV3T0NBRlpVWC9V?=
 =?utf-8?B?aitJZk93cndDbVNqTjlEV3NJR3d0b09CUXJ2dW5kN1pSdHJYQ21yOWI4ZEg2?=
 =?utf-8?B?Q0dIMHlMRTdCTnB3dkY1WnEvcDRNU1JDRmNYUTdmeStqZzVUNTJvaEIvQk9W?=
 =?utf-8?B?Zzk2RldEL2x0enpYbC83RDBKZ1dPL2U4V1d1YkFwWGVabUdlOFBPNndya1Rz?=
 =?utf-8?B?RStiK00xWGZ6K2E4T0o3Y2t6blkwMGZFckpucUdLMFdCdnU0eWFpb2E5TVdl?=
 =?utf-8?B?M2xiWDlVUE8wTnpVU0JwMkkzYndLOTFDNU9OSFpXS0FxdWJDUDE0RGt4QW1l?=
 =?utf-8?B?YmJXdXYyeVluemxFdFE4VUI1THM4dzZDRkhVb3NzTHQ3TDJ5WGU5NmFmOTRl?=
 =?utf-8?B?bkNSWlNWMUcxdit3c3o3K3MvUWhYRFBHZkhoWjM0ME1kQUVaQ1YwWDM4T0ZP?=
 =?utf-8?B?QzdTN0RDNlBxZjRNZXhqY0d3dDZxbHJDNmZ1UnBVRmJhNE9CTnVMTFFLYXlq?=
 =?utf-8?B?R3c1aURVOWg3Y3Y0ZVo4MzFQTHVtbUlkcWVrUHhmb0k5K1R3K29ueHhaeWpS?=
 =?utf-8?B?OUcwOHlwNXJESDRidDBpYkMwaWU0cUwzMW04ZmF2R0I1enNidGJEMDRrZnRy?=
 =?utf-8?B?RGlnQnZVTVMwaUZ6dEdRcnJJYUFmdzcvMExmQXB1RUdST3VoRE9hazg1YnU5?=
 =?utf-8?B?dkg5cVM0dXlKMlE0a3AvNlBHSEVCTThCbDFpRG9kTHFHeTd4ZkdaRm96RTJq?=
 =?utf-8?B?dHpNeldvMk5lTFI3RUlCMHVDMmVqdURFZ0dYVzJRamFxTmVaek5VS2hweDhn?=
 =?utf-8?B?cWlzUUhqcVMyM0QyMmNhSGZobHo0NXhCNHFQQUZOMlAxc1JMemcvNGpsRy9p?=
 =?utf-8?Q?XYChPIDE1FpTd5fFM3+ngIx/0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1fd260-d508-4e3a-7abc-08dbcc0c3e9a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:48:36.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFxZziOHT6hBYYLDlyQndAYBaeI9rwMlpwwGRPoA8VNmVYGZD+Ef2o7n021LSSdqb1wKlXPguQeQoec9TVAQig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/5/23 17:43, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> For auto-discovered regions, the driver must assign each target to
> the correct position in the region interleave set.
> 
> cxl_region_sort_targets() uses the kernel sort() function to put the
> targets in relative order. Once the relative ordering is complete,
> positions are assigned based on each targets index in that sorted list.
> 
> The sort() compare function does not consider the child offset into a
> parent port. The sort put all targets of one port ahead of another
> port when an interleave was expected, causing the region assembly to
> fail.
> 
> Replace the relative sort, with calc_interleave_pos() on each target
> in the region target list. That will find the exact position for each
> target based on a walk up the ancestral tree from endpoint to root
> decoder.
> 
> calc_interleave_pos() was introduced in a prior patch, so the work
> here is to use in cxl_region_sort_targets().
> 
> Cleanup the obsolete helper functions from the prior sort().
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 127 +++++---------------------------------
>  1 file changed, 15 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 297b9132d5b3..5a4a70ceb4ce 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1480,6 +1480,14 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +static int cmp_interleave_pos(const void *a, const void *b)
> +{
> +	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
> +	struct cxl_endpoint_decoder *cxled_b = *(typeof(cxled_b) *)b;
> +
> +	return cxled_a->pos - cxled_b->pos;
> +}
> +
>  static struct cxl_port *next_port(struct cxl_port *port)
>  {
>  	if (!port->parent_dport)
> @@ -1587,131 +1595,26 @@ static int calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  	return pos;
>  }
>  
> -static void find_positions(const struct cxl_switch_decoder *cxlsd,
> -			   const struct cxl_port *iter_a,
> -			   const struct cxl_port *iter_b, int *a_pos,
> -			   int *b_pos)
> -{
> -	int i;
> -
> -	for (i = 0, *a_pos = -1, *b_pos = -1; i < cxlsd->nr_targets; i++) {
> -		if (cxlsd->target[i] == iter_a->parent_dport)
> -			*a_pos = i;
> -		else if (cxlsd->target[i] == iter_b->parent_dport)
> -			*b_pos = i;
> -		if (*a_pos >= 0 && *b_pos >= 0)
> -			break;
> -	}
> -}
> -
> -static int cmp_decode_pos(const void *a, const void *b)
> -{
> -	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
> -	struct cxl_endpoint_decoder *cxled_b = *(typeof(cxled_b) *)b;
> -	struct cxl_memdev *cxlmd_a = cxled_to_memdev(cxled_a);
> -	struct cxl_memdev *cxlmd_b = cxled_to_memdev(cxled_b);
> -	struct cxl_port *port_a = cxled_to_port(cxled_a);
> -	struct cxl_port *port_b = cxled_to_port(cxled_b);
> -	struct cxl_port *iter_a, *iter_b, *port = NULL;
> -	struct cxl_switch_decoder *cxlsd;
> -	struct device *dev;
> -	int a_pos, b_pos;
> -	unsigned int seq;
> -
> -	/* Exit early if any prior sorting failed */
> -	if (cxled_a->pos < 0 || cxled_b->pos < 0)
> -		return 0;
> -
> -	/*
> -	 * Walk up the hierarchy to find a shared port, find the decoder that
> -	 * maps the range, compare the relative position of those dport
> -	 * mappings.
> -	 */
> -	for (iter_a = port_a; iter_a; iter_a = next_port(iter_a)) {
> -		struct cxl_port *next_a, *next_b;
> -
> -		next_a = next_port(iter_a);
> -		if (!next_a)
> -			break;
> -
> -		for (iter_b = port_b; iter_b; iter_b = next_port(iter_b)) {
> -			next_b = next_port(iter_b);
> -			if (next_a != next_b)
> -				continue;
> -			port = next_a;
> -			break;
> -		}
> -
> -		if (port)
> -			break;
> -	}
> -
> -	if (!port) {
> -		dev_err(cxlmd_a->dev.parent,
> -			"failed to find shared port with %s\n",
> -			dev_name(cxlmd_b->dev.parent));
> -		goto err;
> -	}
> -
> -	dev = device_find_child(&port->dev, &cxled_a->cxld.hpa_range,
> -				match_switch_decoder_by_range);
> -	if (!dev) {
> -		struct range *range = &cxled_a->cxld.hpa_range;
> -
> -		dev_err(port->uport_dev,
> -			"failed to find decoder that maps %#llx-%#llx\n",
> -			range->start, range->end);
> -		goto err;
> -	}
> -
> -	cxlsd = to_cxl_switch_decoder(dev);
> -	do {
> -		seq = read_seqbegin(&cxlsd->target_lock);
> -		find_positions(cxlsd, iter_a, iter_b, &a_pos, &b_pos);
> -	} while (read_seqretry(&cxlsd->target_lock, seq));
> -
> -	put_device(dev);
> -
> -	if (a_pos < 0 || b_pos < 0) {
> -		dev_err(port->uport_dev,
> -			"failed to find shared decoder for %s and %s\n",
> -			dev_name(cxlmd_a->dev.parent),
> -			dev_name(cxlmd_b->dev.parent));
> -		goto err;
> -	}
> -
> -	dev_dbg(port->uport_dev, "%s comes %s %s\n",
> -		dev_name(cxlmd_a->dev.parent),
> -		a_pos - b_pos < 0 ? "before" : "after",
> -		dev_name(cxlmd_b->dev.parent));
> -
> -	return a_pos - b_pos;
> -err:
> -	cxled_a->pos = -1;
> -	return 0;
> -}
> -
>  static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	int i, rc = 0;
>  
> -	sort(p->targets, p->nr_targets, sizeof(p->targets[0]), cmp_decode_pos,
> -	     NULL);
> -
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> +		cxled->pos = calc_interleave_pos(cxled, p->interleave_ways);
>  		/*
> -		 * Record that sorting failed, but still continue to restore
> -		 * cxled->pos with its ->targets[] position so that follow-on
> -		 * code paths can reliably do p->targets[cxled->pos] to
> -		 * self-reference their entry.
> +		 * Record that sorting failed, but still continue to calc
> +		 * cxled->pos so that follow-on code paths can reliably
> +		 * do p->targets[cxled->pos] to self-reference their entry.
>  		 */
>  		if (cxled->pos < 0)
>  			rc = -ENXIO;
> -		cxled->pos = i;
>  	}
> +	/* Keep the cxlr target list in interleave position order */
> +	sort(p->targets, p->nr_targets, sizeof(p->targets[0]),
> +	     cmp_interleave_pos, NULL);
>  
>  	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
>  	return rc;
