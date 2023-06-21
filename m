Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EECEB64D7
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Jun 2023 00:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjFUAHA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 20:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFUAG7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 20:06:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312241BC
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 17:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687306017; x=1718842017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CG74mUX22U2UyNDpdLMK64gasGzYxEb7zAdo88UpBaI=;
  b=aOb7SzPsGdy84L31GBYBc6PaH1M0XV2NvidZabjPm9B8t9UFuDn3/nT0
   Jz/psWohNFnHd9vEKSMnbHZQYZtmam8O+IbEwbTmuzqA6TnZmeMTqgL5S
   Qu6u3tTOUv8jc4pN4fe6fa1O0uPgIL9vIQcsRvbDCfH5mGpl1nvNwr49E
   Osr4KGzKobLgILOwwMrvnAhkK2uzkqoBAEHiZRGtCbgy9oea7raVSt9zc
   EhaEj7elh8aygE15UJwMahxRbFxcQJ3YYYT0u0j40NsMc1Ov8Rtg3cYwg
   s50qPUdz6ZLVQA7G6UGj0h2REiYvIiydXjkkBOJ5Sp5zxqDxIpophfQNo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357511836"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="357511836"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 17:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="960968813"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="960968813"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jun 2023 17:06:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 17:06:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 17:06:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 17:06:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 17:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrYNbMrJfpo+BOuNTwnrtlOmWSLkJfrwmC9ifJUZFU8+8A0wHGWLQr+Jgx0aQt6dRALSPRgNFXWywARowclXl741cd3ErKplyiHblWsw8/ohMceekV3z3pqPp4bP5T+ncC3bs7NRqUpLoWExrElmyJEYhZv3Q5ALvh1eU4b6SRefspZCkyVV0lpDwRq/a/+vRMROtHn5PcMrlTVmozP66Nok70Y6Nm7+2Ke4omNVd6qzUxOGLLxGzfNFD7gNSpovv1rdPr9bWhVoi392VvorrtUasIwb+bKnGaHP9OKOiy6s/vrsW1Jvv0GV83GxcuFZKx2RCN/2MCLajaOsMJFstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR0I+WaDJC+kusKTTGu4lL4aPYJHINTs3af30KOkWXs=;
 b=R1/9J1Djo+NkbaDnHhDwFMb18g+hicy2DiISxSwlYjGEagrBK9dcazEDXtNNk8qfZ4KxcqpkCgEl7vJhXKBa7OWdt59uwLQU4yhIOjKL5H3yhJfiPh+vppdEmqrZqdtc2pNGDuzDkqaO8RFFt6AcEeRkMI2eoxhUKc7K/4o9gnvwJBkYhViND7RmWoIl5Zor3TcuvWXQX+aD0XX1EFNsc6hP/qyi7IkfZt9dWKySyC+q5pKQnxZWWl20cEAqCH6Y7EgW2GY1f9uTmyTKJNSCq2wgUdcJ6wcIJxc5KvvqjqlsOe5KjP5DICjcXD2BKBkr9aEOl8un45eYgfOAqqnu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 00:06:53 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 00:06:53 +0000
Message-ID: <e4f8ca3d-9950-a541-4e51-4a55ab4a7742@intel.com>
Date:   Tue, 20 Jun 2023 17:06:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 3/3] cxl/region: Fix state transitions after reset failure
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
 <168696507968.3590522.14484000711718573626.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168696507968.3590522.14484000711718573626.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b87ca8-d098-4e65-cda2-08db71eb6b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9pXSKbN50ZG06ZkZjwYPjSYTq0gxyOlrcs3LwDUEGX5QHr3X7ueDv3yrowa0iXZqndx4Cb8tQ01exz9bg8ewuA1Ni8zWBx92Pie5ujvyc7fIiF0ef9F8ZhHgQuS9BLmuQh0IBvhqPLZ48I+zg6ueyWh9wBZvFZkzpjSv8wtU1JMaaz69ilRCjBell9lCnQgnauyfPA/oRNGb671/r7KyRBEDNYcZ6GfWDJsdczZ2xNkPmLs6dGSM+CoEvqXx5IoaC3H/SFBs2ysPrB76sBAtJi6zw7XA8wo9Sdh1aCgl9waHwHGagF4I5G6t/zlA3cjKZy5AMXi6g6V9gDc6zDUS9cpQk2yohM6XZ+JWh5Q0rcoe4FZZC62tWVaCo3gf+w+z5V6Kc6zGzAfCp0Q2NHl7CAbDyIkz+HrU7Tg6O3RmMXwBy2Lz+xEzQAI/ofBebAFzwAR1UlJWCK62AvObWHbSEE3XUIv86jjfYvcaDPT0059cmgWHM/6mHDvaDTaHeaTxzaP9QM9WQBuJUNGKQviKCybXRUhuI1ibAcJPnUZ0DjxKkyzLPEz4iPnZ7Q0NDuZCjJdhBllC9ESfU1AE0/7dTOVyvF484rO5cfzlKpY9CJ7zTR3hQF0FU424iNHSrC1Htu9RwNriDr3A/o0sADbiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(8936002)(8676002)(5660300002)(44832011)(31686004)(4326008)(66556008)(66476007)(66946007)(316002)(41300700001)(2906002)(6486002)(966005)(478600001)(53546011)(6506007)(26005)(6512007)(186003)(36756003)(83380400001)(38100700002)(82960400001)(86362001)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9XN1Jmc0xMbnlCZG1RYkZlNk5rTzJGOVppY25JZzA0YkZZR2ltNHliQXNq?=
 =?utf-8?B?WHVPT1RXNHJxR2VUMWJZclRUYlRKbEl3bnk3YjZKUVZnOUJyWFMwcUdvMTE0?=
 =?utf-8?B?dHd1Q0F1WWdoOEcvd054YkZoNlNOUVRObytBN3RBWnJJZVV6NHNRcGtweHVt?=
 =?utf-8?B?b00rUldwVHRsRFFBcTNCalVJYUtsbzQzN1dpdkFuL2hMc2EzZkgxUS96U3My?=
 =?utf-8?B?UXZWbHdDb1ZXVlFsNEtBVkhBMmVHdGlRNXc4U1hpN1QzMXpDZ2dzUU5mUVMz?=
 =?utf-8?B?RGFDdFVka2RURjJtcGJhUnFtTWgwN2xGTWhVYjlUbHozZUg2WTVkcnE1QTY3?=
 =?utf-8?B?RFVsODBZbGVnenk1ZHJ1OVBDdG81NjUzT3pDa3NlTGlzOU5XaDFZZndFMEFG?=
 =?utf-8?B?RElEd3VXYytweGcxTm1ZSjRhUzNOa3QrTnRieExNTk9pMWZFZzd1R0Rob1BT?=
 =?utf-8?B?enpjWDIwL2hsYnJ0QmJJYlJ3anhEdis5Mkx4dndmaWdTSFM1cXM3c3luOFdj?=
 =?utf-8?B?S3pXYk1iTGFXTUJzY2JDZGt5elZkaGdHdFpyeUl0RHFmZW5UWS9LY3o2TFY0?=
 =?utf-8?B?SUw0dlRydzZMVmpyNDBNNy9ZeTNmZjk0Y04wNmhVeGhNQXBRSFJ0MFJrUFRs?=
 =?utf-8?B?dXNvWU9NT2phZVZUMDBtUU1NOE1Jb1VUS1ArTnpnSDlYY2JMY0dyTDhnbHZM?=
 =?utf-8?B?MC9kZUh1dWUyVlYwRFlvNnkyRkxWRnl2bzNocFVNUm9tM2wvc1hERmJic2JG?=
 =?utf-8?B?am1lSjJ0UVZWSkxzZVppdGFXcjYrUlpRc1lJalZ4TU81VmdaK1RZejFKa2hR?=
 =?utf-8?B?Yk5rbnlJUmo2TUtWMUliTE9BSWpkeDR6SGVzMThHMjNNMkNJNmtHTDJld0Rw?=
 =?utf-8?B?Zi9KUG9EcGtjWVdxbVdMT2Qrcnk1WWJtTzd4OVdZMyt4TUh3TnpVeEVUWXBK?=
 =?utf-8?B?SC9zT21pZkNhSm1oTmZweWViRFc0R1JoMERmd3VnY1RCL2RkNDFVNEtxRytB?=
 =?utf-8?B?cHFERWxNNnBvc3JnRnAyYldWVEV1eDNFZDArSTJYVHg0Ym4vZDhkSHJPclRr?=
 =?utf-8?B?Y3YzTGYxQUJvb2diQXRlcnF6OUNOWFAxSGE3OHczeEhETXI3RE00OUdEMG5a?=
 =?utf-8?B?dUZPZ0Y0dnNNa3M3SDFKMmpweUJYMDBoU2ZTR0dBeXVCY2NYTTl2b0NHT1JT?=
 =?utf-8?B?bjd5SDhPVHoweUlrNjc2RmdYSzRrOFpkUXBxbllCWk1pTGtKVTBnWXU1Wkg4?=
 =?utf-8?B?bjZXa1UxYk14T2Vxend3TzZBNHkyTWdNVmwxcWI1YUxaUk81UmlQbjZCUWg3?=
 =?utf-8?B?RndRM24xRDBzaHpQcDJlQjYrSSt0NHY4UHRwM2ozWTlkM09vU3o4b0Ezazdk?=
 =?utf-8?B?cXMzS2JUVU13T1V3MnV0cjhPN1Q5V1JwNTNCYXlmY2kvUThMakptM1I0WXZz?=
 =?utf-8?B?UjdEc3Z0ejY5ejB1S1B3d0lZT0poWXhsMGZBSHRoellOS3RHWVZsZVg0Z28y?=
 =?utf-8?B?SGVpdnJZc3FIc0duRjBlMVA2RGhwSlhST29ZOHlnTkNnZ2JaN2Z4Y0RoSlM5?=
 =?utf-8?B?U2pJOHlDQWR3Sm9sQkJGbFM4b2ZtK3k2RjlZTzY4eVU2ODBOcFhyQmwrVlRQ?=
 =?utf-8?B?Nnkwbzd2bHdIWUhBVnJjQ3BtcHUwRG9LREs4UnJ6TlhCQkU4VWFvRTJSSzdm?=
 =?utf-8?B?T2RCek1CNGJqVTJqQzFKOFpOdzlZUllsK21ZSlE1Rkd4SHAxdWd0RzNjRTNv?=
 =?utf-8?B?SWswMXNib1lrNmdQVVc3WmpaUXVmWDRtbndIbzJzanRZU3hSWlg3Wkc4TEpZ?=
 =?utf-8?B?dDE5aUZROE9DNTVhWjFxanB3b3BRaUIxUk1OT1NkMGxPZ1NpRWJqMzhzR1BD?=
 =?utf-8?B?SFR6RmxXT1hUT01RR0t6aFlsWEhaZWZKY1RpV1hlZ1NPTGdRbUxFWTRpQnh4?=
 =?utf-8?B?amFtTWpPTVhSN2djUHhISytzcEdTMXB0WTU2UURwVWtwTDdXVTAyd2tXZnQ1?=
 =?utf-8?B?TkxNWnhGMEc0L09YOW5OOHkrMlFWaEFPVnV2Y1BqRDlSV3hBRS9Kc2NNUTkv?=
 =?utf-8?B?R2NZSFEwSDAzY2pXelZNbXBIQUZqZ2JFSGJHY28zL0VneGpocmY3ZkRvcDBJ?=
 =?utf-8?B?K3E2TlhsM1I1VGMveG1qL0EwRGpQbm1zSG5IYlhIekRnNGRXQlZEYWNOOXNr?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b87ca8-d098-4e65-cda2-08db71eb6b29
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 00:06:53.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaaYewVjxSH7SxF9KFJ/ZCGl9mtTWHdad76qiT7PCt/6FhCprlG2tFxz37/ubIjO+x4R2UBW9Ge0nxBvWmZwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7563
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/16/23 18:24, Dan Williams wrote:
> Jonathan reports that failed attempts to reset a region (teardown its
> HDM decoder configuration) mistakenly advance the state of the region
> to "not committed". Revert to the previous state of the region on reset
> failure so that the reset can be re-attempted.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c |   26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 31f498f0fb3a..38db377e13f1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -296,9 +296,11 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>   	if (rc)
>   		return rc;
>   
> -	if (commit)
> +	if (commit) {
>   		rc = cxl_region_decode_commit(cxlr);
> -	else {
> +		if (rc == 0)
> +			p->state = CXL_CONFIG_COMMIT;
> +	} else {
>   		p->state = CXL_CONFIG_RESET_PENDING;
>   		up_write(&cxl_region_rwsem);
>   		device_release_driver(&cxlr->dev);
> @@ -308,18 +310,20 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>   		 * The lock was dropped, so need to revalidate that the reset is
>   		 * still pending.
>   		 */
> -		if (p->state == CXL_CONFIG_RESET_PENDING)
> +		if (p->state == CXL_CONFIG_RESET_PENDING) {
>   			rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
> +			/*
> +			 * Revert to committed since there may still be active
> +			 * decoders associated with this region, or move forward
> +			 * to active to mark the reset successful
> +			 */
> +			if (rc)
> +				p->state = CXL_CONFIG_COMMIT;
> +			else
> +				p->state = CXL_CONFIG_ACTIVE;
> +		}
>   	}
>   
> -	if (rc)
> -		goto out;
> -
> -	if (commit)
> -		p->state = CXL_CONFIG_COMMIT;
> -	else if (p->state == CXL_CONFIG_RESET_PENDING)
> -		p->state = CXL_CONFIG_ACTIVE;
> -
>   out:
>   	up_write(&cxl_region_rwsem);
>   
> 
