Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5296C00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 19:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbiHHT2q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244033AbiHHT2p (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 15:28:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4101A04B
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659986924; x=1691522924;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0Yisd6CxAqY7S0/Ht6YeMIlMkTz8wFXyUQ+PnoOxl5w=;
  b=F2NgIiXPQ7tUNt1yEN2a4VcUMDfm7qnP5CYrMB0TXNSpnyZejnEso4W7
   44qGh8q5Jo9BHBJksPV/bYRXjXFX/4mogk7GU/sEqJ1r72qsqwr8M2Y3H
   yVoEE+/RV/wO8SWW+dObL/htjeZ/bSK/PTIkyM3PeXkx5sZp7OZkcK70u
   s1kdflMLpdzmZOh5Ao7ll1Jhgbvn88BMHnYNPdh7cgEywYe1WMqR1+BUK
   3sSZaL78wAl3CzbOa2sD2JuDZ5jA2hwQfZNTvxqDjHELonxcrwtFSCEIe
   ZmFdOGVtJL2UL5eyysc2Y3dS7AHIPSTZVVPHemcg1ldmiGT6D//5CRZDJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="277610037"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="277610037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 12:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="604486932"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2022 12:28:44 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 12:28:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 12:28:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 8 Aug 2022 12:28:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 8 Aug 2022 12:28:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n44OmklRJmSe8wmDJ0B5hU2lI0GXyP76926b/mFckq+pE6r/nMRSv/vUlcfzeRK5dJt03RlklVCYuJELjodXZbjmbUaNltVTuDH/XZzJbkY2TS21cJRzK1TPnBnjbixL3Um6JXbLw7sRDaf2zqsJPzdDj66aL0Jpv7CAk2u3HqwE6MPqHLbx0kavZWiCq5oeTFhiGhKnf6VvKg7JtC3/1rUcjs2FxZz7ofeTdC/v/UO4WZowrjCoMcqX9PiBMqX3yU2N60gfHIq0MApVbnxKS8kQQUoQnklwqiJiv/pzOEi+dQJEcSoAEr1MsZEQ8m85t05CaZlmt31+GcYaFQVmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoP4A34dFlEZPx4bX+jSloUd/28fI8dIMM+w6LXMQJQ=;
 b=QyrHsBPZb0wDvvHJTksviJXwoBOhbmhLcrcxr/K4bicnS5zbcjKJpWtnsyRSUYgBtE5dsHlvraaekfkYFjnIg/V5oLfhnW3q4tgqaSuF8rj7TwNYCBnl0XcWV70LtA4/Xtd8zQj9v34ZAmB+KfIv71QHpyI6X47Qg750L8PFkp1a34Y8r5rXgSMiApWoAZ8b9/RxzOoC6bRu2+Qw1aoJZc32GOPPlagO6v8AoLNxivMUuQFp9+nfMWu87gQFnN+Jb/omW8cfyfCjOeCjW9NsBPT+dU16RL34GwKqIzjmuJpJGf39Eq531MllUgrDcfQeF5lIpIagPxwehoMERv91LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1492.namprd11.prod.outlook.com
 (2603:10b6:405:b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 19:28:41 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 19:28:40 +0000
Date:   Mon, 8 Aug 2022 12:28:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH v2 2/3] cxl/region: Fix x1 interleave to greater than x1
 interleave routing
Message-ID: <62f163e4227ea_1b3c2945@dwillia2-xfh.jf.intel.com.notmuch>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
 <165973126583.1526540.657948655360009242.stgit@dwillia2-xfh.jf.intel.com>
 <20220808120306.00000847@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220808120306.00000847@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bed832b3-e710-4e1a-0543-08da797432a2
X-MS-TrafficTypeDiagnostic: BN6PR11MB1492:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvj3fVpq0vZRxDpJ2ZHC6jPy0S5HDQ1FZFC8rJ81Dxg5yqIhz3t5CDvno1EMDpvqA7ObocLz28b+nuKVdO4bbNUlUfS7yN9lMOnh9I4qKoK6SUDcHosUB//e2NO/rtbbYhUQP5Hak7l+PcIEFIknRL3ZZuyUClA26YIzjrZx4USOI1eQAE0ca7IcF36ky/tV8IjFJA4pVNZQbh3DBXFejJfFZEL0V1WO1uaevpNE2cfpbP8f9xy9bkfQAs1qMpxAyGUC2N5PdViAH7zJtyjYyaFRmRr2U1uu/7AvlLHGFJHYH94kjJS5eeUCm78zlqqzF8K1fSURb12pyM5gz1tpu8mRE0GBj9gcv/W/YgXPne5Kv92eMD8NoQV5sJ5jSmMnJ4EOhsRdHgscEWf1MgWdi3hEBZeCqq0oT7it5gD8KJwVOEtH16KYHFfCQVfjvA3tL2O18sz3vgb28s/IxNh//zNMoOwe5GxutBhuS3BQCV3/74lkSijGJ+XtjrSeBqgpBQTTca3i8qPPdcvo1r8EXxeX9C7TX2iVT0V/iWusnYHZh8zaeHLeBdNeSme7m9tlgD1QZ9C+LTfNzsEKbA1k6P7fDrOu7UwPQypwpednE+BeC8JaXDnds7diyoEDpFdS69rAoCXOPUTWnF8OJZ17kLMhzlkwypJx0/AA6Gn8Kp5utgi2fJjrQ4vq6yldewrjPp+bcbMV8TpjENE2fbgZfDrHa6Jf2hFtQBAMOyj/3OZTCRdhKmlxu+NN2iLuPDA9kOkACdsmIwo6crcD1WQ8XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(366004)(346002)(110136005)(316002)(478600001)(6486002)(966005)(41300700001)(2906002)(4326008)(66946007)(8676002)(66476007)(66556008)(5660300002)(38100700002)(8936002)(82960400001)(86362001)(9686003)(6512007)(107886003)(186003)(6506007)(6666004)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gXWsylXb7iak/D938mwjXWB0gVCgM++AUpzFEIwkEnYXmNTl2EH4Ae0KIjS0?=
 =?us-ascii?Q?H6ZjPFc1MZzjhpFJuacS2ap6u2cOe8y51M9DWPMPYKNl7jzBmbQXrAzlAGL3?=
 =?us-ascii?Q?ggE4n0pWuskjKz2PKQS7zYNydh+25jrCH5SdPXh/JehlRQhU9GHP4nzxAS0g?=
 =?us-ascii?Q?KrdIPExN/g1TKnVdHT6IIoTfjg3DpCw+Xss6cNwVPwAIIiwezIiNF7ULIJaF?=
 =?us-ascii?Q?I+ED0dr4yiYjxwlbmFpLKpmwexQaNcpeHEjskHL7qDtT1t1UOB4hZD4p0s8g?=
 =?us-ascii?Q?iMoNUFmZd8tbAlyXkLdwaihsTZDCnfJg0yNhYUAwoOBZV4te0YWNcN0hF9fe?=
 =?us-ascii?Q?b2Zk8XgDU1aeZyNFePzgR+rsB5Uuq07vzsPeXdPA2HdlFOemcUFhsLNiE3S/?=
 =?us-ascii?Q?4gL3J0AMzrjiqGCPuGq/Kf4fG0MhYqIaXpsaVa61yuadU7fCYnsDcVzp86Dn?=
 =?us-ascii?Q?DK6ZpGo9RLck0I/NIerUF4NMAt6AOSy1bFjGsqh2XkvN/PcRSw8H3Ru8BIcG?=
 =?us-ascii?Q?hqnPu0omVnbbqIzelR6yKkK9h1A/IP/MJ0YYKISz264hIj5jV/nXTlnJWsIV?=
 =?us-ascii?Q?w3QSAGfVobSG5NbWxaIokzoxbLBOb79JzEVEwh4yR04mK+yutPKC5ckXZj3J?=
 =?us-ascii?Q?79580loeFk4Z3E88n+5E5gM0sufOAdb7daMzRrTUEUsSNEXnj4TsniPy9NZO?=
 =?us-ascii?Q?BZMFHFDJZCyOKeL2aT74ItBIsxSPseVmW2akFoAHyhM6WIqJA0gIonFk8fGt?=
 =?us-ascii?Q?ZJNX+c6SFKxB3uBbiLB7H/RLUYlBOYLqB8CBoUJAmU8ng3zKSoKj7hZY4fp0?=
 =?us-ascii?Q?D5EuxcZ/rbku3/aYQQC5gsFAIsvgtFT82b22F3kMmxO1CXROqpsZrBKhNWN+?=
 =?us-ascii?Q?KG0rrni72UEP5+JkktxS9u7DT9frFs46mSWTPaL7Bn2Hq1TIXjmf1nibryGO?=
 =?us-ascii?Q?12KiHQZ43dC4RYsqK3kb0dFKn14NrNMiUr3AqoPUXb8Z+yCBp9FqlyIGwPL4?=
 =?us-ascii?Q?kpq4lVzUrd8wSMUYdKIvX5Uvefzx9/+qzeKc/Rmn5/beJCkDlcTrkrH2heKj?=
 =?us-ascii?Q?1cXp4GCvaCsbyJP4sX2HsrDzJ473dSjDVCBJgrZCgB3B8SqGFLG7D9wWqtvl?=
 =?us-ascii?Q?vygV6lJ1zJItu3U5G9zUf3LFknndua/QM6P3TRVeq8u7GCUPZVOJANSJzJfE?=
 =?us-ascii?Q?EQEz55dCXqUFnqfrMMw/03nJUPpVrbaA+Av5zJzCU0rbRdcg6mlCzOqPdJ/J?=
 =?us-ascii?Q?17/VBhsO7RlGtVGybmLqoCowzAOao0L96uX5JurK/A0L/Dd5lcQ8xAP4yTZU?=
 =?us-ascii?Q?WK0+VdWYGJqC2jgE3+pn5u6u0Qy2T1quiB/WsQ14XxE6DY8DRKPFnxU4SUyl?=
 =?us-ascii?Q?WikVAJzuUgG5yz18XhMRcaAEAWqvD9MV4f9Ua4yMga204oJCZ3lC47KsCQc6?=
 =?us-ascii?Q?DmxM36VN0Wwnrw8yvmDj6teacpSDKFeBuENze2Eqe1wvNj2p8S5BRm/Tqk4t?=
 =?us-ascii?Q?vP0xSAQG1TTFscMeCSZA4MqmB8tf4PqIRyfKjwl9OeK0Z+lLGE0PjM/fe28w?=
 =?us-ascii?Q?+zhExqWsOBUFQuM2icTx0p1nHtIRI7uJKGkjJTdWUohdWf0XXqNDJMjADng8?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bed832b3-e710-4e1a-0543-08da797432a2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 19:28:40.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmyT7XN8s1Qa+OL1dsnx7k+Pyp9JkoZILI0RqsSjBhe0Y5q1x/S0GPln5jnQLCQKUzM8K2sDImA84grNdo+LPivZgxLfM/Vup7CCC2FXhB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1492
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 05 Aug 2022 13:27:45 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In cases where the decode fans out as it traverses downstream, the
> > interleave granularity needs to increment to identify the port selector
> > bits out of the remaining address bits. For example, recall that with an
> > x2 parent port intereleave (IW == 1), the downstream decode for children
> > of those ports will either see address bit IG+8 always set, or address
> > bit IG+8 always clear. So if the child port needs to select a downstream
> > port it can only use address bits starting at IG+9 (where IG and IW are
> > the CXL encoded values for interleave granularity (ilog2(ig) - 8) and
> > ways (ilog2(iw))).
> > 
> > When the parent port interleave is x1 no such masking occurs and the
> > child port can maintain the granularity that was routed to the parent
> > port.
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #via qemu

Thanks Jonathan.

In the interests of being able to make a:

"these commits have appeared in Linux next with no known outstanding
issues"

...I'd like to note these review and test tags in the merge message.
They will still be in the history just not in the commits directly.
Similar to what I did here:

https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tag/?h=libnvdimm-for-5.17

The current state of cxl/next hit linux-next last night. Let me know if
you have any heartburn about that.

> Now this is resolved, I'll get qemu fix sent out (hopefully later today).

Good to hear, thanks.
