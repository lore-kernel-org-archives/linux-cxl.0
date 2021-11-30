Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173C4C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Nov 2021 13:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbhK3NZ4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:25:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4183 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhK3NZs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Nov 2021 08:25:48 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J3NCm1nZbz67LyN;
        Tue, 30 Nov 2021 21:21:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:22:27 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 30 Nov
 2021 13:22:26 +0000
Date:   Tue, 30 Nov 2021 13:22:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 7/9] cxl/acpi: Map component registers for Root Ports
Message-ID: <20211130132225.00005cea@Huawei.com>
In-Reply-To: <20211129214721.1668325-8-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
        <20211129214721.1668325-8-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 29 Nov 2021 13:47:19 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> This implements the TODO in cxl_acpi for mapping component registers.
> cxl_acpi becomes the second consumer of CXL register block enumeration
> (cxl_pci being the first). Moving the functionality to cxl_core allows
> both of these drivers to use the functionality. Equally importantly it
> allows cxl_core to use the functionality in the future.
> 
> CXL 2.0 root ports are similar to CXL 2.0 Downstream Ports with the main
> distinction being they're a part of the CXL 2.0 host bridge. While
> mapping their component registers is not immediately useful for the CXL
> drivers, the movement of register block enumeration into core is a vital
> step towards HDM decoder programming.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
