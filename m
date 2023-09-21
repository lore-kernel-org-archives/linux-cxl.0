Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DED7E7D0A2
	for <linux-cxl@archiver.kernel.org>; Thu, 21 Sep 2023 19:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjIUTF6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjIUTFE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 21 Sep 2023 15:05:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C96C4B738
        for <linux-cxl@vger.kernel.org>; Thu, 21 Sep 2023 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318666; x=1726854666;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DutRzpJ1dKXJ4NNRGZPUR/jTCOAKUAaBqTw8w5C6aSM=;
  b=C/17pXC3DoTmD9FqYlf4vUYV8/V39qz74Ji/6/cvpXly6uGvF0gxRdJ1
   ObCoOTN/t2YIPHT6OLp+VlnaKlLEnizAwAfcQgdQoolRIunomuMRK/eCP
   riMX0IahCU2lZg+KKhRFq2ZVeeIxpCeRXaokncFxjSzDHRXC26GtcKld4
   CBxD0ILkzPC3cHrsZbd5GjIX3wY08i0Kp+3Bb5tjRvD5vGQZgYceYFicY
   wU0hvRuE0z583PbB1KQkCrFjG0U/+ej0x9hc/hcJel7KN7p66NdWzet4p
   OjSECKZancfO2fcIr7ZY0rH7hlRueZ9CbQDn+zL1XicXQueHQ4EjcFy1n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="384446582"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="384446582"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 10:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="994168256"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="994168256"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 10:24:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 10:24:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 10:24:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 10:24:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 10:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVYQwSJOww2BmKMpmjZaoDEagtwjhJdISrDXKQhzuTl/koVEsJtnIHENKjbw21kMZltAe+e6kGvIwlg1c/qKSG4hC72Ot5otcYRyvrHwsIqybn6wuASRG6HhxruY8dOBYmyfFic0BB9PYIV6Ct978g8i5qvoT/DRqHH4RkEk/dZyVANFA9T4lh445nhNvTCNx8xJyuSL+Ef4pKaQPYHIZxAGUMhiulBfHR4sBwDhc4Vwf7fVum7KAtJsHdm3xI5pBCvfW472hvI+WXwY2Ar14yy+mNj88KQHYZ4N0i35uGe9K3j1AXnwEpf67plN6ORzSbnKAfbzSm41l2L9s6dfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp3G94h/cKrfY1Gi4FevR5XalDkx6faVgup8S5cqPQU=;
 b=bbsIN6OB6w2JfNKvGcLosW3CAZPS9C1+wQXgI5JUiIy9Lm3n4heEwaGlcCLMnOI+kWqglhsIOT1Hdnc8fyXQUEQ1QiFTeMCTb/at1g7wMvwtRLmuz5lP1a3WhyW5aCOS++CbQHcVMk5XooD4WkoA7oBhmHOm2WBkj4r429t6G5ATiRFznXKUMN3H+7qmayFxsiH7GKg9PJRJcxjUmfsLpb4KTbOeqUG266e7XrD/Y2Cgm6+a9e7NLUatcR+O5JekS3Cboic6qxCPz7dk4OpbGaXB4H3+40yQSTgWxydVpH6YzKs8YKmvmONPzGZyi/Q9CnU28Rgy071DH/esoKzi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Thu, 21 Sep 2023 17:24:14 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::c542:a94c:fc8a:52fc]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::c542:a94c:fc8a:52fc%7]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 17:24:14 +0000
Message-ID: <721dd264-939a-e791-f7de-e229355ebb2d@intel.com>
Date:   Thu, 21 Sep 2023 10:24:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v3] cxl: Remove noisy dev_dbg() outputs
From:   Dave Jiang <dave.jiang@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <169524300432.3077964.4526387988891514104.stgit@djiang5-mobl3>
Content-Language: en-US
In-Reply-To: <169524300432.3077964.4526387988891514104.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DM4PR11MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8cb21d-4419-48b3-3fc4-08dbbac793c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBKp71Gas1ywDhVZhAunidLUid8uDQB2oU8ubcmBlUDUvPwttiB09vUmtTrqFpZTBUjOXdJJ4R2Rr7bw1UBXrH5FzSgJ+r8pAyva1jSHcxPmOMFoEh6ucNvf9xnxwEy5FQkqNyYTpoTDwvplg3+k/4CQYMcC/JWaFiCV/utTGkCvVcEhT60BE6YGqwdQJMN2OAbKc40hhu763TqTATkRu5OjTMqKE9gLC9frvVo6foZNjbpVRgg13vd+SW/vBS/l0emgL1bzPTayVeNWJz0InR8r8lxQwNcQbxSMDktMHIvmByleXYx5gEdXuVO+/lXgI1jYCD8o8nQSKB3619T5OvXkVnd7aQXUFoWimiyHtYTZUREBhCLz5QZNImb9koAGioyI6dHOMdPPLniXVZWdIXx2jOpmgUxBjDYF9hgJSGS+qebIXYLsQkrVyl9abnsquQlafNLgkQ/QK/XCct4y+2PieW5Osxhjw4SPZYXhPKR7B7Ub1vYPozsInNp0KS/odiyLRihz0URRUmArgrH2PHn8d55vmqd3Haw+JD1BbuJ2lvAQq+Lmn25xzEkaqMCvD0RQULMqBFtkvpz02f5SIbFMm98sDKkQkpHl4x4cbRbfSuVLAE9SD94nobQfOUSspa9Y7iUBmckqSs+sET3Lvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5990.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(1800799009)(451199024)(186009)(4326008)(8676002)(8936002)(41300700001)(5660300002)(44832011)(6916009)(316002)(66476007)(66946007)(66556008)(2906002)(36756003)(82960400001)(38100700002)(83380400001)(26005)(478600001)(966005)(6666004)(107886003)(6506007)(2616005)(6486002)(53546011)(6512007)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUdsbHowNTB1cm8vckxtZVJXa3VtVytpSExFZVp2cFR3ajBKT254N09vUGhl?=
 =?utf-8?B?ZEgydTdVem9wczU0LzNqclgvYlJVUlNwWW1mWVJWaUtLTERLN0VYM0xnY2Fh?=
 =?utf-8?B?V3d1TFdweCsvTWNxNG16WEM1SFF6WWgyMGNHb2l5SWg1QU02RDdmeEh5MmlI?=
 =?utf-8?B?VUJPTGxxemc5b0gyei9Uclp2UERtTWZLTCtFb3NCUTl2cENnSEVtZHRnVysw?=
 =?utf-8?B?WEE0TEc0VVBTc0NuSXdEd2FGSG5VZmxrU0I5bFM3VDk0WW5HZGhSYnBZTklD?=
 =?utf-8?B?Uy9Pa0h0VUpvU1Q5eUtzTWVCQ3ZjMzA2Nko3RFBodklKdWI2UEgrYU5KRWNa?=
 =?utf-8?B?N3UvZDdwNDNJbTBvQVUyYURPajZka2hmck4yTDgwUzcraU8wdFcxSEpIZlBK?=
 =?utf-8?B?dW1hT01CcnZncVNOZTdLZXhaYi9CUERTb1doV281bHFxcUlyN0YrVnllMGwr?=
 =?utf-8?B?WVlSV2JjWWNXUjAwNXR3NDdCZWYzSTA2TUZrcTFLMW41Nnl5VW1JRzB6Q3Bp?=
 =?utf-8?B?Yk55Q3pzV3NlY0J2N3lzTWE3U3FQUXdvcGhtaGUzQWpYVmZhOXpvbFg4S2tr?=
 =?utf-8?B?cDljUytPNFl4VXczUytEQ3B5cHFjeUNjaHVzdHU4STFwbDN0NzEvOWtUbzI4?=
 =?utf-8?B?L0l3NUQxbWR6VGtEckYwWWJuSlhGT0hXR3JSMUZVZS8vcVVBcDd4dnJFUUho?=
 =?utf-8?B?M0UrWnFzNWZSOVhzb1RmQU1XaHJ0cEhEVXFEam5vTmp3QmRpaEd5cGlsanRw?=
 =?utf-8?B?Q1JZRGFkd0hVeG1pRXlQaGxJVnZoL3dMMFJKakRSZzBDZHVkVGg2ZWExMDha?=
 =?utf-8?B?cHdaMlliODkxNjcwTW9vcmZsSHdxd0FNYXJoK0QyT3BWanVlNEVwV0s0enlh?=
 =?utf-8?B?dDhFd254ZHZadGdlcmo0TlpCS0k0cGJxQmtiZGRWNk50emZRRVFDbmlVTHh3?=
 =?utf-8?B?VWlxV1JBNU0xZUtMVi9DQ1pCYXVwMnVzYkpUaWN6aVp4OXFGeVAza1V4UFVW?=
 =?utf-8?B?SS9pT2x0bFhIWGZvNFN3cjRnNXd5VFdORXNBNmk0c0ZtNnord2NqeVRLT09R?=
 =?utf-8?B?a2NsTndXcXpoYlhLMnArN2wwSS9tY1hCR3ZLTlowdmtEOFY1WUhDWmFhYXRW?=
 =?utf-8?B?NFRsazZ6R05Nd1NBb1NCVE5SSjBjaTBoK1NMeXVERlk3N3pOYnlZOE1BNkdZ?=
 =?utf-8?B?NEhLamMwMDR1V0QyYmxORkR6SWVZempNNXExQjRWcWs5c1NIMXNwK0Fzc1Nv?=
 =?utf-8?B?ZUlwSUZnK0dzZUljUTAzajcvNjNQN2VFUjVFWHA5c2ZjczJ1RU4vajUzWHp6?=
 =?utf-8?B?dm15ZlY4MmxEc1BhNnFhaTVGV1JMZUpQVG9VbmdQTDM4K3YwZ0c2d2pwRVVz?=
 =?utf-8?B?UGRtdXV4UFo3YUNrYUJjblVJMUFqMFRvT3g4bXF5aTZFaDhMNzBIR0NoSmlo?=
 =?utf-8?B?UGdBS0hPWEpBeHRUNjV4alZoWDhOdG43cmYyR0l2ajdMa0pKN3lVZnliZll0?=
 =?utf-8?B?dTQvZm1VaVRHeVp5UGxHbjhVNlg2M1NSa1d4VmJMUnJlY2JKS25veE8vUlJL?=
 =?utf-8?B?aWV6clQ0M0VXd2VCVmdMQnN0RkFCNkU1eW9samRUdzdIbUZxUVBJYll6b1Vl?=
 =?utf-8?B?S2l6Uk1ld2N1bnBkVk9xS1dyWS9rNXQ3Y1VkNTZQZURXNFhSd0NKOStBSHA1?=
 =?utf-8?B?WXkxaU9DKys1YngyWjBGN2hlZTRSZmJUbTFudzNHcEl4WTVQUy8wVHdMaHVy?=
 =?utf-8?B?eFY4U2w3bkcxZjFFcEFiT2YrV1h2MDR1NEZWUnhQMXh4UzY3S2hyTGozQ2Y3?=
 =?utf-8?B?R1R0cGtjSSszaEZna2tWS29wNTF3aHBQQ0RWNzNxR2k4Zy9Obit1Smo2cGIy?=
 =?utf-8?B?aWtoNzNabUx4TXg4QlhBRnNKc21UUXZNMGxuTGZTeFJvdEkxNVk3ekRYM3JK?=
 =?utf-8?B?dFBpODFIeFBacTRLV2dJZDdlYUNUdS9FUmpZTlpxSHhDcEdwWmxCaUxKOVdU?=
 =?utf-8?B?SjllUFNQbXQwUEZOQVJvYkxucFZiemcvLzBLNjdmRVEyMHg1dFJ3VVdTaStC?=
 =?utf-8?B?RDJpSnhjL2orWWF3NmhSdjErb3llTUxTcFg2YjMzN1hrS1JWb0cwQnhldE9C?=
 =?utf-8?Q?pzB8TNhz6DLYW7X89bT2N9s6b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8cb21d-4419-48b3-3fc4-08dbbac793c9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 17:24:14.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCCS7f7rGg/5/xg2PYa9yfVppNMu9BuxBvb3tvZX27VDUnaz24EaqMntZmcs5F/0FL48lmgeWDXYbKWplJ506A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5296
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/20/23 13:50, Dave Jiang wrote:
> Remove noisy enumeration of commands and CEL opcodes via dev_dbg()
> emit. These outputs were useful during early development. However they are
> now unnecessary and creates excessive noise in the debug log. On certain
> hardware up to 500+ entries have been observed.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

After discussing with Ira and Dan offline, this patch can be ignored.

To reduce noise, something like this can be done instead:

options cxl_core dyndbg="+fp; func cxl_walk_cel -p"
in /etc/modprobe.d/cxl-debug.conf


> 
> ---
> https://lore.kernel.org/linux-cxl/b72946f0-31dd-b22a-f2e8-a12eb2f522ae@intel.com/T/#t
> 
> v3:
> - Drop eventtrace and just remove the dev_dbg(). (Ira & Alison)
> v2:
> - Add enabling note in commit log (Ira)
> ---
>  drivers/cxl/core/mbox.c |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ca60bb8114f2..963c668a4eb4 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -707,7 +707,6 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  {
>  	struct cxl_cel_entry *cel_entry;
>  	const int cel_entries = size / sizeof(*cel_entry);
> -	struct device *dev = mds->cxlds.dev;
>  	int i;
>  
>  	cel_entry = (struct cxl_cel_entry *) cel;
> @@ -717,11 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  
>  		if (!cmd && (!cxl_is_poison_command(opcode) ||
> -			     !cxl_is_security_command(opcode))) {
> -			dev_dbg(dev,
> -				"Opcode 0x%04x unsupported by driver\n", opcode);
> +			     !cxl_is_security_command(opcode)))
>  			continue;
> -		}
>  
>  		if (cmd)
>  			set_bit(cmd->info.id, mds->enabled_cmds);
> @@ -731,8 +727,6 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  
>  		if (cxl_is_security_command(opcode))
>  			cxl_set_security_cmd_enabled(&mds->security, opcode);
> -
> -		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
>  	}
>  }
>  
> @@ -787,7 +781,6 @@ static const uuid_t log_uuid[] = {
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mbox_get_supported_logs *gsl;
> -	struct device *dev = mds->cxlds.dev;
>  	struct cxl_mem_command *cmd;
>  	int i, rc;
>  
> @@ -801,8 +794,6 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  		uuid_t uuid = gsl->entry[i].uuid;
>  		u8 *log;
>  
> -		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
> -
>  		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
>  			continue;
>  
> 
> 
