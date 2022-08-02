Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F6C00140
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Aug 2022 17:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiHBRd3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Aug 2022 13:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiHBRd1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Aug 2022 13:33:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347BD4B490
        for <linux-cxl@vger.kernel.org>; Tue,  2 Aug 2022 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659461604; x=1690997604;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+9SY+/aiPdvKs2rxKrq8LzehUj4OyUS8TFsMzFcrBkg=;
  b=GDJMcPYWDnNNZ3s4WRjjrHgHULSCQd6uTJ7W0Hnb0/oy2iDKdlPOc7Yk
   eduilRy9wTKwiDVuT8mPi5i9/Hdnnxf0C0WGWMiateXqRph4HnRgxR77+
   qj29yjt8JQMLTSuNiSVhoD2NXftKDRmfkVUdjBr6qwFTr/ccZfKcRm/ki
   /wOJjqmJkA/kGCjECa2+ckLQsOsu7CMrel4w5zJsevyGwLOMtdVdCzeIn
   57TZ3NgcOVE6QcpvUrbQAR7/03Bw0nrZ0IqK9sCarwEv4xYtdulvW4piV
   B6d9vULlD7AQDIGeJCaB3+eaEzxoJGmHkpIkwOFGwODBVTgvgY4SmUgW+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287035598"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="287035598"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 10:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="705463548"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2022 10:33:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 10:33:23 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 10:33:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 10:33:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 10:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhzqMqdhGSISkZRyKHX3LoPfo2IvqUfj8xp0dNpLBEFDIosmWg0aUcxsc+K8KA2klQWhgy73I3+ghWWHn0VtJey6MQO04XRPbK24fiKUsunFB/h0j623uB4YBCKoVMz1cLt/+60JPaEWYSMWXWkB4aCoADLaLf7iJqNv7DqqLyH88vgEUQf43Wa/5EVraZVEg3DBxYxGUPpCFkGw40ghxoGrydVGF/Zsr7M7GI1z/QD/4Ct32Nzeh1Y7OPk/fojh20UQmxtSI8rMbAm1clqge4XG47AF5pzdISYldWqlA3/4xtRW6fZB9dcmqhcOOUOtMgo8zNwlPxQS3qe1+YP+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5fo8iOCDZM1s5Zgtc6tziE/Ab/QByx0zKdJCv+XkUM=;
 b=oFa5akYz/3PCGta1wQvwKyskwHJyub8eBCLtRElz8R5c6ocyxKmQkjGrXIZlWIDPb+MZOjtt5ipavyrei5HBOYgmBbfAm3HW4RyNbd8UHP+yktsgOTbVwoG4o7QLuLq9qIkY8mIwESca0LHu+GJkjSTHUILATN9Yq+EztC9lt/8isZpbAR59J0WVhkr9Wgc18PyQEkd1Fzg6jcPcJmE32ZzLqAm/sr5BszmAmlnwy0UX/B303uW+7G9jf8AgmARTaoFr/iph0sI6vZaTQZWIixHuQousIaaz3sA9q5efB3J0unu3aSDwaFdj6PEP++yucQKAyAJOOPsZ1/aiqPM5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CO1PR11MB4818.namprd11.prod.outlook.com
 (2603:10b6:303:93::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Tue, 2 Aug
 2022 17:33:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 17:33:21 +0000
Date:   Tue, 2 Aug 2022 10:33:19 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/acpi: Minimize granularity for x1 interleaves
Message-ID: <62e95fdf9f6e2_30440294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
 <20220802165627.00003464@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220802165627.00003464@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faa301c9-d2d6-4e7c-0c42-08da74ad186f
X-MS-TrafficTypeDiagnostic: CO1PR11MB4818:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW7kRgOd3QZ27wP6fo+iZZ3G7OLdq+l2av/ux06gwZ/CQtTwuutxoYMDNAGwxAeamPSNWpEEkfnBSbThsTQVy4bD6PGqZCDZ+oFU9snT16+IwOc8ndinkVBNcoZgqd6WTgT8rwlJuEMtov+JoTDrbScDY8rxgKhyUVaQZsj8+PV9WrQT/Rp+8+oPWjhaQv1uUMYjFd6wWB6qPhjkW0iwQrqfCDL2Gtm2ANkHwROUXf0ivsEWp9uRonLsnkA3HZih8xUbDnMuVSfaPMEzY6tbsmeGSHFYGTBDFoHpBu0C6OwxdgrdksYf2opGCLgzYmK744z4YGRKxrKKDUSV92Do9IvoHwXNksNRMOdOJhuvHf0Xc/jjFtbPEriVABoxiweJ7dpeSzIkhCpfQc5vOUXa1qCZ0AL7s04h+q8/asLxyQM8oUK/8kkxHOqjSsD8GgoCWkjpq6FP7f57rzbFZ8AyybeNqq+H0VL6tj17o2AiknP5Awak6Ig8MgHbZkEVNEkGopKl/BCQXxQAUbJmaeyKc9kcHPIKxxkttwxVozTrV868hbxOu+ZbmKp/IKSudN98ASQ28n7QRgGb04PQgQws7B/tKI0HhdAqjclTGvqnd5YY9hPck8RFtue2VQyu5UFotW/KtFbKTqDXFH5DT5YqfOV9B4Zx8Tcm2KKJe245bhBgzlOq24+2tfZ2xE7hbEOQYncoQHBspCGs0XypXGx3yD5vngzCH73TTIvSW2mtipEuK4m3zSfo9iIf4qSw4amA3XmpaWMiENwl/O9F+cdnvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(39860400002)(376002)(396003)(6506007)(6512007)(26005)(5660300002)(9686003)(82960400001)(38100700002)(316002)(966005)(6486002)(186003)(83380400001)(478600001)(66946007)(4326008)(8676002)(86362001)(66556008)(66476007)(41300700001)(8936002)(110136005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yHUZaafERwz+vr2yzdY5eqxGqr6yPQXMIuS8DqOr/3m7A8LNusa5T5lHoYUu?=
 =?us-ascii?Q?t5vVn0oGu2nt6LMmHvEA/ZbEMTcnaA/H/npsDG6nhFpX/xDjJsSJERw4FxdL?=
 =?us-ascii?Q?bjrxrUYAsKcow2SFFtJqlhkanA3k2Ww8+BIZqZdc/G1WMd1GeNU9vYQ0vR3h?=
 =?us-ascii?Q?vyCdTlJ6/ZzbLreHO4OO8VxALijgx285ffSfamFPKzBPGXkIpqMD6sBawcPV?=
 =?us-ascii?Q?k/aOgSWksfLkk/7Zh246dVaNpzfLfNIjcMQg4lqPYn17Nvm+/bNuNy8JM6fh?=
 =?us-ascii?Q?ZvR0x+IiWxWPDSed1C9+f3sx0llKXNpmhk1PatX47F5Je8zBxPxGKabsrTG2?=
 =?us-ascii?Q?4E+XfxSY9+YMwk6E3gTpf5bEyiWqdOt3JwNFU78rZioV2uARS8AyAphAbYXb?=
 =?us-ascii?Q?UitEmnZwYcLUoLYNGIFiYGkEO4LpBjxhSRtZnV8teNpA3nko3zD9/KjTi6Z7?=
 =?us-ascii?Q?16ByyBek/VFUE5aw0jWLAP4CBcFq+e5sSVfU6je+q8iwgrdzLwSp4DWWrRQi?=
 =?us-ascii?Q?yrCPfxV6ZiOdKt1smouvtpRzggCQQIiQYgww3xKuGt3IFb+8HAlbhE6nbW0I?=
 =?us-ascii?Q?THyt3AnwkI8R/8Lg91xb810nlPB/Q/gpULf4i2nVuDavjwfxVUVRZkyrliQ9?=
 =?us-ascii?Q?+9mixSPAPAjVVt/mKcEXMKY/lZ/I5+x4ZDsj1UOiLZuss6I4pcNvTW2JTA/Q?=
 =?us-ascii?Q?nVCpJnq/kfdP+Vsq4Ll6clCagDrWpJNq4kMKfdYFbzYP3d8aullfFFHARoCr?=
 =?us-ascii?Q?BAa6x5B+wSRg7agowtlIr5/fSyf04FoYFP9SYuSjXbpsjlOzNHPH8ovxU/u0?=
 =?us-ascii?Q?BVsRevcgaTgBExpR3kxQf595nfzh3TK5xFSX4opgm1ka/knYnV1BC/Ga0A4+?=
 =?us-ascii?Q?UK4Ch4nahFvjfjzUbCijrqpeoJ4elZRLMY1tDvGJ0TzygsCDCzebyGCQprpu?=
 =?us-ascii?Q?L4op/pAc/bYe/GbimBXbgqG2OrTcNs6R2ifyaq6XH28YoLkm8pQ/hPBS4JEX?=
 =?us-ascii?Q?Ztu3DpqT6/vyv+P+u5QCrF619iyAyZPSOpX7c9FzQy7PDKZc2RNdwGan1l//?=
 =?us-ascii?Q?wdqMPqQWXwCwlI6ojYImyKmZT1pVE0dXN8RJ1omfwiz6jayuZjERRsZgcyoo?=
 =?us-ascii?Q?8a6YXJMQo/knqsLVZ5AvSP7eAhSwPhreOGv4UMejGmuM4aK8L9DQHI5jNIji?=
 =?us-ascii?Q?e68rNfaQYf4zUlNqolAyzGx+D3URMMHFq5g1jJ+BWcA3X2eH34IQ+uwp2f6/?=
 =?us-ascii?Q?xXhachc9wLSHIw9Y1bfECkC8YOp5oS4rfxGh573mQCY9+aZHVyZqa1zktBKR?=
 =?us-ascii?Q?C5h4ufr4A8ZEwRS6+nPKvrScRwyZPgnlvX6vv33fE2Kzs8tWjZ1UdN7TY6pr?=
 =?us-ascii?Q?zvPosUsQbhF5rKbB+kYB/FRnD8OumMISJsndZB65/bbxd/zMo2HZ912wzcjN?=
 =?us-ascii?Q?aUPQivYNnpa/8F4GL5UArQHChnjI+0GCj9aYqqClEbV7GL2C0OopNSr9zTgJ?=
 =?us-ascii?Q?m9O05RwB2MdXRKA1izBl5vIYUEvnC3P5D0KHZYydrq5YkrZhyAVFhk0ckoA7?=
 =?us-ascii?Q?xOQZYvzyc8DvZguZYT47rdNFTNRe3H3+pLM13iFfKveZaqHxYFYugJbtDIWq?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: faa301c9-d2d6-4e7c-0c42-08da74ad186f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 17:33:21.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fOCZF2CuZX6oURMqOtCM+shDqVupyua4xNtzxc6Lf+9KSwovduJZoJmjTFSylNGxsPt8nCusGpotCZHkGVhXNrPEHk/g8Stp04x5mInhpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 22 Jul 2022 17:56:09 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The kernel enforces that region granularity is >= to the top-level
> > interleave-granularity for the given CXL window. However, when the CXL
> > window interleave is x1, i.e. non-interleaved at the host bridge level,
> > then the specified granularity does not matter. Override the window
> > specified granularity to the CXL minimum so that any valid region
> > granularity is >= to the root granularity.
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Hi Dan,
> 
> Debugging exactly why this is failing (from cxl.git/preview) for my test setup...
> (1 hb, 8 rp, 8 direct connected devices)
> 
> If I set the interleave granularity of a region to 256, I end
> up with 256 for the CFMWS which is fine, then 512 for the HB which
> is not - EP interleave granularity is expected 256.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/drivers/cxl/core/region.c?h=preview#n1070
> 
> Calculates the eig as address_bit - eiw + 1
> 
> iw = 8
> eiw = 3
> peig = 0 (pig = 256)
> peiw = 0 (piw = 1)
> (all as expected I think...)
> 
> So address_bit = s max(peig + peiw, eiw + peig) = max(0, 3)
> and eig = 3 - 3 + 1 = 1 (ig = 512) which is wrong.
> 
> I'm not 100% sure on the logic behind this maths, but would expect eig = 0 as the output for this
> setup..

Yeah, the "+ 1" is not required when routing from the x1 HB level. I can
reproduce this config with cxl_test to validate.

> Even with this hacked, qemu address decode is landing at wrong address in the backing files (but it
> is at least landing in the right file!)
> Curiously interleave ways = 1 for the EPs which is obviously wrong. (I'm not convinced the
> qemu address logic is right but it'll never work with that value).  I'm struggling to figure
> out where we actually set the interleave ways for an EP.

Ugh, it is not set and I think I was blinded by some successful region
creation results and assumed they also ran cycles to validate the data
consistency. My expectation is that the EP interleave_ways is set here:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cf5d5811fe4c..dd4035d92041 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1285,6 +1285,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 
        p->targets[pos] = cxled;
        cxled->pos = pos;
+       cxled->cxld.interleave_ways = p->interleave_ways;
+       cxled->cxld.interleave_granularity = p->interleave_granularity;
        p->nr_targets++;
 
        if (p->nr_targets == p->interleave_ways) {


> Also I'm not having much luck requesting a larger interleave granularity for the region (desirable perhaps
> because the devices give better performance with 1024 byte sequential reads)
> 
> Clearly going to be one of those bugs all the way down days. 
> 

Yes, the hunt continues, but I think the driver has some large ones the
squash first.
