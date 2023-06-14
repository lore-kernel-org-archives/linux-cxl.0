Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E24EB64D7
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 01:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjFNBGV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 21:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjFNBGU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 21:06:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EF31BE5
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686704778; x=1718240778;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w/c4Ep9R02I66UWU3ArtVLaERG27kKdIgoVLNpJVgkk=;
  b=d2c2F4IsG/jyZeq60I61IqrRQPA2H0MhcRNa7jbI9Q4Ec21e3OWbreJb
   Wvkyd58hmCToHlo4PlAB0UOZlwsB3q0bkxCkO7Hxx4DfcucWJ84eplepf
   ViPTNKUaFP8/A8S95Tb8zyTus2bStuqgEA7PIIiFAvQviuV8DG9wTDi8r
   6Ak/2SA/89/YTFtV9IamD7JB3B4g7TueCHsaf1ULMZIReX4qX7E/P+gMg
   qcgulV+ucs/vC46lt3+yxPFR4BVgH6UyKgGf5WoheA2Mwo0l5hmWtwa5i
   0l4UGtui/G9+TxFPQT8oYqIztVJwGlQ4oW6bI6mubhWC/KR73Xd38wuil
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338123563"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="338123563"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 18:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="662197573"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="662197573"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2023 18:06:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 18:06:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 18:06:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 18:06:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 18:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J78k9WK2ESq+l2clb0cSzr7PT0+SQdtI7MuMADXUuvGaTABnfAtex7x38zpAhx6h1ALkfb/albNO5RoSG9eJtORH8hM8D1skG8EZXJQTnSj1wI8qQzeZjihmGPOzdW646fZP7/5muhOxlIJzLRFabU1m/gUEPdHkFJGVwKZuEU3nwqv841ywbU2Fay9/ssKiNXoj+D9Ym/H6k7p47hYxdPJjc6/bVY2SPgQ539KavDdeU5SZSUJANbSQ3FLMveyULZ4O0kmdoOgW6ZTNZ76gwEDsT+NGJktBesL4hAMbi4jUeX5Mzpd65KsGghB5kNps/ylCRnxEhRpYVz21laW7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBEFH6UYZv79J0HY/0dvsu4hGNnHpIPOjfQZLVePMH8=;
 b=EcVH4ISei/VyOiy0hSkiz/d4w1OQdApb2KVehvYK1h8iC0OxiIABHi5IQxa4ssucMtUC5PmM8+/T7jXmdcau5zsOuHdJu8U9ulNGxaHQBrHWu0H6PJoWAKnDaRv7dze+PwFTFumw0rC+SFTGXvuSOGWdRj96Pji6fxmbx5NCu8GJgdWRWFQ3CcF9prLXggigDVnF5srzPpd51HU1wv4ZgB/shzH/WKwWzRPIUARGzGwq+vCeLfQSTgT+Un+YCyb4IG26Mp8ZQp/Fbwx/SdvjcfX9gUWeO0HL7k8etmIQnnoCiTNoJZ+4KM3ynqoHUOAbM4cVG51b94x+5Ay/OkO5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5122.namprd11.prod.outlook.com (2603:10b6:303:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 01:06:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 01:06:15 +0000
Date:   Tue, 13 Jun 2023 18:06:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 08/19] cxl/port: Enumerate flit mode capability
Message-ID: <648912849903_2f4fca2945e@dwillia2-xfh.jf.intel.com.notmuch>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592154146.1948938.12085726872761686977.stgit@dwillia2-xfh.jf.intel.com>
 <20230606140419.00007a54@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606140419.00007a54@Huawei.com>
X-ClientProxiedBy: BYAPR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: f8675b54-5518-477b-e312-08db6c738d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLXn33qaxTMgvIEvznYoi/clTQ0K8u3qLKYWFRWczv9iwZYIrnCDOFdBwc4+QTfL1/FWW44D0Gkn1gloB01vcxJqoTfayBjLOnTyZ1MrHXcf2yc56DktHpEP0SbphohEM/YKWtfvW4xZSayvaQ6YmR924vFnzjkuorTnmNGbfoAeOqzEnhb7B5Dow+atTbm6xnMpGBNqd4sFzMUQCV+hW7Ol+tz7FpIx08+4bKqt104Vc+EOuZWtVoroZCODa0gbfn5FMaNNxK3SSQEupp3W1UVoPaaZaUMxQS4AxMzySknUTYRBgPwip7T7Ql0OTdJYrxGK4VtCp+OT9mcKOU5ly0u8TOhHLmsPlZfOdgVcM5AzYcO7u8/zMrrCvNO2ZXftVN+b8KurlCVjw2bperiJWnbGaZP/Xi9Kvdsk7u81J8Z7TgFXm74GHF7UCfimaf7JMKCavsAFBtseq9aBEFLU0CgW1p91QlVeC1sUv4m8UPM7wjO02mQXFEv2Shh3LRxNpnpb9kF+anBLuOA8j57+RlPj4AgI3rsyfui3gaCzXkqgXOuutbMW4rj/FJlDA6wm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(107886003)(6486002)(6666004)(83380400001)(38100700002)(86362001)(82960400001)(6512007)(6506007)(9686003)(26005)(186003)(2906002)(110136005)(66556008)(478600001)(316002)(66476007)(4326008)(41300700001)(5660300002)(8936002)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r4DhOXFbocZXQgsS5I5rpoz7yxHdo31UII3ZZca6+ErdVXJsR6WI/XueLUVJ?=
 =?us-ascii?Q?EsEXXIP8lp6RfsguLhheggkKnwL1efFLuiTVGO9+2a2gWIpHogVbPol2Ohjk?=
 =?us-ascii?Q?Wm1+jvWiOzSgQoNnWHiy6xOXSFtdLCXc4MYgyFQJQ11NV83iJTVWVHTWYyLp?=
 =?us-ascii?Q?X8WJqvwLQ4d6Jwf0MUG+eeuxA1si+L07VFvpywHAt/60ylFLNXUL/NiSGPgg?=
 =?us-ascii?Q?oHaRjO2E0Ys8WHpcGyFYwIfjdFRCpPaUsj+GRUan5Y/flCDDhlIn9316SzQj?=
 =?us-ascii?Q?wA+ccTLXpFF7dEKap76hLfXnpZ2UFI05AMHRCRkPoVZOVuYuZqxINGhOBrlM?=
 =?us-ascii?Q?b0pgk/9eYoJ2dj0DlM57iT7X/EBZFCvH2+RCUIjNwttnkM941ndiJWTHqrKD?=
 =?us-ascii?Q?jC2XluxdqEJNeWO2HJr41N51pj8tvYC8qPtDgn5qn2R/o7QIfNYHMvSvZ/xL?=
 =?us-ascii?Q?CrViO3/sAvGi6In5aWwCTo5cCSawcP1XV2zBrMn0WtRr5O728tQbc6Wpq4Mk?=
 =?us-ascii?Q?qhB+mFlLgNtkcTIhkPOwuFEuvLvFysATfCrFwsOL0JbbjfO76IYqpNxKeNY5?=
 =?us-ascii?Q?NvdP5F3BujHqs7GAvWiIFq/Ao5WRlbTjI/igyMxrc+w9Wa4UDek0GPVWzx8C?=
 =?us-ascii?Q?ppa3bE4Imqh6VUzX8rAhuieqBlXJHpkvGwFIMhQCU2RREfAGcvkM1e6G/Gx0?=
 =?us-ascii?Q?YnXmIOfhdap+UJYEJIl3zKCJxGpfZEIk5cVZNb/Yxym0nuP+uciV6WmnOQx5?=
 =?us-ascii?Q?Zh1enV/Z7W+zsrlPS9P5jEes0xs+zCZ8ACBdWDryWSRrUuElij9n+jBhuNiF?=
 =?us-ascii?Q?QnxjkN7BYuOXCeA4nss06U7nBV1VyhIMJ7WdtgbKNdgJMriZOZgPrfzf9/IX?=
 =?us-ascii?Q?28HypU4gZwnSByZkXZJC9wcTxH6/Eu3Ew3AL1qozP6vFpXxxJOg3R3QsO1XK?=
 =?us-ascii?Q?hmxTGzAIxZRyFGVHb9AOTl2Is/pz1iFVlCQ6OORLAKmL6rFzHUNbWsvl9fz/?=
 =?us-ascii?Q?8AaaEFjXfLq3Wok0+zoQPEYvHS2C3LO/d/bHFqe4lXkzl5diLz1gppSJpDjt?=
 =?us-ascii?Q?F5cIFEV/d+jjJkUDQ8aJOlCBKlN9mwomTUlMg7exJfTSu2T20P1UZDd6xfDw?=
 =?us-ascii?Q?GHiefgwzAc1BzJ+wRiE7bNSy6J5rdmdUZ9lZ0yLp1frt1jp+itr0RyS/Bf5n?=
 =?us-ascii?Q?biWNVDpoBD+8tMQ6Ytlkzo9+z9AzSg/kRIbG2U8cgxEXZLt4svo3lB6aAjfZ?=
 =?us-ascii?Q?PV9TfMoGBmfNub7bct6affmLq0zw7bLNIIy2DfWHWlzAljhWUOocM2+rR0oQ?=
 =?us-ascii?Q?kzsizUnrVYF15UiDCpUHbvVndlX/zKNZbVngTbo6St40WYkXkDhmHALSFR0l?=
 =?us-ascii?Q?eeI8mA+CaJiIPErvgJhzeUJMjaCG3Vt6FeKhIKAPnJmZ9OR2fPTSyEFFS7Lv?=
 =?us-ascii?Q?o4YIUmcJvvvVhX/dGOkmBsfZptEXCwFlVaxoZ/0+sDKmHmGAeaxUDnc8Wp/e?=
 =?us-ascii?Q?QcnWzqbtXuCGy5L19mIroI0dNGzmC6C2naIolYHWoOpcKkWKKPeApWz1MJEI?=
 =?us-ascii?Q?KzPC73zxGNfeCoIgU24aU+NnheUg54WGc4ygtF69DTg/JVG4QlyBVresZoz9?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8675b54-5518-477b-e312-08db6c738d0a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 01:06:14.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08RLMxl12bhT7HBv4PgknYnBd9RGWt/eo7pVXqi3IpyRp+HQ84JUec88Aea9TgJytdi3zMBBnh1Xng+p6w6WP1zzeI0GpHUESl9CrezOyYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5122
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 04 Jun 2023 16:32:21 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Per CXL 3.0 Section 9.14 Back-Invalidation Configuration, in order to
> > enable an HDM-DB range (CXL.mem region with device initiated
> > back-invalidation support), all ports in the path between the endpoint and
> > the host bridge must be in 256-bit flit-mode.
> > 
> > Even for typical Type-3 class devices it is useful to enumerate link
> > capabilities through the chain for debug purposes.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A few minor comments. In particularly that the field you have in here doesn't
> distinguish between 256 byte flits and otherwise.  That's done with the PCI spec
> field not this one which is about latency optimization.
> 
> > ---
> >  drivers/cxl/core/hdm.c  |    2 +
> >  drivers/cxl/core/pci.c  |   84 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/port.c |    6 +++
> >  drivers/cxl/cxl.h       |    2 +
> >  drivers/cxl/cxlpci.h    |   25 +++++++++++++-
> >  drivers/cxl/port.c      |    5 +++
> >  6 files changed, 122 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index ca3b99c6eacf..91ab3033c781 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -3,8 +3,10 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/device.h>
> >  #include <linux/delay.h>
> > +#include <linux/pci.h>
> >  
> >  #include "cxlmem.h"
> > +#include "cxlpci.h"
> >  #include "core.h"
> I'm not following why link related patch should change includes in hdm relate c file?
> Maybe later once you use it this makes sense?

Definitely. I missed that this straggled in here.

> 
> 
> >  
> >  /**
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 67f4ab6daa34..b62ec17ccdde 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -519,6 +519,90 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> 
> > +
> > +int cxl_probe_link(struct cxl_port *port)
> > +{
> > +	struct pci_dev *pdev = cxl_port_to_pci(port);
> > +	u16 cap, en, parent_features;
> > +	struct cxl_port *parent_port;
> > +	struct device *dev;
> > +	int rc, dvsec;
> > +	u32 hdr;
> > +
> > +	if (!pdev) {
> > +		/*
> > +		 * Assume host bridges support all features, the root
> > +		 * port will dictate the actual enabled set to endpoints.
> > +		 */
> > +		return 0;
> > +	}
> > +
> > +	dev = &pdev->dev;
> > +	dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > +					  CXL_DVSEC_FLEXBUS_PORT);
> > +	if (!dvsec) {
> > +		dev_err(dev, "Failed to enumerate port capabilities\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	/*
> > +	 * Cache the link features for future determination of HDM-D or
> > +	 * HDM-DB support
> > +	 */
> > +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &hdr);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_FLEXBUS_CAP_OFFSET,
> > +				  &cap);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_FLEXBUS_STATUS_OFFSET,
> > +				  &en);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (PCI_DVSEC_HEADER1_REV(hdr) < 2)
> > +		cap &= ~CXL_DVSEC_FLEXBUS_REV2_MASK;
> > +
> > +	if (PCI_DVSEC_HEADER1_REV(hdr) < 1)
> > +		cap &= ~CXL_DVSEC_FLEXBUS_REV1_MASK;
> 
> I talk about this below, but I'd not normally expect to see this.
> Anyone who used those bits out of usage defined by later specs has buggy 
> hardware and should quirk it rather than having it built in here.

True, makes sense.

> 
> > +
> > +	en &= cap;
> > +	parent_port = to_cxl_port(port->dev.parent);
> > +	parent_features = parent_port->features;
> > +
> > +	/* Enforce port features are plumbed through to the host bridge */
> > +	port->features = en & CXL_DVSEC_FLEXBUS_ENABLE_MASK & parent_features;
> > +
> > +	dev_dbg(dev, "features:%s%s%s%s%s%s%s\n",
> > +		en & CXL_DVSEC_FLEXBUS_CACHE_ENABLED ? " cache" : "",
> > +		en & CXL_DVSEC_FLEXBUS_IO_ENABLED ? " io" : "",
> > +		en & CXL_DVSEC_FLEXBUS_MEM_ENABLED ? " mem" : "",
> > +		en & CXL_DVSEC_FLEXBUS_FLIT68_ENABLED ? " flit68" : "",
> > +		en & CXL_DVSEC_FLEXBUS_MLD_ENABLED ? " mld" : "",
> > +		en & CXL_DVSEC_FLEXBUS_FLIT256_ENABLED ? " flit256" : "",
> 
> Definitely want that text to be more explicit about latency optimized

Ok, see below, I think dropping flit size altogether from these names
makes sense.

> 
> > +		en & CXL_DVSEC_FLEXBUS_PBR_ENABLED ? " pbr" : "");
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_probe_link, CXL);
> > +
> >  #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
> >  #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
> >  #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
> 
> 
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 7c02e55b8042..7f82ffb5b4be 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -45,8 +45,28 @@
> >  /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
> >  #define CXL_DVSEC_DEVICE_GPF					5
> >  
> > -/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
> > -#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> > +/* CXL 3.0 8.2.1.3: PCIe DVSEC for Flex Bus Port */
> > +#define CXL_DVSEC_FLEXBUS_PORT					7
> > +#define   CXL_DVSEC_FLEXBUS_CAP_OFFSET		0xA
> > +#define     CXL_DVSEC_FLEXBUS_CACHE_CAPABLE	BIT(0)
> > +#define     CXL_DVSEC_FLEXBUS_IO_CAPABLE	BIT(1)
> > +#define     CXL_DVSEC_FLEXBUS_MEM_CAPABLE	BIT(2)
> > +#define     CXL_DVSEC_FLEXBUS_FLIT68_CAPABLE	BIT(5)
> 
> This one includes the stuff that makes it 2.0 rather than 1.1  Might need a longer
> name to avoid miss use? (I checked the 1.1 spec and reserved so would be 0).

So maybe I will drop the flit size from the name until a conflict
arises. I.e. this bit is relevant for all known flit sizes that support
VH topologies.

> 
> > +#define     CXL_DVSEC_FLEXBUS_MLD_CAPABLE	BIT(6)
> > +#define     CXL_DVSEC_FLEXBUS_REV1_MASK		GENMASK(6, 5)
> 
> Unusual approach.. Shouldn't be needed as those bits were RsvdP so
> no one should have set them and now we are supporting the new bits
> so should be good without masking.

Agree.

> 
> > +#define     CXL_DVSEC_FLEXBUS_FLIT256_CAPABLE	BIT(13)
> 
> Not just flit256, but the latency optimized one (split in two kind of
> with separate CRCs)  So this name needs to be something like
> FLEXBUS_LAT_OPT_FLIT256_CAPABLE

Until a non-flit256 latency optimized mechanism is added the flit size
is redundant in this name.

> 
> 
> > +#define     CXL_DVSEC_FLEXBUS_PBR_CAPABLE	BIT(14)
> > +#define     CXL_DVSEC_FLEXBUS_REV2_MASK		GENMASK(14, 13)
> > +#define   CXL_DVSEC_FLEXBUS_STATUS_OFFSET	0xE
> > +#define     CXL_DVSEC_FLEXBUS_CACHE_ENABLED	BIT(0)
> > +#define     CXL_DVSEC_FLEXBUS_IO_ENABLED	BIT(1)
> > +#define     CXL_DVSEC_FLEXBUS_MEM_ENABLED	BIT(2)
> > +#define     CXL_DVSEC_FLEXBUS_FLIT68_ENABLED	BIT(5)
> 
> Again, not just FLIT68, but the VH stuff from CXL 2.0 as well.
> 
> > +#define     CXL_DVSEC_FLEXBUS_MLD_ENABLED	BIT(6)
> > +#define     CXL_DVSEC_FLEXBUS_FLIT256_ENABLED	BIT(13)
> Also latency optimized is key here, not 256 bit (though you need
> that as well).
> 
> > +#define     CXL_DVSEC_FLEXBUS_PBR_ENABLED	BIT(14)
> > +#define     CXL_DVSEC_FLEXBUS_ENABLE_MASK \
> > +	(GENMASK(2, 0) | GENMASK(6, 5) | GENMASK(14, 13))
> Ok - I guess the resvP requires this dance.
> >  
> 


