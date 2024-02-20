Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBE7764A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Feb 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453251; cv=fail; b=b++5VTl+5UDG6kYw683VR+1UqGznD8x7dqlF08x8xrjyYI5wpzEOWJX1OS8aHSEh+8xrUtin+KPEpFLUFlVWEn5Gb0GjGBTqYxGm2AwqmTAw/ld8V9S1vL+qseEe4LM41sNGyMsthcIncix9k76CbjEQdIGgl8K2hkIFPpjWOJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453251; c=relaxed/simple;
	bh=5k33eQtIMrubhy6Socl4QjIgYNnkTUafOc7VsU/c1ss=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MVXEZSOdjPkABOno0RLtC5REFfZ15SoqeR/nT1HpGOslDvDVzekSsP1JXW3HYzXlrmgMqN9EwxHXoeMKV0qUi45TAwQ3flabojoTfI1uFub0mur/flX3O+xLTgB3wQ9BPzKj3y3OJEAhtm6wXB69migYy9eZsuk75sLgwsazu8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWtFnuXm; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWtFnuXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708453249; x=1739989249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5k33eQtIMrubhy6Socl4QjIgYNnkTUafOc7VsU/c1ss=;
  b=UWtFnuXmPmeTOyjAyfF2WrtqODcSTt4gpIWSNrjan5CJmYhAuD85fEK1
   hIHORQrNWNEEoS2ea1VZQEDu/zeAShX5jMEsCk/7H9An/xzYbfkw/iXr5
   enm3+RiIVf/yPOmWCw0G+GZZLt0KVVAGz7zFf0cGaccoQDbs0yByQAGHB
   aeRr51Y0G4aEmJk3Sbo7zlHluFzIrdYUczFO5w8z9rEPMGGk7vC+XjE9H
   JW7bfWvA7dVR3w9rqA6/IcUAsPWn8aeNGLaf5UlSiRGcDTGZSnXiwYuxs
   ohstA9Gp4drYcXkDQaxKfvnCyxsDvOmJzQg7gCW/qDL3XcsNcZhQWRyJ5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2684521"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2684521"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 10:20:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="42349529"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 10:20:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 10:20:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 10:20:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 10:20:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 10:20:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKVaP5i8delygueGRhhFkQZwEBa7/ZsHxS4Kq19J7AXQkiHP/1sOmpz8Lx35OIHAOLqTWsFQVGRyTJhjh3IUZULu7OCOA+hK6QZn8d9tYlayA+VmaFgJAiP3nFw8q7xOX77kq/cPDt1Q1b0YKAYkMTm1rWlqbtipRhfLmmCa5oXXtYyyLAwqaDqR1HqRaHnqTtBUnKmS6uVsxsuJBEWhOUiasfiv8C/IsyE7blDB8DVlrC2sOpL5ft9EPLizd/Pvb2GArk23vWf5TnvuEk/QjR/JpAHbw/CDiXIaA0xI4+VaeLFiVF0egASlvy+216JBv1jgiYQ8+GFDWBbthg21xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mx0IG1J0DOAj/cBDEodwLheqgSfSNGc8xbKKL9GRDuw=;
 b=fMblrL+tTuBGtt0jsgcVTdo5HmTGSg5IjpkOW5K41Hbd+Ji/HkZNomB+VOhyrSfudtA/VdyjVEcWzDFE1yNJJbIwHe9S3q8O67JCsUdwPl1I2sC7RCuCkLHV6siQL3OAQ3Ecmpi0UNqsb+Jf+5Oe94p3LL/+/s9zzwEiO+pejr4HmyEmM+I6TMiytBC1v/WexuNLLzS7P940K7zWQy54Rm4qe5GVP+/eNCi8JFcQ8BvA/bK/ucTcYjikXZ9JL2WkHytXPu307BsZWSJ/G8X56DzQ37NvdmXaw3Fjk1+NwWMMOVQiolOOELshv1rCT+2G1zL4/ccyl9d0Gv2xrKF3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 18:20:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:20:37 +0000
Date: Tue, 20 Feb 2024 10:20:35 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH] cxl: Add post reset warning if the reset is detected as
 Secondary Bus Reset (SBR)
Message-ID: <65d4ed7338566_6c7452941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240215232307.2793530-1-dave.jiang@intel.com>
 <20240219142006.000056a4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240219142006.000056a4@Huawei.com>
X-ClientProxiedBy: MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e24de1f-c70c-4c20-9135-08dc3240a31b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fBZziDRZxP4rnQMKr6ZGvwDgqKwZoL4+6tdQhMrgYCKz0AxLxH6Ur8LmGsBfHclc8tPAWorX2mLEfN6ZfoQt/P0j0naCjWkNES1bA7zZsHeRqD1uq2P2qBfR45a1Ms0LTV9aC52frupziIHoljRCTolYJ0PZTZub+ZsKH33cKw5R9GbHBzhEKvBGBULI03N7PpfdV8j32mA1MbfRgLqq1PFKCEVI6xwbMg2V7RkBeTP824Ws+ywD8mmtIcr/UvQU4/cgj3Ao+fbYFfA7U8ZJ3TEAbH25cuuskHDFa5Q9pUpElTvyXBdGaqgUdOdAZBUrSrmEdkflcQafd0npZACUtWKYwiCGBMOWXkI2h6uiWk/9/EmT3hzXbRXeO9qewjbAiLf14K3Rk4ysRdSjhNvFNl++AqQhem+S1coUCphhViUXCQygNUJ67cQSYp9fH47CIcZNEystj//0Pr0Vg1jIa7CrKrwM8l/ItlFVtG+D7rCVAnvcPagtX2ojAkbceqHhjxYIX+7ewghd9xPKSLxVaVb3o1tfYQNGYNni3r7AWn0761ov/mw4TS6Nfw7S2rn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nhnzdm0GwZSxLiFBDi8B6czlkyr1mPTMPWfPHUT8lquJz4n5MNGTtVsy6VoD?=
 =?us-ascii?Q?SxwUiNhvK0zS99sbNS48NFg/yMOwia5rRa492wSOMFexaNV/8/18S7PQXp/y?=
 =?us-ascii?Q?a/QdJa99qG2OSS09RGK6QzBMpTq451/Lw73tY+x/UOQ2ynua5MANqjU06qpT?=
 =?us-ascii?Q?KOE5G2bGUCNJffnjxAlo5RhFSPA1D0H/rd9fBAyDTdeqlp1dsEJKpk5NIQDW?=
 =?us-ascii?Q?OYlpRTtEj+pjwKpqj/mg7VLvNr0VR4NFjuwhsR3nIHjn8uF4v7+Wrr3tt7wo?=
 =?us-ascii?Q?0Qy44tD8jr9deXwHOy7xcjYsNlMG8x66QwnuR8mML2LCR4hHdKjM2yN0MCGC?=
 =?us-ascii?Q?5z4qmYe3A1VDY4Pou9YU1Uwr07Nbker9BXwOVodmipX3fVtU9nrH+JcvJs/C?=
 =?us-ascii?Q?UjKbiZfIGYGtPqHWaU8Jpd4VfS1e/QMLSMddq7Eap2gp9JPcKE//XnJ7ec2x?=
 =?us-ascii?Q?cPgpX/CipFmevmwmyAQppoVB4wfE5FMpEc6DHPadiwLJ95MmZTsApSg3msrD?=
 =?us-ascii?Q?Z3vcJNXczAN0jniUOVq46tZjqwfr/R1iH0sbAZ1QKfB75+v1lQrld8NPVrdi?=
 =?us-ascii?Q?Cjsy15lP2lSB52asvO5uTe0yxXPTV6gDBCBUv9hIaWGcs/6nprvUroVUsg9d?=
 =?us-ascii?Q?d22F2K1pkktZaFhr5FfExV29WND4f78OsJADT9zxD7UMD3SaXcNxvNZCBUfk?=
 =?us-ascii?Q?1XwarTiETz/CW/u/YPS2QovuAZbig4ow4YPTzsigjoXUtym6B+BH8Obw9syZ?=
 =?us-ascii?Q?pW22iJvYpHr+wqA5ROvMlDzsiOCAac+ILtcwYomsMW855iRbMis4rTaqm4Hh?=
 =?us-ascii?Q?rbA1bnnVsjqKmi80mNO8zfYaa9NqVq0xS3OGo/5MWqHqoHfpQP9pO+sstcLG?=
 =?us-ascii?Q?ICdV/Nitnn7KJjI6TS+mtCnnc0/thX1Bogt1kgvrcqjJEijIY+E5wd+B6kO3?=
 =?us-ascii?Q?yten37mRaxdYOqa29JfHE/ehZcJ7J03pNIRYOXpXo7suwMYH5fJlFr7Tssva?=
 =?us-ascii?Q?OjOe4Ma8DFeAPFC0cLtXKF16NNDx/cV+jY5vpJnWdgp9uk7Em9ZqbLQi0Gb9?=
 =?us-ascii?Q?Y/mhLGHiSSGgWYZ7YB/raTPpmNOQeAV97wep2Znco5HxhO9V81gSFHLLtSN5?=
 =?us-ascii?Q?Ghs/A0jyC6hKSzmo48p5L9pQa60tHyPXncRydWMf3e/bfzqVmCWPVL6iHYuS?=
 =?us-ascii?Q?9d+GpN3po15hD9cWas8JzQwja3C9SRrGVzVWPUeIK1ntEDY0QCRhcUvhrfOL?=
 =?us-ascii?Q?ET9rAeXUWftRHjaXJwhAZ6Jo+tvLnpaDGSBn+umZn1kulQnHXfnyDDM5fs0j?=
 =?us-ascii?Q?L9AbCtF/uSk3/Uf9qESIDdvkruPgZg9Pu1Kzcc44SiRH5NO6xqmo6UnGuZOo?=
 =?us-ascii?Q?oriiG7HEyC67Ic43n0RfBe6yJq1jO1xUDyZ/yU3/FU0+BKhzaPE7w/SxT/zK?=
 =?us-ascii?Q?DrviwQVM2VhdjT09q+7KvBoo6nim5V/KQm6Qfznhuql77F4wxptwG/PmU7yO?=
 =?us-ascii?Q?srUdf+kFeKd4YdyrnqL/dsmu3US6BZmzz+itB9HjhlhMYSOZI75cnS2hYZ1W?=
 =?us-ascii?Q?DDct1+PqfLNPOHWAqMhMjjaTg8l2jdTJeEnlSR3XS/pyS9sJxoKIHbgJzHLv?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e24de1f-c70c-4c20-9135-08dc3240a31b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:20:37.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQCcN3QJMacFUjz17PkpsXNxNc0xOQSBY061H0uSBePU26hNmPxLXSIByUyLUrC16GdkaLAhtb6EbEb/CyP0ghitZOJ33jKGOkJDT4gmepg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 15 Feb 2024 16:23:07 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > SBR is equivalent to a device been hot removed and inserted again. Doing a
> > SBR on a CXL type 3 device is problematic if the exported device memory is
> > part of system memory that cannot be offlined. The event is equivalent to
> > violently ripping out that range of memory from the kernel. While the
> > hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> > register and the kernel currently does not unmask it, user can unmask
> > this bit via setpci or similar tool.
> > 
> > The driver does not have a way to detect whether a reset coming from the
> > PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> > detect is to note if there are active decoders before the reset and check
> > if the range register memory active bit remains set after reset.
> > 
> > A helper function to check is added to detect if the range register memory
> > active bit is set. A locked helper for cxl_num_decoders_committed() is also
> > added to allow pci code to call the cxl_num_decoders_committed() while
> > holding the cxl_region_rwsem.
> > 
> > Add a err_handler->reset_prepare() to detect whether there are active
> > decoders.  Add a err_handler->reset_done() to check if there was active
> > memory before the reset and it is no longer active after the reset. A
> > warning is emitted in the case of active memory has been offlined.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> This feels like we are papering over a hole in the PCI core.
> Is there no way of detecting Secondary Bus Reset (SBR) and
> communicate that down to the device?
> +CC Bjorn. 
> Most of the logic would be needed in driver anyway though as
> we don't want to bother warning on SBR if there was no memory mapped.
> 
> Bjorn, would you prefer this FLR vs SBR being detected by state
> change in driver, or a modification to the PCI core so that it
> provides this info to the drivers?  I assume this pretty unique
> to CXL as normally there isn't a magic control to ignore triggering
> a reset.

So there *is* a magic control to ignore triggering a reset per the CXL
specification, see "Unmask SBR" in "Port Control Extensions".

Moreover, I do not see this as papering over a hole. The only software
that flips that "Unmask SBR" bit from its default today is a userpace
"setpci" script.  Unless kernel_lockdown is in force there is nothing to
stop or warn root about the danger, in fact there is a wide swath of
damage that root with config-cycle-write-access can wreak.

If someone goes through that trouble, and in keeping with the general
Linux ethos of giving root access to footguns (outside of
kernel_lockdown), there is not much justification to block it, but the
driver can definitely clarify the damage after the fact.

I will also point out that the lack of a reset reason notification is
not the loan concern. If there is appetite for increasing core-to-driver
transparency, the hotplug reason is also missing. Whether ->remove() is
logical or physical and the ability to set the magnetic-retention-latch
from an endpoint driver could be interesting, but the staus quo is
sufficient for now.

...a comment for Dave below

> 
> One trivial comment inline.
> 
> Jonathan
> 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index e59d9d37aa65..81d9f57d2e84 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -45,6 +45,17 @@ int cxl_num_decoders_committed(struct cxl_port *port)
> >  	return port->commit_end + 1;
> >  }
> >  
> > +int cxl_num_decoders_committed_locked(struct cxl_port *port)
> > +{
> > +	int decoders;
> > +
> > +	guard(rwsem_read)(&cxl_region_rwsem);
> > +	decoders = cxl_num_decoders_committed(port);
> 
> return cxl_num_decoder_commited(port);
> 
> > +
> > +	return decoders;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed_locked, CXL);
> > +
> >  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
> >  			    char *buf)
> >  {
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index b6017c0c57b4..530c7e693096 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -720,6 +720,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
> >  }
> >  
> >  int cxl_num_decoders_committed(struct cxl_port *port);
> > +int cxl_num_decoders_committed_locked(struct cxl_port *port);
> >  bool is_cxl_port(const struct device *dev);
> >  struct cxl_port *to_cxl_port(const struct device *dev);
> >  struct pci_bus;
> > @@ -800,6 +801,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> >  int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
> >  			struct cxl_endpoint_dvsec_info *info);
> > +bool cxl_dvsec_rr_active(struct device *dev, int d);
> >  
> >  bool is_cxl_region(struct device *dev);
> >  
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 5303d6942b88..9f1814005322 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -440,6 +440,7 @@ struct cxl_dev_state {
> >  	struct resource ram_res;
> >  	u64 serial;
> >  	enum cxl_devtype type;
> > +	bool active_rr_prereset;
> >  };
> >  
> >  /**
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 233e7c42c161..5a5fda7134f6 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -957,11 +957,42 @@ static void cxl_error_resume(struct pci_dev *pdev)
> >  		 dev->driver ? "successful" : "failed");
> >  }
> >  
> > +static void cxl_reset_prepare(struct pci_dev *pdev)
> > +{
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > +
> > +	if (cxl_num_decoders_committed_locked(cxlmd->endpoint))
> > +		cxlds->active_rr_prereset = true;
> > +}
> > +
> > +static void cxl_reset_done(struct pci_dev *pdev)
> > +{
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > +	struct device *dev = &cxlmd->dev;
> > +
> > +	/*
> > +	 * FLR does not expect to touch the HDM decoders and related registers.
> > +	 * SBR however will wipe all device configurations.
> > +	 * Issue warning if there was active configuration before reset that no
> > +	 * longer exists.
> > +	 */
> > +	if (cxlds->active_rr_prereset &&
> > +	    !cxl_dvsec_rr_active(&pdev->dev, cxlds->cxl_dvsec)) {
> > +		dev_warn(dev, "SBR happened without memory regions removal.\n");
> > +		dev_warn(dev, "System may be unstable if regions hosted system memory.\n");

Dave, did you test this? I reacted to the addition of
->active_rr_prereset as a case of putting code logic in a data
structure, but I doubt it is even effectice since nothing informs
software that the register values changed. I.e. the check should be to
walk through all the software committed decoders and see if they are
still hardware committed. No need for ->active_rr_prereset.
