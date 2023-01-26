Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3875AC61D97
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 22:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjAZWU2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 17:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjAZWU1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 17:20:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF8A26B
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674771625; x=1706307625;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vKVWgYhhP0p+TwYfLGaxWiV8IzKIadGAz4HZpzjCY+I=;
  b=bSo0vBxw0NxaRaaGrmJ33HaOQfSqyYav9ch8bbxaQ5vbRETL7sJPJ2iO
   B95vj4vpT9XvMs47csTTjklvXvTcag92X7jcPoCWm8O+sgmnECPtNZLyz
   QErC8//0U3UJuFAQAnknM0zuoNmNeUlJbp0LtXccSc6jTLJey5RIbWAcc
   8bH1iFJFN1sc97AmvZ6VJ88YGeH66LxGGa603alGhOeTz9wG7miHzKwAP
   8fLd30ijSY752C6bGwFZ7xAQy6lU+w2OLsJIWSthjhDK9BUVZED3PcCaj
   4KRl9hDfeDAAvsH8EcNiZ+GE1HpLan4E8fjQGcC5gsbzaN8d8BvuVGF9U
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="306618662"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="306618662"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 14:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="751773154"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="751773154"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2023 14:20:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 14:20:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 14:20:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 14:20:21 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 14:20:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuAluzW4OldJjL5R0gkC+pom0H6pb9L7RZCfQ68t++V2YSZCXTjWqp42oWan7vjNzOym1/LQF5bhcUwp45G0q9Dy8H5641Ht5iFW7u7E271HNMD+twVVtbfbDGHjzuJyEUFeMhViBdzXnKTysGygEJOHAwMOE5CGe/Tr0QbGdg2xdDMUfPh9D8e4T0ssiJy/wra10CJ6C4cnF/7NkQdwqfO6btmp37yGGqRJ0tKPqU6UKEA2XgGg8C988thd06pfEaT9/1jCnFfnNnaX2yUUNQE/Qby4pDFHTW1ld2m1CIq6pjgrn7Ym2jHU9rsfvaadeBTIw1bI2Lo0Apg0EDp0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpnTipSk6yutsaRqOkMMa5RBoGjX4sQFERY6OrxnjLE=;
 b=CwIyRPTkA/1Ibyidc5tywHQi5rZc/4KxOfp73wCxGkjhKYBgwLamsdHdzOzisOm/Fo3WsVfLcpATIsgM8btE9PWnkTJYJYoT1H23FG/iifPGmntK4DBB/NNS1EYaM1Sx8gdwk0HQgKnajX2ASExVpA0nN07mOdj4EwXgFfzS7oBITdHGc40FganSf9ZFwqUCMvWIIoR1+7QRsLS+ssv0E7QyKAm90E1lQnHyrvquOsU0L+5yDlMSFEMUIf+pbf09thNK28XX44cWwpDMjLXP0UcHYEJ5pkcom9RbsuU3iagbzuWEl+2NM2zB7SewBW8My8Q3QXIGpdCB6TKJkeJRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Thu, 26 Jan 2023 22:20:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 22:20:17 +0000
Date:   Thu, 26 Jan 2023 14:20:15 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <63d2fc9f81af1_ea22229463@dwillia2-xfh.jf.intel.com.notmuch>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9L5RGZc5lcV2Ina@memverge.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9L5RGZc5lcV2Ina@memverge.com>
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dacdcc-b8e2-44cb-12ee-08daffeb8115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6vSEEHGarw5J9dVL8IMPhAEViUEpmFdyndeo5vAeffy4F6EcmXnCShkQFvCxK5joSJdDIsh7vvpxyiRz6iSpP37Ep4mj96G5l5tJlm59W6Lq56JAhmPwkRXxFxKchR/UOsDbyLF5PDNeWLSIN8icuwHNGD6RMx8Ch4IJ+CmG/ITfweET9eMcrFs/UeNbQN0hgWLO83OhcIoRovnuLTESPYbdVHArRKj74mcIni+Qugh99D5W2GdubP4/ndhl5Bz7krUTJlGsLtycODCtn800RHhHoCFrUMWIjAkAiXAVDHDpwBGjcCKTl/OnJlQsrZi71uSaEiale69l2gtQvMSZTYqmNob0w8la2DkdNZB+IvyyxnhvNHg6u0Jh0aIyJyK47TJNO5cnE/faxZm5mRZWBzOir0t+7Xf+/233PXUMH7NyuNfeb1CcH8HxMi+RhEfSpcAFUMTIpLtt7E5fgKRTPyEEwTlEyf25lCmZAhlUAx6VEXNVSYpx8Rs8jtUYwYx5dIATkbLnk1jCEgF35pIBrGcRS/qLyp1DTDlKF78/p1wA4bKCFyiAwAccqCYv1lehC8CH3Uy3ZDLaEGbdeEhXQZnRpxglw2COD9J/thAcxNQtcfMbgjiV5uUx59J9TO0mCV/yqSkoSMWjWuQocpUc1wzmF+VVw6I6zpesZ68MviZLOsBHYpzSezimOau/UO/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199018)(8676002)(478600001)(316002)(82960400001)(6506007)(6486002)(66946007)(5660300002)(2906002)(4326008)(66476007)(41300700001)(8936002)(66556008)(38100700002)(26005)(83380400001)(86362001)(966005)(186003)(9686003)(110136005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0kvNk5mQzhUK0VUanBwWnVuWitFRERHTEE4Q0lRS01CUzBaZis3UGFKYkxG?=
 =?utf-8?B?NGE1Zm1NTU1Gc3JFMDB4UXRZN1dKakx0d3IyOUJ5MFBtYmlvN0xMQkF2NW5w?=
 =?utf-8?B?S0RZNERCamIwY3RrSWIrdlIyeC9na2FjMWxXTm1LN2ZvNlFQYXFaaWJaRnRy?=
 =?utf-8?B?aVk4a3Q2TnkxUTRlSjVTR0szaE0xRFdEWitXcDdhNmlPeXU3N012SWxjclg1?=
 =?utf-8?B?RXlTdFhQdkhiSVlDeGJKTjVLbjl1MDJVekZBYUxLOEJUM0RSdHpaaXYyaklK?=
 =?utf-8?B?SXJpUk9sZmZ6dGRQeSswY0FkWGRBd2xuSkpMVWJkRG1yQ1U5WDVKZHl0aTFL?=
 =?utf-8?B?djNIZi9PTjN0anJZeWFhQkcvcHI2MVFhT2lOUTIycW15RjA3UzRYOWwzVkZH?=
 =?utf-8?B?MTRpZkdia0M1MHFYVm0rYzZtRlhKdmhjT1Q3cGt3bzIyWVN3MEtMSG0ra0tR?=
 =?utf-8?B?Z1hySUZJMlhzNVYvVDJacm1HRWJYenlwVS9OWUFxMFd6WFdmYW0vZVE4ZmdQ?=
 =?utf-8?B?YmZ5TjdIOFh5NWprekx1N0JXR0tzTUZKQ2lWSTM3a3B2NHNEbFZxZ0xrL2Zt?=
 =?utf-8?B?WEp5dHhFTTlXbW83V0RiampDeHV4NkpaSGtzaEVuUTYzZkZNQmRtRU1Wa0lX?=
 =?utf-8?B?ZXREa0VCb2d5cUZxdC9Ld1Z1cXlFeGh3cFRJSDJQL29TNFNNMkhSWlgxR2lM?=
 =?utf-8?B?K3RZRXBJMUdhdlhZcDlNT2hnUUJTNmdMazdpblNzMG1sOTk4U2R4U0lMOWpW?=
 =?utf-8?B?TG8yeXByVFdyQjZPS2xLTHcwNnJ3SlJNOFJRY001WVdPYVo5WDB1U1FXOGEw?=
 =?utf-8?B?Y091NXlRMm1pWlNmc0tYOU1jbEFkUldrZEFibFcySDhZZWsyYXU1Nlg2U2lN?=
 =?utf-8?B?WG4yb01wZ2hiSDNqZVo5QXd2U1dsaWFndDJ5alJSVmpOQzQ0ZEZuOXNFdVB0?=
 =?utf-8?B?Rk5PaENxN2hEN2hZVHFrRU52Wi95YjdwelNjZDA2UE9UVXRDZVhSYXcyRHRu?=
 =?utf-8?B?V0kxWFhCZ1VkSG5XR3F4aTNQcE5EM25od2xwREhnSXFNV0NTQ1Q3YnRibVBq?=
 =?utf-8?B?dE54RFBYUGt3M1RLN2Z2WUc5UVVsdHRFcUFGcHYzUnBUc1Z0MEVRbWpoMkJR?=
 =?utf-8?B?QTBrVXdhOUxyQm9xWjl0SHdBTlZlT1JqK2NubkMyaW9CL0Q2bXBBRmxxQUl1?=
 =?utf-8?B?eUFuQm12S3picGliVkFVakRmWkhIek1haFhlcmpOMVIwait4Q3dzTnNJUkQw?=
 =?utf-8?B?YzZiNkRFOWlTVU5uSjRPcUJDcElheHF2ZW0rOEtYcUFJazBqZUlOa0xZYmVz?=
 =?utf-8?B?ekhsNFJvZEpuZVJBTEpnZ2pPejNJWlpobFJTQjI1Z1kwMllFVG9ocmtqNXRM?=
 =?utf-8?B?M0FIS2RNTFJmc2YxWTRveEdIa3hmTUp5TGdzMVVEdlNIdXUweDN1Y2tYTmM2?=
 =?utf-8?B?RGluak9BY0doWTBHS2tjNkNuRkNMVFlxS3gvNEhNQ1MrV1NjNkUybm0xZFJF?=
 =?utf-8?B?NVhhUTlWQjUyY29HQ05WRDZ2Y2M5aXdNZlRkSFhsR3BtczdyeGRKME9SR3E3?=
 =?utf-8?B?YVpvZSt4bW5xdEZrQ3U0RGJpVVBOYVc0SG1NZVJHR1RORzNSbVIxcWFCVk1R?=
 =?utf-8?B?dU44aXlVcEdMekdXNzNSa2pTczJuK2pOakk5RjYxVzVpcXFhYWdLaFc1dmh4?=
 =?utf-8?B?azZyOFA4ejZySW9pb3pwNmExZXhidlg3dXFOcUQxMXNCalZERUhNNDQ5NWRF?=
 =?utf-8?B?V1ZjR2UyYVhQcFBTaGdaSEVtYS9qVWxOQW42RFdWOHVWSTZqcSs2NGlxMGpE?=
 =?utf-8?B?N3pxM3FXWk16TmJPaHpyaXBrRXBQSUdlM2ZjN0hnSms3dStocnV6MFRtcnIx?=
 =?utf-8?B?bWFOajQva1BabGxDMFU0cWRYUzBCeDVTMWpFVW9FZEJXVm52WVc0MjdUcG13?=
 =?utf-8?B?SzlyLzNzaU93dHZtVTBTVWhNQWl3U2xTQmgvNWVDY3hNNlprWnhiQm0zK0Nj?=
 =?utf-8?B?Y1krYlY4WFRRcUsvUjgwOEw3aEcrd1RQOEhHNzB4TmM2RDlPNTFrSENQeUlz?=
 =?utf-8?B?bk1jbnJKcDR4RUU4NjU1YWtVNE1OMURId25oWFZndzZMazU2WFZvRzMwSTcx?=
 =?utf-8?B?S1dhN1ZlR0ZNdU5JYmwvRTlHZXNKbnBIVFhVVDRuREJNMVhKa0htZUFJcmtH?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dacdcc-b8e2-44cb-12ee-08daffeb8115
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 22:20:17.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VmzjuivWoJpcqzDt7qfoEqasNuH8nXG+QPadrkdt44JJ7dz69v8ujRFp53SCzZI8UVSXS7RQDkEBAPjSgIyP091lsM0AhSc4QR6Stq07g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Wed, Jan 25, 2023 at 10:25:42PM -0800, Dan Williams wrote:
> > There are still some sharp edges on this patchset, like the missing
> > device-dax hookup, but it is likely enough to show the direction and
> > unblock other testing. Specifically I want to see how this fares with
> > Greg's recent volatile region provisioning in QEMU.
> > 
> > I am hoping to have those last bits ironed out before the end of the
> > week. Note that this topic branch will rebase so do not base any
> > work beyond proof-of-concept on top of it.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region
> 
> 
> Testing this out now.  Pulled it on top of the recent DOE updates so
> this build error may be related (or not).  But it does look like it's
> just a naming collision.
> 
> 
> 
> 
> lib/stackinit_kunit.c:34:13: error: conflicting types for ‘range_contains’; have ‘bool(char *, size_t,  char *, size_t)’ {aka ‘_Bool(char *, long unsigned int,  char *, long unsigned int)’}
>    34 | static bool range_contains(char *haystack_start, size_t haystack_size,
>       |             ^~~~~~~~~~~~~~
> In file included from ./arch/x86/include/asm/page.h:21,
>                  from ./arch/x86/include/asm/thread_info.h:12,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:9,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:56,
>                  from ./include/linux/kref.h:16,
>                  from ./include/kunit/test.h:21,
>                  from lib/stackinit_kunit.c:14:
> ./include/linux/range.h:16:20: note: previous definition of ‘range_contains’ with type ‘bool(struct range *, struct range *)’ {aka ‘_Bool(struct range *, struct range *)’}
>    16 | static inline bool range_contains(struct range *r1, struct range *r2)
>       |
> 
> 
> Was just going recommend renaming contains to envelops for a quick hack
> to fix the build issue.

I think it would be more appropriate to adjust kunit to a less generic
name since a 'struct range' is a kernel-wide data-structure.

I'll propose this in the patch when I send it out.
