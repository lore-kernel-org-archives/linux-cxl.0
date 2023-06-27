Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829ACEB64D9
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Jun 2023 23:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjF0XBi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Jun 2023 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF0XBh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Jun 2023 19:01:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5064D2940
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jun 2023 16:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687906896; x=1719442896;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zmGUe7EY9xpBLVkrTG/k3COs5fX9H86HQ20uL93Z+zo=;
  b=V1kkzL1uVx+nOYfDfTX3p2S6HWdKFwjyxoYAyP1oTy7XKQ2LstN2AQld
   DH8ZCH/Ta2BFu6Z5QERiGxxvIM1OYTdAlgUC1r9dkEcjpXwkxokD7siUI
   AdS2Ymycr0W7Bple//t6by8kHkO/di7TGXbeWLYUy7Q1jdPZkX/cZXmqa
   LMXYyHDP+bCZTYjs3WrykkXjUn27p9obKz6cWHI2GXIc4xeYpktvbbL9N
   QpE4kBuQdJTnFIIeX9ijDnmB5faYIQcR9Ss1b0Fawf12JWRP4k8eVIwvY
   jm4GkWKtFUw6VJ05XHJDH3PxcbZTXaQATjZ8+S5wF5hjpk6Mdt4oS1u/o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="346462607"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="346462607"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="840850717"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="840850717"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 27 Jun 2023 16:01:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 16:01:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 16:01:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 16:01:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ner1/9Tl6CvNTzRWd/dYTmxG17cIfYIcL1SEN8Bj/D9vi2jfGjk6RJZO2PmEd7irV4tGKBTrpBXP8I+byp+7zxndrKnhVfjxZPuQCAXiLgFxJxWyowOm2Okv9XXEhElYjD/pTx30Evcw3QumXRFru1wubL6jb/zuhNPCOsAyX0CzT/edb7yiVecHpHSobOl8gfPsqlvbObdjtkVj5URor6I0TnNVDl5AZ6ETZayT3180PJ6tfx5n9tsVl2GDy12U/P0HzQQ0vctTHy++V2JvQKryXHBMPYEgaHpS+Ax0SQh8zwiLfUw4EC+gJUrSNv5C3cG2csG25/4WA5BwQxNVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVX9pEagqzEX3FyESlQOvImovoZZxS2FtfJHpYIbAjY=;
 b=IllGtB3mj1ZGipT5vp0JQfb2ZMHDkmGP1+sEq54Q9XtiaKjjhVuPdML3RWpiRc0cmRKg0LUE35qiqIDV070XiZ48m3jKskVvWsAjBdNyJzOaHeZMA3glVKBW4t0Uv6GZhRN7k7hIF8dSq9LXiLEMDGWqhSuq0gg71mm/mqfPoeQFz9f5Gh5xaamx6yxGHgvHtliAXC7Ar/vG9/wSPZcE70rU1YeZH51kEdvFuWy5jFzezMbwC/ZDe7cR5JhfNH0k0JJJzjBfC4PvpOe9PgNX6UqwE+NCPeNYjrkulskZljj5i0ugYWg7L2R6J1CdgkgeOZOqEOf0w4EVsflv1UKI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6551.namprd11.prod.outlook.com (2603:10b6:8:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Tue, 27 Jun
 2023 23:01:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Tue, 27 Jun 2023
 23:01:15 +0000
Date:   Tue, 27 Jun 2023 16:01:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <vishal.l.verma@intel.com>,
        <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/pci: Use correct flag for sanitize polling
Message-ID: <649b6a384f56b_11e68529444@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <6498c35a934ab_8e178294b9@dwillia2-xfh.jf.intel.com.notmuch>
 <ll3imaqzzqkhmsa2r4rxxzhmgnpoayuasb3ay5dfx47f7avco2@j6bmlcelamco>
 <649a1583f3331_8e178294f6@dwillia2-xfh.jf.intel.com.notmuch>
 <7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx>
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd43248-386f-420b-dfdd-08db776268a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIHwPMCIKlhCiuGcX9O/H4Me7o6g66MnRmp3xlrOgMg4gg3tIAaqobT/2nejJrPOf1223WFRYhVSchxtQ0Ca289OVWhKt4ug4gRZOISp24gQjF8NKaA8oNqq/idiQSQcZvOrrQKi9kPAFeDjDgWNLxIV0ZjHmCTkTLW8tnCXUJN+s8Kz1vAAf100jE1OqxauJxSFtR2J84Wp6+uLxRfem/HbWKZ0z/JhJF6K/odlxLvatgkBzTwV8TvA2kRk8ZpgAmy/QCV2Tq2bV/yLZ8r32yOj7yl6fMkVQTdmZjm2u4S99iacj0IJ0LQCAhokLMld6wQhrEEFAAc6sBMcmAbLk4SvpejLgCm7vqOpGcKLNHft+TqeKuCJwFer5BfZowSpMDxHXHWpeCN2j4JJozALDGdn3GcXQiw3ZqrhgiWFEG2+PYAFRWTitCi4yox7Nio/LEikNX4VTKCFqSc2PmlxyR4R1sYTqIau7q4XkAUJcSfHJYAWJfu87CZp9M1METcESTNYzUS5p1dcf1wUBPUeyZ4YT0jNBCtL3YMpZk1Ibtk4oxUge/LTN5JJmNlO+BMqEfwix2gClouCowaWrT3q3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(82960400001)(38100700002)(86362001)(84970400001)(4326008)(6486002)(41300700001)(966005)(8676002)(5660300002)(478600001)(6506007)(8936002)(6512007)(26005)(9686003)(186003)(83380400001)(2906002)(316002)(66946007)(110136005)(6666004)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3puZlNRSmhtcFlDTUF1NlczNTdOM0NlTDNPMmJrZDd4QW5od0FEQ1hiM3R2?=
 =?utf-8?B?SHJVVTVjbXovWWpZcDdSdEh6dzNtSUtmQk5seXBRemN1YTJ1VDVSOEpXcHlL?=
 =?utf-8?B?eEdaMjlrdkVHMVBpQU5Pa1hlclFqNHVvUnBYaEFQY2lRTFh1eXBnN3pKZ2tJ?=
 =?utf-8?B?UlJJRGlWbTBIdVp6bWFHdGE5azlsTWtGdlhFNUx4cTN3R2RRRHpKYkR1bjQw?=
 =?utf-8?B?Mm90Q1pCKzZSMmZkSHdOQ3FwTWNVRHpIVFNJT1BrbVU5R053QXpFMnFNdkUr?=
 =?utf-8?B?bENmZUhZS1dIWWFPK3FGTXNSQnRCaWM0QjFRM3dGeXRzL2Rta2lBaWp1eVV2?=
 =?utf-8?B?MURwOEt6bmhLMTZ2dHpQa205R2pmaHExNERDcWVuc1pFQi81RHpwelNENExa?=
 =?utf-8?B?ZFRoOHYxNkp6UGRWWks2aU05VVd3ejNLaTJxdUxTT3h4WUNpTHVwU3l6STJs?=
 =?utf-8?B?VjRDYVhmc3FIaGVkRk5BbjFsZW9tY0JPSXVxcDkrcEtQTW84aXJQL0JnM3NN?=
 =?utf-8?B?THJGZS9VcExpOHVmQ2RJQW1DWWQzWUZTSnlSZWNGOE53ZTdoWEpsYlZCdFRs?=
 =?utf-8?B?Q1lzYnBzcDZyV2ZlcklGcEI5WE1kcU9ERjg4TEF5RFlNTk8vaUdpSE9GZkVG?=
 =?utf-8?B?YytCc1pzVGxxMkExRjJ3eDdZSjFDMWJsZlpZSVNkd3g4S3lmV0hLdlFtNU8w?=
 =?utf-8?B?c3EwYmlIUTFIZUY3emJuUzlrWXI0VXVFbFZwUUw2Si9KSVkyVE9MU3ZQMEIz?=
 =?utf-8?B?aHhGK0hveGtodHpja2JEVkljUXR3MUszOSsyQ1pkc0YxUVNwSVZOaHAzc2NO?=
 =?utf-8?B?YnJuZ090cU5LUktzK3krMTRtSzZpZmNQamxzLzBBNnB0SmxQY1RVbVo5c1Ew?=
 =?utf-8?B?UWxyaWt5MzVONVNhK0NaYy9nVHRWcTIwaDhwSkRoNEg1ZTZFVGpPcThHUUtv?=
 =?utf-8?B?WkdBTDZ0N25zSllrdThJcFVTRUY5bkpER1pKc1NYOTY0bkFEZnNwTUp6Mlc2?=
 =?utf-8?B?eUxVL3NIN1FlYWJRankvZGdyMVJuWmh1WVJwaTR0bC9QV01panVzcTFhKzRh?=
 =?utf-8?B?cUhuR2ZtSDBwNGExOGI1VjR5dkFlREFpazhsWitiQ0l0UUxZU0ZvRTRNOEFT?=
 =?utf-8?B?ckxZRTQ5RGJhcDVqUS9jeFl3RlEzZTBjNHV0M1NNS09HNlpoTmlUakNCbGts?=
 =?utf-8?B?ekVadmxDLzRhSmR1M2YwMWdVd08ybGxGYzJKdndhTkkrOVhzYm4rd0pLZURF?=
 =?utf-8?B?QWRRNWh3S2QvUWYrWm83eWl5Rm9TZS9TUTlQRExGRkpscTZibXVhb3RYaS91?=
 =?utf-8?B?RFVaenhRd1VuV2VRNW5MNDY3d3Y5cXZzc3lpZEFQUmUyNDZHVzl0MVlLb1dn?=
 =?utf-8?B?VU9FWmkzak5yZFNyWC95S3cwNkxSYnZ4OEFZY0dsZ2xONGg3UGVPcHpYTEpB?=
 =?utf-8?B?N1lZdHBURzM3TFVMM2dmM0t6L1h6Y2V3ZVk1Wkl1OUdpRUd1RDdGbkcwUDFS?=
 =?utf-8?B?d2ZLdnpuM0lHZ2tVOVpZK0V5VDhnVXpmK0FSVmszZW1kMWEzS29mS1RnUWpW?=
 =?utf-8?B?OWxHZUxNbDBBSUExMk1YbXBwNGxsYWdsMmRSUkFvWUJoTmc2WnpxMlRGYThw?=
 =?utf-8?B?ajFYUk1VVlIwNFB0ZlFPRU9iUDZBRmZqODhEeU1oU3ZLTTdoVkFodFVyRFZE?=
 =?utf-8?B?ejRyeURmeTBteTFKdFQxUTBENkU5dEJVK1I3RXREWTFMQ1I0UUxYY2wzajlD?=
 =?utf-8?B?ajl2Q2ZrSS83K2NDajVYcXVxT1ZzQkRDYTF6MmdiWlRyM3lUazRLcUNLTitw?=
 =?utf-8?B?TGlKTGhiWjZyaTU0YTQ1SWRtWG9jYVp0cWFINndxRXc4alFkRytXRjRBN3RI?=
 =?utf-8?B?dVVNeEl5a3VwalNqblVoZXg4WEhRMEFVTEhtaTlMYWFDZk96UWJqb1dZUXM1?=
 =?utf-8?B?TzVtOXhTc3lFQklYYm9lYWx1aE1wWmQ1NkpJeC9LdENFWWVaY0VLaVdmbmNx?=
 =?utf-8?B?SlFXZllqbHFYa2FpZUVhTTZ3ME54bmZob0FGWVdpb3lmbUtxNlJjbmVRd0k4?=
 =?utf-8?B?UGREREtOcUlubDBQVVVoTGNnSWUraFdadk1MNnpNVDB6S2lyLzNmcmdmNnNa?=
 =?utf-8?B?SWNYQTVFalpVZlVuYnI5NTJqVURkQmYveC8vcHNwdkwrNW80UStubzVkcU1x?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd43248-386f-420b-dfdd-08db776268a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 23:01:15.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXHJYBMlNwrea5GSBSpwveR0670cdfIzRmv6urZyLOnFuUs4C5DpROkKzpp8A8jC6/jSFl8dKk7Kg9V1R0ZP79DiPaCGu1igEbRP25BehMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6551
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> This is a bogus value, left behind from a previous version.
> 
> Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   drivers/cxl/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 48f88d96029d..1cb1494c28fe 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -295,7 +295,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
> 		 * and allow userspace to poll(2) for completion.
> 		 */
> 		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> -			if (mds->security.poll_tmo_secs != -1) {
> +			if (mds->security.poll) {
> 				/* hold the device throughout */
> 				get_device(cxlds->dev);
> 
> --
> 2.41.0

I had to pick this up manually because 'git am' complains:

    error: corrupt patch at line 10

Just letting you know in case you can spot the issue because I am still
scratching my head. Here are the steps I took to apply it manually:

---

$ b4 shazam -sl -P _ 7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx
Grabbing thread from lore.kernel.org/all/7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
  Added from v6: 1 patches
Analyzing 18 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH] cxl/pci: Use correct flag for sanitize polling
    + Link: https://lore.kernel.org/r/7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx
    + Signed-off-by: Dan Williams <dan.j.williams@intel.com>
  ---
  ✓ Signed: DKIM/stgolabs.net
---
Total patches: 1 (cherrypicked: <7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx>)
---
Applying: cxl/pci: Use correct flag for sanitize polling
Patch failed at 0001 cxl/pci: Use correct flag for sanitize polling
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: corrupt patch at line 10
hint: Use 'git am --show-current-patch=diff' to see the failed patch
$ b4 am -sl -P _ 7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH] cxl/pci: Use correct flag for sanitize polling
    + Link: https://lore.kernel.org/r/7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx
    + Signed-off-by: Dan Williams <dan.j.williams@intel.com>
  ---
  ✓ Signed: DKIM/stgolabs.net
---
Total patches: 1 (cherrypicked: <7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx>)
---
 Link: https://lore.kernel.org/r/7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx
 Base: not specified
       git am ./20230627_dave_cxl_pci_use_correct_flag_for_sanitize_polling.mbx
$ cat ./20230627_dave_cxl_pci_use_correct_flag_for_sanitize_polling.mbx | patch -p1
patching file drivers/cxl/pci.c
$ git add drivers/cxl/pci.c
$ git am --continue
Applying: cxl/pci: Use correct flag for sanitize polling
$ git show
commit 71baec7b8500c92f9723f39d06a7ae465483da1f (HEAD -> for-6.5/cxl)
Author: Davidlohr Bueso <dave@stgolabs.net>
Date:   Tue Jun 27 01:02:02 2023 -0700

    cxl/pci: Use correct flag for sanitize polling
    
    This is a bogus value, left behind from a previous version.
    
    Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
    Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
    Link: https://lore.kernel.org/r/7q3vcjqidtmxmys4n34g6b3mygvhaen7yikzxanpz56lw43fz7@7subbtbfkmyx
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 48f88d96029d..1cb1494c28fe 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -295,7 +295,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
                 * and allow userspace to poll(2) for completion.
                 */
                if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
-                       if (mds->security.poll_tmo_secs != -1) {
+                       if (mds->security.poll) {
                                /* hold the device throughout */
                                get_device(cxlds->dev);


