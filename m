Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1649C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 02:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjERC7y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 22:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjERC7x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 22:59:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71087121
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684378792; x=1715914792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dx3KIOZjH6OSmjLRvoybWrxgiG1dV3te4FqgHtl+AGg=;
  b=X/3yAivObKF22dfTPlkvZ67pyZjtn/7SlWloVaAujqtiC91ZOieRWZWN
   VpBPdPIRxV4ZmkymNviYIQMOpjWEcuzn3IelnE6AA3kt/+Yi0RGn6zOGG
   Rd4BW7LBoNFg4UILMi02L03x2X0cQxFtm/fVINo5heFnVEDefWY29CmqN
   6uE4wqsV4oIuHyCfGzb9ND1dyobdqEGTOCmXxXYeTjSnV8rPPl7rMK9II
   ceyjYL9lni44mP6Fsc6qW4ERqx5YCryAg3aBo2Qw56lvInL22s6Ft97+a
   JEZ8bLs8RlmT8IBq3VRAFVxOIjA51GZ0AQr19XKev78M2FGBz39bfV0Vr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380149265"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="380149265"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="696140825"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="696140825"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2023 19:59:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 19:59:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 19:59:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 19:59:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YALGT5PQBiMBQWoRiP/RGCzpDPg8OhmG1imVuUyVTREblWgfZA0YgrdYlnPeRSQyLrAg5dj/fXi/Vh6zwAsp99z8suLfOHOwkYKFUegZ7GBfgouXC+Em7/Sg8Yb0rC6maMFtFEtfgCel/PO1GysTvQANuMICCh3U8RoA6fbizorHxqonVwCPD3yNiz3Mo2rWnHK3fkG06O7pBNvQODiz4Olruj0JqssqGMKFh6x5DxNRInjpqLLQ94f/eJQ78RlGnaf7ODGTnKLPvYvIHVYXpBrWGAETW5wJOda+av8HFJhortcO7EDEzG1bcaEupbepZ2IbXKU+6XxQX5NiGI3fQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIUjg9F3xOaZj+wcdAQmcyGO8Im9qnG7eUJ9VxO8PJI=;
 b=EK6IGVbGQR2kRJLsE6XYm+ewOSpiFRkMhomyp2r38MZgDTBrwtumyTlQjyv/cf5Sa4njJl7UYq4LIGYZ26+KMqpYROnMsMRQ6qU6BsnecyQXudwWKRb/uG6tjQFPVUfSxX6cAgUTuuO9a+xsitZhso4GwpqPaSsEb7L4Gogqgxn0rkGr6oQ3bqU5vS6Rm9l0rjSpj/HN1FfxrJJ7LBTvI/rrzC4oVG2xJJccSgsjmhxc7lqhmfU3nqwAtyWCRduYcqiJBBtN4rDLdlDVZhpo/a0xo/1VHNGLK1xYpCKBX0yErfpJ+8HOtXCYch3ItNTFMS8eqlK6kQ/amrA0p3L9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 02:59:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 02:59:33 +0000
Date:   Wed, 17 May 2023 19:59:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH 3/3] cxl: Move read_cdat_data() to after media is ready
Message-ID: <6465948f96968_109619294d2@iweiny-mobl.notmuch>
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
 <168428297113.2205351.16197713607932380832.stgit@djiang5-mobl3>
 <646593bbe667d_10937a2947d@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <646593bbe667d_10937a2947d@iweiny-mobl.notmuch>
X-ClientProxiedBy: SJ0PR05CA0134.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: ef069297-1ce1-446c-c544-08db574be7a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9bMJh4/PzkqlTJoifXT5sG3/ygldCCbhuRu2WkN5/alupy36471t0vFpOkp6Fg6EZmZ5bJvLYTQYJ64o09WZdmyB/ezepk6kQzhT7UiPFXd3VIrtB2LBAeHRSfGqi/nK+6RT908bCayD9Q/YKVdrZyqIYf7YspRnltpSIcZeF1kNZ3PE5kDJSIUBZ/xKbCLYmV6OJZPlXSAchdlVMyDLC1PNPe4oeEsGQGfe6iuj4FvdxIFhCBbdXEC4/PGkERRcPxHsSL/EyuJCHGnQlHiwWkzwoRGza7wRIyePkzX3RpAluZuNpiN9XwCLgVpaN4TtClCkiw1UcVSa8ajXGb5sE2+iNMc5Udp+t/bdiH8TU3LXLqwPGncLJSiy8W0Iz9ltlm+pcZjBBBdEUwJS2/d2OWTQoePcnJrf+ziygR/7ml+XhbieC9r8VpYr3xl97xQDcTqAG6RaVq28QTS3/Nda8sCfbBb40QjIvZX13oKwy1/iBwwuWQvAtozJbSXu3yjzzdQonFB2Vt4gdeJDQ33ehR43oZ579hxCk59N2N9bdcC1xT0l7zCY49M/HGaj8M8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(2906002)(478600001)(316002)(41300700001)(110136005)(44832011)(6486002)(6666004)(4326008)(6636002)(66556008)(8936002)(8676002)(5660300002)(66476007)(66946007)(26005)(6506007)(9686003)(6512007)(107886003)(186003)(82960400001)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EApYariY94p3xedKO96f6ZqeAtBxkwIbci99LU2G7PsvigNkac52AKJNm6dg?=
 =?us-ascii?Q?Vxa+aEWSGrDUlsQkK5Q64nnQ2Dziqc75kR6kfPaHYw07/mUNpYcLOOqnWddM?=
 =?us-ascii?Q?hfwSMEm9nTmixj06hHUkGv0305rH4MtmvbxM/FfjOVUUpQnVdPzDpNt8baK1?=
 =?us-ascii?Q?epIcYl6OjBKUBejheNdEGpyf6STIDWmr4bpZdOkWJLqcMIT/KVfnA5jmxmFr?=
 =?us-ascii?Q?/85bFoYhKSAiOLI9cGiLWYTc9qzdZJzY5ldIcHyWrmF7xxDoUDi71h952ZS4?=
 =?us-ascii?Q?Bu5EGjM6uAFUjv8Hnffv1KmpXFPSkUJT7OOs+YPWv7ih2MJI7IeDqMld2YTq?=
 =?us-ascii?Q?wX9e1Y36TFNJ6/fbKU3Lr7hE3TUee1DVMt9nkSA9elVDK2SjF/9y1L2YKfVK?=
 =?us-ascii?Q?spOho6t0Mvvo/EmUqxjORzlNVYl1Ht59lmbKzUMb1kY9SkpsgrespRy2UHpq?=
 =?us-ascii?Q?s2qjwzqUuKcuMMniwUP7yaSGIln/TrgQM/3Hq3f9K2NOWuwI/At1HFTAe4I1?=
 =?us-ascii?Q?9lSq8+KcikeP/fEtEX5F5waMzDuK2KCoSlOjxNVLQywySwkegEYHf/uR6/KN?=
 =?us-ascii?Q?jzCVKlWrNCb7bn3hMYJ5RhTygNgaKYXjkXBEYtAc122lPWXylYJPS7MfnGtd?=
 =?us-ascii?Q?Cx7KZ9dfUqlej9AmAYll1xapYyX+/yFmBEYEllRdzIoUdGKPgrY1fpQ9Ern3?=
 =?us-ascii?Q?UpuvZeBau0NW4J+DFrkLpJBBxbOBR2TX0mRCD5jGplwuLHwBAzVOJcJhIacu?=
 =?us-ascii?Q?ed8J3iajdseHdH/9bBVGxjVap6T28G4K/xPTeyid48qSRg6T3B491787D8Xm?=
 =?us-ascii?Q?d8pi9+wtc3GeS5d8vR8XulQRNA6V6lkpVymoU97j/Q6yFzoZXgiaLzzui80f?=
 =?us-ascii?Q?97YVKNy9TnbJ9ViVd+9WfQ1e7YQuR85wM04Sv+pqBMPlHCuY/YXsTNjyv/60?=
 =?us-ascii?Q?u5sl+W8D+BD9r7u3eLM4gexI9OYS3gf0rxPh3R0077wGyNxyuWG9uocBYQ0i?=
 =?us-ascii?Q?ehPnLlF5eoaVvE/jEm+egJWGH2CfHkva6TKZGq8cFY8A3F9P820Y+/REgWs8?=
 =?us-ascii?Q?CD3LAY1QzWa3YHifq9EUlVHrHUgkRLdal4OAac7ueCC1c2h/ZfyoVLn/VgkM?=
 =?us-ascii?Q?lRDzTEocArcIPdNUATyXeO9gK2v8iN3c8Z7hH7N2df+kskS7tDzxifUEok8P?=
 =?us-ascii?Q?ZvxOn/rIEMLIIA/BIPx1q/yj8Vl0eB7T6HWnPoRklDWcWhqJWOCXm9J3JYbI?=
 =?us-ascii?Q?wjoxmFGrikNfa3O6O5BGnp2UlZAYxP8kNgIdCJfVlm69SiryUQNM/xFQfZuC?=
 =?us-ascii?Q?9vZDi+eeuG3MMq7Uc1WI36COgPU6RhWWspphYL5YqlYX60nvqucgJfqJyTOz?=
 =?us-ascii?Q?xs0KL5CZepa9IW0yRxFfn8AHGKxq3ymcLsaX2W8AX041AYWOHBCW1DZidC62?=
 =?us-ascii?Q?M3womTipX87EhxOSg+HNn7y+DZddzeVMSs78Eyd0kWldG49GYwCZrmX4hEzv?=
 =?us-ascii?Q?eHrlUpe79WZXmKxD+/YavzMmP+Sxo5OKH1UDY48s/BSZ6JCRV/ey/mPCLlBl?=
 =?us-ascii?Q?CJP2m9ieFxFYcR0SkEUqfMyY9BjPucpCU9gzvzlR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef069297-1ce1-446c-c544-08db574be7a1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 02:59:32.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qR3hzscKyj0SdmPmYL7yYWYC7BwoV1P+GmPk7aijNBgyrYCSbQR+1Qok0bVxALBkIatrIRQb90Vwitss+gtqfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> Dave Jiang wrote:
> > CDAT data is only valid after the media is ready. Move read_cdat_data() to
> > after cxl_await_media_read() is successful.
> > 
> > Fixes: 32ce3f185bbb ("cxl/port: Split endpoint and switch port probe")
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/cxl/port.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index 40e7b7de8bf6..bebc297fde5c 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -96,9 +96,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
> >  	if (IS_ERR(cxlhdm))
> >  		return PTR_ERR(cxlhdm);
> >  
> > -	/* Cache the data early to ensure is_visible() works */
> > -	read_cdat_data(port);
> > -
> >  	get_device(&cxlmd->dev);
> >  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
> >  	if (rc)
> > @@ -114,6 +111,9 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
> >  		return rc;
> >  	}
> >  
> > +	/* Cache the data early to ensure is_visible() works */
> > +	read_cdat_data(port);
> > +
> 
> Does this apply to the latest master?  I'm not seeing
> cxl_dev_state_identify() in the current cxl_endpoint_port_probe()?
> 
> I think this is good and needs to go in but I'm not sure where this call
> is landing now.  I assume it is right after cxl_await_media_ready()?

<sigh> Never mind...  I see now that patch 2/3 added
cxl_await_media_ready()

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Ira
> 
> >  	rc = cxl_dev_state_identify(cxlds);
> >  	if (rc)
> >  		return rc;
> > 
> > 
> 
> 


