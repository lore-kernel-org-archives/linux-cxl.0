Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207B8C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 15:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350621AbiELPyw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 11:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346693AbiELPyw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 11:54:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D292618FD
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652370890; x=1683906890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NtmTxmIUibqIvUZsk1i2Jxm7uWgkNZfVVWO7Z8pp5AI=;
  b=FlFdcYNbaxl+BpE7EALE7PX4QChv21Sm3QXiBGTWuaC+tJoMURY5TurT
   EKqXgpZMXq5NprV2rrhhiXA2Md8fVNH9NUe3FCBLU6L1EXo35q64GYXPh
   PEY6PxvI8upTUTOxUd1PO19Trzz0dFPw96x3HblJdW2dMbt+YnSwyB/0b
   b5wuZ430AF5Q5OZCPhaqhsYkfs4FME66Tbv68Eh1rXUgtFudfUiAUc6UW
   Qx05aDMYN1GO6z4biQjyAQou0NmSodVPXugo9SKA78j+p0WWD7BbSmY4/
   sTz9loVIKSveebjMTbZI9pz6CyBkA4DnxtI3mkr8R7ZLd1SJoebziF7r5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="249937095"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="249937095"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:54:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="739740455"
Received: from wcogara-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.107])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:54:50 -0700
Date:   Thu, 12 May 2022 08:54:43 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [RFC PATCH 12/15] cxl/region: Add region creation ABI
Message-ID: <20220512155443.6mutrxptd7itk4ds@intel.com>
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
 <20220413183720.2444089-13-ben.widawsky@intel.com>
 <f9fa0a306b167db2a91021aff70bcdbc8c154391.camel@intel.com>
 <CAPcyv4jM_N0Sz_MpFC9+tr01ysJ16EwkSsbxOXxCM5aC7FSe3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jM_N0Sz_MpFC9+tr01ysJ16EwkSsbxOXxCM5aC7FSe3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-05-04 22:17:49, Dan Williams wrote:
> On Wed, May 4, 2022 at 3:57 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
> >
> > On Wed, 2022-04-13 at 11:37 -0700, Ben Widawsky wrote:
> > > Regions are created as a child of the decoder that encompasses an
> > > address space with constraints. Regions have a number of attributes that
> > > must be configured before the region can be activated.
> > >
> > > Multiple processes which are trying not to race with each other
> > > shouldn't need special userspace synchronization to do so.
> > >
> > > // Allocate a new region name
> > > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)
> > >
> > > // Create a new region by name
> > > while
> > > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)
> > > ! echo $region > /sys/bus/cxl/devices/decoder0.0/create_pmem_region
> > > do true; done
> > >
> > > // Region now exists in sysfs
> > > stat -t /sys/bus/cxl/devices/decoder0.0/$region
> > >
> > > // Delete the region, and name
> > > echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region
> >
> > I noticed a slight ABI inconsistency here while working on the libcxl
> > side of this - see below.
> >
> > > +
> > > +static ssize_t create_pmem_region_show(struct device *dev,
> > > +                                      struct device_attribute *attr, char *buf)
> > > +{
> > > +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > > +       struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxld);
> > > +       size_t rc;
> > > +
> > > +       /*
> > > +        * There's no point in returning known bad answers when the lock is held
> > > +        * on the store side, even though the answer given here may be
> > > +        * immediately invalidated as soon as the lock is dropped it's still
> > > +        * useful to throttle readers in the presence of writers.
> > > +        */
> > > +       rc = mutex_lock_interruptible(&cxlrd->id_lock);
> > > +       if (rc)
> > > +               return rc;
> > > +       rc = sysfs_emit(buf, "%d\n", cxlrd->next_region_id);
> >
> > This emits a numeric region ID, e.g. "0", where as
> >
> > > +       mutex_unlock(&cxlrd->id_lock);
> > > +
> > > +       return rc;
> > > +}
> > > +
> >
> > <snip>
> >
> > > +static ssize_t delete_region_store(struct device *dev,
> > > +                                  struct device_attribute *attr,
> > > +                                  const char *buf, size_t len)
> > > +{
> > > +       struct cxl_port *port = to_cxl_port(dev->parent);
> > > +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > > +       struct cxl_region *cxlr;
> > > +
> > > +       cxlr = cxl_find_region_by_name(cxld, buf);
> >
> > This expects a full region name string e.g. "region0"
> >
> > Was this intentional? I don't think it's a huge deal, the library can
> > certainly deal with it if needed - but would it be better to have the
> > ABI symmetrical between create and delete?
> 
> Yes, makes sense to me.

It was not intentional. It's "region%u" for both create and delete now.
