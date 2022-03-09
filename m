Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EF4C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Mar 2022 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiCISXX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbiCISXW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Mar 2022 13:23:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305DC574BF;
        Wed,  9 Mar 2022 10:22:23 -0800 (PST)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KDLBS6h5Vz67SnY;
        Thu, 10 Mar 2022 02:21:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 9 Mar 2022 19:22:21 +0100
Received: from localhost (10.47.72.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 18:22:20 +0000
Date:   Wed, 9 Mar 2022 18:22:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH 03/11] cxl/core: Remove cxl_device_lock()
Message-ID: <20220309182217.00006bf5@Huawei.com>
In-Reply-To: <164610294604.2682974.11169622387063183603.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164610294604.2682974.11169622387063183603.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.72.217]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 28 Feb 2022 18:49:06 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for moving lockdep_mutex nested lock acquisition into the
> core, remove the cxl_device_lock() wrapper, but preserve
> cxl_lock_class() that will be used to inform the core of the subsystem's
> lock ordering rules.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Makes sense, but perhaps the description should call out that after
this patch it's not just a wrapper remove, but rather the lock
checking is totally gone for now?

Otherwise this looks fine to me. FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
