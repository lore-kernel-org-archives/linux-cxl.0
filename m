Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B947C6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 20:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjC3UUU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC3UUT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 16:20:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B1940D3
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680207619; x=1711743619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jgkhHX292Xf/cK+6P+P4xAlOFFLJbgjLYz8TQuv4ZA=;
  b=HX1eEGjSL5mN3Lla2YYfzh+pbFF125lXvquFR7RB7JQtzSzoXt7SxJEO
   5H5WIw1+ve2b2JbQmLSyuh6hVHm39S3XbMkYKmoOv+wFhRrSS/fXsWvjB
   CePZxfesnF63S+jlTIR2hs4he7H/zz0P43VCWDbkG9V+8wjDcKSHDf3PM
   qKoHftN+LGoHEQNm+psxNdNJ04gqo2bZULF2R8T/7WMrviUHuwMWIgwtF
   gQvKPyVT93JU1XksO0xntJtzQLblQPgrIylcT6ZcXx2eA3XgnSEdK+2rD
   gn0z2qJtTX/wSdE0WchMRSFdRfMKQ22jF2f7ugcICVTTaTUCvQlfDPXFF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342922901"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="342922901"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 13:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="1014562941"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="1014562941"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.67.201])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 13:20:06 -0700
Date:   Thu, 30 Mar 2023 13:20:04 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v11 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <ZCXu9IyUYWzLZLy3@aschofie-mobl2>
References: <cover.1679888450.git.alison.schofield@intel.com>
 <f1a60cac8cc404f2fc8768333afbf16be01a5a90.1679888450.git.alison.schofield@intel.com>
 <20230330184240.0000411f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330184240.0000411f@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 30, 2023 at 06:42:40PM +0100, Jonathan Cameron wrote:
> On Sun, 26 Mar 2023 22:02:09 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a boolean 'true' is written to this attribute the memdev driver
> > retrieves the poison list from the device. The list consists of
> > addresses that are poisoned, or would result in poison if accessed,
> > and the source of the poison. This attribute is only visible for
> > devices supporting the capability. The retrieved errors are logged
> > as kernel trace events with the label 'cxl_poison'.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> A grumpy reviewer comment inline...  But meh, if non else minds
> let it be.

Sigh! I know patch review fatigue is not suppose to apply to
the sender...but I clearly have it. Thanks for the review.
I'll queue it for v12.

Alison

> 
> 
> >  static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_serial.attr,
> >  	&dev_attr_firmware_version.attr,
> > @@ -130,6 +177,7 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >  {
> >  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> >  		return 0;
> > +
> 
>  Noise...
> 
> >  	return a->mode;
> >  }
> 
