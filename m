Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F1EC19F2D
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Aug 2022 02:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiHJCn0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 22:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHJCnZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 22:43:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2C76C105
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 19:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660099404; x=1691635404;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OJkxjhS3eXi9TJj8k4v4Xi8WZMsTUzUHT3gcQsl5HcU=;
  b=FmPdV0vyT0TIbwCG8Ea2GR0Fi8NYRbO0/OzacS+o6cKKXJIwojTB3Kx5
   FUbFuTMAcYp6oFTTPd5mVvcpyfM9yvDMjs4+a7NKYWAdvMIpaGUGLkION
   TPI2CfM7iWCI+1I87yj/EvWxFaBEgeeVwqJSACKJF1qQh55NLfpeoTA3h
   fE73ba/IlmgeyPx9R0lz2tJUKYd/hGNlGM2T5Z/V8m+x6PbxnaIYDClRl
   MIGEo5KbfXCmd9SoyXQ0mpbGscGlaQ2IoXxaVhoDeN8IYcuERXcrtQv+b
   xQMnqyyClecQk/zc1UhKhOENN/F19HgG+HPcS6oNfsf9pqSWfQjT3CWI7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="289735650"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="289735650"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 19:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="637940950"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 09 Aug 2022 19:43:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 19:43:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 19:43:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 19:43:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv148vutE1oDpdt/at1neA3+IdXGm8v3KgR8rlVYkY3JjnDLYzm4qfnk0ezkRgndDBMTJqNfL8MxhYhnoYzVq17iLJtWVimU43DEu8lsNc0PHmpjKLHK5UzUE3EIH0qyLax7c1eBHy9VvIsaGiKIa7BcJV5gP72xQIFdHIPq2pGO2g6k6awe0Ciqj8BDpH1u1gDFdPZ1D522icVHfHgUtFszOLTtrkKEtutqjp9c0WBA/HLyjP7pJi7PHuNousUecIRX3y7QUF8RwB+XIrocWRjItFcm3U/9UtJFh58oZp4QzoVyMHJ8kwD2rRbSQAoRnmSRk7BS+X8IgsSsxGJPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Yc/4RfJwMObaVOXI80fui8gaTBM3G44nYgYqMLmtFQ=;
 b=Q6dz7JQCYDOoMd60pIatN/n6PD9nkzY5CcJg7d7vJZuDyX/TEhgmbufaRe6W+74zAfCSj+djyXYwUrGIZwYFqKzaCZw6BUJLzJEY2UsDAgZUlJJjZ2BmG4NOysBQW7CWQbElX87n7ck758Q6TqHyB9U9+dv3oQzOKFCwLSQ7+zXIr+RVRw5SvB+1tmzNIs3nWsa/Mgw5HFfJ1xYWxBJO/yYC88cex/T6Z0FCFl07PVM5K4nrgNo+pZ2LT+dHjvpwXxC/CNRpgwvITm4//JGxci3j5tMYWTiA+ISvN8Hi+7Qqyl0Trv9zHe9wAvWJMqPc8DYOrPD1K4565VeOGRrwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH2PR11MB4456.namprd11.prod.outlook.com
 (2603:10b6:610:48::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 02:43:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 02:43:19 +0000
Date:   Tue, 9 Aug 2022 19:43:16 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <62f31b44ab3e6_33248294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1660079951.git.alison.schofield@intel.com>
 <f092ab4c6eb82c83c9cec4e7000bac8115c3664d.1660079951.git.alison.schofield@intel.com>
 <62f2ef6e71b35_332482941c@dwillia2-xfh.jf.intel.com.notmuch>
 <20220810011223.GA1757903@alison-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220810011223.GA1757903@alison-desk>
X-ClientProxiedBy: BYAPR08CA0072.namprd08.prod.outlook.com
 (2603:10b6:a03:117::49) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ffe8529-a05e-4fcd-83e8-08da7a7a15ab
X-MS-TrafficTypeDiagnostic: CH2PR11MB4456:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qI4sQITmzho/eR/fhizGRkoqkklfRMjSxlZKyuwK8FUuUZ0jDvahBjyEScijFi7P+Q15JrWr56EIJ1CkpGxe2pu8am15wvA07Xq0STF0StZXjhHHqF51b+dto0JgaYTv9nOQNDtMIbNJ/nx4NjV8soM3htmTmIMFEwjPZkDYZ8Y4zNFXDQdfSQTRdD/2gshu5SfrH3PQE/fmFEdkUqY01y4eU4dSEqVH88W6qWU8EjhXcBDw8h/LQ7jeRSpS/NIhAoWHBytY+9Tc5l2f/e2eUclONDusKJyiC2QQb8G9FZKdMNoMyJ2G6jwHm3244HBtJuWP4o0Rd0BEXeubrvaMQTPHU3dK3NaAq8DksFior/4w6dFGYOLOdLPa/2vfF+DKKEUjuz6HZh1BVUC1EMs+7yJp0v0l1Nmx8Zv6jBH9JBqJPF8g5lO4JPjSzzGH1BXURKWbbfJnCC9wqy+3p+821AtExipO8C2Yp6cRIVe5YB4qnA0gBeM2SlxVVxpLx/fXH6xMZm5KVIayhshIujpcT2JCxXspCUjlUwo2lj1PnuOojX9IzolTFDm92UgQ/aaS1UIcdNQgyq3aWuXjbJnTVc/Xf2adbKjB3mjGBeXTM7v+55w2apTSaSPMqKK70xILWIJjXMhtkoSYI2bRvV72BZFpap9VcTN6THmtOVrg8gH9NMU540uq5m18jcT3JjSVv+mCtYfr1fDjb4mmRpHwBFRrjX/+zTNOt6xKwadsWiq0uxESjIqDoDXH420dyQV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(366004)(346002)(376002)(186003)(41300700001)(8936002)(5660300002)(83380400001)(2906002)(86362001)(82960400001)(66946007)(66556008)(66476007)(26005)(38100700002)(54906003)(6486002)(316002)(478600001)(4326008)(9686003)(6666004)(110136005)(6506007)(6512007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dhnFvw/f+zfQkcPFkDCIOf2Yp7Eu7KXCyRa/TdJCUBDqeyed2v3kWKsOTFdj?=
 =?us-ascii?Q?SQdlVRp3/2UKx+FjKdQ8INFnRyQb+l39Ck1T/mG5/Vuwy3wn4B4EHldWwsQ8?=
 =?us-ascii?Q?DPthQGpmuPS+1DlZK+HC4wVJf49Zit3LFcjEVlzX0YLn8I6d8zI1tk0a4u3+?=
 =?us-ascii?Q?Tnz4skEcbaZYLY/7cqukZHHhsNGvDAdMv/Q/p1r3n9BcT2pQjUWcaM2jq4Hp?=
 =?us-ascii?Q?PasqvGmjGqHNuoUxgKNoPxxLmqktSY0JQrnSVur5129XUbfwEfqi6Oe3PmzF?=
 =?us-ascii?Q?cviNCdkI2VN72Qjd22+CD/jv3DnFqYwkX30ZhFsVFlPwbepBxL+NoqVpjRPl?=
 =?us-ascii?Q?xISTNsW5YaOm+yg0x6LT/xEo5wJ619uHdod/Mj/6XdB7zNZtGexJteKIKyRz?=
 =?us-ascii?Q?KCb1XzYl6tEUQ3CTNIXVE1myZDok24/09SkYq3ZTeGRPdlQeDO/ypujdGpY/?=
 =?us-ascii?Q?y2N4w6w+IkuWu0HPqptJlp8agN4kmqWpcSk0bVhYkvtSQ44+GvDFD2I7I/9I?=
 =?us-ascii?Q?LEh6G8XZjb4RMB1dY9ARlFymA5SP0F9KpYsMUAvnPUznX3c3dpxHk4gxa123?=
 =?us-ascii?Q?6ljPFkvFn/GqYG0Wu8vBsFqaLveh1WdjqFzhr9xrHsZClynI3j4r9OiwxvPi?=
 =?us-ascii?Q?8OwVYj4WgDB47rdLfZv5Ju5R5X+N8bfrSYQeSMfGUUHvP4+0cR9N6dQ2IFtK?=
 =?us-ascii?Q?bz46lItvhe+x7hW1Drn+6PL7q0cKSOYO5wCL81s07eO5FA4eIpDzWo9jbPlJ?=
 =?us-ascii?Q?KPgpEgJOuLuu6sAomc5WIC86FIcXS7ddgplZY3bbVkpw892yDY+QJsFbFTng?=
 =?us-ascii?Q?crP6PZ0zmvCPKdYozSWIg/fN9YFhq6k3fz7eIfAbOlgbGwV4/H+zh1YcEEsL?=
 =?us-ascii?Q?ZNyDdPDLhMylTaVY22+QJbfeqGgpxwNs+Ah9bugKJD/sH7WF46Hr+TjbCtF+?=
 =?us-ascii?Q?OBEcoJqqRSWZX4b0zu2RmVitTk2iPf53C1lFkn07oCBAx00WiH1Njs1U7ZNb?=
 =?us-ascii?Q?Sc/4FR19K3WOgr7yoona9mhLkpEcAwV6HOZO45SDFyKeNLXPRawS2hI4+mmX?=
 =?us-ascii?Q?TCNUZtOIqO780cv/8EGPj1RpvURk//IFJEdcCJnZ+EWrh7Czc/HJQKujTnL6?=
 =?us-ascii?Q?M162nISAxo+Fv7DmSj+q9swQMg9D496NUgoIxDqKy53XP50GmI0N76fQovCK?=
 =?us-ascii?Q?s5U4LTJ01Q86sB3C08dNa+G/DLV+4gIM1z5BIajtFA850KOZgTdyws2ts1CN?=
 =?us-ascii?Q?A30ngKZJOyF7WmfS+WLhduS6w1vCnzONkfD0e8USld1TNx/AIlyYr8UqdRVl?=
 =?us-ascii?Q?ya1Pgdi6E7C7VF+z1tsNSZ+ve0E537k0d5Eb+mEYspLHLVF3YAPGy8CeA8IM?=
 =?us-ascii?Q?xTYlQddsczQvyqzGCgM+NMbDBqdk2kgrcgLI4JTMlaVKO3hQO8hqBu6JooIw?=
 =?us-ascii?Q?9fe4nbJDz4aowLVoA+jrIPYjow/1miBPOWsEF9N7j4WuSPCRLTRI66VRTYUD?=
 =?us-ascii?Q?wPCGq0n4yiigi9YXl8ZiUlHD+TnFfbs9lM7DYz3lfGjvdlvF6reutX0ofZ79?=
 =?us-ascii?Q?7ljMrI4GMR12a99plrEyI2NJ691Ljb4i+E6nv6BCZFhZKYIQaU+YHcdHMWnA?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffe8529-a05e-4fcd-83e8-08da7a7a15ab
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 02:43:19.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUqT77Fn226s1A4Ba79txtChBOOh+rQoBAoNGYYb4HP0hHHpqsMqsuilc6VyeiKFJ+AlcX52uA0XgOvC7fvhzyKBXcGgFZRfuoJgYNz7up4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4456
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Tue, Aug 09, 2022 at 04:36:14PM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > When the CFMWS is using XOR math, parse the corresponding
> > > CXIMS structure and store the xormaps in the root decoder.
> > > Use the xormaps in a new lookup, cxl_hb_xor(), to discover
> > > a targets entry in a host bridge interleave target list.
> > > 
> > > Defined in CXL Spec 3.0 Section: 9.17.1
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/cxl.h  |  2 +
> > >  drivers/cxl/acpi.c | 96 +++++++++++++++++++++++++++++++++++++++++++---
> > >  2 files changed, 93 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index f680450f0b16..0a17a7007bff 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -330,12 +330,14 @@ struct cxl_switch_decoder {
> > >   * @res: host / parent resource for region allocations
> > >   * @region_id: region id for next region provisioning event
> > >   * @calc_hb: which host bridge covers the n'th position by granularity
> > > + * @platform_data: platform specific configuration data
> > >   * @cxlsd: base cxl switch decoder
> > >   */
> > >  struct cxl_root_decoder {
> > >  	struct resource *res;
> > >  	atomic_t region_id;
> > >  	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
> > > +	void *platform_data;
> > >  	struct cxl_switch_decoder cxlsd;
> > >  };
> > >  
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index fb649683dd3a..6ac6751c7f4e 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -9,6 +9,79 @@
> > >  #include "cxlpci.h"
> > >  #include "cxl.h"
> > >  
> > > +struct cxims_data {
> > > +	int nr_maps;
> > > +	u64 xormaps[];
> > > +};
> > > +
> > > +static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> > > +{
> > > +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> > > +	struct cxims_data *cximsd = cxlrd->platform_data;
> > > +	struct cxl_decoder *cxld = &cxlsd->cxld;
> > > +	int ig = cxld->interleave_granularity;
> > > +	int i, n = 0;
> > > +	u64 hpa;
> > > +
> > > +	if (dev_WARN_ONCE(&cxld->dev,
> > > +			  cxld->interleave_ways != cxlsd->nr_targets,
> > > +			  "misconfigured root decoder\n"))
> > > +		return NULL;
> > > +	/*
> > > +	 * Find this targets entry (n) in the host bridge interleave
> > > +	 * list. Defined in CXL Spec 3.0 Section 9.17.1.3 Table 9-22
> > > +	 */
> > > +	hpa = cxlrd->res->start + pos * ig;
> > > +	for (i = 0; i < cximsd->nr_maps; i++)
> > > +		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> > > +
> > > +	return cxlrd->cxlsd.target[n];
> > > +}
> > > +
> > > +struct cxl_cxims_context {
> > > +	struct device *dev;
> > > +	struct cxl_root_decoder *cxlrd;
> > > +};
> > > +
> > > +static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
> > > +			   const unsigned long end)
> > > +{
> > > +	struct acpi_cedt_cxims *cxims = (struct acpi_cedt_cxims *)header;
> > > +	struct cxl_cxims_context *ctx = arg;
> > > +	struct cxl_root_decoder *cxlrd = ctx->cxlrd;
> > > +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> > > +	struct device *dev = ctx->dev;
> > > +	struct cxims_data *cximsd;
> > > +	unsigned int hbig;
> > > +	u8 eiw;
> > 
> > Per your comment on Dave's patch lets keep eiw as a shorthand for
> > "encoded interleave ways" i.e. the ilog2()'ish value of interleave-ways.
> > So just: s/eiw/iw/.
> 
> Then maybe it's intentionally wrong. The eiw tells the number of
> xormaps to store for use in cxl_hb_xor(). The 'iw', as stored in
> cxld->interleave_ways would be too many, so I translate back to the
> encoded version here.

Oh, what threw me off was the:

+               cximsd->nr_maps = eiw;

...because nr_maps is not @eiw. My suggestion to just change it back to
cxld->interleave_ways though is also wrong, sorry about that. 

The calculation for nr_maps is not ways_to_cxl() it is just plain
"ilog2(cxld->interleave_ways)" because the nr_maps needed for 3, 6, 12,
are 0, 1, 2 respectively, not 8, 9, 10 which is what @eiw would be.
