Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC56ABBF
	for <linux-cxl@vger.kernel.org>; Thu, 14 Dec 2023 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkEzf3Yo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702593579; x=1734129579;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HponnmJGNxhvKH8NFdXvBwemC8ilngRngeB2moHDCZ8=;
  b=PkEzf3YoMcd9TU5uqUkidfxJfqa/mfDowTW/X1FFZnmcUccTiEqeJXnx
   PRm5GNEJPKangAtwxgTAhVYznrFCvkL64trrHDQc0VYnHpSqWFW5KEgoT
   R0MIm/npnF2ZeYJW9/E6nJINuIGHxCsQU/V7KbX/urkgII/RmUnY+TZmQ
   104xIu22UlHeE2tLmyFwfDpe8zG9hkkpAkQDJPU+dgGAKrkAWf70sY7p7
   faKnSegf/FrdpLe8QTpqCkyzj62mcJvB3jIshdlZb6CSVhy7TPDLERSKr
   lU/bf96oj9e5GSSgidqIciUMhuNZFtl5+71GGrjWE9aJzcxiBlCS5AcsC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380191039"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="380191039"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897908853"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="897908853"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 14:39:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 14:39:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 14:39:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 14:39:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqNNSLs1ZzB3hNK+nyMKI1M4E5fdEaJz0IbqlI/sbC6QEQWFB8Etr68meV+0CGI8f72m8knAh/b2Sa3PTKcs+mumTBpvZrWHs9wN0A124C2Mj5BdHIpp1uKhA0yAvmp7cxNGRT8X1c0vuvcul70q1LPh0vdCg7TNgURusueOrFv/yIGZ3hEQoATBUbg7ojIS8VM3LDQb/iowTWIzcHet7gKYPL9Z96LmrHaB2eK8Nvi2FEF2VcmD66C3bgxeNBiWisca21nubrzVYq2/i1nXpCsGwKsmx5LnAdD/XTvOBePi8ONiU4wccaLoq8NJqpjl5DwPDhm5Nra+i4u+t/rykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfUkGacfNfR4YqCVSi00TyvMjQXJ3x8FkXNVdX+sdUg=;
 b=mcrz4uUGv7s4Lrz2TdjyvOZEzIA2IR0b3b4bC0tuMwp5QRgG5yNjGWbIz/lq7jhIlP5XDSyOJwoN6lzq6QfVQUEYIz/KMdB+wVYZh/ARQOx+vBrMCPpxNNqUzM+G1gc2ob4WhKzwodclW8ZM2QHqL3bTaYTilOj6VWvcoJAji4wDwgclglJH/SpbBZhgkzrY7EyouF2HnPVLPyJ6KM+p8KrlaG/q/iKi/CraaDKxfiWr9qMvJLRfcyAvoO5/KmxLyTat5LhQIz60/vUt3m5KrEfeBJ9TujDLmwHUaT6frqvJi4qN6Z8xF9nQqh1QVJGBZEROZDNZZSDODWRXvf9O5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 22:39:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 22:39:34 +0000
Date: Thu, 14 Dec 2023 14:39:31 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH] cxl: Fix unregister_region() callback parameter
 assignment
Message-ID: <657b84231ad12_27db80294bc@iweiny-mobl.notmuch>
References: <170258123810.952211.3907381447996426480.stgit@djiang5-mobl3>
 <657b72cac2ec9_27c4df29484@iweiny-mobl.notmuch>
 <657b813a745a6_17c9712941e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657b813a745a6_17c9712941e@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: b03a05b6-a5dc-4005-ee2f-08dbfcf58b59
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXiY1MA9/9SKWYctxK549nUv/k21j6m8IeAvRHTQXRh/I2yHlH8scU+13XQK5M1qbo9hcHLhXhbCV/7GjpB300O09r2Sg5pbpF8akT9ENnxiRPj+grqOypB6t/zbWAFx/PKBLvLN7zhuc2mnWW68BxBBhe3eCD6stT7C95MIz3HcpgSLmaLhN42CQZ4mXi0AlfnK2UMLnmFSt2OPOI4cSJEpS9S8bcfO+VF7PW7z3SKfFYEVpOlgS+H/ylKK159ClH08m657HRBF0vVkYxj0xjIbjPolz5wfG39TnWBkkMGo3qylt3zO+9mCTdfM4k4YSsJjVfeIe4JFG+H9lRu4XAZQyiiMZ3aXUH9qPG0Eq3LH7YfBk2iKeh4I4J1sT+s1/1iyzSde8ePLo483MU1AIADL0lqajy1nQ0wD6TKUfDoFb7eUg6fBkehT/1Gm1m6PLXk+wdI6KCh4H4ze2uo1x2hH68o6e8aBNS+W8/+XRG1sjLADByMKKNNS4lD73qnIwFiicBlw2gn/eW1PQYkvYqJjFBvippvHtzYYl5Kyavinz3CbLIa828QyrLUKyXh8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6512007)(9686003)(8936002)(6666004)(4326008)(8676002)(478600001)(44832011)(26005)(110136005)(66556008)(66476007)(66946007)(316002)(6506007)(5660300002)(2906002)(82960400001)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L4VCAdkHJ0C7d6WheIueoDkK/CbD3lPe3BhlTQ1Mvjf3YXDPtIn2ldrPhXkV?=
 =?us-ascii?Q?8auCQif9SVJRfO+OooEVTTjuniieO4SNndkl8yGthXv46pVAZ//sr1tjbE4A?=
 =?us-ascii?Q?OhgbR90xaCTOvBNq4FZea3DJTiiMxx3lEyTS3Ng52WdM6/K9cgoX9DsuhFl/?=
 =?us-ascii?Q?gceCvJYnaZrefhSFhHjOBZAtsrZyMr0/ZGBHNuXHaEbQoQ7lDQqtOD9Rdd0K?=
 =?us-ascii?Q?QoSXookSOTwyaSfsYhu52iyty5koIA+upcy7nUOk3eTr+CSFSLHm06o4pRNB?=
 =?us-ascii?Q?x2Wpx2Ny2cOavuALLzy7nzT1LGJe6djOygBC5wBP1V9JpVFkHh2eQjCPO5a4?=
 =?us-ascii?Q?Zfcge01g8vuGABLnnQHRHBOhhk8ND1JVXVaBtX1uob87zKAlCEzuLcQ1iFJL?=
 =?us-ascii?Q?xWlwn+EkE/XzAcgK4ZZ4eZswlKE2AqulkGJQTyoh+MfdEVH9B162blWuAOKw?=
 =?us-ascii?Q?Sw3pbD8QQowt8e82A8sF1e0yzSCfiDCK51QgFx8CeBeTZVdpXg6qhuROKADC?=
 =?us-ascii?Q?+w00X+qYXq8Rj/RAnrT8CU9Xuf2XIVPdJJSHSeZ5kGqaZZS61G/qMZw2k4YP?=
 =?us-ascii?Q?lXIHS4h3w2GHFw9c2bc5BIeJ+cxEEzZHgdkE60tMq6zxzdQccEFmM1/8S841?=
 =?us-ascii?Q?2ojdgIZJ1+BOkL8nwl+9eMESS+uZ2wH5qJNUrdD4tW2AJbIqhUEtEKOdtH39?=
 =?us-ascii?Q?q/rYLS+1stfel2YJsIguaDUi2Uu2VBjGBrd1YmhEcg1Pu6X1JVpQpxRB13Yr?=
 =?us-ascii?Q?8TTMc0vw9aPCKNme3MFnp8wtaejiCOhQvFGhBolhxzPy7uGj1G0AXTa/Dce5?=
 =?us-ascii?Q?JDVqYunHfdVYdSWtnZXKZ8Kw9SyNX203QXNTKJByk+rihpvdYqWb30UaMyd9?=
 =?us-ascii?Q?uC/t2CRHl+m1PNidySCdLyE36uHGgzYRs6siRLHnUy50y4BpLzuuLQZvhjCe?=
 =?us-ascii?Q?MXCdsASdy9pmeXXzQjRLzJ6yxrOqbZd5p6OHK6PkFweiQapsOE1exBS0Gmmd?=
 =?us-ascii?Q?rrzKIo4EkwpCneN5KbPisugkHg5wU2Yii0cPk6cazpUB0f/tqZU1uHYLseZj?=
 =?us-ascii?Q?Yo52OW5NhzcmSQ0ifdrJISX32oVueYtNhlcpiWFhQuO42H6e97UIkUbv7DTa?=
 =?us-ascii?Q?MP2/61lOW4ojs8K4PWpGwK2KUt7reCBfxe4Me8w2+0QAxHD3bwa8c6tycdcb?=
 =?us-ascii?Q?rVVralWwv4F4siIZkIevCp5zRYEGAay1mni+gzn2p8Ds8le1YQTuVrzsgWuE?=
 =?us-ascii?Q?Rnzvg4wT7E6TtPcfoCMGR/FJ0HNXvq5SxQ5TU1IOV/FYmwv/8e/pTYJOi8rU?=
 =?us-ascii?Q?iXu1nK269Qk0P8a2Ir7j+UIZYVCmyMABm4lw3F2Np9wL8r/Hc7bFm6O80xeW?=
 =?us-ascii?Q?lSLTaX6KZLjct9yFEm6lrqvAVNGJCD+6ZLRTu029jJuozZiRwrDJ6i1P6j5t?=
 =?us-ascii?Q?UM+4CyguNFNZIemwpIaMx3fYtDxJfXiFIE6qz2UXvrndZZJ34WEJ0rIw55JC?=
 =?us-ascii?Q?SvVpWgwuOhwP6aBz3B8DdfeLCGCAIfWSy5W3eNub/+C9Svy8hsGDfdW1nTaZ?=
 =?us-ascii?Q?AcReAIeELDX2kYHtMccht9lJkk/teVFh0kG+zSec?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b03a05b6-a5dc-4005-ee2f-08dbfcf58b59
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 22:39:34.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWe/bLtexUWwxRsikAXp87KmMk0h+/ioqYZRHKyOo0JKM+TATYb70iuiaLMQln6FVMVQKeWG2UXjmqPuHxRlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Dave Jiang wrote:
> > > In devm_cxl_add_region(), devm_add_action_or_reset() is called by passing
> > > in unregister_region() with data ptr of 'cxlr'. However, in
> > > unregister_region(), the passed in parameter is incorrectly assumed to be
> > > a 'struct device' rather than the 'cxlr' pointer. The code has been
> > > working because 'struct device' is the first member of 'struct
> > > cxl_region'. Issue found by inspection. Fix the assignment so that cxlr is
> > > pointing directly to the passed in parameter.
> > > 
> > > Fixes: 23a22cd1c98b ("cxl/region: Allocate HPA capacity to regions")
> > 
> > Technically I think the essence of the bug existed in 
> > 
> > Fixes: 779dd20cfb56 ("cxl/region: Add region creation support") 
> 
> Agree, that's the correct Fixes: line, but I am also debating dropping
> Fixes because unless the definition of 'struct cxl_region' is changed
> there is no problem in practice. So a Fixes line will generate
> unncessary backport thrash. I'll just change it to be mentioned as the
> originator of thinko.

Yea that makes a lot of sense.

Ira
