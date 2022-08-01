Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305BC00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 21:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiHAVcY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiHAVcY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 17:32:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F51818B37
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659389543; x=1690925543;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QTwelfmZGXg/aTo/f1kG6nWoOYYzVbQNHzF4lKtViyE=;
  b=Tnr4f+mY/3XOyAHpkGZ9DNc6HStt3Xw5ofkNMLv+0UVklG3ONYJkuEWT
   pWjJPjTv2c23y/YaqbJLTyOxb2JJortDaML4kI86Z1oerHx78RSxx9+XZ
   ZSohKRH5Ey8fbCVt7Plz8oOSHzGT42S0fmZJDh3cmF/45Fjih2FgdjXRa
   IpWztS6ye0luOANQNSSHyw/VFYt0W3N91xAX7bCVVHsmUqUUK8DXXKzTd
   zSIZyevYBbVkKAwazUWQC18CjjtnVCFL9DRSDDRidWXqKm5lamStJhxnS
   6tScK4IDYSwwvIJZalyeqXKxALqPatDHgdG8IXBNOwJAy6aOR7J2rvEIe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290030382"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="290030382"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 14:32:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="599076513"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2022 14:32:06 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 14:32:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 14:32:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 14:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPpxVgw4nnnNysdoGUC6yxGU0hSmCiBcm7N8u/fuNB6JU3iJfKtf89raJLU3RDfEAQwIYt33VUwzzrq2jxbgKDun1kJSdY04C2p+m53riFV3hhntDhU1ekK0BhqbVViWsmWIQMqRZyho5xZvXrQY8oWxSnGf5UFZf34yEqD/m/kQAqHXu7zz3f2l0KUXUTo3+aP7zdLS5GRgSznyUgp5M8wJTpKPeMd9HjWP2XgjuP0HZvPSS1jvCZL+OuMp0J891yDa1l8opp/HjxWpanv8X07IW7t+nvTekIZGGownVQp4M4rZbw8X7sMv7vHRck6Dzcgo2zegBehr8Xp44c143A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj6nJ68ZB9lR56/dIlnNNBww8ivNmFRRCM+KE/L889I=;
 b=Ry2vWxVvfCCzBI5wgTsBThTOM8b6KVq0FVznBM1A3S4vpS83D+olFT4h9eid5hEqVahW/4C82Z5jzP3VkCOgD9xG4viPuC19st9+AO4hDKm7r/W3YZ5Z+khx/jOiHj1GVFHf9uPEkNjsbGGsjokedkb8o4j0EfgcyNqOYLU68VBtHZ7DoHMQNPdfq3rN7INmgkbj7UtWG+iUc4aObVXA8zdnmOZZIkTgOG+eBc9vVdFOAl5JvQExcLzQPk1j/lEy4i9oTsC+mzdRVsjHb/uhR4ZbBuWVF5e9/mQ6gWXtYjpwix2iQVfvQIfgyrx8kNsJVah1mhRkKAay6PxjhoVLSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4396.namprd11.prod.outlook.com
 (2603:10b6:5:203::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 21:32:03 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 21:32:03 +0000
Date:   Mon, 1 Aug 2022 14:32:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Delete 'region' attribute from root
 decoders
Message-ID: <62e8465170267_30440294cb@dwillia2-xfh.jf.intel.com.notmuch>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853776328.2430596.4647259305040072751.stgit@dwillia2-xfh.jf.intel.com>
 <919eb8198e880205b81da7090d6f0535782f0fad.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <919eb8198e880205b81da7090d6f0535782f0fad.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da6e33c7-a8ff-48b2-5b37-08da7405467a
X-MS-TrafficTypeDiagnostic: DM6PR11MB4396:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzFVRyKI/VO6sCsYg6IjLRhXB7UQ4UQZft+pC+FpVqTykJQbs21qRmQLDA2+OtzyjL3QYsRCg7x2mpAlVZlwtToGlYAHtUC1+FMkBVy8HpwI52lLtXL1SDuiSMNISfVHuBQMYjZ9Ox8DACvR86YrYqcZlyRHeZyO08jZu0b3IAGl5CvnGGVNbbVHTyygMp3Ktr4mebgtBH+4fZl1hcuWJGfJr0VNjwrKdZTudOZE9tmfNKX7d3+lBCCkTCgoJKXNZsB4zJEAtDe45eTmGGlomD+OpyhfyYPCEGOSXMKjRlWNzqlQlz7kAfjRCIgrMVCeujmfFljnpU4yG7SiSxFPKbU5U+J/hYeUekzF/3u9pi+cW1nEVe7HlntEP294UIvlPQNfiYE2mDrvYm2342S3odWTXbcpHihRGZgVlvqwYo8lzEqKKjMObMIWWF9iS0iF+ftTB63Qm6S5ll7/MWcAHeSOVrhPFjdUl9RC35EXz0+FUwS9Es41t358fGYairyqJrwDyEF4ilTjWWQHk/1aCIzy8+5fJedv3rSe9E5wuRjRKSi6w325U7VZNktHbwF9do6hj5agcx6bOXr18n9hMph+83IKWeSlWImy3ApO860s6UMRByLdsmpPPvD6TmmWjpzBuFTMKLNBM20/oPjcsLr+3ccSrTgpLulRCNmzd59lG6qqa+1BygwrYTsf1ghfWIpgSXie60VyqS+JJek0w1bwvVr0tgunZ0Xai42s2IOWRIh16+JUNKZx973oVojE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(136003)(346002)(376002)(82960400001)(316002)(110136005)(38100700002)(9686003)(26005)(41300700001)(66556008)(6486002)(83380400001)(66476007)(66946007)(6512007)(478600001)(186003)(6506007)(5660300002)(8936002)(2906002)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Xf6X7WF90fbX/qDErX238PWFWJrJPympJfPdR01Augyz+vobgGdauEQUYr?=
 =?iso-8859-1?Q?CETkn/lzGTgBMT1KSA6YbwZLAJSsXYsbTp4hPiYND1kWohNNkah6Mh8TQf?=
 =?iso-8859-1?Q?oi8wVSAdrrg1up1cAX4zZanb/uPZmJIHwyTDjkKvPw6dyNk+G8FGnKp/K+?=
 =?iso-8859-1?Q?npTNAeeJcQr6dKN3Bp0WNzX9WrmZ1VBd4Am3KTnMs6QPmOcdDKt1z9C+zS?=
 =?iso-8859-1?Q?VZQ98772/Uc4nFnQdcI0i/F1NwPY9KdoEDrcXRc7Uu+Y7T4+I00Z9hLUyK?=
 =?iso-8859-1?Q?I4YygJzlbIVb0IGu4FzZMXp4UK+lqFDhi1BsNYrUPb8SgcnfKGLS8gjFGg?=
 =?iso-8859-1?Q?fX8pFPJdtB6EdFUY6t5//sjif1nOkFH5p8NrXA3k3C0guZl7vHLUuOp1ug?=
 =?iso-8859-1?Q?PBT+TUkNwnparyfJDgHAAUCGS0/4r0se8MCWZrMZWcmW+neUdW+vvYNZh8?=
 =?iso-8859-1?Q?3rrpEX/t8yYA21FhwNtwNoxDjOrbwYxSLTHQ6AwmgXET+6OwTM4URAGdRt?=
 =?iso-8859-1?Q?u9efwV5ZZYlupltLo8T+kC92JBJcXp+kg9OLTPiNuVb5cDfWf4BDuqu9Sd?=
 =?iso-8859-1?Q?4PHvqsnYhcF5aU9AoRqX7M9/G14r8M3met6WlQeuN69JgPm6zWFwzm25Vh?=
 =?iso-8859-1?Q?2rsZXuDzXQrbAcOfR0R18ojKMTLB4pkQOjEsuLWmP07CYa/UG9271/EK1O?=
 =?iso-8859-1?Q?S2h28Tnb6kJiIHMRmNNbwk5/bgfcPRVs7RTYZo+M5n8x5DCxwoUpvTz39o?=
 =?iso-8859-1?Q?BZyO4n3irU44V9LNGsnZOVhkyY8VLGMJyxCsk1nZoJvh7FFmSC/SHeWtEg?=
 =?iso-8859-1?Q?1QCdeepelYV0fOohHoadjzW+D2lVHFtcGGT5z7qL5bIZCoJKfoJxc/QKTP?=
 =?iso-8859-1?Q?N5JsNclo4D6jgNR5bhOmoIut7n030Ki/rmwhOQI1kep/5j4r4fvJVjLqzJ?=
 =?iso-8859-1?Q?Ter7Sv4hRl7yJIiPWY5bFPzQWtEtyURpjm0nvrjF2weOrKHAE7HP1Q7POH?=
 =?iso-8859-1?Q?G0t3FfvbhjoLAv1f4VLP18WunqK+6O584/Jt+zXq8BUEM5dp1YK/RjjzYE?=
 =?iso-8859-1?Q?kLFeD5vSlW7KXH16DE/jyeGW5+TnEGMvBaSlZNT/WvJMKhesTuLML9PMpD?=
 =?iso-8859-1?Q?11RW60243x91TJt/lkyOG7YFBoRpgAJKoaisfE57J9+svBy1wgh2IND9XU?=
 =?iso-8859-1?Q?fxHiIJ04+pFo1HokWft7F72t5im4VJ2O/fA5Mw1fZM0sX4FZ7AGDsCZ/A8?=
 =?iso-8859-1?Q?AZLQsXhvkHE8J1D9pyg+X9Ham9uC1rePRqespJYNI2VN4OVmRAhTzP/wxs?=
 =?iso-8859-1?Q?Fko81nbaQs3YPsYxJvjAW3OTK9xASkx26J0n0ya6TjTt4Sgrp8UH7DfKHx?=
 =?iso-8859-1?Q?oR7+vK1VYWOkou9XF78wKh3GxWTHh+M9YUhc8TPqWWp2vmj7n7K9hriHAF?=
 =?iso-8859-1?Q?6k++2/NApuCkBK3Ot3yWrkeg0Ukll9crf2UDizi1N5ilT+Bt0h9FSUOFbo?=
 =?iso-8859-1?Q?P00T8gq5W6teBXcEnOC4kJz9NorHR3sqZ+QLIJQeE6MumVda9a3y/N7C3f?=
 =?iso-8859-1?Q?J86TmAELAgfSGtbV+MdlJIEzgtqTvo75PdjGsu4IsyBjPGIEoQlyzgIOvx?=
 =?iso-8859-1?Q?A9u1nRi/V4GI7yfE9ipMms1g8rpeY10xbcG2xp1ycLedId9ejfPjzBAA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da6e33c7-a8ff-48b2-5b37-08da7405467a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 21:32:03.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DLxQ1RiO5NI0c4GeHbzP1l4JBL4QeQYTP0zyzb2/mUdai+arCcR2zifRZuW2esHB9oWg8tnuvasbsI8mPrVopq8bqJSDwc7EETx4p+MdQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4396
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Verma, Vishal L wrote:
> On Fri, 2022-07-22 at 17:56 -0700, Dan Williams wrote:
> > For switch and endpoint decoders the relationship of decoders to
> > regions
> > is 1:1. However, for root decoders the relationship is 1:N. Also,
> > regions are already children of root decoders, so the 1:N
> > relationship
> > is observed by walking the following glob:
> > 
> >     /sys/bus/cxl/devices/$decoder/region*
> > 
> > Hide the vestigial 'region' attribute for root decoders.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/port.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 3d2d0119cc3d..bffde862de0b 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -290,7 +290,6 @@ static struct attribute *cxl_decoder_base_attrs[]
> > = {
> >         &dev_attr_locked.attr,
> >         &dev_attr_interleave_granularity.attr,
> >         &dev_attr_interleave_ways.attr,
> > -       SET_CXL_REGION_ATTR(region)
> >         NULL,
> >  };
> >  
> > @@ -345,6 +344,7 @@ static const struct attribute_group
> > *cxl_decoder_root_attribute_groups[] = {
> >  static struct attribute *cxl_decoder_switch_attrs[] = {
> >         &dev_attr_target_type.attr,
> >         &dev_attr_target_list.attr,
> > +       SET_CXL_REGION_ATTR(region)
> 
> This patch removes the 'region' attr from switch decoders, but isn't it
> also vestigial under root decoders?

Take another look. It removes it from the common cxl_decoder_base_attrs,
and adds it back to just cxl_decoder_switch_attrs and
cxl_decoder_endpoint_attrs.

Perhaps you read this context info:

> > @@ -345,6 +344,7 @@ static const struct attribute_group
> > *cxl_decoder_root_attribute_groups[] = {

...and thought it was adding it back to the root decoder attributes?
