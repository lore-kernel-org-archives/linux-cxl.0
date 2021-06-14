Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39402C48BE8
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AFB61380
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 08:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFNIWi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Jun 2021 04:22:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3230 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhFNIWf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Jun 2021 04:22:35 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3PNJ4l6Kz6F9Vs;
        Mon, 14 Jun 2021 16:13:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 10:20:31 +0200
Received: from localhost (10.52.126.149) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 09:20:31 +0100
Date:   Mon, 14 Jun 2021 09:20:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 0/4] Region Creation
Message-ID: <20210614092026.00002842@Huawei.com>
In-Reply-To: <CAPcyv4j=cFikFD_jrPwMfGuMbFZ+1DPUyQjYq7SqTYYauMxLOA@mail.gmail.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
        <CAPcyv4j=cFikFD_jrPwMfGuMbFZ+1DPUyQjYq7SqTYYauMxLOA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.126.149]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 11 Jun 2021 17:44:02 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Jun 10, 2021 at 11:58 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > CXL interleave sets and non-interleave sets are described via regions. A region
> > is specified in the CXL 2.0 specification and the purpose is to create a
> > standardized way to preserve the region across reboots.
> >
> > Introduced here is the basic mechanism to create and configure and delete a CXL
> > region. Configuring a region simply means giving it a size, offset within the
> > CFMWS window, UUID, and a target list. Enabling/activating a region, which
> > ultimately means programming the HDM decoders in the chain, is left for later
> > work.
> >
> > The patches are only minimally tested so far in QEMU emulation and so x1
> > interleave is all that's supported.
> >
> > Here is a sample topology (also in patch #4)  
> 
> I'm just going to react to the attributes before looking at the
> implementation to make sure we're level set.
> 
> >
> >     decoder1.0
> >     ├── create_region
> >     ├── delete_region
> >     ├── devtype
> >     ├── locked
> >     ├── region1.0:0
> >     │   ├── offset  
> 
> Is this the region's offset relative to the next available free space
> in the parent decoder range? If this is output only I think it's ok,
> but I think the address space allocation decision belongs to the
> region driver at activation time. I.e. userspace does not have much of
> a chance at specifying this relative all the other dynamic operations
> that can be happening in the decoder.
> 
> >     │   ├── size
> >     │   ├── subsystem -> ../../../../../../../bus/cxl
> >     │   ├── target0
> >     │   ├── uevent
> >     │   ├── uuid
> >     │   └── verify  
> 
> I don't understand the role of a standalone @verify attribute, there
> is verification that can happen per attribute write, and there is
> final verification that can happen at region bind time. Either way
> anything verify would check is duplicated somewhere else, and the
> verification per attribute update is more precise. For example writes
> to @size can check for free space in parent decoder and fail if
> unavailable.

This comes back to your question above on whether offset is writable
and what it is with respect to.

If it is writeable, then you can't really verify size and offset
separately.

I'm not against just doing it on commit.

> Writes to targetX can fail if the memdev is not connected
> to this decoder's port topology, or the memdev is out of decoder
> resources. The final region bind will fail if mid-level switches are
> lacking decoder resources, or would require changing a decoder
> configuration that is pinned active.

