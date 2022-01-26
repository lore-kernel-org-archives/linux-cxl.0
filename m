Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C242DC28CF5
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 18:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiAZS7P (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 13:59:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:31926 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbiAZS7N (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 26 Jan 2022 13:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643223553; x=1674759553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eK8zNCKSJHtg/mLYP+qyKQ7z0PpD8d7i8SqrFy5jEGs=;
  b=Sb9kZqBz3pLz+30NH3lEP33mTEoUZ1piRFdnwnnEUch5NMFcOCOzwckd
   Dw0IFYq/bdJN0WDbHqK/mNFCCijZfPo5HjoICLp2fX5keeg6v8uwcRz8u
   28zl4eCua1UXOTBcD61dhOEyFnjiiUCObTpd5Hg7nn4ceM1DoSOH0tmhn
   HufmKEx2+1Vd3XHhKXBsCi9rgOBgr5Vip6Ghf3oa/p4VBcwoddLuD1DQD
   Z7N5N3MofszkcE4zbrOl3wfP6mE0rp4MpQFm0BpALmmcjET6pwZPqRauE
   u6s0fvBakC1D5PcsAa3lVw1ceQrguOvRZW1HwO8+nr+cOzke3SNb3xuH+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246570845"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246570845"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:59:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="479984312"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:59:13 -0800
Date:   Wed, 26 Jan 2022 11:03:45 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH v3 4/6] cxl: add memdev partition information to
 cxl-list
Message-ID: <20220126190345.GA888573@alison-desk>
References: <cover.1642535478.git.alison.schofield@intel.com>
 <5c20a16be96fb402b792b0b23cc1373651cef111.1642535478.git.alison.schofield@intel.com>
 <CAPcyv4g3s=4AV+B3EHgANHXedrvOeY8vasE7uR5vznUX5BX24w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g3s=4AV+B3EHgANHXedrvOeY8vasE7uR5vznUX5BX24w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 26, 2022 at 09:23:23AM -0800, Dan Williams wrote:
> On Tue, Jan 18, 2022 at 12:20 PM <alison.schofield@intel.com> wrote:
> >
snip

> > +# cxl list -m mem0 -I
> > +[
> > +  {
> > +    "memdev":"mem0",
> > +    "pmem_size":0,
> > +    "ram_size":273535729664,
> > +    "partition_info":{
> > +      "active_volatile_bytes":273535729664,
> > +      "active_persistent_bytes":0,
> > +      "next_volatile_bytes":0,
> > +      "next_persistent_bytes":0,
> > +      "total_bytes":273535729664,
> > +      "volatile_only_bytes":0,
> > +      "persistent_only_bytes":0,
> > +      "partition_alignment_bytes":268435456
> 
> I think it's confusing to include "_bytes" in the json listing as it's
> not used in any of the other byte oriented output fields across 'cxl
> list' and 'ndctl list'. "_size" would match similar fields in other
> json objects.

Got it. Will drop the _bytes in v4. Thanks!
> 
> Other than that,
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
