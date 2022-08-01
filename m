Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3372C00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 21:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiHAVeq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiHAVeo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 17:34:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADDC2A978
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659389683; x=1690925683;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=A45q+RrDi3YXxeCwktITjHJGEQ7InW3maz7Fe2+u9Vg=;
  b=Mz7jBcS0lkrBY65yEz8dfYF5PJl3Juns0r/pP0uip4fSPuB43Hsq+Fvy
   hjC/qGWwSnVI/LxGTmcGxVsqZ/3bss6k1RK9ISdRQmArm/sBk22e3N0jr
   X82o5dRaHLLyMPZq21sVlqFMAYnCn1wL0/P57ZKkw79Q2PZgbFb9t36FH
   e8sm/t8XRGP7owNjquj3WthjailTlJ/Hc9d7D8HwpSW7iRaNLrKtrxSpa
   HUGU8qXxdiUS5EImyBRVNUh8SDiTN6DmPP7uZJKNmc91/9ST9KqQ4aZly
   ybVUBHjuKmzMNUxxyngk5OrCwaBdFfL9A4QUe7a72c7taFUTgVPFBFIaQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="350965189"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="350965189"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 14:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="599077613"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2022 14:34:43 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 14:34:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 14:34:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 14:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SowxHoeMfR3nBQXnZmIwZkGpxIDsfiqIoLtzC7pZmGjpo32/BtfkvHudrazT2wtqYOf0JNUn2QIoP6sLEXYLM24ISm3oFkCbsxmFr119JKm3h25T5cQSXTQ9t+oQ4dv0q3cA+AMAvPrxIeK+EeuDznPPoD6rgLprgEwMTqsM77Ziu+8nmiLiu6q9B22lnvryfZ1G0+D8Gghv7UxVpjffXgOpmV1m/SdIpOo6HrfvUa1qJowk4+ORpS3925AUTNt/0wWhLT/KLxv+HHm+VQhu4SRMh69rGnv9tF6G7B+gl9k8YCUqezjK2qDi3/ndYLHSp/+9pPJ+bgLwZZzJvbd6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaHhIipRdJbwJBTBqm1OMAMBeTtHpfOKYR0nxIxyy/A=;
 b=AxKAAugx5dIgbw9NKTqrC3ofNYvobldo0l7R+YHaKVEsreTOVIS52z6cdOeLjo0q4m3c3aywiaB9VrexJNlfzF8jH89Uulw6H0H9W+98kV21uDxfGeU+UeD0DLjMcSU68aFc3Q7p7UvdWBPTNwlyFmLpBoeib42Jttb7WYxhOaZ/H9lVLHGvAScKsbhSLHY/81N59UjcTL421c/2A8jq19//bDgyl7Rrv/JRJiXT+dd5/82GrgWbM42zLB1Xi0t0iaIsNXhv35Uc1cHRm9FjVyjjMMSBJrF4DW6RGZQgDMvXMlPTYxzxEYvvfILaSWLSo75ZfWWg4ldYklZv5zTivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH8PR11MB6804.namprd11.prod.outlook.com
 (2603:10b6:510:1bc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 21:34:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 21:34:40 +0000
Date:   Mon, 1 Aug 2022 14:34:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/5] cxl/acpi: Minimize granularity for x1 interleaves
Message-ID: <62e846edf1f83_304402944f@dwillia2-xfh.jf.intel.com.notmuch>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
 <0db502f7dc66fdfdfeed41bb95ee13d431d909c6.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0db502f7dc66fdfdfeed41bb95ee13d431d909c6.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2fad867-460e-4d7e-a3ec-08da7405a3dc
X-MS-TrafficTypeDiagnostic: PH8PR11MB6804:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EfSSqZgjWNtv1TPwRHQ02/ZbXbdmRggW9y/4X0ur00bVLFyi88itl50NQVMQ/xXXhVjAOFtEVDDb5A2zQBOUMEpdpYw/MPTV7rVQUurHNRWa3dm102pfZc6Ucrr11pYljdsWWLmlexi01nGO7IWTmh41D1RbQkrMa6A3piEFvLq2JcoYIWE3dMxGBhVmxSgbFxYkm1CRhLNGAHjzjWbvPWNCGcg1zQTrOe6tIIB+50keTISGNqkZ+6317HOLOt5NCDIoTrmzyR2nR/U/Fg4sdlffpwSHorukXbApz8vuuMx6tGDCO6mIp/57jMiLv2/61/H1C7RP7uA6yHARhK+ReMktVonWOC2au8hpQKESAWVy9pW9bG3UdzUPCMmcSVNdDpDg/PxNOhob/WtWIM7NHUgS+gAj4vJI4yPjdhGlpszMwM1KFuoUurLVbUp0hCxeZDbFx7RmhaXHGJLOuHWQG/jaUpfltJVo2eWAdeQjfs4tFhWSgwf7KScp5D/8aSGair3D8Qzw9Q9OtEqHqr5AjoSCemUE6QCobAG1spaCXurQkh8D8CF2szRNAu2ayUAFFbvT0E/Ly5PilTT2divkiVL4AOhTamDL0AhIHdSE+zT20G2kLS8ktQ5GcuvzSIReYVUqXkMvGIZhAVgZWCjDvS1uLgoiTXZ8BhWQwNtBqA18kfK0f7HvlTN8/utGYtNU+FkzxKMmrpuU9zNvjwkUb1H6cHqWvB5aRuoD+brTCqR55aMtkwfkZKMNQlxUHSqt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39860400002)(366004)(396003)(110136005)(4326008)(478600001)(41300700001)(316002)(8676002)(186003)(86362001)(5660300002)(6506007)(8936002)(66556008)(26005)(6512007)(9686003)(66946007)(66476007)(38100700002)(2906002)(82960400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?g5gOwaOKnf/V14um8h2A3sP4SwqTMUkPZyr7kAdwnTtY1WSdiZ+t6ITtBU?=
 =?iso-8859-1?Q?PxsAsMPfgjgPC23MO+0MFnWDgi/CQTuEncH1wWnm39IUYzxm+qsoibgfW9?=
 =?iso-8859-1?Q?2axp1sII+aL3IMX90gRbQFwQ0uexzOiddAR+Qa7SZsrC0e4OfO67aFh5Jg?=
 =?iso-8859-1?Q?KDe6snkMZKEZqAYW0sO3c/bxAVVSX6/oiyPbdMOFh3unWS0GArw/QMKvyn?=
 =?iso-8859-1?Q?VQJV2sTZhXHSfoWcbidE+qOgvqXo5lids+3IiY7S1nMc11QsNnkUSKXL5A?=
 =?iso-8859-1?Q?UjsR9+0FdgS9gGq9fpX7wmmTG/GkHNVJ0cZKT7LXqcMp8D2UQDSgFPN9YK?=
 =?iso-8859-1?Q?u/YmGcSjNie92eNMQHacJfQ7wGyNp6AVC7M1n78imFgYR9NGOBFlhOA3PD?=
 =?iso-8859-1?Q?i+Lg2B911RM7l8L4lOCVjAMwmgi1hXbpn0juyPd05pl4O8cqlAAgHUey6P?=
 =?iso-8859-1?Q?7kzJ7PQ+XShiTVhM+MQ+GZBR+ROCWXhw6/SLsHEFOP5cxBmkntnC0kY464?=
 =?iso-8859-1?Q?Xc8ZRLadEWpnwxO8yTK8iGndy2bkxGY9ZHEKEuap9Od3Ei0Teldo4j20S/?=
 =?iso-8859-1?Q?g+TFxcWeQfD7tx2ijhArROwqrqgsdp5HAWTG9KqaFCAp8ZQQhDvDUGEK9L?=
 =?iso-8859-1?Q?a0ZVVUxCGr5CpHG/zFtq9nHYAXrvpww3MwhdlTAvEd7I9m9qVOVuiX3GAU?=
 =?iso-8859-1?Q?dPRpKNoowlfpaa8yboMX+G8ktvc7ElIy4fQtsuTzvYOhTOYUjMAxdWuC3q?=
 =?iso-8859-1?Q?8QkGjOzrMZF+XxjBAyNCnJ9Zdes8IYSTaun27waVv97U7aepFC4dW5RUEb?=
 =?iso-8859-1?Q?tqDvt0/SbfNqsMXHZdMWI1uQvxiT6bYZU1b+XKGpklsy3JmVfkCzpT8dbo?=
 =?iso-8859-1?Q?0s3aTJpKOlZlD59641toui9pq03ZatsIP1L9Q/L4W/SFWY2ri+4V/H0fsx?=
 =?iso-8859-1?Q?cxYKYquXEIgqALD9gthdT0xm3sNVbApPOVefACsRfqgEM6KXc9oeiPxpgR?=
 =?iso-8859-1?Q?JyZs9V/CbcbdlR7My30ckpUjYaSe9QFq6EPXndL18EDoNmHmi6L9SM7l5Q?=
 =?iso-8859-1?Q?UCteGmInmT8xfvkxTsumnGyKZ4GVqbu8kXHab6IaRWtPuZY5nSpiDh2Sv+?=
 =?iso-8859-1?Q?UXgBgIaQmKMvbMUuJsi5uyCitkO1gWb2bfzYaHHTihvqA7a6T4MzdLmu1P?=
 =?iso-8859-1?Q?QFIp/DLSbI1pC9Tdsmy9uOTleaO3/LhXws59c964/Q1AzV6yHsz6mg0GyM?=
 =?iso-8859-1?Q?UVSdufycIhH7A5qh0YAcX1x0ntj0v1QVacIkn6D4tlk8P5jfSx+j09DuYf?=
 =?iso-8859-1?Q?62piovcnKD5inu7YQJ2LJb5aiGIVqrDWyhB0WrSOWPzWGXO7wE0ehZyaRe?=
 =?iso-8859-1?Q?aiRfKoCITTaIHaP8qSaewZfN0ND1NjBFJr2eVJprskLqaZkAWB3NSfVTnX?=
 =?iso-8859-1?Q?CgTO31qRIw3CPn3XRzFNInHAoNs8mibAmJDQuYMsUTpa/wpX9b2Xl4SsnE?=
 =?iso-8859-1?Q?4oCroN+YP1Sz1wcyyDoqQN8TCNTmWGjAzuh4NMXyptWgcTuJOY85lxvtcY?=
 =?iso-8859-1?Q?AymV5NYmSCy9GP75iTyDyaCqtcz9guVEI3h0cmGYSZcewDelQiGnOewoOc?=
 =?iso-8859-1?Q?7fSXUU5z5RCFHMBL4uN/3qCkDaqMFrt6MynnUkUviqzhoy/YhsG2mVXw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fad867-460e-4d7e-a3ec-08da7405a3dc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 21:34:39.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68wfSixCZ4wM9/vbampSCmVjOB6v8vkTyyKQ0F0kKI1gUxGye9jlHZYMhukV72FroASCVMQ8VaUO/UhoK2o2wv+PJM2SaZPKziMcWljIzsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Verma, Vishal L wrote:
> On Fri, 2022-07-22 at 17:56 -0700, Dan Williams wrote:
> > The kernel enforces that region granularity is >= to the top-level
> > interleave-granularity for the given CXL window. However, when the CXL
> > window interleave is x1, i.e. non-interleaved at the host bridge level,
> > then the specified granularity does not matter. Override the window
> > specified granularity to the CXL minimum so that any valid region
> > granularity is >= to the root granularity.
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index eb436268b92c..67137e17b8c9 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -140,6 +140,12 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >                 .end = res->end,
> >         };
> >         cxld->interleave_ways = ways;
> > +       /*
> > +        * Minimize the x1 granularity to advertise support for any
> > +        * valid region granularity
> > +        */
> > +       if (ways == 1)
> > +               ig = 256;
> 
> Probably not super critical, but should this be a #define somewhere?

Yeah, something like CXL_MIN_GRANULARITY, will add.

> 
> Regardless,
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> 
> >         cxld->interleave_granularity = ig;
> >  
> >         rc = cxl_decoder_add(cxld, target_map);
> > 
> 


