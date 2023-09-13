Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A009EDEC73
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 15:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbjIMPZL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIMPYz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 11:24:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4E1FE9
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694618680; x=1726154680;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=llVXBtO6C4D/zh73J5wlEw+TqOaVRSOQfVK+FEQMO54=;
  b=J+H9a1TX/NvwlGVimAaowSgGtwFqpzlzqgHx5YPrCd/n0/y5QvUnKzEi
   JdgsQ5wzl05KByb9eQN+ZzGGHTpHFHvpE/A0bkkI55ZtCeXW9+3E3TT0F
   VrrvVWW6SB55lTiTOLGHkvlEcdSf7+ENQrm8uqJP89tah0Hy9yTiGXzUs
   rigXR2jvUzKev7Fk9Acpf4v9JnzeVZYT9thQDwU6AnQKhe5OcwtyOclUH
   mCvLDbGC72QTbqa6kN751vOHKum0TNEJg+ezl7h0J68eDfjANRwv80C+J
   aSrJ/b4EmdDHkc22C6LUH50dd0KsXpBCGs3E3CdW0JPRS8T6CHQLegiE1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378602845"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378602845"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 08:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="917874540"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="917874540"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 08:23:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:23:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:23:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 08:23:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 08:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnDhLdO6NUcGregFTlMORzn9OhFD7k6ZEBjA4AjIo3APdM0cjsYivFpI8Z1N2q/R9FHERdpLcilZ6D2JtIYrYJ0kBGtkRJshfS3KP+lpHaJJirskzKSfMLdQ67izo8dJMNn0YTC4bRauUcG9qMs6EnB/jPn/bETtaVTYj9f7JGc0GMCs3R8GMrjhL3synbj74Hr5gohoirK+12rJXp2xHReNoqqiS+voS0WtzBY13l2IS3VfiThFvsoPo5btBZxPzqdt9A/7uj5e3Vkr1bqS5CDp+CC2sHrOx8qHMwwJLeDiZ2aubFR+uJBA06x4JkED6Y8qKJXQHw0Svb1d5S3xRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69eTSyGs7JP0BO0VyVTHokFExMrSpflbhGaZ24JUWa0=;
 b=GqCHobfE77s/ndcn7rakX9A9oDTJk86/Ya0iE1yvWOLg2cZwFouaIEMpbQ5dULpYTLpcWzUzEbbdy+xGPta6pspV0EQ04UJa0p8J9WHT6rTrVOpBHM0DU3mTR7UBxot7g9HcG6OMm7wWFH0ggYbNanDE4KJWwXUzys01jf5W84ecm+yzr7a93aLD0zG16k+A0cRQK9XhyyAjPEY4mnqcJ3A7SswP9N1ziGvRYHz+WI/CdgXYevsJ17kYcW9xlOb4taNNap5YTz8oGpyCYEGKQ7HEQvUwewZFUbzWJHMWpHkstwZYL+DMCWhpAfya3i7SWcGNWgk1KtzJxk0VMvmxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 13 Sep
 2023 15:23:10 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:23:10 +0000
Message-ID: <0afa6920-3c89-5d8c-db28-1edb22322fb3@intel.com>
Date:   Wed, 13 Sep 2023 08:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2 3/3] tests/acpi: Update DSDT.cxl with QTG DSM
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
References: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
 <20230904161847.18468-4-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230904161847.18468-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA0PR11MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a5f06b-36fe-4d63-ab5e-08dbb46d56ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3lhooTjmHK1tR9qog/xXl38zrVHg4u8oIVXnTO/Ijy7UfmM+l0Mjmy1QlQpQJFhO8N3jS//ceSV/p3wIZNMcaKl2PDiECY+OEwE1STyJEexLKyFvwuLRZqy2KBBb7RbqfSQvF+HSDSf/h7x6sEhL2gzrRMLr9WGYg/l9V6E2IDdmGh3Rmu3Qbhg1sr3tVFwJNnA5wMPVrhJc6cekDXnec4dVyzSRicDeBBm8R9FKdYiSHzSzsgTDu0cpKKZvJqZu5rsTqiVZpB68WYkMIBlCBnDJyQsDAan7ynK2QNQSK+r8vfUn7zlDn5oSb7PQlej+RhRnHrYLfUNIZWeowz0h9Q0TPCNB4kcXt605qzxoHPPId9kpdZPSdrMcSFYPbjP007IARFjF3FEFMYvtFnAc3y9IqN9jac06bxVmWHETFOjZVa2JIhoRgYY4wONqN8KxfVuXw4x2PL1buWEF7+xduP4omTn4s8OKW6eE6ZCrON5KgvQfXXHAiCa4N0fVlYl54gM+3NgEmUKHYw84rw6xivz9v1Khc+sEStFDqiojsrR8RkXu2ferIgH2YCeVnOuz7X15tpdnsUbRCSUp6tlehQrmeAyhyuv5rjBFTaqMKlDUoWfF8twfQos+RdmgGWNUN/CvzRYmsaaDwzuwNzKNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199024)(1800799009)(186009)(31686004)(53546011)(6506007)(6486002)(6666004)(38100700002)(36756003)(82960400001)(86362001)(31696002)(26005)(2906002)(2616005)(6512007)(83380400001)(478600001)(4326008)(44832011)(316002)(8936002)(8676002)(110136005)(41300700001)(5660300002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amFIdnVUS0xkNVp2bjNUNFNMcm1lb1NRcEhmSUw2ZkJFakRBWm5FMWZ6L1hO?=
 =?utf-8?B?VlFEUHNYWlVpMEM0N0RyQjZzRWRIelgzZ3IxUDMxYkFXSGhrTzlicDRIQXh5?=
 =?utf-8?B?RHdYcy9sdEkxRkpoZFdCbjJhaSsveGQxeWRGSUhpanB5Wm5sd2hPRU9mTHBa?=
 =?utf-8?B?LysvOTFURmlZckp3NlkxVDgwN1lCT3ZMcmxRczluczRnL2ZScEE5YW1tbXlt?=
 =?utf-8?B?NWYwS29DdkpXY2Z3NUZycUFvMFkvdmc2b1pPNGNLNWZkSmFqMnJqZFpERU9X?=
 =?utf-8?B?OUFWVkFUQnVBRGpCNGhqUkJMdk81NG9CNWV0OHNjREhDTDVlWDBmUmp2Rktp?=
 =?utf-8?B?eTV5ek13eFlZeTZUV29uQVlyL3FRbTBrMVFXS3Q5RG50SnFWK0JXMkZVZ0dl?=
 =?utf-8?B?S0lybmNlblFSb1ZaTzYrQkNSMnBpMHA2ODcrN2ZOdGlWcU1qTVlDNWp3UEdX?=
 =?utf-8?B?NkpodFFaV0RFWk1CNTE4S3Jpc3pHRnhqS3E5MTRaWGxGcDlwdlVLcGF5K0Rr?=
 =?utf-8?B?U1ZockZXY1U4TmQzMmEvcmVyNGVlSHV0QlU5cmJSUGk0Z0gwZmtFQW5nbVVP?=
 =?utf-8?B?OEg1Mlp4a0dWVVVDUWVRc3F3aTdSdnNFaFlEQ05BVE1MRHhUbkxtUjR4Qy83?=
 =?utf-8?B?Q25yamhGVVluT3RsSlBlbEMvVFM2bitKWGI4Ukltc2tOanhhUkZWSk5mTDI1?=
 =?utf-8?B?TG1uMkNxY3cycmdpZFRjRmdZY1dtNzBHUkZhK0tpZjdtcWpNYWo2QzQ4SnNV?=
 =?utf-8?B?NHc5NkZienQwWVRheFJ0cGhsSDdZb1ZzejZ2bFhSTnQ5YnpicldVUlBzWXNL?=
 =?utf-8?B?cjdQa3I1bnU0ZHM1VVpXNTQrL1k4M1ZyVDlISnlFalVwaUZJSTJ5YUFrbHNm?=
 =?utf-8?B?dS93d0FMVWgwZnA1eFZIdUI4R0ZERFhBMml1OGpVV0dHaVB1QnEzM1NXaVZi?=
 =?utf-8?B?dHAvWVZXMWYzejVuKzNtNkJMaTkxb0R5WC9YNWE4YlVKNzVYM3R1TzE5L2dR?=
 =?utf-8?B?OUZQQ25ibUNORVl3TVh2V1E0TWFnZHBJeVdWazdZK1VSVFYzWVR3azhUTU90?=
 =?utf-8?B?VTJMZFhNbVZ4Tlg3aWdKRGpUeHZhQ0h2UUJnN2docmJodlVOSnhMMHR5NE1n?=
 =?utf-8?B?a1pWMVVqTEVYdWxFNVpjaEpzaDhwQVM5TkpmQTZCdGhXUHZNVlF1OVNSbHRH?=
 =?utf-8?B?a3JUUnprUU1CM3hmUkNQWitiUkUyQ2dVM2RZckdLZ1Z1d0JyejNLRVpYODMv?=
 =?utf-8?B?SDBlaXlheUc5WDFraGVkdWFkQUxOSVlnMHcxTUE1NzJDbk9STFVaWHFhVmN6?=
 =?utf-8?B?Z2NJVk9ubDkxN1JFYjJJSVhzczhCUTVBblMzczFOSVloMVFVWUhhc0IweWM4?=
 =?utf-8?B?a3QwS3dQbE84em8wUVdCTHhuaG43c1dRQXpldGluNnl1ZXpUVVEzZXZmRUVy?=
 =?utf-8?B?dzR1QW5VUVQxeG9sc3FFQlJtTnpQcXZ5M2tuN1NBazVxSjI5RlFVUS9VQ0lR?=
 =?utf-8?B?MkJGS0htM2VsYVJLY09wcVhwMmpRTFBweWJFZWxGclk1ZElrWGhTRTlZWEVZ?=
 =?utf-8?B?Z2pteEpRUS9SdmtyMlEvZG1kTU1zZ3hmZ1FYMCtiK1l6Z0Y2ektPajlLdzM3?=
 =?utf-8?B?eFJLTlJ4SzkxSHhYOUNmS0RaVjY0Zjg1TkgwbjJHRlUxanBlRStPcXE3OFlr?=
 =?utf-8?B?NTRCMFIxMEN2ZDMzMVpmaHExcjhrUFlWNkNxZTZxVzR1ZGs1NmlxV0QzSnQ0?=
 =?utf-8?B?N1lsL3VNTW9VR0lwaU1XME5oQjc0NFlzL3FqVzZ4K2RVSGJZZUNYMVpsR0Jp?=
 =?utf-8?B?U0FQYzdIUG84a3hPd1RBSm9rdGFvRExBRU1JMFJTMkNacUVpS25TS2wwZS8w?=
 =?utf-8?B?Nk5EeXNQM1g3MGlXNVBmZFBxbUt2MExWeWJOckZaaWt5TEhNRDRJRFkvTHE1?=
 =?utf-8?B?TUZ2OWxNTkM2c2pXNHhGV0QxdmE1T2pvRXJtNUp5eGo3R2hva08yc3MyOUpT?=
 =?utf-8?B?akJEcXhMd05TWVZCZVJKTGpWQTVjK2hDYTAxdG1YYWc5R1IxSDJ1cTBCTERz?=
 =?utf-8?B?VTRnbUxrc3FhdDN0UGk5R01SNVlTNDdkTnZ1N0hqV0p2Ry9XZnZoV29RczZ6?=
 =?utf-8?B?RzZIdldEQjVWTm1WK25vam9hc0h4MjBKZ1VtaTZSY2JBdWxzT0UwZFhGZFp5?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a5f06b-36fe-4d63-ab5e-08dbb46d56ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 15:23:10.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wN49H5qxpsMCvDTyKY8Rd0HhRaKFvVEulQxz5ydGu9PYf6VIRAsT7MwxDHxSs9teLYJNifT6hf7Duri68dAGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/4/23 09:18, Jonathan Cameron wrote:
> Description of change in previous patch.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  tests/data/acpi/q35/DSDT.cxl                | Bin 9655 -> 9723 bytes
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 9ce0f596cc..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT.cxl",
> diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
> index ee16a861c2de7b7caaf11d91c50fcdf308815233..d4272e87c00e010a6805b6a276fcc87d9b6ead17 100644
> GIT binary patch
> delta 129
> zcmdn){o9+%CD<k8w<-ezW5-6WiHaE>Z1KTP@zG5VY|arrz8vu$o-VwO&H<hV28QMg
> zA{_C-A&v}77)2ae;$4D$c@|hs&JYyl5?J;#_4B>ug$~QIw(xNK_XREBoSen5M39-0
> gae?^cEXE~5f=q&}Tuh7%LL7`B1_Q(9{fa-B0lXk1>i_@%
> 
> delta 61
> zcmezEz1^G3CD<ioyD9?%qu)lZiHa&J@xe~<(M__>5k9^g@gANoypGNRo(2Yn<_sbn
> R@xdXE3`-a{Gb{aI1^_O_5bOW|
> 
