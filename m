Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A6DC433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Jan 2022 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiAFVaJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:30:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:26072 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239110AbiAFVaI (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 6 Jan 2022 16:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641504608; x=1673040608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rl3K8/5aCq/nfNXdtWTKkM3vpiduR9F9Zk/QukE0+t8=;
  b=a/ybspJq0HgNAhn8E5VPQzgRjSN4uk+yEgZH8qURbtMhJuaEsQ6uxxf+
   1FhS75YepiRWVHH+rgvTGkyG8vTzUG4h1tZYsZeo02Cu0/KOK6RaNoDMj
   NTf3wE4xYS4rA2bFtYCMfwwocI0u3mniDwNB6b/E7flvYmWQKcLQpxlMR
   MWAkFkRmVMBggFLK884AV7lQoLBK07d82ndQqWLdaFRFypGEsH0K2Jekf
   FYjM1lNksoVogJmDaXyoJJudbM0hDXmtYe+aGKIz7KEiFV4TlWh6kximJ
   O28knPgUFPdmj+Yyj/GYH6+mLRt00HMY7G/6zvNHX0zlkGgddO0g0Fx0s
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303489425"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="303489425"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 13:30:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="611971386"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 13:30:08 -0800
Date:   Thu, 6 Jan 2022 13:30:08 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 1/7] libcxl: add GET_PARTITION_INFO mailbox command
 and accessors
Message-ID: <20220106213008.GI178135@iweiny-DESK2.sc.intel.com>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>, linux-cxl@vger.kernel.org
References: <cover.1641233076.git.alison.schofield@intel.com>
 <9d3c55cbd36efb6eabec075cc8596a6382f1f145.1641233076.git.alison.schofield@intel.com>
 <20220106201907.GA178135@iweiny-DESK2.sc.intel.com>
 <CAPcyv4h4_V+fugcbU0f_+ZJ9sALdDqAtgovoVhpjzd6cYiBHgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h4_V+fugcbU0f_+ZJ9sALdDqAtgovoVhpjzd6cYiBHgA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 06, 2022 at 01:21:45PM -0800, Dan Williams wrote:
> On Thu, Jan 6, 2022 at 12:19 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Mon, Jan 03, 2022 at 12:16:12PM -0800, Schofield, Alison wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> > > index 89d35ba..7cf9061 100644
> > > --- a/cxl/libcxl.h
> > > +++ b/cxl/libcxl.h
> > > @@ -109,6 +109,11 @@ ssize_t cxl_cmd_read_label_get_payload(struct cxl_cmd *cmd, void *buf,
> > >               unsigned int length);
> > >  struct cxl_cmd *cxl_cmd_new_write_label(struct cxl_memdev *memdev,
> > >               void *buf, unsigned int offset, unsigned int length);
> > > +struct cxl_cmd *cxl_cmd_new_get_partition_info(struct cxl_memdev *memdev);
> >
> > why 'new'?  Why not:
> >
> > cxl_cmd_get_partition_info()
> >
> > ?
> 
> The "new" is the naming convention inherited from ndctl indicating the
> allocation of a new command object. The motivation is to have a verb /
> action in all of the APIs.

Yea my bad.  I realized that later on.  Sorry.

> 
> >
> > > +unsigned long long cxl_cmd_get_partition_info_get_active_volatile_cap(struct cxl_cmd *cmd);
> > > +unsigned long long cxl_cmd_get_partition_info_get_active_persistent_cap(struct cxl_cmd *cmd);
> > > +unsigned long long cxl_cmd_get_partition_info_get_next_volatile_cap(struct cxl_cmd *cmd);
> > > +unsigned long long cxl_cmd_get_partition_info_get_next_persistent_cap(struct cxl_cmd *cmd);
> >
> > These are pretty long function names.  :-/
> 
> If you think those are long, how about:
> 
> cxl_cmd_health_info_get_media_powerloss_persistence_loss
> 
> The motivation here is to keep data structure layouts hidden behind
> APIs to ease the maintenance of binary compatibility from one library
> release and specification release to the next. The side effect though
> is some long function names in places.

Sure.  I'm ok with that.

Ira

> 
> > I also wonder if the conversion to bytes should be reflected in the function
> > name.  Because returning 'cap' might imply to someone they are getting the raw
> > data field.
> 
> Makes sense.
