Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E162EC54E94
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 21:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbjAYVLm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 16:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjAYVL3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 16:11:29 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D71D6469C
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 13:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674681051; x=1706217051;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9Atx62Sr+5prod6pqRJHgO/YguI2/JaUHstd6mFqa7g=;
  b=nTHTkz+NkC00hWqnmhWM7j94z95MpEsne+SyFqt9kj7BC5HWUSxk8O7D
   VwNPZfbOmWKANEeQwcrjlybcimSmT29ecqqezxilabzsZtif2usak3rb5
   nkiozKWlxbzfP8GIvf/3ojnVOGCuSJBTktEWbBI5thBlZAmIlXdyhQrqX
   kbAo2MVJAvAERf/qmlxPemeldQM0ajKaHv1v2wkst0hi+Xypv8jSLjL6Z
   +5KsT7tLoiMbx9KTQLsmDU+hlceYjqPRu04a2j3dNbY9o1zcDYuPcfxDE
   iDhhCr8KVbB+IaPNzmDaC2+yAC+xNMJFoIOimon5j+KKfthASiOLqLOoM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="328763309"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="328763309"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 13:09:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="664608700"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="664608700"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jan 2023 13:09:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 13:09:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 13:09:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 13:09:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 13:09:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnAl98dT42Z3ETJNmM2h4RMy62pzy2txs4QjbE0ZcKLezG82veJB0hGjjb+NXBZ0d1RAqJQBWBZFdpd8o8A26/3LH15+Io/c4GqPFdXZe3rvDqdPDXsMYWJwE8YHJOM6SWYoTXLx+e34aOT6Y4zoWBaQqa8zStS8UQyswvgstE7sG3CCwYPytfsLEB5sJvqGT0fmOzNNaba5goPpBY+ksoEfnJslQYbLMqAeBu7dXi5yKhAnbirkc5Be056tnNxtbKSgC59pkCn3brkt+M0egCNlncRvEMavUkezRqhYW0tAxjLpkRGnLD9v1b50SZ0r7nDB+ZXzYrWRrFSRh5/2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdME8UGz/cirVvaoYSG5sTSn4qPSFkWeC7osjUltTqU=;
 b=btiD6T8F09n0fIBUjSFhEVunuwgVeln5+Z1t16zbVyhzSn/0/M2KFCDY70EdG+bWrAWLeDB9+j5QoYeBlb0Xgh1QVXhUeyYomG+uP++MOQz3RhXoCy5FzilLGn3eA8eXVX4Gjv7NBy6fVfQvDJsTpaCB4gn9FuyMFJJVvwMClejw42zV0deiftbhW19y8MpQDe9MwsqAHJt2lrzh36R1LfUciDgLFfsdLrEqZgjcTJrIOxsoHFXqILUgpVM4w+TPq7xGdtVJIzGMubU6AW+dBQP+v5OxP8m6bA/2cFoODjZUJbYVdwErrPBpTnWMi3/aHn0mO4LKPm4AT/6Owkr7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4782.namprd11.prod.outlook.com (2603:10b6:a03:2df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 21:09:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 21:09:23 +0000
Date:   Wed, 25 Jan 2023 13:09:20 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Robert Richter <rrichter@amd.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Robert Richter <rric@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mem: Quiet port walking warning
Message-ID: <63d19a80bfa68_3a36e5294d4@dwillia2-xfh.jf.intel.com.notmuch>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
 <167124081278.1626103.4792472728150764118.stgit@dwillia2-xfh.jf.intel.com>
 <Y7QIP33kUAEPp6sb@rric.localdomain>
 <63b49906246a_5174129457@dwillia2-xfh.jf.intel.com.notmuch>
 <Y7VIjfnd957nCncQ@rric.localdomain>
 <20230113110441.0000657e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230113110441.0000657e@Huawei.com>
X-ClientProxiedBy: BY5PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:a03:167::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e0771e-530a-4992-5d3b-08daff186eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3RRH2ZOSNskQblb9ugGK4Uvq6CC1U795b8wWbTRNx1dg9B74lMT603fn3Dq9HUDWpWlFQDuYNoDMazSN1VOcU0Ryv1Bt8iPnlSMJ+j1x6rmVPMTWN518A+hIcEdsVTBp567+9JIyqs2+pYipkybMzS6mR7b22trpc9iqhmfefJApNO6j4sEwxJ/2KTCSn72PEIqjOSTH0M/K7ey+F7VAA+C1oB9ylsQzKdtCGj0W3vI50o1vfA2Z1h5gcGaeU5CAmtcP+uj/tWvoyznTvWBqMhCUT4xr8BAEbLLr1vC+c94tr9MXmboIZ2i140wfKmqbJpg1EEyqbzNUWAerr8zkntaYJDcNuh/AVCC3+q8NS35b1/EyWUlx8xu3yiDBIRReDRGokl/OSudNOm7FsYy6jDkSIBObrT8sbZ3/QpHxU9bYfffojc9eKaF468NiLgr+Ko74Nsp1xKofTCbVoosmmC9mXJzbXFKDhk/8WphEfQ5W2puySU40yX0k8lQHPmgWK6KMUSEkzde6rjVh9fb/J4JKgO2YohcCFrDxjK0M50mP+nZEq8xwSgr10nflgkq4lNm6zdV6VCsktI7XWdEX72ut4yOCn57B3nZ2Gi46tm9Ay6rXpjTVoQ+UsCEkZaQR7lVW9A/vTASmEyjHe5nKAooPrNm1Lt2LpEUUum4fLUI1lmpAZaFUhTIrLGuI8vR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199018)(41300700001)(8936002)(38100700002)(5660300002)(2906002)(82960400001)(83380400001)(53546011)(6506007)(6486002)(86362001)(186003)(6512007)(26005)(478600001)(9686003)(66946007)(66476007)(66556008)(4326008)(8676002)(316002)(66899018)(54906003)(110136005)(3714002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oxgItf6/ZX0WN1B83EjbK18baxyM3h537GUKBUkoylZz7kXe8bi3KpEJbFjN?=
 =?us-ascii?Q?TqFCCUjz3BsF5yn/cg6EBJP3lQpl9q5F2dpKKkEwfPGP2ke1ptNe7f+UM2nY?=
 =?us-ascii?Q?NY7IxjBfhfdCyoozo7jdMuqGZRVKUJrWHMxkzrd3jtuBigk1Xwx6+z2iOL74?=
 =?us-ascii?Q?MSVldR/N3JfRluE3VWmRinpCp0E8GyaBzGTh4LJTT54snERGF5HqnTh5oTuw?=
 =?us-ascii?Q?wY7ltCAAL3RNUb0VCQ+aWqeV3M91CG7WQLAoDDKF4CZgBRtBNlqWARzh9mrT?=
 =?us-ascii?Q?vJmw4c+Rf5SE5eCFjKGDBrxy5KvI15OgUWiukKWUjD36nVRKyu/WIMDFo+5x?=
 =?us-ascii?Q?5YgUI64Ty3gqts7/Gye01vKodZaF8Z7L5Hu0CgmNaJ0FweXCiLwqI4LfSYsm?=
 =?us-ascii?Q?zBEW6I2yKl0CqR9XVj29ffwrsra14Je7296ijdjLkOMVB28Fnjcc9AT3Nce8?=
 =?us-ascii?Q?VzsS6bXU731Kfa9mHrJXYQQ92mKwo7LIXSALYm7sTqgRaQa73cbzjdDvrcwf?=
 =?us-ascii?Q?oLPMFCnBvr5LL+xZCLK9I5mfPljNpDpQyo9xoJHeQgPIaHL6D1/0J2pGp25e?=
 =?us-ascii?Q?UPAUcMX3zHl7J2Cf+I0X4wbMK/toAzWBWJNONJTRBFsbf/zPmK0yddMpbxeU?=
 =?us-ascii?Q?O8SM025Jf6W8DH6aISlGFPqzz0bH8OZi1zX8SJxRoUxGdQE4w5ABfxersoLy?=
 =?us-ascii?Q?suKVmhXMVdVKmHIiJxX0Dx+F012C9h8yLdwsVYtQ2YURHyi9FxhDzZVzYpT1?=
 =?us-ascii?Q?jSPszHrcMJlR+00CwDGt61owblGNi4cA1UeThTh70E3ie2CuYEyrPtemdymi?=
 =?us-ascii?Q?LCNjVwjOZZ2dpAxihSk4kwxZGtPSPKx0vkRB9ZOBg/CUbqgMgQq3OrqhOVjk?=
 =?us-ascii?Q?3xFj8R1TG0Biq4C+u5Ct/U/R7WrrmAyjsf7H1UVAtgJkKX8gBZQHxF0N9cjZ?=
 =?us-ascii?Q?K8Pu6ZU5rZ0KzY4uloEPzkf7hzS1Rvx5XXF8LVc8fMr3mRsTKGlYvXbYlshm?=
 =?us-ascii?Q?JKMPZDeAeWuAh6ZmlEyiw1+7IdXY87uFoYRxx9HvTMOE2VjIsWOtstGJHYYG?=
 =?us-ascii?Q?ETuE2fgidY1g3fM8lkNohJDNI78YWOaKqrhngRsNnsUVDNucMqz738EzXajZ?=
 =?us-ascii?Q?swGjEGINvLEXj5IqWWarjT1BDmSVdF1110ZTh+1k6VCLE3McLuGrg/X0NMw/?=
 =?us-ascii?Q?7OTrlCPT+bI/3w7aP4B1qpp8iNgBbkWT2qLqmPUkK1vSsZmAQRz1vBeAvzM+?=
 =?us-ascii?Q?mel55ZzF4rBMf0ZCboPFra4O12HRpWToW3v7yJRsFaooHIuUYV0ELzd9h2N6?=
 =?us-ascii?Q?us1qIwG7pXgVfUSdd+k+WcejRxWBanMvojr6UDgc7tFQdfKK54Zt5dIFtgvB?=
 =?us-ascii?Q?fQ8ozElsXPli1M+aIl+0lo2be7HhAFJZV4y5bg3ZmPQoaeWwqHYoa4QLuyZ4?=
 =?us-ascii?Q?3YduE4d8sdwhqAtVng3oAHaldEKZ1/mKcLcYsL760VeYyHfjD1XqRvcX+irj?=
 =?us-ascii?Q?mc+jnihmrI6PUE8BfxRsmtBzqUD0S+uk8vbX+1mLbtIQtGlCaqf2xV44uYFX?=
 =?us-ascii?Q?blTFg5z0b9X0dEczwRWVKzJoHheT7VEXh+j8qdpy43MVluw30PNcNjc6Vc93?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e0771e-530a-4992-5d3b-08daff186eba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 21:09:23.0227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDUzBk6nj548Fw24rJto4MMgZ0P/DcjY918EpGBUaff2pKoeg6yBWy+JiTG98M22HTpN63tlEwBCS7y4LqWx2BvcTeSIaT0+z+oDoh5Pg0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4782
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 4 Jan 2023 10:36:13 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > On 03.01.23 13:07:18, Dan Williams wrote:
> > > Robert Richter wrote:  
> > > > On 16.12.22 17:33:32, Dan Williams wrote:  
> > 
> > > > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > > > index 810e60cc331c..6296d2bc909a 100644
> > > > > --- a/drivers/cxl/core/port.c
> > > > > +++ b/drivers/cxl/core/port.c
> > > > > @@ -1400,8 +1400,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > > > >  
> > > > >           uport_dev = dport_dev->parent;
> > > > >           if (!uport_dev) {
> > > > > -                 dev_warn(dev, "at %s no parent for dport: %s\n",
> > > > > -                          dev_name(iter), dev_name(dport_dev));
> > > > > +                 dev_dbg(dev, "at %s no parent for dport: %s\n",
> > > > > +                         dev_name(iter), dev_name(dport_dev));
> > > > >                   return -ENXIO;  
> > > > 
> > > > Maybe we should also change the return code to the common -EAGAIN for
> > > > this case here too? It looks like it is just passed to
> > > > cxl_mem_probe(), so there are probably no side effects of this change.
> > > > The probe is triggered then again by the base driver.  
> > > 
> > > Good point, might as well explicitly return EPROBE_DEFER rather than let
> > > the driver core turn EAGAIN into EPROBE_DEFER. Tests seem to pass with
> > > that change as well.  
> > 
> > Yes, EPROBE_DEFER is the one used in the Deferred Probe
> > infrastructure.
> 
> If doing that, can we add a dev_err_probe() call so that the deferred probing
> infrastructure gets a nice error message for anyone wondering why this
> deferred.  That calls the device_set_deferred_probe_reason() in the
> -EPROBE_DEFER call and deals with dev_dbg print for this case for us.

Ah, sure that's better.
