Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B943010D
	for <linux-cxl@vger.kernel.org>; Fri, 15 Dec 2023 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0mVmIWP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702662789; x=1734198789;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ktegcNuh2KQ/QngC0Qkz6tqe3SnRqvKrTU7zIRmzPMw=;
  b=h0mVmIWPTJ38j7QbcolhsMCrBcbsCVgLtMLnP5vfyW4SY0fmehDRockL
   LqktY/xHGeCYEmWz3hm0VQKqd7wKvXDc0JKHAKX5xpBxNZ1TVE0PNmvbt
   /pP19ew0ShFDXyAsuJL2tnCLhHbQang2+VIHWzojPCremm3nuHeMM9KEP
   YSIzRgcDWZB/sbMwHz1eJ7d4bKUkTa3Qt2JtGkc79gQ6ww0sQ5bzgKT7r
   P3jYO/D1f+HyL9RQ3EpYNhEyQPXUDXaQ0vVWmETIBe9X5p33YLLy6X08s
   MJQM/JlBJFRO1ym0BlGIKaAjIMU2wmbe8ptF7letrLpMEJ4k7//oIkAVL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="426436773"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="426436773"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:53:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="845199833"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="845199833"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 09:53:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:53:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 09:53:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 09:53:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llTcvOdK6QaNFTtYECb99pA6EEeCUKBKwIoGYY19NIpEPiAj8/VyEHhK7xTKF++8AIc1dSGhH8bTJ4KOQTHqVm0kPTXcBbXpWHxh4TMs2EHluQ6NEvWYDDPlUN3ivMzIxe9Tzbr1PqJi9TSbCFfR256ry4BaBWxbsi0m/1fFmRUeX504XzdULlks5g1PE/iESniNw9lwMPi+K0GcxHZNX+9o+NDzDm+eNgMEcu6654ciZPl+TdcIB1p8UFtvIJ0ucHB5WGF+F97OeboqpOkGEmXX866KvFVZkO/Ni5qSF4O4g+LFwbUWPYjS9gciJvr57e9TY587+i9pf5BoHQbWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJRaPA3kLhz8nt1Psno8pCjofBlgQPM6mcoqX29taWU=;
 b=VMREl4MRcL70U5t6eydPx3UkxIV8sV7QHeJa4/aDxCVxofa0ygPiwOkJiJcF1RdlIU9z9UUvz+OFKLXhN3zJIDffafdraHyzErpGPEJtvDFe8lcIrZOGLi57ukROkd6bfZyDPp08/fhkhjcTPxO5Inxwr1CKrZGW3Mbj6JpXu9DJdYj7XBpboHdjnQ7QIEvh2Ms5oJAPo+CgFLnRKzaZH4qP8ShhXQOoIWPdjUPFTYGXr1jzk/b5SYml9sprVkh78ZDC6BrRo7iIZxaqJ4v201uOhBMBtJB0bmMpz9FKcW4MEWRdFLeyafyFgE21xjBTnOhmTtTdIOWrwPNZAILOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29; Fri, 15 Dec
 2023 17:53:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:53:05 +0000
Date: Fri, 15 Dec 2023 09:53:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Robert Richter <rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/pci: Kill a goto in read_cdat_data()
Message-ID: <657c927f1842f_269bd29491@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
 <657c8454a31f1_2947c22949f@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657c8454a31f1_2947c22949f@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:303:16d::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4645:EE_
X-MS-Office365-Filtering-Correlation-Id: 22072baf-138a-4fea-33dd-08dbfd96b07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljFBJPv7DTYZa0A9s0LpAuK7vAICVSKL3wOPGGxGONlXNYKGl4WZHTDI2jiKnXpI76GoKNW24IToLXsTMciiviAg13iSZYP0He8KrNk6L4USiaZ6l6AwWCaMQ6QMvhjNSN1ex2c5xr+Kx8OBK464Nxy+MM6DmdQaxacPaU77YteZoTywEzoQWIClE0Jy5sukylR8jlWT126AiLCA5YeUmpNTgno8AbcZBycGIq5yQgzeAU8a1UloPAoWNe2WkPT2kULk03vrH2b+yYI2ryg9cKjobbUhDB5wc0jvR8FZRWeAzKuFIDUSyUYv3J/s2tQZiGifJjB0if8+zj4bMehZg/14K/zjHABc3j77WWuZIta4SGczLkHeXu1kDUrc5hyAC2c9lpoFe9KTEzawnvjQCt8apdTM78im3JVsWvjUgBhjUn9tMIxkmhKuFV3by7L5GTtx2p2Rzo09ZweOpjbP+OG1mKSXS0UGEGqtie4ZoUHiAzw1Kj7xUBzOQw0WQM4NZDfMLkL5fAlKZbhe9zikzGp3pKN96vykkItcmV5TFoi5G9uM8tIplljg+JOUU3cX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(8676002)(8936002)(4326008)(83380400001)(54906003)(66946007)(66556008)(66476007)(316002)(38100700002)(86362001)(41300700001)(82960400001)(2906002)(107886003)(5660300002)(26005)(6486002)(478600001)(6506007)(6512007)(9686003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GEkEcwVC39YFBJ8hQlhTAh/cZIfaTxaXIHdkiOglOuBerQMJIuTbe4bLcVjm?=
 =?us-ascii?Q?OXeyz9EWlft0wMtRGwRkYrk73+6Ti4slB97/Szh5ft2ukjpuWgXqMIymssBH?=
 =?us-ascii?Q?KhKcss6alZ6rJ2QQNzofhVHv39E2C9z534U1QE1S5HeikUvSj0M0kPqWN8Iq?=
 =?us-ascii?Q?U7kmpu3OCE6KOJGCSZ01zvP5OjLLnFdKDYVthztbRBBP4SYcCxYr+FePJLJx?=
 =?us-ascii?Q?gOTmwP3HpciKYtNUR4eBxiwRUN5egU16jw8ZMaOcdhLJq5RnWbNhL0U1ha85?=
 =?us-ascii?Q?yxCMrcxUdFVoAp127yd7eZJ/AYn5PRBC24sz6Mm2HzwLD7ycPQXAeHUpovJg?=
 =?us-ascii?Q?sVz202kpcqKFxgyAjim1MNYgMABQwq8QTgnv0W6ygSSnJfbNOR9gpuzxblw7?=
 =?us-ascii?Q?MbXESWp3oyN7+e/m74KZHYuJAIcgpmkVdlMlEUQ2xJORkm+Of3EWUEAoZ3P+?=
 =?us-ascii?Q?wUr0QHURle0Qq0SKn07BVi07ov6KzmwIu5qDP6rlcX8EhMp+BvWc037SZAMm?=
 =?us-ascii?Q?m7aATl6XjxhKH1I6gtnplUnGGHLNAZgHKyMJfOo6FgTJ1hf0/DFS9FfJWZ1z?=
 =?us-ascii?Q?SZHU2IG/XJZiO/CZW6m783iEQJuQRR+cbWTz1wYM45BKDZKGvyJ5W52pSgKy?=
 =?us-ascii?Q?dnOoXXtwjA1l5sFW7kHofGkVoSzr2aSAcTSOBZMc6B+RuJj5aBstKxUZiYt3?=
 =?us-ascii?Q?piAHzteRgZnGhQg6S4kSmk0T8Ycm2S1Dpb/JUBufj2sLP460gj1EJEuodfgr?=
 =?us-ascii?Q?XMKGbt3a1D3LaRl01wQktRK68d7ved9tpUp7i7ZW2ZpCAFF2CUCAoL9iD68J?=
 =?us-ascii?Q?IqsLOWg77exa0LPLObZT+Q/NLOO4bPTUk/zyRhWJyvLzr9aQM9ab/vlNFE2b?=
 =?us-ascii?Q?xybjd9Jb2MRa3C6kvieYhPuT51m3X13G3msFFpgWNUGXgsbnoiKF/+Sv2z/k?=
 =?us-ascii?Q?qsxkow3VTjyGH5j3YxcdFc+L2NweY0tddAu0asu76IxIunVtDYGyzYs5zqE0?=
 =?us-ascii?Q?0l3ctLxn0r/uVla+7PGWnX8SFKwQnfcCixvlxjpXndU07X1pWpAC0PdHOelJ?=
 =?us-ascii?Q?y+GdTr+ghGui7GebZZI7KAJcRUmdwuDU/qbKfKfSZ50ffETOLgDU8xqIJV3h?=
 =?us-ascii?Q?7znR9SwrRvdQmpBRyu+03XOJBUEZJCTIYIF204rgwWexsB9N+u5mzJReZv51?=
 =?us-ascii?Q?NZaqpbj+5M/nXNhCHh99UDpclhAlBi86j2p32BFtvaKpwFkIF0hkrRsnG0Fa?=
 =?us-ascii?Q?XY6nK7HWgYqp2+XowcPP2cmqtFG/eMzw40UuackpXiEIBrGIq3Q/NYoL8EDs?=
 =?us-ascii?Q?U+xglGk/SvcPJSl511ji/jCYhIsDzONvRP7zBLpFxf3b3jweVXDH1Rajglu4?=
 =?us-ascii?Q?KJqdqCuxRkuJy8g1oQj+e73ttxGJcCMWQyPu7ra7Kyxw6Lfxq3atg/DFB40t?=
 =?us-ascii?Q?LulasJdNWc5wDt3xUDZ4TBE2G/hPZaQ344FKCjeHlllBn2TF9Ba8MQYGitfw?=
 =?us-ascii?Q?qRYOXMZ5eUlZzRMp2dx4sJ77H/ZRb/hW0cWPLkb6NnRiQ8O+zQ9FzR5IWahQ?=
 =?us-ascii?Q?76Nmkv5BosILJr4gcfX4lNTEnBd/CEUmOl/kL5zxlKOpB1wkfQg/6aN7/WI1?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22072baf-138a-4fea-33dd-08dbfd96b07e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:53:05.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+gBmcN4AmIXdoNhGAFjPcvI+YCcPP6/VLtPAvho57YOepXlApPRSgmcq7yya3cQFdC/3Cf8sReS0VV1Goq8GwHib4q0w0cftfXlJzbnYb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4645
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Given there was already one bug here around passing the wrong value in
> > the cleanup path, remove the goto with the use of the __free() helper.
> > Note that since the cleanup helper only passes a single pointer as an
> > argument the auto @tbl variable needs to also include the @dev argument
> > to devm_kfree().
> > 
> > The open coded math to shift the port->cdat.table to the relevant part
> > of the response buffer is saved to a follow-on patch to cleanup.
> > 
> > The "devm_buf" scheme can maybe move to include/linux/device.h one day,
> > but the expectation of using devm_kfree() in an error path for the same
> > function that performed the allocation is a rare pattern. Many
> > devm_kfree() usages are at object mid-life or end-of-life time, not init
> > paths.
> > 
> > Cc: Robert Richter <rrichter@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/pci.c |   29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 37e1652afbc7..dd938a60a2de 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -606,6 +606,12 @@ static unsigned char cdat_checksum(void *buf, size_t size)
> >  	return sum;
> >  }
> >  
> > +struct devm_buf {
> > +	struct device *dev;
> > +	void *p;
> > +};
> > +DEFINE_FREE(devm, struct devm_buf, if (_T.p) devm_kfree(_T.dev, _T.p))
> 
> I wonder if this deserves more wide spread use?

Yeah, I just think there might be a path to do something more
sophisticated like DEFINE_LOCK_GUARD_1(), but I am not savvy enough at
the moment to figure out how. Exposing the definition of devm_buf to the
caller is more shortcut than global recommendation.

> 
> [snip]
> 
> > @@ -651,26 +657,19 @@ void read_cdat_data(struct cxl_port *port)
> >  		return;
> >  	}
> >  
> > -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> > -	if (!cdat_buf)
> > +	rsp.p = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> > +	if (!rsp.p)
> >  		return;
> >  
> > -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> > +	rc = cxl_cdat_read_table(dev, cdat_doe, rsp.p, &cdat_length);
> >  	if (rc)
> > -		goto err;
> > +		return;
> >  
> > -	cdat_table = cdat_buf + sizeof(__le32);
> > -	if (cdat_checksum(cdat_table, cdat_length))
> > -		goto err;
> > +	if (cdat_checksum(rsp.p + sizeof(__le32), cdat_length))
> > +		return;
> >  
> > -	port->cdat.table = cdat_table;
> > +	port->cdat.table = no_free_ptr(rsp.p) + sizeof(__le32);
> 
> It is unfortunate that we can't get rid of the mystery __le32 offset
> here...  I'm not seeing a quick way, so...

That's what Robert's cleanup is all about, then maybe this can become
less magical with something like this?

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index dd938a60a2de..2a05666fbdd7 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -606,9 +606,9 @@ static unsigned char cdat_checksum(void *buf, size_t size)
        return sum;
 }
 
-struct devm_buf {
+struct devm_cdat {
        struct device *dev;
-       void *p;
+       struct cdat_doe_response *p;
 };
 DEFINE_FREE(devm, struct devm_buf, if (_T.p) devm_kfree(_T.dev, _T.p))
 
@@ -620,7 +620,7 @@ DEFINE_FREE(devm, struct devm_buf, if (_T.p) devm_kfree(_T.dev, _T.p))
  */
 void read_cdat_data(struct cxl_port *port)
 {
-       struct devm_buf rsp __free(devm) = { .dev = &port->dev };
+       struct devm_cdat rsp __free(devm) = { .dev = &port->dev };
        struct device *uport = port->uport_dev;
        struct device *dev = &port->dev;
        struct pci_doe_mb *cdat_doe;
@@ -665,10 +665,10 @@ void read_cdat_data(struct cxl_port *port)
        if (rc)
                return;
 
-       if (cdat_checksum(rsp.p + sizeof(__le32), cdat_length))
+       if (cdat_checksum(&rsp.p->cdat_table, cdat_length))
                return;
 
-       port->cdat.table = no_free_ptr(rsp.p) + sizeof(__le32);
+       port->cdat.table = no_free_ptr(rsp.p) + offset_of(rsp.p->cdat_table);
        port->cdat.length = cdat_length;
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
