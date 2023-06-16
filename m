Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC6EB64D9
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 02:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjFPCr0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 22:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFPCrY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 22:47:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB659297C
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 19:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686883643; x=1718419643;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tFnhMBhSGXdG5Eyau4CYsmCN5vB8cfoSP9Eq8cDFrTA=;
  b=AMf/L7NreSa+pviNtBp1NwL6D3tdI0EDQwQF64EQ45xSwIpDOSqngsiP
   6fvtWyfDumnbiM198xd/MPLkiMtOMxHKynzrqzc3ZLQypXRUHSFadW+Zc
   C12ztIt7+nRFpU5jhfCemWgY5jHGTV3Fs4kW8pgm3xTxzBjDPaZk8aXvp
   3IJzzequmisUQe+n4M4IRhZYmbqty7sOb663lIktRjHk5jnmHEr5/BpS9
   2sWSGAFdPK/OVaKBJAdxVNjhsfwEIHoYD8lXR/XzffOSdjDWEmpFZEQb6
   8EY4ymqJNepARmTastufxvnKHyiL2AgomwA8Pa/zusLljQvw1uQiDzOGM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="359102654"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="359102654"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="663009483"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="663009483"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2023 19:47:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:47:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:47:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 19:47:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 19:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG51P2dhg3csWqc9HPBdcCK6twkLtqLNlDUa46VRfMui/kuyl6HF8TfFDDYIqI5gpuB7XKmWAKPEvnwXrJP89JEEfAPXabcO6aG+VZDPr222NqWgEWcw157Vakx38XiLg52Z/yJiMgAZgvwVDALpjN8M/TkGWDB6NrBYHgvHWbr7bYfg9UgTTAarB9s3d9jb2E2B//LioYNpg1x9l/+wu7eNzPfJfc/8F1HWC2QjvzIFxB2OgwZhyo5/p08jsWFmN35k6OjPxKwfpuN2BLiENqBagMWnRikBzKh4LQm2fxFH0kGJHzuXpDAT8gXSnKCBEWOwo8L8wKMaeWg1PULsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xbBQ3b4VnqqZmh3rHe3GSqU0MlRKgns3nZCxl69Llw=;
 b=GEtAAnKweL6/6XaPw5ioRvvIX4W6hJO7XXktxEWz4qttOAEpk+y1C6Iozvzjtt7iZ6PuIWSEK4nWy1GVCV6XXS6uyoP9jGBgEarVBiERyxfj1QYHfuxw2Qr4zPeCKEchRpHVl+mibeL4Mi/d4viNGQn0s75abI5OPTXb4YX9EZBCqID0kARM3wcafMQr8yaMHP6xS01OMgLFuvnvpvzfR4Sq/1xmgAXOumGYXeNlIFyHrogNbAQJnZM36GPtDp4nNSsX7HYoha8BJmjGnh9tK8ZbAeWY7Zy5Cgli04MnWRvwywr73QGDl2SHr1MkKOY8e6V9tkKzBL3CItMYKzweoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5932.namprd11.prod.outlook.com (2603:10b6:303:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 02:47:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 02:47:18 +0000
Date:   Thu, 15 Jun 2023 19:47:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/mem : Expose dynamic capacity configuration to
 userspace
Message-ID: <648bcd316f4eb_1c7ab4294c9@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-3-71b6341bae54@intel.com>
 <ZIpeCsiJgLcD7eju@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIpeCsiJgLcD7eju@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 917da793-c472-4ef2-d24a-08db6e13ffd2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mP/zDmBFjNW4elG9ib0lRBv3u7yAqO1vrdBpZhUOrt7dg/OkhqVkdIaWPzTUWfU44aN3P/AafZKQX97Uk0nA5VtbjFWLbHql/+6R9mN90ddm4JMdIQ56cCGXID7OxLsQP9CPs47eOP1d+OtWN8SzfxwkFoz1ShkmYMSdT7qq+iuAD1cwnvC5qvbVqexGomvFe0MT9eit3zGkRBsi274uVmSmckT9t/d/a4tWIIvV+iBQ+EtRR2hUvRaQt2haifDiKQhVT2+SAwylKgD+zjkmuX9DXPkKy808g0okaeBP2uFTCQ11RKsnK5iSpcxKO9gRFq36Z1QDjSp88dQuTpjTbK78t8sNQj70XcFT7U7IkT7HUswRyOMXw2PZPECoZOBqpZno8FWDe19ZnD5r7EiUCnuP+mcP2RNrtJt6Y+Z6LXwg3TfwQkJE3/1TBMi/uz907nsE49DnW1IOWRDGasYp/YVIa+X3NwCfeu4FAuawWLI4hK9KjndbJWe3ZJ6Ta/l3g6fV9AXCFACfZRwGFnqkNMVLfWu9KyKriLdgbXuhQVFxtdBMEu4dHozDh0ATpKbl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(44832011)(6486002)(6666004)(478600001)(186003)(9686003)(26005)(66476007)(86362001)(41300700001)(6506007)(8676002)(8936002)(6512007)(316002)(5660300002)(4326008)(54906003)(82960400001)(66556008)(66946007)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mK5rRuJZXVthpcur4aR+oW4NYuQlDyfOu6IVBHZswzaKqXRCMbwgxoi9+BOm?=
 =?us-ascii?Q?/2mCtQwIw+46lIo4CqUWS/Cyy7DIKiAWkhMhB3l2Mx+ArJ3oSOyj0VR4n/gs?=
 =?us-ascii?Q?hrSuTjHDDh5ASYkaiXMna4ppWHRJ6cojEY/5fii0+q1xjF2ZSkAA5+Z9Xo+k?=
 =?us-ascii?Q?FCIQVJJtC4B7MnXeqV0olDftUV+/xyTlVNuyEmqIrFlZNMwCIQ1/0vIVuS3M?=
 =?us-ascii?Q?DCIasvaQumO8abRbrkpj+Bio+3jyRT4lTkkj9HyfHCEUOaoKy5hGWyhkTPFY?=
 =?us-ascii?Q?HOILz8KypFN2EYW5lpGA85MBifUDB1Z4Xm31kC4aZouGIsihfWschyWmYhDb?=
 =?us-ascii?Q?4xZrthCP30Xwggd7lcPupHStshSLtdY5rhdxgXTteiVqMnAvzYbWw1WVEhjb?=
 =?us-ascii?Q?QFHlI671Js3BQwAc4mrfJePwCLCqOM1rtpK2pxilzdGG7oy4ouGRohHkRP76?=
 =?us-ascii?Q?rvUDvIeOU/qHjUgB1fYe7IZL9tUAsRymJB910YL5Io7Eyp1HrTPm8unF3MaL?=
 =?us-ascii?Q?FDJb/uWsJyQCVjt4oWtEdIgZJrMLovMWK/TMP8+vMuX9QPehtFiJdKB6ney1?=
 =?us-ascii?Q?5SnFJ3an6lGIJLIofos6v6ylvrVLmkJcUxzQ1lKMWc7PDE2BHvbi8/zNvREF?=
 =?us-ascii?Q?0o03hB12u0Rwb3UrLER4XKKBxeSUPHevJ7OKYa/y22S2bpmSl8QyEUiJqXCO?=
 =?us-ascii?Q?jS5IEIv7affloT2Xat9XKVeHsuNpo6OcxGqjQ4YGmUfRVo8NbUNqTYVYTVu8?=
 =?us-ascii?Q?RRn/sup6z+zAMYxILuxUUibv8kyiuzMNKIhGugpz3eZztFfUe/3YED67lfxy?=
 =?us-ascii?Q?ZCW5gGLXYzvSUEZiceQD/Jm7CgMyYAJr3zgv7gdeb5SfkY6Gw1GHVpDQNj3E?=
 =?us-ascii?Q?awOn0cDo40CbzrRUh1XmT4QSlR7tCqg++TItw3vYisuTz2YeteJHi1qmlr+i?=
 =?us-ascii?Q?K387nD+aStQ+qwgtdU15ixJINRyAYhqlczxiAf7UHzWguQe+c3U0NAigCdWd?=
 =?us-ascii?Q?At9Y6sAI3sC9DCsGwmc1aapMjX2K9yxFuHlKwRUzItISBMUlVBkIFRzt7ksA?=
 =?us-ascii?Q?n6iTcFc+Y3bk5JBUCQJUvHDiluplFhMVongeaaSxXY6IlanFHmgxIyvzDPef?=
 =?us-ascii?Q?9BFBZjOQSRauxqBK5OX17A4VrytMSOEENSB19adrWWtrHAqROG4NAUc2yPjt?=
 =?us-ascii?Q?sM9WNiJOB2NOIcMRKnk7Cktky/OXUPPMQBcuAudvMc/hltJcALTA9SfGVY7u?=
 =?us-ascii?Q?vpcmR/WMWBAtRIjbQRchfNKeyOldw6XiccYO5j8xWYkYkOaEE03DL/FQv3IV?=
 =?us-ascii?Q?AvX8ZpeXdW43Zs2mCHExO8aJcToD7MqdvE0Mll1WbqtQsRNpUUurUzxTkrLw?=
 =?us-ascii?Q?jxcVw9NDks9e6xL1ajzNRc9r5Qj6vfrGtty+HeeVEUJWxu0Cibw/wtAMVCho?=
 =?us-ascii?Q?k5Tu5Dw1WYlOggjByxsjiw6909xFknk9cmzJFvN5p2SVtEI17pcrv2wZJouh?=
 =?us-ascii?Q?pyzwcTq7wePNUA2U0+stZHXjbIujUmIm1tGjh8ZZ645wMuHjJco41se9UVRV?=
 =?us-ascii?Q?Tt05QSqcK+1FpHy7lcYGX6IybxBsmfmGg096FzbW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 917da793-c472-4ef2-d24a-08db6e13ffd2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 02:47:18.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twFE9imtLyCUX2lcYgwi40LSt+4qTHwXPmyUAKGIA5fArzD9ZbYML4evCdEMjVDcWDfXb9zETLvo2E2X/+GXpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5932
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Wed, Jun 14, 2023 at 12:16:30PM -0700, Ira Weiny wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Exposing driver cached dynamic capacity configuration through sysfs
> > attributes.User will create one or more dynamic capacity
> > cxl regions based on this information and map the dynamic capacity of
> > the device into HDM ranges using one or more HDM decoders.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > 
> > ---
> > [iweiny: fixups]
> > [djbw: fixups, no sign-off: preview only]
> > ---
> >  drivers/cxl/core/memdev.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> 
> Add the documentation of these new attributes in this patch.
> Documentation/ABI/testing/sysfs-bus-cxl

Good point.  And the region creation patch needs some updating for the
sysfs documentation as well...

Thanks!  I'll work on those.

Writing the documentation it seems like 'dc_region_count' should just be
'region_count'.  Because the 'dc' is redundant with the directory.
However, dcY_size has a redundant 'dc' but Y_size (ie 0_size) seems
odd.[*]

Thoughts on the 'dc' prefix for these?

[*] example listing with 2 DC regions supported.

$ ll mem1/dc/
total 0
-r--r--r-- 1 root root 4096 Jun 15 19:26 dc0_size
-r--r--r-- 1 root root 4096 Jun 15 19:26 dc1_size
-r--r--r-- 1 root root 4096 Jun 15 19:26 dc_regions_count

> 
> A bit of my ignorance here, but when I keep seeing the word
> 'regions' below, it makes me wonder whether these attributes
> are in the right place?

There is a difference between 'DC region' and CXL 'Linux' region.  It has
taken me some time to get used to the terminology.  So I think this is
correct.

> 
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 5d1ba7a72567..beeb5fa3a0aa 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -99,6 +99,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
> >  static struct device_attribute dev_attr_pmem_size =
> >  	__ATTR(size, 0444, pmem_size_show, NULL);
> >  
> > +static ssize_t dc_regions_count_show(struct device *dev, struct device_attribute *attr,
> > +		char *buf)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +	int len = 0;
> > +
> > +	len = sysfs_emit(buf, "0x%x\n", mds->nr_dc_region);
> 
> Prefer using this notation: %#llx
> grep for the sysfs_emit's to see customary usage.

oh.  I did see this oddity when I was testing and forgot to change this.

However, I think %#llx needs to be used in show_size_regionN() and this
needs to be %d.  This is just a count of the number of DC regions
supported by the device.  I don't think that needs to be in hex.  Changed
to %d.

> 
> > +	return len;
> > +}
> > +
> > +struct device_attribute dev_attr_dc_regions_count =
> > +	__ATTR(dc_regions_count, 0444, dc_regions_count_show, NULL);
> > +
> >  static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
> >  			   char *buf)
> >  {
> > @@ -362,6 +376,57 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
> >  	NULL,
> >  };
> >  
> > +static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
> > +{
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +	return sysfs_emit(buf, "0x%llx\n", mds->dc_region[pos].decode_len);

... changed this one to %#llx.

Ira
