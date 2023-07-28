Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A233EC001DF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jul 2023 18:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjG1SBd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jul 2023 14:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjG1SBb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jul 2023 14:01:31 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64119AF
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jul 2023 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690567290; x=1722103290;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VQduM0YeJv4MLaxZcXt8/vPFYA3B6t1F4OJp93WNCp0=;
  b=DXd/YDiPQffjgIS5ceoWVV6klIo6haG56V2YbXMM9/qL4QvmTeprzP0a
   qaznY4ztNVSCfuSBGrZuS+nF6SRMqfr5LxcC+7NPVJajEOr6ngtGvOXAV
   JbeTbJaCWNwqa01Niw7QWBRaZ3OGBhqXgtFtAxjI0un5/zGbXe84LbEAa
   4JDB1ZHB8FrWZiMBVtLzF5GiT96h6wyb5LLD17eMgppwl76YsvfXnPcNY
   KXmFXCvL4ZBhABr2V5umFfUQzRT4vnPexl+D/LdODw8tzwb+RMbNxyq8M
   Yr9w+iPAcFaBEi9/I1rroITsRDo319IBcYPC8tmTeacrJYmfRAxcktuTT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372278498"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="372278498"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 11:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870927451"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2023 11:01:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 11:01:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 11:01:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 11:01:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNPSGP1uPubPtriu1XOhCkAJUiiAuMaFnKwmfyJIbzbYxidcJXu5seryDae4SNrlebfWQh6ATflUg5YX05uV2FO+NbQcmMEUOcjYfkBJm1O377j2wBXELxF9XGTeePSh//VrBbuURx2BgxLllbvkT17HK1zE44epGKmhJhXld4bf3hmL2lugyzet4008cSo5jLu4uPAQ7E0r1kbYp9M2OlTNJEjVkzN5NQSMgE9CCbxkzVPth8zdcXP5OLlDawhkLAlqw9hVJEXpUfUdSPqqGNCVN4KoEZN/7q2idZ/4TjLjQ2zi1/9z5uzFaDWgQVJXcCjflBJCxoiu8gRKmaPWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypgENqXwr5Jwp+7KOvwcHykRsrUXiAyxoe9qAeWU1cw=;
 b=Tv+he7SCDf5rAdeZTkD3EMZ7B/FoSu3mZiIQNaKR/FHBGIg7TeY4DBycBbtA83PD+iyfRDsH19U69jAu4EWKIGvcut3rgvuF6U0RuZtzbd9YesybrqOZZBnNd8ntCW78mGWIlVUC5jFrG82oy8ZCxGrEg0GaIEJ2BsBEEzK11SwgtkDHf6W4A4/vgCcNT7NgI6VlDgQ0pCZDy/ENghG7bgJ8pNFGJOLqXSsjbSrFTeh0YjHKOOMogTxA2/DNRQGJ3X9oQ7BY07ewfiDthxXqSFZbQHJsmuj1onz6yAg/oVygfw/CCL5MJ6/0jQxhRF31HMXB8Ug1J2QvhfdK6yJVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:01:27 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6631.035; Fri, 28 Jul 2023
 18:01:26 +0000
Message-ID: <396ef614-6b06-ae8d-8c08-ba61fc30631f@intel.com>
Date:   Fri, 28 Jul 2023 11:01:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 1/3] cxl/memdev: Improve sanitize ABI descriptions
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <jonathan.cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230726051940.3570-1-dave@stgolabs.net>
 <20230726051940.3570-2-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230726051940.3570-2-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: ecec3877-ac0f-45a4-2709-08db8f94a95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0Ex4zeRTMTcQoSwp2ssoAns9FfbjVmYjG/OozCrwZr5x2ymoukYmiNiLfl+PzkjOmCfZjfAfe2ih3NldRdqb3wadQjM064Rsfn0MMP02TH1oY80MqKuC7YwhqIPFVfDqGIv1Ng62l4NNT0/g/CFuWzdIhM2mpg9Zf2H4DMnEIqVFoEx4dk/ICVXVbMd58JccIl7OvDi0O+2+1cnn4sqynrMWO7ajq7UrCT6U562+YYBA0WJ0Kz0ar2gQRnsx1LKMYd7go9xDYHtyjLeKbrC9yGC0TU6wqUGt1M5UestViEf+S+w1F4jDLdr0CSzCYN1ioC+CKimLOuHI3LrNgpmu6G+UXLhj6jWA50LU9LzL+TOeI8I06pe2IqfPSECzVUkySftah98vAbE9RDKhOKiLxa9srTOaZCMWzDG08D3s0m6CgxblYcUmOpdhoLum912pjGQ5WfTnAUs5LMd9n7mSQe1D5AOoKiv225rxrsvqg3x32g8uGMG7Cv7+c4TKImVpqIMyjxYFsl6d8KOzBXeYTFFS1Q75GwImoE77bhFy1xwp73hNiMXAfULqF9UeICrCoSHAkCRYUSI2IC+GIJxH3n104wY51gBTvrVoUALuFnsuHiTQRlojq4bZSOxhuwh4Jo/7So/+GbsdAHCcw0snQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(2906002)(83380400001)(6486002)(6666004)(2616005)(36756003)(38100700002)(186003)(44832011)(31696002)(5660300002)(86362001)(31686004)(316002)(66556008)(26005)(6506007)(53546011)(41300700001)(8936002)(8676002)(4326008)(6636002)(478600001)(66476007)(66946007)(6512007)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG42Y2ljWmZ1ZEdyTmg3RHdBc0Z5UW1BdjNOdEgrdkJiZ0ZBUEJjb1J4YXNX?=
 =?utf-8?B?bDBhcHlvRFB6QkI5YkhjTDRzSUlJSUQ0eG5ZQjlNUGlvVE42c1pVSmxPWk81?=
 =?utf-8?B?cHRmUWFtL3lPS1F6M1BYKzYrUE80MTJtT1V6Z0VmRXVQTGJWK2tvZDdsVS9C?=
 =?utf-8?B?U09wTVV0MTN2aUlmYy9QVFM2d2gzeWpETitVa29Nb3B1WlN5dW9WNlRocUk1?=
 =?utf-8?B?M3pkUGk1VDNNODhIOXNycDJ2MG1tZW42U1ZjZERSQzJSOThCRWJLMnpDVEl4?=
 =?utf-8?B?OS96aENITDl3Z1gvTi9YU25YOXBxenZJdzJKUlZ2cDZtSWUxUXB0SGtRcFk4?=
 =?utf-8?B?TzRROFBNR3EyU2hvRlBBd25ONGJCOWdtTitoaGl0U3RYbkpjZXkyUnhaV2FE?=
 =?utf-8?B?aTdtYmY1cmI3ZlhhUjdVdjF0NHNxeEtKclFvMU1FNUNmaVdUMUhlcHUrNE9H?=
 =?utf-8?B?WmZxb0ZlU3c3dGJyK2FXZnJ4ZWQ4V1Avc3MrMkN0K3lveDRWSENGcEdzdHFp?=
 =?utf-8?B?Yi9BRllvdUNhQXl3WkhZMmRNS05teTljMUMrMXNITGlmdVFGWGhWaDBLNkRz?=
 =?utf-8?B?RGxWWGF6dEFxTll3c0pCSFkzUUlycDc4WW5tQzdoS3BseExlUWZSTFNjb1Nz?=
 =?utf-8?B?SVp6bDdONWZJUDNscTdESFR1am01cmFCelVjSjhaRVhPQWlpeWptSjFOeHdH?=
 =?utf-8?B?TzA2V25Pd0YralpPdi90aGx4WG5WVWtVd2lhdTA2Q1JQS2JGWU5MaVRxM1RH?=
 =?utf-8?B?UGVJVTNFTjlIRDh3RXRiMjFvcHVHeVNaVlJkaU5CQVFkQTNzSGRFdnVqVysv?=
 =?utf-8?B?TDJhNCs5S2R1aWxVQisyazQvQ0Nac0JIN051dUNlV3F4M0pkTHlWWVpYcHNw?=
 =?utf-8?B?OVZSb2laeGZmVm90YXNQRzhzRGdsUE8rS1RxU0tQaGNlcnI5R0RMVnFFZ1cx?=
 =?utf-8?B?L29XYXI3T0tWeHJVYmV0SEJuWGJmMUlVK0h4UDNWMFc3bVE3b2srUlJXRmhy?=
 =?utf-8?B?cTU2K3VtNW4rbEFkMkh6eEFLVzNWWVNFZ2tHeEtCL2J4Wkl0TkpiR1JaVDBX?=
 =?utf-8?B?VEM4UlppQUJpMEgwN3A4c2MyVWxSeldiald5RVd2cW85ZXFHYW1CNjlVWDFu?=
 =?utf-8?B?VnpPdFlsRXgydDBQNGw3UWZwRm1IeTFib2I2QkE2Vng3MGlyT0ptSExGTzdZ?=
 =?utf-8?B?cFpVQThXcGpmWW9JOVl2MFFqQzYwcGhtZ01wOUowYTdzeEpOV0xhVWZ1azJp?=
 =?utf-8?B?VXdDRi9BQ1gxTG13QlVpeE5FSTMvNGVvTGJKZWNGWjJyMnVKalJFelhHbklZ?=
 =?utf-8?B?ak54NTJjb0NYVUJ3djY4WEU3bno0b3ZyekZacUhYTm5VWkRTcXN3UDYzaFRy?=
 =?utf-8?B?MythKzhpUFBuL1VNQk8yTFQ5ZVUzRW9zdkpCWGFJd3RoOXluczcySFVKdDJT?=
 =?utf-8?B?eERDKzAvaUJ0b0Y1SDNQaHBRcmVDL3Jzd3lNbVZCNi8yQjl5c2l5aUxTdW1j?=
 =?utf-8?B?SDVKZlRQK25sUWQ5TnBGRWRnRUsvY3FzWStvWFl1REtTMTZjZjRlaWZHby9N?=
 =?utf-8?B?NmJqcFV2a3JUdktUVUJxM1h4L2U5emtFVnVFSUsrdmJnZ2sxUEdqMEIyNlpt?=
 =?utf-8?B?SFdkNHUxU1l4eEV1NnBlRTJsb0d0dGlHSUZLQ3I5MVVoUy9GSFFueDdrR3BB?=
 =?utf-8?B?QjNnYU9yVDBWalAvNFFVNDdpempGNUJDNno5K2VhRWQzbkJzNnEvMlU5cWha?=
 =?utf-8?B?KzJGY0lZcDd4OG5sc0t0eFRndWxHR0cvQjBibEtkY0NoZzRpYUVvTVNtSnJD?=
 =?utf-8?B?eEN6V2cwRnUyeWpPc3l4QU9oL2ZSTjZ5dnhpNjBZV0VxM0dyYXg2L0hyTlJr?=
 =?utf-8?B?M1pJMWFRR2kxTFo5c3lzYjJ5V0pRd2cxM0IrcnZIQmdYYkxwcXEyOG1TeXRL?=
 =?utf-8?B?N1BTS1NWSVpoWDU2b1ZjcGFxQXg2dC84US9Fb1hOUnFjVnZKNWN2TGNZVytl?=
 =?utf-8?B?S1RaTkZVVnozdVBwWG1sQXZrRUt3a3Jrc1dCWHVUU2VCQVJNTlhMeTh3TDJx?=
 =?utf-8?B?MHpFOFlKdDRCSEsvcU52KzNXZnd4TFpxakw0d0dGaGtBR1NVRHh3REFLTE9V?=
 =?utf-8?Q?7Wpwc5xH+dRsGHE9BLzN6UfxR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecec3877-ac0f-45a4-2709-08db8f94a95b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:01:26.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQZqoKdcqIcTdjNXYXGy0qMMeIsHvCKXYSEQ08hgA2eX0l5Chgo8gVSqCF+1ef1PfvRTbSI5kqBPryUwVoAj0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/25/23 22:19, Davidlohr Bueso wrote:
> Be more detailed about the CPU cache management situation. The same
> goes for both sanitize and secure erase.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 6350dd82b9a9..c4c4acb1f3b3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -82,7 +82,11 @@ Description:
>   		whether it resides in persistent capacity, volatile capacity,
>   		or the LSA, is made permanently unavailable by whatever means
>   		is appropriate for the media type. This functionality requires
> -		the device to be not be actively decoding any HPA ranges.
> +		the device to be disabled, that is, not actively decoding any
> +		HPA ranges. This permits avoiding explicit global CPU cache
> +		management, relying instead for it to be done when a region
> +		transitions between software programmed and hardware committed
> +		states.
>   
>   
>   What            /sys/bus/cxl/devices/memX/security/erase
> @@ -92,7 +96,12 @@ Contact:        linux-cxl@vger.kernel.org
>   Description:
>   		(WO) Write a boolean 'true' string value to this attribute to
>   		secure erase user data by changing the media encryption keys for
> -		all user data areas of the device.
> +		all user data areas of the device. This functionality requires
> +		the device to be disabled, that is, not actively decoding any
> +		HPA ranges. This permits avoiding explicit global CPU cache
> +		management, relying instead for it to be done when a region
> +		transitions between software programmed and hardware committed
> +		states.
>   
>   
>   What:		/sys/bus/cxl/devices/memX/firmware/
