Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06756440
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLu5wycp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704746640; x=1736282640;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MwY3blmwFOIbTgzaATTVeK9pGzwPGdF6+pp7o/7tlp0=;
  b=YLu5wycp05yvDZ/w3BOVQtm1V1+sCHWOuUYGQGKubaZCRSZLvsAu2tGG
   ZSs5hja2LVwky+n8kwF1vIRCA3/hZDCaC+2TkVCvWwE1pC9v4D1NTPCnZ
   H0aBY/QtI3ZyaNYeeG8lgDc15T89nC7aI35/3bGJyWjnqTJx30txtf/zn
   1dw61SAaWa9ItxHGodZiLeyitUPomyHpP3p9cN/Cl8D5ESy9UOmce4ggk
   3zWIdMJnvD7/qO54ErsHeLcO2USdv0/6z10/Z/sdpZFwog7e49f/DBU6/
   cJOx75RoS/HLkOKi+UUGLkZ38o/ON7h3Vg+geFtyWUAmtmlSOyKulDSnc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="401794267"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="401794267"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 12:43:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="954762776"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="954762776"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 12:43:59 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 12:43:58 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 12:43:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 12:43:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 12:43:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMhVgzr2P2z0MaF5mOF2WHONodHWOAiZPnepM1yShAXBz4JPLH1pd0CBo8NwyO8vLwl0Esg4Jbf1wRyqEDCkPrqKb5W1VfPCtpCm9vuEpJdqAyTXo/OVhCs5ANfocWToM0SMiLBpM9yU1vv4jkRJri9WZ6xI/EddsZyzGIEvUMXOPI+uPiGwjarRr8y79HQFvd54gDOylReF4QRZGvBcck5rDW8mg0F1O/RqffdGHyc20eyIe0CfZnCenGq3BZTrjPrfO2Wil2Tfq7adSnAi73bdM5Nt5fc32fv1w7vTbELuWLkdhO1js2HsLSxS13Qoz0CqxLzy4nZD/FsRDn+ydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHn5z6+BzHH8RsYkUHe4GPVr608hBUVbNN8srf9iAfY=;
 b=E6aRK+Pnfrhw2HJDzkaZt65K32B25g5LZcobePIfBZ2P91L5ZY0yuQtZp8UTO0JF2S3/PYk/R8Cr6ZRsXtE+tg7VIGFK4KXYIozDvlzOP35H7u2V436HqBIMfQbFV8SZS/w6Jkf8YQ3/zBk9vWhq64WxkrvyqGbrDLPXOPJ5ifmE0I/AiO3m3gWchzjJAvPqOjwiPMlEcOjvvMu5DbU60hdzvH8ppaZgia0t5mhDbTYjiPNCFiWI7kFi6a/jlpLtovnkAZEi6xy5BcxfJoKkHe/2zNSULi6r9Gyar4o5atL9NODUsY32/tk5YGNQhEAlRDGlQaG/m4PqFLYJKMetnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 20:43:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 20:43:53 +0000
Date: Mon, 8 Jan 2024 12:43:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: Re: [PATCH v6 2/5] cxl: Convert find_cxl_root() to return a 'struct
 cxl_root *'
Message-ID: <659c5e868d50b_127da229425@dwillia2-xfh.jf.intel.com.notmuch>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449246044.3779673.13035770941393418591.stgit@djiang5-mobl3>
 <ZZiH7QGDLD8DlRNu@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZZiH7QGDLD8DlRNu@rric.localdomain>
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: ef31bd87-8bc1-4e7c-7122-08dc108a869c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0jgv79OiadD+Z+34WFe885ye9HDVvFXhFhp4U558QwZyRZN8kJLj+4OrbwTc4O3lT7Xo547Ih5DgGiOpCvwgFvLH5Fo7o3Hnycv1n6oYgc0KGsHpyqw5LfVVnaCMZHaIhZm3qCfCwvYKflevFKIWBoRIAYb5kNsZ3onhzfaplSNfTOUZT2bOdo0NAQPRVVqRrvBvrcQQ9PtqRefGTqWY8zGYmpxxfEKdzyzwcQYlHiymLYISTAcvkhokLkktceWnZF5ynIeZsUEGaYM3LBYn+zJzBfUmOFdx/Hsaiq9Io+YqygCAHnD94Z8zxDz7Nze+p5qc+d4o+tngfrB9teQJJdb6PEPgffRrhVmKbNZmsehMRaNi7NS81pI07E//dQAfNvfoQyL2DkZ/u3NnEU+UyB3+VMUXYeW+8lmu9WFvFrF5LgW4FA+9RCMpE2zpUDp8WV/SwjIfDbQamI+OHaF1TH41XMAIxUPs4j2sQaPw65qIKgHRwy7OukxClAwsAV1zZRPydL3yoH+DJTR9amlowVkaX7FXUGctiYYpc8G3oA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(6506007)(5660300002)(26005)(86362001)(9686003)(38100700002)(6512007)(966005)(478600001)(53546011)(6486002)(41300700001)(66556008)(6636002)(54906003)(110136005)(66476007)(66946007)(2906002)(4326008)(8676002)(8936002)(316002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rc0NubPq/VqbWeLbZDbCCDTvlAaqrMKYIoi0pSu9oRh3s8MpUgWyWcKHptF/?=
 =?us-ascii?Q?n4Id6nuUJ+Q/NpmG041nXRJj2cEAiGjZmTRlgBaMJPPRuqfjahkrbn3xj8+i?=
 =?us-ascii?Q?C/AvLNOQT+CbGCNrP23fLbHY4Zce/mKTioWadqNzbkiTG3G4/9NlMUhDv0Sm?=
 =?us-ascii?Q?70uIMIy9LBWleT3BTNgQ6FcwRTIsE0AksUwFCW6ZGGkOtGQUQ/DYxUWjNyNs?=
 =?us-ascii?Q?2wWoxWdoz8aavgibV7yDBbDTho2bV/TL/szkmUwoj8Dm8n1hw3baKIUYo644?=
 =?us-ascii?Q?U9W6j5wzL9v30E4445uG5la3iwWTyUsg9b9b7AUkG/gZNI/Th7Mq/DA5pT1q?=
 =?us-ascii?Q?Sv41FnYdyYW6i0+SSm3TD86vCVXa3kCE3Id12p7+qAw+DRm1tRcSBF/ez4R2?=
 =?us-ascii?Q?G7AEIcs0qV5vZmBjikD/9antdxrIcLA+QgJZDnxo7FHZLww9gLkQbew89otv?=
 =?us-ascii?Q?CW0QR9lZ8W6ma/k0Bt2J0/d98qoB4qHdok46HwO48t7DZZ1hdAfZQldJ9Ff6?=
 =?us-ascii?Q?CwsbZXaAdp5ewhxu5KPBhavgO+E30N8bwCNrZwJcvIu13cd6xqgyl8wuS16O?=
 =?us-ascii?Q?8tUvriFzCnalMXnvGt8lGWi22pJR3jboahS+uUKyJa98ByrdISe4fZPrl3iF?=
 =?us-ascii?Q?NZrcemNUCp3X0xEKi6zjpA0+PSdOGlKtXjeajC4vdJB+falgTCgTtkA2Tfxs?=
 =?us-ascii?Q?anpnLcPpMcPMv8z96GEr6wVfVWZ03AHlv757mgIcKbDZG6ztdQwr8av98WbV?=
 =?us-ascii?Q?4UZ/aw9LkulryFsrmbou8fTnL3k3PNf/VvwodoJQ3udd3QvkzgkfAJohg3hD?=
 =?us-ascii?Q?JBiIsfOuhh5tUN/pNiZbZNUQ6eM/8LgJF2+K9RhQpa/krWk8YqTPcAEHchqa?=
 =?us-ascii?Q?L3FAkNa1er/3kIm14wpJoFt/x3JTueUbiKGI08HKQn1K90zxt9qq2X+Vcs8t?=
 =?us-ascii?Q?xN8z1Y1XAgw+nlK5/+wyp5heurt5tVyYgdSrs8A0AD6lK7+CLaqI4CiztRDg?=
 =?us-ascii?Q?oWj80DiC98mt4eaQf+j5oDNdDAgG7hqB1uYrpAxGrcre8OjRTUOS5uTJBEAh?=
 =?us-ascii?Q?riaTr0FwB+k17vnLtCB4udeJNdsSrf9WX2ekr4uqwsXmGbgbhMjzYzTT4uEF?=
 =?us-ascii?Q?8tZwJ77hoEgQ23qkbyGeVTNu3a5oWo/Ko4H3Bc7zRyIo64AKsrHOZ9PN2eYd?=
 =?us-ascii?Q?W/FK2rA2P8KH+mTkvvXgAYPByap/YhGN2g+bZl0CpA1bh3PsGiYp0zLCp7od?=
 =?us-ascii?Q?+H1R5LIYekxlDY+V+V2Jab1KWPW0plcu7kEup2Fg4F1qfzqsIRb4s0d/EA1V?=
 =?us-ascii?Q?oRlT7n0TVSvhNNJy1toMr/cfnPSNQgy5oOJ89aP138z7BcpfmbYt0xL9PpF7?=
 =?us-ascii?Q?ci5AqW5ZL4Z4qCa9ABhVvvYpzDQJ4so0e9+hi544jru+giUIaHbl7xsIa/hx?=
 =?us-ascii?Q?rZm+vQhtQEKzpAwqIRJgOJUWXdMqETooFFaaJRTr93OWI7QuGsSvj6Wu/1k1?=
 =?us-ascii?Q?sNXkIdu2YOu5/gmT6qbFq5u38K7unNCpJPuvOdwrvgScAgg7ibkVbbti2Zzj?=
 =?us-ascii?Q?x4y3v9YjoEwdfr5NCj7AYpQerTZ1H+eggVP5IiX3rTOZa5RaBB9ywDhZzEom?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef31bd87-8bc1-4e7c-7122-08dc108a869c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 20:43:53.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lDVyK99cqlc7s3w/lh49A4WsYEvClVL8jzjOOZcYiddKMh5SkQVxlLyZLGAaH8kXcVMqKp7PFcXh7T5HbBWUuRrlzEAlLrBVcGJdjUHnXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
X-OriginatorOrg: intel.com

Robert Richter wrote:
> See comments below.
> 
> On 05.01.24 15:07:40, Dave Jiang wrote:
> > Commit 790815902ec6 ("cxl: Add support for _DSM Function for retrieving QTG ID")
> > introduced 'struct cxl_root', however all usages have been worked
> > indirectly through cxl_port. Refactor code such as find_cxl_root()
> > function to use 'struct cxl_root' directly.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> > v6:
> > - Revert code that broke device_for_each_child() (Dan)
> > - Leave put_device() calls in this patch. (Dan)
> > v5:
> > - Squash in v4 3/6 to update the qos_class to cxl_root. (Dan)
> > - Moved the introduction of __free() for cxl_root_put from v4 1/6 to
> >   here. (Dan)
> > v4:
> > - Adjust ordering of patches to move this to 2nd place. (Dan)
> > ---
> >  drivers/cxl/acpi.c      |    6 ++----
> >  drivers/cxl/core/cdat.c |   17 ++++++++++-------
> >  drivers/cxl/core/pmem.c |    6 ++++--
> >  drivers/cxl/core/port.c |    4 ++--
> >  drivers/cxl/cxl.h       |   14 +++++++-------
> >  drivers/cxl/port.c      |    4 +++-
> >  6 files changed, 28 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index afc712264d1c..dcf2b39e1048 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -295,14 +295,12 @@ cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
> >  	return rc;
> >  }
> >  
> > -static int cxl_acpi_qos_class(struct cxl_port *root_port,
> > +static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
> >  			      struct access_coordinate *coord, int entries,
> >  			      int *qos_class)
> >  {
> > +	struct device *dev = cxl_root->port.uport_dev;
> >  	acpi_handle handle;
> > -	struct device *dev;
> > -
> > -	dev = root_port->uport_dev;
> >  
> >  	if (!dev_is_platform(dev))
> >  		return -ENODEV;
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index cd84d87f597a..0df5379cf02f 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
> >  					struct xarray *dsmas_xa)
> >  {
> >  	struct access_coordinate c;
> > -	struct cxl_port *root_port;
> >  	struct cxl_root *cxl_root;
> >  	struct dsmas_entry *dent;
> >  	int valid_entries = 0;
> > @@ -175,8 +174,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
> >  		return rc;
> >  	}
> >  
> > -	root_port = find_cxl_root(port);
> > -	cxl_root = to_cxl_root(root_port);
> > +	cxl_root = find_cxl_root(port);
> >  	if (!cxl_root->ops || !cxl_root->ops->qos_class)
> >  		return -EOPNOTSUPP;
> >  
> > @@ -193,7 +191,8 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
> >  						    dent->coord.write_bandwidth);
> >  
> >  		dent->entries = 1;
> > -		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
> > +		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
> > +					      &qos_class);
> >  		if (rc != 1)
> >  			continue;
> >  
> > @@ -349,15 +348,19 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
> >  {
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > -	struct cxl_port *root_port __free(put_device) = NULL;
> >  	LIST_HEAD(__discard);
> >  	struct list_head *discard __free(dpa_perf) = &__discard;
> > +	struct cxl_port *root_port;
> >  	int rc;
> >  
> > -	root_port = find_cxl_root(cxlmd->endpoint);
> > -	if (!root_port)
> > +	struct cxl_root *cxl_root __free(put_cxl_root) =
> > +		find_cxl_root(cxlmd->endpoint);
> 
> That's the drawback that lines get very long. Not sure if that was
> discussed before, maybe just assign NULL in the definition and then
> have the first assignment right after?

That style recommendation was something we were discussing here:

http://lore.kernel.org/r/20240104223725.GA1829769@bhelgaas

...where the outcome I took away was "try to keep the get/put in the
same statement, especially if the function has multiple usages of
__free()".

> 
> Should be moved to the definitions above without a newline.
> 
> > +
> > +	if (!cxl_root)
> >  		return -ENODEV;
> >  
> > +	root_port = &cxl_root->port;
> > +
> >  	/* Check that the QTG IDs are all sane between end device and root decoders */
> >  	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
> >  	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
> 
> It looks like cxl_qos_match() consumes a root port, so we could pass
> cxl_root here directly and get rid of root_port.

Agree, that would be a useful incremental cleanup.

> 
> > diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> > index fc94f5240327..da92a901b9e8 100644
> > --- a/drivers/cxl/core/pmem.c
> > +++ b/drivers/cxl/core/pmem.c
> > @@ -64,12 +64,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
> >  
> >  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
> >  {
> > -	struct cxl_port *port = find_cxl_root(cxlmd->endpoint);
> > +	struct cxl_root *cxl_root = find_cxl_root(cxlmd->endpoint);
> > +	struct cxl_port *port;
> >  	struct device *dev;
> >  
> > -	if (!port)
> > +	if (!cxl_root)
> >  		return NULL;
> >  
> > +	port = &cxl_root->port;
> >  	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
> 
> No need for port variable here.

Agree, but to me that's a follow on cleanup. It's nice not to need to
review the changes to the device_find_child() line. In fact, there was
already one breakage of mixing up the arguments to
device_for_each_child() in this set, so minimizing the collateral
changes with a local variable is what I asked for.

> 
> >  	put_device(&port->dev);
> >  
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 64f30d5fe1f6..63a4e3c2baed 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -972,7 +972,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
> >  	return false;
> >  }
> >  
> > -struct cxl_port *find_cxl_root(struct cxl_port *port)
> > +struct cxl_root *find_cxl_root(struct cxl_port *port)
> >  {
> >  	struct cxl_port *iter = port;
> >  
> > @@ -982,7 +982,7 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
> >  	if (!iter)
> >  		return NULL;
> >  	get_device(&iter->dev);
> > -	return iter;
> > +	return to_cxl_root(iter);
> 
> I guess this is the last user of to_cxl_root() now so we can remove
> the macro entirely. Unlikely we will ever need it again and a
> container_of() call is also fairly easy.
> 
> >  }
> >  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
> >  
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index df3db3e43913..3a5004aab97a 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -617,12 +617,6 @@ struct cxl_port {
> >  	long pci_latency;
> >  };
> >  
> > -struct cxl_root_ops {
> > -	int (*qos_class)(struct cxl_port *root_port,
> > -			 struct access_coordinate *coord, int entries,
> > -			 int *qos_class);
> > -};
> > -
> >  /**
> >   * struct cxl_root - logical collection of root cxl_port items
> >   *
> > @@ -640,6 +634,12 @@ to_cxl_root(const struct cxl_port *port)
> >  	return container_of(port, struct cxl_root, port);
> >  }
> >  
> > +struct cxl_root_ops {
> > +	int (*qos_class)(struct cxl_root *cxl_root,
> > +			 struct access_coordinate *coord, int entries,
> > +			 int *qos_class);
> > +};
> > +
> 
> Any intention to move code here in addition?
> 
> >  static inline struct cxl_dport *
> >  cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
> >  {
> > @@ -734,7 +734,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
> >  				   struct cxl_dport *parent_dport);
> >  struct cxl_root *devm_cxl_add_root(struct device *host,
> >  				   const struct cxl_root_ops *ops);
> > -struct cxl_port *find_cxl_root(struct cxl_port *port);
> > +struct cxl_root *find_cxl_root(struct cxl_port *port);
> >  void put_cxl_root(struct cxl_root *cxl_root);
> >  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
> >  
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index da3c3a08bd62..4f3a08fdc9e9 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -94,6 +94,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
> >  	struct cxl_endpoint_dvsec_info info = { .port = port };
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct cxl_root *cxl_root;
> >  	struct cxl_hdm *cxlhdm;
> >  	struct cxl_port *root;
> >  	int rc;
> > @@ -130,7 +131,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
> >  	 * This can't fail in practice as CXL root exit unregisters all
> >  	 * descendant ports and that in turn synchronizes with cxl_port_probe()
> >  	 */
> > -	root = find_cxl_root(port);
> > +	cxl_root = find_cxl_root(port);
> > +	root = &cxl_root->port;
> 
> Same here, no need for the root var.

Again, this one I like here because it keeps from needing to change:

    device_for_each_child(&port->dev, root, discover_region);

...in the same patch, and avoided a bug in one version of this series
that did, something like:

    device_for_each_child(&cxl_root->port.dev, &cxl_root->port, discover_region);

...i.e. inadvertantly replaced the first argument.
