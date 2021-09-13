Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD23C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 08:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1CB60FBF
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Sep 2021 08:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhIMIax (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:30:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3768 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhIMIaw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Sep 2021 04:30:52 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H7KNL3N0zz67xMM;
        Mon, 13 Sep 2021 16:27:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 13 Sep 2021 10:29:35 +0200
Received: from localhost (10.52.126.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 09:29:34 +0100
Date:   Mon, 13 Sep 2021 09:29:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 10/13] cxl/core: Map component registers for ports
Message-ID: <20210913092931.0000357b@Huawei.com>
In-Reply-To: <CAPcyv4jkw+QGwc3ZrQkVvOLcLpjstcyYror-TYKJQUZT1An9gA@mail.gmail.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-11-ben.widawsky@intel.com>
        <20210903171405.000024fe@Huawei.com>
        <CAPcyv4jkw+QGwc3ZrQkVvOLcLpjstcyYror-TYKJQUZT1An9gA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.41]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 10 Sep 2021 16:52:48 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Fri, Sep 3, 2021 at 9:14 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 2 Sep 2021 12:50:14 -0700
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >  
> > > Component registers are implemented for CXL.mem/cache operations. The
> > > cxl_pci driver handles enumerating CXL devices with the CXL.io protocol.
> > > The driver for managing CXL.mem/cache operations will need the component
> > > registers mapped and the mapping cannot be shared across two devices.
> > >
> > > For now, it's fine to relinquish this mapping in cxl_pci. CXL IDE is one
> > > exception (perhaps others will exist) where it might be desirable to
> > > have the cxl_pci driver do negotiation. For this case, it probably will
> > > make sense to create an ephemeral mapping. Further looking, there might
> > > need to be a cxl_core mechanism to allow arbitrating access to the
> > > component registers.  
> >
> >  
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> >
> > As you predicted I don't like this. Needs some thought on how to get
> > around the mapping games though and it's Friday afternoon so I'm not
> > going to offer any concrete answers...
> >
> > Not totally obvious to me where RAS will be handled as well.
> > I think we definitely need an arbitration mechanism here.  
> 
> Poison consumption is handled via typical memory_failure(). Event
> record and event interrupts can be handled by the PCI driver
> potentially notifying the memdev driver if necessary. Port specific
> error handling (RAS component registers) can be handled by the port
> driver.
> 
> > Wouldn't it have been nice if all these capabilities had been nicely
> > padded so we could map them individually.  Oh well!
> > Gut feeling is this will only get worse for future versions of the spec
> > so we should assume there will be lots of stuff shoved in here.  
> 
> I'd prefer to run away from arbitration and towards sub-drivers
> providing services with distinct lines of ownership. In the rare cases
> where a driver can not act independently there should be a well
> defined driver API to request help from the register block owner, not
> pass around access to the register block.

Agreed. Where possible keep ownership well defined + API to deal
with the occasional cross over point.

J
