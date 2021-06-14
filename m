Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FAEC2B9F4
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB88261209
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 21:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhFNV4w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:56:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:58470 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhFNV4v (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 14 Jun 2021 17:56:51 -0400
IronPort-SDR: fnabyfdd/ptNrdTpVJmJ/OdhFDppmTukpiU8qV484FRhFQaG1rGtGCe9/oqaDqzmqrvv56F0pJ
 rQ03ohnhbl4A==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="202860332"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="202860332"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 14:54:05 -0700
IronPort-SDR: ybaGFAH0EOUaTEtqzddXqJMMYYi/rChdBO1Oljr/v7BXr/r5djph9a7yFg51cgm9uIubgO/qoG
 43NNfXs5InyQ==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="636923886"
Received: from smothe-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.124])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 14:54:04 -0700
Date:   Mon, 14 Jun 2021 14:54:02 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 0/4] Region Creation
Message-ID: <20210614215402.mxcwdv4wno6krm7w@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
 <CAPcyv4j=cFikFD_jrPwMfGuMbFZ+1DPUyQjYq7SqTYYauMxLOA@mail.gmail.com>
 <20210614161159.cqq64nbm5whzpud7@intel.com>
 <CAPcyv4gaxWDC9eN965VkbDv0W5QgBBP7Cg0RU74uE08OKSZVow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4gaxWDC9eN965VkbDv0W5QgBBP7Cg0RU74uE08OKSZVow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-06-14 14:04:32, Dan Williams wrote:
> On Mon, Jun 14, 2021 at 9:12 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-06-11 17:44:02, Dan Williams wrote:
> > > On Thu, Jun 10, 2021 at 11:58 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > CXL interleave sets and non-interleave sets are described via regions. A region
> > > > is specified in the CXL 2.0 specification and the purpose is to create a
> > > > standardized way to preserve the region across reboots.
> > > >
> > > > Introduced here is the basic mechanism to create and configure and delete a CXL
> > > > region. Configuring a region simply means giving it a size, offset within the
> > > > CFMWS window, UUID, and a target list. Enabling/activating a region, which
> > > > ultimately means programming the HDM decoders in the chain, is left for later
> > > > work.
> > > >
> > > > The patches are only minimally tested so far in QEMU emulation and so x1
> > > > interleave is all that's supported.
> > > >
> > > > Here is a sample topology (also in patch #4)
> > >
> > > I'm just going to react to the attributes before looking at the
> > > implementation to make sure we're level set.
> > >
> > > >
> > > >     decoder1.0
> > > >     ├── create_region
> > > >     ├── delete_region
> > > >     ├── devtype
> > > >     ├── locked
> > > >     ├── region1.0:0
> > > >     │   ├── offset
> > >
> > > Is this the region's offset relative to the next available free space
> > > in the parent decoder range? If this is output only I think it's ok,
> > > but I think the address space allocation decision belongs to the
> > > region driver at activation time. I.e. userspace does not have much of
> > > a chance at specifying this relative all the other dynamic operations
> > > that can be happening in the decoder.
> > >
> >
> > This was my mistake. Offset will be determined by the driver and I intend for
> > this to be read-only.
> >
> > > >     │   ├── size
> > > >     │   ├── subsystem -> ../../../../../../../bus/cxl
> > > >     │   ├── target0
> > > >     │   ├── uevent
> > > >     │   ├── uuid
> > > >     │   └── verify
> > >
> > > I don't understand the role of a standalone @verify attribute, there
> > > is verification that can happen per attribute write, and there is
> > > final verification that can happen at region bind time. Either way
> > > anything verify would check is duplicated somewhere else, and the
> > > verification per attribute update is more precise. For example writes
> > > to @size can check for free space in parent decoder and fail if
> > > unavailable. Writes to targetX can fail if the memdev is not connected
> > > to this decoder's port topology, or the memdev is out of decoder
> > > resources. The final region bind will fail if mid-level switches are
> > > lacking decoder resources, or would require changing a decoder
> > > configuration that is pinned active.
> >
> > I strongly believe verification per attribute write will get too fragile. I'm
> > afraid it's going to require writing attributes in a specific order so that we
> > can do said verification in a sane way. We can skip that and just check it all
> > on bind. Most of that logic is what would be contained in verify(), so why not
> > expose it for userspace that may want to test out various configs without
> > actually trying to bind?
> 
> Because there's no harm in actually trying to bind. A verify attribute
> is at best redundant, or I am otherwise not understanding the proposed
> use case?
> 

That's the use case. Though I don't consider it redundant. All bind() can return
is errnos + what you mention below (and following LWN link).

> > Also, I like having ABI that helps userspace get details on the configuration
> > failure reason. You mention in the other reply, TRACE_EVENT. I suppose userspace
> > could use tracepoints, or scrape dmesg for this same info. Maybe it's 6 one way,
> > a half dozen the other. I'd be interested to know if there are other examples of
> > tracepoints being used by userspace in a way like this and what the experience
> > is like.
> >
> > To summarize, I think we need an atomic way to do verification (which obviously
> > happens at bind()), and I think we need UAPI to get the configuration error.
> 
> I expect higher order configuration error reporting and non-atomic
> pre-verification to come from user tooling.

But isn't that just duplicating code that we have to have in the kernel anyway?

> As for what the kernel can do at runtime in the absence of user tooling, or in
> the development of more aware tooling has been debated in the past [1]. In
> this case the entire decoder resource topology is visible in userspace, an3d
> while userspace can't atomically predict what will happen, it also does not
> need to because the admin should not be racing resource querying and resource
> consumption if they want to get a reliable answer. The reason I recommended
> TRACE_EVENT() rather than dev_dbg() is due to being able to filter event
> messages by cpu, pid, tid, uid... etc. Another approach I have seen upstream
> is to emit extra variables with a KOBJ_CHANGE event, but that is more about
> event reporting than extra information about provisioning failure.

Interesting. Thanks for the link, it looks like it never landed. I think trace
makes a good deal of sense considering all the options. I'm not convinced the
interface is "at best redundant". I'll just drop verify(). I have no further
arguments in favor and you don't sound convinced of the original ones.

> 

> [1]: https://lwn.net/Articles/657341/
