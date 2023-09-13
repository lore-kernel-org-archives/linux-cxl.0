Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8937FEE3F3F
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 00:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbjIMASB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 20:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjIMASA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 20:18:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5E210F2
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 17:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694564276; x=1726100276;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p+1CXmM5a0G5nwd9aM2RyeMN+sOtBVQQig6DcDguVzk=;
  b=aJdaYauU9l39xgli4obCXgRV4Dl745BcNW97cHWp+2gkL/qEOcUH2CYu
   KjBAoeQPE6NjniDcNaoeU+ykfDLM+Ay2zTByZqVlWPooHZuApfZgLs4E4
   EofsdV7xTm+95DdSls3oMNhWL0Qahxyex1WiDwSJ6H5dQueEHMZWYqAt9
   dmIdVVjLKfj0QQ8Nk1oShKdN2Cqmg8ZKJe3I2sdWI1YfuaqRuiUoEkXRX
   aFpMIBIGO40qfIN4fz36Zm0RZ9VL9tKkV5axzdWuGmEW7MAedSM9BQSqm
   U8wi2R2ic061WdCWF/7/gOZETrlagsZIwpK9f5c/bKabRhIpTrAdTVG1Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="375858617"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="375858617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 17:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="720619483"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="720619483"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 17:17:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 17:17:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 17:17:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 17:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV8CuGcDgUMWpKJCj45NehAqkWpf60kyZEp8jZkIWbNy1JJ/EnPph3QxwmGN00qOm6iA08OXt3cDpGaeYMWyvzURYK1cyj5V1dvXnTTO8Tqzy5yGeIrua1F0pTVrBzf2hotK091G3pfwXk3GCUCSl8Qz64PMi7xfLcywtLZyCdpEYYSaGcEoFWGWc6cnhs8xUL8pETAEwEXHMqoRuabfJOgjGZ0gP7S9z1R8FRHrmidg5QSz1MV+EhcGUj9oyvWvKhivuSw/oVGcjmdr8wrLJ16KS6jDHaqaZbAGM08Q+POysgCeREskAujGWJzzxvZp9xbGmItA3wjeJu2Q2agE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWISgvGFuNlEbJigkXoOaQ/hjGxoq8OBIN1IylXs8jc=;
 b=BY4nKhz1LWXgU31v3KGbSrwk/MDgvnTFU4Rj8p04sRz2FY+NFJFG+e0JHHlS0T7zJjCP8NDonVZ6f5Ieknw9i/JmBfAYHp2MFijESeHxm9Lc5/1rDYYuzjL+RNkh+Rs32fLPpiUmddwMNm3bmcJZ5niIGQ+jlXoQfl3eFvgW5R0r6Edi1IdorcKwZq4UTL4vVOpfijFWY9R3t/FVpDIKYUh5/KjuqqyhjX6p83pC8k9x1x+HEAE4zOGKBWtrC1sIErBQkFQChQtOCEz+C6oNS8BgLZez4YSd0KuFPk1hHdtA0MgQz3vkGIaHBkfVqibwRFJr3NSaN0q1Dn6uafp0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB7445.namprd11.prod.outlook.com (2603:10b6:510:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Wed, 13 Sep
 2023 00:17:53 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 00:17:53 +0000
Message-ID: <d2678911-af6d-86cd-981a-7a20fe17c68c@intel.com>
Date:   Tue, 12 Sep 2023 17:17:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH ndctl] test/cxl-update-firmware: Fix checksum sysfs query
To:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
References: <20230912-cxl-fw-test-fix-v1-1-bc544002cd02@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230912-cxl-fw-test-fix-v1-1-bc544002cd02@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fb6413-b3e9-4774-8415-08dbb3eedf26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ko5q4h0QMFd1i5iHh1YFXD7smdwjEuhUnlrG4A5etwMD43FW6uaul7+B5Re9E8nz8k+Y6451DBhQ7/wwYd1s/YMZM1oi0zbIFn3RsuZGVpQH+xqUZIsajYqL0wXhuL0BBsWXW5bizgKWYT7hiiYR2ao3BMtigaeFnxuDlgieh60J4Jdns2GVbP8XI8FbyihCvLtbU6yfhMpd13vOzwOZIzLGuhcEgRg0MlNrhzQzURwplulDaDYMBwQty89/QMhApzX9aqz2uDt6eRieC1eSFWrJLrRA+P9CtGY2yDdYF3ohnj5lDn7lNVSM+oHUWsJwZzYyG1EvwZxvtk/mubmH7vQJkSs2SRwSg3nHXUWk/47P0UUWKZpEDOViM+ucm5ctt6BilxnbjuT9PiKY8BP7fWuZQ9xKnJzsHPz0xPciaj70vAvh2NdTCSzWRLbFUkpKHbEgJ89PpZVrj8hHc4jvHJm3fAb2j7wVGKh4YAIVe36zb5usj76eB8dzmtvbc0akhPVIyqL07u+WkgaeytOWMt/Dg6bLwaPPu74vztZd2BzQQzAYHp4qB/fzHTOmgBdlFxTtyHVqpgfYCQ4mS0z81qNM81VbKbZbEzHtC1RmHyHVojkw0ui6eS4VWcKkxCyv7kypSFxSIoemXeIXxixwdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199024)(186009)(1800799009)(41300700001)(31686004)(6506007)(53546011)(6486002)(6666004)(38100700002)(36756003)(82960400001)(86362001)(31696002)(2616005)(2906002)(6512007)(15650500001)(26005)(83380400001)(110136005)(316002)(5660300002)(8936002)(4326008)(478600001)(8676002)(66556008)(44832011)(6636002)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWdpcFI4Mm9pb2VRdnkyeGI0THlrb0JwdWlOMXdjQjcyNzRUR2RuWGlRbktF?=
 =?utf-8?B?aTNUMHFUVlBhNVJzMnQrbmRsTUpsc0EzYXpIQ1ZlU2lTdVdaayt3ZjJjb0ps?=
 =?utf-8?B?djhKYlMyUUIrbXNkT3BoMWxjck9TV0lrdm9NR0xBY1BUc3VHZkVpQmg3Ri9Z?=
 =?utf-8?B?QkgzWUgwR2tVZ2RKNzJZLytxb2htS2lxQXZOUDdwdXRrM1p6a082cVNBR1R0?=
 =?utf-8?B?OXUzK0QwTVFUMmhXSUE1cGZrUERYaWMvaXBhdmovQTNJRHNudmM1WlJvNk9D?=
 =?utf-8?B?U05Mb0ZuVDJQTW1yS1VBSXlOc2VHaFpaQ094T3I0ei9FRnZxaWgxcjhFR1VY?=
 =?utf-8?B?QlcwYkdHSWZjRUU0YVF0S2dWRUhBY1FyZ0VWMFZWa1A2OTR5NTJEU0M0UDJo?=
 =?utf-8?B?bC9wRlBEbmRsTWRJZzkzVVZISXQvTUVvRDF2eSt5OXNnMnNGYXpLOUh1dkpT?=
 =?utf-8?B?blAraTVkSkQ4ZGhyUmZibkI0UHJ4NEFUcjVBMGxTTTkvczJWdGhvUElJVHE1?=
 =?utf-8?B?cFhLRngxSDRlRDZUOFdvR2MyaklveFdpSFFPZGk1NVYyRWlSRzgzbSszSmdR?=
 =?utf-8?B?TXhsam9HaGVjMHlQTXc2dk5LNE9WUUZxTVJLZk1VdWRHcDNMYlFtOVU2eHFo?=
 =?utf-8?B?K1VPTkN2Q24xV1FCNGs2QitIcW9zQWJndEU5SHBJbHljZ0txamhuMmsxYXY5?=
 =?utf-8?B?R2o5b21UTENFbXB5aWJ1cnRQeW9EWkdXVHZFSGZyb1lQTGptQkdscXhxdUVW?=
 =?utf-8?B?SzFucGFMNnM0ZFdBMExISlF6KzZVbWZFR09JTktUMEtxNE9UNXJMZk9iUy9Z?=
 =?utf-8?B?cDM0N1FGeUpXLzFrL3puQ2Z2RDhZS1QvNnNsQjZaYUNnc0plU3NsMkthZy8x?=
 =?utf-8?B?bXNXZFNMMXNkdGVuNFhaVXIxZ3JJTEdWaitqb2tQdEc1c0xiT0VvOUlockxO?=
 =?utf-8?B?d3FFOEV4b0ZIcEV6WE92MHdCL1Axc3h2NU9KeUxmYld5WklXeDQ5OURsYzN3?=
 =?utf-8?B?WEp5TDFSN1pJeVJXREVpckI2RXNubEc0MWp0Si8zOTVDWXlkYmFGYWF2ODFP?=
 =?utf-8?B?M09tcUJBS2NZWE1GZ1NmNzhjQWdUOEJFUWMxZGVKckZObTNiREM1MUY1Q3E0?=
 =?utf-8?B?SGJRdFhUQmZlY3pUS1d5QThhYzJnenJjRkdJelB6YkdqdXB4YnJGRWN6Y2ZS?=
 =?utf-8?B?ZFdFaWJiSWNyWDM1UEh4S2ViMW0rMDFmZ2NrUWFkRVIxM0hjUVF5emdPSE0y?=
 =?utf-8?B?bk11WDk2eWNIUUZQaTBIRFpmQlFkNkJxOFFqVXgxeitoenc4TTB2TTNRem9y?=
 =?utf-8?B?LzdrTmlBZHhpVjA4czFnTHFhTXNCMWRuWDFiMmI2dGhoVW9BK21TWUJlZ3g0?=
 =?utf-8?B?dGZaa1cwbU1xMitxY3NFYitkRUJXT25wSFBqdnNlMXUzdVRKMUNvM1dPWkJl?=
 =?utf-8?B?MXRIVTRIWWh5S1p2V0ljSjd3Mzl2VGlXK1paeEQ4OVlPL0YxbFRjRkErK01S?=
 =?utf-8?B?VnZrdW5HdE0vSUh5TzRKVkN6RURHM1R6M1kwU3pvYjd6aldjdDBzRjdmbHRR?=
 =?utf-8?B?YzNKdk41cDJWQ1FCRU11T3l5LytkdE56UTcza3Bzbkc4bFYxOHEwVDgweEJz?=
 =?utf-8?B?S1A4QWpCUFdTR2RLc0pkaXIzdlFMNDJvclkwbjB4bUdGVjQ3dW9WTno1eExX?=
 =?utf-8?B?L1dGdHN2ZXh5UUVKMllPUThwNGFKMVZXV3BHL0N4RWpuRHVLQ0pzM3Y3TTZ3?=
 =?utf-8?B?NVM5R2w3QUxGekM5L1R5a3NmT3hieGVBREFjWnBjRW1XR3NiYVpXcjhBVEZ0?=
 =?utf-8?B?bGszVkRRaU1FaFVLbGpDV3IyUEwrOVdSdG4xdjRtTEJBdEtxWkhwK3E5a3lm?=
 =?utf-8?B?N2J2dVBrNUNDd1d0VkQrcnBJUlRiek4xSktWWnlEUlBic3RZWWpVRnloaFhl?=
 =?utf-8?B?S3JNbGpERWFVNU5aVU53VXBWQkhENXQweSsvODIrS2lIWDhHS3puVXlTd0lR?=
 =?utf-8?B?T3RBRTU2cEZmczVHUE5DWHdlSWorb1JsRDlGbE9BVjdIWUpTT3dpMHNFRlBo?=
 =?utf-8?B?ZERVa2MrVllsZ1c2YnVpTXZYR2dId2dEMnk2eExobUZPSVA0cnVyN3ppV1NN?=
 =?utf-8?B?TGtVeW1RN09pSWpkUlBOejN6SGNpcWhxUXJuZXB0YTUwWGpmbXpoRmpSdXhk?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fb6413-b3e9-4774-8415-08dbb3eedf26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 00:17:53.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZ84sm6+F4MILoTUNW4+IGBHeMHtM/JFOpVqGvrZCceGi6iIQRv8Qvs+jdZefv7vZgYFQpw636hUAXqfBWAy3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7445
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/12/23 17:14, Ira Weiny wrote:
> The cxl-update-firmware test is failing on 6.5 and recent 6.6-rc
> kernels.
> 
> The checksum check incorrectly uses the mem device id to form the host
> name when checking the firmware checksum.
> 
> Get the host value from the mem device and use that in the query.
> 
> Fixes: 813809ed318f ("test/cxl-update-firmware: add a unit test for firmware update")
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  test/cxl-update-firmware.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/test/cxl-update-firmware.sh b/test/cxl-update-firmware.sh
> index c6cd7429bb85..f326868977a9 100755
> --- a/test/cxl-update-firmware.sh
> +++ b/test/cxl-update-firmware.sh
> @@ -118,14 +118,15 @@ validate_staged_slot()
>  check_sha()
>  {
>  	mem="$1"
> +	host=$($CXL list -m $mem | jq -r '.[].host')
>  	file="$2"
> -	csum_path="/sys/bus/platform/devices/cxl_mem.${mem#mem}/fw_buf_checksum"
> +	csum_path="/sys/bus/platform/devices/${host}/fw_buf_checksum"
>  
>  	mem_csum="$(cat "$csum_path")"
>  	file_csum="$(sha256sum "$file" | awk '{print $1}')"
>  
>  	if [[ $mem_csum != $file_csum ]]; then
> -		echo "checksum failure for mem$mem"
> +		echo "checksum failure for mem=$mem"
>  		err "$LINENO"
>  	fi
>  }
> 
> ---
> base-commit: a871e6153b11fe63780b37cdcb1eb347b296095c
> change-id: 20230912-cxl-fw-test-fix-5b11b75412a0
> 
> Best regards,
