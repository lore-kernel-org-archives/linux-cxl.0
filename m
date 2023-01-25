Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887CBC54E94
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 22:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjAYWrC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 17:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjAYWrB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 17:47:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EBE113D7
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674686820; x=1706222820;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jDiDRu1tZ3+21sOkRRj/RJGMBWWMmUZRLFcia9CsGqg=;
  b=VoEknabjwnsI4tLqtX4dp41PXwelWynJZHL79dP13fEKHDnlrkv6hosR
   qZ3mi7Yj8QikO1Pv3pjCnKXWRaSjdcomZ4CKK7x8XsujgdYMbDiUeb15k
   i5cdaH4AcTxdQEDKF8mTot1SH82rMjtA3FFtzmh7gvp5jW/LrQY8c3lXB
   biAdXg/irhGgsBL55mdSQM3IaUtJBaqOitlI3YM5CoxdXvGxd99vEAoXH
   P21n59dm6K6FxXclcutQXekMVq/UNtZ5p9aL6L/BpHxwZSR3sS5s98w1D
   HODJnEig3kpshQXB06Rxr2sj6Tf6BvJMpftj8i6tcbWSIOFVIDMxPXMq6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="325372073"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="325372073"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:47:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770922989"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="770922989"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 14:46:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 14:46:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 14:46:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 14:46:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/xmVK3MMqaDwKxvwrlCVNBgbLW4fS+sM7rCnhppI3vQvraY+ucrqVe8IwYZtrbWD7LnscxrCL6Ekk88yDbrA5uK3+7NbfIddvhLghgx2+akJ874oH1wkMuxri8uBM266y2GBkNyKigSV0poihf9EWbuF5Bk32aP+jfFAJyBR+KpstcCjYILq4Gjzcon6B0T4dk0EosAHbaUGOh9lVLNlUT9BkA8Wwz1yUvI+Zf5ClsgbKJ6lyGH+sT3ABWCAsXuWQBlu+RQo/pF2yoIphNqyrc+IFhd0NYtDbmayVdv/kTx6AvRWoO2xXB/00wHPf5xRn2CBALQuPmDYsr18sEIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfarjX4s7y0NwgjB+lBHtIc8c9sJ+3jB86MF89hBU8s=;
 b=GfMtY2Ka53gjU+MQn8Cy1422I+Yz4KMd1kkVLL+8ITle2Fn4b5uTzVv1EGv+45GDrxeWQHU6DRhV7BmtqZKrIQOH8kcrmtTPMr2FpJ0evNpNpNRBz0oRdnQOL59YsaZFB4FJzIL+pkfPDH8i0gbLWiq+NenGIp6BCrejx059TGvYcj288oFcsaHQjU5biBOKZwVO+lycfxmWBnjmO2IVCkRZsyPgDu4RPbAYwHpy1dSbtFzIcL7zyO/XXRfTaqsVaNGi2OXBII13swmEe9HQD+iXVfqRgL7TrVSfDprQvLYw+1jjijxc3Pk4ix8r5Y8FuWCqoeYp/IcZK7EY34Klrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 22:46:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 22:46:56 +0000
Date:   Wed, 25 Jan 2023 14:46:53 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/port: Link the 'parent_dport' in portX/ and
 endpointX/ sysfs
Message-ID: <63d1b15d95155_3a36e52946@dwillia2-xfh.jf.intel.com.notmuch>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
 <167124082375.1626103.6047000000121298560.stgit@dwillia2-xfh.jf.intel.com>
 <20230113113911.00007348@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230113113911.00007348@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:303:8c::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: f81bd2f4-3957-4a64-2bd1-08daff260fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQ+Lg5egNmTvIkYxI/IAALA0qd9SszfjqtexKNK9nmHFfaxJ3pc+WphFgR/MRZVv9OmdZxggwiJiJ6R08RzkiACQS43LYlY5IJl8Yr3sw/nyEFhqVO3ZcCJSOoA95RSz+JNYJivYyve44Jl67H77BFcSGr3BmaT4RDDLk4MiliE7eLi+hZRTHyLiJHcO60WIkpTOe8sUa1GtvbNxZHP5uBtbx+Op4GCUIWC/bgtMjDWmuot4hpg+OrGpO6R8mYtXdE013nerNosHEbscO3kK3FOZwVZ0g4WLoyzYbizXq1rK0S9/evW/9yLjD3Dy1v2sRxEGcUlOTjub43IS/YrQ4j2OCt6+mhnCdUAGXJsksQ/Qup3pxLcJkI77i6GG2L74CILb9GK0hJaH0XUXxEdd9eREPNpJDNLuEYIUNynBRdF5fcjK/kwWP9BJytKNuKLDY7Iqj0f5FgPjvdSdWvD0y57UCRA4DrlFYeM1Epc1wYD/0UIsPMgzIvtI03mg0mRL9rcu8jBSwaXEKZUKmGqZ4AV8GZLQmoIy7PL+fHMm8eAnyUT7uHT9JlJv8kN6bYwKMilJDrFCBIMUoAQYqyDeHYapfwk7Mjb3GhtAaqZZrnmGTg7tZtLUpssgnv9H9uMVfK8foK61Rty7C6r6NWrWvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199018)(86362001)(8676002)(66556008)(66946007)(110136005)(9686003)(66476007)(316002)(4326008)(6486002)(5660300002)(38100700002)(6506007)(41300700001)(82960400001)(2906002)(186003)(6512007)(26005)(83380400001)(478600001)(6666004)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUpmTOSqmXK+v+TQqj4hFGXvuVTVsyDGprah+7xOIV/KFchkrMonpLILmVMJ?=
 =?us-ascii?Q?4cyBHPbfmPwiGlkCuMuB3mwB/Hlxeq2VijcjKvMolrlHggaOLVSXEZiocEjX?=
 =?us-ascii?Q?a0l/onYj2NbEayebnHeIk3BSwYdX8QS+dVOba72WvZyKGaM69gaIYktNaclc?=
 =?us-ascii?Q?EePw4YicdlicyOvm+Sq0LzD4kgbUgZ+H9J2wFlHV1vzVyIrvHWJ9L5NHMr+V?=
 =?us-ascii?Q?3ZOQ/idTOZ9RzD6ckzcFyUS6UAl8q5QoHHj34Vok/PZn7s3YKPTD24CCj2Az?=
 =?us-ascii?Q?bKvv3sAofANZQ8ZEA/H8o116gWlHfuMEjkoby6oiFP2xKlzm5vSVHDOD4kx9?=
 =?us-ascii?Q?/XP8Ikit326aneNZzy9GSBqZHH6ZcnPb2SpYdGSCRgOFK5Vn/PDMDTUGBEKV?=
 =?us-ascii?Q?mjW2EODd9xjfYUsw6sk/A19UHrHhAA3wdiUb34LKd/I+ikbpgw0Hzw23EqZ7?=
 =?us-ascii?Q?gRaIVAa3KNfI8qZ21259uUsJYdgJt8+cP09C5srM6fmc+xnCnMnQgg+e8cGO?=
 =?us-ascii?Q?7n2oyiX4QJsgfSBEq0ssi4w2kRTYtNejmKLu8xO59yF18+b5CafsCgotRD36?=
 =?us-ascii?Q?k5SQFSC6HQsSBhyPvJe9I3Oz1wL1doFTn2i/gLQ+dfGFO1tpC5VkJv+8O//Z?=
 =?us-ascii?Q?VW0BDiarCFerQEFJe9wSY2lMBScUCM6SvyUBjtanXyI2OehsJo8fJT8adb0i?=
 =?us-ascii?Q?UxuxOMJJrhaLel4s0iKDOTWg+AxxvTktZn8fdH5yl4FKcgJ5n0BEVjp3Xgo8?=
 =?us-ascii?Q?btxM0pnuO1daHYt7+LNbJDPdqRBfwcxgoLrV4ir332zqYQl/Cx3aQvdLZk9m?=
 =?us-ascii?Q?vrsv1CmosayKE+xGe1bMgX+082P1rRruNqyXzFwYMxI2TlVrV5u4K+nV5jeF?=
 =?us-ascii?Q?FZIozqgTXByy1zsESXPcNbl7kpD+7o1Jo/XPjMbQyzMlvoEDnNBMQ24zh6l0?=
 =?us-ascii?Q?xw/0vk8439TSIeGEBaUC8iskSAeX8EjZt5LG7swYXMmQR5WEUJC+scc5nfJh?=
 =?us-ascii?Q?Wt0vM9rdVseuyLrYdTYBb9ME28Co8v0Ev1s1ydPru0u4joFhHBMpuGMonTq2?=
 =?us-ascii?Q?USfJGpdBkz1xh40qw0l14Wyt6iuNuPK1J6cR4W2wWspBlVptxYGDc4UI859D?=
 =?us-ascii?Q?JGN6NDFMVn4HK1fNBSIpr6jfwyb6LnY4ZWOtZ7F4lKtef/GSrnYq3U24wQTh?=
 =?us-ascii?Q?m59Nw7IOCK+DKZ6Ddvd9Z7nLBD9JhrBW+du4HU2KKUwuGM3D5nd1cai3fO3m?=
 =?us-ascii?Q?RtIYvoH6pBgB64y86/Z8PzCuYuchmWDsPu1st15ZDFePwR8nTZngh4WBJ5LP?=
 =?us-ascii?Q?89NKtIot0RDPs008uD66HJaYJpb7w3FdDwNk8LKPpX583NULQhtnclqnrU80?=
 =?us-ascii?Q?fT2gYqU+soLbTxQtbnPmM3/YtxVa+qGJj8W0HydBZ+Niw+4tNThXFtvrIfVp?=
 =?us-ascii?Q?FKb6e+L2jDJ4hbBZHCz24iDmKRNiND0EO6ocn01+d8hVbE1+v8Jw0jjWP2wG?=
 =?us-ascii?Q?J5fetXFCQZcmLubTEtuK4GhkjEaGBqwA8oxlWvnFfviepCCsuwGC98VrOxDS?=
 =?us-ascii?Q?6ryik1UovVBe+YCMggdqaKHzvUqLlG2yI6s0kYGWu0uJQj+GKAmdhraVwXyF?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f81bd2f4-3957-4a64-2bd1-08daff260fc4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:46:56.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FUMlubsad3yyhvs49Sz+1q9kvQu6/4ugX0zWdQLiaeIL7sTYJuqZ7MzZwAIQ53mvId8YuRChqs6AQnsw+m1+0YB2bnLqP1tDaE1bi2/Ouc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7579
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 16 Dec 2022 17:33:43 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Similar to the justification in:
> > 
> > 1b58b4cac6fc ("cxl/port: Record parent dport when adding ports")
> > 
> > ...userspace wants to know the routing information for ports for
> > calculating the memdev order for region creation among other things.
> > Cache the information the kernel discovers at enumeration time in a
> > 'parent_dport' attribute to save userspace the time of trawling sysfs
> > to recover the same information.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I'm not totally sold on this being worth while as opposed to building reverse
> look up in userspace, but meh - seems harmless and is consistent and tiny
> amount of code so

Yeah, an interesting point because all of this could be done in
userspace, but I think it is useful to avoid the possibility of
mismatched expectations here, and cache something that will be
referenced often.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |   15 +++++++++++++++
> >  drivers/cxl/core/port.c                 |   27 +++++++++++++++++++++++++++
> >  2 files changed, 42 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 8494ef27e8d2..1b17c8cb48b5 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -90,6 +90,21 @@ Description:
> >  		capability.
> >  
> >  
> > +What:		/sys/bus/cxl/devices/{port,endpoint}X/parent_dport
> > +Date:		October, 2022
> > +KernelVersion:	v6.2
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) CXL port objects are instantiated for each upstream port in
> > +		a CXL/PCIe switch, and for each endpoint to map the
> > +		corresponding memory device into the CXL port hierarchy. When a
> > +		descendant CXL port (switch or endpoint) is enumerated it is
> > +		useful to know which 'dport' object in the parent CXL port
> > +		routes to this descendant. The 'parent_dport' symlink points to
> > +		the device representing the downstream port of a CXL switch that
> > +		routes to {port,endpoint}X.
> > +
> > +
> >  What:		/sys/bus/cxl/devices/portX/dportY
> >  Date:		June, 2021
> >  KernelVersion:	v5.14
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 6296d2bc909a..729e4aab5308 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -586,6 +586,29 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
> >  	return devm_add_action_or_reset(host, cxl_unlink_uport, port);
> >  }
> >  
> > +static void cxl_unlink_parent_dport(void *_port)
> > +{
> > +	struct cxl_port *port = _port;
> > +
> > +	sysfs_remove_link(&port->dev.kobj, "parent_dport");
> > +}
> > +
> > +static int devm_cxl_link_parent_dport(struct device *host,
> > +				      struct cxl_port *port,
> > +				      struct cxl_dport *parent_dport)
> > +{
> > +	int rc;
> > +
> > +	if (!parent_dport)
> > +		return 0;
> > +
> > +	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport->kobj,
> > +			       "parent_dport");
> > +	if (rc)
> > +		return rc;
> > +	return devm_add_action_or_reset(host, cxl_unlink_parent_dport, port);
> > +}
> > +
> >  static struct lock_class_key cxl_port_key;
> >  
> >  static struct cxl_port *cxl_port_alloc(struct device *uport,
> > @@ -695,6 +718,10 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
> >  	if (rc)
> >  		return ERR_PTR(rc);
> >  
> > +	rc = devm_cxl_link_parent_dport(host, port, parent_dport);
> > +	if (rc)
> > +		return ERR_PTR(rc);
> > +
> >  	return port;
> >  
> >  err:
> > 
> 


