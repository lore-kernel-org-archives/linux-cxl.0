Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55201D68F
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6j5SDt/"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A48EA9
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 16:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697153737; x=1728689737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVZvw0tEDsZXmxb1feizOxnDInOHxuZSQUQNFsFqnJU=;
  b=Z6j5SDt/x87+oytM2NlFgWBND156k7dUaOfMvPeCVGyiSVGNY34ajHrp
   8uttDphyfIiXVrBiMQp0ZCoo/NzYFMW9O59RiD+/P79bX9g2rPGpXEYBc
   QT/gUJ8pzSuI+8SSgH0lWPSVoczVgntmpdx7wwWhgUWnfXkb3u0iADy3r
   1HJ73xZG7Wx8IkEHwgjztoSrcrinU+K9ZxwqQ3O754APC3EfyytIBTB/W
   cVaJCYzdvSX5UVKwPn8LoIti8il3yo1Ozrkdeww5WOCOm763gL4JLI9Yf
   OFpNWjtrpbzNLlE05M70gxYDWmGUXCVsclGTXn4gRr6Wjn4gZ0Gnz+Rxp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365324350"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365324350"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 16:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="731112946"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="731112946"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 16:35:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 16:35:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 16:35:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 16:35:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEBFYxdss9gOOOWqrRm+gi/iPDs1x30Svm/eKrUb9PU5hTuNLmtRBzwI2xPsOgALBphA+vcItW7JfcdIfwmM3QKBUDaCmr+ky5jLUC4nmsYpOQnT4yKUcMsQWkNR6dkvYPsxkjzv+mTfk1oiY4dTro6+ywYQorbfj2QkirhCRbx31O7sBBkifwv+83I/g8kYooTG3yvJaePW/Xf3MtRLXsgeUrT1qT9EZ7txn15DlXT0WiZHGXyeJtFeKuE6f+1pdUQzi32GOIxwkC2cYpW+2Gm+NhXLLO5sbqE2VWhJqJQcz47PbV2pk0+T8leaqiFnuDaLmvPc3YR7KY6xuZNOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY8wQ5zGhZuO9qMOY+pPRgRMTV9JWZvDG1Iz1baW0cE=;
 b=NKoQZH+rcgcZzmwqMRJhyotl1A15Xada3a0cEGX2YVu/hd8/Efk2GnFHkxWLeMDJ+EEHNMhIXTAqmucIvSfCIwTumiJViktnrODxD/S8/6CfNjpsl9fbF78J7/2ZbDrpItedMXbWpaIrWQFl+rRchmtLvgolNPLebFD9rXyva8SG0y2r83t1+G+RSw0NKosmIVfdqykP4E0KiZycRez8nwcoQCdxe8bGDXFhyMXwo5LFNttIaoMP1IQYzHiMLUY1WZMG4AvgAs4pMlmPVOFUZWeV+YS1d78lCpyjmUhRZDcuuC7qTblJaD5knJEb0wNm0MJV2d0Ve3bNZl4CxGCjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6924.namprd11.prod.outlook.com (2603:10b6:806:2ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 23:35:34 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Thu, 12 Oct 2023
 23:35:34 +0000
Message-ID: <f15bbd8e-c3b5-4ce5-be76-4ee9ca66029b@intel.com>
Date: Thu, 12 Oct 2023 16:35:31 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/3] cxl/region: Prepare the decoder match range helper
 for reuse
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>
References: <cover.1696550786.git.alison.schofield@intel.com>
 <79f1fb5c1756289d1ee02bd6581548aba0718b98.1696550786.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <79f1fb5c1756289d1ee02bd6581548aba0718b98.1696550786.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 5caa0273-adbb-4b52-5f07-08dbcb7bee0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42yFW4HAp8gz7c1p2GGMMt/3+RRuaFoCl0cMLg9Q9dGtCax4zSFlDhDHbqlvJzeV+xkTSB2s0qwHBoZT9583456p7+UecvN36j5XIeN0sMmvHBS8BuSXk7RInhOKHjlQ5A30T+uovzBxYH+xirp9Zn5RDcOT+BbaNrQS7sMsHOp+HR2vNvLq5xJ+l8UYhXALU5TRfjccegNgfPsJqh8Y33NxmtNaeqwameFTgC8Aq6+MFz6xMPEeSBn3Rl8Q486hvUtzbX4atFxpNDu22wNc0nAkdvCJb9qcqeDOx7x6+GvC3wFDPEPTyexLvB9YVjvxELxdDD2IOnhYF5E/j3RKtOf+f6yYluhhF3SjieyE81onnrq8PmlQnuikv/1vBNWYYwmLGUm7HT+H9pdcQQ/qg8lr4HAEVTy2A+eJIZq9noTwvwo2RltyZ6AwLmkQmS3BuFE0mUhPFv97gxjALXTEwA7+DpFI2C/+Ld4V7qVuu3PCLxkzkPuKkYl2ULUEE5xuLM9GjiYOBZciBSVD0qLC4txbVPSacRz56MrhkjDVPZ5IhFWCbNbghMp+g/c1AUD1t/YQSUaauLDrNuSgkVqRRguVTG9BMK1D/xcsAwQwmM7LcUj8mmjRVAGIR6BCG8Ba
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6636002)(2906002)(316002)(41300700001)(5660300002)(44832011)(8676002)(4326008)(8936002)(31696002)(36756003)(86362001)(83380400001)(107886003)(2616005)(26005)(82960400001)(6512007)(31686004)(6486002)(478600001)(66476007)(66556008)(66946007)(110136005)(53546011)(6666004)(6506007)(38100700002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnFlMG9zVm9sRy9XbGZsT0owU3ZKZWlOM3RFeHNPWW0zRUlKSWNVT0pXaDBv?=
 =?utf-8?B?UE03c05OTlU0emZpeFZjR0g1UDVzeGpOV2M2SlBERDBlZzQ5UlQzQ3ducFFr?=
 =?utf-8?B?V1F3TUxTV2hTZFdmNUdqeXBua0dmbjIycEdyeHpBNHdkc0thbzg0Tmt4THRo?=
 =?utf-8?B?T0VjTVBLNTJxT2NwNXRQc1dKSWI0WWhOakFqVm85T3QwUlhqN0hiQXkxWkhH?=
 =?utf-8?B?bURjQlVkb3JEb2Z6Z1JZQmh2QnNxaHRSWkFCN0hqTjJDOE5TNGNlQUVUYTVi?=
 =?utf-8?B?Lzl0RVBmVDlzYVJETDYvWUJ4OXgxOGpHZFRLMzI1VThSUmYyUHNROXJKaWdm?=
 =?utf-8?B?S0FERDIxLyswZlJSYlF5dFFpb09FakhsSE1uN2wzbFdxcHhoK1lQTW0yVG1x?=
 =?utf-8?B?dmpSQjZJMkJQMFB3elR2dXVxT09lNVBBbk8wTEdtaGRLeng5Q0FMN1lzQlZi?=
 =?utf-8?B?c0ZJWkcwTHdQazB3R2owZ1JSZmoybU1OWWV2Um1nR3d5WkJJNUE3U09za3Z2?=
 =?utf-8?B?M0NDRHBPZjFWOXk0KzZCTEFKd2RwVGNpOGxZVS9sNHJ2ZWdMejg2STRjV3pY?=
 =?utf-8?B?VlR4cDM2NzZuS1M0Sm9SR3NHVU5MakNaa0tXSVdwZ0Q1MllFd3dRbzlXaEJ3?=
 =?utf-8?B?U3RmVlpoRGVLQ05kMzdNNC9OL2JybStnLzdPRGZsYll4UzJhK1h0Z1Jqb3Zt?=
 =?utf-8?B?dklEaEl2ZDVEUVdZNi9VODBWNElBZE44QzlLTmxKR0FwU3VnanRNYkJxRHFC?=
 =?utf-8?B?enpPMlhMQzdaRWtsOVZYcW1PWTJSTXFwV0RnTW02dk9NVm9KU0E3bkRZRDJC?=
 =?utf-8?B?ZVBtdDNsV1BKeVZiWjU4UEJlanZTUFQyQUdwZUpiOHdhZUpGdUZHeUJVRHJy?=
 =?utf-8?B?c2ZFZkhsWTl1UENWdkMwVk94OHcxcG0wdWJpUzJ6dTdmR1o0cjY4NTlBTWpM?=
 =?utf-8?B?K0d3NjJsd2tPV3g5QTdxbHRCeGJiOWVidGRINWgxdzlWcG15dlRwYzAvK2xu?=
 =?utf-8?B?cldRNzFHMkp5QXNMM3hBcFFHOS9BZ3cySHVVT0VnNVdKbDJMcWFwbi9NdGda?=
 =?utf-8?B?eVovWjlGQWlma0VQUE93L2xPc1ZtUDZBRnBJay90ek0xcDZ1Q2NtMDM3djd2?=
 =?utf-8?B?MHVtOEZJNUw0bkRNajdqZHdaaENoUE9NZGd5ektJOUIrM3AvWnZIWkRDdlhB?=
 =?utf-8?B?c0g3M0xnZ3RXbHYyV0g1cllHdEJzeTU3MHhObEJIMU1YNExpYUhtWFplN3d5?=
 =?utf-8?B?YlcySDFjVi9MMGlMVGVka1paR1lBNHZySlp2MVBqekx6UkdLeU9ZY2hRdzdi?=
 =?utf-8?B?d1Z4Vjk2Y2ZmVDduK2NESnY5TkRqRlI1dUJKS3FHcC9FZUoyRzlBd3k2aXJr?=
 =?utf-8?B?OGhBckpKQXpQU2pJcVB2WjhJU3pRT0ZSaGhZTHBEQkFlZXh3N2xraUFrZkV5?=
 =?utf-8?B?b1dxcUk5K3lDRGVRdWRGb3VEU25SQmkxdVoyU1UvZGc5Q3hoTmxNd0dYZVdu?=
 =?utf-8?B?U09NZTlLbVhodFZtQTVhUjFRR05la2tHdnFmQ0xsM21GQ0d2d2h2azc5SzNI?=
 =?utf-8?B?L0UyODQ0N0VySGovNi9rNEU4c3gyWjJwdEtSNmZXdFVDTUlPQnBaRVVNTlJE?=
 =?utf-8?B?VnRzM3Nocnk0bzFQZlVoSXRWbUZOZmZxeHNyV05HUm93cTJKWDRnRC9xMDNF?=
 =?utf-8?B?OWl5b0p4a241MHNMZmZOMWcrNmJYdm9hRXlyK1pINklrL3BhMEhwTmQ4aWk0?=
 =?utf-8?B?Z08vQ2ZEZGpFTWxrRDFBZzVweXJlcFZueGhBMGRyYk85cDF0NTRhUHFGMDQw?=
 =?utf-8?B?ZS9GY2F1ZWpQUGVzby9HRGw4eUt3K2cvQnN3RUZacGtuM0F6M2JoQ0dZQndF?=
 =?utf-8?B?SUV0cjR4MFFrRVBrOHJzZlpUSXE0TVpzZmUvMEtSZVBOZWpmOVZ5VVBtRitN?=
 =?utf-8?B?aldzeFVvQzViS3l2ZlNITktDVitoeFRYcHorWnYxa0pXQmpCN21KT0dnTDhj?=
 =?utf-8?B?NklkdnlGQ2ZYUEpnNm5kN0ZvajNJNVFqTFcyRElaeGZTdUVuSEd6Ry95d28r?=
 =?utf-8?B?RFF0cFcvZEVPYzRoT2tSRnJrMVgzQVA3djdZb2FTdVE4QWZRRGx6eGdyWEJ6?=
 =?utf-8?Q?GRuANj2bm7FrhqjR0Y0ItJIxW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caa0273-adbb-4b52-5f07-08dbcb7bee0d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:35:34.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nC2TECuxVFqMADiN3Ju0UjSIfX9kmtZqxgOxHlWIxFWo6R1ad+5n2yfZiVi+l0D70UTbn27Hv7/ejPIwbC/Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6924
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/5/23 17:43, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> match_decoder_by_range() and decoder_match_range() both determine
> if an HPA range matches a decoder. The first does it for root
> decoders and the second one operates on switch decoders.
> 
> Tidy these up with clear naming and make the switch helper more
> like the root decoder helper in style and functionality. Make it
> take the actual range, rather than an endpoint decoder from which
> it extracts the range.
> 
> Aside from aethetics and maintainability, this is in preparation

s/aethetics/aesthetics/

> for reuse.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Those two function names are definitely very confusing. 

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..64206fc4d99b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1487,16 +1487,19 @@ static struct cxl_port *next_port(struct cxl_port *port)
>  	return port->parent_dport->port;
>  }
>  
> -static int decoder_match_range(struct device *dev, void *data)
> +static int match_switch_decoder_by_range(struct device *dev, void *data)
>  {
> -	struct cxl_endpoint_decoder *cxled = data;
> +	struct range *r1, *r2 = data;
>  	struct cxl_switch_decoder *cxlsd;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxlsd = to_cxl_switch_decoder(dev);
> -	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
> +	r1 = &cxlsd->cxld.hpa_range;
> +	return range_contains(r1, r2);
> +}
> +
>  }
>  
>  static void find_positions(const struct cxl_switch_decoder *cxlsd,
> @@ -1565,7 +1568,8 @@ static int cmp_decode_pos(const void *a, const void *b)
>  		goto err;
>  	}
>  
> -	dev = device_find_child(&port->dev, cxled_a, decoder_match_range);
> +	dev = device_find_child(&port->dev, &cxled_a->cxld.hpa_range,
> +				match_switch_decoder_by_range);
>  	if (!dev) {
>  		struct range *range = &cxled_a->cxld.hpa_range;
>  
> @@ -2696,7 +2700,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int match_decoder_by_range(struct device *dev, void *data)
> +static int match_root_decoder_by_range(struct device *dev, void *data)
>  {
>  	struct range *r1, *r2 = data;
>  	struct cxl_root_decoder *cxlrd;
> @@ -2827,7 +2831,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  	int rc;
>  
>  	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
> -				      match_decoder_by_range);
> +				      match_root_decoder_by_range);
>  	if (!cxlrd_dev) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
