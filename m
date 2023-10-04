Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A334CE936EA
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 22:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjJDWE3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 18:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjJDWE2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 18:04:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6832C9
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696457065; x=1727993065;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TTaYAkaxMqIrqCAoaQiIZ7mbeJhfGS3njxrh1L7mhpo=;
  b=gmf+OimLn7MSUbnwktgCP4OPr3Bgu4EGlV00fCJVc2MTJUff63qxhAmG
   BO4zh/6Fk/ZJHadiJL4tC4Oyzg+zQIHoGQN+3aHsffwp8PWE9MCwm73Ic
   gXi/5m2pgLmi5NFbvRT0zhZ4M2N8Z6jd26c4NZiXkDuoucUPBDC9Wm/qy
   oRMRqrxGkbqGg/VMedvbRQ5V00aZdiDzNvrhxtGz94T8Gk481fJRioRiq
   gamMl/2i5tHh7Kgbx5MSS/fJzzEPXGnY4q1w1VZriP05Vyev3fujcEWw6
   YxT3x9IG27znLKhWm2b5LOxx8Smkl8sYQDb62Cyti8J3gRd7ENzRcSMBV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="1914693"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="1914693"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 15:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="925327723"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="925327723"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 15:04:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 15:04:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 15:04:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 15:04:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 15:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fB2bpljgqZmZrTkHFTQbZy1BIOvKamovEBHVqnpAy7RlifsvGWIvm57PFVOtFULyXUiN90DdIsthsmQ5vrkvSbltCapZndChen9cOX96OQHIavSQs8OoHmVI4fgHOqKUivVZxphkuKHyHb0Ix13JxO8lX9KwG6tKs0R+j/jMFQYQGX6WkD8H0SoqfdpblX3AHg1fO6+s9ViIHz3IFuyXboC15APukvRjIwH4XZMes/0VnMY5dxrqJdcmOlh3/HWsqB5r8N0BXh+U8FNVLgVEV2E43CWfNHfRYW/8fP2iJhY/6QaYC+WX1IJzHG43qZfTDbDX6ivEvIMZy77hCy081w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nls1hX2NlS9afwuwtjd1kr7GSor8w0aGcopKr+nYpcM=;
 b=M9UIJ82p5z20f05JMwQb8gP4IJm7SKjaVutWaCpfTDIZPp5M9QpXZhMaNc+S0PL+n2zh++e9XYcJJh3P1Xn4QTs2gGFWCNF4zqcPiK5othc2xjNnND7GTy4M+1RI+phzNK7yyt5hyB/+HDJfvlKpoD+CHmwau/2cUOTlYMGMsvAtcniImNYMAlXOr3Gu4berFZp8lDx2mOe6shtjyhDQZjEHUdD7RjgYdabVsBqAtIh+Nh8SknuTrCF8Ooj69pyqtqHYunLOIO4KHsCb5XTtoIicBHnfAhDUMae+DBB9oa2kU/AqPpUd9JMQDaU9VluE1PWF5SWe6I70LkVRQ+BHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 22:04:21 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.029; Wed, 4 Oct 2023
 22:04:21 +0000
Message-ID: <3c7dbdb5-4efe-456b-ad04-2f823877f52c@intel.com>
Date:   Wed, 4 Oct 2023 15:04:14 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl: Add cxl_decoders_committed() helper
From:   Dave Jiang <dave.jiang@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <169645694613.622744.16961380551670781524.stgit@djiang5-mobl3>
Content-Language: en-US
In-Reply-To: <169645694613.622744.16961380551670781524.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|LV2PR11MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f596932-218d-4bd2-a2d4-08dbc525dcac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eY9J25JA6gb7UmIOSbiCU63HSNmued4VS6XYxAR6fhnxqT166yzo8uTCDRO9A4jo8jc7l5tbvHp4VQHQC7pYe8phb8wjrp8fXuKPaLprYNVeKJ12rIhES/zPDv/HuoSoVwVM+xVh1gMg+WZIMCXdFcJ42EZ3wEB32ZDDPK/CxMdOA5QFIVcoAKWaxgoqXh6WhQMwaHmbGmgupSGueEyBGCDK7Du28k3ryx6ldNelggiQyrbckvoxSYdbCnJXVI96gSKQbieJwTQ/8pNLBxDT3bqT+ywZJS0WwvFc0o2VClJrK+TfFLaolrchN2QWmQULimAm590oNrXKXJdK6dUnLhtg9OG1QRqyy7R80KNBSLFlpBN/0msgs8TgHOmiNgtzxx1LoeHk3Rl8jsfUdzdapuItMyViqANhVw+K81zHLuh403dESS/vkrwS15hRxHn0PML+N3WsjCl05OiNupmHneU1J0kO/ntkXSiHH8WjXEgCAPoOQ+9QzrxY8/eumLtWTlGMaOv9b8x+k8kPwKyJtes7PABsu6IqDhAfw0gOhHN3InejBmj/C/FDmuCx87SUiqVVRr1m9ovu1efhZPz0LwCISMlFix5/jZXrS/FaTNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(44832011)(5660300002)(2906002)(38100700002)(6666004)(6512007)(478600001)(82960400001)(6506007)(53546011)(86362001)(6486002)(966005)(36756003)(31686004)(31696002)(26005)(107886003)(8676002)(8936002)(4326008)(66476007)(66946007)(66556008)(6916009)(316002)(41300700001)(2616005)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE03amFiOU1wY2l5S2RKcldadTMzRFZUSDAyMkpJd3duY2ZENDBnS2p5QldL?=
 =?utf-8?B?d2Rtc25Lb2FZQ2JpeWJmUmRNdkp0WEV3Z1dobklPVmxXWFd6MktuZkdNc2Vz?=
 =?utf-8?B?aDBIZWlmMURIRHlEdUVvQU5NK2tMbklwQnFrTmZhU3c4ck1wMFFrTkplN3lG?=
 =?utf-8?B?d3lNbERha0tzYXBJU2U0L2ErOWFaMDdHbW8rS1hjU2N4VTg1d2drQ2cyZjVt?=
 =?utf-8?B?RWYvTTdFR1RQT252U2FPTlJhektvbTdwNHZKRmU2MlBQY2lTUG9uSitzNDZy?=
 =?utf-8?B?ejQzU3MvWmpqSEtOVlNOQmVlSllWcjloMWFFSzA3NnpWWW5pb0JJRTZOUkVE?=
 =?utf-8?B?N1c2a2JlQ0tmbmpSVTdqVDBKWEViVVVKOXZpUXNQK2FXQkJqN3B6TlJvL0Ur?=
 =?utf-8?B?MG1tY2EwY0d4Yk5RQmZ2ZW9ONnNOSVI1SDlBczBiZEdHbkFHUC93amJUSVQw?=
 =?utf-8?B?bW1mSlNtTFdmemVXa2NFSHhPaDd6NDlMdDJSTFVya2tuRFZHK0JhOXhCWmox?=
 =?utf-8?B?aWFNSlhvR1N1TEZsL0hLRmlsMnpTK2hUTWxiSjg1Vmc1dlZmZVdqQ2RTOUMz?=
 =?utf-8?B?TklIeHQ2N1VmWFQ3UEFNYVh2VFR5TWZQdnlhU012eGo3SzcyZVNKNHE1VWVs?=
 =?utf-8?B?cU95TDdST2ZudnhZSGJjNVVVMFlLejVMODMxT3hNUG94QzNFK2pwc20xcVZT?=
 =?utf-8?B?d2pYRklWamhaOU96cHJBN1JXcjZBZkdzeFVtWjlvR0srOVhLak1qdFpBS3k3?=
 =?utf-8?B?TUthU1ZBVEQzWGhqWlpQYks3UG5TQThHMHBLTlRQRWxJVkdsNzlQUWVmS2w3?=
 =?utf-8?B?YW0yNDlUT1dMVk4zS3NjZmIvSmVkZno3U0JxM1RHU1hqcUMrMHJVT1pjREto?=
 =?utf-8?B?WDBLUWxOZ05aL2pmSEtPZGNhZG9tV2h1UUF5YzU4RnYwZGJpSHM0ME14M29N?=
 =?utf-8?B?eHJBbUs5dFdKZE1sN1pyV09MY0RnWlVWMWJ5cnhXVTlwa2hCOE4ybzJWYjkx?=
 =?utf-8?B?Nk5WZTlDeE4rdEwvVVVLL2Fkc3NsMFlydU84WDh0NEpKQWV3MUQ4NlNpU3pF?=
 =?utf-8?B?MW9XdUFCdnZFUy9JcFZ0emQ2OWh0RjE0a1owYWZlV0gzZFUrcmVORVl4QVVT?=
 =?utf-8?B?YmQvSGxXeVhpclV6YlJWTzd2TytwWWgwN2laTVYxam1qcGR1MXhibkxXaVFs?=
 =?utf-8?B?RmRVOVdZNnYzc0JBUlIxVC9oZ1R0STIrRXY3dDlLNXk5ZkdmdzNCR3JmdGJs?=
 =?utf-8?B?VHBqMmgzT2FGVWYzdmxHVzQ1RVRQaElJM01zbnBDZDd5OWp2OXMxS2sxSDZP?=
 =?utf-8?B?azlEdkMwWUpBSGs1ZUV3UXVBcElqZ2R5bHBkRGh4OVVzOGtheVJsRjdLbHpn?=
 =?utf-8?B?UTZGTld2SUcwOEx2SmVrMmM3TzZ5VExXSDlPWkdqTWdSSlFiWmdmQUpYTnVO?=
 =?utf-8?B?YmJKQ0hlNFJNRnpJRUlPejRPZlNxczgwL3ltWVROWFl0eFhkSmpqNktzbTEx?=
 =?utf-8?B?d01EejJMVXRQNHNZSFhDK0E1VWtRc2tJRHJqYTYxTXJDUzdPNk5JTTdRUkI5?=
 =?utf-8?B?dWZYSWpiRUNaaVdoZDhGN1k2d1BmbnVYZ2EyMjlEckJFN0dQMW9PQnovQ2h2?=
 =?utf-8?B?OUxOdFJNRHFMMUhYSjdDUTlhNGp3L0x5RmFxMmZRdU5jYlNuUzl0UDJoNldW?=
 =?utf-8?B?emJHMm5ucHhkQkNnekcyOFJOSXBaUFM4YlBsUXM5S2YvV0lqRG5rcVAvZ0Qx?=
 =?utf-8?B?V2FiOVhDWnlPLy9SaGQ4WWlrb01wVFVRUFd0S0JMZlYyMno3MzE4SmZYVlNI?=
 =?utf-8?B?MFY4NjQ4bUJvV05zNHhlbi9ZL0ZKTzdBODRXM1Mwa2ExNlpZRlV2SmcvS3pS?=
 =?utf-8?B?Yi9HeVE1dUFXMy9hQ3k5b05Bc2puamJiZzEwb3I5MmpJRFZHcjdzSktJN2w5?=
 =?utf-8?B?T2Q0dVNBdmNSdmVUTGZzc3RKa2M4SE5WbFByUjdSRWVqSDlTYjh6TnR4ck5W?=
 =?utf-8?B?UmJ1SVdBbXBRa3JYbkQ4cDBvRGFPTUJQVTkrWTFZTndLakFkdzNsTlFUdFFQ?=
 =?utf-8?B?U3JKVGZlWVZUMnNwcFYxd01vVG5GZDRISjJoSDVRczJ6Rk0yQjNKdUY5anpG?=
 =?utf-8?Q?FXJ2Me0oIyMFgj6Mgf5+c+SsG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f596932-218d-4bd2-a2d4-08dbc525dcac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 22:04:21.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBjGMXYyrktGBLX7d7qR8qH9euTvH7igrtIGobhhyrQBcmipMjkcSQoIOcWLOXKa0pjaCyQbP5JfTethsFzr+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 10/4/23 15:02, Dave Jiang wrote:
> Add a helper to retrieve the number of decoders committed for the port.
> Replace all the open coding of the calculation with the helper.
> 
> Link: https://lore.kernel.org/linux-cxl/651c98472dfed_ae7e729495@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Ignore pls


> ---
>  drivers/cxl/core/hdm.c    |    7 ++++---
>  drivers/cxl/core/memdev.c |    8 ++++----
>  drivers/cxl/core/port.c   |    6 ++++++
>  drivers/cxl/cxl.h         |    1 +
>  4 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 4449b34a80cc..1b1ba46decfd 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -643,10 +643,11 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		return 0;
>  
> -	if (port->commit_end + 1 != id) {
> +	if (cxl_decoders_committed(port) != id) {
>  		dev_dbg(&port->dev,
>  			"%s: out of order commit, expected decoder%d.%d\n",
> -			dev_name(&cxld->dev), port->id, port->commit_end + 1);
> +			dev_name(&cxld->dev), port->id,
> +			cxl_decoders_committed(port));
>  		return -EBUSY;
>  	}
>  
> @@ -844,7 +845,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
> -		if (cxld->id != port->commit_end + 1) {
> +		if (cxld->id != cxl_decoders_committed(port)) {
>  			dev_warn(&port->dev,
>  				 "decoder%d.%d: Committed out of order\n",
>  				 port->id, cxld->id);
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b547c07f54..cb88a2dd723a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -164,7 +164,7 @@ static ssize_t security_sanitize_store(struct device *dev,
>  		return -EINVAL;
>  
>  	/* ensure no regions are mapped to this memdev */
> -	if (port->commit_end != -1)
> +	if (cxl_decoders_committed(port))
>  		return -EBUSY;
>  
>  	rc = cxl_mem_sanitize(mds, CXL_MBOX_OP_SANITIZE);
> @@ -191,7 +191,7 @@ static ssize_t security_erase_store(struct device *dev,
>  		return -EINVAL;
>  
>  	/* ensure no regions are mapped to this memdev */
> -	if (port->commit_end != -1)
> +	if (cxl_decoders_committed(port))
>  		return -EBUSY;
>  
>  	rc = cxl_mem_sanitize(mds, CXL_MBOX_OP_SECURE_ERASE);
> @@ -242,7 +242,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  	if (rc)
>  		return rc;
>  
> -	if (port->commit_end == -1) {
> +	if (!cxl_decoders_committed(port)) {
>  		/* No regions mapped to this memdev */
>  		rc = cxl_get_poison_by_memdev(cxlmd);
>  	} else {
> @@ -293,7 +293,7 @@ static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
>  		.dpa = dpa,
>  	};
>  	port = cxlmd->endpoint;
> -	if (port && is_cxl_endpoint(port) && port->commit_end != -1)
> +	if (port && is_cxl_endpoint(port) && cxl_decoders_committed(port))
>  		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
>  
>  	return ctx.cxlr;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7ca01a834e18..16efb68eacfa 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -31,6 +31,12 @@
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +int cxl_decoders_committed(struct cxl_port *port)
> +{
> +	return port->commit_end + 1;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_decoders_committed, CXL);
> +
>  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 76d92561af29..2728700d8b33 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -679,6 +679,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  	return port->uport_dev == port->dev.parent;
>  }
>  
> +int cxl_decoders_committed(struct cxl_port *port);
>  bool is_cxl_port(const struct device *dev);
>  struct cxl_port *to_cxl_port(const struct device *dev);
>  struct pci_bus;
> 
> 
