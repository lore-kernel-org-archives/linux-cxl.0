Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98855C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 15:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbiERPdp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiERPdo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 11:33:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1987354F
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 08:33:41 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3H7t14yJz6FGP2;
        Wed, 18 May 2022 23:33:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 17:33:39 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 16:33:39 +0100
Date:   Wed, 18 May 2022 16:33:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <Ariel.Sibley@microchip.com>, <linux-cxl@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v2 14/14] cxl/port: Enable HDM Capability after
 validating DVSEC Ranges
Message-ID: <20220518163337.00005735@Huawei.com>
In-Reply-To: <CAPcyv4jVAMsbUfN3D_5DnPKKP4FdU1V50XL1ZgZpdff7-c5tQQ@mail.gmail.com>
References: <165237933127.3832067.12500546479146655886.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165283418817.1033989.11273676872054815459.stgit@dwillia2-xfh>
        <MN2PR11MB3645021EB1CC6D28206D75AD88D19@MN2PR11MB3645.namprd11.prod.outlook.com>
        <CAPcyv4jVAMsbUfN3D_5DnPKKP4FdU1V50XL1ZgZpdff7-c5tQQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 17 May 2022 19:44:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, May 17, 2022 at 7:08 PM <Ariel.Sibley@microchip.com> wrote:
> >  
> > > Previously, the cxl_mem driver was relying on platform-firmware to set
> > > "mem_enable". That is an invalid assumption as there is no requirement
> > > that platform-firmware sets the bit before the driver sees a device,
> > > especially in hot-plug scenarios. Additionally, ACPI-platforms that
> > > support CXL 2.0 devices also support the ACPI CEDT (CXL Early Discovery
> > > Table). That table outlines the platform permissible address ranges for
> > > CXL operation. So, there is a need for the driver to set "mem_enable",
> > > and there is information available to determine the validity of the CXL
> > > DVSEC Ranges. While DVSEC Ranges are expected to be at least
> > > 256M in size, the specification (CXL 2.0 Section 8.1.3.8.4 DVSEC CXL
> > > Range 1 Base Low) allows for the possibilty of devices smaller than
> > > 256M. So the range [0, 256M) is considered active even if Memory_size
> > > is 0.  
> >
> > Regarding "So the range [0, 256M) is considered active even if
> > Memory_size is 0."
> >
> > Since Memory_Base is included in address A, this portion of the equation
> > from CXL 2.0 Section 8.1.3.8.4 mandates that for host access to address A
> > to be directed to local HDM memory, Memory_Size[63:28] must be > 0:
> >
> > (A >> 28) < Memory_Base[63:28] + Memory_Size[63:28]
> >
> > This means if a device advertises Memory_Size = 0, no host access will
> > result in access to the HDM memory.
> >
> > I would also note this text from CXL 2.0 Section 8.1.3.8:
> > "A CXL.mem capable device is permitted to report zero memory size."
> >
> > For a device with a non-zero capacity less than 256M to satisfy the
> > equation, it would need to advertise a Memory_Size of at least 256M.  
> 
> I think we need an errata to delete the "(e.g. a device with less than
> 256 MB of memory)" mention. I otherwise do not see how such a device
> can exist if Memory_size must be >= 256M.

My reading of that is it is permissible to implement a device that
has say 16MiB or actual memory, report it as 256MiB and follow this
behavior for the 16-256 MiB range.  It also covers a 300MiB device
where the size of the HDM decoder is set to 512MiB etc.

As such I don't think it's wrong, but rather just not relevant to us
here (0 is a valid setting for Memory_Size).
Would need impdef means to establish the actual size of the
memory to do anything useful with that corner case.

Jonathan

