Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5DEC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 14:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjEZOt2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZOt0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 10:49:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F3A1BB
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685112544; x=1716648544;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=iTMDdqx+xUu8OEzmJpBKSaigGoTY0KGjmEATS2BvBxY=;
  b=Xl4yxSKmYUnSOvdRz3oUKDfoaO0clQFZhFUYdWvuIfhJuORHQpXoZptY
   jkgi19BVPHZEohzJfIY8HKrFiFkB39xWXGsDtcoOxEegqgSZDOEZxAUaa
   XtPiTBOF7r09Z6jYYCUJSN79F2gJiQ23E+C+eG/w0ZpMan4pK3yrjhfrX
   jxkiGKBe21aFbrkJnVXPFg+IbJhLS+E71IS0MAF5eLtJ4qlsKacIa0Wru
   Ze3lTrx097eKh+h808bNDd8IVGrXTVW9WgxXCBn32RUH+vRPozS6JMF0q
   QYKZguJ/C+FslMfC30ZNYQSOaYYkv8MYzVWrH1pl9cTrqr7As0XOgbmTV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="334568797"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="334568797"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 07:48:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="795110070"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="795110070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 26 May 2023 07:48:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 07:48:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 07:48:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 26 May 2023 07:48:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 07:48:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQIkpFgxr8913Aa7+ftrQZmWvnZzYG7J/EkTebyZ4IL3boJY8/W27viv/7lbrR7zRFcc6ovpf/MXQ2PUukw8mDE+p6mfbu6jfW3ysAmW78if5MBGLSdt1D/ImMsUUykjBsgxzN7Sfk1IC6qdf6q6TGueDUWhRsNmBGN8PCwMrSSJKkTS/43575QNNB8/ZwgB2umwCTZxrXhbb3Y3vGk1UWJRR3JXl73U82bCRMNbTxh6/KAqzUI953oQMN98cHzTiq2g2JYyNCKTy0KF6WJcAj9UNXsY+CkQPPVQWRqfEKZxVyef9/JYSd5D+BDqV+QCpYRprsw+qU6oM9IdUmcFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjtiJeIQlssc/ui9AY4q94tSduTL6zcYhlmVTEPBtbA=;
 b=bAlMxNFljyTRw49ASPHJaU805OFX9wq6uM7aVIiHpBFcrR5Sa4lI/xK2ldMpUhKnqdI3mMjm5mbUSs6WrBs+xmJy22g84cK3KF5ayQO2HpGrMadCEolRJGhvBwNJcGELKxiPMZP/4WdsHBw+vZ1MEZiHL8KJ/hqpvuu9IgOBizj5gtmOzkMQxQm5u5D5ay5m12BMk5DCwU4QakN3fyAF8xpbwgBpa+pg/9nqX6OW0oTXCfP7qq1Ao1j7TyPi5Ebz5Zbn3Og6UGGsrGj7c2+vN6N0MtLDpCsnWzhmfXgMIj9wyjePansR0Dr5SQQlF6jQQFDUIV1mdkuKxffsfwObHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8191.namprd11.prod.outlook.com (2603:10b6:610:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Fri, 26 May
 2023 14:48:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 14:48:06 +0000
Date:   Fri, 26 May 2023 07:48:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <6470c6a44e869_1fc5429435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <TYWPR01MB10082A36ECFE209E4A05BA33190479@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB10082A36ECFE209E4A05BA33190479@TYWPR01MB10082.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c599706-6583-484f-bd87-08db5df8371d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q33ZABVrhu6rqSPQnr4ug+t83AplZXRsyNj+GxW+ON5GqhedxF2AuSVdvdyt+/iAsTwzHKqTxUxqP/ic0a/SVz8K35oS3yDWwctFDkNCo40rIDu4Y10zgiM48so97iPFbLu/0e+H9aytusRrkAODBancXF+HtOCLM2aKRPcaYftzq5skUakHAvfm4jQ0oWlyQHCCOUIHi4FSG2VkcX4jRVL7NfDvTnipk80B10ZO7F6y5UiESZpazAlM5aMlf8wmF9CsXeS6wCJ/qkl0j7KSg07owoPzWcETFpo8xlEGHXB4M61xLV263PDBEKjQYcD9/kweEGbUxOCZKfrK3XT4WqD1UULlrsJWMdSqgrcAOWMsV+tQxG2seUr8n7qm4iFdHCI/Vayi8tnl91YQ4m+VM/x8nKxwG7Y8Oiof7YZpxUx7vaqc7EHxruLdQPxRuD7M0vZEBpH/33lKMbnbG1qdEMg9YJpbMguBS0RArMRdyBTocTXtjHqAQGO9jy6aiY2gTfxI/5T2FT/NqzSAZqRIs4SEl43x+dJM0xyB8dFBDso=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(41300700001)(38100700002)(316002)(6486002)(8936002)(8676002)(86362001)(186003)(2906002)(5660300002)(83380400001)(9686003)(6512007)(6506007)(26005)(966005)(478600001)(66556008)(66476007)(66946007)(110136005)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fxf5ekeXwmUsBIYyKIgNmyyXOuoJfBLlax/XP32uq3oUhM4bJbXw+tqVsF+7?=
 =?us-ascii?Q?qPGSrfFZqWT5GpZySyKvWrSaaQAzManepkKUGuvLbeS584luKxWMJys0Uztc?=
 =?us-ascii?Q?seBVPiu+QCeycMk6+FfCYtB8Nu7K82sUUweP8oXkfB8UY+tvBLjrAUcx83OM?=
 =?us-ascii?Q?iurujOY0Iu1UNLXFapNV8iixqLFbE9h9sGQWIl7AVE1mmzVl5g52yIKhipfN?=
 =?us-ascii?Q?F9CWyDpWYFebokUe8jmDhEfDv9RdXZbxZi389il+MfR+IdBytYNNnjuAHYiA?=
 =?us-ascii?Q?QUN/6HlExEaug7xfNOGYwNxHnepeWaSz09avqUa3dcw4i2dcLCew6K5II/vu?=
 =?us-ascii?Q?/O7mqu8Pe2ce1Nsl0aghLOA9a1n9R2+JrBbQqiD66WC+QXytwWZ9miI+D0Va?=
 =?us-ascii?Q?mParxplrWiVSZknAGtd9fAedGJRBNElB393tgFqDWJW/+aPZKd87ysqMDDDi?=
 =?us-ascii?Q?c/pBfUQdGWAJwa/GYvUzbQUQ8PGW+cMpngYY+3zs/eHIlPDXNoy7SRE/IE8E?=
 =?us-ascii?Q?dcEab5DZsCCyxMQB2tskuC1DrXf0sYHvoZ0f9tUFM2OMEv33J2Tyob5ViUZi?=
 =?us-ascii?Q?PflcH16dgoyEYCfN8hC9u61LPPbI09fPxtr1JlUvU58MIOyi/K2j9VB/Oxig?=
 =?us-ascii?Q?FbKOwaoxhpEH/YhPhBasalZqRiZ8/qFCx2uG0fBo4twW1o2zrhNhzdkXiIj5?=
 =?us-ascii?Q?HSZJh9Qy0ox4PjtzVlqIiyiY7VFzR+d6N8hrbJyoNrYDiEhWEs+oDo/UwOSk?=
 =?us-ascii?Q?zck3GXeR9q9Sq8nO2cb7ZYiEBNBbfY04OwTTTZUQDi+7rEDhTFdfeExrcqaT?=
 =?us-ascii?Q?w2ODUi/XoMWz/BMncuoNKNBAPfHkPr/pNbn2v+CWUnzxaLRe2n3jpE5v4RQf?=
 =?us-ascii?Q?XZZYPsC0+z/yV23MgpecFApk2VOWRwu0nJlsuGgaYBvcESM8Hd8yeWQeaPo7?=
 =?us-ascii?Q?rKAarqkzpncZSDQFqmLi/iAPzL7Cj1macMf7j2UG7FjDuucX6t78lYy/HkWI?=
 =?us-ascii?Q?ZkqYOYTs85Q8JDXJub18KfBf420fbRDlCUiq0+ZjJNG78yw2CD0Jg4YJk+2W?=
 =?us-ascii?Q?ieJ9+fCOAignzFa7zFapV/I8NnAjiMmIYbRFMid3ZItPeUbVX4DcgjiUvafY?=
 =?us-ascii?Q?2DdkUj7I9VbgwTft5KnMVDzKXfqGE142k9XmPlIe0THC9uVOf6HqgnkO0Li0?=
 =?us-ascii?Q?BvfQLO+Ly89hnzW38cDVdnVulyhybK2Rh5chM+CUu8HC/MDUdr2+rWxKCtVB?=
 =?us-ascii?Q?FXLlQQ6rWkV4+nj8mdGL/g+8EmgPV+i71y5l04OSWcPDDKCIMDcTscZO2Twr?=
 =?us-ascii?Q?trXp1edrOBNlYdgdcCFlsIODYVlvM02/X8dWsJSDACPJXLdPlD4e1B8nUX0Z?=
 =?us-ascii?Q?euW2W9e5gKUo/kILL3PWdNKYYmxeI9ZGee24iaiuqlzqOGL+XCoTxGiXGPuT?=
 =?us-ascii?Q?GslD5fT5mslAoBDD2V0CfRbiFa+DuT4EGSlpQeLsEF2VoJd7X843jnAvcgUI?=
 =?us-ascii?Q?AkE2pDoS2kLwiNDRzk/b65rhYPb0issrLZDKVhcQZzjThjIlbbXcq/yehShK?=
 =?us-ascii?Q?8ZpBf3RJU+n1wSNepDFVdgkEwklUCS8dUEQNaSetYkBcT1ldPdN5dxInw0+G?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c599706-6583-484f-bd87-08db5df8371d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:48:06.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHOVi8GY+gVuLjF25MMPZAOJx1VAdBiBVuDZ90GgSa85p3Ay7c0OaOn7HD6Y+8U61UT++X2+hY9EEvuz2NGbwpMFUO34id39dgfA+puvcfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8191
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Yasunori Gotou (Fujitsu) wrote:
[..]
> One of what I mind here --was-- which documentation describes OS triggered hotremove instead of PCIe trigger.
> Because many hardware/firmware developers don't know the circumstance of Linux.
> They may want to implement same system not only for Linux but also for VMware or any other system,
> and may want to obey only the specification or any similar documents.
> But I found " CXL* Type 3 Memory Device Software Guide: 2.13.7 OS managed hot remove sequence"
> https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device%20SW%20Guide_Rev1p0.pdf
> Then, I can talk with them by it. So, it was solved.
> 
> My remain questions are the followings.
> 
> Q6) Are there any way to hotremove from outside of servers now?
>     Currently, administrator seems to need to login a server and execute offline and cxl disable commands
>     to remove memory in it, right? But in future, something software like memory pool manager,
>     Fabric Manager, or any other management tools which can manage many servers CXL devices
>     will want to remove each server's devices from outside.
>     But I'm not sure it can available or not yet now.

As far as I can see all of the PCI hotplug state machines just
coordinate the removal internal to themselves and the PCI bus core
without any participation from the impacted driver before the ->remove()
event. The ->remove() event is too late to cancel the hotplug. So the
change here would be either an upcall to userspace, or some permission
request callback to the impacted driver. Since this is a policy decision
whether to allow a given CXL device to be removed that leans towards a
userspace upcall mechanism.

> 
> Q7) Are there any interface to know which block cannot be offlined?
>     Even DCD is supported, such manager software seems to need to repeat memory offline
>     request for many blocks and collect succeeded blocks until requested amount....
>     It may need much time to complete even if its success rate is low. I think that "time out"
>     for such case is not so good idea.
>     If there is an interface for such application to know which block has long term pin pages
>     or any other obstacles, then it is desirable the above software can avoid to wait long time.
> 
>     If not, I would like to investigate more how to make it.

memory_block_offline() can fail and that error code is returned to the
sysfs operation that wrote 0 to
/sys/devices/system/memory/memoryX/online, but there is no facility to
determine whether a block is long term pinned. You can only try to
offline it, but whether that error is transient or permanent is unknown.

However, one of the mitigations here is that DCD allows for partial
release. So unless the fabric manager strictly needs to get all of its
memory back then it can make forward progress with a partial return
rather than timing out. If the fabric manager needs guarantees then
there is also the option to never online the memory. So, we have some
flexibility here before it is clear that a new interface is needed.
