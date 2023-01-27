Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922D6C61DA4
	for <linux-cxl@archiver.kernel.org>; Fri, 27 Jan 2023 12:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjA0M2U (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 07:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjA0M17 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 07:27:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CA16A47
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 04:27:33 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P3GWL3lj1z6J6JM;
        Fri, 27 Jan 2023 20:06:06 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 12:10:14 +0000
Date:   Fri, 27 Jan 2023 12:10:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <20230127121013.00007966@huawei.com>
In-Reply-To: <20230127100406.00006c65@Huawei.com>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
        <63d2e0f67eee9_ea222294b6@dwillia2-xfh.jf.intel.com.notmuch>
        <20230127100406.00006c65@Huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> > >  /*
> > > @@ -857,6 +859,29 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
> > >  
> > > +int cxl_set_timestamp(struct cxl_dev_state *cxlds, u64 ts)
> > > +{
> > > +	struct cxl_mbox_cmd mbox_cmd;
> > > +	struct cxl_mbox_set_timestamp_in pi;
> > > +
> > > +	/*
> > > +	 * Command is optional and functionality should not be affected if
> > > +	 * the command is not available.
> > > +	 */
> > > +	if (!test_bit(CXL_MEM_COMMAND_ID_SET_TIMESTAMP, cxlds->enabled_cmds))
> > > +		return 0;

One side effect of dropping the userspace handling is we loose
the presence in enabled_cmds (based on the CEL).  I've replaced
this with specific handling of the Not Supported mailbox return code
and suitable comments on why I'm not considering that an error.

Hopefully that compromise makes sense.

Jonathan
