Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A211EC433EF
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Dec 2021 05:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhLDFQv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 4 Dec 2021 00:16:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:15031 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhLDFQu (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 4 Dec 2021 00:16:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237036874"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="237036874"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 21:13:26 -0800
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="610650728"
Received: from pnaidu-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.128.34])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 21:13:25 -0800
Date:   Fri, 3 Dec 2021 21:13:24 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 7/9] cxl/acpi: Map component registers for Root Ports
Message-ID: <20211204051324.3ifts5otddabj4mh@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
 <20211129214721.1668325-8-ben.widawsky@intel.com>
 <CAPcyv4jUebWTEOaULzDDqXf50QDEBZ3F4RAZVCO_kGXHjbo_xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jUebWTEOaULzDDqXf50QDEBZ3F4RAZVCO_kGXHjbo_xw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-12-03 20:37:26, Dan Williams wrote:
> On Mon, Nov 29, 2021 at 1:47 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > This implements the TODO in cxl_acpi for mapping component registers.
> > cxl_acpi becomes the second consumer of CXL register block enumeration
> > (cxl_pci being the first). Moving the functionality to cxl_core allows
> > both of these drivers to use the functionality. Equally importantly it
> > allows cxl_core to use the functionality in the future.
> >
> > CXL 2.0 root ports are similar to CXL 2.0 Downstream Ports with the main
> > distinction being they're a part of the CXL 2.0 host bridge. While
> > mapping their component registers is not immediately useful for the CXL
> > drivers, the movement of register block enumeration into core is a vital
> > step towards HDM decoder programming.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> > Changes since v1:
> > - Add comment on why component register enumeration for root ports is
> >   optional (Jonathan)
> > - Fix kdoc for cxl_find_regblock (Jonathan)
> > - Convert cxl_reg_block macro to static inline (Dan)
> > - Rename cxl_reg_block cxl_reg_block to cxl_regmap_to_base (Dan)
> > - Make cxl_regmap_to_base return CXL_RESOURCE_NONE on failure (Dan)
> 
> Hmm, it's not doing that...
> 

Oops. I'll fix that. I suppose the best check is to check @base? I don't see any
other obvious way.
