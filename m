Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03C224DF
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dh+A2Jti"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45B4B7
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697237979; x=1728773979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b/HHGCxcL70iDUiCTT23ONzaMOJgVZEW2sXJGSmgxmQ=;
  b=Dh+A2JtiZ+EBM6gUZ/udQ7vCdRaguqLLs8bBqsCjnZc0XXcLwufKjyba
   LVmUY/KV1tctIRuu0dUKOYMYMihfHrFhGLQ+yz/PASA6K+5NzXZzS03+G
   xGzAfNqXZ49m+rcNGuIV4umr6YQOB7DAiVEi8YKYPJYn2Rc4Ao2i5nBcf
   3YfTnWM+R0JFZiVRs0KqoFDhA426azRzRrlie0uMv7vr8ex2t1lDmoUD1
   HCDeynnq+9S0lV1246H3+uN8btP4uvW+4kYqPS0KU4NDfFXiOxpHqCZwG
   1ogBHPA6mNIRnT0trRJ3aob0bMjrNEUOJBJsM+p7JceJ0oZ/PWj+bxgeF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="6843983"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="6843983"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 15:59:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="748521321"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="748521321"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 15:59:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 15:59:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 15:59:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 15:59:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 15:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U46xI/8wxVHSXQ7GTRNwN7OBMxaZ8Fjj1K5xeYRtd2Y19k9Qw4/4v9uW1wGw6bbIxmTWjlGYDVaZI7FwIGYs74Tr/u9VLLGTjNkcLAY4ZWR1FBAyevIPyhjZB91XvcACS2ciKSCbzDQAH0xFskhtEKA0BtcHtVTEepeEOZ1GguKcxSGG2RbIE3KOeSBOz7wHxv0Hhz2mIIBGMpJ1WhROApP2l/akjiHkRlCejASlNTcjpnrbrM2ycjS6Tu9XCByBRcyPWCVRM1mh+jk4TQNqKPh+tBUxeeMzxA9dAuA9d/gBQCqS/zuzcleKTaZS+0kSs6m0MXrRalnvUNPYBvUbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyEI/MDFCLbqRWIyBImueh74nt5OxYE+sPRdpFrSbqo=;
 b=X8Tic7gt2hAGKn+MIc7KeG6qDT0+E1GccNdb12CzPBEOMCbaYzygkH4MddhLqFS4z4W4XT+LB2dTkXUCgCGt/bIiBOb422SG5tguzoeT12zAfIIiM2gxHJ8IOM1Mmga12mp2ocHzqEq/7HibBewcJZaXMGbdH6wL2YHdH8fZOtB129mG13EXjhNXiRAJJHbRSpZWHR1FurTps7mht7EBwz/QjDKEnH7iVhYIWSiQi79+XI7UaEcEqfT+QTbiTHhKQgLi1C+hDf5PcCs/woeaBrMH6zFny4yxy5qx/DrDWuV2lgEGZYt2Dsr6LQUBgGHkA1a404sPiZusorGg7vtNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:59:26 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Fri, 13 Oct 2023
 22:59:26 +0000
Message-ID: <14c1c609-3b26-4691-8228-902cdbd639db@intel.com>
Date: Fri, 13 Oct 2023 15:59:22 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 1/2] cxl: Add cxl_decoders_committed() helper
To: Jim Harris <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>
References: <CGME20231013213154uscas1p2995ce0b20ceed38023c42ace0b6db096@uscas1p2.samsung.com>
 <169723269532.66903.10556183191413240496.stgit@djiang5-mobl3>
 <3CD88963-27CD-45F7-BB00-616F44D39EF2@ssi.samsung.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3CD88963-27CD-45F7-BB00-616F44D39EF2@ssi.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB5423:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7ecc5e-1fa0-4e3e-0c6e-08dbcc400c3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3lkZGVf5d4CgokwsCci2YhYlDZkTk7jjzdf+XzeCt6W03g/lUavpzvvH3lB2/VcY5beLewA+/WuctXLVbMF+RjVrKqEZJPlWFQH85mhmDwCh/+6ny/tjbT7Ota8ErbDbPY2/hJ5bAiHFKtt7X3KF/LtaBu9WGM405eGgLNY4NseTFBqUQaIzl8Q7shUJCmI9/WjwmwD2tLYBL2aokEj0dCSkRZaXeLGta4GY+PwFVMGFrwA/X22g0l33OK4sUgdp68BdzaquxQFbh4CFt0KrFP/Mv+K1cgUjH9yNdJU83sEmS6V4FH7mMqSAVbMAoKJGT+RAywPTeqPSjrDaGUEPHebiBnuK9knZWcdcP5ljVSCOJYcmb1sYNGrJv3rKUAqlNYKzlG9veqDlkZmrDO5rlFHh7ck6T5Wbh5ZH6EvRFeSuJALTn8iIj8UeK7bDlVSrIG3MjVZlXf3DwqLXaFywF0D7A3vbMpE1fNGsfk9+P++OB9NcDhp3dwirYDDAtIoi9j7Zsakc1WX4NO3RDuvSaJs5QRryq4U/+xCpVLQb04NiVqT6pmrCav57cgWHepCkBRxaMDBA4VyViIEeS0CTbmeY3yfHUivGlgvNhj4fCRBJ5ATQZ/ASofHUSU0SR/2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6512007)(478600001)(83380400001)(66946007)(54906003)(316002)(66556008)(6666004)(6916009)(66476007)(86362001)(107886003)(31696002)(6486002)(36756003)(26005)(2616005)(2906002)(6506007)(44832011)(82960400001)(53546011)(41300700001)(31686004)(8936002)(38100700002)(8676002)(5660300002)(4326008)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1FYMnU0RjdjNUFmR2dkVzJsa0l3R3JZSG1vaU8xM2lFUVBnUW5lSEU0OHo3?=
 =?utf-8?B?K0lzNnYrSFdLR2hYWUJIMGhnc3dvdDFUcmJoMnBGS1NYWlFKUkNid1Zta1J0?=
 =?utf-8?B?OGh6QWJOY3VSUmgzbFZyWEE4NFpFdHlUeUYxbVFwMHhONXhSajF0bGRaVm1H?=
 =?utf-8?B?ejhrTkxXUHlqQkwzOTM5eVFBYWNqcCtqNzdwYXRtTGkrSFpJc3lBd0Q0ejVu?=
 =?utf-8?B?aThtWEVha0tkeDNDa2xSd2sxWXFveEhVbC9haGdKZ0NzbE5XQ05aWHRkZ3Nx?=
 =?utf-8?B?RHJKak9vY1NLYmp0MFk3M1ZoMlZoT05IV0ZDTUwweVdlRzBETGVRS3BFcUJO?=
 =?utf-8?B?cldaTzJQOFpCN1hpYmVGdkN2d2F6NWVSSVo3WW5iejJ3NzhZc3NoZWZGbE9M?=
 =?utf-8?B?Zmg3dWpoT3FWaldLelMxaGNiRG8vNG83TG4zNnFxUzhYd25JRmJSa25sZzJM?=
 =?utf-8?B?azlvbkhCeHM1dkE3OURWOGNFM3FudVArVlpsaC9nSlAybWNVQTlBREFHMTFU?=
 =?utf-8?B?ZnNTd0hLdmdXTGtXVjk4QUVpMUJoN3lwMzhXUGt1aGJicmFrQ1pZMkF4T08x?=
 =?utf-8?B?Q2YzVXdER1pnc1liQjFiZUZicjMzS2s2bkFPVFNCMVN6YnozdFF2SWxpVS9E?=
 =?utf-8?B?Q2R6eDhYZEhuTjF1eS9HeUhFaFkrbi9qTzdsL1c5R3dINjk0VXBYd0F4OVlo?=
 =?utf-8?B?TDNYdmpFd1FoVWREbkEzSFZFRTNwQWRPUDRpTVQzcXo0ZkJrVEFQaGM1L0hK?=
 =?utf-8?B?Vko3cHVVdDNuQ1ZoU0cxY0RGMXU5Ky9xVEdtOFVYTVNjQ2pick5kQ1ZHSVZr?=
 =?utf-8?B?R205OU16a0dKa2ZvaE5VU1NNcXhNV1FCNE5rREpFS1hURXJMUW0wdUxPcGE3?=
 =?utf-8?B?Yk1TNk5pS0J0QmtwL3VGdE9vYlBiWG9rc04zTVNRWmZvVDlrT0JUU1ZYUk5B?=
 =?utf-8?B?bDJIR2ZrSnY2UDBoRkR4VXF3S283WjlRS0FhTDBQUC9JUG1EZWVMOHpzcDR3?=
 =?utf-8?B?L2F4UTZLQ3IwaUZaLy94WDVkdWF4bzFZU3dBclRkcm5PT3ZmdCtPMGI1ZHcv?=
 =?utf-8?B?ZUhPVDZIbWVqU2h1cS80dnR0MGloTElDcXBCZ2JiZTRXRTI2MFp2Tkx6Z2l6?=
 =?utf-8?B?SVVxUmVXdFoxVzZ2R0hKb1pSc1BuUEFZbC9LYXk5Nk1lNXcwUk9PTmRFeE1U?=
 =?utf-8?B?WXdVZis4QkRNWDc0WXFGdWpRTk4wMmpVaitRMTF0SXJGWUlhTTZVMXlIYWls?=
 =?utf-8?B?OGtYZU1XbG1aMndtbmxjVmZVVmJ5aENpWEh6dlFnN05pbXMvZGFSWjUvZGth?=
 =?utf-8?B?TTJiYnR1VFNTakQ0aEJZRStkbGdiNzFGYTkrZ1NFaGEyZHVNRkc2Rk9Sczkv?=
 =?utf-8?B?SHVSWUJoVzlhamtzb1ZyZndYR2dsTkdQQi9xem02U25xRnV5ZElhV3hkWVA3?=
 =?utf-8?B?azlNREVjODRUdU9YSS9FSDAxRk5aVmJwTHZDNjdqZ2M1NW10WlFvSjhRVlpF?=
 =?utf-8?B?YTltaDlDdm44T1ZUNy94dFZSNHBhRC9sTUMyVmVGaHhiNU9udnpTT2NvUG84?=
 =?utf-8?B?K1VrbGI3WXZNREJSQmJPT3VzV3dDVGdYSFYwTWV4Q1BraWZLMXNhYnBtTHhn?=
 =?utf-8?B?bWtrbVZUbTVnaElxRi9jOWVXRkZhd2NEeUVKeE55bUdJK1ZmMVQ1UnRVTTJD?=
 =?utf-8?B?UlJKT0pGQXNCdC82UzNzemNhWUwrMEtoanZIbU1yZ1pSdzRRYXJaaFlLNTdk?=
 =?utf-8?B?TFRFMk82dnRKajNsYWdJTmxHNWJMcDQ3OVNNOGpOOFVnUmFqZ0ZoTXF2QnpO?=
 =?utf-8?B?eHZwTGpQN2NEd3ZUK3hCZzJZU3A4NzFwMHBWY1RnRVNFTHEvbWtLVkFENGpL?=
 =?utf-8?B?TXpiVkRZVHpFditrNlNXdGdVeGozR1cyZWRlelo2Ym92Z0p6NTh2UjhTKytB?=
 =?utf-8?B?S1ROZTRvVFdCeHZETUVmQ3VGV3FhMnpOOGN5V2xGVjRVS0F4cFJwNlNCbjZV?=
 =?utf-8?B?MGRISEIyTjVCekJaei9iV2hkTWlxZDR6dFo1UWVWV1FMdEVydEhjWnlBRW54?=
 =?utf-8?B?RndnbmpjUWxWRHNPMkNGTmE4Z1pFU3VyUm5vRGZVdVF2bDNxRHVkSVlDVHdS?=
 =?utf-8?B?MDVDU29xeG5Qb3VhQklpUWtHdjBTc04yRnAvZEtpbDZiemVlcVQ1elJJSE9y?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7ecc5e-1fa0-4e3e-0c6e-08dbcc400c3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:59:26.0059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpGSMX5rqs03/D4CUx/XEOyYuvnlDCqLJJ5W3R2hUNyKXr29TOg+tMgyeCXgKTeGdT0RXa+ymKxNsGubMS6gjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5423
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/13/23 15:48, Jim Harris wrote:
> 
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 67aec57cc12f..6e6a87abfa9c 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1200,7 +1200,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>> * Require an endpoint to be safe otherwise the driver can not
>> * be sure that the device is unmapped.
>> */
>> - if (endpoint && endpoint->commit_end == -1)
>> + if (endpoint && !cxl_decoders_committed(endpoint))
> 
> Hi Dave,
> 
> Maybe compare to 0 instead? This avoids misinterpretation on whether
> cxl_decoders_committed() returns int or bool (i.e. “are there cxl
> decoders committed?”) without referring to the function itself.
> 
> cxl_num_decoders_committed() would also make that more clear.

Sure I can make the changes. 
> 
> 
>> rc = __cxl_mem_sanitize(mds, cmd);
>> else
>> rc = -EBUSY;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index fed9573cf355..78b6e58e0a31 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -231,7 +231,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>> if (rc)
>> return rc;
>>
>> - if (port->commit_end == -1) {
>> + if (!cxl_decoders_committed(port)) {
>> /* No regions mapped to this memdev */
>> rc = cxl_get_poison_by_memdev(cxlmd);
>> } else {
>> @@ -282,7 +282,7 @@ static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
>> .dpa = dpa,
>> };
>> port = cxlmd->endpoint;
>> - if (port && is_cxl_endpoint(port) && port->commit_end != -1)
>> + if (port && is_cxl_endpoint(port) && cxl_decoders_committed(port))
>> device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
>>
>> return ctx.cxlr;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 5ba606c6e03f..fd1cc307759f 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -37,6 +37,13 @@ DECLARE_RWSEM(cxl_region_rwsem);
>> static DEFINE_IDA(cxl_port_ida);
>> static DEFINE_XARRAY(cxl_root_buses);
>>
>> +int cxl_decoders_committed(struct cxl_port *port)
>> +{
>> + lockdep_assert_held(&cxl_region_rwsem);
>> +
>> + return port->commit_end + 1;
>> +}
>> +
>> static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
>>    char *buf)
>> {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 76d92561af29..2728700d8b33 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -679,6 +679,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>> return port->uport_dev == port->dev.parent;
>> }
>>
>> +int cxl_decoders_committed(struct cxl_port *port);
>> bool is_cxl_port(const struct device *dev);
>> struct cxl_port *to_cxl_port(const struct device *dev);
>> struct pci_bus;
>>
>>
>>
> 
