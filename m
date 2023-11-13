Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7F1381
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3M3J82L"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE773D40
	for <linux-cxl@vger.kernel.org>; Sun, 12 Nov 2023 16:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699834212; x=1731370212;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BjWHtYkGDm21QLXZfiPZYojKdptd/d49A5AU0o3RJRU=;
  b=C3M3J82Lz5pmAjYXfAPpfQg5gXTLAD+niXQTqkEog4tXTnDh/MFu4lJu
   JDMrNLlPdJ4P34tEA4FexU2G1YniwRXNeE+ZAQw5AQoKfZnkTuId8SVlr
   +RKCh/eZeqMQaDIL0kRA06dJ1lzWxCEC784sdsdlWS7yGqwZKLANUEfNl
   3wS6476R28Khu1jpYfJQdR7+LrXZp0UWzjDZ/MLHcqy5rmtQs1KfZr2KQ
   j+UqV6QfqaotzGuHxQGmw7Y/oJBtPJ07LNrav9cQKOlYycVrYCAxhXs4K
   hA/f4HekBsO01tREjYjlJ1TwMSVWr6jsDEmfZ0vIATQYCAcE9e73dOotK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="390166016"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="390166016"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 16:10:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="714102875"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="714102875"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 16:10:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 16:10:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 16:10:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 16:10:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuWvN2hpxj1dg26Okn+qlkJ4T2BU/ZyuQPP96skQCHp5taDBL5/G06dMgpP1ZR14J9XGux6sHohV6jtms5vhLqiIBYahejMjirFtO1R1x3WGD7bqys45NeuCwkrMvyMeJALEeMC7svDtUykrhSpmPYYtuUsZOjkG8qwiLkiSSqwCsjNA5iwnL6SwtjtuNppsqsrSCnmVJtivnHXdOcH+nnJJKdD0twd+cD7hdF72bXvgFAPXHREYmppJLf//Q6P1bwRwrku62O882Wd6XRqKWG7Cqa27lkXjDJUekVhtQqW8jF1BQWdJeq1TcumnEEBxWrPrd3PnpV+vs0TCquZNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFHPHUAazyii/gr5gsquCwxnBUXZNcgXqf0lsYD0Rlw=;
 b=jHEHqT5tLXaahijkivzV1SObf2IyO8rnBVYxtjvE+IAbCUBvsOPW92SShvpOk6xJ5OyBm5URW7Hyp2JhqFPL8ZufgyyyHXY5CV2U0NHRfwYOw/B+r0hTB0Vem9eIJoHNFFNy++h5v4WuFn0gWEmMOMjhveqKBNZbpZzX0lcEmJsAPcMp+RFSVh6g2WTpVrnVnxLO2os70/4UL0jF8XqS37eM6Qrif2pUh0VrlRcny6W1tQA8mUc71BDS5IAgDmxsOlI17MOPrXfcgIc36lgx5soYSyQHkGfduNEPYYjuO3FRjtqme7WXhrg8FcEXW+1eiIu+n8AP4uEYBx8pKjHNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8686.namprd11.prod.outlook.com (2603:10b6:8:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 00:10:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce%5]) with mapi id 15.20.6977.019; Mon, 13 Nov 2023
 00:10:09 +0000
Date: Sun, 12 Nov 2023 16:09:35 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	"Alison Schofield" <alison.schofield@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/4] cxl: mbox: Preparatory move of functions to
 core/mbox.c and cxlmbox.h
Message-ID: <6551693f988f1_46f02942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231016125323.18318-1-Jonathan.Cameron@huawei.com>
 <20231016125323.18318-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016125323.18318-2-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb5bb9c-038a-42c1-c454-08dbe3dce542
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwFjoWSGdzMUCk4ZFbmf3P3sKnDs+Z4uRR8JMh9lR/7ERWAWv3tBCi83aSpvuJXtkBTcOh8ERl5N4jjels9Ymx4H2coeNzIUTOrVPH8qkwi16PprCw34f2qp4qus1/4S/AsGqxcNuaKDRmPcYpvDKKPQkg4aEmqra7/7aqbkEcquPZtDrtN5I/sCX9wzmwsi1spZiK9N5LZ3zcqCKu95WTNPqB+lZ9D8sEEfdapLF+4XE200Ft1z2NJKbQ3NYCW8cciJGnlO84B+lppga2J6AzVWxS4nZWz2P5TDu8vzOwHcy20BvbN/X5YXiIC3MBMQZ6zvAlpBMtAhz9zfPA07htW9kdBQBqj0GJELS2q/uePgoLTswhDfbYIqDh7kQyMC9B6cgrZqld0SdNCUS5rQ+dDt6OoyzX2mbhyE0pBniTtngSDcKaKpbBbPFYNLG4KfigqGCll8RFCZNiWabBKkatwTCizGAzeFSqq84pWDLUkYnbO/JpaT+uHANvMPyDbn3ZZBBMbBDOrHcA5+sklUxGnRcOnTN+tDpvpmIeSzu5rUlxKb4TC1qQhrXM9fzd//e0Yl6KCCWGkq3xun3cIYxBBW0jifgDXevhHBRGm5hkIbvHrUDNw/JtjB08Yf/Thk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799009)(4326008)(8676002)(8936002)(26005)(2906002)(5660300002)(86362001)(82960400001)(6506007)(6486002)(6666004)(478600001)(41300700001)(38100700002)(83380400001)(316002)(6512007)(9686003)(66946007)(66556008)(66476007)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lj1odD+Uk0wnFfhpyk7MnBBaj9Z1Z7wrkZZ0NqvHalyVPrDgOB9BiZILU72F?=
 =?us-ascii?Q?iLPQJiKl1+D45LdlheezSNmn3Ld/fYO4J8yLsjKKOnn36jl1xFiuj3jbKJZ5?=
 =?us-ascii?Q?uXj6YO1yI0kdP6m2thvYkxQ0qT6NHgXHkHmOCuiwO4TMW9kw4un2eTmpPsmk?=
 =?us-ascii?Q?oVSVeLlK38fdcNtetUPL2ht9qvRbca2GjG8cCpVIaFln6Ssked9OYGYhnwI9?=
 =?us-ascii?Q?UHWHp6dQX89RjM2ux5lf6KH6XkJCpMCdALmbDcY21BkFy4IQUipaCS9kOjD6?=
 =?us-ascii?Q?AySEzaRkXbjvOgXsYEOJK6nB419hNGMh2ertFnkUplPefK5oivxBpNwKeE0s?=
 =?us-ascii?Q?hOuYBbgvQPH8cIPouT8ixSi07GG1ILH/iZWW8XfrtCGG4ciStieMl6+Ul1iC?=
 =?us-ascii?Q?N3pE+dxp/o5+R6YNLacbKi7f4h/BPtgEP0jrHLfnYnKweqNkiv31BJfBskGu?=
 =?us-ascii?Q?ZRRBC9ek0mv5PuPuT8+4ZqwnuZ0VUwz1hx+lBD9ZWCgqyCCxxjOx1mK68VG+?=
 =?us-ascii?Q?2tocpL7XAxo4XZJIzPi2pjr3QeoEFyCq5295tkUse2nAQvKflhrpXk1VkQHO?=
 =?us-ascii?Q?sTDZdJmatF1wHFx4+mPDVKGLHolgXjMN7/xprNxyX2sHeWTeOyGteODOXss7?=
 =?us-ascii?Q?vvotK51eGtS217kxAkCOR1on+AV6BkaTH4Wougjk0AJnaaLHUeAyrJv5wt7Z?=
 =?us-ascii?Q?/Djcl3LQYYCbBo45ylzt5JReJ2WTS4L9hKh2xJpK1nC5hO0Lx74va09IVLy7?=
 =?us-ascii?Q?eMyDuFI9Luxw3OmyNR08aKN23CmJoqD+jqDjl9ivPXCnRweae5IAYoWPDyDK?=
 =?us-ascii?Q?csdX0Asa/XIz6rBpq/dsZcmBNlkLaQ0Y7R3yushVKQgNrK2avzpJqgItZOxM?=
 =?us-ascii?Q?cu5YOz2nLcDp8S1isP7zJ0bxgtREPC4qVZ2rx++oqwhUK1Ei9yNqiU0JCpGG?=
 =?us-ascii?Q?51/RTcTvpFsAtk2q4q/1UoNk4ItykJzgBSKDYmHpMQvLJVqky2H1tfgxQFde?=
 =?us-ascii?Q?mDCjPe4Mskn6z9Ed35bgh3OfluYP1K/I6LbV8a8PFWPZnqRdNb0TxQIkrhUz?=
 =?us-ascii?Q?TqgO9wnP11ZLtZ1Jjyjb8eWzKt0hEGbxREW67igC8GQ+uOOsNNndZcvUoHUm?=
 =?us-ascii?Q?/6sfqHM7Ph3soxsGl1TsqOeDaPqDACs/L4zZGgfbw4mObX3P+m4r9zv5BFLM?=
 =?us-ascii?Q?I5CTrH6bIMAxV9Dm1uh8GvHK4De8zy8rI9ICR2Te5a1UUv54aMtmpMyG5WRj?=
 =?us-ascii?Q?Rc5kdfDA5iYidbAJVwy/IcPnXao+jA1AERCp6svL6fDm1v07oGvln8ESffAR?=
 =?us-ascii?Q?Rdw4Qxx6/YfvTZ9bDE0F69vR2YxPF7hXLHLMlHDB178pg1HDIiij9u/Z6n4t?=
 =?us-ascii?Q?oGJyiHZDEJprv7XfCZ4YkzzRFwQ5nRQWXYWfPDP9Jusj4MOrjYh9GhXmj2lt?=
 =?us-ascii?Q?BOJMvNXH/oTS42bXA52SqJIX2BHFY92GvjoKZ7oPn6IQXGF/YdtrGmgIDVAT?=
 =?us-ascii?Q?OhytdJJgcfku0fDliZClplkuSLBCCrssOuQJzDjwpbuW7HADuDvtUytkII0n?=
 =?us-ascii?Q?kXfznDeXPCfW8ha8zGtG1Hux25N92SMWA3I8ZElpcIn5GmHK9JqbYWTNHPkC?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb5bb9c-038a-42c1-c454-08dbe3dce542
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 00:10:09.5048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgNMYeLVoaKLJZLKbYL9qJAvrwpQP9o7O573pcaWS7qW5YzcR9iR1EpETt3WnvErUk0tsLMVGMi0jGxjxyj4vfDgdrCSJw17+hOd3RoCvR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8686
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> A later patch will modify this code to separate out the mbox
> functionality from the memdev.  This patch is intended to make
> that a little more readable.  Related move of cxl_err(), cxl_cmd_err()
> to make them accessible from other parts of the cxl core code.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 261 ++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxlmbox.h   | 146 ++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 148 ++--------------------
>  drivers/cxl/pci.c       | 265 +---------------------------------------
>  4 files changed, 418 insertions(+), 402 deletions(-)

Given that the CXL mailbox format is being adopted by other standards
efforts in PCIe and OCP I would expect that this functionality is better
served moving out of cxl_core.ko into its own compilation unit.

Something like drivers/cxl/cci/, that CXL can select. The s/mbox/cci/
rename is a proposal to both drop a letter out of the acronym and
perhaps make the code a bit more discoverable / palatable for folks
coming from those non-CXL specs to find the Linux code. However, if
folks think that's too much thrash I am ok with drivers/cxl/mbox/.

As for the policy for raw commands. I would still like for there to be
some discipline of registratants to this facility to classify production
vs debug commands to give Linux distributors a single place to set policy.
I.e. keep up the need for consumers of this to define "Linux" commands
to avoid the "raw" warning.

That said, how much of what switch CCI wants to do should be an ioctl()
ABI vs sysfs / configfs? The raw commands are really only there for
prototyping until production flows are established.
